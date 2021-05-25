% Implements the "in-place" version of the value iteration algorithm
function [v, pi] = valueIteration(model, maxit,tolerance)

% initialize the value function and the policy
v = zeros(model.stateCount, 1);
pi = ones(model.stateCount, 1);
for i = 1:maxit
    % Used for convergence criterion
    v_comparison = v;
    % Perform the Bellman update for each state
    for s = 1:model.stateCount
        Qs=zeros(4,1);
        for a=1:4
            Qs(a)= model.P( s, :, a )* (model.R(s,a)+ model.gamma*v);
        end
        [best_Qs_a,~]=max(Qs);
        v(s)=best_Qs_a;     
    end
    
    % Exit early if v is not changing much anymore
    if max(abs(v-v_comparison))<tolerance
        break;
    end
end
pi=policyFromV(v,model);
% If maxit was very small, the true value function associated to pi
% can be quite different from the function v (which was not a true value function)
% used to define pi. For maxit> ~20, this is superfluous
v=policyEvaluation(pi,model,10000,tolerance,v);
i
end



