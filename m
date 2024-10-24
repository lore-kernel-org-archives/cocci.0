Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEC9CE8E6E
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2024 12:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=caBVJVv7nT0Cz4UrfmRZGmNkeOC3QOLv18cfDhmAqCA=;
  b=DrUfs7ydgGWjyH0ngSDS0x4T0XecMmWzZuIxLEVkDUhpglyM+DZuFsp3
   dYnXaiWpxsCY7tevCT6JpH0GbmQ72iKzzD70VELlZ7yyqzQG1v12efLaG
   8WkWP6OE6+SGBTGg6oU1mwFqyI9DJ0or7qN/ffOP6NME8UEp9PrDdWqhB
   4=;
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
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="190549946"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2024 14:43:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4A6BDE0D1C; Thu, 24 Oct 2024 14:43:05 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E63C9E0133
	for <cocci@sympa.inria.fr>; Thu, 24 Oct 2024 14:42:59 +0200 (CEST)
IronPort-SDR: 671a40d3_J6vmmBQxkPcC+c3eoG5dJ+9iQC24nho3K0YruuHl5Q8L8Gn
 qDQPGs0VmSnGCtRsPo2GW1jdAc1+d47m9JjpCzw==
X-IPAS-Result: =?us-ascii?q?A0EKAABWQBpngwsR49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYJDYhtaMwQLSIRWiB2HMIF0LQOEO48OiHWBVoF+DwEDA?=
 =?us-ascii?q?Q09BAECBAEBAwMBggyCdAKKJAIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABA?=
 =?us-ascii?q?QUBAQECAQECBAYBAhABAQE6Bw4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQINOkQBAQECASMdAQERJwQLC?=
 =?us-ascii?q?xoCJgICVgYBFAEBgn0Bgi8BAw4jBw0Gr2yBMoEBggwBAQaBWEHYQh8sIleBY?=
 =?us-ascii?q?wMGgRouAYVpgmIBhiSEPCcPgVVEgTyCSzg+gmEBAQKBNSmDW4JpkgmCEIlaJ?=
 =?us-ascii?q?YhBboJAhTOJXVJ7HANZIRMBVRMXCwkFiTUKgxyBbiaEEQiBKxODX4FnCWGHZ?=
 =?us-ascii?q?V2BDIE+gVkBRoJySoNMgWEFOEmCTWpONwINAjeCJCRcgk+BJQQFgzyBIB1AA?=
 =?us-ascii?q?gELbT01CQsbBj2rdIFZR4JcaFlPLApAL8ZBNAeCOIFlgWMMiieVLgYTL5dAD?=
 =?us-ascii?q?gaSeJh3Io1bmyOBZzqBXDMaJIM2TwMZD44hGYNhM4ELyQRBNQIJMAIHAQoBA?=
 =?us-ascii?q?QMJhUYBAYklNIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aXZhYyJfa1jdXPMLA==
IronPort-HdrOrdr: A9a23:us0rpq3d/PLCKrXOuhok8gqjBGwkLtp133Aq2lEZdPUnSL38qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFhbX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AtHpevGvFSnLLyEPbWE2eeRJa6ItmeWyG71OMGHa?=
 =?us-ascii?q?7BGBgRYaLT2eOpbpdxp8=3D?=
X-Talos-MUID: 9a23:Kt26yQZFjt39FeBT8C3CiypSCdhSsuexOVlSyIsLq4qAHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="99951045"
X-MGA-submission: =?us-ascii?q?MDEOg6KL8x+zwVEBvRtQfmIB7rb0pFOQ22L4d+?=
 =?us-ascii?q?W94YL16qj6G3b/C9zYJeU1/w/3/OEk79MN+p3bcqFokjWkyArQNWsUsp?=
 =?us-ascii?q?TMj2OCS/icOjqPlqrsJRra62aup78uA39Jys1Gw/zPVCJd/UYAi+04Ap?=
 =?us-ascii?q?SPWlcIcynLutMvKzIiZlaszQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:42:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729773777; x=1730378577; i=markus.elfring@web.de;
	bh=caBVJVv7nT0Cz4UrfmRZGmNkeOC3QOLv18cfDhmAqCA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EJ9PDfVKJktIkWSH0GswH09yEBZxutTULbeY/8Y8yHJ3v7+M3r+5UHLX8+6Wo2DH
	 jsIZonycrAta+WKdeVf9Yty2tSzCbdoPWeekPl2xYVN5fgE5jzZxGJkf29N/s1205
	 jCFfeSOXofJ3zIQB0xazXxOoMO/corcpFRRlqo9lo8nalJnucep0UCpOcHdzgl5eA
	 YQt0435EBdfBwCg7cHUAuczDtYKAGkYad8MXAIlyVBnJyRt23GD4lXZhO4A22U52x
	 +Qbr896x2oEZQ3bi1MjQvx1PIhAjNpAHVfFPs6PopZo0fzZn7jSR9J+d1vLopaXx0
	 wOL8lezRcjlOz7q8OA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MumNN-1tuXvm3OIV-015p2T; Thu, 24
 Oct 2024 14:42:57 +0200
Message-ID: <d84b1aa2-9d02-429c-bc9b-f76a0971cb45@web.de>
Date: Thu, 24 Oct 2024 14:42:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Derek M. Jones" <derek@knosof.co.uk>, cocci@inria.fr
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x6sPO1BWBlUyy+soBx6gyWN/ikrScANtWc6omWJe4h4kaOWasNn
 Zh67d/zw9qtWOz87Nqk9cYodq+vaLgdBZZMnvZeiIfyE8BQkmh6WvtYGCMDXLsltM/bdHEb
 LXtIYl56mCF76JtNQcYkC1in7/hQoqXt7Seg02nu0KKsrjrYFCTJKUBsFPQgtfZjJLS0P8b
 KTkVKBLMdHVYWRtbYyyMA==
UI-OutboundReport: notjunk:1;M01:P0:DqqwX76v0XU=;BMesc6R87lqaEGEYre9Xrt511g/
 bbuVeH1F6Rr4G/pe4wLc1NQDPGsOTKOzI7zilvXdeO8pF6f9ckhytoi9fPZZUuInpciaZyGp0
 3neVnrVZPHWpHtFuEPLPKstJPjtmUoyabpITyl4QqS/Ok5fzaOJlhW1eo+OoPLkh/2+kqJbyp
 /M/8A3afh8oPMVnttZK5ulkRYQ58OxPh8E3DTUlZjR25K8SQlBdXDbbjxEj2pzQzApSrKhido
 zYwkBrXSDc5mFGvN5U7zKUbTPI/K7ZYk679w7LGmvDwPnjgayDAScd1RhBKqjUtQRgCauv1yw
 3ELzUQrXIHDVnnZ7ysNbC+Ad8vlVFidrUz+DpjI3rrXrxBHabqHGIlBEWVf67HDAbETbo/wWA
 nAaRsw/Iz8hznhRemVVB/juTU48FEAV/Z2lADI+FutsJCxghdq/sQQ5qn33Cwl3xH3szFt3za
 I75z2xiRY1Qd75PmC3ZOGfUkh19SghTA33t81XJIqYd65Oteg3Jh0e6ig/MfpHQkeQkdETpeO
 pfaNVbLyJaTOTVUp8Wk1L3Oqkjg38AE4qd3urruRJtgsdmUhrWwBTdbEX7ojxemHMyQ33U+BE
 LBqyGQY3DkFbJjrONueyflTWEySIEakZbHnScxbb2FCil45gs/vJ2YLgqwSF5LIeCE6J1JUAA
 LG6BhJBctq1Cw1ZajUxmEX1lXoyYTvGTNB5bBdtaPM2YFVcIyegely6dDvLg14mw8tRcsccOS
 g2WuILPCWdMwMstXteA1EmLWxtjWOX4Y+EG42infUEeYAkPBzq7bmV2dXU8Z0TutUeOp1JnFW
 5JnKDQ2TX8wAdmyc0Cn2SFaA==
Subject: Re: [cocci] Multiple returns significant performance impact
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1919
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/d84b1aa2-9d02-429c-bc9b-f76a0971cb45%40web.de>

> I'm interested in finding the start/end line of
> functions, and the pattern below does this.

It determines the positions of some curly brackets.


> However, return statements cause multiple matches to
> occur.=C2=A0 For instance, in the following code the python
> in the cocci script below is called twice.
> This is not a problem because I can filter on the
> highest line number.

Is such behaviour relevant for the clarification of this test case?

Would you like to use any finalisation rules for the desired
Python or OCaml code?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/7bc8a7acf4673a3143cae=
7aa00ef9374c9fdf893/docs/manual/cocci_syntax.tex#L688
https://github.com/coccinelle/coccinelle/blob/7bc8a7acf4673a3143cae7aa00ef=
9374c9fdf893/docs/manual/cocci_syntax.tex#L688


> The real problem is the performance hit.=C2=A0 Matching
> a function containing lots of returns takes forever (there
> are lots of these in the Linux kernel).=C2=A0 I am regularly
> seeing timeouts after 600 seconds (the specified timeout).

Would you like to enlarge computation resources anyhow
if the software implementation would be too limited so far?


> Is here a way of improving performance,

I hope so, too.


> given that I am not interested in the returns?

How do you think about to influence the availability of
development resources any more?

Regards,
Markus
