Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E87E7716E
	for <cocci@archiver.kernel.org>; Sat,  7 Dec 2024 07:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=I2/QGQyXUEI9r+j7dj7IcZro7sP91VOnwn73bwZEMkM=;
  b=ihdxr7vRtBSJAkThJF++TDjYcvn+lucGSnamJSPx4FwclgWsOalVB0Ek
   LE2EOVvnxZKIGDUxPI1IGmpZTv0t9B1RJxbJ8N051U89DnEtvjPraQo5i
   rTDnUH73vWmc9jS6oY84W081iwal9HPtn8jrbX+GR1TW9+VjSrx3HGbd1
   c=;
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
X-IronPort-AV: E=Sophos;i="6.12,215,1728943200"; 
   d="scan'208";a="197863676"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Dec 2024 08:24:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DFA53E013D; Sat,  7 Dec 2024 08:24:15 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6FE2BE00B6
	for <cocci@sympa.inria.fr>; Sat,  7 Dec 2024 08:24:12 +0100 (CET)
IronPort-SDR: 6753f81b_8ZjyLMoahTkVJtbCsMqtmn+xHmQvydTRSjUa+hhx7gjZsYS
 K0YSSaDSMED/ty+l6soT+Gacwz1oHPtg3sUhG+g==
X-IPAS-Result: =?us-ascii?q?A0GcAwAy91Nng07ASNlaHgEBCxIMQIQXYiFUMwQLSIRWj?=
 =?us-ascii?q?02BdDCEO4c7h1aKYIFqDwEDAQ1BAQIEAQEDBIIMgnQCimkCHgcBBDQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEhGQcOO4V7DYJiAYEkg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBESYBDwsaAiYCAlYGFQEBgn2CM?=
 =?us-ascii?q?AEDDiMHsSaBMoEBggwBAQaCaNdzHywiV4FkCYEaLoVrgmMBimInD4FVRIE8C?=
 =?us-ascii?q?4J4PoQFPoNbgmmCQIE9gSyCKSWHcyVog36GcYJfhEeCDIkXUnscA1kyAVUTF?=
 =?us-ascii?q?wsHBYEpISwDgkh/gTaBUQGDEEqDLoFeBTdHgkppSzcCDQI2giR9gk2BJQQFg?=
 =?us-ascii?q?2uBC4NehFqGJYIaFR1AAgELbT03CQsbBj2jEYRoyHk0B4I4gWWBYwyfWgYTL?=
 =?us-ascii?q?5dDDgaSeph7qSqBfiOBXDMaJE+CZ08DGQ+OIQwNCYQLvldCNTwCBwsBAQMJh?=
 =?us-ascii?q?UYBAYspgUsBAQ?=
IronPort-PHdr: A9a23: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
 ybY6NJj8QnOrw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:6WSRQ6MSZpkz38BcThWjsMiBIKoaSvp037Dk7TEVdfUnSL3+qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQU3WBVB8bFYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 NdmsNFeb7N5DZB/KTHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AlBBMuGmjTQSkxD9T4I6Iv5qrtvzXOXT30XrNH02?=
 =?us-ascii?q?YMFdkYuKvYnGQxqpLveM7zg=3D=3D?=
X-Talos-MUID: 9a23:B7t9SwoWIoTOu79jmDMezw86Cpxpw4mLMW0EzY8ZvtOlBBxrKx7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,215,1728943200"; 
   d="scan'208";a="103690951"
X-MGA-submission: =?us-ascii?q?MDE/lO7N400yRewdOwROn1UMnZgH/SxkXLfl8N?=
 =?us-ascii?q?68PUaRUUJXAInXU3ZOQ8FPDA8jBPZPl9jOkklG3ooolEneWKh27zIH9s?=
 =?us-ascii?q?QmenZKa2Q+9FSRc2N6CyGBqmapHjj8ZcbwT+m9jdJilyTFNuv71enTSt?=
 =?us-ascii?q?YRBybwvSEARXu152rxJg6xzw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2024 08:24:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1733556250; x=1734161050; i=markus.elfring@web.de;
	bh=I2/QGQyXUEI9r+j7dj7IcZro7sP91VOnwn73bwZEMkM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AjQ1Kd9HQD7lnMx3i/PH42539ibXZPiMKMRkjpG3naqKTzJvDjiwxcYMAaoQe4y1
	 fR/RwgRI1yCQFbYu7OXwpCDViRGXvqg5Zm0RpNsnB6Ypw1J8oPgP/Ai9q7W9z1a4H
	 K3UqOD2lsHoHXXY98dgcaHd9H90YzARBaLP36quT+Xrk0Lq7l8im6/bKxbgh5yQtT
	 +7KSEgFw1vQ581+DTAnRbx5yOvIepzrIB4dlCBq5gh+doRTXg0Uh9gk/zBsOWYfCo
	 +iHoQaUU251p2lUh+Z4aM1qBJyYSqVi+vrQS9BKxnqaNjy2WGPEqC8EMjya4U80HI
	 Y6OKsO/kyh4+gezr+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.27] ([94.31.88.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MoecF-1tz9P92nfN-00oilp; Sat, 07
 Dec 2024 08:24:10 +0100
Message-ID: <ffbdf21e-3807-4a35-8f53-60957606c9e5@web.de>
Date: Sat, 7 Dec 2024 08:23:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: cocci@inria.fr
References: <CABQX2QM+cBpVhcBYRae+W4n5a6bVJ=sC+zu9GGj0veiqvU2_4w@mail.gmail.com>
 <6b81d431-36e9-7a7a-687b-2d7fc7aa6c31@inria.fr>
 <CABQX2QP0Vk5UZPDFDXThvzuw-gkam-4wU_xq3rbSmwi9x7cBHw@mail.gmail.com>
 <dff4cbd9-00c1-47a9-b2f7-fb2e98d04433@web.de>
 <CABQX2QPZB9uHMxKKoZA6f=+4f0ifHfft-rHcqd-Ck9rjo7-ShQ@mail.gmail.com>
Content-Language: en-GB
In-Reply-To: <CABQX2QPZB9uHMxKKoZA6f=+4f0ifHfft-rHcqd-Ck9rjo7-ShQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7DcTR/xteGRTpKItpNIWv6kT8TFaULPsz/EphQlb0f2T5++GGYB
 aXeEA4WYl/bUDosDSuOYfrzh8m9O/8q4qK2+XBwHFi2MKv2PGQAjAg9hvIDhL8Syk6LXA4H
 LFFWJkUfLJijX4fx8tgnx1QCcNYVGYzDgdgaDAgzCBWQo33RbioSYbZ3BqZMXAOxwmLdYiU
 F0LtTktmWttmoZ+F2Wy+A==
UI-OutboundReport: notjunk:1;M01:P0:Cgkj76rwLOo=;VC7NnMubG1D3+e+mSQk5T1RRv/x
 bSivtHiztfsEW/GPd0S01NjZ40tgcglZncYroelkFhfCP9C7LMLt/Vz2xiNJzjMXXqI4x8rXD
 u0v3gdIzdF07dtnCirRf7iHvnyYPZxdOG568Dm6Xb7ygfHen9U0KMQGVtIn8F1Y3BCoAid5Jg
 TaEi184CC5e2Moa+LiAoCHOPLnhK9EGJjwjx1ujNuCueLAaxOgvf9TSq/JTsG27tXTF3Grxe5
 xDfX8H/penv2q+PAUy+m8TI2U7T7AXuFjajOmnpEgF2p6AzkWD+pnbxu/ok0mxdZJtTWJtAQy
 7KOGMtRGZnN5TcU8C6stWskmc6xGgsHVGVjO8eq9Jma+oILFOgpalWihMKFozx27NnLHuuxiC
 IPEA5beox0qbJR4nyO6JGEYJURJmMt3kr64lbHljFz86zgbEXsA8mpH1JcjmX+hOQC6c+nrx1
 GKaCS7vaGlpNHLVERw8Eu5P3uUoIVaVvz9Jq6R3iBm7uQtKyeEfk3LdFXF1WZvPxo/H1WYHCJ
 JOHJCe482R0TcG0sXBKTIvNV5VP/1Am6tZ2AO4cIyizfzls0r1PicsmXyDLOFWN14bHKNB+Az
 T2FmHFUadcPml32RyLPwcGDZp3SHA7zjxNXoSyN4PQFksEvAClPrUMaNxqZYbPu+++UKs8+gp
 BVOxWUuarPNDRuDcnYXf4P9AFg+2id3gKwV9BltbEl7PCyNX6nRdyavHwLKA5541oMTqQuKfg
 bpH8+kdn5iecfw5fvFE0GCbYscVVq8WoULCLMAxb/DN6oWryvsezbzvxTOKv2/coaZve0NsmN
 AsO/uTVpkrUzeslaVgX8uwpPneYv96SOkirEa3Q91TSxkUj8zncG4Dkb6XBe992EtjN5EnWK9
 qs0bRWbX6GLpckAp5KS5Ob7a5WLN7us/u+xDyVkSTt512Jqg/UCCp+JzN79u4OLVhgVnx7WD6
 NwcepJIm+NP6xB3m5s5YkdYCvya9REbsa7FqboEM4JC7C1D/02EBnWpSc0qW9Po1hPJoQycLF
 aXYwwXzrDLnfoG+rqX85tA8jhH/EeengRWe4dnsgXNk3mxztL+ue5W7VZI8lPTs503byJ9K4L
 irE4Q7S9M=
Subject: Re: [cocci] Replacing type names
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2162
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/ffbdf21e-3807-4a35-8f53-60957606c9e5%40web.de>

>>> From the sample_case.c I linked before the two constructs I'm having a
>>> hard time matching are function names in definitions and type names in
>>> parameter list, i.e. in
>>> static bool SomeDeviceLocalCompare(SomeDevice *localDevice)
>>> neither SomeDeviceLocalCompare or SomeDevice seem to matched via idexp=
ression.
>>
>> * Did you find scripted SmPL constraints more attractive somehow
>>   than script rules?
>>
>> * How do you think about to choose more appropriate context information
>>   and corresponding metavariable types?
>
> Sorry, I'm not sure what you're asking.

Does anything hinder you to extend data processing for a source code searc=
h approach
like the following?

@find@
identifier i;
parameter list pl;
type t;
@@
 t i(pl);


1. Improvable software documentation

2. Evolving programming interfaces

3. Development resources

4. Source file sizes

5. Communication


Regards,
Markus
