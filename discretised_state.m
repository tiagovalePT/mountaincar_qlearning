function discretised_state(state)


    DISCRETE_WIN_SIZE = (agent.maxinput(1) - agent.mininput(1)) / env.discrete_buckets * size(agent.maxinput,2);
    discrete_state = fix((state - agent.mininput(1)) / DISCRETE_WIN_SIZE);

    
    return discrete_state
end