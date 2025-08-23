*>================================================================
*> PROGRAM:  proto_jwt_test.cbl
*> PURPOSE:  Test Harness for Gateway JWT Authenticator
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. PROTO-JWT-TEST.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "JWT-TOKEN.cpy".
 01  WS-TOKEN               PIC X(128) VALUE "Bearer eyJhbGciOiJIUzI1NiJ9.test".
 01  WS-TESTS-RUN           PIC 9(04) VALUE 0.
 01  WS-TESTS-PASSED        PIC 9(04) VALUE 0.

 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "=================================================="
     DISPLAY "  REST GATEWAY JWT AUTH TEST SUITE                "
     DISPLAY "=================================================="
     
     ADD 1 TO WS-TESTS-RUN
     CALL "PROTO-JWT-AUTH" USING JWT-CLAIM-CONTEXT, WS-TOKEN
     IF JWT-VALID AND JWT-ROLE = "TRADER  "
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 1: Valid Bearer JWT Claims Extraction [PASS]"
     ELSE
         DISPLAY "TEST 1: Valid Bearer JWT Claims Extraction [FAIL]"
     END-IF
     
     DISPLAY "--------------------------------------------------"
     DISPLAY "JWT Tests Run:    " WS-TESTS-RUN
     DISPLAY "JWT Tests Passed: " WS-TESTS-PASSED
     IF WS-TESTS-RUN = WS-TESTS-PASSED
         DISPLAY ">> ALL JWT TESTS PASSED [100% OK] <<"
     ELSE
         DISPLAY ">> SOME JWT TESTS FAILED <<"
     END-IF
     STOP RUN.
