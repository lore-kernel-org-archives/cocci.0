Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AFBC4345F
	for <cocci@archiver.kernel.org>; Sat, 13 Apr 2024 14:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=M8DFZODmUf8xfSZH7j4X/yyb2nvIgc0TL3tU0CvHTXI=;
  b=Y868TtqbyDeYj9FpJ+CtpFOfmnnKu8VTt5Mw6KDHh7Km5eo9RxBDKmyV
   UANGAsQDDx6jmy/Ott5oi7HCy8XhrVuaBxEFumNssTBdkr4216CJfbis2
   RGXi106GUeFFY7EQ60aQylC5cwey8CKbgjI1sbeOhmvhOla1WVCqzYMww
   w=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@sang-engineering.com
X-IronPort-AV: E=Sophos;i="6.07,199,1708383600"; 
   d="asc'?scan'208";a="161420853"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Apr 2024 16:25:55 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A16D3E0CCC; Sat, 13 Apr 2024 16:25:55 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DFDF4E004E
	for <cocci@sympa.inria.fr>; Sat, 13 Apr 2024 16:25:52 +0200 (CEST)
IronPort-SDR: 661a95f0_lujn4Q7EtAS5RqUwwZshhL75wevcUXhogwbqGNemS2Y7bBQ
 SyDgpCVSa2FO4KNG2LatUVnOMJWuZosPOeQuU5w==
X-IPAS-Result: =?us-ascii?q?A0GUAADLlBpmkCH+dcJaHAECAgEHARQBBAQBQYE7BwEMA?=
 =?us-ascii?q?YJDgVEwAwcISIxzX4hvkmGLJ4F+CAcBAwEIBUQEAQEDAQOCC4J0AogZIAYBB?=
 =?us-ascii?q?DAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBAQEBIB4QC?=
 =?us-ascii?q?gQnhW0NgmcBgQWBDQEBAQEBAQEBAQEBAQEBIisCgQkBAQECAUABATcBBAsLR?=
 =?us-ascii?q?lYGG4J4AYI8IwexS4E0gQGCCgEBBtwdgVoHCYFIAYFWhkwLAYFTg1yEE3qCT?=
 =?us-ascii?q?4Q/PopkIpgwg1WFeFSBGQNZIRMBSwpFCwQMGgIvDSQjAixKChACFgMdGDIRC?=
 =?us-ascii?q?QsHHwMqBjkCEgwGBgZbIBYJBCMDCAQDUAMgcBEDBBoECwc4PYF+gT0EE0QDg?=
 =?us-ascii?q?UKKFAyBfYE0KYFQKYR+cYQbgTkDRB1AA3g9NRQbKAGcYzCDG3RgSQ6CP8V0h?=
 =?us-ascii?q?B2hREkDg1wBk1OSbphionmGDIFkOoFcMxojgzdPAxkPjjmDYZxnRDI7AgcLA?=
 =?us-ascii?q?QEDCYkigUgBAQ?=
IronPort-PHdr: A9a23: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
 J8HS7sdRlEoDatBTEhoToVqHQ==
IronPort-Data: A9a23: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
 Qo=
IronPort-HdrOrdr: A9a23:NwkY96tNUAoS7AUhdfMq/IQr7skDQNV00zEX/kB9WHVpmwKj9/
 xGuM5rsyMc6QxhP03I/OrqBEDuexzhHPJOj7X5eI3SJTUO21HYSL2Kj7GSoQEIcheWnoQx6U
 4jSdkaNDSaNykYsS+V2miFOudl/PTCyqS0nKPlw212TQdsApsN0ztE
X-Talos-CUID: 9a23:oOkc6GCbbBF741j6EwRL62klEMs0S1/2wC73DGDkJXpnEZTAHA==
X-Talos-MUID: 9a23:pJEBqwXOq+wjSXrq/Bi0vD1YM8R12paVUUUki5wou/DDNxUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,199,1708383600"; 
   d="asc'?scan'208";a="161420848"
X-MGA-submission: =?us-ascii?q?MDFtKRYoNpL2nv4N/B9Bcoq/A0bhTXnG6NCHRB?=
 =?us-ascii?q?/BRr6JsZqz7rejLC0reccc0d7Y2r0ctxSyAkIqq5WqTMUUn66yAj55p8?=
 =?us-ascii?q?5OZwdbh3ngj45aHqWDkfauIGFT3UsppovPzKoi+K3H86qQdR714lzwBl?=
 =?us-ascii?q?1QwJqQGd0WLvXi4EiNpMg+ig=3D=3D?=
Received: from www.zeus03.de (HELO mail.zeus03.de) ([194.117.254.33])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2024 16:25:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=M8DF
	ZODmUf8xfSZH7j4X/yyb2nvIgc0TL3tU0CvHTXI=; b=DVmDDlTU9Z0QDFuPyHtn
	wpuEGi8CPLg1PGmcKqNltyyOqBIKOs80+fketkBS0zZdBVLYyrC8ED+n6SAqu3ok
	lKSWFewtLduIkD5ZmMi46TnnrYpEI4sznf2KCKB/cEX+wUu+dEr1iISEJXSrsO+d
	dpU52Ov9NNVuEfAiQwO+PRJWuO+g/cplzsb03X9wak7S6EvTTXTQK8t+C9Tb1M3U
	QlMEnJXc/TiF/5pMXyr4mZ0O88WFPsQzNnl3HrklEGv+giuTuM/lq8HY3haiyitc
	AWjlMHsthcLE+uKk/JBPTFoG7ziVN/m1htjSm5XzQn6fy4RyAotFTwouks0COAP4
	uQ==
Received: (qmail 1531301 invoked from network); 13 Apr 2024 16:25:51 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Apr 2024 16:25:51 +0200
X-UD-Smtp-Session: l3s3148p1@He5MKvsVC7ZQk7GI
Date: Sat, 13 Apr 2024 16:25:50 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
Message-ID: <cz2lsskp62xcr6biadxwzzoy4p2ijhx4pvpew555zkyhhbzuft@ssb45xj53yi4>
References: <20240413065726.2197-1-wsa+renesas@sang-engineering.com>
 <20240413065726.2197-2-wsa+renesas@sang-engineering.com>
 <45e717c6-80aa-4ac1-b682-821e73328e77@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="opappcwzznugzaib"
Content-Disposition: inline
In-Reply-To: <45e717c6-80aa-4ac1-b682-821e73328e77@web.de>
Subject: Re: [cocci] [PATCH 1/2] docs/manual/Makefile: check xxdate only for
 HTML builds
Reply-To: Wolfram Sang <wsa+renesas@sang-engineering.com>
X-Loop: cocci@inria.fr
X-Sequence: 1651
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/cz2lsskp62xcr6biadxwzzoy4p2ijhx4pvpew555zkyhhbzuft%40ssb45xj53yi4>


--opappcwzznugzaib
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Markus,

> How do you think about to improve the software build system accordingly?

I also thought it would be a good idea...

> Would you like to support any additional build options?

... but I refrained from doing so since it exceeds my autotool-foo and I
have no bandwidth to improve it.

So, this task stays for someone else.

Happy hacking,

   Wolfram


--opappcwzznugzaib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmYaleoACgkQFA3kzBSg
KbZLEA//ZZZ0yK0DWilVZGy/nkBq6T084LpWyZr7Vq890RwajicTsiQT3Pw9adrh
z0jVfgshDIkxei4dcoTzYYFEnl8gnovC+cSl0z60t7554e/3DMB4cryb/uU2SaEL
3jfbM6eYP1LL5+eD55iWcCwn7nRv+coZ79v6klxge3iZG1x6wyGRg+mxE/GF8OKF
BnQRy4mC9C0X/BDoeDs4xIoGmcxgNbb97aYc0PycZxV/sY3n4UhRt1M52pLF+7S4
v6o0T5avuNhmZqepgAgXGjWSkBaNTINYxi7IN2pW9gJNMlYyhWK5HsPJBT+xWTGV
2EdMUQs2Dx2pxiHvj34PnitESPmHUm8SBjj4C2rQuJcscrszDfTPcqODvDI2MQmy
ZfMY1MCEIRQnj/8K4vIg+1743g1Fgf+s20YkxWqjie3P7dOanO/8THRwGD98DbUM
2XSToLsm5OO2P4URPOQV+JErQHZ1zUjxF2gflNqjZL9C9Kb/KQhp9dhuHpitgQiQ
+y/qepyVgR4GIZKfhRRx4z4j2TrXHF6cT+laeOKvuUk0WmbEJjmw7Kj1m7WpO2An
oQMHWbN2EIBdoJgiRfpAw0BPNLecZ8dd6G0jfy2rCI7aKWnRF55QoBvy1EulUQId
H9XzdXBYLhXxX9s5RK+A3uSRGJYcjwySnRAA9S/z+pMnm8I9qfI=
=zX6u
-----END PGP SIGNATURE-----

--opappcwzznugzaib--
