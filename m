From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Tue, 21 Apr 2015 13:37:53 -0700
Subject: [Cocci] [PATCH v3 0/3] infiniband: few MTRR fixes and conversions
Message-ID: <1429648676-17755-1-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Infiniband has a few MTRR uses which from the looks of it
was first written on the ipath driver, later copied and pasted
on the qib driver. The behaviour of not counting is matched on
both drivers but with no good reason, since we want to generalize
use of MTRR in order to actually phase it, fix the driver to use
accounting as all other kernel users and also convert the qib
driver to arch_phys_wc_add().

The ipath driver is left without conversion to arch_phys_wc_add().

Luis R. Rodriguez (3):
  IB/qib: add acounting for MTRR
  IB/qib: use arch_phys_wc_add()
  IB/ipath: add counting for MTRR

 drivers/infiniband/hw/ipath/ipath_wc_x86_64.c |  2 +-
 drivers/infiniband/hw/qib/qib_wc_x86_64.c     | 31 ++++-----------------------
 2 files changed, 5 insertions(+), 28 deletions(-)

-- 
2.3.2.209.gd67f9d5.dirty
