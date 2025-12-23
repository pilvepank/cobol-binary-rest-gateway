*>================================================================
*> PROGRAM:  proto_cors_test.cbl
*> PURPOSE:  Test Harness for Gateway CORS Security Validator
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. PROTO-CORS-TEST.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "CORS-CONFIG.cpy".
 01  WS-ORIGIN              PIC X(64).
 01  WS-TESTS-RUN           PIC 9(04) VALUE 0.
 01  WS-TESTS-PASSED        PIC 9(04) VALUE 0.

 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "=================================================="
     DISPLAY "  REST GATEWAY CORS VALIDATOR TEST SUITE          "
     DISPLAY "=================================================="
     
     ADD 1 TO WS-TESTS-RUN
     MOVE "https://portal.balticcore.ee" TO WS-ORIGIN
     CALL "PROTO-CORS-VALIDATOR" USING CORS-SECURITY-POLICY, WS-ORIGIN
     IF CORS-ALLOW
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 1: Whitelisted Origin Header Acceptance [PASS]"
     ELSE
         DISPLAY "TEST 1: Whitelisted Origin Header Acceptance [FAIL]"
     END-IF
     
     ADD 1 TO WS-TESTS-RUN
     MOVE "https://malicious-external-site.com" TO WS-ORIGIN
     CALL "PROTO-CORS-VALIDATOR" USING CORS-SECURITY-POLICY, WS-ORIGIN
     IF CORS-REJECT
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 2: Foreign Origin Cross-Site Rejection [PASS]"
     ELSE
         DISPLAY "TEST 2: Foreign Origin Cross-Site Rejection [FAIL]"
     END-IF

     DISPLAY "--------------------------------------------------"
     DISPLAY "CORS Tests Run:    " WS-TESTS-RUN
     DISPLAY "CORS Tests Passed: " WS-TESTS-PASSED
     IF WS-TESTS-RUN = WS-TESTS-PASSED
         DISPLAY ">> ALL CORS TESTS PASSED [100% OK] <<"
     ELSE
         DISPLAY ">> SOME CORS TESTS FAILED <<"
     END-IF
     STOP RUN.
