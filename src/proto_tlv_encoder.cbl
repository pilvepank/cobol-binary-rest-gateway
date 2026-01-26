*>================================================================
*> PROGRAM:  proto_tlv_encoder.cbl
*> PURPOSE:  Binary Protocol Type-Length-Value Frame Pack & Unpack
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. PROTO-TLV-ENCODER.

 DATA DIVISION.
 WORKING-STORAGE SECTION.

 LINKAGE SECTION.
 COPY "TLV-FRAME.cpy".
 01  LS-TAG                 PIC 9(04) COMP-5.
 01  LS-LEN                 PIC 9(04) COMP-5.
 01  LS-INPUT-BUF           PIC X(128).

 PROCEDURE DIVISION USING TLV-FRAME-HEADER, LS-TAG, LS-LEN, LS-INPUT-BUF.
 0000-MAIN.
     MOVE LS-TAG TO TLV-TAG-ID
     IF LS-LEN > 128
         MOVE 128 TO TLV-LENGTH
         MOVE 'TR' TO TLV-ENCODE-STATUS
         MOVE LS-INPUT-BUF(1:128) TO TLV-VALUE-PAYLOAD
     ELSE
         MOVE LS-LEN TO TLV-LENGTH
         MOVE '00' TO TLV-ENCODE-STATUS
         MOVE LS-INPUT-BUF(1:LS-LEN) TO TLV-VALUE-PAYLOAD
     END-IF
     GOBACK.
