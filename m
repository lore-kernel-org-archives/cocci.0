Return-Path: <SRS0=YvFH=VT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6406C76188
	for <cocci@archiver.kernel.org>; Mon, 22 Jul 2019 06:00:47 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 372EB21955
	for <cocci@archiver.kernel.org>; Mon, 22 Jul 2019 06:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Q4S1aKIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372EB21955
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6M60W6k024240;
	Mon, 22 Jul 2019 08:00:32 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E6F8576BF;
	Mon, 22 Jul 2019 08:00:31 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4AAC0420D
 for <cocci@systeme.lip6.fr>; Mon, 22 Jul 2019 08:00:30 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6M60Sen010010
 for <cocci@systeme.lip6.fr>; Mon, 22 Jul 2019 08:00:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1563775227;
 bh=/7q9JVdIhlfFHmueCgoKgqCgST7j9CBkuVgzah8iipY=;
 h=X-UI-Sender-Class:To:References:Subject:Cc:From:Date:In-Reply-To;
 b=Q4S1aKIWt+GoZ5xz4rDvOYfXnylBZ4Mn3WxrcfF9k2g1OFbNUWSg9YrwgeKAy9M7M
 86aBfYoHXc9rw6SDO7+cP6J0laXSObV5sb0CGs0bkM/i5XraByPWJoRhdpiFUaSxWB
 bO317vkdP+YVRcFnBgx9/UChm1hG56ULDEXFy6ow=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.185.108]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MBCBN-1hfJ1C0qkn-00AFKY; Mon, 22
 Jul 2019 08:00:27 +0200
To: Ron Minnich <rminnich@gmail.com>
References: <CAP6exYLjntc0iPNOHdWSSUMw-ay3n4dFBAFfW=6Y1SOvmXT-Gg@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <97b1adc6-b176-bc37-7224-aee45ff073d7@web.de>
Date: Mon, 22 Jul 2019 08:00:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAP6exYLjntc0iPNOHdWSSUMw-ay3n4dFBAFfW=6Y1SOvmXT-Gg@mail.gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:DbBpXtoZ6w/kLXsAFRYJIOZ3fWi5ZIDqDxqoN6vIH+t8LHYSXve
 yZeXKyEZLXx5suGvXoK8/z9dDOZyqyiv1Wd4J3EeZjQ5IqrE1BoRQtnU+DUB7tbiUKzZbNt
 lSOj+FMoifJT6MXg+GVxnbC3rhs9B2NE8GG/m2qBpY9bn+AbxdMcXQBsM3OtKf6gOke3IKQ
 cSS498273P49y2yJ+l25A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DvUpKPsaKD4=:yTf+1eL4kY4xDjRr0SFglE
 Z6j/gi1IT1J7o1EK8+Y2dRHy8Tp6WZffr8btHzGTBcbQH97y6fyyr0xhsVd/XSjUmmyRdQs48
 8rgw922HmHLyhDfZ2JEY89FpdjgyBC2Hci9wf02QWFEsDqPgl7PIK3XiSOcertXWp68Xy7b2Q
 diyS1QURpv3ub6tXL4Hj2Rhz7v/uyulp+6+o3boToDXg4/PnXgjri2g7VjxTQDuOK22jm2FMg
 vRN+FdOERdNw2vwq4PYaNizReTHytXrfu8CwAr+OFWmnkack5wjRe6SeH1oYE/AQoJs8PlfLk
 92S+Ay/PSZRGr92VqPRJSMJFV9b8t84xeFkqz98QjYqblx36eBm+U9FzOkHmOcj9ADZvMi3Na
 +87+PGABxk9lAVRUTy4etMKHrcG6YLEEsbYTAePuw16bkBdwj4BneXOobk2lRvz/cBeY1uK2g
 fGOELptMWkcvw3HRp5R0ArvW3pHqhIwAt507wBCKgUl0y1S2Nx88JTomjMT1QxXtyeC0V0crv
 QvgekJr1fP/7YS6yHRXwuUQkhX+ejEK/mTlRD20XaD86z6Y+pfpx4rEUYpiuglYoB4yIuxPob
 LiaXJAAAcVaBhVusQGAoy46XoKeq2A81d3eZF2d6tM8HqRQgtZ1iwdNdxgzs88tKotjcLIImt
 7iVXg1+ECGdBuZYaEp+FzppCD2zlhvHJPDcQXsPw+f/5rzbE7x6jT18Ipuh/CTHVN9YHI3CSI
 qYJtWh/71bcpISwCcPd4uWl1sP/PNNyLWPjx/Ip8iELR7JKHVM1vP5ZnuAorlhekB4aG8stJ1
 NLHMEdyKlTKQwSKD7aNrHzOMDr2Fa43PwGwsnsAViuN2+XPf4qToKfTxnOLiuU+jodALlgkl6
 lllGDIpk1ImAnbVfiyaRxAazJVqRdwxy5X4MClQzTSfdRXyf7d58PQs1Jg9Mxx2iGJszeHdpx
 mBul7FxUrAWVyairc9zdKA5eT5aB06LyBDQ7gy1YCKqESwh+AKbs4yL5/lDiJry/eQLwaCRVH
 +rtNReLzOepoURYnzmD9ms8yjOPteOa9OAWm7TZfh11MjC9oryP2SvP0UU0brEg/B92ACn6YY
 WrmaCfS9lIz/oiXI8dPAwm0ndGa25c0SVW+
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 22 Jul 2019 08:00:32 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 22 Jul 2019 08:00:29 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Coccinelle for Go
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

> But I also write tools that
 use the Go AST package to rewrite Go,

Would you like to share any more experiences around related software?


> and have never felt the lack of
 coccinelle for Go.

I find this impression interesting.
How much did you get used to functionality which is supported by
the semantic patch language?


> I'm curious what you see as the use case.

Are you looking for wider support of a known programming interface?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
