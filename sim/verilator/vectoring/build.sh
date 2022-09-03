#!/bin/zsh
verilator --cc \
          --exe \
          --build \
          --trace-fst --trace-depth 1 \
          -Wno-INITIALDLY \
          -y ../../../verilog \
          -y $BLUESPECDIR/Verilog \
          mkCORDIC_v_16.v \
          Request.cpp \
          Response.cpp \
          sim_main.cpp
