####################################################################################
# Makefile (configuration file for GNU make - see http://www.gnu.org/software/make/)
# Time-stamp: <Fri 2018-11-30 00:30 svarrette>
#     __  __       _         __ _ _
#    |  \/  | __ _| | _____ / _(_) | ___
#    | |\/| |/ _` | |/ / _ \ |_| | |/ _ \
#    | |  | | (_| |   <  __/  _| | |  __/
#    |_|  |_|\__,_|_|\_\___|_| |_|_|\___|
#
# Copyright (c) 2012 Sebastien Varrette <Sebastien.Varrette@uni.lu>
# .             http://varrette.gforge.uni.lu
#
####################################################################################
#
############################## Variables Declarations ##############################
SHELL = /bin/bash

UNAME = $(shell uname)

# Some directories
SUPER_DIR   = $(shell basename `pwd`)

# Git stuff management
HAS_GITFLOW      = $(shell git flow version 2>/dev/null || [ $$? -eq 0 ])
LAST_TAG_COMMIT = $(shell git rev-list --tags --max-count=1)
LAST_TAG = $(shell git describe --tags $(LAST_TAG_COMMIT) )
TAG_PREFIX = "v"
# GITFLOW_BR_MASTER  = $(shell git config --get gitflow.branch.master)
# GITFLOW_BR_DEVELOP = $(shell git config --get gitflow.branch.develop)
GITFLOW_BR_MASTER=production
GITFLOW_BR_DEVELOP=master

CURRENT_BRANCH          = $(shell git rev-parse --abbrev-ref HEAD)
GIT_BRANCHES            = $(shell git for-each-ref --format='%(refname:short)' refs/heads/ | xargs echo)
GIT_REMOTES             = $(shell git remote | xargs echo )
GIT_ROOTDIR             = $(shell git rev-parse --show-toplevel)
GIT_HOOKSDIR            = .git/hooks
SRC_HOOKSDIR            = config/hooks
#SRC_HOOKSDIR_TO_ROOTDIR = $(shell git -C "$(GIT_ROOTDIR)/$(SRC_HOOKSDIR)" rev-parse --show-cdup)
SRC_PRECOMMIT_HOOK      = $(wildcard $(SRC_HOOKSDIR)/pre-commit*.sh)

GIT_DIRTY    = $(shell git diff --shortstat 2> /dev/null | tail -n1 )
# Git subtrees repositories
# Format: '<url>[|<branch>]' - don't forget the quotes. if branch is ignored, 'master' is used
#GIT_SUBTREE_REPOS = 'https://github.com/ULHPC/easybuild-framework.git|develop'  \
					 'https://github.com/hpcugent/easybuild-wiki.git'
GITSTATS     = ./.submodules/gitstats/gitstats
GITSTATS_DIR = gitstats

# Branches to update on 'make up'
GIT_BRANCHES_TO_UPDATE = $(GITFLOW_BR_DEVELOP) $(GITFLOW_BR_MASTER)

ifeq (,$(wildcard .bumpversion.cfg))
VERSION  = $(shell [ -f VERSION ] && head VERSION || echo '0.0.1')
else
VERSION = $(shell bumpversion --dry-run --allow-dirty --list minor | grep current_version | cut -d '=' -f 2)
endif

# OR try to guess directly from the last git tag
#VERSION    = $(shell  git describe --tags $(LAST_TAG_COMMIT) | sed "s/^$(TAG_PREFIX)//")
MAJOR      = $(shell echo $(VERSION) | sed "s/^\([0-9]*\).*/\1/")
MINOR      = $(shell echo $(VERSION) | sed "s/[0-9]*\.\([0-9]*\).*/\1/")
PATCH      = $(shell echo $(VERSION) | sed "s/[0-9]*\.[0-9]*\.\([0-9]*\).*/\1/")
# total number of commits
BUILD      = $(shell git log --oneline | wc -l | sed -e "s/[ \t]*//g")
#REVISION   = $(shell git rev-list $(LAST_TAG).. --count)
ifeq (,$(wildcard .bumpversion.cfg))
NEXT_MAJOR_VERSION = $(shell expr $(MAJOR) + 1).0.0-b$(BUILD)
NEXT_MINOR_VERSION = $(MAJOR).$(shell expr $(MINOR) + 1).0-b$(BUILD)
NEXT_PATCH_VERSION = $(MAJOR).$(MINOR).$(shell expr $(PATCH) + 1)-b$(BUILD)
else
NEXT_MAJOR_VERSION = $(shell expr $(MAJOR) + 1).0.0
NEXT_MINOR_VERSION = $(MAJOR).$(shell expr $(MINOR) + 1).0
NEXT_PATCH_VERSION = $(MAJOR).$(MINOR).$(shell expr $(PATCH) + 1)
endif
# Default targets
TARGETS =

# Local configuration - Kept for compatibity reason
LOCAL_MAKEFILE = .Makefile.local

# Makefile custom hooks
MAKEFILE_BEFORE = .Makefile.before
MAKEFILE_AFTER  = .Makefile.after

### Main variables
.PHONY: all archive clean fetch help release setup setup_git_hooks start_bump_major start_bump_minor start_bump_patch subtree_setup subtree_up subtree_diff test upgrade versioninfo doc

############################### Now starting rules ################################
# Load local settings, if existing (to override variable eventually)
ifneq (,$(wildcard $(LOCAL_MAKEFILE)))
include $(LOCAL_MAKEFILE)
endif
ifneq (,$(wildcard $(MAKEFILE_BEFORE)))
include $(MAKEFILE_BEFORE)
endif

# Required rule : what's to be done each time
all: $(TARGETS)

# Test values of variables - for debug purposes
info:
	@echo "--- Compilation commands --- "
	@echo "HAS_GITFLOW      -> '$(HAS_GITFLOW)'"
	@echo "--- Directories --- "
	@echo "SUPER_DIR    -> '$(SUPER_DIR)'"
	@echo "--- Git stuff ---"
	@echo "GIT_ROOTDIR            -> '$(GIT_ROOTDIR)'"
	@echo "GITFLOW                -> '$(GITFLOW)'"
	@echo "GITFLOW_BR_MASTER      -> '$(GITFLOW_BR_MASTER)'"
	@echo "GITFLOW_BR_DEVELOP     -> '$(GITFLOW_BR_DEVELOP)'"
	@echo "CURRENT_BRANCH         -> '$(CURRENT_BRANCH)'"
	@echo "GIT_BRANCHES           -> '$(GIT_BRANCHES)'"
	@echo "GIT_REMOTES            -> '$(GIT_REMOTES)'"
	@echo "GIT_DIRTY              -> '$(GIT_DIRTY)'"
	@echo "GIT_SUBTREE_REPOS      -> '$(GIT_SUBTREE_REPOS)'"
	@echo "GIT_BRANCHES_TO_UPDATE -> '$(GIT_BRANCHES_TO_UPDATE)'"
	@echo "GIT_HOOKSDIR           -> '$(GIT_HOOKSDIR)'"
	@echo "SRC_HOOKSDIR           -> '$(SRC_HOOKSDIR)'"
	@echo "SRC_HOOKSDIR_TO_ROOTDIR-> '$(SRC_HOOKSDIR_TO_ROOTDIR)'"
	@echo "SRC_PRECOMMIT_HOOK     -> '$(SRC_PRECOMMIT_HOOK)'"
	@echo ""
	@echo "Consider running 'make versioninfo' to get info on git versionning variables"

############################### Archiving ################################
archive: clean
	tar -C ../ -cvzf ../$(SUPER_DIR)-$(VERSION).tar.gz --exclude ".svn" --exclude ".git"  --exclude "*~" --exclude ".DS_Store" $(SUPER_DIR)/

############################### Git Bootstrapping rules ################################
setup:
	-git fetch origin
	-git branch --track $(GITFLOW_BR_MASTER) origin/$(GITFLOW_BR_MASTER)
	git config gitflow.branch.master     $(GITFLOW_BR_MASTER)
	git config gitflow.branch.develop    $(GITFLOW_BR_DEVELOP)
	git config gitflow.prefix.feature    feature/
	git config gitflow.prefix.release    release/
	git config gitflow.prefix.hotfix     hotfix/
	git config gitflow.prefix.support    support/
	git config gitflow.prefix.versiontag $(TAG_PREFIX)
	-$(MAKE) update
	$(if $(GIT_SUBTREE_REPOS), $(MAKE) subtree_setup)
	@if [ -d "$(GIT_ROOTDIR)/$(SRC_HOOKSDIR)" ]; then \
		echo "=> setup local git hooks"; \
		$(MAKE) setup_git_hooks; \
	fi

setup_git_hooks:
	@if [ -n "$(SRC_PRECOMMIT_HOOK)" ]; then \
		if [ -f "$(GIT_ROOTDIR)/$(SRC_PRECOMMIT_HOOK)" ] && [ ! -f "$(GIT_ROOTDIR)/$(GIT_HOOKSDIR)/pre-commit" ]; then \
			echo "=> setup Git pre-commit hook"; \
			ln -s ../../$(SRC_PRECOMMIT_HOOK) $(GIT_ROOTDIR)/$(GIT_HOOKSDIR)/pre-commit; \
		fi ; \
	fi

fetch:
	git fetch --all -v

versioninfo:
	@echo "Current version: $(VERSION)"
	@echo "Last tag: $(LAST_TAG)"
	@echo "$(shell git rev-list $(LAST_TAG).. --count) commit(s) since last tag"
	@echo "Build: $(BUILD) (total number of commits)"
	@echo "next major version: $(NEXT_MAJOR_VERSION)"
	@echo "next minor version: $(NEXT_MINOR_VERSION)"
	@echo "next patch version: $(NEXT_PATCH_VERSION)"

### Git flow management - this should be factorized
ifeq ($(HAS_GITFLOW),)
start_bump_patch start_bump_minor start_bump_major release:
	@echo "Unable to find git-flow on your system. "
	@echo "See https://github.com/nvie/gitflow for installation details"
else

define __VERSION_BUMP
start_bump_$1:
	$$(if $$(GIT_DIRTY), $$(error "Unable to bump version: Dirty Git repository"))
	@echo "Start the '$1' release of the repository from $$(VERSION) to $2"
	git pull origin
	git flow release start $2
	@sleep 1
	@if [ -f VERSION ]; then \
		echo $2 > VERSION; \
		git commit -s -m "$1 bump to version $2" VERSION; \
	fi
	@if [ -f .bumpversion.cfg ]; then \
		echo "=> using 'bumpversion [...] $1'"; \
		bumpversion --commit --no-tag $1; \
	fi
	@echo "=> run 'make release' once you finished the bump"
endef

$(eval $(call __VERSION_BUMP,patch,$(NEXT_PATCH_VERSION)))
$(eval $(call __VERSION_BUMP,minor,$(NEXT_MINOR_VERSION)))
$(eval $(call __VERSION_BUMP,major,$(NEXT_MAJOR_VERSION)))

release: clean
	@if [ -f .bumpversion.cfg ]; then \
		echo "=> release using 'bumpversion [...] release'"; \
		bumpversion --commit --no-tag release; \
	fi
	git flow release finish -s $(VERSION:%rc=%)
	git checkout $(GITFLOW_BR_MASTER)
	git push origin
	git checkout $(GITFLOW_BR_DEVELOP)
	git push origin
	git push origin --tags
endif

### Git (submodule|branch)  management: pull and upgrade to the latest version
up update:
	$(if $(GIT_DIRTY), $(error "Unable to pull latest commits: Dirty Git repository"))
	@for br in $(GIT_BRANCHES_TO_UPDATE); do \
		echo -e "\n=> Pulling and updating the local branch '$$br'\n"; \
		git checkout $$br; \
		git pull origin $$br; \
	done
	git checkout $(CURRENT_BRANCH)
	@echo "=> updating (NOT upgrading) git submodule"
	git submodule init
	git submodule update

### Git submodule upgrade
upgrade: update
	git submodule foreach 'git fetch origin; git checkout $$(git rev-parse --abbrev-ref HEAD); git reset --hard origin/$$(git rev-parse --abbrev-ref HEAD); git submodule update --recursive; git clean -dfx'
	-@for submoddir in $(shell git submodule status | awk '{ print $$2 }' | xargs echo); do \
		git commit -s -m "Upgrading Git submodule '$$submoddir' to the latest version" $$submoddir || true;\
	done


### Git subtree management
ifeq ($(GIT_SUBTREE_REPOS),)
subtree_setup subtree_diff subtree_up:
	@echo "no repository configured in GIT_SUBTREE_REPOS..."
else
subtree_setup:
	@for elem in $(GIT_SUBTREE_REPOS); do \
		url=`echo $$elem | cut -d '|' -f 1`; \
		repo=`basename $$url .git`; \
		if [[ ! "$(GIT_REMOTES)" =~ "$$repo"  ]]; then \
			echo "=> initializing Git remote '$$repo'"; \
			git remote add -f $$repo $$url; \
		fi \
	done

subtree_diff:
	@for elem in $(GIT_SUBTREE_REPOS); do \
		url=`echo $$elem | cut -d '|' -f 1`; \
		repo=`basename $$url .git`; \
		path=`echo $$repo | tr '-' '/'`; \
		br=`echo $$elem | cut -d '|' -f 2`;  \
		[ "$$br" == "$$url" ] && br='master'; \
		echo -e "\n============ diff on subtree '$$path' with remote '$$repo/$$br' ===========\n"; \
		git diff $${repo}/$$br $(CURRENT_BRANCH):$$path; \
	done

subtree_up:
	$(if $(GIT_DIRTY), $(error "Unable to pull subtree(s): Dirty Git repository"))
	@for elem in $(GIT_SUBTREE_REPOS); do \
		url=`echo $$elem | cut -d '|' -f 1`; \
		repo=`basename $$url .git`; \
		path=`echo $$repo | tr '-' '/'`; \
		br=`echo $$elem | cut -d '|' -f 2`;  \
		[ "$$br" == "$$url" ] && br='master'; \
		echo -e "\n===> pulling changes into subtree '$$path' using remote '$$repo/$$br'"; \
		echo -e "     \__ fetching remote '$$repo'"; \
		git fetch $$repo; \
		echo -e "     \__ pulling changes"; \
		git subtree pull --prefix $$path --squash $${repo} $${br}; \
	done
endif


# Clean option
clean:
	@if [ -d "$(GITSTATS_DIR)" ]; then \
		echo "==> removing '$(GITSTATS_DIR)' directory"; \
		rm -rf $(GITSTATS_DIR); \
	fi
	@echo nothing to be cleaned for the moment


# Perform various git statistics
stats:
	@if [ ! -d $(GITSTATS_DIR) ]; then mkdir -p $(GITSTATS_DIR); fi
	$(GITSTATS) . $(GITSTATS_DIR)/

doc:
	@if [ -n "`which mkdocs`" ]; then \
		mkdocs serve; \
	fi

# # force recompilation
# force :
# 	@touch $(MAIN_TEX)
# 	@$(MAKE)


# print help message
help :
	@echo '+----------------------------------------------------------------------+'
	@echo '|                        Available Commands                            |'
	@echo '+----------------------------------------------------------------------+'
	@echo '| make setup:   Initiate git-flow for your local copy of the repository|'
	@echo '| make start_bump_{major,minor,patch}: start a new version release with|'
	@echo '|               git-flow at a given level (major, minor or patch bump) |'
	@echo '| make release: Finalize the release using git-flow                    |'
	@echo '+----------------------------------------------------------------------+'

ifneq (,$(wildcard $(MAKEFILE_AFTER)))
include $(MAKEFILE_AFTER)
endif
