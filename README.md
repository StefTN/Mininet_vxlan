# Mininet_vxlan
git clone https://github.com/StefTN/Mininet_vxlan.git
cd Mininet_vxlan
vagrant up /^mininet*/
ssh to a jumphost (any linux_desktop VM that connects to Host-Only Network 192.168.56.x)
copy "windows.tmux.mininet" in .byobu folder on jumphost
from jumphost run "BYOBU_WINDOWS=mininet byobu"
