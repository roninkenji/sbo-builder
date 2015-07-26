#!/bin/bash

if [ ! -f /srv/sbopkg/config ]; then
  cat <<EOF > /srv/sbopkg/config
# $Id: sbopkg.conf 922 2013-12-09 02:11:01Z chess.griffin@gmail.com $
#
# Please read the sbopkg.conf(5) man page for information about this
# configuration file, including an explanation of how to set these
# variables.

# The following variables are used by sbopkg and by the SlackBuild
# scripts themselves.  They must be exported for this reason.
# $Id: sbopkg.conf 922 2013-12-09 02:11:01Z chess.griffin@gmail.com $
#
# Please read the sbopkg.conf(5) man page for information about this
# configuration file, including an explanation of how to set these
# variables.

# The following variables are used by sbopkg and by the SlackBuild
# scripts themselves.  They must be exported for this reason.
export TMP=${TMP:-/srv/sbopkg/build}
export OUTPUT=${OUTPUT:-/srv/sbopkg/output}

# The following are variables used by sbopkg.  Any of these variables
# could be exported, if desired.

# Path variables
LOGFILE=${LOGFILE:-/srv/sbopkg/sbopkg-build-log}
QUEUEDIR=${QUEUEDIR:-/srv/sbopkg/queue}
REPO_ROOT=${REPO_ROOT:-/srv/sbopkg/repo}
SRCDIR=${SRCDIR:-/srv/sbopkg/src}
# sbopkg's temporary directory (where its internal temporary files are
# kept and where packages are made prior to being moved to OUTPUT)
# defaults to /tmp/sbopkg.XXXXXX where 'XXXXXX' is a random string. If
# /tmp is not a suitable containing directory, pass in an alternate
# TMPDIR or modify the following variable. This is actually a mktemp(1)
# variable.
export TMPDIR=${TMPDIR:-/tmp}

# Other variables:
CLEANUP=${CLEANUP:-NO}
DEBUG_UPDATES=${DEBUG_UPDATES:-0}
KEEPLOG=${KEEPLOG:-YES}
MKDIR_PROMPT=${MKDIR_PROMPT:-YES}
NICE=${NICE:-10}
REPO_BRANCH=${REPO_BRANCH:-14.1}
REPO_NAME=${REPO_NAME:-SBo}

# The following variable determines if multiple instances of sbopkg can
# be run simultaneously. It is *strongly* recommended that this value be
# set to NO. Do not set it to YES without first reading the
# sbopkg.conf(5) man page.
ALLOW_MULTI=${ALLOW_MULTI:-NO}

# The following variables are required and can be tweaked if desired,
# although this is not recommended.  Note:  rsync already uses
# --archive, --delete, --no-owner, and --exclude in the main sbopkg
# script so there is no need to add those flags here.
DIFF=${DIFF:-diff}
DIFFOPTS=${DIFFOPTS:--u}
RSYNCFLAGS="${RSYNCFLAGS:---verbose --timeout=30}"
WGETFLAGS="${WGETFLAGS:--c --progress=bar:force --timeout=30 --tries=5}"

EOF
fi

mkdir -p /srv/sbopkg/repo/SBo/14.1 /srv/sbopkg/queue /srv/sbopkg/build /srv/sbopkg/output /srv/sbopkg/src

/usr/sbin/sbopkg -f /srv/sbopkg/config "$@"

