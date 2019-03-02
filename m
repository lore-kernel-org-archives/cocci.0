Return-Path: <SRS0=YNK9=RF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2647C43381
	for <cocci@archiver.kernel.org>; Sat,  2 Mar 2019 06:05:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49BF320836
	for <cocci@archiver.kernel.org>; Sat,  2 Mar 2019 06:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BF320836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2264qXF015367
          ; Sat, 2 Mar 2019 07:04:52 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8D0427701;
	Sat,  2 Mar 2019 07:04:52 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 316563ACF
 for <cocci@systeme.lip6.fr>; Sat,  2 Mar 2019 07:04:50 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2264nA1019547
 for <cocci@systeme.lip6.fr>; Sat, 2 Mar 2019 07:04:49 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.58,430,1544482800"; d="scan'208";a="297853098"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2019 07:04:48 +0100
Date: Sat, 2 Mar 2019 07:04:47 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Timur Tabi <timur@kernel.org>
In-Reply-To: <CAOZdJXVJw4VSq5YzCaQGjsEA2L3EdByRvNpSF3TvPm1FqNsQPw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1903020701270.2572@hadrien>
References: <CAOZdJXVJw4VSq5YzCaQGjsEA2L3EdByRvNpSF3TvPm1FqNsQPw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 02 Mar 2019 07:04:53 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sat, 02 Mar 2019 07:04:49 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] ERROR-RECOV: found sync '}' at line
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



On Fri, 1 Mar 2019, Timur Tabi wrote:

> Cocci seems to have problems with { } blocks inside #if statements.
> For example, the following code:
>
> void func1(U32 Notifier)
> {
>     if (x == 0)
>     {
>         x = 1;
>     }
> #ifndef MACRO
>     else if (x == 1)
>     {
>         x = 2;
>     }
> #endif
>     else
>     {
>         return;
>     }
>
>     DBG_PRINTF((DBG_MODULE_PERFCTL, DBG_LEVEL_INFO, "hello\n"));
> }
>
> Gives me this error:
>
> ERROR-RECOV: found sync '}' at line 19
> parsing pass2: try again
> ERROR-RECOV: found sync '}' at line 19
> parsing pass2: try again
>
> In this case, my nv_printf.cocci is still able to process the
> DBG_PRINTF and convert it to NV_PRINTF, so technically it still works.
>
> However, I have much more complex source files (which I cannot share)
> that choke spatch.  I typically get multiple "found sync }" messages

Those messages are not necessarily a problem.  It is talking about parsing
pass 2.  There are four parsing passes.  To find parsing problems, you
should look for BAD.

> along with stuff like:
>
> PB MAYBE: dangerous typedef inference, maybe not a typedef: NvU8
> TYPEDEF CONFLICT:NvU8
> FLOW: cant jump to done: because we can't find this label
>
> In this last case, the label "done" does exist, but it's called only
> from within macros.

Is the macro defined in the same file?  Coccinelle may try to unfold macro
definitions if they relate to control flow.  Or you could put the macro
definition in your --macro-file-builtins file, which I think causes the
macro to be unfolded always.

julia

> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
