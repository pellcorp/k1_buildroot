SHELL := /bin/bash
BUILD := build_scripts/build.sh
VARIANTS = simple qemu

all: packages
packages: sdk simple qemu

# SDK targets
sdk: sdk_build

sdk_prepare:
	$(BUILD) prepare_sdk

sdk_build: sdk_prepare
	$(BUILD) build_sdk

sdk_rebuild: sdk_prepare
	$(BUILD) rebuild_sdk

sdk_clean:
	$(BUILD) clean_sdk

# Variant targets
define VARIANT_RULES

$(1): $(1)_build

$(1)_prepare:
	$(BUILD) prepare_variant $(1)

$(1)_build: $(1)_prepare
	$(BUILD) build_variant $(1)

$(1)_rebuild: $(1)_prepare
	$(BUILD) rebuild_variant $(1)

$(1)_clean:
	$(BUILD) clean_variant $(1)

endef

$(foreach variant,$(VARIANTS),$(eval $(call VARIANT_RULES,$(variant))))
