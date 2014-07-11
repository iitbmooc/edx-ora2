all: install test

install-system:
	sudo apt-get update -y
	sudo xargs -a apt-packages.txt apt-get install -y --fix-missing

install-node:
	sudo add-apt-repository -y ppa:chris-lea/node.js
	sudo apt-get update -y
	sudo apt-get install -y nodejs


install-python:
	./scripts/install-wheels.sh
	./scripts/install-python.sh


install-js:
	npm config set loglevel warn
	npm install


install-nltk-data:
	./scripts/download-nltk-data.sh


STATIC_JS = openassessment/xblock/static/js

minimize-js:
	node_modules/.bin/uglifyjs $(STATIC_JS)/src/oa_shared.js $(STATIC_JS)/src/*.js > "$(STATIC_JS)/openassessment.min.js"


install-test:
	pip install -r requirements/test.txt


install: install-system install-node install-python install-js install-nltk-data install-test minimize-js

test:
	./scripts/test.sh
