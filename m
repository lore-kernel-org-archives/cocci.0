Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F348DCEBF8A
	for <cocci@archiver.kernel.org>; Sun, 16 Nov 2025 07:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=DEGyEj9oaW7iEozQ96hpJE+hqHxMaFaIIiceFbhoMRY=;
  b=X2J4izHDkM2HKZMmXJBwy+yXMR0FxvmB/NHzojHOkv30AsP55mTvAfuI
   3v9XvxmxslHTAt1umOmAxF2RVwc01IrxgpLBqI+BG+y1zHd9QeJDOlwKi
   2815vX9PDvouaANRHhxASLyXpjc+zVJDQ0LPfPjzl49P5t9LRaehTI8R8
   A=;
X-CSE-ConnectionGUID: kHMLm4XsSi+ufOTEY7eW0g==
X-CSE-MsgGUID: DTTd785kSsCGJXN+P2/q8A==
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
X-IronPort-AV: E=Sophos;i="6.19,309,1754949600"; 
   d="scan'208";a="249372148"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2025 08:55:39 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E5FCFE0172; Sun, 16 Nov 2025 08:55:38 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5A5DEE0171
	for <cocci@sympa.inria.fr>; Sun, 16 Nov 2025 08:55:37 +0100 (CET)
X-CSE-ConnectionGUID: fK++tqkuTc+/cqXQyoCAxg==
X-CSE-MsgGUID: JCdMXkzSSy+s8KMNEO89Ng==
IronPort-SDR: 69198379_END77vebuXGTRBuquSoyMknuMnWRDiXYih+CSn7ES2mneAb
 xKt5WrDjxfUCqrTZtw5jhklxj4fI/nGXSaa3Gww==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E/DwB/ghlpgAMP49RagQmEEIECBlgzBAtJCIRNj1OCJ?=
 =?us-ascii?q?IQ7jxGMSwIPAQMBDUoEAQIEAQEDAwGEdgEJAoxbAh4HAQQ0EwECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYZPDYJbgSyBJgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAkdEAQEBA?=
 =?us-ascii?q?gEjHQEBEScECwsaAiYCAlYbAQGCfgGCIgEGEAEDDycHDQauH4EygQGCDAEBB?=
 =?us-ascii?q?oJp13YfLCJZgWQDBoEcLoVugmUBimYnD4FVRIE8C4JHMT6CYQEDgV5Ngw6CR?=
 =?us-ascii?q?yKCJoEOmWRSeBwDWSwBVRMXCwcFgSBDA4ELIw88BS0dgSQiHxAIE2A9F0CDS?=
 =?us-ascii?q?RwGaA8GgRIZSQICAgUCQDqBaCIGHBICAwECAjpVDYF3AgIEghx+ggoPiTWBC?=
 =?us-ascii?q?QUoAgELbT03CQsbBj2VHlGDOyzIejQHgjiBZ4FkDIoulT4GEy+DcQGTYA4Gk?=
 =?us-ascii?q?wUemGiOCJVzhUaBfyOBXDMaJIM2TwMZD5JUgQvDUEI1AgkxAgcBCgEBAwmFR?=
 =?us-ascii?q?gEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 chWIle6fFkyC+9cFUlvWtAPcs8fYw==
IronPort-Data: A9a23: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
 AzwUQ==
IronPort-HdrOrdr: A9a23:woP7eqvKn3jHazDls8DSrJol7skDqNV00zEX/kB9WHVpm7+j5q
 STdZMgpGbJYVcqKRcdcLW7U5VoLkmyyXcY2/hzAV7mZniAhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgjWQL/Zl5sWb+6a1gurkw25qVhwCUdAb0+40MGem+lYdfng/OXPVLu
 vm2iLNygDLRUgq
X-Talos-CUID: 9a23:xifbjW7Lwah1EwMIiNss+m1XWdw8cWDhxzSXKFaIMHduY5SFRgrF
X-Talos-MUID: 9a23:lVEJgQWkvGnYUmfq/B3HiBRSN9VT2LXtExAutLMrnJnVEyMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,309,1754949600"; 
   d="scan'208";a="249372147"
X-MGA-submission: =?us-ascii?q?MDFZYxTD5w37Tr/F8NZV46PRXSWR52pc8ZYTbm?=
 =?us-ascii?q?akYkrhD9D9B8dZqF8CKJYLdAD9sm/bWrqgLYJIWCVJ+U2c4I5RDE5N38?=
 =?us-ascii?q?ZtDPQXYPlJgXBCvsm33DxFzlii8cmDBkAQjMIElFGDYLejNlwAD8i7aB?=
 =?us-ascii?q?Gbk5b7ceazmBSBTYoJe2WPNw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2025 08:55:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763279736; x=1763884536; i=markus.elfring@web.de;
	bh=DEGyEj9oaW7iEozQ96hpJE+hqHxMaFaIIiceFbhoMRY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Oa2UdhJLxAvbl1NkwQ/04ZrKUz/TrEqPR31rneetn3TPkc3RvWjQBMlmsSANircU
	 mqtaXuqAXCCkEiDdSDq14PZg5RPXpHV3fu5HH8yXiOd7mlRUTD+X5RxKaCfPheSBX
	 wve4DnUGZ71fvxxWCXimucJH4O+glc6jV792BZ/0XERc5oAjJ/Iwp+DlVJXxX/rKf
	 RJWZlun2rygZoiSrooAKSEom6ufceGpiI2uIx0JdEH5aUclYohCAH7yLUVBk+JgqR
	 fgCTd2uoFA7pw/EP5OmWLV3SWPTlWzgspc0Cr/oUXxXGVc5U8eji/ncKmCPqGE5lW
	 wh043mWbwM/XJqDLWw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.193]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mpl4z-1vwgpZ0PQD-00ncYw for
 <cocci@inria.fr>; Sun, 16 Nov 2025 08:55:36 +0100
Message-ID: <f0241fcb-ef3b-4b76-8417-95b0a009307b@web.de>
Date: Sun, 16 Nov 2025 08:55:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <f29ecd7d-5841-4989-b3c9-1055a6df5eec@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <f29ecd7d-5841-4989-b3c9-1055a6df5eec@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5pUiukAler8454z5xwHccCVo3yI96jOpTQU+g/jIThtqeAchtuu
 CzMSCxdfcHFPsIYrELsbbF8aijIURWghWygXncc+HOozRZd2LdDAEigi4fA8t4Ztkdm+nWM
 X6a7gEr7kQ2sw2e4VjxpbMp++dl4UeZbr1tsJmdzACjuOmnt873FE0I2bFxtIy63pLSs60C
 oNj4LrXHsrdod1dEs2bfA==
UI-OutboundReport: notjunk:1;M01:P0:hUGwbyoLzxI=;CrskM6qeGnaJdgI3D4SpDq1K5TK
 +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
 zgeN3dC+14G4K1RzQ=
Subject: Re: [cocci] Missing file filters for data processing with SmPL
 scripts?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3184
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/f0241fcb-ef3b-4b76-8417-95b0a009307b%40web.de>

> Under which circumstances do you observe the information =E2=80=9CNo gre=
p query=E2=80=9D?
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/e6f8731b851f5d76d27=
31a9d546dc4f0b181526e/testing.ml#L660-679

Would you like to point any more source code places out which are relevant
for this data processing?

Regards,
Markus
