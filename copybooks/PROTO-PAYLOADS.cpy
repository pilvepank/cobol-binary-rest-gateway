*>================================================================*
*> PROTO-PAYLOADS.cpy - Zero-Copy Financial Payload Union Schemas
*>================================================================*
 01  WIRE-PAYLOAD-BUFFER.
     05  PAYLOAD-RAW             PIC X(512).

     *> Credit Scoring Request (Zero-Copy Overlay)
     05  CREDIT-REQUEST REDEFINES PAYLOAD-RAW.
         10  CR-ANNUAL-INCOME    PIC 9(9)V99 COMP-3.
         10  CR-EXISTING-DEBT    PIC 9(9)V99 COMP-3.
         10  CR-MISSED-PAYMENTS  PIC 9(4)    COMP-5.
         10  CR-EMPLOYMENT-MOS   PIC 9(4)    COMP-5.
         10  CR-REQUESTED-LIMIT  PIC 9(9)V99 COMP-3.

     *> Credit Scoring Response (Zero-Copy Overlay)
     05  CREDIT-RESPONSE REDEFINES PAYLOAD-RAW.
         10  CR-SCORE            PIC 9(4)    COMP-5.
         10  CR-DECISION         PIC X.
             88  CR-APPROVED     VALUE "A".
             88  CR-DECLINED     VALUE "D".
             88  CR-REVIEW       VALUE "R".
         10  CR-APPROVED-LIMIT   PIC 9(9)V99 COMP-3.
         10  CR-APR-BPS          PIC 9(4)    COMP-5.
         10  CR-TIER-NAME        PIC X(16).

     *> Loan Amortization Request
     05  LOAN-REQUEST REDEFINES PAYLOAD-RAW.
         10  LN-PRINCIPAL        PIC 9(9)V99 COMP-3.
         10  LN-RATE-BPS         PIC 9(4)    COMP-5.
         10  LN-TERM-MONTHS      PIC 9(4)    COMP-5.

     *> Loan Amortization Response
     05  LOAN-RESPONSE REDEFINES PAYLOAD-RAW.
         10  LN-MONTHLY-PAYMENT  PIC 9(9)V99 COMP-3.
         10  LN-TOTAL-INTEREST   PIC 9(9)V99 COMP-3.
         10  LN-TOTAL-PAYMENT    PIC 9(9)V99 COMP-3.
         10  LN-AFFORDABILITY    PIC 9(4)    COMP-5.
