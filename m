Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAC9C48297
	for <cocci@archiver.kernel.org>; Fri,  9 Feb 2024 11:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lBr09c/+5dzgrJp7lf1R0EH+fFaIi91/H1/lU99vgSE=;
  b=q2dlNWwvNsCnt/tNnCx8l22zy3RuRQiOY3bBnYYZh88O5znZYTzcUo2b
   XMwTq/HwHZVQoqPzZlZ2NqvMLduBYs8ccj4sdKhQHhI21DumHSfne52bq
   z1QKA+rW9SyqVl4IrTIAp5IFSHt9Y5geFME2AV8chTv7XBjyWqn/X34Rf
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.05,256,1701126000"; 
   d="scan'208";a="151170367"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Feb 2024 12:19:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9EA7FE008A; Fri,  9 Feb 2024 12:19:47 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 008C3E008A
	for <cocci@sympa.inria.fr>; Fri,  9 Feb 2024 12:19:45 +0100 (CET)
IronPort-SDR: 65c60a51_zs5vFqUAX2qxK33QqRQKJ6Lf9FYNrbU0hQnVlHQM/1mZjmE
 MFlggwDnRoXLsgt8x8GEzN+8ee4MZ0jCi0Rxo1g==
X-IPAS-Result: =?us-ascii?q?A0HjAwDeCcZlh07ASNlaHgEBCxIMQIFEC4I5f1MyBAtIh?=
 =?us-ascii?q?FOROjCEO4c3h06IcIFWgUA+DwEDAQ1BAQIEAQEDBIILgnQCh1cCHgcBBDEID?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxcHDhAnhWwNg?=
 =?us-ascii?q?lwBEIEOgSYBAQEBAQEBAQEBAQEBAQEBAQEXAkdCAQICASMdAQERJwQLCxoCH?=
 =?us-ascii?q?wcCAlYGARQBAYJ8gisBAw4jB7UqgTKBAYIKAQEGr1ofLCJWgWEJgRouiCYBh?=
 =?us-ascii?q?W6EOycPgVVEgTwLgng+iB6CaIEZhDuYBlR/HQOBBQRaDRsQHjcREAUODQMIb?=
 =?us-ascii?q?h0CMToDBQMEMgoSDAsfBVUDQwZJCwMCGgUDAwSBMAUNGgIQGgYMJgMDEkkCE?=
 =?us-ascii?q?BQDOAMDBgMKMTBVQQxQA2QfMgk8DwwaAhsbDScjAixAAxEQAhYDHRYEMhEJC?=
 =?us-ascii?q?yYDKgY2AhIMBgYGXSMHDwkEJQMIBAMrKQMhdBEDBAoDFAcLB3iCCYE+BBNEA?=
 =?us-ascii?q?xCBNIU+hA4DGSsdQAIBC209NQkLGwY9Ap8sgVWBZqVHoRg0B4I0gWCBYQyfO?=
 =?us-ascii?q?AYTL4NykzwOBpJemFcgqFeBZAE4gVwzGiSDNk8DGQ+OIBkfg3WPR0I1OwIHC?=
 =?us-ascii?q?wEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
 9KJmK+hcF+qHPrL8MFaC8WGcaq6
IronPort-Data: A9a23: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
 aUIqbh4fXyG
IronPort-HdrOrdr: A9a23:mJcAoqO6pI97XcBcTh+jsMiBIKoaSvp037BZ7TETdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVyaygc378
 ddmsZFeb/NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: 9a23:GFu9smG8qnqef4ZkqmJK2WgdBt4pLEGe922IelWpImNUVKOsHAo=
X-Talos-MUID: 9a23:V5rptwUdMo/ZW0Lq/BDGux5bDoBO3/2/GGoiybk05dWnNjMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,256,1701126000"; 
   d="scan'208";a="151170362"
X-MGA-submission: =?us-ascii?q?MDEDkWu5YrMxtxhe+xcwzR1n2X4MBoEEe6wYYo?=
 =?us-ascii?q?UIDZWPkO+eAbZQp6zlRCUATrR308Jw1Yov1pEyTHTSFx3OdGQS/oMwgo?=
 =?us-ascii?q?bWec/NjiEdA5hq54aB/kMRtUlm96QL4dAW8pLbRJspu03DsGZ7c34kBz?=
 =?us-ascii?q?yCF9OuplPFjBBA9IXXZ8ox7Q=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 12:19:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707477584; x=1708082384; i=markus.elfring@web.de;
	bh=8W4u/sgaNLFTdXukOXnjZUFiiUAWRqYD+EQR+0YRvE4=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=Nu0YZgU+LM7/U8rOo2byzUHAlrV4DOajMy4SC27GnBg/RwCWY33/ff69Oq33FtHc
	 rkMVyldIBK6+jeoEou3sGPWSsjCBHubDAfu3RX1Cp+eXJmyAgMlA6ok2iMGg4bz2V
	 zUHYyLgT3tW9KEQt+gdlckxvlDlCEkMHhCRhW+l8dwJPjN6kzyS/ja28PODg6EiiN
	 ZqEnNkLvgtNOPe0ZKKYkr/L3rh6aBadIgu0Ce87eZ4JRDvNfq2y+g/PQKJwdneRHy
	 oG0eiet9y1Ab/VSTUt+/XDYHLTQ9/KMWSJX4gz4kAsgfPa7BMpgkdIdigKbNzbyhm
	 GxTtY6QBi29bfDVDvg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLAVc-1rGJnu2xxS-00IPDn; Fri, 09
 Feb 2024 12:19:44 +0100
Message-ID: <26ccf50c-4e2f-4553-936f-2d4c6142ecf8@web.de>
Date: Fri, 9 Feb 2024 12:19:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <41052adc-2065-4cf2-9160-2e986de1bf9b@web.de>
 <289a052b-86ff-4ecd-ae55-89fc0238373e@web.de>
 <alpine.DEB.2.22.394.2402072108500.3138@hadrien>
 <d983ec62-2e0e-4102-bddc-4c420a75601b@web.de>
 <51feebc2-751d-4e1b-bf72-28dc8ed975c9@web.de>
 <eb10beb1-c8b-47e5-ab28-5c1bba502d2a@inria.fr>
 <70dc14fc-5e21-4eee-be17-c9fd30b99cef@web.de>
 <856ae5f3-f31a-2661-90ae-6041c3318893@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <856ae5f3-f31a-2661-90ae-6041c3318893@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:g2+c23D39x/KdlOiVhplpy0531gO2fEebxckd1ArD2aMf432XYO
 WsVYCzd5ycyexca7zHEEfkkyA4GnkDEzKKNf9zZUkLjaMe3VKZVZfJ7GhzAzjw0WBmW0PDD
 PGkacDdj6z3N7bQNQkk2fXDXByrGZdEOyfYpzihe7zWb5KrTSk981yC4FD+oTXo51ympPjn
 AP3pyMrrOBgMguIZaDp3g==
UI-OutboundReport: notjunk:1;M01:P0:+1ofYzDfUfU=;LZ1b5l9KcER+H9V1EIoQujrcJ+U
 UrpPkn9pmr+YdPK95a+C/GzxYoJMCYFIAHfxMm6jpM4JbaJQwb7YgaP1Q7YF2QgwUoVQLowQu
 XQeQCZC+gqFJBB1z0w/uacOmHjDEylH/+s6oB2j4YKfYrj2sRmR8x6BhbSxiU+KKM7QaV5cwI
 BlM7lgRsK44wzmuLlNQIH9/cRmkEGuuTQYk+1ja49A1wDzHv6dF9yXpELB2MFQo3Eouh65c4f
 WcTPLupByMWm863WKaUPnmfe8lSZ8XimaRMvLtYkCVOIIHlRc7UqM25HkwJ3ZLUAV+SplVpLK
 GOEr0c/I9sIrArLzLJLRUUgGv+rWKHWRAT2L/Kg2hrpHqwKPtGKLlp6lLJ7fgieG1hEe5Xnmu
 h3lVH+fJ4XNGzU8cbU0V6L1f0mPAcnHdoc49K1TE5beEupV9OcHK/dDmzBGGWKnqokLs/hOhJ
 6kjms6brDXLt3whW5PeoUjvVPx5xhcgRl6Im6IPqfR4wEz8B5arTSJngxSr6mnnOMOlNmV2/K
 iM1bhOEGwak5bOJ0a1fWNul/R5VcAMN+DEgZDOGajff3SJQqgbL0gPlQtWzMNB4dS2gia/LTN
 4dxR6aUlPNgCRHEdy95iaMzFX8P561CzCd3rjpL+KisKKhPV3grR3RUmUPLLU5ZWCdTX9DDxR
 hcktZU0UBb9dcYH04z77DUdGgnFhtnGhy15Z6CiuBFgu6w4mae5vN0CiRqmURpUrzijg7Ys+U
 ezWlxivWC146O5qUoRVArsROrAg2av5chy2ctHPltqO1oBt7QLSRqepAf+BmCd7m48gBwf536
 o15ptZlDddQy2atrtEaIfLGfNKWlyoZAQN1pOTsGBoTCw=
Subject: Re: [cocci] Supporting transformations better according to reduced
 number of function call parameters
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1530
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/26ccf50c-4e2f-4553-936f-2d4c6142ecf8%40web.de>

> I don't think it is useful to do anything for this.

Can the following SmPL script example point further opportunities out
to improve the software documentation?


@special_selection disable decl_init@
expression action;
identifier var;
position call_pos, declaration_pos;
declaration declaration1;
statement statement1;
type t;
@@
(
(t * var@declaration_pos;
&declaration1
)
 ... when != var
     when any
(action@call_pos(..., &var, ...);
&statement1
)
 ... when exists
 var
|
*declaration1
 ... when != var
     when any
*statement1
)


Regards,
Markus
