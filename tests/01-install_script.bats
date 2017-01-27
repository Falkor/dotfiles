#! /usr/bin/env bats
################################################################################
# 01-install_script.bats
# Time-stamp: <Mon 2017-01-23 01:42 svarrette>
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

setup() {
    # Avoid to run the tests on your machine
    case "$(hostname -f)" in
        *travis* | *testing*)  echo "=> Tests on travis resources";;
        *vagrant*) echo "=> Tests on vagrant resources";;
        *) # Detect TRAVIS_CI_RUN environment variable (set in .travis.yml)
            if [ -z "${TRAVIS_CI_RUN}" ]; then
                echo "tests on $(hostname -f) skiped"
                skip
            fi;;
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
    assert [ -e "${DOTFILES_D}/bash/custom/aliases.sh" ]
}

@test "install --bash --delete" {
    run $DOTFILE_INSTALL --bash --delete
    assert_success
    assert_falkor_dotfile_absent "bash/.bashrc"
    assert_falkor_dotfile_absent "bash/.inputrc"
    assert_falkor_dotfile_absent "bash/.bash_profile"
    assert [ ! -e "${DOTFILES_D}/bash/custom/aliases.sh" ]
}


# @test "install --vim" {
#     run $DOTFILE_INSTALL --vim
#     assert_success
#     assert_falkor_dotfile_present "vim/.vimrc"
# }

# @test "install --vim --delete" {
#     run $DOTFILE_INSTALL --vim --delete
#     assert_success
#     assert_falkor_dotfile_absent "vim/.vimrc"
# }

# @test "install --screen" {
#     run $DOTFILE_INSTALL --screen
#     assert_success
#     assert_falkor_dotfile_present "screen/.screenrc"
# }

# @test "install --screen --delete" {
#     run $DOTFILE_INSTALL --screen --delete
#     assert_success
#     assert_falkor_dotfile_absent "screen/.screenrc"
# }

# @test "install --git" {
#     [ -n "${TRAVIS_CI_RUN}" ] && skip
#     run $DOTFILE_INSTALL --git
#     assert_success
#     assert_falkor_dotfile_present "git/.gitconfig"
#     assert [ -f "${TARGET}/.gitconfig.local" ]
# }

# @test "install --git --delete" {
#     [ -n "${TRAVIS_CI_RUN}" ] && skip
#     run $DOTFILE_INSTALL --git --delete
#     assert_success
#     assert_falkor_dotfile_absent "git/.gitconfig"
#     assert [ ! -f "${TARGET}/.gitconfig.local" ]
# }

# @test "install --zsh" {
#     #[ -n "${TRAVIS_CI_RUN}" ] && skip
#     run bash -c "echo password | $DOTFILE_INSTALL --zsh"
#     assert_success
#     assert_falkor_dotfile_present "oh-my-zsh/.zshrc"
#     assert [ -h "${TARGET}/.oh-my-zsh/custom/plugins/falkor" ]
#     assert [ -h "${TARGET}/.oh-my-zsh/custom/themes/powerlevel9k" ]
# }

# @test "install --zsh --delete" {
#     #[ -n "${TRAVIS_CI_RUN}" ] && skip
#     run bash -c "echo y | $DOTFILE_INSTALL --zsh --delete"
#     assert_success
#     assert_falkor_dotfile_absent "oh-my-zsh/.zshrc"
#     assert [ ! -e "${TARGET}/.oh-my-zsh/custom/plugins/falkor" ]
#     assert [ ! -e "${TARGET}/.oh-my-zsh/custom/themes/powerlevel9k" ]
# }
