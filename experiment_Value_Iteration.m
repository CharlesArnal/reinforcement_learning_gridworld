gridworld
maxit=10000;
tolerance=10^(-7);
[Vopt, Popt] = valueIteration(model, maxit,tolerance);
plotVP( Vopt, Popt, paramSet )