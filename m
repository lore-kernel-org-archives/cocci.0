Return-Path: <SRS0=hTpQ=YH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A801C4CECE
	for <cocci@archiver.kernel.org>; Mon, 14 Oct 2019 11:51:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB88207FF
	for <cocci@archiver.kernel.org>; Mon, 14 Oct 2019 11:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="O3bIaz+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB88207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9EBoiCM020027;
	Mon, 14 Oct 2019 13:50:44 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4225C77B2;
	Mon, 14 Oct 2019 13:50:44 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1A0EC7792
 for <cocci@systeme.lip6.fr>; Mon, 14 Oct 2019 13:50:43 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9EBogF7005611;
 Mon, 14 Oct 2019 13:50:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571053837;
 bh=ww5VwVU+LPiwubY3uWmNENP/n6oE4cEePj2LOyVc1jQ=;
 h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
 b=O3bIaz+ARLd3Tg6uO1+ReRjRvZ911zcwQqylQMfFWcDdpw1Wruh9hdekVXZT5e/p7
 x/u3DYvkEFTh8uhcXHXHnnsj+bPxDBx0J9sDwTfXOasSygGbgPWEOgdk39bjhmKYHr
 ap7rn0LxNN5Owv+Qa1fekTunbMewiTFQfotqqzkI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.26.106]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MGzFy-1iG7GZ2iEk-00Dny1; Mon, 14
 Oct 2019 13:50:37 +0200
References: <alpine.DEB.2.21.1910141309080.2330@hadrien>
To: Julia Lawall <julia.lawall@lip6.fr>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?=
 <jgross@suse.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <62c99227-667a-0133-ac31-6e6b144bb3d9@web.de>
Date: Mon, 14 Oct 2019 13:50:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910141309080.2330@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:XVBsHeGzg4ga9TiXQ3yeSa26REfo7qhSPsKy+7C3c1YUWlO0j0G
 vxnrzRQNCAH8WfMkds3fm4mswsQSimCmJooAYTdQFOwri84lPG/X4Wa6zAij1Ys51EyCjx1
 qoe2ctjtyMhy8/Hmykm6rW0srTSxxKYDBiOEb3kCyAM4Ni8HXTVvVpSQxJDt5QSzTC7Rfji
 fARzKL4AkJFXZDLwguMww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9c/bVYZnflA=:Qto0Kfk0MJyx8VUxpvfaS6
 BVavgnDC4Jsshkd41H1XLrtkKzfuG/khxhEQfhv0hHx94iS5pgIU87duWdlBE5h1vIKqQoS18
 lax97BunlZWA7JLm6kndFgiglhaJ6Am5Rvf4mjL4BYPvDsEFDjp2kElu+d0idnYB4s0emXaUz
 Ntqip9oYlZeUknPOTWyL0lQRBbVRfttHs+MZ1StxEslOFm/754lVXMD5f7+/MQLPOYPcMksrF
 yEwREMjNtl4+zaLxJcepuzd4Fh64UGF4LPg33TrcHwe9TdsHbLvqOqq031FvJTfylF4mV4wAn
 gcprSvaMXOs2BlP6AjBPYA+GSZa2rQAs/juPVCy2s1Qco/NK9O13LCjNQCEEETx0EP6Yg69N4
 3IiBmJh4q5OteipqqzpIqTBN61CfU5MApRbUzh9vPHZjTaVlxDrkfLaqAdES0TbyRaXEBii1m
 U3hVZcboCXDgMmH7EVPF2NQfNAnlMOLbiEVF/Co97iF6jIX2YebjE81DO+gHbjXqOIZIGvLiz
 QnDejH/HUCikRN3HiOLfMiwGQk/UU+ZjLXkL5q+FPZHUs5W3OJ6+T5SOaC9YaQzIF8L3WBPFk
 g9e8I+19a2q819I7Y34e7AO7XFmYFxYrfA8ax8ehOkcp9nWy20YiYTOOOE/M5FoKkWx/zISLc
 lxUlfnkJ9F/zmwOnlWugZtJp7YP6XHnWBJdP98seFvsAaazI/peg+TzXl8thBVVA2WkMIdnw1
 ahhVH2ADyXaqQ3bLpxNZyjkywuyXApuNpgONFIXpppPoR21+1HeqDfWTB5PsbuKXtMLHNmEXk
 W2POBZJ6QSQ6l6haymYZE/J4oCRbtBh0adaJN13pZmoReI2XxUjYt2EZs3XXj2b5DTrLuwxpO
 6OAega0qxIeg65mVS+ESIUA2PyAFBrErHTTUMgrGjMbKSodzrqXwiKvAx442mSP/+86XLNw+f
 LUqoqpt+rZr7jm5GDNSHlxtSixvd9m85At8FRsCX/WQHvMT96/4Axqrr2Gykbf5MZHrNH6i09
 PMFjZcgekrK8/lvvoJQmlfFckKjzaGnbodZtFkvEXY7/QQapxrol2LrJvN+XwhrC5Uw97spnY
 ejNx+VxxAzaJQLS6+S5xb7h0jakFUOEx/rJvL7E9SWyG8omtURpwrYbJDvTrMLLX8mjRYoc3+
 QbBoysmT2gx2GG3OqfDwHWpP5xnQfSA/6XkMVa4uk0AnwdyXrx7Xvt4zJu7HiOTQ98rYzWqYq
 aEAVQy6/+DDAAlXzhWyi9le+ijOO+3YfYHSr9HnIqLBg/A1hBeJRHWWeCgEM=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 14 Oct 2019 13:50:45 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 14 Oct 2019 13:50:42 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] macro parameters and expressions?
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

>  #define macro2a(par)            \
>          par++;                  \
>          func(buf, 1, 17)
>
> Nothing happens here either.

May I see also the complete source code examples?


> Because the final ; is omitted the body of the macro is not valid C.

I suggest to reconsider also this view.


> But it doesn't work if you add a semicolon at the end either.
> It seems that a sequence of statements is not supported either.

Do such software limitations become more interesting?


> On the other hand, if you transform it into a do while(0),
> even with no trailing semicolon after the while (0) all is fine.

Such a coding style can also help.
How will the affected software components be improved further?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
