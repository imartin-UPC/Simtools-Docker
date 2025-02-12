#!/bin/bash

sudo sed -i 's/root_fs_tutorial/debian6.fs/g' /usr/share/vnuml/scenarios/switching-vlan.vnuml
sudo sed -i 's/linux/linux-3.3.8/g' /usr/share/vnuml/scenarios/switching-vlan.vnuml
sudo sed -i 's/from scapy import/from scapy.all import/g' /usr/share/vnuml/scenarios/files/switching/tmp/client-chat-LLC1.py
sudo sed -i 's/from scapy import/from scapy.all import/g' /usr/share/vnuml/scenarios/files/switching/tmp/server-chat-LLC1.py
sudo sed -i 's/from scapy import/from scapy.all import/g' /usr/share/vnuml/scenarios/files/switching/tmp/send-frame-LLC1.py
