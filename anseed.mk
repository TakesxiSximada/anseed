# Need include environment settings. ex) include environ/$(environ).mk

######## MUST SETTINGS ########
# STACK ?= CFSeed
# S3_BUCKET_NAME ?= CFSeed
# S3_BUCKET_PATH ?= $(environ)
# REGION ?= us-east-1
###############################

ANSIBLE_VENV ?= $(CURDIR)/.venv
ANSIBLE_PLAYBOOK ?= $(ANSIBLE_VENV)/bin/ansible-playbook
ANSIBLE_VAULT ?= $(ANSIBLE_VENV)/bin/ansible-vault

VAULT_PASSWORD_FILE ?= ~/.ansible/vault_password
GALAXY := $(ANSIBLE_VENV)/bin/ansible-galaxy
GALAXY_REQUIREMENTS := galaxy.txt

.DEFAULT_GOAL := help


.PHONY: env
env:
	@# Create venv.

	virtualenv $(ANSIBLE_VENV) -p python2.7
	if [ -e $(ANSEED)/requirements.txt ]; then \
			$(ANSIBLE_VENV)/bin/pip install -r $(ANSEED)/requirements.txt; \
	fi
	if [ -e $(CURDIR)/requirements.txt ]; then \
			$(ANSIBLE_VENV)/bin/pip install -r $(CURDIR)/requirements.txt; \
	fi


.PHONY:
play:
	@## book=PLAYBOOK
	@#
	@# Execute playbook

	$(ANSIBLE_PLAYBOOK) -i environ/$(environ)/inventry $(book) --extra-vars=environ=$(environ) \
		--vault-password-file $(VAULT_PASSWORD_FILE)

.PHONY:
vault-show:
	@## fiel=FILE
	@#
	@# View encrypted file


	$(ANSIBLE_VAULT) view $(file) --vault-password-file $(VAULT_PASSWORD_FILE)

.PHONY:
vault-edit:
	@## file=FILE
	@#
	@# Edit encrypted file

	$(ANSIBLE_VAULT) edit $(file) --vault-password-file $(VAULT_PASSWORD_FILE)

.PHONY:
vault-encrypt:
	@## file=FILE
	@#
	@# Execute encrypt

	$(ANSIBLE_VAULT) encrypt $(file) --vault-password-file $(VAULT_PASSWORD_FILE)

.PHONY:
vault-rekey:
	@## file=FILE
	@#
	@# Rekey encrypted file

	$(ANSIBLE_VAULT) rekey $(file)


.PHONY: galaxy
galaxy:
	@# Install Galaxy packages
	for line in `cat $(GALAXY_REQUIREMENTS)`; \
		do \
			$(GALAXY) install $$line; \
		done


.PHONY: help
help:
	@# Display usage.

	@unmake $(MAKEFILE_LIST)
