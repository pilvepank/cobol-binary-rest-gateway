*>================================================================
*> COPYBOOK: JWT-TOKEN.cpy
*> PURPOSE:  JSON Web Token (JWT) Claim Descriptors
*> ================================================================
 01  JWT-CLAIM-CONTEXT.
     05  JWT-ISSUER              PIC X(16).
     05  JWT-SUBJECT             PIC X(16).
     05  JWT-ROLE                PIC X(08).
     05  JWT-EXPIRY-TS           PIC 9(12) COMP-5.
     05  JWT-STATUS              PIC X(02).
         88  JWT-VALID           VALUE '00'.
         88  JWT-EXPIRED         VALUE 'EX'.
         88  JWT-BAD-SIG         VALUE 'BS'.
