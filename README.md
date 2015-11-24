This script allows the user to connect to a ROS network
through MATLAB and interact with it by publishing
messages on various topics.
This script is known to work with *MATLAB 2015a* and *ROS indigo*

Troubleshooting:

* In case the script complains when connecting to the ROS
  master, try changing `rosinit('localhost', 11311)` to your
  machine defaults
