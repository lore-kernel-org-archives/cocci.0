Return-Path: <SRS0=Rern=IA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D3DC433E0
	for <cocci@archiver.kernel.org>; Tue,  2 Mar 2021 11:59:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3CA264FC7
	for <cocci@archiver.kernel.org>; Tue,  2 Mar 2021 11:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CA264FC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 122BxIGV005429;
	Tue, 2 Mar 2021 12:59:18 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6C27C77CC;
	Tue,  2 Mar 2021 12:59:18 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BBBBB5DC3
 for <cocci@systeme.lip6.fr>; Tue,  2 Mar 2021 12:59:16 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 122BxG31018627
 for <cocci@systeme.lip6.fr>; Tue, 2 Mar 2021 12:59:16 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.81,216,1610406000"; d="scan'208";a="374514781"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 12:59:15 +0100
Date: Tue, 2 Mar 2021 12:59:15 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: "Richard W.M. Jones" <rjones@redhat.com>
In-Reply-To: <20210302114208.GA1818@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2103021258130.2906@hadrien>
References: <20210302114208.GA1818@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 02 Mar 2021 12:59:18 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 02 Mar 2021 12:59:16 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] A few build failures with OCaml 4.12.0
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



On Tue, 2 Mar 2021, Richard W.M. Jones wrote:

> ocamlfind ocamlopt -c -package result -package seq -bin-annot -no-alias-deps -I . -alert -deprecated stdcompat__arg_s.mli -o stdcompat__arg_s.cmi
> File "stdcompat__arg_s.mli", lines 3-17, characters 0-38:
>  3 | type spec = Arg.spec =
>  4 |   | Unit of (unit -> unit)
>  5 |   | Bool of (bool -> unit)
>  6 |   | Set of bool ref
>  7 |   | Clear of bool ref
> ...
> 14 |   | Tuple of spec list
> 15 |   | Symbol of string list * (string -> unit)
> 16 |   | Rest of (string -> unit)
> 17 |   | Expand of (string -> string array).
> Error: This variant or record definition does not match that of type Arg.spec
>        Constructors number 14 have different names, Rest_all and Expand.
>
> There is a new Rest_all constructor:
>
> https://github.com/ocaml/ocaml/blob/500d8dc8296d09305b5413f140c63ffee1de111d/stdlib/arg.mli#L92
>
> ----------------------------------------------------------------------
>
> ocamlfind ocamlopt -c -package result -package seq -bin-annot -no-alias-deps -I . -alert -deprecated stdcompat__spacetime_s.mli -o stdcompat__spacetime_s.cmi
> File "stdcompat__spacetime_s.mli", line 3, characters 16-32:
> 3 | module Series = Spacetime.Series
>                     ^^^^^^^^^^^^^^^^
> Error: Unbound module Spacetime
>
> This module was removed in OCaml commit
> 540996d21ee3793a1cecce252c81fb76a6b9fd61.
>
> ----------------------------------------------------------------------
>
> ocamlfind ocamlc -c -package result -package seq -bin-annot -no-alias-deps -I . -alert -deprecated stdcompat__ephemeron.ml -o stdcompat__ephemeron.cmo
> File "stdcompat__ephemeron.ml", line 1:
> Error: The implementation stdcompat__ephemeron.ml
>        does not match the interface stdcompat__ephemeron.cmi:
>        ...
>        At position module type S = <here>
>        Type declarations do not match:
>          type 'a t
>        is not included in
>          type !'a t
>        Their variances do not agree.
>        File "hashtbl.mli", line 335, characters 4-14: Expected declaration
>        File "stdcompat__ephemeron_s.mli", line 6, characters 4-13:
>          Actual declaration
>
> Not sure about this one but AFAICT cocci doesn't use this module.
>
> ----------------------------------------------------------------------
>
> I made a patch to workaround the issues in Fedora, but it's a pure hack:

Thanks for the feedback and the fix attempt.  I hope that this can be
fixed on our side shortly.

julia


>
>   https://src.fedoraproject.org/rpms/coccinelle/tree/rawhide
>
> Rich.
>
> --
> Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
> Read my programming and virtualization blog: http://rwmj.wordpress.com
> libguestfs lets you edit virtual machines.  Supports shell scripting,
> bindings from many languages.  http://libguestfs.org
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
