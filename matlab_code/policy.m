function act = policy(p)
global agent

[junk,action] = max(p);
if rand < agent.epsilon
  action = ceil(rand*3);
end
act = action;
%acts = [acts action];
  
