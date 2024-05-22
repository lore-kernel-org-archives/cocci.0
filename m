Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AC0C25B77
	for <cocci@archiver.kernel.org>; Wed, 22 May 2024 08:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Awa+Is0nAHQn2aWCkbZQzI2y4qYWVDCq49tbuBmhfYo=;
  b=MdCm8tdgjKxIcdWVlIu37mleGuviyEKN4+dyq21N4v92KX1q5KpFsDcA
   7TowpW1Y8XBEbj2bUBQUycj4SzLNoJtPkvaiDCJu3XzkY1mduy3K6oQer
   0cex9kY8J0d1RhnV8iSBQv1GyHUt3MKeE1rubRPTEHC4KJdAHmIvRuktp
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
X-IronPort-AV: E=Sophos;i="6.08,179,1712613600"; 
   d="scan'208";a="166829678"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 May 2024 10:44:13 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 72C31E0CCA; Wed, 22 May 2024 10:44:13 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7A0F4E00B6
	for <cocci@sympa.inria.fr>; Wed, 22 May 2024 10:44:10 +0200 (CEST)
IronPort-SDR: 664db059_ZFpoNqPGEoB35zYfC4m3GKeYZhAjnwlYjj7Q8Vztoa5xH8y
 GfyaGjzlu364ogdN+8Ib1zuVDksTwg44yuUSaLQ==
X-IPAS-Result: =?us-ascii?q?A0EuAQCvrk1mhwQP49RaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YJDfAZUMwQLSAiETpE9MIQ7jwiIcYMWPg8BAwENPQQBAgQBAQMDAYILgmoKA?=
 =?us-ascii?q?ohEAh4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBA?=
 =?us-ascii?q?SMXBw4QJ4V0DYJnARCBDoEmAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQECDTpCAQEBAgEjHQEBEScECwsaAiYCAlYGARQBAYJ8A?=
 =?us-ascii?q?YIvAQMOIwcNBq9zgTKBAYIMAQEGgVhB2EAfLCJXgWMDBoEaLgGILQGFfIRAJ?=
 =?us-ascii?q?w+BVUSBPIJSMT6CYQEBAoFeg1uCaZl6kjZUfRwDWSETAVUTFws+CRYCFgMbF?=
 =?us-ascii?q?AQwDwkLJioGOQISDAYGBlk0CQQjAwgEAxAyAyBxEQMEGgQLB3WBcYE0BBNEA?=
 =?us-ascii?q?4E3iXAMgy+BdSmEHghDbBWDcoF2DmGDUIRLY4EQgUeBFh1AAgELbT01CQsbB?=
 =?us-ascii?q?iIBHaRnhCJJEIFRk3uyMTQHgjaBYIFhDIohlSMGEy+XOQ4GkmiYYyCNVpsUg?=
 =?us-ascii?q?XskgVwzGiSDNk8DGQ+OIRmDYTOBC8sUQTUCCTACBwEKAQEDCYVGAQGDWoFIA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 VQIeF0=
IronPort-HdrOrdr: A9a23:HnQBbq4xTs579TjicQPXwBbXdLJyesId70hD6qkDc20xTiX+rb
 HWoB17726TtN91YhodcL+7V5VoLUmskaKdpLNhWotKPzOJhILLFu1fBOLZqlWMJ8S9zJ8+6U
 4KSchD4bPLfDtHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNz2CJ5sA0+9jYDzranGeqTM2fqbQn/
 enjPZ6mw==
X-Talos-CUID: 9a23:CyK+jm7RukLpf6saF9ssrQlXGN0nQnfh6HrwEXTmUGRlC5CWVgrF
X-Talos-MUID: =?us-ascii?q?9a23=3AaMW6nAyOANWFaYOTCwxAOH2b1RGaqIuELRwVzpU?=
 =?us-ascii?q?oh82FHB5sPie2gz+Tf5Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,179,1712613600"; 
   d="scan'208";a="87650065"
X-MGA-submission: =?us-ascii?q?MDHqAP4/7oc/ayEoTxmteULFFjmiL1P81hyOee?=
 =?us-ascii?q?+B0x40KqE60STOrBcBp1WJO0IcanVVzvuR11U9GjZLz+IDiN5oRFcZry?=
 =?us-ascii?q?1ZglEcfhqBUe31ydPfhq521QgU2qj/JGNVRkEP1sSDaRAJFVsciW1MN0?=
 =?us-ascii?q?ajhVR7MvPTCwhjS/5wXpaVPg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 10:44:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716367448; x=1716972248; i=markus.elfring@web.de;
	bh=Awa+Is0nAHQn2aWCkbZQzI2y4qYWVDCq49tbuBmhfYo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RRMnGMtfH99eLVXIwx1DgXlUro8XrSHLMHKN3mxlCiV79gI0mYkLGz1dceol9ffq
	 S70ebMZJMSbXbw7CVo7bwU41KOh1Ge6jHQR1ItIaBTGur2OPJjVQ+iYefUidfPyjX
	 k+s5FwiruaifXmfrzEv/uAMeqxifi0Fege9oNT9S4dyHP2mLLBMdlV5JiKZWo6+bS
	 /xk961Xyh6eAk2zjOwkWEFPAz+b7NB24zD1sl/LZwU9LB+EIZ5ZnpYrHootUIXtsg
	 O/kL2/3pHEF/fNn+eYSpWLP5/NFdN2SDblPyxDsHzT72R25WcvH2/taxDunZ3w15B
	 Mcy51kFcp2mlK5hmgw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3GgY-1saY8Y26SI-00sAUL; Wed, 22
 May 2024 10:44:08 +0200
Message-ID: <d4f4694a-b81c-47cb-b351-9bc6a75e7f73@web.de>
Date: Wed, 22 May 2024 10:44:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de>
 <594a83eb-b693-4f5b-b330-c0c4cb655661@web.de>
 <9b4af55-40c-3082-52f3-12b4b535376f@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9b4af55-40c-3082-52f3-12b4b535376f@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EN2ybdq3C2v/6nSv2mX539b+26av+ILMq4qHZMOVevP8fTldgLT
 i1Mev9otX36EPkz1Q+msewvV/d/a8KKNrhvWQ73cP2rr7NQ7zdZ3tj+omm5eyK/WXTJtpJR
 fbeSxQ9fZkCQDoPl5XInmErEMQVfyDina11Ytf9HyYMkpAMARsw0mfpaDplyQw07BkiV8mm
 6iQTTnxM9l9PXC/Pk1wfQ==
UI-OutboundReport: notjunk:1;M01:P0:WQTUdMfK5mo=;zS6ZESLKEPMtte495ylHas+NAdv
 ba9IdSk2cxpUOk/fYPaXlWZL1OZCsdtqptk+3yB5X6qBLzavWmbcmmJIUrYC7ZAyaEk3lPP8Z
 aJtWSwwGJ++w5rUJsZeE654PT5itlacHlHr1sBfr3hvXV5LPbKEclHwib6uA/NG7RphtPqfAn
 5y4LzvMAk3q4atvdnhcEi1zU2FxM64jMaWAjKfn6gxGWF5q9n3X/kGmw6zwuayvwXbczyZfMo
 55xYLCyfu1m+NEFSAe2o+zz0eFfP4bQ6Q08p1xV2byjkPuwKCMiPcHgro30jGnhr5mZWDJsVh
 RtSFeTrrJhfhScfpVEa46oAxtsaIbSl7LZgpNy/Dvu+KlATpYI4kv0xFr8DKBkO+Blouvlb0B
 txxEOTUQPdCHi9EjNnxH4LVkPfuYlBs99+/1MVyQ9K6HVN2PThfCxEovfrh3k8eCy6Cp0oU06
 NFO96Z3SZWDuG4eEQbZZBXyvxSBf9Fzj1OGkDvJPWDe9g9CrQTUrtGs+UAp0/6W30uYvoizVe
 8Lit9cVeWQ/Rb5bhRmLiH3R/E95U/k5/0il1Vgb2npipshHTIv4xUfnZ5QJPK4oX8AmhqV/U2
 ljdQG9Erifii09ei4TKP7L7lnBXi7KOJJK0Ju2uP6LAgwuTIR0jNFT59a4/jAVpFNUqm9n1I7
 zeIEbXykq5mRLR6rht/vj3bRq8j3hjGL1C+12HCeLdt8aeWXvbb6TsWSg29tYTZuvEuDCaiin
 3/gdrBJbutbtAlRcVTO530bp5isGhnzu4q/gVgEjDoNDe3pXanCMDEI5XsYQIojWZwZP2hUA8
 5k+Dcw+Feal0OopXo60ZPqY+BItVslpy3RYj4zWz7Pahc=
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1749
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/d4f4694a-b81c-47cb-b351-9bc6a75e7f73%40web.de>

>>> Source code parts can occasionally be repeated.
>>
>> Would you like to clarify how the data processing for scripts of
>> the semantic patch language should be influenced by the program
>> parameter =E2=80=9C--no-loops=E2=80=9D?
>> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/477e7e12478bd317aa=
97ee79857d185601ab6f33/docs/manual/spatch_options.tex#L365
>> https://github.com/coccinelle/coccinelle/blob/477e7e12478bd317aa97ee798=
57d185601ab6f33/docs/manual/spatch_options.tex#L365
>
> --noloops mean that the back edge of a loop is ignored.

Do =E2=80=9Cback edges=E2=80=9D occasionally need special treatment accord=
ing to the evaluation
of computation tree logic variants?


> It can greatly reduce running time.

Such information is good to know for more desirable run time characteristi=
cs.

* Will the software evolve any further also for better detection of
  duplicate source code?

* How good are statement sequences actually handled so far?

Regards,
Markus
