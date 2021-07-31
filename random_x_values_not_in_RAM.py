import random


def decimalToBinary(num, k_prec) :
    binary = ""
    Integral = int(num)
    fractional = num - Integral
    while (Integral) :
        rem = Integral % 2
        binary += str(rem);
        Integral //= 2
    binary = binary[ : : -1]

    binary = "0" + "0"*(4-len(binary)) + binary
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
    f = open("random_x_values_not_in_RAM.mif", "w")
    n = 20  # int(input("Enter the number of random values to be generated : "))
    for i in range(n):
        x = float(str(random.randrange(-15, 15, 1)) + "." + str(random.randrange(0, 10000, 1)))
        if(x < 0):
            k = decimalToBinary(-x, 11)
            k  = ''.join(['1' if i == '0' else '0' for i in k])
            temp = int(k,2)
            val = bin(temp + 1)[2:]
        else:
            val = decimalToBinary(x, 11)
        print(x)
        f.write(str(val)+"\n")
    f.close()


XValues()