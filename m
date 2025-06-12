Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC3CC7114B
	for <cocci@archiver.kernel.org>; Thu, 12 Jun 2025 13:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:message-id:mime-version:
   content-transfer-encoding:to:cc:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=T+1brjTtLxh3V2AXFc9+E8KS4xWSQDx97+f2le9Gc1Y=;
  b=QQdOwOMJO1ESIzZtOtSD2TStbWDlzIGviOZLReuvdGqM74UiWm9f3JCy
   Gqo7icfTUkI0fxyjXscJR4qK+AP/qChb6lIG23dPquQ519JHMsAbPFeRc
   QFyG6XANwagMK8GbpAgftCWxZSAT7ABjO2FPCcgkTUvV9Mb4I1KidpjNR
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@quicinc.com
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="226896211"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2025 15:49:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BFB32E0CEB; Thu, 12 Jun 2025 15:49:27 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 12D7DE0131
	for <cocci@sympa.inria.fr>; Thu, 12 Jun 2025 15:46:33 +0200 (CEST)
IronPort-SDR: 684ada38_4wGPgxuFbu4KpmfYmleRKvcVDjaNBb5y8gAGKUxOcyfbLvk
 msCCfQ/79Oa8DOZhcj/P+4FJgDSfgTh4nnyZs9A==
X-IPAS-Result: =?us-ascii?q?A0EFAABg2Upog4O03M1AGhsBAQEBAQEBAQUBAQESAQEBA?=
 =?us-ascii?q?wMBAQFAgT8GAQEBCwGCQ4EAgQ0EC0kEGYQ4iBxfhlWCIZxEgVWBfQIPAQMBC?=
 =?us-ascii?q?wEBRA0EAQEDBIUAi2kCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQEBATkHDjuFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQIIBV4BA?=
 =?us-ascii?q?SAWER0BATcBLAgCJgJIAhQBDQUigmABgihGAwUMBqMUQ2cqWQGBIEKJEgEBA?=
 =?us-ascii?q?XiBMoEBggwBAQaCaNsgAwaBGy4BiE8BgW2DfzuEPCeCKIZPgwqDQoJpgRKCL?=
 =?us-ascii?q?IFAgmSEK4RHS4JfgXKHR4clCT+BAhwDWSwBVRMNCgsHBV5SMwMgCgsMCxIcF?=
 =?us-ascii?q?QIUHRIPBBYyHYINgi1Pgh2CEnCKGIRJK0+EJQ9tgSaDYRETcg8GR0ADCxgNS?=
 =?us-ascii?q?BEsNwYOGwY9AW4HmAmDbwGBDytQgS1Tlj1JjVNooQ4NhBiMHZYDhASmXS6YV?=
 =?us-ascii?q?iKCNok2gXmVUg2FJwIEAgQFAhiBaDqBXE0jgzcTPAMXAg+OIRmDZ4UTiioBq?=
 =?us-ascii?q?CY2NQIBOQIHCwEBAwmGSIk1LQUugR0BAQ?=
IronPort-PHdr: A9a23:C3xZthzknWTWTJDXCzKAwlBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 xeZvawm1QKTBc2bs6sC17GM9fi4GCQp2tWojjMrSN92a1c9k8IYnggtUoauKHbQC7rUVRE8B
 9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUhrwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9I
 Ri4owjdrNUajZZtJqosyhbFvGdEcPlSyW90OF6fhRnx68mu8JJ57yhcp/ct/NNcXKvneKg1U
 bNXADM6Pm4v48HlqQfNRhaV6HsGVWUWnBtIAwzb4xz/Q5z8rCj0uPdj1SeDJcH5Qqw6Vjqk7
 6dwVR/nkzwHOCIj8GHWkcN/kqRWqw+8qhNlwo7UZIaVNOdifq7YYNgXS3ZNUtpXWidcGY63c
 ZcBAPQdMuZZt4n9pkUBrR2iBQm3GejjziZEimLq0aEm1ugsFxzN0g49ENIUqHnarMj7OqkRX
 ++60KbGwivNYu1R1zf884XIbhIsrOuQUb9qbcbcy08iHB7FgFWKrozlOiuY2OIQs2ic8uFuU
 eOvhHA6oAx2uziv28YshZXRiYIR11DE8id5zZ0sJd2lSU50fd+kEJ1MuC2AK4R2RcYiTnhut
 S0nxbIIpYS1czIWyJQ72RHfcfqHfpCK7x/jSuucISt1iX1kdb+9hBu/7Vasx+/8W8S1zlpHs
 ChIn9rSu30Q2BHf98aKR/998Eqj2TiB1w/e5+VEL00pk6fQNpAvwrk1lpUJsETDGDf7mEbog
 6+McEUr5Oyo5/7gYrX8qZ+QL5N7igbiPasym8yzG/00MgwPX2id+uSx0qDo807hQLhSkPE6j
 qnUvIrEKcgFuqK1GRJZ34U/5xqlEjur3skUkWEaIF5ZYh6KjJTlN0vNLfzkF/uygEygnCp1y
 /3CJLHsDZTAImLHnbrgZ7px9VJQxQwuxt1B45JUF6oBIO7tVU/rqdLYDx44PBKszur7Dth2y
 5kQVniVAqCDNaPfqV+I6fwrI+mLfIIVvTn8J+Q+6PL3kXM1hVEQcbS00psZdHy0A+5qI12BY
 XrshdcBCnsKsRQjQ+DwlFKCVjtTa26zX6I6+D47FJqrAZnfSo2tmrCNwjm3EoFMamxbCV2AD
 W3ke5iKVvsRcC6SJ9Vukj0AVbivUY8h0hSuuRfjy7p6L+rb5jUXtZb+1Nhy5e3ejggy9SF1D
 8uB0mGNSX17knkUSD8x2aBzuUp9xUyb3qhin/NYDcBT5+9OUgoiK5LQ1/Z6BMzqWgLdYteJT
 06rQtG8DjA/VN0xx9sObl18GtWjixDMxDCqDKUPm7yKApw06KPc0GLrK8Zz0XbKzLMhgEU+Q
 stTKW2mgbZy+BTUB4HVj0qZlr2ndb8c3S7I7GeM13CCvEBeUA5qUKXKR2oTZkXMrYex2kSXf
 qK0GPwBNRFG14bWO7ZQe5vvik9BWt/sPd3fZyS6nGLmQV6yz6iJcZGiRWQZ2CjYD0Uf21QX/
 HCbJSAkDzykvnnADThqGFfobliq/eoo7DuZU0s1xkmuZlJo0779rjwIgf2VDdcawbsAvA8gr
 S91FRCzxYSSQ5CmpgFmeKxHKes05FZXnyqNsQ12OZipNOZ6j1ofYyx2ukrhkRttXMEIusE2p
 XcrykJXILiZ1lpaP2eT1Iz5PrzRbGz75hGpYrX+00vblt2R//FLoMs5r1GrkAygHU0kuyF40
 t1R+3iR/JPHCEwVS52nFg4S/gJx74PLZCY86pmcgXhlI4G3vyXE1tZvA/EqnFLoWNNeLq6eX
 DLqD8ocT5ypLO00lkLvcwoYO+Z68K8yItPge/aYjurjHuFtjXqJinlD8cgp0EWB5mxzTfPMz
 r4M2fTe1QyCAXO0t0qzr8P20aMMXTYPGm2kxGCwH5NDe65zO54MFGOpOMCfz897wZXqXigcv
 GyuAVwGxc7hSAfaO03gzwBW2kQKoFSnhCKnwj0ymDYs+PmxxivLlsD/c1IlO2MDEHB/jFzbJ
 ZWzjfgDQUmjbg4i0hCi4BCplOBguK1jIjyLEg9zdC/sIjQnC/Po3lLjS8tG6Zdy9D5STPz5e
 1eRDLj0vxod1SrnWWpY3jEyMT+w6d3ihxIvrmWbIT5oqWbBP9lqzELG+d3XcvpM2TguXTR5g
 jjRDR63ONz6tc6MmcL7u/ulH3mkSoUVdCDqyY2asy7u/HBrCiq7gvexssT6EAM71yS93N5vB
 m3TtBipRI7t2uyhNP5/OEllAFip881hBoR3iZc9nrkVySAQw83NpiMLnz+qd81D2aXlcHcBA
 zUMxrY5+SDD30tuZjKMzoP9DDCGx9d5IsO9aSUQ0z486MZDDOGV6qZFlG17uAjwqwWZevV7k
 joHrJlmoHcHn+EEvhYsxSSBE/gTG0dfJynlixWP6Zi3sqxWYG+ldbX42lB5mJitC7SLowcUX
 3icGN9qBDJx5fJ7LVXO+GTu64rlftKWZtUW91WVnxrGk+lJOccpjPNZ4EgvcWn5vHAj16s6l
 Uk0hcz85tLfbTw9pOTgWUcLU1+9L9ke8Tzsk6tEy8Of3oT1W45kBi1ORpzjC/ShDDMVs/3jc
 QeICjw17HmBSt+9VUeS7llrq3XXHtWlLXaScTMA0NRpcx2AI053mR0VVzQ8ldgyEQXgl6mDO
 A9poysc4FL1sE4G0/9pPC77T2DdjB61azw1TpPZJx1TpFInhQ+dIYmV6eR9GDtd95uqoVmWK
 2CVUA9PCHkARk2OA12L0qCG3dDb6KDYA+O/K6GLerCSsalEUPzOw5uz04xg9jLKN8OVP3AkA
 edpkkZEWHl4HYzelVBtA2QOiiPGWMqGoxWU4zB2pcG5+7LgXwen6YaUCrRUOMli4Fjs2frFb
 bTIwn8pcXABjcpEzGSA0LUF2V8OlyxiElvlWa8NsyLAVuOYm6NaCQIadzImMcJJ66wm2Qwec
 cXfi97zyvt5lqtvUwoDDwa53Jj5PYpTeDjuUTGPTFyGP7mHOzDRlsT+YKfmDKZVkP0RrRq7/
 zCSD07kOD2H0TjvTRGmd+9W30T5dFRTvp+wdhF1BC3tVtXjP1eiLd58ujkrxr8cn27LPm8aO
 n53dEYH/djypWtIx+5yHWBM9C8vNPSFkBGd8u7aAo8LsPBqBC8ynOVfqidfqfMd/GRPQ/p7n
 zHXp9hlrgS9k+WB/TFgVQJHtjdBgI/Y9VUnI6jS8YNMHGrV5B9Yp3vFEAwE/pE2b7+n87AV0
 NXEk7j/bStP486Bt9VJHNDacYqGKCZza0K0XmSOVE1cHWbtbDqGzwlUlPXYnpGMhr49rJWk2
 J8HS7sBEUcwCutfEENuWtoLPJZwWDog17+dls8Bo3Sk/lHXQ41Bs5bLW+j3Y72nISuFjbRCe
 xoDwK/pZYUVOIrh3kV+a1581I3UEkvUVNpJr2VvdAgx6ElK9XF/SCU01SeHIku152QPEPevg
 hMsog5uOe5orG+3uls5fgOMvDMwl1ItlNmjijeUMXbwIKq2QYBKGn/0ukw2YfaZC05+aQy/m
 1AhNS+RHeoMyeE6LSYy2Fea4MAWSps+BeVebRQdxO+afaAt2FVY8GC8wFNfoPHCAt1knRcrd
 pilqzRB3RhiZZg7P/+1RuIBw15Oi6aJpiLt2Po2xVpUPlsM+1SWZSkKkFUVN7InISHu9etpo
 1/n+XMLaC0XWvwmr+g/vFs6IPiFxjn83qRrL1DpPanHd/jAt2aYzIiQWlM3zV8Fmw9O+r08g
 qJBOwKEEksoyrWWDREAM8HPfBpUY8Rl/3/WZS+SsO/JzPqd3q24BrjiCLfW7/8YjBr9Wh4xH
 4MX8skNWJKr1ROARS8CBKcYyB4s4g+tL1KAXqwhkP2jiSoGqMC5x9l82owPf1kg
IronPort-Data: A9a23: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
 9VsD7UD6Jy5FX1s
IronPort-HdrOrdr: A9a23:rDoHLa3wyGvBXPPZBTXPvQqjBc5yeYIsimQD101hICG8cqSj5r
 mTdZMgpHvJYVcqKRQdcLW7UpVoLkm9yXcY2+cs1NSZLWvbUQmTXeJfBOLZqlWKdkGQygc378
 ZdmsZFebvN5dsQt7eJ3CCIV/18hOSd+KqrheDRpk0dKj2DPMpbnntEIzfeP0FoSAxBHJYjUL
 iR9qN81kCdUEVSQ8ilCnwCRuTZ4+fKmpXvfAIcC3ccmXKzZEuTmcbH+k+jr2ojegIK+Kwl92
 fdlQz/++GMj9GXoyWsp1P73tBug93mxcJEBMuQzu4vChuppDqJSe1aKs6/VBZcmpDa1H8a1O
 DWpREuJsJy7G6URHi8pV/B1xTp0DM1r1Pkwzaj8AreSAjCNUxKfvZptMZgWDvf9kY6u9l4uZ
 g7oF6kiw==
X-Talos-CUID: =?us-ascii?q?9a23=3ASp1y5mvWbajZMrYPfc5phfOG6Is7TVTF4i/zMXa?=
 =?us-ascii?q?dLmEwEpK8RwaQ9oN7xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AS+7CgAzD+JCw0+ASf3nO4h1QDp+aqJj2Vkcwy5Q?=
 =?us-ascii?q?rgveVLzBzJie2kQ+uX7Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="226895203"
X-MGA-submission: =?us-ascii?q?MDFDSjSAtulVcJbeHey0yg+udYNfyXLoaX/4qU?=
 =?us-ascii?q?zhIG2H1InuUXvl+ikyxNchLKryK6W5hCB4dd0Av4o4ko/6qs/MB1WNV6?=
 =?us-ascii?q?CFGKg4rgAn5V/llGkPyr+eL47FfRdmBBRtPluzGdoAOV6x6/+HYsDL60?=
 =?us-ascii?q?h5rt/Ke03ewAgOy3v1mQHxdg=3D=3D?=
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 15:46:32 +0200
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C8Fc4X009059;
	Thu, 12 Jun 2025 13:46:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=T+1brjTtLxh3V2AXFc9+E8
	KS4xWSQDx97+f2le9Gc1Y=; b=H7pJpLQxBqA+ctHtWENfTOv6yL7ozGnX7lCB+w
	NEKOIsrzoRb5f13Joyi3FftTM8a8QUX5Mgdvu1Z9QioIGvd1wm7dnSf23BN5q0GQ
	KwIImeMhszsjsFaX5/ydoYMvCfLmbaXsjrYOICk1Yr8dhq+9Q1xok6DmLVSZTBYj
	KkJxUzbUC2hO4Jk7sMd1i0z9irX/zQB/6DvpgLv8VLh3SrvZ3lcGZ7qjz6mvgmbh
	h19set99A/t8UOBogT3FDQ17JeP1zL42yahv3HfN1YzDXiZ2zLAVoQZP6B2o5Drp
	V0ZVmHZwalSCYItFeDaSeq3HoSf4IyUaBj5XUkGr4MODpdCA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47753bvkvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 13:46:19 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55CDkIsU005063
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 13:46:18 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 12 Jun 2025 06:46:13 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 12 Jun 2025 21:46:07 +0800
Message-ID: <20250612-field_modify-v4-0-ae4f74da45a6@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB/aSmgC/1XMSw7CIBSF4a00dyymQIW2I/dhGoM87E0sKGhj0
 7B3sY4c/ic53wrJRrQJ+mqFaGdMGHyJZleBHpW/WoKmNLCaHWpBGXFob+Y8BYNuIUxS3jkhedt
 SKJd7tA7fG3caSo+YniEumz7T7/qDGir/oZmTmggnu44p5fRFHh8v1Oj1XocJhpzzB+3DDmqqA
 AAA
To: Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes
	<linux@rasmusvillemoes.dk>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Nicolas
 Palix" <nicolas.palix@imag.fr>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton
	<oliver.upton@linux.dev>,
        Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <cocci@inria.fr>,
        <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        <andrew@lunn.ch>, <quic_kkumarcs@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_leiwei@quicinc.com>,
        <quic_suruchia@quicinc.com>, <quic_pavir@quicinc.com>,
        Luo Jie <quic_luoj@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749735973; l=2184;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=FnYESTc3DcIkI9hMohVQTf+nyHZ4BGncS0S/+iZ8iCI=;
 b=xZouBP9zRArppTkikHk52vKnv/VDF8IkUZQ6FlgXUpKraQ/ZWDR3LbdL5GBQGam7r8uwtydvt
 z43rhJ809e0APfbst02ptlifu9hZWGDsYGM2BFcjUAn4O2ZV86HxOIZ
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDEwNCBTYWx0ZWRfXz6dofNTEmtXZ
 FbD2t5SbL7YDM/rCcADKQDWAWyfmP8+CiQtEnfCeCou0L3igg6FgSHnXkZd4/0Wfx2rytRZWPLW
 F0S2JybJMU1qe5+NmmeosebL6V661rW7Q1QB1GMD4/8IBRMMyohiYCgdP+0PFnRPpjcH92qvGhc
 e54RzVNv80Vjp+plUyKJrBpwZGcVHDCN+GjuMNx0RmR5obAidccoRc3EKSpE++rOfQ5JSYoO4P7
 UgpRrCj8Adm4OB0tA+0aPUwxMH453EK1l9DIR2Lv6Mb2gc07cmctbzj+gpgM5XlpYDWmYPr+4ZR
 SlcJ+ALWthNnu7eZ3Wdxd3Ks2nW+I6HcS5pRIGAK9/IiPo9NTEAVIDc4xYqdWFHhI9IvqsfdUi1
 HAzUM9eBjARnnnAZ4X0yRN6TfscLakiM9e4UY27IW+QjYzrdFaMoy1QSrSdWDEJoucha2QiD
X-Proofpoint-GUID: tPmwA4XSRPj3-r3rjLHQnd-ZR-6A550P
X-Proofpoint-ORIG-GUID: tPmwA4XSRPj3-r3rjLHQnd-ZR-6A550P
X-Authority-Analysis: v=2.4 cv=SqOQ6OO0 c=1 sm=1 tr=0 ts=684ada2b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=UexEAHeDQikcoB9hcigA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_08,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120104
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v4 0/5] Add FIELD_MODIFY() helper
Reply-To: Luo Jie <quic_luoj@quicinc.com>
X-Loop: cocci@inria.fr
X-Sequence: 2774
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/20250612-field_modify-v4-0-ae4f74da45a6%40quicinc.com>

Add the helper FIELD_MODIFY() to the FIELD_XXX family of bitfield
macros. It is functionally similar as xxx_replace_bits(), but adds
the compile time checking to catch incorrect parameter type errors.

This series also converts the four instances of opencoded FIELD_MODIFY()
that are found in the core kernel files, to instead use the new
FIELD_MODIFY() macro. This is achieved with Coccinelle, by adding
the script field_modify.cocci.

The changes are validated on IPQ9574 SoC which uses ARM64 architecture.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
Changes in v4:
- Add org, report and context mode for coccinelle script.
- Fix other comments on coccinelle script patch.
- Remove the FIELD_MODIFY patch as it is merged.
- Link to v3: https://lore.kernel.org/r/20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com

Changes in v3:
- Correct the order of header files included.
- Add the Coccinelle script field_modify.cocci..
- Convert the opencoded FIELD_MODIFY() variants inside arm64 directory,
  identified by field_modify.cocci.
- Link to v2: https://lore.kernel.org/all/20250410131048.2054791-1-quic_luoj@quicinc.com/

Changes in v2:
- Update the documented example for FIELD_MODIFY().
- Improve the commit message to describe the need for the change.
- Link to v1: https://lore.kernel.org/all/20250318071526.1836194-1-quic_luoj@quicinc.com/

---
Luo Jie (5):
      coccinelle: misc: Add field_modify script
      arm64: tlb: Convert the opencoded field modify
      arm64: nvhe: Convert the opencoded field modify
      arm64: kvm: Convert the opencoded field modify
      arm64: mm: Convert the opencoded field modify

 arch/arm64/include/asm/tlbflush.h          |  3 +-
 arch/arm64/kvm/hyp/include/nvhe/memory.h   |  3 +-
 arch/arm64/kvm/vgic/vgic-mmio-v3.c         |  6 +--
 arch/arm64/mm/context.c                    |  3 +-
 scripts/coccinelle/misc/field_modify.cocci | 61 ++++++++++++++++++++++++++++++
 5 files changed, 66 insertions(+), 10 deletions(-)
---
base-commit: 0bb71d301869446810a0b13d3da290bd455d7c78
change-id: 20250612-field_modify-27139f673881

Best regards,
-- 
Luo Jie <quic_luoj@quicinc.com>

