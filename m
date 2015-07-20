From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Mon, 20 Jul 2015 15:32:19 -0700
Subject: [Cocci] [PATCH v3 0/5] pycocci: few updates and add to install
	target
Message-ID: <1437431544-32662-1-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This v3 addresses the changes noted by Julia. Since this is extending
features to help with SmPL patch development, in particular --show-proof,
and since we're using quite a bit of heuristics useful to users of Coccinelle
depending on their version installed document all this on a proper man page
for pycocci and also add pycocci into the install target.

In the future we should probably just let pycocci read ini type of file
on say your ~/.pycocci which will let you specify and customize further
defaults we'd inherit depending on your target. Then you can further
customize your options per project. Each upstream project can then also
have their own .pycocci perhaps which promotes a set of options to use.
For instance right now Linux scripts/coccinelle/ lets scripts gather
options to use per SmPL patch. We shoul standardize on a format format
for that and to enable project specific tuned variables.

If there are no issues with this v3 I'll merge soon.

Luis R. Rodriguez (5):
  pycocci: add requirements class
  pycocci: add git class
  pycocci: figure out if to enable --jobs, --use-gitgrep or
    --use-glimpse
  pycocci: add Coccinelle SmPL patch proof support
  pycocci: add man page and promote pycocci to install target

 Makefile       |   3 +
 docs/pycocci.1 | 217 ++++++++++++++++++++++++++
 tools/pycocci  | 486 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 687 insertions(+), 19 deletions(-)
 create mode 100644 docs/pycocci.1

-- 
2.3.2.209.gd67f9d5.dirty
