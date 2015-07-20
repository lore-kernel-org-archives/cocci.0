From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Mon, 20 Jul 2015 15:30:44 -0700
Subject: [Cocci] [PATCH v2 0/2] backports: respin on 0002-no_dmabuf SmPL and
	ckmake changes
Message-ID: <1437431446-32619-1-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This v2 is a respin with the ckmake format changes fixed. I'll merge
this now as I had not heard feedback on the v1 spin and this is needed
to move on with life.

Luis R. Rodriguez (2):
  patches: replace most of 0002-no_dmabuf with SmPL
  ckmake: address directory max depth

 devel/ckmake                                       | 132 +++++----
 .../media/0002-no_dmabuf.cocci                     |  75 +++++
 .../media/0002-no_dmabuf/v4l2.patch                | 305 +--------------------
 3 files changed, 163 insertions(+), 349 deletions(-)
 create mode 100644 patches/collateral-evolutions/media/0002-no_dmabuf.cocci

-- 
2.3.2.209.gd67f9d5.dirty
