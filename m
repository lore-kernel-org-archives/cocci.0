Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03843C61DA4
	for <cocci@archiver.kernel.org>; Mon, 13 Mar 2023 21:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ztxOko0zcxycz6ZSbAKvj0jfMt9lILPV2SVFFQxMV9s=;
  b=OhTCJLYHKIPiCujlHtoD/8UCJEbdtvfFiU5eH4AIaQ/d4U0I9LnzD7Qb
   kiEX7m8X6aC81e8b2oyv9lLXK8m18egL2ULGWHBP2sN90cgDh+ei7aJJU
   iY4hEiGqHMd3IH9ceyRm89R7W2HEFv071j2Cbi1WS1FpBah0CEJz4HiDQ
   A=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.98,257,1673910000"; 
   d="scan'208";a="96964199"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2023 22:09:39 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 12038E02CA; Mon, 13 Mar 2023 22:09:40 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9984AE0010
	for <cocci@sympa.inria.fr>; Mon, 13 Mar 2023 22:09:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ztxOko0zcxycz6ZSbAKvj0jfMt9lILPV2SVFFQxMV9s=;
  b=Rq9DCQrBeLQzEWx/djfpM16AoP0kqD5oxMTCjBNgu6xv+GYMzhTMrVH9
   TCaKOftaA9gGYo6y4Qbod6HyNxXBBNMUUiVLsFOpvgBC61lhu39qi7y4s
   M3Av+KCATT7g3Gh6ZjE/UJl8lF9xwTbmkkZhJ0lNNZqWCSU7O7TkhZEvb
   c=;
X-IronPort-AV: E=Sophos;i="5.98,257,1673910000"; 
   d="scan'208";a="96964195"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 22:09:37 +0100
Date: Mon, 13 Mar 2023 22:09:37 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
In-Reply-To: <20230313203847.33c9ff24@nbbrfq>
Message-ID: <alpine.DEB.2.22.394.2303132208060.3007@hadrien>
References: <20230309092812.71b25d5c@nbbrfq> <89959f1e-b5ed-6b2c-2931-4fdd65428e89@inria.fr> <ad666bb2-3f4-47a2-13fd-8f7e29b8af79@inria.fr> <20230310110135.66cbd31b@nbbrfq> <145e5e3e-1ce3-819f-a271-5c8b8a273a53@inria.fr> <20230313203847.33c9ff24@nbbrfq>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] HELP: multiple inserts at one position
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 889
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/alpine.DEB.2.22.394.2303132208060.3007%40hadrien>



On Mon, 13 Mar 2023, Bernhard Reutner-Fischer wrote:

> On Fri, 10 Mar 2023 11:12:27 +0100 (CET)
> Julia Lawall <julia.lawall@inria.fr> wrote:
>
> > On Fri, 10 Mar 2023, Bernhard Reutner-Fischer wrote:
> >
> > > On Thu, 9 Mar 2023 09:47:17 +0100 (CET)
> > > Julia Lawall <julia.lawall@inria.fr> wrote:
> > >
> > > > On Thu, 9 Mar 2023, Julia Lawall wrote:
> > > > > On Thu, 9 Mar 2023, Bernhard Reutner-Fischer wrote:
> > > []
> > > > Another issue is that your semantic patch could be more efficient.  You
> > > > have the declaration
> > > >
> > > > type mpz_t;
> > > >
> > > > I think you meant:
> > > >
> > > > typedef mpz_t;
> > > >
> > > > Then the only goal of the pattern
> > > >
> > > > mpz_t i;
> > > > ...
> > > >
> > > > seems to be to ensure the type of i.  This can be done in the metavariable
> > > > declaration:
> > > >
> > > > local idexpression mpz_t i
> > > >
> > > > and then in the second rule, it would be:
> > > >
> > > > local idexpression mpz_t mpz_0_find.i;
> > > >
> > > > In this way, you will not be matching from the top of the function, but
> > > > rather only from the relevant call to the return.
> > >
> > > mhm. But if there is no return statement whatsoever in that scope?
> > >
> > > Consider:
> > > int myround (double dbl)
> > > {
> > >   int ret = 0;
> > >   // mpfr_t outer; mpfr_init (outer);
> > >   if (global_var)
> > >     {
> > >       unsigned long ul;
> > >       mpfr_t i;
> > >       mpfr_init (i);
> > >       mpfr_frac (i, dbl, MPFR_RNDZ);
> > >       if (mpfr_cmp_si (i, 0) != 0)
> > >         {
> > > 	  ret = 42;
> > > 	  moan ("round");
> > > 	}
> > >       /* mpfr_clear (i); missing here */
> > >     }
> > >   // mpfr_clear (outer) insertion works, there is a return stmt.
> > >   // probably breaks in a void function like in the scope above..
> > >   // There is no 'i' to clear _here_, of course!
> > >   return ret;
> > > }
> > > EOF
> > >
> > > If i'd understand a local idexpression 'i' to have a scope, i would have
> > > hoped to somehow get at the position of i at end of scope?
> > > But i think i need to match either a return or end-of-block, so i can
> > > insert the mpfr_clear properly in either case. Somehow.
> >
> > OK, there are some hacks to deal with the issue at the end of the
> > function, but not in the case of an arbitrary scope.
> >
> > Typically missing frees affect if branches, so the problem doesn't arise,
> > but if you want the whole scope, it seems that you would need the {}.
>
> So IIUC i would need to attach a position to the closing curly brace
> '}'.
> But how would i do that? I tried:

I would suggest ot have one set of rules that takes care of the cases
where the return is explicit in the code.  Then you can have a rule like
the following one, that just takes care of the final trailing return case
(bcause youhave already taken care of the explicit returns cases):

@exists@
typedef mpfr_t;
identifier i, f;
@@

void f(...) {
 ... when any
 mpfr_t i;
...
 mpfr_init (i)
 ... when != mpfr_clear (i)
++mpfr_clear (i);
}

julia





>
> /// mpfr ///////////////////////////////////////////////////////////////
>
> @ mpfr_0_find exists @
> type mpfr_t;
> identifier i;
> position ret_pos, e_pos, s_pos;
> expression E0, E1;
> statement s0;
> @@
> {...
> mpfr_t i;...
> // rejected: <...{...>
> ( mpfr_init_set_str (i, ...)
> | mpfr_init (i)
> | mpfr_init2 (i, ...)
> | mpfr_init3 (i, ...)
> )
> <+... when != mpfr_clear (i)
>     when != mpfr_clears (...,i,...)
> ( return \(<+...i...+>\);
> | return@ret_pos ...;
> //rejected: | }@e_pos
> )
> ...+>
> //rejected: <...}...>
> // the below does not seem to work for me (2)
> }@e_pos
>
> @ mpfr_0_replace @
> identifier mpfr_0_find.i;
> expression mpfr_0_find.E0;
> statement mpfr_0_find.s0;
> position mpfr_0_find.ret_pos;
> position mpfr_0_find.e_pos;
> position mpfr_0_find.s_pos;
> @@
> (
> ++ mpfr_clear (i) /* ret */;
> ? return@ret_pos ...;
> |
> ++ mpfr_clear (i) /* E0 */;
> // below an attempt to reference e_pos as per (2) above:
> //assertion failed:  e_pos;
> //rejected:  @e_pos
> //rejected, no semicolon?:  E0@e_pos
> //rejected: no semicolon?:? E0@e_pos
> //the below does not work, E0 was not set
>  E0@e_pos;
> |
> ++ mpfr_clear (i) /* s0 */;
>   s0@s_pos;
> )
>
