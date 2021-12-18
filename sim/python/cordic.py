# coding=utf-8
# CORDIC in polar coordinates (rotating, vectoring)

from math import sqrt, pi, atan, copysign

vectoring = True
rotating = False

def cordic (x0, y0, z0, mode, iterations):
    # map argument -π...π to -π/2...π/2.
    if (mode == vectoring and x0 < 0 and y0 >= 0) or (mode == rotating and z0 < -pi/2):
        x, y, z = y0, -x0, z0 + pi/2
    elif (mode == vectoring and x0 < 0 and y0 < 0) or (mode == rotating and z0 >= pi/2):
        x, y, z  = -y0, x0, z0 - pi/2
    else:
        x, y, z  = x0, y0, z0
    # iterate
    A = 1.0
    for i in range(iterations):
        d       = -copysign(1, y) if mode == vectoring else copysign(1, z)
        pow2    = 2**(-i)
        x, y, z = x - y * d * pow2, y + x * d * pow2, z - d * atan(pow2)
        A       = A * sqrt(1 + pow2 * pow2)
    return x, y, z, A
