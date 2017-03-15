From: jslaby@suse.cz (Jiri Slaby)
Date: Wed, 15 Mar 2017 12:00:09 +0100
Subject: [Cocci] [PATCH 1/1] sisusb_con: fix coccinelle warning
Message-ID: <20170315110009.7739-1-jslaby@suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

After commit d705ff3818 (tty: vt, cleanup and document con_scroll), in
the coccinelle output, we can see:
drivers/usb/misc/sisusbvga/sisusb_con.c:852:8-9: WARNING: return of 0/1 in function 'sisusbcon_scroll_area' with return type bool

Return true instead of 1 in the function returning bool which was
intended to do in d705ff3818 but omitted.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Fixes: d705ff3818 (tty: vt, cleanup and document con_scroll)
Cc: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb at vger.kernel.org
Cc: cocci at systeme.lip6.fr
---
 drivers/usb/misc/sisusbvga/sisusb_con.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sisusbvga/sisusb_con.c
index 4b5777ec1501..3c6948af726a 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -816,7 +816,7 @@ sisusbcon_scroll_area(struct vc_data *c, struct sisusb_usb_data *sisusb,
 
 	mutex_unlock(&sisusb->lock);
 
-	return 1;
+	return true;
 }
 
 /* Interface routine */
-- 
2.12.0
