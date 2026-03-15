Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C788F46424
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2026 09:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ogl36sDc4lA7zd3iAm+79l5Zxy3RYlQtKbABYdJcUws=;
  b=AUXm3r9XK+DNc9sbgjgi3gh/H04nHWZOiOVVHLElf0n/IHSbJbo8mKaw
   /f36ScCN5dOkY+IxLSA6f9lzC5T2PNccJz6cDGxLpIQ4+vNBHb33LpXc3
   yhI3upwJdP9crcouVulGR+3kbOhQN5r0c1sFG4hvN4LXyaBw43uwfaheF
   Q=;
X-CSE-ConnectionGUID: 1h/o38UBTga7U8Z3dv8Y/Q==
X-CSE-MsgGUID: DyfT0OB2QlutOKmp/lo8JQ==
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
X-IronPort-AV: E=Sophos;i="6.23,123,1770591600"; 
   d="asc'?scan'208";a="267915507"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Mar 2026 10:29:28 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 051E981F65; Mon, 16 Mar 2026 10:29:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 03FA580E2C
	for <cocci@sympa.inria.fr>; Sun, 15 Mar 2026 18:18:05 +0100 (CET)
X-CSE-ConnectionGUID: fNOAkxQHRFmU8BAgDi7LNQ==
X-CSE-MsgGUID: 9/wWPJXdT3CI7c3UZWOTNQ==
IronPort-SDR: 69b6e9cd_OKWWgF64I/9N4/8zmrdNmJMFGMPDsaQ8Rx+PvmtUMCuJzB2
 lb6sG+OzCNKn8vkErebfgwMC4b9hyhp1TKM9vtg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HtAQBH6bZphR/86qxaglmCQYEHXzMEC0mEWINPhSyGW?=
 =?us-ascii?q?FsBAQaBQYV6hXqGd4svgX0CCAcBAwEIBTcaBAEBAwEDggyCdAKNIwIeBwEEM?=
 =?us-ascii?q?QgOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQEBQEmGT?=
 =?us-ascii?q?w2CYgEzcYElAQEBAQEBAQEBAQEBAR0CDX4BAQEDIwQZAQE3AQ8LGCoCAhBGB?=
 =?us-ascii?q?gGDFAGCIgdKA7NtfzOBAYIMAQEGgQjbIoFeCQMGFAGBOIFYhnAMAYFdhBeEA?=
 =?us-ascii?q?HonG32BEIEVgyo+iB6CaYImgQ6JB4olUoEUA1ksAUsKNQwzK0VDAyovUEsFN?=
 =?us-ascii?q?2USPyEdDxwfOQI4BwUSIREZgUR4ggEPhmp5AyMLXhoOIgI5XEo+XQWCLQInA?=
 =?us-ascii?q?3g9NxQbBIxfECENghA9gi1hYIJ3kmqyD4E+hCaiOJc/kxkumFgiqR+BaQE4g?=
 =?us-ascii?q?VwzGggoCIMiTwMZD44tDQmEWYQYxBVCNT0CBwIHDQMLkhyBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:JvV3L60ISsAnSSJmyfbD5VB1kn2cJEfYwER7XKvMYbSIYQITYwd3j
 TtIBzjCf73ffDO2KOnCW/2y9hgDvMWDm94yGgpp/H0xE3kVopedXNrGcRyrZHucd5TNHBk34
 59EY4WcJZ9rQ3WB9hqhObK/8CYk2aiBTeahYAKo1lidYCc9IMt2oUI4wIbV+7JVvOVVIz9hm
 Puo/ZSHZlX+12AlbGlLtvvc+E0/5qWv6W8SswJmO6hG43bTxiIfZH49DfHofiGgGuG4PcbjG
 r2dlOnhlo/9101wYj9wuu+jKiXmepaLYE7TzCMQA/X/6vR7jnRa+r4hM/YBYltghTyMntRgo
 P1ArpXYpT0BZ8Ugo8xDFUMDe81CFfceouGfeiHi6ZX7I3DuKhMA/d0+VCnaAqVDoo6bMUkWn
 dQEJTYEaAy0hu7e6NqTVul2i80/G9LgNYUZt2sI5Wmx4SEOHPgv642TjTNp9G9YavJmRZ4yV
 OJFAdZbVyksVjUUUrsh5D3Sq8/z7pX3W2UwRFt4PsPb6UCLpOB6+OCF3NY45rVm7Cia96qVj
 juuwoj3Pv0VHNK57hOG4kuMvMHKoHPRcY0+FeKc0Mc/1TV/xkRLYPEXfUC2qL+ijVOkUN8ZK
 EEO/Ccq668o+yRHTPGkAEf++iXY+ERBAZwLSoXW6ynVokbQyw+dFkAHQyRHZdhgs9U5LdAv/
 gXXwIO1Xm0w7tV5T1rMsairlRGCNRROBk5dbnQ5fzQi3//a9dRbYhXnFYo8TP/k1bUZAwrYx
 zmVpSw6r6cSiMQR3uO6+0rGinSivPDhRQk+7QT/RXOg9go/ZYi/ZoXu50Kz0BpbBJ2URx+au
 2UekMXY7+0UC5yJ0iuXT43hAY1F+d6LFhr1gk5WP6MP8gn90VesUYEPxBdHcRIB3tk/RdP/X
 KPEVepsCHJ7J3ajK7Rwfpi6BoIpwLLmGNCjUerbBjavXnSTXFDalM2NTRfKt4wIrKTKufxnU
 Xt8WZv1ZUv28Yw9kFKLqx41iNfHPBzSOl8/tbigk0v7gOvFDJJkYb4GOV6Hb6gl4aiEpgLR9
 NleOtDCyhNUFoXDX8UjyqZKdQpiBSFiVfje9ZcNHsbdeVUOJY3UI6SKqV/XU9c+x/wN/goJl
 1nhMnJlJK3X3yaZdljaMSw6M9sCn/9X9BoGAMDlBn7ws1BLXGplxP53m0IfLOZ/pt9wh+V5V
 ecEcMimC/FCAGaPsTcEYJW36MQoeB23jEjcd2CocRouTa5GHgbpw97Dehew1S8sCiHsi9Ayj
 Yf93SzmQL0CZT9YMuDoVNyVwWmM4EctwNBJYxOQI/14Wlndz4xxGimg0t41O54tLDvA9Bu71
 iGXIw0qlcvQkbAq7dOSp6alrpioIcR6DEF1D2nW1pfoFCj4r06I455Mb/aMRh/ZDFjLwaSFY
 f5E6c38PNksvkd4g6AlH5lFlasBtsbS/ZlExQFaLVD3RlWMCII4BEKZ3MNK55Z/9pUAtSSYA
 kuwq8RnY5OXM8bYEXkUFgovTsKH8do2wjDyz/AEEH/W1R9N3oiscBttZkGXqSlnMrFKHpsvw
 r4htO4o+gWPsEcWHejcvB9E1VanDyImaLomhKE4EYWwqwsMy3N+W7L+JBLywqmyb4RrDhF3D
 B6S3LHPlpZN9HrkKnATL0XA7cBZpJYJuS1J8mM8GkS0qoLFq8IzjTJs8mURbwVKzx94/fp5F
 Up1OmZUe6if3Tdaq/JSfmKrGggbOgyT/3Lq715YhV/IblKJU1bVJzYXIte9/0E+8kNdcANE/
 bqe9n3XbDbycOz13QowQURAqcG/fedu9wbHpt+rL/6FE7Y+fzDhpK2kPkgMlDfKHuIzgxfhi
 dRx3eMtd5D+CzEck5c7B6aey74UbhKOf05GYPN5+ZI2DXPuQy6z1ReOOnKOVJt0fdKSynCBC
 utqOs5rfDa93nzXrjkkWIg9E4Utl/stvNc/arfnIFAdiISmrx1rjYnx8xbvj2p6UvRslscAc
 rnqTQygKVDJp3VomD7qlvJma06YetgPYTPu0N+lqNspE40xi8AyUEUQ/IbtgVCrHlpGxS+Eh
 CLCeK7c8MJ6w6tOgYbHM/tOFie0G/zJRcWK9wG46epOSdXpL8v+lQEnkQT9DTR0IIkuRMl9z
 paLkd/o3XHquKQ9fHDZlqKgSYhIx5SWd8hGPv3nKEJ1mXO5Z/btxB8Y6kaEKZBtu/FM1PmNH
 geXRpO5So8IZo172nZQVRl7Lz8cLKbGNoHbuiK3qqW3OCg3iADoAouuyi70UDt9aCQNBpzZD
 z30sdaI4vRzjtxFJD0ANsFcL65IGn3Rcop4SISprhidNHeivX2asLi7lRYA1yDCOkPZLOnEu
 6D6VjrMXzXsnprXzeNpkZ145TwWK3dfvdMeXGwg//xOtjTrK1JecMo8N8wKBKgBx2a2nNv9a
 SrWZWQvNTTlUH4WOV/g6dDkRUGECvZIJt79IScz8liJbzutQrmNG6Zl6jwq9kIeluEPFw17A
 Yp2FrzM0hmNLlVBXusaoOe8nP1sy7XZy2gO9ES7lNb9a/rb7XPmy1Q5dDehlwSeey0OqKkPD
 Ws4X2ZJRAe8U0GZ/QNIZStOAB9A1N/w52xAUMpMqeozf62YwfdGxfm5PPv8ulHGgALmO5ZWL
 U7Kq6CxD6x6F5DdVWbFez7kvEOsNc+2Iw==
IronPort-HdrOrdr: A9a23:3Npjo6ov1DcitiWiN4TNkYQaV5okeYIsimQD101hICG9vPb4qy
 mLpoV96faUskd0ZJhEo7290ca7LU80maQb3WBVB8bFYOCEghrMEGgB1/qA/9SIIUSXnYRgPO
 VbAspD4bbLbWSS4/yV3DWF
X-Talos-CUID: 9a23:F6LqO221BKcQLQ680adBw7xfFOYCW37N9VfqDUqFWUxAR5GUFnu2wfYx
X-Talos-MUID: 9a23:NwvTIAakgbCOauBT5njzuwlABMtUuI+PV0tWrKc5nPWiDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,122,1770591600"; 
   d="asc'?scan'208";a="267843976"
X-MGA-submission: =?us-ascii?q?MDEx8H8Q4StmkY9n055jpudYnLE0Ro8qS78BgX?=
 =?us-ascii?q?qt/7kn2rSO+NAGM/Iu1Pi6BpyP41oX7fSo87q4mn1MNz3dbUEXWnk8jn?=
 =?us-ascii?q?nXwED6RNRsdNK/aDLcH++qiX+xdXaXrtHoAYM6MmqtUeYDUIo9uNfE4I?=
 =?us-ascii?q?bk8oc5dA3KUELXytRkU6OCzw=3D=3D?=
Received: from sea.source.kernel.org ([172.234.252.31])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 18:18:04 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B9D4C40388;
	Sun, 15 Mar 2026 17:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FA0C4CEF7;
	Sun, 15 Mar 2026 17:17:59 +0000 (UTC)
Date: Sun, 15 Mar 2026 18:17:57 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>, 
	Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr, Nicolas Palix <nicolas.palix@imag.fr>, 
	Kees Cook <kees@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org
Message-ID: <abblv3nCut5aRk7q@devuan>
References: <cover.1772752564.git.alx@kernel.org>
 <9fd8d3d1e7ef3efb6e6dae0972dd515ff02e42bd.1773058287.git.alx@kernel.org>
 <806bcb6d-3ebb-4454-973c-f9d6530a17c2@web.de>
 <aa7XD-rk_KWQvTQX@devuan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="opxaxau6jwzrl3oj"
Content-Disposition: inline
In-Reply-To: <aa7XD-rk_KWQvTQX@devuan>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2] scripts/coccinelle: Add script for using
 ARRAY_END()
Reply-To: Alejandro Colomar <alx@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3434
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/iVBtt-p4d8aYYtCU2pQJxA>


--opxaxau6jwzrl3oj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>, 
	Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr, Nicolas Palix <nicolas.palix@imag.fr>, 
	Kees Cook <kees@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] scripts/coccinelle: Add script for using ARRAY_END()
Message-ID: <abblv3nCut5aRk7q@devuan>
References: <cover.1772752564.git.alx@kernel.org>
 <9fd8d3d1e7ef3efb6e6dae0972dd515ff02e42bd.1773058287.git.alx@kernel.org>
 <806bcb6d-3ebb-4454-973c-f9d6530a17c2@web.de>
 <aa7XD-rk_KWQvTQX@devuan>
MIME-Version: 1.0
In-Reply-To: <aa7XD-rk_KWQvTQX@devuan>

Hi Markus, Julia,

On 2026-03-09T15:32:24+0100, Alejandro Colomar wrote:
> > =E2=80=A6
> > > +// Comments: No known false positives, but has a few false negatives
> >=20
> > Would such information motivate for any further software refinements?
>=20
> Yes, if anyone here knows how to handle the false negatives and wants to
> work with me on improving those, I'm very interested.
>=20
> Here's one case which isn't caught, for example (which I expect will be
> difficult to handle, if not impossible):
>=20
> 	@@ -2876,7 +2876,7 @@ static struct dentry *proc_##LSM##_attr_dir_lookup=
(struct=20
> 	inode *dir, \
> 	 { \
> 		return proc_pident_lookup(dir, dentry, \
> 					  LSM##_attr_dir_stuff, \
> 	-                                 LSM##_attr_dir_stuff + ARRAY_SIZE(LSM#=
#_attr_dir_stuff)); \
> 	+                                 ARRAY_END(LSM##_attr_dir_stuff)); \
> 	 } \
> 	 \
> 	 static const struct inode_operations proc_##LSM##_attr_dir_inode_ops =
=3D { \
>=20
> I could research and find other false negatives.

Here are more false negatives that I found manually.  The semantic patch
didn't find them.  Does anyone know how we could improve it or why it
didn't find them?

	diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
	index 8d81c1e7..d883e1bd 100644
	--- a/arch/powerpc/kernel/rtas.c
	+++ b/arch/powerpc/kernel/rtas.c
	@@ -555,10 +555,8 @@ static struct rtas_function rtas_function_table[] __r=
o_after_init =3D {
		},
	 };
	=20
	-#define for_each_rtas_function(funcp)                                    =
   \
	-       for (funcp =3D &rtas_function_table[0];                           =
    \
	-            funcp < &rtas_function_table[ARRAY_SIZE(rtas_function_table)]=
; \
	-            ++funcp)
	+#define for_each_rtas_function(f)                                     \
	+       for (f =3D rtas_function_table; f < ARRAY_END(rtas_function_table)=
; ++f)
	=20
	 /*
	  * Nearly all RTAS calls need to be serialized. All uses of the
	diff --git a/arch/s390/purgatory/purgatory.c b/arch/s390/purgatory/purgato=
ry.c
	index ecb38102..3e45056b 100644
	--- a/arch/s390/purgatory/purgatory.c
	+++ b/arch/s390/purgatory/purgatory.c
	@@ -19,7 +19,7 @@ int verify_sha256_digest(void)
		struct sha256_ctx sctx;
	=20
		sha256_init(&sctx);
	-       end =3D purgatory_sha_regions + ARRAY_SIZE(purgatory_sha_regions);
	+       end =3D ARRAY_END(purgatory_sha_regions);
	=20
		for (ptr =3D purgatory_sha_regions; ptr < end; ptr++)
			sha256_update(&sctx, (uint8_t *)(ptr->start), ptr->len);
	diff --git a/drivers/md/bcache/util.h b/drivers/md/bcache/util.h
	index f61ab1ba..988b0773 100644
	--- a/drivers/md/bcache/util.h
	+++ b/drivers/md/bcache/util.h
	@@ -273,9 +273,7 @@ do {                                                  =
                      \
		BUILD_BUG_ON(sizeof((array)->data[0]) < sizeof(void *));        \
		(array)->freelist =3D NULL;                                       \
										\
	-       for (_i =3D (array)->data;                                        \
	-            _i < (array)->data + ARRAY_SIZE((array)->data);            \
	-            _i++)                                                      \
	+       for (_i =3D (array)->data; _i < ARRAY_END((array)->data); _i++)   \
			array_free(array, _i);                                  \
	 } while (0)
	=20
	diff --git a/drivers/net/wireless/ath/ath9k/ath9k.h b/drivers/net/wireless=
/ath/ath9k/ath9k.h
	index 6e38aa73..c0cd2d1e 100644
	--- a/drivers/net/wireless/ath/ath9k/ath9k.h
	+++ b/drivers/net/wireless/ath/ath9k/ath9k.h
	@@ -444,9 +444,7 @@ ath_node_to_tid(struct ath_node *an, u8 tidno)
	 #define case_rtn_string(val) case val: return #val
	=20
	 #define ath_for_each_chanctx(_sc, _ctx)                             \
	-       for (ctx =3D &sc->chanctx[0];                                 \
	-            ctx <=3D &sc->chanctx[ARRAY_SIZE(sc->chanctx) - 1];      \
	-            ctx++)
	+       for (ctx =3D &sc->chanctx[0]; ctx <=3D ARRAY_END(sc->chanctx) - 1;=
 ctx++)
	=20
	 void ath_chanctx_init(struct ath_softc *sc);
	 void ath_chanctx_set_channel(struct ath_softc *sc, struct ath_chanctx *ct=
x,
	diff --git a/drivers/net/wireless/intel/iwlwifi/mei/net.c b/drivers/net/wi=
reless/intel/iwlwifi/mei/net.c
	index eac46d1a..b0d2905d 100644
	--- a/drivers/net/wireless/intel/iwlwifi/mei/net.c
	+++ b/drivers/net/wireless/intel/iwlwifi/mei/net.c
	@@ -43,7 +43,7 @@ static bool iwl_mei_rx_filter_eth(const struct ethhdr *e=
thhdr,
			return false;
	=20
		for (filt =3D &filters->eth_filters[0];
	-            filt < &filters->eth_filters[0] + ARRAY_SIZE(filters->eth_fil=
ters);
	+            filt < ARRAY_END(filters->eth_filters);
		     filt++) {
			/* Assume there are no enabled filter after a disabled one */
			if (!(filt->flags & SAP_ETH_FILTER_ENABLED))
	@@ -142,7 +142,7 @@ iwl_mei_rx_filter_tcp_udp(struct sk_buff *skb, bool  i=
p_match,
		const struct iwl_sap_flex_filter *filt;
	=20
		for (filt =3D &filters->flex_filters[0];
	-            filt < &filters->flex_filters[0] + ARRAY_SIZE(filters->flex_f=
ilters);
	+            filt < ARRAY_END(filters->flex_filters);
		     filt++) {
			if (!(filt->flags & SAP_FLEX_FILTER_ENABLED))
				break;
	diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
	index f6ce6e26..a7aa3ce4 100644
	--- a/drivers/usb/core/devio.c
	+++ b/drivers/usb/core/devio.c
	@@ -1490,7 +1490,7 @@ static int proc_conninfo_ex(struct usb_dev_state *ps,
	=20
		if (ci.num_ports < ARRAY_SIZE(ci.ports))
			memmove(&ci.ports[0],
	-                       &ci.ports[ARRAY_SIZE(ci.ports) - ci.num_ports],
	+                       ARRAY_END(ci.ports) - ci.num_ports,
				ci.num_ports);
	=20
		if (copy_to_user(arg, &ci, min(sizeof(ci), size)))
	diff --git a/fs/smb/client/dfs.h b/fs/smb/client/dfs.h
	index e60f0a24..4977f649 100644
	--- a/fs/smb/client/dfs.h
	+++ b/fs/smb/client/dfs.h
	@@ -32,7 +32,7 @@ struct dfs_ref_walk {
	 };
	=20
	 #define ref_walk_start(w)      ((w)->refs)
	-#define ref_walk_end(w)        (&(w)->refs[ARRAY_SIZE((w)->refs) - 1])
	+#define ref_walk_end(w)        (ARRAY_END((w)->refs) - 1)
	 #define ref_walk_cur(w)        ((w)->ref)
	 #define ref_walk_descend(w)    (--ref_walk_cur(w) >=3D ref_walk_start(w))
	=20
	diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
	index 1b9b18e5..0ff49f24 100644
	--- a/kernel/bpf/core.c
	+++ b/kernel/bpf/core.c
	@@ -2298,7 +2298,7 @@ static unsigned int PROG_NAME(stack_size)(const void=
 *ctx, const struct bpf_insn
		u64 regs[MAX_BPF_EXT_REG] =3D {}; \
	 \
		kmsan_unpoison_memory(stack, sizeof(stack)); \
	-       FP =3D (u64) (unsigned long) &stack[ARRAY_SIZE(stack)]; \
	+       FP =3D (u64) (unsigned long) ARRAY_END(stack); \
		ARG1 =3D (u64) (unsigned long) ctx; \
		return ___bpf_prog_run(regs, insn); \
	 }
	@@ -2312,7 +2312,7 @@ static u64 PROG_NAME_ARGS(stack_size)(u64 r1, u64 r2=
, u64 r3, u64 r4, u64 r5, \
		u64 regs[MAX_BPF_EXT_REG]; \
	 \
		kmsan_unpoison_memory(stack, sizeof(stack)); \
	-       FP =3D (u64) (unsigned long) &stack[ARRAY_SIZE(stack)]; \
	+       FP =3D (u64) (unsigned long) ARRAY_END(stack); \
		BPF_R1 =3D r1; \
		BPF_R2 =3D r2; \
		BPF_R3 =3D r3; \
	diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
	index 198f8a0d..d98e42a3 100644
	--- a/net/ipv4/tcp_input.c
	+++ b/net/ipv4/tcp_input.c
	@@ -2009,7 +2009,7 @@ static struct sk_buff *tcp_maybe_skipping_dsack(stru=
ct sk_buff *skb,
	=20
	 static int tcp_sack_cache_ok(const struct tcp_sock *tp, const struct tcp_=
sack_block *cache)
	 {
	-       return cache < tp->recv_sack_cache + ARRAY_SIZE(tp->recv_sack_cach=
e);
	+       return cache < ARRAY_END(tp->recv_sack_cache);
	 }
	=20
	 static int
	@@ -2109,7 +2109,7 @@ tcp_sacktag_write_queue(struct sock *sk, const struc=
t sk_buff *ack_skb,
	=20
		if (!tp->sacked_out) {
			/* It's already past, so skip checking against it */
	-               cache =3D tp->recv_sack_cache + ARRAY_SIZE(tp->recv_sack_c=
ache);
	+               cache =3D ARRAY_END(tp->recv_sack_cache);
		} else {
			cache =3D tp->recv_sack_cache;
			/* Skip empty blocks in at head of the cache */


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--opxaxau6jwzrl3oj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmm26b8ACgkQ64mZXMKQ
wql5PBAAkykb7HqRWjEK8ldPEC6BUK0vqJdoGQjVyl6eyr9+jo1EsS2nkohZdYdn
h5kgD8XM/YmrnODA0tALE40J2COginmkNCjRaKSk/+nqOvow+Ztb0ziW7ia8yN9C
7djLetk613JM8rjGOVU3D7WcpiGpo4UWq00eqcgJlaCqLQP57vyBhtXfYS9MIUrG
b3X6sTw5sqYGYrw0o0zsRyu4KuctvGs8jkyAxcE+UK62qZNe4v87IWe8q2vbIq2f
+25sCZwrnvsb4zXNbR86oIFtaIObkT1f3yB84hJv2QLHR7L6XkaL/gvcaBmgdhfz
cVlfORcvHwpyDoXBDMbeFPmUiMA4p7XNxRaWxeB7KDb6iP4614H1lnWKAgPbHv+7
NrRPRLBjLbCUM3lXlyQw/FY+6XssjHE8mZ5ivFPy/iH7ZTpPZ/eMpp7t6XJNvzXb
yWbkMrLJumdtwIknCPeU5OANMzmuMxPh5NacULzTuBfzhKeVp+pQXyfjrqGaRILt
cF9I8nqH8FtAd0EiKZ/iCqzcgFt331ZthXrzy0e7HAMkLUNB8Orel8aU0F0w2J9o
3bFrN7tNR+AWf0HFpR3I5u8CGkAkIb/8PhUSVT5dDrMa2Q6FJUoW2cO8JfIzdJhk
yGBDeaHZzSaDSb6oKXLp3943XNwQdicd1Y91ak99LeXBBrGUwoY=
=C+Zu
-----END PGP SIGNATURE-----

--opxaxau6jwzrl3oj--
