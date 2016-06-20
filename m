From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Mon, 20 Jun 2016 14:54:05 -0700
Subject: [Cocci] [PATCH v2 0/3] coccinelle: expand docs
Message-ID: <1466459648-17477-1-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This v2 modifies the ++ demo and documentation to something
a bit more safe for its use, and while at it decided to extend
the iteration documentation and document support for .cocciconfig.

Luis R. Rodriguez (3):
  docs/demos: add a few ++ documentation and demos
  docs/manual/cocci_syntax.tex: extend with python iteration
  docs: document .cocciconfig

 demos/plusplus1.c            |   4 +
 demos/plusplus1.cocci        |  17 +++++
 demos/plusplus1.res          |   5 ++
 demos/plusplus2.c            |   7 ++
 demos/plusplus2.cocci        |  26 +++++++
 demos/plusplus2.res          |  10 +++
 docs/manual/cocci_syntax.tex | 169 ++++++++++++++++++++++++++++++++++++++++---
 docs/spatch.1.in             |  32 +++++++-
 8 files changed, 258 insertions(+), 12 deletions(-)
 create mode 100644 demos/plusplus1.c
 create mode 100644 demos/plusplus1.cocci
 create mode 100644 demos/plusplus1.res
 create mode 100644 demos/plusplus2.c
 create mode 100644 demos/plusplus2.cocci
 create mode 100644 demos/plusplus2.res

-- 
2.8.2
