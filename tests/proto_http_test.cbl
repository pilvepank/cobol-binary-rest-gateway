*>================================================================
*> PROGRAM:  proto_http_test.cbl
*> PURPOSE:  Unit Test Suite for HTTP/1.1 Protocol Parser
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. PROTO-HTTP-TEST.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "copybooks/HTTP-REQ.cpy".
 01  WS-METH                PIC X(08) VALUE "GET     ".
 01  WS-PATH                PIC X(64) VALUE "/api/v1/accounts/1001                           ".
 01  WS-TESTS-RUN           PIC 9(04) VALUE 0.
 01  WS-TESTS-PASSED        PIC 9(04) VALUE 0.

 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "=================================================="
     DISPLAY "  HTTP/1.1 WIRE PROTOCOL PARSER TEST SUITE        "
     DISPLAY "=================================================="
     
     ADD 1 TO WS-TESTS-RUN
     MOVE "GET     " TO WS-METH
     MOVE "/api/v1/accounts/1001                           " TO WS-PATH
     CALL "PROTO-HTTP-PARSER" USING HTTP-REQUEST-BLOCK, WS-METH, WS-PATH
     IF HTTP-OK AND HTTP-METHOD = "GET     "
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 1: Valid GET Request Line Parsed [PASS]"
     ELSE
         DISPLAY "TEST 1: Valid GET Request Line Parsed [FAIL]"
     END-IF
     
     ADD 1 TO WS-TESTS-RUN
     MOVE "INVALID " TO WS-METH
     CALL "PROTO-HTTP-PARSER" USING HTTP-REQUEST-BLOCK, WS-METH, WS-PATH
     IF HTTP-BAD-METHOD
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 2: Unsupported Method Returns Error [PASS]"
     ELSE
         DISPLAY "TEST 2: Unsupported Method Returns Error [FAIL]"
     END-IF

     DISPLAY "--------------------------------------------------"
     DISPLAY "HTTP Tests Run:    " WS-TESTS-RUN
     DISPLAY "HTTP Tests Passed: " WS-TESTS-PASSED
     IF WS-TESTS-RUN = WS-TESTS-PASSED
         DISPLAY ">> ALL HTTP PARSER TESTS PASSED [100% OK] <<"
     ELSE
         DISPLAY ">> SOME HTTP PARSER TESTS FAILED <<"
     END-IF
     STOP RUN.
