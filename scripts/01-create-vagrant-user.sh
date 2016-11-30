#!/usr/bin/env bash
#
# Create the vagrant user and configure

echo "Creating the vagrant user and setting up required options..."

# Create the required group
groupadd --gid 1000 vagrant

# Create the user
useradd --create-home --uid 1000 --gid 1000 \
        --groups wheel --shell /bin/bash \
        --comment "Vagrant User" vagrant

# Configure authorised ssh keys
SSH_DIR="/home/vagrant/.ssh"
# WARNING: Uses the insecure Vagrant key
VAGRANT_SSH_AUTHORISED_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key"
[[ -d ${SSH_DIR} ]] || mkdir ${SSH_DIR}
chmod 700 ${SSH_DIR}
echo ${VAGRANT_SSH_AUTHORISED_KEY} > ${SSH_DIR}/authorized_keys
chmod 600 ${SSH_DIR}/authorized_keys
chown -R vagrant:vagrant ${SSH_DIR}

# Configure password-less sudo for the vagrant user
SUDOERS_USER="/etc/sudoers.d/vagrant-user"
cat <<EOF > ${SUDOERS_USER}
# Allow vagrant user to run commands as root without providing a password
vagrant  ALL=(ALL)  NOPASSWD: ALL
EOF
chmod 0440 ${SUDOERS_USER}

echo "Complete"

exit 0
