Return-Path: <SRS0=J+r8=6L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43F7C54FCB
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 17:13:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66B4720738
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 17:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B4720738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03RHDUnM001736;
	Mon, 27 Apr 2020 19:13:30 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A4E547807;
	Mon, 27 Apr 2020 19:13:30 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 95AC97769
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 19:13:29 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03RHDSAS009144
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 19:13:29 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,324,1583190000"; d="scan'208";a="347098464"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 19:13:28 +0200
Date: Mon, 27 Apr 2020 19:13:28 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>
In-Reply-To: <20200427120834.380-16-jaskaransingh7654321@gmail.com>
Message-ID: <alpine.DEB.2.21.2004271913060.12657@hadrien>
References: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
 <20200427120834.380-16-jaskaransingh7654321@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 Apr 2020 19:13:30 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 27 Apr 2020 19:13:29 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH 15/23] parsing_cocci: visitor_ast: Visit
 Parameter attributes
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



On Mon, 27 Apr 2020, Jaskaran Singh wrote:

> Parameter attributes are added to the SmPL AST. Visit these attributes in
> the AST visitor.
>
> Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
> ---
>  parsing_cocci/visitor_ast.ml | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/parsing_cocci/visitor_ast.ml b/parsing_cocci/visitor_ast.ml
> index 8e530114..f1e78d8c 100644
> --- a/parsing_cocci/visitor_ast.ml
> +++ b/parsing_cocci/visitor_ast.ml
> @@ -621,9 +621,18 @@ let combiner bind option_default
>    and parameterTypeDef p =
>      let k p =
>        match Ast.unwrap p with
> -	Ast.VoidParam(ty) -> fullType ty
> -      | Ast.Param(ty,Some id) -> named_type ty id
> -      | Ast.Param(ty,None) -> fullType ty
> +	Ast.VoidParam(ty,attr) ->
> +          let lty = fullType ty in
> +	  let lattr = multibind (List.map string_mcode attr) in
> +          bind lty lattr

There are some more inconsistent indentations here.

julia


> +      | Ast.Param(ty,Some id,attr) ->
> +          let lid = named_type ty id in
> +	  let lattr = multibind (List.map string_mcode attr) in
> +          bind lid lattr
> +      | Ast.Param(ty,None,attr) ->
> +          let lty = fullType ty in
> +	  let lattr = multibind (List.map string_mcode attr) in
> +          bind lty lattr
>        | Ast.MetaParam(name,_,_,_) -> meta_mcode name
>        | Ast.MetaParamList(name,_,_,_,_) -> meta_mcode name
>        |	Ast.AsParam(p,asexp) ->
> @@ -1582,8 +1591,11 @@ let rebuilder
>      let k p =
>        Ast.rewrap p
>  	(match Ast.unwrap p with
> -	  Ast.VoidParam(ty) -> Ast.VoidParam(fullType ty)
> -	| Ast.Param(ty,id) -> Ast.Param(fullType ty, get_option ident id)
> +	  Ast.VoidParam(ty,attr) ->
> +            Ast.VoidParam(fullType ty,List.map string_mcode attr)
> +	| Ast.Param(ty,id,attr) ->
> +            Ast.Param
> +              (fullType ty, get_option ident id,List.map string_mcode attr)
>  	| Ast.MetaParam(name,constraints,keep,inherited) ->
>  	    Ast.MetaParam(meta_mcode name,constraints,keep,inherited)
>  	| Ast.MetaParamList(name,lenname_inh,constraints,keep,inherited) ->
> --
> 2.21.1
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
