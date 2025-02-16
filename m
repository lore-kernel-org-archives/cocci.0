Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C493AC02198
	for <cocci@archiver.kernel.org>; Sun, 16 Feb 2025 09:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KMfBdVxOdGOAu36mEZ/YEMrXCGsUsk6Ma2NHmmsQTVQ=;
  b=CzCwWZ16GDYHuP7QYe1GZeqQPaCl9K99jhyOeubKOdt6JrqvOdh7ki5+
   iwme5fBG/8YcIL9CDF7XqUgaIb8FomHsVN6hxXAmZ8qKkCp71spOsB54T
   UiNbCrblxLmVMJ/JRAZKtszJV9kclJXiRxUIsmAw7APWSelTmwPLeN/fy
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,290,1732575600"; 
   d="scan'208";a="208483583"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Feb 2025 10:15:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 27924E0D1E; Sun, 16 Feb 2025 10:15:21 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1BBD3E0260
	for <cocci@sympa.inria.fr>; Sun, 16 Feb 2025 10:15:18 +0100 (CET)
IronPort-SDR: 67b1aca5_EFbmk+VEbolEUt9iHbLPn5IzzS1EvAuEXsrZll5VGfQob+8
 +KBztcBcScNWCtpKxWzDJSpJi4sYA8OuVsy26Zg==
X-IPAS-Result: =?us-ascii?q?A0FrFADlq7FngAMP49RaHgEBCxIMQIQXYnUzBAtIhFaPT?=
 =?us-ascii?q?4F0MIQ7hzuHU4h1g1QPAQMBDUEBAgQBAQMEggyCdAKLCwIeBwEENBMBAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CYgGBJIEmA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREnBAsLGgImAgJWBgEUAQGCfoIwA?=
 =?us-ascii?q?QMOIweufYEygQGCDAEBBtpcHywiV4FlCYEaLoVsgmMBhiaEPCcPgVVEgTwLg?=
 =?us-ascii?q?kcxPoRDg1uCaYIzhEdniWeIaod7iwRSexwDWSwBVRMXCwcFgSlIAyo0MSOBI?=
 =?us-ascii?q?wU0QTqCDWlJOgINAjWCHiRYgitqBAWBLYI6hEOES4VaghKBXQMDIgGCMXB4H?=
 =?us-ascii?q?IMeNYE5gRkdQAIBC209NwkLGwY9oC6DOXSCKsdnNAeCOIFmgWMMn10GEAMvg?=
 =?us-ascii?q?3ABk1IOBpJ7iEOQOiKpDIF+I4FcMxokgzZPAxkPjiGELcYZQjU8AgcBCgEBA?=
 =?us-ascii?q?wmFRgEBiniBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 ajZiF2omH2GdHM=
IronPort-HdrOrdr: A9a23:vhf1GKv4ytNWV5Lc2MYsBlps7skDqNV00zEX/kB9WHVpm7+j5q
 WTdZMgpGbJYVcqKRcdcLW7U5VoLkmyyXcY2/h0AV7mZniAhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAb0+40MGem+lYdfng/OXPVLu
 vm2iLNygDLRUgq
X-Talos-CUID: 9a23:0aJB1WPtsmx5oO5DdQdb3244QuUZaWDH6VL8D36ZU21sYejA
X-Talos-MUID: =?us-ascii?q?9a23=3ACkOgjQwUVcQsZY3fjx2PoZudTMCaqI2tJwc3gJM?=
 =?us-ascii?q?BguOVNhNiBxGUsB2TSJByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,290,1732575600"; 
   d="scan'208";a="109232599"
X-MGA-submission: =?us-ascii?q?MDGd7S4BDU6NN6AhLl9Rw+hvWbFScTCVDGgq21?=
 =?us-ascii?q?H7p5P4ahDUaggsGPcddFn3VLjsMSYem+SGVL5f8/soypwkRjEqq6Lpn6?=
 =?us-ascii?q?7dQML5y6uwpfr4JPLIvFbH4WLk6LKQY59NSUBLPl+MAG4F4PzvJCZ1P7?=
 =?us-ascii?q?d6KiAlKzdQIUCxat6GDmoipA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 10:15:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739697317; x=1740302117; i=markus.elfring@web.de;
	bh=KMfBdVxOdGOAu36mEZ/YEMrXCGsUsk6Ma2NHmmsQTVQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MWFw8S0ZfUe9NswDqq0m0KrhwlSG9BJCoEX9KnG48eWWNOWo8QcjJAm6wTb7LuW4
	 raiC+fyqZGkfSNi8UYJsgt7G+z/SxTb8hKHucylC9QznkKXuy501oJYF2pDYDeqI6
	 czWRzpe9RGZSDvtqy0Kf7nV3Ch2MBh2RGvnkTq47FbAAhKIxfXMOHLaslvqw5U7iH
	 Dva4Rp24gSsxjJ24rAzD6YBNtEIrD1wW5pnphmG/GlvLPMIcpfKdIbgsYU8SuKaYW
	 9EdbdLUv+WBy5jYhdJVJ9Yf+Hg2v6BRGE08m8+L1bV3j0SCATxmFMZyZAEnRyfsnM
	 pazx8ye+SzUM34uk1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.29]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIL4K-1tXTFo3dqO-007fwa; Sun, 16
 Feb 2025 10:15:16 +0100
Message-ID: <58372589-d18b-4f68-8867-d1d24802b65f@web.de>
Date: Sun, 16 Feb 2025 10:15:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mats Kindahl <mats.kindahl@gmail.com>, cocci@inria.fr
References: <592e3d24-4d42-43c7-9874-8c8eb1e12deb@gmail.com>
 <alpine.DEB.2.22.394.2502152149070.17391@hadrien>
 <289696b5-d47e-4acd-90ba-89665ea8708a@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <289696b5-d47e-4acd-90ba-89665ea8708a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AaUBuhETe7xsouBbNjRGONvVAvdtsHPwVZuPd4SeO2TjmcZqWo7
 Qxn+1t1EOjy32vGWms5bNU1qbNFMlwbry5zQO8mmvGBLU89vwnEAqNZ02vMf1TFGyq3mNFp
 tXCxEH+/WD/pBhLjv5n/JHNMAr4R9u7Yh8Tj3Jh9YbA3Ob6WQLFEXdmVb0TaYPXWfl4TKiP
 lrSOkkSrEZLZqHVdI2JwQ==
UI-OutboundReport: notjunk:1;M01:P0:OgCHcGso/uM=;VnSsS8wS8IWg/QkXRojvSPJ5Tm+
 Gtui4If255pDQgeNPVVCKFnMcYRhXsk+0ptXn91gq+PPM7toY7c4BPvLwsU9CCB2C3lwSZEzW
 PdUTc1Ja2XdFPlHS+9KfQZhhKPDNDZ6TV0BAKVw/iSzkGDbXqxaFNaKZ/0PPcW2w72283kBN3
 DNrH9Cgsf1cnweGvBZR1fKjIFo9KLsHDq18+kAtLPH/Vkn+zSov8TAQ9ltHJZ1wfhNGxYVKxI
 F8o2MhUlGLd8bVB94B77XywsEdFluQOWFp75aWiiF8U23bagWNEC8jTml0kgSpYgej7dqVyAR
 2lNiOIoXETfBHomRYybQX8hq3QeDbhl8D5orZDD21JNub85lP1KtWMQux2w7tf8HwzgJOhWhA
 eh6rfH+cia7yMlJ5dqjYTJkWrw21N59uJVR4BgZVfA1R2BxHB7q6UoPRV5EknK9ZTM0KNCNZF
 farn7StvuxCdRV/yNNhxCh198dePgxwqDcVqzUTsHhH/V4gCVo116u8nQ+Kopwqwvov2oExEq
 gjkFNSUOUWpF4WE43eq3QyYzvjBCP8Z94RUmUHGX0FuJiR9eKzKfWoT7E5kQBsSHcj3XPb8GU
 3EqmP9ctkYSNxCllrBVTVzleNxqt4RgXUIXCPrqCFUKQH4bW5xWaSJj7dkPeMQLIyU65AMkEA
 xVbpchqFfPjQbFnrrpAUI2C7V7nuqcptwqSo/mXh4L1wteUxHGdtWnmyv+vgaGM2xELJGraTX
 6Iljp3OyFL3y9mH0p72D+yB1WjBuzOZ8Bx9PxrAoRvNsMbgdAbTce+Tvrc5pm1/93XlViSGAv
 BvQmvYdsdNw+pKU/RR3/t+a6HwT4Cia8uwHqhMMpXiyQ8BEKbTQptNx02bRE6kSTIkR46QxX4
 RDP8OZQomeUg+ETvkLnAs2NUeYjRnxaQ9EatJtwYS5V7rH2gZ2Nlkdsg83uA7bdzBP0TV7b2j
 SRqS9LLFkzT0+roXeQvhzDEQBog5+YvUNNtTYWpKc0jGoyaiDMfCWHB8akUFCddP4sGWCAzE/
 /eVvQFdE62IVKt8yK+IsMtJR925INFNNo0V+9nbo/p/27P+IXKFHfv+z+MssUJZdJT25+csod
 CE0EmSvibyPIjKdbA65CyeNY0nO7V+khlIxA6iaralzqxVmKaYYBHls7n1KL6vxJxntRcAKN6
 kxA5O4e4dkmcLHxOxq1uqHNzOHTd4B/cOp5TiOTGy0bEMR7TuHPnsPxKuRH0JDlbrCjZafLTr
 EvZaebY246GbQyRIiErGWvt2iqG7CuzkDriCh6fHunlNuNoPs91HbdrgBhk0rcvV57fLg8OVf
 9vCx7A1v0f/TDxrcPTwwXnnE7+P80J/H2yzAP+uwx2ESVnzNtTgpeIDmGdNNMKDqvf8/BUcIV
 e3Nfnu0cpJvf1Ah/D4vvfZL0ZKBnsDBvRDEElKEH4F+A/uvqrWteZDZjxYklv0okdVOKjLk44
 gxvwD4YGEpSIz0kCzCpaP1NgXIwA=
Subject: Re: [cocci] Adding statement after declarations with zero-length
 match after
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2423
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/58372589-d18b-4f68-8867-d1d24802b65f%40web.de>

> I tried this approach on a large code base, and it seems to be significa=
ntly faster. This approach took about 2 seconds, the one I attempted took =
more than 2 minutes. Going to check that it matches the same=C2=A0things,=
=C2=A0but=C2=A0otherwise=C2=A0this=C2=A0seems=C2=A0a=C2=A0lot=C2=A0better.

Would we like to clarify software run time characteristics in more detail
with any additional tools?

Regards,
Markus
