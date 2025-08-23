      *================================================================*
*> COPYBOOK: RATE-LIMIT.cpy                                       *
*> PURPOSE:  Token Bucket API Rate Limiter & Quota Context        *
*> ================================================================*
       01  RATE-LIMIT-BUCKET.
           05  RL-CLIENT-KEY           PIC X(16).
           05  RL-BUCKET-CAPACITY      PIC 9(04) COMP-5 VALUE 100.
           05  RL-CURRENT-TOKENS       PIC 9(04) COMP-5 VALUE 100.
           05  RL-REFILL-RATE-PER-SEC  PIC 9(04) COMP-5 VALUE 10.
           05  RL-LAST-REFILL-TIME     PIC 9(16) COMP-5 VALUE 0.
