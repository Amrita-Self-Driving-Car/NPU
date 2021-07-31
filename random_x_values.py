import random

f = open("XValues.mif", "r")
k = f.readlines()
n = 10  #int(input("Enter the number of random values to be generated : "))
gen = []
for i in range(n):
    m = random.choice(k)
    print(m.strip())
    gen.append(m.strip())
f.close()

f = open("RandomXValues.mif", "w")
for i in gen:
    f.write(str(i) + "\n")
f.close()