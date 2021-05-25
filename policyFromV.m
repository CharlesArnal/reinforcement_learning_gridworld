% yields the greedy policy pi associated to the value function v (assuming
% that v is a proper value function)
function pi = policyFromV(v,model)
    pi = ones(model.stateCount, 1);
    for s=1:model.stateCount
        Qs=zeros(4,1);
        for a=1:4
            % Q(s,a) of the policy being defined
            Qs(a)= model.P( s, :, a )* (model.R(s,a)+ model.gamma*v);
        end
        [~,best_a]=max(Qs);
        pi(s)=best_a;
    end
end