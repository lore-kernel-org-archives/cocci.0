Return-Path: <SRS0=TkRd=G6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3218C433E0
	for <cocci@archiver.kernel.org>; Wed, 27 Jan 2021 20:35:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FF7761488
	for <cocci@archiver.kernel.org>; Wed, 27 Jan 2021 20:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF7761488
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 10RKZ95A008052;
	Wed, 27 Jan 2021 21:35:09 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C8C51754C;
	Wed, 27 Jan 2021 21:35:09 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 06DA4389B
 for <cocci@systeme.lip6.fr>; Wed, 27 Jan 2021 21:35:09 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 10RKZ88G014205
 for <cocci@systeme.lip6.fr>; Wed, 27 Jan 2021 21:35:08 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.79,380,1602540000"; d="scan'208";a="371320931"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jan 2021 21:35:08 +0100
Date: Wed, 27 Jan 2021 21:35:07 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: "James K. Lowden" <jklowden@schemamania.org>
In-Reply-To: <20210127152325.5692b2e6eb7b8ed82d91262b@schemamania.org>
Message-ID: <alpine.DEB.2.22.394.2101272128510.3768@hadrien>
References: <20210127152325.5692b2e6eb7b8ed82d91262b@schemamania.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 27 Jan 2021 21:35:10 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 27 Jan 2021 21:35:08 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] qualified function rule
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



On Wed, 27 Jan 2021, James K. Lowden wrote:

> I don't understand how, if it's possible, to qualify a function in a
> rule.  I want the class of all functions having a parameter of a
> particular type.
>
> The code I'm working with has hundreds of unnecessary casts.  Many
> functions take a void* parameter, but are nonetheless called by casting
> the parameter.  For example, the parameters to memcpy(3) often
> have casts applied.
>
> I imagine writing a rule like
>
> @@
> type T, D;
> identifier F(void*);
> identifier D * data;
> @@
>
> - F((T*)data)
> + F(data)
>
> but that doesn't work, and I haven't found anything that does.
>
> In the kmalloc examples, I see things like
>
> - \(kmalloc|kcmalloc\)(...)
> + mumble something
>
> but that forces me to enumerate all such function names. It seems
> vaguely like positions would do the trick, but, well, vaguely.
>
> Is there a way?

In principle, you should be able to specify the type of F. But I'm not at
all sure that that is supported for function names.

Maybe it would suffice to do:

@fn@
identifier F,i;
parameter list[n] ps;
@@

F(ps,void *i,...) { ... }

@@
identifier fn.F;
expression list[fn.n] es;
type T;
expression *e;
@@

F(es,
- (T*)
  e, ...)

@ty@
identifier F,i;
parameter list[n] ps;
type t;
@@

t F(ps,void *i,...);

@@
identifier ty.F;
expression list[ty.n] es;
type T;
expression *e;
@@

F(es,
- (T*)
  e, ...)

Probably your function prototypes are not in the .c files, but rather in
things that they include.  So you would want to use an argument like
--all-includes (include locally mentioned header) or --recursive-includes
(include headers included in other headers).  You may want to give some -I
dir arguments to help it find the header files.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
