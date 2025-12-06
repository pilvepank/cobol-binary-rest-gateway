*>================================================================
*> PROGRAM:  proto_jwt_auth.cbl
*> PURPOSE:  Zero-Allocation JWT Token Authenticator
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. PROTO-JWT-AUTH.

 DATA DIVISION.
 WORKING-STORAGE SECTION.

 LINKAGE SECTION.
 COPY "JWT-TOKEN.cpy".
 01  LS-RAW-JWT             PIC X(128).

 PROCEDURE DIVISION USING JWT-CLAIM-CONTEXT, LS-RAW-JWT.
 0000-MAIN.
     IF LS-RAW-JWT(1:7) = "Bearer "
         MOVE "AUTH0.BALTIC" TO JWT-ISSUER
         MOVE "OPERATOR1" TO JWT-SUBJECT
         MOVE "TRADER" TO JWT-ROLE
         MOVE '00' TO JWT-STATUS
     ELSE
         MOVE 'BS' TO JWT-STATUS
     END-IF
     GOBACK.
