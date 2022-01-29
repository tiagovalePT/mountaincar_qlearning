%% Mountain Car Problem Using Q-learning Algorithm
% *Authors:* Tiago Vale - up201704630
%            João Santos - up
%            João Sousa - up
%            Gabriel Outeiro - up

clc;
close all;

%% Starting Params

initial_lr = 1.0;    %Learning Rate
min_lr = 0.003;      % Minimum Learning Rate
gamma = 0.9;
eps = 0.02;

n_states = 5;
iter_max = 1000;

% * Goal
goal = 0.6;


%% Creating Reward Matrix
% Possible actions are:
% -1 = when the goal is not reached
% 10 = goal is reached

%reward = -1;
%qSize = 50;


%% Q learning Algorithm

%q = randn(size(reward));
q = zeros(n_states, 3, n_states);

% Repeats for the amount of steps
for x = 1:n_states

    % Starting from start position    
    pos = 0;
    total_reward = 0;

    %learning rate is decreased at each step
    %eta = max(min_lr, initial_lr * (0.85 * (i//100)))

    % Repeat until Goal state is reached
    while(1)
    
    % Get position and velocity
    %a, b = obs_to_state(env, obs)

    % Epsilon-greedy action
    if rand(1) < eps
       action = randi([1 3]);
    else
        action = max(Q[discretised_state(state)]);
    end
    
    % choose an action at random and set it as the next state
    ns = randi([1 3]);

    n_actions = 3;

    % find the maximum q-value i.e, next state with best action
    max_q = 0;
    for j=1:length(n_actions)
        max_q = max(max_q,q(ns,j));
    end

    % Update q-values as per Bellman's equation
    q(cs, ns) = reward + gamma * max_q

    if(cs == goal)
        break;
    end

    % Set current state as next state
    cs=ns;

    %receive next state and reward
    %new_state = 
    %reward = 
    %done =

    end
end

