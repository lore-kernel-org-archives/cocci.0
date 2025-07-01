Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B0EC8302F
	for <cocci@archiver.kernel.org>; Tue,  1 Jul 2025 11:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=AtCcNmpNa6TRDlw9MsqdGEPA9NJG8oGqbnuHZDMXwzw=;
  b=AdcPDTV1LA4qjYKLDoEmCjRsvOVLWRDTFsY1rFhXwmyXztspmljkCHBZ
   H6vLlf02p6Po65P1uTsNTXyEVcP1/91SfrSeKnrBpS9W4SVMTiVBEHo88
   cpCfxZwwFp/fmPPf7Qh7fqH6zuc5PldQNQGkRKpJEABapE+KPp12vfHUM
   8=;
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
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="229791594"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Jul 2025 13:54:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5D9D5E02E4; Tue,  1 Jul 2025 13:54:34 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id F08E0E0157
	for <cocci@sympa.inria.fr>; Tue,  1 Jul 2025 13:54:28 +0200 (CEST)
IronPort-SDR: 6863cc74_iM/JIB9UDBa/U1DkHtz7Zt4+w1X6OEXwMwFR28ZPIx+ti6a
 51QrVe3NK6EeS1MHZy5nnincDupjsXSogKjRXsQ==
X-IPAS-Result: =?us-ascii?q?A0H/CQBwy2NogAMP49RagQmBU4JEgQZUMwQLSYRVj1CBd?=
 =?us-ascii?q?DCEO4c8h1OKTIF9Ag8BAwENTgECBAEBAwSFAAKLdAIeBwEEMAkOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgoxhXsNgluBLIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQJHRAEBAQIBIx0BAREnBAsLGgImAgJWGwEBgn6CIgEGEAEDD?=
 =?us-ascii?q?iQHsBuBMoEBggwBAQaCadd1HywiWIFlCYEbLoVtgmQBimMnD4FVRIE8C4J4P?=
 =?us-ascii?q?oRDTYMOgmmCJoEWhHqGfIw3UngcA1ksAVUTFwsHBYEgQwOBDyMPPAUtHYEnf?=
 =?us-ascii?q?4FNHIMJgQ6ELCtPgiR1gXlBGT+DVB4GbQ8GgR8bQUACAQttPTcJCxsGPZJbh?=
 =?us-ascii?q?y3GJzQHgjiBZoFkDJ9pBhMvg3GTWw4GkwKZBak8gWg6gVwzGiRPgmdPAxkPj?=
 =?us-ascii?q?l+DdbtPQTU8AgcBCgEBAwmFRgEBiAyBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:vVp3N6DLIuBnU7LlHely55DYdb4zR+YMi2TDpHoBLSC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBDhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOk9K1vp
 0BT0ERMqyTMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:BL/kBG0XtEvIR/mjw9NRc7xfGvBmVFuFl1PsCBGVOFRQZoO4Rm2J0fYx
X-Talos-MUID: 9a23:AxZgGwgXOU8AFK6WGELwc8MpF9wx3YaoAns2ipQissu1ETd+EWqwg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="229791571"
X-MGA-submission: =?us-ascii?q?MDFPHwyeFvfyBck9d5HGda3/eU9/AgsqNLyac5?=
 =?us-ascii?q?5DFnJjiWbU4aCa2NBxFrL7tG3ODfJGB6RelqqKmcSn6BcaRB7eD4Uh78?=
 =?us-ascii?q?I6tsqsE+wRTh3BAfxyka+jP/S2CJUR5cfH/UVH02NArmMVuWNSq3OKQL?=
 =?us-ascii?q?1PW4DNZ9Xr6yZvBIf84fRNww=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 13:54:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751370867; x=1751975667; i=markus.elfring@web.de;
	bh=AtCcNmpNa6TRDlw9MsqdGEPA9NJG8oGqbnuHZDMXwzw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XF2yEXS01phsl8Nu58cdQlBztyT/BCCNwz3HR5uCbk6Cr1fMiFF0Mvc72MssSwPa
	 OYkOD/ECPWsscaKwi2NnhVb7h9h4HVNmJ3gF/KCJWW/IwNgYjfrBGPAKh0vE0hJvm
	 45r0dUtOYnUN3qvglDhbWhEiyvplG5TWsta9Baod7txYlD1aW56La5gCOia/4Isty
	 gxvDjOFN05qi0AdgehTuZ5yrhtlzGHbFH+eJ/34utIRRGHuXNmKEXjjO4bar3RAxQ
	 rbT5vjoUKB1LMDPDpZ85qOPP+1wjlSxLloxj19pSD6K5icHQ7jc9ZLl/D0uhqlP1T
	 4P6p8bkLvWDoMw/MZQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.242]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mf3qY-1vBh4j2QHa-00jQbK for
 <cocci@inria.fr>; Tue, 01 Jul 2025 13:54:27 +0200
Message-ID: <701689c5-3003-417e-91bf-866355e2fe65@web.de>
Date: Tue, 1 Jul 2025 13:54:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <3675aefe-7163-4b02-a4ad-07b7a23a4b13@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <3675aefe-7163-4b02-a4ad-07b7a23a4b13@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WiVBp+HIlY9QRHJyugCXfZBvsGPqUumyGRFC3MDVJ50VlpHKc4D
 ZR0THvgGUKMOH217nvQPR4V5A/v03bdrRqBvuz1nPLx1+PBw2yMZkmZYf3N1VLLndslxOkz
 /MAUJksO7xJLuZ7+KYDjb8D918W0OBE3GjWu7yDs4j+KE+8LYfQAWa4T5nIp1GctZ18B7SL
 tz6p01zKCYfJQLHv/1uWg==
UI-OutboundReport: notjunk:1;M01:P0:i4rDWa2mgNw=;yTlxKNUG8beB2YVlg1w2PL9QKdn
 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
Subject: Re: [cocci] Searching function implementations with variable
 declarations and statements?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2831
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/701689c5-3003-417e-91bf-866355e2fe65%40web.de>

> May I expect that a function like usb_ss_max_streams() can be found with=
 the help
> of the following source code search pattern?

Another SmPL script example:
@display2@
statement list sl;
identifier i;
type t;
@@
 <+...
*t i;
 ...+>
 sl


Should any diff output be produced accordingly?

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --no-loops =E2=80=A6/show_variable_declarations_before_statements.=
cocci include/uapi/linux/usb/ch9.h
=E2=80=A6
real    0m0,138s
user    0m0,101s
sys     0m0,035s


Regards,
Markus
