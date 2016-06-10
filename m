From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Fri, 10 Jun 2016 13:42:08 -0700
Subject: [Cocci] [PATCH 0/4] scripts/coccicheck: add paramap and indexing
	options
Message-ID: <1465591332-31113-1-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

coccicheck hasn't been updated for a while. The backports
project has been using some features for a while now that
we should be able to also take advantage of with coccicheck,
the most important one is paramap support.

glimpseindex stuff wasn't even building but today I decided
to go tackle and fix that, the public open source release is
is now working and you can optionally use that. Note that
using git performs just as well, glimpseindex just shaves off
a bit of time, however if since we can support it now we do it.

Luis R. Rodriguez (4):
  coccicheck: move spatch binary check up
  coccicheck: enable paramap support
  scripts: add glimpse.sh for indexing the kernel
  coccicheck: add indexing enhancement options

 scripts/coccicheck | 62 +++++++++++++++++++++++++++++++++++++++++++++++-------
 scripts/glimpse.sh | 12 +++++++++++
 2 files changed, 66 insertions(+), 8 deletions(-)
 create mode 100755 scripts/glimpse.sh

-- 
2.8.2
