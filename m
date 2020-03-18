Return-Path: <SRS0=Yu4p=5D=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D19C10DCE
	for <cocci@archiver.kernel.org>; Wed, 18 Mar 2020 18:47:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1F662076D
	for <cocci@archiver.kernel.org>; Wed, 18 Mar 2020 18:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F662076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02IIl6j3026026;
	Wed, 18 Mar 2020 19:47:06 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3153E7809;
	Wed, 18 Mar 2020 19:47:06 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6FAAD77F9
 for <cocci@systeme.lip6.fr>; Wed, 18 Mar 2020 19:47:05 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02IIl4Y6010656
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 18 Mar 2020 19:47:04 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.70,568,1574118000"; d="scan'208";a="441037351"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Mar 2020 19:47:04 +0100
Date: Wed, 18 Mar 2020 19:47:04 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>
In-Reply-To: <20200316100319.27935-23-jaskaransingh7654321@gmail.com>
Message-ID: <alpine.DEB.2.21.2003181946180.2979@hadrien>
References: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
 <20200316100319.27935-23-jaskaransingh7654321@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 18 Mar 2020 19:47:06 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 18 Mar 2020 19:47:04 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH 22/26] parsing_c: unparse_cocci: Print
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



On Mon, 16 Mar 2020, Jaskaran Singh wrote:

> The order of the terms in ParenType require implementing a special
> case for ParenType. This case handles only the following:
>
>         <type> ( * id [ .* ] ) ( params )
>
> i.e., a function pointer or an array of function pointers, and will fail
> for any other cases. This is similar to the function used to print
> ParenType in Pretty_print_c.
>
> Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
> ---
>  parsing_c/unparse_cocci.ml | 60 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>
> diff --git a/parsing_c/unparse_cocci.ml b/parsing_c/unparse_cocci.ml
> index 30e755e9..9dd84821 100644
> --- a/parsing_c/unparse_cocci.ml
> +++ b/parsing_c/unparse_cocci.ml
> @@ -722,6 +722,13 @@ and typeC ty =
>    | Ast.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
>        print_function_pointer (ty,lp1,star,rp1,lp2,params,rp2)
>  	(function _ -> ())
> +  | Ast.ParenType(lp,ty,rp) ->
> +      print_parentype (lp,ty,rp) (function _ -> ())
> +  | Ast.FunctionType(ty,lp,params,rp) ->
> +      fullType ty;
> +      mcode print_string lp;
> +      parameter_list params;
> +      mcode print_string rp
>    | Ast.Array(ty,lb,size,rb) ->
>        fullType ty; mcode print_string lb; print_option expression size;
>        mcode print_string rb
> @@ -786,6 +793,57 @@ and storage = function
>    | Ast.Register -> print_string "register"
>    | Ast.Extern -> print_string "extern"
>
> +(* --------------------------------------------------------------------- *)
> +(* ParenType *)
> +
> +and print_parentype (lp,ty,rp) fn =
> +  match Ast.unwrap ty with
> +   Ast.Type(_,_,fty1) ->
> +    (match Ast.unwrap fty1 with
> +      Ast.Pointer(ty1,star) ->
> +       (match Ast.unwrap ty1 with
> +         Ast.Type(_,_,fty2) ->
> +          (match Ast.unwrap fty2 with
> +            Ast.FunctionType(ty2,lp2,params,rp2) ->
> +             fullType ty2;
> +             pr_space();
> +             mcode print_string lp;
> +             mcode print_string star;
> +             fn();
> +             mcode print_string rp;
> +             mcode print_string lp2;
> +             parameter_list params;
> +             mcode print_string rp2
> +         | _ -> failwith "ParenType Unparse_cocci")
> +       | _ -> failwith "ParenType Unparse_cocci")
> +    | Ast.Array(ty1,lb1,size1,rb1) ->
> +       (match Ast.unwrap ty1 with
> +         Ast.Type(_,_,fty2) ->
> +          (match Ast.unwrap fty2 with
> +            Ast.Pointer(ty2,star) ->
> +             (match Ast.unwrap ty2 with
> +               Ast.Type(_,_,fty3) ->
> +                (match Ast.unwrap fty3 with
> +                  Ast.FunctionType(ty3,lp3,params,rp3) ->
> +                  fullType ty3;
> +                  pr_space();
> +                  mcode print_string lp;
> +                  mcode print_string star;
> +                  fn();
> +                  mcode print_string lb1;
> +                  print_option expression size1;
> +                  mcode print_string rb1;
> +                  mcode print_string rp;
> +                  mcode print_string lp3;
> +                  parameter_list params;
> +                  mcode print_string rp3
> +                | _ -> failwith "ParenType Unparse_cocci")
> +             | _ -> failwith "ParenType Unparse_cocci")
> +          | _ -> failwith "ParenType Unparse_cocci")
> +       | _ -> failwith "ParenType Unparse_cocci")
> +    | _ -> failwith "ParenType Unparse_cocci")
> +  | _ -> failwith "ParenType Unparse_cocci"

Can some code be shared?

> +
>  (* --------------------------------------------------------------------- *)
>  (* Variable declaration *)
>
> @@ -818,6 +876,8 @@ and print_named_type ty id =
>  		pretty_print_c.Pretty_print_c.type_with_ident ty
>  		  (function _ -> id())
>              | _ -> error name ty "type value expected")
> +      | Ast.ParenType(lp,ty,rp) ->
> +          print_parentype (lp,ty,rp) (function _ -> id())

Is it normal that there is no FunctionType case here?

julia

>      (*| should have a case here for pointer to array or function type
>          that would put ( * ) around the variable.  This makes one wonder
>          why we really need a special case for function pointer *)
> --
> 2.21.1
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
