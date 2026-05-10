Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21187CD3427
	for <cocci@archiver.kernel.org>; Sun, 10 May 2026 11:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=c8qrkuQ5K6dhNQx/fbLxXNtogALK4B8tyywuVisJ79Q=;
  b=Fg2T73ijIp8z5oeasnHcg69vhnW/nPi2jSxIlBf8VNrJKliknnZ+e8gI
   l6dZufJnDuatbP37EOytU2LchoCHfjITY7qNNAOGqoJjqzIReHAxQqOUV
   nNk+nNPD3No9VJAeeYzyVexj9fOHiZHvrYWEFzgwwRgOiMgWjdEFI1u3/
   g=;
X-CSE-ConnectionGUID: oGT7CSLFSByvLkgSkD+bVw==
X-CSE-MsgGUID: d+5qQ3T8TFW5f1WGEnH3Lg==
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
X-IronPort-AV: E=Sophos;i="6.23,227,1770591600"; 
   d="scan'208";a="276026027"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 May 2026 13:42:26 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 2558C812EF; Sun, 10 May 2026 13:42:26 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 40B6F8126C
	for <cocci@sympa.inria.fr>; Sun, 10 May 2026 13:42:19 +0200 (CEST)
X-CSE-ConnectionGUID: dM6aBS9tTCWakSXJCLtwow==
X-CSE-MsgGUID: ZlwRi8yYQcm2nIub1sdKnQ==
IronPort-SDR: 6a006f1a_QfQXJgAf09/bqTV7lwTfuzTQJTxsoKurHlt7cY5Oi2BgK7y
 e0zbj7rRv3cByAKnAee7fo8PCTmjV0Rm7o1rNaw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H1AQBObgBqg07ASNlaglmCQYFmNAQLSYRYj1OCJIQ7h?=
 =?us-ascii?q?zyHVYh5gVWBfQIPAQMBDU4BAgQBAQECBIILgmoKAo0zAh4HAQQxCA4BAgQDA?=
 =?us-ascii?q?gMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEBOgcOO4ZPDYJiA?=
 =?us-ascii?q?YEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBEScECwsaAhgOAgJWBgEUA?=
 =?us-ascii?q?QGCfoIjAQYQAQMPJwe1G4EygQGCDAEBBtpmHywiWoFnCYEfLoVygmcBhjGEQ?=
 =?us-ascii?q?CcPgVVEgTyCUjE+hEODW4JpgiaBDo8CUngcA1ksAVUTFwsHBYEjQwMqLy0jS?=
 =?us-ascii?q?wUtHYEjIR0XFR9YGwcFEiEqbktkLFwaAwMNITVZdQoBSQWBdAKCHhlfIy8DT?=
 =?us-ascii?q?oEFAgELbT03CQsbBD2LPB0PhjTGMDQHgjiBZ4FkDJ9tBhMvg3GTYQ6TCx6Ya?=
 =?us-ascii?q?CKpH4FqATeBXDMaJIM2UAMZD446hBzDV0UyPQIHAgcNAwuFRAEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:VUuSpaqwOeVSqMGrwIEeh9gaV5r1eYIsimQD101hICG9Afbo8v
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3ADppogGpE68h0YAGAug9hujnmUcwALHT39ybMH2S?=
 =?us-ascii?q?HAGVSeJ++bUOP/7wxxg=3D=3D?=
X-Talos-MUID: 9a23:f0ITxQumq56TSslCRc2ntjV9DsY48pWXA0VXl7QbsZCfOQ92AmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,227,1770591600"; 
   d="scan'208";a="146158192"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHmo/PdnBLay9EfXtY+JD/ACya+z0n9De+8o1?=
 =?us-ascii?q?9P2bi3/aPR1UdaVT4BZn3sJKQqqinFUrRPUs111i4shbkC25wc4kKxIM?=
 =?us-ascii?q?tRPvhrOlV3K7KhXE+hHrI7lgNvjh7j1s2DsB1N0hZq2Qc4FfHoQo3YD+?=
 =?us-ascii?q?s9iQLPZ9rjtOb7xlv1nXwuDQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 13:42:19 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5CQh-1xN2bc1msP-00r1qd; Sun, 10
 May 2026 13:42:17 +0200
Message-ID: <569a2fa4-d655-4c26-836d-a86aedf4e0b9@web.de>
Date: Sun, 10 May 2026 13:42:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <ffd64e55-beb3-4030-8b7d-763ba6f8f563@web.de>
 <1f97d99-bf20-44f9-8781-26162f5824b@inria.fr>
 <ef0539dd-b1d5-49b0-9c20-74c5e5d977b1@web.de>
 <e5a66d9c-5462-2f54-6abf-d2ec2cfd1d9@inria.fr>
 <26e1d3aa-13f1-4e55-88d1-68b9d027ded0@web.de>
 <806afe75-8e1-17d8-dc3e-c2e33f4ab64@inria.fr>
 <049a046d-3952-4192-9b9f-a7c2162c6ea9@web.de>
 <2437833c-e02c-736c-e96f-7ded7eb263c1@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <2437833c-e02c-736c-e96f-7ded7eb263c1@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8HvIcKc3NhN47CVlImOh6tUuqWrIAZNim67dOe3HCyTw/DvYJZ1
 d4mfWe+vhYdahhXXtseb4mSRYNAET63W2hkN6toLs5MAUiJk6vG9PPH+ziN7Hhidq9y6pbq
 WCXVCX2zoI5S3rcBiBVWrqnhv18Qusa66KZqGzQUHnbWHh1oXObOMPtVfCOKt/yBDx6olJr
 46JsH6UtAmYOv0UVhACqg==
UI-OutboundReport: notjunk:1;M01:P0:b4dpqVgJNnA=;jXF010mMJP0Ql1sj1h2R3jjmo6r
 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
 Ws
Subject: Re: [cocci] Merging results from parallel data processing?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3495
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/aAjcXk5VFTGDh-UlsvQEAg>

> You can declare variable in OCaml or Python to be the result of
> concatenating the results from the different threads.  There is nothing
> more to discuss about it.
>=20
> It's true that the above tests are overly simplistic.  Maybe
> tests/names.cocci would be a better example.  But it doesn't have a pyth=
on
> counterpart.

How should users of the Coccinelle software get to know
that such a special programming interface is supported according to
parallel data processing anyhow?

Regards,
Markus
