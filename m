Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA0EC282EC
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 12:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=singh3sWNlErpLMt1tHEBDl9S143CDdNk0uTcG1wkTQ=;
  b=mkeZZqdz1nk55vVuITmCGedO5q0TTzO4WDRFyrcj2IZfvsaRb5KScDT8
   ISWM+2ve9oNDQK4uhjeDHaaD0B0VBUOw1Ab8fWVNsZKRMvEtAjlerOy0h
   AYg0VZKqm7b4EqDgiVOkTUo5MZxXcfjKkT1uersPnb54hRXr75dj56ACI
   E=;
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
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="213472180"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 13:19:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3D2D4E0D1D; Tue, 18 Mar 2025 13:19:38 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BCAF7E0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 13:19:36 +0100 (CET)
IronPort-SDR: 67d964d9_KtqOL9+TZeZBzFPs1Rfd9Vxjc0it6ZPgVc1ccGGbET00Ht6
 /w8JWE0mpocbEU+fP4l1AyRYyETiWVKfCHvhYQg==
X-IPAS-Result: =?us-ascii?q?A0GmAQD7Y9lniw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UIEAQELAYJDYnUzBAtIhFaPUIF0MIQ7hzuHU4h1g1QPAQMBDUEBAgQBAQMEh?=
 =?us-ascii?q?HcJAosfAh4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBATwFDgoxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJ?=
 =?us-ascii?q?wQLCxoCJgICVgYBFAEBgn6CMAEDDiMHrWuBMoEBggwBAQbaXB8sIleBZQmBG?=
 =?us-ascii?q?i4BhWyCYwGFbDuEPCcPgVVEgTyCUjE+iB6CaYIzhENnlmKDGZAcUnscA1ksA?=
 =?us-ascii?q?VUTFwsHBYEpQwMqNDEjD4ETBTQKKg44KYFjaUk6Ag0CNYIbJFiCKGoEBYEkg?=
 =?us-ascii?q?jeEPoRBhVCCEYFdAwMiAYIwb3Ucg0h2PoRkLVCBTR1AAgELbT03CQsbBj2jS?=
 =?us-ascii?q?YRDqF2hPTQHgjiBZoFjDJ9eBhMvg3ABk1UOBpJ9mH4io3KFH4F9JIFcMxokg?=
 =?us-ascii?q?zZPAxkPjiEZhBS2FEI1PAIHCwEBAwmFRgEBilSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 VUIeA==
IronPort-HdrOrdr: A9a23:LyhYlK/RFyQBq3uW6mxuk+AGI+orL9Y04lQ7vn2ZOiYlF/Bw8P
 re5cjztCWE7gr5PUtKpTnuAsa9qB/nhPpICMwqTNCftWrd1ldATrsP0WKK+VSJdhEWtNQtt5
 uIGJIfNDSfNykYse/HwE2fD8sqxsWB/ZulnOHE0h5WPHtXgu1bjjuQEWygYzVLreR9dOEE/B
 Hw3KB6mwY=
X-Talos-CUID: =?us-ascii?q?9a23=3AIBqHmGhVNWYFgrzf6i4PQfTn2TJua32H3XnZGky?=
 =?us-ascii?q?EUH9ARayQeGeVpqBhnJ87?=
X-Talos-MUID: 9a23:+3M/VwgvsMsuCFoh4rVFnsMpPcNV5br2Dgc0tZxcpdndLgF9OxKhpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="213472175"
X-MGA-submission: =?us-ascii?q?MDHaIHJOaqnR1YBkSQnmNQ1/wHXLZcWCHe5tXq?=
 =?us-ascii?q?TnXapn4Go4dII+5PJAoGEOcGf4vPbWFdz128ZmfPmxhvHQdz0uCL82lU?=
 =?us-ascii?q?XTaawitvQT9OBe7UUxJ3QK5AzMg+lHxx8s8T8EZNnJib/W1ZeBu/T2WH?=
 =?us-ascii?q?g9qwQS8rBgg8i3067qzsvlcQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 13:19:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742300375; x=1742905175; i=markus.elfring@web.de;
	bh=singh3sWNlErpLMt1tHEBDl9S143CDdNk0uTcG1wkTQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=W1we3ut3oFmc5qE3xjlfv7nJo4tXqfqwTlTCL44SeoYAkBt0DJsXOuGlyDWeTI0/
	 QnDjBajyxrZGoZLsKfNnvkSirXtqiKX4UD5Ya/9mypwMQaey2cHNKZR/42tCGADFS
	 1JweBaiQhQNaRexfllxSEI8WFTjuxLAdrLZbgTS7uORDYkj0WBHX8pfoG37DxPTOy
	 ZJtjXrJg8lHRsHvg6MXSle7aNddP+RxoRad/MYrhJ4IXiJB1DPU8jW1w8y29fn0R9
	 elTNp2/kceyHmGFUVq7TmGBP2GDGDMOfsV6O8JqBjXUhspZr+exdBzvfzx/Jd/3/r
	 TFRQCAZ+fTPJJVitHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.69]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mtgyp-1t2y3k363L-00rczP; Tue, 18
 Mar 2025 13:19:35 +0100
Message-ID: <69ba6c44-9db9-4b97-b45d-1dc59073c2ea@web.de>
Date: Tue, 18 Mar 2025 13:19:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Olaf Hering <olaf@aepfle.de>, cocci@inria.fr
References: <20250317075809.27150-1-olaf@aepfle.de>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250317075809.27150-1-olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:irjwO8zfb770uy5bgtC82dAQmp1noJh4DHQUCpO1eLH8O9gTIhl
 eE3CJKlp8UI1fNRc9UMzXkBJ7Bzl9ol2+9SGqmHRBRzHs1cKtF5CDsRP2F94nHO6UMfe5eU
 mUN7VFn7zlsS/Gq3IgUCyjPtC4Lsqmb5JuE2+PW1FlhVaZFlQMcSRMtXmrEfH7BvdXz1z/V
 p62JeevxdqDLT+YfKpgNw==
UI-OutboundReport: notjunk:1;M01:P0:m8/4D7s1pgg=;+SRsDuG1X7sQkLl2rg34dNTrTXN
 GCqezx6d16zx5Ua9b8hNtreNyzHsPH1ktnI7Nv+OR0HJZ5yLG67DqGORKRRvBq3HnonT2APR4
 lhPsJwkgOnougl8vsJoMJE41OqXc9+rjEbZXB/eCij0G/8cpPBeyKikJ5cVmGD4YKIaV6d9tS
 6kzLobTWRRKI1YCKpOzNTjmhPlOWkFv9CuJJrcLruQ3SnE/noS/Z7gX44swsBL6pI756p7QrS
 cvQWm7Kj+iqFaiBPWD4LOuBJ40ZgjFU6EP7HcOEeyEFEcXFPjxcnL3oaZ+N1VkzsGpnf42J65
 VVll8YcPf4dZyAXql2tofdbjvxbkM4k2ki9cs5j7Z9Ha9f375qingIYv2MkHsWj/cYCDqxmqp
 9PA9GckhCKJk5H0sB2Rbu68fLOK5sC84oaLSsOr7B1gfVQ68av0c4sGhWWEmXlbhxpoXoBjSl
 xsHDT3d7S/g+d+CaziFbqZHizIs64OymauvD8Yl/b/lQHoD2cdmyPLkhGGt/s5NKqQrXoAWcW
 9F7xSLNEZNc6Z9efUeciLj1Jzr4NgxY5EhlVBBLReIp6j+cuUuGB16sePQFu0sPklvQH8j51Q
 Dt/6Fgu30EujIhpm1byYjsFvuZphw4jQsu3LsyhxDJrCLqOU1FrTlG9TuIuQLY49EmdhQjtNt
 IiN8AWgBvShPf94ZXYv/h6VVh1Uf7ECvSIQxDNZazARNTJk1/UCJPaNagQYXi9wDE2JLOseQJ
 ixNAWCxW0adLd4sj3AglFKjFlTiNMh89dbEn3w0lsA5GsiYtL4rUUsIJyaGyYyhZVGxNvHd2L
 zug1R99RYCUp1kVVH872WzW9i4Ic/Xkee1+22nTfPZYuqPFVdGEp8qtzHt3gdpQH7YKzoOaWE
 HkHc81Pe5rjE90huCypDJvYyjWong5Vpr3z7Ol6axqedy0s+j/AUmcy1QI5TWkWAeYWGTQfuL
 ckjy54Ijt8eEyFnPakSCBgQdr1mhPBEqFMjghHWIssx0iLd3esfpIr2pJtMM63TsL9dNHGHCe
 FyquKJQfonyVXpEzAThBi0zMCgR0fcBRphs7sNeOmET21/igq+OlrpLJVL9xhi97KmiAMAwPD
 M/CJnaaQy9Je0hwmVASTFsIIGVpZE8dZ6fQl/OAzMbTsHaE+xxGGLnYnTiA65MoiNGmC32P+Z
 QuokLONUtLmoR7pTfeEeegCoEg25+nqfFhdfqCRCW50gkA7AFfyxt5c/PZJ1VH0jqOKfwEJ24
 vPh9V2IK1jj2ISyZ64FOk3HeWloXOhh7kerAQ5ghTgLLzdLxaRTvAIpx4lStlov6CaDFrqKUV
 lb2+/58QxfSE7t3KBiZZrfMz3RiqtBV2CUiM33JZEY4hVkMHeLpBTjs3f1Nkm1DblxH/9ugt6
 2T2EZlyoH2gi0xljUri2C53Rc0ublJK5sIFAsDHX3LES1DJwTYxaZIgR+2Hng7DHDHFicQjDj
 G+dnpxsrPjxVJf3DsCWVkEhHWXIQNH+vFLn2jlSu8L+LFSl1byvYcMlYIJH2jeNFhS8W/Cg==
Subject: Re: [cocci] [PATCH v1] Adjust configure warning for systems without
 hevea
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2614
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/69ba6c44-9db9-4b97-b45d-1dc59073c2ea%40web.de>

> Fixes 07e224f35 ("small fixes in configure and man pages")
I would appreciate a bit more information for a better change description.

Regards,
Markus
