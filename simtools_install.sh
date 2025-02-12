guides_path="./install_guides"
files_path="./files"
bin_path="/usr/local/bin"
current_path=`pwd`
version=1.3.1

# Create and run the container as a daemon.
# To run simctl commands type: simctl [options]
sudo docker run -d -it --device /dev/net/tun --name=simtools --cap-add=NET_ADMIN --network=host --ipc=host israelmartinescalona/simtools:$version /bin/bash

echo "Copying required files to the system..."

# Copy the profile in the case konsole is available
check=`ls /usr/bin | grep konsole`
if [ ! -z "$check" ]; then
	mkdir -p ~/.local/share/konsole/ &> /dev/null
	cp "$files_path/profiles/simtools.profile" ~/.local/share/konsole/ &> /dev/null
fi

# Copy the command simtools-captap so run several wiresharks in the host at once.
sudo docker cp simtools:/usr/local/bin/simtools-captap "$bin_path/simtools-captap"
sudo chmod +x "$bin_path/simtools-captap"
sudo docker cp simtools:/usr/local/share/doc/simtools/screenrc.user ~/.screenrc

# Copy the binaries (simctl wrapper) to the system and setting the right permissions
sudo cp -f "$files_path/bin/simctl" "$bin_path/simctl" &> /dev/null
sudo chmod +x "$bin_path/simctl" &> /dev/null

echo "Done!"
