Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A02C282C5
	for <cocci@archiver.kernel.org>; Mon,  3 Mar 2025 10:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=jd+52AX5/piObKdzzA9/9SXvFOM9JdZ0fKfhSwOzzPU=;
  b=KDYnsLnxxT3U4mXcEILzPdHczC0ewTLjBalyzIW5IMO3SsTOKov1ho2k
   kwFRInXm5ZX3Q/ZsfGT4xgnMVQZgwCFWduZV+g2mBGeii7IHddczjY3FI
   Y5mECMCpPsCWvNeoTpCHKePxEeALnNniK0dkUGNV4qE3Jr4AI+Aibu9di
   4=;
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="scan'208";a="210837557"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Mar 2025 11:26:14 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 47306E0D1E; Mon,  3 Mar 2025 11:26:14 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id EBDBEE0260
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 11:26:08 +0100 (CET)
IronPort-SDR: 67c583c0_8sCV5iT5EMXwSc1sMPSi2l0h+1RoJ7QaBCccV++sFJkc1qL
 1Uf7EZX3uC0owyCiHtIjJPlvsbSdCO4wAtLF8dA==
X-IPAS-Result: =?us-ascii?q?A0HJDQDSgsVnfgQP49RaHQEBAQEJARIBBQUBQIFCBQELA?=
 =?us-ascii?q?QGCQn1aMwQLSIRWj0+BdDCEO48OiHWDVA8BAwENNQwBAgQBAQMBA4R2CgKLF?=
 =?us-ascii?q?QIeBwEEMwYOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHD?=
 =?us-ascii?q?gkBMYV7DUkBDAGCCwGBExF0MAIBAQEBAQEBAQEBAQEdAg06RAEBAQIBIx0BA?=
 =?us-ascii?q?REmAQQLCxoCJgICVgYBFAEBgn4Bgi8BAw4jB68dgTKBAYIMAQEGgU4B2Q0fL?=
 =?us-ascii?q?CJXgWUDBoEaLgGFa4JjAYVSVINCeicPgVVEgRUnglIxPoJhAQOBXoNbgmmCM?=
 =?us-ascii?q?4RAZ5oFjlNSexwDWSwBVRMXCwcFgSkQOAMqNBQdIw+BFAU0QTqCC2lJOgINA?=
 =?us-ascii?q?jWCHiRYgitqBAWBJII3hD2EQII/UYJCghFxbAMDFg8Bgx93HINPgS2Eah1AA?=
 =?us-ascii?q?gELbT03BgMLGwY9oW07hEKBOSmCP5Yir1I0B4I4gWaBYwyKKZU1BhMvg3ABk?=
 =?us-ascii?q?1QOBpJ9mH0ijWObLIF9JIFcMxokgzYfMAMZD44hOIN1hCXECkI1PAIHAQoBA?=
 =?us-ascii?q?QMJhUYBAYhCghKBSwEB?=
IronPort-PHdr: A9a23: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
 J7DmfCqQAo=
IronPort-Data: A9a23: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
 ITteV15fQ==
IronPort-HdrOrdr: A9a23:9/mcdamxWwcodlwDXeUa8RStFnTpDfL43DAbv31ZSRFFG/FwWf
 re/sjzpiWE7Ar5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6PoSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3AWdhuMWibZwajiGV26JNRV233jzJuVTr0wG/9P36?=
 =?us-ascii?q?BJntpUIXKY0Kgw7pZqp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3ARcINsQ4p7cwMZTYmEzJfuxtVxoxZvKmNNHESzqw?=
 =?us-ascii?q?ZmJSgdhZvNWbBt2qoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="scan'208";a="210837529"
X-MGA-submission: =?us-ascii?q?MDGbJxPw7FdCj8sIWZ1i1clSGroewcIPoHpQdZ?=
 =?us-ascii?q?91wb3gRRGc9liSdZZK3fPVi69gDSt03zWJmGqSlt6bW1DXZo9kFB5GJH?=
 =?us-ascii?q?gYwO0X12vnwADYJFb2Ndh7l1figF0v+Dc3HEwJFzb0s1t3X1wrC3x8LI?=
 =?us-ascii?q?6IUfWQUDMxI7bfcXhKePpNEQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 11:26:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740997563; x=1741602363; i=markus.elfring@web.de;
	bh=jd+52AX5/piObKdzzA9/9SXvFOM9JdZ0fKfhSwOzzPU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bd6TKmoX3VCx+K8pzRAkR6zDAiJPvB/N6Kx0szJn1iKNr14hSRAzUUIahlcmKw2C
	 OT9nGT7QIwCVc/a4/X/YL6gQkxRyH3NbG4vxQh/Z6QbwUV8Q882t0+OHrjK/4KWK9
	 0ntCKz+239JWuvXaApQs3tDsgesRqX5uKXIrDjDGkvnxPl6vP7UQLJyj+Sr2BsXnp
	 UyElQpO136tU/xgP1XidRdjXCjN3WWNoVTo2gkg6InypTPzelocWv6MPt/B08wTmH
	 zC5dBF9ygWqosaySVWF0jML4U6ytgpf3IK6uCUnTtqOH/zuD/hfMXDYQEqFzyTRwn
	 BDOJp9vkRQPRn6Fk+w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MECGX-1twVdn3hu1-00EsYP; Mon, 03
 Mar 2025 11:26:02 +0100
Message-ID: <79df6406-72c3-4f5d-acaf-9129b08ef404@web.de>
Date: Mon, 3 Mar 2025 11:25:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Ariel Elior <aelior@marvell.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Manish Chopra <manishc@marvell.com>,
 Paolo Abeni <pabeni@redhat.com>, Ram Amrani <Ram.Amrani@caviumnetworks.com>,
 Yuval Mintz <Yuval.Mintz@caviumnetworks.com>, cocci@inria.fr,
 LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <f7967bee-f3f1-54c4-7352-40c39dd7fead@web.de>
 <6958583a-77c0-41ca-8f80-7ff647b385bb@web.de>
 <Z8VKaGm1YqkxK4GM@mev-dev.igk.intel.com>
 <325e67fc-48df-4571-a87e-5660a3d3968f@stanley.mountain>
 <64725552-d915-429d-b8f8-1350c3cc17ae@web.de>
 <a191bd33-6c59-45c2-9890-265ec182b39a@stanley.mountain>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <a191bd33-6c59-45c2-9890-265ec182b39a@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sFY4lNudEKPt31p/OofSHuUe2r+pMZ9PoMkfiipwtJeNiIi3ot6
 ROhkegUFPVYWImquRud5jz9IRQ6MVTELXnCC4MKVJOUSx2ZuNJm3qPS3kuO2snpyCaJVRO5
 eLgp9prn2PPIT68u1vNcn0kUD1MSxNQnqTv6rEsnu/mAOXdaDDasPJpZ3hGjxxLgpyYz2+C
 HseknLEcrxPoV0VIFQfaw==
UI-OutboundReport: notjunk:1;M01:P0:g8CJMAUTc50=;kqgVeauKUouTGLBH4WBo+Qu+a7h
 ARKWrZqQ+S+u6Bvs+zp4n/cP/zyYMnoX25InH00cmqeOmwHHWKTogFzZLgbaZvBneDf/b33ho
 w8FKysGeKNxLnO/dHe2aprA8hAEEE3sPtHbH8Oi1ic6MA4h1dzmJZikWuYWBnVXSTayV0/tCs
 jdL4evJD1E+HWdIvhXIlPhvd0pA6jEAGfmvvjO1n+QeusPf9ChWvnZb1nAlbPFes6rs64b9kT
 XD/+KE1O9Ds0QmqvFIMnjYb9CfZUFTsM7sewMCuKKtciwP9xBklOeV6TZCIWcBzWlVupkdQeJ
 8oAgq1sR3LSe24J2IvSjcRHKQzbxLcdehvibjok5SpPT0DGKGS5OKrheHI+flMXTLxbe31q5x
 1zN+NpI8bGGSrhKI2ciNgYpHsnfZGJIXSbhuuPeV0fs0Ue7MILxmLagE4MvDzlZGpLtlVHqIo
 3nmDdDhQ4C0+Kbw5+WEeYMmNV5mB5Gvt4zqzC3BK33xVeC40GgLMVxHcoCdxxzgzRKlQka6MY
 lh4GVtwd145gTqjvsXzNUXBr/WeiODdgjemFL52t0c6+O9Ca6vqr3cOzB8Vv41nxwgctM192U
 JJ0TqVPpltZmfbYVg1hKjgUjC8kA2cSA18dD3USXhZR6/DpbVsi/24Y26Be7hqiq3bNoSoZLb
 7+MPcVsA54xyKX/Lpse0nhOs/U8aYtbBjohrnYWztMfVs370jagISiXq9LhYgdjekRbXzLuEz
 VaufmDZ/zZt7PVbl0JSNt5c5YkBALZvGcnspVWTlYP0KsZbVY6REE4m5MaOwIMNGuV+mgruv3
 O6MONXhg48NMi82koNyyUdoVWEvciQIwWaqsCCiWuG8broWOIK6UDczOknzJeREnoYQ3CutRE
 /AOBjRZgjCrS6cuB+Nr7x2OiT5TD7HqZTKh8DUVSdQn0yjzYTvoXDMUV8+wcjAaImY2un21ly
 LXAX3NaJokG1iePftL+09y2pnl7j/ktD0DCYuJD3WI1+Ufa/9npBOJY0fMx2386NrwuRL04dl
 2/Co7j8VtV8i6/dwy/RtgTEHnJ6DUqLCksnZP5rr14+anVD3VsUWaw4y3R9k7+A3ZaEAFkw9q
 x65mOTGly+y3sntF58PsraztAiEPI7VzbLNuFf8LBPR64fUVeC0c/W44DgAIWtzG/iold7zir
 Ry8DCr/qWbgm9QTGmFC4kIjoVtheQj+IgX7M+C7gv5eF3Xp2SGZmL5EnnXEvT/au+hBVDOW/U
 +KHm1UTn8zBlvpS/0JARPu7U32ZnD4kWLokPT/fJUyK8nU+3kgT9YqahXgJB98sBNpwl7rDK9
 3stp2hAqN7mr2WqfvfE1G17gqNqA0fGUDw1uaAfhfdmQpzjmBCgFKMDgvQ8/HDCoJzj0ycJji
 GB5iO/TSN61Gd5soPMqvhtgTWYRyy7TEKfe8hcGgSIRfGEcWlHwz9mI7qTwbhkITTwlP+Np7P
 fQSlqyI7pCevqZEdp3kJjiye3IwI=
Subject: Re: [cocci] qed: Move a variable assignment behind a null pointer
 check in two functions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2477
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/79df6406-72c3-4f5d-acaf-9129b08ef404%40web.de>

> This is not a NULL dereference.  It's just pointer math.
How does your view fit to information in an article like =E2=80=9CFun with=
 NULL pointers, part 1=E2=80=9D
(by Jonathan Corbet from 2009-07-20)?
https://lwn.net/Articles/342330/

Regards,
Markus
