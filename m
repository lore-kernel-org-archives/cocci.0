Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7FEC3DA7A
	for <cocci@archiver.kernel.org>; Fri,  6 Jan 2023 13:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=OiW01BfmsvuNECBfXSc/dK7rS47Ce4NZnmg9Wv2r7lE=;
  b=RrBjgB/wzLNFkak53l7S2IOY6b2CYXkPuqsG8ZFsGrgLNKkGQwdL1GtF
   bS64NUsRFLoX2Ru4nAoYEv7pbv0LyUKYRTFecXrgX/Us14nHzzPM6t1oH
   TjHScMjPk7AkmjBbHDcb0JptC9j01FdiP+uJ1yIVTPe5Iq9oZ5wnfAh7a
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,305,1665439200"; 
   d="scan'208";a="86301878"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Jan 2023 14:05:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 11286E0145; Fri,  6 Jan 2023 14:05:34 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5AF2FE0128
	for <cocci@sympa.inria.fr>; Fri,  6 Jan 2023 14:05:32 +0100 (CET)
IronPort-SDR: 63b81c8e_W8M0bBg7Em+lCKCuQkts0FU9TzzYONkv/oLmcBi347/5ygO
 hYB8bHF6KuaJP9g4ixpe2TCE3LlygDxNvHiUZgQ==
X-IPAS-Result: =?us-ascii?q?A0GHCwBQHLhjhwwR49RaHgEBCxIMQIN8gV0uBAtFhE+Qc?=
 =?us-ascii?q?TGEK4clhzGEYIQCgxY+DwEDAQ1BAQIEAQEDBDiBU4FggRMChRICHQcBBEcBA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEaCRcHDgULBSKFa?=
 =?us-ascii?q?A2COCkBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEgJHUz0BAgIBIx0BA?=
 =?us-ascii?q?REmAQQLCxQGAh8HAgJMCwYBDAgBAYJ6gm4BAw4jB7BcgTKBAYIIAQEGnAgfL?=
 =?us-ascii?q?CJTgV4JgRSMbDKDN3onEIFVRIE8DIJ3PogbgmeOeYMAh0EKgT18gScOgSslB?=
 =?us-ascii?q?A4DGSsdQAIBCzsyCkA1BgMCC0siCRobB4EKKgkfFQMEBAMCBhMDIgINKDEUB?=
 =?us-ascii?q?CkTDScmawkCAyFhBQMDBCgtCSEfBxURJDwHVhIlAQQDAg8fNwYDCQMCH05wA?=
 =?us-ascii?q?gklERMFAwsVKkcECDYFBhw2EgIIDxIPBiZDDkI3NhMGXAEqCw4TA1CBTwQvX?=
 =?us-ascii?q?n8KBikooFOWZoxxn3M0B4IigU+BUAyecQYTLoNmkxAOBpIbLYVHgVsTj2Ugp?=
 =?us-ascii?q?2E1gUUigVwzGiSDNk8DGQ+OIBkeg26KLEA0OwIHAQoBAQMJAYFWg3ABAYZaA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 ZBIRrIJDTTd99sfDVl5WsMPKtF7U2F8+YM=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:+xKKL6n7wemaXZjrTKYeqL/yGenpDfL43DAbv31ZSRFFG/FwWf
 re+cjzpiWE7wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQiVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,305,1665439200"; 
   d="scan'208";a="86301843"
X-MGA-submission: =?us-ascii?q?MDENbyWXCe/WSOKr3a18Hma/tKOQERt2LRaXc0?=
 =?us-ascii?q?LPGDkMvDWcWEimdzj07ywgC7Sloym8ViikRsIOSAqgkl7vzMLxaindMv?=
 =?us-ascii?q?XsM2kN8mYtD9cO4cG86cKZmrh4CoKzaK2/cLomMt/eb29A+6waw5TobT?=
 =?us-ascii?q?K3RG3oGhxRs9BoTdb1oLIlew=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 14:05:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1673010315; bh=OiW01BfmsvuNECBfXSc/dK7rS47Ce4NZnmg9Wv2r7lE=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=fBaDSg6JsJXIWbbInrPQb5ChchyghV1nGPYBI6xMQtTcaljWIYxCt3DqpbKvwObb6
	 5T9tw399/55ESxBkWI4RmWzCYZEc5HYcKYjJ+J4RI3QbvquFBxvCxcCZ2mx1PPnoBt
	 Y9qLFU+Slv4q/mENbCwrB1pOl3EYrxprUNF177A3lAwEhbeyLDy1xlcM3Knb36m/TH
	 mhxg8Iw5WiSqbIzYWefhYB7sngSC31540NWyP7MG5D7lLg5XYwf2Oabm+8vPHBkeQb
	 hj/RQaCNN5jgH5cwLly0uaxeN+LPSlq+zXytfgXdOGMwtlYuh8LGHczbTnlC8k0GBZ
	 spHpljmK9hPGg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MOUtg-1pQTCv0618-00QISa; Fri, 06
 Jan 2023 14:05:15 +0100
Message-ID: <b3de7b45-e59e-3388-1e34-fee3e8fdc8aa@web.de>
Date: Fri, 6 Jan 2023 14:04:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From: Markus Elfring <Markus.Elfring@web.de>
To: Coccinelle <cocci@systeme.lip6.fr>, Dejin Zheng <zhengdejin5@gmail.com>,
 Julia Lawall <Julia.Lawall@lip6.fr>, kernel-janitors@vger.kernel.org,
 cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, Denis Efremov <efremov@linux.com>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Michal Marek <michal.lkml@markovi.net>, Nicolas Palix <nicolas.palix@imag.fr>
References: <25b804fd-0d04-475d-f614-26c03c9fd544@web.de>
 <5f9fdd59-4b0b-1cb5-c3a2-92efc5bb3841@web.de>
 <4b505afc-ae48-d8eb-f4e1-8e3f7192f73d@web.de>
 <01ea8faa-6fca-a91e-2b5d-378262dcc671@web.de>
Content-Language: en-GB
In-Reply-To: <01ea8faa-6fca-a91e-2b5d-378262dcc671@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:JM5K5/EyZkh4XvI74QfhVIbqjxYkUgo6OzI44zq2xWQYMHuGJ8K
 l5I2y3tmd7y9/9ZKXRfYAgKq3crxkbyo57+3kSl4MLn3OgBe2INOyWxGhmWmjIzaJwSQBtU
 IfUsPMxsHnfCfDPxoExZXt8ys9WMUWmdztNQdjz/llmY6DvpAAfNGjFQrwrK03sIhn2to59
 1tjAmmwaytgTzOebVFA3g==
UI-OutboundReport: notjunk:1;M01:P0:N3+TnHW4PEI=;kvsQFylPAp7SePSsnq9j03lfgoK
 kLMt/GjE9v3Pbg2jHYpM9Ii+vpL0GVKF6HE33rJjbUFBb+3EJFO2thc/5KHn8SWW8pHgU8UlK
 Vmoj2KrGBFOqAmLY15smlpg1x5LjcNYSzeTWgJJuOn/wC/W9Mn/gOUfI7gHv29PngMHw0exwP
 YgqqMW7tzBmdZFaRb658mzK/07eJiUSc3BZIBWAxrWVrQ6DaezYoVMi9lWxcFuON7SjXL6mq3
 RgqQfceI45N+ygQrsLkAM/YHd7aSAlBjLEqyl9cUGKTqoyUEnQN/UyAsbuysU3P8tlqjQVVol
 3mhcRtjWd/xU7OqlkGS1QKtQWn8czprsEyyb9k917Jw5fIy0jI6NwqTrBJSP5qiYfROB3fLoG
 UAyDln7F+ZCNc4fwLAcAE0vEtoHN8gghoURr6KZY75DPDHu5XsTVdAjHO663UKpJOMDJhgk48
 oS9TWJi/yeeJhUy6cR7PBmda4nCOP8oa4EG+ZAmyw0S3HSThlXYPNaCuU8ATh8KbcGo1qznrp
 3p5ftDmMvv8Q0mVFLiuy/L9fBibqWZlIf2G5/6zd9yCROQE0GqKRDGUAFmPNtIOUSPg7Fker6
 vqNWFMi+u8xvGMWPsUCG8qKEtPVB/VzIXR5luF8mLRgo/hmhGE0GlGHLU1xisnpcHXWpdfEWM
 dzs8vMpR4rBLB4FwEcef+qj5fOnllBZG9s+ITCwZf2nZG4tRGp1oSm7PJwv2ltJGMao9HA7Yt
 i+YvVpCjmV6U6kGtbGs6bF1S6tp7usGandAklCJzYaM2KzL46u+NbJmk7Hl3/NzqLy6D+rPB+
 Jbzd/YZsQdl7KwxEZj2RLs7sDbaKsMkh4+Mo0vifY0Tm87FsONqbqEpsF8zpAc2eg+h/pBKcx
 /OygYBLmhX6OLZ2k7JSexL4CjQcyoRaSZg6iY8puzN4LCdidzsYzxMRlIKLS/rPAGJkxlDJMZ
 VIT9Pg==
Subject: Re: [cocci] [PATCH v3] Coccinelle: api: Add SmPL script
 =?UTF-8?Q?=E2=80=9Cuse=5Fdevm=5Fplatform=5Fget=5Fand=5Fioremap=5Fresource?=
 =?UTF-8?Q?=2Ecocci=E2=80=9D?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 805
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/b3de7b45-e59e-3388-1e34-fee3e8fdc8aa%40web.de>

> Date: Mon, 7 Sep 2020 20:00:09 +0200
>
> Another wrapper function is available since the commit 890cc39a879906b63912482dfc41944579df2dc6
> ("drivers: provide devm_platform_get_and_ioremap_resource()").
> Provide safe design options for the adjustment of affected source code
> by the means of the semantic patch language (Coccinelle software).

Do you find this transformation approach variant acceptable?

How are the chances for integration of this SmPL script version?

Regards,
Markus
