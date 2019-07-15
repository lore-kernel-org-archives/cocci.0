Return-Path: <SRS0=+49j=VM=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A6AC76191
	for <cocci@archiver.kernel.org>; Mon, 15 Jul 2019 19:50:47 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56E3120C01
	for <cocci@archiver.kernel.org>; Mon, 15 Jul 2019 19:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="SeSHN48j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E3120C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6FJoVev021532;
	Mon, 15 Jul 2019 21:50:31 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 08E247788;
	Mon, 15 Jul 2019 21:50:31 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5C24E777C
 for <cocci@systeme.lip6.fr>; Mon, 15 Jul 2019 21:50:29 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6FJoRwN025919
 for <cocci@systeme.lip6.fr>; Mon, 15 Jul 2019 21:50:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1563220226;
 bh=5Uyj5xiLZUp3if9lAOuR/dnBm1MulyCbMHyKbQu2cUM=;
 h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
 b=SeSHN48josUg7183J9cP1sURwG8i/ok2usFo432KGc7fAyuTGyRAL6lwLZlV64pX4
 kyWPpwVnd+ZQfQOcsFnmKoS9HN2+lsrZx6pjt/DAyE26Y/PSzvcZKj5cTWSsB3/T7B
 XVvB6bLuINutood2+lqPhnDxzX3LKgW47aEVr/J0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.73.93]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M2dTd-1icshL1VcT-00sLRe; Mon, 15
 Jul 2019 21:50:26 +0200
To: info@metux.net
References: <1559767582-11081-1-git-send-email-info@metux.net>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4b14aac8-af14-3599-0d66-7ebde8b06ac1@web.de>
Date: Mon, 15 Jul 2019 21:50:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1559767582-11081-1-git-send-email-info@metux.net>
Content-Language: en-GB
X-Provags-ID: V03:K1:TBraqjKCNdYQmhd5j/pGOzdN0GeoOc+PUA3HIPuC47rN+pf+QYM
 LxpWsIkRR5/ck1EeUIi7mxV2dQSuUsrY4dOl5A9L2fOABt9sUAV00IOUnLy5lIM/Yy6riDP
 O9DV2MHh48qOycoX4D6lWv0/4mrxBWBjvQeW5FgStQBuXecmo+5IaI8JcE8VhHaNLkRZrjB
 BzxdFlHNj1+X45cChYAVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h9kH35N01kM=:cRQ8oSh3mqzXX9H7pRC6sN
 YGr+JYf4GVXvSz/4utvBwbnKg6OJckXzlQh6Zwn7/kbjVUdZfTgCxg1mo+MrKTIOXdNl0PeZT
 3ZDAZNM8TKtK7dcQyLnyZaIy6G575IKHReyn/YfjAO8wM6TBBM5nrLyX/5lhvCvBkNn2nV5bq
 26DebGzLRSMzPPVdpEPlkP4y0BgDsEsPdj9mWEp87a8mlQnyedaWRElFPYHNih9pU1Vky8oKZ
 y1Pz9L+zeqjog6l//Pf0U8b4aPQdKyFE/zcxjXmYGL3wLlGKGv+F6sqnnZ+meEdYxojvtFCfK
 YNIQA/IIV7yZYwXhCDAFXVuXUSfznbW5F7ovULDcD8b5UejDhDch5h83Bm0h7P3mofQiIKeRO
 JJKnkN73LZDmH+sg2fn5yMaxEhFvb3uzTKWiWDl7YOBNGN27VrEfPhhcPfN4fVbWRyczkkkaf
 OSy4mX1WWbEhUSK8CKL+BsgL03FuSNCZnSac5xTNmRngHZ5FVHXs7GyvtWS7RmW31wldMPDzd
 escaoEKb6DCGTfBxhdfx5lpoKoYZa0QDeRhUySMkrJxVAKOptv+cZ5F7xYDaCltNOW2VIxvEv
 9XPyFeEA98NqO+Y1kZEOA2fTfX74b1UqL43fumBDVw1MTSZGQnumAqtLKB3L7uRmud/8gj1cA
 MIDEToWsxMs4JNZ9fYXbCmG+hpP5iKgCVCGqrtJqNrSmxyPIxqEyD/Ku4osY/6tY14bNEw9nV
 ywjxt5z3QwJ59OnMwJBtOctr/2Z1JOOsGBdXYsDRRjrvnndnmLjhC4+GzysaSy4W5D8K2JXW9
 1nIclcuXoj1lZ7KB+ydsAm+mYrR2KBagKeSxJ/0rw8E+FVk77vft/LMYT9lgA7hZiMIEdAUEP
 Gz3gWKyiLWYLJEZ13pZgnUUhnxyRVUr3QwgpDtEQYBLfiaMdyejXZME4rHTB2tGIEqF5bnaIN
 B+/JuVVxBj2zdXVLbf/wRKyBIRd/GZw+/XVtp6fIiVi8w2mIdbPWxuuOUPeo1Abm9AVDOmIrJ
 RcCoOjWdt4P7k/B6e5fLWPTlMGYl9bIDwx/GSeO9x0RcR2k4j1uolGWn1Sqv80Wh3azCYcfN4
 BnmQ9z9L2jrmJ2fplrd7Mk4Ukn3VsmhJMwl
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 15 Jul 2019 21:50:31 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 15 Jul 2019 21:50:28 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH] scripts: coccinelle: add check for uncessary
 double unlikely() calls
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

My software development attention was caught also by your proposal.

I would appreciate a message subject without a typo.


> +virtual patch
> +virtual context
> +virtual org
> +virtual report

These metavariables are not used in the subsequent code in this approach
for the semantic patch language.

Fine-tuning might become relevant also for the change specifications.
https://lore.kernel.org/lkml/1559767582-11081-1-git-send-email-info@metux.net/

Would you like to contribute an extended script version?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
