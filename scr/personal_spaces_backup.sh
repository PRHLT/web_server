#!/bin/bash

# Temp backup
dest=/tmp/pwb
mkdir ${dest}

# Copy all websites to temp dir
for user in $(ls /home/)
do
    if [ -d /home/${user}/public_html ]
    then
	mkdir ${dest}/${user}
	cp -r /home/${user}/public_html ${dest}/${user}/
    fi
done

# Compress file
tar -czvf /tmp/personal_webs_$(date +%A).tgz ${dest}

# Copy to server
username=username
server=dns
scp /tmp/personal_webs_$(date +%A).tgz ${username}@${server}:web_spaces/

# Remove temp files
rm -rf ${dest} /tmp/personal_webs_$(date +%A).tgz
