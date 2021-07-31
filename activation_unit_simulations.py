import math
import numpy as np

def bin_to_dec(binStr):
  i = -1
  sum = 0
  for digit in binStr:
    sum += int(digit)*pow(2,i)
    i=i-1
  return sum

''' Sigmoid '''

def sigmoid(x):
    try:
        return 1 / (1+math.exp(-x)) #for x less than -1023 will give value error
    except:
        return 0

''' TanH '''

def tanh(x):
    try:
        return np.tanh(x)
    except:
        return 0

''' Softmax '''

def softmax1(x,sum_exp):
    return round(x /sum_exp, 5)

def DtoB(num,dataWidth,fracBits):#funtion for converting into two's complement format
    if num >= 0:
        num = num * (2**fracBits)
        num = int(num)
        e = bin(num)[2:]
        if (len(e) < 15):
          e = (16-len(e))*"0" + e
    else:
        num = -num
        num = num * (2**fracBits)#number of fractional bits
        num = int(num)
        if num == 0:
            d = 0
        else:
            d = 2**dataWidth - num
        e = bin(d)[2:]
    return e

def ActiFuncSigTanH(dataWidth,Size,weightIntSize,inputIntSize):
    f = open("SigTanHContent.mif", "w")
    fractBits = Size - (weightIntSize + inputIntSize)
    if fractBits < 0:  # Sigmoid size is smaller the integer part of the MAC operation
        fractBits = 0
    x = -2 ** (weightIntSize + inputIntSize - 1)  # Smallest input going to the Sigmoid LUT from the neuron
    x_axis = []
    for i in range(0, 2 ** Size):
        tan_func = tanh(x)
        sig_func = sigmoid(x)
        tan = DtoB(tan_func, dataWidth, dataWidth - inputIntSize)
        sig = DtoB(sig_func, dataWidth, dataWidth - inputIntSize)
        x_axis.append(x)
        #print(sig_func," ",tan_func)
        f.write(sig+tan + '\n')
        x = x + (2 ** -fractBits)
    f.close()

ActiFuncSigTanH(dataWidth=16,Size=10,weightIntSize=4,inputIntSize=1)
