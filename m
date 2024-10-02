Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7181ECF31AE
	for <cocci@archiver.kernel.org>; Wed,  2 Oct 2024 09:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=QMFKi1F4X4A9U6IPrNCS9VFuBFuOrJ/a4M5vl00noMk=;
  b=ovj2ZwRogPzDpC8SfOqhk80cgCN+p6rh0Fx7gfD5CjgxClokxRL0FEiv
   22zmkHemzgAI6FeXg98IL48E2bLappNEDx46YmXC10RNtSaD272GwSFIX
   1oc8twkhcCPMHUmjC4pDdv7lovzsHiLyrIsRvD0VMutAu+QHYiPL8WoDk
   8=;
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
X-IronPort-AV: E=Sophos;i="6.11,171,1725314400"; 
   d="scan'208";a="186454046"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Oct 2024 11:45:44 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7BF21E0CD0; Wed,  2 Oct 2024 11:45:43 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A2130E0035
	for <cocci@sympa.inria.fr>; Wed,  2 Oct 2024 11:45:40 +0200 (CEST)
IronPort-SDR: 66fd1644_w/+hb/zji+RyG/GjceaYZG3VGU/+XdBmwDd+n5SgP03VuCo
 U+c4obrtjqfIG5xWkpwcY+O0ygUkBdhUdbPZ07g==
X-IPAS-Result: =?us-ascii?q?A0FuAACfFP1mhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYJDYiFUMwQLSIRWj02BdTCEO4c6h1SId4FWgUA+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBIUAAooZAh4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBAToHDgkyhXsNgmMBEIEUgSYBAQEBAQEBAQEBAQEBAQEBAQEXAkdEA?=
 =?us-ascii?q?QEBAgEjHQEBESYBBAsLDgwCJgICVgYBFAEBgn2CMAEDDiMHsTqBMoEBggwBA?=
 =?us-ascii?q?QbaWh8sIleBYwmBGi4BiEoBhiGDQnonD4FVRIE8gmYdPoRDg1uCaZINi24li?=
 =?us-ascii?q?FtwkWZSexwDWSETAVUTFwsJBYk4CoMcKYFFJoQVCIErE4NfgWcJYYdnYoENg?=
 =?us-ascii?q?T6BWQFGgnFKg0+BdwU4SYJRa045Ag0CN4IoJGqCWYEnBAWDSSqBCh1AAgELb?=
 =?us-ascii?q?T01CQsbBj2uYIYuxhE0B4I3gWSBYwyfUgYTL4NyAZNLDgaSdph2Iqh7gWkDN?=
 =?us-ascii?q?YFcMxokgzZPAxkPjiEZhBS+VEE1OwIHAQoBAQMJhUYBAYZBgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:/zdymqEK7TrmnkbtpLqFb5HXdLJyesId70hD6qkvc3Fom52j/f
 xGws5x6fatskdoZJhSo6H6BEDgewKVyXcR2+Us1NiZLW3bUQeTTb2KqLGSugEIeBeOvdK1t5
 0QFJSWYeeYZTcVsS+52njfLz9K+qjlzEncv5a6854bd3AJV0gP1WdEIzfeNnczaBhNBJI/Gp
 bZzNFAvSCcdXMeadn+LmUZXsDYzue72a7OUFojPVoK+QOOhTSn5PrRCB6DxCoTVDtJ3PML7X
 XFqQrk/a+u2svLhiM0llWjoKi+quGRi+erN/b8yvT97Q+cyTpAUb4RFYFqegpF4t1Hpmxa1e
 Uk6C1QRfibo0mhA11d5yGdkTUImQxelEPK2BuWh2Durtf+Qy9/A81dhZhBeh+c8EY4uspguZ
 g7qF5xmqAneC8oph6Nk+TgRlVvjA65sHAimekcgzhWVpYfcqZYqcga8FlOGJkNESrm4MR/ed
 MeRf309bJTaxeXfnrZtm5gzJilWWkyBA6PRgwHttaO2zZbkXhlxw8TxdAZnH0H6JUhIqM0kd
 jsI+BtjvVDX8UWZaVyCKMIRta2EHXERVbWPGebMT3cZdM60rL22u3KCZkOlZGXkcYzveUPsY
 WEVEkdrmI7cV/vD8qVtac7jiwlaF/NLAjQ9g==
X-Talos-CUID: 9a23:7Au1vmz0xrAUZCepDDNBBgVLI50DV0/xyE3iBGiqFjc4TLuuaW2frfY=
X-Talos-MUID: 9a23:yuATnQlngw6RDk41LxhhdnpdL9w4ypS/LXxVtq8fm9uPPjFxIge02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,171,1725314400"; 
   d="scan'208";a="97990844"
X-MGA-submission: =?us-ascii?q?MDFe09+PZgmZ7eWB9nezPQTWEIdM+nJLcbELPO?=
 =?us-ascii?q?Fii1r7oWQM5KCfZxR+yZAnYLk/TiT1tQqeMmWiN72ncyuHUXwXSvkkEV?=
 =?us-ascii?q?fYnAGPPrO+59SroKaRKLq9AGc0OFTcOWWJqvbGhWg5zwNxQzPBffHiuf?=
 =?us-ascii?q?t4DXXNqxeD26UU/8NvH6fmyw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 11:45:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727862338; x=1728467138; i=markus.elfring@web.de;
	bh=QMFKi1F4X4A9U6IPrNCS9VFuBFuOrJ/a4M5vl00noMk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZvVGSep6R0tmB8ekLnTrp2PkdCiEMob5NpAn5EGf4snrY8B75wEZbVQIfqKdyC7A
	 iO4HL8wja+uZwodYr2TZFChi3xfIRJiOJFNDIbF2jylXGzd5YXSvdsWqehgI79oPU
	 sAY5VjdrRjPdqlk34aalxOrkoGMMx+sOo7/3SGue+/zQ9RnfwHd48IU0VoDxMc4FH
	 JcMnKtyjYTwvS4xsN0Uha9cDR9TtJuQx1QuKZassF0Ql7SSAllZb8pcq4bfhevsFI
	 cVG3jhPCahCNl1rIuj3j24i96ALT32QekbpBgZ4szj+kVNRF5mf+fbNei557UWHmh
	 gPe9TZawl4NWiCtSqQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnX17-1sCjLz2nWn-00nebl; Wed, 02
 Oct 2024 11:45:38 +0200
Message-ID: <6fe4e3cd-1a3a-4e8f-bd4c-4e6eabf11351@web.de>
Date: Wed, 2 Oct 2024 11:45:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, cocci@inria.fr
Cc: Denis Efremov <efremov@linux.com>,
 Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
References: <CACzwLxiohvUHUxm2XM8B08RwY6VCLuK1p32Ek2Y0M+t1wTfX8g@mail.gmail.com>
 <d3f5836b-9a4e-5974-b649-e6f75c5183f8@inria.fr>
 <CACzwLxiaXLLSZH=rufJkkyr07u45W40ENd=BXqU4B1NoyS1iag@mail.gmail.com>
 <fbd705ff-2c6d-4b96-aa71-114ed8789b99@web.de>
 <CACzwLxiFrQx81F_NWDjWSEseu=ePn5PoPt59c74ud9-eUWCfFw@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CACzwLxiFrQx81F_NWDjWSEseu=ePn5PoPt59c74ud9-eUWCfFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+uIRAbxrx4vswVBjoMpZkoIfjozomAdtUXkpQuIoPlnzU80SwWS
 PSiQ0jwJ+xn+IXmbDjOu68wKhewGG+rqb0iwWi48fC2jOed/FAObIGMHXi1214Coz5NSecK
 NE/bQ/dFt984b0V2dyHVQKsoctpAtJubzDuHVAIsgFKvRx4E98wE5rBln2PBBgpHtEOBSqa
 fuXLXq1GkUAMZSm7DBcwA==
UI-OutboundReport: notjunk:1;M01:P0:FygI/PfQaE4=;CGh/RgLpfx5uuxKGlx51grnLsy7
 2AeLdXeFWlNngtHlozCOPSrqx1uTIvxK84VsmFVX+7d4FWE9yIiAcCcWGTlrWHzR5Y1XniM0M
 Iw8mDECDU/H/ugA6PM1q+leHtV/NjWOdTdm0TaYEMlwyI4yjmD4v/0VMOfteVAMLV2nMV8Wnv
 SNRZdwfsqsr8JsXSFWCfIMpYGlCBY2V1RG9RTQblG/X5aPol3rkCjANW1vUVFepA0rVZrblQ2
 fowbKiQSX0fYVZaOzYBw5tJ56dsWUvq6mGyvPKwIZRt6VtrKXKJol4khRQSwrCASWpQOt+PkW
 aJ8c4yxGJqBqAHltnpZZHUg5PBHNlkrR3owPW38JVrR22cKXu1qjt9FUDkI5RFeQMSUypylJT
 PNWad4W0Y+rb3qPGhazJKepkkApzn4o+4fLAB8laKfG+JAKIk6BDzovE7QJ7JTwvvN1XHEFFc
 4vudgU03VSTiseuWQGWml7pzpNDmfJOu/XSA09YGXkPWLdnmZGooxJJoI2EcHwpyXuM9ccFMj
 MZwaW1nAxRmVwNUWzWcyCaPYVQGsSl0GylVTmAQ6eOhWrLYilBqdhjcjYj6Q5d8krZtAbHRO3
 drZ9WqoElk2nVGsscNjOx0BMFFMFu/xeaa+lxwXuvdo9dS0AsXFN9B9/loaPu8X3zUrFrdwdV
 x5ss/fkEGFiFWcwai8N03RrVsWEQxj0ZFNQsL3UeAyxKPEEN6KYuW6drT+IjwWvOqJsc++hBZ
 GXTw6A1UjHwXriYeRkEDzz+cvHj+ItAMyJuerWIpx01k7qIHfgsS+g/FD8YO7xid5npp7UR36
 Klb2v6epJaZBEToCRp86/w5A==
Subject: Re: [cocci] Assistance in Coccinelle script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1904
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/6fe4e3cd-1a3a-4e8f-bd4c-4e6eabf11351%40web.de>

> Going to improve the script further or it's much easier to filter out ca=
ses.

Would you like to fiddle with any nested SmPL disjunctions (for your rule =
=E2=80=9Cr2=E2=80=9D
so that duplicate SmPL code can be avoided another bit)?

Regards,
Markus
