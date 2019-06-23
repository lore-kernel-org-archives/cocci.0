Return-Path: <SRS0=b71c=UW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540DEC43613
	for <cocci@archiver.kernel.org>; Sun, 23 Jun 2019 07:29:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3BB42073F
	for <cocci@archiver.kernel.org>; Sun, 23 Jun 2019 07:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="ZwaquKaA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="heJrSMnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BB42073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nexedi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5N7T7HL023139;
	Sun, 23 Jun 2019 09:29:07 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7C5ED776C;
	Sun, 23 Jun 2019 09:29:07 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 95BA67761
 for <cocci@systeme.lip6.fr>; Sun, 23 Jun 2019 09:29:06 +0200 (CEST)
Received: from mail180-6.suw31.mandrillapp.com
 (mail180-6.suw31.mandrillapp.com [198.2.180.6])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5N7T4f7018409
 for <cocci@systeme.lip6.fr>; Sun, 23 Jun 2019 09:29:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
 i=kirr@nexedi.com; 
 bh=SQoaU4CrfNl4Jf6eu/xkbrQQO2NHeGQLLOHbulVuvP0=;
 b=ZwaquKaAAIpxxVQEmVOT20IFfM3TMqO23bu/l9VI1hdlMD38vOfkJAPHN+oLM6CxHTN+K/l0/Yrt
 IGni4RFYHR+YACpcXAjgkPsVqzXAV2IfAZhtGtA8g04LwaFhcmIDpWnzLDeDrHLiuoSr+X2dMc3W
 22/snrvgn7MtTVocGo4=
Received: from pmta03.mandrill.prod.suw01.rsglab.com (127.0.0.1) by
 mail180-6.suw31.mandrillapp.com id h1sl4222sc0f for <cocci@systeme.lip6.fr>;
 Sun, 23 Jun 2019 07:29:04 +0000 (envelope-from
 <bounce-md_31050260.5d0f2a40.v1-6fcf5f7623804ea3ad43c52b07d966f4@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1561274944; h=From : 
 Subject : To : Cc : Message-Id : In-Reply-To : References : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=SQoaU4CrfNl4Jf6eu/xkbrQQO2NHeGQLLOHbulVuvP0=; 
 b=heJrSMnHQWCGWzsl8h/w5zgwVtCwfoZnUV0KKdOcVCJFq23XOse0MannbQ15D+vKAXkJKb
 i40erQl26b5//TWMWUUKri8AORF/xUA8LgF0y4VItMSSdNpfNOf6EnrkRwvKexBm6P6giEc/
 693nMiLlsQzxwU9XyKJ0YA4VW6qoY=
From: Kirill Smelkov <kirr@nexedi.com>
Received: from [87.98.221.171] by mandrillapp.com id
 6fcf5f7623804ea3ad43c52b07d966f4; Sun, 23 Jun 2019 07:29:04 +0000
X-Mailer: git-send-email 2.20.1
To: <cocci@systeme.lip6.fr>, <linux-input@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Message-Id: <20190623072838.31234-2-kirr@nexedi.com>
In-Reply-To: <20190623072838.31234-1-kirr@nexedi.com>
References: <20190623072838.31234-1-kirr@nexedi.com>
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here:
 http://mandrillapp.com/contact/abuse?id=31050260.6fcf5f7623804ea3ad43c52b07d966f4
X-Mandrill-User: md_31050260
Date: Sun, 23 Jun 2019 07:29:04 +0000
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 23 Jun 2019 09:29:07 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 23 Jun 2019 09:29:05 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jan Blunck <jblunck@suse.de>, Kirill Smelkov <kirr@nexedi.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [Cocci] [PATCH 2/2] *: convert stream-like files -> stream_open,
	even if they use noop_llseek
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

This patch continues 10dce8af3422 (fs: stream_open - opener for
stream-like files so that read and write can run simultaneously without
deadlock) and c5bf68fe0c86 (*: convert stream-like files from
nonseekable_open -> stream_open) and teaches steam_open.cocci to
consider files as being stream-like not only if they have
.llseek=no_llseek, but also if they have .llseek=noop_llseek.

This is safe to do: the comment about noop_llseek says

	This is an implementation of ->llseek useable for the rare special case when
	userspace expects the seek to succeed but the (device) file is actually not
	able to perform the seek. In this case you use noop_llseek() instead of
	falling back to the default implementation of ->llseek.

and in general noop_llseek was massively added to drivers in 6038f373a3dc
(llseek: automatically add .llseek fop) when changing default for NULL .llseek
from NOP to no_llseek with the idea to avoid breaking compatibility, if
maybe some user-space program was using lseek on a device without caring
about the result, but caring if it was an error or not.

Amended semantic patch produces two changes when applied tree-wide:

        drivers/hid/hid-sensor-custom.c:690:8-24: WARNING: hid_sensor_custom_fops: .read() has stream semantic; safe to change nonseekable_open -> stream_open.
        drivers/input/mousedev.c:564:1-17: ERROR: mousedev_fops: .read() can deadlock .write(); change nonseekable_open -> stream_open to fix.

Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Jan Blunck <jblunck@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
---
 drivers/hid/hid-sensor-custom.c          | 2 +-
 drivers/input/mousedev.c                 | 2 +-
 scripts/coccinelle/api/stream_open.cocci | 9 ++++++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index c60f82673cf2..fb827c295842 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -687,7 +687,7 @@ static int hid_sensor_custom_open(struct inode *inode, struct file *file)
 	if (test_and_set_bit(0, &sensor_inst->misc_opened))
 		return -EBUSY;
 
-	return nonseekable_open(inode, file);
+	return stream_open(inode, file);
 }
 
 static __poll_t hid_sensor_custom_poll(struct file *file,
diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index 412fa71245af..58afd5253485 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -561,7 +561,7 @@ static int mousedev_open(struct inode *inode, struct file *file)
 		goto err_free_client;
 
 	file->private_data = client;
-	nonseekable_open(inode, file);
+	stream_open(inode, file);
 
 	return 0;
 
diff --git a/scripts/coccinelle/api/stream_open.cocci b/scripts/coccinelle/api/stream_open.cocci
index 12ce18fa6b74..df00d6619b06 100644
--- a/scripts/coccinelle/api/stream_open.cocci
+++ b/scripts/coccinelle/api/stream_open.cocci
@@ -134,6 +134,13 @@ identifier fops0.fops;
     .llseek = no_llseek,
   };
 
+@ has_noop_llseek @
+identifier fops0.fops;
+@@
+  struct file_operations fops = {
+    .llseek = noop_llseek,
+  };
+
 @ has_mmap @
 identifier fops0.fops;
 identifier mmap_f;
@@ -180,7 +187,7 @@ identifier splice_write_f;
 //
 // XXX for simplicity require no .{read/write}_iter and no .splice_{read/write} for now.
 // XXX maybe_steam.fops cannot be used in other rules - it gives "bad rule maybe_stream or bad variable fops".
-@ maybe_stream depends on (!has_llseek || has_no_llseek) && !has_mmap && !has_copy_file_range && !has_remap_file_range && !has_read_iter && !has_write_iter && !has_splice_read && !has_splice_write @
+@ maybe_stream depends on (!has_llseek || has_no_llseek || has_noop_llseek) && !has_mmap && !has_copy_file_range && !has_remap_file_range && !has_read_iter && !has_write_iter && !has_splice_read && !has_splice_write @
 identifier fops0.fops;
 @@
   struct file_operations fops = {
-- 
2.20.1
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
