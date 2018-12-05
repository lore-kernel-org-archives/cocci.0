Return-Path: <SRS0=Yxto=OO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3752C07E85
	for <cocci@archiver.kernel.org>; Wed,  5 Dec 2018 06:47:48 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 670532082B
	for <cocci@archiver.kernel.org>; Wed,  5 Dec 2018 06:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670532082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB56lTB7017492
          ; Wed, 5 Dec 2018 07:47:29 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6CD3F76DA;
	Wed,  5 Dec 2018 07:47:29 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4555E76D4
 for <cocci@systeme.lip6.fr>; Wed,  5 Dec 2018 07:47:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB56lRHP026192
 for <cocci@systeme.lip6.fr>; Wed, 5 Dec 2018 07:47:27 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.56,317,1539640800"; d="scan'208";a="358830649"
Received: from abo-91-111-68.mrs.modulonet.fr (HELO hadrien) ([85.68.111.91])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 07:35:33 +0100
Date: Wed, 5 Dec 2018 07:35:33 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Timur Tabi <timur@kernel.org>
In-Reply-To: <CAOZdJXUDY=D7mbCGTqyseq6nDsevAr9TFg9_utKnSQWPjH5a5g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1812050734520.2670@hadrien>
References: <CAOZdJXVLMv-5_u1uOq6re+1O3vADsrTK0+J3Fat-XN4_2DEp4w@mail.gmail.com>
 <alpine.DEB.2.21.1811151327420.2372@hadrien>
 <CAOZdJXWD0L4Qwh2raJLF25Ax0=DR06vhfGWhpQVf804YQJ5jeA@mail.gmail.com>
 <alpine.DEB.2.21.1812042124260.2383@hadrien>
 <CAOZdJXXMTrXXEKta-M0uYq3EpjVaSz2++OT1GOB5HYmx5h_TgA@mail.gmail.com>
 <CAOZdJXUDY=D7mbCGTqyseq6nDsevAr9TFg9_utKnSQWPjH5a5g@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 05 Dec 2018 07:47:29 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Wed, 05 Dec 2018 07:47:27 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Can the current function name be passed to a Python
 snippet?
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



On Tue, 4 Dec 2018, Timur Tabi wrote:

> On Tue, Dec 4, 2018 at 4:02 PM Timur Tabi <timur@kernel.org> wrote:
> > Based on what I've read, I need to add < > in order for spatch to run
> > the rule multiple times within a function.  But if I change r4 to
> > this:
> >
> > @r4 depends on rules@
> > identifier func;
> > expression x;
> > constant char[] c;
> > @@
> > func(...) {
> > <...
> > NV_PRINTF2(x, c, ...)
> > ...>
> > }
> >
> > It doesn't work at all.
>
> Ok, I changed it to
>
> func(...) {
> <+...
> NV_PRINTF2(x, c, ...)
> ...+>
> }
>
> and now it works.  I don't know why I needed the +'s, but at least it
> works now.  Thanks.

This means that the rule only applies when there is at least one
occurrence of the pattern in between the <+... ...+>.

The previous rule matched all functions.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
