*>================================================================
*> PROGRAM:  proto_metrics_exporter.cbl
*> PURPOSE:  Prometheus Exposition Text Serializer
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. PROTO-METRICS-EXPORTER.

 DATA DIVISION.
 WORKING-STORAGE SECTION.

 LINKAGE SECTION.
 COPY "METRICS-COLLECTOR.cpy".
 01  LS-OUTPUT-PAYLOAD      PIC X(256).
 01  LS-PAYLOAD-LEN         PIC 9(04) COMP-5.

 PROCEDURE DIVISION USING PROMETHEUS-METRICS-BLOCK, LS-OUTPUT-PAYLOAD, LS-PAYLOAD-LEN.
 0000-MAIN.
     MOVE "# HELP gateway_requests_total Total HTTP requests" TO LS-OUTPUT-PAYLOAD(1:49)
     MOVE 49 TO LS-PAYLOAD-LEN
     GOBACK.
