Return-Path: <SRS0=pejK=5M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98144C43331
	for <cocci@archiver.kernel.org>; Fri, 27 Mar 2020 18:37:48 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DE0F20716
	for <cocci@archiver.kernel.org>; Fri, 27 Mar 2020 18:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE0F20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02RIbZNI022924;
	Fri, 27 Mar 2020 19:37:35 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 166147812;
	Fri, 27 Mar 2020 19:37:35 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2BE1F780C
 for <cocci@systeme.lip6.fr>; Fri, 27 Mar 2020 19:37:34 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02RIbOu1011737
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 27 Mar 2020 19:37:24 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.72,313,1580770800"; d="scan'208";a="442686665"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Mar 2020 19:37:24 +0100
Date: Fri, 27 Mar 2020 19:37:24 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: George McCollister <george.mccollister@gmail.com>
In-Reply-To: <CAFSKS=NXVUcp1KwpidZoFTfyUCmh+8ij2njaGZ7g6h9LvEiYrA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2003271926000.2709@hadrien>
References: <CAFSKS=NXVUcp1KwpidZoFTfyUCmh+8ij2njaGZ7g6h9LvEiYrA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 27 Mar 2020 19:37:35 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 27 Mar 2020 19:37:24 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] using cocci to switch to formatted log/print function
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



On Fri, 27 Mar 2020, George McCollister wrote:

> Hello,
>
> I'm working with an old code base that makes excessive use of the
> following sort of construct:
>
> char display[128];
>
> ...
>
> snprintf(display, sizeof(display), "example log message %d", i);
> log_buffer(level, strlen(display)+1, display);
>
> I'd like to replace this mess with a single call to a function named
> log_formatted(). This involves moving the format string and arguments
> passed to snprintf into the log_formatted() call, removing snprintf
> call and (here's where it gets a bit tricky) remove the buffer if it
> isn't used for anything else.
>
> I have this all working with the following script with the caveat that
> running it on moderately complicated source files makes it never
> finish (after an hour or so the spatch process crashes with a stack
> overflow error).
> I've tried --no-loops which seem to speed things up but complicated
> source files still result in it never finishing.
>
> @r1@
> type T;
> identifier disp;
> expression level;
> expression list prnt;
> @@
>
> {
> ... when any

The above is not necessary.  YOu don't have to start the match from a
block.  You can just start it from the declaration.

On the other hand, the declaration may not be needed either.  After your
metavariable type T, you can put

local idexpression T[] disp2;

Then the match should be:

  snprintf(disp2@disp, sizeof(disp), prnt);
... when != disp
- log_buffer(level, strlen(disp)+1, disp);
+ log_formatted(level, prnt);

The notation disp2@disp will match both disp2 (idexpression of a
particular type) and disp (identifier) against the first argument of
snprintf.  This is needed because 1) you want to give a type, which
requires and idexpression, and 2) in later rules you want to change a
variable declaration, which requires an identifier.


> (
> T disp[...];
> |
> T disp[...]="";
> )
> <+...
>   snprintf(disp, sizeof(disp), prnt);
> ... when != disp
> - log_buffer(level, strlen(disp)+1, disp);
> + log_formatted(level, prnt);
> ...+>
> }
>
> // Only remove the display variable and snprintf if there are no
> // other references to the variable.
>
> @r2 depends on r1@
> type r1.T;
> identifier r1.disp;
> expression list r1.prnt;
> @@
>
> {
> ... when any
> (
> - T disp[...];
> |
> - T disp[...]="";
> )
> <+... when != disp
> - snprintf(disp, sizeof(disp), prnt);
> ...+>
> }

Here you could try considering the problem from the opposite point of
view.

@r2 exists@ // exists is what helps you drop the complexity, by needing to
type r1.T;  // find only one matching path
identifier r1.disp;;
expression list r1.prnt;
position p;
@@

(
T@p disp[...];
|
T@p disp[...]="";
)
...
snprintf(disp, sizeof(disp), prnt);

@r3@
position p != r2.p;
type r1.T;
identifier r1.disp;;
@@

(
- T@p disp[...];
|
- T@p disp[...]="";
)


Does it matter that the initial value of disp is ""?  In the proposed
first rule I have dropped that constraint.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
