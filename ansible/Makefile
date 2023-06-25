
venv: requirements.txt
	python3 -m venv venv  && \
	. ./venv/bin/activate && \
	pip3 --quiet install --upgrade pip && \
	pip3 --quiet install -r requirements.txt

.PHONY: check
check:
	ansible-lint *.yaml

.PHONY: clean
clean:
	rm -rf venv target src/*.pyc
