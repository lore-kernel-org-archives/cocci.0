Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AEE6D58D65
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 16:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=J7W5I/le5fz/NY9HD+vPgCUVx8m9M3DgLeQ/73s2W5U=;
  b=MalokBxz0wHjPm7k3L3C3VRnsapXAs0c6RhoL9C/3x6bjNiPqTgFVpjq
   lDAP56y9SKa5g5c6Z7CSYIlMzWzFWzYndShQVJf/bRKc4KMIxivnbyHEe
   MC98+wisQ44hUWfXTX8ojjsmihAyps32xNBFleRY67TUBevPCjLiv4L9e
   k=;
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
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="195719484"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 17:34:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 77310E00B6; Mon, 25 Nov 2024 17:34:17 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 62AE2E00B6
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 17:34:13 +0100 (CET)
IronPort-SDR: 6744a704_R0gV+HZyVtRDGnFNjXjcLULEqkBOg9xCSe99ij9EXG4teQb
 y71uvybkkwWvCWH3HceOTlzLvqMyl90nb8zSfTw==
X-IPAS-Result: =?us-ascii?q?A0FsAwBWpkRneA4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VOCRGIhVDMEC0iEVpFBhGuHO4dWiHWDVA8BAwENQQECBAEBAwSFAAKKWQIeB?=
 =?us-ascii?q?wEENBMBAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAFDDgoxhXsNg?=
 =?us-ascii?q?mIBgSSBJgEBAQEBAQEBAQEBAR0CR0QCAQMjHQEBEScPCxoCJgICVgYBFAEBg?=
 =?us-ascii?q?n2CMAEDMQewLYEygQGCDAEBBtpbHywiV4FkCYEaLoVqgmIBhiSEPCcPgVVEg?=
 =?us-ascii?q?TyCUjE+hEODW4JpgkSFDyWIGGibM1J7HANZMgFVExcLBwWBKSEsA2SBFU5/g?=
 =?us-ascii?q?TaBUQFCgk5Kgy4cgUIFN0eCSmlNNwINAjaCJCRZgk2BJQQFg2uBC4NehF6GB?=
 =?us-ascii?q?h1AAgELbT03CQsbBj2hWoYHgQgkxhg0B4I4gWWBYwyfWQYTL4NxAZNRDgaSe?=
 =?us-ascii?q?ph7IqkGgX4jgVwzGiSDNk8DGQ+OIYQtxyVCNTsCBwsBAQMJhUYBAYtygUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23:V15twRYwGgb4CacRDNv6zwT/LTE62oqcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1waPAdiQu6wMy7KP9fy7ASpYudfJmUtBWaIPfidGs/lepxYnDs+BBB+zB9/RRAt+I
 v5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vI
 BmsogjcuNQajZFtJ6sxxRfEoXpFcPlSyW90OF6fhRnx68ms8JJ57yhcp/ct/NNcXKvneKg1U
 bNXADM6Pm4v48HlqQfNRhaV6HsGVWUWnBtIAwzb4xz/Q5z8rCj0uPdj1SeDJcH5Qqw6Vjqk7
 6dwVR/nkzwHOCIj8GHWkcN/kqRWqw+8qhNlwo7UZIaVNOdifq7YYNgXS3ZNUtpXWidcGY63c
 ZcBAPQdMuZZt4n9pkUBrR2iBQm3GejjziZEimLq0aEm1ugsFxzN0g49ENIUqHnar9v7O6gcX
 u6o0qfIwzXNYPFK1jny84XIbgkhrOuQUb5sb8bcy08iHB7FgFWKrozlOiuY2OMXvGiB7OpgS
 PmvgHMopQF1rDiv3MYsio/GhokIzV3K8j92wJw2Jd2lU053e9GqEJ9etyGANot2RMwiTnpmu
 Skk0bIKo4O0czYTxZkh2hXQZOCJfZKS7RL/SOaePy14hHR9db++mRu/7VSsx+niW8S2zVpEo
 ShIn9rRun0P1BHf98iKRudy8Eu92TiB1w7e5vxZLU01m6TVJZAvzLAym5cNs0nOGDL9lkbuj
 KKOaEko5/ak5/75brn4pJKQLZJ4hwHkPqgzlcGzGeA1PwcUU2WV5Oiwzr7u8EzjTLhOjvA7l
 LTSvY7eJcQGva65HxFa0pw+5Ra+DjapzswVkWUBIVlYYhyIlZLpNEvLIP3gDfewnVCskDBzy
 vDDOb3hH4nNImLNkbj/Zrlx8VNTxxQrwdBe4ZJbFK0BLertVkPsqtDUFAE1PxK2zur9Fdlw1
 pkSVX+AD6OBNaPdq16I5uYhI+mWY48VvS7wJf8/6P70jn85hEQdcbOm05sTZnC4BPVmI0OWY
 Xf3jNYOD3wFshAjQ+P0kFGCVyVcaG6oX60g/jE7FJ6mDYDbS4yzmLCBxju0HoVKZmBaDVCBC
 XPoeJ+KWvgWbCKSJtRskz0FVbikUIAhzwuhuBX7y7phNOrU+zcXuYjt1Nhv/+HTjw099SRoD
 8SB1GGAV317nmQUSDAq3aByuld9y1eG0ahgmfNUD91T5/VTUgc7L5HQ1eJ6C8qhEj7GK/WUT
 FevCvGvHjg1SpplwcIKYk87H9y9hxTH9yusGb4c0bKRUth8+aXX1HnZJsBnyn+A2rNyoUMhR
 55qPHelm7U32gzdHY/PnA3Nsq+wdrkHmgPJ+n2Cy2Wmo0xSFgJ9B/aWFUsDb1fb+IyqrnjJS
 KWjXPF+alMpIa+qL6JLboasllBaXLL4P8yYZWutmmC2DBLOx7WWbYOsdX9OlD7FBh0ilAYet
 W2DKRB4Hj2o9kfXFj9zDhTCZ0328O9xgGy2RAk4wlLCdFVvgoK84QVdnvmAU7UW17MAtj0mr
 mBRFUy+wsmQJt6OvQtnc41DbNl77FoUnXnBuVlbOZqtZ7tnmkZYcwlzuBb20A5rD4xbjcUwh
 HYt0RY0Nq+Sll9MH9+B9bb3PLCfamz7/RT0LrXTxkmby9GOvKEG9PU/rVzn+gCvDEsrtXt9g
 ZFT1DOH65PGARB3M9q5W1sr9xV8u7DRYzUsr4LS23p2NKCoszjEk9s3Deohwxykcp9RKqSBX
 AP1FsQbAYCpJolI0xCMZwgHIfsU2ao6JcKgeNOZ1aTtMOsh1DOqgGJb4Zxsh1qW/nk0QerJ0
 pAZhvCAi1HeDXGm1gjn652xwNwXAFNaVnCywiXlGoNLM6h7fIJQTHyrP9Xy3dJmwZjkR39f8
 lenQVIAws6gPxSIPDmflUVd01oapXu/lG621TtxxnsMp7CcwTeI7uDsbhsBNUZUSWMkgVqmc
 u3Wx5gKGVOlaQQkjk7vwE/gxLVA4ol7IXPSR0hgYCX8aW1vGPjV1PLKc4tE75Umtj9SWeK3b
 AWBS7LzlBAd1jvqA2pUwD1TmyiCgpzihFQ6jWucKC02t3/FYYRrwg+Z4tXARPlX1z5ARS9ii
 DCRCELud9Wu+NyVkd/EvIXcHyqEX4dQbDKt4IeOriq96kV1DBf5k/37ltD8EAc82DP2zJEwD
 H+O9kyjJNC2kf3meet8NlFlHlr999Z3FuQc2sMriZcc1GJbzpSZ8HwbkHviZNBS2Kbwdn0IF
 nYAx9/Y5hSg2VU2dCvTgdijCTPEn404O4rfACtewC824sFUBb3B6bVFmXAwuV+ktUfKZuA7m
 D4ByPwo4XpcgucTuQNrwD/OZ9JaVUReIyHokAyFqt6kq6ACLkOma7utzwxTmd67DbeNih5RU
 jD1d91xeE04ptU6K1/K3HDpv8vBccPTcMlVmxmaiRbGgMBKJZh3mvdA1k8FcSrt+HYizeA8l
 xln25q36ZOGJ2ta96W8GhdENzfxapBb6nT3gK1ZhMrTw5G3E8ArBGAQRJWxB6HNcnpapbH9O
 g2JCjF5tnqLBe+VA1qE8Ek/53udFpe2KzeIKXNfwdgqTUuYI1FDxRAaWy8ll4Q1UB+nzortf
 SIbrngYtFv/twcJwOV1MRLyFHjSrkGkZ389Gp2YMQYT5RpI+kPWd5WX6O4qWSpf+/jD5ESEe
 GmcehgNBnoCXVacQQnqOLX3o9LH9qCOD+66ZZMieJ2orupTH7eNzJOric59+iqUc96IJj9kB
 uE63UxKWTZ4Hd7YknMBUX5fkSWFdMOdqBqmn08/5smi7PTmXh7u7oqTGvNTN9to4RW/naaEM
 aaZmi94LT9S0p5Ey2XPzfAT21sbiicmcDfIc/xIrSnWUKfZgbNaFTYebD5vctRF5eQw00gFO
 MLWjM/0yq8tjvMxDAQgNxSpkcWoaMoWZmClYQmeXgDRbuvAfGCNmp2kBMH0Aaddh+hVqRCq7
 DOSEku4ey+GiyGsTBe3d+dFkCCcOhVa/oC7aBdkT2b5H7eEIlW2NsF6iTouzPg6nHTPYCQ5O
 CJ/blgLg7me9yJejd1gFmYH4ncvfozm026JqvLVLJobq64hGiNvi+dT+2g30ZNQ6zxYAuN4k
 m3eo5Q9xjPu2vnKwT1hXh1Urz9Nj4/epkRuN5LS8ZxYUGrF9hYAhY1xIxENuscjFdDl/axdm
 ICnfE3bNzpItd7Zr5J07y38N8+NdnYsY0KBJQ==
IronPort-Data: A9a23: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
 QAIeIyPfK13pYMd3yqtl7651Sz1ZA/S8gg=
IronPort-HdrOrdr: A9a23:wDiPNqEO/uhXxnmapLqENseALOsnbusQ8zAXPjNKOHlom6uj5r
 mTdZUgpHnJYVMqM03I9uruBEDtewK5yXcx2/h3AV7AZmfbUQmTQL2KhLGKq1Dd8m/Fh4xgPM
 xbE5SWZueAbmRSsea/xhWkGNA9x9S9/Lmvnvq29QYWcegnUcBdBxwSMHfiLqSafng8OXKzea
 D32vZ6
X-Talos-CUID: 9a23:Lb15+251NhrcKnpSPtss5U8bFt48Unnh/kjcGFTpJVhFeZfLcArF
X-Talos-MUID: 9a23:eU8K9QlUkHnm+Xh6UXtKdno9Net3/IDpVXsTiM8GpPKOGDBfMjy02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="102589752"
X-MGA-submission: =?us-ascii?q?MDGP4dZ5FddfwqGT7qdziz3sxFAFodFVorkQOi?=
 =?us-ascii?q?GGtFfWemyCL30iR2wjj2PXbgtrIPLqcZJzk57KJESIe7pZdg8rjtP4hs?=
 =?us-ascii?q?36QQDuwS9zUI3FKHavppFlntJsbmsK/QC1pVFK+JXGQLRhTz3y8R6c/K?=
 =?us-ascii?q?shDr2cboD1dZnEkSC8YnSw4g=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 17:34:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732552452; x=1733157252; i=markus.elfring@web.de;
	bh=J7W5I/le5fz/NY9HD+vPgCUVx8m9M3DgLeQ/73s2W5U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MaLSFf95+P9vOfYtnav2vy+BqPUNCzSerq5khq0ug/Xf/yMTdwFK6iP86EohUgaS
	 4UsDbr+bxG6dquYvrxknW0Jik2k4kFnDt8u2KBQPhLvKZS9Ls5WQs2u6HRJgAIwMo
	 WutaV6pUcqVTQcjtOOaFE0qwjC1fPvwpERj8vEkvnHtbm1PPFmXpNBSkrqO54/E2k
	 oaFQbUqfOVxrLSeWo0Qa7lSoZXiPCeE0xXW4fwEDDhhZrW+/iju2Bp2X+oXHyKMFl
	 fMCf7n2am0CJtanPEy9SG/llwz36PWFJaKD7PAYNjpBggPlmE63dri6cxyYLNRm9I
	 5S0oXxJTKIR7L+G7zA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDdy7-1tO5xr0kIJ-00FYEC; Mon, 25
 Nov 2024 17:34:12 +0100
Message-ID: <71494b2c-d690-4b58-ada0-59233e10c7a4@web.de>
Date: Mon, 25 Nov 2024 17:34:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <434d257c-f0a5-483d-9fcb-3303301ad867@web.de>
 <9e8d6626-f8a2-19a7-33d3-b0cc48d2fa68@inria.fr>
 <100663c2-6281-49cb-bb9f-55656dff80ca@web.de>
 <d05cde6b-6189-4c2-a452-a0851430dcb@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d05cde6b-6189-4c2-a452-a0851430dcb@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QcNc2Xx8fnE2HS9P+1ofRx1jp1YOS4Tn+fswE9nlg9bCopJuL4t
 6nSeFHnbxllzjhRb6KH5UgD2Kx5bwTi/XsMrp+5rIBf4skorKZjp9NF/j1n4dIiXOwMTuUV
 INT1J9R1Y2ljI/519eOyEp2jFaPiP2S/kRl/vYqiIdy0rZkhB7R3PXznqr8jCPWEaFSk3D4
 whMr9oX20KrtaEOSBExyw==
UI-OutboundReport: notjunk:1;M01:P0:snb98+1JmEQ=;C86V2CYTPsTkto1zw9rO2c1iI21
 ifjQqzm9RRRYAF6Fdp7obATHl3M0RAYsE807Z9yoy8kKmSjRb092x5q3Ca+799RPpMxyCQBJR
 UgdnYMP6TfvFpl+StK1hjbt/gbaLsTmznKVsa8kXwH4OcLQ2JRdPYiGpm7pgZTdNIjFXmI7t8
 Z82VpqypvOgPiLTuOEVVCTKn28kFzkSS8WrL4g6xDdUPsaYPAnANrM4ljVm1EB/HDvznHpzs+
 W2EWKNoTm6f2K4Z56wladkj7cb7+bOZW/+AGAiK47HM6aElzbaUOUYrYF/4mc/Z8qo8HM+emo
 BLyAd8B0VkFp3rDKimmQu1bfOM2l5DcEcp3K0xybP5ZLY9NvyP1NG61mOQGgcewQrrem0aqDI
 dfvVRrzFak5p6cFbJqvlsQRA+yml3NGX+I5qgQEki7MyKLSgL8yrT+FmNxGkSlN5M5NGGgdux
 0cqcuYoUd4n3839MRRIOxSIh7O3tpKfeXInzeBw+9OrO8KQ8g7nP4S/1nz5c0aZ66W1DrLLOv
 EHnUBOYFc6KfvVyIy/TvOS15mO85C/iy3uA6CEEHCrjEfLB0ryBCtnlEVDI0DIYpvG2fBh1Rj
 4UlEomWEn6ErUm4ppoApXWJl7uGj0fPhLnjr8+NrsrB85jpdQ64TeRbPtonbUC9Afk/jvqvnj
 MNXsNIJ0wImq6300X0YnWYMpG4x1ChvTaaWxdC+itprFlVR0Tr+oR4VjKxZxq6K9QpVvs3FHv
 UhZaW+JEnyGCqk2fEDUnd32ojJ46YPZjtIQPclUqrxU0fQnQsP7QfgIHLqU3xqfNFyZcvzXzl
 SCnj3m0NOZ6Z3UWYuFAyxzg5cxQrX5aZHg6oz88Z9nyeSK0IL7FvKwZbR+tz3f+TbIxO5C543
 AreKY77dPbkwpClFgPY3agXkiBByWcros6wqAZqElhNByFVnw6FWmf2QG
Subject: Re: [cocci] Reconsidering application of selected SmPL isomorphisms
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2102
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/71494b2c-d690-4b58-ada0-59233e10c7a4%40web.de>

>> * Specifying a varying (or even unlimited) number of items for discusse=
d boolean operators
>
>   e1 || ...
* Does such SmPL code indicate that subsequent expression parts can be opt=
ional?

* How should the shown SmPL ellipsis be restricted according to such an op=
erator?


Regards,
Markus
