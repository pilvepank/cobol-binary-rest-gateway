*>===============================================================*
*> COPYBOOK: JSON-PARSER.cpy                                *>
*> PURPOSE:  Inbound JSON Tokenizer & Key-Value Parsing Context   *
*> ================================================================*
       01  JSON-PARSE-CONTEXT.
           05  JSON-RAW-BUFFER         PIC X(512).
           05  JSON-BUFFER-LEN         PIC 9(04) COMP-5.
           05  JSON-CURRENT-POS        PIC 9(04) COMP-5.
           05  JSON-CURRENT-TOKEN      PIC X(32).
           05  JSON-EXTRACTED-VAL      PIC X(64).
           05  JSON-PARSE-STATUS             PIC 9(02) COMP-5.
               88  JSON-SUCCESS        VALUE 0.
               88  JSON-SYNTAX-ERR     VALUE 1.
               88  JSON-KEY-NOT-FOUND  VALUE 2.
