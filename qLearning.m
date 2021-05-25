function [v, pi, R_history] = qLearning(model, maxit, maxeps,initialAlpha,alphaDeclineCoeff,initialEpsilon,epsilonDeclineCoeff)

% Initialize the value function
Q = zeros(model.stateCount, 4);
% The cumulative reward for each episode
R_history = zeros(maxeps,1);

for i = 1:maxeps
    % Epsilon decreases for epsilonDeclineCoeff > 0
    epsilon = initialEpsilon/(i^epsilonDeclineCoeff);
    % Alpha decreases for AlphaDeclineCoeff > 0
    alpha = initialAlpha/(i^alphaDeclineCoeff);
    % Every time we reset the episode, start at the given startState
    s = model.startState;
    % The accumulated reward for that episode
    total_R=0;

    for j = 1:maxit
        % We choose and take action a, observe new state s_ and reward r
        a = EGreedyActionFromQ(Q(s,:),epsilon);
        s_ = categoricalSample(model.P(s,:,a));
        r = model.R(s,a);
        total_R = total_R + model.gamma^(j-1)*r;
        % What would have been the greedy action to take in state s_
        % (a 0-greedy action)
        a_ = EGreedyActionFromQ(Q(s_,:),0);
        % Update Q(s,a)
        Q(s,a) = Q(s,a) + alpha*(r+model.gamma*Q(s_,a_)-Q(s,a) );
        % Actualize current state
        s = s_;
        % Stop if end state reached
        if s == model.stateCount
            break;
        end
    end
    % Records the episode's cumulative reward
    R_history(i)=total_R;
end
pi= greedyPolicyFromQ(Q);
% We compute v - we could use Q, but if the number of episodes was small,
% Q might be an extremely poor approximation
% of the true state-action value functions of pi
v = policyEvaluation(pi,model,10000,10^(-9));
end

