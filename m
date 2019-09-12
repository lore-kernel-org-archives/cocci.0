Return-Path: <SRS0=dhti=XH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D142FC4CEC6
	for <cocci@archiver.kernel.org>; Thu, 12 Sep 2019 14:56:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 286C42081B
	for <cocci@archiver.kernel.org>; Thu, 12 Sep 2019 14:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="kRSWQgUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286C42081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8CEugN8023857;
	Thu, 12 Sep 2019 16:56:42 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7144A7798;
	Thu, 12 Sep 2019 16:56:42 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 43B0C7797
 for <cocci@systeme.lip6.fr>; Thu, 12 Sep 2019 16:56:41 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8CEu8Z5018960;
 Thu, 12 Sep 2019 16:56:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1568300167;
 bh=PGbF4lrqiG6Gf8fuWBxAi1SsDcqxpCIGDGRWe9DoM9M=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=kRSWQgULfz4dHkgy0AHfm6UZ5UYQC/rkCbQL5CtziPM5rH2tso5kVU4Fje3hsIfPC
 5Fx0v7BDEHJZeiWuv4Tvx2Vnw2LoT3aezM+cbcoaOjDC+EV4mK3HWiJ/BO/7Qdk/DH
 w5ZvxfrIBHBK5LKGeS8AyJr2a7ojvZGh2ypgh/kA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.130.119]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LcPf8-1iZXnt0WwQ-00jp3k; Thu, 12
 Sep 2019 16:56:07 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <20190912123435.ztwsymd7m4s4n6hq@gintonic.linbit>
 <9ba987e2-c6a2-cf6a-5a94-8bf841a6e195@web.de>
 <alpine.DEB.2.21.1909121648550.2876@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8360681f-15d1-0292-a6c6-720746844280@web.de>
Date: Thu, 12 Sep 2019 16:56:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909121648550.2876@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:i+pQCzkeK8cHko46YcI/NQYBjnZ9WtGoR97ueNEHHnp39CW7YQV
 Y30u38OWEkaWG06AdhCoiZ9/nBlUcmel49QX3R7MJM4eXt0/x0+5A1ZH5nYyWs4Zp3hahv4
 GK8v0JV6QKyrao+zLft6370yWxTK3iDTE5Re/taIMLmK8cyqz1J/YyXJ02PErFdLtsW1cy/
 WeIYaJ5Cs95mWrZVrpvYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j2Kp1z7h38w=:OMpFD5UfBZH0rH0E5ZNm65
 5cf4zuQZB+6kaC9OTWPeHAIAhuyk8XRe2ugW5zdYZwud/QexlCgjrBj1iZ/k0NbeJuYe1TwrW
 nRAqJK1lCebA2yfF/4fN0cq/JdxJqwbHsY9OSSoV+itnOLade++O/PZAnn0EF/g8z/0QkCmVb
 VlTiFxpGROMJbHqe+MmOH9NphH0gTnL95EoH36Tt32Q4xnnuIpX28A4fjAASLBECSQeVtg+m7
 irlZeSyvfGi2p+nMvjLM86oUL70eOOU0kHR7h07kpw3xoEfzG5D/eqCKzp/g98nfrXHa7b5eZ
 lbF5SaVpOvkOa+YfrgSP3zkEJJZNmmmkqQfSirvLkr9hixwCRmTh3Sp0D44nac6O21sd3EzqO
 3ggpAcq83NuM5shX4w2P+tjBfQrD3AqidgcfCGJksCkT96leZu97EwQSnF/vkpAvDBM+Rxfb+
 ZME10O8CIYQe3LPYuaZnXWIcsVts4O423LYfLOPhRYLBvQWjiaHYvChW/RiAlG+rF5nLXR5/R
 O5wx/MxlCScZKV/ZPMdACbh/IzId99TE/zVUjFvhnQU28/sox43aYlUT5NjZh5JcPk//lPiB9
 msKjQYqw8tHKVxWYbzsscHH4RCzJCVDa0KpXVuYsTYeicK3eqUGgRJ9OKGlABfXxchvvGUQ1Q
 +t8mdLwX3K4D3dzZH75aAupOfJxI8uPHLiHRHSbhLs0gXzoeBD+aOnoWj2tbfg0u+5WlCvwkw
 gNmoZfV+UP7CCP3aFyiVq0SIdn9i6twnxK1mEPm0g/XytnwWXjiFiXEBv4WbwH8m8Smd4FAKz
 YfNZh5BdK+d16BJegeobdbs0Gwbt1va5GOICfyHNT0el5KCG2e9iJyW0yGi6r+yHNMnyOCSLF
 KHw7XIZ5zNS3gaqBtqCFbZ5Ck0L/53LWX9eI+WCBcQaoYOoJrvcivGyBhlxIOE63QE2dulYn8
 pWYl07bdPsz72r81txxL7lE/i6vaiG7PJIHB/LcuxuHAnijxSSfUm6vvr1+z5d/FgcWWoc55M
 zmyN0941X+NNoODXPxDtNmIQyO6U26aJisDRYrW0bIBJ9Q83DD9AkjJYWIDQ3vgSo0xxoVKFf
 8syQYum1jcFU9XfaXmea6ypmTwq5JBuX9SPJanvdQ4dtxpluZ/7qfx9Vp+g8u9MTEQbCVrcwm
 FJNBPKZy2HJr/8ysplErhxh8iEyJnVhiPL+BZbOxp3++b3TPWyZ/e30JbYOcqck/Lxg5p6Itt
 jqadRhgcFddg3l2Y+JuDW6axnGgpjlm+7/bYzX543MfYZDnZ/MbJT2H6uu9Y=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 12 Sep 2019 16:56:42 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 12 Sep 2019 16:56:08 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] const in parameter lists
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

> It would really be helpful if you would actually test things before
> proposing them.

Should the suggested SmPL approach work also finally?


> This produces the same parse error as the other options.

Will the software situation improve this use case?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
