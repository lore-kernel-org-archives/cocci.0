From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Tue, 14 Jun 2016 15:10:13 -0700
Subject: [Cocci] [PATCH 0/4] scripts: add basic python version library and
	use it
Message-ID: <1465942217-14452-1-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This series depends on the last set of coccicheck enhancements which
add parmap support and indexing heuristics.

Coccinelle SmPL files may often require advanced grammar techniques not
available in older versions of Coccinelle. We can use --parse-cocci and
bail if a file does not parse, however this doesn't tell us anything about
requirements. An alternative approach is to specifically do a check for
a version of coccinelle.

Since checking for versions can be generic we can just write a python
library to do these sorts of checks for us, this allows us to provide
a generic kernel library for version checks for any binary. This adds
that and then makes use of it as an example within a coccinelle SmPL
file which require a later version of coccinelle.

Luis R. Rodriguez (4):
  coccicheck: propagate error and stop processing after first error
  scripts: add reqs python library
  coccicheck: enable use of the kernel's python library
  scripts/coccinelle: require coccinelle >= 1.0.4 on
    device_node_continue.cocci

 MAINTAINERS                                        |   1 +
 scripts/coccicheck                                 |   7 +
 .../iterators/device_node_continue.cocci           |  13 ++
 scripts/lib/__init__.py                            |   1 +
 scripts/lib/reqs.py                                | 211 +++++++++++++++++++++
 5 files changed, 233 insertions(+)
 create mode 100644 scripts/lib/__init__.py
 create mode 100644 scripts/lib/reqs.py

-- 
2.8.2
