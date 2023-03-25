Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B78C6FD1C
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 09:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lECrlV6AjGgvgxsl93MQ4KyVbxHF/rZynSnnCUqkXnY=;
  b=uMPEAxDkac39iwDtYuj6MW1Ka8xTkWCkMlxceemg+4rHu9NwyHlA+6DC
   eCa9k/jG1cZfWQrg1p/DaGg6NZGqNpfUVg4O8xVpjPikXYibfDw1tgokn
   GrNVNCdv1V9aklH+WHwY8ez8X+0UMZyiANUq5LXop/Brk9BQJRWCm5O/0
   Q=;
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
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99043880"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 10:00:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B403CE0D44; Sat, 25 Mar 2023 10:00:14 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9A5A8E0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 10:00:10 +0100 (CET)
IronPort-SDR: 641eb81b_OvU95DGlLJWeDa1SJt8hVS5aBsgI4TLfKCNm46GodmNlYlp
 6O1/VfuDqzJKQvwVyoFKnVlCWymlixtaCwV4L6A==
X-IPAS-Result: =?us-ascii?q?A0FDAwBatx5khwsR49RaHQEBAQEJARIBBQUBQIFPgi6BS?=
 =?us-ascii?q?y8EC0aEU5EBLgOEL4cshzqIaYFqgSw+DwEDAQ1BAQIEAQEDBDiERgKFOgIdB?=
 =?us-ascii?q?wEENBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEaCRcHD?=
 =?us-ascii?q?hAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESAkdTPQMDI?=
 =?us-ascii?q?x0BAREmAQ8fBgIRFQICVwYBDAgBAYJ6gigBAzEHsSeBMoEBgggBAQaCY5knH?=
 =?us-ascii?q?ywiU4FeCYEULY0FgzZ6Jw+BVUSBPINBg32BBoMZgmeBDIEclyoKgTR1gSAOg?=
 =?us-ascii?q?T2BBAIJAhFrgRIIa4F9QAINZAsOb4FKAmRMgR4lBA4DGSsdQAIBCzs6PzUGA?=
 =?us-ascii?q?wsgBlhrAgkjERMFAwsVKkcECDkGHDQRAggPEg8sRA5CNzQTBlwBKQsOEQNQg?=
 =?us-ascii?q?UcEgQqBAQYBJiSdWwGBDpVNEZIvng40B4IogVWBWQyfDAYTLoNqE5MLDgaSI?=
 =?us-ascii?q?5dqIIIupUyBeiOBXDMaJIM2TwMZD44gGR6Dbo9HQDQ7AgcLAQEDCYVGAQGDJ?=
 =?us-ascii?q?C2CKgEB?=
IronPort-PHdr: A9a23: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
 vbTohRza6Ih+WW0i2o=
IronPort-Data: A9a23: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
 ewjxw==
IronPort-HdrOrdr: A9a23:CwC/d6hKqIqOFxOb5ZskydQc+3BQXg4ji2hC6mlwRA09TyVXrb
 HLoB1p726WtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW2ldAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykcsS+Q2mmF+rgbsby62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99043870"
X-MGA-submission: =?us-ascii?q?MDF2udo51H8S8/GCVl0x0HRMMcr4PtYyDRHzII?=
 =?us-ascii?q?LpY4m1IYNjXlOys8T/ZRtYJlD4U5fW1GBqTTpuMKqRRcJGfC/xkpOl2L?=
 =?us-ascii?q?niMQTN6gM9uZlbYl++PATKFKo9OvBPlUCdzjNt2Q/ERiN618k0RuGO+N?=
 =?us-ascii?q?PcPQJVNqdcAiBpUl0h9acLvQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 10:00:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679734809; i=markus.elfring@web.de;
	bh=fX7savOh+VdYapjCLubdOlQSvygHRnDFyOiEGJzJp2w=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=NY6lQJ9fjWYC7DKyixKibDXBgEc60yd6CuriHAqpao9AwxU7UBajmDJhNNpK64vBb
	 JMUmIoACxyph8KhUtLAr7+14B753hy+JE9h5kv/nLmnAVljNwJ06tL5qBqnLI0gJOW
	 1dfccv6Re3fcQOB8UQqhMuIdoW+f4QGz9KDjxaAM0t2asVXWvP79bVZeEkk2a/fzYi
	 oBjOQ1yTviSVeQTzYLdLzT3a0t319YCLZUgHe6abvWFyb3rKII3x+PSU36tpH5pj4W
	 7vmyEkwigPRJTb+dmzL/nyKPfh1xk/pT2PJ6IS0coZo7f5HVqrnpVdn/yW5poa80bR
	 5J8NQxTYdh1nQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MrwwJ-1qIaIm1Uof-00o0pD; Sat, 25
 Mar 2023 10:00:09 +0100
Message-ID: <1595e3ec-d137-80f1-af27-b8fabd8bfd4f@web.de>
Date: Sat, 25 Mar 2023 10:00:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-scsi@vger.kernel.org,
 MPT-FusionLinux.pdl@broadcom.com,
 Sathya Prakash <sathya.prakash@broadcom.com>,
 Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <46330de1-742d-f95d-e355-a214330698e7@web.de>
In-Reply-To: <46330de1-742d-f95d-e355-a214330698e7@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s73ZwnB+I6hrqZgJF16K3TWSQsqBqiYMy5t9SW2BFWBKz2EtBw9
 aWFdMeKbnj8q4NdSYzr0ZDicB/grv6Vd8DYCfDzKJY3PxjzNBUfWwdAJl5jvdJ7gsEZ68tS
 7+YZn08U7Lq2LYqYiL1CobgoAMDDgA/HnECwusDpl+aWnDsaO9KQDrv6eHMDsh4FduOIOlq
 pzmcIIbLEIiVa3rDBK+mg==
UI-OutboundReport: notjunk:1;M01:P0:4+oBjwyl9Mw=;F1mpkkNsMvsaGdW7kcZrLyMV46n
 dS0FuEglOMf8uBJ/YwJV2fwW2dwt3Ew+PNcgD5wDhx/XLddIp1Gx/zkDk1ZKPENrOWHYkZ8Zn
 AdLvEXgeg9qVFma6yyjW6D5U4XekM3Tub2iXKTgFzTFuF1cME7uLsn6QbMwwjRKh1BtivfOY0
 Ai8br6uOrtzFw/cc1YuU8WQV6MgrSgWCF4BFYi5BGovjRWNjcALyju89pzPujWzm8YB5g++0s
 I9tfcb0EX2LLcWdaWwm3A5w3PyZHqanuX5sAtEJli7HUNZ2+Igp4Cbt7ET87V+GM5muTiWhZE
 0K+eF3ffK3TrSwdy2oLoyZLllNGVM6CLUrjXBG05on42oDaQuvP1ukhusTU0JeYlD83z3vC16
 35Ipd+XtKpIyaS6tJPHFJld19Oym+J3aeTYAONI3hCpIGq2vcH3z5e9huYjjIZ6OWn5eYxNo1
 H70obUfAxblHSaXd39661Bn8g5JWF/qjxSMGtrgdvf9OSwPekkk5dvtif0QIGSZbsr+ZFYl/0
 RYObBLXT7l6OY3gLMBn9MflvbETiS4F4xlnyEmGKNix7LypndS3cYstfqUzKfhZ1vV4w6kJfd
 fQac2vIStztNLtL6MQFGtX/p5geiK7omZPHjGqMFNuT/A44qK8BDAsD2Y3yndYDgj5SbGd/dy
 OQRKJNJTU35pIogMYZiEgPltHkF0Pkd95LVArs9zqlFxmSd/++8iv8xXIDxWA5glxpwybPVdP
 cPd1f0O0YlIQXRiIak3cBIvXvncub8RD5GFLw1xKZ2WtJGV6iZFzzHmy3RjzE/GPyHWqQrDSJ
 vtCBD1DzFq4q4s3iqXfGCq0m5O6lX7uyYUMSTVi1K5j2CAF4VHWMzBr+hlTEsNEyOEzYDH8WX
 w0ZCuFA55mZlbpLTVGFFqva7h3aiAXadf+/fl9yzM5LKAVzSrG1+HpEC2
Subject: [cocci] [PATCH resent 0/3] scsi: message: fusion: Adjustments for
 four function implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 925
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/1595e3ec-d137-80f1-af27-b8fabd8bfd4f%40web.de>

Date: Tue, 21 Mar 2023 16:16:44 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Return directly after input data validation failed
  Delete a redundant pointer check
  Delete an unnecessary variable initialisation

 drivers/message/fusion/mptbase.c | 49 +++++++++-----------------
 drivers/message/fusion/mptsas.c  | 59 ++++++++++++--------------------
 2 files changed, 38 insertions(+), 70 deletions(-)

=2D-
2.40.0

