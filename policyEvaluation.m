% Computes iteratively the value function associated to the provided policy
% using the "in-place" algorithm
% Works for both deterministic and non-deterministic policies
function v = policyEvaluation(pi,model,maxit,tolerance,varargin)
% The last optional argument is meant to be a value function
% to be used as a starting point by the algorithm
if nargin == 5
    v= varargin{1};
else
    % otherwise, initialise v trivially
    v = zeros(model.stateCount, 1);
end
for i = 1:maxit
    % used to test convergence
    v_comparison=v;
    % tests whether pi is deterministic or not, updates it accordingly
    % using the Bellman update
    if size(pi,2)==1
        for s = 1:model.stateCount
            v(s)= model.P( s, :, pi(s) )* (model.R(s,pi(s))+ model.gamma*v);
        end
    else
        for s = 1:model.stateCount
            v_(s)=0;
            for a = 1:4
                v_(s)=v_(s) + pi(s,a)*model.P( s, :, a)* (model.R(s,a)+ model.gamma*v);
            end
            v(s)=v_(s);
        end
    end
    % exit early if v is not changing much anymore
    if max(abs(v_comparison-v))<tolerance
        break;
    end
end

end