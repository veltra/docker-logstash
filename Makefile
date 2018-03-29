.PHONY: test build

build:
	docker build -t veltra/logstash .

test: build
	docker run -p 9600:9600 -d --name logstash veltra/logstash; sleep 30
	docker run --network container:logstash appropriate/curl --retry 10 --retry-connrefused 'http://localhost:9600/_node/plugins?pretty'
