Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31330C369D9
	for <cocci@archiver.kernel.org>; Wed, 30 Apr 2025 14:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=UBp9TQi8sX5Z6YGsKCT7pxJ4WlX9H4sfZrpISQpb604=;
  b=E7fMjk01fWnryNB+Ixtm88S6UZ+DWeagFHDFJ8hP3oFBSbXMSwThVDDV
   R3y+zbE5ZbO0xl+ODgry81q+x/Tsc7dYJWhNNg0UPmiDEDjRg7w1IF7m/
   C5zJwwj60EnMHQC8R8VKcCF4QODC+UDTCGAv1jMvymGe9EMy5DG7Ipvi3
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
X-IronPort-AV: E=Sophos;i="6.15,251,1739833200"; 
   d="scan'208";a="220200332"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Apr 2025 16:30:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7CB22E0D21; Wed, 30 Apr 2025 16:30:10 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 03462E007A
	for <cocci@sympa.inria.fr>; Wed, 30 Apr 2025 16:30:08 +0200 (CEST)
IronPort-SDR: 681233ef_ERtsXU7pBaANC/VOG3M7CI/NKoNZ6z6tKy3Lb7mn4UxoTdY
 ZoYnwxET4RWSQTZrxoYjV9wHNKz0B+VqlkpOHxg==
X-IPAS-Result: =?us-ascii?q?A0FzAQBxMhJog07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VOCRIFXMwQLSIRVj1CBdDCEO4c7h1OIdoNTDwEDAQ1BAQIEAQEDBIIMgmoKA?=
 =?us-ascii?q?os0Ah4HAQQ0EwECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBO?=
 =?us-ascii?q?gcOO4V7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBESYBBAsLG?=
 =?us-ascii?q?gImAgJWBgEUAQGCfoIwAQMOIweyZYEygQGCDAEBBtpcHywiV4FlCYEbLoVtg?=
 =?us-ascii?q?mMBhieDQnonD4FVRIE8glIxPoRDg1uCaYIxgRaNOZBnUnscA1ksAVUTFwsHB?=
 =?us-ascii?q?YEmQwMqNDEjDzwFLh2CEYUhghGBXAMDIgGDE3Qcg0aBI4RQLU+DL4ICThpEI?=
 =?us-ascii?q?0ACAQttPTcJCxsGPZY/hCg+L4JBky+zAzQHgjiBZoFkDJ9eBhMvg3ABk1UOB?=
 =?us-ascii?q?pJ9mH4iqROBfiOBXDMaJIM2TwMZD44hGYQauwdBNTwCBwEKAQEDCYVGAQGKf?=
 =?us-ascii?q?IFLAQE?=
IronPort-PHdr: A9a23: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
 uU=
IronPort-Data: A9a23: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
 lTZiYyJrI9XhKIx/Qtdl6ZpJSwk
IronPort-HdrOrdr: A9a23:eKWcPqvlciLQUAS/qsmPybP87skDotV00zEX/kB9WHVpmwKj5q
 KTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: =?us-ascii?q?9a23=3AKU/FhWr3i4dUeD+9GkH2aZXmUe8uUyz9l37wH16?=
 =?us-ascii?q?fMHhlE5uXR32Q9Zoxxg=3D=3D?=
X-Talos-MUID: 9a23:umGgAggQZYJG75IBf0homMMpLMgw04iHLU40ussosseDMRdTPhGipWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,251,1739833200"; 
   d="scan'208";a="220200318"
X-MGA-submission: =?us-ascii?q?MDERcBkADgzapJ8XAotUDkF2ZIQR9F7z5+D3y1?=
 =?us-ascii?q?sHDELCvVjOnHsaxtzZQN+wnVv/ZoUV+fFHnLR/AgyuRPafoKRj1QwUuy?=
 =?us-ascii?q?IAeoNYjVbhX5wt9ILqcRobKwzsaFbwr3R0gByTulgvsBvABkcUCs5qX0?=
 =?us-ascii?q?/dV7lA0H6qhxNqDtrvd9RLkA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 16:30:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1746023406; x=1746628206; i=markus.elfring@web.de;
	bh=UBp9TQi8sX5Z6YGsKCT7pxJ4WlX9H4sfZrpISQpb604=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=POZgfciRkq28D2QVDHUR7LKQN4nRmInf9TYWHCWMSJez0eUaXddVEYJ1VpE5y2iM
	 V0Mx2PLU1Sy3/X6PKWA7fkB4VeBudvEI/+b3xDcogMbmy+xdjV545nc9MGHQqdCAF
	 gwSR/fGT1YteMBC57DTTP6UbyoLRSCxk6kuWnBImUwMo9gqsh1JdNN+Fq7rbkd8ev
	 nUZtcyjiSav25ocrjau7jB5Mi9GBCUBppgCZdanu+JWspYe+yx3vGudG7YE66/RSb
	 49MFj/6R/l8yWBnY4tRyUTwQcdkH4g+DHHQD3B8BmUKduyc0zzac6GpsI0cIzCXEg
	 8YZe2lO0lh3GnlxgaA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.59]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVrbz-1ubwh11BTx-00XFCc; Wed, 30
 Apr 2025 16:30:06 +0200
Message-ID: <c9f8e1b5-10a4-44a1-8eb3-3f635c7dd504@web.de>
Date: Wed, 30 Apr 2025 16:30:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Dan Carpenter <dan.carpenter@linaro.org>
References: <09b11b9c-21af-4c9d-b818-b0029bca5b9d@web.de>
 <101ac934-7955-4266-4691-d834aec286c@inria.fr>
 <9c26bec1-887e-48dd-a72e-20dd13e41a95@stanley.mountain>
 <825f5062-6790-217c-4c57-d4b5b13c38d5@inria.fr>
 <168d3944-871e-4a08-9bfa-b1a1f597e93c@web.de>
 <97522457-7023-73b1-2e2f-2f5f573e243a@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <97522457-7023-73b1-2e2f-2f5f573e243a@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t5JM71rE64+ZaZAfISPqDINbgZimv3KbjWasyHNzrrqarMZLI6d
 zsqIejILt4T2VbkmSa3GNrSLCLk0CfL6l4inwnF+aS4vVYtfKkTgt9ZejcBkW8f3364ycTZ
 98WedmYydzBqdZp7ETG6SvN6vEAFXHbSHyBwqjhpUqgVZ/wHXB0OfS5+9ekMyrNyKs4osZ4
 9P4IslPfOpXA2QAvidCXQ==
UI-OutboundReport: notjunk:1;M01:P0:mLBbf156/hw=;UH6WMYCHGqbU6LmJCYUZ1JyUBGb
 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
Subject: Re: [cocci] How to delete selected redundant null pointer checks
 with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2732
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/c9f8e1b5-10a4-44a1-8eb3-3f635c7dd504%40web.de>

> Maybe the function triggers a parse error?
Do you observe a corresponding error message with your current software ve=
rsion?

Would any data processing be still improvable here?

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> spatch --pars=
e-c drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
=E2=80=A6
nb good =3D 818,  nb bad =3D 97 =3D=3D=3D=3D=3D=3D=3D=3D=3D> 89.40% good o=
r passed


Regards,
Markus
