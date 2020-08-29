Return-Path: <SRS0=mjN0=CH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFDAC433E2
	for <cocci@archiver.kernel.org>; Sat, 29 Aug 2020 13:10:16 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03DF22076D
	for <cocci@archiver.kernel.org>; Sat, 29 Aug 2020 13:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DF22076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07TDA1in005954;
	Sat, 29 Aug 2020 15:10:01 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 171EF777D;
	Sat, 29 Aug 2020 15:10:01 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4A8FD3F6C
 for <cocci@systeme.lip6.fr>; Sat, 29 Aug 2020 15:09:59 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07TD9wM6001041
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 29 Aug 2020 15:09:58 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; d="scan'208";a="357585620"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Aug 2020 15:09:57 +0200
Date: Sat, 29 Aug 2020 15:09:57 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b131add2-f494-d129-f83f-ef2c6de7a849@web.de>
Message-ID: <alpine.DEB.2.22.394.2008291507400.3629@hadrien>
References: <b131add2-f494-d129-f83f-ef2c6de7a849@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 29 Aug 2020 15:10:01 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 29 Aug 2020 15:09:58 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>, Kees Cook <keescook@chromium.org>,
        Gilles Muller <Gilles.Muller@lip6.fr>, kernel-janitors@vger.kernel.org,
        Nicolas Palix <nicolas.palix@imag.fr>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [RFC PATCH] coccinelle: api: add flex_array_size.cocci
 script
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



On Sat, 29 Aug 2020, Markus Elfring wrote:

> > Suggest flex_array_size() wrapper to compute the size of a
> > flexible array member in a structure. The macro additionally
> > checks for integer overflows.
>
> Can the following script variant for the semantic patch language help
> to clarify any software development ideas and remaining open issues?

A patch proposal needs to say what it is doing and why.  You haven't
provided either information.

What changes have you made as compared to the original proposal, and why
have you made them?  Removing newlines and adding spaces, as done in
decl_flex, is not something I am interested in.

julia

>
>
> virtual context, patch, report, org
>
> @decl_flex@
> identifier name, array, size;
> type TA, TS;
> @@
>  struct name {
>  ...
>  TS size;
>  ...
> (TA array[];
> |TA array[ \( 0 \| 1 \) ];
> )
>  };
>
> @ptr_flex@
> identifier decl_flex.name, instance;
> @@
>  struct name *instance;
>
> @struct_flex@
> identifier decl_flex.name, instance;
> @@
>  struct name instance;
>
> @ptr_flex_size depends on !patch@
> identifier decl_flex.array, decl_flex.size, ptr_flex.instance;
> type decl_flex.TA;
> position p;
> @@
> *instance->size *@p \( sizeof(TA) \| sizeof(*instance->array) \)
>
> @depends on patch exists@
> identifier decl_flex.array, decl_flex.size, ptr_flex.instance;
> type decl_flex.TA;
> @@
> (
> -sizeof(TA)
> |
> -sizeof(*instance->array)
> )
> - *
> +flex_array_size(instance, array,
>  instance->size
> +)
>
> @struct_flex_size depends on !patch@
> identifier decl_flex.array, decl_flex.size, struct_flex.instance;
> type decl_flex.TA;
> position p;
> @@
> *instance->size *@p \( sizeof(TA) \| sizeof(*instance->array) \)
>
> @depends on patch exists@
> identifier decl_flex.array, decl_flex.size, struct_flex.instance;
> type decl_flex.TA;
> @@
> (
> -sizeof(TA)
> |
> -sizeof(*instance->array)
> )
> - *
> +flex_array_size(instance, array,
>  instance->size
> +)
>
> @func_arg_flex_size depends on !patch@
> identifier decl_flex.name, decl_flex.array, decl_flex.size, func, instance;
> type decl_flex.TA;
> position p;
> @@
>  func(..., struct name *instance, ...) {
>  ... when any
> *instance->size *@p \( sizeof(TA) \| sizeof(*instance->array) \)
>  ...
>  }
>
> @depends on patch exists@
> identifier decl_flex.name, decl_flex.array, decl_flex.size, func, instance;
> type decl_flex.TA;
> @@
>  func(..., struct name *instance, ...) {
>  ... when any
> (
> -sizeof(TA)
> |
> -sizeof(*instance->array)
> )
> - *
> +flex_array_size(instance, array,
>  instance->size
> +)
>  ...
>  }
>
> @script:python depends on report@
> p << ptr_flex_size.p;
> @@
> coccilib.report.print_report(p[0], "WARNING opportunity for flex_array_size")
>
> @script:python depends on org@
> p << ptr_flex_size.p;
> @@
> coccilib.org.print_todo(p[0], "WARNING opportunity for flex_array_size")
>
> @script:python depends on report@
> p << struct_flex_size.p;
> @@
> coccilib.report.print_report(p[0], "WARNING opportunity for flex_array_size")
>
> @script:python depends on org@
> p << struct_flex_size.p;
> @@
> coccilib.org.print_todo(p[0], "WARNING opportunity for flex_array_size")
>
> @script:python depends on report@
> p << func_arg_flex_size.p;
> @@
> coccilib.report.print_report(p[0], "WARNING opportunity for flex_array_size")
>
> @script:python depends on org@
> p << func_arg_flex_size.p;
> @@
> coccilib.org.print_todo(p[0], "WARNING opportunity for flex_array_size")
>
>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
