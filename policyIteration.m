function [v, pi] = policyIteration(model, maxit)
% Initialize the value function
v = zeros(model.stateCount, 1);
% Initialize the policy and the new value function
pi = ones(model.stateCount, 1);
for i = 1:maxit
    % Perform policy evaluation to find the value function associated to pi
    % As an optional argument, we use the previous value function as the
    % starting point of the policyEvaluation algorithm to speed up
    % convergence
    v = policyEvaluation(pi,model,maxit,10^(-10),v);
    
    % The greedy policy associated to v
    pi_ = policyFromV(v,model);
    % Exit early if pi is not changing anymore
    if sum(abs(pi_ - pi)) ==0
        break;
    end
    pi=pi_;
end
i
end

