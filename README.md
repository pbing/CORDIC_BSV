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
|  mode                                             | xerr     | yerr     | zerr       | xenob     | yenob     |
|---------------------------------------------------|----------|----------|------------|-----------|-----------| 
| [rotating](sim/verilator/rotating/Response.cpp)   | 0.719916 | 0.721141 | 0.779065   | 15.894761 | 15.895094 |
| [vectoring](sim/verilator/vectoring/Response.cpp) | 1.629335 | 0.706702 | 255.999018 | -         | -         |

### Round half up
|  mode                                             | xerr     | yerr     | zerr     |xenob      | yenob     |
|---------------------------------------------------|----------|----------|----------|-----------|-----------|
| [rotating](sim/verilator/rotating/Response.cpp)   | 0.528808 | 0.528494 | 0.000000 | 15.888566 | 15.888126 |
| [vectoring](sim/verilator/vectoring/Response.cpp) | 1.135232 | 0.612975 | 0.044195 |-          | -         |

### Convergent rounding
|  mode                                             | xerr     | yerr     | zerr     | xenob     | yenob     |
|---------------------------------------------------|----------|----------|----------|-----------|-----------| 
| [rotating](sim/verilator/rotating/Response.cpp)   | 0.528640 | 0.528560 | 0.000000 | 15.888164 | 15.888278 |
| [vectoring](sim/verilator/vectoring/Response.cpp) | 1.143321 | 0.604856 | 0.044195 | -         | -         |

## References
* [CORDIC (Wikipedia)](https://en.wikipedia.org/wiki/CORDIC)
* [Ray Andraka, A survey of CORDIC algorithms for FPGA based computers.](http://www.andraka.com/files/crdcsrvy.pdf)
* [CORDIC processor](https://github.com/pbing/CORDIC)
* [Gisselquist Technology, Rounding numbers without adding a bias.](http://zipcpu.com/dsp/2017/07/22/rounding.html)
* [Rounding (Wikipedia)](https://en.wikipedia.org/wiki/Rounding)
