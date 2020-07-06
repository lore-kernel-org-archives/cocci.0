Return-Path: <SRS0=XQjq=AR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1ACC433E1
	for <cocci@archiver.kernel.org>; Mon,  6 Jul 2020 20:04:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0FCE20702
	for <cocci@archiver.kernel.org>; Mon,  6 Jul 2020 20:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0FCE20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 066K3nwi027706;
	Mon, 6 Jul 2020 22:03:49 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 79ADA7489;
	Mon,  6 Jul 2020 22:03:49 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 919283D0F
 for <cocci@systeme.lip6.fr>; Mon,  6 Jul 2020 22:03:48 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 066K3l6e023756
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 6 Jul 2020 22:03:47 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.75,321,1589234400"; d="scan'208";a="458580204"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 22:03:47 +0200
Date: Mon, 6 Jul 2020 22:03:47 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jaskaran Singh <jaskaran.singh@collabora.com>
In-Reply-To: <20200703175931.1693-3-jaskaran.singh@collabora.com>
Message-ID: <alpine.DEB.2.22.394.2007062203360.2521@hadrien>
References: <20200703175931.1693-1-jaskaran.singh@collabora.com>
 <20200703175931.1693-3-jaskaran.singh@collabora.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 06 Jul 2020 22:03:49 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 06 Jul 2020 22:03:47 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH 02/20] parsing_cocci: parser: Wrap SmPL
	Attributes
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



On Fri, 3 Jul 2020, Jaskaran Singh wrote:

> Attributes are wrapped in the SmPL AST. Reciprocate this and wrap
> attributes in the SmPL parser.

This doesn't apply for me.

julia


>
> Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
> ---
>  parsing_cocci/parse_aux.ml            |  3 +++
>  parsing_cocci/parse_aux.mli           |  7 +++++++
>  parsing_cocci/parser_cocci_menhir.mly | 18 ++++++++++--------
>  3 files changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/parsing_cocci/parse_aux.ml b/parsing_cocci/parse_aux.ml
> index b5d1afb4..f2036bfc 100644
> --- a/parsing_cocci/parse_aux.ml
> +++ b/parsing_cocci/parse_aux.ml
> @@ -152,6 +152,9 @@ let logic_op ast_op left op right =
>  let make_cv cv ty =
>    match cv with None -> ty | Some x -> Ast0.wrap (Ast0.ConstVol(x,ty))
>
> +let make_attr attr =
> +  Ast0.wrap(Ast0.Attribute(id2mcode attr))
> +
>  let top_dots l = Ast0.wrap l
>
>  (* here the offset is that of the first in the sequence of *s, not that of
> diff --git a/parsing_cocci/parse_aux.mli b/parsing_cocci/parse_aux.mli
> index 91d7cb26..0ecf10b0 100644
> --- a/parsing_cocci/parse_aux.mli
> +++ b/parsing_cocci/parse_aux.mli
> @@ -151,6 +151,13 @@ val logic_op :
>    string -> Ast0_cocci.expression -> Ast0_cocci.base_expression Ast0_cocci.wrap
>  val make_cv :
>    Ast_cocci.const_vol Ast0_cocci.mcode option -> Ast0_cocci.typeC -> Ast0_cocci.typeC
> +val make_attr:
> +  string *
> +  (Data.line_type * int * int * int * int * int *
> +   (Ast_cocci.added_string * Ast0_cocci.position_info) list *
> +   (Ast_cocci.added_string * Ast0_cocci.position_info) list *
> +   Ast0_cocci.anything list * string) ->
> +   Ast0_cocci.attr
>  val top_dots : 'a -> 'a Ast0_cocci.wrap
>  val pointerify :
>    Ast0_cocci.typeC ->
> diff --git a/parsing_cocci/parser_cocci_menhir.mly b/parsing_cocci/parser_cocci_menhir.mly
> index 63cb8b5e..32bcd63c 100644
> --- a/parsing_cocci/parser_cocci_menhir.mly
> +++ b/parsing_cocci/parser_cocci_menhir.mly
> @@ -1495,11 +1495,11 @@ fninfo:
>  	let _ = List.find (function Ast0.FInline(_) -> true | _ -> false) $2 in
>  	raise (Semantic_cocci.Semantic "duplicate inline")
>        with Not_found -> (Ast0.FInline(P.clt2mcode "inline" $1))::$2 }
> -  | Tattr    fninfo
> +  | a=Tattr    fninfo
>        { try
>  	let _ = List.find (function Ast0.FAttr(_) -> true | _ -> false) $2 in
>  	raise (Semantic_cocci.Semantic "multiple attributes")
> -      with Not_found -> (Ast0.FAttr(P.id2mcode $1))::$2 }
> +      with Not_found -> (Ast0.FAttr(P.make_attr a))::$2 }
>
>  fninfo_nt:
>      /* empty */ { [] }
> @@ -1514,11 +1514,11 @@ fninfo_nt:
>  	let _ = List.find (function Ast0.FInline(_) -> true | _ -> false) $2 in
>  	raise (Semantic_cocci.Semantic "duplicate inline")
>        with Not_found -> (Ast0.FInline(P.clt2mcode "inline" $1))::$2 }
> -  | Tattr    fninfo_nt
> +  | a=Tattr    fninfo_nt
>        { try
>  	let _ = List.find (function Ast0.FAttr(_) -> true | _ -> false) $2 in
>  	raise (Semantic_cocci.Semantic "duplicate init")
> -      with Not_found -> (Ast0.FAttr(P.id2mcode $1))::$2 }
> +      with Not_found -> (Ast0.FAttr(P.make_attr a))::$2 }
>
>  storage:
>           s=Tstatic      { P.clt2mcode Ast.Static s }
> @@ -3227,12 +3227,14 @@ script_virt_name_decl:
>
>  %inline
>  attr_list:
> -                        { [] }
> - | a=Tattr f=full_attr_list {P.id2mcode a::f}
> +                           { [] }
> + | Tattr f=full_attr_list
> +    { let a = P.make_attr $1 in a::f }
>
>  full_attr_list:
> -                        { [] }
> - | Tattr full_attr_list {P.id2mcode $1::$2}
> +                           { [] }
> + | Tattr f=full_attr_list
> +    { let a = P.make_attr $1 in a::f }
>
>  anything: /* used for script code */
>     TIdentifier { "identifier" }
> --
> 2.21.3
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
