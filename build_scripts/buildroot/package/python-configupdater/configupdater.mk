################################################################################
#
# python-configupdater
#
################################################################################
PYTHON_CONFIGUPDATER_VERSION = 3.2
PYTHON_CONFIGUPDATER_SOURCE = ConfigUpdater-$(PYTHON_CONFIGUPDATER_VERSION).tar.gz
PYTHON_CONFIGUPDATER_SITE = https://files.pythonhosted.org/packages/2b/f4/603bd8a65e040b23d25b5843836297b0f4e430f509d8ed2ef8f072fb4127
PYTHON_CONFIGUPDATER_SETUP_TYPE = setuptools
PYTHON_CONFIGUPDATER_LICENSE = MIT
PYTHON_CONFIGUPDATER_LICENSE_FILES = LICENSE

$(eval $(python-package))
