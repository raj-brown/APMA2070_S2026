a = 20
b = 10
 
s = 0

def f(x):
    print(f"Square of x: {x**2}")

for i in range(a):
    s += a / b
    breakpoint()
    f(s)
    b -= 1
