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


function [v, pi,vEpsilon,piEpsilon,R_history] = expectedSarsa(model, maxit, maxeps,initialAlpha,alphaDeclineCoeff,initialEpsilon,epsilonDeclineCoeff)

% Initialize the value function
Q = zeros(model.stateCount, 4);
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

    for j = 1:maxit
        % We choose and take action a, observe new state s_ and reward r
        a = EGreedyActionFromQ(Q(s,:),epsilon);
        s_ = categoricalSample(model.P(s,:,a));
        r = model.R(s,a);
        total_R = total_R + model.gamma^(j-1)*r;
        
        % Update Q(s,a)
        probas=epsilon/4*ones(4,1);
        [~,best_a]=max(Q(s_,:));
        probas(best_a)=probas(best_a)+1-epsilon;
        expectancy = Q(s_,:)*probas;
        Q(s,a) = Q(s,a) + alpha*(r+model.gamma*expectancy-Q(s,a) );
        % Actualize current state and new action
        s = s_;
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

