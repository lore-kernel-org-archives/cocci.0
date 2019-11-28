Return-Path: <SRS0=sp25=ZU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041BFC432C0
	for <cocci@archiver.kernel.org>; Thu, 28 Nov 2019 07:08:21 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F5BD215E5
	for <cocci@archiver.kernel.org>; Thu, 28 Nov 2019 07:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5BD215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAS77xf9010006;
	Thu, 28 Nov 2019 08:07:59 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6291F77CC;
	Thu, 28 Nov 2019 08:07:59 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2BAC377B5
 for <cocci@systeme.lip6.fr>; Thu, 28 Nov 2019 08:07:58 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAS77vYa002857
 for <cocci@systeme.lip6.fr>; Thu, 28 Nov 2019 08:07:57 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.69,252,1571695200"; d="scan'208";a="413885251"
Received: from abo-228-123-68.mrs.modulonet.fr (HELO hadrien) ([85.68.123.228])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Nov 2019 08:07:57 +0100
Date: Thu, 28 Nov 2019 08:07:57 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Strace Labs <stracelabs@gmail.com>
In-Reply-To: <CABvP5W1W=p1-n_831VaiJyNsHrepFS0CNJSDQqmfPkrC1rx=Ww@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911280807030.3704@hadrien>
References: <CABvP5W1W=p1-n_831VaiJyNsHrepFS0CNJSDQqmfPkrC1rx=Ww@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-767525040-1574924877=:3704"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 28 Nov 2019 08:08:00 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 28 Nov 2019 08:07:57 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Replacing printf/format calls based on the data-type
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

--8323329-767525040-1574924877=:3704
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



--- Please note the new email address ---


On Thu, 28 Nov 2019, Strace Labs wrote:

> Hi,
> I am working on a semantic patch for replacing specific format string token based on the used data-type.
> so, I have several calls of my_printf() and some special macros pointing to them around my code.
>
> e.g: part of my code.
> .....
> struct mydata *m;
> struct mydata h;
> .....
> my_printf("%s", m->name);
> .....
> my_printf("%s", h.name);
> .....
> my_printf("whatever id %d following the string %s\n", id, m->name);
> ....
> Macro_to_my_printf("Hey id %d, let's see %s\n", id, h.name);
> .....
> Macro2_to_my_printf(fd, "Hey id %d, let's see %s\n", id, m->name);
> .....
>
> My current humble *.cocci
>
> $ cat fix-my_printf.cocci
> @r1_heap@
> struct mydata *SMD;
> format F =~ "s";
> @@
> -my_printf("%@F@", SMD->name);
> +my_printf("%m", SMD);
>
> @r1_stack@
> struct mydata SMD;
> format F =~ "s";
> @@
> -my_printf("%@F@", SMD.name);
> +my_printf("%m", &SMD);
> $
>
> But, I can match only with partial content as can be seen below.
>
> $ spatch --partial-match --sp-file fix-my_printf.cocci sample-format-string.c | egrep "^(\+|-)"
> HANDLING: sample-format-string.c
> diff =
> HANDLING: /Volumes/Users/jpereira/Devel/Sandbox/sample-format-string.c
> diff =
> --- /Volumes/Users/jpereira/Devel/Sandbox/sample-format-string.c
> +++ /var/folders/ld/6tg9c6qj4fx4c85q26mcqrsh0000gn/T/cocci-output-24659-130f86-sample-format-string.c
> - my_printf("%s", m->name);
> + my_printf("%m", m);
> - my_printf("%s", h.name);
> + my_printf("%m", &h);
> $
>
> Anyone could give me a light about how to proceed to match the entire ".....string format..." ?

I think that what you are asking is why you can't write a pattern like:

foo("...
-%@d@
+%x
  ...")

At the moment, there seems to be a bug.  I will check on that.

julia
--8323329-767525040-1574924877=:3704
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-767525040-1574924877=:3704--
