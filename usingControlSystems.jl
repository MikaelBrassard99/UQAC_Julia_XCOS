#import Pkg; Pkg.add("ControlSystems")
#import Pkg; Pkg.add("Plots")
using ControlSystems

# Motor parameters
J = 2.0
b = 0.04
K = 1.0
R = 0.08
L = 1e-4

# Create the model transfer function
s = tf("s")
P = K/(s*((J*s + b)*(L*s + R) + K^2))
# This generates the system
# TransferFunction:
#                1.0
# ---------------------------------
# 0.0002s^3 + 0.160004s^2 + 1.0032s
#
#Continuous-time transfer function model

# Create an array of closed loop systems for different values of Kp
CLs = TransferFunction[kp*P/(1 + kp*P) for kp = [1, 10, 25]];


# Plot the step response of the controllers
# Any keyword arguments supported in Plots.jl can be supplied
using Plots
plot(step.(CLs, 5), label=["Kp = 1" "Kp = 10" "Kp = 25"])


#import Pkg; Pkg.add("ControlSystemIdentification")
#import Pkg; Pkg.add("ControlSystemsBase")
# using ControlSystemIdentification, ControlSystemsBase
# Ts = 0.1
# G  = c2d(DemoSystems.resonant(), Ts) # A true system to generate data from
# u  = randn(1,1000)                   # A random input
# y  = lsim(G,u).y                     # Simulated output
# y .+= 0.01 .* randn.()               # add measurement noise
# d  = iddata(y, u, Ts)                # package data in iddata object
# sys = subspaceid(d, :auto)           # estimate state-space model using subspace-based identification
#bodeplot([G, sys.sys], lab=["True" "" "n4sid" ""])