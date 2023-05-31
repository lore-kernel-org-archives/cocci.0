Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B20EC7EE2E
	for <cocci@archiver.kernel.org>; Wed, 31 May 2023 14:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wek8rYR7vBOtpKuNZYQsnONruUL4nz5oFrDKu21ooTY=;
  b=hHJ6Ie9goIgKXU3SjaBWL7OrdILcgvEriAEsjyxuWO/QEy1I8Lv60uiW
   nrecjeLQOstncwRlI+SomufG4cGmImCOoXhBF9jmmvjmg5DtLHAlJUrMR
   ZyrZCFo1MVqi+fquJo5gy4DdQrEoJjEVOqpxScLl6Oefija3sNS6Tqeeo
   c=;
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
X-IronPort-AV: E=Sophos;i="6.00,207,1681164000"; 
   d="scan'208";a="110510756"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 31 May 2023 16:02:28 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6FBCCE0277; Wed, 31 May 2023 16:02:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 23ADEE0081
	for <cocci@sympa.inria.fr>; Wed, 31 May 2023 16:02:25 +0200 (CEST)
IronPort-SDR: 6477536f_/xkRk9d5Ao+xOKISoDKincQq5Igt+NMSMy2zE/1IQXx4gbx
 K73uK0Yly/UGE8BVA4yZqaIfdfhWMECUhjVBrbQ==
X-IPAS-Result: =?us-ascii?q?A0EcAAB8UndkhwsR49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE+AgEBAQELAYIueFMwBAtHhFKPGYF2MYQzhzCHRIhqgxY+D?=
 =?us-ascii?q?wEDAQ1BAQIEAQEDBIFMgzMChWACHQcBBDMGDgECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgQFAQIQAQEBIxcHDhAnhWgNgjcpARFkgQgBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBARICRz8BAgIBIx0BAREmAQQLCxoCJgICVwYBDAgBAYJ6g?=
 =?us-ascii?q?igBAw4jB7AUgTKBAYIIAQEGnA4fLCJVgV8JgRUtAYxqQoQxJw+BVUSBFSeDB?=
 =?us-ascii?q?D6IH4JnjjuNTIEvcIEhgSaBAgIJAhFngQ4IYoFzQAINVQsLY4EjVT2BRwICE?=
 =?us-ascii?q?SsTFQVJfA4BEQMHBAKBBxAvBwQyCRYJBgkYGRgnBlYHLSQJExVCBINnAwqBG?=
 =?us-ascii?q?0wVEgIKJQQOAxkrHUACAQtwPTUGAwsfBiYBHgIrgVgEL1p5KCSfWwgVgS2kN?=
 =?us-ascii?q?IE1oFQ1B4IwgVuBXQyfGwYTL4NsARKTEg4GkiuYDiCCL6VkgXkkgVwzGiRPg?=
 =?us-ascii?q?mdPAxkPjiAZhA6PSD80OwIHCwEBAwmFRgEBhX4BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ozmUUq77xPQhsYYgQwPXwBzXdLJyesId70hD6qm+c20wTiXqrb
 HKoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkdNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3AA90L8Gi7n7M8/1ZLQtYkAvv8FDJuUiDU5i7aeha?=
 =?us-ascii?q?DDG9NRbaxZHaU07p2nJ87?=
X-Talos-MUID: 9a23:sqgBVQWLJ3wWnQPq/ASrnDxcFdxh2L6zB3sNl7YqnOvfNxUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,207,1681164000"; 
   d="scan'208";a="110510744"
X-MGA-submission: =?us-ascii?q?MDFJpE14p8b3VaZWzc0bvhQT/X03dmX5MfwIQ8?=
 =?us-ascii?q?Dt9JsRkIn/cyg+fxH/BR096vGaH3feWr1JlDUXJHMQvHLR+GSiW0bd2H?=
 =?us-ascii?q?IeLdiNHm++llktoWdQImvNWOE+0BMU7vSjEtxMkbkLdL+nw9zeAc57Tn?=
 =?us-ascii?q?ePgeqnxl/nM0QUfZLnhI0/xA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 16:02:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1685541740; x=1686146540; i=markus.elfring@web.de;
 bh=wek8rYR7vBOtpKuNZYQsnONruUL4nz5oFrDKu21ooTY=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
 b=CwFzQWFXuyuyj8dhe4v8dO5bTWjDgXg+MFYk3buv8BoNBm7bEAx8CHM2y5M7CWyGASu8Qhm
 ZeGlr7eizHd3c+qq4tqZ5geTQ4fR4duiwFI2kRuaQ6/RJ8z4rT4Kwa2MHKrjecilYsMRNVywU
 EU5BcEszCvRoV+ir9jsFC0Kr016/lfP+X4fi2V/xFKpnhnTDd5Xf2WzxXnBbLr1TmTzJdOnCa
 E2HCXXUoJBxGtwc2bov+us1RlMkv3NSAcNKxHpbwklim+2cXpZqZSN1Ry1dZdocNP8rkpn9Fr
 TOJqFHGhzAGbwxvAxFAbim0DcHS19exIf+Ls1OVY4Bh4lirSmipg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M59jC-1q3GTQ3604-0017hX; Wed, 31
 May 2023 16:02:20 +0200
Message-ID: <b8383f46-2b22-07a0-15b2-4f0c88f6fa72@web.de>
Date: Wed, 31 May 2023 16:01:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
To: Claudiu Beznea <claudiu.beznea@microchip.com>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>
References: <20230530074044.1603426-1-claudiu.beznea@microchip.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230530074044.1603426-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:mGDmfNtEu0PG6U43MYLBXSwn/IKPUbFs97RHusKTgyRQHLiXBdI
 tBhJ9f1ZmS43qqo68MYaQTIk2GC8lF3uDiO1ZDuyTmfF3pPVhZIbiO7JAu8xSUBEJAqoV6R
 VmoVteQJR8u9ZLwhRkoBIV4ZP9cv1SxMMcxn3vSXnsqIjHsN404FtrKvnIbMFzQr6wwqKet
 jQNCdA+RNSZYLYMI1/3OQ==
UI-OutboundReport: notjunk:1;M01:P0:Zkz2dVRQKx8=;Y2BR8UKnHA7lDJHnDrAaXb/51pG
 uOKGJR5CjC/luW49lr4SmxJyE0/68996l99UTr98DRj5etuk05U8rbIlbLC9tFginoVpZFVqL
 EsuNbiBqeu+vVWVIy3tTD6jGlSZZTv2bUky9mR3SaIqCGQSkwCTzb8dXSnSVkjFXN5hv6IS6D
 ih/HHWtb/FW1X7z034uB17Q9HY8Ov5M7EoaLtatp97Ylvby2lfzFbLGABPGe/QCq0zOftmSyr
 9DAJty27Bopy+H+UTMa9ZS/WIKLxl5z+z15M0UBKLQ2uJqkJosPdjknnT6a/I6EaY4aShb33z
 xUZOIZhKA8NsTyIYVax4OIQKgZqoUjEO4cFyDSDazYWOpcXAB/G2gU/zWr2O99MBBixdsZdH5
 JNRgu06Xe8gC/SPvkEiGYP2d/f4ea9K3Gs+nOvNRYY/xwplOeDsD+2+mN7Nm0VQCvkWvvzW5k
 5oX6cbWdsz1zOac2Q0WpAJTXVljMY5h/whOeCGBr5K94ii1PHgTDYAA3XSAeyzIqBh/OR7zz7
 GORGtOoaztd+OfHstdXIO4CQHz6BY80pIkTibVk0W7vfYiuiw1XgSJNO8SycGrov/8D5I4KjE
 eExao3Me/dOdBipws2Vk5SqTmoOHCHmHgsI5nLMInV24mhpr/e+yiEdlCwh7cjwkAmRWy9gTB
 Pl8gSobq92eUi7F23aU3lvtLagW+3aAfERJAXp29bu0uQs7QEynNxD6Gz+DYj7hwEAmImfK/B
 BFhehyxGblqneToAvsHlPJxFWbdvccG6oZRpRnZHr2PoVcXKaqMDlJQUnifo9nNbhdxpJv3Ti
 d+2UT5I4mXxU0uZytrcHSgaiKRz/x5sI7SSKIyKQ8yTVvxd+Y3HWjQ6uo7iGDNVmF1HApPLmT
 duGdS2TsHg6chE9gWRRRmEwmduLcAelelfpW7Cr23dy5Qg6Dqr1vdjg7y0A0nFiyQGwTMJzyN
 9xO82w==
Subject: Re: [cocci] [PATCH] Coccinelle: kmerr: increase check list
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1165
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/b8383f46-2b22-07a0-15b2-4f0c88f6fa72%40web.de>

> There are other functions allocating memory who's return value could
> be NULL in case allocation fails. Update the list with these.

How complete can such a function name list become for the affected SmPL script?

Regards,
Markus
