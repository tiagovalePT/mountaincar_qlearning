function st = discretised_state(state)

    global env agent sim

%     DISCRETE_WIN_SIZE = (env.observation_space.high-env.observation_space.low)/[DISCRETE_BUCKETS]*len(env.observation_space.high)
% 	discrete_state = (state-env.observation_space.low)//DISCRETE_WIN_SIZE
% 	return tuple(discrete_state.astype(np.int))
% agent.mininput(1)
% agent.maxninput(1)

% discretised_state([1 0])

% agent.maxinput = [0.5 1.5];
% agent.mininput = [-1.2 -1.5];
% env.discrete_buckets = 20;

    DISCRETE_WIN_SIZE = (agent.maxinput - agent.mininput) / [env.discrete_buckets] * size(agent.maxinput,2);  % verificar o porquê do x2
    discrete_state = fix((state - agent.mininput) ./ DISCRETE_WIN_SIZE);
    

    st = discrete_state;
end