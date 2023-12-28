if test -n "$(command -v brew)"; then
  export LLVMPATH=$(brew --prefix llvm)
  export PATH=${LLVMPATH}/bin:$PATH
fi
