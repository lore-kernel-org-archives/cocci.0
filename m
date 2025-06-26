Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC16C7EE32
	for <cocci@archiver.kernel.org>; Thu, 26 Jun 2025 11:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ungKwFOtEzIYKnf/yhZWuG/t/MagGOMM96bsTQ1jq00=;
  b=CDs9+C9Omh2Mk+qwfRnVMILmpm14Wv/Z3+XxJDiV6MarQZq/tgaFqmse
   fbxc+OzLA2fUNxw0tWkMSHjnGQYxYUsXwI+5q93p4GjoWdE2ccocLpQ/l
   qrVjiU5eBTGWNCqrH4oXoxoZwTx+MwqugWVAYC/NHoRjuCijIvOjb42Y9
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.16,267,1744063200"; 
   d="scan'208";a="229141798"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Jun 2025 13:19:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EFA98E01A8; Thu, 26 Jun 2025 13:19:09 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 993AAE0131
	for <cocci@sympa.inria.fr>; Thu, 26 Jun 2025 13:19:04 +0200 (CEST)
IronPort-SDR: 685d2ca5_WwYe9bsahcNFUq9m7Yoof++9AuUKOJAhNp+thQgkdztWHkf
 aq9alE9Upsp6aQyxTrCfsxHtvn0DpuSTz7njJRg==
X-IPAS-Result: =?us-ascii?q?A0FnAAAsLF1ogAwR49RaHQEBAQEJARIBBQUBQIFBBgELA?=
 =?us-ascii?q?YJDgQAGVDMEC0mEVY9QgiSEO48PiHeBVYF9Ag8BAwENRAoBAgQBAQMDAYIMg?=
 =?us-ascii?q?nQCi3ACHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QE7Bw47hXsNgluBLIEmAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQECDTpEAQEBAgEjHQEBESYBBAsLGgImAgJWBxICAQGCfgGCI?=
 =?us-ascii?q?QEGEAEDDiQHDQaxbIEygQGCDAEBBoFGAgwCQ1DXdR8sIliBZQMGgRsuAYVsg?=
 =?us-ascii?q?mQBhieEPCcPgVVEgTyDAz6CYQOCLIMOgmmCJoEWhU6Ta1J4HANZLAFVExcLB?=
 =?us-ascii?q?wWBIEMDKjQxI0sFLR2BJ4EAgU4cgySBG4RFK0+CKHuBfkwZQYNeHgZtDwaBI?=
 =?us-ascii?q?RwmQAIBC209NwkLGwY9kn+ENykCgjGkfKFCNAeCOIFmgWQMii2VPAYTL5dMD?=
 =?us-ascii?q?gaTApkFIotsgXmbNYFvDCeBXDMaJIM2TwMZD44hhDOBC4NVtSdBNQI6AgcLA?=
 =?us-ascii?q?QEDCYVGAQGKTIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:emif/aEMjkbOLU3lpLqEPMeALOsnbusQ8zAXPo5KOHlom7+j5q
 eTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/hzAV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAsxD4bbLbWSS4/yKgjWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3Aa3MfIGmuZwX7g8/ztBEPH/DjaffXOVHz5kmIAEn?=
 =?us-ascii?q?kMnRod6CYGGe+3PJbuOM7zg=3D=3D?=
X-Talos-MUID: 9a23:XeYVQQRXBriTcwTERXT3uRdHK+ZQx5jtFXIdgcQ768zabAd/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,267,1744063200"; 
   d="scan'208";a="229141776"
X-MGA-submission: =?us-ascii?q?MDHTXSW3u74GSBAjBiBMPP2PetU0frbw6lC702?=
 =?us-ascii?q?Hsn6MhtMWw8laDHuno4m3d9hG/HbFA/0H1Ph4cw9ybZiQ6782m57xJLO?=
 =?us-ascii?q?Bih2AohLyKmDR7Ur1/11lYmkb4+6Dz03W2XYvWYJdor7vp1zPruN8Yyk?=
 =?us-ascii?q?df7ihcc1fUq7gqE685CVVbYA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 13:19:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1750936735; x=1751541535; i=markus.elfring@web.de;
	bh=ungKwFOtEzIYKnf/yhZWuG/t/MagGOMM96bsTQ1jq00=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AGwyVDkVszpIu4jZ5zemtB7nhBruYc5bAPXwnjyrr7bKU7BwCv2aUeD7FWUM8KIc
	 XbePP/wTF5k4Rgc6zu3jCTvQ7bQG1CupRaeR8xPDFzHjLjxISTURUA/wA51/BJcPW
	 ArTIfZEghSPzqlfihW2JlG7vGBpF25fSX4IzN9arUZOWzZH5XpxT2OxT6h/q5CdVL
	 odQO2ptJL/KiCuN3lIZg/58jjY+U29i8mv+oqAKEimAQCU0vYU3H92eAJOVf36Ylu
	 g0RiM0IJsBQ/09U9IeMIlvn6zJ5uBJ0WFXPeuarrhvrMCB/oZ6kojFVgubWeiw61o
	 OYR1SWirlzcaqjZnxA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.202]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSIEs-1uJmII2m76-00LgRI; Thu, 26
 Jun 2025 13:18:54 +0200
Message-ID: <5682c295-0c4a-41e9-bf80-fd14fd5c94db@web.de>
Date: Thu, 26 Jun 2025 13:18:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <2dc257b4-d310-47dd-90ea-9b081727be2a@web.de>
 <481faa1d-7171-4657-8dc0-c37b153e6eaa@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <481faa1d-7171-4657-8dc0-c37b153e6eaa@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:WUmnOIsrbZmldbhsDvrqqPwFzwR8D07shP8Wv3Q1JkdxQbbend+
 RLA3Vdb5SGjKGKTfiF/1gm91RZmZy7PTx0Juinw5HBm9hoyCdDkO0tIPUJGpy1P6GsvGWex
 +nHiYNPMdVxfYnNPv61Evku8pKv7d1IpSbTQA0snP/P72ihmokDkTCOSi4/cX4un+HmsQyf
 veA6svSlrv+eZzGU8DqDg==
UI-OutboundReport: notjunk:1;M01:P0:WMbcRzyDllo=;m5JuxULKfomwhoM9nDCiZ+jejwZ
 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
 OU2CTmLzSMckt9sTaeBXQJ/SzY9UznF4=
Subject: Re: [cocci] Passing code replacements by APIs (for SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2796
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/5682c295-0c4a-41e9-bf80-fd14fd5c94db%40web.de>

> Would you become interested to convert contents from any header (or source) files
> into more advanced transformation approaches?

I demonstrated that expressions can be extracted from selected function implementations
also by the means of the semantic patch language.
https://lore.kernel.org/cocci/481faa1d-7171-4657-8dc0-c37b153e6eaa@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2025-06/msg00044.html

Now I am looking again for further software extension possibilities.

1. I would like to sort found expressions by decreasing complexity.

2. Some expressions will probably refer to known function (or macro) calls.
   How can corresponding identifiers be replaced by previously determined source code?


Regards,
Markus
