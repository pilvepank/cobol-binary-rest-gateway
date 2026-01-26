*>================================================================
*> PROGRAM:  proto_circuit_test.cbl
*> PURPOSE:  Unit Test Suite for API Gateway Circuit Breaker
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. PROTO-CIRCUIT-TEST.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "CIRCUIT-STATE.cpy".
 01  WS-RES                 PIC X(01) VALUE 'F'.
 01  WS-ALLOW               PIC X(01) VALUE 'Y'.
 01  WS-TESTS-RUN           PIC 9(04) VALUE 0.
 01  WS-TESTS-PASSED        PIC 9(04) VALUE 0.

 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "=================================================="
     DISPLAY "  API GATEWAY CIRCUIT BREAKER TEST SUITE          "
     DISPLAY "=================================================="
     
     ADD 1 TO WS-TESTS-RUN
     MOVE 'C' TO CB-CURRENT-STATE
     MOVE 0 TO CB-CONSECUTIVE-FAILURES
     MOVE 3 TO CB-FAILURE-THRESHOLD
     
     MOVE 'F' TO WS-RES
     CALL "PROTO-CIRCUIT-BREAKER" USING CIRCUIT-BREAKER-RECORD, WS-RES, WS-ALLOW
     CALL "PROTO-CIRCUIT-BREAKER" USING CIRCUIT-BREAKER-RECORD, WS-RES, WS-ALLOW
     CALL "PROTO-CIRCUIT-BREAKER" USING CIRCUIT-BREAKER-RECORD, WS-RES, WS-ALLOW
     IF CB-IS-OPEN
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 1: 3 Failures Trip Circuit Breaker to Open [PASS]"
     ELSE
         DISPLAY "TEST 1: 3 Failures Trip Circuit Breaker to Open [FAIL]"
     END-IF
     
     ADD 1 TO WS-TESTS-RUN
     CALL "PROTO-CIRCUIT-BREAKER" USING CIRCUIT-BREAKER-RECORD, WS-RES, WS-ALLOW
     IF WS-ALLOW = 'N'
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 2: Open Circuit Rejects Inbound Request [PASS]"
     ELSE
         DISPLAY "TEST 2: Open Circuit Rejects Inbound Request [FAIL]"
     END-IF

     DISPLAY "--------------------------------------------------"
     DISPLAY "Circuit Tests Run:    " WS-TESTS-RUN
     DISPLAY "Circuit Tests Passed: " WS-TESTS-PASSED
     IF WS-TESTS-RUN = WS-TESTS-PASSED
         DISPLAY ">> ALL CIRCUIT BREAKER TESTS PASSED [100% OK] <<"
     ELSE
         DISPLAY ">> SOME CIRCUIT BREAKER TESTS FAILED <<"
     END-IF
     STOP RUN.
