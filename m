From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Tue, 21 Jul 2015 13:51:01 -0700
Subject: [Cocci] [PATCH 2/2] autotools: add localversion information
In-Reply-To: <1437511861-2205-1-git-send-email-mcgrof@do-not-panic.com>
References: <1437511861-2205-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <1437511861-2205-3-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

When someone is building Coccinelle from source on a git tree
with some modifications we currently cannot tell what type of
modifications were, if any, were done. Add a localversion info
postix which will be pegged onto the version string *iff* the
git tree used has either a change non-commited  yet or if the
git tree has some commits beyond what was officially released
and tagged.

So if you have a dirty tree with some uncommited changes the
version will be postfixed with -dirty. For example if 1.0.2 was
blessed and released and you had a series of uncommited changes
you'd end yup with:

1.0.2-dirty

Likewise if your tree has some commits not upstream these will be
reflected. For instance, say you had one extra commit, you'd end
up with:

1.0.2-00001-g8870d8b0cf33

The purpose of this is to enable developers and tools within
Coccinelle to be able to tell when folks have modified upstream
code.

The setlocalversion file was take and modified from the Linux
kernel, it was repurposed for Coccinelle by just simplifying it
by hardcoding it to use the long version string if there is any
delta.

Cc: Peter Senna Tschudin <peter.senna@gmail.com>
Cc: Nikolay Orlyuk <virkony@gmail.com>
Cc: S?bastien Hinderer <Sebastien.Hinderer@inria.fr>
Cc: Quentin Lambert <lambert.quentin@gmail.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 scripts/setlocalversion | 77 +++++++++++++++++++++++++++++++++++++++++++++++++
 version.sh              |  3 +-
 2 files changed, 79 insertions(+), 1 deletion(-)
 create mode 100755 scripts/setlocalversion

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
new file mode 100755
index 000000000000..f6b6d9df5ed9
--- /dev/null
+++ b/scripts/setlocalversion
@@ -0,0 +1,77 @@
+#!/bin/sh
+#
+# This scripts adds local version information from the version
+# control systems. It was taken from the Linux kernel as of v4.2-rc2
+# and simplified for use on Coccinelle by mcgrof. The version info
+# was hard coded to use long version. The svn postfix details were
+# also removed.
+
+srctree=.
+
+scm_version()
+{
+	local short
+	short=false
+
+
+	# Check for git and a git repo.
+	if test -z "$(git rev-parse --show-cdup 2>/dev/null)" &&
+	   head=`git rev-parse --verify --short HEAD 2>/dev/null`; then
+
+		# If we are at a tagged commit (like "v2.6.30-rc6"), we ignore
+		# it, because this version is defined in the top level Makefile.
+		if [ -z "`git describe --exact-match 2>/dev/null`" ]; then
+
+			# If only the short version is requested, don't bother
+			# running further git commands
+			if $short; then
+				echo "+"
+				return
+			fi
+			# If we are past a tagged commit (like
+			# "v2.6.30-rc5-302-g72357d5"), we pretty print it.
+			if atag="`git describe 2>/dev/null`"; then
+				echo "$atag" | awk -F- '{printf("-%05d-%s", $(NF-1),$(NF))}'
+
+			# If we don't have a tag at all we print -g{commitish}.
+			else
+				printf '%s%s' -g $head
+			fi
+		fi
+
+		# Check for uncommitted changes
+		if git diff-index --name-only HEAD | grep -qv "^scripts/package"; then
+			printf '%s' -dirty
+		fi
+
+		# All done with git
+		return
+	fi
+
+	# Check for mercurial and a mercurial repo.
+	if test -d .hg && hgid=`hg id 2>/dev/null`; then
+		# Do we have an tagged version?  If so, latesttagdistance == 1
+		if [ "`hg log -r . --template '{latesttagdistance}'`" == "1" ]; then
+			id=`hg log -r . --template '{latesttag}'`
+			printf '%s%s' -hg "$id"
+		else
+			tag=`printf '%s' "$hgid" | cut -d' ' -f2`
+			if [ -z "$tag" -o "$tag" = tip ]; then
+				id=`printf '%s' "$hgid" | sed 's/[+ ].*//'`
+				printf '%s%s' -hg "$id"
+			fi
+		fi
+
+		# Are there uncommitted changes?
+		# These are represented by + after the changeset id.
+		case "$hgid" in
+			*+|*+\ *) printf '%s' -dirty ;;
+		esac
+
+		# All done with mercurial
+		return
+	fi
+}
+
+res="$res$(scm_version)"
+echo "$res"
diff --git a/version.sh b/version.sh
index f18206344a76..a12597c246ca 100755
--- a/version.sh
+++ b/version.sh
@@ -1,3 +1,4 @@
 #!/bin/sh
 VERSION=`cat ./version | tr -d '\n'`
-printf '%s' $VERSION
+LOCALVERSION=`./scripts/setlocalversion | tr -d '\n'`
+printf '%s%s' $VERSION $LOCALVERSION
-- 
2.3.2.209.gd67f9d5.dirty
