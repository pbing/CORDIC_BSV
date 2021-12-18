# Error calculation vectoring mode

import numpy as np
from cordic import *

def calc_err(bits, iterations):
    n_2 = 2**(bits - 1)
    n   = 2 * n_2

    theta = np.linspace(0.0, 2*np.pi, num=n, endpoint=False)
    x0    = np.cos(theta)
    y0    = np.sin(theta)
    z0    = np.zeros(n)

    x = np.zeros(n)
    y = np.zeros(n)
    z = np.zeros(n)
    A = np.ones(n)

    # CORDIC
    for i in range(n): x[i], y[i], z[i], A[i] = cordic(x0[i], y0[i], z0[i], vectoring, iterations)
    x = n_2 * x
    y = n_2 * y
    z = (n_2 / np.pi) * z

    # reference
    xr = n_2 * A * np.sqrt(np.square(x0) + np.square(y0))
    yr = np.zeros(n)
    zr = (n_2 /np.pi) * np.arctan2(y0, x0)

    xd = x - xr
    yd = y - yr
    zd = z - zr

    xerr = np.sqrt(np.average(np.square(xd)))
    yerr = np.sqrt(np.average(np.square(yd)))
    zerr = np.sqrt(np.average(np.square(zd)))

    #print("x0", x0)
    #print("y0", y0)
    #print("z0", z0)
    #print("A", A)
    #print("x", x)
    #print("y", y)
    #print("z", z)
    #print("xr", xr)
    #print("yr", yr)
    #print("zr", zr)
    #print("xd", xd)
    #print("yd", yd)
    #print("zd", zd)

    print("xerr=%f (xdmin=%f xd.max=%f)" % (xerr, np.min(xd), np.max(xd)))
    print("yerr=%f (ydmin=%f yd.max=%f)" % (yerr, np.min(yd), np.max(yd)))
    print("zerr=%f (zdmin=%f zd.max=%f)" % (zerr, np.min(zd), np.max(zd)))

if __name__ == "__main__":
    bits = 16
    iterations = bits + 1
    calc_err(bits, iterations)
