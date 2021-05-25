% Picks a as follows: 
% Draw a Bernoulli r.v. equal to 1 with probability 1-epsilon.
% If it's one, let a= argmax Q(s,-)
% If not, draw a Bernoulli r.v. equal to 1 with probability 3/4.
% If it's one, let a = argmin Q_number_visits(s,-),
% i.e. choose the action that has been chosen least
% If not, choose an action with uniform probability among the 4 possible
function a = modifiedEGreedyActionFromQ(Qs,Qs_number_visits,epsilon)
    probas=epsilon/16*ones(4,1);
    [~,best_a]=max(Qs);
    probas(best_a)=probas(best_a)+1-epsilon;
    [~,least_visited_a]=min(Qs_number_visits);
    probas(least_visited_a)=probas(least_visited_a)+3/4*epsilon;
    a=categoricalSample(probas);
end