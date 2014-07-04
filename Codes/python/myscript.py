#!/usr/bin/env python

print('demo1')
a,b = 0,1
while b < 10:
  print b
  a,b = b,a+b


demo2 = ['cat', 'window', 'defenestrate']
for x in demo2:
  print x, len(x)

for n in range(2, 10):
  for x in range(2, n):
    if n % x == 0:
      print n, 'equals', x, '*', n/x
      break
    else:
      print n, 'is a prime number'


def fib(n):    # write Fibonacci series up to n
a, b = 0, 1
  while a < n:
    print a,
    a, b = b, a+b
