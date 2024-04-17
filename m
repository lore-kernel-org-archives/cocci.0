Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBA7C001CC
	for <cocci@archiver.kernel.org>; Wed, 17 Apr 2024 13:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=xa9Y2JlAzPWgzeTQg3xFw/b6FgTih5DMjmNr0dCbG3w=;
  b=ji4jtU2awUGDe2Kotl51cfrEhQT7J0qhVi00e+W5JTKrbFCLC7ZPeqVP
   0KmMhDF+hgDtwwEigh5uZyZbUoh5uA1UbNvfmjTo3UU5YaRzza2qejWPN
   peM5LiVppJmaoyDZjkZUddpJjV4TQSvVyRbrl0zJ9Hd5KXKtMa3U6DwJM
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.07,209,1708383600"; 
   d="scan'208";a="162067311"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Apr 2024 15:03:12 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 510EEE0138; Wed, 17 Apr 2024 15:03:12 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6FE27E0035
	for <cocci@sympa.inria.fr>; Wed, 17 Apr 2024 15:03:07 +0200 (CEST)
IronPort-SDR: 661fc88a_PZQSFUPx16W7/40H09bDz7EnaxT4SHRshAn9HF5Ry9JdGRS
 e2lD/2FAx3FWz6RyyguETOHYp3eh87U4BpmiVzg==
X-IPAS-Result: =?us-ascii?q?A0GfAAB/xx9mhwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYJDfANUMwQLSIRWj0aCJYQ7jweIcYFqgSw+DwEDAQ05CAECBAEBA?=
 =?us-ascii?q?wQ4hEcCiBsCHgcBBDMGDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAQEBIxcHDhAnhW0NgmcBEIEOgSYBAQEBAQEBAQEBAQEBAQEBAQEXAg06Q?=
 =?us-ascii?q?gEBAQIBIx0BAREmAQ8LGgImAgJWBgESAgEBgnwBgi8BAw4jBw2yEoEygQGCD?=
 =?us-ascii?q?AEBBtpZHywiV4FhAwaBGi4BiC0BhXyDRnonD4FVRIE8gks4PmmBYYE7PoNbg?=
 =?us-ascii?q?mibVoY8VH0cA1kyAVUTFgIbFA0kIwIpPgMJChACFgMdFAQwEQkLJgMqBjYCE?=
 =?us-ascii?q?gwGBgZbIBYJBCMDCAQDUAMgcBEDBBoECwd1gXyBPQQTRAMQgTIGig8MgzEpg?=
 =?us-ascii?q?U4pgSqDCQhDcRWBCQKCfYF9D0QdQAIBC209NQYDCxsGIgEdngQBhD7HfTQHg?=
 =?us-ascii?q?jaBYIFhDIohlSMGEy+DcgGTRQ4GkmiYYiCLXYF3mxGBeiSBXDMaJIM2EgE8A?=
 =?us-ascii?q?xkPjiAZhBSEYZBoQTU7AgcLAQEDCYVGAQGDWoFIAQE?=
IronPort-PHdr: A9a23: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
 pYDGOczaQ==
IronPort-Data: A9a23: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
 VQIeF0=
IronPort-HdrOrdr: A9a23:jDioma9Xo4nEB0OOH6Fuk+AMI+orL9Y04lQ7vn2ZhyYlEPBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3Aneo+omjLSleyAhnKidEeGoptrjJucVvN6FDOAUu?=
 =?us-ascii?q?DFGMuFOaWZUKI57Jgqp87?=
X-Talos-MUID: 9a23:NHNLpwulPlJ+z0TA/M2nxwtfbvxN5biVDB4Ty4kD5enZEy9hJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,209,1708383600"; 
   d="scan'208";a="85053995"
X-MGA-submission: =?us-ascii?q?MDHqFD5hkCK1NbFpEiHUzyazRd5o4feYP4QAT4?=
 =?us-ascii?q?HRzXsS/5Vgi0BFcp8pQQDoYyo3tOwOOYl3cUN7kO8KFBBCXo1049g9ms?=
 =?us-ascii?q?YfS4p6b2HQE6DbR0wjRI5Fj1Iiz6LOV6gx4LBWECLbRN771y5J2b+vco?=
 =?us-ascii?q?NHZx2R+bNYhJvis+xIAkgGPQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 15:03:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713358984; x=1713963784; i=markus.elfring@web.de;
	bh=xa9Y2JlAzPWgzeTQg3xFw/b6FgTih5DMjmNr0dCbG3w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=wn00AVNjAWypuN4K5zt0FQOjhUsO/eCWIa31kq9s4DTUnFPwbjO2mdX1Io7YgdWf
	 urT5xTBZfgOOho5P6LSU4VT2GNDvSP6Qi370ZyDKYP4n55gjm9eiuIq6JaRv1vHYB
	 IMlzTdwVvSahn9CsMmEzpqfFXklmE4QIXo0++L/J/IF17I+9JfeRpNjbbE1wLyKMc
	 5IXm7vK24ooqhikXDUUqM1vmcgZN/hyUqZzDMGYiOksKrsnDsvc5vNJTgrIK7OEJu
	 g2BdhzXoyR7EQiXdYh3dTyV4Gn2Bcx3azCrdwGvMDTVTR/vRxcWxJ+kjoZOQEAINm
	 akbZ3yD3AD32tf4bnA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSZMD-1sKxcX1Jft-00RG2W; Wed, 17
 Apr 2024 15:03:04 +0200
Message-ID: <ba67e3ac-33c4-4ced-86ca-fc590ca0ed36@web.de>
Date: Wed, 17 Apr 2024 15:02:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ricardo Ribalda <ribalda@chromium.org>,
 Julia Lawall <Julia.Lawall@inria.fr>, cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, Denis Efremov <efremov@linux.com>,
 Nicolas Palix <nicolas.palix@imag.fr>
References: <20240415-minimax-v1-1-5feb20d66a79@chromium.org>
 <fbf22b53-7b68-4e60-99c7-ab38a77a53c8@web.de>
 <CANiDSCuvXvjfhw2mjSef1wR8RiL=9KrDEoh+3o1ed4+8P+AqGw@mail.gmail.com>
 <60df00eb-41ca-417f-8b8b-90dba6eaaf65@web.de>
 <CANiDSCtZzAs0u2tqJGRaJz6iqCTu_p-j_rkyGU7a9HFqUbJEMg@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CANiDSCtZzAs0u2tqJGRaJz6iqCTu_p-j_rkyGU7a9HFqUbJEMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Id/SyUE37WytGTXv9/AzLmpUP6D+3CgV5CSpMPXJ6Ha2AdKXIvU
 nkdtbHWZ797VjYOZV14VbyarnqFGn6vYzl57mNLE46em0NbwjurUoxzn+0uCUP+Ex3lMNVJ
 R2h0ZOsm5IHV/nzTSDmsPYa/Oa9EKguqFY4Xb58U1KG+GpmOE5ucf01jsOa2iIxISvdv4kr
 lX19sgDD5z8X/+IEjiwVA==
UI-OutboundReport: notjunk:1;M01:P0:Tk5eMEQ2d4o=;2DAq3UailJ6az1acc0gW0vsf3aL
 QXj8elUWfmbY5J7eZ4AWgrdHt0U8Ex7ErIzHurLGu9fUyT9SSRJn1Xx2pvD4GDYIIpJiiU6iF
 pqFIFRgwXReZgZ2cPvOqMhATOh2uzfHnt3AUN0ZjY3H66w7XKtl8ivTkJGeiVDtlTcfKaOl/c
 B3gAVCVNG35g+gllcpkurRQ/SSY89ZvJXMM6OxlQLz0UqUxS19KOjxFQoeavSE5qGiV/QaILx
 PUpuWO9XdREoHNnlkExgrWiLbA7c/i8KsEYYPaA/1ZI69/IzmefwkiJIYkFZr1BSwJO5ddqd9
 qmzU2RRk4kTGkGW8f2MmPBFhyMRvgA2K14DZ34X45elAFgbVpCW8QSlNXhp0O+ysJFOyJhq6R
 2efk1IXFZe7it0beaIbKrzpjG8dKMgnw0K6guiYRO6V8C+dGd/8kx3YnoJyGftB53KchF48Ni
 O272abTsp+mVp1IUUvS0F6+l27tGsjuYggq5YvHp9IKw6p1NL+ZKkGLOQMwPFBFcp/p89RGiB
 Sy6P5GTRlpT45eK4W3FxHKU48wg2EjnxCFve6XPXNKNzfirQwPFJiHNEUI9Iv+VtctK12Tvhs
 tTcgKOwqt9lsonC+E9hWC2ttXW51QeY8f0CMKwsHdWyhYydURIn0Leq7kwGBu1s8snhWf94S1
 oNuvTC4lm4zw5ZB/ZpUTfCrPaeq47UrCOCmslVqgJ7NO+XI5VBQ1UWqCYuSOguwszI8m1dWe0
 ZIJ5ec2a3nllDf+XJ9zmMIScAdBGP7MLuSnB5ZU/eGAKi5Gszw0R/PCrX319vmrjrwbWkG2g4
 WILBecNreaUpAyLEfXIEOFRj/PrBtLz1OXVifly640H1s=
Subject: Re: [cocci] coccinelle: misc: minmax: Suppress reports for err
 returns
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1672
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/ba67e3ac-33c4-4ced-86ca-fc590ca0ed36%40web.de>

>> Adjustments for functionality of coccicheck operation modes can be clar=
ified further.
>
> https://lore.kernel.org/lkml/2024041643-unshaven-happiest-1405@gregkh/

I hope that remaining communication difficulties can be resolved in more c=
onstructive ways.


Do you get further development ideas from previous contributions on presen=
ted topics?

Regards,
Markus
