*>================================================================
*> COPYBOOK: HTTP-REQ.cpy
*> PURPOSE:  HTTP/1.1 Wire Request Line and Header Descriptor
*> ================================================================
 01  HTTP-REQUEST-BLOCK.
     05  HTTP-METHOD             PIC X(08) VALUE "GET     ".
     05  HTTP-PATH               PIC X(64) VALUE "/api/v1/health                  ".
     05  HTTP-CONTENT-TYPE       PIC X(32) VALUE "application/json                ".
     05  HTTP-CONTENT-LENGTH     PIC 9(08) COMP-5 VALUE 0.
     05  HTTP-PARSER-STATUS      PIC X(02) VALUE '00'.
         88  HTTP-OK             VALUE '00'.
         88  HTTP-BAD-METHOD     VALUE 'BM'.
