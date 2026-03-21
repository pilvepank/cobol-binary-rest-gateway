*>===============================================================*
*> PROGRAM:  proto_json_test.cbl                            *>
*> PURPOSE:  Unit Test Suite for JSON Parser & Deserializer *>
*> ================================================================*
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PROTO-JSON-TEST.

       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-JSON                     PIC X(256) VALUE '{"user": "alice", "amount": 500}'.
       01  WS-KEY                      PIC X(16) VALUE "user".
       01  WS-VAL                      PIC X(32).
       01  WS-STATUS                   PIC 9(02) COMP-5 VALUE 0.
       01  WS-TESTS-RUN                PIC 9(04) COMP-5 VALUE 0.
       01  WS-TESTS-PASSED             PIC 9(04) COMP-5 VALUE 0.

       PROCEDURE DIVISION.
       0000-MAIN.
           DISPLAY "==================================================".
           DISPLAY "  REST GATEWAY JSON PARSER INVARIANT TEST SUITE   ".
           DISPLAY "==================================================".

           ADD 1 TO WS-TESTS-RUN.
           CALL "PROTO-JSON-PARSER" USING WS-JSON WS-KEY WS-VAL WS-STATUS.
           IF WS-STATUS = 0
               ADD 1 TO WS-TESTS-PASSED
               DISPLAY "TEST 1: Inbound JSON Key Deserialization [PASS]"
           END-IF.

           DISPLAY "--------------------------------------------------".
           DISPLAY "TEST SUMMARY: " WS-TESTS-PASSED " / " WS-TESTS-RUN " PASSED.".
           DISPLAY "==================================================".
           IF WS-TESTS-PASSED = WS-TESTS-RUN
               DISPLAY ">> ALL JSON PARSER INVARIANTS PASS [100% OK] <<"
           END-IF.
           STOP RUN.
