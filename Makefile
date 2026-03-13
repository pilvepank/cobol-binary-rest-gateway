all:
	cobc -free -x -Wall -Icopybooks src/proto_engine.cbl -o proto_engine
	cobc -free -x -Wall -Icopybooks tests/proto_test.cbl -o proto_test
test:
	./proto_test
clean:
	rm -f proto_engine proto_test *.exe *.o
