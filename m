Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE91C77B7C
	for <cocci@archiver.kernel.org>; Thu,  3 Jul 2025 10:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=FOJ91ljDLw18UTx2ppyn6p8Xzq1LLbcoL6PVZpenOs0=;
  b=LkUDf4CYoSt5C5HRlINq0aIuOippHrBk46CmDeeBnw+EmW/t6o0E28kZ
   yzbJGK0fW6vzxqDmE/oNmjv7+Pwc/4apWwAl2xQZd+Ep9cDaMxMgv45vZ
   1Ye9a3vaiLiS3QrpDWMh98Ky3VG/RdoVF1wL3a5hFtJHD4RXfyj3982Vf
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
X-IronPort-AV: E=Sophos;i="6.16,284,1744063200"; 
   d="scan'208";a="230150573"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Jul 2025 12:28:30 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3311BE0AF1; Thu,  3 Jul 2025 12:28:30 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2AFE3E0157
	for <cocci@sympa.inria.fr>; Thu,  3 Jul 2025 12:28:25 +0200 (CEST)
IronPort-SDR: 68665b3b_CHPpKWscI7y/GKaPQlknXOnYfv323e/mmfT5DL2M2ce/fc9
 6IfiN+YVFA68Mj6OjMd5fKgMWSrkSluHzVowtYA==
X-IPAS-Result: =?us-ascii?q?A0FWDADHWmZogA4P49RaHgEBCxIMQIQXgQZUMwQLSYRVj?=
 =?us-ascii?q?1CBdDCEO4c8h1OId4NSAg8BAwENTgECBAEBAwSFAAKLegIeBwEENBMBAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CYgGBJIEmA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREnDwsaAiYCAlYGARQBAYJ+giIBB?=
 =?us-ascii?q?hABAw4kB64OgTKBAYIMAQEG2l4fLCJYgWUJgRsuhW2CZAGGJ4Q8Jw+BVUSBP?=
 =?us-ascii?q?IMDPoRDg1uCaYImgRaEeo0VhlZSeBwDWSwBVRMXCwcFgSBDAyo0MSNLBS0dg?=
 =?us-ascii?q?Sd+gU0cgwmBDoQrK0+CJHWBeUEZP4NTHgZtDwaBHxtOAgICBQIVQAIBC209N?=
 =?us-ascii?q?wkLGwY9knLNVDQHgjiBZoFkDJ9pBhMvg3EBk1oOBpMCiEOQQiKpGoF/I4FcM?=
 =?us-ascii?q?xokT4JnTwMZD44hhDPAWkE1PAIHCwEBAwmFRgEBiAyBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aTZiIyKrIxXiaI8LCq4R0NoJQ==
IronPort-HdrOrdr: A9a23:VWViQKsKZQ+tZbNpn4ps8evO7skDqNV00zEX/kB9WHVpm7+j5q
 WTdZMgpGbJYVcqKRcdcLW7U5VoLkmyyXcY2/h0AV7mZniAhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAb0+40MGem+lYdfng/OXPVLu
 vm2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3AlJ9hfWpX4s/Aeg3qOpB5vf/mUf8ddUX+5WriGEa?=
 =?us-ascii?q?1J2J5ZryIRgaq1poxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Aq14MkgzL9YOlMz2bsLXkMwtQw1aaqKSvK14Ko6o?=
 =?us-ascii?q?oh9WZLzN0Bm+kgT+JE5Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,284,1744063200"; 
   d="scan'208";a="120593735"
X-MGA-submission: =?us-ascii?q?MDGO1o7pYI4ORVlUU5jFLdaeYtzhuuIDEI/A0O?=
 =?us-ascii?q?tgCLLsNNZRgk8oJq4RuH7uYBQspSYyZ4oEjbt9koxcSrm2F92aZhL4OZ?=
 =?us-ascii?q?oVpExBrPRFYZUXgKz8O4RGqyi6jkhMZQK+GzuGGYIuHaN7+C4FWxcEkx?=
 =?us-ascii?q?fc4TIpiDslJXW1w7dm/eGe9Q=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 12:28:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751538490; x=1752143290; i=markus.elfring@web.de;
	bh=FOJ91ljDLw18UTx2ppyn6p8Xzq1LLbcoL6PVZpenOs0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lGmWUPhCvgf5/OWqOhvMg/J88qB2RD17HJeCO+sxX6+7g6INEFIPODyfVBDB/ffF
	 jxl2hyTR+x23hdBQXfb40IBtMUF5dqpz61cWoAEcbb4bUW+TCMNiWmTJDzCzDh5Z7
	 H7I8klq5fnFiwN1ZQIgQ3ETCqkda29ofTv8rM2P/9vtbeyHlIGB/wqJsPIt905O3x
	 1BJZtDWR+xNi4z1aHxOAA0bSmRSmoV7DVauML8TeuK5Py75vMYOPfh88Ei9nG5wx4
	 LitoojEAIzxGeFLbN6Bu2BO/R5FWHS4dKGQtdjvMrzFQBwoYiKV7gF51r81fTVyTA
	 gRfocU3WhqI4J9OZrw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.211]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJWsm-1uHneb31UO-00XyeA; Thu, 03
 Jul 2025 12:28:09 +0200
Message-ID: <7a1ae793-7f9b-4ec7-9cc7-db176207369a@web.de>
Date: Thu, 3 Jul 2025 12:28:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <3675aefe-7163-4b02-a4ad-07b7a23a4b13@web.de>
 <38ed2bf4-4bb2-4ace-87c8-191e19f8445b@web.de>
 <5ce5048-db22-67f-aceb-a358c54a62ee@inria.fr>
 <65638cec-fc36-44c0-88ce-f9678a0a1d53@web.de>
 <d0fb31c8-2888-47e6-c527-57f0e828f32d@inria.fr>
 <20d8778f-27fa-43ff-97e1-44375755d952@web.de>
 <8a69338-c049-cce1-2d66-a9607c175270@inria.fr>
 <ab0209a9-fbf7-4bd8-ae78-d6fb337ee294@web.de>
 <44735e62-2ed6-730-6ab3-b2251d8b6723@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <44735e62-2ed6-730-6ab3-b2251d8b6723@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LO60mGrGnFeQ8GWmzqWPrtUOK2MKi4+BB8a+n0iQnulKzDiscKn
 eMFT39c5knzRBNgBe4XsyK2PcYg2SIpeCe59zEoewATY+FAcNZvLB8PfZU5jMHxNwa7v5a2
 1IAgl304MldhPEk30mOub8XrVuOt78OV5kWow2nkXKMmOv2JzNaaBmRrSKE4qjo9nYtlx41
 b16lVNQNGF/OFp/YR83eA==
UI-OutboundReport: notjunk:1;M01:P0:xcY/QMzxeZ0=;KrWb0Xf8cNAqdzvHRB4UmJ54MEP
 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
Subject: Re: [cocci] Using statement list combinations?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2850
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/7a1ae793-7f9b-4ec7-9cc7-db176207369a%40web.de>

>> Would you find an SmPL code variant (like the following) more reasonabl=
e?
>>
>> @display@
>> statement header, footer;
>> statement list sl;
>> @@
>> *header { sl } footer
>=20
> I don't know what you expect it to match.

Such a source code search approach is very generic.
I am curious how often this code pattern could be found finally.

Regards,
Markus
