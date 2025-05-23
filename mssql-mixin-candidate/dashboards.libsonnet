local g = import './g.libsonnet';
local logslib = import 'logs-lib/logs/main.libsonnet';
{
  local root = self,
  new(this)::
    local prefix = this.config.dashboardNamePrefix;
    local links = this.grafana.links;
    local tags = this.config.dashboardTags;
    local uid = g.util.string.slugify(this.config.uid);
    local vars = this.grafana.variables;
    local annotations = this.grafana.annotations;
    local refresh = this.config.dashboardRefresh;
    local period = this.config.dashboardPeriod;
    local timezone = this.config.dashboardTimezone;
    local panels = this.grafana.panels;

    {
      mssql_overview:
        g.dashboard.new(prefix + ' MSSQL overview')
        + g.dashboard.withPanels(
          g.util.grid.wrapPanels(
            [
              panels.connectionsPanel { gridPos+: { h: 8, w: 12, x: 0, y: 0 } },
              panels.batchRequestsPanel { gridPos+: { h: 8, w: 12, x: 12, y: 0 } },
              panels.severeErrorsPanel { gridPos+: { h: 8, w: 12, x: 0, y: 8 } },
              panels.deadlocksPanel { gridPos+: { h: 8, w: 12, x: 12, y: 8 } },
              panels.osMemoryUsagePanel { gridPos+: { h: 8, w: 24, x: 0, y: 16 } },
              panels.memoryManagerPanel { gridPos+: { h: 8, w: 16, x: 0, y: 24 } },
              panels.committedMemoryUtilizationPanel { gridPos+: { h: 8, w: 8, x: 16, y: 24 } },
              panels.errorLogsPanel { gridPos+: { h: 8, w: 24, x: 0, y: 32 } },
              panels.databaseWriteStallDurationPanel { gridPos+: { h: 8, w: 12, x: 0, y: 41 } },
              panels.databaseReadStallDurationPanel { gridPos+: { h: 8, w: 12, x: 12, y: 41 } },
              panels.transactionLogExpansionsPanel { gridPos+: { h: 8, w: 24, x: 0, y: 49 } },
            ]
          )
        )
        + root.applyCommon(
          vars.singleInstance,
          uid + '_mssql_overview',
          tags,
          links { mssqlOverview+:: {} },
          annotations,
          timezone,
          refresh,
          period
        ),

      mssql_pages:
        g.dashboard.new(prefix + ' MSSQL pages')
        + g.dashboard.withPanels(
          g.util.grid.wrapPanels(
            [
            ]
          )
        )
        + root.applyCommon(
          vars.singleInstance,
          uid + '_mssql_pages',
          tags,
          links { mssqlPages+:: {} },
          annotations,
          timezone,
          refresh,
          period
        ),

    }
    +
    if this.config.enableLokiLogs then
      {
        logs:
          logslib.new(
            prefix + ' logs',
            datasourceName=this.grafana.variables.datasources.loki.name,
            datasourceRegex=this.grafana.variables.datasources.loki.regex,
            filterSelector=this.config.filteringSelector,
            labels=this.config.groupLabels + this.config.extraLogLabels,
            formatParser=null,
            showLogsVolume=this.config.showLogsVolume,
          )
          {
            dashboards+:
              {
                logs+:
                  // reference to self, already generated variables, to keep them, but apply other common data in applyCommon
                  root.applyCommon(super.logs.templating.list, uid=uid + '-logs', tags=tags, links=links { logs+:: {} }, annotations=annotations, timezone=timezone, refresh=refresh, period=period),
              },
            panels+:
              {
                // modify log panel
                logs+:
                  g.panel.logs.options.withEnableLogDetails(true)
                  + g.panel.logs.options.withShowTime(false)
                  + g.panel.logs.options.withWrapLogMessage(false),
              },
            variables+: {
              // add prometheus datasource for annotations processing
              toArray+: [
                this.grafana.variables.datasources.prometheus { hide: 2 },
              ],
            },
          }.dashboards.logs,
      }
    else {},

  applyCommon(vars, uid, tags, links, annotations, timezone, refresh, period):
    g.dashboard.withTags(tags)
    + g.dashboard.withUid(uid)
    + g.dashboard.withLinks(std.objectValues(links))
    + g.dashboard.withTimezone(timezone)
    + g.dashboard.withRefresh(refresh)
    + g.dashboard.time.withFrom(period)
    + g.dashboard.withVariables(vars)
    + g.dashboard.withAnnotations(std.objectValues(annotations)),
}