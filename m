Return-Path: <SRS0=b71c=UW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03E9C43613
	for <cocci@archiver.kernel.org>; Sun, 23 Jun 2019 07:29:19 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF9C2073F
	for <cocci@archiver.kernel.org>; Sun, 23 Jun 2019 07:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="jdV7G+N0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="adHVKzGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF9C2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nexedi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5N7Su8J007609;
	Sun, 23 Jun 2019 09:28:56 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1E4F1776C;
	Sun, 23 Jun 2019 09:28:56 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 499D17761
 for <cocci@systeme.lip6.fr>; Sun, 23 Jun 2019 09:28:55 +0200 (CEST)
Received: from mail180-6.suw31.mandrillapp.com
 (mail180-6.suw31.mandrillapp.com [198.2.180.6])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5N7Ss0Q016495
 for <cocci@systeme.lip6.fr>; Sun, 23 Jun 2019 09:28:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
 i=kirr@nexedi.com; 
 bh=heA1ye5BNgh1EP8cOvkyYqS+CIu9oX7BkDTAUuWSqzo=;
 b=jdV7G+N0xuN+X03q/9LTAL1LwB5YmbwtvlSHrOtQqdNRxZrHn3NuH8CqADn+cptoLeribb9GvhXd
 +3oS0bN9p7kwLBgJunb/EbxygPaAwbv2JLRU1IewTiJ87p8UX7rlbxqA4EpOflnNTw/da/fZzma8
 ffti3qG+rPMOdlxILnQ=
Received: from pmta03.mandrill.prod.suw01.rsglab.com (127.0.0.1) by
 mail180-6.suw31.mandrillapp.com id h1sl3c22sc06 for <cocci@systeme.lip6.fr>;
 Sun, 23 Jun 2019 07:28:53 +0000 (envelope-from
 <bounce-md_31050260.5d0f2a35.v1-8cdb15a37a814ba290b8404b68063b5e@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1561274933; h=From : 
 Subject : To : Cc : Message-Id : Date : MIME-Version : Content-Type : 
 Content-Transfer-Encoding : From : Subject : Date : X-Mandrill-User : 
 List-Unsubscribe; bh=heA1ye5BNgh1EP8cOvkyYqS+CIu9oX7BkDTAUuWSqzo=; 
 b=adHVKzGzJx5PRnR2SWx/SexOQ/pyUP+lJfGFSgNcoa2egwdmgBfgykhFZD0b2Jvc5L9vhA
 0ocGYcOUuXbTwAnfO1INhKawCTNrvmpxhMeIFH5BagbEDmsm4nPO8y8KQXQO+PrhCnpvPBn0
 VvsV+NdVI3P2bD54ov9B2BpcZMOzU=
From: Kirill Smelkov <kirr@nexedi.com>
Received: from [87.98.221.171] by mandrillapp.com id
 8cdb15a37a814ba290b8404b68063b5e; Sun, 23 Jun 2019 07:28:53 +0000
X-Mailer: git-send-email 2.20.1
To: <cocci@systeme.lip6.fr>, <linux-kernel@vger.kernel.org>
Message-Id: <20190623072838.31234-1-kirr@nexedi.com>
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here:
 http://mandrillapp.com/contact/abuse?id=31050260.8cdb15a37a814ba290b8404b68063b5e
X-Mandrill-User: md_31050260
Date: Sun, 23 Jun 2019 07:28:53 +0000
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 23 Jun 2019 09:28:56 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 23 Jun 2019 09:28:54 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Kirill Smelkov <kirr@nexedi.com>
Subject: [Cocci] [PATCH 1/2] coccinelle: api/stream_open: treat all
	wait_.*() calls as blocking
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

Previously steam_open.cocci was treating only wait_event_.* - e.g.
wait_event_interruptible - as a blocking operation. However e.g.
wait_for_completion_interruptible is also blocking, and so from this
point of view it would be more logical to treat all wait_.* as a
blocking point.

The logic of this change actually came up for real when
drivers/pci/switch/switchtec.c changed from using
wait_event_interruptible to wait_for_completion_interruptible:

	https://lore.kernel.org/linux-pci/20190413170056.GA11293@deco.navytux.spb.ru/
	https://lore.kernel.org/linux-pci/20190415145456.GA15280@deco.navytux.spb.ru/
	https://lore.kernel.org/linux-pci/20190415154102.GB17661@deco.navytux.spb.ru/

For a driver that uses nonseekable_open with read/write having stream
semantic and read also calling e.g. wait_for_completion_interruptible,
running stream_open.cocci before this patch would produce:

	WARNING: <driver>_fops: .read() and .write() have stream semantic; safe to change nonseekable_open -> stream_open.

while after this patch it will report:

	ERROR: <driver>_fops: .read() can deadlock .write(); change nonseekable_open -> stream_open to fix.

Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
---
 scripts/coccinelle/api/stream_open.cocci | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/coccinelle/api/stream_open.cocci b/scripts/coccinelle/api/stream_open.cocci
index 350145da7669..12ce18fa6b74 100644
--- a/scripts/coccinelle/api/stream_open.cocci
+++ b/scripts/coccinelle/api/stream_open.cocci
@@ -35,11 +35,11 @@ type loff_t;
 // a function that blocks
 @ blocks @
 identifier block_f;
-identifier wait_event =~ "^wait_event_.*";
+identifier wait =~ "^wait_.*";
 @@
   block_f(...) {
     ... when exists
-    wait_event(...)
+    wait(...)
     ... when exists
   }
 
@@ -49,12 +49,12 @@ identifier wait_event =~ "^wait_event_.*";
 // XXX currently reader_blocks supports only direct and 1-level indirect cases.
 @ reader_blocks_direct @
 identifier stream_reader.readstream;
-identifier wait_event =~ "^wait_event_.*";
+identifier wait =~ "^wait_.*";
 @@
   readstream(...)
   {
     ... when exists
-    wait_event(...)
+    wait(...)
     ... when exists
   }
 
-- 
2.20.1
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
