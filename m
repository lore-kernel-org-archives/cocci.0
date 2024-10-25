Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D0DD116F4
	for <cocci@archiver.kernel.org>; Fri, 25 Oct 2024 05:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=uEVAqJjbdi/ZsMGTkSiG3Jx79liKFoL2Z1Op909MUXc=;
  b=I6gN4GuVrgkiX0TBpYoIsuaapARgzIFS3b2mA364786d74f68sOE/l62
   eSSphDgp+xaXYpRuZJcam07025TGrpSriNNLufdutiPQrVVafg1wLlpnQ
   milkUnoVRvoKtHZojKspQ/w/dZ1cr8rmPD6eVrB5/hQY/9+ICVdH9AfAl
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.11,231,1725314400"; 
   d="scan'208";a="190654923"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Oct 2024 07:38:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 92026E0D1E; Fri, 25 Oct 2024 07:38:48 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 659D1E0133
	for <cocci@sympa.inria.fr>; Fri, 25 Oct 2024 07:38:45 +0200 (CEST)
IronPort-SDR: 671b2ee5_gwkGYARVQ1fgDzt//5i7hzFELtqLGc9xr3yMY0Ky8Hq0a2K
 QbFuDoYsuec4KOOdQ04L0mLwmIoBt8YfvqG/Czg==
X-IPAS-Result: =?us-ascii?q?A0ElAAA9LRtn/wMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDB1sbWjMEC0iEVoNPhE6HMIF0MIQ7jw6KSxSBag8BAwENOwYBA?=
 =?us-ascii?q?gQBAQMBA4IMgnQCiicCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQKBCggLhTVGDYJiATNxgSUBAQEBAQEBAQEBAQEBHQINOkQBAQECA?=
 =?us-ascii?q?SMdAQERJgEPCxoCERUCAlYGFQEBgn0Bgi8BAw4jBw2vaYEygQGCDAEBBoEI2?=
 =?us-ascii?q?VMfLCJXgWMDBoEaLgGFaYJiAYpgJw+BVUSBPIJLOD6CYQGBGkc/gxyCaYcSg?=
 =?us-ascii?q?lWDNIRugiqFVoNqJYRvgiKBMG6HS4seUnscA1khEwFVExcLCQWJNQqDHCmBR?=
 =?us-ascii?q?SaEEQiBKxODX4FnCWGIQoEMgT6BWQGDOEqDTIFhBThJgk1qTjcCDQI3giSBA?=
 =?us-ascii?q?IJPgSUEBYM8gXsdQAIBC209NQkLGwY9rC4BgVlHg3Ure8c6NAeCOIFlgWMMi?=
 =?us-ascii?q?ieVLgYTL4Nyk04OBpJ4mHeNfZsjgWc9gUERBzMaJIMCAQEyUgsOD44hDBaDW?=
 =?us-ascii?q?DPKMkE1OwIHCwEBAwmFRgEBiVSBSwEB?=
IronPort-PHdr: A9a23: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
 CaA9raGRnm5n+PJxjc1CHJz
IronPort-Data: A9a23:axyX6a5WZuU96qPp1fz+DAxRtCzGchMFZxGqfqrLsTDasY5as4F+v
 mcZWTyOPa2CYWCgKtl0PY/n/EgF6MPWytFlHQVt/ns8Zn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOC6UoYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE0
 T/Ii5S31GSNhXgtawr414rZ8Ekz5ayo5WtB1rADTakjUGH2xyF94K03fvnZw0vQGuF8AuO8T
 uDf+7C1lkuxE8AFV7tJOp6iGqE7aua60Tqm0hK6aID+6vR2nRHe545gXBYqhei7vB3S9zx54
 I0lWZVd0m7FNIWU8AgWe0Ew/y2TocSqUVIISJSymZX78qHIT5fj68l3LBl1GaE6we9MDmdS+
 /ETOm0gVjnW0opawJrjIgVtrsEkMdWtI44V/H1tpd3bJax/G9aZGfqMvIIeh1/chegWdRraT
 +8Qczlyd1LtZxNVO1EYII0zlqGkixETdhUB+QrL+PZmuje7IApZ6L7nNfeKd5uxS9RRh3TJi
 kXDx2XAO0RPXDCY4X/fmp62vcfEmijwWaoJBbig/7hrhkeSzyodEnUruUCTpP6klgihVtgZJ
 0F8FjcSkJXePXeDFrHVNyBUalbd1vKxc4M4/zESgO1M9kbV3+pdLm0DUyIHd9Es8sM7LdDvO
 pllgPuxbQGDcpXMIZ5eyltQhSy/M24ZIAfuoAcaGBAd7YCLTJ4b13ryoxUKLEJxpsL4E3f8z
 lhmacT4a6o71aY26klwwbwLb/9AaHQEos7ZKzg7hl6Y0z4=
IronPort-HdrOrdr: A9a23:i4yVp6/sraSh7A8I/Epuk+AMI+orL9Y04lQ7vn2ZhyYlFvBw5P
 re+cjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3A5RqryWlIx5/463EA8DigC/CUdkvXOUHE7C+TB2O?=
 =?us-ascii?q?aMm9SR7uJR1Kb6v5Jq+M7zg=3D=3D?=
X-Talos-MUID: 9a23:uR11DATfs/4HBQQuRXTUgjtnGZhlpJ+gGUQUo8QqnMy8NBVJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,231,1725314400"; 
   d="scan'208";a="190654917"
X-MGA-submission: =?us-ascii?q?MDHjd+cYFcpeSzlU5pI75gs6H73MGWaXxpmyZc?=
 =?us-ascii?q?1QHnQWKi/i216kpsVUHzDRJqyO76utgulBz4P5Fc5gqj23AfvKPN2KHF?=
 =?us-ascii?q?xHVhiV8FnckNPmUy3cKh53pR+oOfa8j2Mz3xvu1IWCMFHYGde+mw7UoG?=
 =?us-ascii?q?ltX3+zj1caAympQfhFDfvclw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:38:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729834714; x=1730439514; i=markus.elfring@web.de;
	bh=uEVAqJjbdi/ZsMGTkSiG3Jx79liKFoL2Z1Op909MUXc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MBxZv5Na1tyOSi5Bd9wYAAc4upZZxAVyebtsdB9hHtxLgJtei5Rrhs4FRP17HzoN
	 0PJpVKqrxO3qVisGYQYO/GfHfGBTHmkYObrxPlTw67+I+ltcNbx541AEP8mgFiSjh
	 5rFEm+NE40KrFgEF62BA348Iy46QA1vnfB0bf4Uii01GNRrWIJspEBVfDlRGk/MQ5
	 1jQEGELJAJoFfH81BUrdfQHBE96avyynV37UJwZZBGTeyoEVNZ3ECbgjkr/3tyxBb
	 JyHWHVE8SiioXoFO5NPl2YFgFB3hs41w/BU5llkrIDl0I4dUFk1Iy4PxKi0/nZ0hd
	 MXdBKF/tkXLQVnQ0rA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1rTQ-1t206T3uDQ-00F6DI; Fri, 25
 Oct 2024 07:38:33 +0200
Message-ID: <582c1098-213f-4c6f-ab35-4a7fb508c2a6@web.de>
Date: Fri, 25 Oct 2024 07:38:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Derek M. Jones" <derek@knosof.co.uk>
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
Content-Language: en-GB
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d32d5bc4-3299-4977-bb0a-a3b0a53c829e@knosof.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M1tY4+phgW/3/KWJ5q5i8MH6NUDEuB19nuWw6jDFXnY2klOsKR4
 IIXHLP8KUpBlVBFJu5kPsuAPnCpd95E4W2qExi2iTo2odj+gpOim0BF30HqCf5DVG/2wdnP
 EQ7f6cYFxI8bK2f/Bviygy4DN0v6amCnFbRutIK2lGlCHmQbKRDgwud4QLtzHuvS53bL3mc
 nnocKqutbMHHWkPH+hA8A==
UI-OutboundReport: notjunk:1;M01:P0:Jej38Gw6yOg=;fb0AONzy7ymjGQjdXLlro8A/x9Y
 d7Tx/NatCZz9w/puUX647PiXxVAPvL/dhTekJLrnUVIaWruJf5KzVVvT+KYTtgRBhke7IzgdZ
 13iJm/GWN79V992XFsWKKdsTN2Gb/rhuvVNFaX+okTgF49XfJh90WFok1+a6RQoZj55anZGEF
 DqWDGyUnfYlMTHMUDk/8q6WWsnYGinLNheRnpRNtNa66GxAyYVd3ORmhrGsOO3SyRfp03Ol1h
 i/JKnIGEzfWXNow3IjHPo0jzWJXidV7Fx/gyaXcTqp04XA9+OeaTiDILSdWcheaLaokXKen3E
 j4ktC6lNLYqRIB9WygH+nUTIPjwE/XX8CfyYyBLXULGcFDrrQ03FrcwXcE6dzhaobEelgBRi7
 8lHctnumV1gLekSyrJSsPDw5dMFVpF7I7pfSJRZ5SjjhZ35ND8/kYMacIdKlVrM+PcCtlhOP0
 XHpMRagizZfqq/IGdTlX0LWohyHvEzWbhnftx2IUVi+pmSplDe6DgervdG+oyi9rQnnxX4Q7Q
 HlBPPt6/SwyS4B2FQ0X2++RQDn11rJzEmZpdEToUxczGfC0lp9m7ICSRGfj1ZMqw4SMlxwU1B
 aS0l9gpEpI8unqbaSfEjVBpE+rxXZBF7xT5Mw1nOyeOgeKFGf7gmKaSTsfRd3tE800bE0KTjk
 zdppyRr4RrbhoIyON5JH58DyJ4lBno3hgxvYgibnnbqa1bQeVvnt2DanjWk3uqqNJtArhOy5U
 P7S0B7pY57mKFeQWiM6h3v3R9zWKjeJZ1/rsWrX3fjlVv7bTrqE13YMVHhV0HX1LhqDrzdfoo
 3rzB3lR8B6ze2GEbksTm1SCw==
Subject: Re: [cocci] Multiple returns significant performance impact
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1937
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/582c1098-213f-4c6f-ab35-4a7fb508c2a6%40web.de>

>> Which analysis goals did you try to achieve by extracting source code
>> position information from function implementations?
>
> An example
> https://shape-of-code.com/2024/10/13/if-statement-conditions-some-basic-=
measurements/
* Do you plan to analyse any function implementation sizes (according to y=
our statistic approach)?

* Would source code be taken into account also from header files?

* How will the clarification of software run time characteristics evolve f=
urther
  for advanced usage of the semantic patch language (Coccinelle)?


Regards,
Markus
