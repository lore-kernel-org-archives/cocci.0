Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC37C7EE30
	for <cocci@archiver.kernel.org>; Tue,  1 Jul 2025 13:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=BFTE7aDHm/FGNgfs6qZn2/Rm1jcunFZpNlBuLcRysQA=;
  b=kz+KmBSacOazSL2nB1nRw10RSpSS5h6OPU1hvGrpoMShgnYwHUdnfNvZ
   eNZnRkeQhpCe/DOeL+oe8Giql9tu4iF7WE5apS9vEU+ymdiPozSlS5qk+
   y0HKbfxuniIM3Njekrsp3RH4gcXowDqoAvUxFqOwa1cRiU7/zvLspfjVy
   g=;
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
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="229823578"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Jul 2025 15:55:51 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E88BEE0AF6; Tue,  1 Jul 2025 15:55:50 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 26C75E0131
	for <cocci@sympa.inria.fr>; Tue,  1 Jul 2025 15:55:48 +0200 (CEST)
IronPort-SDR: 6863e8e3_mfvZESFDgH7ynbYP4kTw32djpTkBYezMMt/2a4GJxydujX+
 zV9yAADQLirbiZSQ09+7Iov/0EYRcAQD/SmLqxQ==
X-IPAS-Result: =?us-ascii?q?A0FYCgDC52NogA4P49RaHgEBCxIMQIFIC4JEgQZUMwQLS?=
 =?us-ascii?q?YRVj1CBdDCEO4c8h1OId4FVgX0CDwEDAQ1OAQIEAQEDBIUAAot0Ah4HAQQyB?=
 =?us-ascii?q?w4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CY?=
 =?us-ascii?q?gGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREnDwsaAiYCAlYGARQBA?=
 =?us-ascii?q?YJ+giIBBhABAw4kB7ARgTKBAYIMAQEG2l4fLCJYgWUJgRsuhW2CZAGGJ4Q8J?=
 =?us-ascii?q?w+BVUSBPIMDPoRDg1uCaYImgRaEepMzUngcA1ksAVUTFwsHBYEgQwMqNDEjD?=
 =?us-ascii?q?zwFLR2BJ3+BTRyDCYEOhCwrT4IkdYF5QRk/g1QeBm0PBoEfG0FAAgELbT03C?=
 =?us-ascii?q?QsbBj2SW81UNAeCOIFmgWQMn2kGEy+DcQGTWg4GkwKZBSKpGoFvATKBXDMaJ?=
 =?us-ascii?q?E+CZ08DGQ+OIT6DdbtPQTU8AgcBCgEBAwmFRgEBiAyBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aXZi4yJrIFXhHMdyfpdRkM=
IronPort-HdrOrdr: A9a23:oSVj2qpjyhkmET/cOVKWSVoaV5oFeYIsimQD101hICG9Kvbo8P
 xHnJwguiMc+wxhPk3I+OrwQpVoLkmslqKdjbN9AV7mZniDhILKFvAe0WKB+UyDJ8SWzIc0vs
 1dmupFebjN5DNB4/oSlTPZLz9W+ri6Gc6T6ds2hE0dND2CI5sQlzuRJDzraXFLeA==
X-Talos-CUID: 9a23:+sSE227Jz0V0rxZgJ9ss5FMrFZEYbk/kzHLRc2u2Jj1naIK4RgrF
X-Talos-MUID: 9a23:su8fqgUn440CPPvq/AbtnQleL/5y37mNOBwyss8o68C0biMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="229823549"
X-MGA-submission: =?us-ascii?q?MDFlCywncd3g71bJc3vS9+HSizuCDGvYQMZs0s?=
 =?us-ascii?q?R5SjXfRaW7Vrq9CGNP3cV0FyyhK0KLem3RBYLCrAJC0czPGPOOpTyYVX?=
 =?us-ascii?q?MsQiYnfdfo7wIAQuje3TflTSfe3ZnPIZkXHm6IAyslCdNJUfIRlgaQ3Y?=
 =?us-ascii?q?vBXQz8bzBzM9+M9h4svHFwpA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 15:55:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751378147; x=1751982947; i=markus.elfring@web.de;
	bh=BFTE7aDHm/FGNgfs6qZn2/Rm1jcunFZpNlBuLcRysQA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pyzVKtwW6WjHlnWloUjmYIViC0PgpAYwMkiQYkKSsf0+fQ8F/7H1GvGhCNQJR0Qs
	 3tx9Sc46DPIss7Vn2Rnfd52Tv96sdFCL4yJ9yOmBDO1pk6OjTpqEIHY0y/32eJ8DK
	 kyJW28/DHFj+Tvnr3jf2uYC6qW1npQh7Z4BOGiHgCLAtcC6TXO8wZX3r0R83Uv+Tq
	 qEcLF6H7Cz3ufnKTQsf6PAdEeh7ZHBxjHexK2G8/zGpbbY30UZjJBbNy0tJ7IjNV4
	 RFhynN7eADrPOxed1AiwG7bLhP+z/Z4OLfQjKOU5qnYUFzlveU68rwuTHohnvnI+w
	 4K8yvf/TmLa2KaIXpA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.242]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5UkQ-1ulDnU30nq-00tIxl; Tue, 01
 Jul 2025 15:55:46 +0200
Message-ID: <12e9c764-18ed-417e-baab-66accbe52cd0@web.de>
Date: Tue, 1 Jul 2025 15:55:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <3675aefe-7163-4b02-a4ad-07b7a23a4b13@web.de>
 <bd958cff-a9bb-4f6e-8305-e5a09375ccc6@web.de>
 <5da0fab5-ebbd-491b-84b1-69db7cec524e@web.de>
 <92cfc83e-99b8-409e-8691-e761b3ede15f@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <92cfc83e-99b8-409e-8691-e761b3ede15f@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fuDpvRtc/1phsHZT8/B5Z2qcOXbHchHv576VsakrAsR2Gvqs2x5
 IZedxElYuQlsiuYKTIVG0i+8Uc3fZ1y5E0wc6nrFmFEesFAfF3p/xn/bw/YFT5S3z9Lp9q7
 p5RVmEF7vvLLKPjGAX+y8Rx5+667yFeOSXVmfp6DTkwx+ZGrQrU6BsOCVicCUCQYrx4osKz
 p8j2Kn48dhiBjgctWNljg==
UI-OutboundReport: notjunk:1;M01:P0:xVT0+5Ij27A=;hbORjopI25aAwxep4yMfiigjwOO
 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
Subject: Re: [cocci] Searching function implementations with variable
 declarations and statements?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2841
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/12e9c764-18ed-417e-baab-66accbe52cd0%40web.de>

>> Another SmPL script example:
>> @display3@
>> statement s;
>> identifier i;
>> type t;
>> @@
>>  t i;
>>  <+...
>> *s
>>  ...+>
> You don't need the +

Would we occasionally like to show a =E2=80=9Clist=E2=80=9D of statements =
(detailed control flow)?

Regards,
Markus
