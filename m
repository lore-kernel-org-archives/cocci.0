Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D60C46CD4
	for <cocci@archiver.kernel.org>; Fri, 29 Dec 2023 09:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=BTlTiw3od+zRvZkdkmC/usfjKGkFNJTzefXH2qefj40=;
  b=W9HDmY4l4PdErhv5fw6ZZQocc04YjW4miHzekl6ADnJoutoW7RcTvHfZ
   zk6pzCboA5vCVbldJPz71YZFV3tJatnresYD6vWs1qHUH6hVGmLxISygA
   ZR3zdzXXxUf9AFnPiHXNG9OeUSyoHy2ylTNIbryBzBpS2fGbI9z7qivHW
   I=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,314,1695679200"; 
   d="scan'208";a="144279143"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Dec 2023 10:00:45 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6DDA1E004E; Fri, 29 Dec 2023 10:00:44 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4F9A0E004E
	for <cocci@sympa.inria.fr>; Fri, 29 Dec 2023 10:00:39 +0100 (CET)
IronPort-SDR: 658e8ab8_HlHQiIO21NYxa2cIX717c80LjlBoL5cU+IG/nNUrQe0e/7l
 eOIwhTJCHdG+mqLz0ZrB2FsbQ/OOXMy9hx/Lt0w==
X-IPAS-Result: =?us-ascii?q?A0E6BACKiY5l/w4P49RaHgEBCxIMQIFEC4I5B3hTMgQLS?=
 =?us-ascii?q?IRTj0GBdTBVg2aHNYdMhGuEBIMWPg8BAwENQQECBAEBAwSEdQEJAoc2Ah4HA?=
 =?us-ascii?q?QQzBg4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECgQYThWwNglwBE?=
 =?us-ascii?q?IEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAkdCAQQBIx0BAREmAQ8LGgImAgJWB?=
 =?us-ascii?q?gEUAQGCfIIrAQMOIweuUIEygQGCCgEBBq9YHywiVoFgCYEaLogbAYRFgSKDQ?=
 =?us-ascii?q?XonD4FVRIE8C4J4PoRDg1uCaINmnTNbIgVBcB0DBwN/DysHBDAbBwYJFBgVI?=
 =?us-ascii?q?wZQBCghCRMSQIFfgVIKfj8PDhGCPis2NhlIglgVDDRKdRAqBBQXgQ4EahsSH?=
 =?us-ascii?q?jcREAUSDQMIdB0CMjwDBQMEMwoSDQshBVYDQgZJCwMCGgUDAwSBMAUNGgIQG?=
 =?us-ascii?q?gYMJwMDEkkCEBQDOwMDBgMKMQMwVUQMUANpHxgaCTwPDBoCGx4NJyMCLEIDC?=
 =?us-ascii?q?QoFEAIWAyQWBDQRCQsoAywGOAISDAYGCV0mBw8JBCUDCAQDKykDI3QRAwQKA?=
 =?us-ascii?q?xQHCwdUAxkrHUACAQttPTUJCxsGPgInvH8dkx2ecjQHgjSBYIFhDJ8rBhMvg?=
 =?us-ascii?q?24BkzcOBpJULodAEJBPIKhGgXkngVkzGiSDNk8DGQ+OIDiDc49HQDU7AgcBC?=
 =?us-ascii?q?gEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:mbmbk6O22AL8psBcThWjsMiBIKoaSvp037Dk7TEVdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YFT0EUMr3N5DZB/KTHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:K1aBoG/eXWpStHCKkI+Vv1EEWd8lLkDi9yb3A2q0SkVHb6+5cWbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3APOXsKg7MnBg8uv643z/XzfgSxow4yrqHTx9KuKw?=
 =?us-ascii?q?rgPfUcn03HW6W0zOoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,314,1695679200"; 
   d="scan'208";a="144279130"
X-MGA-submission: =?us-ascii?q?MDFoOsIE0ZsHiwd9Yxyf/zGTrA94KZpO1Yr0q6?=
 =?us-ascii?q?lWax46xE7BeBli6HAH9FTrwNg61oNPKnAV3YEjyuExNPt8Q8ZFwSnjtN?=
 =?us-ascii?q?5BA14YUV2xmzfG5PcMFzYQ2hSY7552JDtIPvS4iv1OctzH+UPuNK2RiM?=
 =?us-ascii?q?Wauu++qwpxi3rhGP0CeU4jyw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 10:00:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703840428; x=1704445228; i=markus.elfring@web.de;
	bh=BTlTiw3od+zRvZkdkmC/usfjKGkFNJTzefXH2qefj40=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=l07ZjodOoyATj0Jz/jD/neCa3r83waQzBb3O6X6Ar6X/kjFiMlYTtThb+0hZs3pV
	 KyWXSs4Gd10EoGVlObSfKi6cS7pvrjcwKpuE+UKy70ZK7i3cTxJRiCkBqP6wpyeba
	 Ry2mM5gMrMQNlxR8GUMx6hVNuYODTJab68JQuRjZ8geowjeBzlTAcBO/stTtjOj2u
	 gvSMa9eKT7G/Jf5bYElrjDS2QiJN+zypZDB7EZQXe3XPTenNys3EmSkkar6onobRX
	 32Bd5MTA1QwMEMr2BX6QQFhzLOaAZzDCG2fk+2ekQhcwmGgxGxzrazmUGPGYzZgLg
	 xD7aUEt1r64jlBhHvA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeDQZ-1qiQrj2X4R-00avGO; Fri, 29
 Dec 2023 10:00:28 +0100
Message-ID: <df72e6dc-5d4a-4101-9366-24a9166ec9ba@web.de>
Date: Fri, 29 Dec 2023 10:00:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>,
 LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <5088a905-4f29-41d3-a96e-5b66aad551f1@web.de>
 <ZY54hX3VLswwKgMH@google.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZY54hX3VLswwKgMH@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ygcekGhx0S1ZMtT/mPQnzee7NC/ULw8FHFpKluylUlAMwneyvoQ
 5o8HMnGrlADOZSswpOTbLmvctCdDNHiRBDhdDS3I2iHQ0v1BTPCJZyIoDamFp6ebcKAR7Wy
 nOiGeAVSznZ7hjYAbm3Q03BRREJtYMDBnl+lEQWAIfqQIR/iymG8ooWQvjsSY6KwJIHPKr5
 VklaoYKooZsxs4PLYqQeA==
UI-OutboundReport: notjunk:1;M01:P0:arcw1lIPLVs=;H0swndXBK/ormHQV4YcjXhL/wzf
 eW7hTc/MWZK7jSd8+Ns9BN8ysD2VbXhpWKai2/JclPXR8UGH6fTgOa42TS5Y0fjCr9lm+fPX3
 wjJWPMFrT1h1BSreFjRFYBQbafgT0GLHXeHGcX7zHz3xLMx3swPu4Fl9/tDDc+9X66ItGnVkd
 CIUJ4E/OrBPcHyAxkv5YoBDEWLhEKyIqwQ/gbiIyxOt/2YpolnZ/oUJ4dNi7Wc9QVRdwlVwG6
 yj1SSlTQPsLU9h4vtcs/wKdm2A7j6O0HJMkIy5SHdxfYNn3ONwcsyELlKD8YfJX1rdgIkBndx
 eilSOK9nmzGN7s125FzmiU6CiwUY0U4Wz3uJTrGyfD4j9ghB0rHOC+F7rpv/0Ib+UFDhzk3nO
 pbNWbowDg9994ZULfqZOMHiMl4N6WKc92oYXvWtoc86deNrQu68EKrqX2Fx2thDfNNw6BIddp
 Fh1e16E7w4of37XGOdNeSVwBlJdo1SVaTyWaGrLNx/DXSCFTdWbHD6W/l+w8MEKPUNQuzK116
 1JUeeAredBclUWOVW3MuhVt8C+bhYUVjAvFBwxTMT2xyXWS5PpZ0+JYFXPR6RazTnt4NU9u+B
 sYlovPS9FBz3WhIATK3o0e7OdoQ/ol0NZIxogIXyguai5Msl8eEQB0CZmnv8jDCCbYS0Cm5DD
 7+/KOYRdM5VVnz6c5CN3bgDKB0PVl5MkPgqyBc0hhLBLVaUF5RCuyN5yC5zKa1C/LHn7CWlb0
 m6sSlqd8Ba1rTOsBs1iPxrhNZ/ceZEMhN1geabTeWrLpc4nuspvz8boihZ1dbnDedgI+uASw+
 5tr8Doyth3HpEnC/WEahnYzOPK9zPsIrw3E1YU2VTwLGxUmSzq/4mcdgci8e7P+76Q251AAHd
 jdSPzTx0tfKxxdj6DEXdgNpFSdmykqT74MMuFH7JkPa9zekYr6FlGI9fV/TyMlzOagZQ94C4m
 m5ZGSN5qCaPSByYsgUXtjkGli9A=
Subject: Re: [cocci] Input: MT - Return directly after a failed kzalloc() in
 input_mt_init_slots()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1426
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/df72e6dc-5d4a-4101-9366-24a9166ec9ba%40web.de>

>> Thus return directly after a call of the function =E2=80=9Ckzalloc=E2=
=80=9D failed
>> at the beginning.
>
> This is not needed. The same arguments as on the patch to
> usbtouchscreen.c.

I suggest to avoid redundant data processing a bit more.

Regards,
Markus
