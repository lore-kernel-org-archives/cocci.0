Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243E5C48260
	for <cocci@archiver.kernel.org>; Sat, 10 Feb 2024 15:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=OuXP1Rogd6wgHT7IeLjdPdKJiVBpotO3oiGtnNvLMW4=;
  b=K7xKEDy844/UVdDXnpvaT++V6ePlpHWehR4oNWbALpgTLkPRHZfgBU+0
   9XghcLcxfyWm26/OE+h86uv24mjDLiV6Wh7zcwpf8SHvq1A/IgdlhEJTs
   JIOQYBOLXEdIvJh7JTmKRIfrygfH0Seoh1FYWkXUm68LIPKZ1cGxXOuEM
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.05,259,1701126000"; 
   d="scan'208";a="151316333"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2024 16:10:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3360DE0CD5; Sat, 10 Feb 2024 16:10:10 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1149CE008A
	for <cocci@sympa.inria.fr>; Sat, 10 Feb 2024 16:10:07 +0100 (CET)
IronPort-SDR: 65c791bf_XRSbCMyZCkvmEnV/S1FNebJ/1ZYIq1UprrdHI2PjV3KWiSS
 VmKdel0OHAXmlX6ap/G/8nhFbpUpDTfwvmpIpsw==
X-IPAS-Result: =?us-ascii?q?A0FXAwBukcdlhw4P49RaHgEBCxIMQIFEC4I5gVIyBAtIh?=
 =?us-ascii?q?FORaYQ7hzeHTohwgxY+DwEDAQ1BAQIEAQEDBIR/AodXAh4HAQQzBg4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXBw4QJ4VsDYJcARCBD?=
 =?us-ascii?q?oEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgECAgEjHQEBEScPCxoCJgICVgYBF?=
 =?us-ascii?q?AEBgnyCKwEDDiMHsiyBMoEBggoBAQavWh8sIlaBYQmBGi6IJgGFb4Q7Jw+BV?=
 =?us-ascii?q?USBPIJSMT6EQ4NbgmieM1SBAh0DgQUEWg0bEB43ERATDQMIbh0CESI6AwUDB?=
 =?us-ascii?q?DIKEgwLHwVVA0MGSQsDAhoFAwMEgTAFDRoCEBoGDCYDAxJJAhAUAzgDAwYDC?=
 =?us-ascii?q?jEwVUEMUANkHzIJPAsEDBoCGxsNJCMCLD4DERACFgMdFgQ0EQkLJgMqBjYCE?=
 =?us-ascii?q?gwGBgZdIwcPCQQlAwgEAyspAyF0EQMECgMTBwsHeIIJgT0EE0QDEIE0hT6Eb?=
 =?us-ascii?q?wMZKx1AAgELbT01CQsbBiIBHQKkXcQigQY0B4I0gWCBYQyfOAYTL4NykzwOB?=
 =?us-ascii?q?pJemFcgqFeBeSSBXDMaJIM2TwMZD44gGYQUj0dCNTsCBwsBAQMJhUYBAYNag?=
 =?us-ascii?q?UYBAQ?=
IronPort-PHdr: A9a23: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
 /DKk7/vbihP+ZTY8JlEbyA7AN2KOjwtPEiwcAM=
IronPort-Data: A9a23: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
 VQIeF0=
IronPort-HdrOrdr: A9a23:iOZ78quByb1Vm1Z3ivoEFPg77skDqNV00zEX/kB9WHVpm7+j5q
 OTdZMgpGbJYVcqKRcdcLW7U5VoLkmyyXcY2/h0AV7mZniAhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgjWQL/Zl5sWb+6a1gurkw25qVhwCUdAb0+40MGem+lYdfng/OXPVLu
 vm2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3A9jmpPmr4khduhsK6yQiDHkbmUZgiVXqa0G7UGki?=
 =?us-ascii?q?HOTtFUOGHFF6ho5oxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AGk6r9g61CSqViiuCRy4RPTqDxox3uKX/FRgprqk?=
 =?us-ascii?q?HgJmjJBVNGj6ajgieF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,259,1701126000"; 
   d="scan'208";a="79286081"
X-MGA-submission: =?us-ascii?q?MDFJspUUdSf5ml3uq0H7o1R2UC5BrzdjAuZdM+?=
 =?us-ascii?q?XUw1YDhYnfzQ7dt5oS0lnzchHVoZp+YKVeg+BYLHkNIJrVnkzKgAo2ez?=
 =?us-ascii?q?SjiUx9mL7oqzEfdgLDfHxur5ptfjva9kxWU1kUUFGQ/nWWI5r/ZWGbvG?=
 =?us-ascii?q?ZJHdN7gYgUknQJQxtAkUJGPw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 16:09:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707577789; x=1708182589; i=markus.elfring@web.de;
	bh=TFu/+3HPXRPaiSKqx/HPTymlXDOCarQiACduwCXSkb4=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=B7Bq514kH0ofIBV/FbrJePfxdTV/sLfmwrpLtU2SCNGgto8644dpFHFCxoXQOQ9M
	 DCwRftNn0cIBRNxvz8TIj4SRdfDBPlw8cU8M3/OlH0f8z3h8Vmij7/dx48v0/E3o7
	 pI37iH+gh1Qvr9OFHIngADpqyGIsLHs8iYsUC0io5WU7WYrqpEhhoaE55eR60vURX
	 Rx9POl4NvaJ8VUpTb++sM039yKJoqk1VidTUqrEwRVedmHEAGiUns5AJxJ7Cu8ey4
	 2hUw4Nmyk5CvFkpVrOzNCwe2anrtEkq88piOL5t02c4+iAi6joeTyBcGAtRGGIqDz
	 8Ophz73pJ6QPT+Nd3Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnpGw-1rEMWl3HZK-00pJn4; Sat, 10
 Feb 2024 16:09:49 +0100
Message-ID: <b8b858a4-8d5f-43ec-95bd-c114ad980cab@web.de>
Date: Sat, 10 Feb 2024 16:09:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <d4abffb5-6221-4109-9316-acb5c3720c31@web.de>
 <alpine.DEB.2.22.394.2402100936350.53569@hadrien>
 <1c2bfc73-cf2e-4949-bf60-6fc432ef67a8@web.de>
 <alpine.DEB.2.22.394.2402101124030.53569@hadrien>
 <501ef7d8-223c-4647-a302-7aeee083af14@web.de>
 <alpine.DEB.2.22.394.2402101421490.53569@hadrien>
 <836e2ebd-a9cf-4644-9619-2526bddae0bd@web.de>
 <alpine.DEB.2.22.394.2402101554070.53569@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2402101554070.53569@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R6zHoEXHQ8gZ9kx6q3Xrg6GZEP5xWgQN0jmUlJz6hHB6qQtYY/8
 JGtouAjEcGnisy1nz2+cqNOKzwFEwAL3mhh4bnw2OAZ6FqJTQ+hcrS8KJGGvkhNknLMK3YR
 4a7M2qjNTPlbctnStDrSD5UIPVV2ElqMUIL8h9t1dPM20YchcSOJDoFiL3JynCOnxV9uQ2d
 pqaiFdRHoHiQz3alBh8RQ==
UI-OutboundReport: notjunk:1;M01:P0:FjZHiA/kH/M=;fZWM6+mfkQWHhR5Q4E0pD9uPbQu
 Qu/UiOiQ0mKIVaUajP1m95nYX7NejeKifAkU4aKz17cWQr9QWoiX8cUMLx+FC9AObhNhJGYTY
 H3/pRREObqsk991MULQ77EsyImlm7RohwDWqZ6pqLiZY701TPWxlf7GsMIRl7VUSWWPznKWOW
 ym88mpWiDzcXy/M5b3/bxTs2HmX9MKHaVln/HLB/RJPnkGTwR9DXIovRpKJMJA2nLhABxFvPk
 GqIslirAnYunY6ccpfF/H6ylW0HnCpntdb2frzukxfEo6x5ZS83DCRF8QkkXS5JDdsuNvF2lE
 rwzy5+COTxQZWVueDESXMIn/w3LVFerHgNDt+9huhl2XRwoOQRiB8QRsv4G6EC0y/Eanp1Uh7
 90r2OacRn5X1TN/sL9w8PSWBYDiA7BfokkPJLxpN3yJXmyWYeqam2n8+73Y/vPKqDw4boF2ki
 wdQSGHnWPJp4EHUkDhLiPWR8rpgv6+VCR7oa7vpxG3TzM38HVyxod5bHOZzKpS3zAzBPXp9lp
 xjgVHuy2Onz+ujBimOpl6G4GIpBp/2Nqsj2TCOQT1GP37sW9HpmnD5PRq+YgowQXUvr8TYN4C
 l/elihHbgHIZzHSqYfMlvnvX8Ko+9dK1ER7R9MqnMoAP5wB/jZzaS3MyyRnvn07jjmrRbVyoA
 xAz+AtbSVv83aBVLzLe6cZVOBm66cPkYU+hYnT7h2597fZoazydfAGjUs4Bcbh1Vhs8OnBUXf
 nWg9RKoC0oI41CXucm8X8YTD86HjR2FxFAaw9NWrs0xlt+uWdoUow8XEquIJIbOsK9Ud55GL8
 xTRvErfYMlH9u7nWdyAV6wmsVoDa9wlgc9jPh81dd2Y88=
Subject: Re: [cocci] Extending handling of position information for SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1540
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/b8b858a4-8d5f-43ec-95bd-c114ad980cab%40web.de>

>> If you would like to support references for already assigned/bound posi=
tion metavariables,
>> you probably need an alternative notation for the specification of corr=
esponding identifiers.
>
> It's already supported and there is no need for a different notation.
>
> Just like for any other metavariables.  For example, if x is a metavaria=
ble,
> you can say f(x,x) with no special notation for either of them.

Are there further constraints to consider if they would refer to source co=
de
positions next to each other?

Regards,
Markus
