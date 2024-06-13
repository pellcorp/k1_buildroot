# Disable ccache compiler_check, since it messes with with ccache if the SDK was rebuild
# ~/.buildroot-ccache must be manually deleted if any toolchain settings change
export CCACHE_COMPILERCHECK=none

include $(sort $(wildcard $(BR2_EXTERNAL_PELLCORP_PATH)/package/*/*.mk))
