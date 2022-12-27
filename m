Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48DFC4332F
	for <cocci@archiver.kernel.org>; Tue, 27 Dec 2022 11:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=aL0pKCLIsZ9fCH9YMGn9fO/HE07eRMjemi6L/kxBBOc=;
  b=Dcq18hyhQx4wCrBv69/6o6W0Z7IKAcHGTR1Buhv79o3DfUZee1pj8w4o
   g2R8VDb+NPBWaFgDzCokV3aIhgxQ/SbYw5VRC0/gaN2S31LjzJc1ImZ2U
   WAF/RwZJXdhKVJmKM/0C/Zoo1LIEwOWhYNIjw1Kz/gfIBgor95BxbDm88
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,278,1665439200"; 
   d="scan'208";a="85149459"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Dec 2022 12:40:19 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9FE98E0141; Tue, 27 Dec 2022 12:40:19 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EA9BEE0128
	for <cocci@sympa.inria.fr>; Tue, 27 Dec 2022 12:40:17 +0100 (CET)
IronPort-SDR: 63aad9a1_GIEzsk5yhGi9zDrP2M5bQDiUQUHkFbaRavVwqHvRRQwrS4B
 ZNQp4c4v8UBj9JVcto5x7tyNJLlK0fh4HgoB9oQ==
X-IPAS-Result: =?us-ascii?q?A0H1BADo2Kpjhw4P49RaHgE8DAILFYN8gQdWLgQLRYRPj?=
 =?us-ascii?q?nqCKIQrjlaLeD4PAQMBDT0EAQIEAQEDAwE4gVOCcwKFEAIdBwEENBMBAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEaCRcHDhAFIoVoDYI4K?=
 =?us-ascii?q?QERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QECR1M9AQICASMdAQERJgEPCxoCJgICVwYNCAEBgnoBgm0BAw4jBwyvBYEyg?=
 =?us-ascii?q?QGCCAEBBoFAARVBmXEfLCJTgV4DBoEULJApeicQgVVEgTyCUzA+gmIBA4U1g?=
 =?us-ascii?q?kUijmSCf4cxCoE9fIEnDmQlBA4DGSsdQAIBCzsyCkE1CQIMSysaGweBCiooF?=
 =?us-ascii?q?QMEBAMCBhMDIgINKDEUBCkTDScmawkCAyJhBQMDBCgtCSEfBxURJDwHVjcBB?=
 =?us-ascii?q?AMCDx83BgMJAwIhUXACLhETBQMLFSpHBAg2BQYbNhICCA8SDwYmQw5BNzYTB?=
 =?us-ascii?q?lwBKgsOEwNQgU4EL15/CgYpKJpmgwFZggSjLZ9xNAeCIoFPgVAMiXeUeAYTL?=
 =?us-ascii?q?oNmkxAOBpIahROSM41GmjiBeSOBXDMaJE+CZ08DGQ+OOYQMgQuJIUA0AgkwA?=
 =?us-ascii?q?gcLAQEDCYVHAQGGWgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:fEcNoaOk6HqjG8BcThWjsMiBIKoaSvp037Dk7TEVdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YFT0EUMr3N5DZB/KTHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,278,1665439200"; 
   d="scan'208";a="43692595"
X-MGA-submission: =?us-ascii?q?MDHVyCxLnHVK6iC81+3XjgdRbVzKoE6F9+t8qx?=
 =?us-ascii?q?o/+2nAcpHYHq0T1h5Gkz90EssoDmAPWY+ixk3ejBmYYrQFyPJHyQ2xye?=
 =?us-ascii?q?xQ5shpKcaGQmLfOgzeaEotUpcsHwceBHOVgptVvqdwrPElZ4lUVFK7dj?=
 =?us-ascii?q?ZMmjQllHID32pUt0+HTPJYyA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 12:40:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1672141216; bh=aL0pKCLIsZ9fCH9YMGn9fO/HE07eRMjemi6L/kxBBOc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=j34WUftddhbrtM2el4ALKNv8HEcQcfBzFv7R7jAgMuszY6TRLiq1PdRpmBFY7AA0t
	 qfulgK+xbVF8PpFeEifRB1IYwgoDLHTzBTma7auG31N7qmQlq5rD8w55JxWpfxbvwq
	 8mN+13z4M/8pKGhuBqzMz8nLX8W9qgUq9emNdrXd5+B3k8TsPn9mIRKwjxSvKscJLH
	 JpIo5prem1NC9V1I53Vrx4U6Py5W46F65Wz3wOdlyQgmpX+I96LCXHLmbz9I9T8XbO
	 IhjBMeW+ccTdVX8BZGqj3W1Lv4EOZjpbFBCjvuxLedaYcp3l5p+a9Up6dEsYONaJUG
	 GxL3aC7CSHp6w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mfc8y-1ocyIS1or2-00gDtd; Tue, 27
 Dec 2022 12:40:16 +0100
Message-ID: <4ee46301-0ce0-58c6-38da-4d87dfbaa5b4@web.de>
Date: Tue, 27 Dec 2022 12:40:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <7da2d07d-c1fb-1a58-8b57-3d1248f70c87@web.de>
 <alpine.DEB.2.22.394.2212260740380.2980@hadrien>
 <ae73c3b9-1f8e-4069-5bce-9380a187e1ac@web.de>
 <9fcc50af-da1a-6d71-934-b87d383ed38c@inria.fr>
 <29059e41-6c8e-56d9-48c0-d4cc61e02e77@web.de>
 <alpine.DEB.2.22.394.2212271047470.2927@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2212271047470.2927@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:6k10wVcGYHq1JelkL4NVBHer1+Kdvz/+bUxhG/468k2MN9lNqeG
 aC4Cx4ITI5LlTE9Pvk3UfQO9dMHTEtxKhtAsryb4Lo0+RCZlpOaoAI90id+q3ro7fgBbHKS
 zRtN9rD9Yd5tiyOuNMdKp7PdhsrlY+33qD4zJQZENlSU1Djlv4pfZWcUw9ckcgznNQhfg6n
 U/mE9Yme1B+KVaZ5eAB9A==
UI-OutboundReport: notjunk:1;M01:P0:oKHxfkjowCI=;0127tLYrrnEWBopc6CV59ia5O66
 I3+6sf9930NwFD+o+V15U/ThCI//xja+aUrHoHaPzkFuTEPn1R0j9uzys29czhOdROepPHQr6
 7zp6BWYxoLuEbqGAq+r5ffda6Md2vGbmOvkSCcmIW2VTkEy5f+RkM/5UEWtN6f2s/VdY5a/pe
 /FXr0w9MopCgUh+uU23u/EUDCKWQ5mJFJsXppPCDOWYDH+zMcTkFZ9TQmrABFVIaDMshYNjBN
 p1w23GQhZrM9NV/Z44aKYzQK7NDfPsOnzITlNoE18oZg7q59a8NklE6PRBIHQE/hBBccGEnxE
 yDmhqNcLm4Iqlkl6V9sJDoY3LfEHeD5geVY1Gcn5Vap9JR3EDEOamMF9efQc8Tulm+8lQHFw0
 uS/2D44pt2KjvDIzfGDB0E1uiNgg0y1SCLxne9T9aid4eOpfNnyse1amfIquCjjJTyC05eDcm
 QVOyD1ZIIk5GBxtt6+AM8e7J/jtKdpBNCIuugPFDeY8k2WN/IflTb2A+K766JKoiG0f7SZbw3
 cW2u9m3Hi19r63OrhTp8kArFojOeo7/B0ylo5RfMjTeCmAo37y2lFito+h5D2lf79rth/Iyvb
 VNAPqK+9wmQTcfXBlRrRyF+U7g2ZjAojjFFpO26IVZWiZ+BEtVKTR62DE47ZZLVLvDb+yL4dk
 c5HwMOUAjE0BC+SYevKXY69qhHsC2ougIoLnkoW6JdDEqRjRavpjVke7xkGsZn4tXHEU9XAmh
 bY+kNK28eMbsxNu/4kWZSHWSF+0ZBMzOnOfdBbZZsOfcdRxB6F+1andma28C9HpUOHCxKtfG1
 0Zr8zaoDNDUOoom7c9Q1ZZwCwMh3EmTZR5GP9LOVv0sQN1tTFEJPKkKGGXULCPc3TirSPZsvN
 z6SnsBaZ8efq8IHA6iDZKXUiSR4z8fAKKm7y0W3j/7qsroq+TR74buPMCY8mXrbsIQr/wdm0q
 0Pw75A==
Subject: Re: [cocci] Another extension for the software documentation
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 801
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/4ee46301-0ce0-58c6-38da-4d87dfbaa5b4%40web.de>

>>> Lists can be empty.
>>
>> Are you going to add this information to the SmPL manual?
>>
>> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/87350d742df39d847b15af39865329c2fe23460d/docs/manual/cocci_syntax.tex#L315
> OK


Thanks for your tiny documentation adjustment.

make clear that list metavariables can match nothing
https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/b9603af4eca7f4c771d57a3861855332e9bb1c4c


Can it occasionally be required that such list metavariables should match
one item at least?

Regards,
Markus
