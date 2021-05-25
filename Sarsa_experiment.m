clear all;
close all;
smallworld
maxit=40;
maxeps=10000;
initialAlphas=[0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1]
initialAlpha=0.5;
initialEpsilon=0.1;
alphaDeclineCoeff=0;
epsilonDeclineCoeff=0;
modified=false;
N=50;
Performance=zeros(10,1)

[v, pi,vEpsilon,piEpsilon,R_history] = sarsa(model, maxit, maxeps,initialAlpha,alphaDeclineCoeff,initialEpsilon,epsilonDeclineCoeff,modified);
%{
for j=1:10
for i=1:N
    rng(i)
    [v, pi,vEpsilon,piEpsilon,R_history] = sarsa(model, maxit, maxeps,initialAlphas(j),alphaDeclineCoeff,initialEpsilon,epsilonDeclineCoeff,modified);
    Performance(j)=Performance(j)+R_history(100)/N;
end
end

R_mean=mean(R_total_history,1);
figure(2)
plot(1:1:maxeps,R_mean,"color","blue")
%}
plotVP( vEpsilon,pi, paramSet )



