Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03448C61DA4
	for <cocci@archiver.kernel.org>; Thu,  9 Mar 2023 08:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:content-id:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=EdO3Hqq5IjC510rD2+Qtpds/HpXYKBxLxvE4oHgw8OQ=;
  b=r8xvE7IvaZPUNwEP00YIBEuFoEH8e5xjZoPFYlgbkF6Xcg8P/5RECHJ5
   4SzvAGdFS3k0H8CKLRqJ8Q76jZIRAEQCWgEscJMOFFBTRMD+IQYlX3Oj9
   Ki+xScBus4ELViHPvTv4yNJWZuM3U0nvg+l9PatLdixnMQtL7cY55fGDt
   g=;
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
X-IronPort-AV: E=Sophos;i="5.98,245,1673910000"; 
   d="scan'208";a="96224037"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2023 09:47:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 02E54E027F; Thu,  9 Mar 2023 09:47:21 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 095BCE00BE
	for <cocci@sympa.inria.fr>; Thu,  9 Mar 2023 09:47:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=EdO3Hqq5IjC510rD2+Qtpds/HpXYKBxLxvE4oHgw8OQ=;
  b=AnUL4R28uaRXHJ0ZQJIoq13Fm9KaUu/pjxFCVO23VrT4DsA6mttbnKeR
   DX3O6ujmVg3/k24SoS0Bx3f9YuU9aU+JyMaVUaOXpl4tBha2G4zBHdRuj
   mjbof8B8VOKgphWxVKZsytlskoetAAWIVG5/aHTut5fnyYDY+9eY+HTMZ
   w=;
X-IronPort-AV: E=Sophos;i="5.98,245,1673910000"; 
   d="scan'208";a="49650791"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 09:47:18 +0100
Date: Thu, 9 Mar 2023 09:47:17 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <89959f1e-b5ed-6b2c-2931-4fdd65428e89@inria.fr>
Message-ID: <ad666bb2-3f4-47a2-13fd-8f7e29b8af79@inria.fr>
References: <20230309092812.71b25d5c@nbbrfq> <89959f1e-b5ed-6b2c-2931-4fdd65428e89@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1199699491-1678351417=:3662"
Content-ID: <e323552-b7b-b072-e662-75dba917eea6@lip6.fr>
Subject: Re: [cocci] HELP: multiple inserts at one position
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 881
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/ad666bb2-3f4-47a2-13fd-8f7e29b8af79%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1199699491-1678351417=:3662
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <a66cd05f-1b49-f430-418-cd334e3d5231@lip6.fr>



On Thu, 9 Mar 2023, Julia Lawall wrote:

>
>
> On Thu, 9 Mar 2023, Bernhard Reutner-Fischer wrote:
>
> > Hi!
> >
> > I'm trying to follow Julias advise in
> > https://www.mail-archive.com/cocci@systeme.lip6.fr/msg06465.html
> > ---8<---
> > > >   Unfortunately, I stumble on the error message “replacement: already
> > > > tagged token:
> > > >   C code context” then.
> >
> > This is what I would expect.  You could use one rule with an exists to put
> > a position variable in the place where you want to put a kfree, and then
> > use another rule to put a kfree at that position.
> > ---8<---
>
> Use ++ instead of +.  Then you can add multiple things in one place.
> There is no guarantee on the order in which they will appear.

Another issue is that your semantic patch could be more efficient.  You
have the declaration

type mpz_t;

I think you meant:

typedef mpz_t;

Then the only goal of the pattern

mpz_t i;
...

seems to be to ensure the type of i.  This can be done in the metavariable
declaration:

local idexpression mpz_t i

and then in the second rule, it would be:

local idexpression mpz_t mpz_0_find.i;

In this way, you will not be matching from the top of the function, but
rather only from the relevant call to the return.

julia


>
> julia
>
> >
> > I'm attaching my sample inp.c and my attempt at the script and would be
> > glad if you could give some guidance how to properly phrase the
> > replacement rule.
> >
> > In effect, i want to insert *multiple* hunks, each hunk before the
> > respective single return statement.
> >
> > TIA for your help or any pointers and cheers,
> >
> > PS:
> > In case it matters, i'm using the debian package which is
> >   spatch version 1.1.1 compiled with OCaml version 4.13.1
> >
> > The two attached scripts are identical, just
> >   sed -i -e s/mpz/mpfr/g
> > If i patch the mpfr part of inp.c, then all works like i would
> > envision, since there is just a single replacement to be done:
> >
> > $ spatch --sp-file ~/mpfr_free.0.cocci /tmp/inp.cc;echo EOF
> > init_defs_builtins: /usr/lib/coccinelle/standard.h
> > HANDLING: /tmp/inp.cc
> > diff =
> > --- /tmp/inp.cc
> > +++ /tmp/cocci-output-1395250-146bec-inp.cc
> > @@ -34,9 +34,11 @@ CompileExpr::compile_float_literal (cons
> >        rust_error_at (expr.get_locus (),
> >  		     "decimal overflows the respective type %<%s%>",
> >  		     tyty->get_name ().c_str ());
> > +      mpfr_clear(fval);
> >        return error_mark_node;
> >      }
> >
> > +  mpfr_clear(fval);
> >    return real_value;
> >  }
> >
> > EOF
> >
> > But when attempting to insert multiple "free()" for a handful of
> > identifiers in the mpz case, then:
> > $ spatch --sp-file ~/mpz_free.0.cocci /tmp/inp.cc ; echo EOF
> > init_defs_builtins: /usr/lib/coccinelle/standard.h
> > HANDLING: /tmp/inp.cc
> >
> > previous modification:
> >
> >   <<< mpz_clear(i);
> > CONTEXT
> >
> > According to environment 4:
> >    mpz_0_find.i -> id ival
> >
> >    mpz_0_find.ret_pos -> poss[(/tmp/inp.cc,CompileExpr::compile_integer_literal,((44,0),(80,1)),(71,6),(71,12))]
> >
> >    mpz_0_find.i -> id ival
> >
> >    mpz_0_find.ret_pos -> poss[(/tmp/inp.cc,CompileExpr::compile_integer_literal,((44,0),(80,1)),(71,6),(71,12))]
> >
> >
> > current modification:
> >
> >   <<< mpz_clear(i);
> > CONTEXT
> >
> > According to environment 4:
> >    mpz_0_find.i -> id type_max
> >
> >    mpz_0_find.ret_pos -> poss[(/tmp/inp.cc,CompileExpr::compile_integer_literal,((44,0),(80,1)),(71,6),(71,12))]
> >
> >    mpz_0_find.i -> id type_max
> >
> >    mpz_0_find.ret_pos -> poss[(/tmp/inp.cc,CompileExpr::compile_integer_literal,((44,0),(80,1)),(71,6),(71,12))]
> >
> >
> > mpz_0_replace: already tagged token:
> > C code context
> > File "/tmp/inp.cc", line 71, column 6, charpos = 1993
> >   around = 'return',
> >   whole content =       return error_mark_node;
> > EOF
> >
> > Isn't this OK nevertheless?
> >
--8323329-1199699491-1678351417=:3662--
