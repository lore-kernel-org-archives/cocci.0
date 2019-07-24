Return-Path: <SRS0=DzZf=VV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28BFC7618B
	for <cocci@archiver.kernel.org>; Wed, 24 Jul 2019 09:31:05 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F03C620651
	for <cocci@archiver.kernel.org>; Wed, 24 Jul 2019 09:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="gc9Fn+D2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03C620651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6O9UpvD019495;
	Wed, 24 Jul 2019 11:30:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 81D1A777C;
	Wed, 24 Jul 2019 11:30:51 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0D4D3420D
 for <cocci@systeme.lip6.fr>; Wed, 24 Jul 2019 11:30:50 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6O9UkEc016699;
 Wed, 24 Jul 2019 11:30:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1563960632;
 bh=SyheEE4mTCHAKERmFibC4B8V4srPs1I08MSz+S5/dO4=;
 h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
 b=gc9Fn+D2o643SKOGsG7FR+3k3BRobz6iRTobFNKD6Yo8vSmk7pM7/Eh8B6+ZLyAdg
 RqPurAjIbiwQLyiI9h/vMlbGSz4MWJjl2k+pQrEl6FYat96Qo9tUXb2YZCYIkbLS5j
 B7Zmk88CtdWguiCG2Ebcc+7OwJhajqNuyLUD0LnQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.51.56]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LhvUI-1iCtE53FEg-00n8pJ; Wed, 24
 Jul 2019 11:30:31 +0200
To: Stephen Boyd <swboyd@chromium.org>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <20190723181624.203864-4-swboyd@chromium.org>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c98b8f50-1adf-ea95-a91c-ec451e9fefe2@web.de>
Date: Wed, 24 Jul 2019 11:30:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723181624.203864-4-swboyd@chromium.org>
Content-Language: en-US
X-Provags-ID: V03:K1:h3uGTxvoka6FJzcsaW1+c+MOCdTgPVPq4eeDSKpeLxNRxNAG99L
 Eskdzrm7XPJQcRB7ghNsxAfij474SiVAVMLc6ilPSenqu+faindFx8b3OhFVVAwuwDHN38d
 S/B0lsKo6GMVUomfAEtCmx9uMAFKG0kjw7bd+2cr+Uc/OGgWxi16f/4jXUcNiZPne3bD5QO
 ZuoQjF5Ercjgg27P1i/GQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MSSJnV4GNxM=:vC1JGF5Mm0SZsbcWnFAoh8
 hzzHzP9Q0NYzV2opxD+rl4IGEC6aqToLzkPm5ZH86vv/+3AcZPUfLTriyBdAw06P14rMZBS5c
 F/8RC7T/g0wyMylS7w9J8T7ETK3cDebU4CzXza42gZ7rVI1eMa76S05TQ/uTOHlF+EvScDF8Q
 YzWZpHffOt5baJ9uliAW0ZHg4/12gYVsE8fIaaoshLk45obTsRIW/EWr8OG4RPaTJWRvClvzs
 lBgGqkRFZZyLkHlEiVrVuIn32nRSiF7QNzpseW+NnY3SE4P2+/psbKn86rEPC5f8GFlTB/hVl
 XJZ8ACXw6H4I5y/GpTss/fblAjpAU8v7+nq5HwLDzrhsAhR10FiEXe+rJ6PLFfcS85ppqfdPI
 OhgcftEU1E27ZMe0av1g02Q/bXK4YHcWoes5JnSVaB6oyY8vPiU3vX6B0qNSKx3LFUo1mj3K0
 C3ZlzbfXoEggxZD07y6AnnuqfwCSE0GTdRaD7ze+fpb0r+qhyb4rpWkXvU/sZsLqeQW1VqPKu
 Zt1Sy/UHpr+KC7ycvvkqzRKkw03HyWiDOxNFp6m9G01X2u7EsH3NuVVLqXXDaLADO1S3Q1ZlA
 iMCvUz4OIeeavFhD1zRdDMcCcG4EEAep3hDEJXNhsTOsOwb+HJunHkneQZSmTZ8AP0G1v7B9Y
 BeN1GJcFJRzt4awwN9T5Aw24+7X8q2V2mA+217VFk9b1BOfBq1XKBMEmakFNcgA6UwQPmeZ8x
 D7OpffoNyFq7wkUTNDe7NWTcbLZHLb7d7JeU/NJnNyTEJD+GgnrsfKJM035Mo++srq8Mj6/TV
 04Wkn8BrN8uzYy23y4HpT+2xZbaIt7aDIrmJsa793FcpOmotWcK9lh14ZrKm3umJxiV0GS2+J
 Mff7de65/uRi6W7NgOYz8tMTaCgkxm//4gWrTA6M+W2tVqHYUwr6AScpiTri2a7LBye3oiFRx
 3WpbaSyzNtnsEBDUbA/nqmbfxLE9eOLGvi+9XK4M45YWs4m7z4ZtpTRADu/WHyqk1xySibS4m
 g2LBENLkOn6K8wlyzf1v1jtr6H/qjqHSI8BvcRq0WaIIew72NdS6REYrTCajU7zeknsCMm1i4
 6JYos/ryg4irIvlUHqU2L1j3WaGPE/DWyq7
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 24 Jul 2019 11:30:52 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 24 Jul 2019 11:30:47 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [Cocci] [PATCH v4 3/3] coccinelle: Add script to check for
 platform_get_irq() excessive prints
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

I would prefer to concentrate the usage of SmPL disjunctions on changing
implementation details so that the specification of duplicate code
can be avoided.


> +(
> +platform_get_irq(E, ...)
> +|
> +platform_get_irq_byname(E, ...)
> +);

Function names:

+(platform_get_irq
+|platform_get_irq_byname
+)(E, ...);


> +if ( \( ret < 0 \| ret <= 0 \) )

Comparison operators:

+if (ret \( < \| <= \) 0)


> +if (ret != -EPROBE_DEFER)

Is it appropriate to treat this error code check as optional
by the shown transformation approach?
Can this case distinction be omitted?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
