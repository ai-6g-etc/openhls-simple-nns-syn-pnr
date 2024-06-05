import numpy as np
from openhls.ir.memref import MemRef, GlobalMemRef
from openhls.ir.ops import FMAC, ReduceAdd, Copy, SelfCopy, ReduceTiling, Div, Sqrt
from openhls.compiler.runner import parfor, Forward, make_output_file
import os
make_output_file(os.getenv('RUNNER_OUTPUT_FP') or __file__)
__constant_11x11xf32 = np.array([0.1576385, -0.146185, 0.04934788, -
    0.01429983, 0.1693715, -0.2409347, -0.1779356, -0.16714, 0.103919, -
    0.2519541, 0.1540605, 0.1391728, 0.2526919, -0.1372477, -0.2978266, 
    0.2953767, -0.2760251, 0.2987897, 0.1039158, 0.04500446, -0.2320356, 
    0.01142813, 0.1666138, -0.1319891, -0.1305987, 0.2534783, 0.05841539, 
    0.003167509, 0.2568971, -0.1452786, -0.01678655, -0.1321718, 0.08818427,
    0.1976369, 0.135227, -0.07942878, -0.2275672, -0.1643816, -0.1376494, 
    0.2746334, 0.1449693, 0.2179956, 0.03650284, -0.05525675, 0.2498136, 
    0.006674499, -0.2110457, -0.1761207, 0.2348864, 0.1237346, -0.2842763, 
    -0.09037679, -0.1037419, 0.0635911, -0.2851996, 0.2610556, -0.2983899, 
    0.08445986, 0.07367177, -0.1954886, 0.0458402, -0.1850669, -0.1040556, 
    -0.1636716, -0.2187925, 0.07971109, 0.2407284, 0.2454032, 0.1853858, 
    0.2666092, 0.2514421, 0.1802394, 0.2877056, 0.03546638, 0.1664484, -
    0.174556, -0.01993583, 0.173898, -0.1632208, -0.09367421, 0.1678423, 
    0.06936508, -0.2196227, 0.01216737, -0.02274945, 0.2502406, 0.003084409,
    -0.06604536, 0.2218276, 0.1446718, -0.2873058, 0.06925873, -0.02375362,
    0.249664, -0.009961482, -0.07553696, -0.01873084, -0.1507863, 
    0.02304278, -0.0132021, -0.05672956, -0.2129534, 0.2204294, -0.1250761,
    -0.2326053, -0.1846267, 0.1185312, -0.1078517, 0.2254409, -0.1263583, 
    0.2836447, 0.1835069, 0.1416698, -0.217584, 0.09588653, -0.05552582, 
    0.2938903, 0.2655748, 0.1593273, 0.2453967, -0.08511274]).reshape(11, 11)
__constant_11xf32 = np.array([0.2516007, 0.1764848, 0.164554, 0.1870631, -
    0.1179187, -0.001213722, 0.2332864, 0.05957484, -0.22945, -0.05044252, 
    0.0103478]).reshape(11)


def forward(_arg0=MemRef('_arg0', 1, 11, input=True), _7=MemRef('_7', 1,
    output=True), _1=GlobalMemRef('__constant_11x11xf32',
    __constant_11x11xf32), _0=GlobalMemRef('__constant_11xf32',
    __constant_11xf32)):
    _2 = MemRef('_2', 11, 11)

    @parfor(_arg1=(0, 11, 1), _arg2=(0, 11, 1))
    def body(_arg1, _arg2):
        _8 = _1[_arg1, _arg2]
        _2[_arg2, _arg1] = _8
    _3 = MemRef('_3', 1, 11)

    @parfor(_arg1=(0, 1, 1), _arg2=(0, 11, 1))
    def body(_arg1, _arg2):
        _3[_arg1, _arg2] = 0.0
    _4 = MemRef('_4', 1, 11)
    _4.alias(_3)

    @parfor(_arg1=(0, 1, 1), _arg2=(0, 11, 1))
    def body(_arg1, _arg2, fma):
        for _arg3 in range(0, 11, 1):
            _8 = _arg0[_arg1, _arg3]
            _9 = _2[_arg3, _arg2]
            _10 = _4[_arg1, _arg2]
            _4[_arg1, _arg2] = fma(_8, _9, _10)
        return _4
    _5 = MemRef('_5', 1, 11)

    @parfor(_arg1=(0, 1, 1), _arg2=(0, 11, 1))
    def body(_arg1, _arg2):
        _8 = _4[0, _arg2]
        _9 = _0[_arg2,]
        _10 = _8 + _9
        _5[_arg1, _arg2] = _10
    SelfCopy(_5)
    _6 = MemRef('_6', 1)
    _6[0,] = 0.0
    _7.alias(_6)
    _7[0,] = _5.reduce_add()
    SelfCopy(_7)


if __name__ == '__main__':
    Forward(forward)
