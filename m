Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE1AC83F26
	for <cocci@archiver.kernel.org>; Thu, 24 Jul 2025 15:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Vyvc9ARS8AuRZ7rVvunpQE7xRzhKwoUoPcXlwrHs5aY=;
  b=B4pZ+cEDkJnyx1sKl+JMfwGNKKbNpAEt18o6oQt90p099CnFKBEb2bMM
   EwS2P56Gq8EfersUSXH2GnqxMruMRbE9VfqrmyqKKYCOyxJWrrR0fdxYK
   R7D/LPGpSUueX61/qIaHVQerBemDUQe0ImNJgkAzCEbMOrJ7idC7scVZ+
   Y=;
X-CSE-ConnectionGUID: jYANYUsiSjuW6VPpSozu4w==
X-CSE-MsgGUID: gPfS3oOXSNaLjfcXRTACsw==
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
X-IronPort-AV: E=Sophos;i="6.16,337,1744063200"; 
   d="scan'208";a="233018237"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2025 17:30:44 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 84FFAE0CD5; Thu, 24 Jul 2025 17:30:44 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6F09FE0171
	for <cocci@sympa.inria.fr>; Thu, 24 Jul 2025 17:30:40 +0200 (CEST)
X-CSE-ConnectionGUID: mze0PbMdR6ejJCTvdV1j1w==
X-CSE-MsgGUID: Ch1/8QVXS26wesO7X086Rg==
IronPort-SDR: 688251a0_H0Ij6Mye/y/Qp76pkfgu9RLFHQmKyUQYQ3lS7HJcIfV9JxZ
 A9y8/VZ4rclBMzeLrUcuL4OJ99pyNd79jveVq5Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FRAAAOUYJogAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgQZUMwQLSYRViByHNIIkhDuHPIdViHmBVYF9Ag8BAwENTgECB?=
 =?us-ascii?q?AEBAwSCDIJ0AowXAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECEAEBOwcOCjGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBA?=
 =?us-ascii?q?QIBIx0BAREmAQQLCxoCJgICVgYBFAEBgn6CIgEGEAEDDiQHthqBMoEBggwBA?=
 =?us-ascii?q?QbaXh8sIlmBZAmBGy4BhWyCZAGGJ4NCeicPgVVEgTyDAz6EQ4NbgmmCJoEWg?=
 =?us-ascii?q?2WNBogxUngcA1ksAVUTFwsHBYEgQwMqNDEjSwUtHYEnfYMNgQ6EKCtPgiJ1g?=
 =?us-ascii?q?XlBGT+DUx4GbQ8GgRgaSgICAgUCQ0WBR0ACAQttPTcJCxsGPZMVhTVERkGTQ?=
 =?us-ascii?q?oMtr2w0B4I4gWeBZAyfawYTL5dSDgaTBZkGIqNOC4VGgWg6gVwzGiSDNk8DG?=
 =?us-ascii?q?Q+OIYQzvypBNTwCBwEKAQEDCYVGAQGKMYFLAQE?=
IronPort-PHdr: A9a23:RolSyRdo0tpXCbsmPWXttkeYlGM+M9TLVj580XLHo4xHfqnrxZn+J
 kuXvawr0ASSG92AoKId07KempujcFJDyK7JiGoFfp1IWk1NouQttCtkLei7TGbWF7rUVRE8B
 9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUhrwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9I
 Ri4owjdrNUajIVtJqsy1xfFvmdEcPlKyG11Il6egxnz6sCs8ZB57i9eoegh98lOUaX7e6Q3U
 7lVByk4Pm42+cPmqwDNQROA6HUEXWoaiwRFDQfY4h3iUZj/riX1tuxm2CmHJsL2Vqw7WS6j7
 6hwVhDljjoMOiMj/2HWjsxwi79boA6kqhdizYPYfJ2ZOfxjda7GY9gUWXROUdpQVyxZA4Ozc
 Y0PD/YaPe1Fq4XxvkYCoQeiCQWpAu7k1z1GiWLs3aAi0OovHw7J0wI9EdwQrnnUotX7O6UOX
 u6616TI0SzDYulK1Tvh9oTFcBYsquyMU7JqdsrRzFEiGQTfgVWKqozlIiiV3fkCvWif4epgT
 +Ovi2goqwpspTWhwd0jipPKhoII0VDI7yp3wII7Jd2iSU57Z9GkHYBeti6ELIR6WN4tTH9xt
 Ss817YJtoK1cjIQx5Q72x7QdeaHc46Q7x/jVuucPSp0iW55db+hiBi//kutx+3zWMWp31hEr
 jZJnNfSu30MyhHe5MqKRudz8Equ2DuC1QPe5+BYLU0wlKfWLYMqzL0olpcLr0jPAzH6lF/og
 KOIdEgo4PWk5ub9brn7uJOQL4t5hw7kPqkgh8CzG+A1PhYUU2SF+emwyLvu9lDjTrpQlP05i
 KzZvYjaJcsFoq65BBdY0oMk6xaiEzeqytoZkmccI15fZR2IkZDlO1DIIP/mEfeym0qgnCp1y
 /zcILHtHJfAImLenLrjZ7px9lBQxBI2zd9F5pJUDr8BIOj0Wk/0rNHWCQU2Mxa3w+b6E9Vxz
 IwQWWaBAq+DMaPSt1CI6/khIuaSf4AZoivyJOY96/70kXA5gUMdfbWu3ZYPdH+4GehpLFmYY
 Xf3mdcAEWIKvhIkQ+DwiV2CVyRTZ3eoUK4m6DE7EpqqDZ3fSYC1nLyBwCC7E4VSZm9cBFGDC
 3Pod4GfVvYNaSKSJ9RukiYeWrS7So8h0wuutA7gxLZ9IOrU4DUUtZT429dt/e3ciQky9SBoD
 8Say2yBUXl4nmwWSD8x365xu1RwxFmM36RgmfxXC8JT6fBTXAoiMJ7cyPF6C8zoVgPPYNiGU
 0yqTci4Dj0pU90xwN4OY0NlFtu6gR7M0TSkDaMJmrKNHJA776fc0GLrJ8lh03vIzLAvgUEpT
 MdXLm2mnqB/+hDJCYPVjkuXir6mdb8E3C7D7GiDzXSBvEVfUANoSavLRGgRaESF5ej+s2HfS
 76nQZAuLQJFzYbWKLZOa9SviVxZTfPnENXYeWO43WmqU1LAzbSHZ4vCemMH3SybBlJXvRoU+
 COjPBI9GzzpjmbQFj1oGhq7Rkr28vRl7l6/QFU1yQ6icEBrkba4rE1GzceAQu8ei+pX8Bwqr
 C95SRPkh4q+47uoogNgeP8ZetYh+BJd0mmfsQVhP5umJqQkh1gEcg0xsVm9nw5vBNBmls4n5
 Ggv0BI0MbiRhXZIbTCFxtbdPrPNK2/91A+iYeja1wKWy86Yr58G8+9wsFD/pEesH0sm/W9g1
 oxw2mGf+46MIQ4cS5P3XW4o+hI8q7yJKjIl6dby0nthebKxrieE298tA749zQ28et5ELK6eP
 Ar1DtFcGMWkbuAn87SwRjQDOu0atKs9Psf8MuCDxLbuJuFr2jSvkWVA5ol5lEOK7St1DODSj
 d4DxLmD0w2LWi2Z7h/pu93rmY1CeTAZH3augSniColLY6RufIENQW6wKsyzz996itbjQXldv
 FKkAloH3oeud3/wJxTY1BdTyF9RjHipgyq+wBRrnjtvoqfelC3CzuL+dQYWb3ZRTToqhlPtL
 I6oytECCRLxNU5zzkTjvBm8nvIIwcY3Z3PeSkpJYSXsemRrU6/q86GHf9YK8pQj9yNeTOW7Z
 1meDL/7uRoTlS35TA48jHg2cS+nvpLhkll0kmWYeTxWpWDaZNo26BPR/t3aStZO0zBASCQy2
 ly1ThCsesKk+9mZjcKJl+mkVH+6ELBXfzPqy4yoqyaxo2FnS07a/bj7ipjsFg401jX+3t9hW
 HDTrRryVYLs0ryzLeNtekQA6EbU08NhAck+l4IxgMtVwn0GntCP+nFBl27vMNJd0Ka4bXwXR
 DdNzcSHqATi3URiKDqOyeebHj24y9FiesL8T2cYwCM74OhVBa3S4LEMkSZuo1W+pB7cerAnx
 21bk6FxridFxbhT8AM2hj2QGLUTAVVVMUmO31yT4tayob8WLGejfL6s1VZvyNWoDbWMuAZZC
 z7yfpYvGzM1790qaguWlieptce9J5+JN4F21FXciRrLgulLJYhkk/MLgXAiImfhpTg/zOV9i
 xVy3Ja8tYzBKmN3/av/DAQLU1+9L84V5Dzpir5T28iM2IX6VLBoADYWR93FSfyyETQdnevqP
 UCCHXdvzxXTUaqaBgKZ5Ep8+jjqGoqoKmrRCX0X19RkSzGCKUYZjA1eD1BY1tYpUwutwsLma
 kJw4Dscs0X5phV7weVtLxDjU23bqVTgenIuRZOYNhYT8hBa6hKfL5mF9uwqVXI9nNXpvEmXJ
 2ecfQgNEWwZRhnOGQX4Jrf3rdCS9u+FGqyhIvGIbbjGoL5bUOqUgIKh1ZF59iyAcNqCND9uA
 phZkgJKD3V+BtickTISTSca0T3AZYiXqV+1qChws9z6++/hRQbso9KGDbcLd95o/nXUye+KZ
 euXmTo8Ii1T0YkUgybBzrRGmlUVjml4fj2pW9zsrAbrS6Td0u9SBh8fMWZoMddQqrg71U9LM
 NLajdX80vh5iOQ0AhFLTw6pnMbhfsEML2ynUTGPTE+WKLSLIyHKyMDrcOu9T7NXluBdqxy3v
 36SDUbiOj2JkzShWQqoNKlAiySSPRoWv4/YEF4lEW/4UNfvcQG2KvdyiiAqh6I5jDXGOC9UM
 DRxdV9MsqzF7S5chaYaeSQJ5X5kIO+Y3ieBurOBcNBM66QtW3syzrgJhRZyg6FY5yxFWvFvz
 S7br9o05kqjjvHK0D1sFhxHtjdMgouP+0RkI6TQsJdaChOmtFoA63udDxMSqp5rENrq7up1w
 8LMibm1BTNM6dPS8uMDCsKSJM/NYx9DeVL5XSXZCgcIV2vhLWbEm0lUi+2f7FWQqYUm7Ifhk
 twCR/UIMT59XuNfAUNjEtsYJZ5xVT5xir+XgvkD4n+mpQXQTsFX1ngofu2fC7PjJWTA5VGlT
 x4P3K++MokZcIH2iRQKgrxSg4nAXUbdD4glnw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:6PYAiq5sy0UMeTDgwgPXwBzXdLJyesId70hD6qm+c202TiXqrb
 HLoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3AujWJUmnjAO8Qg+d3A9KtJgzxuQvXOXjPwS/oKWq?=
 =?us-ascii?q?0MzhkSp++dUGcxvpmytU7zg=3D=3D?=
X-Talos-MUID: 9a23:nJfqigYZ0L9YiOBTnD+1w2FbCvdTufqxBVsqzqVe65e+Onkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,337,1744063200"; 
   d="scan'208";a="233018227"
X-MGA-submission: =?us-ascii?q?MDEImB1LVj23xb8RiJ48fJxLx69HISLVGcUQ64?=
 =?us-ascii?q?IiXVj3aXhJkXeDRGS6CK19pnCXB33buIOjKl/8c56twLjMYIXRXmJNUe?=
 =?us-ascii?q?eN3sqRhGoMOU5L7566eiEWH/HkbLqjoA0UUet9GgtP7xVrCvRQLEFaS/?=
 =?us-ascii?q?f3fezZcyTobZ5d8dqE3uSGsg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 17:30:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753371039; x=1753975839; i=markus.elfring@web.de;
	bh=Vyvc9ARS8AuRZ7rVvunpQE7xRzhKwoUoPcXlwrHs5aY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DMkb+4EL+P8zv+cY8/nfBe4pZizUVk7F4ubq2mMHqiqFty/1CgSCse/GfQB9Uznv
	 nIamMX1fDZ0ZFv9800tg1T9j4MSIHHDvmx7yfXY0+oRrE/6+Q2YpJt+J8Cbz23rLC
	 A44htTYa6QSmavPFbJrHczUfojD2Fp+R1MKBuFLjyoeZYkJdUdTy0M6bToyIxxDDJ
	 SGq3gFtNGCtzCBD1mX7xpitbDS0OVIJ09qPGROtibyrGKcyDF8npyjgu8Vw75AJuR
	 KDHnctrNMgAKA6rObVUFuC9PG+RT5HU7fffaTbb9KmrJzYOJQb1AX50X3qwl/jg6y
	 Lxxy/HMW0yd+9Jnnvg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.250]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0qr9-1uTCAt2y3x-014jnF; Thu, 24
 Jul 2025 17:30:38 +0200
Message-ID: <e61aec6f-197d-40d0-812c-83eb3f5a6ad0@web.de>
Date: Thu, 24 Jul 2025 17:30:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr>
 <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de>
 <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr>
 <e1366c81-c634-408a-8c53-2d16600f7bfc@web.de>
 <7b288440-f620-5376-876d-6239e8545fec@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <7b288440-f620-5376-876d-6239e8545fec@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0LP3sVpucagvem5ujyiqDZSLXW6l6IbpEqrjeW6EMk/Lm4wBkP2
 WVswivTu/we5BInfoC03au71XrPvdxAcqZ7k+4qWNWh/II7Jw7jHXFkH9QZWEsUBX8FF5Mi
 rKydw1L2z/9kEM4ub19bwRILvMjdpWzz5B+f2ZCOKnnUmzTELwRC9pzt7EJp5N1qxza+HHd
 MwtrhlH+kW6OvQ4BxChnQ==
UI-OutboundReport: notjunk:1;M01:P0:zyGTva1oHa0=;pZqnkwmrmpf1DRmj4nl08yFBKKv
 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
 fg==
Subject: Re: [cocci] Searching for questionable call pairs (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2913
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/e61aec6f-197d-40d0-812c-83eb3f5a6ad0%40web.de>

>>>> * Why is the diff marking missing for the first lock call so far
>>>>   (within the implementation of the function =E2=80=9Chandle_uaudio_s=
tream_req=E2=80=9D)?
>>>>
>>>>
>>>> I would appreciate further advices.
>>> I would think you should do:
=E2=80=A6

>>> And then use a python rule to print p1, p2, p3, p4.  That way you will=
 keep
>>> the different matches separated.
>>
>> I miss still a corresponding answer for my original question.
>>
>>
>> Can the Coccinelle software handle call orders correctly also according=
 to
>> passed (different) expressions?
>=20
> I don't particularly understand the question,

Why does this happen again for this clarification approach?


>                                               but Coccinelle knows about
> the control flow, so it would seem that all is ok.

I got the impression that another implementation detail is broken so far
and is therefore improvable somehow.

Regards,
Markus
