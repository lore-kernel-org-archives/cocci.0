Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922D8C001B1
	for <cocci@archiver.kernel.org>; Fri, 23 Jun 2023 11:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=JFhiLiSCiHKJoTDmjutsLcAqLwLTMIPTUHm8UbtiEoI=;
  b=VVB6ZsCLatEJjCpZcqm1agtJmJE3cWB8PE5NHMhDgASbDd20WAd/sb52
   Kho4gFUIAA6A3rQQeXv+KRK3j5CUiJOvZUH5OFxRLdwyyV8rAiJWbXglA
   CNcZC68FgVdSCDhYUFfuHXc83HbGqtzjLZV70bIUQfid27qaj8YqZvxXG
   A=;
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
X-IronPort-AV: E=Sophos;i="6.01,151,1684792800"; 
   d="scan'208";a="114364191"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Jun 2023 13:04:27 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 740F9E03AD; Fri, 23 Jun 2023 13:04:28 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A5E78E0157
	for <cocci@sympa.inria.fr>; Fri, 23 Jun 2023 13:04:25 +0200 (CEST)
IronPort-SDR: 64957c23_wtKZD+n+Mzrf+tc+ApX08g/PHb9WdGMsm6EsqFDDZ3sTi1F
 yHTwYutcCIQMcBDiZy/Jsv89xptqGhFjqZ9s/WA==
X-IPAS-Result: =?us-ascii?q?A0G2AADue5Vkhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIyeFMwBAtHhFKIHYkHMYQ2hzKHRYhsgVaBQD4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEgUsBgzMChgYCHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBA?=
 =?us-ascii?q?gQFAQIQAQEBIxcHDhAnhWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARICRz8BAgIBIx0BAREmAQQLCxoCJgICVwYBDAgBAYJ6gigBAw4jB61yg?=
 =?us-ascii?q?TKBAYIIAQEGr1IfLCJVgV8JgRUtAY0wgzl6Jw+BVUSBFSeDBD6ERINbgmeOJ?=
 =?us-ascii?q?4UmPweLdIEob4EegSB6AgkCEWeBCAhfeXlAAg1UCwtjgRxSOh6BKAICEScTF?=
 =?us-ascii?q?AVOeBsDBwOBBxAvBwQvCRYJBgkYGBclBlEHLSQJExVBBINYCoEMPxUOEYJZI?=
 =?us-ascii?q?gIHNj8bUYI/JQQOAxkrHUACAQtwPTUGAwsfBkICKYFXMFZwCiQko1ODeMQVN?=
 =?us-ascii?q?QeCMIFbgV0MnxwGEy+EAZMUDgaSL5gaIIIvoC2FPYFjOoFcMxokgzZPAxkPj?=
 =?us-ascii?q?iAZhA6PCQE+PzQ7AgcBCgEBAwmFRgEBhgABAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 z3TFr0c8yVdGq1UeNs=
IronPort-HdrOrdr: A9a23:h1mNf6nWnQ3GQ2QjFEIShTbOIUHpDfL43DAbv31ZSRFFG/FwWf
 re+cjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:UdIzIWyYNJ2DZnD+e0agBgURNMsVQ2Lv3kvgIkmaL0Q0WeTEY0W5rfY=
X-Talos-MUID: 9a23:0yD1gQUCYNiT3Xrq/CTW1TdLHfw42IaRUWYMl5o8sumgDDMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,151,1684792800"; 
   d="scan'208";a="59639747"
X-MGA-submission: =?us-ascii?q?MDE5IOintZw1ApV9BHJDnAeN/dH19bjzMTp0v6?=
 =?us-ascii?q?p+xnRM7gNVochukttFYtLdsJ1xP+dvHqkhDeKBYhxZ3LwuEMI1TXiR4u?=
 =?us-ascii?q?0RWuLpf6e+1MH5Er+5HbApBJd0kkCOGXqfIquCJBO3iOSjDNOT2yZWxv?=
 =?us-ascii?q?DqsTq5tQIRONZS8qzq0p1Gug=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 13:04:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687518237; x=1688123037; i=markus.elfring@web.de;
 bh=JFhiLiSCiHKJoTDmjutsLcAqLwLTMIPTUHm8UbtiEoI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=QNH4JSg7TLFgfJfQv3fvFvOHAJ1YmjV1xykKX1ba4V5zHEG4Ol1lWU0uOjFLEU/P0+CzJis
 f+qipfm0byRpEPwVfA+vboSyso6x5W1CxsVKJsTdNh2rinPhwjOg4yrgWViTogK4vtAfreiPx
 paoW+VwlsKeO4tpHiO95Y4DeM73qqBi/FpC8KqypPcFG42uzZKaJ3kRjQJtoHPEot1t1h49z9
 +yuMREjIL8L0k9gdjmkHJ30p4Ax1lLWZho18dlKLOkX0VRkjvPkEtxPHpPvo4Oaoce61wgBfU
 1ex46rGzk1WoC5EYtA/5JIHk3llDCyA2jIuXqlF0VzNi+RXPoaCQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgANG-1paoeR0L5K-00hUFY; Fri, 23
 Jun 2023 13:03:57 +0200
Message-ID: <c15e650e-6aee-d3e1-3fe1-7e5d34813a04@web.de>
Date: Fri, 23 Jun 2023 13:03:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-GB
To: Kah Jing Lee <kah.jing.lee@intel.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley
 <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "cocci@inria.fr" <cocci@inria.fr>
References: <20230622123432.593548-1-kah.jing.lee@intel.com>
 <ee1779cc-fe9e-d529-3188-4feef8f27b98@web.de>
 <PH0PR11MB56730E97D182D413C9B555E1CB23A@PH0PR11MB5673.namprd11.prod.outlook.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <PH0PR11MB56730E97D182D413C9B555E1CB23A@PH0PR11MB5673.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pQX3BjFfPdRNPOHfcOtw4rYjc6gtr2RRyDFNDiUT7B0FYOFRO0J
 jidsk9XXF3y8TVQvZafWaYK+dHMao1+qJR9MJ74Pg3pEPENTmoOyYTHeH4XsD+5UIXWPBoe
 4sYStVFrwG3Os9NBLNxMZnLjbzRFe9vW5d033CdjMo6YkvZwoLHupjW5Appc9p6qgO6yqLK
 ZNJO2B1kBT5ff/6u2q2Fw==
UI-OutboundReport: notjunk:1;M01:P0:TkJFlr3bQfM=;sLfJmLicILl7A7orNDUisdqNDj3
 QluiE5jjTjG0Cfn4fUKl56/O06zvUPfH9oT30uiUKnO72kWJlwlzxFgv7oKWdNSXYGaX5Fuv+
 ZHVBn6PV0hj28BfsZnwqMSVm8hHEeC8FJ2e3Gj+VUuE6Qw79rwlI8tIEYpiXQQHKcfNO58Hrk
 IpqwUOrNWhEWSrBXmUODhe3UuFvKqI7XCimLX3RDz3sd1eBXkjSSR+DScMJXxfEnU6WD5LHtH
 9i2fNtHgrSm9BLG7MjlRFX5scDf40dswSZfAoL6o+mTB5gh4HEEqFFa0MSdhJkZMaX99KS0K9
 1scoFHplKSjv3+00XYUYrWnfef72QY2wdHRf3U7767GV2Qr0fUJ4Lt87JJ2O4cLmBxQCr2XTE
 AJsT/m2AdbVrGfpHYz7za5bqJlRG3TO/VIC1Ux6kBeHapxka/lYUSCYe8pdEOqh2evid75ph8
 KHGwuel5iwLrugZSvIFG/2X433/OtiKKpi/HkEE+S6m8SCSqauFJdyEiG6PJgXqho5YIHkpCB
 7XJUdhzEHlAWKq+7XExv+58nCAF13kCy/39+epXnhHVp4roOP5GLIUrqhszb1Y89h4k6gf7Nl
 I1UZp5ptKv47Opl3I1/Q/ey4xPYvlvnQT2VkVwS3q/1rHdPvF8ryyKUGl7lWLg4aYHNCebJMj
 jWLvHsnYsNgC5qiLr8leDQeHhKy2/BCP9LN3XC2PiMnmBLiGj/mINLx+qGDfLAIwfHYER6kvz
 Vrug1hhYmSo+jLYFJXAZF93pfx6DrkzzSm60LlwubblSgi/+BY3QKmlcmnRLflyVqxcCeXGsj
 T6alVC2xLgjNI2CxmX3rZXTDvYvKX9CLtg96F6TS2g9FO4ypVtUlFhEH4S8FOtaLEF7w5R1Ul
 eBumD9i3rpSVAjA/SlD6QgwDAJqvkXecVaW/0iyPSBfnVfS7D1iy3o0NqSbscY64EddQTHTCr
 Mb9y0A==
Subject: Re: [cocci] [v2 1/2] arm64: dts: agilex/stratix10: Updated QSPI
 Flash layout for UBIFS
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1207
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/c15e650e-6aee-d3e1-3fe1-7e5d34813a04%40web.de>

> Updated in v3 - Commit message:
> Update the QSPI flash layout to support UBIFS in mtd root partition.
> Flash layout is updated in order to store non-UBIFS related boot and fpg=
a data in qspi_boot(mtd0)
> while keep the rootfs with UBIFS in the root partition(mtd1).

I got the impression that this change description is also improvable a bit=
.
How do you think about a wording variant like the following?


Non-UBIFS related boot and fpga data should be stored in qspi_boot (mtd0)
while keeping the rootfs with UBIFS in the root partition =E2=80=9Cmtd1=E2=
=80=9D.
Thus update the QSPI flash layout to support UBIFS in the mtd root partiti=
on.


Will similar adjustments become helpful for subsequent update steps?

Regards,
Markus
