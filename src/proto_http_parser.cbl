*>================================================================
*> PROGRAM:  proto_http_parser.cbl
*> PURPOSE:  Inbound HTTP/1.1 Request Header Extraction & Validation
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. PROTO-HTTP-PARSER.

 DATA DIVISION.
 WORKING-STORAGE SECTION.

 LINKAGE SECTION.
 COPY "HTTP-REQ.cpy".
 01  LS-METHOD-IN           PIC X(08).
 01  LS-PATH-IN             PIC X(64).

 PROCEDURE DIVISION USING HTTP-REQUEST-BLOCK, LS-METHOD-IN, LS-PATH-IN.
 0000-MAIN.
     IF LS-METHOD-IN = "GET     " OR LS-METHOD-IN = "POST    " OR LS-METHOD-IN = "DELETE  "
         MOVE LS-METHOD-IN TO HTTP-METHOD
         MOVE LS-PATH-IN TO HTTP-PATH
         MOVE '00' TO HTTP-PARSER-STATUS
     ELSE
         MOVE 'BM' TO HTTP-PARSER-STATUS
     END-IF
     GOBACK.
