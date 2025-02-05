Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9B4C02198
	for <cocci@archiver.kernel.org>; Wed,  5 Feb 2025 14:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=IPbYopkpgEivNZMMS73ihzw1864mT8zOzgG10BotjFI=;
  b=HQRTH2dmy65VbQu8kqLFtGQsvc98LxaJlyFfwQNXelqxJbJXpXD4943E
   ifsuSXvIGQ6XuYH4kf4b4m7+Pv0JQ7J7fx+XwYqEk6ze1CdmXHp2Qzvhl
   FjGb6q/TBIdTlA70rw3bI9rzbx1TytiHWyRFfJZ0yO2S7726L86kmPItv
   k=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.13,261,1732575600"; 
   d="scan'208";a="206749627"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Feb 2025 15:28:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C71D8E0D1E; Wed,  5 Feb 2025 15:28:54 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AA0DEE0260
	for <cocci@sympa.inria.fr>; Wed,  5 Feb 2025 15:28:49 +0100 (CET)
IronPort-SDR: 67a375a1_Rj3HXoBVbTBPblsKbbSImcC/hiZQX2bNL+rg8T25QS7x3iD
 HS6G7NVpTLcH3ZRZLf7U0cg+3sHWTUByFu2RmJQ==
X-IPAS-Result: =?us-ascii?q?A0EDAACPdKNnjliJgsNaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAYF/BgEBAQsBgXFSgVczBwgaLoxziVMUngOCDQEDAQ1BAQIEAQGQBwIfB?=
 =?us-ascii?q?QIEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEBAQEeG?=
 =?us-ascii?q?wUOO4YIgmIBhDgBRoE9ARKDAoJlBAOyYYEB3jSBboFIAYVrh19whR6CKIEVM?=
 =?us-ascii?q?oJHb4sHBIIvgUKCBYFqiHuZe0iBIQNZLAFVEw0KCwcFgTk4AyAKCwwLBg4cF?=
 =?us-ascii?q?QIULAYQBG1EN4JHaUk6Ag0CNYIeJFiCK4RehEOEToJIVIJEghJ0iUJAAwsYD?=
 =?us-ascii?q?UgRLDcGDhsGPm4HnU48hBKBDgZGAnYcGTB6xhSEJYFjn30zqlMumE4io0ldh?=
 =?us-ascii?q?GaBZzqBXG2DOk8DGQ/aHUI1PAIHCwEBAwmFRgEBimiBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 E7K
IronPort-HdrOrdr: A9a23:g/yerq32vsPJA1xX9TEZVQqjBK0kLtp133Aq2lEZdPWaSKKlfq
 eV7ZAmPHDP6Ar5NEtNpTniAtjkfZq/z+8X3WB5B97LN2OKhILCFuBfBOXZrAEIYxeOlNJg6Q
 ==
X-Talos-CUID: 9a23:b8CoU2NkUMYzJO5DdAs+2m8OSvweSFrDxnvzPkucMjlDV+jA
X-Talos-MUID: 9a23:+y6WsAWftkRL5E7q/GHWgxJgDchT2oKVMEwCzZwE4+O5EwUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,261,1732575600"; 
   d="scan'208";a="206749617"
X-MGA-submission: =?us-ascii?q?MDGE/0RvAs6bMuG6MNZSxAwH8KyJURPn6Lx4JS?=
 =?us-ascii?q?dX25SdceShROV7bjne2/QtLUeoGOZrQcXH4r/tkKKsEyHTtIQkSA7gwG?=
 =?us-ascii?q?IhOPyWRAw/+76fOOfVB3l+ydmzO4lxyMKWe79Mhc00EPVICu0XTYNw6d?=
 =?us-ascii?q?j89d59dLhmXbJJef9ZB6IYPw=3D=3D?=
Received: from michel.telenet-ops.be ([195.130.137.88])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 15:28:49 +0100
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:fa11:c14e:2df5:5273])
	by michel.telenet-ops.be with cmsmtp
	id 9qUo2E00F3f221S06qUolE; Wed, 05 Feb 2025 15:28:48 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tfgOK-0000000Fw9I-0wES;
	Wed, 05 Feb 2025 15:28:48 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tfgOW-00000006bKZ-1Dbu;
	Wed, 05 Feb 2025 15:28:48 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: cocci@inria.fr,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed,  5 Feb 2025 15:28:43 +0100
Message-ID: <f4d11c2e43697681678cf3fe0b2781bcd3bf3884.1738765482.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [cocci] [PATCH/RFC v2] coccinelle: of_table: Do not add commas
 after sentinels
Reply-To: Geert Uytterhoeven <geert+renesas@glider.be>
X-Loop: cocci@inria.fr
X-Sequence: 2349
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/f4d11c2e43697681678cf3fe0b2781bcd3bf3884.1738765482.git.geert%2Brenesas%40glider.be>

It does not make sense to have a comma after a sentinel, as any new
elements must be added before the sentinel.  Hence do not add the comma
when adding the sentinel.

Include the comma after the previous entry, else it will appear after the
sentinel.

Add a comment to clarify the purpose of the empty element.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Add devicetree people.

This is a patch I wrote last year.
My original intention was to create a Coccinelle script to remove
commas after sentinels, and annotate them, to automate the creation of
patches like commit 0256b6aeee11d705 ("pinctrl: renesas: Annotate
sentinels in tables").  Unfortunately I could not get that work (blame
it on this being my first experiment with Coccinelle).  Hence I gave up,
and instead settled for adapting the existing script to not add these
commas in the first place...

Known issues:

  1. This generates patches like:

	+	{/* sentinel */}

     while I would prefer to see:

	+	{ /* sentinel */ }

     Is there a way to do that, or should I just post-process the
     generated patches?

  2. If the array contains a "{ NULL }" element, this is still flagged
     as a missing sentinel:

	-	{ NULL }
	+	{ NULL },
	+	{},

     Note that this is a pre-existing issue.
---
 scripts/coccinelle/misc/of_table.cocci | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/scripts/coccinelle/misc/of_table.cocci b/scripts/coccinelle/misc/of_table.cocci
index 4693ea7447534144..7ade9766dee89c70 100644
--- a/scripts/coccinelle/misc/of_table.cocci
+++ b/scripts/coccinelle/misc/of_table.cocci
@@ -37,15 +37,14 @@ struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
 	...,
 	{
 	.var = E,
--	}
-+	},
-+	{ }
+	},
++	{ /* sentinel */ }
 };
 |
 struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
 	...,
 	{ ..., E, ... },
-+	{ },
++	{ /* sentinel */ }
 };
 )
 
-- 
2.43.0

