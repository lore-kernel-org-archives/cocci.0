Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F96D2ECF7
	for <cocci@archiver.kernel.org>; Tue, 20 Jan 2026 08:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=5qjlawWZvfjsgjj/soaY35D5p4b1pLvvvzm4Vb2i+qk=;
  b=hTfG7fs2PMj/ETG+g2X/RTS9WifbUxHr7AZyuNXVM6mGTHOslnX+J9RG
   WZBXbQzIEPKhpvwfjJnMCZr2mrsxW7b85aYz0dw1lqvTgkwNIOtga/2cr
   AnGMXwjcBiAueeGm7Je26FEX/YDhQafDVKv+dQ5MFhlIUaM9htkKVIPrI
   s=;
X-CSE-ConnectionGUID: ixH4L2naSL6/RlEFbUhqYw==
X-CSE-MsgGUID: DDYTE7JMTUO+v51tNxDbgA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.21,240,1763420400"; 
   d="scan'208";a="259391466"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jan 2026 09:47:52 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id AA21283953; Tue, 20 Jan 2026 09:47:52 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id A6238817C9
	for <cocci@sympa.inria.fr>; Tue, 20 Jan 2026 09:47:47 +0100 (CET)
X-CSE-ConnectionGUID: JcEKCbAxQoyDZzezgg8I/w==
X-CSE-MsgGUID: ek8jOEf8Qpam8uMCcqxPRw==
IronPort-SDR: 696f4126_mV/FfmxuyuQdjkqW4mqW3k61jI+u4OxUmxjXaAeSr3AcAUP
 gI9VlbJ4paLMZJELGepCa8sWbVJ3n09pANwGXSw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FvBACAQG9pgwsR49RaHgEBCxIMQIFFC4JBaCVZMwQLS?=
 =?us-ascii?q?YRYj1OCJIQ7hzyHVYpOgX0CDwEDAQ1OAQIEAQEDBDiESAKMeQIeBwEEMgcOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQE6Bw47hk8Ng?=
 =?us-ascii?q?mIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMEGQEBESYBBAsLGgImAgJWB?=
 =?us-ascii?q?hUBAYJ+giMBBhABAw8nB68+fzOBAYIMAQEG2mMfLCJZgWcJgR8uhW6CZQGKZ?=
 =?us-ascii?q?ycPgVVEgTyCUjE+hEODW4JpgiaBDpQOUngcA1ksAVUTFwsHBYEjQwOBBiMPP?=
 =?us-ascii?q?AUtHYEjIR0XEx9YGwcFEyNsBhsGHBICAwECAjpTDIF1AgIEghN7ggEPhxGBA?=
 =?us-ascii?q?AUubxoOIgJBUgIBC209NwkLGwQ9kAlHgTKEfsYyNAeCOIFngWQMn20GEy+XU?=
 =?us-ascii?q?g4GkwUemGipQYFvAzCBXDMaJIM2TwMZD44hGSWDdcdZQjU8AgcBCgEBAwmFR?=
 =?us-ascii?q?gEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 x4P3K++MokZcIH2iRQKVw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:o3Mgj6mEC55o61k6nZ6wSloFDNrpDfL43DAbv31ZSRFFG/FwWf
 re+cjzpiWE7wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQiVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:eUduZWDH9ZDxy2H6Ewts2W0/EOk1S3rM4EXCLl23BjZID6LAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AH67vwg+ZjMQ2aVNKTa0s7pmQf8prs6aJJU5dqI0?=
 =?us-ascii?q?PvpmZEAd7IieltiviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,240,1763420400"; 
   d="scan'208";a="259391430"
X-MGA-submission: =?us-ascii?q?MDEGH5VW5lQxHeN3By0Bvx4ohqEgpbPa57lga0?=
 =?us-ascii?q?2Pu6X04kvyZ0tR+Ok9QlUH1WNGbPeUtyZsyKqv9VnLGWnyFL7/CpRbWp?=
 =?us-ascii?q?E6ft3RRNPY+pV2e+Izt8mii4tg9iT9EEimj/pyafCjZI2FFJg80WWpqT?=
 =?us-ascii?q?+bJOCXqjmKraJTPthjzFfZ6g=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 09:47:34 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.179]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MumJF-1vyxl81Q9r-017QpX; Tue, 20
 Jan 2026 09:47:33 +0100
Message-ID: <ba44f42c-202e-4fc2-b906-ff06f0aca80a@web.de>
Date: Tue, 20 Jan 2026 09:47:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <e12b2a95-f1e6-4f8b-ab62-151c9789e798@web.de>
 <3857229-a98-854f-225f-5a63ca19cb7d@inria.fr>
 <15bca19e-5a87-4efd-8da7-c6ea2cad27f1@web.de>
 <ca324487-4858-9054-14e8-dbeabae9728a@inria.fr>
 <78df0ed3-2bb4-438a-bba5-c858dd20c1f1@web.de>
 <2e04b3-525f-c970-4d51-ae20a9cd7a2@inria.fr>
 <3eb7e985-02b5-4be3-9414-78d7e155bf84@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <3eb7e985-02b5-4be3-9414-78d7e155bf84@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z+eS8Jm9nGY2WRw19GOWCqeHFExHYjighLGExVuPekItog9PXZB
 n65LG4II3A8OLdA8/czyA7JCdRA91SZWJ+T3yyTerGFeB0W9cY7g0OLeLs02AmNPolwY4r4
 WPsA0AVmiNebUvDzs7zjkwnfrw6kf7Ke2QEvd7AmDoJFeO4P7MbjMyzmICTbEYEFQM6PQ0V
 Q+NNwSouSyZKO48lRV6aw==
UI-OutboundReport: notjunk:1;M01:P0:L4Q0mRJ4IfM=;TOfJzoZMFOY9Ow3BNbwgaDq3ORW
 6mRzLP6z0sMnpd//qfSE+Nvw3o+mCD9Wyx8wOnWU6BYmYRHSuHigRrZuwo+3JCT8Ht25oG9bI
 ceFN1m3E4bNpcFaVyc5r31i8NK4co9edx3X95jQRxVgYoB6Qt8orPmAUOL2T0+6olig6uG1M4
 lwi1C2fmQEvtokGf/UH/kI3pqRLv0ETP56/DuCjli3DDK9F5kMklWldcEXarcf+Ci03NZuF2v
 2K3/EYdEAKdDHJiuKI07iq//WPztOJyZbJdv/WuQc65I3N4+yexWnVRIVjUAz0CmOr9AabCMt
 EmmwEydBJefjoKlbRbjBi0gIVnM176NzXdL4xnTGrVF45JXF83P2ttYhUUj41s/ev4xTCgmKy
 IINjQQpPtmt6OKpG8IFTB1S0XD7sT0Xhk/TiXzc9QDD8FMlGgkZATF4fTGrj2/CXReOcmVeP1
 QF45ztpB9uujpUDZbON2/t1nLjlB6P3+lhnFvrH36QnKKUGb/SIiDgIXVxXhlFKujJirt3fa1
 8P1/lFSUtsMCUbZg1cfAmH7ESnaS2N3tLEtwfp+Osu5m2fJDi+ZdXX0LktA51cBlTRBIH1Wqw
 ATM0NIYVELZqSZU7AZ6FX946/D/OAoeMM4NyEPGtro+ISeucygHgtMt+7Fr8V7gkcCdh/2BzV
 RIR/JGAnwWHZmeajVllysYP4dNlOy2K4WinCIjlUQu9QkUDMPJQ7chi6z7pji1hvux91xSBMm
 A8u7aMt5z2PYt9rbf1zrw5f/CW4IspLsVvp4FNoW/g082PLKqyoHvy4tg9boZNHwPCbq5yTi1
 MR8TV1xcqdccVLP/UpSdkXk+EP4aNejMfdZ5gyUa8hf0WeZxKS0fOwPmtqgotLlJmaLe3nD4b
 4MW/xPcRZD2faHrKZ0c/wrmka/MJsTgnnx746cC6kaafaKJYpoQWYtey0hspVDcRJk9HPJmBl
 8nr+d//qpR/2brH8w4SgnaK7DgMRtpss+9EOcJZ1i9KNdX3Sg46jHhQJ2SASGWSHl++eABHJG
 V9dXFvyl0wrTeLbS8IDWoKodb7j4RYYNVd5AJbr1KPZeyEhIbJax6eJ3oHiFhEdmoSs9mHSfo
 8CFPulT/FDmme7aboJlbfQxnEUIuQcCsdelbgjeuqyRcnbuNnc2Es0EsGfpO1Vbbmu0BSZt0J
 d7eW1rWtELZIVfI4FlvJwZn5nT9DVgJ+D1MIpmQzsg9p/zbfWAzTKmFCYImukawjGh4jFsVgN
 kxhy2k+JPvrqOOv78mI7V1n+ts5uZK9o/nmnJWkvO1JpUmVmSzOREDrMYXbkwIrBlvjPX4WjY
 K/e9n4GEnT1paE5jh2zLwykIHWhh4oDlDmus9LN/WWgAPb6EiIrjYa5nLyTPKZZopjDoSHGw5
 nrAuB8vbKnq/G725ALQu0cmxqdjpC234mYUew2sgcuXrjs4y5nP/VT95HTmL58kxH9Xq0RsXS
 HOxU4jqpGrkVHi1j+JDT0FTM3oJ1w4pJbCfmtWVmnp2E52YRuxvfm9ho0U31pqfWQaZ7eyJ2J
 y7ftvy0omFq4k2jWSm6/PNDyxRRDHC/h1eRJsLnBD0Ue7iyoKu3cA/2IcKJw5LfcdRF93JFUM
 y/9C+5QVs8Rr3kdME4Tupylv8QnQOTJZJJIac4o1izfihG6AILyKpX3HJCx201LBOyXtjvu9t
 phVTtp/tgQCyhn88bmxnt0Fmppsw6gwxxWvhuDk9LcRdlOBbAKe+PSt+xJLdKROEzIcUlsha8
 FeEtWx0PAsIn0AWXJ8BJ0EWeeKR5dHWHoF1kseAQgWgx3r827KwC+sRrdLALnl+3U3/6e1PO4
 MIvpM4MduftSbBOy07ZdDkuYxMJE+k5uSKPC8AkhHx8Z7KRQCoihmrTEyLADqk/ehyV0UWptS
 Gu9trA0u+F2M4al6mFGxlSRi/ra2y+AygVS/DYlK4ENv38dJ1u9E/YX8PpkBAhrPVOP6fdKnX
 pUdFJ/SN3UD0enbxGjHEzNkV79huUZWrveIho+3kCFjqA5N2hYozoSuBVK638wO1n4XzDFeBA
 dpIdLNo9bJSNaXLh0ivEMvUdziNKsLJefmFs8OcnXZRg10tsn5Os14k73Ku/fYhcjZiT7D6ia
 6ZoYrURFdyg9cng6lQ4HQ1g0nQU6BarmVdHTg+0Vo9VHFXgDU8R0T36gda3x+WqeVhcseKYF8
 E+qSgnmrLgwhsXMTt3KuSA4LZI8js4LvQ8isEaJSvpqqkMH+xZy0uuTgE38X+l9XgR+idLeEw
 R5jb8ZqOtf7/ZgB04uv12nEVW8g7l7MrCIj07vM1B0DpwyGAQTaE3tcq8rNNukYaRprU7xTTW
 m+rolNUh4COtcVUtqS9NjQI43xaBgqkO2AolUWX2U9dkzUzHLHE/6lULdeVDZ/dOwmeBhFuNI
 XQsB3iHCrtSO1c0rAEqXpkvGGJ+Oo8ULsb02XfcQVaDIO7KmaltcytroPUBP44g65aY2QiU4L
 eRFskkfW80LUgvLfs4BpNgEFBr3G2v6+INyPZbeUGhU5fdFH+WNiaiyT10eVuVJYL/m7msJ1A
 Kgjq2eyaPkHCGQbToW/AXKnMPpt+qhnIKjPsRMAx9cJBFyQpJ5Ewfwb3MwEKk3H0tqhyHmEho
 Fo4GGkqQKJRDEBo4y+hzHPIZioiYzjYLE6QLIUq6GxReQ7AA8d/BQIY2a+fVYVK8Nz1GZFbDp
 ov3CW2QofWzyd7MSbv77cZDvcTKXcuHiEGws2kWUfpG2Z5ZjjRu823JO+quLGTvNws1EMW45P
 nrHUyv1nAwAD2v1+5D1gwreSYQwYJPrGlnGce3Dyx/YEtnFFDfgtr2LFcA8N+X97+OVtQ3mQo
 1Uxg3O7PcZiAvrO1xRz6i304BLbJvk2GZ7BeLuwU/6VboBzOzEJRFchksQnViFJ2V1uadyQuY
 3mIsc9hMhrIyhcd/bqZPBUefJTc15J+uFcwo0NvZ4Cul63tceTaUUL3zTDVsSUz9rjKFPx6Ll
 hGgQ83+8HztFQ7iYjrpH0MtHUmoQ+jc9CuCkHBEibPTGqDd/QBF3KX8agB7dUj9FbgjGO5Err
 uy0Cd3XG7JNhUT6AdSWpo+k+kRKK1HZV3A9bWbgBVEPrwosSI027YA+KJwXJkQTHlbS0u6MO9
 0kSc6AygJV2nstYDsTUPfkMW7CwTqsQTwZCQDAYs1CMT8F/jC0eQjRlgPj2eRH3CItsC0M+Gw
 Apz0jq6I3EAgChkWGzGPEb4KJzaX/TZqhErDuR4ilwpNbWOBmIcRRpZOGsJO9tKlOXHvafSz9
 khrXI+wMHQmqkeO+dEu4pVAoAa0sUh7zXq2GWvoDg3N0hi6xk3Y221bG4ZxXCgapvEEs/QvpN
 AV0eKhjKdhYG95K/gbdZbXUtQ7lZqOuxY8WcQ6SxWBIlPXxhEyVAMBqITDbMZRZZBJ+vIqWyH
 rX5riEPTUeS8+KTY/HU+Hiho3Dpakwq9nuDgYrc3KzNb0Wo2+4QS8V4Ww/r/gsqYZg1FhMV5o
 n8LDxyvHGwJaDcOXlie3a4h7SaME4RiF473/KrGUGIJjkqaonS1KA5ahnxTqxQvPQIoWGH6y3
 Iu9jgiPaTE+Sma7tpcE6bs5DW5NpctXEghfomSWrzrNqRa12YbzujvdWhYAypS4bpHkbOtSqU
 9vb9ynbdgr2FLdXcV6WtQLGaSbsfH6carPLfGaVu9vrrGx5sNZupaEBBZu2JdERNpiJ0svwdp
 tdU8f0oP3605BnGXBDhb080OJn2obbFwscphlKnxtNGOd6VU7XqOKUmmcRJ+CVEPgHqACRUMo
 6C2/FS0c8N9AexJC5Hgh6fLixWzeV62gGDvSVG+decZLE9s3juOmVkYLREDgqnDu/tewPw9y5
 WVd0C3vndNIxRcwE7FVbOYlzjNkEegf6x3Vtj+rxo5g2WAcmTk3RQWdFBe8GZAelgCF8E6zSr
 3Eqz+nhXpOUX0jvGW/Y3BhQViQDb1dyjn2M5QwkjYpudlVTBFY2LGhM6AewVAevVPxZ+Cp52f
 4XXNvieeAegPhM9+JasXAhQPY/1izvniXKOSpMsqXcoKzCHbpW55Usi4/3DxA3BAIM6ZtWYiy
 iCIAQJfV2mNP9PZxAgw7jLog97qYkfEUloeJdlXKEDPrUIRCLoL6a7oLsGVq3lOB+gYyEzOKg
 NATYiE9rLsgwFBfLCzc0AYatm7Klu13te8cSnM6yFAAvrRWZH0nu6tOOeAtMvqDGuwALaxUsM
 uYq1zdhJNQqDIfIG1uwDIzZfNLmtDtzgRnd8jwIQPTy/+v0T1fkfoxTV2rkQR3i5fimmPwnKL
 axATMTwNCH+dqk7kd5+zHlIFQeCfk8JKjPhRJJ/RmtyEnLYCchCn7iMf3NTncSUInLSqB8UNv
 S5bfQTNH71/si3lKlvZaeppelmCA4mpAnmbuZ2ZtgcdJiV7Z6Wx5fPgmC87ro/YlkRyJh2FRj
 39qog0sMx8OYQTpzQEsvSU+7lyAuBNdA+d8m6CS+fhZXTXq8DlgmvFFOSLuh7tCuh7oTrDs0h
 1V9n7G/GgAQ/FLAWODlNkjIGzcxfQPQFYVOlYiG445LEK8wdPg8KzK2c8J6Rg2NYBpIbba+BK
 DNJ05PVvhbxWZ63o2m3XYS0TBL6BqPWGIafMd0MuosoOIB03ufrk90yYIg3A5PWHTx4prPcOT
 ElIL2/ZDVuxPSuaCREiwl0nojVE9lH2aE2P9uclq4WDldhaATgyOymx6Ml4KyodorSfRMNvBx
 p17n/Tp1ZGIv8WcuBgn1xIFDWGnWpFvBp9p8lOQZ8M8XhMxoAOnnjl1oocb/bonBZIZchH43o
 z2UJEUxPhd9yRLsoXb0r0ZdT/Mu34eqyrDivY0yDFBL94ZUzVFTdWV9TPkaELzbepOJTNBueO
 lqZTLs+1gzKUUGWDdKjZd0CHxSwBgs2pRsve9jSGk8JheNgNFXMl1boac+72v537wvk7wj8um
 OPzpcCw9xWgTXIr29ewtJeeFS9zj2IJZNsyM9TMFzNPQjQDV2xROaqyRZCnbgfMEB2qMndiSE
 sX5F1oAYybfODxymlUaixaRYhUMDcPAvZ7X95+UfKEZwgBFxWXJy+ni3hyQ6oFxUwRHKgOgA7
 J2qlAKOsPrT87R/s3cRgHMp4FKscyMR4W8vY6I6kvXfABGO69muSWvpWfBXVGgV4hxiz/nHGP
 Q/ogTXvlGPb27zOH+kkNwq0qcBZFHqqGIwOn40I1hwiF5o9+Jw9oGTV46e+jVRwsCi660fMD3
 H+mBuwZ0kVwIO7TZGTihMZlToxxfGe8Zdx/Zh5it7eM7wvzJx+7KN109CIETFvLTOyMgg/cBa
 IalB4rkDdaZ/QhalUPDBksLuwrFKo7xgk32N++PIdA==
Subject: Re: [cocci] Checking data structure member accesses after function
 return value assignments?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3279
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/vAoNFUOd6LIN4S_iJJB15w>

> I can try another SmPL script example out:

@display_without_extra_semicolon@
expression action;
expression * pointer;
identifier member;
@@
*pointer =3D action(...);
 <+...
*pointer->member
 ...+>


> Do you imagine any further data processing refinements?

Corresponding test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --no-loops =E2=80=A6/Projekte/Coccinelle/janitor/show_questionable=
_statement_combination6.cocci drivers/regulator/fp9931.c
=E2=80=A6
@@ -438,44 +438,21 @@ static int fp9931_probe(struct i2c_clien
=E2=80=A6
-       data =3D devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
-       data->regmap =3D devm_regmap_init_i2c(client, &regmap_config);
-       if (IS_ERR(data->regmap))
=E2=80=A6
@@ -501,7 +478,6 @@ static int fp9931_probe(struct i2c_clien
=20
        config.driver_data =3D data;
        config.dev =3D &client->dev;
-       config.regmap =3D data->regmap;
=20
        for (i =3D 0; i < ARRAY_SIZE(regulators); i++) {
                rdev =3D devm_regulator_register(&client->dev, &regulators=
[i],

real    0m1,057s
user    0m1,008s
sys     0m0,026s


Regards,
Markus
