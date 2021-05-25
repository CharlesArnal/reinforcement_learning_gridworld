% yields the greedy policy pi associated to Q (assuming
% that Q is a proper state-action value function)
function pi = greedyPolicyFromQ(Q)
    pi = ones(size(Q,1), 1);
    for s=1:size(Q,1)
        [~,best_a]=max(Q(s,:));
        pi(s)=best_a;
    end
end