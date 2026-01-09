*>================================================================
*> PROGRAM:  proto_cors_validator.cbl
*> PURPOSE:  HTTP Origin Whitelist and Preflight OPTIONS Evaluator
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. PROTO-CORS-VALIDATOR.

 DATA DIVISION.
 WORKING-STORAGE SECTION.

 LINKAGE SECTION.
 COPY "CORS-CONFIG.cpy".
 01  LS-INBOUND-ORIGIN      PIC X(64).

 PROCEDURE DIVISION USING CORS-SECURITY-POLICY, LS-INBOUND-ORIGIN.
 0000-MAIN.
     IF LS-INBOUND-ORIGIN = CORS-ALLOWED-ORIGIN
         MOVE '00' TO CORS-VALIDATION-STATUS
     ELSE
         MOVE '99' TO CORS-VALIDATION-STATUS
     END-IF
     GOBACK.
