Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FB7D111A8
	for <cocci@archiver.kernel.org>; Mon,  1 Dec 2025 09:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=1T/dAcnQcnPMN+4st3QNuoKDWXPoZ+Atp918VgpxXIw=;
  b=EZPVIrFFHh2kg1mmlnFMsRFa4Glqk9S6Brq0Wog7VcdDIIQfiFFbBh4Z
   HNEgex4LI5WFCswsvdp7LD2S/YKo3UucGahbM3OsNZyjke+mi06Tt0sIZ
   SQ58zS/DBUKS2WbAXoSjwMRNFY3tz4TrRqv5AnoZyXld70HcNxtKuom2g
   8=;
X-CSE-ConnectionGUID: faE6fY0RSfyBw8V+85xw9Q==
X-CSE-MsgGUID: B+LCY9aRTYmMcaltz/XAYQ==
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
X-IronPort-AV: E=Sophos;i="6.20,240,1758578400"; 
   d="scan'208";a="252053729"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Dec 2025 10:43:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AEF1BE0AF1; Mon,  1 Dec 2025 10:43:09 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6AFA3E0157
	for <cocci@sympa.inria.fr>; Mon,  1 Dec 2025 10:43:07 +0100 (CET)
X-CSE-ConnectionGUID: yS7oOpFlR/ygxnIU13740A==
X-CSE-MsgGUID: uNQ/05UPRES1qarO6ODy1Q==
IronPort-SDR: 692d632b_8cmG+8ViYks5DMzy4X8PvucsJti+m+injjdN7KC8TgkpIeT
 7zDmKBJ0bNk6WY1JRXA3eGX84l9a+ZT8Sbohq+Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EnAAASYi1pgwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwHAQELAYI/gQIGWDMEC0kIhE2IHIc3giSEO48Rik6BfQIPAQMBDUoEAQIEA?=
 =?us-ascii?q?QEDAwGBTECCLkYCjGUCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQIQAQEBOgcOO4ZPDYJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQINOkQBAQECASMdAQERJgEECwsaA?=
 =?us-ascii?q?iYCAlYGFQEBgn4BgiIBBhABAw8nBw0GshGBMoEBggwBAQaBRgIQQdhGHywiW?=
 =?us-ascii?q?YFkAwaBHC4BhW2CZQGKZicPgVVEgTwLgkcxPoJhAQECgV6DW4JpgiaBDplRU?=
 =?us-ascii?q?ngcA1ksAVUTFwsHBYEgQwOBCyMPPAUtHYEjIR0YE2A9F0CDSR0GZw8GgREZS?=
 =?us-ascii?q?QICAgUCQDqBZgYcBhwSAgMBAgI6VQyBdwICBIIWfoIKD4gGgQkFLoENAgELb?=
 =?us-ascii?q?T03CQsbBj2VDFCDEC4rgVGkLqJ7NAeCOIFngWQMii6VPgYTL5dSDgaTBZkGj?=
 =?us-ascii?q?gibOYFoOoFcMxokgzZPAxkPjiEZJYNCM4ELw3pCNQIJMQIHAQoBAQMJhUYBA?=
 =?us-ascii?q?YxWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 PwhrIfvNMklYQl5TA==
IronPort-HdrOrdr: A9a23:Db2okK37klIXL4R0/WptqAqjBGYkLtp133Aq2lEZdPWaSL3+qy
 ncpoV/6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SODUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyTMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: =?us-ascii?q?9a23=3AV3hSB2g3WbtO9igWJnoyyPIGvTJuY0aCy1DIDUu?=
 =?us-ascii?q?CTndmWLu0dAbLp/88up87?=
X-Talos-MUID: 9a23:as+1agqrT2M93s2leZIezyxEDYAwvpmWMm02yIwPoe7aEgBhYg7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,240,1758578400"; 
   d="scan'208";a="252053721"
X-MGA-submission: =?us-ascii?q?MDH+VY1tDyzg/3La6z987AnhAjOE7DDXSexyVU?=
 =?us-ascii?q?gMkGTBO4phDCO0AmGjMBl4atpy4YzwCnvNFMsJizMdfWmfxuI2MzVxj4?=
 =?us-ascii?q?t5o58SnxDPLjN8YIJaD/t6kezcUtydPMu/+e4C4u2PP/pWtNvVdRWVew?=
 =?us-ascii?q?SrqTxw3x/+6A84c0eV4H+AoQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 10:43:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764582185; x=1765186985; i=markus.elfring@web.de;
	bh=1T/dAcnQcnPMN+4st3QNuoKDWXPoZ+Atp918VgpxXIw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SzQE4VVtRsfSnBr0+zClJbWB6yCilLYPZ+Lfcvx3bZMalutB+Kl3VEuAtLb0vPs3
	 gkbftVtJ8inykuF8AK/fStmIeLG68nIjT+yCx5BCw7aDmvBxENhthJQF9XUHTJb1u
	 4FmjBbB5JhQTPGLUaM1tIOoV3GKk2xXK8NfgP/pr8Cle8EbXx7EEa3Tnv6g0U5IXm
	 8k5HZv5es3MteJmJcONu4F+iZqET7dLUUyhLJVUy+HxZZWxUNzgJ16BgTbsGdlFKD
	 VXJx6dUZPRGjgiNMGeAOCYh34ZmJlZ3MZhBX1ErDyfN9dSfvGptjN9hb+uXIYo7Qw
	 ggnRbK/HhQGDRoI3jg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.215]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmho4-1vpxaJ1RPq-00gSPx; Mon, 01
 Dec 2025 10:43:05 +0100
Message-ID: <f7a8a978-ca23-4486-a744-3e43ea0ef307@web.de>
Date: Mon, 1 Dec 2025 10:42:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tobias Deiminger <tobias.deiminger@posteo.de>
References: <4f6e259891de0666aa1fa10b810a5dd3@posteo.de>
 <b4884a21-4a59-c549-8466-164a20a76abe@inria.fr>
 <2897bda0c438111e967017f6bb3422f0@posteo.de>
 <caf02577-eee9-d55d-1f42-7b1f3bd2f60@inria.fr>
 <3ae5bc93f8cae1f28a068d89d3d1b070@posteo.de>
 <67f9e0f2-fa4e-c7a-d388-3732d8aec1e6@inria.fr>
 <67d1e00d2e22a4655cb10ec55d1a99db@posteo.de>
 <83c8a7aa-9b98-8ac1-d563-e8fe2588f9a@inria.fr>
 <fd7307f8024706d4bd128d0b7f43bb96@posteo.de>
 <29c204aa0f1f08074279425b7de42dd7@posteo.de>
 <825ab32a-2544-d2a8-bc48-38f26c62bc@inria.fr>
 <ded004b275d73e35c46c3d30c057d58e@posteo.de>
 <e88c503c-b2a1-454b-a4a4-ae2dedd79daf@web.de>
 <893abd46009f5e07e55f6b3f36645eda@posteo.de>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
In-Reply-To: <893abd46009f5e07e55f6b3f36645eda@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:77odtVWkvMZQake8WTQmhjqfQ+7J9X1yND4kw3BJ/pZg5DMUIFo
 xBvoOZSyqVhAc+j+go7J977UBdeATT/a0p2XyfwSkuO18kCHn/fsG1eABpfHAvC9BVhMqd+
 F25bXhwGYKZRFPfKBgFpvknjaV6ykWuIOAagR4ttREP0M1hje8GcOFSsuzgBNyll8kLvv9u
 ssF4aMDOcLl+LMIJUtSKA==
UI-OutboundReport: notjunk:1;M01:P0:Vp2E0SRBdIM=;gkT5gQgmo4Tmz0Myhzco0IndmKe
 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
 0eZgVEQ+VbF2q/9hYLm357JHLUtSv
Subject: Re: [cocci] Can we match a known macro by macro name instead of
 expanded function name?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3227
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/f7a8a978-ca23-4486-a744-3e43ea0ef307%40web.de>

> I observed this while looking for standard.h modifications that =E2=80=
=A6

Further information can eventually become helpful from known development h=
istory.
https://gitlab.inria.fr/coccinelle/coccinelle/-/commits/4c9d00ae071800cb44=
7efaffd753f3bb2be28800/standard.h
https://github.com/coccinelle/coccinelle/commits/master/standard.h

Program parameters can influence the usage of header files.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/4c9d00ae071800cb447ef=
affd753f3bb2be28800/docs/manual/spatch_options.tex#L407-450
https://github.com/coccinelle/coccinelle/blob/4c9d00ae071800cb447efaffd753=
f3bb2be28800/docs/manual/spatch_options.tex#L407-L450

Comments contain hints for the handling of =E2=80=9Cbad macros=E2=80=9D.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/4c9d00ae071800cb447ef=
affd753f3bb2be28800/standard.h#L2-56
https://github.com/coccinelle/coccinelle/blob/4c9d00ae071800cb447efaffd753=
f3bb2be28800/standard.h#L2-L56


> So far I think Coccinelle is an amazing tool.

Yes, of course.

This software is still improvable in various ways as can be seen by some k=
nown information systems.


>> There are promising software tools available.
>=20
> Probably :) Do you have other suggestions?

I came along related development ideas.
The discussion can eventually be continued accordingly.

Regards,
Markus
