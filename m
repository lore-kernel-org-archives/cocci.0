Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931EAC7EE39
	for <cocci@archiver.kernel.org>; Sat, 28 Jun 2025 19:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=LuAj7OksYsVlZbChAoJMHqmKOV48KrH9W83EyoloqgA=;
  b=c2Wx8VonrYZ5ZVDN11OzwYaMrzR4G9mAjv0iTSEIpQfPSb7UAdE+XdRG
   zfTcXJvb6xC7BUy0rhnRaUfVcXVXJkozHGnlcoA2z9gF6e/9agOx3ACeT
   LEFNK2XWieVCQsFG+qh1wDFD5XGa8jJnVy1MvD3AIPCFsamHhmf2t5pxr
   s=;
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
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; 
   d="scan'208";a="229434421"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jun 2025 21:50:49 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 137EFE01A8; Sat, 28 Jun 2025 21:50:49 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2874EE0131
	for <cocci@sympa.inria.fr>; Sat, 28 Jun 2025 21:50:46 +0200 (CEST)
IronPort-SDR: 68604795_ovO29Kyic/I1vqWAs+f2SgNwF5yooDGn5vo2oaKCBMJk7aw
 g/II8dmzivHWoHP6+daYXNsUbWzJ3jJQmu2xt8Q==
X-IPAS-Result: =?us-ascii?q?A0HPAACvRmBogAMP49RaHQEBAQEJARIBBQUBQIFBBgELA?=
 =?us-ascii?q?YJDgQZUMwQLSYRVj1CBdDCEO4c8h1OId4FVgX0CDwEDAQ1OAQIEAQEDBIUAA?=
 =?us-ascii?q?otyAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBO?=
 =?us-ascii?q?wcOCjGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREnDwsaA?=
 =?us-ascii?q?iYCAlYGARQBAYJ+giIBBhABAw4kB7JagTKBAYIMAQEG2l4fLCJYgWUJgRsuA?=
 =?us-ascii?q?YVsgmQBhieEPCcPgVVEgTyDAz6IHoJpgiaBFoVNlABSeBwDWSwBVRMXCwcFg?=
 =?us-ascii?q?SBDAyo0MSMPPAUtHYEnf4FOHIMegRuERStPgigBe4F6QRlBg10eBm0PBoEhG?=
 =?us-ascii?q?zZAAgELbT03CQsbBj2TAoMhHYJ+V0nEa4EKNAeCOIFmgWQMn2kGEy+DcROND?=
 =?us-ascii?q?YY7DgaTApkFIqkagW8FLoFcMxokgzZPAxkPjiGEM7xDQTU8AgcLAQEDCYVGA?=
 =?us-ascii?q?QGKXYFLAQE?=
IronPort-PHdr: A9a23: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
 ICnfE3bNzpItd7Zr5J07y38N8+NdnYsY0KBJQ==
IronPort-Data: A9a23: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
 aTZiIyKrIxXiaI8LCq4R0NoJQ==
IronPort-HdrOrdr: A9a23:8XFRDqOjyhATS8BcTh+jsMiBIKoaSvp037BZ7TEVdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVydygc378
 ddmsZFeb7NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: 9a23:/prqMWPyo3i7+e5DXTlF9FMfGMwfSWDMk0fofHC7NXhQYejA
X-Talos-MUID: 9a23:TLXa1QkEl+LZv9qVOaeZdnpnKex5+72rI3scy6g8uvCZbyJvGmiS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; 
   d="scan'208";a="229434420"
X-MGA-submission: =?us-ascii?q?MDFZrMAkaEoBsALZ5CJ1QxTtzg3xy0OWFW/KLt?=
 =?us-ascii?q?eJkeMerWTA6BoViNQdaD9/RGxIjfJwL5FW80jh2qDqiZ+XrzaEuO/VP0?=
 =?us-ascii?q?h0YpI14kXO4unb6hVIkgU6FMsxsR1AuQTu5I3nMMdSbT9iayxrlHe4/k?=
 =?us-ascii?q?4GMq7AkvmxrNc1DsQbIdpj7A=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2025 21:50:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751140245; x=1751745045; i=markus.elfring@web.de;
	bh=LuAj7OksYsVlZbChAoJMHqmKOV48KrH9W83EyoloqgA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KmOD4zdKCJvSga8mtZI7574LG5YMjOLm6uCaPAY16ZFSu4L7xOSiTQmItwhpzdPQ
	 qzuCmQcILGyfLBhxKDnjZOXcdaJQNi2a8vJrcrbT8yvkxkVN7Yb5E62xFg6aN72hV
	 oTDT7gPZSEQPajibuFwxHGlQ8CATz0VK8FuVlzD5bZFo6YQiA7R4WCKStkvyGlR8T
	 7uxQ4qUgB4R/EnP/HqIfjI+hXdtnyfVG8PpXYQw1FJAUc37VIWEBkHP33NjSDYhoq
	 c+bi7RtoB2XWP/gc2lN88+uxUg3tLmjfOYQKdL7hsH7FUsy6TQzVYd9KftNYRUPMP
	 TOZg4ZjPS0OwgzjYBg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.176]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N62yi-1ul8I90pg0-00trF7; Sat, 28
 Jun 2025 21:50:45 +0200
Message-ID: <47efbf70-5b53-4e7f-922f-b6405e240134@web.de>
Date: Sat, 28 Jun 2025 21:50:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <2038c080-a429-44bb-a572-c1f9e733320d@web.de>
 <alpine.DEB.2.22.394.2506281638300.50494@hadrien>
 <1f3bd2ed-0252-4347-835f-5fecda857cf0@web.de>
 <alpine.DEB.2.22.394.2506282132040.50494@hadrien>
 <8737f8dc-a10e-4f2f-8a50-87edc5c2aa78@web.de>
 <alpine.DEB.2.22.394.2506282142200.50494@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2506282142200.50494@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wgTcZDJBHrR0v/qMom+lHQ2uU7FM8XAttDgLAl4bTv2DplWQSu7
 8P7yKeVyGNVYcFPm0vCc5AjUHR5k1WX6PY6DAQeU1WDcnXULMyiMuQwXu0TjVGiGkLfdgAh
 5Ko1sWdMfP6ckrA2Tn53oXlb6I+DfCYQdzZppoBGdwdRZsRMABHJBVFYOO3J3yzb2PzsMry
 REQYX3V9NA294CDJFm83g==
UI-OutboundReport: notjunk:1;M01:P0:+FmBJV1mNJ4=;5p3UA5IzRJAgbEPS9MsO5NnxP0V
 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
 6H5tJwtMJOg==
Subject: Re: [cocci] Avoiding metavariable confusion for duplicate
 identifiers?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2803
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/47efbf70-5b53-4e7f-922f-b6405e240134%40web.de>

>> Which chances do you see for automatic data processing here?
>=20
> I really have no idea what you want to do.  Please write a complete
> semantic patch and provide a complete (but minimal) example of code that
> you want it to apply to, and the expected effect.
I showed variations of a known use case.
I demonstrated that selected function implementations can be extracted.
Duplicate identifiers can be applied even in a single return expression
(for example).
Known functions can occasionally be called then more often.

Regards,
Markus
