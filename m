Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCEECAC5B0
	for <cocci@archiver.kernel.org>; Tue, 23 Sep 2025 13:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=e1mcJirNjh4z6VBGGwuBKbcsUsJQnW1IihaGJIlTrkM=;
  b=slZfHsKmH/IhGr9n0s3yI/4ivkh4KnKKU1Tn0QE1QY6EZvr4lqT1SXNt
   1wfyUXdIA+ywM2QJp+NJVxwQ6l1Ef+xUJwFgOZawXbSqGzWZKAwJqfCyP
   nlMoi6WMYIm6SctMuNfGkP3uNN4r04qWfFPvuvWfCpP1TA+d99Au0ofs4
   0=;
X-CSE-ConnectionGUID: sOPl5FJAQsmb0BC+xjecHw==
X-CSE-MsgGUID: D/gxK68fTj2X620LJN0AVA==
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
X-IronPort-AV: E=Sophos;i="6.18,288,1751234400"; 
   d="scan'208";a="240630983"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Sep 2025 15:08:18 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4B46CE0BE9; Tue, 23 Sep 2025 15:08:18 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D1A76E0171
	for <cocci@sympa.inria.fr>; Tue, 23 Sep 2025 15:08:12 +0200 (CEST)
X-CSE-ConnectionGUID: K//KRfbfRji/hX7HtOC3pA==
X-CSE-MsgGUID: PPImGa0JTlOIt7M5Mp2VQQ==
IronPort-SDR: 68d29ba2_S7WSCcJZKGYTpRdYVxCXZs8ghBuuUtrHKMui9+fks3BdeHD
 4UBwnNtkx+kkaq42nTsI7h/Wu8p5oThGxCpCD3w==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GPAgBIm9JogAwR49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBU4JAZR0GVDMEC0kIhE2PUIIkhDuPEYh5g1ICDwEDAQ1ECgECBAEBA?=
 =?us-ascii?q?wSCDIJ0AoxBAh4HAQQ0EwECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQE7Bw4KMYZPDYJiAYEkgSYBAQEBAQEBAQEBAQEdAg06RAEBAQIBI?=
 =?us-ascii?q?x0BAREnBAsLDgwCJgICVgYBFAEBgn4BgiIBBhABAw8mBw0GtWWBMoEBggwBA?=
 =?us-ascii?q?QbaXx8sIlmBZAMGgRsuhWyCZAGGJ4Q8Jw+BVUSBPAuCeD6CShcEgV6DW4Jpg?=
 =?us-ascii?q?iaBFoNWjFmNClJ4HANZLAFVExcLBwWBIEMDKjQxIw88BS0dgSd3gweBDYQeK?=
 =?us-ascii?q?0+CHHKBdD4ZQYNTHgZrDwaBFRlJAgICBQJDPoFrIgYfEgIDAQICOlcNgXoCA?=
 =?us-ascii?q?gSCSoESKUACAQttPTcJCxsGPZc3gyqBQYIfxls0B4I4gWeBZAyKLpU+BhMvl?=
 =?us-ascii?q?1IOBpMFmQYijWabOYF/I4FcMxokgzZPAxkPjiE+g0IzyCxBNQIBOQIHAQoBA?=
 =?us-ascii?q?QMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 YT4qa6oja17pYPM/R5cRkNo
IronPort-HdrOrdr: A9a23:EXfE/6EYl2JOckInpLqENseALOsnbusQ8zAXPjNKOHlom6uj5r
 mTdZUgpHnJYVMqM03I9uruBEDtewK5yXcx2/h3AV7AZmfbUQmTQL2KhLGKq1Dd8m/Fh4xgPM
 xbE5SWZueAbmRSsea/xhWkGNA9x9S9/Lmvnvq29QYWcegnUcBdBxwSMHfiLqSafng8OXKzea
 D32vZ6
X-Talos-CUID: 9a23:91bvNGN2vmrIx+5De24g13QaEM4fcHyazEePA1OfIj1xYejA
X-Talos-MUID: 9a23:5+RgownXRIDAgaGtQCcfdnpaDOZtzK32KnwJtrQa5OzZEDQqBQ6k2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,288,1751234400"; 
   d="scan'208";a="126350879"
X-MGA-submission: =?us-ascii?q?MDFuGhWII8zcH7z85du6TQfEO2lPjMmAG17u7m?=
 =?us-ascii?q?Yx7BVCkjdhNPFvqcFP19Lvk21uSQBsmW3tmRAAsx4ZZkTXCa30Y4klER?=
 =?us-ascii?q?RYbMpUblQs7c4DwM82kxXN6/FwG5wRMtQOyYXBc3Cz7+vBNQBIbYdNVj?=
 =?us-ascii?q?RC1T5fCssA7f8iOPFewmhxFQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 15:07:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758632863; x=1759237663; i=markus.elfring@web.de;
	bh=e1mcJirNjh4z6VBGGwuBKbcsUsJQnW1IihaGJIlTrkM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VBnvLPygm+f2ocDYvjrYMaOsratncVlyyCYlyQ2m+8EbUV98Pfbui9iJeAo51Fzs
	 X+H+EQi7uqH8CGBemID2X0o5IJrEOxniQFZBtSm/mV9XLxOsp4NtumZbTKCr08mK0
	 hiuc5RvAYk7VFK9pptaVshd97t1iaxnDRRD9G+qdFQRhAyOlWRzrX2nY7BbJfPhV+
	 bJEAspqy27VJxm9JgzriBrOII5Mv8UlcjxNNfgtl6nv3gTBw4wMSruK0j/coDXqGu
	 1LE7spxSOzNGgm/W3Bm1jBX0yTsWj/qh9KSo6DGbt91S+q2huMg1hdSk+hVKMzkMi
	 n8lxZeZHNmAKWULqvA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.248]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLRUX-1ujEdx3bJj-00Vul6; Tue, 23
 Sep 2025 15:07:42 +0200
Message-ID: <a42c2271-51b1-4864-be63-d0757dd58b5c@web.de>
Date: Tue, 23 Sep 2025 15:07:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Oleg Petrov <o.petrov@ispras.ru>, cocci@inria.fr
References: <3addf44d4f2524588d664102d5109aad@ispras.ru>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <3addf44d4f2524588d664102d5109aad@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uNOE+H0tohffVQSOK+kAJZerw7fL1PlIRxP1wqF3UpaejlmpXcl
 Vv7QZar0caYXelOHJNUXKd04AXnPtvdKZmre66X3Bv5kOczuERh1CvWD+4c5pDGqdjyKA/7
 nxwu9eedcOUcomgKkmIiWNn8N9DKEoXgn96tqW+sKSyGS+ruJc8gjasgry9BPqu6e9lCAp5
 rUQW0awOfipfpL5DQVZng==
UI-OutboundReport: notjunk:1;M01:P0:pgNcdH6QfpE=;hDvCtx6QOmwrcObJq2OFT7tjlVd
 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
Subject: Re: [cocci] devm as drm-init arg: rule with expression finds less
 than rule with identifier
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3032
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/a42c2271-51b1-4864-be63-d0757dd58b5c%40web.de>

> I=C2=A0wonder,=C2=A0why=C2=A0is=C2=A0that=C2=A0the=C2=A0case?=C2=A0As=C2=
=A0I=C2=A0understand=C2=A0it,=C2=A0identifier=C2=A0itself
> should=C2=A0match=C2=A0expression.

The software combination =E2=80=9CCoccinelle 1.3.0=E2=80=9D does also not =
produce an expected
difference display by the following SmPL script variant according to the
implementation of the function =E2=80=9Ctilcdc_crtc_create=E2=80=9D.
https://elixir.bootlin.com/linux/v6.17-rc7/source/drivers/gpu/drm/tilcdc/t=
ilcdc_crtc.c#L1017-L1076


@badarg2@
position p, q, r;
expression devm, e, local;
@@
*devm =3D@p devm_kzalloc(...);
 ...
*local =3D@r <+... devm ...+>;
 ...
*drm_crtc_init_with_planes(@q e, <+... local ...+>, ...)


How will the software be improved further?

Regards,
Markus
