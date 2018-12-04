Return-Path: <SRS0=Y1Te=ON=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AD4C04EB8
	for <cocci@archiver.kernel.org>; Tue,  4 Dec 2018 22:03:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB1AB20672
	for <cocci@archiver.kernel.org>; Tue,  4 Dec 2018 22:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2Ci+dmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1AB20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB4M2qUF002232
          ; Tue, 4 Dec 2018 23:02:53 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D3F5E76D4;
	Tue,  4 Dec 2018 23:02:52 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 44BA175E8
 for <cocci@systeme.lip6.fr>; Tue,  4 Dec 2018 23:02:51 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB4M2nkx023445
 for <cocci@systeme.lip6.fr>; Tue, 4 Dec 2018 23:02:50 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E893420672
 for <cocci@systeme.lip6.fr>; Tue,  4 Dec 2018 22:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543960969;
 bh=XbgANHkucaNoCFq7kDgXiYCG6bUInTujgEd1yX+lWx0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=e2Ci+dmPlBJ7cgeKicGAufqOxf+r0Fm0tR6/cyx+X+5cJVEfXAWBhWS5W+lrKMQtR
 eUHzZelIFcyQyqHu0ZhRN9RfsCZNRk/kI+n9QqyuemOLnpqiHklALDpYSSNdF1R+oQ
 teI/Wayzvfosv3Hg1YInaKT6N/tFUfoNvNZfG9zY=
Received: by mail-oi1-f173.google.com with SMTP id x23so15730964oix.3
 for <cocci@systeme.lip6.fr>; Tue, 04 Dec 2018 14:02:48 -0800 (PST)
X-Gm-Message-State: AA+aEWa47L5iaORnQiAJbkxtNS8Xq7Dfm28Blr6v3UGn88ze1zer+g/1
 hjnIYOOoOm8/SaBqQFn7L6yvC2D1qFi+x4OE8qA=
X-Google-Smtp-Source: AFSGD/W/O5TAqWTZtLQJ6iKIusZ0edOWTEJv7eHZK97TiJVnSf8GlYS14X/Z4mIfiab4FRObfWFZKEhDMgkwxPLozQ8=
X-Received: by 2002:aca:3f42:: with SMTP id m63mr5087522oia.270.1543960968236; 
 Tue, 04 Dec 2018 14:02:48 -0800 (PST)
MIME-Version: 1.0
References: <CAOZdJXVLMv-5_u1uOq6re+1O3vADsrTK0+J3Fat-XN4_2DEp4w@mail.gmail.com>
 <alpine.DEB.2.21.1811151327420.2372@hadrien>
 <CAOZdJXWD0L4Qwh2raJLF25Ax0=DR06vhfGWhpQVf804YQJ5jeA@mail.gmail.com>
 <alpine.DEB.2.21.1812042124260.2383@hadrien>
In-Reply-To: <alpine.DEB.2.21.1812042124260.2383@hadrien>
From: Timur Tabi <timur@kernel.org>
Date: Tue, 4 Dec 2018 16:02:11 -0600
X-Gmail-Original-Message-ID: <CAOZdJXXMTrXXEKta-M0uYq3EpjVaSz2++OT1GOB5HYmx5h_TgA@mail.gmail.com>
Message-ID: <CAOZdJXXMTrXXEKta-M0uYq3EpjVaSz2++OT1GOB5HYmx5h_TgA@mail.gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 04 Dec 2018 23:02:53 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 04 Dec 2018 23:02:50 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>, Timur Tabi <timur@kernel.org>
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

On Tue, Dec 4, 2018 at 2:25 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
>
> On Tue, 4 Dec 2018, Timur Tabi wrote:
>
> > On Thu, Nov 15, 2018 at 3:29 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
> >
> > > The name of the current function at a given match is available in a
> > > position variable bound as part of that match.  A position variable should
> > > have a current_element field.
> >
> > Unfortunately, I don't understand what you're saying.  I see some
> > examples referencing the "position" in a Python script, but they don't
> > make any sense to me, e.g.
> >
> > http://coccinelle.lip6.fr/docs/main_grammar016.html#sec27
> >
> > The example shows:
> >
> > @ r exists @
> > local idexpression struct device_node *n;
> > position p1, p2;
> > statement S1,S2;
> > expression E,E1;
> >
> > I assume when you say "position parameter", you're talking about the
> > "position p1, p2;" above.  If so, I'm completely confused.
>
> In the example, p1 will store the position of n.  In the python rule, you
> can then access p1[0].current_element to get the name of the function in
> which n occurs.

What do you mean by "position of n"?

I managed to figure it out without using positional parameters.  It
almost works in that it only does the replacement once:

// Look for NV_PRINTF2 calls that have the function name in the string
@r4 depends on rules@
identifier func;
expression x;
constant char[] c;
@@
func(...) {
...
NV_PRINTF2(x, c, ...)
...
}

// Get rid of the function name at the beginning of the string
@script:python s4@
c << r4.c;
c2;
f << r4.func;
@@
import re
coccinelle.c2 = re.sub('"%s[: ]*' % f, '"', c, 1)

@depends on rules@
expression x;
constant char[] r4.c;
identifier s4.c2;
@@
NV_PRINTF2(x,
-c
+c2
,...);

Based on what I've read, I need to add < > in order for spatch to run
the rule multiple times within a function.  But if I change r4 to
this:

@r4 depends on rules@
identifier func;
expression x;
constant char[] c;
@@
func(...) {
<...
NV_PRINTF2(x, c, ...)
...>
}

It doesn't work at all.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
