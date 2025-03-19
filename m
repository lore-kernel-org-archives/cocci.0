Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAF3C35FFA
	for <cocci@archiver.kernel.org>; Wed, 19 Mar 2025 23:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=uaWYskoNnFtCFNeMMOVfiaXwLMWiaRyjeMQFL9mIqzU=;
  b=j9jOAJZS3aNGPVMJx8+BHyQOWx1cketvjB6b07cm+YsWVj3KHXVcaRFW
   HQf/FTQ3qQmajFUVN8dkH2PYaJtaooo9FWDM/rIsjtY1/m8L52uQ+C1Yh
   +MixJGFbrSDsHWf4UpYk3NbDs+AjnVKJ1DiQfdPLOROosJ/7jJDNEud2S
   U=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.14,260,1736809200"; 
   d="scan'208";a="213794663"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Mar 2025 00:25:06 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 79ECFE0D1E; Thu, 20 Mar 2025 00:25:05 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 581C5E007A
	for <cocci@sympa.inria.fr>; Thu, 20 Mar 2025 00:25:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uaWYskoNnFtCFNeMMOVfiaXwLMWiaRyjeMQFL9mIqzU=;
  b=B64JbIJwtjVp5igVIU5uEQSYGW4OYF2o7k8I+tZ8m6jFr7kqH0LdDMlj
   HZB+BTXup1slbe9yF9vk96aVQbQW5KROtZmDQfGzOsu/wlzGfSGwO5O/w
   VSM2Gtg99gWIUBavZllw8iviKWJQUZk2JxWwNLY5O6grhzvDggPLXk7NZ
   E=;
X-IronPort-AV: E=Sophos;i="6.14,260,1736809200"; 
   d="scan'208";a="213794658"
Received: from unknown (HELO hadrien) ([217.111.66.206])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 00:25:02 +0100
Date: Thu, 20 Mar 2025 00:25:00 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Kees Cook <kees@kernel.org>
cc: cocci@inria.fr
In-Reply-To: <202503191424.2FA8A7E@keescook>
Message-ID: <1b774129-badf-f889-8d3c-c6492097d3f@inria.fr>
References: <202503180924.2135CF8FD@keescook> <F7BB5789-F9F2-4D17-986A-AD7BC976F18B@inria.fr> <202503182023.D7C4D91@keescook> <8714afb-4938-9beb-9f0-4a4972f4b81@inria.fr> <202503191424.2FA8A7E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] __free() attribute inhibits matching?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2660
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/1b774129-badf-f889-8d3c-c6492097d3f%40inria.fr>



On Wed, 19 Mar 2025, Kees Cook wrote:

> On Wed, Mar 19, 2025 at 08:44:38AM +0100, Julia Lawall wrote:
> > On Tue, 18 Mar 2025, Kees Cook wrote:
> > > On Tue, Mar 18, 2025 at 06:56:40PM +0100, Julia Lawall wrote:
> > > > I think you want
> > > >
> > > > Expression *m;
> > > >
> > > > A->@m b
> > > >
> > > > B would be an identifier
> > >
> > > But how does "B" get correctly type restricted? (Or in my example,
> > > "NAME"?)
> > >
> > > I tried:
> > >
> > > @direct depends on !(file in "tools") && !(file in "samples")@
> > > type TYPE;
> > > TYPE *P;
> > > TYPE *MEMBER;
> > > TYPE INST;
> > > identifier NAME;
> > > expression COMP;
> > > identifier ALLOC =~ "^kv?[mz]alloc";
> > > fresh identifier ALLOC_OBJ = ALLOC ## "_obj";
> > > @@
> > >
> > >        \(\(P\|COMP.@MEMBER NAME\|COMP->@MEMBER NAME\) \& VAR\)
> > > -       = ALLOC((\(sizeof(*VAR)\|sizeof(TYPE)\|sizeof(INST)\)), GFP);
> > > +       = ALLOC_OBJ(*VAR, GFP);
> > >
> > > This parses, but don't match (from crypto/asymmetric_keys/x509_cert_parser.c):
> > >
> > > 	cert->pub = kzalloc(sizeof(struct public_key), GFP_KERNEL);
> > >
> > > But does match (via "P"):
> > >
> > > 	cert = kzalloc(sizeof(struct x509_certificate), GFP_KERNEL);
> >
> > What is the command line, eg --all-includes?  You can try
> > --verbose-includes to see what is happening with #include "x509_parser.h"
>
> Okay, my hiccups continue.
>
> I do not seem to be able to mix a "type" metavariable with anything else.
> For example, instead of these rules repeated:
>
> @direct depends on patch@
> type TYPE;
> TYPE INST;
> identifier PTR;
> expression GFP;
> expression TYPED;
> identifier ALLOC =~ "^kv?[mz]alloc$";
> fresh identifier ALLOC_OBJ = ALLOC ## "_obj";
> @@
>
> (
>         TYPE *PTR
> -       = ALLOC((sizeof(*PTR)), GFP);
> +       = ALLOC_OBJ(*PTR, GFP);
> |
>         TYPE *PTR
> -       = ALLOC((sizeof(INST)), GFP);
> +       = ALLOC_OBJ(INST, GFP);
> |
>         TYPE *PTR
> -       = ALLOC((sizeof(TYPE)), GFP);
> +       = ALLOC_OBJ(TYPE, GFP);
> )
>
> I wanted to write it as:
>
>         TYPE *PTR
> -       = ALLOC((sizeof(\(\(*PTR\|INST\|TYPE\) \& TYPED\))), GFP);
> +       = ALLOC_OBJ(TYPED, GFP);
>
> But this doesn't let me even put "TYPE" in the \( \) at all, much less
> put it into the TYPED expression:
>
> minus: parse error:
>   File "scripts/coccinelle/api/kmalloc_objs.cocci", line 55, column 34, charpos = 1235
>   around = 'TYPE',
>   whole content = -     = ALLOC((sizeof(\(\(*PTR\|INST\|TYPE\) \& TYPED\))), GFP);
>
> How do I collapse these three into 1 rule?

A disjunction has to have the same kind of thing in every branch.  INST is
an expression but TYPE is a type, so that doesn't work.  sizeof is
misleading.  There are actually two different sizeof's, one where the
argument is an expression and one where the argument is a type.  One
requires () around the argument while the other does not.

You can just make a () with three copies of sizeof, or even two copies of
sizeof, on for TYPE and one for a disjunction of the other possibilities.

julia
