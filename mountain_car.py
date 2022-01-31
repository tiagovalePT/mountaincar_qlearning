
from traceback import print_tb
import gym
import numpy as np
import matplotlib.pyplot as plt
from sympy import false


env = gym.make("MountainCar-v0")

## 1) Variáveis globais
DISCRETE_UNITS = 20
NMR_EPISODES = 500
DISCOUNT = 0.98
EPISODE_DISPLAY = 20
LEARNING_RATE = 0.3
EPSILON = 0.05
EPSILON_DECREMENTADOR = EPSILON/(NMR_EPISODES//4)
env._max_episode_steps = 1000

#Environment values
# print(env.observation_space.high)	#[0.6  1.5]
# print(env.observation_space.low)	#[-1.2  -1.5]
# print(env.action_space.n)			#3


#Q-Table de tamanho DISCRETE_UNITS*DISCRETE_BUCKETS*env.action_space.n
#Q_TABLE = np.random.randn(DISCRETE_UNITS,DISCRETE_UNITS,env.action_space.n)

## 2) Criação das tabelas de qualidade -> array com número de tabelas correspondente ao número de estados discretizados
Q_TABLE = np.random.uniform(low = -1, high = 1, 
                          size = (DISCRETE_UNITS, DISCRETE_UNITS, 
                                  env.action_space.n))


## 3) função para calcular o estado em tempo discreto
def discretizar_estado(estado):
	tamanho_janela_discreta = (env.observation_space.high-env.observation_space.low)/[DISCRETE_UNITS]*len(env.observation_space.high)
	estado_discreto = (estado-env.observation_space.low)//tamanho_janela_discreta

	#integer tuple para usar mais tarde na extração dos valores da tabela Q
	return tuple(estado_discreto.astype(int))		


# Para estatisticas
array_it = list()
episodes_list = list()
ep_rewards = []
ep_list = []
x_graph = 0;

iteration = 0
## 4) Inicio do algoritmo
for episode in range(NMR_EPISODES):

	episode_reward = 0
	done = false

	## 5) Discretizar o estado inicial
	estado_discreto_atual = discretizar_estado(env.reset())
	# print(estado_discreto_atual)

	# calcular estado para renderizar o simulador
	if episode % EPISODE_DISPLAY == 0:
		render_state = True
	else:
		render_state = False

	## 6) Ciclo que percorre as interações dentro de cada episódio
	while not done:

		# contar o número de iterações necessárias para atingir o objetivo
		iteration+=1

		## 7) condição para gerar uma ação random, para a ação do agente não ficar enviesada
		if np.random.random() > EPSILON:
			action = np.argmax(Q_TABLE[estado_discreto_atual])
		else:
			action = np.random.randint(0, env.action_space.n)
		
		## 8) outputs do ambiente em função das ações do agente
		novo_estado, reward, done, _ = env.step(action)

		## 9) novo estado discreto
		novo_estado_discreto = discretizar_estado(novo_estado)

		# renderização do simulador
		if render_state:
			env.render()

		## 9) Verificação se a ação já foi tomada
		if not done:
			## 10) cálculo da nova matriz Q 
			max_future_q = np.max(Q_TABLE[novo_estado_discreto])
			current_q = Q_TABLE[estado_discreto_atual+(action,)]
			new_q = current_q + LEARNING_RATE*(reward + DISCOUNT*max_future_q - current_q)
			Q_TABLE[estado_discreto_atual+(action,)]=new_q

		## 11) Verificar se o agente chegou à posição objetivo
		elif novo_estado[0] >= env.goal_position:
			# atualização da matriz Q, quando o agente chega ao objetivo
			# if Q_TABLE[estado_discreto_atual + (action,)] == 0:
			# 	print(episode)

			Q_TABLE[estado_discreto_atual + (action,)] = 0

			# estatisticas para o gráfico
			x_graph += 1
			array_it.append(iteration)
			episodes_list.append(x_graph)
			iteration = 0
		
		## 12) atualização do esatdo discreto, para calcular a ação no inicio da nova iteração
		estado_discreto_atual = novo_estado_discreto
		episode_reward += reward

	## 13) cálculo do novo epsilon
	EPSILON = EPSILON - EPSILON_DECREMENTADOR

	ep_rewards.append(episode_reward)
	ep_list.append(episode)

	if not episode % EPISODE_DISPLAY:
		avg_reward = sum(ep_rewards[-EPISODE_DISPLAY:])/len(ep_rewards[-EPISODE_DISPLAY:])	
		print(f"Episode:{episode} avg:{avg_reward} min:{min(ep_rewards[-EPISODE_DISPLAY:])} max:{max(ep_rewards[-EPISODE_DISPLAY:])}")

env.close()


# plt.plot(ep_list, ep_rewards) 
# plt.title('Mountain Car Q-Learning')
# plt.ylabel('Average reward/Episode')
# plt.xlabel('Episodes')
# plt.show()

plt.plot(np.array(episodes_list), np.array(array_it))
plt.title('Learning Trial')
plt.ylabel('Performance')
plt.xlabel('Trials')
plt.show()