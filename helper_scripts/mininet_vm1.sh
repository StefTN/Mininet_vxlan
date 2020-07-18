#!/bin/bash

echo "################################################"
echo "  Running Mininet_VM Setup (mininet_vm1.sh)..."
echo "################################################"
echo " Detected vagrant user is: $username"

echo " ### Creating mininet python topology (including vxlan ovs tunnels) ###"
mkdir -p /home/vagrant/mininet_topology
cat <<EOT > /home/vagrant/mininet_topology/vxlan.py
"""Custom topology example

Two directly connected switches plus a host for each switch:

   host --- switch --- switch --- host

Adding the 'topos' dict with a key/value pair to generate our newly defined
topology enables one to pass in '--topo=mytopo' from the command line.
"""
from mininet.cli import CLI
from mininet.net import Mininet
from mininet.topo import Topo
from mininet.util import dumpNodeConnections
from mininet.log import setLogLevel
from subprocess import call
import os

class MyTopo( Topo ):
    "Simple topology example."

    def __init__( self ):
        "Create custom topo."

        # Initialize topology
        Topo.__init__( self )

        # Add hosts and switches
        redHost = self.addHost( 'red1', ip='10.0.0.1/8', mac='00:00:00:00:00:01' )
        blueHost = self.addHost( 'blue1', ip='10.0.0.1/8', mac='00:00:00:00:00:01' )
        centralSwitch = self.addSwitch( 's1' )

        # Add links
        self.addLink( redHost, centralSwitch )
        self.addLink( centralSwitch, blueHost )

setLogLevel('info')
net = Mininet( topo=MyTopo( ) )
#dumpNodeConnections(net.hosts)
net.start()

call('ovs-vsctl add-port s1 vtep -- set interface vtep type=vxlan option:remote_ip=192.168.56.92 option:key=flow ofport_request=10', shell=True)
call('ovs-vsctl add-port s1 vtep1 -- set interface vtep1 type=vxlan option:remote_ip=192.168.56.93 option:key=flow ofport_request=11', shell=True)
os.system("ovs-ofctl add-flows s1 '/home/vagrant/mininet_topology/flows.txt'")

CLI( net )
net.stop()

EOT

echo " ### Adding OF flows to a text file ###"
mkdir -p /home/vagrant/mininet_topology
cat <<EOT > /home/vagrant/mininet_topology/flows.txt
table=0,in_port=1,actions=set_field:100->tun_id,resubmit(,1)
table=0,in_port=2,actions=set_field:200->tun_id,resubmit(,1)
table=0,actions=resubmit(,1)

table=1,tun_id=100,dl_dst=00:00:00:00:00:01,actions=output:1
table=1,tun_id=200,dl_dst=00:00:00:00:00:01,actions=output:2
table=1,tun_id=100,dl_dst=00:00:00:00:00:02,actions=output:10
table=1,tun_id=200,dl_dst=00:00:00:00:00:02,actions=output:10
table=1,tun_id=100,dl_dst=00:00:00:00:00:03,actions=output:11
table=1,tun_id=200,dl_dst=00:00:00:00:00:03,actions=output:11
table=1,tun_id=100,arp,nw_dst=10.0.0.1,actions=output:1
table=1,tun_id=200,arp,nw_dst=10.0.0.1,actions=output:2
table=1,tun_id=100,arp,nw_dst=10.0.0.2,actions=output:10
table=1,tun_id=200,arp,nw_dst=10.0.0.2,actions=output:10
table=1,tun_id=100,arp,nw_dst=10.0.0.3,actions=output:11
table=1,tun_id=200,arp,nw_dst=10.0.0.3,actions=output:11
table=1,priority=100,actions=drop
EOT

echo "############################################"
echo "      DONE!"
echo "############################################"