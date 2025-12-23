*>================================================================
*> COPYBOOK: METRICS-COLLECTOR.cpy
*> PURPOSE:  Prometheus Text Format Metrics Collector Layout
*> ================================================================
 01  PROMETHEUS-METRICS-BLOCK.
     05  PM-TOTAL-REQUESTS       PIC 9(12) COMP-5 VALUE 0.
     05  PM-HTTP-200-OK          PIC 9(12) COMP-5 VALUE 0.
     05  PM-HTTP-400-BAD-REQ     PIC 9(12) COMP-5 VALUE 0.
     05  PM-HTTP-429-THROTTLED   PIC 9(12) COMP-5 VALUE 0.
     05  PM-HTTP-500-INTERNAL    PIC 9(12) COMP-5 VALUE 0.
     05  PM-P99-LATENCY-MS       PIC 9(05) COMP-5 VALUE 1.
