function startsim()

global env agent sim

def discretised_state(state):
	DISCRETE_WIN_SIZE = (env.observation_space.high-env.observation_space.low)/[DISCRETE_BUCKETS]*len(env.observation_space.high)
	discrete_state = (state-env.observation_space.low)//DISCRETE_WIN_SIZE
	return tuple(discrete_state.astype(np.int))

DISCRETE_WIN_SIZE = (agent.maxinput(1) - agent.mininput(1)) / env.discrete_buckets * size(agent.maxinput,2);
discrete_state = fix((state - agent.mininput(1)) / DISCRETE_WIN_SIZE);

return 


agent.mininput(1)
agent.maxninput(1)

sim.running = 1;

while sim.running

  sim.trial = sim.trial + 1;
  
  % Meter agent a 0's
  %initagenttrial;
  sim.step = 0;
  env.r = -1;
  
  % Escolhe uma posição (x) aleatório entre 0 e 0.5
  initstate;
    
  % Gerar quality matrixes
  q = randn(env.discrete_buckets, 3, env.discrete_buckets);
  
  while (env.r ~= 0) & sim.running,
    sim.step = sim.step + 1;
    
    % Primeira Iteração
    if sim.step == 1
      % Calcular output
      calcoutput(env.state);

      % Primeira ação
      agent.action = policy(agent.p);
    end

    updateelig;

    %    oldp = p;
    %a    oldx = x;
    %  oldaction = action;
    %    if debug, oldx, oldaction, oldp, h, ewh, ewo, end
   
    % Gerar a próxima posição (estado)
    env.state = nextstate(agent.action);

    if env.display,
      h = findobj('Tag','car');
      showenv(h);
    end

    if env.state(1) < 0.5 %reward function
      env.r = -1;
      p = calcoutput(env.state);	% without saving hidden and output outputs in struct % Calculate Outputs
      action = policy(p);   %rand < epsilon: action = ceil(rand*3)
      error = env.r + agent.gamma * p(action) - agent.p(agent.action);
    else
      env.r = 0;
      error = env.r - agent.p(agent.action);
    end
    errorVector = zeros(1,agent.no);
    errorVector(agent.action) = error;

    updateweights(errorVector);
    
    calcoutput(env.state);
    agent.action = action;  %sarsa.  Use action already chosen for this state

    drawnow;				% to handle all gui events

  end					% end of one trial

  if sim.running,

    sim.perf(sim.trial) = sim.step;

    if agent.displaysurf & rem(sim.trial,agent.displaysurfrate) == 0,
      a = findobj('Tag','agentsurfaxis');
      axes(a);
      plotQ(20);
      set(a,'Tag','agentsurfaxis');
    end

    if agent.displayrbfs & rem(sim.trial,agent.displayrbfsrate) == 0,
      a = findobj('Tag','agentrbfsaxis');
      axes(a);
      plotrbfs;
      set(a,'Tag','agentrbfsaxis');
    end

    if sim.display & rem(sim.trial,sim.displayrate) == 0,
      a = findobj('Tag','simperfaxis');
      axes(a);
      showperf;
%      set(a,'Tag','simperfaxis');
    end

    drawnow;
    
  end

end

