Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192AED58D73
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 17:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=K0XYrUZeOUS86PUVgYMtsFCsLByL3URpN16CiW7TRkg=;
  b=ajuXfcO1cXSYNjAmkj5Aj5rnj/GQf4J6oM9l9VM+I91nQ5VaJWgp1Jx0
   nBNCLfotCEG2ckiYZYDjD3ZOrD7ZGN2SE8ypjqNlltsaZHFqDaBWhgMi8
   FGaeMKciLyI4uZke93WYG7gqF5k5Mlro8NYgJjz9KuIGwfQJgHxECtPvw
   A=;
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
   d="scan'208";a="195733722"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 18:58:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8171FE00B6; Mon, 25 Nov 2024 18:58:20 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6417CE00B6
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 18:58:19 +0100 (CET)
IronPort-SDR: 6744babb_by8710P5hB9zYSCk4CGjFo4k+6FZqFEERWgUnbz6ByBoRE0
 HyjHJ0vh0gbEp/9sv/JkugyI/YviGDJAIhxEKtA==
X-IPAS-Result: =?us-ascii?q?A0GuAwBGukRneA4P49RaHgEBCxIMQIFIC4JEYhsGVDMEC?=
 =?us-ascii?q?0iEVo9NgXQwhDuPEYh1gVaBfg8BAwENOQgBAgQBAQMEhDpGAopbAh4HAQQyB?=
 =?us-ascii?q?w4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAFDDgoxhXsNgmIBg?=
 =?us-ascii?q?SSBJgEBAQEBAQEBAQEBAQEBAQEBARcCDTpEAQEBAgEjHQEBEScECwsaAiYCA?=
 =?us-ascii?q?lYGARQBAYJ9AYIvAQMOIwcNsDiBMhNuggwBAQbaWx8sIleBZAMGgRouhWqCY?=
 =?us-ascii?q?gGGJIQ8Jw+BVUSBPAuCRzE+gmECgWCDW4JpgkR5hBYliBhoiBqTHlJ7HANZM?=
 =?us-ascii?q?gFVExcLBwWBKSEsA4F5Tn+BNoFRAUKCTkqDLhyBQgU3R4JKaU03Ag0CNoIkJ?=
 =?us-ascii?q?FmCTYElBAWDa4ELg16EXoYNHUACAQttPTcJCxsGPaEXR4RYKyKBL8Z4NAeCO?=
 =?us-ascii?q?IFlgWMMiieVMgYTL4Nxk1IOBpJ6HphdIo1emyiBbgEygVwzGiSDNk8DGQ+OI?=
 =?us-ascii?q?YN6M8cRQjU7AgcBCgEBAwmFRgEBjACBSwEB?=
IronPort-PHdr: A9a23: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
 ZBIRrIJDDQI
IronPort-Data: A9a23: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
 QAIeIyPfK13pYMd3yqtl7651Sz1ZA/S8gg=
IronPort-HdrOrdr: A9a23:XIXVza44zpErVd7xLAPXwBbXdLJyesId70hD6qkDc20xTiX+rb
 HWoB17726TtN91YhodcL+7V5VoLUmskaKdpLNhWotKPzOJhILLFu1fBOLZqlWMJ8S9zJ8+6U
 4KSchD4bPLfDtHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNz2CJ5sA0+9jYDzranGeqTM2fqbQn/
 enjPZ6mw==
X-Talos-CUID: =?us-ascii?q?9a23=3AnBpqb2lKxW8H+R6T5o7fzHTqd1/XOUXZ7lnBHEq?=
 =?us-ascii?q?zNVlWbrTPTQfK4YE+mMU7zg=3D=3D?=
X-Talos-MUID: 9a23:Z/SrEwuxp5ZOvg44Pc2nnyNZMshM4L6XD3stqpAvoMfZFR5uNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="195733721"
X-MGA-submission: =?us-ascii?q?MDEApU/8LJvgkhYAPqchn0jn8a1tPhzesOMsZA?=
 =?us-ascii?q?LkIhUDxSktA7nYdeUIkNg54Ytf5pNXnszkaHofk5Bwty9Dk4Yw8n8iDM?=
 =?us-ascii?q?Pq3iYaEcML9pGxNFhzToYGUsI/bBfSZSHUJmU0h6T8mQMHGWOxUpvigB?=
 =?us-ascii?q?utHZ1JrjQreA1rPX7jQv4cYQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 18:58:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732557498; x=1733162298; i=markus.elfring@web.de;
	bh=K0XYrUZeOUS86PUVgYMtsFCsLByL3URpN16CiW7TRkg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MO0NsfaiIwizMmSJOnnnAEfrZk7TOOYYlqRcFJkszxnntsq7BmvNFUfMQ5awrPJS
	 Ygf2gjTPxcDzaq1Qt78JDbH8x8FR9KY4fF0wxZ3gtdodGZYQ1Xbvu2eMg3gkI3i2U
	 w+zqnfkY4gmG32TEzABQ7ADMvaRUFPCkvfQmH/qWUB21KfAB5idAoIk8YHw3B03i/
	 YbBoy0fKQNBWei7ibOWyv1dSVwlkba3vxx6B+A60NfR7NPZw+xkVNCCB2Avk4qZ6K
	 n56n0xkGhOgOJFdWQppL9n8IV/l7bT/JpG4GISQap5tJNg7fEPoXL18MKODy+IlYz
	 KkW2/IMGICP9pJgt4A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mrwrx-1u11NX1sWb-00kmQM; Mon, 25
 Nov 2024 18:58:18 +0100
Message-ID: <2268c2c1-ea3d-4269-b202-8a569d2f9a8f@web.de>
Date: Mon, 25 Nov 2024 18:58:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <434d257c-f0a5-483d-9fcb-3303301ad867@web.de>
 <9e8d6626-f8a2-19a7-33d3-b0cc48d2fa68@inria.fr>
 <100663c2-6281-49cb-bb9f-55656dff80ca@web.de>
 <d05cde6b-6189-4c2-a452-a0851430dcb@inria.fr>
 <ee6bacc9-eece-40b5-b86a-fa022532af9e@web.de>
 <76e08376-fc21-cef6-ec3-6ccfb33ed6a1@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <76e08376-fc21-cef6-ec3-6ccfb33ed6a1@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L5MWVIbP00E6iegw0rRulG+OOWZIY23P4R8GdtRnp5yLsbSyyNl
 OZHkY0R/DoEsSTdNZYX3FWyOG4xXOzwFXaGkBa8DOiqpF1w45APlZeZYVj52dkQ5xTHLIJh
 0PiL42vhIs0bb2W8JSkC8l9nzzC6bXY6X6/4PwdVpnopsMudHQH1qqQvs1v4OhG1WOc8p2D
 5TpEYAkz5R7JgvbkOLvUw==
UI-OutboundReport: notjunk:1;M01:P0:mHTeNcek8Vw=;sStWTkKquwMCB/bYGn/NnYfWwAJ
 D/YtjDFHq6hpOpM0nKDL9ESnFcTscqjAHJxjVTFGDgeyDnMT6wd9M3HTOj0LGurJ2H4wA3tV/
 RPmwGAdRSVb9aOWQ8zPLjGc655adgNDZj44UNbJlQAP/mG12qnbFkItA3K1zjtviXAo21V6Q5
 FOhnLcQ4hVCCyl9ArBDH0IweGawkVB/n8nn1U5YRGECF/HuJb0xv4Gw10rEPQ3i6PFWfdKlPb
 VGVbXkuV2lLO/FYKLi34jVIIOjdE2C1K2c/bNhDA97wE/gwR5JDrTjTgSy8dMfbfJ3bLDr0MK
 o4ciohMTFelSrzY72go7Sa7FAL8LXlfpC/qOXP6D0E9qcNf+i9BPiaa/W9wGuS9Bi8g642DDL
 7wAXQJkvlei6XACwEOgd6qKh2aRsXbNp+dP3weQW1cmaYhKq19PNrpTvcvgnUsIiiKyAVfONH
 Q2l0+HYlpE+uedhVV56nsHU1mevhDOTAestK0O/9pTOPD80lyO6tiEZzHVjqVT0BjIwjA2C1o
 Tceb3i/5ZPm57NfSiL93VF5AXCemu8OhEwhAk0FVQTpyqt8qCRZuaFsqTXfYNSbgKpAJs1kCh
 721cemGgnj3wU6iB/y691McyXgdKC2TAPb22t5ORdLmhS9fUWXBfKNzcBvctHaC+THFDJ6yNy
 p4ZIIH3t/CjSihyvEa7nR33nneH8506dzmRoUxn7pfHOeU+35NiYFgV+YxdzngEnjNEWqBo9i
 WnD4ajAhljhVh0TvUu71qG2uihbi80fqqMxAAnytDIo+7vfoDCKm9FmuckACS6GBOWiBl37zU
 v9IDL4LahtSYPZqEWTkFBooIZIIkiXP54q7GDw4+XhnGsOJQHa6v0jeqszY8NSNkFFncmNlev
 s8qnkpE7/3sXSocfnSLemRzmD0TE9+r24WTX/UHXoE/37i0I8I/SdumSr
Subject: Re: [cocci] Data processing challenges for pointer expressions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2126
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/2268c2c1-ea3d-4269-b202-8a569d2f9a8f%40web.de>

> You can use options like --all-includes or --recursive-includes to get
> more information from header files if it is needed to obtain the type
> information.
>
> But I have no idea what is a "data processing challenge".
The mentioned program parameters trigger some =E2=80=9Cside effects=E2=80=
=9D.

Example for corresponding development considerations:
How to fix a stack overflow?
2014-10-20
https://github.com/coccinelle/coccinelle/issues/30

Regards,
Markus
