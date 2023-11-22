Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C142C27C40
	for <cocci@archiver.kernel.org>; Wed, 22 Nov 2023 20:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=pg1iqOs0I4UjIzpwNaG22vETHl4Wc4ei095rSplVcj0=;
  b=i7o9O1fHUw468iqlo9DjJCvmwlwX254/IR3AhLBAtvcj9uRpBJ8E+DHM
   pyo1pDK+YYCAicBuiqfBjQrtGl0DJzFMrO4BGS1xxnJe5cO1fTNJhWZo0
   kaROwF5ndChJaseVmX7HKPpxCiw+vRUh3Wh22dwFEONvZCXbnWRF98Ytu
   M=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.04,219,1695679200"; 
   d="scan'208";a="137977647"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Nov 2023 21:55:16 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1E0A2E0CCC; Wed, 22 Nov 2023 21:55:16 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 66858E004E
	for <cocci@sympa.inria.fr>; Wed, 22 Nov 2023 21:55:15 +0100 (CET)
IronPort-SDR: 655e6ab2_zCQ1PmH3fiy5tJijae9h8nPp8gmyGNHP6SQvm5Am/leANs+
 1hGpAioMDv52jr3ZI5dOh37r/BVxH8Jn7szm0sg==
X-IPAS-Result: =?us-ascii?q?A0G4CAD7aV5lhwsR49RaHgEBCxIMQIFEC4I5gVAwBAtIh?=
 =?us-ascii?q?FORMi0DhDuHNIdKiG+DFj4PAQMBDUEBAgQBAQMEhH8ChykCHgcBBDMGDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBIxcHDgoBBSeFaA2CX?=
 =?us-ascii?q?AEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR0IBAgIBIx0BAREnBAsLGgImA?=
 =?us-ascii?q?gJXBgEUAQGCfIIqAQMOIwevNYEygQGCCQEBBq9VHywiVoFfCYEaLogNAYVZh?=
 =?us-ascii?q?DUnD4FVRIE8glIxPoRDg1uCaINugiuDDoYtg3qLAl0iBUJwGwMHA38PKwcEL?=
 =?us-ascii?q?RsHBgkUGBUjBlEEKCEJExI+BIFhgVEKgQI/Dw4Rgj4rNjYZSIJbFQw1SnYQK?=
 =?us-ascii?q?gQUF4ESBGobEx43ERIXDQMIdB0CESM8AwUDBDMKEg0LIQVWA0IGSQsDAhoFA?=
 =?us-ascii?q?wMEgTYFDR4CEBoGDCcDAxJNAhAUAzsDAwYDCzEDMFVEDE8Dax82CTwPDB8CG?=
 =?us-ascii?q?x4NJyUCMkIDCQoFEgIWAyQWBDYRCQsrAy8GOAITDwYGCRsEDgMZKx1AAgELb?=
 =?us-ascii?q?T01CQsbBj4CJ6JXUxmDVB6Se7F6NAeCMYFfgWAMnyMGEy+XIg4Gkk+YQCCoN?=
 =?us-ascii?q?IF5JIFcMxokgzZPAxkPjiAZhBKPR0A1OwIHCwEBAwmFRgEBg1qBQAEB?=
IronPort-PHdr: A9a23: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
 ZBIRrIJDDTd+dsFB04jENFQef9K
IronPort-Data: A9a23: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
 YT5qa2ojq12pY4d3PuMo0JoJSw=
IronPort-HdrOrdr: A9a23:FWx1WaDwjVaIXUrlHely55DYdb4zR+YMi2TDpHoBKiC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOk9K1vp
 0BT0ERMqyTMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:MY7Vo20zAr9z18fbc2JUubxfINskSHnxlVbsf0aoDzZVEOO7eVqA5/Yx
X-Talos-MUID: 9a23:zGJ4CQlYJ7B2QTv0MnM3dnoyCsdq5K2EJHk0usg/o+CVCBJZChmk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,219,1695679200"; 
   d="scan'208";a="72301859"
X-MGA-submission: =?us-ascii?q?MDHZ6b9gyqNvq9qdp0q6y1/CNdD0E/UWXB/YQc?=
 =?us-ascii?q?+W9d6xhBC6vbqpT9iAArginzygamIu8+njiHouo6ez+ZNA49V/U9zDue?=
 =?us-ascii?q?5przJLkvLlZTTreZ9cJO+sGvSoV8DAvRnR3Cpoz2rWn0JEKvHO8sjzKj?=
 =?us-ascii?q?5wf6PBE5OajqdzGMA05MsBCA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 21:55:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700686513; x=1701291313; i=markus.elfring@web.de;
	bh=pg1iqOs0I4UjIzpwNaG22vETHl4Wc4ei095rSplVcj0=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=g/msdv0Z2siSujjDNxMGDiVAGdIgO2SJfI4Zc0vWW7b/BFmx8pqWJcklQaJSQaQi
	 OZOffn1/h0bzxieV9c/MuHMCT/osKpyEF3jImz8bv4P8MaWI6c23VektbgwWCtG9p
	 FKluvd0DI0adgbt2q+r9851dXn3COcIJpnCLwyrftSJkhthQflIGh9cWMO3txlpqa
	 1soKaMbYOLL4XWoB4vdK5NX2IMgtX6Pt5Msh8qFJfgVTHS/4LjuQRqAS3Tu+XNpAP
	 6qIGNZ39b90Zgm9A7/K/kyrYxv9fHjT2H0r90fYEMMVsg2uIvQ+2eEHlH3RmW2fZ7
	 z80OfIXB13iwKXNZRQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MI3p7-1r8uuc349H-00FB7B; Wed, 22
 Nov 2023 21:55:13 +0100
Message-ID: <471b38f1-fc2d-482b-ba0a-8c7982ba9618@web.de>
Date: Wed, 22 Nov 2023 21:55:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <83e9ceda-9f18-4bb5-a945-261e2c03a427@web.de>
 <43f969f3-94a5-6cd2-74a1-ae46f74de331@inria.fr>
 <a59723a4-9b39-4de3-8efd-101c5f8485ff@web.de>
 <alpine.DEB.2.22.394.2311222131120.3262@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2311222131120.3262@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FB5Jmmmjv7XxQs2FicaXNmNAvjdoR4WfnsPYg9ZjkZftmfmEUFO
 RrHPCZIygG//D93RvNRu7A4AFwsIT0m+VFL5XM1+rIYdd4+s0emdFZ4zeWGZPaG6xqwhG21
 O3FhK3PiBxNhvO0lNL0hAdbQldLipUrwR2e/CcyyFHQiUyDapEVpLZrQI2AVnyC5BNCHkNG
 UJ5v60mAB2su2zzpI0vsw==
UI-OutboundReport: notjunk:1;M01:P0:msc2VfpnVeY=;SUQjbQlbgHsBH0szQON5OzsanqP
 ksapqt4K5YBjZnwjPffyYC9/ez6IEOm29VVwWaMtB2TVqAsAmsauPfPs/82JPGp3in3i+8IJo
 K0J0uoeUHH+yVshgPfwcazQdQVTEGD3dfXoLwT6uHUiL3DpzSDbOcGJgmsaSAekx8U9x9Fes7
 NqCY335cydaCKNo+Tg2Mfi3Zn/oh+Q6KdVsQXhbqkvZtx+ao98tvVrzUzrYTHxb07ueoAtFUz
 tlDrkVwESI5e1gWcO2n3J6508IFm6NGwqCWdt4dmmejdRbHkKxSBmngcoP7iOIhKBFrYBzBaY
 B0Kz+gC8duTyOH+H/sPwpMhh7ml88u1KCuU8WmMZYE9udtwLw6HrTGeU/+9HnhsEDq44rbzuM
 Ydw+oKW98JTdd+1mc6JV7jGARkMiRuCv7OjW/FCiYViOW1gllyfTUtFLF5lNoB16h7X0g+PAv
 2S9sMNEeIBDs6uJGPcvqRvTMcb7X8ewXk8DsPYcS1bOy+iu3No0+FbLRPUfeG7WBMyWOf/TyG
 4oSrXtgd4gsOHNjl95Tr/GCYJ7WbvObsoSyJCdWVZqY/h8v15tZYL7EZxsqKHhn97lZU5cJ66
 IP5VhHXFwjjDwH/iHRUE9gDTfGUSNSp5Mnow6GeIO5e/ZOJ7TTOQIWjqQKHcLtYDSP9P0YrIH
 PEUdCk/8WWeyCk+/uREtXf2merb0GhQd2NRWL7ecFgvy9WKgx76LCpLqiy5dc7k1MRVlzjiA2
 bo5fpIUU+HSG4dng4AGZpV+A7OhhnSpyEUCeuJ8x7VDOb2JAEbmV+5YHnEz7uvABhS/n5001u
 diaPRUclGLgCV5s8x60HJEvVfmufSmYk4RpkjxQPusetBozmfvK5vWYort4C3p2tzm2vD6wSv
 f/1cSCqAJX6YgIo2wfrjcAaJGSEJI+v9JBMigVC9tbvxS1pKTOROce/ijGx5JF8jprQsW9AJc
 DPpk9w==
Subject: Re: [cocci] Detecting statements from the last if branch (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1310
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/471b38f1-fc2d-482b-ba0a-8c7982ba9618%40web.de>

>> But it would be uncertain then if this code block would be really
>> the last one within a selected control flow.
>
> It would seem that it would be the last one, because there is no else.

Such if statements can be distributed within function implementations.


> But one could have a different optinion abou what "last one" means.

A code review can point implementation details out for further considerati=
ons.

Additional context data can be provided around and/or within an if stateme=
nt
so that it would be clear that such a code block belongs only to the last =
if branch.

But I got the impression that the control flow analysis is more challengin=
g
for the general case.


> If you don't want any subsequent ifs, then you can put ... after th } an=
d put
> when !=3D if (...) S1 else S2

How do you think about to count involved if statements?

Regards,
Markus
