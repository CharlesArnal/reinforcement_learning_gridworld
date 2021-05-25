clear all;
gridworld
maxit=1000;
tolerance=10^(-7);
[Vopt, Popt] = policyIteration(model,maxit);


[Vopt2, Popt2] = valueIteration(model, maxit,tolerance);

max(abs(Popt-Popt2))
max(abs(Vopt-Vopt2))
plotVP( Vopt, Popt, paramSet )
