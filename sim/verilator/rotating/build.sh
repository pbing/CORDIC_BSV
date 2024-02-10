#!/bin/zsh
verilator --cc \
          --exe \
          --build \
          --trace-fst --trace-depth 1 \
          -Wno-INITIALDLY \
          -y ../../../verilog \
          -y $BLUESPECDIR/Verilog \
          -CFLAGS -std=c++20 \
          mkCORDIC_r_16.v \
          Request.cpp \
          Response.cpp \
          sim_main.cpp
