From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Tue, 21 Apr 2015 14:50:33 -0700
Subject: [Cocci] [PATCH v4 0/2] qib: few changes to bury MTRR use
Message-ID: <1429653035-19424-1-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

MTRR use is being deprecated and should only be used
with the helper arch_phys_wc_add() when PAT is not
available and enabled. This v4 follows addresse the
removal of the PAT module parameter for the driver which
was always preferring PAT anyway.

Luis R. Rodriguez (2):
  IB/qib: add acounting for MTRR
  IB/qib: use arch_phys_wc_add()

 drivers/infiniband/hw/qib/qib.h           |  1 -
 drivers/infiniband/hw/qib/qib_file_ops.c  |  3 ++-
 drivers/infiniband/hw/qib/qib_iba6120.c   |  8 +++---
 drivers/infiniband/hw/qib/qib_iba7220.c   |  8 +++---
 drivers/infiniband/hw/qib/qib_iba7322.c   | 41 +++++++++++++++----------------
 drivers/infiniband/hw/qib/qib_init.c      | 26 ++++++--------------
 drivers/infiniband/hw/qib/qib_wc_x86_64.c | 31 +++--------------------
 7 files changed, 39 insertions(+), 79 deletions(-)

-- 
2.3.2.209.gd67f9d5.dirty
