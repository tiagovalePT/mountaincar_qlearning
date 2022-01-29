%function startsim()

clear
clc

global env agent sim

%%% ELIMINAR DEPOIS
env.discrete_buckets = 40;
agent.epsilon = 0.5;
agent.maxinput = [0.5 0.05];
agent.mininput = [-1.2 -0.05];
agent.LEARNING_RATE = 0.1;
agent.DISCOUNT = 0.95;
env.reward = -1;
agent.goal = 0.5;
env.nr_episodios = 30000;
env.nr_it = 200;
count_ep = 0;
env.mass = 0.2;				% mass of car
env.force = 0.2;			% force of each push
env.friction = 0.5;			% coefficient of friction
env.deltaT = 0.1;			% time step for integration



%%%
sim.running = 1;

while (sim.running & count_ep < env.nr_episodios)

    sim.trial = sim.trial + 1;
    
    % Inicializar a reward do episódio
    env.episode_reward = 0;
      
    % Meter agent a 0's
    %initagenttrial;
    sim.step = 0;
    env.r = -1;

    % Escolhe uma posição (x) aleatório entre 0 e 0.5
    initstate;
        
    % Gerar quality matrixes
    q = randn(env.discrete_buckets, 3, env.discrete_buckets);

    counter = 0;

    while (env.r ~= 0 & sim.running & counter < env.nr_it)
        sim.step = sim.step + 1;
    
        
        % Epsilon-greedy action
        if rand < agent.epsilon
            agent.action = randi([1 3]);
        else
            disc_aux = discretised_state(env.state);
            q_aux = q(disc_aux(2)+1, :, disc_aux(1)+1);
            [q_min, agent.action] = max(q_aux);
        end

        
        % Próximo estado + descritização do estado
        env.new_state = nextstate(agent.action);
        env.new_discrete_state = discretised_state(env.new_state);
        
        % Maximo q do próximo passo
        q_aux = q(env.new_discrete_state(2)+1, : , env.new_discrete_state(1)+1);
        max_future_q = max(q_aux);
        
        % Verificar se já chegamos ao objetivo
        if env.new_state(1) >= 0.5
            q(env.new_discrete_state(2)+1, agent.action , env.new_discrete_state(1)+1) = 0;
            env.r = 0;
            disp('CHEGUEI FDP: ')
            disp(count_ep)
        else
            % Atualizar o valor de q consoante a nossa ação
            current_q = q(env.new_discrete_state(2)+1, agent.action , env.new_discrete_state(1)+1);
            new_q = current_q + agent.LEARNING_RATE * (env.reward + agent.DISCOUNT * max_future_q - current_q);
            q(env.new_discrete_state(2)+1, agent.action , env.new_discrete_state(1)+1) = new_q;
        end
        

        % Passar para o próximo estado
        env.state = env.new_state;
        %env.episode_reward = env.episode_reward +1;
        %disp(['RUN ONCE:', env.state]);
        %disp(env.state);
        counter = counter + 1;
    end

    count_ep = count_ep + +1;
    
    
    
end



%end