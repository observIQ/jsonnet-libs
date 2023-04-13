{
  prometheusAlerts+:: {
    groups+: [
      {
        name: 'ApacheDruidAlerts',
        rules: [
          {
            alert: 'HighQueryFailures',
            expr: |||
              apachedruid_failed_query_count > %(alertsCriticalQueryFailures5m)s
            ||| % $._config,
            'for': '5m',
            labels: {
              severity: 'critical',
            },
            annotations: {
              summary: 'There is a high number of query failures.',
              description:
                (
                  '{{ printf "%%.0f" $value }} query failures have occurred over the last 5 minutes on {{$labels.apachedruid_service}}, ' +
                  'which is above the threshold of %(alertsCriticalQueryFailures5m)s failures. '
                ) % $._config,
            },
          },
          {
            alert: 'HighQueryTimeouts',
            expr: |||
              apachedruid_timeout_query_count > %(alertsWarningQueryTimeouts5m)s
            ||| % $._config,
            'for': '5m',
            labels: {
              severity: 'warning',
            },
            annotations: {
              summary: 'There is a high number of query failures.',
              description:
                (
                  '{{ printf "%%.0f" $value }} query timeouts have occurred over the last 5 minutes on {{$labels.apachedruid_service}}, ' +
                  'which is above the threshold of %(alertsWarningQueryTimeouts5m)s timeouts. '
                ) % $._config,
            },
          },
        ],
      },
    ],
  },
}
