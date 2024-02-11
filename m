Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE62C4829C
	for <cocci@archiver.kernel.org>; Sun, 11 Feb 2024 13:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=FzBI6xnvopl5t6qYrDf1Ke1jsds3t9tHn+XyE0N2UXc=;
  b=sOaknZbhCcry2OlJ8HqH5jc24e8VzAMoJaDxjV9ajwlEnmoKjR1wFvsc
   VLp8QucqOy/S/o+2AbNPeqj4AgYX3HxR2JURduhaB/qGdHJTu00scTmwA
   pKd0ltXQHaLGOhnZJFvnoZqzqy7za3x3ULUJ3+XzUC/jpZf6VcOg0BUJy
   4=;
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
X-IronPort-AV: E=Sophos;i="6.05,261,1701126000"; 
   d="scan'208";a="151358941"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Feb 2024 14:34:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 008EAE0CD5; Sun, 11 Feb 2024 14:34:45 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AD4E5E008A
	for <cocci@sympa.inria.fr>; Sun, 11 Feb 2024 14:34:44 +0100 (CET)
IronPort-SDR: 65c8ccf4_cEowUxRUKnGiBmG0Hrfu4LWM8xyxTekhl/F4gg3i+DXJKAT
 KLYmg9Bnrt/VvMWYjwNWVf5VB4+OmDDCvTenVWg==
X-IPAS-Result: =?us-ascii?q?A0GmAABhzMhlhwMP49RaHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YI4f1MyBAtIhFOROYRrhzeHTohwgVaBQD4PAQMBDUEBAgQBAQMEhHUKAodXA?=
 =?us-ascii?q?h4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXB?=
 =?us-ascii?q?w4QJ4VsDYJcARCBDoEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgMDIx0BAREnD?=
 =?us-ascii?q?wsaAiYCAlYGARQBAYJ8gisBAzEHshaBMoEBggoBAQavWh8sIlaBYQmBGi4Bi?=
 =?us-ascii?q?CUBhW+EOycPgVVEgTyCUjE+hEODW4JoiQNilENUfx0DgQUEXA0bEB43ERATD?=
 =?us-ascii?q?QMIbh0CMToDBQMEMgoSDAsfBVQDQwZJCwMCGgUDAwSBMAUNGgIQGgYMJgMDE?=
 =?us-ascii?q?kkCEBQDOAMDBgMKMTBVQQxQA2QfMgk8CwQMGgIbGw0kIwIsPgMREAIWAx0WB?=
 =?us-ascii?q?DIRCQsmAyoGNgISDAYGBl0jBw8JBCUDCAQDKykDIXQRAwQKAxMHCwd4ggmBP?=
 =?us-ascii?q?QQTRAMQgTSFPoRqAxkrHUACAQttPTUJCxsGIgEdAqAagUDIJDQHgjSBYIFhD?=
 =?us-ascii?q?J84BhMvg3IBkzsOBpJemFcgqFeBagUugVwzGiSDNk8DGQ+OIBmEFI9HQjU7A?=
 =?us-ascii?q?gcBCgEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
 9KJmK+hcV+qFvrL8MFaC8WGcKq6
IronPort-Data: A9a23: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
 VQIeF0=
IronPort-HdrOrdr: A9a23:iI/1F6naZGMVK050jLHtN2dtplPpDfLy3DAbv31ZSRFFG/Fw5P
 re/8jzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNOftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njbL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: 9a23:nfyb+2BDoHg2e9v6Ew1u92EaHdsfSWbYxU/NAxOZUFhqUqLAHA==
X-Talos-MUID: 9a23:Iq7qmAaF5Ak/1OBTu260tQp7ZOxTxbW3CFEWuslbie3ZOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,261,1701126000"; 
   d="scan'208";a="151358939"
X-MGA-submission: =?us-ascii?q?MDGS8UqnSdyyDrtzA2hscRjpxXgJdErzjhPS2Q?=
 =?us-ascii?q?+aOLQERpmNJ9Lh4zccIBlTxEnjRISCx5yAEYPAmqWsXrSmqUUsPos68Y?=
 =?us-ascii?q?WIOugLqbYWVRox425RjKvWHdoG3VF02fQzCEOXGK6hsrLDnYKO4opAmY?=
 =?us-ascii?q?AOF0oJdNoVMQXjXBE8RRh7Uw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 14:34:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707658483; x=1708263283; i=markus.elfring@web.de;
	bh=4/1tM3Ms7OCtKKRZsQ4At9+0drEsZeSoajGNY5E6g6Q=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=cD/d2lGPKxYh07s0FrILOkRBnMNboKxzipYJglg7FzB4Rx+muSmPBLCzf2CsOKHl
	 Fafl6QKOKjR/AT/1BWqA5xxkQcTi21VM4+uvQnEh/ihplEzZZQaBV+H9b3G9jmqBd
	 h2cW8UHlAaZaiZudiwkQRnAXR17oQqWa6jxJj1VaOiQKKrX741S/ZI1jWZ2zMsqZj
	 SFKISQVOMx3kW/OnKULylmvOSeHM4agr+1IHuLCQGyn1QNEe5hHPikGAy1D/JY0Py
	 Ey52htIdy5KGmJc7uOv72zo1Itu3v2QcavmRjte3UjTAzLA6m4olYWOVzAlpqTbQh
	 8lGXbhTaeXwPj9Npvg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4bYo-1rao8j3OFS-001gyx; Sun, 11
 Feb 2024 14:34:43 +0100
Message-ID: <b6318c80-5ced-4ae1-bf26-52826fbfbe7f@web.de>
Date: Sun, 11 Feb 2024 14:34:43 +0100
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
 <400ced6a-bf8b-4ddc-afea-a5d0bb49234b@web.de>
 <alpine.DEB.2.22.394.2402111426580.53569@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2402111426580.53569@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1vX5gvrL0FZYAmrcqwIjg+0RNZVh5iMBIxqfpJGCA4aaU/Q0Vi/
 W2D0un4YKdE52u3RHjbThG8b7KoBJnXwBLFQ9qSQjdw83dtutDR+gO0k+zcsdUFAFObsERG
 IQk4vBi8c2EUQONtEB/MB49fd4SJeRGVDsmpzn/bbkVgX0OoiMMhvzFgyoRzrRj7OpjnnS4
 OkuurmKwFXpDSB74dY1rA==
UI-OutboundReport: notjunk:1;M01:P0:mAZG5y4O81U=;qX0QUnmC78tEPc1PNLaglmHUfLp
 HCvtXiFfPGZfY6ihd4HYQVIJMd1LDPRaTKIvaVT9OxG5gwOUAKDJkaosbDvc3/Y7Ucs4B/avQ
 mwZ8Vg+JSScR5FQ6erpJ8Y+psWfvfloRgxIVO3xHjpHx4OZoLa4TRUl9WL7ksM73GWLxuZTaK
 nEgRyIiRlia/hGfsTGt9nuSojGdSnoM/uNvSQPLC4jQVmV+iAFOZDe9Jhz/9czvfDoBsUmLo3
 lmlMFN6FoOT4Px3nnUY2B+Ucj0iim7WwSwmLBjRZCaj1HstWj7KjDRM6ddvVMM659ETydr6bp
 TnfdCc9vSAO8/VUjuzeU0KuHEQrB3MyPABEsMxDzpXjRbFua9uGgK8xGFp3UdFzBt7r/7j1MK
 NtaMABgixV5gtdkPlk8bk//NAdHBxRCueKPut7QG7Q3LEIkTk4gmPTkhPn5dm317HaznlHy6s
 AbqdMqR639rX1FSqw0KUuMbDm9jG7gdo25rlHxTjQ6DJzN0UD/lJXbPb7lCjZLu8YDsagpLcP
 k3Jr9BgDyKjpIqQWsCay3B0NSi0EFkSGRXD+X5GC+BnxrOHyQqwMt4NMiHodmfl5+bRjFnwEx
 2aRTycx21mc8qr3HpAwPSne1x1P2jcn0o70BV+D/0MczRkHFABEjmIbjYwuAyeBH7c469ouJu
 Lbo0mjR/Ma7YQmLcCYY3hL08fanLqhq5fWRnm8CUTm5lA/hudFArTt+vA0oHQNZWGtboWaGtz
 EevJ5Os5ygigJa183Xz0+ULwgH9In3XJEKb+79GaTKJw6OoGROCcG6MzZ0xOxsrvL9rt8Umax
 XFKgloAJZdCnKwK/3zsRyylylkffuqtefK6bNTMzmWjgM=
Subject: Re: [cocci] Extending handling of position information for SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1547
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/b6318c80-5ced-4ae1-bf26-52826fbfbe7f%40web.de>

=E2=80=A6
>> @rename@
>> identifier f;
>> position x;
>> @@
>> -f
>> +g
>>   (x,x)
=E2=80=A6
>                    A position variable has to be attached to something.
> And anyway, there is no hope that the two arguments of a function will b=
e
> in the same position.

Would you like to offer clearer error messages for such special cases?

Regards,
Markus
