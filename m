Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93B9CFD2F6
	for <cocci@archiver.kernel.org>; Sat, 29 Nov 2025 14:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=aUCP5Cn1+hlI94okpUkavz0MUc2QGNL1cu5dEXViMfc=;
  b=bm7u4NagcJYVOVe32JjNfXKQDh/nEMYlwp8eSPZlkTCmSmv/oJwKsfKz
   uNjegntKwv+CmkbiY3YGl6gk0KZ5AJ230JS1LmjO6gjtG9sGqysRU8kF/
   QG2DEZ4jSxww3EkDJFyLHTdcZa7gnVFEPti2PMl4tgHKaE/lACMxqGvK/
   4=;
X-CSE-ConnectionGUID: sxs3yLr+TsyThP7YV/FU7g==
X-CSE-MsgGUID: iOHOgfJAQMafpB47iblfBg==
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
X-IronPort-AV: E=Sophos;i="6.20,236,1758578400"; 
   d="scan'208";a="251892107"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Nov 2025 15:52:00 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AF512E0260; Sat, 29 Nov 2025 15:52:00 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CC5C7E0157
	for <cocci@sympa.inria.fr>; Sat, 29 Nov 2025 15:51:56 +0100 (CET)
X-CSE-ConnectionGUID: qFE4YzKhQ5GtW6So0nHEuQ==
X-CSE-MsgGUID: Ep7jiEi7THWv8NO2jAuCvQ==
IronPort-SDR: 692b088c_Htb2DJ6iLrzoP7qM7reqpV96tN2Rw987iURghXsYL+7sVvV
 XGdSXYRHgxz/0Lk2scoWnfg6hBR2wDv5raFgrOA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GBAwDwBytpg07ASNlagQmBUIJAgQIGWDMEC0mEVY9Tg?=
 =?us-ascii?q?iSEO48Rik6BfQIPAQMBDT0RAQIEAQEDBIFMgm5GAoxlAh4HAQQwCQ4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBAToHDjuGTw2CYgGBJ?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBAQEBAQEBFwINOkQBAQECASMdAQERJgEPCxoCJgICV?=
 =?us-ascii?q?gYBFAEBgn4BgiIBBhABAw8nBw2xR4EygQGCDAEBBtpfHywiWYFkAwaBHC6Fb?=
 =?us-ascii?q?oJlAYpmJw+BVUSBPAuCRzE+gmEChTuCaYImgQ6BcoQykzJSeBwDWSwBVRMXC?=
 =?us-ascii?q?wcFgSBDAyo0LSMPPAUtHYEjIR0YEWA9F0CDSR0GZw8GgREZSQICAgUCQDqBZ?=
 =?us-ascii?q?gYcBhwSAgMBAgI6VQyBdwICBIIWfYIKD4gLgQkFLoENAgELbT03CQsbBj2VD?=
 =?us-ascii?q?VCCKIFBIoFio3uiezQHgjiBZ4FkDIoulT4GEy+DcZNhDgaTBZkGIo1mmzmBa?=
 =?us-ascii?q?DqBXDMaJIM2TwMZD446JYNCM8R4QjU8AgcLAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 kFucjvJFes5Z1pIcGd2lEnDtJEJFfMOFcV5
IronPort-Data: A9a23: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
 N0AgKXOxMk9sfl5nc3A3ene
IronPort-HdrOrdr: A9a23:u46Eka2lXEOXtxD9oPjgqAqjBGYkLtp133Aq2lEZdPWaSL39qy
 ncpoV/6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyTMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: =?us-ascii?q?9a23=3AxqTY6GoUg7K6bYdDtZbmdhjmUdkLXyHs3lTQGhK?=
 =?us-ascii?q?XFVk3c7rNT3+95Zoxxg=3D=3D?=
X-Talos-MUID: 9a23:gCX5egSW6drpnCJSRXTBnG5gNeppvJiON15dt7JcueCZHjJJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,236,1758578400"; 
   d="scan'208";a="251892102"
X-MGA-submission: =?us-ascii?q?MDGyXHQGccUlKpAsYGyHBN82vrDHSl+2KN2MDo?=
 =?us-ascii?q?iVkl9Si+uG54Ccyi64pgJlyJ1n9E6LRkAtkKW/Vybs0Yto6xlmgqz8J0?=
 =?us-ascii?q?3udQ0UjCYqFrAFFvKA8MNy3SfXe0ANIDXGNFzm/Mw7rlQPr/Spb/WaXa?=
 =?us-ascii?q?uJXRO6katyNGg26j3WoMm5FA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 15:51:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764427915; x=1765032715; i=markus.elfring@web.de;
	bh=aUCP5Cn1+hlI94okpUkavz0MUc2QGNL1cu5dEXViMfc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RRuWQS444CwFrQ6pda/f9NRsVjq+p+2DiIhG/4rMmsqSYHFCZoqOLuuOTZSWhjBS
	 8sR7QJQ6x8+j6S/fU7nyPkcN0G1QqzT2GyCNd811ASu6a2xdtmHYG93qKEygbWy4B
	 o9ES+zHYBTSS3qOFwc7ePzLaEIG/xMJsZ8JhGiO8rcoriCJ+KEGpQ8Se9ohyhkXlo
	 HTGNyA0S5TMo1Ln6/qVhhda6zr5KLt/wboSk9Jy5UxSOd8bxTCpyBeEyObwPuiO6C
	 aG6jU6k+pTfDaQq537Aw3OfQcYuV+M0twcECFpUDtBQG3+TeuGHQsE91ftcptsBAC
	 RZ0vQZYiRckLwifrYQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.187]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4KJX-1vP5Jr3ugD-00Gyoq; Sat, 29
 Nov 2025 15:51:54 +0100
Message-ID: <24d6e1ac-0dcb-4334-bc44-65c3012f7764@web.de>
Date: Sat, 29 Nov 2025 15:51:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>,
 Tobias Deiminger <tobias.deiminger@posteo.de>
References: <4f6e259891de0666aa1fa10b810a5dd3@posteo.de>
 <b4884a21-4a59-c549-8466-164a20a76abe@inria.fr>
 <2897bda0c438111e967017f6bb3422f0@posteo.de>
 <caf02577-eee9-d55d-1f42-7b1f3bd2f60@inria.fr>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <caf02577-eee9-d55d-1f42-7b1f3bd2f60@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s2bB8QzFmW/12+wZV9FXkpaeDqryWlFIikEW4+tdh4ER8h3rn1R
 Pwt3SbABAbgye2OE/i6cj00hgtUM3sxyBh1n0WzYxp6NLY4pUgtduOAIW/eV5KpYXjGgDuE
 HsbWPc5Z9DhNmQrTbijAxvXexm9CzTBx3mp5Bx/lPRDPjFRAPFq+p1Wka4PK/qAJFYCw33b
 yjksRwxymOOGf5GFhUTfw==
UI-OutboundReport: notjunk:1;M01:P0:5CSuJeAeB1E=;0B7l+9uEud8SVOhSzh2nnkm0qiv
 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
Subject: Re: [cocci] Can we match a known macro by macro name instead of
 expanded function name?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3209
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/24d6e1ac-0dcb-4334-bc44-65c3012f7764%40web.de>

>> How else to look for functions with attributes then?
> The return type for the function is required in this case:
>=20
> @r@
> attribute a;
> identifier fn;
> types t;
> @@
>=20
> * t a fn(...) { ... }

Would a similar source code search approach become interesting
for further clarifications?

Exclude macro calls from searches for function implementations
2024-10-28
https://github.com/coccinelle/coccinelle/issues/381

Regards,
Markus

