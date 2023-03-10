Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFA9C64EC4
	for <cocci@archiver.kernel.org>; Fri, 10 Mar 2023 10:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=hwsD4eIOdWNm6R0k91qsQN+eLrhaO1bFhNExnj3sAHc=;
  b=WIsy/GbVhUDNZ9WDGSpzSe2imenR1+D3GZq2641gqnejlRf5RpjuYzzQ
   +XKrQzK8HblvN3rtc1CLrDr/nA1ndf8Ge3su5BKOpCQZo+mUASE/Yg5qh
   Yb3+ssOb38gBwoTXidE3Z0pyg12z6gVpvdNiyA2bHH1MrmxeaqywB3GMo
   k=;
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
X-IronPort-AV: E=Sophos;i="5.98,249,1673910000"; 
   d="scan'208";a="96479908"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2023 11:12:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EE558E00DA; Fri, 10 Mar 2023 11:12:34 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E528BE0010
	for <cocci@sympa.inria.fr>; Fri, 10 Mar 2023 11:12:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hwsD4eIOdWNm6R0k91qsQN+eLrhaO1bFhNExnj3sAHc=;
  b=UbCu1NGbOgsduDdt1zEW1BFw5yxu5gMgNcMU32LA6yfRt4F5oQsDjlhg
   nDc8vpIhUm+bEduW5pLJ+BJzvtjZVoMroaWqaR9J/LFfotFUSXad8Ikm0
   X3A2b6Iz1RrhIl+IOD7+Mbrz2dmyNrdu427jl3hN1HtBmP+gnTi2wExtg
   A=;
X-IronPort-AV: E=Sophos;i="5.98,249,1673910000"; 
   d="scan'208";a="49783170"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 11:12:28 +0100
Date: Fri, 10 Mar 2023 11:12:27 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <20230310110135.66cbd31b@nbbrfq>
Message-ID: <145e5e3e-1ce3-819f-a271-5c8b8a273a53@inria.fr>
References: <20230309092812.71b25d5c@nbbrfq> <89959f1e-b5ed-6b2c-2931-4fdd65428e89@inria.fr> <ad666bb2-3f4-47a2-13fd-8f7e29b8af79@inria.fr> <20230310110135.66cbd31b@nbbrfq>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] HELP: multiple inserts at one position
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 887
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/145e5e3e-1ce3-819f-a271-5c8b8a273a53%40inria.fr>



On Fri, 10 Mar 2023, Bernhard Reutner-Fischer wrote:

> On Thu, 9 Mar 2023 09:47:17 +0100 (CET)
> Julia Lawall <julia.lawall@inria.fr> wrote:
>
> > On Thu, 9 Mar 2023, Julia Lawall wrote:
> > > On Thu, 9 Mar 2023, Bernhard Reutner-Fischer wrote:
> []
> > Another issue is that your semantic patch could be more efficient.  You
> > have the declaration
> >
> > type mpz_t;
> >
> > I think you meant:
> >
> > typedef mpz_t;
> >
> > Then the only goal of the pattern
> >
> > mpz_t i;
> > ...
> >
> > seems to be to ensure the type of i.  This can be done in the metavariable
> > declaration:
> >
> > local idexpression mpz_t i
> >
> > and then in the second rule, it would be:
> >
> > local idexpression mpz_t mpz_0_find.i;
> >
> > In this way, you will not be matching from the top of the function, but
> > rather only from the relevant call to the return.
>
> mhm. But if there is no return statement whatsoever in that scope?
>
> Consider:
> int myround (double dbl)
> {
>   int ret = 0;
>   // mpfr_t outer; mpfr_init (outer);
>   if (global_var)
>     {
>       unsigned long ul;
>       mpfr_t i;
>       mpfr_init (i);
>       mpfr_frac (i, dbl, MPFR_RNDZ);
>       if (mpfr_cmp_si (i, 0) != 0)
>         {
> 	  ret = 42;
> 	  moan ("round");
> 	}
>       /* mpfr_clear (i); missing here */
>     }
>   // mpfr_clear (outer) insertion works, there is a return stmt.
>   // probably breaks in a void function like in the scope above..
>   // There is no 'i' to clear _here_, of course!
>   return ret;
> }
> EOF
>
> If i'd understand a local idexpression 'i' to have a scope, i would have
> hoped to somehow get at the position of i at end of scope?
> But i think i need to match either a return or end-of-block, so i can
> insert the mpfr_clear properly in either case. Somehow.

OK, there are some hacks to deal with the issue at the end of the
function, but not in the case of an arbitrary scope.

Typically missing frees affect if branches, so the problem doesn't arise,
but if you want the whole scope, it seems that you would need the {}.

julia
