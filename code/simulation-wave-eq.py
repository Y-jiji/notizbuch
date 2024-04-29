import torch
import matplotlib.pyplot as plt
import matplotlib.animation as anim
import functools

N = 100
T = 1e-3
C = 2
X = torch.arange(N) / N * torch.pi
Y = torch.sin(X * 4).to('cuda:0') + torch.sin(X * 3).to('cuda:0')
M = torch.sin(X * 4).to('cuda:0') + torch.sin(X * 3).to('cuda:0')
I = 0
A = lambda x: 0

FIG, AXE = plt.subplots()

def update_pure(V, frame):
    N, T, C, X, Y, M, I, A = V
    # change of motion
    M[1:-1] += (Y[:-2] + Y[2:] - 2 * Y[1:-1]) * T * C * N
    # left side & right side, update with given acceleration
    M[0]  += A(torch.tensor(I * T)) * T
    M[-1] += A(torch.tensor(I * T)) * T
    # change of position
    Y += M * T
    I += 1
    AXE.clear()
    AXE.set(xlim=[0, +torch.pi], ylim=[-10, 10])
    AXE.plot(X.cpu(), Y.cpu())
    AXE.plot(X.cpu(), M.cpu())

update = functools.partial(update_pure, (N, T, C, X, Y, M, I, A))
animation = anim.FuncAnimation(FIG, update, frames=1000000, interval=T)
plt.show()