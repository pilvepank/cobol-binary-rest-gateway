*>================================================================
*> COPYBOOK: TLV-FRAME.cpy
*> PURPOSE:  Type-Length-Value (TLV) Binary Protocol Frame Layout
*> ================================================================
 01  TLV-FRAME-HEADER.
     05  TLV-TAG-ID              PIC 9(04) COMP-5 VALUE 0.
     05  TLV-LENGTH              PIC 9(04) COMP-5 VALUE 0.
     05  TLV-VALUE-PAYLOAD       PIC X(128) VALUE SPACES.
     05  TLV-ENCODE-STATUS       PIC X(02) VALUE '00'.
         88  TLV-STATUS-OK       VALUE '00'.
         88  TLV-PAYLOAD-TRUNC   VALUE 'TR'.
