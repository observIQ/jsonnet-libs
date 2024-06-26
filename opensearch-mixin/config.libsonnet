{
  _config+:: {
    enableMultiCluster: false,
    // extra static selector to apply to all templated variables and alerts
    filteringSelector: if self.enableMultiCluster then 'cluster!="",opensearch_cluster!=""' else 'opensearch_cluster!=""',
    groupLabels: if self.enableMultiCluster then ['job', 'cluster', 'opensearch_cluster'] else ['job', 'opensearch_cluster'],
    instanceLabels: ['node'],
    dashboardTags: ['opensearch-mixin'],
    dashboardPeriod: 'now-1h',
    dashboardTimezone: 'default',
    dashboardRefresh: '1m',
    dashboardNamePrefix: '',

    // prefix dashboards uids
    uid: 'opensearch',

    // alerts thresholds
    alertsWarningShardReallocations: 0,
    alertsWarningShardUnassigned: 0,
    alertsWarningDiskUsage: 60,
    alertsCriticalDiskUsage: 80,
    alertsWarningCPUUsage: 70,
    alertsCriticalCPUUsage: 85,
    alertsWarningMemoryUsage: 70,
    alertsCriticalMemoryUsage: 85,
    alertsWarningRequestLatency: 0.5,  // seconds
    alertsWarningIndexLatency: 0.5,  // seconds

    enableLokiLogs: true,
  },
}
