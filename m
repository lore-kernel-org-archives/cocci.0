Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EBAC761A6
	for <cocci@archiver.kernel.org>; Thu, 30 Mar 2023 16:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=T0bZTaUErz9+L6d2YfcWXbt3iMIbcYfv4URuh0hgpCI=;
  b=LzoPelWZmq8+y/gjRqNP8caClIGjSHylSFRaZ8/Pu9jD9djs9QyxiVUN
   s15JMetnp5nQA6Kv7Myedu5lbJ48PJ9ZN0gx+63/8BwThe9pTeACAYHsT
   66kkkLfKJxMvgRyLFw/W+GSy94RqsoxkZzna6KLB3rtjuOlLR+Yk5QGF9
   Q=;
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
X-IronPort-AV: E=Sophos;i="5.98,305,1673910000"; 
   d="scan'208";a="99967955"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Mar 2023 18:18:36 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4ACE7E019F; Thu, 30 Mar 2023 18:18:37 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id F1256E013A
	for <cocci@sympa.inria.fr>; Thu, 30 Mar 2023 18:18:32 +0200 (CEST)
IronPort-SDR: 6425b658_awLw7JsgLKwBuv3We9vPFKRAqLXu9yKthhX/tEqgCfvKyXN
 Ofljc2uPZGzFstQ5GGpYV2HMU/YmZXZdCwIzrrw==
X-IPAS-Result: =?us-ascii?q?A0FCAAB+tSVkhwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYItgUsvBAtGhFORATGEL4csjCGEAoFWgUA+DwEDAQ1BAQIEAQEDB?=
 =?us-ascii?q?DiBU4JzAoU6Ah0HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEB?=
 =?us-ascii?q?AEBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQESAkdTPQMDIwQZAQERJgEPHwYCJgICVwYBDAYCAQGCeoIoAQMxB60lf?=
 =?us-ascii?q?zOBAYIIAQEGgmOZJx8sIlOBXgmBFC0BjQSEMCcPgVVEgRUng0GIHIJngimHV?=
 =?us-ascii?q?Y9VCoE0c4EgDoE9gQQCCQIRa4ESCGuBfEACDWQLDnGBSgKCYSUEDgMZKx1AA?=
 =?us-ascii?q?gELOzo/NQkLIAZYawIsERMFAwsVKkcECDkGGzQRAggPEg8sRA5CNzQTBlwBK?=
 =?us-ascii?q?QsOEQNQgUcEgQ18CgYBJiSdf1M7TCaCBJJYkkCeDjQHgiiBVYFZDJ8MBhMul?=
 =?us-ascii?q?wgOBpIiAS6HLZAPIKd6gWoBMoFcMxokT4JnTwMZD44gDA0JhAOPSD80OwIHA?=
 =?us-ascii?q?QoBAQMJhUYBAYV7AQE?=
IronPort-PHdr: A9a23:x/EPqh0Q51u4C8PIsmDOkA4yDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BaCo68w3RSRAM3y0LFttan/i+jYQ2sO4JKM4jgpUadncFs7s/gQhBEqG8WfCEf2f7bAZi0+G
 9leBhc+pynoeUdaF9zjaFLMv3a88SAdGgnlNQpyO+/5BpPeg9642uys+5DfeRtEiTq5bL99M
 Bm7rRjau9ULj4dlNqs+xRzFr2dSde9L321oP1WTnxj95se04pFu9jlbtuwi+cBdT6j0Zrw0Q
 rNEAjsoNWA1/9DrugLYTQST/HscU34ZnQRODgPY8Rz1RJbxsi/9tupgxCmXOND9QL4oVTi+6
 apgVQTlgzkbOTEn7G7Xi9RwjKNFrxKnuxx/2JPfbIWMOPZjYq/RYdYWSGxcVchTSiNBGJuxY
 YgBAeUOM+lWsonzqUUArRagBwajGOzhxyRUhn/vx6A2z/gtHA/E0QEmAtkAsG7UrNLwNKoKV
 u661rPIzTbeb/NNxDzz54zIch47ofGNW7JwftfaxE4oGQzflFWQqpHlPyiP2uoCt2ib4fBgV
 eOpi24osAxwrCagydw2hobUmI0Y01bJ/jh2z4gpP9O3UlJ7YcK6H5tKsSGXL5Z6T8EtTm9ot
 ig216AKtYKmcCUKy5kqwwPTZvKIfoaI/B7uVeacLCl5iX55d7+xiRK//0i9xuDiWcS4zEtGo
 jZDn9LRtX4NzwTe5taaRvdj5EutxyiD2gLJ5u1ZI004j7fXJ4A5zrM0mZcfq0rOEjLslEj1j
 KKabEYp9+au5u/6eLvpvIWcOJVxigzmMqQhhMi/AeMgPwgLWGib5Pi82Kft/ELnW7pGlOA5n
 bfBvJDbI8QUuLK5DhdL3oo+9RqzFSmq3MoakHUdMV5IegiLg5X3N13WJfD3F/a/g1CikDdxw
 PDGO6XsDJLXIXjZk7fhYK1951RTxgo3w9Bf/ZNUCrcOIP/oVE7+qsfXAgUkPAOq2+rnDs5y2
 ZsEWW2TGq+ZLL/SsViQ6+4yO+WMfpMauC7hK/g54P7jlWM2mVgBcqa13Jsac2u4H/RjI0WBe
 3XgmNYBEWEQvgo/VuPmklOCUSQAL0q1CqEx/Dc2DMekBIHCWoe3m5Sf0yqhWJ5bfGZLDhaLC
 3isP72EWvMIaTraBsh8nTwJT/D1U48g0RWvrCfh0qduNera4Wsfr52lydsjtMPJkhRn0DVuD
 NmGm0yJQXt1mGxAExo/xqNiugpQzlmZ0K53q+NVH5pf6qUaAU8BKZfAwrkiWJjJUQXbc4LME
 Q7+Kj3HKTQ4T9ZqhsQLf144ANK6yBbKwyutBbYR0b2NHp09tKzGjDDqP8go7XHA2eE6ikU+B
 NNVPDiDj7R86hOVKorHiUSfmI61eK5a0COevHybwz+2tVpDGBV1Tb2DWHkeYkXMqtGsw0rYT
 KK1T5kjPBFAz8GqNaZALNHk3h1dXPm2HtPYbiqqnnuoQxaFwrTZdI3xZ2AUxznQEmABlB0Pu
 2mLP04yC09Nukr4CzpjXRLqakLoqqxlrW+jC1Qz10eMZlFg0Ly8/lgUg+adQrUdxOBMviBps
 DhyEFunurCeQ9OduwpserldatIh8R9G02zerQl0Ip2nKehrmFcfdw19u06m2Q9wD81Mls0jr
 XViywQXS+rQ9VpbdC6Dm730NKfWLGba4x2lLaLbmxnf3NuQ5qYT+aEgsVyw9AqtF0ck7zBmy
 4wPiiHavM+VSlNNF8urASNVv1BgqrrXYzcw/dbR3HxoauyvtyPanskuHK0jwwqheNFWNOWFE
 hXzGosUHZvLSqRill63YxYDJO0X+rQzOpbsUvKc27Owestkkiini2tv/413lE6BvXkZKKaAz
 9MezveU0xHSHRL1llS8qYbanY5eZDcdNnWyw27oCcQCA886NZZOAmCoLcqtw9x4jJO4QH9U+
 mmoAFYe0dOocx6fB7Dk9TVZzl9f4XmumC/jiidxjylsta2HmirH3+XlchMDfG9NXmhry1n2c
 8C4iNUTXU7gaAZM9lPtwE/gxLVA4ol7IXPSR0hgYCX8aW1vGqe9rbuNZcdT5Yhg63wNFr7mP
 hbDFfik+VMTyGv7EnFbxSwnej3P2N2xhBF8hG+HbT5yoHffZcBs1ELa7d3YS+RW22lOTy15h
 D/LQ1mkaoPwp5POzciF67/4DjjyM/8bOTPmxo6BqiahsGhjABnk2uu2hsWiCg8ilynyy9htU
 yzM6hf6eIjikaqgYocFNgFlAkHx781iF8RwiIw10ds10GIZm47T0H4Ji2b1Pv1E1Ki4YHdHF
 ltpi5bFpRPo3kFuNCfD4ovjVWiGhOZlacO7ZGw+xS83qcxHQvTxjvQMjW5+pVy2qhjUaP52k
 2IGyPcg33UdhvkApAsnyijOSqBXB0RTOjbg0giZ993r5rsCf36hKPLjsSg21cDkFryJpRtQH
 Wr0aot3VzEl9d1xaRrNyCGhsNi+PoOKMpRK7EPSyk2QyLIITfB53vsS2Xg9YDi75yd6jbdmy
 0Qph8zyvZDbeT80puTjWEEeb2KzP4RJpXnslfoMxJ/Jmd/1WMwwQHNRAMuvF6PNcnpatOy7Z
 VbUVmRi9zHCROuZRUjFtg9nty6dScn0cS7NYiNBkpM6A0PCbE1H3FJOBWp8wcR/T1HwgpK9N
 x0ng1JZrl/g9kkckKQxaUS5CD2O4l7zMn81UMTNfEAQt18foR2OaYrEtKo2FiVctPVNtSSrL
 WqWL0RNBGANAQmfAkz7e6Kp/Z/G+vSZAey3K73PZ6+PoKpQTaXAw5XnyYZg8zuWU6fHdnB/E
 /023FZCVnFlCozYnTsIUSkeiyPKaYaSuh69/iR9qs33/u7sXUrj4o6GCr0aNtsKmVj+maCYK
 +uZnzp0Mx5d0Y4Qg2DFwv4T0R9aii1jcSWsDaVVtSPJS/G1+OcfBBoaZiVvccpQuvhlhE8XY
 5Gd04yzj+Qr65x9Q01IXlHghMyzMMkDImXmcUjCGF7OL7OeYzvC38DwZ6q4D7xWluRd8ROq6
 lP5WwfuOCqOkz7xWlWhK+ZJ2Wu+NQZdpZr7XxJjE2nlQ/r5Zxf9PNI93lhUifUkw2jHM2IRK
 202a0RWsriZ9j9VmN16HHFdqGVoJ6+IlmzKiouQYoZTuvxtDCNukutc63lv0LpZ4hZPQ/ltk
 TfTpNpjy7lHuuyI1yYhTxdE7DpG1trjVapKJqjTsJVNCy+sFPcl8miaTRgH9YMNNw==
IronPort-Data: A9a23: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
 RoiFrEc8/R/LlyFhQre2xBjvdpa+w==
IronPort-HdrOrdr: A9a23:OeS0SKmxUY2BWgxfpeuJbtPSj1DpDfL43DAbv31ZSRFFG/FwWf
 re+8jzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQmVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjjzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,305,1673910000"; 
   d="scan'208";a="51734481"
X-MGA-submission: =?us-ascii?q?MDFwCjZUv1v5av0kp3tcIJz3B30CMLL4NZ+QMP?=
 =?us-ascii?q?vATn67hFvL2fFO137Gwn+eoZ883l5UJ8yMQcNsxTLQkjeysnKyDv3iYC?=
 =?us-ascii?q?E5Qeom/p10Re+ojymyAXzv9UXoq/kcd1+vxQW9lA4wypULZI+siGqJ4M?=
 =?us-ascii?q?sRZgVw03QeXWUsycFglv1V7w=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 18:18:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680193111; i=markus.elfring@web.de;
	bh=pPRSvC8bcUBeJQaLwuf7x9xPMGbDNMQennsg1oAZDu4=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=IMmLOoxH03Z8QLD0g14TaKgP1AUGTBiHeKBYgt2d8Z2Ht59T+OO0DcdGfyhS7YsVO
	 iTuWzDXXNwU/i3+XCT+C8RY067ridZLcFmcjR1+DYZ9MqybTWyRjtJTDHwbbTE64or
	 V+WrWSUP289Au3VJr1UZjaOHXzHTp+YwKzgB3w9tjA7LrPk4Rh0TtFWqjPaRDZz1X+
	 SlgkPqr80LHkJ7HtbEYGgSj6yQ0wQ6QHkpvq5lOe84AtWcEmxHGGV92t8S7b3A4/I6
	 rwCflmpp59PUME0eR3PYtm6xGnvcWfqrT4E4INWTOlsBrqXSJDKSbceDvpaBRbZCzo
	 ybBNJ9SWs/jpg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMGuC-1pz1rF1eFC-00JmGv; Thu, 30
 Mar 2023 18:18:31 +0200
Message-ID: <f1712777-97ff-d89c-0bdd-d72faed9a7f1@web.de>
Date: Thu, 30 Mar 2023 18:18:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, Phillip Lougher <phillip@squashfs.org.uk>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 Minchan Kim <minchan@kernel.org>
In-Reply-To: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ieDMDR+TkrqHUQtgAFpDkksuOJMbErZfotYzpOdlA032+mcwhwq
 6l/goLOQST70ahYtTqAOMRe5WJd4IXm/+Cq5ruqu4VR82Rv+8khIpBrUxJuyPz8eB07GskG
 mO8tcE5JbotI0nxDqaLsPMRpSC2gXCwiPZioPmk9j/qcw4iXm3ZGwU1wYJ4+M2ON4zgXexV
 fhaPGkeNG53y/LBRgCRFQ==
UI-OutboundReport: notjunk:1;M01:P0:O8KknBHwIEk=;UagSHbdL6L5QoS7S02gr9pGXEqX
 SW+6Fy0YMpI05kUNxhybXuNqAp1f9Lx7Axp4+ACGIlFsj5JwjbmvPq/40HmpuWcLSqiKEdJ3G
 9/kRTTItUOpCNLbd0rbmfeGoyJeBLrQ95VVJGZQWn8+Og2ZAwnrhaFGTBnipERsCnP8EOtbbF
 GJcfrg1/PkY0JO0Jd0v0N8LsrWM5pmeDeuBJNoDOkG52xoCsunspi0WsnXyNn182hXc/1F6sw
 3AwpVa3UUs1ckf4MzJeinwkQoL61GjHwkb33C87uvp4hHLzrVU573ukNfcq32Yu20rSuz0v8r
 0eL1zBS70eiiuLYNHB66RisZRqGINOhtDozkUkN9jvQwBxhMd/KrYVJybcFmOiF5QBEws1La4
 w7Wz4t7qgjy519DpUARc6HpZrSDQfQ73yxvL8apHrGu2vfdKYmUUIo94+cYN2u8mNO1LAS/ND
 weXfuJOu4PmBxLeaKInltmIMf+CWDZy+XTeXOBbIndNId+GTo7vRvTdbAPZtRLL6Wvj+WMawU
 hn5k3Mu+N7gL/47mZgv1PvCvQQ4VJel3VD3FZGz+LvG+zuyGGz3yRxFZS4QTc6m5J/BmuRuZ+
 1KpCSn2O1dvKonQyc3yg/QYit+yXNipswua/5ogW46Yj9Kf27mYIRcbNvFbeEVWl36AdOXPm/
 P5qNkn4ADPYHL+H69XnEykApIdBNGBbIZFlC0h/HDP5UwCzEDCURFAHsUiNKd/pKt5e85cLs9
 6shGMeXh+yEWALRXPBptGZpHvcfxdTAbHF7H+mgKsHFTInJ4RIA02uUvApfzWYjQgOKuLsvFB
 ORoCKEKmTtLH7Z4zLepkk2Vzhn1GPyVowko3VSqPUxnrYDb4HlVu8i+1I84g7/QplIKrdg/BR
 10oWiMMs8ko/yRd3XThYcVCTDYaCDh8vuszJTWeOM2bJTGVF23TBbpH1p
Subject: [cocci] [PATCH] squashfs: Improve exception handling in
 squashfs_decompressor_create()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 993
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/f1712777-97ff-d89c-0bdd-d72faed9a7f1%40web.de>

Date: Thu, 30 Mar 2023 18:03:47 +0200

The label =E2=80=9Cout=E2=80=9D was used to jump to a kfree() call despite=
 of
the detail in the implementation of the function
=E2=80=9Csquashfs_decompressor_create=E2=80=9D that it was determined alre=
ady
that a corresponding variable contained a null pointer because of
a failed memory allocation.

Thus perform the following adjustments:

1. Return directly after a call of the function =E2=80=9Ckzalloc=E2=80=9D =
failed
   at the beginning.

2. Use more appropriate labels instead.

3. Omit extra initialisations (for the variables =E2=80=9Cdecomp_strm=E2=
=80=9D and =E2=80=9Cerr=E2=80=9D)
   which became unnecessary with this refactoring.


This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/squashfs/decompressor_multi.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/squashfs/decompressor_multi.c b/fs/squashfs/decompressor_m=
ulti.c
index 416c53eedbd1..0a054ba4c541 100644
=2D-- a/fs/squashfs/decompressor_multi.c
+++ b/fs/squashfs/decompressor_multi.c
@@ -62,12 +62,12 @@ static void *squashfs_decompressor_create(struct squas=
hfs_sb_info *msblk,
 				void *comp_opts)
 {
 	struct squashfs_stream *stream;
-	struct decomp_stream *decomp_strm =3D NULL;
-	int err =3D -ENOMEM;
+	struct decomp_stream *decomp_strm;
+	int err;

 	stream =3D kzalloc(sizeof(*stream), GFP_KERNEL);
 	if (!stream)
-		goto out;
+		return ERR_PTR(-ENOMEM);

 	stream->comp_opts =3D comp_opts;
 	mutex_init(&stream->mutex);
@@ -81,22 +81,25 @@ static void *squashfs_decompressor_create(struct squas=
hfs_sb_info *msblk,
 	 * file system works.
 	 */
 	decomp_strm =3D kmalloc(sizeof(*decomp_strm), GFP_KERNEL);
-	if (!decomp_strm)
-		goto out;
+	if (!decomp_strm) {
+		err =3D -ENOMEM;
+		goto free_stream;
+	}

 	decomp_strm->stream =3D msblk->decompressor->init(msblk,
 						stream->comp_opts);
 	if (IS_ERR(decomp_strm->stream)) {
 		err =3D PTR_ERR(decomp_strm->stream);
-		goto out;
+		goto free_decomp_stream;
 	}

 	list_add(&decomp_strm->list, &stream->strm_list);
 	stream->avail_decomp =3D 1;
 	return stream;

-out:
+free_decomp_stream:
 	kfree(decomp_strm);
+free_stream:
 	kfree(stream);
 	return ERR_PTR(err);
 }
=2D-
2.40.0

