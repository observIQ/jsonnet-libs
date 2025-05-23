local g = import './g.libsonnet';
local commonlib = import 'common-lib/common/main.libsonnet';
local utils = commonlib.utils;
{
  new(this)::
    {
      local t = this.grafana.targets,
      local stat = g.panel.stat,
      local fieldOverride = g.panel.table.fieldOverride,
      local alertList = g.panel.alertList,
      local pieChart = g.panel.pieChart,
      local barGauge = g.panel.barGauge,
      connectionsPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Connections',
          targets=[],
          description='The number of network connections to each database.'
        )
        + g.panel.timeSeries.standardOptions.withUnit('connections')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(54)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      batchRequestsPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Batch requests',
          targets=[],
          description='Number of batch requests.'
        )
        + g.panel.timeSeries.standardOptions.withUnit('reqps')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(0)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      severeErrorsPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Severe errors',
          targets=[],
          description='Number of severe errors that caused connections to be killed.'
        )
        + g.panel.timeSeries.standardOptions.withUnit('errors')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(0)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      deadlocksPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Deadlocks',
          targets=[],
          description='Rate of deadlocks occurring over time.'
        )
        + g.panel.timeSeries.standardOptions.withUnit('deadlocks')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(0)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      osMemoryUsagePanel:
        commonlib.panels.generic.timeSeries.base.new(
          'OS memory usage',
          targets=[],
          description='The amount of physical memory available and used by SQL Server.'
        )
        + g.panel.timeSeries.standardOptions.withUnit('bytes')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(51)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      memoryManagerPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Memory manager',
          targets=[],
          description='The committed memory and target committed memory for the SQL Server memory manager. See https://learn.microsoft.com/en-us/sql/relational-databases/performance-monitor/monitor-memory-usage?view=sql-server-ver16#isolating-memory-used-by-'
        )
        + g.panel.timeSeries.standardOptions.withUnit('bytes')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(51)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      committedMemoryUtilizationPanel:
        barGauge.new(title='Committed memory utilization')
        + barGauge.queryOptions.withTargets([])
        + barGauge.panelOptions.withDescription('The committed memory utilization')
        + barGauge.options.withOrientation('auto'),
      errorLogsPanel:
        g.panel.logs.new('Error Logs')
        + g.panel.logs.options.withEnableLogDetails(true)
        + g.panel.logs.options.withShowTime(true)
        + g.panel.logs.options.withWrapLogMessage(false),
      databaseWriteStallDurationPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Database write stall duration',
          targets=[],
          description='The current stall (latency) for database writes.'
        )
        + g.panel.timeSeries.standardOptions.withUnit('s')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(0)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      databaseReadStallDurationPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Database read stall duration',
          targets=[],
          description='The current stall (latency) for database reads.'
        )
        + g.panel.timeSeries.standardOptions.withUnit('s')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(0)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      transactionLogExpansionsPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Transaction log expansions',
          targets=[],
          description='Number of times the transaction log has been expanded for a database.'
        )
        + g.panel.timeSeries.standardOptions.withUnit('expansions')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(0)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      pageFileMemoryPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Page file memory',
          targets=[],
          description='Memory used for the OS page file.'
        )
        + g.panel.timeSeries.standardOptions.withUnit('bytes')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(50)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      bufferCacheHitPercentagePanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Buffer cache hit percentage',
          targets=[],
          description='Percentage of page found and read from the SQL Server buffer cache.'
        )
        + g.panel.timeSeries.standardOptions.withUnit('percent')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(0)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      pageCheckpointsPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Page checkpoints',
          targets=[],
          description='Rate of page checkpoints per second.'
        )
        + g.panel.timeSeries.standardOptions.withUnit('checkpoints/s')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(0)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
      pageFaultsPanel:
        commonlib.panels.generic.timeSeries.base.new(
          'Page faults',
          targets=[],
          description='The number of page faults that were incurred by the SQL Server process.'
        )
        + g.panel.timeSeries.standardOptions.withUnit('faults')
        + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(0)
        + g.panel.timeSeries.fieldConfig.defaults.custom.withSpanNulls(false),
    },
}
