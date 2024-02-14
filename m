Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99332C48BC1
	for <cocci@archiver.kernel.org>; Wed, 14 Feb 2024 17:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Ncs7/7D36gPlY0H5WrCH+6Wq5TAQ8Q55XUarOWdGegQ=;
  b=Gra9UYninepvjRsenn33PjuhNmZmtUqjSFKV9CKLYVox7qtw6WnRI5/X
   BxVP9o7Yun9kOE4cuzHskJzGI+65F1OuqJZJpesj4wmKt8p1pUtTHSqYa
   11LxJOwP7eA9VdQ0RAI4V5nOG7nzTe4e/Iw3lxYSTB/xetRP2AyFExrx8
   s=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.06,160,1705359600"; 
   d="scan'208";a="151994089"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Feb 2024 18:39:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 901E1E0CD5; Wed, 14 Feb 2024 18:39:24 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8AB80E008A
	for <cocci@sympa.inria.fr>; Wed, 14 Feb 2024 18:39:21 +0100 (CET)
IronPort-SDR: 65ccfac9_bPHBuQ64W89k+vUhTmXfdlRYOED4kBSTc0j4EKl1R3Wdv2M
 PPAP0o5nclPj3frZCqLwHT0jRIHdZ5YTcWUl0SA==
X-IPAS-Result: =?us-ascii?q?A0ElAADB+cxlhwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4f1MyBAtIhFOIHYcngXUwhDuHN4dOiHCBVoFAPg8BAwENQQECB?=
 =?us-ascii?q?AEBAwSCC4J0AodbAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBASMTBAcOECeFbA2CXAEQgQ6BJgEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RcCR0IBAgIBIx0BAREnDwsaAiYCAlYGARQBAYJ8gisBAw4jB7I9gTKBAYIKA?=
 =?us-ascii?q?QEGr1sfLCJWgWEJgRouAYglAYVvhDwnD4FVRIE8C4JHMT6BBQGDPYNbgmiCG?=
 =?us-ascii?q?IM7mSVUfx0DgQUEWg0bEB43ERATDQMIbh0CMToDBQMEMgoSDAsfBVQDQwZJC?=
 =?us-ascii?q?wMCGgUDAwSBMAUNGgIQGgYMJgMDEkkCEBQDOAMDBgMKMTBVQQxQA2cfGBoJP?=
 =?us-ascii?q?AsEDBoCGxsNJCMCLEADERACFgMdFgQyEQkLJgMqBjYCEgwGBgZdIwcPCQQlA?=
 =?us-ascii?q?wgEAyspAyF0EQMECgMTBwsHeIIJgT0EE0QDEIE0iiwMTwMZKx1AAgELbT01C?=
 =?us-ascii?q?QsbBj0CohjIJTQHgjSBYIFhDJ84BhMvg3KTPg4Gkl6YWCCBCKdPgWQ6gVwzG?=
 =?us-ascii?q?iSDNk8DGQ+OIAwLAgmEC49HQjU7AgcBCgEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 IT1qa15rJmHdHPM
IronPort-HdrOrdr: A9a23:+krCh6513fiw+DCbXQPXwBbXdLJyesId70hD6qkDc20xTiX+rb
 HWoB17726TtN91YhodcL+7V5VoLUmskaKdpLNhWotKPzOJhILLFu1fBOLZqlWMJ8S9zJ8+6U
 4KSchD4bPLfDtHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNz2CJ5sA0+9jYDzranGeqTM2fqbQn/
 enjPZ6mw==
X-Talos-CUID: 9a23:iEvf4WzlIFpyhC10AbevBgUERO8HXCHx6kzfLlXgVDxIbpfKGU+frfY=
X-Talos-MUID: 9a23:aI9hrQZea9uu3eBT7CX9iz5pGZ1U0bXtLnIkrJE7t5SfHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,160,1705359600"; 
   d="scan'208";a="79657563"
X-MGA-submission: =?us-ascii?q?MDGfov9DtP5Hz4aVdNJxRzuYI/c8VZo02rrYBs?=
 =?us-ascii?q?HF7S3DscIfSnyRrd0snebKamSptlYTdN2sC3zw3H5aKcLZsOnkR2/rSi?=
 =?us-ascii?q?J0dJ7cZn9eq0QT3EGQCdvjHmXAmFc2sDSRjA5uphtb/OSBMSIw+Ktr1r?=
 =?us-ascii?q?n/Vj7OCF+aJk0JH5PboiYlZQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 18:39:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707932359; x=1708537159; i=markus.elfring@web.de;
	bh=Ncs7/7D36gPlY0H5WrCH+6Wq5TAQ8Q55XUarOWdGegQ=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=GUKSJZ8YgSaYpacqFtqfG6nm362gEIQHAeHR3M8Beu0uQKXnxcXwloguGYV4Re11
	 OjRFYLm1G5fJtypBDd8XZvizffwDbiKOa3/Qil/Cs3v9dcsSUWaOEGFy3g/7lplz+
	 Inuoy44Rn9nFSsJSUkdNBiL6DwdARacNVvDz9pjvWTpf07HU+Hsvno+m/QjXBd07z
	 BKdFjmsIfzaCloAFQUQyeAegGa1BH7Zqt6ng9fSruXWwURVjaOeEFC+eG35JgONF2
	 G2IwnrtwZ34xBM1MCCVVhyrTALYgdn5tPByn1yIaeBoWC3mw3sV0McHfJcxNBQ3Ih
	 t13eUC0DVWklZy/ZKw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbCHy-1qylUF35lg-00bYXp; Wed, 14
 Feb 2024 18:39:19 +0100
Message-ID: <5a3fabb1-32a7-4c44-8825-70a863f76bfe@web.de>
Date: Wed, 14 Feb 2024 18:38:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <6346056f-abf8-47b9-9024-ceb60a3f36a8@web.de>
 <alpine.DEB.2.22.394.2402132145410.5600@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2402132145410.5600@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eAKjluaYD95OWHLaUMH5lfetUzC4BSjfTs/2Sr00E6jWpvLOx/Y
 RAZocrKtnfq7DRzBRp142ODeVRwJcBPVMsLbNdwfoKdOx1pq5Sq+zAuWOVRiJKsiAN/uTDO
 0JEkNHU4ukqdv7lSbJLlK9iZ9Rv2YOV0ecmqRusYrzwWGhXZRq8J4KrAllWhMY06kyMrtUw
 XiaphOX7iiZSBNyjDNomQ==
UI-OutboundReport: notjunk:1;M01:P0:RyJR1av/ejc=;KkpsMLlWRptcBy8yiSepLB84rXD
 +0U0+e8HK+UAqe8iw0t5RJrcr2Ma/dsztIAskWdtguiDNjJoc5MgnqNxYWZKtTWrVaxvKPV9m
 /D7QxO2dU0LSQutLuxF4Q37p7EoGr7ytHGusLExvGdyD0cDhALyjd1i9aFjNyijv+/Dy6/S6T
 dYUJVpsfjlz221ekrQQKUuil2wbAzyJiF4Lj4L324qvtVES0YGVgjej0fVpmIbqJf/FHMxRlu
 dwZVbYEO4DWjABdkOYhtDmsP3Ket9qscqF9JJED3qqlQ4rJEV/VZPo7inAfOX6ijXMpwxa9nV
 i9rfe7zhmfOCQt/CWxfNoHk2JlhHNKQgH4VERepbicn41I+hmk2pTXqh438SQ2nZB14wpcEoM
 o5JFRGiI3yh0qQYa4K+edPBR/Vbl27aNivUmfDp1Jf0OcbDmMIAZVDBRIanaXjElqHT96jJn7
 BHnvkQh6nj54w91w3jYw4mC5sBb8Fd4mN1R6VTK5cn3qKBenFKtLJyAGkwK1zKBGL26lwUJgw
 fYiol0aOoBCXWwvGad0bl/Ifc3r2FWKOXDMJtFJY5d+y8rSJGH7gnWG1Z0uYzNAkdcsW6RiYW
 G5DMgajltsgoE6SlI+7LKtXzfqxKI1H92m6lbPAxtrccVUpETX7trDu4HDcwOp/07qzIUWA/h
 gI9/FVdvvyTB/TPwujKWESzzCqVrtMli00eX/KwIaK6kzDBgyD19YTkdiqUxLpWhXde0osLVi
 Muyreoh20STUmfRHCpMw2zKvPB9T5DqP8rvy5eHh8l9Fau5XmnWh67ZthxNZN0N++bOCHJJhL
 svJXrqlvhXSb6Lr8PdOrFHmeEROnZybqnbdkTVW4y6L1I=
Subject: Re: [cocci] Fixing a parse error for a SmPL position variable
 constraint
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1552
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/5a3fabb1-32a7-4c44-8825-70a863f76bfe%40web.de>

>> position find.p1, find.p2;
>> position pos !=3D find.p2;
>
> Try switching the above two lines.

Did you try this SmPL code adjustment out already in your test environment=
?


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> spatch --parse=
-cocci show_same_statements7w-20240214.cocci
=E2=80=A6
Variable find.p2 in duplicated_code cannot be used as both a position and =
a constraint


How does this error message (from the software combination =E2=80=9CCoccin=
elle 1.1.1-00687-g0df3efff=E2=80=9D)
fit to the discussed data processing intention?

Regards,
Markus
