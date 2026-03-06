Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6CDF01832
	for <cocci@archiver.kernel.org>; Fri,  6 Mar 2026 13:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=UUXLyJIcCqVAcAJ6YvN486S9B0JY6l2Uwk0DSD/ID7s=;
  b=FTL4Pb1QhSbe3Bk9e3VAya/pu4WemvdENfMuMNu9N7WpUHExJ1OXP1so
   l0wOsfDalyvc2xlYYTZPI3OkwhmqaHPhYKDO+utT3OTh2xZkOr37BUK1m
   caVP9WIP6D5TJFDStn2Wr19f4WjI6ntrRwbWRG+GYvvN1amKStWRFUe8a
   k=;
X-CSE-ConnectionGUID: hfWisv3pQvyksu4b7YoRmw==
X-CSE-MsgGUID: D+AWV3CHQ2qjoWuQE09UHg==
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
X-IronPort-AV: E=Sophos;i="6.23,104,1770591600"; 
   d="scan'208";a="266590384"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Mar 2026 14:14:20 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id AC04A82E85; Fri,  6 Mar 2026 14:14:20 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id CB19E82E81
	for <cocci@sympa.inria.fr>; Fri,  6 Mar 2026 14:14:16 +0100 (CET)
X-CSE-ConnectionGUID: cCN1swAcSauxfTNsHnrMFw==
X-CSE-MsgGUID: sDy3B2yrTcm+7kk+O+WbxQ==
IronPort-SDR: 69aad328_uYu4zqM2JAj4T8UoBGQSUPAmKpRaIryJVU75zIFL/mWe+vT
 t8KPNTojsBOTOWTY1REnU8Wh+gpOAGIDyBdjkdw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GnAwB90qppg07ASNlagQmBUoIWKWgfXjQEC0mEWI9Tg?=
 =?us-ascii?q?iSEO48RjEsCDwEDAQ1ECgECBAEBAwMBhHYKAo0gAh4HAQQ1BQ0BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBASEZBw47hk8NgmIBgSSBJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAkdEA?=
 =?us-ascii?q?QEBAgEjHQEBESYBBAsLGgIYDgICVgYVAQGCfgGCIgEGEAEDDycHDasygTKBA?=
 =?us-ascii?q?YIMAQEG2mQfLCJZgWcDBoEfL4VugmUBiXR6Jw+BVUSBPIJSMT6EQ4NbgmmCJ?=
 =?us-ascii?q?oEOkyNSeBwDWSwBVRMXCwcFgSNDA4EGI0sFLR2BIyEdFxQfWBsHBRIhKoFpe?=
 =?us-ascii?q?IIBD4ZqeQMuXhoOIgI6XEo+CgFaBYIZAgELbT03CQsbBD2Obj6DbkbINDQHg?=
 =?us-ascii?q?jiBZ4FkDIoulT8GEy+DcQGTYA6TC5kGjgmbOIIAIoFcMxokgzZPAxkPjjqBG?=
 =?us-ascii?q?wECgnyBC8ZvRTILMQIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 klQqVsdBZsePMv31h46AmQ=
IronPort-Data: A9a23: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
 w0hoIfv5esRkNiEndjBDAzfYzqi
IronPort-HdrOrdr: A9a23:41Q2KK+0kTtiTrUSoHluk+AMI+orL9Y04lQ7vn2ZhyYlEPBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3AZpq1PGqWXm/dhV61sKsw3xjmUcsOVCTG017bGEa?=
 =?us-ascii?q?lGWhVbqa1T0W11rwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3At5JMfA+mb5dKm7dFUK/PvmaQf9xE8v+EUlEXrZ4?=
 =?us-ascii?q?D+JaHNm9XeAiXnA3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,104,1770591600"; 
   d="scan'208";a="140621219"
X-MGA-submission: =?us-ascii?q?MDGZXPEugzyBmXBJyIG4/llwZIEtxdbBOax/sn?=
 =?us-ascii?q?tTkUsN9DnPXosZ91DWhT6exrP5a/NtAtKUB3CBRWO+spUbBrahue8yc1?=
 =?us-ascii?q?JgW/9uNY4VNpGK4s1/YjNbLgANnz4tSCcGOsbsmDwoV6Yv0SU9R8bTTp?=
 =?us-ascii?q?v6xWtYO6TlV2hxMeB9httLxg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 14:14:15 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBS6v-1voMv34C0V-00HEY6; Fri, 06
 Mar 2026 14:14:15 +0100
Message-ID: <a976b521-08d2-4a7d-9b89-d8c0f04a29ca@web.de>
Date: Fri, 6 Mar 2026 14:14:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <30ca5b1f-1add-4ce2-b01c-495966773a98@web.de>
 <1d6176db-f59f-9ebf-f96d-87babf92526f@inria.fr>
 <9548ebc2-57ba-4d35-aa07-015c9d2b1e2b@web.de>
 <cd2290ba-5099-d55d-a55a-8713568c77f1@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <cd2290ba-5099-d55d-a55a-8713568c77f1@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8AU//u/0yQz5te9ikK/R/Uv9R5zx7M2MiccLqPylR8s6sz9Bph2
 3iDp5xtshr//ztGrPqXdJ4QbFeX8hSfy/xtfh3TuJRKV9oS5GFccfLxWVaRkywr9GLpOgOI
 P+ubsbiQP6gzQlIVALKyAt14tDDP/H5erd3V0BVsWSfsmGjWqTWB4fNL0PfIAnlndhH+bsI
 FLs3p69Wk8eKPQBZ27YMw==
UI-OutboundReport: notjunk:1;M01:P0:78V9XV07R4M=;Wj/9gfKZEsZfwX4clSEJtRnXve3
 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
 Vd2ZW+EncUqiC+UxUjsSmzDtd9ZxL
Subject: Re: [cocci] Separating label from previous key word display
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3326
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/Cf94wswRjInAYcsX26VkjQ>

> OK.  If you had written something like:
>=20
> Shouldn't:
>=20
>>>> gotospecial_target
> be
>=20
>>>> goto special_target
> I could have known immediately what you were talking about.

Thanks for your corresponding adjustment =E2=80=9Cadd space after goto tok=
en=E2=80=9D.
https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/91665c5ff245fcd23a3=
6bc0ba9662e02c731bbcb

Regards,
Markus
