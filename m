From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Tue, 21 Apr 2015 13:40:47 -0700
Subject: [Cocci] [PATCH v3 0/3] vesafb: remove theoretical MTRR uses
Message-ID: <1429648850-17902-1-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

The vesafb has some theoretical uses of MTRR, in practice only
write-combining is used and since PAT replaces MTRR and MTRR's
use should be phased lets just remove such old theoretical uses
of MTRR.

Luis R. Rodriguez (3):
  video: fbdev: vesafb: only support MTRR_TYPE_WRCOMB
  video: fbdev: vesafb: add missing mtrr_del() for added MTRR
  video: fbdev: vesafb: use arch_phys_wc_add()

 drivers/video/fbdev/vesafb.c | 77 +++++++++++++++-----------------------------
 1 file changed, 26 insertions(+), 51 deletions(-)

-- 
2.3.2.209.gd67f9d5.dirty
