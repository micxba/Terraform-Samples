cd /go/src/Module/test
dep init
dep ensure
go test -v -timeout 60m 2>&1 | tee /output/go_test_results.log
cat /output/go_test_results.log | go-junit-report > /output/junit_test_results.xml