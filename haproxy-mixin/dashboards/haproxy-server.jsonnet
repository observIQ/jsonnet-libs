local d = import 'dashboards.libsonnet';
local g = import 'github.com/grafana/dashboard-spec/_gen/7.0/jsonnet/grafana.libsonnet';

g.dashboard.new() + {
  title: 'HAProxy / Server',
  editable: false,
  panels:
    local requests = d.util.section(
      g.panel.row.new(title='Requests'),
      [
        d.panels.serverHttpResponseRate,
        d.panels.serverConnectionRate,
        d.panels.serverBytes,
      ],
      panelSize={ h: 6, w: 8 },
    );
    local errors = d.util.section(
      g.panel.row.new(title='Errors'),
      [
        d.panels.serverResponseErrorRate,
        d.panels.serverConnectionErrorRate,
        d.panels.serverInternalErrorRate,
      ],
      prevSection=requests,
      panelSize={ h: 6, w: 8 },
    );
    local duration = d.util.section(
      g.panel.row.new(title='Duration'),
      [
        d.panels.serverAverageDuration,
        d.panels.serverMaxDuration,
      ],
      prevSection=errors,
      panelSize={ h: 6, w: 8 },
    );
    requests + errors + duration,

  templating: {
    list: [
      d.templates.datasource,
      d.templates.job,
      d.templates.instance,
      d.templates.backend,
      d.templates.server,
    ],
  },
  time: {
    from: 'now-6h',
    to: 'now',
  },
  timepicker: {
    hidden: false,
    refresh_intervals: [
      '5s',
      '10s',
      '30s',
      '1m',
      '5m',
      '15m',
      '30m',
      '1h',
      '2h',
      '1d',
    ],
  },
  uid: 'HAProxyServer',
}
