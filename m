Return-Path: <SRS0=lElT=X5=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744F5C4360C
	for <cocci@archiver.kernel.org>; Fri,  4 Oct 2019 11:21:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2207215EA
	for <cocci@archiver.kernel.org>; Fri,  4 Oct 2019 11:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2207215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x94BLcBf007237;
	Fri, 4 Oct 2019 13:21:38 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5A82677BE;
	Fri,  4 Oct 2019 13:21:38 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8F47177B4
 for <cocci@systeme.lip6.fr>; Fri,  4 Oct 2019 13:21:36 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x94BLZfZ010105
 for <cocci@systeme.lip6.fr>; Fri, 4 Oct 2019 13:21:35 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.67,256,1566856800"; d="scan'208";a="321625822"
Received: from portablejulia.rsr.lip6.fr ([132.227.76.63])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Oct 2019 13:21:34 +0200
Date: Fri, 4 Oct 2019 13:21:34 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To: Michele Martone <michelemartone@users.sourceforge.net>
In-Reply-To: <20190925165414.23602-1-michelemartone@users.sourceforge.net>
Message-ID: <alpine.DEB.2.21.1910041321090.2992@hadrien>
References: <20190925165414.23602-1-michelemartone@users.sourceforge.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 04 Oct 2019 13:21:39 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Fri, 04 Oct 2019 13:21:35 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: nicolas.palix@imag.fr, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] clarify misleading warning message
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



On Wed, 25 Sep 2019, Michele Martone wrote:

> One may think that when warning that
>  "should %s be a metavariable?"
> Coccinelle also treats a given symbol %s as a metavariable.
> Better state explicitly that this is not the case.

The change is ok. Please add a Signed-off-by:

thanks,
julia

> ---
>  parsing_cocci/check_meta.ml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/parsing_cocci/check_meta.ml b/parsing_cocci/check_meta.ml
> index e728d8f5..b857d3f6 100644
> --- a/parsing_cocci/check_meta.ml
> +++ b/parsing_cocci/check_meta.ml
> @@ -84,7 +84,7 @@ let rec ident context old_metas table minus i =
>  	    not err(* warn only once per id *) && not info.Ast0.isSymbolIdent
>  	  then
>  	    warning
> -	      (Printf.sprintf "line %d: should %s be a metavariable?" rl name)
> +	      (Printf.sprintf "line %d: should %s be a metavariable? treating it as symbol." rl name)
>        | _ -> ())
>    | Ast0.MetaId(name,_,seedval,_) ->
>        check_table table minus name;
> --
> 2.20.1
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
