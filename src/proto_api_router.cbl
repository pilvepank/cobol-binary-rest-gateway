*>================================================================
*> PROGRAM:  proto_api_router.cbl
*> PURPOSE:  Prefix Path Trie Dispatcher & Microservice Resolver
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. PROTO-API-ROUTER.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 01  WS-I                   PIC 9(04) COMP-5.

 LINKAGE SECTION.
 COPY "ROUTER-TABLE.cpy".
 01  LS-IN-URL              PIC X(32).
 01  LS-BACKEND             PIC X(16).
 01  LS-STATUS              PIC X(02).
     88  RT-MATCHED         VALUE '00'.
     88  RT-NOT-FOUND       VALUE '44'.

 PROCEDURE DIVISION USING GATEWAY-ROUTER-TABLE, LS-IN-URL, LS-BACKEND, LS-STATUS.
 0000-MAIN.
     MOVE '44' TO LS-STATUS
     MOVE SPACES TO LS-BACKEND
     PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > RT-ROUTE-COUNT
         IF RT-URL-PATTERN(WS-I) = LS-IN-URL
             MOVE RT-TARGET-BACKEND(WS-I) TO LS-BACKEND
             MOVE '00' TO LS-STATUS
         END-IF
     END-PERFORM
     GOBACK.
