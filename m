Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775BBCCF9EB
	for <cocci@archiver.kernel.org>; Fri, 31 Oct 2025 06:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=aaD7SmVvNirUVU1SyVtpmfmSup17ggQJA0B2lH9gy/M=;
  b=r9E4keQCgXXsousk4sgsVbhpaOej1lcEuLV2pb6E0zm7QSXpC53rb6B/
   sorZgRe+/Ma9OR1RWYi/taghivHM4WOdmbyF1OakjqDZGVfNkz9Lv9L2L
   +BOAxo9ZG8iRDVohAk7tkhDIUu6qyewpFJJY+TP6+nQYB3iOD1f1/8BOZ
   g=;
X-CSE-ConnectionGUID: o+0V4WpqTRKxtEHirOTUMw==
X-CSE-MsgGUID: 3rEWa5kwTFGCcsod3zrOaQ==
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
X-IronPort-AV: E=Sophos;i="6.19,268,1754949600"; 
   d="scan'208";a="246947097"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 31 Oct 2025 07:01:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4DB8EE0172; Fri, 31 Oct 2025 07:01:28 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 000EDE0171
	for <cocci@sympa.inria.fr>; Fri, 31 Oct 2025 07:01:25 +0100 (CET)
X-CSE-ConnectionGUID: BM55vMkVSGy/rp7hoPcmJw==
X-CSE-MsgGUID: Kt8USkjbSzi/GS0n1PtfKg==
IronPort-SDR: 690450b5_U1WypOQ/p0EYENs6OyyEdzORU90KvLvhOZdTibPvrsWS2Rd
 IegJryqr74Ol18zr/Kbd+bTX4lvoP7PfP1F77Zg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GHAAAeUARpeAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0GAQELAYI/ZR0GWDMEC0mEVY9SgiSEO48RiHmBVYF9Ag8BAwENRAoBAgQBA?=
 =?us-ascii?q?QMEggyCdAKMUwIeBwEEMQgOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECA?=
 =?us-ascii?q?QECBAYBAhABQw4KMYZPDYJiAYEkgSYBAQEBAQEBAQEBAQEdAhQzRAEBAQIBI?=
 =?us-ascii?q?x0BAREmAQQLCxoCJgICVgYBFAEBgn4BgiIBBhABAw8nBw2wVoEygQGCDAEBB?=
 =?us-ascii?q?tpfHywiWYFkAwaBHC4BhWyCZAGGJ4NDeicPgVVEgTwLgkAHMT6EQ4NbgmmCJ?=
 =?us-ascii?q?oEOmQBSeBwDWSwBVRMXCwcFgSAQMwMgCjQtAhQNDxMPGgUtHXAMKBIQHxgRY?=
 =?us-ascii?q?D0XQINJGwZoDwaBEhlJAgICBQJAOoFoBQEcBh8SAgMBAgI6Vw2BdwICBIIbf?=
 =?us-ascii?q?oIPD4k0AgELbT03BgMLGwY9lEeDVDcrL4FOlxGvbDQHgjiBZ4FkDIoulT4GE?=
 =?us-ascii?q?y+EBI0ThjsOBpMFmQYijWabOYFpATiBSQwHMxokgzZPAxkPjiE+g3U3ywxCN?=
 =?us-ascii?q?QI6AgcBCgEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 JTqo38Sg2pe
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:wcYdS61GQyMgxw3+PtDltAqjBGYkLtp133Aq2lEZdPWaSL37qy
 ncpoV+6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:RmkDpWFElKbyW5L9qmJN0RNJBOUmTEby3TDKOxC4Dl5iTZ+KHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AWApsAA4URzGuojPDH/v99CHnxoxL//STM0MPm64?=
 =?us-ascii?q?Uuo6rDnR2Yg+Bghe4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,268,1754949600"; 
   d="scan'208";a="129546647"
X-MGA-submission: =?us-ascii?q?MDE3dSX2gSfJieLWrKpe0D0MwpK4kn93xzJfxv?=
 =?us-ascii?q?Ne0haEx5pAcIOyurbHwZO5Z7XKZkvs1iRpSd7Yzc+sp08WjFSb47vGEA?=
 =?us-ascii?q?bah2m1J3Vovwh061zxHfOwVbFDv7r5iqefURYog+xfgL06U4lqkZOYzF?=
 =?us-ascii?q?TwfTrfz/7nXOCbooG53JpBRQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 07:01:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761890477; x=1762495277; i=markus.elfring@web.de;
	bh=aaD7SmVvNirUVU1SyVtpmfmSup17ggQJA0B2lH9gy/M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DN475Zlfb9OrFlz7lv+MyO1yfTlWnIKHzLps+hJgH75od+001EC4WrldK6VUzT0+
	 Wc0yQ1A42/90cJGfbli1KkiuhLYDj3NdDUbOQPcObO3kfX0YUom38/5KI5kbMeRc5
	 5KZmRMuOGXLpe96u0uWNnS9Bl/u1L/aglW+7l2Foy176ILaHIOV361TFEloSF3CeN
	 bcD2Dz9pjv80K3k2hk6fbEpFaqZtMccu8lKIJ32khW1gBb7rp6jVAASV2MHO8m5fW
	 n1lNmlhfIAHHF2ml5mJA9yvb18hdayd0Tkh4sM/h4u+bupl2e6B4Dz0cM71Slxcct
	 DnV3BM9rK5eIph5N1g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.206]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MODmV-1vd6qC2wET-00YaqS; Fri, 31
 Oct 2025 07:01:17 +0100
Message-ID: <8c401643-3fe6-4511-b55f-5d7643ad4fa3@web.de>
Date: Fri, 31 Oct 2025 07:00:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Miaoqian Lin <linmq006@gmail.com>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de>
 <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr>
 <60f881dc-979d-486b-95be-6b31e85d4041@web.de>
 <aa99eded-be51-af3b-414-7c3bbaddea4a@inria.fr>
 <aQNsecHJSO2U68Fc@stanley.mountain>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aQNsecHJSO2U68Fc@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fJSFIDjBuqyXf5xK4j0b9RLZt+tcFKODlrlL/6uCZwrrZcr8ki7
 OxyYJ6KZ+XB1UoZepXahZTmCxJyoAm+A3SaVlzDjCUBfG/v9veAIPVpn23AURgFHbSX0okh
 MWUkwbg/txF7RnFxT00A/hvl1mEVVQ20+00wNtKcR5KM6uefHsv2aEFVxRcJ4TrNTAQoR4V
 7pQ2IH1z5gS2H51HMUvNQ==
UI-OutboundReport: notjunk:1;M01:P0:5G+lWctbkEQ=;cAEhZezXAH8VvydVLnyZlocFqni
 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
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments
 from memcpy() calls with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3129
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/8c401643-3fe6-4511-b55f-5d7643ad4fa3%40web.de>

> No one will thank you for making these changes...  :(  Please don't do i=
t.

I am curious if further developers would dare to try another source code s=
earch pattern out.

@display@
expression destination, size, source, target;
@@
*target =3D memcpy(destination, source, size);


I would like to point out that return values from memcpy() calls are assig=
ned
to variables in 16 source files of the software =E2=80=9CLinux next-202510=
30=E2=80=9D.

Under which circumstances can development interests grow to reduce =E2=80=
=9Cunused=E2=80=9D
return values also for this kind of function?
https://wiki.sei.cmu.edu/confluence/display/c/MSC13-C.+Detect+and+remove+u=
nused+values

Regards,
Markus
