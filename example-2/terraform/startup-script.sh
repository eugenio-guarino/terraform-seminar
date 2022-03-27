#!/bin/bash
bash
sudo su

# Install Cloud Storage Fuse
export GCSFUSE_REPO=gcsfuse-`lsb_release -c -s`
echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" | sudo tee /etc/apt/sources.list.d/gcsfuse.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
apt-get update
apt-get install gcsfuse

# Mount bucket using Fuse
mkdir /bucket
echo 'project /bucket gcsfuse rw,gid=33,uid=33,auto,user,implicit_dirs,allow_other,_netdev' >> /etc/fstab
mount /bucket
export LINE_TO_UNCOMMENT=user_allow_other
sed -i "/^#$LINE_TO_UNCOMMENT/ c$LINE_TO_UNCOMMENT" /etc/fuse.conf