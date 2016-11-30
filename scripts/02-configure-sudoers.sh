#!/usr/bin/env bash
#
# Configure settings for sudo

# Logging for packer
echo "Disabling requirement for TTY with sudo commands..."


# Although this setting will be overridden by the file created below it's
# still nice to show users this setting is disabled in the main sudoers
# file
sed -i '/^Defaults .*requiretty/ s/^/# /g' /etc/sudoers


# Allowing sudo commands to run without a TTY is a requirement for vagrant
SUDOERS_NOREQTTY="/etc/sudoers.d/no-requiretty"
cat <<EOF > ${SUDOERS_NOREQTTY}
# Disable the requirement for a TTY with sudo see:
# https://bugzilla.redhat.com/show_bug.cgi?id=1020147
Defaults !requiretty
EOF
chmod 0440 ${SUDOERS_NOREQTTY}

exit 0
