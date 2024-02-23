Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4044C48BC4
	for <cocci@archiver.kernel.org>; Fri, 23 Feb 2024 08:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=VgoxRZuajSmK4az1j16EgdZPeibLcxEmhC6bBs5ycBw=;
  b=etWtwXS0630+l3IrfYEAKqMRezjta7X/vhmzHRn4PQRWg0Q2IiBvg2rk
   5fT1VUvZrn4VrQ2D25cVBh56sQwa7VKSeztOdVlzOwky5LuSuVLbHQDPl
   tFTlzCN59Gl0IOG6WkX6k6xdZRcxQry0pA2HOe0/x1I5clFkkQ72Bgzya
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.06,179,1705359600"; 
   d="scan'208";a="153411461"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Feb 2024 09:01:43 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DB524E0CD7; Fri, 23 Feb 2024 09:01:44 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 35511E008A
	for <cocci@sympa.inria.fr>; Fri, 23 Feb 2024 09:01:39 +0100 (CET)
IronPort-SDR: 65d850e1_E3cQNVaO3k2+azykbMY3HbfbhXnG0Fq44HSIjLorRCpyh0h
 Wl0fEhR+XelafeynI7STM0qhbbeUc1/s8Y/cytQ==
X-IPAS-Result: =?us-ascii?q?A0HWBwDPT9hlhwQP49RaHgEBCxIMQIQIYh1TMgQLSIRTj?=
 =?us-ascii?q?0SBdTCEO4c3h06IcIMWPg8BAwENQQECBAEBAwSCC4JqAQkCh24CHgcBBEcBA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXBw4FCyeFbA2CX?=
 =?us-ascii?q?AEQgQ6BJgEBAQEBAQEBAQEBAQEBAQEBARcCR0EBAgIBIx0BAREnDwsaAiYCA?=
 =?us-ascii?q?lYGARQBAYJ8gisBAw4jB7FEgTKBAYIKAQEGr1wfLCJWgWEJgRqIVAGFb4Q8J?=
 =?us-ascii?q?w+BVUSBPAuCRzE+hEODW4JooDxUfxwDgQUEWg0bEB43ERATDQMIbh0CMToDB?=
 =?us-ascii?q?QMEMgoSDAsfBVQDQAZJCwMCGgUDAwSBMAUNGgIQGgYMJgMDEkkCEBQDOAMDB?=
 =?us-ascii?q?gMKMTBVQQxQA2cfMgk8CwQMGgIbGw0kIwIsQAMJChACFgMdFgQwEQkLJgMqB?=
 =?us-ascii?q?jYCEgwGBgZdIwcPCQQlAwgEAyspAyF0EQMECgMTBwsHeIIJgT0EE0QDEIE0i?=
 =?us-ascii?q?iYMgkgDGSsdQAIBC209NQkLGwYiAR0CpEKBUsVLNAeCNIFggWEMnzgGEy+Dc?=
 =?us-ascii?q?gGTPg4GkmAemDsgqFiCHoFcMxokgzZPAxkPjiAZhBSPR0I1OwIHCwEBAwmFR?=
 =?us-ascii?q?gEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
 ICnfEfbNzpItd7Zr5N0Og==
IronPort-Data: A9a23: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
 FXZnVx5fXw=
IronPort-HdrOrdr: A9a23:Qd4hjKA+oZbqeZXlHely55DYdb4zR+YMi2TDpHoBKiC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOk9K1vp
 0BT0ERMqyTMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: =?us-ascii?q?9a23=3AarloCWv2jWDGheBJ0cTcEkli6IsqMXf0y3D2AXa?=
 =?us-ascii?q?zInhTD6W0cVuc1r5rxp8=3D?=
X-Talos-MUID: 9a23:k2muOQgeyKOxNdinL74GWMMpNp5S752pBxo2ussrqeWGdgwgPRehtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,179,1705359600"; 
   d="scan'208";a="153411437"
X-MGA-submission: =?us-ascii?q?MDEM56nZ81Z5UXX3/rxdu55hMy7GRHtPfU6ZOs?=
 =?us-ascii?q?154LJP9Gv7MffZEMni27vl+5glVKzcWZ6qUvNNyn6xy11m6Hn4Jyw+GA?=
 =?us-ascii?q?mD5pC1WJatsobzuEAZMOA2Mx1DafSf/FCbUeD61ElIq1aLkCd8Th64bu?=
 =?us-ascii?q?J96d/xCCHUSFXD+5cghHtJgQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 09:01:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708675297; x=1709280097; i=markus.elfring@web.de;
	bh=VgoxRZuajSmK4az1j16EgdZPeibLcxEmhC6bBs5ycBw=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=VQTfSqCvQuc6hbd4vpbOpzg6cbL4jrFeuzxtbvcZr84KRKd7cEE/fQaUF55Qw9oA
	 ig2HgkKaIBaHT2fLdqQB6yL2TvpWf84Q4WphkFu++FlRG8FSG8rTPXCGIVOGwHo3w
	 Loco7cpKnBg4ieaBNWE5kDlEc9S9RSMFVASALyRUuYJf6/R4dRDbM13rqRGXDx2/O
	 w6AGZZKYwtDPBITzNhW05ZhBjP5QeEJZZVLGb+yTeda3uCTt6hfDplT2TamGL38Jm
	 FMaFQtsFPdzyDDYqbLRjYopIporaSio6Co7L5xGmYY3pFWzWaj2lQz+giMtsKq2Qf
	 h3mGhy1OSKnTRabG/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mx0N5-1qguy21w8B-00yHZd; Fri, 23
 Feb 2024 09:01:37 +0100
Message-ID: <876202ae-9105-4c2b-aba6-2db0bfa01645@web.de>
Date: Fri, 23 Feb 2024 09:01:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <784320f8-7731-47df-be6f-9ddc71c20d61@web.de>
 <71f51659-e163-abfd-7f96-fb6f40e0117@inria.fr>
 <e3d5d5ca-ab22-49a4-8483-75e35a88446b@web.de>
 <d4527c39-a26-ae3-86d-be23b6d457b@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d4527c39-a26-ae3-86d-be23b6d457b@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3U5tYtCqQgeNPi3Ig6rBc6Gv3VByi6eSXkgvPrn2zGZlQJTJArs
 25QdHKx3JzSWm9bJvhHYepasZFCCowJzSCypKSNA26QfGqpV03hmq5Fa1u7ZTF0zd4QOVAa
 qH+F+afcZFW77q0Nhrvq0OGob7RpxxRnySCgbOWvoIyYMJDQEyhdtaohjPiCoEh/cunwxtW
 TtzkWHNiTZ7iAQlUKeYFw==
UI-OutboundReport: notjunk:1;M01:P0:OgnTz/WVAFA=;02KpbGjmTQ2Yz2v5DFV2GSVn4XY
 7OZ31cZGvsswOVJDUFxcRsghr3xi9etHYSHRGyGpXKZQH2ZVo866Vo8VRZGO6vmy95sXAKZSp
 9xthNleTyshHMXNHHqrsichl2jlWwfJNHc5vUVIFa/6jpfjxSDnvWHZmTl/eT8TuRP2A7MlEr
 sLhT5L9pFHEAZYdkcpCO28sh7JrqQ+T1ibZoCFR70pk2gS+Ro6VxtHu24y6FMrW3H9WhLtbjk
 YRR1TsorDCS1vYlBXw+g76b4S5dAH9LFAj6mO6WOVVgJfbtMy7bqm8XMQsF0P67xssrucpNjH
 nyf9bdR5qkNTRXPTlgyJy94d/B14JqoChFBvn3XeZJeND+vxEhGtAQ7PD6NKeaoMM8kZuQZrS
 HseEedTazhFYI/etMEHLUHqYIBfpLBqqjSZak7rQ1RH/v/Xe598qlookwRn8aHoD74zyEWEuX
 VsWBEe74Mc33GX6MJh/nbsJx/gvWggne5niquUJDWMnIIJ7/dSo/fDyEFdgULLVVSgqIozYxY
 fafCKNWXGutWYgoZVThpmHLDTw9dzFMk2IlW1JrzVZ2YEi3UCrVGeLSQtIwj1RRbG/j3pkpA8
 CGLIpUTVcgejEES8qidHl/GjHDMXtnrUoQuIfQb6Z4344+Amjx8VMNl0N/4CR+TER+RsA58K7
 Mjc3ulRT7xUQJeWCpn2cA9IYcnLyu9HXTLs0qItsyomMkvCKNAjHMN4txsk/Paf5WlaDBj8Br
 98ix8TYJqKzhaWJZBomk5UxWnJv4nT1g5SHDFX8B578Jfsqq90Szzoh4vWKBtneKbOr0QMuhu
 ysx5Yg1V11V4VLD5trXwBhxBUOfhr0mERZsLwKUjmut2c=
Subject: Re: [cocci] Using inherited input data for SmPL script rules?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1602
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/876202ae-9105-4c2b-aba6-2db0bfa01645%40web.de>

>> May SmPL script rules depend then on search results from a previous rul=
e
>> which references also inherited metavariables?
>
> No.

I hope that such a software limitation can be adjusted under other circums=
tances.

Regards,
Markus
