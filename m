Return-Path: <SRS0=POHO=YU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA247CA9EAF
	for <cocci@archiver.kernel.org>; Sun, 27 Oct 2019 16:47:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D6D20679
	for <cocci@archiver.kernel.org>; Sun, 27 Oct 2019 16:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="CGFtbDQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D6D20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9RGlgpt020418;
	Sun, 27 Oct 2019 17:47:42 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 91EE077B4;
	Sun, 27 Oct 2019 17:47:42 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 61D2C77AE
 for <cocci@systeme.lip6.fr>; Sun, 27 Oct 2019 17:47:40 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9RGldNK025118;
 Sun, 27 Oct 2019 17:47:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1572194859;
 bh=GDmu09TFhFJqCHeH7OQwXo1vq2SxtMi/IGmPFPRlffA=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=CGFtbDQQuupkf0tKiL41jiLvjJOwzwW7hqzXjuAFp9tIU8MgkO2xlALqHqZvx0KhU
 NPvXILRLdfAGoDqgaXMtso0m8arZShv7alsIRjirlyZzncUUeOtiXVlVEUZs7OZ8rP
 59pQqz8gbAkJy9dS9eIySbMJ6xsvubb8P41uRtF8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.56.174]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MWinD-1iVcGm0xIp-00Xpk9; Sun, 27
 Oct 2019 17:47:39 +0100
To: Julia Lawall <julia.lawall@lip6.fr>
References: <258d568b-2783-9f13-d84d-37a84150432b@web.de>
 <alpine.DEB.2.21.1910271713280.2623@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <580c9b95-90a3-eb69-18d5-44883676fecb@web.de>
Date: Sun, 27 Oct 2019 17:47:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910271713280.2623@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:TaBwgIXhxJGUq+idRp9xI8Y5UrA0M8jEmhoU1XW79mIGPY6q91r
 aWLUBXNbzqH3z+cUqzqtpnokng9bF/QzuneVRj2GUoCal1Wf05vBWkvOvXVkWpxFaDjlM0r
 Co7Ayx6Mg6IQXXe/dE5KpAb08QGCq+7gD+5eKeCE728ViOwkPLEn2fabO/0oJO4IZzyBxb9
 zA8my7u9EELuW1jjtnC3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6B9izkTPJcs=:ScIsAfVa/73FcT/EbrtfKo
 mM4HmHTTJ7fwLF3jTSHfG4itgxV44PEutabLAkKyfMdv7qaIZ1pL19Lzg1GdBNVVMZsivHPVG
 /WldOk6qRgL+m+YHu18CkfN82mNt1B5mwFyBtvdx+NWVdt/7oVNft0jlaHeGcdMOyybmaC4AO
 RQbZHE9We+8lrhkeLEmoft1WEvOBFNjzgP1Kbe/Dp2CAEM9BLT4H5EScup2UIeXb5bwSaGYNC
 rUv/Ajq6bpX97nqKdzooeUwt62uBlW4ekGgvB0Dehj0YpgMtyB28owEUUAS9Wj8oxU+VibVOS
 tNMrRO1lZ/8jOUk2o5BlVMTKTcpsofL2eco0STHtoi95R+PNEHpq+4yxNRNjCl12ibLpqgcwA
 Ft2tm1XS17wwkesKzVbiNyoxqotJYhzimOCDFi29P6VsJLsg5WXiqKb5Ps62Eaj8V176ycpqR
 UwFvUd3hGlKc6YgrpBBOdk83Qq/xkueNI4FbBkDQ96KNkWMap/bv+4YJmJg8aEtcOi9mspxFU
 AUpnFpgaPeROK5vzIn4BjlKyFUt3gEZJ2l9Y1PWdMrOrCi3LJdBFmZW8LLQEZxR6eiZjEhT15
 j2pdu/oL/oY/6b7XHFZjDxmY1jEAAxkImgx0j16sb+g5PrmfGSrKvv/RByR3AKn/Ow48o7f+9
 TIDhesWvi6jIzZoslNKl4JilqFWp/X1Tl1sQl0krJb+zBtFw45dWfXEdIOChi5EIqjIqoqvNy
 N24tfqsfFQvrcVP+IcaWMrOPtWP98aLiY0lR5+dw4Bx3LYSwGIWgAZNXe19rArU2B5XztN6Gi
 gMAzWgmyf2pjS71ZGoRnD19udG6GL/XUtM2A0NWkDvBDUi67yG7szpNu9lzscPw6x0ER/vBrH
 gXi0erc174Iqkfk94eBA7J7ttZq4MJsyrvXDDIu6ab8n4HVtf2KAvl6kyCH9FK85fmsO/R9pe
 bAagESUnEscFMqhSX2VHtkyrhrpq+SIZDAQxpYvCuojtRvkZAilOCfVhadXrVtBiclJRZKYT6
 8GTL2nfC1f1fUt0M40DQ7BuPATJWQrtyrybRAnok3fZwpV4JsbUZE4cjcBHTUiJFQoGiFK0vx
 1548/Htxs4dBGt0z4vcZdH7IPEGJhKxfXaBdfQWyV6o8wAhehMg9Y6eoq21yP2dPkiB/4Vzem
 IiLHPGFSPrnPNllq5VjKLXgCMgmUbZVfGQjg0vC7P/2ifDtsrf6XqzBmHZk5frVRwk8MPIWuT
 Cn03o62Xo3n/S75kejh4PTqkbitC5ESOBpFRy5NHoDzy0jKwhEp6fk6YdvzY=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 27 Oct 2019 17:47:43 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 27 Oct 2019 17:47:39 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Searching designated initialisers with SmPL
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

> I don't know why you would even expect this to work.

I suggest to take another look at related information sources.
https://en.cppreference.com/w/c/language/struct_initialization


> .remove is not a mainingful construct in the C language.

I got an other impression from the declaration of a known data structure.
https://elixir.bootlin.com/linux/v5.4-rc2/source/include/linux/platform_device.h#L188
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/platform_device.h?id=153a971ff578e9c8c5eadc9463c1d73a6adc8693#n190


> It is part of one, but it is not a construct by itself.

I am trying to improve source code analysis also around the usage
of function pointers.

But I have found some interesting information by the following search approach.

@find@
identifier action, driver;
@@
 static struct platform_driver driver =
 {
 ...,
 .remove = action,
 ...
 };

@display@
identifier find.action;
type T;
@@
 T action(...)
 {
 <+...
*kfree(...);
 ...+>
 }


So I guess that the clarification can become more interesting also for
the influence of commas and related SmPL constructs.

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
