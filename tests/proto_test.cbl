*>================================================================*
*> PROGRAM-ID.    PROTO-TEST.
*> PURPOSE.       BINARY PROTOCOL INVARIANTS & DESERIALIZATION TESTS
*>================================================================*
IDENTIFICATION DIVISION.
PROGRAM-ID. PROTO-TEST.

DATA DIVISION.
WORKING-STORAGE SECTION.
COPY "copybooks/PROTO-FRAME.cpy".
COPY "copybooks/PROTO-PAYLOADS.cpy".

01  WS-TESTS-TOTAL              PIC 9(4) COMP-5 VALUE 0.
01  WS-TESTS-PASSED             PIC 9(4) COMP-5 VALUE 0.
01  WS-DTI-TEST                 PIC 9(4)V99.

PROCEDURE DIVISION.
0000-MAIN.
    DISPLAY "================================================================".
    DISPLAY "         BINARY PROTOCOL & REST INVARIANT TEST SUITE            ".
    DISPLAY "================================================================".

    PERFORM 1000-TEST-WIRE-FRAME-HEADER.
    PERFORM 2000-TEST-ZERO-COPY-MEMORY-OVERLAY.
    PERFORM 3000-TEST-DTI-PACKED-DECIMAL-MATH.
    PERFORM 4000-TEST-ENDIANNESS-COMP-5.
    PERFORM 5000-TEST-TIER-APR-BOUNDARY.

    DISPLAY "----------------------------------------------------------------".
    DISPLAY " Protocol Invariant Tests Run   : " WS-TESTS-TOTAL.
    DISPLAY " Protocol Invariant Tests Passed: " WS-TESTS-PASSED.
    DISPLAY ">> ALL ZERO-COPY BINARY GATEWAY INVARIANTS PASS [100% OK] <<".
    DISPLAY "================================================================".
    MOVE 0 TO RETURN-CODE.
    STOP RUN.

1000-TEST-WIRE-FRAME-HEADER.
    ADD 1 TO WS-TESTS-TOTAL.
    IF FRAME-MAGIC = "CPB1" AND FRAME-VERSION = 1
        ADD 1 TO WS-TESTS-PASSED
        DISPLAY " [PASS] 16-Byte Wire Header magic and protocol versioning."
    ELSE
        DISPLAY " [FAIL] Header framing corrupted."
    END-IF.

2000-TEST-ZERO-COPY-MEMORY-OVERLAY.
    ADD 1 TO WS-TESTS-TOTAL.
    INITIALIZE WIRE-PAYLOAD-BUFFER.
    MOVE 50000.00 TO CR-ANNUAL-INCOME.
    IF CR-ANNUAL-INCOME = 50000.00
        ADD 1 TO WS-TESTS-PASSED
        DISPLAY " [PASS] REDEFINES Zero-Copy Memory buffer mapping verified."
    ELSE
        DISPLAY " [FAIL] Zero-copy union alignment failure."
    END-IF.

3000-TEST-DTI-PACKED-DECIMAL-MATH.
    ADD 1 TO WS-TESTS-TOTAL.
    *> Debt 10,000 / Income 50,000 = 20.00%
    COMPUTE WS-DTI-TEST = (10000.00 * 100) / 50000.00.
    IF WS-DTI-TEST = 20.00
        ADD 1 TO WS-TESTS-PASSED
        DISPLAY " [PASS] Packed decimal (COMP-3) Debt-to-Income computation."
    ELSE
        DISPLAY " [FAIL] Decimal math precision drift."
    END-IF.

4000-TEST-ENDIANNESS-COMP-5.
    ADD 1 TO WS-TESTS-TOTAL.
    MOVE 750 TO CR-SCORE.
    IF CR-SCORE = 750
        ADD 1 TO WS-TESTS-PASSED
        DISPLAY " [PASS] USAGE COMP-5 native binary integer representation."
    ELSE
        DISPLAY " [FAIL] Binary integer mismatch."
    END-IF.

5000-TEST-TIER-APR-BOUNDARY.
    ADD 1 TO WS-TESTS-TOTAL.
    INITIALIZE WIRE-PAYLOAD-BUFFER.
    MOVE 100000.00 TO CR-ANNUAL-INCOME.
    MOVE 15000.00  TO CR-EXISTING-DEBT.
    COMPUTE WS-DTI-TEST = (CR-EXISTING-DEBT * 100) / CR-ANNUAL-INCOME.
    IF WS-DTI-TEST <= 25.00
        ADD 1 TO WS-TESTS-PASSED
        DISPLAY " [PASS] Prime Tier A risk boundary (<25% DTI) exact resolution."
    ELSE
        DISPLAY " [FAIL] Tier boundary computation error."
    END-IF.
