Return-Path: <SRS0=Yu4p=5D=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D23C10DCE
	for <cocci@archiver.kernel.org>; Wed, 18 Mar 2020 18:37:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0392720780
	for <cocci@archiver.kernel.org>; Wed, 18 Mar 2020 18:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0392720780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02IIaox7017193;
	Wed, 18 Mar 2020 19:36:50 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5ABA87809;
	Wed, 18 Mar 2020 19:36:50 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9FDE277F9
 for <cocci@systeme.lip6.fr>; Wed, 18 Mar 2020 19:36:48 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02IIakdE023510
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 18 Mar 2020 19:36:46 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.70,568,1574118000"; d="scan'208";a="441036062"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Mar 2020 19:36:46 +0100
Date: Wed, 18 Mar 2020 19:36:46 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>
In-Reply-To: <20200316100319.27935-10-jaskaransingh7654321@gmail.com>
Message-ID: <alpine.DEB.2.21.2003181936210.2979@hadrien>
References: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
 <20200316100319.27935-10-jaskaransingh7654321@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 18 Mar 2020 19:36:50 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 18 Mar 2020 19:36:46 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH 09/26] parsing_cocci: unparse_ast0: Add cases
 for ParenType/FunctionType
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

> ParenType/FunctionType are now types in the SmPL ASTs. Add
> cases for these types in unparse_ast0.ml.
>
> Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
> ---
>  parsing_cocci/unparse_ast0.ml | 43 +++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/parsing_cocci/unparse_ast0.ml b/parsing_cocci/unparse_ast0.ml
> index 5d450e0e..f8684dd2 100644
> --- a/parsing_cocci/unparse_ast0.ml
> +++ b/parsing_cocci/unparse_ast0.ml
> @@ -292,6 +292,40 @@ and print_function_pointer (ty,lp1,star,rp1,lp2,params,rp2) fn =
>    mcode print_string rp1; mcode print_string lp2;
>    parameter_list params; mcode print_string rp2
>
> +and print_parentype (lp,ty,rp) fn =
> + match Ast0.unwrap ty with
> +   Ast0.Pointer(ty1,star) ->
> +     (match Ast0.unwrap ty1 with
> +       Ast0.FunctionType(ty2,lp2,params,rp2) ->
> +         typeC ty2;
> +         mcode print_string lp;
> +         mcode print_string star;
> +         fn();
> +         mcode print_string rp;
> +         mcode print_string lp2;
> +         parameter_list params;
> +         mcode print_string rp2;
> +       | _ -> failwith "ParenType Unparse_ast0")
> + | Ast0.Array(ty1,lb1,size1,rb1) ->
> +     (match Ast0.unwrap ty1 with
> +       Ast0.Pointer(ty2,star) ->
> +         (match Ast0.unwrap ty2 with
> +           Ast0.FunctionType(ty3,lp3,params,rp3) ->
> +             typeC ty3;
> +             mcode print_string lp;
> +             mcode print_string star;
> +             fn();
> +             mcode print_string lb1;
> +             print_option expression size1;
> +             mcode print_string rb1;
> +             mcode print_string rp;
> +             mcode print_string lp3;
> +             parameter_list params;
> +             mcode print_string rp3;

It should be possible to share some code here.

julia

> + 	| _ -> failwith "ParenType Unparse_ast0")
> +     | _ -> failwith "ParenType Unparse_ast0")
> + | _ -> failwith "ParenType Unparse_ast0"
> +
>  and typeC t =
>    print_context t
>      (function _ ->
> @@ -306,6 +340,13 @@ and typeC t =
>        | Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
>  	  print_function_pointer (ty,lp1,star,rp1,lp2,params,rp2)
>  	    (function _ -> ())
> +      | Ast0.ParenType(lp,ty,rp) ->
> +          print_parentype (lp,ty,rp) (function _ -> ())
> +      | Ast0.FunctionType(ty,lp,params,rp) ->
> +          typeC ty;
> +          mcode print_string lp;
> +          parameter_list params;
> +          mcode print_string rp
>        | Ast0.Array(ty,lb,size,rb) ->
>  	  typeC ty; mcode print_string lb; print_option expression size;
>  	  mcode print_string rb
> @@ -367,6 +408,8 @@ and print_named_type ty id =
>  		mcode print_string rb)
>  	| _ -> typeC ty; ident id; k () in
>        loop ty (function _ -> ())
> +  | Ast0.ParenType(lp,ty,rp) ->
> +      print_parentype (lp,ty,rp) (function _ -> ident id)
>    | _ -> typeC ty; ident id
>
>  and declaration d =
> --
> 2.21.1
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
