# coding=utf-8
# CORDIC in polar coordinates (rotating, vectoring)

from math import sqrt, pi, cos, sin, atan, copysign, floor

def cordic (x0, y0, z0, vectoring = False, iterations = 10):
    A = 1.0
    # Input scaling and
    # map argument -π...π to -π/2...π/2.
    if (vectoring and x0 < 0 and y0 >= 0) or (not vectoring and z0 < -pi/2):
        x, y, z = y0, -x0, z0 + pi/2
    elif (vectoring and x0 < 0 and y0 < 0) or (not vectoring and z0 >= pi/2):
        x, y, z  = -y0, x0, z0 - pi/2
    else:
        x, y, z  = x0, y0, z0

    for i in range(iterations):
        d       = -copysign(1, y) if vectoring else copysign(1, z)
        pow2    = 2**(-i)
        x, y, z = x - y * d * pow2, y + x * d * pow2, z - d * atan(pow2)
        A       = A * sqrt(1 + pow2 * pow2)
    return x, y, z, A

def main():
    bits = 4
    iterations = bits + 2

    # analog output
    #iterations = bits + 1 # bits=2
    #iterations = bits + 1 # bits=3
    #iterations = bits + 1 # bits=4
    #iterations = bits + 2 # bits=5
    #iterations = bits + 2 # bits=6
    #iterations = bits + 2 # bits=7
    #iterations = bits + 2 # bits=8
    #iterations = bits + 2 # bits=9
    #iterations = bits + 2 # bits=10
    #iterations = bits + 2 # bits=11
    #iterations = bits + 2 # bits=12
    #iterations = bits + 2 # bits=16
    #iterations = bits + 2 # bits=20

    # output rounded
    #iterations = bits + 3 # bits=4
    #iterations = bits + 6 # bits=5
    #iterations = bits + 5 # bits=6
    #iterations = bits + 6 # bits=7
    #iterations = bits + 5 # bits=8
    #iterations = bits + 6 # bits=9
    #iterations = bits + 8 # bits=10
    #iterations = bits + 11 # bits=11
    #iterations = bits + 10 # bits=12
    #iterations = bits + 11 # bits=13
    #iterations = bits + 12 # bits=14
    #iterations = bits + 12 # bits=15
    #iterations = bits + 15 # bits=16

    print("xr, yr, zr, x, y, z")

    for i in range(2**bits):
        x0 = 2**(bits - 1) - 1
        y0 = 0
        z0 = (i - 2**(bits - 1)) * pi / 2**(bits - 1)

        x, y, z, A = cordic(x0, y0, z0, False, iterations)
        z = 2**(bits - 1) / pi * z

        # ideal response
        #x, y, z = A * x0 * cos(z0), A * x0 * sin(z0), 0

        # error plot
        # Usage: python3 cordic.py | grep -v '0, 0, 0$'
        #x, y = x - A * x0 * cos(z0), y - A * x0 * sin(z0)
        #x, y, z = floor(x) - A * x0 * cos(z0), floor(y) - A * x0 * sin(z0), floor(z)
        #x, y, z = round(x) - A * x0 * cos(z0), round(y) - A * x0 * sin(z0), round(z)

        print("%f, %f, %f, %d, %d, %d" % (x, y, z, round(x), round(y), round(z)))
    print("A=%f" % A)

if __name__ == "__main__":
    main()
