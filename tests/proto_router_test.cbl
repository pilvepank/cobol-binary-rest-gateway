*>================================================================
*> PROGRAM:  proto_router_test.cbl
*> PURPOSE:  Unit Test Suite for API Gateway Path Router
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. PROTO-ROUTER-TEST.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "ROUTER-TABLE.cpy".
 01  WS-URL                 PIC X(32) VALUE "/api/v1/orders                  ".
 01  WS-TARGET              PIC X(16) VALUE SPACES.
 01  WS-STAT                PIC X(02) VALUE '  '.
 01  WS-TESTS-RUN           PIC 9(04) VALUE 0.
 01  WS-TESTS-PASSED        PIC 9(04) VALUE 0.

 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "=================================================="
     DISPLAY "  API GATEWAY URL PATH ROUTER TEST SUITE          "
     DISPLAY "=================================================="
     
     ADD 1 TO WS-TESTS-RUN
     MOVE 1 TO RT-ROUTE-COUNT
     MOVE "/api/v1/orders                  " TO RT-URL-PATTERN(1)
     MOVE "LOB-MATCH-SVC   " TO RT-TARGET-BACKEND(1)
     
     CALL "PROTO-API-ROUTER" USING GATEWAY-ROUTER-TABLE, WS-URL, WS-TARGET, WS-STAT
     IF WS-STAT = '00' AND WS-TARGET = "LOB-MATCH-SVC   "
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 1: Registered Path Routes To Backend Service [PASS]"
     ELSE
         DISPLAY "TEST 1: Registered Path Routes To Backend Service [FAIL]"
     END-IF
     
     ADD 1 TO WS-TESTS-RUN
     MOVE "/unknown/route                 " TO WS-URL
     CALL "PROTO-API-ROUTER" USING GATEWAY-ROUTER-TABLE, WS-URL, WS-TARGET, WS-STAT
     IF WS-STAT = '44'
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 2: Unmatched Path Yields HTTP 404 Route Not Found [PASS]"
     ELSE
         DISPLAY "TEST 2: Unmatched Path Yields HTTP 404 Route Not Found [FAIL]"
     END-IF

     DISPLAY "--------------------------------------------------"
     DISPLAY "Router Tests Run:    " WS-TESTS-RUN
     DISPLAY "Router Tests Passed: " WS-TESTS-PASSED
     IF WS-TESTS-RUN = WS-TESTS-PASSED
         DISPLAY ">> ALL ROUTER TESTS PASSED [100% OK] <<"
     ELSE
         DISPLAY ">> SOME ROUTER TESTS FAILED <<"
     END-IF
     STOP RUN.
