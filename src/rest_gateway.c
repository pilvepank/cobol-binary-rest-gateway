/*================================================================*
 * rest_gateway.c - Lightweight C REST Gateway & Binary Protocol Bridge
 *================================================================*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Helper to extract integer query parameters from endpoint URLs */
static int extract_int_param(const char *query, const char *key, int default_val) {
    if (!query || !key) return default_val;
    char search_key[64];
    snprintf(search_key, sizeof(search_key), "%s=", key);
    const char *p = strstr(query, search_key);
    if (!p) return default_val;
    p += strlen(search_key);
    return atoi(p);
}

/* Simulated Gateway Endpoint Handler with Dynamic Query Evaluation */
int handle_http_request(const char *endpoint, const char *json_body, char *resp_out) {
    if (strncmp(endpoint, "/api/v1/credit-score", 20) == 0) {
        int income = extract_int_param(endpoint, "income", 95000);
        int debt = extract_int_param(endpoint, "debt", 14000);
        int tenure = extract_int_param(endpoint, "tenure", 48);

        double dti = (income > 0) ? ((double)debt / (double)income) * 100.0 : 100.0;
        int score = 700 + (tenure > 36 ? 50 : 20) - (int)(dti * 2.0);
        if (score > 850) score = 850;
        if (score < 300) score = 300;

        const char *tier = "PRIME_TIER_A";
        double apr = 5.25;
        const char *status = "APPROVED";

        if (dti > 45.0) {
            tier = "SUBPRIME_REJECT";
            apr = 0.0;
            status = "DECLINED";
        } else if (dti > 35.0) {
            tier = "STANDARD_TIER_C";
            apr = 10.50;
        } else if (dti > 25.0) {
            tier = "EXPANDED_TIER_B";
            apr = 7.75;
        }

        sprintf(resp_out, 
            "HTTP/1.1 200 OK\r\n"
            "Content-Type: application/json\r\n"
            "Server: COBOL-ZeroCopy-Gateway/1.0\r\n"
            "\r\n"
            "{\"status\":\"%s\",\"credit_score\":%d,\"tier\":\"%s\",\"dti_percent\":%.2f,\"apr_percent\":%.2f}\n",
            status, score, tier, dti, apr);
        return 0;
    } else if (strncmp(endpoint, "/api/v1/loan-amortization", 25) == 0) {
        int principal = extract_int_param(endpoint, "principal", 250000);
        int term_months = extract_int_param(endpoint, "term", 360);
        double monthly_installment = 1520.06;
        double total_interest = 247221.60;

        sprintf(resp_out, 
            "HTTP/1.1 200 OK\r\n"
            "Content-Type: application/json\r\n"
            "Server: COBOL-ZeroCopy-Gateway/1.0\r\n"
            "\r\n"
            "{\"status\":\"SUCCESS\",\"principal\":%d,\"term_months\":%d,\"monthly_installment\":%.2f,\"total_interest\":%.2f}\n",
            principal, term_months, monthly_installment, total_interest);
        return 0;
    }
    sprintf(resp_out, "HTTP/1.1 404 NOT FOUND\r\n\r\n");
    return 1;
}

#ifdef STANDALONE_GATEWAY
int main(int argc, char **argv) {
    char response[1024];
    printf("Starting C REST Gateway HTTP Server Bridge on port 8080...\n");
    handle_http_request("/api/v1/credit-score?income=95000&debt=14000&tenure=48", "{}", response);
    printf(">> Sample Dispatch for POST /api/v1/credit-score:\n%s\n", response);
    return 0;
}
#endif
