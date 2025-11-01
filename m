Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281B3CCF9F8
	for <cocci@archiver.kernel.org>; Sat,  1 Nov 2025 09:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=aaK/6CXH6ASpGryYyRVYkMSycnj2BZ+MKdyQNNm1x4Q=;
  b=Kk0t7IyUPnymHpeMHd/sNBspuSCOvBpxDsZlrDSQdSR/AOlb2xnFeAOZ
   PZxObuDHQL+mfIWjUKDDoPbMcqxQLjQiyPAjpqZpkdFBKvmyVknmgYKu6
   SHGECT3cLUXzo2l088HnqfPnihnlMzwXbbHY9L78wGcls3y2oFyp3ffAa
   4=;
X-CSE-ConnectionGUID: gzwCR7vyRN+LBzd96TfDMA==
X-CSE-MsgGUID: 3YSyWqvES4exTQ7+C/nNyg==
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
X-IronPort-AV: E=Sophos;i="6.19,271,1754949600"; 
   d="scan'208";a="247089064"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Nov 2025 10:28:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 892C6E0264; Sat,  1 Nov 2025 10:28:27 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 04A7BE0171
	for <cocci@sympa.inria.fr>; Sat,  1 Nov 2025 10:28:22 +0100 (CET)
X-CSE-ConnectionGUID: oguEnhfTQZqrUFeyIahNug==
X-CSE-MsgGUID: 8aguQCmNRkejQu9l+Oa1+w==
IronPort-SDR: 6905d2b3_Fx0L34MmwgQD03MCwjxestR0VDptKrBpCMWXKtrMqgF+VdS
 Jde+RW+0Bc/2g6qxwkZofzspG1mQDXy4CiG0NHw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GCBwAP0gVpe07ASNlaHgEBCxIMQIFFC4JAZSNYMwQLS?=
 =?us-ascii?q?YRVj1KCJIQ7hzyHVYh5gVWBfQIPAQMBDU4BAgQBAQMEhHcJAoxTAh4HAQQyB?=
 =?us-ascii?q?w4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBIiAOO4ZPD?=
 =?us-ascii?q?YJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBESYBBAsLGgImAgJWB?=
 =?us-ascii?q?hUBAYJ+giMBBhABAw8nB7FJgTKBAYIMAQEG2l8fLCJZgWQJgRwuhW2CShoBc?=
 =?us-ascii?q?4h3eicPgVVEgTwLgkcxPoRDg1uCaYImgQ6HZpEmUngcA1ksAVUTFwsHBYEgQ?=
 =?us-ascii?q?wOBCyMPPAUtHYEkIh8YEWA9F0CDSRsGaA8GgRIZSQICAgUCQDqBaAYcBh8SA?=
 =?us-ascii?q?gMBAgI6Vw2BdwICBIIcfoIPD4lGAgELbT03CQsbBj2UUYN/yTI0B4I4gWeBZ?=
 =?us-ascii?q?AyfbAYTL4NxAZNgDgaTBZkGo2iFWYFvCCuBXDMaJE+CZ08DGQ+OIYQzy0FCN?=
 =?us-ascii?q?TwCBwsBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 GmlUVbOwhkRkdiJndsQLTgjssqi6jQyB+rE
IronPort-HdrOrdr: A9a23:/lEj3q/hQAsW7rZ5XyBuk+AMI+orL9Y04lQ7vn2ZhyYlEPBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: 9a23:9Lccf2H0QUVe56AYqmJg+1M5HMArTkTv1W3tDUKpKG9pbqCaHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AwtYUIA/EuJksRGpq3GXjkIGQf5dh7LmXI0Urq5Y?=
 =?us-ascii?q?LufCZZCgzHD7EzyviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,271,1754949600"; 
   d="scan'208";a="247089058"
X-MGA-submission: =?us-ascii?q?MDGJZl+JVCvOxIzBe6NZ3bEO3Qbnu6hd6kLWpS?=
 =?us-ascii?q?7tmvlpYLwPh2Dftpnaycelfz8+LpuVWt3pLoplB2xNDB0JC2ancXFGy1?=
 =?us-ascii?q?8IhrQyO6DlPi6Pq1dDEzxOeJaPf+iFLAUTFumgjPVPtanRcIFUjMYzKD?=
 =?us-ascii?q?ta0AIHNLuvIHhDHdeVAIFMtQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 10:28:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761989299; x=1762594099; i=markus.elfring@web.de;
	bh=aaK/6CXH6ASpGryYyRVYkMSycnj2BZ+MKdyQNNm1x4Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rxykq1ixuh9eclPB3lZTZYCnU8xpbvI4S/zLG5mBzOfCHxmle2HnJeOwSSQhJEoa
	 GEqdGB+Ijhd1hwVSxrhFjzl9UcSdH2crqP8NdLmcvaqX6pFFjwQNVg4vIFndsaKOL
	 E4j1x3oHfP2Vsq0Vhrcws5eAQgj5wW+rkLACSE0rErsHb0dHh74jZdGszdD6j58Ho
	 CJfScPMt8hwsVx7qcTYjThJbGDVXiFNIo/CPn54JWd4uDPXCJ1TRJBe5mCBxRfnWB
	 3cnKIp9W5afWOBkqC0T6Ray4A0od3P5XFDH9B+Agaad3KHI7DP4K8thXcImFGNSCl
	 pIzrfOEoIlhrUIsA8w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.236]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MECCd-1vMagR3plF-003bkb; Sat, 01
 Nov 2025 10:28:18 +0100
Message-ID: <3e448c59-e62a-4199-847a-91c479fe3395@web.de>
Date: Sat, 1 Nov 2025 10:28:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <8586e8c0-a756-4d43-8bf5-2e26fccceeff@web.de>
 <603a30da-628-2e4e-8044-a9b686e42a5a@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <603a30da-628-2e4e-8044-a9b686e42a5a@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fOJv+9AKfxA6Z34NFD2ktSu+kplsQQteAaPjLzX/PXr0ExjqY4Q
 6bIIbCuj56JDs5EK5oMNkK6Z1Ijz5J5FSUpOE2A7wg2b+KBF2SXUeKFiyE27JZO7Y9ry8r2
 Zy8Lp3lZQx/PvSsyunehyIDNPzsOJ0rAg+1EAAaS4wMSm9eUp9pXmYWO/zeTzKfK0SDJtn3
 EA/qx96fZYt8ZwXX7NE0Q==
UI-OutboundReport: notjunk:1;M01:P0:3zD/kMitSCg=;qROUHGlviiTQF2pCS8jmkrsdtRF
 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
 71AnfARJqH47H3h1BUcLADqXhHIDG7Q+juk=
Subject: Re: [cocci] Improving expression list selections with SmPL
 ellipses?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3133
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/3e448c59-e62a-4199-847a-91c479fe3395%40web.de>

>> *my_action("Hello!", ..., ...);
>=20
> I have no idea what you think this should mean.

Can such a search pattern indicate that three parameters (or expressions) =
should be passed?


>                                                  How is it different tha=
n
>=20
> my_action("Hello!", ...);

It is tried to express another constraint, isn't it?

Regards,
Markus
