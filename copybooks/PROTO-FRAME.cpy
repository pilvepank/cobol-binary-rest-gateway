*>================================================================*
*> PROTO-FRAME.cpy - Zero-Copy Binary Protocol Wire Frame Header
*>================================================================*
 78  WIRE-MAGIC-CONST            VALUE "CPB1".
 78  WIRE-VERSION-CONST          VALUE 1.
 78  MSG-TYPE-CREDIT             VALUE 1.
 78  MSG-TYPE-LOAN               VALUE 2.
 78  STATUS-OK                   VALUE 0.
 78  STATUS-VAL-ERR              VALUE 1.
 78  STATUS-SRV-ERR              VALUE 2.

*> 16-Byte Wire Header
 01  WIRE-FRAME-HEADER.
     05  FRAME-MAGIC             PIC X(4)   VALUE "CPB1".
     05  FRAME-VERSION           PIC 9(4)   COMP-5 VALUE 1.
     05  FRAME-MSG-TYPE          PIC 9(4)   COMP-5 VALUE 1.
     05  FRAME-PAYLOAD-LEN       PIC 9(9)   COMP-5 VALUE 0.
     05  FRAME-STATUS            PIC 9(4)   COMP-5 VALUE 0.
