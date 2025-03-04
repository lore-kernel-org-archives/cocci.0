Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152D3C021B8
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 13:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=UMMNbqmprEUf/HLWOjYQYKCqdN+GILAnTDEYyfL3pew=;
  b=IOOWKwEXwySlzGWJvWntb36FEPkRtVq0O/lffYV4lVIuK706SMrIV3/s
   +crMLEammBa2AaswFP7FBlEmfg3GVhsX7Lfiz6g28/EnZXDcp46iCbF+q
   IDOgJiiFGAbhiMeeiyurkCW54Hw0c2THo1yaQdiGX1PjL5rv/apSEvfOB
   c=;
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
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211118763"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 14:14:30 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 44008E0261; Tue,  4 Mar 2025 14:14:30 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 54635E0260
	for <cocci@sympa.inria.fr>; Tue,  4 Mar 2025 14:14:29 +0100 (CET)
IronPort-SDR: 67c6fcb5_3ZNP+B1L51P721vXI/WqULOCLvYK9nYAqfRbgDKCna5bFwP
 y5b5VeJItyLdtc+4PF02rKP0ggEDihHAyr/H6JA==
X-IPAS-Result: =?us-ascii?q?A0GkAQCJ+8ZngQsR49RaDg8BAQEBCQESAQUFAUCBPwgBC?=
 =?us-ascii?q?wGCQ4FXMwQLSIRWiB2HMoF0LQOEO4c7h1OEb4QGgVaBfg8BAwENQQECBAEBA?=
 =?us-ascii?q?wQ4gVSCdAKLFQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABATsHDgkBMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAgEDIx0BA?=
 =?us-ascii?q?REmAQ8fAQUCJgICVgYBEgIBAYJ+gjABAzEHryCBMoEBggwBAQaCaddzHywiV?=
 =?us-ascii?q?4FlCYEaLgGFa4JjAYVrO4Q8Jw+BVUSBPAuDNogegmmCM4Fqgz2oXIFNHANZL?=
 =?us-ascii?q?AFVExcLBwWBOTgDIAo0FAQZAhQcAQ8GEARqQzeCRWlJOgINAjWCHiRYgitqB?=
 =?us-ascii?q?AWDW4Q9hECCQVGCQoIRcYEXgjGFUIEthAhkHUACAQttPTcGAwsbBj2hcjqDT?=
 =?us-ascii?q?nMBUjtMJoIExhI0B4I4gWaBYwyfXgYQAy+XRQ4GknwBLodlkGoiqQ+BZzqBX?=
 =?us-ascii?q?DMaJIM2TwMZD44hhC2PAblAQjU8AgcBCgEBAwmFRgEBilSBSwEB?=
IronPort-PHdr: A9a23:xyH0EB+TtNahjf9uWf62ngc9DxPPW53KNwIYoqAql6hJOvz6uci5Z
 gqHvb401AWQBM3y0LFttan/i+PaZSQ4+5GPsXQPItRndiQuroEopTEmG9OPEkbhLfTnPGQQF
 cVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZvJuTyB4Xek9m72/q99pDdfQlEniaxba99I
 BmrsQndqNQajZZ/Iast1xXFpWdFdOtRyW50P1yfmAry6Nmt95B56SRQvPwh989EUarkeqkzU
 KJVAjc7PW0r/cPnrRbMQxeB6XsaSWUWjwFHAxPZ4xHgX5f+qTX1u+xg0ySHJ8L2TLQ0WTO/7
 6d3TRLjlSkKOyIl/GzRl8d9l7xQrg6/qBNjwo7UeICVO+R4fqPBZtMRWG5NUt9MWyBdHo+wa
 o0CBPcDM+lFtYnwv1gAoxWxCgaiGe3hyiFGi2H43aI4z+svHhrL3BA5H98UrHjYsMv5OaUUX
 OuozKfI1zLDb/ZO1Dn68ofIaBMhoeyXXbltfsTRzUcvFxnEjlWWpozuIjSY2OMXvGiB7OpgS
 Pmvh3QopQF1rDiv3MYsio/Gho8OxFHL6z52zJwoKtKmUUN2Z8OvH5RMuS+ALYR2Xt8iTH9yu
 CY80rALt522cSwWxZkjyRDRa/iKfoqK7x//W+icPDR1iG5rdr+hhhu8/0qtx/PyW8S6zVpHq
 iRLn9fNu30T1BHe9NaKR/1g9UmiwTaCzx7f5vxaLUwui6bXNZwszqQtmpcRq0jPAzL6lF3yg
 aKZbEkp9PWk5/7lb7n6vJORNoB5hwfjOakwnsy/HP84MhQQUGiB5Oq81bzi8lPhTblWiPA9j
 7PXv4rAJcsBo660Gw9V3Zgn6xa4Fzqm1dMYnWQbLF5fdhOIkZPmN0vTL//mFfu/glKsnyl3x
 /3eILHtH4vBImLdnLv/f7tx8VNQxQgpwdxC+p5YErQBL+jyWk/1utzYFBg5MwmszujgEtp9z
 IAeWX+UAqODP63StVGI5vguI+mKa48Yozj8JOY+6PL0kHA2h0cRfa+y0pQPcnC3AuxmI1mFY
 XrrmtoNDH8GvhAiQ+zylF2CTTlTam6uUKI7+j40FIOmAJzYRoGthbyBxD20EodXZmBAEFCME
 G3ne5+KW/cWO2quJZpinyYCWLzkSYYn1A2prhTS1bVqNKzX9zceuJal08J6o6XXlBcv5Xl5H
 9jB+3+CQnsynW4SQTIymqdlrgg141GPy6VxmLR0FNhc6ukBBg42NJrTwvY8CN3oXA/FVtuIT
 FmrWJOtCGd1Bvk42dsJeA5YEtSlihHF2GL+CLoclruPBZoz2rjR03j4O4B2zHOQkOEMlVgtC
 uFOOmKrnLU3owXZBoHGnl+Cv6mtcqsY0WjG82LViSKyvExfXAlqXO35Rj8YLh/KvMji4WvHT
 qPoBLg6ZFhv08mHf45DcN70lh1rQPn5OdLRKzaUkn2zGA3O67eCdovsdE0C0S+bBEVSwFNbx
 mqPKQVrXnTpmGnZFjE7UAu3OysEkMF7oXK/FAovyh2SKldm3Pyz8wIUgvqVT7US2KgFsWEvs
 WY8B06zivTRDdfIvA99ZONEe9poxV5d1n/C8SF5MIahKa9KmVMUNQh67Av1zxsiMoxbioAxq
 W8yig97KKaWylREIhaRx5PtIfv6Lmfo/RagQ7Hb0BfS3YXe4b8BvdI/rVirpwS1Dgwi/nFgh
 sFSyGeZ747WARA6VJXsTgAo+hI8q7yyjjAVwYTS2DUsNKC1tmWHwNc1HK4/zR3med5DMaSCH
 Qu0EssABsHoJvZ4016uJgkJOuxf7stWd4uvaueG1ai3Pe1hgCPujGJJ55p4216N8Cw0Q/DB3
 pIMyfWVlgWdUDK0gFCku8Hx0YdKAFNaVk+20yv5H8h8YqNofIAEIXijKYu7y5Q2hpLgXWJZ6
 E/2H0kPi4eifRufaUC43BUFjx1N5yb9xm3hkHotymJMzOLXxiHFzuX8eQBSP2dKQDMnllLwO
 c2uiNtcWkG0bg8vnR/j5EDgxqEdqr4sSgubCUpOYSXyKHlvF6Wqsb/XKetG8pA1qmN6VOqmY
 FaVYqHwqV0W3mmwegkWjCB+bDystpjjylZfgXieMW01gX7XY8B2yj/A6daaSfMbjV9kDGFoz
 DLQAFa7Jdyg+96ZwozCvu6JXGWkTpRPcCPvwOtsrQOD7HZxSV26lvG3wJj8FBQilDX83J9sX
 DnJqxD1Zs/q0b67OKRpZBsgCFj54st8UoZw9+l4zLQZw3sHndO4+XQdkGH8GcpW0+TyYTIBS
 CUKzNjc/AX+kBc6dDTTnd2/Dyrbm5IpbsLyem4M3yMh881GbcXcpKdJmyd4uBvwrA7cZ+R8g
 iZIzPIv7HAAhORa8AEpzyibHvUTBRwCZHaqzU7XqYnh6vwONwPNOfCq2UFznM6sFuSHqwBYA
 jPif4s6WDV35YN5OU7N13v67sflfsPRZJQdrE7x8V+Igu5LJZY2jvdPizBgPDe3mHQ/yPMgy
 zFq04u7uoevNGhnuq60SE09VHW9d4YI9zfhgLwL1OOfxYOyBdNMHjsRXZ3nZe2lGnQeuL60U
 mTGWC15oXCdF73FGAaZ40oztHPDHaegMHSPLWUYx9FvF1GNYVZSiwcOUHAmj4Y0Q0q0kdf5f
 h4ztVVzrhbo7wFBweVyO1zjX3fD8U22PywsRsHXJUhT6RxeoVjYO4qS46p6TSRf44HkvAKKM
 HOSfQgOEmwDHECJYjKrdrD84N7d762SAfe4JPaIfriE7+BTH/7awJWyzs5t5DyRMsbJZ3BkA
 6R90U1GOBIxU82LnjISV2kcjCnKddbd/R669nQxpce6uOLiXAaljWeWI51VN9gnuxW/gKPZc
 vWVmD48MzFTkJUF2X7PzrEbml8UkSBnMTe3Q/wGsmbWQaTcl7UybVZTYj5vNMZO86M33xVcc
 c/dhNTv07dkj/kzQ15bXF3lk8utaIQEOWa4fF/AAU+KMvyBK1ipi4nvZrigTLRLkOhOnxi3p
 CrdDELpeDiO1nHoWx2pLeBQnXSbMRhZ6+TfOl5mDWnuSs6jawXuaoYty2dsnvtt2TWTbD15U
 3A0aU5Go7yO4DkNh/x+HzYE9X95NayenC3f6eDEK5EQuP8tAyJulusc7m5prtkdpCxCWvFxn
 zPf69B0pFTz2MyG0Dl6S1xjrjhRhYSElVpvM+PV+9MTPBSMtAJI9miWBxkQ8pF9DcbzvqlL1
 tXVvKf0NSsE7N/eu8cRTZuxSorPID8qNhznHyTRBQ0OQGuwNG3RsEdalemb6nyfqpVSQn3Eh
 5cEDLNWBgRd/hIyD0N4AJodLZ0xUj52ydZzY+YX6HD4oBSDHa1n
IronPort-Data: A9a23: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
 abZiIyErIyGpZbNLPtd
IronPort-HdrOrdr: A9a23:lvvOnqm+ZcAQWIgUqtPnXaNdsETpDfL43DAbv31ZSRFFG/FwWf
 re+cjzpiWE7wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQiVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3AA6G0CGmgabiLc1noW02xUOG4Px7XOVeMzGvuPnG?=
 =?us-ascii?q?nMzpoSLnNbAeq/YlbjPM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ASqSgwQ3o2X8J5TUXJxTuiMtx0jUjv/WHIWtXm7o?=
 =?us-ascii?q?66oqPE3JqIRCPsiaVXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211118757"
X-MGA-submission: =?us-ascii?q?MDF74XR4yJbjC5SDEKEkNx4vrhZ9/Nl7TfMbPY?=
 =?us-ascii?q?2aVbz3LRkS1wW4N75A+BZ6al3fUt9KAyj1Sv/AlPLJ+XtgUbNrE8BtDO?=
 =?us-ascii?q?7W3eQGolu+j3JyBI0TX04Oz17J5Rgs95UaUKavQDibdvTkH3hCWQSk+D?=
 =?us-ascii?q?HyBP9FLm6q3iPLz4nykp//+g=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 14:14:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741094064; x=1741698864; i=markus.elfring@web.de;
	bh=UMMNbqmprEUf/HLWOjYQYKCqdN+GILAnTDEYyfL3pew=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=k4iS6DZQ8/M15TRZ65pVu59nIeVatpdt31uGFspHEieqUYXIl0Z+N7FHmFPZhyDZ
	 V/QiTDVCKKX4WzY28rlTn9RyjanmosZgh3nY1VpW5Mm8iWO+xqmTODtmP1tlgkMgf
	 xAKlPeP2LRUVfR8csxkKx2TQJFjAEQ9OukbxLAEeaYzo/rwyN6oC4noSyCvuAVXOp
	 kkNtMsqrHUB5UJ5KgfisFh3dOeZSV2QiSYX71CtTzBWlxfgpMj6UndWvOGLjMsj6V
	 AQoXeQl78DbqGRUrAIeYf7Rsd41SiLzHRtWmoWCujtFjFwlFj8nK4vZghKk6DG8J5
	 8oSTRSbYfUiTbp5nqA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.64]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7QUJ-1tCxYw3epR-016ZhD; Tue, 04
 Mar 2025 14:14:23 +0100
Message-ID: <81165091-3dcf-4693-8e8f-658cb95dbbb7@web.de>
Date: Tue, 4 Mar 2025 14:14:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-ext4@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Carlos Maiolino <cmaiolino@redhat.com>, Eric Biggers <ebiggers@google.com>,
 Theodore Ts'o <tytso@mit.edu>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <7214c986-4d0e-ad78-6312-c84515dc9abf@web.de>
Content-Language: en-GB
In-Reply-To: <7214c986-4d0e-ad78-6312-c84515dc9abf@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E5kv+niPk+2Rgm08pXEtLMbHHQnvn5ILOYRpqiTaXLnnlYAhqjj
 GBoPmLWu+eHxJk3tVh6KBsVIEcJb86QMkysVG5p8vK6giss/7dfoAK+WczhPNmgWmWiSVDM
 vl2X3J8+Z0wTg11ycHOmqNpJr6xc/HUI6a8/9wMHc8vLPbaEK5GYzEIDw5K1SNeYFWRTdFi
 awo7grstEiuQ+av0enmWw==
UI-OutboundReport: notjunk:1;M01:P0:cWF7ctUm6do=;l9kjC10cYUQOgJH5/7DPwXKZZg+
 e8kTUx40Y9u2VbSiu+UG5ma2q5LPl8u7igzHcRvoTshP5VnUN7djIRGF1JLZT/ojGIlwY4V7J
 OlbGfZkFpDqcoAkfLoXZaun1IcyOcPCzK19ap4AVQwzweGyGRHopTMuPwhtptJz8mRPuQ6FYv
 3UFryxssmNvrrn7A131YPnpJZbngY8C1ITn8fgH65OjidoYUNNqLD6eezHYWX6edtHFT7HbpN
 YkQJk2fsmsPiBUM9Q7kvlh4oCdup3+JCucnHGRMGmfJMCbf15LL4yU5ZBrzGrmDXVvg/0XABf
 WhfaCm782WzcrfmJPRUy6NI3K+wH732abRxIrcLMf69DVx/uy4TRcmLsyEnWXGjStRIOmeT2z
 cekaMJZ1qqyfbR6X5rTj9kDK2cLpZSc2r6GgBGR7fLc4DNH+ZcXeUW8kSeOkCTxovDrCJecQm
 WqcFYDrHUDBZhv9FZsbQI66k57bdrK6kzQCKMmirmRfHy1LWVdT9ynZEMbAsgKV8OsXiZX4Hy
 dXhkowFSbxJo9mQu7+zjBYCAwtj71pgEuLAi7WYSQ7sMgsAvBZrjoUzNrFiZ5ReiibepO4zF0
 uAq/i60lNCGIs6XO5ZCNznigyEhnraeRIcmvkGKJ5uczQCQnO829OjlzaCg6AE7Pz0uOj1TuG
 kLJ7a+HHwxg2iMBrQdbfrnCcTe0g9iSXU3z4XaiybAZV44s8+hHBaCwBC0sb9Afx+D27RphUO
 c0Sk7dOaxwAMdOTlVTxAgz8yixSpdtdArrHjIMz0xGr3DaRK6PnsB7+EXzlGoRqd4QAcYVbwq
 mFZCtO5G0N3/pSuxLkVHmYeh0tuN3zWdb1UHbD/8shKZveRtY5nAOi36DIqS4fq6ruvMaY3ya
 bb4cO3fYPnUI/gQlfPA6c4sdTkLxfmm7nLO5Vprq3920h1jFG7t8W7wpEzOB3fxMx25DIs4dr
 h9VtweZHStOcKMQhX5MUpW6LCPHM8sWIiubV4vsKSB8d7TzM01jk0I9RyH3Hhg1gpO9UZFSQI
 7JCEUG8PjxbfttGNA3ZVURansxspTuIL/TisdTncVM80XHCyFENEdUhTc6Jt30jFxf102oMAr
 XZ+Bv2g2WJ2aYIrKxa8DZKO+QyVV9vFHx8DI1AM608ZVoPvDF/0atiVArT1j/+tAT06MSxKOu
 5hZ5CGkCC0Zn++2BdiC3yMWCTuGuAq/B3uM8HwUkGy670SLxo/BnJKCp2sKxLIy0836mEMGJ7
 PaoRkSWEafmXOAtSaO/t5d4+16opBwR2VHmxTr8lvtD7VWqvQ1d6gojl8tJbRCmqptdFFJQTQ
 xjiK7rXRK6SZAi06FmtUFWQaYW7VhUXBwnybRDUHcyQUOmEDxxk/rBNhAFb0MYG58KanH+frc
 4IpmMwFV2iv9KcfkRRAjqlEzIXlqJUxX31VUC91JvUZHcZd3gPgvV12qHEUqbHyGycgOJ+JOL
 pvh5s9lJVX/eDKPPi4mko7UWIVIg=
Subject: [cocci] [PATCH RESEND] ext4: Fix exception handling in
 parse_apply_sb_mount_options()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2529
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/81165091-3dcf-4693-8e8f-658cb95dbbb7%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 21 Mar 2023 22:33:06 +0100

The label =E2=80=9Cout_free=E2=80=9D was used to jump to another pointer c=
heck
despite of the detail in the implementation of the function
=E2=80=9Cparse_apply_sb_mount_options=E2=80=9D that it was determined alre=
ady
that a corresponding variable contained a null pointer.

* Thus use an additional label.

* Delete a redundant check.


This issue was detected by using the Coccinelle software.

Fixes: 7edfd85b1ffd ("ext4: Completely separate options parsing and sb set=
up")
Fixes: c069db76ed7b ("ext4: fix memory leak in parse_apply_sb_mount_option=
s()")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/ext4/super.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e6d84c1e34a4..c0bc46956353 100644
=2D-- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2435,7 +2435,7 @@ static int parse_apply_sb_mount_options(struct super=
_block *sb,

 	fc =3D kzalloc(sizeof(struct fs_context), GFP_KERNEL);
 	if (!fc)
-		goto out_free;
+		goto free_mount_opts;

 	s_ctx =3D kzalloc(sizeof(struct ext4_fs_context), GFP_KERNEL);
 	if (!s_ctx)
@@ -2467,10 +2467,9 @@ static int parse_apply_sb_mount_options(struct supe=
r_block *sb,
 	ret =3D 0;

 out_free:
-	if (fc) {
-		ext4_fc_free(fc);
-		kfree(fc);
-	}
+	ext4_fc_free(fc);
+	kfree(fc);
+free_mount_opts:
 	kfree(s_mount_opts);
 	return ret;
 }
=2D-
2.40.0

