{
  _config+:: {
    dashboardTags: ['apache-cassandra-mixin'],
    dashboardPeriod: 'now-1h',
    dashboardTimezone: 'default',
    dashboardRefresh: '1m',

    enableLokiLogs: true,
  },
}
