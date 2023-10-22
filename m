Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB902C001DF
	for <cocci@archiver.kernel.org>; Sun, 22 Oct 2023 08:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=CzYAAxsq/739AFbDI41Ez/BJotLCgIuCWi29n9gW9cQ=;
  b=Zna5xTCxeTBDRBLV5eiNLqv1yA9Q7Z2czH36d/oQXgGGTIo7bxIa6iAi
   V9o5zRjLwBlpEk42RB5Kr9XM0NbOFbkbAI+iQKSyeN1vzMTaUci+fBeW7
   k5Z+EHDpVgJj0OptNCBYWGKTCze3FTqLaiXXPQvU5F3ftqBcHJD1rWdxO
   E=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.03,242,1694728800"; 
   d="scan'208";a="132521596"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Oct 2023 10:44:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 38053E00BA; Sun, 22 Oct 2023 10:44:48 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5E64AE00B7
	for <cocci@sympa.inria.fr>; Sun, 22 Oct 2023 10:44:45 +0200 (CEST)
IronPort-SDR: 6534e0fc_R9JqtPZ9B0ilgoZoARBxgXo8rSqED+MjfX9KEg7Hdb6MM80
 tHNdfEk2io+uN1YRN+DOH7LQeWpp3wQp7Ma9cog==
X-IPAS-Result: =?us-ascii?q?A0GsBQA44DRl/wQP49RaHgEBCxIMQIFEC4I5B3ZTMAQLS?=
 =?us-ascii?q?IQXPJEyLQOEO4czh0mIb4FWFIEsPg8BAwENQQECBAEBAwSEewICAocXAh4HA?=
 =?us-ascii?q?QQyBw4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECgQYThWgNgjcrA?=
 =?us-ascii?q?RGBDIEeAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgEEAQwXHQEBEScECwkCGgIRF?=
 =?us-ascii?q?QICVwYBFAEBgnqCKgEDDiMHlgacMoEygQGCCQEBBq9UHywiVYFfCYEaLogKA?=
 =?us-ascii?q?YVRhDUnD4FVRIE8glMxPoN8Rz+DHIJog3mFQJIAXiIFQnAbAwcDgQMQKwcEM?=
 =?us-ascii?q?hsHBgkWGBUlBlEELSQJExI+BIFngVEKgQY/Dw4RgkMrNjYZS4JbCRUMNQRJd?=
 =?us-ascii?q?hAqBBQXgRIEah8VHjcREhcNAwh2HQIRIzwDBQMENAoVDQshBVcDRAZKCwMCH?=
 =?us-ascii?q?AUDAwSBNgUNHgIQGgYNJwMDGU0CEBQDOwMDBgMLMQMwV0cMWQNsHzYJOw8MH?=
 =?us-ascii?q?wIeBA4DGSsdQAIBC209NQYDCxsGPgInnXWBd2wIgRV4J4ESMBEpxCo0B4Ixg?=
 =?us-ascii?q?V6BXwyfIwYTL5cdDgaSRpg8IKgxgWoBNYFZMxokgzZPAxkPjiCEK49IPzU7A?=
 =?us-ascii?q?gcBCgEBAwmFRgEBg1qCKQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 IlhaOLK4X4=
IronPort-HdrOrdr: A9a23:e0gzvqqWaDFiiNN62weYbUUaV5r1eYIsimQD101hICG9Afbo8v
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3AX5WwU2kMMb4KZL+A0Z8hDs4LB8bXOUHl4m3KOFP?=
 =?us-ascii?q?jM2gzbr2ZUWGL0axCssU7zg=3D=3D?=
X-Talos-MUID: 9a23:hs34mgYEbtBOAeBTiy7SnWFlPfZSvqnxCF8Brpk8sNatOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,242,1694728800"; 
   d="scan'208";a="132521595"
X-MGA-submission: =?us-ascii?q?MDFEZxwYvza4G065+KNv0chDT3aYN4g3VqVpol?=
 =?us-ascii?q?vO7xsLrAZHo7AAKTT0py3EScM8TLFsQ9mtf2R220p1SkbZh1fdn2xjtf?=
 =?us-ascii?q?aC8XK8VsDFnlo7yfO5q3c9ps0HETQqW/vejmK1XYSsnZvk0LEDMAzgaJ?=
 =?us-ascii?q?TIndz5oKm2BRtpHY/Z1z0/pg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 10:44:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1697964275; x=1698569075; i=markus.elfring@web.de;
	bh=D0xCFYLLVhOVP6fDOoVeJJE2EmrcmY/DA7K/+7GQ8Ks=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=JiiZRuKkyXkWUkRE2wwQnaLDy3nZb6fnFQs/cCkbcHonqqfiCYyRDhAqL9l2PQbP
	 yjNZwpZsIy5a/amcdzbOSS5UQ0KEhbSdoaSh2Bst+aMrWSIDIlERCAq/qaCtKIUOG
	 BZac/Erl9uQRPzn2BQOfSw76vk/5j99zx546P5pzLP59iNnLnoJAi28cpx7VUSC0r
	 jdQ0k1SvGe6cR9V8D/VmLPtam+SmxkGCEstpLpYuHAfY7DOhVuQTLJO1zc86uKd6s
	 t/IVKSfFmPtaBnaT80vCLOfpTZh22PudvSB6QlJ+2VxqMkOtm6YuDvEEuMfXJIB4B
	 3n+jKY2Ig4X3SDF+MA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWz8v-1r1HXW2TTF-00X2zA; Sun, 22
 Oct 2023 10:44:35 +0200
Message-ID: <0352f48a-47e2-492a-a263-1916a7065157@web.de>
Date: Sun, 22 Oct 2023 10:44:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Martin_Schr=C3=B6der?= <info@swedishembedded.com>,
 Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <CAEqMKof5Ke4yV0KBZm2FW8z-Ct1UHZRDz5=Sd3gaO3a-f4+y_w@mail.gmail.com>
 <6213b47a-3ae7-d316-b1a4-8fb5d3bf9b5@inria.fr>
 <608e77e0-a36d-44ef-a2fd-9c0c50cf61b3@web.de>
 <CAEqMKoco-UjiPu4bwm69t1HexJi0y+cCPEH6NZ10xZCfn36=5w@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAEqMKoco-UjiPu4bwm69t1HexJi0y+cCPEH6NZ10xZCfn36=5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E8pgX80+xD0aUpIMe11wpzadYkGGFH4Dh7DZAVFYyPD1uPNXX42
 d4M7LKUvdh0f3EfJJngu31yoQESk9U/Ab6yOgaTlK9VethVBTvKMHH/Cr4p0uEraCHR+FUf
 9LVLbbTP2A/kFI92MLIXoX4drZtSybnH1YQuRvkorLs2if1C5jtu9yrez4cjLb0tgWEJwXk
 GaT7DZQUSfZmdYZUru9YQ==
UI-OutboundReport: notjunk:1;M01:P0:ccl6YCbAA6w=;lESbVAgwWduUUJ2EpWjWmhCdnqP
 Db7nA8wIDkXyyAHaKgdliee+Gxf9nT5HU4RrXtmy8iavuMludPjsgDvI+3bUUIwcIsaiXy3B2
 YwttX6CCvw7lBCsQcvDCxKwDiqOTUXeR+OiK/o029YYaicygfeOCcxTJiAWI65px42NQGWmFo
 KHch9/QFwm3APptIvWDZcDCFKtY4rIDhndPLgO0nrXuECdUdex9Tw7dhwQ4GN2Ne2El9cTlQG
 hoIRaQprsxW8IBSjaZ2+FePSuMQrOcM1C4pS3Weg2xfaxtShrdplMSpkKS2jEQqbA4NPWPILJ
 e8Wnt5JP4950g5GK7jjtDrmekIpru0AnUyRwLk2qxl9wqR+EES+xFDnFpiSrZdMs9+tTVHotf
 Q/zjVnNaUwjthMmIB+V68TskTbWTgiZm4VOrpJtK9bual/iWFxu0b+xqsSgfdN0Gc+X5q0qGG
 47DE3GAhagtVyRD2znI+ufG55cjsMqg4Jjf1KJlz/pRrxfcEBNqJ36KT1ryeWdJISUnl0+mPe
 B2NE/44r+0jTi5HiR8eszNbdqUSYK+Dbcj88MBmCa+86E3ZZxssuWTMKv2ONnPLNxzQXWYFiQ
 aAatL/P69zMvgTIzUbTGVUwVCrKjNvIE/yLvPoAMNCBYxiTHUUlozer59m+OPRi0+6+x5elMt
 Fp8cvlb917bHVA5usBo2E2tJUhYD4GrVceKaoTWFC6pLjsUDBpzCewMVOAQ6XdSS8meXqBvvn
 XwaP//oi9N8jcHHBCN9riRTVnf1VJVhV+TgRITIUfrHuV/jZ2U+3//tSCwMOJPGKLpaoJYXUm
 pCKoRxKAqrfMX6GEpe4aeLvRhYqGpMbI36oG0rUqUxO7TjRYJTnqAobOKDKOj46nql4N2cS/1
 U5NkeXyFw8ilyb6JJpDwXdDeLhIQpjsuID15Yx9psziyS+VuBOtyh91LmRwkDUEUuyb0wCk+T
 A373lw==
Subject: Re: [cocci] Finding functions that do not unlock mutex in the same
 function
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1267
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/0352f48a-47e2-492a-a263-1916a7065157%40web.de>

> My final script that seems to work looks like this:
>
> virtual report
> virtual patch
>
> @ r exists @
> expression l;
> identifier r, e;
> position p;
> @@
> r =3D k_mutex_lock(l, ...)
> ... when any
> if(r){ ... }
> ... when !=3D e =3D r
> when any
> if(e){
> ... when any
> when !=3D k_mutex_unlock(l)
> return@p ...;
> }
>
> First I match k_mutex_lock. Then there can be any statements between tha=
t and the first check.

I suggest to take further case distinctions better into account
also for such a source code analysis approach.

I imagine that you would like to restrict the code which may be used
between a function call and a corresponding return value check.
Should the (compound) statement be restricted also for the corresponding i=
f branch?


> If locking fails then in the first check it is valid to return.

Such a control flow possibility is reasonable.


> Not sure how to capture that this first if statement must return in that=
 case.

How do you think about to add any SmPL disjunctions and to adjust the usag=
e
of SmPL ellipses?


> Then there can follow additional if statements and in all of them there =
must be an unlock if there is also a return.

* Why do you try to exclude the assignment of the item =E2=80=9Cr=E2=80=9D=
 to other items?

* Would you occasionally like to support (lock) scopes which would be dist=
ributed over
  multiple function implementations?

Regards,
Markus
