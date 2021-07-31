import math
import numpy as np

def tanh(x):
    try:
        return np.tanh(x)
    except:
        return 0

def sigmoid(x):
    try:
        return 1 / ( 1 +math.exp(-x))  # for x less than -1023 will give value error
    except:
        return 0

def decimalToBinary(num, k_prec) :
    binary = ""
    Integral = int(num)
    fractional = num - Integral
    if Integral > 0:
        binary = "1"
    else:
        binary = "0"
    binary = "0" + binary

    while (k_prec) :
        fractional *= 2
        fract_bit = int(fractional)
        if (fract_bit == 1) :
            fractional -= fract_bit
            binary += '1'
        else :
            binary += '0'
        k_prec -= 1
    return binary

def XValues():
    f = open("activation_sig_tanh.mif", "w")
    x = -15.96875
    largest_x = -x
    while(x <= largest_x):
        print(x)
        tan_func = tanh(x)
        sig_func = sigmoid(x)
        print(sig_func,tan_func)
        if(tan_func < 0):
            tan = decimalToBinary(-tan_func, 14)
            tan = ''.join(['1' if i == '0' else '0' for i in tan])
            temp_tan = int(tan, 2)
            val_tan = bin(temp_tan + 1)[2:]
        else:
            val_tan = decimalToBinary(tan_func, 14)
        val_sig = decimalToBinary(sig_func, 14)
        f.write(str(val_sig) + str(val_tan) +"\n")
        print(str(val_sig) +" "+ str(val_tan)+"\n")
        x = x + (0.03125)
    f.close()

XValues()