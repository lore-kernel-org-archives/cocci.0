Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA99CFC518
	for <cocci@archiver.kernel.org>; Sun, 23 Nov 2025 10:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vVLjlyBe9Xes9vQcFLSKMK4+fxRceBGsXrQpFnYX8ag=;
  b=i2vRDx1qUX1AyHLQRwFf6R3tBcWJN4OWCi9liPiTz/GIGQMJdfxjcUh9
   TPYgaEibJYLW85+HtL4Fuu1j8GyBOB+LCJd26C1zcw6COtNN/btuE1anv
   IXT4NoFL02QCXo7yLrscCm5f5c1rxGsATorcnEnk1iFaadqx4yL+lEL19
   Q=;
X-CSE-ConnectionGUID: li9SpSSDSKitZo2sWvvLIw==
X-CSE-MsgGUID: DvB8wJwdQ16nc58McJdPCQ==
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
X-IronPort-AV: E=Sophos;i="6.20,220,1758578400"; 
   d="scan'208";a="250689838"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Nov 2025 11:15:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8DBE1E0B0D; Sun, 23 Nov 2025 11:15:26 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 899A6E0171
	for <cocci@sympa.inria.fr>; Sun, 23 Nov 2025 11:15:21 +0100 (CET)
X-CSE-ConnectionGUID: i8SPppLzR/iXdL47jYXd3Q==
X-CSE-MsgGUID: agRLy+VGSJqc11h1FHAbWg==
IronPort-SDR: 6922deb9_PaA1lhllWJ9kl7KiPfyD0hWZN+RzoXj3V9Yy+wDiJ542J5v
 hGH6e5IJ5hWVlO1zf3ElkEU/4DwNR4i+9rJwcvw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HtAADS3SJpg07ASNlaHQEBAQEJARIBBQUBQIE/BQELA?=
 =?us-ascii?q?YI/ZXszBAtJhFWPU4IkhDuHPIdViHmDUgIPAQMBDU4BAgQBAQMEhQACjGACH?=
 =?us-ascii?q?gcBBDMGDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBO?=
 =?us-ascii?q?gcOO4ZPDYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBEScECwsaA?=
 =?us-ascii?q?iYCAlYGARQBAYJ+giMBBhABAw8nB7BigTKBAYEEgQgBAQbaXx8sIlmBZAmBH?=
 =?us-ascii?q?C4BhW2CZQGGKYQ9Jw+BVUSBPAuCRzE+hEODW4JpgiaBDplXUngcA1ksAVUTF?=
 =?us-ascii?q?wsHBYEgQwMqNC0jSwUtHYEkIR0YE2A9F0CDSR0GaA8GgRIZSQICAgUCQDqBZ?=
 =?us-ascii?q?iIGHBICAwECAjpVDIF3AgIEghl9ggoPiDmBCQUuXgIBC209NwkLGwY9lRBRt?=
 =?us-ascii?q?3+UYzQHgjiBZ4FkDJ9sBhMvg3GTYQ4GkwWYIGYiqR+BfiSBXDMaJIM2TwMZD?=
 =?us-ascii?q?44hGYQaxzJCNTwCBwsBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 V8piPQzmNRedZwkFO1kjrE=
IronPort-HdrOrdr: A9a23:gDJOjaMqcXV1J8BcTh+jsMiBIKoaSvp037BZ7TEVdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVydygc378
 ddmsZFeb7NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: =?us-ascii?q?9a23=3AZ7df/WpT44hD9zhzRYb49tbmUcF1SUXF1FPCGQi?=
 =?us-ascii?q?5OWpNFOKXeG+co5oxxg=3D=3D?=
X-Talos-MUID: 9a23:4uvLAAUo3I6jfkDq/DbjvhVzd/lH2Ia3AxlUkcwom+COCiMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,220,1758578400"; 
   d="scan'208";a="250689834"
X-MGA-submission: =?us-ascii?q?MDG3utyLrJOtX0XtuuD4QZdiO720GnJdSns5Yf?=
 =?us-ascii?q?4IW1Fy9003lOWZVPesAOYhytIbRDSUb6vGLeRJgBe8wFAIs3KzRb/MoP?=
 =?us-ascii?q?43810dsh7mcgt4ZNX0dWJPjXkin1LzPmEcugYpvVhvG49uK4h2irzCo8?=
 =?us-ascii?q?75TS7+rL1nxGv/Kp1WdjJH4Q=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2025 11:15:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763892920; x=1764497720; i=markus.elfring@web.de;
	bh=vVLjlyBe9Xes9vQcFLSKMK4+fxRceBGsXrQpFnYX8ag=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XVCCkGWj4EIzzLyTzjFCcyprEMp1Ct8XDsKNcRfMkDxGOLgQJk21r+Itd5WldNhc
	 D2cBNM6KYb5NfH30/kir3kwBpt9DPknydUUqrggh+6yH/6VJ1eejWrWNyTBCjux2u
	 HgnLlbVubegmRNxv2RayzPdJRaK+vJt1zyMwcZPyFlwnVFqC6TQNRLG83ATWiH58D
	 e24PhZp4x+vgwQDXAzSwiJLp7Dvk9+hQP8LhgdbkR7bBrWwdtrQ6bU5VEw4XMR38Y
	 zMWcZ2QuUxibHol+b4wmy0H1zd6ynvp0cwP7e7hAYk+jB3CBlhbAr8sx3qAL/jcIy
	 HUNdbUBiHIOlemMp9w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.252]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHVal-1vJ0Vl0lEH-00AZUL; Sun, 23
 Nov 2025 11:15:20 +0100
Message-ID: <76a42112-9a8e-48ab-9883-d446f1003bc3@web.de>
Date: Sun, 23 Nov 2025 11:15:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <228c50a2-bb15-4abe-bef9-b0f9b95f6992@web.de>
 <7cea8a1d-31ad-4475-be80-ef1cb1e3b2d1@web.de>
 <188e41fa-91c5-b09c-51d1-8f69f5d8cea@inria.fr>
 <4243db25-4d9a-4d60-adba-b1feb9ba6996@web.de>
 <c23ff4fa-b44e-f653-8015-9c573ae2ad47@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <c23ff4fa-b44e-f653-8015-9c573ae2ad47@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P3EjaSiBS7nh9YOBEz3Sl3c7SGUEryxiLcY3nlbrIeEAqRWC844
 Bh4L/n8DJbK7H4iGGxmFv9Q6Is9DWe7B2rqP8p9qSDFL2PTibGYDhqmOXxYLIbHEni3WNY6
 agA2Ies4N/8p9oCpjYGcsID/cfBiwj1MYZpscbQS2FEOok7tu0VhSo+Ryc27BQbS0OP68LX
 9vjwmP491D9bRwrJIs+JQ==
UI-OutboundReport: notjunk:1;M01:P0:usopu3BICSc=;mBSMS/2IgITFVMgjuSi4q6AG9HR
 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
 8o4PtfLqd5zQNJAzM=
Subject: Re: [cocci] Avoiding duplicate elements in SmPL disjunctions?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3194
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/76a42112-9a8e-48ab-9883-d446f1003bc3%40web.de>

>> Do test results indicate that data processing for isomorphisms is still=
 so erroneous
>> that this functionality should be deactivated until the implementation =
quality
>> will really be acceptable?
>=20
> The implementation quality is fine.

I got an other impression.


> No one has complained for the last 15 years.

Am I a contributor who presented relevant bug reports?

How will development interests (and resources) evolve further?

Regards,
Markus
