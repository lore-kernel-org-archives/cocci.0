Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BAEC48BC4
	for <cocci@archiver.kernel.org>; Sun, 18 Feb 2024 17:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=EgciIHYOGB9uTTwnrkYbX6WN5eNjrFmUJEdCJKlwqdw=;
  b=ly71RJBPpMEdCK13Wd+jVLW0VWG5qk9sBk3JFIXDFAUsVkpQ2WkQtYdR
   +0z+loEK3Ml9YSUmmbkLGGMJrnEvEy/wKp0BStUA/cg7V4WCwi7BsbYQN
   ZTqI5JBslq9aiJZL1b1Zr1JxcdJRnYAiN9wWmvqxyu/WhIqr23CwesaBB
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.06,168,1705359600"; 
   d="scan'208";a="152513491"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Feb 2024 18:30:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1A143E00B7; Sun, 18 Feb 2024 18:30:31 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 854B0E008A
	for <cocci@sympa.inria.fr>; Sun, 18 Feb 2024 18:30:29 +0100 (CET)
IronPort-SDR: 65d23eb4_jDi97lVCOZPFhGfyvMomtwviRnaldhwoTE0iwFG1VrKNrW4
 jWbHneAeu0HWMwm3Dzo8tsEa7WTWk2k7QKGm8+Q==
X-IPAS-Result: =?us-ascii?q?A0EsAgDrPdJlhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+COWIdUzIEC0iEU5FphDuHN5A+gWqBLD4PAQMBDUEBAgQBAQMEhH8Ch2QCH?=
 =?us-ascii?q?gcBBDQTAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOE?=
 =?us-ascii?q?CeFbA2CXAEQgQ6BJgEBAQEBAQEBAQEBAQEBAQEBARcCR0EBAgIBIx0BAREnB?=
 =?us-ascii?q?AsLGgImAgJWBgEUAQGCfIIrAQMOIwezMIEygQGCCgEBBq9bHywiVoFhCYEaL?=
 =?us-ascii?q?ogmAYUkS4Q8Jw+BVUSBPAuCRzE+hAU+g1uCaJ9eVIECHQOBBQRaDRsQHjcRE?=
 =?us-ascii?q?BMNAwhuHQIxOgMFAwQyChIMCx8FVANDBkkLAwIaBQMDBIEwBQ0aAhAaBgwmA?=
 =?us-ascii?q?wMSSQIQFAM4AwMGAwoxBylVQQxQA2QfMgk8CwQMGgIbGw0kIwIsQAMREAIWA?=
 =?us-ascii?q?x0WBDIRCQsmAyoGNgISDAYGBl0JGgcPCQQlAwgEAyspAyEzQREDBAoDEwcLB?=
 =?us-ascii?q?3iCCYE9BBNEAxCBNEKEdoRvDIFSAxkrHUACAQttPTUJCxsGIgEdAqFdCMkgN?=
 =?us-ascii?q?AeCNIFggWEMnzgGEy+XMA4Gkl+YWCCoV4F7I4FcMxokgzZPAxkPjiAZhBSPR?=
 =?us-ascii?q?0I1OwIHAQoBAQMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
 4qX/EocAChP+ZTY8JlFbyAxAN2KOjwtPEixcAM=
IronPort-Data: A9a23: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
 FU=
IronPort-HdrOrdr: A9a23:VUXgZaCPBuww5+PlHely55DYdb4zR+YMi2TDpHoBLCC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOlNK1vp
 0BT0ERMqySMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: =?us-ascii?q?9a23=3AnRfrPmny0rS+s6kBeliCa0Jy2b7XOSzU83L1LBC?=
 =?us-ascii?q?qMlpOcZ6nY2Ki6KR2gdU7zg=3D=3D?=
X-Talos-MUID: 9a23:rr0tsgUKvsuHrlTq/GPNtgBBHudC2Z6zKQNUo78akpavEBUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,168,1705359600"; 
   d="scan'208";a="79952905"
X-MGA-submission: =?us-ascii?q?MDHioDgei9uu8JzFeV/GSpU7JGaWlqZNGPIMJt?=
 =?us-ascii?q?OCayUROkGMVRKl2d4G/zlUBX1SZWC/85nHXPX/A5BbJE8C+3og1VM/zY?=
 =?us-ascii?q?zJ/g4A7Eja+7NyXmt1+Y43H7vvzzrS/S7/MBdZ2jS3+FtR8RF//xQLRb?=
 =?us-ascii?q?VGLMkAOCAqP/5vpYXDbBvjyQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 18:30:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708277427; x=1708882227; i=markus.elfring@web.de;
	bh=wUV5+XgDkz6u8Tu0e9XYA2kDKCjoNhksLpe08CbvI8I=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=Tm4oB/PUwvnB+GBUzdK1wu9+u6OkQYzJJaVWyRaiUgj5g5hSauQqRbXtgecFwb8j
	 hCT9BFBuXzxdDlvlppZMU3xVWZQoLIpBi2WRF6ZISbEZbtYBpfnUxE4uD4eOIR/Lc
	 uxmNfvvmRcA+ljQNQF6/FqIsfohQyz6uIV3nsQMrNFIA7qD+uxTsgB6d258fZjEzs
	 xxJhbsxwGxjzrCwb5C5ThX2kqPbdYbTflQ0yyCeluYE36vsRtBHBOOtGr0bqOM8bH
	 L4gyQoEk7FEylZgb+s3enjK25ZVXW52YaSiPxMr0PVnCC0ZJWAnN0QtbAjTqTDSao
	 Tf8zFSG3/oMtgLKMqw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUlDJ-1rTGgU2aK9-00QnyN; Sun, 18
 Feb 2024 18:30:27 +0100
Message-ID: <541aff0d-1023-4d7a-8ea7-ca64c8002c77@web.de>
Date: Sun, 18 Feb 2024 18:30:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <c5bcc0b5-1a19-4256-8572-b9ee5e78ea0f@web.de>
 <12009cea-f93c-4a80-a95f-9bde16dc78a5@web.de>
 <4bd9de70-de02-4fea-9d41-095304edf4fe@web.de>
 <38d77d89-ffb7-d495-ff80-898861d46d32@inria.fr>
 <5afbaf9d-892b-4105-a54a-35f1e40e6749@web.de>
 <6a89e704-5561-4f44-b9d7-7c8f78976e71@web.de>
 <alpine.DEB.2.22.394.2402180908440.3095@hadrien>
 <30fef057-5f06-47bd-8b62-1bb6fc3fb946@web.de>
 <alpine.DEB.2.22.394.2402181707300.3095@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2402181707300.3095@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jzB0ZOsyXif5/ZF7JaM8qf+bCUBA2bMUQNHLvJCyfcfA4gtI+Qi
 iCSuda63yHG0uuhRBVm3e/rLuQmgkdlNI8wIgyXPRg4Lg425WctU8069+KHDRi8KHFL0gTy
 +/naiS9et07mVp1YpoPNN36iIh1XoQmEpEJFFn4OKbYUlxh4AWbiWK8gqeAk/MGCUvN3V3e
 5pQdMJyWOcyZzR1ekxzHA==
UI-OutboundReport: notjunk:1;M01:P0:9LZgIYt+P6A=;pBNODfIjE0VQxmPVtjVHEDi97YW
 yab1MnpF6eZAjoVoeU50H9hACpKzUiEtdZvAeAW5+bMQmPeIglLTCeK5u8c/N1h6oLwehFn0V
 qkYvlsKVtza10yuQ3pg5L0xNQU0vMRe7XYTC/VLoHPkJr0um4Nmdk2d0JLymYiFcr4hJQ0Xm6
 GQhVVbMR++0jzXr2NMQPB+pTX67vEKcMOopy1EhSd+VgunI4HKBu+/oFcMS6f+S9wTFZya+vx
 /gsBiNmIBmr7CEl0NJbx9tTCuxA9sPTrbkjft/IV9UrqUwbfFVo/n3rb86j1DF7Xe6N/c3YxW
 mYlzexe1j04+Vi0i0crFKvcu8DBzil4Z9CnUptriM2H2YG8VM/lb6cfkx2ChKja4kGVoXGBQo
 YzRdOx3HAaGsCUcVujIN+bXHYXJqNmqB66mQpwGaKDFSdyY2GP1tGCofhbCKQj0wDFJxAHHxW
 R/lBcFBYnCnvMMyXorNsMasbwpCvEvJUJUI4bKYw/MrIvEBs1w5dG57T52tnbzaGqecNX4yFM
 /LHZEyFVmbLgIIvb+tLywjal6H5GXMbBPcQtbw4/RY927Zcjf2It17bzV/Bbx9QFnLQdTC0m5
 UcEDIMZaF1cH0wBwCxW5JtaXU9emiJ5Q86dn4boWTpYv7Poyuuk8A4o2BENJWgBxTYc/Aawan
 h7x5jJvIOdUeA360Z2Tu6aoCzsw3nlFS6HH43Me2Dn38OUk4mH425Jr6bgI9JvtLG/vjIv3yE
 mxdy3B51kUeLxeIlVJHgs7Fz1Aqwpm/a6Lml/aBHJnFnfmd1Dh2tWd5O1Vxanp/+bNMlaGshQ
 AD2hqdzU1tlzGB7bOzmpcfU/CRiaZGFhvggbf7LHtafuE=
Subject: Re: [cocci] Checking the search for a repeated condition check with
 SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1580
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/541aff0d-1023-4d7a-8ea7-ca64c8002c77%40web.de>

> Coccinelle's ... is based on CTL AU, and as such works bottom up.

I would appreciate further clarification for such information.
To which computation tree logic variant do you refer here for the handling=
 of
SmPL ellipses?
(Can your technology =E2=80=9CCTL-VW=E2=80=9D influence the discussed data=
 processing any more?)


> Accordingly, the following semantic patch is quite slow:
>
> @@
> binary operator bo;
> constant c;
> identifier var;
> statement stmt;
> @@
> ( if (var bo c) return var;
> & stmt
> )
>  ... when !=3D var
> - stmt

I find your acknowledgement interesting for further development considerat=
ions.


> And the following semantic patch is quite fast:
>
> @@
> binary operator bo;
> constant c;
> identifier var;
> statement stmt;
> @@
> stmt
>  ... when !=3D var
> ( if (var bo c) return var;
> &
> - stmt
> )
>
> In the former case, it first matches stmt at the end of the semantic pat=
ch,
> that can be anything.

I wonder about this SmPL code interpretation.


> In the latter case, it first matches the if, then binds stmt,
> and then can easily recognize stmt earlier in the code.

I would expect so far that the presented first SmPL script variant
should be evaluated in this direction.
Do we stumble on another communication difficulty around safer and more ef=
ficient
applications of the semantic patch language (including mentioned conjuncti=
ons)?


> There will be no changes in this respect.

I assume that circumstances can evolve in ways which might make
corresponding adjustments more feasible.

Regards,
Markus
