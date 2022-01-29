function out = calcoutput(x)
%calcoutput:  y = calcoutput(x)  or  calcoutput(x)
%  If output is requested, then hidden and output layer values not
%  stored in agent.
global agent

x(2) = x(2);

h = exp(- sum((x' * ones(1,size(agent.wh,2)) - ...
    agent.wh).^2) * agent.sigma);  

out = [h 1] * agent.wo;
  
if nargout == 0
  agent.x = x;
  agent.h = h;
  agent.p = out;
end
  



