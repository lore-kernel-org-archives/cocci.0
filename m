Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614A3C4167B
	for <cocci@archiver.kernel.org>; Mon, 27 Nov 2023 19:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=7oYy44DyAgDqpI6/MMwAAQt5vmJCGz1rbBCnjAAjFKo=;
  b=RmQl2a69hLJzc+0GMiCI/3c3rh8Tn3IDNYDz2jqdO1nOA+rfM8NEvgCd
   T7DZxF7OaaH2fwqNFLzBgBeygOI/jNZu7AUaY9YbMMJCZ+aEexhWGP3je
   VF4VJfdPNO+G9+otyWvwlqutSNOP002ALc09B+3XPJvmHy88OjCLDbs/j
   0=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.04,231,1695679200"; 
   d="scan'208";a="138855440"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Nov 2023 20:57:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9ED04E0AF1; Mon, 27 Nov 2023 20:57:04 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6647AE004E
	for <cocci@sympa.inria.fr>; Tue, 21 Nov 2023 13:38:45 +0100 (CET)
IronPort-SDR: 655ca4d4_5PuMgi8m1Saf152HjdkD0CpMLT1NBFrs+6LHKnPsCWICNqX
 kOEPZDqAJiCcG0YKuakGzP6RLLvwxFSuUsqUlBg==
X-IPAS-Result: =?us-ascii?q?A0FeCABSpFxl/4IoycNaHgEBCxIMQIQIB4FKLwQLSBsBh?=
 =?us-ascii?q?DePPYIlEZ9rDwEDAQ1BAQIEAQGFAgICAocpAh4JAzQTAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQMBAQUBAQECAQECBAUBAoEGE4V1glwBg24BBAEjVgULAgEIGgINGQICV?=
 =?us-ascii?q?wIEE4U8IwetOIEygQGEdq4zgWiBGi6IDQGFQIROJxuCDYFHgkcxPoQhAQEgg?=
 =?us-ascii?q?1uCaASJIAcyhF+BFI5WXSJHWhYbAwcDVikPKwcEMBsHBgkUGBUjBlECAhcRI?=
 =?us-ascii?q?QkTEj4EgWCBUQqBAj8PDhGCPSs2NhlIgl4VDDRKdhAqBBQXgRIEahsSHjcRE?=
 =?us-ascii?q?gUSDQMIdB0CESM8AwUDBDMKEg0LIQUUQgNFBkkLAwIaBQMDBIE2BQ0eAhAaB?=
 =?us-ascii?q?gwnAwMSTQIQFAM7AwMGAwsxAzBVRAxQA24fGhwJPA8MHwIbHg0nJQIyQgMRB?=
 =?us-ascii?q?RICFgMkFgQ2EQkLKwMvBjgCExwDCQMHBSwdQAMLGA1IESw1FBsGPyhLB6JUg?=
 =?us-ascii?q?hKBZ6I3oS2BN4I4gV+BYJ9IL4FJlWWSV5hAo3mEW4FBOSaBWYEFgyJPAxcCD?=
 =?us-ascii?q?6ISQTQ7AgcBCgEBAwmFRgEBIYM5KgGBFQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 c42ohXNA/R6/n2lqSv/KBB2bSeLC842Hk41xH0=
IronPort-HdrOrdr: A9a23:KkUD+6G1EhRwypCepLqE38eALOsnbusQ8zAXPo5KOH9om6uj5r
 iTdZUgpGbJYVkqNk3I9ergBEDEewK4yXcX2/h2AV7BZniFhILAFugLhuGOr1Ld8m/Fh4pgPM
 xbAs9D4ajLfCRHZLHBkXSF+rgboOVviJrY/9s2mE0dNj1XVw==
X-Talos-CUID: 9a23:1FVeCmCMXeqs4CH6ExYgyFVPM+wiSVLmj1zeLFPjBGdbWaLAHA==
X-Talos-MUID: 9a23:rF8c7QtS0/SGeMVQ882nlG4+GuBL/oOVNE0Xr48d48OFKRZ3NGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,215,1695679200"; 
   d="scan'208";a="72124316"
X-MGA-submission: =?us-ascii?q?MDFdJ/2QK9tt8A1b40aMdoCpxhFbgQ54//gn0m?=
 =?us-ascii?q?uZsvsFrm/YaCtDw84g8yHrPqKk4/4zLXhMVncVlNKrwbYCdpCIEL3lib?=
 =?us-ascii?q?0/G7ochEZU9Y57FAN7nXacZfZI/YmZWu1GQwSD2o7AMinsE1IBbLEqcE?=
 =?us-ascii?q?Mj/vicc/5Lbx/tnCZDgZpb2Q=3D=3D?=
Received: from lithops.sigma-star.at ([195.201.40.130])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 13:38:44 +0100
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id AEC166413F8B;
	Tue, 21 Nov 2023 13:38:42 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 7TPDiEqAVqiA; Tue, 21 Nov 2023 13:38:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id DD8C16413F8C;
	Tue, 21 Nov 2023 13:38:41 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id scmSAesyf5fd; Tue, 21 Nov 2023 13:38:41 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id B18346413F8B;
	Tue, 21 Nov 2023 13:38:41 +0100 (CET)
Date: Tue, 21 Nov 2023 13:38:41 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: cocci <cocci@inria.fr>
Cc: Johannes Berg <johannes@sipsolutions.net>
Message-ID: <101903006.275.1700570321591.JavaMail.zimbra@nod.at>
In-Reply-To: <1735034650.197.1700567751120.JavaMail.zimbra@nod.at>
References: <1735034650.197.1700567751120.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Updating all call sites of a function?
Thread-Index: j037/QSx+0lN8HyGf94KwB4D24WWFHoDBJHA
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Updating all call sites of a function?
Reply-To: Richard Weinberger <richard@nod.at>
X-Loop: cocci@inria.fr
X-Sequence: 1342
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/101903006.275.1700570321591.JavaMail.zimbra%40nod.at>

----- Urspr=C3=BCngliche Mail -----
> Von: "richard" <richard@nod.at>
> An: "cocci" <cocci@inria.fr>
> Gesendet: Dienstag, 21. November 2023 12:55:51
> Betreff: Updating all call sites of a function?

> Hi!
>=20
> I would like to inquire about best practices for updating all call sites =
of a
> function.
> During refactoring, I changed the name and arguments of a function.
> For example:
>=20
> ubi_rmvol(libubi, dev, n);
>=20
> becomes:
>=20
> ubi_rmvol_wait(libubi, dev, n, 10);
>=20
> What approach do you suggest to catch all call sites, especially where th=
e call
> is
> part of a non-trivial expression?
>=20
> e.g.
> ret =3D ubi_rmvol(libubi, dev, n);
>=20
> if (ubi_rmvol(libubi, dev, n)) { ...
>=20
> while(0 !=3D ubi_rmvol(libubi, dev, n)) ...

Johannes pointed out on IRC that I think too complicated and gave me an exa=
mple.
This does the trick:
@@
expression uctx, dev, n;
@@
- ubi_rmvol(uctx, dev, n)
+ ubi_rmvol_wait(uctx, dev, n, 10)

My fist version always had a trailing ";", so they matched only trivial cal=
lers...

Thanks,
//richard
