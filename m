Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48143EFCD77
	for <cocci@archiver.kernel.org>; Mon,  9 Mar 2026 09:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=GgQbVckhgGW8jAzdnaHbqifi/n1uJ4U/1Ga2qYPhdCI=;
  b=HIf+mJy3i1p9tutnu9ktwnBgfT2Znkxpkwbal/myrGNnhxv2FTLbe8W7
   QR18eBPpAwKsOxOkcMjJXUQILf2LBHnVOkNPFHcJ4xehlLKHSyXh/f/M4
   u04X/hwYM0Y8R2s8LPSp+Drs2LqGpm++u3KN0sAnCtZm0u9iohbVX8E5y
   o=;
X-CSE-ConnectionGUID: yUrTlXPASL2u86K7TCs/Dg==
X-CSE-MsgGUID: IbcjfvBRQU28UpEW4pvDNQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266839789"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2026 10:49:36 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id F2025819B2; Mon,  9 Mar 2026 10:49:35 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id EAF73804B4
	for <cocci@sympa.inria.fr>; Sun,  8 Mar 2026 11:09:06 +0100 (CET)
X-CSE-ConnectionGUID: uyvXqhVHT/yVDUwpDNckAQ==
X-CSE-MsgGUID: 2TjmpKDUSnmqlfO753Efpw==
IronPort-SDR: 69ad4ac3_gwPPBb6JRhSp9eEArTASM63fqSVnLxdUDNlTVy1W4aURB9j
 O9tjIPE3b2JSPk4f/FdNmaQzUsS33wmfTtN6Jiw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EECABaSq1pgbPWVdFaglkCgj8WcV8zBFSNU4cyAQEBB?=
 =?us-ascii?q?oE+i3eHWIwOPQIPAQMBCwEBPRICBAEBAwSFAI0jAh4HAQQzBg4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBIhkHDjuGTw1JARABBAGCA?=
 =?us-ascii?q?gFYTGECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQoCDR9hF?=
 =?us-ascii?q?iABDQEbHQEDEhApMgIRAQUBIgESIoJgAYIiAQYQAQM2AgERnW+BAkKMUgUCF?=
 =?us-ascii?q?oEBgg0G2mUKGSgNcYFhAQICAQYJAQoBAYE3AYR2KV0BgjeFIIR0gSEbfYEQh?=
 =?us-ascii?q?H2CH0IDgSZOhg0iBIIiehSTKwgHHxIIARwGCgJIFRIDBAMEBAECCxMJAwMCD?=
 =?us-ascii?q?gIIAwIIBhkBPxIEEwoDCgsHBR8KAgwUCigiEgIpCgMgCgsSDwMYFQEBBwYCA?=
 =?us-ascii?q?gMBBAIEDAIJAgIFBAMCCgcDBAEBCAICLQMBAxkICQgCCwURGAwLBQIKJwMPA?=
 =?us-ascii?q?QkDHxcZCAFFCAYWARoHBQYLOBUFDBERAQIGBQMCAQMEAwMDAwMCBAICAgIGB?=
 =?us-ascii?q?wsMBAQEAwUDAwUGAwEDBAMIAwoCBBgGBQICAgECDAwDAwoEBAMCBQIGCQMCA?=
 =?us-ascii?q?wMEAQM5HBMEBQIFAwMBOgMOBAMIHgIBAQIGAgEDAwgCAwEDAgcDFAUBBggCB?=
 =?us-ascii?q?AQKAgMDBwYFBwIRKAQCAgICBAMDAwoHBwQDAQcDAwwCAhACBAQCFAMDBAMQA?=
 =?us-ascii?q?wECEhgGAQMHCAMCBwQWAwIJGQQCBAMCAgICAS4DBQcCBAEHAQMDBwMCDAICA?=
 =?us-ascii?q?hIFBAYCAQMMAwQDBQULLREHEwoGBAcFAgICFAYCBAwSAwMEBAIBAgICOgQID?=
 =?us-ascii?q?BoOBAgHAwcBGAUCAwIFAQMBBwcSAgoIAw4BHQICBAIJAQEKDwICAgQCAgEDC?=
 =?us-ascii?q?BgDBB8EAwMHAgIMCQMEDQISChIbAw4DDRIHBAMMCjALDgQCCQgDDQILCwYFC?=
 =?us-ascii?q?gUZAgICBgIDAwMCBQkBAgEBAQEBAQECBwMDAwIDAwYDDwMODwMLCQgHDAE8D?=
 =?us-ascii?q?AcKKAQ2AQYOFAcEJRlnBweNfD6CMwFYCS0qAoEYl3aPD6AgcWiDPowejz6Ff?=
 =?us-ascii?q?BoeFZdSkxgBiCmQXSKNZ4QJkkeEPQIKBwcRJBKBSCSBXE0jgQGCNk8DGQ+SI?=
 =?us-ascii?q?YUTxEE2NQIBOQIHCwEBAwmFSIlCgksVNIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:A1OXwq49k76eza7zSwPXwBvXdLJyesId70hD6qm+c20wTiX+rb
 HVoB1/73XJYVkqKRcdcLy7Scu9qBDnhOVICOsqTM6ftWDd0QPCXeJfBOPZowEIcBeOkdK1u5
 0QFpRWOZneC0Nlhd327AT9P9Er28mf7ayk7N2z815dCS9vL49vhj0WNu9ZKCJLrct9aKbRbK
 DsnvavbgDARUgq
X-Talos-CUID: =?us-ascii?q?9a23=3ASbrNHWscEh+lX4fmCd08WFNG6Is4Y2Pt1XfuA3P?=
 =?us-ascii?q?/GFhFdaKNZXmb+4pdxp8=3D?=
X-Talos-MUID: 9a23:VxuZhAtajWyXlOh/fs2n3g1gMd9Lz5mVDkUUlZsh5JTfGCJoJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,108,1770591600"; 
   d="scan'208";a="266730697"
X-MGA-submission: =?us-ascii?q?MDGdBv8N2T1m0Q6eRKI0kf2YPedH7NpX49ykvq?=
 =?us-ascii?q?svIr4v3RaArs5SAgVaI7K9N5bcoZRO8pnGxhTox9vBWkfcLYXJPN1xQG?=
 =?us-ascii?q?zisOeMm0C94xsHENSlmpBHGNcAYvBK1ne12/2cd2lDLCuk4BjpoEd0Jv?=
 =?us-ascii?q?xdTEeXux97mt0wLi2eKDVsPA=3D=3D?=
Received: from mail-pl1-f179.google.com ([209.85.214.179])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 11:09:06 +0100
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2aaf43014d0so79618605ad.2
        for <cocci@inria.fr>; Sun, 08 Mar 2026 03:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772964545; x=1773569345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgQbVckhgGW8jAzdnaHbqifi/n1uJ4U/1Ga2qYPhdCI=;
        b=g4nwpB9V1mFwQSAnjZlwplmMxNfOlubxM6ia3hVAdUoCAnXWPLid4sl1hGSF+2oTIh
         pi5b0PmBL5DNWYf8hcATLRcKjBuLYHJnqU8JqinrT/8444B72sJj2vPrra+pGabcLsLL
         ie2P1LdHlvprmkNHNmRI+a/uFevF6hyeNyDqXTjyaVonQcuSDsW5px7qDfyGY5C3CMVk
         h2Nuqbp9dvCpLZtcLX+7juJrgW1lISx9GY931r6k7qxdTtwrXNvhGmLZMRpHSakrlLZh
         tFYhBKVvY+NrMpTG3RgadEr7UGNOs7yfSKuS8QIcRT8VBhrAwWluCP+YeHS7vrZOjTiJ
         GQzg==
X-Forwarded-Encrypted: i=1; AJvYcCV6d2gvJ7MRZbC8PXPmkLNR7qO6ZoUna68eFLBq9msX0W9GFdFmsxPtV3h4eg0duTCri7kYIQ==@inria.fr
X-Gm-Message-State: AOJu0Yxbsj8RlQlzsoykonzyTP94lYJUYuYgVRuz13Wm9mBKdbeBh5b7
	jZs+2h/Gr3dllncFgbMhQ0HtV8xMtGwFzTWYUoXTMR5Gfr4clsWyrj1m
X-Gm-Gg: ATEYQzwwaXhTNBnappBKVa83u/4KR753gnck8S6KER228C3+5NiU+22S8b4JrUSjPMG
	s5nuFiWCNvENNrCzezIMuaqyND9phizkfClx956zdEqdvvM/T0Lyel5AlFM0TEehYO8nFt0BHqm
	LAgugEFaVzMuXrBWWFXjgyGc/CRedJcCsd0a9sGtXei5ntT2bABn6dUeQsEBBE2AoW1ChtWI/mF
	CpaYt8YUOQbWpJMq+IKno/msxPmqMUVV4ZCN7r1oFfOQ/tv7uQlZU1/NBdemueHqUcT2LW454gf
	nBma5bCseo+U+JCMYKoGOmpyWzMqZMfbWH3Wbi8I2BhuayIlkNAqwT6WqsvvxeCAZatId7Der3C
	szke8bZ3V/qjPBqTBRmv0Atmuk2C363af9AFzrEpbmjGF7CBTGp4lCaJf79/kMBBWh6q60Gjw72
	VXJ8ux8esRM2QlBY/QSzq/2K5E293FALHDHS6LGZhU
X-Received: by 2002:a17:903:2c04:b0:2ae:4fc2:d951 with SMTP id d9443c01a7336-2ae8243b629mr81098495ad.27.1772964544798;
        Sun, 08 Mar 2026 03:09:04 -0700 (PDT)
Received: from russ.ust.hk (wf121-083.ust.hk. [175.159.121.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e58592sm102980485ad.14.2026.03.08.03.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 03:09:04 -0700 (PDT)
From: LIU Haoyang <tttturtleruss@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: LIU Haoyang <tttturtleruss@gmail.com>,
	cocci@inria.fr,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Sun,  8 Mar 2026 18:08:50 +0800
Message-ID: <20260308100851.341-1-tttturtleruss@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH] docs/dev-tools: fix a broken URL in
 dev-tools/coccinelle.rst
Reply-To: LIU Haoyang <tttturtleruss@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3351
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/m0hWfAQRffWAIPPOfvzrdw>

The original supplemental documentation for coccicheck is
https://bottest.wiki.kernel.org/coccicheck, which redirects to a not found page,
thus change it to https://bottest.wiki.kernel.org/coccicheck.html,
which adds a suffix to original URL to make it direct to the right page.

Signed-off-by: LIU Haoyang <tttturtleruss@gmail.com>
---
 Documentation/dev-tools/coccinelle.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 2b942e3c8049..f73ccf5397f3 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -61,7 +61,7 @@ Supplemental documentation
 
 For supplemental documentation refer to the wiki:
 
-https://bottest.wiki.kernel.org/coccicheck
+https://bottest.wiki.kernel.org/coccicheck.html
 
 The wiki documentation always refers to the linux-next version of the script.
 
-- 
2.53.0

