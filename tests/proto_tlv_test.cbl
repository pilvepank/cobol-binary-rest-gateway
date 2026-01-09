*>================================================================
*> PROGRAM:  proto_tlv_test.cbl
*> PURPOSE:  Unit Test Suite for Binary Protocol TLV Framer
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. PROTO-TLV-TEST.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "TLV-FRAME.cpy".
 01  WS-TAG                 PIC 9(04) COMP-5 VALUE 1001.
 01  WS-LEN                 PIC 9(04) COMP-5 VALUE 16.
 01  WS-BUF                 PIC X(128) VALUE "BALTIC-CORE-GATE".
 01  WS-TESTS-RUN           PIC 9(04) VALUE 0.
 01  WS-TESTS-PASSED        PIC 9(04) VALUE 0.

 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "=================================================="
     DISPLAY "  BINARY PROTOCOL TLV FRAMER TEST SUITE           "
     DISPLAY "=================================================="
     
     ADD 1 TO WS-TESTS-RUN
     MOVE 1001 TO WS-TAG
     MOVE 16 TO WS-LEN
     MOVE "BALTIC-CORE-GATE" TO WS-BUF
     CALL "PROTO-TLV-ENCODER" USING TLV-FRAME-HEADER, WS-TAG, WS-LEN, WS-BUF
     IF TLV-STATUS-OK AND TLV-TAG-ID = 1001 AND TLV-LENGTH = 16
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 1: Valid TLV Frame Pack [PASS]"
     ELSE
         DISPLAY "TEST 1: Valid TLV Frame Pack [FAIL]"
     END-IF
     
     ADD 1 TO WS-TESTS-RUN
     MOVE 200 TO WS-LEN
     CALL "PROTO-TLV-ENCODER" USING TLV-FRAME-HEADER, WS-TAG, WS-LEN, WS-BUF
     IF TLV-PAYLOAD-TRUNC AND TLV-LENGTH = 128
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 2: Oversized Payload Truncated Safe [PASS]"
     ELSE
         DISPLAY "TEST 2: Oversized Payload Truncated Safe [FAIL]"
     END-IF

     DISPLAY "--------------------------------------------------"
     DISPLAY "TLV Tests Run:    " WS-TESTS-RUN
     DISPLAY "TLV Tests Passed: " WS-TESTS-PASSED
     IF WS-TESTS-RUN = WS-TESTS-PASSED
         DISPLAY ">> ALL TLV ENCODER TESTS PASSED [100% OK] <<"
     ELSE
         DISPLAY ">> SOME TLV ENCODER TESTS FAILED <<"
     END-IF
     STOP RUN.
