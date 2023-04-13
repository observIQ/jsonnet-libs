{
  _config+:: {
    dashboardTags: ['apache-druid-mixin'],
    dashboardPeriod: 'now-1h',
    dashboardTimezone: 'default',
    dashboardRefresh: '1m',

    //alert thresholds
    alertsCriticalQueryFailures5m: 10,
    alertsWarningQueryTimeouts5m: 5,

    enableLokiLogs: true,
    enableDatacenterLabel: false,
    enableRackLabel: false,
  },
}
