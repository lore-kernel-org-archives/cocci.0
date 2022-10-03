Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C5CC433FE
	for <cocci@archiver.kernel.org>; Mon,  3 Oct 2022 07:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=hNx1pIS+0FVT0fw/46tn917BDg6TQA3RirwkM3CDIyE=;
  b=ZREYQ/qPrSqVoYDtQ4T1TVZFxtdX5P6CFtdsNkYxJ+shSNjL4zX3qlGm
   cRkuviK/gBEHHNAqkJQpQKzF22L6P1ME9CsNBe6vSQHILEoLjCFTuhevZ
   phoR3+pClYF99nlMs54PF50ghNLXr6uwae61l9HZGtjhoBArbqEAprlip
   A=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.93,364,1654552800"; 
   d="scan'208";a="55599901"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Oct 2022 09:22:55 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8BC98E028F; Mon,  3 Oct 2022 09:22:55 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 16F98E027C
	for <cocci@sympa.inria.fr>; Mon,  3 Oct 2022 09:22:50 +0200 (CEST)
IronPort-SDR: 633a8db5_hl6Wdqh2OEIbJJkpgVaddcQSYRYk9Wodeb1UagCLYeawI/K
 X3uozXOKsNBeKgQ0YT/HyaFq+eYCMwgrY3YBlsQ==
X-IPAS-Result: =?us-ascii?q?A0CgAwB2jTpjhwsR49RagQmDc4EBVi4EC0WETpBnCIRRj?=
 =?us-ascii?q?j2MKwsBAwENOwQBAgQBAYUFAoRtAh0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgQEARMBAQEZCRcHDhAFIoVoDYI1KQGDZAMDIx0BAREmAQ8LG?=
 =?us-ascii?q?gImAgJXBg0IAQGCeQGCbAEDMAcMqQ+BMoEBgggBAQaBQAEVQYI3HywiUoFcA?=
 =?us-ascii?q?waBESyPMHonEIFVRIE8DIJ3PoJiAQOBXoNWgmaUdYRxJgQOAxkrHUECAQtCN?=
 =?us-ascii?q?RgDFAMFIQcDGQ8jDQ0EFgcMAwMFJQMCAhsHAgIDAgYTBQICTTQIBAgEKyQPB?=
 =?us-ascii?q?QIHLwUELwIeBAUGEQgCFgIGBAQEBBUCEAgCCCYXBxMYGxkBBTInDgkhHAoEG?=
 =?us-ascii?q?g0FBhMDIG8FCjgPKC9pKx0bCoEMKigVAwQEAwIGEwMDIgIQKjEUBCkTEi0HK?=
 =?us-ascii?q?3MJAgMiZgUDAwQoLAMJIR8HKCQ8B1g6AQQDAhAiPQYDCQMCJFl2AjERFQUDD?=
 =?us-ascii?q?RkmCAUjFxsECDwCBQZUEwIKEgMTDwYnSg+ZZ4IUYFmjVqBENAeCG4FFgUkMi?=
 =?us-ascii?q?WeUaAYTLoNkAZMDDgaSCpcNjT6aLYF4I4FbMxokgzZOAxkPjjmEDIELiSI/N?=
 =?us-ascii?q?AIJMAIGAQoBAQMJhUcBAYRwAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:OfTPG61vPvNTKKZetx3v1QqjBJYkLtp133Aq2lEZdPWaSL37qy
 ncpoV+6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrUdKZW8kZxBno3lvgxQpOxRGttdBz4SMHfnLqX8KTMtOaYE
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,364,1654552800"; 
   d="scan'208";a="55599788"
X-MGA-submission: =?us-ascii?q?MDFeLmf0r8OBcpU1aMDB7uNljMGr3iGlyeAYAp?=
 =?us-ascii?q?00QghEhQoOIrTBPTQwEmUf9rkdgBkmubUupmR4RF+e/g9jn5uMiJWu2v?=
 =?us-ascii?q?z6bCa3JKoALeYJpRxHYa5Z/HmY7g6OcDYa1X0yuv8G+krzfg3o8jXhk4?=
 =?us-ascii?q?tj8nNQRuYPkugUpJQIcUqyQA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 09:22:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1664781730; bh=hNx1pIS+0FVT0fw/46tn917BDg6TQA3RirwkM3CDIyE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=vcS/jjP07UO5CrGU+rTQHT0aQCdpSxyiRcHcscQFseaR6T3WMpZOE2yJT5nsJROBl
	 tOEZuBv9aV5X8iB6nd/EItdg4eLGtQHwm1ury7IxeukhkhUk6Z0CZZhI2K8KNOG1MN
	 isoqa4baSdheajZQY3DatWcp7/dncIjNgU4aGWKL3wxdxRfHzQm0hcLeV8raEZb438
	 6zA3uZD0GDpkWpMu/3O21k77fmL4cAAAB+yhbQjYTxqqCAHWQNQTKWc8RXleeuw9pB
	 YrP/++h7rZ0M76lYthxrM3+XdbO602kTCY3R23PRK9RCiqL+pG3Wnn28AwlMxeJv87
	 aNvpUvBClmZOg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.160]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsJSy-1pTE080mKo-00u1o5; Mon, 03
 Oct 2022 09:22:10 +0200
Message-ID: <fbdb47a7-1673-b741-08cb-5703931a8b2a@web.de>
Date: Mon, 3 Oct 2022 09:21:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Yuan Can <yuancan@huawei.com>, cocci@inria.fr
References: <alpine.DEB.2.22.394.2209251906090.3293@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2209251906090.3293@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nVRqY/WzKyn6xvEp60zas3MXSEJKXQnK0T90EdCW4DeXGGsqSGT
 ghil7JrtrR/frP+V506PF3A7M8as98QhBorkhvA0U0BmTH4Gkc4o8B3op469tM7UH2o27Ox
 gvQeMMbO88rmwPgzsZg466iEBghKDw/PEo6XBBkZQN66zeX6M1qg0mQ1tmLfhpCkZ9zACvA
 nkeFEavJvKhPAHkbz7hpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FXa3Xb26jrU=:yp82atDd8H5QEdG9cjgEUz
 i6YuJdA84RbLcQlpFgiYEMJo+FQh5hNRYjdj1LOnPaJNibMksVF5TPluUp3sf0TCXGiJcd8HJ
 SkdgWfR4+pFxNYczoGDZCgNPhlNQSkU/QPkF9rJaEL6Jo9JWhe2OV7mqYZlRWbGA3xxzUmBQu
 a3TQc0LZiv1JHaT0j2rZtMe9sxS20IzZ15CnlwXNSrvB75qY9ShuWWU0w7/SjhKAGZ1KEmK4n
 6hyF3O4pTOl34zNA4rzAur9ZwEScymdBF0sSppFiZGnHUakFcaTguuwtKr87CPodIXa3HmEx5
 uM5bSGJWcGcSDD4m/1jsQRfNtkdOTI29RAGzn7zydQpnC4KknIvM7WMoncouMlG181lMPRWMX
 FJfaZ8oB/1h8A/Lz9tqJ56xYSNy3dRbJxkqelIf+y4WRnBxtm7e4JUDWCY0zXDAo7SIyEVf3S
 L3lDHE0/vN33N+FMBI9HNsVozTcaHJD+GesG4zJRNh6lmdBoxqL2Xzvgr2CBu7HfBYzRI2nK/
 35Izlg9yTlmwNFuvNUBQnbsB70UM8K76R3R8mtsAat/V6hzD9yIY1xxI8hyVCmnyv4iEMjG0i
 zABH1dCaTFRGm5hwc0hY21sSAVUg0J8qWxuhZet6PE8rH1DvmE5PKMh4HJ8m+pIdtY9yLHDq+
 ljZ4xA7KR9AjoujwxCZzB+iWI+Y/YJGFgtZGVl6VNFOJmUXeBUamMzMWJjMl1Ozd+Ulca3hiv
 XgalmLedSfi1EshIqAGPU1nP/KidDN1c8kVv0MQmLKTgNw3mszhXxZAIbnhWiC8S1HvDmhwOb
 E2qSL9+Dittk3oEuD78Jj1kx1Z/z0SvxXAb/8uhLbtunss94JdRN/sQ/QvU2WR4mEpL1CiDB6
 kSi/w2v+72ZZQmZYWuSzroLkUEMQSHhFD476wNhBrXUAiXX/h1gYJ1C6fxYyPara6wfdAdzH1
 3F9+80aZrXVaql/HraqbXRSZ4IEw9EhjgOXkBEK7vk8zQIoDGtYdVguIBBCgo9mFnTEZh+gNc
 0fT2fwLyBMBD+mmh/i1/CmU30+vBh+87juOam4au7hc3GxDwl4wKBKJYc6SW3lHGkbzEATSU1
 LKq5+M+bH/WZk1zqVEc/kVu3NaSPiuuBq2O40T5uisOyJf+pBHTi8FECW/hwGZf0SyxYrByh1
 rox8wQbYaBZccWPHfeavIe5S4D
Subject: Re: [cocci] Checking explanations for SmPL functionality
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 609
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/fbdb47a7-1673-b741-08cb-5703931a8b2a%40web.de>

=E2=80=A6
> (* check for aliases or non-standard uses *)
>
> @alias1@
> type t;
> t o;

=E2=80=A6


I got the impression that such a code specification is not completely expl=
ained
in the documentation for the semantic patch language so far.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/19454bc12f6f8cc0a7a60=
91edb28e8a2ca4518c2/docs/manual/cocci_syntax.tex#L199

Which metavariable declarations may be started with a metavariable name?

Regards,
Markus

