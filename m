Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C22C87FD2
	for <cocci@archiver.kernel.org>; Sat,  2 Aug 2025 15:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=VQkVdeh4G0t4Y1pVajN2pFAq58hGr/TZNvsHSi8bzUg=;
  b=ETnVKARJGL0l6Eyj37G69Hzw1nTZiTHiaCGCcAArjzHumBjEssItWWiV
   K5oBeofky/4xMQQzOoYt7IZJQknwTwtX9vYlMXmRHVueTP6i4XSuFgg7/
   ohPdKYODlPGO57j5D6WxxaJnnJtejc0hgXID/ekTsw5gHGt3K+CgeA714
   I=;
X-CSE-ConnectionGUID: BBYhGGaiRJyYfqMoq6qZ5g==
X-CSE-MsgGUID: UKxqYIrDTj+toxwR36Q1Gw==
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
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233963625"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Aug 2025 17:43:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D9AB5E0BE9; Sat,  2 Aug 2025 17:43:04 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2208CE0171
	for <cocci@sympa.inria.fr>; Sat,  2 Aug 2025 17:43:03 +0200 (CEST)
X-CSE-ConnectionGUID: rKOtiWMNQS+Vyzf6euf8zQ==
X-CSE-MsgGUID: 8IsgtlfsSeis7rpFV5//kQ==
IronPort-SDR: 688e3206_vMak7emdTp3Uwkpihw9X1Qr2DGcLGI/XAAjP3XtkxLl6oFz
 2vGjEV+0up80hNwYDwJRArSz8wE9Cn9gTJNuZbg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GIAAA3MY5ogAQP49RaHQEBAQEJARIBBQUBQIFABwELA?=
 =?us-ascii?q?YJDgQZUMwQLSYRVj1CCJIQ7hzyHVYh5gVWBfQIPAQMBDU4BAgQBAQMEggyCd?=
 =?us-ascii?q?AKMGgIeBwEEMQgOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABATsHDgoxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJ?=
 =?us-ascii?q?gEPCxoCJgICVgYBFAEBgn6CIgEGEAEDDiQHsFiBMoEBggwBAQbaXh8sIlmBZ?=
 =?us-ascii?q?AmBGy4BhWyCZAGGJ4NCeicPgVVEgTwLgkcxPoRDg1uCaYImgRaDY5V0UngcA?=
 =?us-ascii?q?1ksAVUTFwsHBYEgQwMqNDEjSwUtHYEnfYMNgQ6EJytPgiJ1gXlBGT+DUx4Gb?=
 =?us-ascii?q?Q8GgRUaHi0CAgIFAkNFgWAZBhpAAgELbT03CQsbBj2TVIU2ghSWJq9sNAeCO?=
 =?us-ascii?q?IFngWQMn2wGEy+DcZNhDgaTBZkGIqkfgWoBN4FcMxokgzZPAxkPjiGEM70/Q?=
 =?us-ascii?q?TU8AgcBCgEBAwmFRgEBi1uBSwEB?=
IronPort-PHdr: A9a23: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
 10XzLm+IYlBbuXG
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Ad6LxK+SE/t9u91pL4Nuk+AMI+orL9Y04lQ7vn2ZhyYlEPBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: 9a23:TuQygWzD5AL1V43fa15FBgUOOec5c0L46k7rYHGpG2g3RaCbGU2prfY=
X-Talos-MUID: 9a23:gRt9xApqpBU2Bd+gKTEez2FDL8h056q1M00Misoco+e6aGs3OA7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="122663140"
X-MGA-submission: =?us-ascii?q?MDHd37kZwObsHqhpT5l3LDSicfbe5Anuzb6pRp?=
 =?us-ascii?q?nDlJocwaTLwYF6i9wRcKAnjwf4K1DmLlAXjP1g4aWNehRNGVcRnR74Kw?=
 =?us-ascii?q?iyXWnvxZWHv0sOyjMAPWoV263A76w9dsxL/A304l8rFGjTexn3nNEKTc?=
 =?us-ascii?q?UiTHGfiGRID4HrhmYnwrrPCg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 17:43:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754149381; x=1754754181; i=markus.elfring@web.de;
	bh=VQkVdeh4G0t4Y1pVajN2pFAq58hGr/TZNvsHSi8bzUg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cMfH+P8Ceeuao5YeBhU2DSHyDpxBwb+h5xcu/qu6SlyMR/bW/xG/E3dR5ONyY5LU
	 BJ3bYXIOSBURhF7xOy8J0YkJ5e0i4b3JwOucLS+zBOKes5hLMLoUZi8w4G6B3VNYL
	 XSEOsQKonSsFUabDsvYxP5wFZEkGf4kn/WGum5Fwq3HwDVRr9o7jzqCt5dfGadxEp
	 F2J7n1msCXyVBhFV/rvSDwLRRyChT8E9UrVQ2E96hfwJBZLACRfwwZ7Xdohgjx3ck
	 O24ixcEa5e9wb3ysSEfpK0VROu2IcR5lmOcYP9RcCtOXASXhu73UJnXHHnY/klRLp
	 IpL8P1+yUyY/7HxdyA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.1]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGgJK-1uupJn1aRW-002OSQ; Sat, 02
 Aug 2025 17:43:01 +0200
Message-ID: <6239d52e-3213-4083-8d97-9b1f59d2d5b4@web.de>
Date: Sat, 2 Aug 2025 17:43:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr>
 <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de>
 <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr>
 <b7298dde-48c6-4e0a-87af-2046ab999ec3@web.de>
 <3cdb1e5b-72bf-475a-a83b-c469e0225c84@web.de>
 <23a375dc-e768-f2b2-1036-909be61596d4@inria.fr>
 <70a43c52-f898-4fa3-a4b3-16c54bd4f9cb@web.de>
 <c1d74aa4-44db-4618-ba59-e9b6dab28c0e@web.de>
 <alpine.DEB.2.22.394.2508021326250.3428@hadrien>
 <7560a81f-ba29-4b16-b8ed-95cb4d72f3f4@web.de>
 <alpine.DEB.2.22.394.2508021353080.3428@hadrien>
 <e0519749-0043-4cb0-a12d-6a34e2076f58@web.de>
 <alpine.DEB.2.22.394.2508021409080.3428@hadrien>
 <c5042d2d-43df-4276-9611-da4f30763940@web.de>
 <alpine.DEB.2.22.394.2508021502250.3428@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2508021502250.3428@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U/UsfT95XGMV7Gl+OIcfN2R0/LB/lNhAf7w2HcCB7ZXJnzj2lpD
 1naIKbHaGfGxgoAq38gRz4qFtZ2IUJy/HS9+/EhEJrKTSzi+zRIUb3GeS1jC51cgJveWnE+
 9F8XrCoZkmUStF044jtX7UQW6dyaBqw+eHgw/IKEOnqUPsn7sWsfbAzvYcCWUmJoQPJGirv
 HfUXxrZ0//rzObqgRMl5w==
UI-OutboundReport: notjunk:1;M01:P0:JI2w6Qu6N5A=;2PESXdFf6Z42L/B4XbHtmzqRATP
 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
Subject: Re: [cocci] Searching for lock calls without unlocking (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2937
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/6239d52e-3213-4083-8d97-9b1f59d2d5b4%40web.de>

>> How does the =E2=80=9Cshortest path=E2=80=9D fit to the statement =E2=
=80=9Caction_lock(&blockage2);=E2=80=9D
>> from the if branch in your software view?
> I explained it already.  If you have A ... B, Coccinelle doe not allow A
> or B to occur in the code matched by ...

How many lock calls are close enough for the searched first lock call?

Should the lock call from the if branch be excluded then
because another lock call was found before?

Regards,
Markus
