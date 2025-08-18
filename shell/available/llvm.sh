
# Mac OS config
if [ -x "$(command -v brew 2>/dev/null)" ]; then
  export LLVMPATH=$(brew --prefix llvm)
  export PATH=${LLVMPATH}/bin:$PATH
fi
