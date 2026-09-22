Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3C6C9830E
	for <cocci@archiver.kernel.org>; Thu, 24 Sep 2026 08:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:mime-version:in-reply-to:
   subject:reply-to:sender:list-id:list-help:list-subscribe:
   list-unsubscribe:list-post:list-owner:list-archive;
  bh=LyZRkEeGwjHyuGDTM3KzE4fS3EY6TU6KwxEZkwgCfrs=;
  b=ewK3HaEQ9Erp30oJTYbDQ+fqNKrJ87Ag1nyo00exXRvv28wciyw7n0rq
   BSJbLVvEFM2YRCksa1zo6yCvJOYRi4FahZiZwBWmB0qvf6N4w2e3ne9eb
   noYJqeulUQ0wzqEXcOperXEMcuuK9KH82y25U8mLWq75ZEmS9rluhUqIb
   o=;
X-CSE-ConnectionGUID: 9xVVG5HHSiCz0W2R4tZR7Q==
X-CSE-MsgGUID: xlBw08FKQC61sUhd0Eo54A==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.27,120,1787004000"; 
   d="asc'?scan'208";a="296676812"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Sep 2026 10:37:21 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 13E258240F; Thu, 24 Sep 2026 10:37:21 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 7F12580557
	for <cocci@sympa.inria.fr>; Tue, 22 Sep 2026 21:34:19 +0200 (CEST)
X-CSE-ConnectionGUID: zDNmYpvFR1a93OqMNe6oYA==
X-CSE-MsgGUID: MM0C2JCoR8e3RKM0vaQoRw==
IronPort-SDR: 6ab2d83b_vt58VOF9NdllSUvOLAtIfFde6LDqGFNOpeimqtT3ExN+ibZ
 mu/yBLZOfmIHAU+nTYQwd8NJRdKt4NppS6HtNow==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ENAABz17Jqjx/86qxaHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?AcBAQsBgkCBC2EzBAtJhFiDT4RMX4ZYXQaBIR2BFoRnhXqGd4lbgVUUgWgCC?=
 =?us-ascii?q?AcBAwEIBTcaBAEBAQIBA4R+Ao4KAh4HAQQwCQ4BAgQDAgMBAQEBAQEBAQEBA?=
 =?us-ascii?q?QsBAQEEAQEBAgEBAgQDAQEBAQIQAQEBAQEBOQVJhk8NjBoBM3GBJQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEdAg2BAAEDIx0BATcBXAISRgYBEoMCAYIiBxEDNwPEU4EygQGCD?=
 =?us-ascii?q?AEBBoEJ2iwiXYFiBwIDBhQBgTgBgVeGeQ0BgV2EGzsJglVpeicbfYEQgRWCc?=
 =?us-ascii?q?3aEBiODdYJqghEVgQyUbYFmA1ksAUsKNQwzK4EIAyovgRs8ZRI/Pg83OQI4B?=
 =?us-ascii?q?gVDWoEnVIFGIxk2eoEJXnA7KWABJ4EHgggCglSBKlcCAUlDDgdFUwklSxJHK?=
 =?us-ascii?q?SIIEgkBExowC4EngR49NxUZBI48ECENgisfgmMBgQ4RG4ERB6RpozCEKKI8l?=
 =?us-ascii?q?0CTGi6YWiOkAIUggWg6gVwzGggoCIMiUAMZD44iGYRkhBjHCEI1PQIHAgcOA?=
 =?us-ascii?q?wuSHIFMAQE?=
IronPort-PHdr: A9a23:YBhX2h+xdRZiaP9uWU+1ngc9DxPPW53KNwIYoqAql6hJOvz6uci5Y
 gqHv74w0waWFazgqNt6yMPu+5j6XmIB5ZvT+FsjS7drEzIjt4A9sjdkPvS4D1bmJuXhdS0wE
 ZcKflZk+3amLRodQ56mNBXdrXKo8DEdBAj0OxZrKeTpAI7SiNm82/yv95HJbAhFijuwbaluI
 BmoognctssbjZZgJ60s1hbHv3xEdvhZym9vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2T
 qFWASo/PWwt68PlrRbMQRKR63UTT2saihVHDRTL4xH8RZfxrzD1tvFh1ymAPM35Vq47VDK/5
 Kp2UhDoiSMHNzkk8GHLj8F7kaxWrA69qxF53oXZe5+eOuZgcazBfNMaXWtBUdhXVyxdGYO3c
 o8DA/McMepEs4Xxol0Dpga8CwaxHuPi0jFGiH/o06AkzuovEg7J0xA9EN0Mq3nUo8n5Ob0IX
 Oyp0KXFzzPOZO5W1zfn74jIdwgsrO2IXb1uc8re008vGB7fjlWXtIfoITSV1uAKs2ie9eVgT
 /+khmk9pAF1rTmi3cQshZfThoIT1F/E8T91wIEvJd23UUN2Z8OvH5RMuS+ALYR2Xt8iTH9yu
 CY80rALupC2cTQExZkmwxPTd/OJfoaU7x/+SOqcLit1iXBndb+7iRi+7UutxO38WMS6zVtHs
 DRIn9fCuH0QyxDe6NaKR/1g9Umv3jaP0hrc6uBCIU0sj6XbL4AuwrwqmZoVrEvDBCj2lFzqg
 6+RckUk/e2o5P79Yrn8uJCcLIl5gRz9PKQ2gsGzHOY1PhYUU2SF9+mx26fv8VP5TblUlPE7n
 LTVvIjHKcgHuqK1GRJZ3pot5hqlADqr0M4UkWQEIV9DZRmJlZLmO0vUL/D9Ffq/g0qjkDNsx
 /3eJb3uHI/CImLYkLfmYLZ98VJTxxQpwdBc+Z1UELcBL+z3WkPrs9zYFBA5PxS1w+bhFtp9y
 psTVX+ND6OHKq/er1GF6+01L+WSZIIZpizxJvY46/L2iH82g14dfa2n3ZsNb3C4G+xrLF+dY
 XvjmdoBEnkFvhA4TOP0jF2OSzlTZ2y9X64k/DE0FJqmDZvfRoCqmLGB2D20H5NMaWBCDlCBC
 nbpd4SBW/gXciKdONVtkj0CVbi7So8uzwuitAHgy7Z/NOrb5jUYtY7/1Nhy/+DciRYy+iBoA
 MScyGyNVGF1nmYQRzAsxqx/oEp9yk2C0adimfBYG8ZT6+tPUgghLZHc1fB1C8juWgLdedeEU
 EiqTs2pAT4vSdI/wMUAbl5zFNu/lhzDxTSlA6EWmbKRHJE06bzT0GLrK8ZmzHbGybMhgEU4T
 cdVNm2pmLR/9w7NCI7NiUmZkLyqdasE0CHQ92eDzG+OsVlAXgB/X6rLQ2wRa1fQo9jh+0zCS
 qWhCa47PQZZ0cCMM7NEZNLxgVVdXPfjNszTbXitlmmtGBiE3qiMbJLke2oF3CXSFkwEkwcL8
 HieLAYwHiiv8CriC2llElnkYmvt9/N/oTW1VAt87RyObkQp87Oq8xoRzai+VvcS1/QgsTgor
 zFcHVCn3tuQBcDW9CR7e6AJSNcw4l5B2Xje/yd6OpulJroq0lcaYyx0slno2hExDZ9Px5t55
 Eg2xRZ/fPrLmGhKcCmViNWpYuW/wgja+Rmub/STwVTCyJOM/axJ7v0kqlLltQXvF0w48nwh3
 cMGm2CE6MDsCwwfGYn0Tl5x7wJz8rjecgE+6pnS2HkqNrO74XfZw9x8POI+0V67estHdqaNF
 Qv8CcofUsGqOMQplkKvYxZCO/pdp+YvJ83zUfyA1eawOfp42jKriWMS+IdmzkeF7DZxUMbT0
 p9D2PaFxACKETTxllGstobwg48siSg6OG25xGCkAYdQYvc3ZoMXESK0JMbxwNxihpnrUnoe9
 Vi5BlpA1tX7MRyVJ0fw2wFdzyF16TSuhDe4wjpokjoosrvX3SrAxP7nfQYGPWgDTXdrjFPlK
 4y5x94AW03gYw8snRqjrUH0osoT7K17P0HQTF1OciywKHttE+OxureEf89T+cYwqywEGO+4Y
 F2cVvv8u05DjHmlRTACgmpmLXfx48ac/VQykm+WIXdtoWCMfMhxwU2a/9nAXbtL2TFAQiBki
 D7RD1z6Pt+z/NzSmY2Q14L2H2+nSJBXdjHmiI2asy7ur2RuETW8kuq1l9mhFhI1m3yzx5xxW
 CPEoQypKIDvx4y5PPhhc00uA0XzoZkfeMk2gs47g5ce3mIfj5Oe8C8ckGv9Bt5c3Lr3cHsHQ
 TNjL8f92AH+wwUjK3uIw9i8TXCB2o57YNL8ZGoK2yU75sQMCaGO7bUCkzEn6la/qAvQZ7B6k
 FJ/gbMn7G4ygOwTvgcpiCKHDfgeEFJZMirlixmTp4nh9uMNPzrpK+XqkhEn1dm6RKmPuARdR
 Gr0dt85ECl8498+VTCEmHz/54f4ecXBONcatxmaiRDF3KBeLJM8kOZPhDIyYD2n+yd+l6hh0
 EYohsjp2erPY39g96+4HBNCYzj8ZsdJvyrokb4bhMGdmYamApRmHDwPGpruV/OhVjwI5pGFf
 06DFiMxrnCDFP/RBwiavQ1vq2LnEJ2xMXyTYn4Dwp8xDAnYP0FZjA0OCX8zmo4RFQ2wwsHlN
 kBj6XpCgzyw4gsJweVuOR7lV27Zrwr9cTY4Rq+UKx9O5x1D7UPYYoSOq/h+FCZC8ti9vRSAf
 yaFMh9QAzhDCSnmTxjze6Oj7t7a/62EC/qierHQNK6Wp7UWVu/Ul8/1lNE7uW/XZ4PWYiEqD
 uVniBMcBzYgQ5mfx3NVFnBy9WqFbtbH9k7joGst9Zz5qqmxHlm2rYqXV+kLbo8poUvqx/7Zb
 6jL1G54MWoKj8xWgyaQlf5BgBhL230LFXHlB70EsWSloLv4vKhRAlZbbipyMJEN9KcgxkxXP
 sWdjNrp17l+h/pzClFfVFWnlNv7LcoNa3qwMl/KHiPpfPyPOCHLzsfrYKi9VawYjeNasAe1s
 CqaFEmrNyqKlj3gXRSiee9WiyTTMBtbsYC7OhFjbAqrBMrhcQG+OcRrgCce2rA9wGjNKHQXP
 H5/fllLo7nW6jlXw71+F2FH8nt5PLyEliKevIy6Yt4dtfpmBDgxlvoPuStgjeEOsGceGaYzw
 3KBy7wm60urmeSO1Dd9BR9HqzIRwZmOoV0nI6LSsJ9JRXfD+hsJq2SWERUD4dV/WbiN8+hdz
 MbCkKXrJXJM6dXRqIEVA9j8K8+dNncldx3zF3SHaWlNBS7uLmzZi0FHxbuK8WaJq5EhtpX2s
 IEDQ/lAU0EvHf5cCUl/GtEGZpBtUXl39NzTxN5N7n24oh7LQcxctZ2STfOeD8LkLzOBhKVFb
 R8FqVsXBYceLIv23wplcFYoxewi/mLTUMpLryknaRU78h0lGJlWVWA6nVnidxmm7TkQGOSyk
 xpwjRFxM7xFyQ==
IronPort-Data: A9a23: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
 gSRD7MC6Ihp5ayfNHB6CenExn6pbk8xMg==
IronPort-HdrOrdr: A9a23:gf1Un6+gQI91u/Nvyexuk+ALI+orL9Y04lQ7vn2ZKCYlFPBw8v
 rEoB1173LJYVoqNE3I4OrwXJVoGEmskKKdgrNwAV7BZmfbUQKTRekJ0WKI+Vzd8kPFmdJ15O
 NBWOxFBNr8DV91yebiiTPIdOoI8Z2m2+SXiez+yXFuYAl2Y8hbnmREIzfeMmYzegVMJJw+Fr
 eV+8IdzgDQG0gqUg==
X-Talos-CUID: 9a23:kXL0wGCc3cp/KC76EztL0kslAt4LSCTUnSz3OmqeBDhueZTAHA==
X-Talos-MUID: 9a23:xfvpvQUiJ0bNFizq/BrJ3Bo4Fuxv2fSjU3outM0YsvCDDzMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,117,1787004000"; 
   d="asc'?scan'208";a="296368503"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGD69WsUD7NEbVooF+RDWPP7fiyirJ77ALQBV?=
 =?us-ascii?q?d8mSKEg0pcwqIk1B0/2ZXIyX3x+Hh6s9m6j5lHb3EQ8OoabbAX3Qnp9/?=
 =?us-ascii?q?RRSOITTfTSc9w9zRhgBFPiKv78K3cgy+uYWqoWXk5qCt5ysaPQNLJjMp?=
 =?us-ascii?q?8UTQ1JX4LRMMMQQHfIEaDDnQ=3D=3D?=
Received: from sea.source.kernel.org ([172.234.252.31])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 21:34:18 +0200
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9AEE74109A;
	Tue, 22 Sep 2026 19:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7082B1F000FF;
	Tue, 22 Sep 2026 19:34:12 +0000 (UTC)
Date: Tue, 22 Sep 2026 21:34:09 +0200
From: Alejandro Colomar <alx@kernel.org>
To: cocci@inria.fr, Julia Lawall <Julia.Lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, Kees Cook <kees@kernel.org>, 
	Nicolas Palix <nicolas.palix@imag.fr>
Message-ID: <arLXllXUgeG7jdpw@debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bgdsfgnlwxuc6r6g"
Content-Disposition: inline
In-Reply-To: <2ae22f8b73f6424020a6fe876cf2120c7d75b552.1773612610.git.alx@kernel.org>
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v3 (resend)] scripts/coccinelle: Add script for
 using ARRAY_END()
Reply-To: Alejandro Colomar <alx@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3740
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-09/EA_3ymetn9dTXBZJl7wyCg>


--bgdsfgnlwxuc6r6g
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: cocci@inria.fr, Julia Lawall <Julia.Lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, Kees Cook <kees@kernel.org>, 
	Nicolas Palix <nicolas.palix@imag.fr>
Subject: [PATCH v3 (resend)] scripts/coccinelle: Add script for using
 ARRAY_END()
Message-ID: <arLXllXUgeG7jdpw@debian>
MIME-Version: 1.0
In-Reply-To: <2ae22f8b73f6424020a6fe876cf2120c7d75b552.1773612610.git.alx@kernel.org>

Recently, we added an ARRAY_END() macro to simplify finding a pointer
one past the last element in an array.  Such a pointer is often called
the 'end', and thus the macro name.

Make it easy to find more places where that macro should be used.

See also:
436debc9cad8 ("array_size.h: add ARRAY_END()")
8118f197b7b7 ("mm: fix benign off-by-one bugs")
a9e5620c9a9e ("kernel: fix off-by-one benign bugs")
61e9210e2392 ("mm: use ARRAY_END() instead of open-coding it")

Cc: Kees Cook <kees@kernel.org>
Cc: Markus Elfring <Markus.Elfring@web.de>
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---


Hi Julia,

Resent the patch now, as you asked me to do.


Cheers,
Alex

Here's the original message that came with the patch:

Hi!

This v3 only has one change: I've removed the comment about the false
negatives.  They were due to spatch(1) not being able to correctly parse
unrelated code elsewhere.

See range-diff and interdiff at the bottom.


Have a lovely night!
Alex

 scripts/coccinelle/misc/array_end.cocci | 73 +++++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 scripts/coccinelle/misc/array_end.cocci

diff --git a/scripts/coccinelle/misc/array_end.cocci b/scripts/coccinelle/m=
isc/array_end.cocci
new file mode 100644
index 00000000..88c664de
--- /dev/null
+++ b/scripts/coccinelle/misc/array_end.cocci
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Use ARRAY_END instead of an expression derived from ARRAY_SIZE
+//
+// Confidence: High
+// Copyright: 2026, Alejandro Colomar <alx@kernel.org>
+// Options: --no-includes --include-headers
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+@depends on context@
+type T;
+T[] a;
+expression b;
+@@
+(
+* (a + ARRAY_SIZE(a))
+|
+* (&a[0] + ARRAY_SIZE(a))
+|
+* (&a[ARRAY_SIZE(a)])
+|
+* (&a[ARRAY_SIZE(a) - b])
+)
+
+@depends on patch@
+type T;
+T[] a;
+expression b;
+@@
+(
+- (a + ARRAY_SIZE(a))
++ ARRAY_END(a)
+|
+- (&a[0] + ARRAY_SIZE(a))
++ ARRAY_END(a)
+|
+- (&a[ARRAY_SIZE(a)])
++ ARRAY_END(a)
+|
+- (&a[ARRAY_SIZE(a) - b])
++ ARRAY_END(a) - b
+)
+
+@r depends on org || report@
+type T;
+T[] a;
+expression b;
+position p;
+@@
+(
+ (a@p + ARRAY_SIZE(a))
+|
+ (&a[0]@p + ARRAY_SIZE(a))
+|
+ (&a[ARRAY_SIZE(a)]@p)
+|
+ (&a[ARRAY_SIZE(a)@p - b])
+)
+
+@script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING should use ARRAY_END")
+
+@script:python depends on report@
+p << r.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING: opportunity for ARRAY_END")

Range-diff:
1:  9fd8d3d1 ! 1:  2ae22f8b scripts/coccinelle: Add script for using ARRAY_=
END()
    @@ scripts/coccinelle/misc/array_end.cocci (new)
     +//
     +// Confidence: High
     +// Copyright: 2026, Alejandro Colomar <alx@kernel.org>
    -+// Comments: No known false positives, but has a few false negatives
     +// Options: --no-includes --include-headers
     +
     +virtual patch
--=20
2.53.0


----- End forwarded message -----

--=20
<https://www.alejandro-colomar.es>

--bgdsfgnlwxuc6r6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmqy2DAACgkQ64mZXMKQ
wqmzZxAAh6rn8C76/pC5Mcyo3fPnYz2BuRJ08FOCPgHHPl9l/BuNycfl/1Iq9/Wy
ncBSO1uwPA03/WGVYukzlNCGA2Lr0jT8B1Ni2YIvmCcNObdR12sEFtZFh8VeAd4z
1CUE3CjcgN4APU9k+PsC58ftmaEP+US40HGlCGZIUSOyZ+z/Aflz198XnWMF0Ht1
2D0voAgFsSDA1vz6YZ+YEu8vlQs+RtZBMdati1qk6y6ItsVd4pcU0uimCz1Kc5c+
VoEiqdrwSXj1QPg1KfDN5uX5G/9E/hBYmJAleBJPznlia8+0cJHnr2vdsejsjSmS
0VXycfk8AdPgv7F57w6NDjVYWM41x4O/zBNp9tNaQBabX/Nm1RpEKAZIOO27nuBC
UPUd8s66LtenDcs85RPihmX7XIQ4HlV/u6enfht1hLRbLPs5kinLQVMPzOWVLvtf
uIsJZILEWxmF/pJgvoyCByeJm+uQKLhKb6EdPBlDjxi4LAHeI8dmGDV2XdO2tVYH
Zdm4mFXHHknIXUSvNXxn0ftt33Iao8+7cra6+myME7OSTs7rChFmQkGZqqlp3boQ
XP996MVW/4ef/CabRzj1+3TOgODfhBwjbtZYSVCX9f5Lx1EsvKNsdGE3v+BtTNfl
7jh//jGlVT6he4h202HyPlV9RkOa2sNP7WLzCwueMQGxmQENf6Q=
=/qWe
-----END PGP SIGNATURE-----

--bgdsfgnlwxuc6r6g--
