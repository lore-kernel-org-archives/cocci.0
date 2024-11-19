Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63712D4415C
	for <cocci@archiver.kernel.org>; Tue, 19 Nov 2024 13:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=WpBIqVmsVpj3o9M2WNw3biSaha9jZ67LcnavMOJ2bXQ=;
  b=kUChntOh/TZ7Gvj8pAZ930ADbNIcDF9Qj6xVLswxkM6tjx79y3VRa+93
   NxwBaf4SkqydaXvgGjGgPjYY+q5vbw8oc36ePdnOVpovQmBcZRLgoILUj
   1pLM0P9bhw3gj25jjQo0I9aqkunJmNgCQPkTtMaofTr0izJt+KYXhmGFM
   g=;
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
X-IronPort-AV: E=Sophos;i="6.12,166,1728943200"; 
   d="scan'208";a="194657223"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Nov 2024 14:14:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1755AE00B7; Tue, 19 Nov 2024 14:14:31 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 51E41E00B7
	for <cocci@sympa.inria.fr>; Tue, 19 Nov 2024 14:14:29 +0100 (CET)
IronPort-SDR: 673c8f35_eacDblbE030MwAkUYGq76GJ2S5ENXHipz5dWZnPFQpt0E2p
 3s1Tafc14fw8TyO3stajY2R4yRCHqoggnooBcxA==
X-IPAS-Result: =?us-ascii?q?A0F9BAAWjjxngAQP49RagQmBU4JEYhtaMwQLSIRWj02Bd?=
 =?us-ascii?q?IEFg2aPEYh1gVaBfg8BAwENOwYBAgQBAQMEhDqLGAIeBwEEMgcOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgoxhXsNgluBLIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBFwINOm0dAQERJzQCJgJzAQGCfQGCLwEDMQcNsWSBM?=
 =?us-ascii?q?oEBggwBAQaCaNdzHywiV4FkAwaBGi6FaoJIGgEFbYQHYIUHJw+BVUSBPIJUg?=
 =?us-ascii?q?04CAhiCE4MOgmmCRY1LaJodgU0cA1kyAVUTFwsHBYF2A4NGgTaBUYMRSoUMg?=
 =?us-ascii?q?QWCSmlLNwINAjaCJH2CT4ElBAWDaYRshF6EIx1AAgELbT01CQsbBj2eeoEcR?=
 =?us-ascii?q?4I6gjYilVCyVjQHgjiBZQWBXgyJA4EklTIGEy+DcQGTTg4GknqYd41/lVKFV?=
 =?us-ascii?q?jWBOQIxgVwzGiSDNk8DGQ+SGzPFc0I1OwIHAQoBAQMJAYFVg3ABAYl3gUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
 d1UbE5H6LGdv3swahpXBGFLqHZof7Dspg==
IronPort-Data: A9a23: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
 ITteV15fQ==
IronPort-HdrOrdr: A9a23:8I2o/69+G4zr3FBufJZuk+D6I+orL9Y04lQ7vn2ZOiYlEfBw8P
 re+8jztCWE7Ar5PUtKpTnuAsa9qB/nhPxICOoqU4tKPjOLhILAFugLgLcKqAeQfhEWmNQ86Y
 5dU+xZFMD6C0R8gP33+Q+iDr8bsaG6GeyT5Ns31B1WPGdXgkxbnn5E4o33KCdLeDU=
X-Talos-CUID: 9a23:6jfW/m0QnllwuAtoFF5cVrxfSsB1VGzA01LpAxXlFFRyC+eZbVqqwfYx
X-Talos-MUID: 9a23:crU5aQSzWnwNyqLtRXT9uB9pbpxC7pipK18Bl7MeuPmiBCZJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,166,1728943200"; 
   d="scan'208";a="194657205"
X-MGA-submission: =?us-ascii?q?MDEYuBpmcw+/1DoBGnFLaISig55yW2aY4UYka2?=
 =?us-ascii?q?HruUbgJHrQYKOEcqtFcVPovDHCMrt54snfnaaBV097UfAvYg5UXenCsI?=
 =?us-ascii?q?+SxZlzcucTKyvncrKM7acSSkwEVgkbWO0+1SFmDSaav/Ez1qiAKqPsaZ?=
 =?us-ascii?q?ad0SwNjpyKuq6o8/t3FRjNdw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 14:14:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732022068; x=1732626868; i=markus.elfring@web.de;
	bh=WpBIqVmsVpj3o9M2WNw3biSaha9jZ67LcnavMOJ2bXQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hwa4OII4SNK9LtTtrwh3ZWy0ocJk06t7IGX+s3+sFxRoX+ML3BgeC2lBFwdEY+dB
	 HSfvAgpfQfJv7gVAoTHq4bgncUXSpRgwPmsdnkhJ/smejbiyBd7FgOge6j1dyoEkd
	 0Rsx8x3dom+cFFEHGgrCz6AtGCgCb7d0Gkz0VOTxXKbzhWgmOL9P5VduM3SXLBphU
	 myOsC0D934m7dq8Q/mMMEVqCbRIHVOrsySanpLoazgU4FJzJxx8bgqU6r4JQcYd1A
	 vyUr8HzdVBdZ5LJE57qXw2AiKuGB2k0d5bR8w/3J1CDsEtgr4w+MLPynfFE079k4x
	 hcSknzOGkzx9nlmL7g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4bUg-1tCpYw0XQs-00EgqZ for
 <cocci@inria.fr>; Tue, 19 Nov 2024 14:14:28 +0100
Message-ID: <e3af9f65-c923-4fa0-8a7d-be1b27d47fb5@web.de>
Date: Tue, 19 Nov 2024 14:14:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:emz7f9UCEDJmi/nqf9jILkqg1W8nJ8wwNAgLTxYeVh+YzEz/SQk
 JgO2IrZqK6tvFRecI7EHdbDHpcEm1IrkeKybfZTu9Ae1IVxy6ziWKjYXKq5IpNk0RxvR1Dv
 zdXs6Dgej5Park6YoBSp5hy/z5GRKkP285bjf1jbv/d8xCLIpBLPkrPf86ArsxQRenyv9VH
 q2pD6WKCenseplh0S5Kjg==
UI-OutboundReport: notjunk:1;M01:P0:csWDj67HilA=;6uBXp+FNAP53Uofl/HLJOdicTaE
 nRu0S8IKs186NVBFvk2Xt0/yKiSNnaq0dMzXLN4Ptkx7woC+4wtAYQ3HrOxEMDk/lJY7fvtrn
 6pS478EkeVacS9V/Wdj9U6sCk6vkF6y0Nh0XvseRUsuEcTQ2NolRsHLJ3Ga/nNzMtovOcsIft
 lCNKeLJU8RmM4pZc8i1g+dvVyEBbg/ubA2tr4o6maLF1ok/swTD8YMDJGURwmgLhNQlvMTMhC
 kA5PqG5NNnj8D4zINE6BL9C1/lHYmGpv0LoyLeineK67PORs/Ovv37ZRt+E/ojU1rpiQJDxkM
 r9ZDlpdN3U87cXxNizVT0fm0t0CFVpHYirSQBFAcB2FWlxcxU1gj5YtfGwMV7Z3S90ESuBgqK
 tQHHA+Q5CuZFfxj++qKvh6yyyGMPoSEV1xWQa/buwOTAJpqYfCESoKFNZJz0/w7PrV3LXImWs
 qXzUx/YcYBWiIB/GA5BGMggDSLglYAn6ErTk1y+KJAD90TvJ4mEOgTD3rb+DK2PYyABYDeY3q
 9u6hys4CFtbqPg6ewbbUVE/gpe+nq5CZeO5wVVUOhZPm3VMGlCyqrw+AA7ej+8AOLy4aRNd0L
 ltqL/vfvuj8/orV3GZgcYlAKbS5KBvQ/ut7I0h/6wMU7c/JlDPveJN4UdiGBzCIzGE2MJ2Ust
 hBhry7Bu70BHpyJsekcpZkfoPJrUzDlJeJR1KpdGiyUbg4nl54klE6oR5AWKsaN54W3WlbMmp
 sOYA05fyD6y14h5HTM8etuC1HfytQjg5DFOZXemvOhzK/RCKxO8u/hMnh71k38LmO8j6AytHV
 WjMMBpSd760SnnjJClqLRsUir3+PNUZiHwN0FOmquybWVrkMrs7zcSuy3xUyEiKkNuCY8t/fn
 LpwX8y5u4hSSKYGs05ZxCnGk53kKmhdy02fseoQnaYj3TiLOWVn4cPeox
Subject: [cocci] Marking several issues as =?UTF-8?Q?=E2=80=9Cnot_planned?=
 =?UTF-8?Q?=E2=80=9D?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2088
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/e3af9f65-c923-4fa0-8a7d-be1b27d47fb5%40web.de>

Hello,

Various issues were marked as =E2=80=9Cnot planned=E2=80=9D recently.
https://github.com/coccinelle/coccinelle/issues?q=3Dis%3Aissue+reason%3A%2=
2not+planned%22

Does such an action trigger questionable impressions?

Regards,
Markus
