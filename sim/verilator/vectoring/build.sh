#!/bin/zsh
verilator -Wno-lint --trace \
          -y verilog \
          --cc mkCORDIC_16_wrapper.v mkCORDIC_16.v \
          --exe --build \
          sim_main.cpp Request.cpp Response.cpp
