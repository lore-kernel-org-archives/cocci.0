From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Tue, 21 Apr 2015 13:21:38 -0700
Subject: [Cocci] [PATCH v3 0/4] pci: add and use pci_iomap_wc()
Message-ID: <1429647702-17315-1-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This series adds pci_iomap_wc() variants and makes use of them
to framebuffer device drivers.

Luis R. Rodriguez (4):
  pci: add pci_iomap_wc() variants
  video: fbdev: arkfb: use arch_phys_wc_add() and pci_iomap_wc()
  video: fbdev: s3fb: use arch_phys_wc_add() and pci_iomap_wc()
  video: fbdev: vt8623fb: use arch_phys_wc_add() and pci_iomap_wc()

 drivers/video/fbdev/arkfb.c     | 36 ++++--------------------
 drivers/video/fbdev/s3fb.c      | 35 ++++-------------------
 drivers/video/fbdev/vt8623fb.c  | 31 ++++-----------------
 include/asm-generic/pci_iomap.h | 14 ++++++++++
 lib/pci_iomap.c                 | 61 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 92 insertions(+), 85 deletions(-)

-- 
2.3.2.209.gd67f9d5.dirty
