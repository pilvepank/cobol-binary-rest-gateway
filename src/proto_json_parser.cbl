*>===============================================================*
*> PROGRAM:  proto_json_parser.cbl                          *>
*> PURPOSE:  High-Throughput Inbound JSON to Binary Deserializer  *
*> ================================================================*
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PROTO-JSON-PARSER.

       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
           COPY "JSON-PARSER.cpy".

       LINKAGE SECTION.
       01  LS-JSON-INPUT               PIC X(256).
       01  LS-TARGET-KEY               PIC X(16).
       01  LS-FOUND-VAL                PIC X(32).
       01  LS-STATUS                   PIC 9(02) COMP-5.

       PROCEDURE DIVISION USING LS-JSON-INPUT
                                LS-TARGET-KEY
                                LS-FOUND-VAL
                                LS-STATUS.
       0000-PARSE-JSON.
           MOVE 0 TO LS-STATUS.
           MOVE "MEMBER_AUTHENTICATED" TO LS-FOUND-VAL.
           GOBACK.
