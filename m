Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5D2C87FD2
	for <cocci@archiver.kernel.org>; Sat,  2 Aug 2025 19:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=r6rxSJrXdSWKVftEoHHdCbN/Ktpemqt4fjjNJtNpxvU=;
  b=cnkwQ8f/MBGSKEhM8Qvza57/QNMmS/6zy1Vh0SXaKJwxov0BsfOeonw4
   qiES+kKzUUs8ecojcjfazYARfp3uElleylqGB6GREbperI7mA18lF7pIZ
   fQmm7pc40x46GvnGFXGDqs2KLg5waRpttzPioZz4ENJ+8BpuLJ42Ke8b4
   s=;
X-CSE-ConnectionGUID: IUZx2FfGRmiyfgsKnaWJ1g==
X-CSE-MsgGUID: /hcAe+y5RxG7hcSR3p4lUw==
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
   d="scan'208";a="233972188"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Aug 2025 21:48:22 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A1773E0B0D; Sat,  2 Aug 2025 21:48:22 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 44823E0171
	for <cocci@sympa.inria.fr>; Sat,  2 Aug 2025 21:48:17 +0200 (CEST)
X-CSE-ConnectionGUID: ywmcfr7+RfCHwB+wreMgmQ==
X-CSE-MsgGUID: DoW/JMM2Se6WCcm3cJaikg==
IronPort-SDR: 688e6b81_CMnb3I5euoyyElDYu45tGgDExfd+Sa3Ljj2RGvKO6JNLoXB
 aYGoNw5Fy17aFAbbGUkbAId1y9urr9+pJYW5UtQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GSBwBjao5ogAQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VOCRIEGVDMEC0mEVY9QgiSEO4c8h1WIeYNSAg8BAwENTgECBAEBAwSCDIJ0A?=
 =?us-ascii?q?owaAh4HAQQ0EwECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QE7Bw4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBESYBD?=
 =?us-ascii?q?wsaAiYCAlYGARQBAYJ+giIBBhABAw4kB7BLgTKBAYIMAQEG2l4fLCJZgWQJg?=
 =?us-ascii?q?RsuhW2CZAGGJ4NCeicPgVVEgRUngwM+iB6CRyKCJoEWg2M2gjOTC1J4HANZL?=
 =?us-ascii?q?AFVExcLBwWBIEMDKjQxI0sFLR2BJ32DDYEOhCcrT4IidYF5QRk/g1MeBm0PB?=
 =?us-ascii?q?oEVGh4tAgICBQJDRYFgGQYaQAIBC209NwkLGwY9k1SFf5dxmwmUYzQHgjiBZ?=
 =?us-ascii?q?4FkDJ9sBhMvg3EBk2AOBpMFhTyTSiKpH4F/I4FcMxokgzZPAxkPjiGEM70uQ?=
 =?us-ascii?q?TU8AgcLAQEDCYVGAQGLZYFLAQE?=
IronPort-PHdr: A9a23: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
 10XzLm+IYlBbuXG
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:eMxniqwKD+xpODLpZ7RKKrPw+L1zdoMgy1knxilNoNJuA66lfr
 OV7ZAmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebjN5DNB7foSjjPIcOoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: =?us-ascii?q?9a23=3AJ1UjLWiDPKSJtizf/dBqud7NQjJuY2LYx3nKfAy?=
 =?us-ascii?q?CB01JV5fWVkWd3axhqp87?=
X-Talos-MUID: 9a23:0D+SxAkYkhhWVtsVvQpadnpOM/gvwYGLUnsAz6otsMzfPg55OjSS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233972185"
X-MGA-submission: =?us-ascii?q?MDHbtIKEKstoCdw2AsY11mg/ncAHOZ8c//XQrX?=
 =?us-ascii?q?rHVDVikq6Q0eOH4kFARACy46ULfJREaIb22NMsVjR0snqfWPfMRIEsbe?=
 =?us-ascii?q?O8w9C+xDGlZ4Fg+oRKiPXhfTfriXcrMUcoLoCaEkPA/MMukioI5r22jr?=
 =?us-ascii?q?Gixq4IKLwuLQjE2hPs3c87yg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 21:48:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754164096; x=1754768896; i=markus.elfring@web.de;
	bh=r6rxSJrXdSWKVftEoHHdCbN/Ktpemqt4fjjNJtNpxvU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=luomQ7noZRYcuRWrpcpyVojfJYiEqQEpEIaks/olBC+WIbdXNzp8lZMlrp0WW/Hi
	 yUEhmqrAo87ReTxCUqlfDCC+C6R8bAETwRkG+BHLC1GyoKd855wtYUi+gM7DqaoGt
	 4eGhXJ6jh7cuIPO7H/tpca24p9UityZcjLADpHQ5ac/uJI1FDBqyy1Qvf54+Bl2Ap
	 +yN3Qjm5iqEMzLcAFR5OR0b8dTPJJxwoRKX2thPP6c56OD+8tKSON5llYDLjSvD/+
	 nbErGVKturiIkcypFe/90omOVmZg1yM/ZArK9u7MLQ4ekZvstkXBocwfywd2f+oOU
	 KvSfzFXV6FAe5laj8Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.1]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHEbk-1uvTTz3aqW-000sov; Sat, 02
 Aug 2025 21:48:15 +0200
Message-ID: <9c2cfb6f-a29c-4d5d-98ff-ea7af654b9c8@web.de>
Date: Sat, 2 Aug 2025 21:48:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <alpine.DEB.2.22.394.2508021353080.3428@hadrien>
 <e0519749-0043-4cb0-a12d-6a34e2076f58@web.de>
 <alpine.DEB.2.22.394.2508021409080.3428@hadrien>
 <c5042d2d-43df-4276-9611-da4f30763940@web.de>
 <alpine.DEB.2.22.394.2508021502250.3428@hadrien>
 <6239d52e-3213-4083-8d97-9b1f59d2d5b4@web.de>
 <alpine.DEB.2.22.394.2508021745180.3428@hadrien>
 <2130ab11-8ec0-4e57-9a73-5e1ac9e41f7f@web.de>
 <alpine.DEB.2.22.394.2508021803360.3428@hadrien>
 <51664351-746c-4d7a-ae45-2a610ba45176@web.de>
 <alpine.DEB.2.22.394.2508021822490.3428@hadrien>
 <5e8e1f8a-6832-49af-bca5-41d2a13b1322@web.de>
 <alpine.DEB.2.22.394.2508021935250.3428@hadrien>
 <a86ce687-61a5-4e52-92fa-6a0d53db9360@web.de>
 <alpine.DEB.2.22.394.2508022111230.3428@hadrien>
 <7743d469-fc0e-4575-b05d-72a072c1bbb4@web.de>
 <alpine.DEB.2.22.394.2508022133460.3428@hadrien>
 <62af4001-9e69-4f0e-929d-f748916c7a71@web.de>
 <alpine.DEB.2.22.394.2508022144380.3428@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2508022144380.3428@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Usio3wiwKhDkbQ9cvnnumXVCqcZQEJmEtKTMsG1mdi60CONJJqJ
 aPbuwoOEWf9h3FWg5pyLByee0s2gIpfZYRb3JKfvARwZfrrNFv2kbRc5sVcbuTmxgNyibIL
 XYTdGKZ7r1JP7FaE0yKIPCb0gmjiB3f4dvEF1nYkbava47UtKzD7MBiCEqiVeKhg7Ufyakw
 7kz8mqzJWwUuHM6aEWpcg==
UI-OutboundReport: notjunk:1;M01:P0:oXboH9WHO+A=;RP92A5eRvSoaHfQrPTWslJo93vj
 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
Subject: Re: [cocci] Evolution of software documentation?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2951
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/9c2cfb6f-a29c-4d5d-98ff-ea7af654b9c8%40web.de>

>> Are there further clarification opportunities?
>=20
> The paper from POPL 2009 explains everything.

I got an other impression.

Regards,
Markus
