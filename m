Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D7CEB64D7
	for <cocci@archiver.kernel.org>; Tue, 20 Jun 2023 14:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=26Sd1CLKiW59mEYHCLtxAX4ggNuw5qGZKqWi7FJE+jU=;
  b=mUvxvn8KU0opk1xDJiQf8MIfhaeGMIczBWnBI92nGy2J6igSALIhq9DA
   jkzfFD/F/KL6ckiFUQW+jTlVt3TOT1NBtd6Gep0VxTzcEeZN4RLgJ17Sy
   UIrTEFVe/dpBm/BIEwUBUA2FP0yOBsQtFrB48HcHPNki1/U1OxFDqNm+2
   o=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.00,257,1681164000"; 
   d="scan'208";a="113804454"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jun 2023 16:26:59 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4FF26E03AC; Tue, 20 Jun 2023 16:26:59 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 57B70E0157
	for <cocci@sympa.inria.fr>; Tue, 20 Jun 2023 16:26:54 +0200 (CEST)
IronPort-SDR: 6491b72d_vU8aaaRaKuBpk34hkWnOsGkfOp9rdsCZH1Y4QP/9XQayeLC
 ZydBS+LZd973NmFXGxUYMt/IsPVk3+cj6exYakQ==
X-IPAS-Result: =?us-ascii?q?A0EGAAA0tpFkhw4P49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE7BQEBAQELAYIudQNTMAQLRwOET4gdhxCCJ4Q2jneIbIFWg?=
 =?us-ascii?q?UA+DwEDAQ09BAECBAEBAwSBTIJtPAoChgACHQcBBDAJDgECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBIxcHDhAnhWgNgjcpARFkgQgBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBARICDTo/AQICASMdAQERJgEECwsaAh8HAgJXB?=
 =?us-ascii?q?gEMCAEBgnoBgicBAw4jBw2vHIEygQGCCAEBBpwOHywiVYFfAwaBFS0BjS6DN?=
 =?us-ascii?q?3onD4FVRIEVJwyCeD6CSxcEGIUhgmeLKQ4MgmeDNIIxB4s7gShvgR6BIHoCC?=
 =?us-ascii?q?QIRZ4EICF+Bc0ACDVQLC2OBHFI6HoEoAgIRJxMPBQVNeBsDBwOBBRAvBwQyC?=
 =?us-ascii?q?RYJBgkYGBclBlEHLSQJExU7BgSDWAqBDT8VDhGCWiICBzY/G1GCByUEDgMZK?=
 =?us-ascii?q?x1AAgELcD01BgMLHwYmAR4CKYFXMFZwCiMkoAsDgxSBOwKBSw1jozugWTUHg?=
 =?us-ascii?q?jCBW4FdDIoTlQkGEy+DbhOMbIYoDgaSL5gZII07ml2BYzqBXDMaJIM2TwMZD?=
 =?us-ascii?q?44gGR6DcIRhiigBPj80AgEBCywCBwsBAQMJhUYBAYYAAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 T3Tx5EoAiWM/w==
IronPort-HdrOrdr: A9a23:r08nD6E07KEpwo0QpLqEPMeALOsnbusQ8zAXPo5KOH9om7+j5q
 STdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLfD1HZKjBgDWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: 9a23:Lpm5yGwMx//Z+JxoAmfuBgVTOdghXV3CxU7UeWKnLFw5eLOaeEaprfY=
X-Talos-MUID: 9a23:pRg4bgkUrTZahHv6VBl9dnpIEIBG2p+hJnwMjL43q/SfGDFiZQek2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,257,1681164000"; 
   d="scan'208";a="113804439"
X-MGA-submission: =?us-ascii?q?MDHosY91H2G1e+ZenBTqcVlVhg1zg6pSKF2vkm?=
 =?us-ascii?q?dd1YzrPd//++USTeewOeHrMCpJkcUvsXhBbRPojhRy3+SLL9a1jo616N?=
 =?us-ascii?q?7hdjxI5dSOF2R05SquyE72shY0y5T7T8v/duMTAj4se/7MjaPKG2rhXA?=
 =?us-ascii?q?cmKkF/+LGu+97Wp+WtYS+iLw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 16:26:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687271195; x=1687875995; i=markus.elfring@web.de;
 bh=26Sd1CLKiW59mEYHCLtxAX4ggNuw5qGZKqWi7FJE+jU=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=Km8kRDCS0K3t4nBtgE6C3wfluU9PFLrqMUUf89+VkqDQf+vXXVmdzQ3tYL2T7yjS+Plpm7d
 /5eutusPHWyr9GgSeAipb8jmT1hNeXef7xer+faeSNcfXrqvdR5pcoP1672C4kDkxlgIUsaXO
 v88ytjHINsuMxdlc84dFKOSE1ZugVrpWOyZhLNn0NNbiNSidJdvlxFjbNfDdc1p3tgujbWNDM
 gGjz4Vin7P5elb5A3BYOxUPt7PWWIUzZrvbwrmsXlaUmHZ75rawyjCqT4tWT+jGPTKiZa1xsq
 jF+v9PLmCza3Y+fCPuLPwIndvAgQoWrofO5/U5oYjENA8UHSSDaw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSIF2-1qeG5T0f3A-00ScIx; Tue, 20
 Jun 2023 16:26:35 +0200
Message-ID: <035d765f-bf78-7584-901f-9cbd348b0bf4@web.de>
Date: Tue, 20 Jun 2023 16:26:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Jyan Chou <jyanchou@realtek.com>, linux-mmc@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, James Tai <james.tai@realtek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <20230616063731.17591-1-jyanchou@realtek.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230616063731.17591-1-jyanchou@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:oHDIIZvRsqLFlUnjVJtMlxqb+8wC48QGj4rEKZpoG/kXdyzx/wv
 48sMxPSG3X2kBrS1wHFiHTK0MAESQPBlaK/rXTgtSys5QkE8qrcTDoFKw5KhjI8l3PD1ORG
 Bl5INXO+ZJyh53gDzOkmBpWFCEu1NmvsM83WzifPZcsNNGV/gosG1wRCUpil8PrKjaViKxM
 4XtwNIdYnSpdLfgQKA/7Q==
UI-OutboundReport: notjunk:1;M01:P0:/DYfgnJ5kk0=;+EUJ8IYWornsb/YyWxZ99ZsT5E+
 xJSARqGzNTPqbbsSoJ22z6UK52MCkm9JqIFcmnljZQACpvK777RojJtB3oI7o1DyhEDXI977P
 R/Wa68W7HSNxTFk4GDr2I4qcIJcfSYz/+RdSZRG85zW8RXP75QQlrVbY1JqL1pysK9pY0OMI+
 InFANIHYta86cLYxpxA7pJXXSJeOgnH3zQvmPvvQykdKi5+/Wif1ADnknR70ztWJ4GCyT2ZDi
 I6/YGHyAnfOK59w4tt5N7bnJy2DrbpxSdai+YXSoZpQO3DGh9AcnnM90OhHPvlTj0Mb9IrH8B
 eJOO86kMrHzWoFFTMRNkAqnQWy4NUWxpT8FLj7ewKvFDCnZ8xJWj9jjNO/pyoP4o6Azv+cSY5
 ui0vEDf7mqzfdqf4Idh4FxY/MkShXQ7yppJBA9i6KUSCj0bCPkYV0mq1cYWoR6GliI/UcYJVo
 uN+2VFrd7OXBtHKBH5Eawp98RsNO2HhQXiFAN8hYiMhbEp8itI7ah6LrbFVVkpX+mDp+OJDn0
 OrHCuwXd+jrblBPaOrDqBNE4MV9MK3CE/s6z7CLMOe2xpepaZ1wmluNvo/UWVMVoEZZaUudpW
 UTcUYGuIlyXXp9Ge+7nHw80WuHZezKiIiZr9T+xP83t0m+zQ8+oovXxZfER/8aKJXB529lNkY
 kwJosM5x5Ve2cKXW9lm7FVClaJ3F3ry+uKxj1yJ6H2pDZ9XxM6VwAL1gdEaNZVmMZdDLTHHMb
 aDfqsVEODdi+y+Phzv+zq7NXtR+6S3cyPfD990uJfDvLfzxxGeXCvJQtHJvLZkCDz21b8xQuD
 fHk0CerY1CE6/TT7/f0wMyrV+XEtmQGIwuR7szD3UONS6l7qf5VFINhOIi58+WddiJOKGciT0
 mdciIUf+YZ8qVOZ1o43v4fnMYS8QV1fQTjLoAB303l1nnFpSpJ6GVvUqlTu7KXvXrs3i22jpm
 yg1P1A==
Subject: Re: [cocci] [PATCH] CMDQ feature is introduced to eMMC standard in
 v5.1, which can be used to improve performance.
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1201
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/035d765f-bf78-7584-901f-9cbd348b0bf4%40web.de>

Please improve your patch approach according to aspects
which should be known.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.4-rc7#n45


1. Can an appropriate subsystem identification be specified?

2. Please choose a more succinct patch subject.


> We add the mmc driver for the Synopsys DesignWare mmc host controller
> with cmdq support that can implement this feature.

3. Please provide an imperative change suggestion.

Regards,
Markus
