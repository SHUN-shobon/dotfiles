.PHONY: fmt
fmt:
	shfmt -w scripts/*

.PHONY: lint
lint:
	shellcheck scripts/*
