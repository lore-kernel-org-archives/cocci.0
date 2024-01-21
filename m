Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CBFC47422
	for <cocci@archiver.kernel.org>; Sun, 21 Jan 2024 12:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=40KiAZizF12BGn77yM5gz3xPKJe+to74NRYYnmEdrdE=;
  b=VeEiyaCeK+p6JQxq9R7erkhnCM0wwkQeDsxdL8Ml/kEtLRvuzNNmMxki
   IREvRuPCneK2KnxCy9lgwp/6qAYPAC6L6SjsnabyXlPRk4FrbaXoDkWtb
   8LA6M/q13EdqiYwwKwrFYZqgMspvwua9Yls4PdMT/59Kkc5HL7Y6Aj3/X
   U=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.05,209,1701126000"; 
   d="scan'208";a="147780130"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jan 2024 13:03:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 97A3EE0035; Sun, 21 Jan 2024 13:03:09 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 434D5E0035
	for <cocci@sympa.inria.fr>; Sun, 21 Jan 2024 13:03:04 +0100 (CET)
IronPort-SDR: 65ad07f7_IRmfMKsNIhqG8W3E4L9cSCkgHh389Lfeb4Yf92Qw/ghNlIP
 U1q9Cp2WwVx5JLZChMr2fNVzwBxGdbr0IfclqAQ==
X-IPAS-Result: =?us-ascii?q?A0HcAACJB61lhwMP49RaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YI4f1MyBAtIhFORNjCEO4c2h06Ea4QEgxY+DwEDAQ1BAQIEAQEDBIR/AodGA?=
 =?us-ascii?q?h4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXB?=
 =?us-ascii?q?w4QJ4VsDYJcARCBDIEeAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgECAgEjHQEBE?=
 =?us-ascii?q?SYBBAsLGgIfBwICVgYBFAEBgnyCKwEDDiMHs2qBMoEBggoBAQavWR8sIlaBY?=
 =?us-ascii?q?QmBGi4BiBsBhWeDQXonD4FVRIE8C4J4PoRDg1uCRiKBG3+DQ4VPjANUfx0Dg?=
 =?us-ascii?q?QUEXA8bEB43ERAFDg0DCG4dAjE8AwUDBDIKEgwLIQVVA0MGSQsDAhoFAwMEg?=
 =?us-ascii?q?TAFDRoCEBoGDCYDAxJJAhAUAzgDAwYDCjEwVUEMUANoHxgaCTwPDBoCGxsNJ?=
 =?us-ascii?q?yMCLEADERICFgMkFgQ0EQkLJgMqBjcCEgwGBgldJgcPCQQlAwgEAyspAyN0E?=
 =?us-ascii?q?QMECgMUBwsHeIIQgUIDGSsdQAIBC209NQYDCxsGPQKZJYQjsCmURzQHgjSBY?=
 =?us-ascii?q?IFhDJ8vBhMvg26TOQ4GklkuhQWCUBaQOyCoTYF5JIFcMxokgzZPAxkPjiAZH?=
 =?us-ascii?q?4Nzj0dANTsCBwEKAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
 ICnfE3bNzpItd7Zr5J07y38N8+NdnYsY0KBJQ==
IronPort-Data: A9a23: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
 V4pi/QwmNleeE0F8T2Bj7FPgw==
IronPort-HdrOrdr: A9a23:NZj376xCtOsLYoRqW95iKrPw+L1zdoMgy1knxilNoNJuA6mlfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebnN5DNB7foSjjPIceoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:vlohNm9kyDlJvjKageCVv1c0RdAnXSLZ91HNckKbFnswTYKvUXbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AQcJypg+q5YdF1Pq4EczzmZSQf8NUurmrSxwwqIs?=
 =?us-ascii?q?56u7eOyNgJ3Cjpw3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,209,1701126000"; 
   d="scan'208";a="77384028"
X-MGA-submission: =?us-ascii?q?MDEQRkXDRGCf7kw0Avy6xe10h/zrw9IdyDKfgk?=
 =?us-ascii?q?SqnsfolaGYVlvdwf/ZrpV0ahDj/plpgvuvCFbIv6pploc4gawMuWc3Bi?=
 =?us-ascii?q?6k+442O5kqxgXwwkIsRGnfKc67pCpp0hJ8lo5wpNVbLRPoEmUhPMwJPX?=
 =?us-ascii?q?Fz/3osTWBSNANLy4hDfg+qDw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 13:03:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705838582; x=1706443382; i=markus.elfring@web.de;
	bh=kwUryKIJGMlklPd/irqSDeoBQ9mM5+pJPKWXSEABKUc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=GbsndVe+QPud8qouKqCOmpc5o9jcvlbM27Pt/pEnPg0cSl4e9W27UDL4MkBjZjiD
	 52H3aTCx+nQ+ggdJRHvQ+GSIH8tbeMtPfaRa4xMHzFBcySb0dUf2W9bfOxvtzFPZh
	 Z6DiOoULHWRcJwvf849HXqHGr0PTIIjEO6ydhlxpeYulfDSO3zU86ai5mm2X1ZewC
	 c5HcyvLkBFsoCGOP0R74XKyIMGiYSnmPwhLzcvtnkoCbVRqJGpbTipYVyNXS6Dov7
	 TdELnPy5eZJhiKATsrJqs/GK3kTBXXm7CqWpiVjdxNl6H7+q8TvDq83eOAPkNbewA
	 +hQeCToIilzGgpBXTg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Md6xz-1qsjcU3ToB-00ZtGR; Sun, 21
 Jan 2024 13:03:01 +0100
Message-ID: <ab09b77f-12aa-4bfb-9697-f5585303ba2b@web.de>
Date: Sun, 21 Jan 2024 13:03:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, Li Zhijian <lizhijian@fujitsu.com>,
 cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>
References: <20240119062057.4026888-1-lizhijian@fujitsu.com>
 <alpine.DEB.2.22.394.2401202217550.3267@hadrien>
 <f34231dc-186b-4cb9-889b-b3be9224c5a9@web.de>
 <alpine.DEB.2.22.394.2401211159350.3743@hadrien>
 <161c3be1-011c-4ffd-8646-1b95f1a461eb@web.de>
 <alpine.DEB.2.22.394.2401211220480.3743@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2401211220480.3743@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pZi3PE5cu/zeyrIQl9l5Efx77lgAOcKtVKV5hnzGGloVAQxWxfG
 Uyz8ioUvqz3JgFE3Iecb6jIhNpz079S7AyyiKkaIgK1mDAWQjP6SnxrsJ9SPVf/ftEIJ8qe
 1hBNSbVibf4qNX4IItRavh+dBwt1/sxfedOGkxPYh6U2Zh59awmKDyrg22Pf6mhP9M3654l
 0YtnAwywX68cpCPG8c4tA==
UI-OutboundReport: notjunk:1;M01:P0:DQFPm5rJQ+E=;k6hS/MLcglwIftaJziDYl0EVn2m
 trWyfszRciKtCIY3IVUP14NcNTubg3IEUWFG0KEe5LiL20AfSA7Oi0tHAZg/HfyiBr2ygMP17
 UXqN8JDEk7CK1PzBQoyUNh0zACO5+iTC0TDavOHNnX5wKGO1Adwl1edj/ZEsLp7xIePsan61H
 N0RBBx8jqAAuhCV1dUWg4ueavE1TmarmqazIDcXnbHcSFjVSmQZI0QFD+csFJgMj2tqoIMnKp
 RdFfCg4wATyJYu8kOBd2mmodeKDjgolKLSK4s9p66L/iKj1cOhzB2KglN4icclFyskmW48ysu
 FjjDjVse6Qw/FsBmNDFR2lfUd5f7MG7GyDGCkRsdPTEym/H2OlLigUeFo2IdAr31NaB07zE/d
 z5Ewv82hQ21GPs9+6ZiPuviHgcEArhywSCCOYJpedJaqHg8zjjO0n7Nqt1mRnlUyFb7upBrRt
 iCaBvvWBpMjBu0JGUkSwScKzrFogYMozXHhul0BJjPyQmljgqwzdaSTjQOx9fYRsv4nWQ2zca
 NvUoLCk97cCnDZDD+wjsNyycZeSxwuo6fF+vHb1L5hKt0PeksGOlQH8oa5Vy8OI919mNAmar9
 gnC1GfgKueHJyHzlH2ZymzhY/0Ep6HjF7WFuDrAs+nFmVgFMl8Csxr7S6vJtYYDP6uYJ/50eU
 7jme642UTFG+C+QnQsZa/XN8dqjC5ESOWigdYoh/9h2qDp1Iw6SlNsibeY2jaxJNG6ufPhDC1
 PctNoo0LAb/7LRLPbO8Q9VnkCj0sIqvUXj0qWudHeWyJVRMD6Fd6pDBmHzBMe0kTTMy6/7vor
 JBVzyO0PzR7HVz8NorpRRbUWpZvc9gUVfkkKQpDNVq/6fOnPpf8gBcUIRmDv4iDoDur4FPd3s
 mxYWVSMcgqHPA72ZL9wZAqyZBYoR758m4/vZ8+A+uiNzwgmaKu6LkdyK7IZzu7ZRAJ9Sus8Fm
 nDko6Q==
Subject: Re: [cocci] [v2] coccinelle: device_attr_show: Adapt to the latest
 Documentation/filesystems/sysfs.rst
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1464
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/ab09b77f-12aa-4bfb-9697-f5585303ba2b%40web.de>

>>>> -snprintf
>>>> +sysfs_emit
>>>>          (BUF,
>>>> -         SZ,
>>>>           FORMAT,
>>>>           ...
>>>>          );
>>>
>>> It's ok too.
>>
>> Are you going to integrate such a transformation approach?
>
> No.

This is a pity.


> I already pushed the commit for Linux v6.8,

I hope then that the change acceptance for the =E2=80=9Cbeautification=E2=
=80=9D
and refinement of SmPL code can grow for subsequent versions.



> and I don't think the change has any practical impact.

I got an other development view for further fine-tuning possibilities.

Regards,
Markus
