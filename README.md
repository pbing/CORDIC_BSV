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
bsc -verilog -u ./test/Tb1.bsv
```

## Simulated errors
Error calculation was done with Verilator. The module mkCORDIC_16 (16 bit inputs, 17/16 bit outputs) was used.
Inputs are x0, y0 and z0. Outputs are x, y and z.

|  mode                                            | x0            | y0            | z0 | x           | y        | z |
|--------------------------------------------------|---------------|---------------|----|-------------|----------|---|
| [sim/verilator/rotating/Request.cpp](rotating)   | 0x7fff        | 0             | θ  | A·cos(θ)    | A·sin(θ) | 0 |
| [sim/verilator/vectoring/Request.cpp](vectoring) | 0x7fff·cos(θ) | 0x7fff·sin(θ) | 0  | A·0x7fff    | 0        | θ |

### Truncating
|  mode     | xerr     | yerr     | zerr       |
|-----------|----------|----------|------------|
| rotating  | 0.653896 | 0.649125 | 0.462326   |
| vectoring | 1.430610 | 0.706653 | 255.996732 |

## Round half up
t.b.d.


## References
* [CORDIC (Wikipedia)](https://en.wikipedia.org/wiki/CORDIC)
* [Ray Andraka, A survey of CORDIC algorithms for FPGA based computers.](http://www.andraka.com/files/crdcsrvy.pdf)
* [CORDIC processor](https://github.com/pbing/CORDIC)
