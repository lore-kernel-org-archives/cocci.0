From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Thu, 16 Jun 2016 15:31:24 -0700
Subject: [Cocci] [PATCH v2 0/8] coccicheck: modernize
Message-ID: <1466116292-21843-1-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This series gives coccicheck some love by modernizing it
to catch up to some features implemented in Coccinelle, of
most importance is parmap support and some indexing
enhancements. This should help speed things up considerably,
for me this now runs twice as fast in some situations.

This also takes advantage of the open sourcing of Glimpse,
thanks to the university of Arizona for doing and to Udi Manber
for helping push that out.

Since Coccinelle is ever evolving this also now allows developer
to require specific Coccinelle versions on top of the SmPL patches.

This is part of a larger series, all of which you can find here:

https://git.kernel.org/cgit/linux/kernel/git/mcgrof/linux-next.git/log/?h=20160616-sysdata-v2

Since further development is done on top of this we may need to coordinate
with another maintainer for how these go in. The coccicheck changes will be
important to help speed up some of the new Coccinelle API checks and
transformations implemented in later series on the request firmware API.

Luis R. Rodriguez (8):
  coccicheck: move spatch binary check up
  coccicheck: enable parmap support
  coccicheck: add indexing enhancement options
  scripts: add glimpse.sh for indexing the kernel
  coccicheck: replace --very-quiet with --quit when debugging
  coccicheck: add support for requring a coccinelle version
  coccicheck: refer to coccicheck bottest wiki for documentation
  scripts/coccinelle: require coccinelle >= 1.0.4 on
    device_node_continue.cocci

 .gitignore                                         |   3 +
 scripts/coccicheck                                 | 242 ++++++++++++++++++++-
 .../iterators/device_node_continue.cocci           |   3 +
 scripts/glimpse.sh                                 |  11 +
 4 files changed, 248 insertions(+), 11 deletions(-)
 create mode 100755 scripts/glimpse.sh

-- 
2.8.2
