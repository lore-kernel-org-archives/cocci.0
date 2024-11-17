Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B62D10F28
	for <cocci@archiver.kernel.org>; Sun, 17 Nov 2024 20:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+Av1NFUM5FxZ+oPzDw49n9KqJDBxXtp4UeP6BkkYLZQ=;
  b=sz1+6RVg7hL7tpBDNfh9bnmvBmOKeIfHzKGGe8BS+1UKTyUmsdk5TpvF
   nG6XgpsBV5wosLi3YzztZhuDmWv5D7wSBO8LBnVgLkZFQDYk+Ejb7sJwO
   OFi7P4vlPjwD4UZt+0hVR8wWpOg1OL/RoGLgvylP0weQovGPsgoPox8Py
   o=;
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
X-IronPort-AV: E=Sophos;i="6.12,162,1728943200"; 
   d="scan'208";a="194290555"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Nov 2024 21:30:33 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 420F1E0D1C; Sun, 17 Nov 2024 21:30:33 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BB9E1E00B7
	for <cocci@sympa.inria.fr>; Sun, 17 Nov 2024 21:30:30 +0100 (CET)
IronPort-SDR: 673a5266_AHQW4XZLe6hG7ZFr3d+S3JOcbenYjAWSZ30mQvRI5KOsMVR
 53qmAG/4T6jnjKbeu4d2ITWRChJCG3BNkeY4whg==
X-IPAS-Result: =?us-ascii?q?A0FiAwCqUTpngAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VMCgkJiG1ozBAtILYQpj02BdDCEO48RiHWBaoFHIw8BAwENOwYBAgQBAQMBA?=
 =?us-ascii?q?4FJgzcCd4lUAh4HAQQ1BQ0BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBOwcOCjGFew2CYgGBCRt0AQEBAQEBAQEBAQEBAQEiAgEBAQEBAQEBA?=
 =?us-ascii?q?QEBAR0CDTpEAQEBAgEjHQEBEScPCxoCJgICVgYBFAEBgn0Bgi8BAw4jBw0Gs?=
 =?us-ascii?q?C2BMoEBggwBAQbaWx8sIleBZAMGgRouAYVpgmIBhiSEPCcPgVVEgTyDAz6CY?=
 =?us-ascii?q?QSBQAUZg1uCaYJFhQ8liBdomgtSexwDWTIBVRMXCwcFgSkhLAOBeU5/gTaBU?=
 =?us-ascii?q?QFCgk5Kgy6BXgU3SYJKaUs3Ag0CNoIkJFmCT4ElBAWDaYELg2GEXoQEHUACA?=
 =?us-ascii?q?QttPTUJCxsGPaAHR4NxbRCBRZQVsm40B4I4gWWBYwyKJ5UyBhMvg3GTTw4Gk?=
 =?us-ascii?q?nqYdyKNXZUWhhKBfyKBXDMaJIM2TwMZD44hg3ozxXNCNQIBOAIHCwEBAwmFR?=
 =?us-ascii?q?gEBiSKBSwEB?=
IronPort-PHdr: A9a23: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
 PLmq5deU0EpUOwXAAJpEY5aSKo=
IronPort-Data: A9a23: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
 kBtLV15rIqHpYId3Cqul7O52P3Ugd838wgVUA==
IronPort-HdrOrdr: A9a23:9dSpcaPavCv4zMBcTh+jsMiBIKoaSvp037BZ7TEVdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVydygc378
 ddmsZFeb7NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: 9a23:NHAE12FbpUv1rhZDqmI73n8aC5E/U0GEySn/f2qGAltZVeasHAo=
X-Talos-MUID: 9a23:v5NtSQW4g7hVU7/q/BzqoRZnKsxK2vSNOFkWr84KgvDZKDMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,162,1728943200"; 
   d="scan'208";a="101846919"
X-URL-ContentFilter: 
X-MGA-submission: =?us-ascii?q?MDFJ2pLjfcYv8EeJxh1WtrMWEwDngINIXGaxLe?=
 =?us-ascii?q?gsd+A8TAVuloKcnYrTrmXrPSVZ3XzzTehn58ogLbqYBRuAWLjZHYUHTK?=
 =?us-ascii?q?IA2z5gnpmyZtV6/a5C2vXY5DbfWoaZDQJpP0Y9LYq885HC8ucB+Sm+tt?=
 =?us-ascii?q?M47Nm5tp82C75KK9R9lgaF1A=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 21:30:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1731875429; x=1732480229; i=markus.elfring@web.de;
	bh=+Av1NFUM5FxZ+oPzDw49n9KqJDBxXtp4UeP6BkkYLZQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FhTZ+Mx5WrPpgqR2EYo/7L+wXLf7HJt1spRLu40FipJeFn/95P7GHBSmiK/j41My
	 pXFQJy+wJffME6L/U60VwLJxOnOpNWntR9m2LB6PxhAGCeJXPNi69N3K79l+PMsKb
	 la79j7nxDasIp6hIo3kIVMICzKuSl1Nlfnx0g7dn4kFAW0NvHOcSBe+akn36sIg0k
	 DK8ywFtiwp2ZNvBIZbzHZG8tHdnovVfeDQX1ViuOh8IueRsqKlwfNlrembW6nWm/N
	 whabPdEr1YtSKcfKwqyfoiVwQGV4mRqN79Kl2k39YA3J/MF2m3Avgjhnv5Rd29oK6
	 suneYCLPD1vIPLGrsg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MfKtN-1tfDup3hfP-00ZCu7; Sun, 17
 Nov 2024 21:30:28 +0100
Message-ID: <78dd11f0-b07a-4a3e-ab42-4534e4e4ce73@web.de>
Date: Sun, 17 Nov 2024 21:30:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <5231db6d-7d76-4be9-a82c-5224babf8e29@web.de>
 <d577a3b9-d43-19d3-15cf-2b11fb1ce59f@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d577a3b9-d43-19d3-15cf-2b11fb1ce59f@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OL630UETGdbo7q4ouTGMBL9ay5CAhbKxjSX54NyXa48wc7yFVHT
 2lvNqcqGFKFD+2abmqMRwPXh25EJFWZp787C12/UtamNA8w5EBS5Ly6YYKSR0bHvg+JKzKy
 KcqvQ5mRZ83jE72W9CPomChFRGqYsGnay+k+mAX3Gl3LwONr0TTjn6k9iqlR9sKNJNrljW8
 QCaEy5bL4acI5ZS14SFKg==
UI-OutboundReport: notjunk:1;M01:P0:mohqBir7iCM=;k4OnjegcubL9CEEyxTQVJpbQXXy
 W1/TzE8vi7k4/mC/uNlqbLXgCe3BrGdsnqHMiwkJBuTR3dH8NAROwOYgUS4mwpdLwFws813kh
 V85KLg9zLUvJ4bICvtks/HRTcxN/HZaHkNRfSl6cR6WNX4Y0CQTkZRxxY64YID8yYkGhpjNrH
 boHIf2mlwmGXsWN6Vf9Cs0czOob6h1pJIrwUqWLPJm8Fr5xdJS3nmOvfxBEvwvtRdl+ddCXm6
 feeF3RalIT15X8USFuQ81X/i832AsiezP80LYTRvVr/KuXLYGrlALtAXcvGlPSqZJoHHwFt/t
 HTPivbgS5/e+AtrvLk8qJTN76snyH3rCQDKooaGXM6UincAJtgbX5B2DqANhXQkw8beJfMEoN
 By+xMZ6nHk8FknImOmKFfCMTPcHnpYYg7brWNaYLHJNYrX/p+lv9eGH+AUAjgl1tb5DXEDi8f
 tVXf+YDMd4IPWY2BkE+kVcFq20ag5UByAvwkaKjg31QNvDK2drSVBsXFMa9eiT71NloVPaIlc
 j4DtwXkMRr70zra03ZBlaHlixAd9/uY0IwIdyFhrDk3++PgVmYoyJHSexNEHY09javjGLEOnf
 bF7OoYQworu5JOAysqMzRw6CsrDAD+iDjlBUVrKT4GzOTtRvO3u1URoNpl0pxDkFE7IFkjGS1
 dWN5csBdaGc/vTf9OJqJJiyRqEjKLZ6deJ35aNzHJsxbA0DiWw61TI/RhdKXnpASmfeyLMTU8
 jBWTczKJrPUyAzmjBTiHmPs+wS3KPDrCoahwDm71ZRzXqwvKMbAqsXQwNcbHyr9KETz3Lf34T
 iCoXJ86N9aSZxMqVzMXd5HXsvF1hun0eyI0WTfP4NedfUOJHpkKbVCOavjY/jH1hn+me62ntO
 9iAKR5SEObmAsyQejzonZXvzAPN0540WcOyl2myFZV5TIU8g7Fb0QU/Gh
Subject: Re: [cocci] Reconsidering special return statements (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2076
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/78dd11f0-b07a-4a3e-ab42-4534e4e4ce73%40web.de>

>> Would you like to become able to handle such source code places also
>> by the means of the semantic patch language?
>>
>> @display@
>> @@
>> *return ...;
>> *return ...;
>
> What is the problem here?

It seems that this source code search approach points known data processin=
g challenges out
(also according to a specific function implementation example).

https://elixir.bootlin.com/linux/v6.12-rc7/source/drivers/power/reset/as37=
22-poweroff.c#L55


How good does a desire for dead code avoidance fit to the current developm=
ent status
of computation tree logic variants?

Regards,
Markus
