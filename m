Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C57CC25B77
	for <cocci@archiver.kernel.org>; Wed, 22 May 2024 08:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=uffClYsjumXt+ahdCRX4q4ThAB79NArlWRgCuY9A1Uo=;
  b=va+pjIi8s6VkILUe8JT4yLDFOBfZuxIlXWsXvytnLkltk5s5oGS4vANB
   Gu1X2X3T+zpEMWnFP6WcnPk+d97SnmjNups6CxbV8Y61/u6boWpp2BpYT
   DdP8emkZZKYAUItVaYu5pziNUwHD0U/bMvwrAqGb3B4OBdj+mXnMorhSV
   M=;
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
   d="scan'208";a="166820203"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 May 2024 10:20:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 050BFE0CD0; Wed, 22 May 2024 10:20:34 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 40F81E00B6
	for <cocci@sympa.inria.fr>; Wed, 22 May 2024 10:20:31 +0200 (CEST)
IronPort-SDR: 664daace_wjM7mvqGOoQr+r2aZ85W1nCxRW2Fq1hD7FcIHlZ1sqVGZBT
 1ii5W4xUz/nyu7BzzyRmq8/SWFXz+TaTZNIEkhA==
X-IPAS-Result: =?us-ascii?q?A0HKBAA1qk1mhw4P49RaHgEBCxIMQIFEC4JEfAZUMwQLS?=
 =?us-ascii?q?AiETo9IgXUwhDuPCIpHgUA+DwEDAQ09BAECBAEBAwMBhHUKAohEAh4HAQQyB?=
 =?us-ascii?q?w4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXBw4QJ4V0D?=
 =?us-ascii?q?YJgGIEOgSYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQINOkIBAQECASMdAQERJwQLCxoCJgICVhsBAYJ8AYIvAQMOIwcNBq9yg?=
 =?us-ascii?q?TKBAYIMAQEGgVhBTtdyHywiV4FjAwaBGi6ILgGKPCcPgVVEgTyCUjE+gmEBA?=
 =?us-ascii?q?QKBXk2DDoJpmXqSNlR9HANZIRMBVRMXCz4JFgIWAxsUBDAPCQsmKgY5AhIMB?=
 =?us-ascii?q?gYGWTQJBCMDCAQDEDIDIHERAwQaBAsHdYFxgTQEE0QDgTeJcAyDL4F1KYQeC?=
 =?us-ascii?q?ENsFYNygXYOYYNQhS6BEIFHgRYdQAIBC209NQkLGwYiAR2kZ4QiWYFRxiw0B?=
 =?us-ascii?q?4I2gWCBYQyKIZUjBhMvg3KTRw4GkmiYY412mxSBbA4lgVwzGiSDNk8DGQ+OI?=
 =?us-ascii?q?RmDYTOBC8seQTUCCTACBwEKAQEDCYVGAQGDWoFIAQE?=
IronPort-PHdr: A9a23:0Bl5mB36Psy89PwjsmDOzQ4yDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BaOo68z1xSQBdqTwskHotSVmpijY1BI2YyGvnEGfc4EfD4+ouJSoTYdBtWYA1bwNv/gYn9yN
 s1DUFh44yPzahANS47xaFLIv3K98yMZFAnhOgppPOT1HZPZg9iq2+yo9JDffQFFiCCjbb5zI
 hi6ohjdutUUjIB/Nqs/1xzFr2dHdOhR2W5mP1WfkQri6Myt5pBj6SNQu/wg985ET6r3erkzQ
 KJbAjo7LW07/dXnuhbfQwSB4HscSXgWnQFTAwfZ9hH6X4z+vTX8u+FgxSSVJ8z2TbQzWTS/8
 6dmTQLjhSkbOzIl9mzcl8p9h79Zrh28vRxy243abo+aO/VwY63Tfc0URWRDUclNWCJMGZ+8b
 5IVAuYdIepUsYvwql0TphW+HwmsA+bvxydPiHDsx6060PkhERrb1wIvG9IOvm7UrNTzNKcdT
 Ou4y67Gwi/Zb/NVxDf985LEfB8lofGCR7JwcMzRyUY0GgLLkFqfspbpMC6L2ekUtWWQ8uVvW
 /61hWE9twFxviagxt0qioTRmo8Z1FLJ+Tl2zYs6ONC2SE51bcCqHZVftyyXNpV7T8IgTmx2u
 Cs3xaEKtJq7cSQUx5oqyBDRZfOZfoSU/B/tW+CcKip2inJifbKwnRey8U64x+39UMm0yldKo
 TBfntnCrHABzxPT6smbSvt940euwiyD2BzU6uFBJ00/iKnVK4Y5z7Iui5Yfr17PEjHolEj0l
 qOaa0Up9vK15+noernropCRO5V6hw3jKKgjmdKzDf48PwUOWWWQ5Pqx1Ln+/U3iXLVFkOc2n
 LTYsJHbO8sWvrK1DglI2Yg58Rm/FS2p0NEAkHkHMl1FfBWHgpDsO1HJPfD4Ee2zglqynzhw3
 fzJI6PuDo3MLnjFjrjhYa5w51BBxAYt19xT+YxYB7MbLP7uWkL9rsHUAxAhPwyx2ennCdF91
 o0EWWKIB6+UKKTcvkWS5uIsPumMf5UZtjn5K/gr/f7ujHk5mVAGcKinw5QYc2q0Eel4LEmBZ
 3rjmc8OEX0WsQomUOzqlFqCXCZOa3qqRaIz+ik7CJ66DYfEXo2inLuB0zunEZ1XfW1GEVCNE
 XLwd4qeQfsMaSSSItVgkjMeT7ShRZUhhlmSs1rxzLFsL8LV/DcZvNTtzotb/erWwDQ77z9pF
 Iyw12+XTmd71jctTiU1wbs5jEhz0FaF3oBnjvYeGdEFtKABaRszKZOJl78yMNv1QA+UJr9hK
 X6jS9SiW3QqS84phsUJaAB7EsmjiRbK22yrBaUUnvqFHs986brSil72Ics10HPazO85lVBzZ
 8JVNnC9wIN7+RLSAYHhjEiT0aqnJuwHxCCYzG6Y1iKVuV1AFgt5UKHLR3caM27ft9fk/QXvS
 7G0CLIoGhRMw4iOJ/gCccXn2HNBQvqrI9HCeySxlmO3UA6P3a+JZZH2dn812SLAFA4bngpV8
 Xvu2REWICCnriqeCTVvEQiqeEbw6axkr3j9SEYozgaMZkkn1ryv+xdTi+bOA/UUlqkJvisss
 VAWVB60ws7WBtycpgFgYLQUYNUz501C3H7YsAo1N4KpLqRrjFoTOwptuEam2xJyA4RG2c8ky
 RFihC97M6GFyxVscz2C3Jb/EqLaIC/+8VHnaqLb3E3fzMfD4r0Gu7wzr1Tuuh3sF1J3qSw9l
 YMPjD3Fu9OTUFl3M9q5SEs8+hlkqquPZyA849mRznhwKeyutTSE3ds1BewjwxLmftFFMarCG
 hWhdq9ST8WoNuEunECkKxweO+UHvos9JcC7bL2r3KCxPeBvtC2rhyJL7coutyDEvzo5UePO0
 5sflru91xGESiy6oVOvqMHxlqhbaDtUEmf1mk2GTMZBI6Z1e4gME2KnJca6k85/i5DaUHld7
 Fe/BlkC1adFYDKqZkfmlU1V3EUT+zm8nDegiiZzmHcvp7ae2yrHx6LjcgAGMyhFXjsqgVDpK
 Imyx9cUOSrgJy0gjhi4/gDXw6ZBpaJwB3beSwFEcmD6InpjXa25qreZK5QWstVy63oRCbn6O
 AzSQ6W1uxYA1iL/A2ZSoVJzPyqnvJn0hV0yiW6QKmpysGuMfMhxwRnF49mPDfVV3zcAWGx5k
 WyNXwL6ZYP2u4zJ0c6f4YXcHyq7W5ZecDfm19aFvSq/vyhxBAGn2uq0kZvhGBQ71iny059rU
 z/JpVDyeNqOtezyPOR5c01vHFK55dB9H9Q0t4Iqh4wLn1UeiI+U+3Uvjmr5d9lWk/GbDjJFV
 XsQztjZ7RKwkmhqNHGU3MTUUnuHw81uT8a3aCUa12huiqICQLfR57tCkyxvp1O+pg+Eevlxk
 AAWzv424WIbieUE60I9iz+QCbcIEQxELDThwl6WusumovwdNwPNOfCgkVBzlte7APSerxFAD
 TznL4w6E3Y455d6N0/QlmL+4MfodZHZP9cUqwHRgxnHlfdcMp53ifcAwyZqXAC19XR3zukmk
 Vlk2oy8t4XBNGhnuq60ShcKMzroe4YY4TvwiaUYx8+Q09npFZJkf1dDFJK6SPW1DHcZrv/gL
 R7ISTQ6pi7dEr3aVRmW7EMsx57WO7asMXzfZHwQzNE4AQKYOFQamgcfGjMzgp8+EAmugs3na
 kZwoD4LtBb+rVNXx+RkOgOaMC+XrRq0ajoyVJmULQZHpgBE6UDPNMWC7+V1VyhG95ylpQaJJ
 ySVfQNNRW0OX0WFARjkMNzMrZHY9POEA+OlM/bUSbCJtPAYSPqCg56ik8Nn8zuKKsSTLyxiA
 vk8iS8hFThyH8XUnSlKSjRCzXuXKZTB+1Hlp2su8pPakryjQg/k6IqRBqEHNNxu/0rzmqKfL
 6uKgy0/Lz9E15QKzHuOyb4F3VdUhTs9ElvlWbkGqyPJS7rd36FNCBtOIQZ6LshV9OQR2gdXO
 MjUosz43Ph0g7RmbjUNHUykgcyvacEQdiulM0jbAU+QKLmcDTjM3t2xfq62D7FdxrYx1VX4q
 XOQFEntOS6Gnj/iWkW0MO1CuyqcOQRXpIC3dhsF4YfLU9/sLBG2YoYfZdwexLopmjXVOGRaP
 TUuKyulS5WP4CkejvgtQwR8
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ssKLKqmjKEqc/fFh6vMeAUndHa/pDfLy3DAbv31ZSRFFG/Fw5P
 re+MjzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNSftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njbL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: 9a23:X06JxmwwtpaA7viRgG1nBgUzPf4Zdl/GzEzJHB+DMkY5RrKUGAGprfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AyeVwigxVwiLuPz+kZScSpPO1vgGaqISyTxwHu89?=
 =?us-ascii?q?BgI67MxQzBw3ApwboZqZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,179,1712613600"; 
   d="scan'208";a="166820176"
X-MGA-submission: =?us-ascii?q?MDFFwMlfN0cdp8sFmgPem03ocqofuU5MACYQ6r?=
 =?us-ascii?q?PSMxLdVeR+q5iQn8ZeGBhzqpYUweGcj7qE295c3mCSCIrBW5h6SjK8cI?=
 =?us-ascii?q?irdmQzBJZW7qtAXd70CeBxOEtOSUFtt7xGN3TZ1NPcJUt8hjQiL769SR?=
 =?us-ascii?q?CE4a5z2rMgbMmjT4OpkvRoIw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 10:20:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716366030; x=1716970830; i=markus.elfring@web.de;
	bh=uffClYsjumXt+ahdCRX4q4ThAB79NArlWRgCuY9A1Uo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mLv2tIPt7k3z/0PuqxRgXy463OUYy2nKIhQWNc98/+ZerWcDY9hhOy6DayBIMsIS
	 XIik0fFqGqmE23YF9oV+9r7npmG8qNR309EPus2+McE6OtkyVkyJ6LORj7qdMhuJP
	 AgKtrHuRFk1vAMocU0Kr8NL4MlwmIP+6fdalyGWqxXXJje7vTqwsCmMWQrRy/f9EK
	 LCa0xqHJRjLrBJQrAZyCnscVHGhuKSvWah5ABZ9968K5S7h0JKLVDzwFQjeBQ+NJZ
	 gFpFUJ9Cog8NUfhUfal/UTltWNeaDwWaUhH7QLId1fK2zifW2yaZXHokshmNgARJg
	 Ic1tBAdZKtzq+MXKcA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhWop-1snRkM3YLD-00nvMB for
 <cocci@inria.fr>; Wed, 22 May 2024 10:20:29 +0200
Message-ID: <594a83eb-b693-4f5b-b330-c0c4cb655661@web.de>
Date: Wed, 22 May 2024 10:20:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de>
Content-Language: en-GB
In-Reply-To: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UL6uuJvKcwQhlDnp3Gkeu9BoRQg9fJPhQMOatg0yBUVy6UroISa
 8GNmclrrCEsn8HYXZfl6Cl91aZBOuVzuL6RyZBSJrgcwOrh6CJp4E2tU39s5GmVzsjTjJry
 a/VdhvXTc2l1/Jjasj/CVZ8Hgxsu2PmefEXL+L2oWcXV8GG9mq8uCpHEc+ar+wTd13oYDbR
 jgZM6z8MicKpWr8OZ+aBg==
UI-OutboundReport: notjunk:1;M01:P0:7ePk7qd4Mqg=;afDZPTAemL84rkjZGkPOXMPxnhx
 3MSlqgXLgfN4uICIPCN8hb22OsIXRxJLTfqVEpNMNhVmMlTMoZr5JWiu638saF+Fwy0GFc+7V
 hXwO3EuWAClCmdrx9UFgfJVdGLCbcZXz/WBjlig58vO2zPXoHj0hOIHczxFVwNBqTZXupsLrq
 /acG7FhiVL33lnh74z4CNEnVQEjGZm2fhrD/fUENLVyI7gM9IBqFXnxsdtivI+keL6z9nJ92Y
 43a1U52sIFn+kcoLcG2zGIjV0t6QFsMIEE1eFRwti6dTytGVn9v0dAP1z9nnpeh/2ZaRokyUE
 np/xEXG5ehVqQonq1SfS9w0TbGq6JeMd14OmlrVIEkBtDcO2rIqNe6ucyEh2UIaN6KnBKHCk9
 NH6Xa0JXOB7AvfBI/iZ9iA8n0tkXqkjjHDB9inEggBT3zoJRvxEzpdlDhdMJZEwjYaxahmatd
 V52gB6RBcNFTvHd1+lvQmNeajFuMkMN/L07jAGk1BilhyNs5NGy0qAyfwu2D75JGWWaUULZxe
 K8LQORh7HA1nPU3t9b77DpZR7NWiqZBj07EIH4DlMKSp7S94VoEk2j+5pqL/YLGtfx+s6OzOD
 Vp0oLnmXkGkLSUNZ3yhuPq8WN2wMYnHaOVK1bS99a/yFuc+U4/ZAlPuOZ7eUaqBot6j08j/4G
 4MOQdgQE1mvgcUnJeuvGrA8s//p4oMOOZIIp/UyZR1/aT6Tgam5tukkYhMX6lFfa0TjScc/4E
 7Hpa2TNPOdNNSOKvKLJYJhKOraBmEiQ3upO/8qilk6GDlFcyOK72Hz1GyZPbJsf8P2XEmT8FL
 2SvD8yW5kwdfB5wR/L+h7H3JIgGAxmThCNzdDcnR8uiJI=
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1747
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/594a83eb-b693-4f5b-b330-c0c4cb655661%40web.de>

> Source code parts can occasionally be repeated.

Would you like to clarify how the data processing for scripts of
the semantic patch language should be influenced by the program
parameter =E2=80=9C--no-loops=E2=80=9D?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/477e7e12478bd317aa97e=
e79857d185601ab6f33/docs/manual/spatch_options.tex#L365
https://github.com/coccinelle/coccinelle/blob/477e7e12478bd317aa97ee79857d=
185601ab6f33/docs/manual/spatch_options.tex#L365

Regards,
Markus
