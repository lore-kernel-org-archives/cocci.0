Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97669C8302F
	for <cocci@archiver.kernel.org>; Tue,  1 Jul 2025 12:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=pCAv7ryJBgmoZUKC8A1yVDcCWhu2fq2lx4gdp7xSV54=;
  b=YDRnCSE/yP1hJe1wrhpAIDcvLbgdvIMMw1ZWd1XoKnC2FUAE409EqId4
   dTVA/8rK3ZMvnSMRmFmIe5csEeWANWwwFKF4N43i7nmxlQ/XSE2CrTRYp
   NyByVAWlR5avGWpRSiXTwBMuX4YhJKQTGanKQrkEfMeywadzICwlLt4Nz
   M=;
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
   d="scan'208";a="229793064"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Jul 2025 14:00:36 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 524E5E0AF1; Tue,  1 Jul 2025 14:00:36 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 194ABE0131
	for <cocci@sympa.inria.fr>; Tue,  1 Jul 2025 14:00:35 +0200 (CEST)
IronPort-SDR: 6863cde0_S1mnp6jyTBmkxhHfqpBqgiAHSoWHDsbDnlStUqH/KPtdT6T
 PgQdLipWjsC3HNZ8FM7EFlx745QH/Q2M+byLSRQ==
X-IPAS-Result: =?us-ascii?q?A0H/CQBbzWNogAQP49RagQmBU4JEgQZUMwQLSYRVj1CBd?=
 =?us-ascii?q?DCEO4c8h1OKTIF9Ag8BAwENTgECBAEBAwSFAAKLdAIeBwEEMAkOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgoxhXsNgluBLIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQJHRAEBAQIBIx0BAREnBAsLGgImAgJWGwEBgn6CIgEGEAEDD?=
 =?us-ascii?q?iQHsCaBMoEBggwBAQaCadd1HywiWIFlCYEbLoVtgmQBimMnD4FVRIE8C4J4P?=
 =?us-ascii?q?oRDTYMOgmmCJoEWhHqGfIw3UngcA1ksAVUTFwsHBYEgQwOBDyMPPAUtHYEnf?=
 =?us-ascii?q?4FNHIMJgQ6ELCtPgiR1gXlBGT+DVB4GbQ8GgR8bQUACAQttPTcJCxsGPZJbh?=
 =?us-ascii?q?y3GJzQHgjiBZoFkDJ9pBhMvg3GTWw4GkwKZBak8gWg6gVwzGiRPgmdPAxkPj?=
 =?us-ascii?q?l+DdbtPQTU8AgcBCgEBAwmFRgEBiAyBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:MR5bZ6NCEaSdksBcTh+jsMiBIKoaSvp037BZ7TEUdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwIk80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVyaygc378
 ddmsZFeb/NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: 9a23:61JXeG8c6HOiCxrDTrOVv0FFNsEvTj7M9lrZe0ySM3h0auaSTHbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3A+GhlDg3kj84cRbuIUS9BgrA9tzUjxY61JXE2yJo?=
 =?us-ascii?q?6gMCpaSJWPjLDpjD0Tdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="120395443"
X-MGA-submission: =?us-ascii?q?MDH4ex6ecJXr6zTni76WXgIjqhAp39fW+XRuS9?=
 =?us-ascii?q?jReB5r3OujfO7efVPvVm14fSKxxtn9a59dKMwrBxDIZRJYb7Q0pKZLBb?=
 =?us-ascii?q?Rg89HWve6B0GwsdtcpxDmhQ4CpfOIE9pqrxeHBTtUX5HT0kC5GA4+tGm?=
 =?us-ascii?q?JRzztYsfVFdSjb5EWYZTohbg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 14:00:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751371231; x=1751976031; i=markus.elfring@web.de;
	bh=pCAv7ryJBgmoZUKC8A1yVDcCWhu2fq2lx4gdp7xSV54=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IuGX8YgRT/FmqFqF+BxRnMx4VE6i5hiabtmyJYeYgR9z9MNut3700V/xlCwYeQ55
	 dREtB3OotYGkMY+OOFVIn8dlvhP1DX1j/USDRdUIQ5gYoJOmGBj5YBw5YuKTLg8A8
	 LedLGm4IhPsefv3LFL263Ymvrttzw7PXIJ9lysWKCRewbEb9TqiIP9MZwO3YzL0ud
	 ymDomyRTSen7QmisHDEvvrwfMxy9juCAK1xJl8IcoDK1VLC4yuoB1gmkozlzU+Eow
	 ZUNIOEBz1C8kqXWylR/6Q9nuuDR5AsnsmamDsNJqEd/lVXo4yJJ9xAcB09cbDeA5U
	 fUm56B9HDmt9DyRVTg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.242]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MT7aV-1u8bWy0Dsd-00MCoV for
 <cocci@inria.fr>; Tue, 01 Jul 2025 14:00:31 +0200
Message-ID: <bd958cff-a9bb-4f6e-8305-e5a09375ccc6@web.de>
Date: Tue, 1 Jul 2025 14:00:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <3675aefe-7163-4b02-a4ad-07b7a23a4b13@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <3675aefe-7163-4b02-a4ad-07b7a23a4b13@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a4Dmghqdg1EouulS3sc/zIity3w2OOrysgSKhdeJMtQPm8puRqA
 IBGIGcEJ2P60zq/SWHSVtqRLE5DdlPBAWo+jgH/nbKCTuh3xg38tdueyriZVCvjMhjOYW9x
 1of0keK61TY6yyfBIE/Xrvox9aZAbCdmVOkXgVHo+5Zs54tMwcWbfAnZOpbMbEFajhU+uBo
 2mp48uNzRFzHORyQeE9Qw==
UI-OutboundReport: notjunk:1;M01:P0:404AwrEHCQs=;wBSMkvplqaHa46f5LWCANqHLvxz
 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
Subject: Re: [cocci] Searching function implementations with variable
 declarations and statements?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2832
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/bd958cff-a9bb-4f6e-8305-e5a09375ccc6%40web.de>

> May I expect that a function like usb_ss_max_streams() can be found with=
 the help
> of the following source code search pattern?

Another SmPL script example:
@display3@
statement list sl;
identifier i;
type t;
@@
 <+...
 t i;
 ...+>
*sl


Should any diff output be produced accordingly?

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --no-loops =E2=80=A6/Projekte/Coccinelle/janitor/show_statements_a=
fter_variable_declaration.cocci include/uapi/linux/usb/ch9.h
=E2=80=A6
real    0m0,118s
user    0m0,094s
sys     0m0,025s


Regards,
Markus
