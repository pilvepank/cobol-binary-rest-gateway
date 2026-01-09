*>================================================================
*> COPYBOOK: CORS-CONFIG.cpy
*> PURPOSE:  HTTP Cross-Origin Resource Sharing (CORS) Whitelist
*> ================================================================
 01  CORS-SECURITY-POLICY.
     05  CORS-ALLOWED-ORIGIN     PIC X(64) VALUE "https://portal.balticcore.ee".
     05  CORS-ALLOWED-METHODS    PIC X(32) VALUE "GET, POST, OPTIONS".
     05  CORS-MAX-AGE-SECONDS    PIC 9(06) COMP-5 VALUE 86400.
     05  CORS-VALIDATION-STATUS  PIC X(02) VALUE '00'.
         88  CORS-ALLOW          VALUE '00'.
         88  CORS-REJECT         VALUE '99'.
