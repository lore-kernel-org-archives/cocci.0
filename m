Return-Path: <SRS0=peAA=EA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FE2C388F7
	for <cocci@archiver.kernel.org>; Sun, 25 Oct 2020 20:55:19 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B3422284
	for <cocci@archiver.kernel.org>; Sun, 25 Oct 2020 20:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="hiAyX/hr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B3422284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09PKsw68029849;
	Sun, 25 Oct 2020 21:54:58 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2FAD35C18;
	Sun, 25 Oct 2020 21:54:58 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D8D205C16
 for <cocci@systeme.lip6.fr>; Sun, 25 Oct 2020 21:45:36 +0100 (CET)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09PKjauG022421;
 Sun, 25 Oct 2020 21:45:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1603658734;
 bh=XpHzDDphpGg8/UbUK1m3E36mNaylukbZlKLFkPPatW8=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=hiAyX/hrN2bZwnfh1uPjjJrSpkbR2x0pAH/pMUidBHNkrpKvoOQtgGfv4AgapyVN/
 IAIYYIUNrqZxbWMWbQrs+sSzvkF5frB2tI4OAEwJwE5LKEPjvg+ekOCWS9KXDt6qCV
 kBF2Tr9aXbXOmsPej1TjH3hhLuvBH1dGVU9Z9kMI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.86.219]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MG994-1kcHb82UzE-00Gf7N; Sun, 25
 Oct 2020 21:45:34 +0100
To: Julia Lawall <julia.lawall@inria.fr>, Coccinelle <cocci@systeme.lip6.fr>
References: <0d1575b0-ab37-663e-2464-278fd76280b5@web.de>
 <alpine.DEB.2.22.394.2010251924290.2714@hadrien>
 <8f58a94e-b093-a587-c56a-a0ea0fc1f3ea@web.de>
 <alpine.DEB.2.22.394.2010251955280.2714@hadrien>
 <bee0c5df-8f28-ee9d-99e2-abbf84df76e6@web.de>
 <alpine.DEB.2.22.394.2010252122320.2714@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <f32d351f-24a0-be5f-2905-1828943a6512@web.de>
Date: Sun, 25 Oct 2020 21:45:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2010252122320.2714@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:zA5eNEJ96XyR5WBFOZV1K46lyETuuWhU07mEm3e1MEyMpcMj4iw
 na2jGIiII5gRS03enf07utUZfaKvOvmoJxHFrzoKcl5T34d+4bGPkAV4J4r1r0+lNttu/+c
 0a1Yc4YqziFiuYm70NM5xf8B83BE4Qme16AUwBDq/EFBqR4hYzN/XZuBuI6NsreX5TvBnLI
 0w1ACwVCn59RQqP3u5sow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bhyy0d6qwho=:aIvyh2WTMransmz0x5wCS9
 LJfaumrjcJ6zZQ8KbPfsbKmZ1e1Iwf8iiWv1iKWD4mxSESg2P9LopnhkWSChsv7Mm7hX4Lt0g
 +Q6y/cgOjsAnN/sGOscinisr7UEmjxAUoFk/8myFRA4r+1miJ/CYStKFgCQ6L4ZteiI10Q7F6
 nrtLcCM0vE0U7JcBtsgxiZIYVft9xsj7xCZ//8lAbxdsmP6ljmVyq+efUpYUAIpwrq9s6hDSp
 4KN6R3ppmASHctTMsgBzkehO5crx68RAC1sVMMX+uORA5FzAg3Q5JxqPtQKgZQuE7POOfeiG2
 FAB+DC+bHNw5BW/tzKhkfJ2W/XT+myrv8DCeHr6Th2VJ1n2s/OwP9Y5YAOQ6kSXvj6Kno/E2q
 cyory42r8BEHHjPRGcQ/o747lcAmqlurisLER6l3oTObKBxCnbOy8GOwzLX/ZB8pbi4CtH1gX
 a8SQRFTeKKyCGUwbW5lV/Ww7JTdNSk7sH5ELtpzhzfi8SIvAL90lqhpYo4tPFuJpVjLQEnd11
 OUEcJSPWOe537hmbrrK1x+cv1XLUenpuavRRjOgLJjFjwFz+PKCi1p2mNBcaAF50fStvYjbRQ
 qZ9z0Ung0QxsFCieI5xLGSBSpmUI4dMisWke6JZUnA5brVBIeI8c2/tmJP6Tuz45dphWWAbMt
 3c73VBPb/9+0RoNUy3Rmpc6xsPbHFzmvePGW0uXc3gXJPI5AGFtdCeR8Dr/FSEc2ukNswVyac
 CGaWTN9CD0cegZnhLc+Q/1jkoWDJx+2Nd88qqZnU3+3a92vGl6DgEclMLj3SHwvdQ/5j/RXQ/
 GcSelkDS4zlYMcm7c6jy8JGEL/R4V4xWDZ2ogWIWjf97oNzwS4aKoSwuUWOOoyRZa9Q+aN4zx
 j9JqOM3iGkH1mAeiMDxA==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 25 Oct 2020 21:54:58 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 25 Oct 2020 21:45:36 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sun, 25 Oct 2020 21:54:56 +0100
Cc: kernel-janitors@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>
Subject: Re: [Cocci]
 =?utf-8?q?Coccinelle=3A_null=3A_Optimise_disjunctions_in_?=
 =?utf-8?b?U21QTCBzY3JpcHQg4oCcZW5vLmNvY2Np4oCd?=
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

> In the patch case, the user and system time are essentially identical.
> In the context case, the difference in user time is 2 seconds out of 9.5
> minutes, 0.3%.

This was just a single test run example.


> In the patch case, the real time is a bit slower.

I wonder about such an interpretation.


> But I believe that this is due to the time to read in the data from the file system.

I assume that I could reduce such an influence a bit if I would put
(my) Linux repository into a RAM disk.


> I also had a number like that, but the difference disappeared
> when I reran it afterwards, which meant running that case in the same conditions
> as the others.
>
> In the context case, the real time is slightly slower with your patch.

I guess that the small variations from such a test approach can eventually become
more interesting.


> So I see no compelling evidence for making the change.

This can be.

Should any other differences become more significant?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
