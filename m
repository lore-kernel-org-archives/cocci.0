Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B6FEB64D8
	for <cocci@archiver.kernel.org>; Thu, 22 Jun 2023 13:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=I/TGSIjruwPv2BOIv5ee3paRdQDXR6NFkjuzw8yrPMo=;
  b=lnMT6ownpfS9Ps7VHF9OedW8ltB6rxLs7pSbfZA9lR9Dy5LGsHqKzGlI
   L1Zx1jJNrRR5JfQ6faYYzDET0Y2LgBaZt0x37WDKRbcNhrXdaqcdXjvsM
   jBr18IVHhp9vckydlskPWFiNkM7qgZj6W8FoB6X0pT7Vo4etEFrL9aUR9
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
X-IronPort-AV: E=Sophos;i="6.00,263,1681164000"; 
   d="scan'208";a="114206500"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Jun 2023 15:05:36 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D2C79E03AB; Thu, 22 Jun 2023 15:05:36 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E9FC3E0157
	for <cocci@sympa.inria.fr>; Thu, 22 Jun 2023 15:05:32 +0200 (CEST)
IronPort-SDR: 6494471c_1fsnKX95UndrQP/BHpgMdZ3uvtyazLLoeKvsp/sVpNlgvRK
 E0/iCzKpo8tUQkKEN3e0+4be7MGK5wOUkLzHMUw==
X-IPAS-Result: =?us-ascii?q?A0FeAAAiRpRkhwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIydQNTMAQLRwOET4gdhxGCJ4Q2jneIbIFWgUA+DwEDAQ09BAECB?=
 =?us-ascii?q?AEBAwSBTIJtRgKGBwIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECA?=
 =?us-ascii?q?QECBAUBAhABAQEjFwcOECeFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBEgINOj8BAgIBIx0BAREmAQQLCxoCJgICVwYBDAgBAYJ6AYInAQMOI?=
 =?us-ascii?q?wcNrXuBMoEBgggBAQavUh8sIlWBXwMGgRUtAY0wgzl6Jw+BVUSBFScMgng+g?=
 =?us-ascii?q?ksXBBiFIYJniyQODIJngzSCMQeLZYEob4EegSB6AgkCEWeBCAhgd3lAAg1UC?=
 =?us-ascii?q?wtjgRxSOh6BKAICEScTFAVOeBsDBwOBBRAvBwQyCRYJBgkYGBclBlEHLSQJE?=
 =?us-ascii?q?xVBBINYCoEMPxUOEYJaIgIHNj8bUYIyJQQOAxkrHUACAQtwPTUGAwsfBiYBH?=
 =?us-ascii?q?gIpgVcwVm8KIySgJAODIIE7gU1wozygWTUHgjCBW4FdDIoTlQkGEy+DbgESj?=
 =?us-ascii?q?GyGKA4Gki+YGiCCL4sMml6BYzqBXDMaJIM2TwMZD44gGR6DcIRhimc/NAIBA?=
 =?us-ascii?q?QssAgcLAQEDCYVGAQGGAAEB?=
IronPort-PHdr: A9a23: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
 hGe3SROci4AWqhyyhqF3lwwMaKMwnC5u4M=
IronPort-Data: A9a23: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
 D3QFrAc/vR8/32xedsu2w==
IronPort-HdrOrdr: A9a23:DRT4Aa7KPrzCvs4dXgPXwBzXdLJyesId70hD6qm+c203TiXqrb
 HLoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkdNDSaNykesS+V2mmFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:sy7wVWH/9Ot2j/MDqmJ6/X4/NZt7S0TFxXaMMkmlOVlnT76KHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3A7XY8ng8Tw6bRUT1EzHyaYYGQf+Vw2q30K2JQqs4?=
 =?us-ascii?q?5n9GWNhxiGBHHlzviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,263,1681164000"; 
   d="scan'208";a="59554126"
X-MGA-submission: =?us-ascii?q?MDELASa/H27FJ5D9xIeyXOBjif6cBeAvZ+Jar1?=
 =?us-ascii?q?waNSttEYUzAWcW+BSoc5tuDcKXs1jkCXbU8Ow1WBTleWIZWSoPvnmn7E?=
 =?us-ascii?q?7YrYGGY9RcSDx5O3uBT2dENvxuIfL9JDnBjlX6vRL78gbmC1onTkGQUJ?=
 =?us-ascii?q?B/ry6cxkn/09xRaaZmQPUKOg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 15:05:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687439124; x=1688043924; i=markus.elfring@web.de;
 bh=I/TGSIjruwPv2BOIv5ee3paRdQDXR6NFkjuzw8yrPMo=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=EMei/6NK1ZhBA9YBWiZyCT6FIstoSgOITv2H8tkEfeHQ5ovtSlvP7e1mlJAZDFsjPT4A0Rq
 a2mQftsyQwhkdEpFYSr2I69v65tV1M0wKHdluwWnpY1lyLujbJoMAWYRV9f0NGxQyH8lKeXba
 Ni8Eo8z8tBbwMspvWIKotbv0Q5KW8vajjkIWt/sr05GxCD7MoRroAP62ukQbh1YT6kJJC/Dfq
 q3xgJ8xBGkQEBNh/RPKDP2lTYVJP2yprdDuxExFmPQI0NB2woGoM2Jf0QUXifgPfxFTs165AT
 Fgd3Cs2KYHDJ6k1mkinr+cMKTgw0Qzk2m1U9V+8pwrUVJS7a8HYw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M5j5k-1qAhAc1pxC-007eOK; Thu, 22
 Jun 2023 15:05:24 +0200
Message-ID: <ee1779cc-fe9e-d529-3188-4feef8f27b98@web.de>
Date: Thu, 22 Jun 2023 15:05:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 Kah Jing Lee <kah.jing.lee@intel.com>, devicetree@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <20230622123432.593548-1-kah.jing.lee@intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230622123432.593548-1-kah.jing.lee@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:e1vYLn0swWj8sd0EzBy4c45XtCmKFf4PkY65/Fh33GMaXmbYqvM
 gWT8tVvqw3laJ1B6FUp6Evm5JOXNCUUL7ifwauBo8z3vu9XIfwv1hIWEAKPlgucmPKY5dlY
 YmbZYVxgkL5JMQ3q238mu43orrTHGFEgERaTkQEayE8Z4GzHccHlbQzqL8Pij5LLQ2RMkmk
 aNbcNBd++6oXbrTTRrDqg==
UI-OutboundReport: notjunk:1;M01:P0:vVkTbeYK9cU=;MypTJZxIWP1AhO9eEd6YjiiQEJ9
 hIbznBCbV54Iv9koxC0ODf42gZaCK0baeIgV3IejcZPxfuKlwAkw4nX+KolxFziALBy5PhzFU
 Ocu/TJjOkpUbWokgtXXtlV/0L4HCo6agc6Bwkxg2E9nA3ZoXZiRBcqDOsE313w8kdOH3NOaoI
 DXHZwNSTxISzKAtmO0pJoBg7L4Yp4jZI7eGXVJyLasr1ud1f6x1gzHR87VH935sx6G/dnvZNW
 08BP/+vGEXipK+LkGTmNlMG/ifKoPnxpVKHir6OQOmspyanaE02+TZqL/bhpohlQvdMe41/jJ
 qLcC3zLCIgNcHqaP+KT6/nT5SwLDxjx+o38IVYBVoxCSXTmw29I2w5h/bKgKFakqxZLddh+FH
 pf7hRVXiamcWtkCRRoCqfXJNUMKm3u3cQWhZ3eV2Lh+USdSS+DREMUVPfcr6QZjcaamgouRlz
 MQUZPEn0szWq590yuhv4rOlCS7koDuOV1q25qlDLmft0/pvz85C12ed0lTPurR2bRgd5vk/If
 bgp7LqeAZRduOk1RGYzawOKOEi5N/F+RbftYPSBnvNGhcv9D378TGz4oxJhNMDn3QAFfCDV5S
 BwqPZP4HctDCX0zQIPhJ5boF9MK0pr48zCUh6uvLw4dlnz15ezw/HcPPEtdNgmv0ay23nBA6u
 6xQ/xJ+eUPpu8yypUYQxVEAMsXZXrB7hC2bUnamEhJFpUKlFcasRgzKPdjWG7qEZcVyYplGU4
 3V7Jvq3y44bp/aSE83uUnHFxjukPtN+hLQavepajWqAQFpG+JkpmDcQQF2CiSDS8miCurFGII
 yL/aMiciHhl9J6Am6TwvyH3/3O2v+rpZCD9Y/KfyrU3KmwQqhLLw1d2Kg728vSRqv8rVeRH2R
 Rbwbyo3kgzXjjKpo40JUDffqk6Pif7DFandSOPN+yevRWwThhDvuHXExZQfGsevGlQpm2/IFs
 HIpllADU3hyroo92rpUJrgZummo=
Subject: Re: [cocci] [PATCH v2 1/2] arm64: dts: agilex/stratix10: Updated
 QSPI Flash layout for UBIFS
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1205
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/ee1779cc-fe9e-d529-3188-4feef8f27b98%40web.de>

> This patch is to update the QSPI flash layout to support UBIFS in mtd
> root partition.

Please replace this sentence by an imperative change suggestion.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.4-rc7#n94

Regards,
Markus
