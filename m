Return-Path: <SRS0=yhX/=IB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03704C433DB
	for <cocci@archiver.kernel.org>; Wed,  3 Mar 2021 17:21:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0700464DF2
	for <cocci@archiver.kernel.org>; Wed,  3 Mar 2021 17:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0700464DF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 123HLYWT015742;
	Wed, 3 Mar 2021 18:21:34 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0C34877CC;
	Wed,  3 Mar 2021 18:21:34 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 03ABC571B
 for <cocci@systeme.lip6.fr>; Wed,  3 Mar 2021 18:21:32 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 123HLUHm025075
 for <cocci@systeme.lip6.fr>; Wed, 3 Mar 2021 18:21:30 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.81,220,1610406000"; d="scan'208";a="495959768"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Mar 2021 18:21:24 +0100
Date: Wed, 3 Mar 2021 18:21:23 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Mansour Moufid <mansourmoufid@gmail.com>
In-Reply-To: <CALogXGVMCiZcMRovK+9gJVKQPDJJdWUuXRPXVZ0fxmAXyq4Uig@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2103031811410.2980@hadrien>
References: <053b06c47f08631675c295b5c893b90be4248347.camel@perches.com>
 <CALogXGVMCiZcMRovK+9gJVKQPDJJdWUuXRPXVZ0fxmAXyq4Uig@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 03 Mar 2021 18:21:34 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 03 Mar 2021 18:21:30 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Joe Perches <joe@perches.com>, cocci <cocci@systeme.lip6.fr>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr



On Wed, 3 Mar 2021, Mansour Moufid wrote:

> On Tue, Mar 2, 2021 at 4:22 PM Joe Perches <joe@perches.com> wrote:
> >
> > Here is a possible opportunity to reduce data usage in the kernel.
> >
> > $ git grep -P -n '^static\s+(?!const|struct)(?:\w+\s+){1,3}\w+\s*\[\s*\]' drivers/ | \
> >   grep -v __initdata | \
> >   wc -l
> > 3250
> >
> > Meaning there are ~3000 declarations of arrays with what appears to be
> > file static const content that are not marked const.
> >
> > So there are many static arrays that could be marked const to move the
> > compiled object code from data to text minimizing the total amount of
> > exposed r/w data.
> >
> > However, I do not know of a mechanism using coccinelle to determine
> > whether or not any of these static declarations are ever modified.
>
> I thought it would be a fun exercise but it got tedious quick.
>
> I don't know how to ignore an attribute like __initdata.
>
> Feel free to refine it:

This adds the consts, but it doesn't check that the array is never
updated, or never stored in a field from which it could get updated.

In my attempt, I tried something like this for the first part:

@r disable optional_qualifier@
type T;
identifier x;
position p != ok.p;
@@

static T x@p[] = { ... };

In principle, this should match cases where there is no const.  But it
dones't work.  It matches some cases with const too.

Then I tried:

@ok@
type T;
identifier x;
position p;
@@

static const T x@p[] = { ... };

@r@
type T;
identifier x;
position p != ok.p;
@@

static T x@p[] = { ... };

The first rule matches the cases with const, and then the second rule
matches all of the cases with the declared variable at a position
different than that of the first rule.  It works if the type T is a simple
type like int, but it doesn't work if it is something more complex, like
struct foo *.

Afterwards, I have the following:

@bad@
position p;
identifier r.x;
expression e,y;
@@

(
 x@p[y] = e
|
 &x@p[y]
)

@good@
identifier r.x;
expression y;
position p != bad.p;
@@

x@p[y]

@notgood@
identifier r.x;
position p != good.p;
@@

x@p

@depends on good && !notgood@
identifier r.x;
type r.T;
@@

static
+const
 T x[] = { ... };

That is,

* rule bad: Give up if we assign an element or take the address of an
element.

* rule good: Things are going well if we access an element of the array.
If there is no access at all, there is something suspicious, perhaps uses
in macros.

* rule notgood: A montion of the array that is not an element access is
not good either

In the end, if we match good and we don't match notgood, then we can make
the change.

I got stuck on the const problem, and didn't try the __initdata issue.
But one could address with a rule like the rule ok above.

The const problem is at least something worth looking into.

julia

>
>
> @@
> type t;
> identifier x;
> @@
> (
>     static const struct { ... } x[];
> |
>     static
> +   const
>     struct { ... } x[];
> |
>     static const struct s *x[];
> |
>     static
> +   const
>     struct s *x[];
> |
>     static const struct s x[];
> |
>     static
> +   const
>     struct s x[];
> |
>     static const t *x[];
> |
>     static
> +   const
>     t *x[];
> |
>     static const t x[];
> |
>     static
> +   const
>     t x[];
> )
>
> @@
> type t;
> identifier s, x, y, z;
> assignment operator xx;
> @@
> (
>     static const struct { ... } x[] = { ... };
> |
>     static
> +   const
>     struct { ... } x[] = { ... };
> |
>     static const struct s *x[] = { ... };
> |
>     static
> +   const
>     struct s *x[] = { ... };
> |
>     static const struct s x[] = { ... };
> |
>     static
> +   const
>     struct s x[] = { ... };
> |
>     static const t *x[] = { ... };
> |
>     static
> +   const
>     t *x[] = { ... };
> |
>     static const t x[] = { ... };
> |
>     static
> +   const
>     t x[] = { ... };
> )
>     ... when != x.y xx ...
>         when != x[...] xx ...
>         when != z = x
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
