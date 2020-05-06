ci: bootstrap
	./scripts/ci

prepare: bootstrap
	./scripts/prepare

bootstrap:
	./scripts/bootstrap

charts: bootstrap prepare
	./scripts/generate-charts

patch: bootstrap
	./scripts/generate-patch

validate: bootstrap
	./scripts/validate

mirror: bootstrap
	./scripts/image-mirror

.DEFAULT_GOAL := ci

