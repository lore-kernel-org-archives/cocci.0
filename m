Return-Path: <SRS0=ZWNV=TY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F404C072B5
	for <cocci@archiver.kernel.org>; Fri, 24 May 2019 06:22:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 179B320862
	for <cocci@archiver.kernel.org>; Fri, 24 May 2019 06:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179B320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4O6Manx015397;
	Fri, 24 May 2019 08:22:36 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 82F147752;
	Fri, 24 May 2019 08:22:36 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8E9D27747
 for <cocci@systeme.lip6.fr>; Fri, 24 May 2019 08:22:34 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4O6MYdf015809
 for <cocci@systeme.lip6.fr>; Fri, 24 May 2019 08:22:34 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.60,506,1549926000"; d="scan'208";a="384531966"
Received: from abo-218-110-68.mrs.modulonet.fr (HELO hadrien) ([85.68.110.218])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 May 2019 08:22:33 +0200
Date: Fri, 24 May 2019 08:22:33 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <215d5cf7-b44c-8924-d049-e2a6e579f138@web.de>
Message-ID: <alpine.DEB.2.21.1905240821260.2689@hadrien>
References: <alpine.DEB.2.21.1905222114490.2618@hadrien>
 <81b409c6-5986-5961-5edf-843c6737d88c@web.de>
 <alpine.DEB.2.20.1905231500230.3573@hadrien>
 <3a79c8f5-9483-397a-eb98-adeb40634fe8@web.de>
 <alpine.DEB.2.20.1905231659010.3573@hadrien>
 <215d5cf7-b44c-8924-d049-e2a6e579f138@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 May 2019 08:22:36 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Fri, 24 May 2019 08:22:34 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Checking configuration challenges around OCaml usage
	for SmPL
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



On Fri, 24 May 2019, Markus Elfring wrote:

> > You can do whatever you want in the ocaml code.
>
> How will the following software situation be resolved?

make distclean
./autogen
./configure
make

>
> elfring@Sonne:~/Projekte/Coccinelle/20160205> COCCINELLE_HOME=$(pwd) /usr/local/bin/opam config exec --switch 4.07.1 ./spatch demos/comments.cocci demos/comments.c
> init_defs_builtins: /home/elfring/Projekte/Coccinelle/20160205/standard.h
> Using native version of ocamlc/ocamlopt/ocamldep
> ocamlc.opt -c /tmp/ocaml_cocci_bbc38d.cmo -g -I /home/elfring/Projekte/Coccinelle/20160205/ocaml  -I /usr/lib64/ocaml /tmp/ocaml_cocci_bbc38d.ml
> File "/tmp/ocaml_cocci_bbc38d.ml", line 1:
> Error: /usr/lib64/ocaml/list.cmi
> is not a compiled interface for this version of OCaml.
> It seems to be for an older version of OCaml.
> Fatal error: exception Coccinelle_modules.Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_bbc38d.ml")
>
>
> Can the dependency on the system compiler version be avoided here?

There is no dependency on any particular system compiler version.  You
just seem to have compiled some of your code, then upgraded your ocaml,
then tried to compile the rest.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
