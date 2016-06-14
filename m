From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Tue, 14 Jun 2016 13:23:34 -0700
Subject: [Cocci] [PATCH v3 0/6] coccicheck: extend with parmap and indexing
	heuristics
In-Reply-To: <20160614201923.GC11948@wotan.suse.de>
References: <20160614201923.GC11948@wotan.suse.de>
Message-ID: <1465935820-14010-1-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I fat fingered the v2 series and forgot the first patch, this just adds
the first patch... sorry about that.

Luis R. Rodriguez (6):
  coccicheck: move spatch binary check up
  coccicheck: enable parmap support
  scripts: add glimpse.sh for indexing the kernel
  coccicheck: add indexing enhancement options
  coccicheck: document how to pass extra options to coccinelle
  coccicheck: refer to coccicheck bottest wiki for documentation

 scripts/coccicheck | 165 +++++++++++++++++++++++++++++++++++++++++++++++++----
 scripts/glimpse.sh |  12 ++++
 2 files changed, 166 insertions(+), 11 deletions(-)
 create mode 100755 scripts/glimpse.sh

-- 
2.8.2
