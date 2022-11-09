Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AB6C4332F
	for <cocci@archiver.kernel.org>; Wed,  9 Nov 2022 18:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=xVe1McabYxeXTqeKA4U2v4OeiPC8wUUHDyyv2Sm3BCg=;
  b=Gu1zTZSTizeGzoIRuD+NZsFiCq+RU1dSDVGPuS03i79xdFcYEngkX1Rx
   qgtMAI9NvM7EF9svWs012jK92y2gwxGXt17PXVI7bHjT0641uO0nuvHO/
   wfohjI9zpfvyofyi0AMMIEj+YUxfGM70wQDmJuefbfTavbvsSk6o4GORk
   Q=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,151,1665439200"; 
   d="scan'208";a="77528607"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Nov 2022 19:50:16 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 09ED8E0092; Wed,  9 Nov 2022 19:50:16 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id ECC1CE0092
	for <cocci@sympa.inria.fr>; Wed,  9 Nov 2022 19:50:14 +0100 (CET)
IronPort-SDR: 636bf666_bSUI/gRMoDCoZVgEfasjHVV4+FjUtPz2nE+h/sibTIyggfn
 Gp+RlZl1iL6nQXAaLThdhxhwqB3tR5NU/i3WR0g==
X-IPAS-Result: =?us-ascii?q?A0FAAgAX9WtjhwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYIsgQVTLgQLRYRPjnWBdzGBE4MWhx6HL4RfhAGDVA8BAwENQQECB?=
 =?us-ascii?q?AEBAwSDa4ETAoR7Ah0HAQQzBg4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBA?=
 =?us-ascii?q?QIEBAEBAhABAQEZCRcHDhAFIoVoDYI1KQF0gQgBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBFgJHUywBAgIBIx0BAREmAQQLCxoCHwcCAlcGAQwIAQGCeYJuAQMNIwerf?=
 =?us-ascii?q?oEygQGCCAEBBpwGHywiU4FeCYEULAGMW4QwJxCBVUSBFSeCTDc+hESDV4Jnj?=
 =?us-ascii?q?nyIUyYEDgMZKx1AAgELOzIDCkkbMScOCR8WBgoEFw0FBhIDIEgmBQo3DygvZ?=
 =?us-ascii?q?yIJHBsHgQwqCR8VAwQEAwIGEwMiAg0pMRQEKRMNKydvCQIDImUFAwMEKCwDC?=
 =?us-ascii?q?SEfBxYRJDwHVxIoAQQDAhAiOgYDCQMCJFVzAgkmERUFAw0XJQgFTQQIOQUGU?=
 =?us-ascii?q?hICChEDEg8GJkcOSj45FgYnRAEzDg4UA16BawQ1Z50qpBuhBjQHgh6BTIFND?=
 =?us-ascii?q?J5mBhMug2WTCA4GkhQthxyPaSCiU4UFgXgkgVwzGiSDNk8DGQ+OIBkeg26KL?=
 =?us-ascii?q?EA0OwIHAQoBAQMJhUcBAYUcAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 bAJeF15
IronPort-HdrOrdr: A9a23:pdb8MKlB1Yb5HZXXZK4x0rs1AlTpDfL43DAbv31ZSRFFG/FwWf
 re+8jzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQ+VxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6PoSizPZLz9P+qjkzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,151,1665439200"; 
   d="scan'208";a="77528605"
X-MGA-submission: =?us-ascii?q?MDFjqg6AbiR49BI5GXOZPi3T2ecb20fbeYKhxc?=
 =?us-ascii?q?MXlKcuvb9XYLgJTLua+oN/BPCLdBu2fi7kKGkb4b4bpNVE4+5Pr21j50?=
 =?us-ascii?q?5yRHbw5X6+mJhIn3VeXe5tgsrGxz24w10O5Oyq61emZQ8ND59VxvvjEb?=
 =?us-ascii?q?zXf29pK3zhKqPzx151QuL6UA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 19:50:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1668019812; bh=/Q9Dl4jIQ0NtTVTk/rRzmMxuNPsGJ5lTIoVHp1BUxuc=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
	b=ZuFWFpqkd0PHSRhbgVhbCklcqbqtow6M9h7usmO3lctHWQPU+qHEwuM8diQhEcEMQ
	 BbD+TLsGMQWCHMOZFd6Hd3JSShKkID35YQsT64Ot/EjZI/b+5W77gMuBL2tIqStZ1g
	 cOmaWT1/cRPEALupuha3e9zfu94p5C0gfjIAkuBRxNqgPOXTY+keyBLUFf5d0gGWYh
	 jqI2dk8q+PfPhMWPUkWextQ1Q9wh8O+s9OIkFLyKXj8ivkTiZpGH8UPlcBch8jbgEP
	 fL2p6fA4x1JFg9JJ1HWMYE2v0Dh5LMVIwV36TQ2bsxNobjuvlrj8fuCP9hWEGXKlEJ
	 /MYZ+RBv0myeA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MeUXu-1pSzqa12EW-00acU6; Wed, 09
 Nov 2022 19:50:12 +0100
Message-ID: <9f30c50c-bd5f-948a-282a-9457d727f214@web.de>
Date: Wed, 9 Nov 2022 19:50:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-GB
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 cocci@inria.fr
References: <20221107114702.15706-1-u.kleine-koenig@pengutronix.de>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de
In-Reply-To: <20221107114702.15706-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z9oEizc3mWQ7hwk3sXfN4vuB4UR/V+rfF6yvGhZBffJGJO3S//n
 Pe7SQbFk6T9KFS48KH5e1xbT2GBqnUq7+vwacI2qxfsPYYdiM3tz1aU8Ri5JC0Pq+Zx8qp6
 iJPZP3u67WEk4eKxTLH2/Dj4bDNhP34jIpPAabkbAG8PSApnMpUQAEXGwhGd4Zb+r6DmPly
 4RENZxr+N9AzmqJVy2oXw==
UI-OutboundReport: notjunk:1;M01:P0:HSk/R55DOm8=;Lz4nwRTMnsZbOcCotmN43bRYXmx
 NsZoJ0gHzJrecgC3nWSCRpA1ibhe5BsCdv2D4TZJR4yCBc+gcfxV4bar71z+oz4En1XV9JYmh
 CeNPDYwFePz2ZwCGtcUBi/kZPPB+sFIyC8X2VLBJsTLPknnf/HqsTvZ0qcTovTNEv7NkiZQGB
 j/UX+HeZnXjbvdydVZOweKnlBc73X/wZ4kaG1/xpFahUaLLFUGChuml8M+f+hl5M05oCC52at
 FLlXsKxciQUEM5VPvuFub1fJFbez904KW2ctUmfBnQUX5ALMax+hzz8Lvvs34q/mYFmFvkgYj
 WakBSbgtxsOfvoNCE6urFYdciuMnGp09P2/EpLY60NKiDMsjrCTAqUiUmIkCj3Kb0swRqjZRs
 67KGiwVSDks7HgAkbmZUUsalRYA5UW2fs5PBvob2R6aJGlGE7xHqd/ZsRHgGzFbjOuMb76vTr
 WPrRa6+mFtG8UmmYgQZmOyJYg1VdFG0yr8AO6ihVO9oPyOBQqKZNzgn4qES2s90Px0wbzFR/h
 7nueuc49KLF04l0t9ngLCcB8bx7NTCc7zZwOFZSo+/WYAKe/buTH4De5kA/NKJ1C/DiGpR0as
 VwWZx6wU2+g3FAMg7020e8TKcGty8XjntdndG7DZgN+2g88TwgdNF33gpCqTEYY5KJFyaoxAx
 aWcii9Afrz3+qlF0mSzpgj6P7POKDCva+lXcu3TGOHP2f9JJY03O9PZ1ahvxgipFp1QxFkWLT
 9GClEgXNBPP1OooEWbvpAqiB3hNwj5gEJlHVZ7V+uRuJiy3B0YY0XOQ4QLJNOY2E+gZoytvgO
 ltvT2z7v0xbsIBsVVqDjXkQyaVOAa3NqRTN0OToZjmQj1Y3m0VD2Z8/cp1vJhxXwTMRindLiS
 v2q5Wo/HHtL7dG7nC8bavGyYs7qdFF8XVmATsUNEeIazXVMpUKNmEJSsFKbVKwymq6UiZWw5V
 ABT9BA==
Subject: Re: [cocci] [PATCH] coccinelle: api: Don't use
 devm_platform_get_and_ioremap_resource with res==NULL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 731
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/9f30c50c-bd5f-948a-282a-9457d727f214%40web.de>

>  create mode 100644 scripts/coccinelle/api/devm_platform_ioremap_resourc=
e.cocci


Can the file name =E2=80=9Cuse_devm_platform_ioremap_resource.cocci=E2=80=
=9D be a bit nicer?


> +@script:python depends on org@
> +p << r2.p;
> +@@
> +
> +cocci.print_main("WARNING opportunity for devm_platform_ioremap_resourc=
e", p)


Can the following statement variant be more appropriate?

coccilib.org.print_todo(p[0], "WARNING: opportunity for devm_platform_iore=
map_resource()")


Regards,
Markus

