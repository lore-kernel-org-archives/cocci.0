Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41357C76196
	for <cocci@archiver.kernel.org>; Tue, 28 Mar 2023 18:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=SbtiIJ7wT5jFsDNd+NOA5qWlAmUw/b6nOgyOd5cWqCc=;
  b=ucDVFUBY2IgRZ7ysl1fMJ+vseIjsOOAmIkymTfIDmo1Y8X9BkMdJES7w
   NyGRa4iaugCEAIp1rGr+RHFxNHLKkI7xGJrS8aUSpOzBtQGlugAkeQnCf
   nF46wgsYGiU37umf3zUmV/P83S/xBjJc9vSCRYKfCE9ulVfThN4drOO0D
   M=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="5.98,297,1673910000"; 
   d="scan'208";a="99582614"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Mar 2023 20:52:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8EAA2E0D41; Tue, 28 Mar 2023 20:52:48 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 36CFFE0D40
	for <cocci@sympa.inria.fr>; Tue, 28 Mar 2023 20:52:46 +0200 (CEST)
IronPort-SDR: 6423377d_LXrD59PM4ZnKNrQs4x+T9ldQlGo/7elYu85QGxPg5qD67U+
 v8xMkTECVdlgm0qE+bm0wOXBk8BFA/KJq46xdmg==
X-IPAS-Result: =?us-ascii?q?A0FCAwAlNyNkhwQP49RaHQEBAQEJARIBBQUBQIFPgi6BS?=
 =?us-ascii?q?y8EC0aEU5EBMYQvhyyHOohpgxY+DwEDAQ1BAQIEAQEDBDiERgKFOQIdBwEEN?=
 =?us-ascii?q?BMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEaCRcHDhAFI?=
 =?us-ascii?q?oVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESAkdTPQMDIx0BA?=
 =?us-ascii?q?REmAQ8fBgImAgJXBgEMBgIBAYJ6gigBAzEHrySBMoEBgggBAQaCY5knHywiU?=
 =?us-ascii?q?4FeCYEULY0FgzZ6Jw+BVUSBPIEVgiyEC4QRgmeCKYdVj0YKgTRzgSAOgT2BB?=
 =?us-ascii?q?AIJAhFrgRIIa4F8QAINZAsOcYFKAmRMgSAlBA4DGSsdQAIBCzs6PzUGAwsgB?=
 =?us-ascii?q?lhrAgkjERMFAwsVKkcECDkGGzQRAggPEg8sRA5CNzQTBlwBKQsOEQNQgUcEg?=
 =?us-ascii?q?Q18CgYBJiSdU4EOgnaSWJJAng40B4IogVWBWQyfDAYTLpcIDgaSIy6HLZAPI?=
 =?us-ascii?q?Kd6gXojgVwzGiSDNk8DGQ+OIAwNCRWDbo8JAT4/NDsCBwEKAQEDCYVGAQGDI?=
 =?us-ascii?q?oJZAQE?=
IronPort-PHdr: A9a23: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
 +SPzjI=
IronPort-Data: A9a23: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
 D3eFrDN0sCN/6xU
IronPort-HdrOrdr: A9a23:B52DpqDOPrqis+7lHemh55DYdb4zR+YMi2TDtnoBLiC9F/bzqy
 nApoV56faZslYssRIb+OxoWpPwI080nKQdieIs1NyZLWzbUQWTXeVfBEjZrwEI2ReSygeQ78
 hdmmFFZuHNMQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,297,1673910000"; 
   d="scan'208";a="99582612"
X-MGA-submission: =?us-ascii?q?MDHUmuM6URMJuWrHNITcBfmnwxopnWyCfqtRHT?=
 =?us-ascii?q?Nj4l57MgkSCDRC2ylGRKQxSddsgxeE/ZZNR6N+mM2AUtuQahuRA/8MZp?=
 =?us-ascii?q?qcLrbcKoePxCPNHXLGTCbbKpVxONelclJvN3G9qP1OhKlavfxD/sQG6J?=
 =?us-ascii?q?BH+tvNR/xnQsi5LeuQnf6MNQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 20:52:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680029536; i=markus.elfring@web.de;
	bh=PFQAw2klfti/HbNJy4FLI3iFe4BuQmZSxieeZCXTnzU=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=Kv5o0rTztCfj0k6WLqfVjAIYudqBAR/XF0EB9vQB1oMc8yCqlOJ7Xy9gTExIhup3t
	 2kbek44dC+kpxyVc2fPi6smI/uVcnupz5+MdAZBgBHzRHYvkRc2YQsCOO9DdLPQoxp
	 QeRK/3agWgW7P5cEIfWgqnW8fhx+6trBcGt1yqbIwYG8JU4AGCiX6ZOyfZXt6Q/vPo
	 osXfkBO9rBjf2YxzKceI2VY/xncrpYfzKxQ46Qumu5OgODXv8vLD24CRDpVspo+l/y
	 QR9Gi9B+c775kC/hOEc5ikg4/e5RQt5vyAq0w1CUnrdNtYz0cy18OqzkwaL7LstqtZ
	 7+l1giTlq4cNw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhFhe-1qKOj744VW-00eOXi; Tue, 28
 Mar 2023 20:52:16 +0200
Message-ID: <ec283368-bfb8-eebe-1419-f8dd361fd76c@web.de>
Date: Tue, 28 Mar 2023 20:52:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <d9c673f9-2c32-282f-f261-b4d5762409bb@web.de>
In-Reply-To: <d9c673f9-2c32-282f-f261-b4d5762409bb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IR9MW04Q7tEhuw7d/JO+RIl619iRzUlwYIAtpbkCrVehxdGNWQt
 u8wgvnTYF1y3gwWFFoD8iccrhurgmh3PerJxF7umBSvcPkAPD81uGdBg32jhuT/QzDDQAWW
 hg4QRm2rv49SMEHCSUVE31ZTAngNs8ux9mO/j3e4JI0r+wVHTtocH5C8YROd5f2mBl5L0lk
 ToSAS1w9DFsjmUb+GHKzA==
UI-OutboundReport: notjunk:1;M01:P0:M41D0e+JQRE=;lrBAUCMQZCVI3hxZdbUbghst9cw
 RO30snu77sLPznJVKOWXNzY7jpscQogG5TmvF9UhYARV/tq+Wuc2LnnE68LbczJOlv0k9VLbR
 c3N/1eJgWvZoWZ/wU0U5Dm7k/Eg2KIVB/WL3zH9UsVPgJBYDprZ6OhhRbqPAKpmE1Ov8cawQ1
 P+SuOmJx9oS3tl1UT0btW3lJ2MsFjd6vQWb8GYupkU3ErlGrc70JfchwgiX8A3jkfjmHK9yoz
 28mlDKBJnR7UYOjfh5ZTGRvt/ZFp8tuBY3SbW72+cEQZBpKh0e8VU0gzFD4ywbudkZpWmbXFn
 /cg/fnijj70FWJRvqpwXqHzKqzpTicDDr+tvF6qgyEAsJ9rlSCLUbUyU6Gw9RNzvSN6MidHqc
 bNZwQLoeBn2qrTPWEgbotzZs61v2kxwhaEukQM67S/YtyYuE1x4QigPneO/VkJgfcxtQ2seWX
 4Ectr0dcaHvcP4CFx0cnY0UH91a8T0pD+cl39Yccx+LR+eVH96wZGN83vqxg4QvQZLO7gnL8R
 ymxz76r9IaJjw66kgKFqmUKtZ7i0mRmPVow08KTxk2ZHvI1W50ihjN/K03LenE0//vgHhgwZy
 h1U6Q+7HryQjHsB+jXZGCuMYDtypmsxMs6ZJZgX05F3JDDzZD1P13vlHI1/16xrlXFkClXM94
 pWHFv0QUbB1uR2FDf7Jskm6aCvbGZcBSJwyfSN2mytXbuz5IvJ9WVW0zPZy3m6SZPwcTpe/JO
 m7fb/994wPG1sLLp8H0p8SHCB2yGGuT8RpVDEROx3Uw0WKiQClvg+WcTVEd0z2P1InN4yamTA
 W5pgvEM4gThexWz2tLftb/P2WwYEj0CHMbUdDj8XIskNzrMmkjbDox0WlKNBJE1hxtNU1GuJa
 NXWY2Rp8F0Qe87CqoZikkZ9vxlIlZuqmlWAlC3OwqJxzI+qRwAFgeHF0F
Subject: [cocci] [PATCH 2/2] perf/x86/intel/pt: Return directly after a
 failed kzalloc() in pt_pmu_hw_init()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 976
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/ec283368-bfb8-eebe-1419-f8dd361fd76c%40web.de>

Date: Tue, 28 Mar 2023 20:24:16 +0200

Return directly after a call of the function =E2=80=9Ckzalloc=E2=80=9D fai=
led
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/x86/events/intel/pt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 93af27edded3..18c009bdb827 100644
=2D-- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -244,7 +244,7 @@ static int __init pt_pmu_hw_init(void)
 	size =3D sizeof(struct attribute *) * (ARRAY_SIZE(pt_caps)+1);
 	attrs =3D kzalloc(size, GFP_KERNEL);
 	if (!attrs)
-		goto fail;
+		return -ENOMEM;

 	size =3D sizeof(struct dev_ext_attribute) * (ARRAY_SIZE(pt_caps)+1);
 	de_attrs =3D kzalloc(size, GFP_KERNEL);
=2D-
2.40.0

