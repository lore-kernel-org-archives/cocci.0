Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458D9C4707B
	for <cocci@archiver.kernel.org>; Wed, 10 Jan 2024 11:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6QdTdeXXCg7fyOuLAD59o4Ao1IE3MADQTFm1w2/Sico=;
  b=Ga99W2cxCNwHCQlTuPWYWnM+F33MSH087C1m4MlNKib2LzPEGB3zJvXD
   SxLfVkNdgXcY9GPrMJF/Tw0CE5N/KSW4K6XYMNHttPqontHyn8I27xEcH
   6DZQubRayhWro+Ienh732KRrMKiUv3wky9PhK1XkJiQBvRvNnJE7/7IiG
   I=;
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
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="145857593"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jan 2024 12:40:32 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 419CEE0CCC; Wed, 10 Jan 2024 12:40:32 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6D663E004E
	for <cocci@sympa.inria.fr>; Wed, 10 Jan 2024 12:40:28 +0100 (CET)
IronPort-SDR: 659e822b_FRYONO2Wz/HYctpkhvGD16z+4OMslG8WYC8dAC4eR5kv3/m
 qg3C6Kw5SndGQqVUATCjceGCl2IJ+qeO3T5de5g==
X-IPAS-Result: =?us-ascii?q?A0EtAAD9gJ5lfQsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4fFYyBAtIhFOIHYkZLQOEO48BiG+BVhSBLD4PAQMBDTsGAQIEA?=
 =?us-ascii?q?QEDAwE4hEcChz0CHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQEkGAYOBQsnhWwNglwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQINOkIBAgIBIx0BAREmAQQLCxQGAhEVA?=
 =?us-ascii?q?gJWBgESAgEBgnwBgioBAw4jBw0GtgeBMoEBggoBAQaBRQIMAkNOrHIfLCJWg?=
 =?us-ascii?q?WADBoEaLgGIGgGFZ4NBeicPgVVEgTwLgng+gmEDgRiBBoMcgmiCGoNCihyGB?=
 =?us-ascii?q?lJ/HQOBBQRcDxsPHjcREBMNAwhuHQIxPAMFAwQyChwLIQVVA0AGSQsDAhoFA?=
 =?us-ascii?q?wMEgTAFDRoCEBoGDCYDAxJJAhAUAzsDAwYDCjEDMFVCDFADZR8yCTwLBAwaA?=
 =?us-ascii?q?hseDScjAixCAxEFEAIWAyQWBDQRCQsmAyoGOAISDAYGCV0mBw8JBCUDCAQDK?=
 =?us-ascii?q?ykDI3QRAwQKAxQHCwd7gRcDGSsdQAIBC209NQYDCxsGPQKVKgGCOoEOKgKCE?=
 =?us-ascii?q?5Mpkx2ecjQHgjSBYIFhDIoYlRMGEy+DbhOTJQ4GklQumB8ggjGJI4F2mnyBY?=
 =?us-ascii?q?zqBXDMaJIM2TwMZD44ghCuBC4NWimZANQI5AgcLAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
 kFucjvJFeo5sg==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:3TD0OK6DZ4Y9S3iCLwPXwBzXdLJyesId70hD6qm+c20wTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhX4tKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkYNDSaNzhHZKjBkWyFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:NDkhJ2z3a7kr54Vr0/dLBgUeHOokdUfN40voOkueGDhVSIy5d0KprfY=
X-Talos-MUID: 9a23:1IfvSwtk/KGS/s6DzM2nhR57EuMy0pWUOWMmsKwco/efLAJ5NGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="76369922"
X-MGA-submission: =?us-ascii?q?MDGtVJacmhpF9yaT/ocW3U3DWyt6LoPoCW7MoE?=
 =?us-ascii?q?U/s3Agj86NgBfILVhm+MTs0qoWcj/7KDG313gHlJLeCFVuShVivWtMso?=
 =?us-ascii?q?F3qGdTJqyRdH1K2k6Ab2b818Owz9x+CWIDh4PXd82ylPG7vVsZzsbJRE?=
 =?us-ascii?q?fb2+rxfPca1T+EVva3752Z8w=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 12:40:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704886825; x=1705491625; i=markus.elfring@web.de;
	bh=P0anna4JWOhnimdjUk13w2sXj1/SrIEjxwjDEaNWyfs=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=Mt803ouApvmmTNV+/x+Xs0i4q28VuBqjoQJ7NlE98lZpkFr2clisHXsXJG4L8M4f
	 jOigLiSkpA2TeueJuBKVx2pqGOw5LAnjgkwYMEbUObx64L/QmwDbcxnrMsxXP4GHV
	 mi4oZ7SvLjupx5VIbTj7zU2vjWVWbQfeK7IAb+Mr6BmTtrARayn5kLoTOgJdg2Z6A
	 SuRJU+1dOXCxn5n4kq6My49R2m+UvZijQptKdtWW0ZD/aNtou2AW3A2oTXwQUygLQ
	 UBfBUdDm145AD0jlafNkOZGcG6rszcTBXvDg4PVYOdX/w/s4Xh8Q/teEbDcV9UtBV
	 ViTO1ONS9i9MH9pghg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1McZnj-1qlBWG2STd-00cvO5; Wed, 10
 Jan 2024 12:40:25 +0100
Message-ID: <71cd2c67-99a4-4173-8f0f-065fd864f8ba@web.de>
Date: Wed, 10 Jan 2024 12:40:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, drbd-dev@lists.linbit.com,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Philipp Reisner <philipp.reisner@linbit.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <33226beb-4fe2-3da5-5d69-a33e683dec57@web.de>
In-Reply-To: <33226beb-4fe2-3da5-5d69-a33e683dec57@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FvN7dPgcDHXfSNpzcQS0P6dIUa4iuJ1O5Ux14a/Vy6slkXstFSm
 i2fGgA9VGN+mDIJF7soCccsr07aCTRytpI+mT+ILc4ZFWP5nL0tdRHb3Ul2KW2Zd+hfjOtH
 IpDqfB15AUfmtd/igJQglrWxLmNEQLvnSGUJqJHzWA7Mfb24Rbio61GqZpatuYycuhXdXSA
 XTbqo72jfhnC/+4BCZppQ==
UI-OutboundReport: notjunk:1;M01:P0:7RIVCUYl0p0=;SSQc0/FUdDIxV0DAh9oktJT4ZRb
 wuG7UNJDKzrRhXRBuRofdUk+85zgZRDDbdUxbNHU9qvML9hFZ+g0fdM4Agdv1jv96peWx3RFB
 fA0aogvIy5WKlRiNQUuxrNLQ7Kem7jEntm6cFO10Z/rpjBWmXZW4zS6iG/SVDDA68tlMCYBeL
 mNdkc0YF77F8v0cGwucyQ2UuLmEAOk56sIqFovavS7uvz0KrXBhHIvxzqcbFWEJ+WizjcsWGR
 y/4xdtsxCuJ+qIYOx5SZmkmp1cKwwingGbaQJS37jVLI5atqRGObgtnSekAPDl/ZB+jpQTDIA
 2eWdKdFES8ThJflrdBsyE9BtrkRsoaj4Qez89N71pEEy4UadOWiFYS2FNKwvexDm6Xkff7YlV
 V7OSQCK3D1mIcuACYjC3x+cOPDALag1/MmakhDxx7/X6aEzCgZ11YXyeXDaa+Fuf/hLNaN0tB
 eYH9Ti9/jDU6EUzoaE2YLIavTt5Tdb6EXoDI+GejSrAEXXEJ5BE1+T+TLa885rvukHqhS9o53
 O7jELk+A7WJyQBSaxfxj1OIJzFdQLJ83VDaG4dlPyUuX0LYetnXL6prCsQmQpwnLmGMdlEY0S
 80/btsDwSuy5U7eKv87SckRoiJ9rOQAcITknRmKWjVOMvWTOX2y6kimsRqiUNqFXJVGQXnm4I
 ad/GIv3mWXfpr9YPT/Ec90boBxSnmaz0WR165C/eQIXQljuNhbVBsN2vjYciap/vuWDBYZphy
 gDMPomTIJaXvYKmS/3KT9beixW/wVNzynPdwb5LrIKkiICxUI/XcGG6bUbk2vszzEoh+ITuh5
 f3KcwY0BhE2rptaFGZ2wCTvkugdYNbVFojuK0GeB/cpxo68eqjUULPIbvp5U3cSMcU5nfS4tr
 x3NaM2mj+Q8+lwI+2n52HJMALzhdkCG4g+PBPOUF6M9wBUljEXLW+QSKJfDh/Gsld4kuX2zt/
 4eszRg==
Subject: Re: [cocci] [PATCH 0/3] lru_cache: Adjustments for lc_create()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1445
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/71cd2c67-99a4-4173-8f0f-065fd864f8ba%40web.de>

> Date: Wed, 29 Mar 2023 15:30:23 +0200
>
> Some update suggestions were taken into account
> from static source code analysis.
>
> Markus Elfring (3):
>   Return directly after a failed kzalloc()
>   Improve two size determinations
>   Improve exception handling
>
>  lib/lru_cache.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)


Is this patch series still in review queues?

See also:
https://lore.kernel.org/cocci/33226beb-4fe2-3da5-5d69-a33e683dec57@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00110.html

Regards,
Markus
