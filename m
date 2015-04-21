From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Tue, 21 Apr 2015 13:37:55 -0700
Subject: [Cocci] [PATCH v3 2/3] IB/qib: use arch_phys_wc_add()
In-Reply-To: <1429648676-17755-1-git-send-email-mcgrof@do-not-panic.com>
References: <1429648676-17755-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <1429648676-17755-3-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This driver already makes use of ioremap_wc() on PIO buffers,
so convert it to use arch_phys_wc_add().

Cc: Toshi Kani <toshi.kani@hp.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: Roland Dreier <roland@purestorage.com>
Cc: Sean Hefty <sean.hefty@intel.com>
Cc: Hal Rosenstock <hal.rosenstock@gmail.com>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Suresh Siddha <sbsiddha@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Stefan Bader <stefan.bader@canonical.com>
Cc: konrad.wilk at oracle.com
Cc: ville.syrjala at linux.intel.com
Cc: david.vrabel at citrix.com
Cc: jbeulich at suse.com
Cc: Roger Pau Monn? <roger.pau@citrix.com>
Cc: infinipath at intel.com
Cc: linux-rdma at vger.kernel.org
Cc: linux-fbdev at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: xen-devel at lists.xensource.com
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 drivers/infiniband/hw/qib/qib_wc_x86_64.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_wc_x86_64.c b/drivers/infiniband/hw/qib/qib_wc_x86_64.c
index fe0850a..6d61ef9 100644
--- a/drivers/infiniband/hw/qib/qib_wc_x86_64.c
+++ b/drivers/infiniband/hw/qib/qib_wc_x86_64.c
@@ -116,21 +116,9 @@ int qib_enable_wc(struct qib_devdata *dd)
 	}
 
 	if (!ret) {
-		int cookie;
-
-		cookie = mtrr_add(pioaddr, piolen, MTRR_TYPE_WRCOMB, 1);
-		if (cookie < 0) {
-			{
-				qib_devinfo(dd->pcidev,
-					 "mtrr_add()  WC for PIO bufs failed (%d)\n",
-					 cookie);
-				ret = -EINVAL;
-			}
-		} else {
-			dd->wc_cookie = cookie;
-			dd->wc_base = (unsigned long) pioaddr;
-			dd->wc_len = (unsigned long) piolen;
-		}
+		dd->wc_cookie = arch_phys_wc_add(pioaddr, piolen);
+		if (dd->wc_cookie < 0)
+			ret = -EINVAL;
 	}
 
 	return ret;
@@ -142,18 +130,7 @@ int qib_enable_wc(struct qib_devdata *dd)
  */
 void qib_disable_wc(struct qib_devdata *dd)
 {
-	if (dd->wc_cookie) {
-		int r;
-
-		r = mtrr_del(dd->wc_cookie, dd->wc_base,
-			     dd->wc_len);
-		if (r < 0)
-			qib_devinfo(dd->pcidev,
-				 "mtrr_del(%lx, %lx, %lx) failed: %d\n",
-				 dd->wc_cookie, dd->wc_base,
-				 dd->wc_len, r);
-		dd->wc_cookie = 0; /* even on failure */
-	}
+	arch_phys_wc_del(dd->wc_cookie);
 }
 
 /**
-- 
2.3.2.209.gd67f9d5.dirty
