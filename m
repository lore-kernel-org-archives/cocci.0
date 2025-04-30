Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37554C369D9
	for <cocci@archiver.kernel.org>; Wed, 30 Apr 2025 14:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=67N2w5P2l6+VibGrTwmEvvCe87RPrFbKztVZ6dcVags=;
  b=CBGEKeQybTT8t2EYo5Vv74S8yE0wH0nsTUPDe3EqTPrbs/oF02zETdoT
   oGeRsEWqQYEpaGF4weZHUFRNbfCq9Ll9Sv9whEL7qx51QjRvpnM1CLkk3
   lC6pORbIDdDJS6kKnnCiXVey+lktYxEjr0NP3p+kY9UO5Ajy9jEyxfikO
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
X-IronPort-AV: E=Sophos;i="6.15,251,1739833200"; 
   d="scan'208";a="220197151"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Apr 2025 16:15:33 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 67925E0D1F; Wed, 30 Apr 2025 16:15:33 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6DB71E007A
	for <cocci@sympa.inria.fr>; Wed, 30 Apr 2025 16:15:32 +0200 (CEST)
IronPort-SDR: 68123083_Jtb9wby3tDggqayljMRSCbeZJCgpS/PtAhJ7dGgh5uPNnRP
 hbMDV3aXLdzjjxUXRFYL81fpHJpti8W3UDcU2SA==
X-IPAS-Result: =?us-ascii?q?A0ETAAD/LxJogwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBAtIhFWIHIc0gXQwhDuHO4dTiHaBVYF+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBIR2CgKLNAIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABAQE6Bw4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjH?=
 =?us-ascii?q?QEBESYBBAsLGgImAgJWBgEUAQGCfoIwAQMOIweyZ4EygQGCDAEBBtpcHywiV?=
 =?us-ascii?q?4FlCYEbLgGFbIJjAYYnCYM5eicPgVVEgTwLgkcxPoRDg1uCaYIxgRaNOZBnU?=
 =?us-ascii?q?nscA1ksAVUTFwsHBYEmQwMqNDEjDzwFLh2CEYUhghGBXAMDIgGDE3Qcg0aBI?=
 =?us-ascii?q?4RQLU+DL4ICThpEI0ACAQttPTcJCxsGPZY/hF82gkHGMjQHgjiBZoFkDJ9eB?=
 =?us-ascii?q?hMvl0YOBpJ9mH4iqROBZzqBXDMaJIM2TwMZD44hGYQauwBBNTwCBwEKAQEDC?=
 =?us-ascii?q?YVGAQGKfIFLAQE?=
IronPort-PHdr: A9a23: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
 IGnqQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:bgI9u6hbuOtFdaHN0giVEc2W6XBQXg4ji2hC6mlwRA09TyVXrb
 HNoB1p726RtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykesS+Q2mmF+rgbsbq62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: 9a23:oKWDUGCU4ABc+mj6EzN9qEEmHNF5SUbU/FngJmiqGHZNUJTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AHEk10Q+t7WlbOEEi9P1Ga0+Qf8Bi+ZylC30irbd?=
 =?us-ascii?q?cndafMiYzPTmRlyviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,251,1739833200"; 
   d="scan'208";a="115581911"
X-MGA-submission: =?us-ascii?q?MDEb3VEA7IR2oFl1iy6Tr9BWJbLN3E6R+ifXEf?=
 =?us-ascii?q?ivZymYqzMFl+d1aNHZoATsC67SfLvnJk0Y+RWDancKX1AWvrs/Pweafq?=
 =?us-ascii?q?XzsvIjjWiZ2WHrhUVKImWpU++OWkNB6lnnslC9N+zCJd4qMZihPtzBz/?=
 =?us-ascii?q?0e//kbbsCnkmXDdHo+1mG3EQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 16:15:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1746022529; x=1746627329; i=markus.elfring@web.de;
	bh=67N2w5P2l6+VibGrTwmEvvCe87RPrFbKztVZ6dcVags=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qmMhfh3ZArJwfCRNTBJC29KPRuzAAkGKWm9wc1x1SuDGuyVwLOND74N1Mo1W4qrp
	 ykxQSDKAuxAlluFmMiVBdKPpRyUCjuvPgxb3zC/x387gkV9RYocX0PzgJWVMS7oGH
	 OWNHHutmj+R1nmyyqGy/In7xVyxMK280YDEDQ43koI8E9KcjVyaQedBCwScCBo0x5
	 fFLjYy8xHhy3skwEuCRdpXPn1EynnHhdCjgEvt8qDN+6VQeMY0hzg4lgxGN0EeFjJ
	 MANrlWu7QbjZU8t5EUSFBsOwc+uGzzi7dn3hMpGEpA1rSPEAARIuR9EDVLd8UEcoD
	 oPnxfRPGcH1sywRRAg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.59]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Myv72-1uwAZX38aI-00tBhi; Wed, 30
 Apr 2025 16:15:29 +0200
Message-ID: <91b4e7dd-7866-46ae-b9ad-3fdf2d3aa6b4@web.de>
Date: Wed, 30 Apr 2025 16:15:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Dan Carpenter <dan.carpenter@linaro.org>
References: <09b11b9c-21af-4c9d-b818-b0029bca5b9d@web.de>
 <101ac934-7955-4266-4691-d834aec286c@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <101ac934-7955-4266-4691-d834aec286c@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0Bu7zpe6XFthdEzeMFs2dyU124/kNUMIEDf+xt/LTxBgMKnUPnb
 GL/lb0KQWNqXT0tN6vbn43mRsZFvVGqBahQU0kXXtj7WlsswKp7rx4ojF1QS2MkNZG9ZkFo
 2E4QORRV3m5/GC8/Hhh6BCmInuOMEdNLUlXebW8zXz+uMjUTAJZMpYFTNbUSGKdg2bdNTaT
 TlZ3v9F72o1HVb2CSAspg==
UI-OutboundReport: notjunk:1;M01:P0:kNbRKgc11gM=;S1wpNYAfpQqVTmewpSB/9uTQkq7
 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
Subject: Re: [cocci] How to delete selected redundant null pointer checks
 with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2729
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/91b4e7dd-7866-46ae-b9ad-3fdf2d3aa6b4%40web.de>

> I think you want to see if such a thing exists, not ensure that it occur=
s
> on all paths.  You can say:

How good does this feedback fit to the following source code analysis appr=
oach?

@display exists@
identifier member, object, pointer;
expression e;
statement is, es;
@@
*pointer =3D &object.member;
 ... when !=3D pointer =3D e
 if
 (
*pointer &&
 ...
 )
    is
 else
    es


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> git checkout =
next-20250430 && spatch =E2=80=A6/Projekte/Coccinelle/janitor/show_redunda=
nt_checks3.cocci drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
=E2=80=A6

Unfortunately, the expected patch is also not generated then.

Regards,
Markus

