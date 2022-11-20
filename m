Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76E5C433FE
	for <cocci@archiver.kernel.org>; Sun, 20 Nov 2022 15:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=7LHue1CpNUrH9GohsdGTxrNGuLCvOIKh7LjeumUa3Bo=;
  b=vYc56TCF/n52gmIaOBi7AJuHZFpXbE+YS5Woylvt5q0MFZ6MqLBgCIMD
   V3uuPBgxM1C6zsAMlj3YmQ2yQ/Ns1QD0p7Mqi1I6sy12ebjKU1ENIMbtJ
   F+sMgAgZSGDucqEY711SL5T+jbvDgWLWtM6GibmvH/EoDPucxI7QTNWna
   g=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,179,1665439200"; 
   d="scan'208";a="79131062"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Nov 2022 16:20:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8D921E027D; Sun, 20 Nov 2022 16:20:46 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 833A9E027C
	for <cocci@sympa.inria.fr>; Sun, 20 Nov 2022 16:20:44 +0100 (CET)
IronPort-SDR: 637a45cc_wD8JWGliE/H/lBF1YtQaxylKaktSAdjiRfjStgZowVQjTjm
 rwFvCdL43llxAaaKYjpYjYKOavxZCeBNNuId2nA==
X-IPAS-Result: =?us-ascii?q?A0GXLADcRHpjhwsR49RagQmBUYIrgQdTLgQLRYRPiCGIS?=
 =?us-ascii?q?4RahyGHMIhhgVeBfQ8BAwENFAEsAQIEAQEDBIILgmqFDQIdBwEEOAINAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBGQkXBw4QBSKFaA2CN?=
 =?us-ascii?q?SJ9gQgBAQEBAQEBAQEBAQEBAQEBAQEBFgJHU2YdAQERJzQCJgJsCAEBgnmCb?=
 =?us-ascii?q?gEDMQeyUYEygQGCCAEBBoJhmSUfLCJTgV4JgRQthy8dV4kTEIFVRIE8glMBA?=
 =?us-ascii?q?YV9gwqCRSKOdIkJJQQOAxkrHUACAQttCkobMScOCR8cChsNBQYSAyBsBQo3D?=
 =?us-ascii?q?ygvZyscGweBDCooFQMEBAMCBhMDIgINKTEUBCkTDSsnbwkCAyFqAwMEKCwDC?=
 =?us-ascii?q?SEfBycmPAdWOgUDAg8gOAYDCQMCIlVzAi4RFQUDCxUlCAVLBAg5BQZTEgIKE?=
 =?us-ascii?q?QMSDyxFDkg+ORYGJ3QODhQDXoFpBIEbgQsKnRoBlWCPbZ9ZNAeCH4FMBYFID?=
 =?us-ascii?q?IhSlhQGEy6DZQESknYOBjGRYx2XF6I6hT6CEAyBXDMaJIM2TwMZD445hAyKL?=
 =?us-ascii?q?EA0OwIHCwEBAwmFRwEBhRkBAQ?=
IronPort-PHdr: A9a23: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
 D9hbwVSo7fW4S4K2p2X9ERe43AjIeTWwk6k
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:hJvuKavE2Plxicrk10+rIcoo7skDVNV00zEX/kB9WHVpm7+j5q
 OTdZMgpHjJYVcqKRUdcLW7U5VoLkmyyXcY2/hyAV7AZmfbUQmTQL2KhLGKq1Dd8kbFh4tgPM
 lbE5RWNP21K0RmhsDn5wSCH88n28TvytHRuQ6T9RZQpRoBUdAH0+6VMHfjLqX8KTMtOaYE
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,179,1665439200"; 
   d="scan'208";a="79131060"
X-MGA-submission: =?us-ascii?q?MDH4Ic8hXH9MaAIIs1Jbruz6dvNXQ31Tcgcvqv?=
 =?us-ascii?q?eVUDcf2kddmTW4vZ7ilewHS7jHzITAPjyXJrE2W9WWFQWav1PmUHbnhS?=
 =?us-ascii?q?/qbFKASXeKSpd3/Nny5/Dk1/DVKzxwsph6q+p+gKXlB7T4Bbkppp3Vo+?=
 =?us-ascii?q?tj5qYjcPzXOBM+kYT0gzgVLQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 16:20:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1668957643; bh=7LHue1CpNUrH9GohsdGTxrNGuLCvOIKh7LjeumUa3Bo=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=j7rjf1YNQgLvKKYSachWAKk2J5iupXAGDa3/cH4ZuP7kgeKPsTaC03ZxKwWW+RJOV
	 PcPpoFqpQKH6y62htCxFOgXfd8JQk7Pg5X04UY3R7T1Omc6Vz2xa46Rs7rQfnOZ/QI
	 8MctLnKTGsSzkyjQWfgf1DitMOPC8TaTa6Gu4BATbLeE2rEQyg1uNpbA6vWtvA6aA1
	 MeybtvvRHeP7xXf8ueuNaG7mIq4+rGml3U8MFy28zevN12Qz80rsLQ/BTbJcb+gQav
	 pkDNlpsWUoC2FVzTc3MsJYRSMPVNbBwgTiF6BJI9atw3+6g0MwB7zQih8MSJzpn1tj
	 XaDjx5IclN61g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUCuv-1oW4Iy1iiJ-00RU3l for
 <cocci@inria.fr>; Sun, 20 Nov 2022 16:20:43 +0100
Message-ID: <dce20c86-de6b-92ef-3bc3-af39ca99b5c4@web.de>
Date: Sun, 20 Nov 2022 16:20:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:xUhRUjRBjbzqidDeBN6/K+o4BwJLOigqVlaGbf21m7yYsHcgeXG
 nFGyN1RPV1M9xxxRK87WC7/OGnf7gkpBCwFq4bTSzUzQRRRJVXOYtm5AZtzc0y9sk+Z2nyW
 5L4PL9PomSz0PO1/+Z882L3603rUOHJ6Ela5A+1LUEIyjb2LwqFR+DyRwYX53MMODTC+V/b
 XeVbePfyBXMkLSU+R+0nA==
UI-OutboundReport: notjunk:1;M01:P0:73ruvOqJkUI=;dPExsO24rSSHp1IbzQHN+jx/Cte
 hyeNbIKaX+yFpUAXWynCZaaBzqGf88YN0PrC08leJvcFDo97ekpgyz7azK5E1OPenghtirqJz
 7efwDB4j3we619kQaBcOOJ0Fck0aHk99zAn3oSfs4sEvsldoC98zfLdZRAIJJYMuqfxzSC+Co
 lHnmjXVF9Yn0Mi6UiWOIQr8R1q7RL2qVEFmwVFeH/YEJwCa1XLZ2MhDJ1kHD5pe6Y0iDDxFhp
 5is7iolRsShf4jX+j7/GejD6lYmBg5L9uGSCM9XxkOKK8CDW4Bm81w3R87l5SYW3UkNiQclJq
 XmHz8ywOOy86grgTDvxQi4IGF9ieHoX25Ss5+ZiP0mUEJ84WFmazruMRcGn1hy/BpYKvmykUM
 HJEWjmccXidm5jEFEC4etTd6SNhbJZP687zVV0rUp+dTR0sTLw799wq9f437xn4+DWmYG6GsQ
 KyKcb5vH5PEe7O2y7pj0ilXKIK/kSGByvE00dtcVZ9mTLs5kwNkUDKfpYI3kmV3lyYyTzcbI2
 yruSN4DW8hb26Uxvh40ZTnYim5gX0RZda9Y0++gaVs7EHQue34F9YWQCoEi0juIbXI8nS+qxB
 N+CKH7cEf4hhcec3b0TtDk99ADjdWMTFVmL7WbMc7RI2bxI4+CQv/Bzp3Hd4k/zcaDuIyAv1a
 VyeOTQARMRDO7VabAFqScjD7q90pdRXaIyyrGxYzRWdxq0DmF1eYx7ISYdRl6hjyaTqgvW01M
 rdr+HBhj1YZXSauPeudW4A18e1HFvlSyEhZ+FfNPk9U9ea38yRiqENBRfHp4zJ8FZJoOTk8YX
 pVUFKyGZ5xjR8XgWcvCPkvyBFDrN4OJ1zoWqsXhyU262UPgYRPOPA5E/XXYWtmRBSxfhKmLHy
 r58akMrUtyQruy65W/5CzF56nWGXQmgX9PAXRcMiJ7Xy54784Y1gHyUEiNmgQsTQKUzNJjf7d
 YTT9Zg==
Subject: [cocci] Data structures for source file analyses
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 751
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/dce20c86-de6b-92ef-3bc3-af39ca99b5c4%40web.de>

Hello,

The semantic patch language (Coccinelle software) can read some source files.
They are converted to internal data structures.

How do you call the intermediate data representations according to the involved
processing pipelines?

Regards,
Markus

