#!/bin/bash

export DISABLE_AUTOBREW=1

if [[ $(uname) == Darwin ]]; then
  export PKG_LIBS="-L${PREFIX}/lib -headerpad_max_install_names"
else
  # .. on Linux the situation is even worse:
  export LD_LIBRARY_PATH=${PREFIX}/lib/R/lib:${PREFIX}/lib
  export PKG_LIBS="-L${PREFIX}/lib -L${PREFIX}/lib/R/lib -lR -Wl,-rpath-link,${PREFIX}/lib -lblas"
fi

# Check if we are cross-compiling
if [ "$CONDA_BUILD_CROSS_COMPILATION" == "1" ]; then
  R CMD INSTALL --build --no-test-load . ${R_ARGS}
else
  R CMD INSTALL --build . ${R_ARGS}
fi
