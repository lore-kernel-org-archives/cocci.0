From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Fri, 17 Jul 2015 22:05:07 -0700
Subject: [Cocci] [PATCH v2 0/4] pycocci: index opts, SmPL patch proof support
Message-ID: <1437195911-28821-1-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This v2 changes the way we do git tree inference by using
git rev-parse. While at it, I decided to mesh in SmPL  <--> patch
equivalence proof support. This is a generalized solution, I
originally had written for the backports project, we now give
this instead a proper home and purpose under pycocci.

If there are no issues I'll merge this soon, in hopes it will
make it for the coccinelle 1.0.2 release.

Luis R. Rodriguez (4):
  pycocci: add requirements class
  pycocci: add git class
  pycocci: figure out if to enable --jobs, --use-gitgrep or
    --use-glimpse
  pycocci: add Coccinelle SmPL patch proof support

 tools/pycocci | 475 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 462 insertions(+), 13 deletions(-)

-- 
2.3.2.209.gd67f9d5.dirty
