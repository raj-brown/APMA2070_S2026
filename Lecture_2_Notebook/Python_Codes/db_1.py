import pdb
a = 20
b = 10
 
s = 0

def f(x):
    pdb.set_trace()
    print(f"Square of x: {x**2}")
    y = x**2
    z = y+1
    return z

z = f(4)


    
#for i in range(a):
#    s += a / b
#    #breakpoint()
#    a=f(s)
#    b -= 1
