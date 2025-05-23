local g = import './g.libsonnet';

// Use g.util.grid.wrapPanels() to import into custom dashboard
{
  new(panels): {
    row_1:
      [
        g.panel.row.new('Row 1'),
        panels.connectionsPanel { gridPos+: { h: 8, w: 12, x: 0, y: 0 } },
        panels.batchRequestsPanel { gridPos+: { h: 8, w: 12, x: 12, y: 0 } },
      ],

    row_2:
      [
        g.panel.row.new('Row 2'),
        panels.severeErrorsPanel { gridPos+: { h: 8, w: 12, x: 0, y: 8 } },
        panels.deadlocksPanel { gridPos+: { h: 8, w: 12, x: 12, y: 8 } },
      ],

    row_3:
      [
        g.panel.row.new('Row 3'),
        panels.osMemoryUsagePanel { gridPos+: { h: 8, w: 24, x: 0, y: 16 } },
      ],

    row_4:
      [
        g.panel.row.new('Row 4'),
        panels.memoryManagerPanel { gridPos+: { h: 8, w: 16, x: 0, y: 24 } },
        panels.committedMemoryUtilizationPanel { gridPos+: { h: 8, w: 8, x: 16, y: 24 } },
      ],

    row_5:
      [
        g.panel.row.new('Row 5'),
        panels.errorLogsPanel { gridPos+: { h: 8, w: 24, x: 0, y: 32 } },
      ],

    row_6:
      [
        g.panel.row.new('Row 6'),
        panels.databaseWriteStallDurationPanel { gridPos+: { h: 8, w: 12, x: 0, y: 41 } },
        panels.databaseReadStallDurationPanel { gridPos+: { h: 8, w: 12, x: 12, y: 41 } },
      ],

    row_7:
      [
        g.panel.row.new('Row 7'),
        panels.transactionLogExpansionsPanel { gridPos+: { h: 8, w: 24, x: 0, y: 49 } },
      ],

  },
}