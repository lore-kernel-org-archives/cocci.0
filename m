From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 29 Jun 2016 15:10:17 -0700
Subject: [Cocci] [RFC v4 0/9] coccicheck: private review for modernization
Message-ID: <1467238226-10822-1-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Here's a v4 RFC, sending it privately to avoid bikeshedding in public.
These are rebased on top of linux-next tag next-20160623.

Luis R. Rodriguez (9):
  coccicheck: move spatch binary check up
  coccicheck: make SPFLAGS more useful
  coccicheck: enable parmap support
  coccicheck: add support for DEBUG_FILE
  coccicheck: replace --very-quiet with --quit when debugging
  scripts: add Linux .cocciconfig for coccinelle
  coccicheck: add support for requring a coccinelle version
  coccicheck: refer to Documentation/coccinelle.txt and wiki
  scripts/coccinelle: require coccinelle >= 1.0.4 on
    device_node_continue.cocci

 .cocciconfig                                       |   3 +
 .gitignore                                         |   1 +
 Documentation/coccinelle.txt                       | 125 ++++++++++++++++++++-
 scripts/coccicheck                                 |  96 ++++++++++++++--
 .../iterators/device_node_continue.cocci           |   3 +
 5 files changed, 218 insertions(+), 10 deletions(-)
 create mode 100644 .cocciconfig

-- 
2.8.4
