Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E111F606A321
	for <cocci@archiver.kernel.org>; Thu, 12 Nov 2026 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=PahnydId
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:date:from:to:cc:reply-to:in-reply-to:
   references:message-id:content-transfer-encoding:subject:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6p9LwmsqttWJ8H4dyTVas1vScv8juN3ncb8xmD9Yi+k=;
  b=PahnydIdnPR5idgc1ZF3XEhcKOWMV22UgMgy2V0DSuVA7n3psHc1j1R3
   CI6X4IyErTndMEa/6l9h1zz5o/y15wrdllX8mfKt/WIiH4WEVwFpX4ac0
   HqPwh39qUv3E+EckbaCmBv9MLi+E42OzxOHyXkakrfBpY1KyR896kD8+x
   w=;
X-CSE-ConnectionGUID: J1ixeP2+QWChptUKwNvohg==
X-CSE-MsgGUID: xGT7crhZTBCwnhCpCh9IDg==
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
   d="scan'208";a="305078242"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Nov 2026 13:41:19 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 3881681BCB; Thu, 12 Nov 2026 13:41:19 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 8F2E281A27
	for <cocci@sympa.inria.fr>; Thu, 12 Nov 2026 13:41:13 +0100 (CET)
X-CSE-ConnectionGUID: ctVmkC9wTxOJ6J31anrrNQ==
X-CSE-MsgGUID: nXJyrjytSrea0i4UGCYe9w==
IronPort-SDR: 6af5b3e9_Kt3UnxWAfXjOZXkMXc88RoAnaLFPCNYJDlDmSMcmvIHcVlb
 qFdEi34AsN7VsS3KHzakR+7aVL0UhWNuFt7X3sQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FcAwBXs/VqjgUqG9RaHgEBCxIMggULgW5TgQUGThQyB?=
 =?us-ascii?q?wgrhHaIeoYVoQqBfg8BAwENMR4CBAEBAQIEhH4Cjh8CHwcEBSwIDgECBAMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABAQEBAQE5BQ47hk8Nj?=
 =?us-ascii?q?BoBgSSBJgEBAQEBAQEBAQEBAR0CDX4CAQMjDwEFQRAEBwkRAiYCAisrBhuCe?=
 =?us-ascii?q?gGCdAQDAQO7LoEygQGEZtljgR9VgR8uhXSCbgGKdicODYFIRYQQMT6IH4JqB?=
 =?us-ascii?q?IIigQyCV45nhigHBx4mHVscA1ksAQ9GExcLBwVgRUMDgQYjSwUtHTdsIR0XE?=
 =?us-ascii?q?R5YGwYFEiAqQENbgRKBBV2BKyhdAQEBH0YtCguBdQKCUYEjXQIBSUEOB0VTC?=
 =?us-ascii?q?SVDEkckIggSCQETGiwKgRo1PAkmPxUMWwwIAxoFGiYCHwgCCwIMdCgREBMdH?=
 =?us-ascii?q?iQvBRomPhsKfgdmPTcJDBkEAgE6CEIdEgKSZ4JQgVQqyHg8hCqBdIIQiCCVQ?=
 =?us-ascii?q?hIcF4NxAYFppReZCI4Kh12TXoFqAjaBXH0IghSBDwhHAxkPjjuEEc4TRHECB?=
 =?us-ascii?q?wIHAQwBAwuFRoxWgUwBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:UCtrBa9rgmv+23zlpSOeDrUDdnWTJUtcMsCJ2f8bNWPcYEJGY0x3m
 mQcC2iObKqNajHyco9xPoi39UJQv5LQyoI2GgA+/C4xFiIbosfsO4ilIxarNUt+DOWTFRM9t
 512hvrodZ1vECeE/n9BFpC78BGQAInRHuKU5NbsY343HUk4Dnx503qPosZh6qZwm9+1HgiRj
 t37pszbKTeN1iV9Wo4uw/vrRChH4rKo51v0gnRkPaoV5QaHzSFMZH4iDfjZw0XQEtE88tGSH
 L6rIIGRpgvx4xorA9W5pbf3GmViaqLSJwWHlk1NUKGkhBVYzgRqukrsHKd0he9/0l1lrvgpo
 Dl/ncXYpTQBZ8UgrN8gvyxwT0mSC4UWoe6deSDXXfu7lCUqe1O0qxln4dpf0Ycwoo6bCkkXn
 RAUxaxkgrluSItazZriItSAiPjPI+HgIL0auVox0g3JKtR4Y8uaSqPQ//lhiWJYasBmRZ4yZ
 uICbCZ3MVHPOUQJNE0aBdQwho9EhFGlKmce8g3T+fBxvgA/zyQpuFTpGMLUcdeDbclYlEeRo
 CTB5WuR7hQyb4TCkWXVqCj07gPJtSXLepMIFqykzeRniQWSmlE8IywbBETu9JFVjWbkBIsFc
 BF8FjAVhaM1/0eqZsLsWgWx5n+CpB8VHdRKe8U+4R6Ezq788QecDHINCD9Hct0v8sEsLRQ02
 VaMldLkHxR9sbifU3vb97GOrDr0NzJ9EIMZTTQBURNYpta5+cc9lB/CCNh5eEKosjHrMTrs/
 TWJh3khu6U0r5ApjPyy+0rdpQv58/AlUTUJChPrsnWNwDkRWWJIT5et9UCGqPkadcCXVFSM+
 nYe8yR/0AzsJcHU/MBuaL9WdF1M2xpjGGCE6bKIN8R7nwlBA1b5IehtDMhWfS+FyProhgMFk
 GeJ5loLv8I70IqCY7V6bsqqAt9C8JUM4e/ND6iOBvIXO8AZXFbeoElGOxTMt0izyxJEuf9kZ
 v+mnTOEUSxy5VJPkGDuH791PH5C7nxW+F4/srigk0v2gODENCLOIVrHWXPXBt0EAGq/iF292
 75i2wGikX2zicWnOHiLo70AZ0sHN2Y6Dp3QoslaPLzLaAl/FW1rT7ebzbo9csY31+5Yh8XZz
 EGbA0V48VvYgWGYCAOobns4Vqjjc6wipl0GPAstH22S5V4dXaiV4pwyTaAHJJsJycFz/8BZH
 /ghUOecM8tLUQXCqmg8b4GijYlMdyaLpAOpPgi6aQcZfa9dbQ/7xf38TzSz6SNVLCyWtNQ/k
 ZKkxAj0UZoOfCU8Lcf0OdaE7UK9gmgZo812B3D3G9h0fF791opAJwjarO4FE+tVJTrtnjKlh
 hurWzEGruzzkqoJ2djuh5Hciby2EuF7T3FoL0OC4ZmYbSDlr3eem6leW+O1fBfYZmP+2IOmQ
 c53l/jcEvk2rGxmgrpGMYRA7PwBvoP0hrpg0A5bMm3BbA2rBpNeM3C255RzmZMX9IBJmzmde
 xypwcZbC4WrKcm+MV82JSgZVMqh+8wQuAHv6aUSHB2nyg5xpKGKQGdDDSmq0SZ9FoZ4AKkh4
 OUmufMV1TCBtwoXAo6GoBx5p2WoBV4cYpojraAfUdPKiBJ061RsYq78Ky7R4bOdYeV2LW8Re
 zmxhofftbJ+wnj5Ln84FFnW/O9nnZ9Vkgt7/FwDAFWom9T+mf482iNKwwk3Vgh4yhZm0fp5H
 3pCbWlZBP+r1CgyotpHU0SHORBzNDfA9mPfk1I2xXDkFW+2XWnzHUgBEOeq/mVC1klDfzJer
 Yqq+Ey8XRnEJMjOjzYPA2h7oPneTPt0xA3IuOajO++nR5AaQz7UspWCVFoyiSnMIJ0O3RXch
 OxQ4uxPR7XxNncQr40FGoCq7+ksZy7eFlNSY8NK3f0vJn7dSgGQyDLVCkGWe+FxHdLo33K8K
 fRTIpNoa0zj+geI9isWFIwdEY9SxfQJ3ucPSpnvBGwBsoackAZXjYLtxnDAo1EvEvpTkpcbC
 4LOdji9PHSaqllKlkTs8sRVGGqKTuMVRQ/73eua9Oc4Tbwqgs5ScEgN/KaQuiSEAhpG5DORh
 hvIPIXN/txhyKNtvoriKbpCDAOKMuHOVPyE3QSwktZWZ/bNANj+jBwUoVzZIAhmB7sddNBpn
 7CrstSs/kf6kJspcmLewb+tKrJo4JisYe9pLc7HFnlWsi+cUsvK4RFY2WSZK4RMoexN9PucW
 Aq0R8uhR+E7A+4H6iVuVBFfNBIBB4DcTKTq/3q9psvRLCkt61XMKdf/+EL5aW1eSDQzBKT/L
 Q3JoNer2MFTqdVdJR0DBsw+OaRCHn3YZfIEeeHy5B6iNUv5pnOZu7Dnqwgs1iGTNFmAD/TBw
 MzkQjrQSU2MnZ/mnfBjna58hBk1NEpGoPIRexsd8uFmijrhA28hK/8cAKo8CZpVs3LT0rvgV
 WvrbFINMyHMWDBEexSh/t/mVQa7Lc4NM+ffOTYG0R61aSC3D6yEAoo72yZu2Gh3cT3d19OaK
 ckS13nzHxqpyLRrdPkj3eO6iuJZ2f/q/HIE1kTjmcjUARxFI7E1+FF+PQhKDwrrLtrskRjVG
 G0LWmx0ekG3ZkrvG8JGeXQOOhU4vivq/go4fxW039fTlIWK/tJukMSlFbnI7YQCS8AWKJolZ
 3D9HTKN6l/L/E0jg/IivtZxjJJkDf6OINOBE5biYg8vhIC11HUsOpITvCgITfx6wjVlLXHmq
 mCO7UQ9VWO/E2IA6I3OnE9Ns9h0X2kXBj7EsB/nqHWU2VYlxtzeYF6xwBi9NZj0rLP5sl5FR
 CsJKnycuECSqCCusAwWWi73fbBbKZp5+bj4viEUolfaiRKwUDIYG+o4lU8g2t8X/mcsKkB8a
 vOKy9tkkG64dnrn4uwmtI5xjntbQ3MpFgkJirbvuhVxGbNcEavlJs2hJO/Sohk62nlLtJdo7
 iEXQ1DSAwPft09WRDMNVwg9jXBjwuzQ6o/UI2nTwSyXVnFwH3Tfd1OFDdGSRTlr
IronPort-HdrOrdr: A9a23:E0II8aOblgDvSMBcTuajsMiBIKoaSvp037Dk7TEVdfUzSL3mqy
 nOpoVm6faaslYssR0b6LO90ey7MArhHP1OgLX44dqZLW/bUQmTXfpfBFvZskDd8kTFn4Y3v8
 ldmupFeaXN5D5B/KHHCWKDYrIdKbe8gcKVbbe39QYWcehzUcxdBh1CZjpzDHcYeDV7
X-Talos-CUID: 9a23:3kAZ+W+Tos/sJnYYjmOVv0UIJMUmWSzC8Gf3ARGaUj9gTqePb2bFrQ==
X-Talos-MUID: 9a23:Jf1N+QrIDTUT0+74sSoezzdSFtZy4bWyM1oAmM0H5/SrHh19aijI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,209,1787004000"; 
   d="scan'208";a="305078220"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEEFSn1udYs0MLgVWNYTbUv7R8YPFWDyMQQsP?=
 =?us-ascii?q?MEJBC4pjG5L0aWHwuy8LkBSqrBTin0+L7M5DyW1zRIMftsP3HtEjJ8os?=
 =?us-ascii?q?ZnuofdkDvXOq1JgSdvyee2jwXJiQqxFA7yUjI7qWKvoi2g7jqL4FbayP?=
 =?us-ascii?q?iQWJzH+kxpccOvbbYoXNDd3w=3D=3D?=
Received: from smtp5-g21.free.fr ([212.27.42.5])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 13:41:13 +0100
Received: from lettres.chocolatnoir.net (unknown [IPv6:2a01:e35:39f0:1580:aa20:66ff:fe1e:6826])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id 034AC6013C;
	Thu, 12 Nov 2026 13:41:10 +0100 (CET)
Received: by lettres.chocolatnoir.net (Postfix, from userid 126)
	id D827ACE8E20; Thu, 12 Nov 2026 13:41:10 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
Received: from lettres.chocolatnoir.net (localhost [IPv6:::1])
	by lettres.chocolatnoir.net (Postfix) with ESMTPA id BA0B3CE8E1D;
	Thu, 12 Nov 2026 13:41:09 +0100 (CET)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 13:41:09 +0100
From: picca <picca@debian.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr, Julia Lawall <julia.lawall@inria.fr>, Victor Gambier
 <victor.gambier@inria.fr>
Reply-To: picca@debian.org
Mail-Reply-To: picca@debian.org
In-Reply-To: <acfa21d8-8777-4aad-b6d3-38a101f21296@web.de>
References: <45e0468b84f19a5d75ea99fb434113c0@debian.org>
 <acfa21d8-8777-4aad-b6d3-38a101f21296@web.de>
Message-ID: <52015cf484d7c0e5942f8784ac8a948e@debian.org>
X-Sender: picca@debian.org
Organization: Miaouh
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] Bug dans la parseur de coccinelle ?
X-Loop: cocci@inria.fr
X-Sequence: 3798
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/zy7r6NPqjgokfsHlltoAeA>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1

Le 2026-11-12 13:36, Markus Elfring a écrit :
>> here it is
> 
> Are the attached source files and the mentioned SmPL script stored in a 
> public development repository?
> 
> Regards,
> Markus


Yes here

http://repo.or.cz/hkl

take the pu-anarod branch and look under the anarod directory
