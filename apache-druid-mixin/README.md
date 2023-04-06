# Apache Druid Mixin

The Apache Druid mixin is a set of configurable Grafana dashboards and alerts.

The Apache Druid mixin contains the following dashboards:

- Apache Druid overview

and the following alerts:

- HighQueryFailures
- HighQueryTimeouts

## Apache Druid Overview

The Apache Druid overview dashboard provides details on queries and SQL query usages for each configured Apache Druid service.

#TODO screenshots

## Alerts Overview

HighQueryFailures: There are a high number of query failures.
HighQueryTimeouts: There are a high number of query timeouts.

## Install tools

```bash
go install github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb@latest
go install github.com/monitoring-mixins/mixtool/cmd/mixtool@latest
```

For linting and formatting, you would also need `jsonnetfmt` installed. If you
have a working Go development environment, it's easiest to run the following:

```bash
go install github.com/google/go-jsonnet/cmd/jsonnetfmt@latest
```

The files in `dashboards_out` need to be imported
into your Grafana server. The exact details will be depending on your environment.

`prometheus_alerts.yaml` needs to be imported into Prometheus.

## Generate dashboards and alerts

Edit `config.libsonnet` if required and then build JSON dashboard files for Grafana:

```bash
make
```

For more advanced uses of mixins, see
https://github.com/monitoring-mixins/docs.