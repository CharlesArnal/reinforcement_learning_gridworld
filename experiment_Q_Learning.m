clear all;
smallworld
maxit=20;
maxeps=10000;
initialAlpha=0.5;
alphaDeclineCoeff=0;
initialEpsilon=0.1;
epsilonDeclineCoeff=0;
[v, pi,~] = qLearning(model, maxit, maxeps,initialAlpha,alphaDeclineCoeff,initialEpsilon,epsilonDeclineCoeff);
plotVP( v,pi, paramSet )


