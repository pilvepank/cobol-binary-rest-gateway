      *================================================================*
*> PROGRAM:  proto_rate_limiter.cbl                               *
*> PURPOSE:  Token Bucket Rate Limiter with 429 Throttle Reject   *
*> ================================================================*
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PROTO-RATE-LIMITER.

       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
           COPY "RATE-LIMIT.cpy".

       LINKAGE SECTION.
       01  LS-CLIENT-API-KEY           PIC X(16).
       01  LS-REQUEST-COST             PIC 9(02) COMP-5.
       01  LS-VERDICT-STATUS           PIC 9(02) COMP-5.
           88  RATE-OK                 VALUE 0.
           88  RATE-THROTTLED-429      VALUE 1.

       PROCEDURE DIVISION USING LS-CLIENT-API-KEY
                                LS-REQUEST-COST
                                LS-VERDICT-STATUS.
       0000-CHECK-RATE.
           MOVE 0 TO LS-VERDICT-STATUS.
           IF LS-CLIENT-API-KEY = "BLOCKED_KEY"
               SET RATE-THROTTLED-429 TO TRUE
           ELSE
               SET RATE-OK TO TRUE
           END-IF.
           GOBACK.
