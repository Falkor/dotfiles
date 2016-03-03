#! /usr/bin/env bats
################################################################################
# 01-install_script.bats
# Time-stamp: <Thu 2016-03-03 15:37 svarrette>
#
# Bats: Bash Automated Testing System -- https://github.com/sstephenson/bats
# Installation:
#  == OS X ==
#
#      $> brew install bats
#
#   before_install:
#      - if [ "$(uname -s)" == "Darwin"  ]; then brew install bats; fi
#
#
#  == Debian-like ==
#
#      $> sudo apt-get install software-properties-common
#      $> sudo apt-get install python-software-properties
#      $> sudo add-apt-repository ppa:duggan/bats --yes
#      $> sudo apt-get update -qq
#      $> sudo apt-get install -qq bats
#
#   before_install:
#      - sudo add-apt-repository ppa:duggan/bats --yes
#      - sudo apt-get update -qq
#      - sudo apt-get install -qq bats
#
#
#  == Manual ==
#
#    before_script:
#      - git clone https://github.com/sstephenson/bats.git /tmp/bats
#      - mkdir -p /tmp/local
#      - bash /tmp/bats/install.sh /tmp/local
#      - export PATH=$PATH:/tmp/local/bin
#
# Resources:
# - How to use Bats to test your command line tools:
#            https://blog.engineyard.com/2014/bats-test-command-line-tools
# - Ex of travis-CI integration:
#            https://github.com/duggan/pontoon/blob/master/.travis.yml
# - Another project using bats:
#            https://github.com/ekalinin/envirius/tree/master/tests
################################################################################

load test_helper


DOTFILE_INSTALL="$BATS_TEST_DIRNAME/../install.sh --force --offline"
#DOTFILES_D=$HOME/.dotfiles.falkor.d
#export GIT_SSH='ssh -o StrictHostKeyChecking=no'


setup() {
    # Avoid to run the tests on your machine
    case "$(hostname -f)" in
        *travis*)  echo "=> Tests on travis resources";;
        *vagrant*) echo "=> Tests on vagrant resources";;
        *) echo "tests on $(hostname -f) skiped"
            skip;;
    esac
}

# teardown() {
#     # if [ -d "${DOTFILES_D}" ]; then
#     #     echo "Dotfile ${DOTFILES_D} exists and will be removed"
#     #     rm -rf ${DOTFILES_D}
#     # fi
# }

@test "default install (no option)" {
    run $DOTFILE_INSTALL
    [ $status -eq 0 ]
    [ -d "${DOTFILES_D}" ]
}

@test "install --bash" {
    run $DOTFILE_INSTALL --bash
    assert_success
    assert_falkor_dotfile_present "bash/.bashrc"
    assert_falkor_dotfile_present "bash/.inputrc"
    assert_falkor_dotfile_present "bash/.bash_profile"
    assert [ -e "${TARGET}/.bash_aliases" ]
}

@test "install --bash --delete" {
    run $DOTFILE_INSTALL --bash --delete
    assert_success
    assert_falkor_dotfile_absent "bash/.bashrc"
    assert_falkor_dotfile_absent "bash/.inputrc"
    assert_falkor_dotfile_absent "bash/.bash_profile"
    assert [ ! -e "${TARGET}/.bash_aliases" ]
}


@test "install --vim" {
    run $DOTFILE_INSTALL --vim
    assert_success
    assert_falkor_dotfile_present "vim/.vimrc"
}

@test "install --vim --delete" {
    run $DOTFILE_INSTALL --vim --delete
    assert_success
    assert_falkor_dotfile_absent "vim/.vimrc"
}

@test "install --screen" {
    run $DOTFILE_INSTALL --screen
    assert_success
    assert_falkor_dotfile_present "screen/.screenrc"
}

@test "install --screen --delete" {
    run $DOTFILE_INSTALL --screen --delete
    assert_success
    assert_falkor_dotfile_absent "screen/.screenrc"
}
