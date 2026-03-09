@echo off
call build.bat
proto_engine.exe
proto_test.exe
proto_json_test.exe
proto_jwt_test.exe
proto_metrics_test.exe
proto_cors_test.exe
proto_tlv_test.exe
proto_circuit_test.exe
proto_http_test.exe
proto_router_test.exe
