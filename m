Return-Path: <SRS0=1uRY=44=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE92C10F27
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2020 09:36:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB1A02146E
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2020 09:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="dFY5LnH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1A02146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02B9aalh012017;
	Wed, 11 Mar 2020 10:36:36 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5DB9B7816;
	Wed, 11 Mar 2020 10:36:36 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 097727802
 for <cocci@systeme.lip6.fr>; Wed, 11 Mar 2020 10:36:34 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02B9aXUQ015823
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 11 Mar 2020 10:36:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1583919393;
 bh=WDTJsnMCFuYApz+xjVV57fBZ76z0oN3JBLoGS6pOqtM=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=dFY5LnH0DE/YHGZH+4XIM7OmpzABzcVmlNshClBijEGmh3I1E0osZNT49NMYEhmWq
 jPiOOYUxZyKsSqBAPFoxNzWW08yXad6T5SYh2UQ+NfMejgKbXZTvKk10M+vr/xgyii
 8K0TGfqRXznmO60uwnwi8ql1Ivr/ChnVH47vO0jg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.144.136]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LsQPU-1jIT96353o-01244x for
 <cocci@systeme.lip6.fr>; Wed, 11 Mar 2020 10:36:32 +0100
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1c1280dc-d067-e0fe-c421-c18c6a884875@web.de>
Date: Wed, 11 Mar 2020 10:36:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:0r2qr7EPM67C80rfbtDKo8FrCBaqN46kmjd1/74VUXf4t/2B84i
 3M7wWbuakDqUt9FDL9/iVm4u/h78Mo2wlEFi8FgAFPzidtaj2u3xdp/Zz1I585yqpeTOBhs
 vt8j0YuZNBcFmp4DBZGkHTeX3r1YtL+TVORXaGCvvnaOrWcuwfcy6hyV0IIxE1rUgtJRWTL
 chzA62pU0DudaNoYtJMzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6wkA4j59Mw4=:t3tWny7JZKtN6Xiq6m/J/j
 GjCTLZNqlS5qdT4Tcq+Rbhse/T87UTEZop7idg35ZKa1Iqjm6JRQx8BcoXI7PTX47NSy5tySG
 MIXCYG9zVOmfXdsuUKFB/YPfEznssjKE+iK9ZoyYtNr7zCTksXh1FUWAFrqTGAIOKZfh7HLIw
 s2+lPlC6QwxXNaMI6pbsLrAczwjZUJfe+pUHXTLxyxb5cPiZzvdiG4Zd2fW3wx3NlYs6Tw9aM
 9JDfwN2iIoL9uYXnnHBhMWQLkNZbkUx2dVOVx8s5P3uvx/obHBndtiV2tZHCuYm8L6+eQFaqB
 t0GJLnt+4ZXga+AuSPz5Mv2JH9GY1a/z6mpTwDXEKF3D1zi7bhdRD9HW29LzKlxkZnOLr+fLr
 EJgnFBtxC4cD0f59f+YAAxRbKCe0mwcW2LUj6JV0QeKyBszBk4+cVv/+bif/d7TemUO74ms5b
 rvzT8q4qVllMsL+7MoXs1S+ShMiR1ImpbZilc2iPTxPF5djrX7ab3NuIapgSqESF1qEdyL61H
 6TvX6LCxdCrcWeJgaY2jc4tJf3sB2IKpIOShip0oDr4KbNDECdyeLQ6xyI/YtdDBisUTlXMvv
 WcOEMywsKi07RbQj60hjWDJjiaXGD0lQ+DcThTeaEAvqkfu+dHwQhvIIvk/rzxrV9NQ/vFcpB
 iTDRM55TVTUsIXHS6ZAowkmG8Je9P7pCYVd5/MkBS+11Ca0KAyR+Z4/gpladoDrqJ34vryUE8
 DyUIJf3ofcvLsJuIw8jb488/9nQR3TGKcCdxeyRpfAtOKTs9IgVLo4ApasyCZMGwUwyQLVbij
 qfre+pQtgMu0EhJiOW4Gk/p9EjFvtMaWJNvrvGwHdI/KcGwr3rPovEwL3q0zz4t3VoAPj2Rfe
 3yiquWmclPrv/pTZUItGmFggUA2NcTBcz0YbBO0TFMEiY+UHk5JDQER6BGqEFJtYPw7Vfbc7m
 0d19pHzwYo6dnzw/Mq84MJrOtF4ejkIi+X5HEkeAtWYLkYCFNbaglSsMcNfhPNtRS6Kwgbzx4
 9cogZXQ1SREb3MEHlKlf+XXwytvgZdIFMgZGpGUqEABFy9riW0tWT67GxzldrGYrfmjbEJnmn
 9EHQpvNgy+/O1iz0Tjmk2vpYmY+xOaxBLgs94Z/F1WW0uoDn4c40aYSe/ESL8hYnE5IxqvXJP
 zrKJb5i1dvCUVZRigoZxKKd32pr6iBT/AS0p6e9bZNUJvs0UoNyUXQg7+drp8mnnQ07cGwHZm
 yvVZMJncVmYtWyBo8
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 11 Mar 2020 10:36:36 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 11 Mar 2020 10:36:33 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Advanced processing for data streams?
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

Hello,

Can any circumstances evolve under which you would like to perform
data processing by the programming means of a software framework
which would be similar to GStreamer?
https://gstreamer.freedesktop.org/features/
https://opam.ocaml.org/packages/gstreamer/

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
