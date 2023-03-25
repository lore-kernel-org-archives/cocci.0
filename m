Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98034C6FD1C
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 09:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=hzcyhImErQ9Z1On3EyAoR1YC8pkDqNnzp6IICBkWCK0=;
  b=US+r3sTh78CIuRoKUm7Tys6/J8NEtF6SjiWjaimgcdHqf8nM5GRUbNag
   shWn+NNtcaAYs7Z0rJp4Enbhaa6tzMd4RjErGai8yJsk38WVveQvCHqO2
   kGFsPJppmeJgGn2IP6DeP1Or4xONxmHWNCsqpS2W+5rXu++zKsCPr9tAS
   I=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99048339"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 10:50:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D2716E0D41; Sat, 25 Mar 2023 10:50:26 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 93CADE0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 10:50:25 +0100 (CET)
IronPort-SDR: 641ec3e1_kZz9ynWap/Fdfq59xMNegFE2GT/av5NVNPtyloLXnQUC3Eb
 Dc3P4+Jm/0W8niCDU6g2/97c8EqWo25CqbuecTQ==
X-IPAS-Result: =?us-ascii?q?A0EqAAArwx5khwMP49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YItgUsvBAtGhFOIH4hiLgOEL4cskCOBVoFAPg8BAwENQQECBAEBAwQ4gVOCc?=
 =?us-ascii?q?wKFOgIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQA?=
 =?us-ascii?q?QEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBE?=
 =?us-ascii?q?gJHUz0DAyMEGQEBESYBDx8GAiYCAlcGAQwGAgEBgnqCKAEDMQexT38zgQGCC?=
 =?us-ascii?q?AEBBoJjmScfLCJTgV4JgRQtAY0EgzZ6Jw+BVUSBFScMgzWIHIJngiiHVocli?=
 =?us-ascii?q?C8KgTR1gSAOgT2BBAIJAhFrgRIIa4F9QAINZAsOb4FKAoJOJQQOAxkrHUACA?=
 =?us-ascii?q?Qs7Oj81CQsgBlhrAiwREwUDCxUqRwQIOQYcNBECCA8SDyxEDkI3NBMGXAEpC?=
 =?us-ascii?q?w4RA1CBRwSBCoEBBgEmJJpxAgGCZwFSO0wmggSSWJJAng40B4IogVWBWQyfD?=
 =?us-ascii?q?AYTLpcIDgaSIy6HLZAPIKd6gWM6gVwzGiSDNk8DGQ+OIBmEDI9HQDQ7AgcBC?=
 =?us-ascii?q?gEBAwmFRgEBhXsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:QMXRqqPlR0dPbcBcThWjsMiBIKoaSvp037Dk7TEUdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFg7X5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YGT0EUMr3N5DZB/KPHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99048335"
X-MGA-submission: =?us-ascii?q?MDFfwaVsQO+JEjpPrQe5XsM9KB1Xjo7g/9LmLP?=
 =?us-ascii?q?v6hdMURbk97y1PIJyO390pS1cFMOlBN0YJsMs4tT9VOUPCWhmPFnPgg9?=
 =?us-ascii?q?IXCkttbvHspQhh/2r9O2YgUzq56OT9PC9CFejpKyzYVFRSk5itymIJ7f?=
 =?us-ascii?q?nKQMbleCKepgs4PEYwG/YbuQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 10:50:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679737821; i=markus.elfring@web.de;
	bh=l80jziDbpXilVQmI2ARDMit/2J/buNIAba4w+7+afU4=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=TbJF+YOdL8K7ri4xDFX5a8uPcAgwJYFWWXiUkHGQV/swg6kHs0DBTKKHO7j4DE5kF
	 SBTHPDLeaOQfOBwa69QNiRl+Lja9SHjm1PGsXEHcum58rwiR8bbeson8qmuJS0Z+q/
	 fadYlhH2jUTboVwkk9yxWEwiBl66MCFUaDlojksnmx0BgS9MdkbcedP9duWiFtMCmC
	 8ocVLrlJnODHrOM8wBtmPlwojcKicHvH+qVkrAoMh4KK0AU51WEFobRbscJwjmVmZj
	 afaXDQz6yRR1teCxxnQJVmVF9ePxR1vwTWdsOGpDlaT+ec0os1rzaf7vTwpEIINvSn
	 2r4qJAIlaA+7A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6Jxd-1qZ8CK1MAz-016jXo; Sat, 25
 Mar 2023 10:50:21 +0100
Message-ID: <d2fc5995-be1c-0371-c5c8-b9212b906b56@web.de>
Date: Sat, 25 Mar 2023 10:50:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, sparclinux@vger.kernel.org,
 Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>,
 "David S. Miller" <davem@davemloft.net>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <21e58abb-f215-b9b7-ffe8-236dd40c6bd2@web.de>
In-Reply-To: <21e58abb-f215-b9b7-ffe8-236dd40c6bd2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mNBAi3XXomYfgIC1KlABfpPrgeDlx2ukECJXkw93kWiNuWsDOVG
 RtSLElaglpRDgZLUfX/Z6rXoRY2/ql2gjeF0e9wzjH2bOVj9SoF/wMqpJVJwUJOqU5aVOOx
 qK+/ZWuCPtk5Ilq2whFbdZnJ9v25TqzU7QsDwm2+1biH2eZq2Sih3Tc9IeF7Hto5B0G/+DI
 i3w/RRg5s+9nX3U2kcSeA==
UI-OutboundReport: notjunk:1;M01:P0:UIGPTpKJ1Yg=;w4f1MP9yfEcDqNZ0sAb1B65lYnB
 2xRaxGqSIlH4ANCX5gpfzEfbtfqmmWaSgDF82mm6AdrF4yfT5gpN17VIThbjseNVhqQJCQK69
 5irxYjb7SXuMHq0tbd2aCkuSa/+YiSn98ThnRNh6lKphCKaJbgbCYoz9uMvu7RNAA7BIFo6g/
 ev9rkavwvObYih8VAamMXgJ04AUFsZLm9lgR9g+amjcNsSP0GclrVGmLWgz5eWVuBGUztgtSs
 Ztn1PfzkOmliLULljsFa3aGjWQOL7PQQayq7oBiEp9XFvbg4odqRn/K5kMW3oPJMvpBcE1V6s
 LoNtFD52Mvxhh6mM39L7D9OzPFinOr0tCFP3NvkBSWRVZLD1HtNduvZNYyoQS75XBSMzUv/ob
 PHwu8vK56an1uqmoJ4rH8OxjV8IytgNHw2MmKVYF24l3jQcQDs/v2bce6Pj7Bvajiq14J0770
 pQOIc0Va4JXBMGuavuwwfrTnD0Rueciu2frLGDHMkMCaTKi7ueRvLxSZCKaCiWI8YbJMPfWrb
 5dnX6P/FURRSirn1n1cV9mDO+lMYBincsfmuprdcIe7CN67k0haHCKC6wSmOBT1tM3vgvi2RK
 xtRrdcyx1iTqBS63NeEC620snktpQKMJeN7OFTJ8+CQAHMmo5HekK316066E3xe/o943oLPNh
 rbyKKG8PixJYUWIGalEq1nWqOw5vturbE2yJ1hLc/wEW4ai7P3XKihrAATrhCcEe/naaVbsH+
 5enlhn+BDH1vyelmSNgyMv9CWrZrUQ+6/je2F/c6ZyDLnOXg6F10nDkuNRGpmMvCiow/k71PU
 rkORBGhvvPkI4XPhDlw3BekJSzwP/91fQRaXsf4YiLHJlMmUbevj/jefHH4rremHwm2C7cIXE
 zThYLqrUw2jKxbZQsq3yIsnyrV7KKQzkxeH5eOdnGTrlY1hZHObkFOJYf
Subject: [cocci] [PATCH resent] bbc_i2c: Fix exception handling in
 attach_one_i2c()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 935
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/d2fc5995-be1c-0371-c5c8-b9212b906b56%40web.de>

Date: Tue, 21 Mar 2023 21:12:29 +0100

The label =E2=80=9Cfail=E2=80=9D was used to jump to another pointer check=
 despite of
the detail in the implementation of the function =E2=80=9Cattach_one_i2c=
=E2=80=9D
that it was determined already that a corresponding variable contained
a null pointer because of a failed call of the function =E2=80=9Cof_iorema=
p=E2=80=9D.

* Thus use more appropriate labels instead.

* Delete a redundant check.


This issue was detected by using the Coccinelle software.

Fixes: 5cdceab3d5e02eb69ea0f5d8fa9181800baf6f77 ("bbc-i2c: Fix BBC I2C env=
ctrl on SunBlade 2000")
Fixes: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ("Linux-2.6.12-rc2")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/sbus/char/bbc_i2c.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/sbus/char/bbc_i2c.c b/drivers/sbus/char/bbc_i2c.c
index 537e55cd038d..03e29f2760b2 100644
=2D-- a/drivers/sbus/char/bbc_i2c.c
+++ b/drivers/sbus/char/bbc_i2c.c
@@ -306,19 +306,19 @@ static struct bbc_i2c_bus * attach_one_i2c(struct pl=
atform_device *op, int index

 	bp->i2c_control_regs =3D of_ioremap(&op->resource[0], 0, 0x2, "bbc_i2c_r=
egs");
 	if (!bp->i2c_control_regs)
-		goto fail;
+		goto free_bus;

 	if (op->num_resources =3D=3D 2) {
 		bp->i2c_bussel_reg =3D of_ioremap(&op->resource[1], 0, 0x1, "bbc_i2c_bu=
ssel");
 		if (!bp->i2c_bussel_reg)
-			goto fail;
+			goto unmap_io_control_regs;
 	}

 	bp->waiting =3D 0;
 	init_waitqueue_head(&bp->wq);
 	if (request_irq(op->archdata.irqs[0], bbc_i2c_interrupt,
 			IRQF_SHARED, "bbc_i2c", bp))
-		goto fail;
+		goto recheck_bussel_reg;

 	bp->index =3D index;
 	bp->op =3D op;
@@ -348,11 +348,12 @@ static struct bbc_i2c_bus * attach_one_i2c(struct pl=
atform_device *op, int index

 	return bp;

-fail:
+recheck_bussel_reg:
 	if (bp->i2c_bussel_reg)
 		of_iounmap(&op->resource[1], bp->i2c_bussel_reg, 1);
-	if (bp->i2c_control_regs)
-		of_iounmap(&op->resource[0], bp->i2c_control_regs, 2);
+unmap_io_control_regs:
+	of_iounmap(&op->resource[0], bp->i2c_control_regs, 2);
+free_bus:
 	kfree(bp);
 	return NULL;
 }
=2D-
2.40.0

