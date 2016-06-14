From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Tue, 14 Jun 2016 13:05:47 -0700
Subject: [Cocci] [PATCH v2 0/5] coccicheck: extend with parmap and indexing
	heuristics
Message-ID: <1465934752-13792-1-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This v2 addresses the feedback from the v1 series. It also adds 2 more
patches, one to document how to add extra additional options and refers
to a wiki for further documentation.

Luis R. Rodriguez (5):
  coccicheck: enable parmap support
  scripts: add glimpse.sh for indexing the kernel
  coccicheck: add indexing enhancement options
  coccicheck: document how to pass extra options to coccinelle
  coccicheck: refer to coccicheck bottest wiki for documentation

 scripts/coccicheck | 155 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 scripts/glimpse.sh |  12 +++++
 2 files changed, 161 insertions(+), 6 deletions(-)
 create mode 100755 scripts/glimpse.sh

-- 
2.8.2
