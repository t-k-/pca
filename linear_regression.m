clear

Y = [
1 0 0
0 1 0
0 0 1
]

X = [
0 0 1
0 1 0
]

W = Y * X' * inv(X * X')

x = [0 1]'

W*x
