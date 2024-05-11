Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1274FC25B4F
	for <cocci@archiver.kernel.org>; Sat, 11 May 2024 17:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ZD0IBUzzfacRr756mE19cAhvPRKazZAenCklQGysdoI=;
  b=MEOQXZnR/fgFlLQ95Yz+JUxXXKk01e+kmj8LYxalmRATH/x8HLjrPt+3
   vTut3GAY1KsNywRZePKg671Rq8X01nakvN4JAzIAm/0rNZFGGvqb5siTf
   BrnrS3SduX75qV5hNto1RbbqInIYUJytGkOZLHXgkw+26W1LhCcgAWiZd
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.08,154,1712613600"; 
   d="scan'208";a="165202363"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 May 2024 19:21:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CA773E0CCE; Sat, 11 May 2024 19:21:34 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2EC69E004E
	for <cocci@sympa.inria.fr>; Sat, 11 May 2024 19:21:34 +0200 (CEST)
IronPort-SDR: 663fa91d_XWmsBz+QkW1CyLWKT49n1VHmIRteHlqmHS045byWj+XUSM/
 orS4bbXgw8zvmaCAxqK1LEvbgiVcqTbpRt9kw9w==
X-IPAS-Result: =?us-ascii?q?A0HYAwA4qD9mhwQP49RaHgEBCxIMQIFEC4JEgVQzBAtIh?=
 =?us-ascii?q?FaRPTCEO4c5h0+IcYFWgUA+DwEDAQ1BAQIEAQEDBIILgmoBCQKIPQIeBwEEM?=
 =?us-ascii?q?gcOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOECeFd?=
 =?us-ascii?q?A2CZwEQgQ6BJgEBAQEBAQEBAQEBAQEBAQEBARcCR0IBAQECASMdAQERJw8LG?=
 =?us-ascii?q?gImAgJWBgEUAQGCfIIwAQMOIwezCoEygQGCDAEBBtpZHywiV4FjCYEaLoguA?=
 =?us-ascii?q?YV8hEAnD4FVRIE8C4JHMT6EQ4NbgmmaJJBPVH0cA1kyAVUTFws+CRYCFgMbF?=
 =?us-ascii?q?AQwDwkLJgMqBjYCEgwGBgZZIBYJBCMDCAQDEDQDIHERAwQaBAsHdYF8gTUEE?=
 =?us-ascii?q?0QDgTiJdgyDMYF3KYQdCENsFYN2gXcOYYNahFFmgS0dQAIBC209NQkLGwYiA?=
 =?us-ascii?q?R2pN8Z4NAeCNoFggWEMn0QGEy+DcgGTRQ4GkmiYYiCoZ4FsDiWBXDMaJIM2T?=
 =?us-ascii?q?wMZD44hGYQUynhBNTsCBwEKAQEDCYVGAQGDWoFIAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 FUI
IronPort-HdrOrdr: A9a23:DkPf06CsW/S1fXDlHely55DYdb4zR+YMi2TDpHoBLCC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOlNK1vp
 0BT0ERMqySMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:qNgZzWFxVpb64MXLqmI8z0BIA8Ina0HP533zeX7nU2Z5UbmsHAo=
X-Talos-MUID: 9a23:LroYDgZlTWce8eBTsD/x2gFSO9lSs/qrT1AktqcN/Me/Knkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,154,1712613600"; 
   d="scan'208";a="86775989"
X-MGA-submission: =?us-ascii?q?MDFAHwNFP03tRI3dSyeD9HNx6Q1fUlxunJgmYe?=
 =?us-ascii?q?eh8mByygHP61dSX4kEM1vKC2eBMoC+Kn8LxrvOXPN2hzJjF+MJ93PvIn?=
 =?us-ascii?q?HeciFHy37qOWmY+zOf+AwjFZVfd9yuRY9rd06p9q/ErLwWR5iV3rLSUa?=
 =?us-ascii?q?3HqAMHxjF85rd/j4QZbymenA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 19:21:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715448093; x=1716052893; i=markus.elfring@web.de;
	bh=ZD0IBUzzfacRr756mE19cAhvPRKazZAenCklQGysdoI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=r8UyBIUksjVuWE/Q0oKh6svtciktzF1BPVCtD9IO+ld661J3fxEkZ46d/nPkXDNP
	 TCzqPZoVDDgE9Qdz2UgoEPCshUojx7U+ynRkLvk4ciSb80+gBYJb6rAMO5F6RIXvN
	 ArnaL1FDR+MikHlOVBaHMi+hPYKduUqYyL93WsiP0ygoAfou1A05Lxs/lqurMHYoO
	 V7m+t5SIcwuLcajO4hSSORP8JcmUj3NN2j4u4SmuYlGi5vvmUK4eHrjf0I0R/ZYeh
	 bID3bwtVfKgZ6kWhb0qRI9M97SVGRWa9HqsAZDerYEecKjHl8M2pJJ8MCXO3ov7W6
	 4XBnqu5V2U7QdeuiGg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXoca-1s6zYW3YT6-00YLt0; Sat, 11
 May 2024 19:21:32 +0200
Message-ID: <2103e6f9-1790-4bf5-a880-86926e8ff43e@web.de>
Date: Sat, 11 May 2024 19:21:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de>
 <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr>
 <6f5533b1-cbf8-421e-8d7d-8435aa28b360@web.de>
 <alpine.DEB.2.22.394.2405111803140.14453@hadrien>
 <3c953d7c-561d-4ba8-ae23-ffeb12840d02@web.de>
 <alpine.DEB.2.22.394.2405111836340.14453@hadrien>
 <5b96b1f7-9bc3-41d3-b2fa-a377086702d0@web.de>
 <alpine.DEB.2.22.394.2405111912230.14453@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2405111912230.14453@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9JDjhbcSpX5+ggqggpxBdyTFGSbMus0HfnstPdCaHdyzMSsK1ji
 Qpkk/4X9yEdNjGbZ4UWDXxh0DWcEHPqfHyHbRP2OM/lwAFkjRO3QfotJH9fwm5vXxtldyo3
 0gvhe40dqr+0m+o6IUYfbozQY5zD12Gk9e0KmfmjbMwmWTJbRmTFbQ/jY5k64MP1zzt+wyX
 1IUTJxt5akArH07Y84jzQ==
UI-OutboundReport: notjunk:1;M01:P0:U6WXSQJ4q/c=;gpwOlZWC2l3tgo2nnxploZiwau1
 cjSbSA3/NnRaO4mBOmRgBQfeeObqPupN5z6/tfYsWgUesnjfivN3JBpT5rGWNylq7a8HhveB/
 ZY4enPnOU7emIHeOEnvlKNkKu4sTN8mQMY25qygHvwb7sL2iDQA5HWWjP/ywTvv3p6NTRqhbp
 AMnKOu2UG6YTW8B5FB7IQSrJtyEPIQfIyxJev2zn0HSl9j4Hu/GFkBAjCuPuwnIOAwkY+pRLl
 +0LlcIsIAh1kRrS+QD/gz2k8MaXlzlVd5aTSW2SdN3tj+DjGtWZ4LJ8nMv1zicCd9O27Do9l5
 BVipRvSgLdfD9dZ+5cI4hwMlpVrXh72UWtaNhJRS1tCzHHCbOBabIuiiXg3sQxcvzB7jq7Bs9
 UbDQdDs9vA/hH2A/L5WbXLw7LBtxXeJfT8IcmYg5QBPSnWuUTVjaHOSgjcYjlJO1XbC3ByUPH
 TtwSGcG4vUmEDQvyshNd/nY5TK2hq8O2J7S/IL4Q2ig6cxWUVnSWR4VGIQqa2mj7T2kBJIRr4
 x3cDPKY35/z7l0EvQNJv2TK9QDxcOfbCOuVarYKLo75pk3wEcppAg9qVxVDGfIYbQv1R/7pcR
 c4L7hIV0y9LPSJXUUhosLI2yji48SQnHuyiQXXtqBjSOC5hMgYigOMp67vRm+zRk23fbSF1Bi
 IyT763t+ialhCUXcy9XYeIOp83QOGpbfoEqXpaCpShrniKEDe/r+SzDq0glLIHwfaSUR07eWb
 a4n/g8lTwdngcnkeP8+tisdfKHONAxLoMFdAmoDgSgiegkodKjdaLS1AUc1MwinzH5svHnG6t
 swjqP1haSuUVN9738S3JshreS9OAuA+e1m2nQ/MgHP/y0=
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1719
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/2103e6f9-1790-4bf5-a880-86926e8ff43e%40web.de>

>> Which SmPL constructs can indicate a minimum occurrence number (=E2=89=
=A5 2) accordingly?
>
> There is no dedicated construct for that purpose.

Will chances grow to extend involved software components?

Regards,
Markus
