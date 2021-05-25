% pi is the greedy deterministic policy associated to the final
% action-value function Q obtained and piEpsilon is the epsilon-greedy
% function associated to it (where epsilon is the value of epsilon used for
% the last episode, see beloz)

% piEpsilon is a model.statecount x 4 vector, where piEpsilon(s,a) =
% probability of doing a in state s

% v is the value function associated to pi, and vEpsilon the value function
% associated to piEpsilon

% Epsilon is equal to initialEpsilon/(episode number)^epsilonDeclineCoeff -
% let epsilonDeclineCoeff=0 for constant epsilon

% If the "modified" boolean variable is true, the behaviour policy either
% makes the greedy choice with probability 1-epsilon, or chooses the action a such
% that (s,a) has been tested the fewest times among the four possibilities
% (s,up), (s,down), (s,left),(s,right) with probability epsilon*3/4, or a
% random action with probability epsilon/4 (which means epsilon/16 for each action)


function [v, pi,vEpsilon,piEpsilon,R_history] = sarsa(model, maxit, maxeps,initialAlpha,alphaDeclineCoeff,initialEpsilon,epsilonDeclineCoeff,modified)

% Initialize the value function
Q = zeros(model.stateCount, 4);
% Tracks the number of times each state-action pair has been tested (used
% for a modified version of the sarsa algorithm)
Q_number_visits = zeros(model.stateCount, 4);
% The cumulative reward for each episode
R_history = zeros(maxeps,1);

for i = 1:maxeps
    % The cumulated reward for that episode
    total_R=0;
    % Epsilon decreases for epsilonDeclineCoeff > 0
    epsilon = initialEpsilon/(i^epsilonDeclineCoeff);
    % Alpha decreases for alphaDeclineCoeff > 0
    alpha = initialAlpha/(i^alphaDeclineCoeff);
    % Every time we reset the episode, start at the given startState
    s = model.startState;
    if modified==false
        a = EGreedyActionFromQ(Q(s,:),epsilon);
    else
        a = modifiedEGreedyActionFromQ(Q(s,:),Q_number_visits(s,:),epsilon);
    end

    for j = 1:maxit
        % We take action a, observe new state s_ and reward r
        s_ = categoricalSample(model.P(s,:,a));
        r = model.R(s,a);
        total_R=total_R+model.gamma^(j-1)*r;
        % Pick new action a_
        if modified==false
            a_ = EGreedyActionFromQ(Q(s_,:),epsilon);
        else
            a_ = modifiedEGreedyActionFromQ(Q(s_,:),Q_number_visits(s_,:),epsilon);
        end
        % Update Q(s,a)
        Q(s,a) = Q(s,a) + alpha*(r+model.gamma*Q(s_,a_)-Q(s,a) );
        Q_number_visits(s,a)=Q_number_visits(s,a)+1;
        % Actualize current state and new action
        s = s_;
        a = a_;
        % Stop if end state reached
        if s == model.stateCount
            break;
        end
    end
    R_history(i)=total_R;
end
pi= greedyPolicyFromQ(Q);
piEpsilon = EGreedyPolicyFromQ(Q,epsilon);
% We compute v and vEpsilon independently - we could use Q, but if the
% number of episodes was small, Q might be an extremely poor approximation
% of the true state-action value functions of pi and piEpsilon
v = policyEvaluation(pi,model,10000,10^(-9));
vEpsilon = policyEvaluation(piEpsilon,model,10000,10^(-9));
end

