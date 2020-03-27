Return-Path: <SRS0=pejK=5M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C392C43331
	for <cocci@archiver.kernel.org>; Fri, 27 Mar 2020 22:55:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C6F2071B
	for <cocci@archiver.kernel.org>; Fri, 27 Mar 2020 22:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ud2P6+OV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C6F2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02RMt414006781;
	Fri, 27 Mar 2020 23:55:04 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2BB287812;
	Fri, 27 Mar 2020 23:55:04 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B73A8780C
 for <cocci@systeme.lip6.fr>; Fri, 27 Mar 2020 23:55:02 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:234])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02RMt1Ih006138
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 27 Mar 2020 23:55:01 +0100 (CET)
Received: by mail-oi1-x234.google.com with SMTP id k9so10277059oia.8
 for <cocci@systeme.lip6.fr>; Fri, 27 Mar 2020 15:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PFuMXO1qGu3EZgTzCHRV+sZP7BWe2KprQeaP8PvU2ck=;
 b=Ud2P6+OVfQgp4Uf0Ntvn5oK5TWGlzvolv7JWACeBXvB1FeHLaUtHFw36yaJaK7X9ni
 X6WYhCdEF8yI/BCcjQBXUI+M+crRjx6f3lNwUGbwPxa4HF2KlxBEo7DxySPSdDqlWTMe
 GcnqCzfg3lGJZxWmoclK2AkvNZuHtrF4viFTN0Yw3WjsMN1YimJL+zUR0mIHDuZMFwqt
 d9+MXSF2/0XWuVQSxshZ5614xRr/5unuCX9ekLbBmcyjxMn3/ubZ9Uz6xcawL+sZ0YD/
 4Dzo5df6H7OGLPjsOg/gn/1EF1aEBPOe0y8h8JDBV6mRkq3EHy3UyqvjSIYa1OyqyCxw
 75IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PFuMXO1qGu3EZgTzCHRV+sZP7BWe2KprQeaP8PvU2ck=;
 b=n9HKrRrmcY8bk7SnF9ZDqB1hApPDCHDfmbxT+0Brn5hXCfPTv1cIf5mzf9YRThkuAH
 st+WWBP67boi08bKx4NGuVlf1uRRu6Nj4pL0LhSmGfU0VemKGXNnxxITIyoCZjlRTCxl
 uWHJgKcP5IBeSP5grGG7Xq+wLUhu+QBSDMJh9ZxN1S5SHYRDkhJyO5K0JVA7I+NLeLJd
 I17LaDexJEKeCAKirW9SktSDOpyuqFEWMwf87mbFYWfcI7/KnrEEo1sPfdQ88gddrbpy
 tCWoY5r/J0epv6aXURt3FUvCzSJo6ktpbZz2JRJJoYbv5n/SJB/nRTzPzdeVzcIkU2BK
 0JkA==
X-Gm-Message-State: ANhLgQ1sd8z2TdP+PbriBqSnNafcfX0PbRRK4kN2vYW9F5EXAbAf0TOf
 Q/bb/SXz1c85kIr9pD/YN+HQJO23oeHsIQr8Ig==
X-Google-Smtp-Source: ADFU+vs4WUYvB5Wx8cZ1upN1ncl3XNNU+mw3NqZ4Pvsf2QjWUEtCKh2o/Z4bnciryrgKnyY8cBepb8FDoHodXiCrtJQ=
X-Received: by 2002:aca:cf48:: with SMTP id f69mr818154oig.122.1585349700626; 
 Fri, 27 Mar 2020 15:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAFSKS=NXVUcp1KwpidZoFTfyUCmh+8ij2njaGZ7g6h9LvEiYrA@mail.gmail.com>
 <alpine.DEB.2.21.2003271926000.2709@hadrien>
In-Reply-To: <alpine.DEB.2.21.2003271926000.2709@hadrien>
From: George McCollister <george.mccollister@gmail.com>
Date: Fri, 27 Mar 2020 17:54:48 -0500
Message-ID: <CAFSKS=N24b8rQhjTTBGDRSHdRKRcYe2+4YbGrJn7zKReMaV84Q@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 27 Mar 2020 23:55:04 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 27 Mar 2020 23:55:02 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
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

On Fri, Mar 27, 2020 at 1:37 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Fri, 27 Mar 2020, George McCollister wrote:
>
> > Hello,
> >
> > I'm working with an old code base that makes excessive use of the
> > following sort of construct:
> >
> > char display[128];
> >
> > ...
> >
> > snprintf(display, sizeof(display), "example log message %d", i);
> > log_buffer(level, strlen(display)+1, display);
> >
> > I'd like to replace this mess with a single call to a function named
> > log_formatted(). This involves moving the format string and arguments
> > passed to snprintf into the log_formatted() call, removing snprintf
> > call and (here's where it gets a bit tricky) remove the buffer if it
> > isn't used for anything else.
> >
> > I have this all working with the following script with the caveat that
> > running it on moderately complicated source files makes it never
> > finish (after an hour or so the spatch process crashes with a stack
> > overflow error).
> > I've tried --no-loops which seem to speed things up but complicated
> > source files still result in it never finishing.
> >
> > @r1@
> > type T;
> > identifier disp;
> > expression level;
> > expression list prnt;
> > @@
> >
> > {
> > ... when any
>
> The above is not necessary.  YOu don't have to start the match from a
> block.  You can just start it from the declaration.
>
> On the other hand, the declaration may not be needed either.  After your
> metavariable type T, you can put
>
> local idexpression T[] disp2;
>
> Then the match should be:
>
>   snprintf(disp2@disp, sizeof(disp), prnt);
> ... when != disp
> - log_buffer(level, strlen(disp)+1, disp);
> + log_formatted(level, prnt);
>
> The notation disp2@disp will match both disp2 (idexpression of a
> particular type) and disp (identifier) against the first argument of
> snprintf.  This is needed because 1) you want to give a type, which
> requires and idexpression, and 2) in later rules you want to change a
> variable declaration, which requires an identifier.
>
>
> > (
> > T disp[...];
> > |
> > T disp[...]="";
> > )
> > <+...
> >   snprintf(disp, sizeof(disp), prnt);
> > ... when != disp
> > - log_buffer(level, strlen(disp)+1, disp);
> > + log_formatted(level, prnt);
> > ...+>
> > }
> >
> > // Only remove the display variable and snprintf if there are no
> > // other references to the variable.
> >
> > @r2 depends on r1@
> > type r1.T;
> > identifier r1.disp;
> > expression list r1.prnt;
> > @@
> >
> > {
> > ... when any
> > (
> > - T disp[...];
> > |
> > - T disp[...]="";
> > )
> > <+... when != disp
> > - snprintf(disp, sizeof(disp), prnt);
> > ...+>
> > }
>
> Here you could try considering the problem from the opposite point of
> view.

This was the key to getting it work, thanks!

>
> @r2 exists@ // exists is what helps you drop the complexity, by needing to
> type r1.T;  // find only one matching path
> identifier r1.disp;;
> expression list r1.prnt;
> position p;
> @@
>
> (
> T@p disp[...];
> |
> T@p disp[...]="";
> )
> ...
> snprintf(disp, sizeof(disp), prnt);
>
> @r3@
> position p != r2.p;
> type r1.T;
> identifier r1.disp;;
> @@
>
> (
> - T@p disp[...];
> |
> - T@p disp[...]="";
> )
>
>
> Does it matter that the initial value of disp is ""?  In the proposed
> first rule I have dropped that constraint.
>
> julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
