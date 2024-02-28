# OpenStack mixin

The OpenStack mixin is a set of configurable Grafana dashboards and alerts.

The OpenStack mixin contains the following dashboards:

- OpenStack cloud overview
- OpenStack nova and neutron overview
- OpenStack cinder and glance overview
- OpenStack logs

and the following alerts:

- OpenStackPlacementHighMemoryUsageWarning
- OpenStackPlacementHighMemoryUsageCritical
- OpenStackNovaHighVMMemoryUsage
- OpenStackNovaHighVMVCPUUsage
- OpenStackNeutronHighDisconnectedPortRate
- OpenStackNeutronHighInactiveRouterRate
- OpenStackCinderHighBackupMemoryUsage
- OpenStackCinderHighVolumeMemoryUsage
- OpenStackCinderHighPoolCapacityUsage

## OpenStack cloud overview

The OpenStack cloud overview dashboard provides details on the statuses of the basic OpenStack services, alerts, cloud resource usage, and hierarchy.
![OpenStack cloud overview dashboard (services)](https://storage.googleapis.com/grafanalabs-integration-assets/openstack/screenshots/openstack_cloud_overview_1.png)
![OpenStack cloud overview dashboard (keystone)](https://storage.googleapis.com/grafanalabs-integration-assets/openstack/screenshots/openstack_cloud_overview_2.png)

## OpenStack nova and neutron overview

The OpenStack nova and neutron overview dashboard provides details on the compute and networking services in OpenStack.
![OpenStack nova and neutron overview dashboard (compute)](https://storage.googleapis.com/grafanalabs-integration-assets/openstack/screenshots/openstack_nova_and_neutron_overview_1.png)
![OpenStack nova and neutron overview dashboard (networks)](https://storage.googleapis.com/grafanalabs-integration-assets/openstack/screenshots/openstack_nova_and_neutron_overview_2.png)
![OpenStack nova and neutron overview dashboard (ports)](https://storage.googleapis.com/grafanalabs-integration-assets/openstack/screenshots/openstack_nova_and_neutron_overview_3.png)

## OpenStack cinder and glance overview

The OpenStack cinder and glance overview dashboard provides details on the block storage and image services in OpenStack.
![OpenStack cinder and glance overview dashboard (storage)](https://storage.googleapis.com/grafanalabs-integration-assets/openstack/screenshots/openstack_cinder_and_glance_overview_1.png)
![OpenStack cinder and glance overview dashboard (images)](https://storage.googleapis.com/grafanalabs-integration-assets/openstack/screenshots/openstack_cinder_and_glance_overview_2.png)

# OpenStack logs

The OpenStack logs dashboard provides details on incoming OpenStack journald logs.
![OpenStack logs dashboard](https://storage.googleapis.com/grafanalabs-integration-assets/openstack/screenshots/openstack_logs.png)

OpenStack logs are enabled by default in the `config.libsonnet` and can be disabled by setting `enableLokiLogs` to `false`. Then run `make` again to regenerate the dashboard:

```
{
  _config+:: {
    enableLokiLogs: false,
  },
}
```

For the selectors to properly work with the OpenStack logs ingested into your logs datasource, please also include the matching `instance` and `job` labels in the [scrape configs](https://grafana.com/docs/loki/latest/clients/promtail/configuration/#scrape_configs) to match the labels for ingested metrics.

```yaml
scrape_configs:
  - job_name: integrations/openstack
    journal:
      max_age: 12h
      labels:
        job: integrations/openstack
        instance: <your-instance-name>
    relabel_configs:
      - source_labels: ["__journal_systemd_unit"]
        target_label: "unit"
    pipeline_stages:
      - multiline:
          firstline: "(?P<level>(DEBUG|INFO|WARNING|ERROR)) "
      - regex:
          expression: '(?P<level>(DEBUG|INFO|WARNING|ERROR)) (?P<service>\w+)[\w|.]+ (\[.*] )(?P<message>.*)'
      - labels:
          level:
          service:
```

## Alerts overview

- OpenStackPlacementHighMemoryUsageWarning: The cloud is using a significant percentage of its allocated memory.
- OpenStackPlacementHighMemoryUsageCritical: The cloud is using a large percentage of its allocated memory, consider allocating more resources.
- OpenStackNovaHighVMMemoryUsage: VMs are using a high percentage of their allocated memory.
- OpenStackNovaHighVMVCPUUsage: VMs are using a high percentage of their allocated virtual CPUs.
- OpenStackNeutronHighDisconnectedPortRate: A high rate of ports have no IP addresses assigned to them.
- OpenStackNeutronHighInactiveRouterRate: A high rate of routers are currently inactive.
- OpenStackCinderHighBackupMemoryUsage: Cinder backups are using a large amount of their maximum memory.
- OpenStackCinderHighVolumeMemoryUsage: Cinder volumes are using a large amount of their maximum memory.
- OpenStackCinderHighPoolCapacityUsage: Cinder pools are using a large amount of their maximum capacity.

Default thresholds can be configured in `config.libsonnet`.

```js
{
    _configs+:: {
      alertsWarningPlacementHighMemoryUsage: 80, // %
      alertsCriticalPlacementHighMemoryUsage: 90,  // %
      alertsWarningNovaHighVMMemoryUsage: 80,  // %
      alertsWarningNovaHighVMVCPUUsage: 80,  // %
      alertsCriticalNeutronHighDisconnectedPortRate: 25, // %
      alertsCriticalNeutronHighInactiveRouterRate: 15, // %
      alertsWarningCinderHighBackupMemoryUsage: 80, // %
      alertsWarningCinderHighVolumeMemoryUsage: 80, // %
      alertsWarningCinderHighPoolCapacityUsage: 80, // %
    }
}
```

## Install tools

```bash
go install github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb@latest
go install github.com/monitoring-mixins/mixtool/cmd/mixtool@latest
```

For linting and formatting, `jsonnetfmt` must be installed. If you
have a working Go development environment, it's easiest to run the following:

```bash
go install github.com/google/go-jsonnet/cmd/jsonnetfmt@latest
```

The files in `dashboards_out` need to be imported
into your Grafana server. The exact details will depend on your environment.

`prometheus_alerts.yaml` needs to be imported into Prometheus.

## Generate dashboards and alerts

Edit `config.libsonnet` if required and then build JSON dashboard files for Grafana:

```bash
make
```

For more advanced uses of mixins, see
https://github.com/monitoring-mixins/docs.