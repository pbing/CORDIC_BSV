# Description

Synthesizeable CORDIC processor in Bluespec SystemVerilog (BSV)

## Quickstart

### Create an environment for BSC
```shell
source env.sh
```

### Simulate
```shell
bsc -sim -u -g mkTb ./test/Tb1.bsv
bsc -sim -e mkTb
./bsim [-m 30] [-V]
```
or
```shell
./run.sh ./test/Tb1.bsv  [-m 30] [-V]
```

### Create RTL
```shell
bsc -verilog -u ./test/Modules.bsv
```
or
```shell
./mkRTL.sh ./test/Modules.bsv
```

## Simulated errors
Error calculation was done with Verilator. The module mkCORDIC_16 (16 bit inputs, 17/16 bit outputs) was used.
Inputs are x0, y0 and z0. Outputs are x, y and zi with A=1.646760.

|  mode                                            | x0            | y0            | z0 | x           | y        | z |
|--------------------------------------------------|---------------|---------------|----|-------------|----------|---|
| [rotating](sim/verilator/rotating/Request.cpp)   | 0x7fff        | 0             | θ  | A·cos(θ)    | A·sin(θ) | 0 |
| [vectoring](sim/verilator/vectoring/Request.cpp) | 0x7fff·cos(θ) | 0x7fff·sin(θ) | 0  | A·0x7fff    | 0        | θ |

Truncation of the outputs results in a negative bias of half a LSB. Rounding half up improves this bias.
Convergent rounding (round half to even) removes the bias completely.

### Truncating
|  mode                                             | xerr     | yerr     | zerr     |
|---------------------------------------------------|----------|----------|----------|
| [rotating](sim/verilator/rotating/Response.cpp)   | 0.719910 | 0.721136 | 0.779059 |
| [vectoring](sim/verilator/vectoring/Response.cpp) | 1.629323 | 0.706697 | 0.705270 |

### Round half up
|  mode                                             | xerr     | yerr     | zerr     |
|---------------------------------------------------|----------|----------|----------|
| [rotating](sim/verilator/rotating/Response.cpp)   | 0.528804 | 0.528490 | 0.000000 |
| [vectoring](sim/verilator/vectoring/Response.cpp) | 1.135224 | 0.612970 | 0.044194 |

### Convergent rounding
|  mode                                             | xerr     | yerr     | zerr     | xenob     | yenob     |
|---------------------------------------------------|----------|----------|----------|-----------|-----------| 
| [rotating](sim/verilator/rotating/Response.cpp)   | 0.528640 | 0.528560 | 0.000000 | 15.888153 | 15.888153 |
| [vectoring](sim/verilator/vectoring/Response.cpp) | 1.143321 | 0.604856 | 0.044195 | -         | -         |

## References
* [CORDIC (Wikipedia)](https://en.wikipedia.org/wiki/CORDIC)
* [Ray Andraka, A survey of CORDIC algorithms for FPGA based computers.](http://www.andraka.com/files/crdcsrvy.pdf)
* [CORDIC processor](https://github.com/pbing/CORDIC)
* [Gisselquist Technology, Rounding numbers without adding a bias.](http://zipcpu.com/dsp/2017/07/22/rounding.html)
* [Rounding (Wikipedia)](https://en.wikipedia.org/wiki/Rounding)
