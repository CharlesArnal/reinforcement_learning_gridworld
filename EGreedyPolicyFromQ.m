% yields the greedy policy pi associated to Q (assuming
% that Q is a proper state-action value function)
function piEpsilon = EGreedyPolicyFromQ(Q,epsilon)
    piEpsilon = epsilon/4*ones(size(Q,1), 4);
    for s=1:size(Q,1)
        [~,best_a]=max(Q(s,:));
        piEpsilon(s,best_a)=piEpsilon(s,best_a)+1-epsilon;
    end
end