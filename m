Return-Path: <SRS0=vlGS=OQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44183C64EB1
	for <cocci@archiver.kernel.org>; Fri,  7 Dec 2018 17:56:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D69292082D
	for <cocci@archiver.kernel.org>; Fri,  7 Dec 2018 17:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69292082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB7HuS7x001157
          ; Fri, 7 Dec 2018 18:56:28 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F41BA76D6;
	Fri,  7 Dec 2018 18:56:27 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 71CE576D4
 for <cocci@systeme.lip6.fr>; Fri,  7 Dec 2018 18:56:26 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB7HuP0q025779
 for <cocci@systeme.lip6.fr>; Fri, 7 Dec 2018 18:56:25 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.56,327,1539640800"; d="scan'208";a="359347065"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Dec 2018 18:56:25 +0100
Date: Fri, 7 Dec 2018 18:56:24 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Timur Tabi <timur@kernel.org>
In-Reply-To: <CAOZdJXX-_cVVTdvird2amhKRD-ywDgCxJopwof4ZovjU2zS-Yw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1812071855470.20798@hadrien>
References: <CAOZdJXW9XmFAPbhiSsejhFZ+9me=kHc25A-Qk0e=CrCnkkFuhw@mail.gmail.com>
 <alpine.DEB.2.20.1812071837160.20798@hadrien>
 <CAOZdJXX-_cVVTdvird2amhKRD-ywDgCxJopwof4ZovjU2zS-Yw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 07 Dec 2018 18:56:28 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Fri, 07 Dec 2018 18:56:25 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Fatal error: exception File
 "engine/ctlcocci_integration.ml", line 361,
 characters 4-10: Assertion failed
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



On Fri, 7 Dec 2018, Timur Tabi wrote:

> On Fri, Dec 7, 2018 at 11:42 AM Julia Lawall <julia.lawall@lip6.fr> wrote:
> > Do you know which function in your C code causes the problem?  Does that
> > function have some dead code?  You can try
> >
> > spatch --control-flow file.c
>
> That revealed the line number of the problem.  It's a goto tag in a macro:
>
> #define xxx(type, member) \
> ...
> member##_done:                                                               \
> ...
>
> I can work around this by temporarily commenting-out that line, since
> my script doesn't care about its contents.

I guess you run Coccinelle on a complete directory?  If so, does the
assert cause everything to crash, or only the treatment of the given file?

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
