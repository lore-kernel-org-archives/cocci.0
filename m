Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A04C04FFE
	for <cocci@archiver.kernel.org>; Sat, 11 May 2024 17:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=DElZB3vU66P7Z2z8+4IweUOj7TdX3+Aohm68zciHgJ8=;
  b=ZkttoVn6DcPrIbOw/GsI12mffd5JCxWEGV6rZWuRPf0KDaHHtM5qQoFD
   JkRx/EsqgW1euNK5U/AbubDOIsJfDn+kv+WM4JHwq2wifehROfUo1r9x8
   Z1lxsZDGgI+QLg5as6W7Dth4uG8J+01gS53w4YBAC7yFcVEkpAKvXsDw+
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.08,154,1712613600"; 
   d="scan'208";a="165201792"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 May 2024 19:02:41 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 115C9E0CCA; Sat, 11 May 2024 19:02:41 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DB1B1E004E
	for <cocci@sympa.inria.fr>; Sat, 11 May 2024 19:02:38 +0200 (CEST)
IronPort-SDR: 663fa4ae_y9HzyR3fHeqVYVKIAn4gPjTwARLt8KH6NrISnG6mYPRoncG
 zDNvDltXifNiFE4OyJOSZ1bCFga1464czqRGLrA==
X-IPAS-Result: =?us-ascii?q?A0HGBgCjoz9mhwMP49RaHgEBCxIMQIFRgkKBVDMEC0iEV?=
 =?us-ascii?q?pE9MIQ7hzmHT4hxgxY+DwEDAQ1BAQIEAQEDBIR1CgKIPQIeBwEENQUNAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOECeFdA2CZwEQg?=
 =?us-ascii?q?Q6BJgEBAQEBAQEBAQEBAQEBAQEBARcCR0IBAQECASMdAQERJw8LGgImAgJWB?=
 =?us-ascii?q?gEUAQGCfIIwAQMOIwezE4EygQGCDAEBBtpZHywiV4FjCYEaL4gtAYV8hEAnD?=
 =?us-ascii?q?4FVRIE8glIxPoRDg1uCaZokkE9UfRwDWTIBVRMXCz4JFgIWAxsUBDAPCQsmA?=
 =?us-ascii?q?yoGNgISDAYGBlkgFgkEIwMIBAMQNAMgcREDBBoECwd1gXyBNQQTRAOBOIl2D?=
 =?us-ascii?q?IMxgXcphB0IQ2wVg3aBdw5hg1qEUWaBLR1AAgELbT01CQsbBiIBHad6gT3Ge?=
 =?us-ascii?q?DQHgjaBYIFhDJ9EBhMvg3KTRg4GkmiYYiCoZ4F9IoFcMxokgzZPAxkPjiEZh?=
 =?us-ascii?q?BTKfkE1OwIHAQoBAQMJhUYBAYNagUgBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aUIqbh4fXyG
IronPort-HdrOrdr: A9a23:fPGYZ6/EB5pVi1w3w29uk+AGI+orL9Y04lQ7vn2ZOiYlF/Bw8P
 re5cjztCWE7gr5PUtKpTnuAsa9qB/nhPpICMwqTNCftWrd1ldATrsP0WKK+VSJdhEWtNQtt5
 uIGJIfNDSfNykYse/HwE2fD8sqxsWB/ZulnOHE0h5WPHtXgu1bjjuQEWygYzVLreR9dOEE/B
 Hw3KB6mwY=
X-Talos-CUID: 9a23:9WOQvW1daOWIbsfqfIoM/bxfR8kXV3r37nHqCl6jMD01eritaU2swfYx
X-Talos-MUID: =?us-ascii?q?9a23=3A+V7V4Q0WaoIXY5G7ghk+i4Zw5DUj4/mUDG81i4g?=
 =?us-ascii?q?9m9SiDRRqaxvNnS6FTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,154,1712613600"; 
   d="scan'208";a="86775619"
X-MGA-submission: =?us-ascii?q?MDFTAI+rS0Mifg6yGkZw/YVFENhjI5RuQB8+2m?=
 =?us-ascii?q?F5dIJRqCS6NnH5SoDiXBbNBzMZBmbZi59LEhqpgJSvCu/Mhh8u5OwgLb?=
 =?us-ascii?q?UHr1q0ytZ9X09CIBF7Ze2SmNjB/ZRqwbr5cmpkl1Re7SJ1McSXeAcydH?=
 =?us-ascii?q?IeJ49N2gUMk19tyCfOUZ7NJw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 19:02:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715446957; x=1716051757; i=markus.elfring@web.de;
	bh=DElZB3vU66P7Z2z8+4IweUOj7TdX3+Aohm68zciHgJ8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ezaP56tfDeu76+SkhrWK+3QdsiTEEfrIqXRrKA97F3/u7v5leGVI52cHWe69skWX
	 ZMbDVo1PGyLtNk4C5+QKwNhe12Oq0iSe9Um/B1jFWahcJSaHWY/RyXcW2mMXfiE6B
	 9R7+GyJWwX0l55+yibejm+3SG2BN+1Y+0pnTxl9IT2U4UeLjOovheBbcxzh4X83b0
	 fqT5YyRuvw6ErvuQhF9XWQdn4i7em/8NFf7ShkacUhjVHw3RVncIzVvDxgNY9R8/h
	 el/m/EJlBE9lnu3ewIFgvLCekK0eEai2o1EXpZ3EgLZZKaK3bS6O9oPJpYoEsPPP4
	 lmJ/o56fMZnBHlL2OQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHEbk-1rschR1xHk-00DN9w; Sat, 11
 May 2024 19:02:37 +0200
Message-ID: <5b96b1f7-9bc3-41d3-b2fa-a377086702d0@web.de>
Date: Sat, 11 May 2024 19:02:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de>
 <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr>
 <6f5533b1-cbf8-421e-8d7d-8435aa28b360@web.de>
 <alpine.DEB.2.22.394.2405111803140.14453@hadrien>
 <3c953d7c-561d-4ba8-ae23-ffeb12840d02@web.de>
 <alpine.DEB.2.22.394.2405111836340.14453@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2405111836340.14453@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ra/hiCEk5TgXtwbEo/r9qVec3mOl1GcIRu+9VsQXjDBBXs+Pwes
 FcoWY43gGyz+K78sESNUJqiL+oYEMEzpQO/RygaVpO8mBLX3J7WqIKsprloR2JwnilPfoUV
 CaVA0PiLvKkmk2hIJeoygSpVSXHkSY+rhkIjfMXAutiiqMi4SvW5SlKqQMs8RES8ZeGLBEA
 JCfSqb5PSzT8numYNVLhA==
UI-OutboundReport: notjunk:1;M01:P0:V0cNWxtWFZA=;HqLX9ZYWDLDsIcY4Fbxw6Ve64z5
 2mVRTOHXpW5ahkymLmHb+MSVhLHoU8C/8lf5xqurEPqoLWJKp3cnSYIMlXhWaVJCw4gv14yML
 tVqdQT6d++g15Bj7dtCfU3+muarIYvVEgtntbO7/cL2XdJTcAc38ZD5wuDJVp9W2zkM04f46H
 uP+r9oCpnT209n8le9TdqDqZ6a3i3EpfGZhI5QnipxqPb5ufM/7Rs1Q5DC0r8Tem+kWslODWN
 /sa6A2L3KtyUVrGUEZJ/pLKeSQrX/5mh3EJrTCotfeFZx90g2lxG51CZ/mo9Q/TyDsF4121tf
 Rsm3B3g/1iQwrLyJBT7gzargQ6D1H38f8G37zavjeSNTTkqGqd6IDofRLzBPPLNCqGScerY1N
 yTognMw/sh3lcMA8gF0VVPUfET12xh1K9wC74oleyPP1scjPgojWDymvEcxH7Mx9Jg7D5KIFU
 VLidoCtKyqcalH2sXjHgfl9PfdhHucGbWgKPB/w+y28Pg7dNhVPtGjBElLl1v3xUF4Groy/kU
 WLd4QEmh9JlaJQFYFbabEXn6gE/zDWKXyh41tX8aCbHNcOyEyytvtRxSobmaWovlaWg2T/JYD
 sueniSrqOiULO1FO1fs+TVzNkaG7enTJh4wTQf9w/GYeAO5JmJKcbEgfasCwm+QaHt24E0Xb3
 0Xp9WFZuU9+8TmfCo2XjzukXMak+4w97vg+mUbc+ardt5HmGUzv48og6TJTyKKHwvUwCc8gtG
 5SDxgfvhldNv4MbY1OZy9iG4H8ehm8bzlpCzpPbeZgi4wjud/MHLP3fTY5fJOFKCZ8dNIwfaO
 6L0YbK6LdCexU0MgLV3MTRhADMDNYEBUcMmqZ6LmlzR88=
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1717
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/5b96b1f7-9bc3-41d3-b2fa-a377086702d0%40web.de>

>> I would appreciate if undesirable duplication of search patterns can be=
 avoided here.
>
> If you want to find code that occurs at least twice, isn't it most natur=
al
> to make a pattern that shows the thing occurring twice?

Obviously, yes.

Our development views seem to differ in the desire to express such
a data processing task in a more succinct way also by the means of
the semantic patch language.

Which SmPL constructs can indicate a minimum occurrence number (=E2=89=A5 =
2) accordingly?

Regards,
Markus
