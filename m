Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F5A606A31C
	for <cocci@archiver.kernel.org>; Thu, 12 Nov 2026 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=BGHgB2KD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:date:from:to:cc:reply-to:in-reply-to:
   references:message-id:subject:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=FrV6+G+mNJiGZQsusKAglhltZmjWAuFgKzASCtxOzmw=;
  b=BGHgB2KDm3rL4+O4/LTRGvn2mSZHRKmtzzS9kFNHdJZ/wc5EXW6Nk6EY
   XWkaVUOEN4HpwOSPNeC9NqdaACymKiZsbsa0XpqoH6lcKlsF7fYcKV50Z
   kMPc8n1C/1dGW/VEBXWDe/JvRFgPEHoKD01GOBlfHGL6o+ec2YFUgKJ2k
   s=;
X-CSE-ConnectionGUID: A/lSi1ulTnyrHgIe1sAFaQ==
X-CSE-MsgGUID: lKZv1Rb0TNWL84pJYwQ1pA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,209,1787004000"; 
   d="h'?scan'208";a="305077104"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Nov 2026 13:36:21 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id A5D5581BC6; Thu, 12 Nov 2026 13:36:21 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 1939E8145C
	for <cocci@sympa.inria.fr>; Thu, 12 Nov 2026 13:36:16 +0100 (CET)
X-CSE-ConnectionGUID: 5XBTp8sBQKaumHB9QpV5cg==
X-CSE-MsgGUID: DWEjzahzTMylCL3GoDBKzw==
IronPort-SDR: 6af5b2bf_ggyvkvEKYryS5ecHKrdhhTrM/7yhID7GFtxy0jnaaFEIbFC
 QuMrAbOGcPix45Z5AQFeJtVeSL4Ze9kP4p+dvXQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EsAwD5sfVqgQQqG9RaHgEBCxIMggULgW5TgQVUFDIHC?=
 =?us-ascii?q?IUhgRiHYpsWjAmBfggHAQMBDU8CBAEBAYUEAo4fAh8HBAUtBw4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQE7Bw47hlyMGgGEAAIBA?=
 =?us-ascii?q?yNWEAQHCTkCAgIpKwYbgnuCdAQDAbssgTKBAYRm2WOBH0MSgU2FdIJuAYp2J?=
 =?us-ascii?q?w4NgUhFhBAxPoRag0WCagSCIoEMgXiGHY9RBwceJh13A1ksAQ8RNRMXCwcFY?=
 =?us-ascii?q?EVDA4EGI0sFLR03bCEdFxEeWBsGBRIgKkBDW4ESgQVdgSsoXQEBAR9GLQkBC?=
 =?us-ascii?q?4F1AoJRgSNdAgFJQQ4HRVMJJUMSRyQiCBIJARMaLAqBGjU8CSY/FQxbDAgDG?=
 =?us-ascii?q?gUaJgIfCAILAgx0KBEQEx0eJC8FGiY+Gwp+B2Y9NwkMGQQCAUJCHRIClncTg?=
 =?us-ascii?q?TGBLQs6klqRdYxUlF08hCqBdIIQgl+bAxIcF6pymQipRYFuATOBXH0IghSBD?=
 =?us-ascii?q?08DGQ/gX0RxAgcCBwEMAQMLhUaMIgctgUwBAQ?=
IronPort-PHdr: A9a23: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
 O6/mw==
IronPort-Data: A9a23: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
 ms=
IronPort-HdrOrdr: A9a23:l4PPnKni6A53Khq9GRSYkKXtqL3pDfIN3DAbv31ZSRFFG/FwWf
 re+cjztCWE9Ar5N0tBpTntAtjifZqYz+8N3WBzB9aftNWKghrPEGgB1/qY/9QxIVyCygc178
 4JGMIRNDSzNykDsS+d2njeLz9K+qjizEnHv5a98588JTsaEZ2I9z0VNu+AKCFLrRd9aqYEKA
 ==
X-Talos-CUID: 9a23:2Iasnm4npEluEHUYyNssqX4+Jth1aVfk737NJm+SWF9xduCeRgrF
X-Talos-MUID: =?us-ascii?q?9a23=3AAGaCGw6BwdrlOtrBJVMa6MQwxoxE3ImsGkkNg6k?=
 =?us-ascii?q?jqs2vEXdfPBu3ryaoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,209,1787004000"; 
   d="h'?scan'208";a="162459866"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDF6vKGMbOi+jPtCZcxuQ4tSMLFve1GriN2m6P?=
 =?us-ascii?q?MPwMJ+3UjX/E4o0zacEC51mcJyGNKM5mKwPiMUhwzLZs57bNqPqqaODw?=
 =?us-ascii?q?cTrdeSgKHBsp6/e2zfVo88ynaqmU7wiq/6YfcdRbRWwnOhpBSTf9fhG3?=
 =?us-ascii?q?TVhyMTCNZLRr5qIIAK/ADstA=3D=3D?=
Received: from smtp4-g21.free.fr ([212.27.42.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 13:36:16 +0100
Received: from lettres.chocolatnoir.net (unknown [83.159.1.88])
	by smtp4-g21.free.fr (Postfix) with ESMTPS id 1FF7A19F5B2;
	Thu, 12 Nov 2026 13:36:12 +0100 (CET)
Received: by lettres.chocolatnoir.net (Postfix, from userid 126)
	id C4E57CE8E20; Thu, 12 Nov 2026 13:36:12 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
Received: from lettres.chocolatnoir.net (localhost [IPv6:::1])
	by lettres.chocolatnoir.net (Postfix) with ESMTPA id EB207CE8E1D;
	Thu, 12 Nov 2026 13:36:11 +0100 (CET)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 13:36:11 +0100
From: picca <picca@debian.org>
To: Victor Gambier <victor.gambier@inria.fr>
Cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Reply-To: picca@debian.org
Mail-Reply-To: picca@debian.org
In-Reply-To: <e94be607-8aeb-493b-8dec-8415e05551b1@inria.fr>
References: <d4be4d6fe184ccc6147abbe3da5cacc1@debian.org>
 <b225b777-9216-635a-76b8-fc46f6d6a3@inria.fr>
 <45e0468b84f19a5d75ea99fb434113c0@debian.org>
 <0faa3236-0ab2-45d3-953e-6168ce6c8d76@inria.fr>
 <0e99b58f1f63d6ff89889c6f132d4e2e@debian.org>
 <e94be607-8aeb-493b-8dec-8415e05551b1@inria.fr>
Message-ID: <52f7e18cb3dfd61db7e9575c44353928@debian.org>
X-Sender: picca@debian.org
Organization: Miaouh
Content-Type: multipart/mixed;
 boundary="=_d129fcd1f9208b1a1d249f85678cc20f"
Subject: Re: [cocci] Bug dans la parseur de coccinelle ?
X-Loop: cocci@inria.fr
X-Sequence: 3796
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/vB703aqUhmr64Gvb7QeNqg>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1

--=_d129fcd1f9208b1a1d249f85678cc20f
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8;
 format=flowed

Le 2026-11-12 13:29, Victor Gambier a écrit :
> Thank you. I cannot reproduce the error. Could you send me the file 
> "hkl/ccan/array_size/array_size.h", as well as the output of `spatch 
> --version`?
> 
> Victor

here it is :)

$ spatch --version
spatch version 1.3 compiled with OCaml version 5.3.0
Flags passed to the configure script: --prefix=/usr --sysconfdir=/etc 
--libdir=/usr/lib --enable-ocaml --enable-python --with-python=python3 
--enable-opt
OCaml scripting support: yes
Python scripting support: yes
Syntax of regular expressions: Str


Debian stable.

I will test on Debian unstable also
--=_d129fcd1f9208b1a1d249f85678cc20f
Content-Transfer-Encoding: base64
Content-Type: text/x-c;
 name=array_size.h
Content-Disposition: attachment;
 filename=array_size.h;
 size=907

LyogQ0MwIChQdWJsaWMgZG9tYWluKSAtIHNlZSBMSUNFTlNFIGZpbGUgZm9yIGRldGFpbHMgKi8K
I2lmbmRlZiBDQ0FOX0FSUkFZX1NJWkVfSAojZGVmaW5lIENDQU5fQVJSQVlfU0laRV9ICiNpbmNs
dWRlIDxoa2wvY2Nhbi9jY2FuX2NvbmZpZy5oPgojaW5jbHVkZSA8aGtsL2NjYW4vYnVpbGRfYXNz
ZXJ0L2J1aWxkX2Fzc2VydC5oPgoKLyoqCiAqIEFSUkFZX1NJWkUgLSBnZXQgdGhlIG51bWJlciBv
ZiBlbGVtZW50cyBpbiBhIHZpc2libGUgYXJyYXkKICogQGFycjogdGhlIGFycmF5IHdob3NlIHNp
emUgeW91IHdhbnQuCiAqCiAqIFRoaXMgZG9lcyBub3Qgd29yayBvbiBwb2ludGVycywgb3IgYXJy
YXlzIGRlY2xhcmVkIGFzIFtdLCBvcgogKiBmdW5jdGlvbiBwYXJhbWV0ZXJzLiAgV2l0aCBjb3Jy
ZWN0IGNvbXBpbGVyIHN1cHBvcnQsIHN1Y2ggdXNhZ2UKICogd2lsbCBjYXVzZSBhIGJ1aWxkIGVy
cm9yIChzZWUgYnVpbGRfYXNzZXJ0KS4KICovCiNkZWZpbmUgQVJSQVlfU0laRShhcnIpIChzaXpl
b2YoYXJyKSAvIHNpemVvZigoYXJyKVswXSkgKyBfYXJyYXlfc2l6ZV9jaGsoYXJyKSkKCiNpZiBI
QVZFX0JVSUxUSU5fVFlQRVNfQ09NUEFUSUJMRV9QICYmIEhBVkVfVFlQRU9GCi8qIFR3byBnY2Mg
ZXh0ZW5zaW9ucy4KICogJmFbMF0gZGVncmFkZXMgdG8gYSBwb2ludGVyOiBhIGRpZmZlcmVudCB0
eXBlIGZyb20gYW4gYXJyYXkgKi8KI2RlZmluZSBfYXJyYXlfc2l6ZV9jaGsoYXJyKQkJCQkJCVwK
CUJVSUxEX0FTU0VSVF9PUl9aRVJPKCFfX2J1aWx0aW5fdHlwZXNfY29tcGF0aWJsZV9wKHR5cGVv
ZihhcnIpLAlcCgkJCQkJCQl0eXBlb2YoJihhcnIpWzBdKSkpCiNlbHNlCiNkZWZpbmUgX2FycmF5
X3NpemVfY2hrKGFycikgMAojZW5kaWYKI2VuZGlmIC8qIENDQU5fQUxJR05PRl9IICovCg==
--=_d129fcd1f9208b1a1d249f85678cc20f--
