Return-Path: <SRS0=xE9x=IF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE159C433E0
	for <cocci@archiver.kernel.org>; Sun,  7 Mar 2021 19:14:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F2ED60230
	for <cocci@archiver.kernel.org>; Sun,  7 Mar 2021 19:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2ED60230
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 127JEFYL018938;
	Sun, 7 Mar 2021 20:14:16 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D4CA777BF;
	Sun,  7 Mar 2021 20:14:15 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9BDDA571B
 for <cocci@systeme.lip6.fr>; Sun,  7 Mar 2021 20:14:13 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 127JECxv000043
 for <cocci@systeme.lip6.fr>; Sun, 7 Mar 2021 20:14:12 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.81,230,1610406000"; d="scan'208";a="375022443"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Mar 2021 20:14:12 +0100
Date: Sun, 7 Mar 2021 20:14:11 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Joe Perches <joe@perches.com>
In-Reply-To: <a186c9d063663ac6de66db944d1925146393bec5.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2103072011480.2930@hadrien>
References: <053b06c47f08631675c295b5c893b90be4248347.camel@perches.com>
 <a15e5c4d-a60f-14b9-90e5-4e600771aa9d@prevas.dk>
 <a186c9d063663ac6de66db944d1925146393bec5.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1189131414-1615144452=:2930"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 07 Mar 2021 20:14:16 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 07 Mar 2021 20:14:12 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        cocci <cocci@systeme.lip6.fr>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [Cocci] linux-kernel janitorial RFP: Mark static arrays as const
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1189131414-1615144452=:2930
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Wed, 3 Mar 2021, Joe Perches wrote:

> On Wed, 2021-03-03 at 10:41 +0100, Rasmus Villemoes wrote:
> > On 02/03/2021 18.42, Joe Perches wrote:
> > > Here is a possible opportunity to reduce data usage in the kernel.
> > >
> > > $ git grep -P -n '^static\s+(?!const|struct)(?:\w+\s+){1,3}\w+\s*\[\s*\]' drivers/ | \
> > >   grep -v __initdata | \
> > >   wc -l
> > > 3250
> > >
> > > Meaning there are ~3000 declarations of arrays with what appears to be
> > > file static const content that are not marked const.
> > >
> > > So there are many static arrays that could be marked const to move the
> > > compiled object code from data to text minimizing the total amount of
> > > exposed r/w data.
> >
> > You can add const if you like, but it will rarely change the generated
> > code. gcc is already smart enough to take a static array whose contents
> > are provably never modified within the TU and put it in .rodata:
>
> At least some or perhaps even most of the time, true, but the gcc compiler
> from v5 through at least v10 seems inconsistent about when it does the
> appropriate conversion.
>
> See the example I posted:
> https://lore.kernel.org/lkml/6b8b250a06a98ce42120a14824531a8641f5e8aa.camel@perches.com/
>
> It was a randomly chosen source file conversion btw, I had no prior
> knowledge of whether the text/data use would change.
>
> I'm unsure about clang consistently moving static but provably const arrays
> from data to text.  I rarely use clang.  At least for v11 it seems to be
> better though.  I didn't try 10.1.

I tried the relevnt drivers in drivers/input/joystick.  I got only one
driver that changed with gcc 9.3, which was
drivers/input/joystick/analog.c.  It actually got larger:

original:

   text    data     bss     dec     hex filename
  22607   10560     320   33487    82cf drivers/input/joystick/analog.o

after adding const:

   text    data     bss     dec     hex filename
  22728   10816     320   33864    8448 drivers/input/joystick/analog.o

This was the only case where bss was not 0, but I don't know if there is a
connection.

julia
--8323329-1189131414-1615144452=:2930
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1189131414-1615144452=:2930--
