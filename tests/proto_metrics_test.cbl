*>================================================================
*> PROGRAM:  proto_metrics_test.cbl
*> PURPOSE:  Test Harness for Prometheus Metrics Exporter
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. PROTO-METRICS-TEST.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "METRICS-COLLECTOR.cpy".
 01  WS-PAYLOAD             PIC X(256) VALUE SPACES.
 01  WS-LEN                 PIC 9(04) COMP-5 VALUE 0.
 01  WS-TESTS-RUN           PIC 9(04) VALUE 0.
 01  WS-TESTS-PASSED        PIC 9(04) VALUE 0.

 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "=================================================="
     DISPLAY "  REST GATEWAY PROMETHEUS EXPORTER TEST SUITE     "
     DISPLAY "=================================================="
     
     ADD 1 TO WS-TESTS-RUN
     MOVE 1000 TO PM-TOTAL-REQUESTS
     MOVE 990 TO PM-HTTP-200-OK
     MOVE 10 TO PM-HTTP-429-THROTTLED
     CALL "PROTO-METRICS-EXPORTER" USING PROMETHEUS-METRICS-BLOCK, WS-PAYLOAD, WS-LEN
     IF WS-LEN > 0 AND WS-PAYLOAD(1:6) = "# HELP"
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 1: Prometheus Exposition Format Emitter [PASS]"
     ELSE
         DISPLAY "TEST 1: Prometheus Exposition Format Emitter [FAIL]"
     END-IF
     
     DISPLAY "--------------------------------------------------"
     DISPLAY "Metrics Tests Run:    " WS-TESTS-RUN
     DISPLAY "Metrics Tests Passed: " WS-TESTS-PASSED
     IF WS-TESTS-RUN = WS-TESTS-PASSED
         DISPLAY ">> ALL METRICS TESTS PASSED [100% OK] <<"
     ELSE
         DISPLAY ">> SOME METRICS TESTS FAILED <<"
     END-IF
     STOP RUN.
