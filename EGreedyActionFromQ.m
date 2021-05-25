% yields the Epsilon-greedy action associated to action-state function
% Q(s,-)
% Qs should be a vector of size 4
function a = EGreedyActionFromQ(Qs,epsilon)
    probas=epsilon/4*ones(4,1);
    [~,best_a]=max(Qs);
    probas(best_a)=probas(best_a)+1-epsilon;
    a=categoricalSample(probas);
end