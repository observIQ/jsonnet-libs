local g = (import 'grafana-builder/grafana.libsonnet');
local grafana = (import 'grafonnet/grafana.libsonnet');
local dashboard = grafana.dashboard;
local template = grafana.template;
local prometheus = grafana.prometheus;

local dashboardUid = 'apache-activemq-topic-overview';

local promDatasourceName = 'prometheus_datasource';

local promDatasource = {
  uid: '${%s}' % promDatasourceName,
};

local numberOfTopicsPanel = {
  datasource: promDatasource,
  targets: [
    prometheus.target(
      'count by(instance, activemq_cluster, job) (activemq_topic_queue_size{instance=~"$instance",activemq_cluster=~"$activemq_cluster", job=~"$job"})',
      datasource=promDatasource,
      legendFormat='{{instance}}',
    ),
  ],
  type: 'stat',
  title: 'Number of topics',
  description: 'Number of topics connected with the broker instance.',
  fieldConfig: {
    defaults: {
      color: {
        mode: 'thresholds',
      },
      mappings: [],
      thresholds: {
        mode: 'absolute',
        steps: [
          {
            color: 'green',
            value: null,
          },
        ],
      },
      unit: 'none',
    },
    overrides: [],
  },
  options: {
    colorMode: 'none',
    graphMode: 'none',
    justifyMode: 'auto',
    orientation: 'auto',
    reduceOptions: {
      calcs: [
        'lastNotNull',
      ],
      fields: '',
      values: false,
    },
    textMode: 'auto',
  },
  pluginVersion: '10.2.0-60139',
};

local producerCountPanel = {
  datasource: promDatasource,
  targets: [
    prometheus.target(
      'sum by(instance, activemq_cluster, job) (activemq_topic_producer_count{job=~"$job", activemq_cluster=~"$activemq_cluster", instance=~"$instance"})',
      datasource=promDatasource,
      legendFormat='{{instance}}',
    ),
  ],
  type: 'stat',
  title: 'Producer count',
  description: 'The number of producers attached to topic destinations.',
  fieldConfig: {
    defaults: {
      color: {
        mode: 'thresholds',
      },
      mappings: [],
      thresholds: {
        mode: 'absolute',
        steps: [
          {
            color: 'green',
            value: null,
          },
        ],
      },
      unit: 'none',
    },
    overrides: [],
  },
  options: {
    colorMode: 'none',
    graphMode: 'none',
    justifyMode: 'auto',
    orientation: 'auto',
    reduceOptions: {
      calcs: [
        'lastNotNull',
      ],
      fields: '',
      values: false,
    },
    textMode: 'auto',
  },
  pluginVersion: '10.2.0-60139',
};

local consumerCountPanel = {
  datasource: promDatasource,
  targets: [
    prometheus.target(
      'sum by(instance, activemq_cluster, job) (activemq_topic_consumer_count{instance=~"$instance", activemq_cluster=~"$activemq_cluster", job=~"$job"})',
      datasource=promDatasource,
      legendFormat='{{instance}}',
    ),
  ],
  type: 'stat',
  title: 'Consumer count',
  description: 'The number of consumers subscribed to topic destinations.',
  fieldConfig: {
    defaults: {
      color: {
        mode: 'thresholds',
      },
      mappings: [],
      thresholds: {
        mode: 'absolute',
        steps: [
          {
            color: 'green',
            value: null,
          },
        ],
      },
      unit: 'none',
    },
    overrides: [],
  },
  options: {
    colorMode: 'none',
    graphMode: 'none',
    justifyMode: 'auto',
    orientation: 'auto',
    reduceOptions: {
      calcs: [
        'lastNotNull',
      ],
      fields: '',
      values: false,
    },
    textMode: 'auto',
  },
  pluginVersion: '10.2.0-60139',
};

local averageConsumersPerTopicPanel = {
  datasource: promDatasource,
  targets: [
    prometheus.target(
      'avg by (instance, activemq_cluster, job) (activemq_topic_consumer_count{job=~"$job", activemq_cluster=~"$activemq_cluster", instance=~"$instance"})',
      datasource=promDatasource,
      legendFormat='{{instance}}',
    ),
  ],
  type: 'stat',
  title: 'Average consumers per topic',
  description: 'Average number of consumers per topic.',
  fieldConfig: {
    defaults: {
      color: {
        mode: 'thresholds',
      },
      mappings: [],
      thresholds: {
        mode: 'absolute',
        steps: [
          {
            color: 'green',
            value: null,
          },
        ],
      },
      unit: 'none',
    },
    overrides: [],
  },
  options: {
    colorMode: 'none',
    graphMode: 'none',
    justifyMode: 'auto',
    orientation: 'auto',
    reduceOptions: {
      calcs: [
        'lastNotNull',
      ],
      fields: '',
      values: false,
    },
    textMode: 'auto',
  },
  pluginVersion: '10.2.0-60139',
};

local topTopicsByEnqueueRatePanel = {
  datasource: promDatasource,
  targets: [
    prometheus.target(
      'topk by(instance, activemq_cluster, job) ($k_selector, rate(activemq_topic_enqueue_count{job=~"$job", activemq_cluster=~"$activemq_cluster", instance=~"$instance", destination=~".*$name.*"}[$__rate_interval]))',
      datasource=promDatasource,
      legendFormat='{{activemq_cluster}} - {{instance}} - {{destination}}',
    ),
  ],
  type: 'timeseries',
  title: 'Top topics by enqueue rate',
  description: 'The rate messages are sent to the top k topic destinations.',
  fieldConfig: {
    defaults: {
      color: {
        mode: 'palette-classic',
      },
      custom: {
        axisCenteredZero: false,
        axisColorMode: 'text',
        axisLabel: '',
        axisPlacement: 'auto',
        axisShow: false,
        barAlignment: 0,
        drawStyle: 'line',
        fillOpacity: 25,
        gradientMode: 'none',
        hideFrom: {
          legend: false,
          tooltip: false,
          viz: false,
        },
        insertNulls: false,
        lineInterpolation: 'smooth',
        lineWidth: 2,
        pointSize: 5,
        scaleDistribution: {
          type: 'linear',
        },
        showPoints: 'never',
        spanNulls: false,
        stacking: {
          group: 'A',
          mode: 'none',
        },
        thresholdsStyle: {
          mode: 'off',
        },
      },
      mappings: [],
      thresholds: {
        mode: 'absolute',
        steps: [
          {
            color: 'green',
            value: null,
          },
        ],
      },
      unit: 'mps',
    },
    overrides: [],
  },
  options: {
    legend: {
      calcs: [],
      displayMode: 'list',
      placement: 'right',
      showLegend: true,
    },
    tooltip: {
      mode: 'multi',
      sort: 'desc',
    },
  },
};

local topTopicsByDequeueRatePanel = {
  datasource: promDatasource,
  targets: [
    prometheus.target(
      'topk by(instance, activemq_cluster, job) ($k_selector, rate(activemq_topic_dequeue_count{job=~"$job", activemq_cluster=~"$activemq_cluster", instance=~"$instance", destination=~".*$name.*"}[$__rate_interval]))',
      datasource=promDatasource,
      legendFormat='{{activemq_cluster}} - {{instance}} - {{destination}}',
    ),
  ],
  type: 'timeseries',
  title: 'Top topics by dequeue rate',
  description: 'The rate messages have been acknowledged (and removed) from the top k topic destinations',
  fieldConfig: {
    defaults: {
      color: {
        mode: 'palette-classic',
      },
      custom: {
        axisCenteredZero: false,
        axisColorMode: 'text',
        axisLabel: '',
        axisPlacement: 'auto',
        axisShow: false,
        barAlignment: 0,
        drawStyle: 'line',
        fillOpacity: 25,
        gradientMode: 'none',
        hideFrom: {
          legend: false,
          tooltip: false,
          viz: false,
        },
        insertNulls: false,
        lineInterpolation: 'smooth',
        lineWidth: 2,
        pointSize: 5,
        scaleDistribution: {
          type: 'linear',
        },
        showPoints: 'never',
        spanNulls: false,
        stacking: {
          group: 'A',
          mode: 'none',
        },
        thresholdsStyle: {
          mode: 'off',
        },
      },
      mappings: [],
      thresholds: {
        mode: 'absolute',
        steps: [
          {
            color: 'green',
            value: null,
          },
        ],
      },
      unit: 'mps',
    },
    overrides: [],
  },
  options: {
    legend: {
      calcs: [],
      displayMode: 'list',
      placement: 'right',
      showLegend: true,
    },
    tooltip: {
      mode: 'multi',
      sort: 'desc',
    },
  },
};

local topTopicsByAverageEnqueueTimePanel = {
  datasource: promDatasource,
  targets: [
    prometheus.target(
      'topk by(instance, activemq_cluster, job) ($k_selector, activemq_topic_average_enqueue_time{job=~"$job", activemq_cluster=~"$activemq_cluster", instance=~"$instance", destination=~".*$name.*"})',
      datasource=promDatasource,
      legendFormat='{{activemq_cluster}} - {{instance}} - {{destination}}',
    ),
  ],
  type: 'timeseries',
  title: 'Top topics by average enqueue time',
  description: 'Average time a message was held on top k topic destinations.',
  fieldConfig: {
    defaults: {
      color: {
        mode: 'palette-classic',
      },
      custom: {
        axisCenteredZero: false,
        axisColorMode: 'text',
        axisLabel: '',
        axisPlacement: 'auto',
        axisShow: false,
        barAlignment: 0,
        drawStyle: 'line',
        fillOpacity: 25,
        gradientMode: 'none',
        hideFrom: {
          legend: false,
          tooltip: false,
          viz: false,
        },
        insertNulls: false,
        lineInterpolation: 'smooth',
        lineWidth: 2,
        pointSize: 5,
        scaleDistribution: {
          type: 'linear',
        },
        showPoints: 'never',
        spanNulls: false,
        stacking: {
          group: 'A',
          mode: 'none',
        },
        thresholdsStyle: {
          mode: 'off',
        },
      },
      mappings: [],
      thresholds: {
        mode: 'absolute',
        steps: [
          {
            color: 'green',
            value: null,
          },
        ],
      },
      unit: 'ms',
    },
    overrides: [],
  },
  options: {
    legend: {
      calcs: [],
      displayMode: 'list',
      placement: 'right',
      showLegend: true,
    },
    tooltip: {
      mode: 'multi',
      sort: 'desc',
    },
  },
};

local topTopicsByExpiredMessageRatePanel = {
  datasource: promDatasource,
  targets: [
    prometheus.target(
      'topk by(instance, activemq_cluster, job) ($k_selector, rate(activemq_topic_expired_count{job=~"$job", activemq_cluster=~"$activemq_cluster", instance=~"$instance", destination=~".*$name.*"}[$__rate_interval]))',
      datasource=promDatasource,
      legendFormat='{{activemq_cluster}} - {{instance}} - {{destination}}',
    ),
  ],
  type: 'timeseries',
  title: 'Top topics by expired message rate',
  description: 'The rate messages have expired on the top k topic destinations.',
  fieldConfig: {
    defaults: {
      color: {
        mode: 'palette-classic',
      },
      custom: {
        axisCenteredZero: false,
        axisColorMode: 'text',
        axisLabel: '',
        axisPlacement: 'auto',
        axisShow: false,
        barAlignment: 0,
        drawStyle: 'line',
        fillOpacity: 25,
        gradientMode: 'none',
        hideFrom: {
          legend: false,
          tooltip: false,
          viz: false,
        },
        insertNulls: false,
        lineInterpolation: 'smooth',
        lineWidth: 2,
        pointSize: 5,
        scaleDistribution: {
          type: 'linear',
        },
        showPoints: 'never',
        spanNulls: false,
        stacking: {
          group: 'A',
          mode: 'none',
        },
        thresholdsStyle: {
          mode: 'off',
        },
      },
      mappings: [],
      thresholds: {
        mode: 'absolute',
        steps: [
          {
            color: 'green',
            value: null,
          },
        ],
      },
      unit: 'mps',
    },
    overrides: [],
  },
  options: {
    legend: {
      calcs: [],
      displayMode: 'list',
      placement: 'right',
      showLegend: true,
    },
    tooltip: {
      mode: 'multi',
      sort: 'desc',
    },
  },
};

local topTopicsByConsumersPanel = {
  datasource: promDatasource,
  targets: [
    prometheus.target(
      'topk by(instance, activemq_cluster, job) (5, activemq_topic_consumer_count{job=~"$job", activemq_cluster=~"$activemq_cluster", instance=~"$instance", destination=~".*$name.*"})',
      datasource=promDatasource,
      legendFormat='{{activemq_cluster}} - {{instance}} - {{destination}}',
    ),
  ],
  type: 'bargauge',
  title: 'Top topics by consumers',
  description: 'The number of consumers subscribed to the most active/used topics.',
  fieldConfig: {
    defaults: {
      color: {
        mode: 'fixed',
      },
      mappings: [],
      thresholds: {
        mode: 'absolute',
        steps: [
          {
            color: 'green',
            value: null,
          },
        ],
      },
      unit: 'none',
    },
    overrides: [],
  },
  options: {
    displayMode: 'gradient',
    minVizHeight: 10,
    minVizWidth: 0,
    orientation: 'horizontal',
    reduceOptions: {
      calcs: [
        'lastNotNull',
      ],
      fields: '',
      values: false,
    },
    showUnfilled: true,
    valueMode: 'color',
  },
  pluginVersion: '10.2.0-60139',
};

local topTopicsByAverageMessageSizePanel = {
  datasource: promDatasource,
  targets: [
    prometheus.target(
      'topk by(instance, activemq_cluster, job) (5, activemq_topic_average_message_size{job=~"$job", activemq_cluster=~"$activemq_cluster", instance=~"$instance", destination=~".*$name.*"})',
      datasource=promDatasource,
      legendFormat='{{activemq_cluster}} - {{instance}} - {{destination}}',
    ),
  ],
  type: 'timeseries',
  title: 'Top topics by average message size',
  description: 'Average message size on topic destinations.',
  fieldConfig: {
    defaults: {
      color: {
        mode: 'palette-classic',
      },
      custom: {
        axisCenteredZero: false,
        axisColorMode: 'text',
        axisLabel: '',
        axisPlacement: 'auto',
        axisShow: false,
        axisSoftMin: 0,
        barAlignment: 0,
        drawStyle: 'line',
        fillOpacity: 25,
        gradientMode: 'none',
        hideFrom: {
          legend: false,
          tooltip: false,
          viz: false,
        },
        insertNulls: false,
        lineInterpolation: 'smooth',
        lineWidth: 2,
        pointSize: 5,
        scaleDistribution: {
          type: 'linear',
        },
        showPoints: 'never',
        spanNulls: false,
        stacking: {
          group: 'A',
          mode: 'normal',
        },
        thresholdsStyle: {
          mode: 'off',
        },
      },
      mappings: [],
      min: 0,
      thresholds: {
        mode: 'absolute',
        steps: [
          {
            color: 'green',
            value: null,
          },
        ],
      },
      unit: 'decbytes',
    },
    overrides: [],
  },
  options: {
    legend: {
      calcs: [],
      displayMode: 'list',
      placement: 'right',
      showLegend: true,
    },
    tooltip: {
      mode: 'multi',
      sort: 'desc',
    },
  },
};

local topicSummaryPanel = {
  datasource: promDatasource,
  targets: [
    prometheus.target(
      'rate(activemq_topic_enqueue_count{job=~"$job", activemq_cluster=~"$activemq_cluster", instance=~"$instance", destination=~".*$name.*"}[$__rate_interval])',
      datasource=promDatasource,
      legendFormat='{{instance}}',
      format='table',
    ),
    prometheus.target(
      'rate(activemq_topic_dequeue_count{job=~"$job", activemq_cluster=~"$activemq_cluster", instance=~"$instance", destination=~".*$name.*"}[$__rate_interval])',
      datasource=promDatasource,
      legendFormat='{{instance}}',
      format='table',
    ),
    prometheus.target(
      'activemq_topic_average_enqueue_time{job=~"$job", activemq_cluster=~"$activemq_cluster", instance=~"$instance", destination=~".*$name.*"}',
      datasource=promDatasource,
      legendFormat='{{instance}}',
      format='table',
    ),
    prometheus.target(
      'activemq_topic_average_message_size{job=~"$job", activemq_cluster=~"$activemq_cluster", instance=~"$instance", destination=~".*$name.*"}',
      datasource=promDatasource,
      legendFormat='{{instance}}',
      format='table',
    ),
  ],
  type: 'table',
  title: 'Topic summary',
  description: 'Summary of topics showing topic name, enqueue and dequeue rate, average enqueue time, and average message size.',
  fieldConfig: {
    defaults: {
      color: {
        mode: 'thresholds',
      },
      custom: {
        align: 'left',
        cellOptions: {
          type: 'auto',
        },
        inspect: false,
      },
      mappings: [],
      thresholds: {
        mode: 'absolute',
        steps: [
          {
            color: 'green',
          },
        ],
      },
    },
    overrides: [
      {
        matcher: {
          id: 'byName',
          options: 'Enqueue rate',
        },
        properties: [
          {
            id: 'unit',
            value: 'mps',
          },
        ],
      },
      {
        matcher: {
          id: 'byName',
          options: 'Dequeue rate',
        },
        properties: [
          {
            id: 'unit',
            value: 'mps',
          },
        ],
      },
      {
        matcher: {
          id: 'byName',
          options: 'Average enqueue time',
        },
        properties: [
          {
            id: 'unit',
            value: 'ms',
          },
        ],
      },
      {
        matcher: {
          id: 'byName',
          options: 'Average message size',
        },
        properties: [
          {
            id: 'unit',
            value: 'decbytes',
          },
        ],
      },
    ],
  },
  options: {
    cellHeight: 'sm',
    footer: {
      countRows: false,
      fields: '',
      reducer: [
        'sum',
      ],
      show: false,
    },
    showHeader: true,
  },
  pluginVersion: '10.2.0-60139',
  transformations: [
    {
      id: 'joinByField',
      options: {
        byField: 'destination',
        mode: 'outer',
      },
    },
    {
      id: 'organize',
      options: {
        excludeByName: {
          'Time 1': true,
          'Time 2': true,
          'Time 3': true,
          'Time 4': true,
          '__name__ 1': true,
          '__name__ 2': true,
          'activemq_cluster 1': true,
          'activemq_cluster 2': true,
          'activemq_cluster 3': true,
          'activemq_cluster 4': true,
          'instance 1': true,
          'instance 2': true,
          'instance 3': true,
          'instance 4': true,
          'job 1': true,
          'job 2': true,
          'job 3': true,
          'job 4': true,
        },
        indexByName: {},
        renameByName: {
          'Time 3': '',
          'Value #A': 'Enqueue rate',
          'Value #B': 'Dequeue rate',
          'Value #C': 'Average enqueue time',
          'Value #D': 'Average message size',
          destination: 'Destination',
        },
      },
    },
  ],
};

{
  grafanaDashboards+:: {
    'apache-activemq-topic-overview.json':
      dashboard.new(
        'Apache ActiveMQ topic overview',
        time_from='%s' % $._config.dashboardPeriod,
        tags=($._config.dashboardTags),
        timezone='%s' % $._config.dashboardTimezone,
        refresh='%s' % $._config.dashboardRefresh,
        description='',
        uid=dashboardUid,
      )

      .addTemplates(
        [
          template.datasource(
            promDatasourceName,
            'prometheus',
            null,
            label='Data Source',
            refresh='load'
          ),
          template.new(
            'job',
            promDatasource,
            'label_values(activemq_topic_producer_count,job)',
            label='Job',
            refresh=2,
            includeAll=true,
            multi=true,
            allValues='',
            sort=0
          ),
          template.new(
            'cluster',
            promDatasource,
            'label_values(activemq_memory_usage_ratio{job=~"$job"},cluster)',
            label='Cluster',
            refresh=2,
            includeAll=true,
            multi=true,
            allValues='',
            sort=0
          ),
          template.new(
            'activemq_cluster',
            promDatasource,
            'label_values(activemq_memory_usage_ratio{job=~"$job", cluster=~"$cluster"},activemq_cluster)',
            label='ActiveMQ cluster',
            refresh=2,
            includeAll=true,
            multi=true,
            allValues='',
            sort=0
          ),
          template.new(
            'instance',
            promDatasource,
            'label_values(activemq_topic_producer_count{activemq_cluster=~"$activemq_cluster"},instance)',
            label='Instance',
            refresh=2,
            includeAll=true,
            multi=true,
            allValues='',
            sort=0
          ),
          template.new(
            'k_selector',
            promDatasource,
            '2,4,6,8,10',
            label='Top k count',
            refresh=0,
            includeAll=false,
            multi=false,
            allValues='',
            sort=0
          ),
          template.new(
            'name',
            promDatasource,
            '',
            label='Topic by name',
            refresh=0,
            includeAll=false,
            multi=false,
            allValues='',
            sort=0
          ),
        ]
      )
      .addLink(grafana.link.dashboards(
        asDropdown=false,
        title='Other Apache ActiveMQ dashboards',
        includeVars=true,
        keepTime=true,
        tags=($._config.dashboardTags),
      ))
      .addPanels(
        [
          numberOfTopicsPanel { gridPos: { h: 4, w: 6, x: 0, y: 0 } },
          producerCountPanel { gridPos: { h: 4, w: 6, x: 6, y: 0 } },
          consumerCountPanel { gridPos: { h: 4, w: 6, x: 12, y: 0 } },
          averageConsumersPerTopicPanel { gridPos: { h: 4, w: 6, x: 18, y: 0 } },
          topTopicsByEnqueueRatePanel { gridPos: { h: 8, w: 12, x: 0, y: 4 } },
          topTopicsByDequeueRatePanel { gridPos: { h: 8, w: 12, x: 12, y: 4 } },
          topTopicsByAverageEnqueueTimePanel { gridPos: { h: 8, w: 12, x: 0, y: 12 } },
          topTopicsByExpiredMessageRatePanel { gridPos: { h: 8, w: 12, x: 12, y: 12 } },
          topTopicsByConsumersPanel { gridPos: { h: 8, w: 12, x: 0, y: 20 } },
          topTopicsByAverageMessageSizePanel { gridPos: { h: 8, w: 12, x: 12, y: 20 } },
          topicSummaryPanel { gridPos: { h: 8, w: 24, x: 0, y: 28 } },
        ]
      ),
  },
}
