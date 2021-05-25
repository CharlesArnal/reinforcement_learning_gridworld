
clear all;
close all;

% Graph 400 iterations non averaged
%{
cliffworld
maxit=30;
maxeps=400;
initialAlpha=0.5;
alphaDeclineCoeff=0;
initialEpsilon=0.1;
epsilonDeclineCoeff=0;
modified=false;
[v_qLearning, pi_qLearning,R_qLearning] = qLearning(model, maxit, maxeps,initialAlpha,alphaDeclineCoeff,initialEpsilon,epsilonDeclineCoeff);
[v_sarsa, pi_sarsa,vEpsilon_sarsa,piEpsilon_sarsa,R_sarsa] = sarsa(model, maxit, maxeps,initialAlpha,alphaDeclineCoeff,initialEpsilon,epsilonDeclineCoeff,modified);
[v_expected, pi_expected,vEpsilon_expected,piEpsilon_expected,R_expected] = expectedSarsa(model, maxit, maxeps,initialAlpha,alphaDeclineCoeff,initialEpsilon,epsilonDeclineCoeff);

figure(2)
plot(1:1:maxeps,R_qLearning,"color","blue")
hold on;
plot(1:1:maxeps,R_sarsa,"color","black")
hold on;
plot(1:1:maxeps,R_expected,"color","red")
%}

% graph 400 iterations averaged
%{
cliffworld
maxit=30;
maxeps=400;
initialAlpha=0.5;
alphaDeclineCoeff=0;
initialEpsilon=0.1;
epsilonDeclineCoeff=0;
modified=false;
N=400;
R_average_qLearning=zeros(maxeps,1);
R_average_sarsa=zeros(maxeps,1);
R_average_expected=zeros(maxeps,1);
v_sarsa_average=0;
v_QLearning_average=0;
v_expected_average=0;
for i=1:N
    rng(i)
    [v_qLearning, pi_qLearning,R_qLearning] = qLearning(model, maxit, maxeps,initialAlpha,alphaDeclineCoeff,initialEpsilon,epsilonDeclineCoeff);
    [v_sarsa, pi_sarsa,vEpsilon_sarsa,piEpsilon_sarsa,R_sarsa] = sarsa(model, maxit, maxeps,initialAlpha,alphaDeclineCoeff,initialEpsilon,epsilonDeclineCoeff,modified);
    [v_expected, pi_expected,vEpsilon_expected,piEpsilon_expected,R_expected] = expectedSarsa(model, maxit, maxeps,initialAlpha,alphaDeclineCoeff,initialEpsilon,epsilonDeclineCoeff);
    R_average_qLearning=R_average_qLearning+R_qLearning/N;
    R_average_sarsa=R_average_sarsa+R_sarsa/N;
    R_average_expected=R_average_expected+R_expected/N;
    v_sarsa_average=v_sarsa_average+v_sarsa(41)/N;
    v_QLearning_average=v_QLearning_average+v_qLearning(41)/N;
    v_expected_average=v_expected_average+v_expected(41)/N;
end

v_sarsa_average
v_QLearning_average
v_expected_average

figure(2)

plot(1:1:maxeps,R_average_qLearning,".","color","blue",'LineWidth',1,'MarkerSize',15)
hold on;
%plot(1:1:maxeps,R_average_sarsa,".","color","black",'LineWidth',1,'MarkerSize',15)
hold on;
plot(1:1:maxeps,R_average_expected,".","color","red",'LineWidth',1,'MarkerSize',15)
xlabel('Episodes','fontsize',18,'interpreter','latex')
ylabel('Sum of rewards','fontsize',18,'interpreter','latex')
axis([0 400 -100 0])
%legend({'Q-learning','Sarsa',"Expected Sarsa"},'FontSize',18)
legend({'Q-learning','Sarsa'},'FontSize',18)

%plotVP( v_qLearning,pi_qLearning, paramSet )
%plotVP( v_sarsa,pi_sarsa, paramSet )
%}


%{
% interim performance

cliffworld
maxit=30;
maxeps=100;
initialAlphas=[0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1];
%initialAlpha=0.5;
initialEpsilon=0.1;
alphaDeclineCoeff=0;
epsilonDeclineCoeff=0;
modified=false;
R_sarsa_average_100=zeros(10,1);
R_QLearning_average_100=zeros(10,1);
R_expected_average_100=zeros(10,1);
N=200;

for j=1:10
for i=1:N
    rng(i)
    %[v_qLearning, pi_qLearning,R_qLearning] = qLearning(model, maxit, maxeps,initialAlphas(j),alphaDeclineCoeff,initialEpsilon,epsilonDeclineCoeff);
    [v_sarsa, pi_sarsa,vEpsilon_sarsa,piEpsilon_sarsa,R_sarsa] = sarsa(model, maxit, maxeps,initialAlphas(j),alphaDeclineCoeff,initialEpsilon,epsilonDeclineCoeff,modified);
    %[v_expected, pi_expected,vEpsilon_expected,piEpsilon_expected,R_expected] = expectedSarsa(model, maxit, maxeps,initialAlphas(j),alphaDeclineCoeff,initialEpsilon,epsilonDeclineCoeff);
    %R_QLearning_average_100(j)=R_QLearning_average_100(j)+mean(R_qLearning)/N;
    R_sarsa_average_100(j)=R_sarsa_average_100(j)+mean(R_sarsa)/N;
    %R_expected_average_100(j)=R_expected_average_100(j)+mean(R_expected)/N;
end
j
end

%}

%{
% asymptotic performance
cliffworld
maxit=30;
maxeps=10000;
initialAlphas=[0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1];
initialEpsilon=0.1;
alphaDeclineCoeff=0;
epsilonDeclineCoeff=0;
modified=false;
R_sarsa_average_10000=zeros(10,1);
R_QLearning_average_10000=zeros(10,1);
R_expected_average_10000=zeros(10,1);
N=10;

for j=1:10
for i=1:N
    rng(i)
    [v_qLearning, pi_qLearning,R_qLearning] = qLearning(model, maxit, maxeps,initialAlphas(j),alphaDeclineCoeff,initialEpsilon,epsilonDeclineCoeff);
    [v_sarsa, pi_sarsa,vEpsilon_sarsa,piEpsilon_sarsa,R_sarsa] = sarsa(model, maxit, maxeps,initialAlphas(j),alphaDeclineCoeff,initialEpsilon,epsilonDeclineCoeff,modified);
    [v_expected, pi_expected,vEpsilon_expected,piEpsilon_expected,R_expected] = expectedSarsa(model, maxit, maxeps,initialAlphas(j),alphaDeclineCoeff,initialEpsilon,epsilonDeclineCoeff);
    R_QLearning_average_10000(j)=R_QLearning_average_10000(j)+mean(R_qLearning)/N;
    R_sarsa_average_10000(j)=R_sarsa_average_10000(j)+mean(R_sarsa)/N;
    R_expected_average_10000(j)=R_expected_average_10000(j)+mean(R_expected)/N;
end
end
%}


% with diminishing alpha
cliffworld
maxit=30;
maxeps=10000;
initialAlpha=1;
initialEpsilon=0.1;
alphaDeclineCoeff=1/3;
epsilonDeclineCoeff=0;
modified=false;
R_sarsa_average_10000_declining=zeros(10,1);
R_QLearning_average_10000_declining=zeros(10,1);
R_expected_average_10000_declining=zeros(10,1);
N=10;

for i=1:N
    rng(i)
    [v_qLearning, pi_qLearning,R_qLearning] = qLearning(model, maxit, maxeps,initialAlpha,alphaDeclineCoeff,initialEpsilon,epsilonDeclineCoeff);
    [v_sarsa, pi_sarsa,vEpsilon_sarsa,piEpsilon_sarsa,R_sarsa] = sarsa(model, maxit, maxeps,initialAlpha,alphaDeclineCoeff,initialEpsilon,epsilonDeclineCoeff,modified);
    [v_expected, pi_expected,vEpsilon_expected,piEpsilon_expected,R_expected] = expectedSarsa(model, maxit, maxeps,initialAlpha,alphaDeclineCoeff,initialEpsilon,epsilonDeclineCoeff);
    R_QLearning_average_10000_declining=R_QLearning_average_10000_declining+mean(R_qLearning)/N;
    R_sarsa_average_10000_declining=R_sarsa_average_10000_declining+mean(R_sarsa)/N;
    R_expected_average_10000_declining=R_expected_average_10000_declining+mean(R_expected)/N;
    i
end


R_sarsa_average_100_declining=zeros(10,1);
R_QLearning_average_100_declining=zeros(10,1);
R_expected_average_100_declining=zeros(10,1);
maxeps=100;
N=1000;

for i=1:N
    rng(i)
    [v_qLearning, pi_qLearning,R_qLearning] = qLearning(model, maxit, maxeps,initialAlpha,alphaDeclineCoeff,initialEpsilon,epsilonDeclineCoeff);
    [v_sarsa, pi_sarsa,vEpsilon_sarsa,piEpsilon_sarsa,R_sarsa] = sarsa(model, maxit, maxeps,initialAlpha,alphaDeclineCoeff,initialEpsilon,epsilonDeclineCoeff,modified);
    [v_expected, pi_expected,vEpsilon_expected,piEpsilon_expected,R_expected] = expectedSarsa(model, maxit, maxeps,initialAlpha,alphaDeclineCoeff,initialEpsilon,epsilonDeclineCoeff);
    R_QLearning_average_100_declining=R_QLearning_average_100_declining+mean(R_qLearning)/N;
    R_sarsa_average_100_declining=R_sarsa_average_100_declining+mean(R_sarsa)/N;
    R_expected_average_100_declining=R_expected_average_100_declining+mean(R_expected)/N;
    i
end

