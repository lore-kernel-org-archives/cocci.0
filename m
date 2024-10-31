Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EB8E6895A
	for <cocci@archiver.kernel.org>; Thu, 31 Oct 2024 07:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=QujC8cUJ07k6ZhaLuRWHj1vMV0P68UWNFs6L0N3dYQQ=;
  b=NYs9Jh3IVMNgL6ISolZBX7+5XP57t3zZTcZDqbea3/5pSAwFGynARpzC
   gdLtDX2aTgnZwLVfOb22OhCF6Z9rbkD1cu20ragUGLbaSDgYjwbCcagBY
   9hzNfOz4aSQD69A7Kt9oVtvhk/35ZaRyrLqJnETBgoZLpTuo33jlhGXP3
   E=;
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
X-IronPort-AV: E=Sophos;i="6.11,247,1725314400"; 
   d="scan'208";a="191553876"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 31 Oct 2024 08:51:02 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 84029E0D1C; Thu, 31 Oct 2024 08:51:01 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id ACB05E00B7
	for <cocci@sympa.inria.fr>; Thu, 31 Oct 2024 08:51:00 +0100 (CET)
IronPort-SDR: 672336e4_kPLl4O6zPbuKYYyBtA56bkeZdUBv1vSzhyrQzcdbcingNSA
 FExM2FeGkaUfO8cc0yum1+fU/JhpgKaXrfSWOPw==
X-IPAS-Result: =?us-ascii?q?A0FfAAATNiNn/wQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYJDB1shVDMEC0iEVo9NgXQwhDuHOodViHWBVoF+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBIR3CQKKMAIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECB?=
 =?us-ascii?q?AYBAoEKCAuFNUYNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJ?=
 =?us-ascii?q?gEECwsaAiYCAlYGARQBAYJ9gjABAw4jB643gTKBAYIMAQEG2lsfLCJXgWMJg?=
 =?us-ascii?q?RouAYVpgmIBhiSDQnonD4FVRIE8glIxPoRDg1uCaYJUh18liDdokidSexwDW?=
 =?us-ascii?q?TIBVRMXCwcFgSolLAOEblt/gTuBUwFGgmZKg0ccgUUFOEmCTWlNNwINAjaCJ?=
 =?us-ascii?q?CRZgk6BJQQFgziDQx1AAgELbT01CQsbBj2cYYJTyhI0B4I4gWWBYwyfVQYTL?=
 =?us-ascii?q?4NxAZNNDgaSeJh3Iqh/gW4DM4FZMxokgzZSCw4PjiGELcRmQjU7AgcBCgEBA?=
 =?us-ascii?q?wmFRgEBigiBSwEB?=
IronPort-PHdr: A9a23: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
 chWIoI=
IronPort-Data: A9a23:I0sqkK5SqPcI3WRbQjSKDwxRtP7GchMFZxGqfqrLsTDasY5as4F+v
 mEZXWmBPKrYZ2WhctFzad+woRkH75SBy4A2QFduq30yZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOC6UoYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE0
 T/Ii5S31GSNhXgtawr414rZ8Ekz5ayp4WtB1rADTakjUGH2xyF94K03fvnZw0vQGuF8AuO8T
 uDf+7C1lkuxE8AFV7tJOp6iGqE7aua60Tqm0hK6aID+6vR2nRHe545gXBYqhei7vB3S9zx54
 I0lWZVd0m7FNIWU8AgWe0Ew/y2TocSqUVIISJSymZX78qHIT5fj6+lLMWQrG9FHwMEtH010/
 tAiCjQMRB/W0opawJrjIgVtrsEkMdWtI44V/H1tpd3bJax/G9aZGfqMvIIegF/chegWdRraT
 +8Qczlyd1LtZxNVO1EYII0zlqGkixETdhUB+QvI+PFnvDK7IApZ96rRF4DkZoe2WMhnoETEv
 kL+2mr/DURPXDCY4X/fmp62vcfEmijwWaoJBbig/7hrhkeSzyodEnU+UVKkqP29oly/XthFI
 goV/DAvpO487iSDUNb0Whe5rWSsrB8ZUcBZVew88gCEjKTOizt1HUABSSNdLsMrvok6SFTGy
 2O0oj8gPhQ32JX9dJ5X3u38QZ6aYED58Udqie44oQo5Dx3LpYYuklTQQ9wlHKPdYhgZ393v6
 2jikcT8r+x7YQ03O2GT4l3NxT6hznQMZhBg/R3ZBwpJ8SsgDLNIpOWUBZzz8vtKaoqUJrVEU
 L7ohODGhN0z4VqxeOBhjQnD8HxFJxpIDdEEvWNSIg==
IronPort-HdrOrdr: A9a23:EpFN16+dtE3NepHe5Aluk+AMI+orL9Y04lQ7vn2ZhyYlEPBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: 9a23:1He8zWxztPdsZze2K9GiBgUIP/0Ab1uBk033eVGUM21Fcp+RSHWfrfY=
X-Talos-MUID: 9a23:5E6BgAYFIsW66OBTkC3Qo2tTKJxU/qmcNkJRibU+nseCOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,247,1725314400"; 
   d="scan'208";a="191553872"
X-MGA-submission: =?us-ascii?q?MDGdvnJEUr9Oz+JoVY3jMmJcvE8bkVDQnqaFdM?=
 =?us-ascii?q?hnlRa3kr62bg9+SCUFcOo8qmEpu/LzgeQCDbGuNF7zEfMo7hxVXHt0Vz?=
 =?us-ascii?q?b3dRRCgWlb/8kucsUEBdpskCL5DHZ8pMdS1sJHCMmPXbWyorLef/LqBs?=
 =?us-ascii?q?VcLSf9Y+lVeMGZkE5HxUh8Ow=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 08:50:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730361049; x=1730965849; i=markus.elfring@web.de;
	bh=QujC8cUJ07k6ZhaLuRWHj1vMV0P68UWNFs6L0N3dYQQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HUZfXGSnlkIUrm+iKGUQGoL6KBUpKrAwyVodqS5oVrfAiLNiN4zY+u2+j4rvE5mS
	 6fBI0NYGLBh+FBHnhtYXBmGPL7QB/Pi2Ph3Opz4E032SxgEaQ04cLIyBw6HBMmJiJ
	 26ZjCY4H82Ng2MQPjUrIWd90Z2KCfXbfgSSLVC/pu2ShXV6VecvnonJZf/Rrp9pXd
	 cuEhIGcr+U+UCOEBt9G1hoINgtSsNb+oWo4CR5MAa1SJMoSix6gxW/ac0AoiD1O4o
	 TQxezZz6Uh+zcHtevtODIavrhpgYbni6ZnuUdbuw173qtKmQSOf4mMvu5UW0O5Ikb
	 FxUkXPcF7sxaZCTrEA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4vNQ-1tpgK52WUm-00zagT; Thu, 31
 Oct 2024 08:50:49 +0100
Message-ID: <d9bdbedf-c1a4-400a-aa2b-a4d522001c54@web.de>
Date: Thu, 31 Oct 2024 08:50:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: "Derek M. Jones" <derek@knosof.co.uk>,
 Victor Gambier <victor.gambier@inria.fr>
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241646040.3352@hadrien>
 <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241728210.3352@hadrien>
 <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241736480.3352@hadrien>
 <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk>
 <6534a8d0-78e8-48ef-b80c-a9fd3b80f562@knosof.co.uk>
 <ce176aaa-4ce2-4cd3-a943-527724957f9c@web.de>
 <d32d5bc4-3299-4977-bb0a-a3b0a53c829e@knosof.co.uk>
 <582c1098-213f-4c6f-ab35-4a7fb508c2a6@web.de>
 <7f8568d6-4405-4c7e-8dd0-90f140db8dd8@web.de>
 <alpine.DEB.2.22.394.2410271429560.3498@hadrien>
 <80d4b3c8-f29d-466e-b9e2-15f2c78a2f74@web.de>
 <alpine.DEB.2.22.394.2410271803580.3498@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2410271803580.3498@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/jQSQ5ImeZNSiTh8dwWlwJBkaQUfFftLysZkU3wlhk5UlFoIVSE
 lPe1Fj88Mxz0EG8cMBl2MywiSZQQwogdCDwoYE+x9Ero3B5H8N6v/pSKfnr5B98A00KuNrD
 6DdZBJSJlFpbdK0DqqWvxUMs354p7JLGnAoJUUP3lRfxTEBEI1lAVLWxl8HO2M4VsYP8ov6
 LEl7Q9SUF734JMX6j8arA==
UI-OutboundReport: notjunk:1;M01:P0:vaHGzDwRsDg=;fUkhXLBiJh53Qq0Gu+EX34CsDDk
 anaJ2IAAVMZgJcRcpnwwSoiVGHyNw+UAktLNs1vviBjLu5TCSyY2VCPOXCtJQF3ZUQDt2SrM/
 e2KodkXsKKDH/e2svQzxxbuG/ZLpFb21p9cOHzWO78l+/TCRxfs22lbDjJ6Nn5PXJT/NeyAw9
 cyEKEe11+Bj/V6wq/Pbvx89viwOy06cqARBseFlYx0dWOUUQmxZ8MPweLy168qT1mU6cFp0RD
 kJFUk07c5s/dyjfx+sMyZ2D71nV2tTv1+XXI1onegIv6mAi14oyn/E1xtIDIQ/eCCIejTiF4c
 aEjSA2+y7U2BJbaQrcjDUJiLfxj8tBm0ISn/g+mera4nYevgraDD+JdmRhuJ7JFuRSutFUZTr
 6bh+gpkdSpd5z+WgmrsMKxZ2LYoH8XEC9OWKfadsy4LGNXJLZ/n7RzUibRw4BpaO/2ARX7uuW
 7xWgWM8mY+UpwnpaC6v92TrN5/ZQtv4PRBLXnzwXq6ApgHJZK/Mm0mOfeyklZJzkRLNne5jyk
 MEhfYtgAa1KR0JknQuOoyTdxy+FhR4/Vy6F6gTNIifl7MNnRD8GnGS4xXNEpJ8pwB5vofSe1v
 GmSO5MYtxWmmiCXFONBTdLT7Pqv4FG7n7Bi6zf0DkJBUVULamUAXR/EOLQBfGXX2F15ltb7K0
 2P4xZvvLd0Hmv1jruxriyWf2KAL2y7mb2bl1Ua9EhpEsZ+Dzm0jlEwx3MNH/OrXc0q0JruJyT
 YRITbkH+xsR5ZSLJSQAeD9SYJGxvgw1pj4dkyvH8+OoHVys0/Q0CYm72RdakTz7qt+O5Y85f/
 p97FgnGGXrx2tp7YEK+LLwnw==
Subject: Re: [cocci] Broken code block size determination in function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1959
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/d9bdbedf-c1a4-400a-aa2b-a4d522001c54%40web.de>

> OK, that was much more understandable.  In general, we don't make a grea=
t
> effort to give reasonable results for macro definitions. =E2=80=A6

Will any source code places (which can be found by a command like the foll=
owing)
become more interesting for corresponding development considerations?

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/20160205> rg '##' parsi=
ng_c
=E2=80=A6

Regards,
Markus
