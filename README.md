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

## References
* [CORDIC (Wikipedia)](https://en.wikipedia.org/wiki/CORDIC)
* [Ray Andraka, A survey of CORDIC algorithms for FPGA based computers.](http://www.andraka.com/files/crdcsrvy.pdf)
* [CORDIC processor](https://github.com/pbing/CORDIC)
