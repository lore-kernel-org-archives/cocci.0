From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Thu, 19 May 2016 16:08:53 -0700
Subject: [Cocci] [PATCH v2 0/3] coccinelle: add control flow docs and demos
Message-ID: <1463699336-16151-1-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This v2 addresses the typos and issues from the RFC. This also
adds some "depends on" documentation at the end of the control
flow section as well.

Luis R. Rodriguez (3):
  tests: add test to remove single statement from branch
  demos: add basic series of demos for exists and forall
  coccinelle: add control flow documentation

 demos/exists1.c                    |  20 +++
 demos/exists1.cocci                |   9 ++
 demos/exists1.res                  |  21 +++
 demos/exists2.c                    |  21 +++
 demos/exists2.cocci                |  13 ++
 demos/exists2.res                  |  23 ++++
 demos/exists3.c                    |  21 +++
 demos/exists3.cocci                |  12 ++
 demos/exists3.res                  |  23 ++++
 demos/exists4.c                    |  22 ++++
 demos/exists4.cocci                |  13 ++
 demos/exists4.res                  |  21 +++
 docs/manual/Makefile               |   6 +-
 docs/manual/cocci_syntax.tex       | 257 +++++++++++++++++++++++++++++++++++++
 docs/manual/flow1.c                |  10 ++
 docs/manual/flow2.c                |  11 ++
 tests/remove-code-in-branch1.c     |   7 +
 tests/remove-code-in-branch1.cocci |   4 +
 tests/remove-code-in-branch1.res   |   7 +
 19 files changed, 520 insertions(+), 1 deletion(-)
 create mode 100644 demos/exists1.c
 create mode 100644 demos/exists1.cocci
 create mode 100644 demos/exists1.res
 create mode 100644 demos/exists2.c
 create mode 100644 demos/exists2.cocci
 create mode 100644 demos/exists2.res
 create mode 100644 demos/exists3.c
 create mode 100644 demos/exists3.cocci
 create mode 100644 demos/exists3.res
 create mode 100644 demos/exists4.c
 create mode 100644 demos/exists4.cocci
 create mode 100644 demos/exists4.res
 create mode 100644 docs/manual/flow1.c
 create mode 100644 docs/manual/flow2.c
 create mode 100644 tests/remove-code-in-branch1.c
 create mode 100644 tests/remove-code-in-branch1.cocci
 create mode 100644 tests/remove-code-in-branch1.res

-- 
2.7.2
