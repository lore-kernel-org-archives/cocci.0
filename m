From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 29 Jun 2016 15:14:50 -0700
Subject: [Cocci] [PATCH v4 0/9] coccicheck: modernize
Message-ID: <1467238499-10889-1-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

There were quite a bit of comments from the v3 series [0], since there
was quite a bit of review needed for some other changes I've had discussions
with Nicolas and Julia privately over these changes and collected their Acks
privately to avoid unnecessary e-mail waste. I've annotated the changes
in the commit log with any changes done in the v4 series. If most importance
is the use of .cocciconfig, update of the documentation and recommending an
upgrade of coccinelle for users wishing to use idutils. A future 1.0.6 release
of coccinellew will support it best.

This series is rebased on top of linux-next tag next-20160629, I've put
up a branch of these changes up on my linux-next tree, the branch is 
20160629-coccicheck-v4 [1].

[0] https://lkml.kernel.org/r/1466536893-23355-1-git-send-email-mcgrof at kernel.org
[1] https://git.kernel.org/cgit/linux/kernel/git/mcgrof/linux-next.git/log/?h=20160629-coccicheck-v4

Luis R. Rodriguez (9):
  coccicheck: move spatch binary check up
  coccicheck: make SPFLAGS more useful
  coccicheck: enable parmap support
  coccicheck: add support for DEBUG_FILE
  coccicheck: replace --very-quiet with --quiet when debugging
  scripts: add Linux .cocciconfig for coccinelle
  coccicheck: add support for requring a coccinelle version
  coccicheck: refer to Documentation/coccinelle.txt and wiki
  scripts/coccinelle: require coccinelle >= 1.0.4 on
    device_node_continue.cocci

 .cocciconfig                                       |   3 +
 .gitignore                                         |   1 +
 Documentation/coccinelle.txt                       | 148 ++++++++++++++++++++-
 scripts/coccicheck                                 |  94 +++++++++++--
 .../iterators/device_node_continue.cocci           |   3 +
 5 files changed, 239 insertions(+), 10 deletions(-)
 create mode 100644 .cocciconfig

-- 
2.8.4
