function newstate = nextstate(action)
global env mm agent

%x = env.state(1) + 0.1 * env.state(2);
%xd = env.state(2) + 0.1 * (0.01 * (action-2) - 0.025 * cos(3*env.state(1));

x = env.state(1);
xdot = env.state(2);

%action = 3;

newx = x + env.deltaT * xdot;
newxdot = xdot + env.deltaT * (-9.8 * env.mass * cos(3 * x) + ...
    env.force / env.mass * (action-2) - env.friction * xdot);

% Pico -> velocidade a 0
if newx < agent.mininput(1)
  newx = agent.mininput(1);
  newxdot = 0.;
end

%mm = [mm; newx newxdot action];

if newxdot < agent.mininput(2)
 newxdot = agent.mininput(2);
elseif newxdot > agent.maxinput(2)
 newxdot = agent.maxinput(2);
end

newstate = [newx newxdot];
  
