Return-Path: <SRS0=qWDJ=5C=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61EAC10F29
	for <cocci@archiver.kernel.org>; Tue, 17 Mar 2020 07:16:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C1A20674
	for <cocci@archiver.kernel.org>; Tue, 17 Mar 2020 07:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C1A20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02H7G7fU014008;
	Tue, 17 Mar 2020 08:16:07 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 373757808;
	Tue, 17 Mar 2020 08:16:07 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AF1FF3B93
 for <cocci@systeme.lip6.fr>; Tue, 17 Mar 2020 08:16:05 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02H7G5Br017791
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 17 Mar 2020 08:16:05 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.70,563,1574118000"; d="scan'208";a="440687236"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Mar 2020 08:16:04 +0100
Date: Tue, 17 Mar 2020 08:16:04 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>
In-Reply-To: <20200317055920.16708-1-jaskaransingh7654321@gmail.com>
Message-ID: <alpine.DEB.2.21.2003170815300.2482@hadrien>
References: <20200316100319.27935-6-jaskaransingh7654321@gmail.com>
 <20200317055920.16708-1-jaskaransingh7654321@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 17 Mar 2020 08:16:07 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 17 Mar 2020 08:16:05 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH 05/26] parsing_cocci: visitor_ast: Add cases for
 ParenType/FunctionType
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



On Tue, 17 Mar 2020, Jaskaran Singh wrote:

> The order of the terms in ParenType require implementing a special
> case for ParenType. This case handles only the following:
>
> 	<type> ( * id [ .* ] ) ( params )
>
> i.e., a function pointer or an array of function pointers, and will fail
> for any other cases. This is similar to the function used to print
> ParenType in Pretty_print_c.

Did you change this?  It should be v2, and then the reason for the change
should be described under the ---

julia

>
> Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
> ---
>  parsing_cocci/visitor_ast.ml | 75 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
>
> diff --git a/parsing_cocci/visitor_ast.ml b/parsing_cocci/visitor_ast.ml
> index 3d5de794..99af7652 100644
> --- a/parsing_cocci/visitor_ast.ml
> +++ b/parsing_cocci/visitor_ast.ml
> @@ -318,6 +318,61 @@ let combiner bind option_default
>      let lrb = string_mcode rb in
>      multibind ([lty] @ lid @ [lb; lsize; lrb])
>
> +  and parentype_type (lp, ty, (id : Ast.ident option), rp) =
> +    match Ast.unwrap ty with
> +     Ast.Type(_,_,fty1) ->
> +      (match Ast.unwrap fty1 with
> +         Ast.Pointer(ty1,star) ->
> +          (match Ast.unwrap ty1 with
> +             Ast.Type(_,_,fty2) ->
> +              (match Ast.unwrap fty2 with
> +                Ast.FunctionType(ty2,lp2,params,rp2) ->
> +                  let typ = fullType ty2 in
> +                  let lp = string_mcode lp in
> +                  let star = string_mcode star in
> +                  let idl = match id with
> +                    | Some idd -> [ident idd]
> +                    | None -> [] in
> +                  let rp = string_mcode rp in
> +                  let lp2 = string_mcode lp2 in
> +                  let params = parameter_dots params in
> +                  let rp2 = string_mcode rp2 in
> +                  multibind
> +                    ([typ;lp;star] @ idl @ [rp;lp2;params;rp2])
> +                | _ -> failwith "ParenType Visitor_ast")
> +           | _ -> failwith "ParenType Visitor_ast")
> +       | Ast.Array(ty1,lb1,size1,rb1) ->
> +          (match Ast.unwrap ty1 with
> +            Ast.Type(_,_,fty2) ->
> +             (match Ast.unwrap fty2 with
> +               Ast.Pointer(ty2,star) ->
> +                (match Ast.unwrap ty2 with
> +                  Ast.Type(_,_,fty3) ->
> +                   (match Ast.unwrap fty3 with
> +                     Ast.FunctionType(ty3,lp3,params,rp3) ->
> +                     let typ = fullType ty3 in
> +                     let lp = string_mcode lp in
> +                     let star = string_mcode star in
> +                     let idl = match id with
> +                       | Some idd -> [ident idd]
> +                       | None -> [] in
> +                     let lb1 = string_mcode lb1 in
> +                     let size1 = get_option expression size1 in
> +                     let rb1 = string_mcode rb1 in
> +                     let rp = string_mcode rp in
> +                     let lp3 = string_mcode lp3 in
> +                     let params = parameter_dots params in
> +                     let rp3 = string_mcode rp3 in
> +                     multibind
> +                       ([typ;lp;star] @ idl @
> +                        [lb1;size1;rb1;rp;lp3;params;rp3])
> +   	           | _ -> failwith "ParenType Visitor_ast")
> +                | _ -> failwith "ParenType Visitor_ast")
> +             | _ -> failwith "ParenType Visitor_ast")
> +          | _ -> failwith "ParenType Visitor_ast")
> +       | _ -> failwith "ParenType Visitor_ast")
> +    | _ -> failwith "ParenType Visitor_ast"
> +
>    and typeC ty =
>      let k ty =
>        match Ast.unwrap ty with
> @@ -332,6 +387,14 @@ let combiner bind option_default
>  	  bind lty lstar
>        | Ast.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
>  	  function_pointer (ty,lp1,star,None,rp1,lp2,params,rp2)
> +      | Ast.ParenType(lp,ty,rp) ->
> +          parentype_type (lp,ty,None,rp)
> +      | Ast.FunctionType(ty,lp,params,rp) ->
> +          let lty = fullType ty in
> +          let llp = string_mcode lp in
> +          let lparams = parameter_dots params in
> +          let lrp = string_mcode rp in
> +          multibind [lty; llp; lparams; lrp]
>        | Ast.Array(ty,lb,size,rb) -> array_type (ty,None,lb,size,rb)
>        | Ast.Decimal(dec,lp,length,comma,precision_opt,rp) ->
>  	  let ldec = string_mcode dec in
> @@ -384,6 +447,7 @@ let combiner bind option_default
>  	  Ast.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
>  	    function_pointer (ty, lp1, star, Some id, rp1, lp2, params, rp2)
>  	| Ast.Array(ty,lb,size,rb) -> array_type (ty, Some id, lb, size, rb)
> +        | Ast.ParenType(lp,ty,rp) -> parentype_type (lp, ty, Some id, rp)
>  	| _ -> let lty = fullType ty in
>  	       let lid = ident id in
>  	       bind lty lid)
> @@ -1253,6 +1317,17 @@ let rebuilder
>  	    let lparams = parameter_dots params in
>  	    let lrp2 = string_mcode rp2 in
>  	    Ast.FunctionPointer(lty, llp1, lstar, lrp1, llp2, lparams, lrp2)
> +        | Ast.ParenType(lp,ty,rp) ->
> +            let llp = string_mcode lp in
> +            let lty = fullType ty in
> +            let lrp = string_mcode rp in
> +            Ast.ParenType(llp,lty,lrp)
> +        | Ast.FunctionType(ty,lp,params,rp) ->
> +            let lty = fullType ty in
> +            let llp = string_mcode lp in
> +            let lparams = parameter_dots params in
> +            let lrp = string_mcode rp in
> +            Ast.FunctionType(lty,llp,lparams,lrp)
>  	| Ast.Array(ty,lb,size,rb) ->
>  	    let lty = fullType ty in
>  	    let llb = string_mcode lb in
> --
> 2.21.1
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
