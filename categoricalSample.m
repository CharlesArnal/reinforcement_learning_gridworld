% Samples from a categorical distribution defined by a
% (potentially unnormalized) vector of probabilities
function a = categoricalSample(probas)
x = sum(probas)*rand();
a = 1;
t = probas(1);
while t < x
  a = a+1;
  t = t+probas(a);
end
end
