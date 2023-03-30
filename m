Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88728C77B62
	for <cocci@archiver.kernel.org>; Thu, 30 Mar 2023 08:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=eZPtnuWZy5uVn3oTecF9wPEHqCGY8kFlHDaHYNM03VY=;
  b=kXugv8W8whPbZftkMFTsl7laxsjzRnlctWoYc/G3+m3bTUIRJcMM0Sdx
   GutpMN7yI2SNOQhShUSiEiVCH/uH6KgHBcI8m0Pn88N2svER3pj6EK9M4
   E7+o8HCThvQepjaN/CnsCLr7DsciRRPnUeY/Z24NOTFLGNEQjv25t/SfL
   8=;
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
X-IronPort-AV: E=Sophos;i="5.98,303,1673910000"; 
   d="scan'208";a="99849041"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Mar 2023 10:50:28 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5351EE00CE; Thu, 30 Mar 2023 10:50:28 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0752FE013A
	for <cocci@sympa.inria.fr>; Thu, 30 Mar 2023 10:50:27 +0200 (CEST)
IronPort-SDR: 64254d52_LyGX7aTULMN/06sb4CI5F2yyTepDY/9ndXlRjE9OOmYpZat
 buwsoSHPsQIc12BmiRQJj538xP5abqpcMGmPrug==
X-IPAS-Result: =?us-ascii?q?A0EdAAAjTCVkhwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIH4hiMYQvhyyHOohpgVYUgSw+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBDiERgKFOgIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECB?=
 =?us-ascii?q?AQBAQIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBEgJHUz0DAyMdAQERJgEPHwYCERUCAlcGAQwIAQGCeoIoAQMxB6wXg?=
 =?us-ascii?q?TKBAYIIAQEGgmOZJx8sIlOBXgmBFC0BjQSEMCcPgVVEgTyDQYN9gQaDGYJnm?=
 =?us-ascii?q?VMKgTRzgSAOgT2BBAIJAhFrgRIIa4F8QAINZAsOcYFKAmRMgS8lBA4DGSsdQ?=
 =?us-ascii?q?AIBCzs6PzUGAwsgBlhrAgkjERMFAwsVKkcECDkGGzQRAggPEg8sRA5CNzQTB?=
 =?us-ascii?q?lwBKQsOEQNQgUcEgQ18CgYBJiSdfoEOlV+wPTQHgiiBVYFZDJ8MBhMug2oBE?=
 =?us-ascii?q?pMLDgaSIy6HLZAPIIIupUyBYzqBXDMaJIM2TwMZD44gGYQMj0g/NDsCBwEKA?=
 =?us-ascii?q?QEDCYVGAQGFewEB?=
IronPort-PHdr: A9a23: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
 j3ni6/5bjtPoYq8FSQ0GMXebs6KYiNJDA==
IronPort-Data: A9a23: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
 ewjFrbM0tRdD32nqSv/JhB2vAu/+s7n+w==
IronPort-HdrOrdr: A9a23:CKdePKkruddsXFtkhiYF/ckr51npDfL43DAbv31ZSRFFG/FwWf
 re+8jzpiWE7Ar5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQiVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6PoSizPZLz9P+qjkzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,303,1673910000"; 
   d="scan'208";a="51677123"
X-MGA-submission: =?us-ascii?q?MDEaWAAKhqKd+tzT5kqxwaa/TRwveGcratFpCq?=
 =?us-ascii?q?54+6XzyaBWbEbxCYAcbupUNTiktCK6lRi/Ree4+MBw7b2eWsJPZxbd/s?=
 =?us-ascii?q?XqOasBWld/WXHc64I8b+0xzNydVmUn0PCCAhIOIug872MhuPR1qv/sHY?=
 =?us-ascii?q?rd8wcPlI6szJ4JyMD/dwJl/Q=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 10:50:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680166225; i=markus.elfring@web.de;
	bh=Fwh5atJ746lkWU5/DXTpyRGd4k28e2Ur9KnzAcnGfu8=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=vUdOe9xxyTsJWhqMdbrOKf2Oxd9Y0CmQdVpzk13c4+k2AobqF58REZgoaFcbvW9o0
	 mdHMpcBsERM0gXWLRp1a56j/LuPxlI5Z5I7H0Z7AWBPnBZ5LGYYPTmjedOw9u+wvxg
	 wEp3A6waqcMj2HOlo/SjgDZ09OvAzLKkT8HgaYYeDH1sxNz/0ssO9Y3VIUOU3jZqyb
	 rqBOPGLU4OebgJrBZIhzPIKOXilmZH/jdYHCQr6IRSZ/EkhguqChw03QGUSA42PwYm
	 KtQB/tCJ1YgGhiGe7Fh3INvapI8vxwVUCfyeCnoVHYonxMRaqtGck47Ar4EThV47ML
	 t3d98rCeW7tUw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6b8m-1qVxhm3nx8-018D99; Thu, 30
 Mar 2023 10:50:24 +0200
Message-ID: <87b65f8e-abde-2aff-4da8-df6e0b464677@web.de>
Date: Thu, 30 Mar 2023 10:50:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-unionfs@vger.kernel.org,
 Miklos Szeredi <miklos@szeredi.hu>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
Content-Language: en-GB
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>
In-Reply-To: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AJA8+YrObkzvlmZ7NffsW9mH1fx+BoG/7tvrwX+FLKqCtceJjsQ
 qsPoMwXazPA9i+eNJW8++9h0NVi4+lwfPx3V4xBAagcHxep4gNUuG8N8u3sbM0uotRVMQAs
 /fvloazZG52R0B3p3iN8VZ7XR3crUVqm6ugXTVOWtj/OZCdbN5Ryfy7xycm0KiFNju2rdBj
 aItGeJwQ7Cu28yry2tzgQ==
UI-OutboundReport: notjunk:1;M01:P0:QCux4JLsH8g=;2TbtwrZYCh/iOv+Kj1B7fiWqqQ3
 mr9MRUNDMVaqN4P9Jj+SeYswFwujv51ZmS+I67f2VjSqix/SB0/X7874BN27FhsXiNcbUXy99
 hDTtKWjINsGg4HFYXgR810GJsdwN9h9EOvhbQR85W4d/t2yDWDB2LNxQGTWfNkDptkNuYt8ug
 IcG3/o9xvuk53Hg2E6tUM+BouvqSM0thQ2mADaM8XbrlAGYUNLhuzTZXsHHHGCk4xhq7rvfom
 jJ/ADZRvRDr+ngDirsSWb47H7FO83FJoAf68mlrmKrJrmvaLeImUD2QgCuzwePwX9X0Aq+Znp
 h/0pqc3VZuQVyEqcM1kBr3yOeyeV/uNL+qMcoQsO3V0dpvcZxJqYQUyebwtRPYhhVfuPT3mlb
 6l8XySHibNcrIhtJdPUEadCFfts9KSohcs/9/zUUou96HsNyq/efW2+Q55UEVL4P5LBl3gB7x
 ZfdbeywZnkcv+e3zLMpIb41GCshx1rw6eO8nxuve/qthcuDVvZWOIUllGbnz/+2iWXw8qyxXh
 g3Mf+jt4vSzVj2bv1JLg8GekQHG6GEnrG1drWjCnIVRnuWA1LroAqEgHD2Aq/nRWr/OcfFP8Z
 Qrx39ustNhXumk0MpLOx4VelyL2PZR1O1TeDtRxMu+riH7eEywN3ObE+39+jCnC/AaWqJhPn6
 4o/vAuJhh9ExM1tUdecEr9Zfirq72IWFCi66EiYHUX43SfqL5NDn6xZTHOlv6ndin6DcHxXPx
 D9XPTMJvkdtjHC8RjYo2RduePGXHJiveBHPcFa1k6/9IGaBT2Ey4JE1EoLvcV8ON7vNUqG81k
 TeyL9bZhKOlX9kd8j66G+uNss0VayBRuVC+VLnFTLb7knqX95wQIcNUFjenLEPyFbhLoIOfjI
 hqbh7hWMiPBvxbSCOZZu+hMKxYcYW4IPjGKDChp/C8VpuCHL8pkwyHF6/
Subject: [cocci] [PATCH 0/4] overlayfs: Adjustments for ovl_fill_super()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 988
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/87b65f8e-abde-2aff-4da8-df6e0b464677%40web.de>

Date: Thu, 30 Mar 2023 10:38:23 +0200

Some update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Return directly for two checks
  Improve two size determinations
  Improve exception handling
  Move some assignments for the variable =E2=80=9Cerr=E2=80=9D

 fs/overlayfs/super.c | 72 ++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 33 deletions(-)

=2D-
2.40.0

