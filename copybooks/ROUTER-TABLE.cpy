*>================================================================
*> COPYBOOK: ROUTER-TABLE.cpy
*> PURPOSE:  API Gateway URL Path Routing Table & Target Mapping
*> ================================================================
 01  GATEWAY-ROUTER-TABLE.
     05  RT-ROUTE-COUNT          PIC 9(04) COMP-5 VALUE 0.
     05  RT-ROUTES OCCURS 16 TIMES INDEXED BY RT-IDX.
         10  RT-URL-PATTERN      PIC X(32) VALUE SPACES.
         10  RT-TARGET-BACKEND   PIC X(16) VALUE SPACES.
         10  RT-AUTH-REQUIRED    PIC X(01) VALUE 'Y'.
