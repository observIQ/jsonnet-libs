local g = import './g.libsonnet';
local commonlib = import 'common-lib/common/main.libsonnet';
local utils = commonlib.utils;

{
  new(this):
    {
      local t = this.grafana.targets,
      local stat = g.panel.stat,
      local table = g.panel.table,
      local barGauge = g.panel.barGauge,

      vmOnStatus:
        commonlib.panels.generic.stat.info.new(
          'VMs on',
          targets=[t.vmOnStatus],
          description='The number of virtual machines currently powered on.'
        )
        + stat.options.withGraphMode('none'),

      vmOffStatus:
        commonlib.panels.generic.stat.info.new(
          'VMs off',
          targets=[t.vmOffStatus],
          description='The number of virtual machines currently powered off.'
        )
        + stat.options.withGraphMode('none'),

      vmSuspendedStatus:
        commonlib.panels.generic.stat.info.new(
          'VMs suspended',
          targets=[t.vmSuspendedStatus],
          description='The number of virtual machines currently in a suspended state.'
        )
        + stat.options.withGraphMode('none'),

      vmTemplateStatus:
        commonlib.panels.generic.stat.info.new(
          'VM templates',
          targets=[t.vmTemplateStatus],
          description='The number of virtual machine templates available.'
        )
        + stat.options.withGraphMode('none'),
      vmOnStatusCluster:
        commonlib.panels.generic.stat.info.new(
          'VMs on',
          targets=[t.vmOnStatusCluster],
          description='The number of virtual machines currently powered on within the cluster.'
        )
        + stat.options.withGraphMode('none'),

      vmOffStatusCluster:
        commonlib.panels.generic.stat.info.new(
          'VMs off',
          targets=[t.vmOffStatusCluster],
          description='The number of virtual machines currently powered off within the cluster.'
        )
        + stat.options.withGraphMode('none'),

      vmSuspendedStatusCluster:
        commonlib.panels.generic.stat.info.new(
          'VMs suspended',
          targets=[t.vmSuspendedStatusCluster],
          description='The number of virtual machines currently in a suspended state within the cluster.'
        )
        + stat.options.withGraphMode('none'),

      vmTemplateStatusCluster:
        commonlib.panels.generic.stat.info.new(
          'VM templates',
          targets=[t.vmTemplateStatusCluster],
          description='The number of virtual machine templates available within the cluster.'
        )
        + stat.options.withGraphMode('none'),

      clusterCountStatus:
        commonlib.panels.generic.stat.info.new(
          'Cluster count',
          targets=[t.clusterCountStatus],
          description='The total number of clusters in the vCenter environment.'
        )
        + stat.options.withGraphMode('none'),

      resourcePoolCountStatus:
        commonlib.panels.generic.stat.info.new(
          'Resource pool count',
          targets=[t.resourcePoolCountStatus],
          description='The total number of resource pools in the vCenter environment.'
        )
        + stat.options.withGraphMode('none'),

      esxiHostsActiveStatus:
        commonlib.panels.generic.stat.info.new(
          'Active ESXi hosts',
          targets=[t.esxiHostsActiveStatus],
          description='The number of ESXi hosts that are currently in an active state.'
        )
        + stat.options.withGraphMode('none'),

      esxiHostsInactiveStatus:
        commonlib.panels.generic.stat.info.new(
          'Inactive ESXi hosts',
          targets=[t.esxiHostsInactiveStatus],
          description='The number of ESXi hosts that are currently in an inactive state.'
        )
        + stat.options.withGraphMode('none'),

      esxiHostsActiveStatusCluster:
        commonlib.panels.generic.stat.info.new(
          'Active ESXi hosts',
          targets=[t.esxiHostsActiveStatusCluster],
          description='The number of ESXi hosts that are currently in an active state within the cluster.'
        )
        + stat.options.withGraphMode('none'),

      esxiHostsInactiveStatusCluster:
        commonlib.panels.generic.stat.info.new(
          'Inactive ESXi hosts',
          targets=[t.esxiHostsInactiveStatusCluster],
          description='The number of ESXi hosts that are currently in an inactive state within the cluster.'
        )
        + stat.options.withGraphMode('none'),

      topCPUUtilizationClusters:
        commonlib.panels.generic.timeSeries.base.new(
          'Top CPU utilization by cluster',
          targets=[t.topCPUUtilizationClusters],
          description='The clusters with the highest CPU utilization percentage.'
        ),

      topMemoryUtilizationClusters:
        commonlib.panels.generic.timeSeries.base.new(
          'Top memory utilization by cluster',
          targets=[t.topMemoryUtilizationClusters],
          description='The clusters with the highest memory utilization percentage.'
        ),

      clustersTable:
        g.panel.table.new(
          'Clusters table',
          targets=[t.clustersTable],
          description='A table displaying information about the clusters in the vCenter environment.'
        ),

      topCPUUsageResourcePools:
        commonlib.panels.generic.timeSeries.base.new(
          'Top CPU usage resource pools',
          targets=[t.topCPUUsageResourcePools],
          description='The resource pools with the highest CPU usage.'
        ),

      topMemoryUsageResourcePools:
        commonlib.panels.generic.timeSeries.base.new(
          'Top memory usage resource pools',
          targets=[t.topMemoryUsageResourcePools],
          description='The resource pools with the highest memory usage.'
        ),

      topCPUShareResourcePools:
        commonlib.panels.generic.timeSeries.base.new(
          'Top CPU share resource pools',
          targets=[t.topCPUShareResourcePools],
          description='The resource pools with the highest amount of CPU shares allocated.'
        ),

      topMemoryShareResourcePools:
        commonlib.panels.generic.timeSeries.base.new(
          'Top memory share resource pools',
          targets=[t.topMemoryShareResourcePools],
          description='The resource pools with the highest amount of memory shares allocated.'
        ),

      topCPUUtilizationEsxiHosts:
        commonlib.panels.generic.timeSeries.base.new(
          'Top CPU utilization ESXi hosts',
          targets=[t.topCPUUtilizationEsxiHosts],
          description='The ESXi hosts with the highest CPU utilization percentage.'
        ),

      topMemoryUsageEsxiHosts:
        commonlib.panels.generic.timeSeries.base.new(
          'Top memory usage ESXi hosts',
          targets=[t.topMemoryUsageEsxiHosts],
          description='The ESXi hosts with the highest memory usage.'
        ),

      topNetworksActiveEsxiHosts:
        commonlib.panels.generic.timeSeries.base.new(
          'Top networks active ESXi hosts',
          targets=[t.topNetworksActiveEsxiHosts],
          description='The ESXi hosts with the highest network throughput.'
        ),

      topPacketErrorEsxiHosts:
        commonlib.panels.generic.timeSeries.base.new(
          'Top packet error ESXi hosts',
          targets=[t.topPacketErrorEsxiHosts],
          description='The ESXi hosts with the highest number of packet errors.'
        ),

      datastoresTable:
        g.panel.table.new(
          'Datastores table',
          targets=[t.datastoresTable],
          description='A table displaying information about the datastores in the vCenter environment.'
        ),

      hostCPUUsage:
        commonlib.panels.generic.timeSeries.base.new(
          'Host CPU usage',
          targets=[t.hostCPUUsage],
          description='The amount of CPU used by the ESXi host.'
        ),

      hostCPUUtilization:
        commonlib.panels.generic.timeSeries.base.new(
          'Host CPU utilization',
          targets=[t.hostCPUUtilization],
          description='The CPU utilization percentage of the ESXi host.'
        ),

      hostMemoryUsage:
        g.panel.timeSeries.new(
          'Host memory usage',
          targets=[t.hostMemoryUsage],
          description='The amount of memory used by the ESXi host.'
        ),

      hostMemoryUtilization:
        commonlib.panels.generic.timeSeries.base.new(
          'Host memory utilization',
          targets=[t.hostMemoryUtilization],
          description='The memory utilization percentage of the ESXi host.'
        ),

      modifiedMemory:
        commonlib.panels.generic.timeSeries.base.new(
          'Modified memory',
          targets=[t.modifiedMemory],
          description='The amount of memory that has been modified or ballooned on the ESXi host.'
        ),

      networkThroughputRate:
        commonlib.panels.generic.timeSeries.base.new(
          'Network throughput rate',
          targets=[t.networkTransmittedThroughputRate, t.networkReceivedThroughputRate],
          description='The rate of data transmitted or received over the network of the ESXi host.'
        ),

      packetRate:
        commonlib.panels.generic.timeSeries.base.new(
          'Packet rate',
          targets=[t.packetReceivedRate, t.packetTransmittedRate],
          description='The rate of packets received or transmitted over the ESXi hosts networks.'
        ),

      VMTable:
        g.panel.table.new(
          'VMs table',
          targets=[t.VMTable],
          description='A table displaying information about the virtual machines in the vCenter environment.'
        ),

      disksTable:
        g.panel.table.new(
          'Disks table',
          targets=[t.disksTable],
          description='A table displaying information about the disks associated with the virtual machines.'
        ),

      vmCPUUsage:
        commonlib.panels.generic.timeSeries.base.new(
          'Host CPU usage',
          targets=[t.vmCPUUsage],
          description='The amount of CPU used by the VMs.'
        ),

      vmCPUUtilization:
        commonlib.panels.generic.timeSeries.base.new(
          'Host CPU utilization',
          targets=[t.vmCPUUtilization],
          description='The CPU utilization percentage of VMs.'
        ),

      vmMemoryUsage:
        g.panel.timeSeries.new(
          'Host memory usage',
          targets=[t.vmMemoryUsage],
          description='The amount of memory used by the VMs.'
        ),

      vmMemoryUtilization:
        commonlib.panels.generic.timeSeries.base.new(
          'Host memory utilization',
          targets=[t.vmMemoryUtilization],
          description='The memory utilization percentage of the VMs.'
        ),

      vmModifiedMemory:
        commonlib.panels.generic.timeSeries.base.new(
          'Modified memory',
          targets=[t.vmModifiedMemory],
          description='The amount of memory that has been modified or ballooned on the VMs.'
        ),

      vmNetworkThroughputRate:
        commonlib.panels.generic.timeSeries.base.new(
          'Network throughput rate',
          targets=[t.vmNetworkReceivedThroughputRate, t.vmNetworkTransmittedThroughputRate],
          description='The rate of data transmitted or received over the network of the VMs.'
        ),

      vmPacketRate:
        commonlib.panels.generic.timeSeries.base.new(
          'Packet rate',
          targets=[t.vmPacketReceivedRate, t.vmPacketTransmittedRate],
          description='The rate of packets received or transmitted over the VMs network.'
        ),

      clusterCPUEffective:
        commonlib.panels.generic.timeSeries.base.new(
          'Cluster CPU effective',
          targets=[t.clusterCPUEffective],
          description='The effective CPU capacity of the cluster, excluding hosts in maintenance mode or unresponsive hosts.'
        ),

      clusterCPULimit:
        commonlib.panels.generic.timeSeries.base.new(
          'Cluster CPU limit',
          targets=[t.clusterCPULimit],
          description='The available CPU capacity of the cluster, aggregated from all hosts.'
        ),

      clusterCPUUtilization:
        commonlib.panels.generic.timeSeries.base.new(
          'Cluster CPU utilization',
          targets=[t.clusterCPUUtilization],
          description='The CPU utilization percentage of the cluster.'
        ),

      clusterMemoryEffective:
        commonlib.panels.generic.timeSeries.base.new(
          'Cluster memory effective',
          targets=[t.clusterMemoryEffective],
          description='The effective memory capacity of the cluster, excluding hosts in maintenance mode or unresponsive hosts.'
        ),

      clusterMemoryLimit:
        commonlib.panels.generic.timeSeries.base.new(
          'Cluster memory limit',
          targets=[t.clusterMemoryLimit],
          description='The available memory capacity of the cluster, aggregated from all hosts.'
        ),

      clusterMemoryUtilization:
        commonlib.panels.generic.timeSeries.base.new(
          'Cluster memory utilization',
          targets=[t.clusterMemoryUtilization],
          description='The memory utilization percentage of the cluster.'
        ),

      esxiHostsTable:
        g.panel.table.new(
          'ESXi hosts table',
          targets=[t.esxiHostsTable],
          description='A table displaying information about the ESXi hosts in the vCenter environment.'
        ),
    },
}