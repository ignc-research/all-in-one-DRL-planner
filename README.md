# All-in-one Planner: A DRL-based Control Switch
This repository contains the code for the paper [All-in-One: A DRL-based Control Switch Combining State-of-the-art Navigation Planners](https://arxiv.org/pdf/2109.11636.pdf). The All-In-One Planner (AIO) chooses from a given list of local planners in each iteration with the objective to combine the strengths of learning-based planners and classical planners like TEB / MPC. The AIO planner is developed on top of the navigation framework [arena-rosnav](https://github.com/ignc-research/arena-rosnav).

The repository provides:
* A framework to integrate local planning algorihtms with ROS
* An OpenAI gym env for training of a DRL agent to learn switching between different planners based on sensor observations
* Evaluation files for different maps
The evaluation environments were createed with our open source project [arena-tools](https://github.com/ignc-research/arena-tools), which lets you create a variety of static and dynamic indoor and outdoor scenarios.

<p align="center">
 <img width="800" height="400" src="/videos/git/9b1a44e50f1d82027578431aaa09df6425371531.gif"> 
<p>
  
# Installation
* Install arena-rosnav first using the [install guide](docs/Installation.md)
 
* Install ZeroMQ

```bash
workon rosnav
pip install pyzmq
```
* Adapt flatland for training with multiple maps:
Open "/catkin_ws/src/forks/flatland/flatland_server/src/simulation_manager.cpp" and change in line 126
```c++
ros::NodeHandle n("");
```
to
```c++
ros::NodeHandle n("~");
```

* Then open "/catkin_ws/src/forks/flatland/flatland_server/src/flatland_server_node.cpp" and change line 83-93 to
```c++
if (!node_handle.getParam("world_path", world_path)) {
    ROS_FATAL_NAMED("Node", "No world_path parameter given!");
    ros::shutdown();
    return 1;
  }
  std::string map_layer_path;

  node_handle.getParam("map_layer_path", map_layer_path);

  std::string map_file;
  node_handle.getParam("map_file", map_file);
```

# Training an agent
1. In the first terminal execute
```bash
workon rosnav
roslaunch arena_bringup start_training.launch num_envs:=$num_envs
```
2. In a second terminal execute
```bash
workon rosnav
roscd arena_local_planner_drl/
```
and then
```bash
python3 scripts/training/train_all_in_one_agent.py --agent AGENT_13 --n_envs $num_envs --tb --eval_log --agent_name all_in_one_teb_rlca_drl4_rule03_policy13 --all_in_one_config all_in_one_default.json
```
* --tb enables tensorboard logging (tensorboard needs to be installed)
* --eval_log enables saving the evaluation episode results to a seperate file.
* --agent needs to specify a neural network architecture for a new agent. You can select from the architectures defined in ~/arena-rosnav/arena_navigation/arena_local_planner/learning_based/arena_local_planner_drl/scripts/custom_policy.py that is 'MLP_ARENA2D' or 'AGENT_x' with x in [1,20].
* --load defines wether to load an already trained agent (and continue training) or to create a new one
* --agent_name defines the name / version of an all_in_one_planner. If load is set this has to match an all-in-one agent in ~/arena-rosnav/arena_navigation/arena_local_planner/learning_based/arena_local_planner_drl/agents
* --all_in_one_config specifies the name of the config file placed in /arena-rosnav/arena_navigation/arena_local_planner/learning_based/arena_local_planner_drl/configs/all_in_one_hyperparameters/. Here the local planners can be specified (currently rlca, drl agents, a move base planner (not recommended) and teb). If
```bash
"run_all_agents_each_iteration": true
```
all local planners are executed in each iteration and their velocity commands are part of the observation space. If it is set to false only the selected local planner will be executed in each iteration.

3. To visualize the training execute
```bash
roslaunch arena_bringup visualization_training.launch use_rviz:=true rviz_file:=allinone_train
```

# Evaluate agents
1. Start ros
```bash
workon rosnav
roslaunch arena_bringup start_training.launch num_envs:=1
```
2. Start all in one planner.
```bash
workon rosnav
roscd arena_local_planner_drl/
python3 scripts/training/evaluate_all_in_one_agent.py
```
The agents which should be evaluated are specified in the evaluate_all_in_one_agent.py file (line 13-14). As benchmark there are "random", "rlca_only", "teb_only" and "drl_only". The results are stored at /arena-rosnav/arena_navigation/arena_local_planner/learning_based/arena_local_planner_drl/evaluation_logs.
3. To visualize
```bash
roslaunch arena_bringup visualization_training.launch use_rviz:=true ns:=eval_sim rviz_file:=allinone_evalsim
```
