*>================================================================
*> COPYBOOK: CIRCUIT-STATE.cpy
*> PURPOSE:  API Gateway Upstream Circuit Breaker State Machine
*> ================================================================
 01  CIRCUIT-BREAKER-RECORD.
     05  CB-CURRENT-STATE        PIC X(01) VALUE 'C'.
         88  CB-IS-CLOSED        VALUE 'C'.
         88  CB-IS-OPEN          VALUE 'O'.
         88  CB-IS-HALF-OPEN     VALUE 'H'.
     05  CB-CONSECUTIVE-FAILURES PIC 9(04) COMP-5 VALUE 0.
     05  CB-FAILURE-THRESHOLD    PIC 9(04) COMP-5 VALUE 5.
     05  CB-CONSECUTIVE-SUCCESS  PIC 9(04) COMP-5 VALUE 0.
     05  CB-RECOVERY-THRESHOLD   PIC 9(04) COMP-5 VALUE 3.
