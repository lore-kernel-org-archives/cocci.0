Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BD2FE520C
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2026 11:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=JV/1NFzldWIpdczYNzsW98wdHcKLKiYIDDh1jMcjDAw=;
  b=XKlYvwHdpMZocUEsjSrIY6s+Q2ffR7CTCvys9aQ6+zI83Ta7yDbH7zPN
   2x01od67qUnUQgfvRdMGSStuDoQvSaPrZDS9EIKK1xrAd00FRkJNLXJeJ
   Of6tI2yKElCPYKMwEPITvYAKMu6n8wU5YcZrN5BLzZQU5pYiNm/v0InW+
   c=;
X-CSE-ConnectionGUID: tSa9i0KUT3qmHG0QX0P+iw==
X-CSE-MsgGUID: ApVcw6U1Sk6Y32vZY12bBg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,196,1770591600"; 
   d="scan'208";a="273978262"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Apr 2026 13:20:21 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 9081B816D9; Fri, 24 Apr 2026 13:20:21 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 8897780566
	for <cocci@sympa.inria.fr>; Fri, 24 Apr 2026 13:20:15 +0200 (CEST)
X-CSE-ConnectionGUID: J4+tjenQSQmoym+JmhZitQ==
X-CSE-MsgGUID: ZAeSocOFQXWoZsJBJjjKFw==
IronPort-SDR: 69eb51ef_FD5TPDU9RIs4SAhxE94QXHWc/brII9VjJ61i7rRjLiwuQ9Q
 M9AKkO71GiStIBICq1iZsX48+J0Ij8dXhQxDv8A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E1BAA/Uetpg07ASNlaHgEBCxIMghKCP4FlNAQLSYRYj?=
 =?us-ascii?q?1OCJIQ7hzyHVYh5g1ICDwEDAQ1OAQIEAQEBAQEEgguCdAKNLgIeBwEENQUNA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABAQEhG?=
 =?us-ascii?q?QcOO4ZPDYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBEScECwsaA?=
 =?us-ascii?q?hgOAgJWBgEUAQGCfoIjAQYQAQMPJwe1W4EygQGCDAEBBtplHywiWYFnCYEfL?=
 =?us-ascii?q?4VxgmYBhjGEPycPgVVEgTwLgng+hEODW4JpgiaBDoY+iGtSeBwDWSwBVRMXC?=
 =?us-ascii?q?wcFgSNDAyovLSNLBS0dgSMhHRcVHlgbBwUSISpuggx0LHYOITVZSDgKAUkFg?=
 =?us-ascii?q?XACaoE2GV82AgELbT03CQsbBD2LQCAPhAZvU8cWNAeCOIFngWQMn20GEy+XU?=
 =?us-ascii?q?g6TC5kGIqkfggAigVwzGiSDNlADGQ+OIRmEG8ghRDI9AQEHAgcNAwuBaINcA?=
 =?us-ascii?q?QGMVoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:lH4SyqpoBL2FiiaDz77TGpYaV5r1eYIsimQD101hICG9Afbo8v
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: 9a23:PPfrmW/yzMnrPFqNEkSVv2xIWdwnf3vk907VJF69SkRsSI+UVWbFrQ==
X-Talos-MUID: 9a23:Lz4O1AWmjTpaAxvq/A3FiQplP+BG2pSRD3IWs78kucunGzMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,196,1770591600"; 
   d="scan'208";a="144970385"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGLnbKeW372XLWUz3NGreIe9Yz8XLSeVJBGHZ?=
 =?us-ascii?q?fAaYVTal1oVkY8ZPjirqzqdHGmUVLx5+xbNhmdWxXejCCqCGzxN1YbJE?=
 =?us-ascii?q?kXILzpvQ3k4BzcIddVl1wWr37b7IsRGaGJwKNFjWeTvXKxYyHK2dNp/S?=
 =?us-ascii?q?4AdEe4BT5rFZydHg1fpbayNg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 13:20:15 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRW6Z-1w3mEi3ZzR-00Shar; Fri, 24
 Apr 2026 13:20:13 +0200
Message-ID: <366d74af-0552-4c90-9ea4-4f201f5493e8@web.de>
Date: Fri, 24 Apr 2026 13:19:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <138f6f86-b875-42fd-bc00-f0ad5e1f6f6b@web.de>
 <f93c2682-64ef-7a25-239b-5e7e98144a6@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <f93c2682-64ef-7a25-239b-5e7e98144a6@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WkcEVMw0OHKaSQKaao8PDxj54UyILBpmYpsa1lbXjr3Db982dO4
 s4Y1SpbDxBDJddO57G+iIy9srHAKoPpQwp4zojYaX6izhEYotPe/eNbOt1PBIZ3rLF30V2r
 OMdsi4kL/jXvtqmWdbcpJb+pEkYW8IPXE7gMFkgfsbjLfNjz0opRW2C+LsgYsnYmHUhpmYl
 52e+FjyIjZO3AiGNE3oKQ==
UI-OutboundReport: notjunk:1;M01:P0:HCusKYE1l/g=;SCO1jDS6eqtpY+C6L752Wre5nnm
 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
 Vea8nTp9ktrx8lsa+Cdi04dQ==
Subject: Re: [cocci] Planning the next software release?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3483
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-04/iNOZJ--YzQdu293VWGQrxg>

>> With which delay will known improvements become available for general a=
pplications?
>=20
> What is a known improvement that you are concerned about?

1. We know commits which should influence software run time characteristic=
s
   in more desirable directions.

2. Further software dependencies triggered collateral evolution finally.


>                                                            I think that
> everything that is considered to be working is in the master branch and

There are remaining (open) issues for further development considerations.


> will be propagated to the next release when it is ready.

In which time range will anything happen here accordingly?

Which activities would eventually be picked up before?

Regards,
Markus
