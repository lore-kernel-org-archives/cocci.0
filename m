Return-Path: <SRS0=Yu4p=5D=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AECC10DCE
	for <cocci@archiver.kernel.org>; Wed, 18 Mar 2020 17:27:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24AE720752
	for <cocci@archiver.kernel.org>; Wed, 18 Mar 2020 17:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24AE720752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02IHRPVh028275;
	Wed, 18 Mar 2020 18:27:25 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A6C777809;
	Wed, 18 Mar 2020 18:27:25 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6BE0D77F9
 for <cocci@systeme.lip6.fr>; Wed, 18 Mar 2020 18:27:24 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02IHRNGV018390
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 18 Mar 2020 18:27:23 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.70,568,1574118000"; d="scan'208";a="342837321"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Mar 2020 18:27:23 +0100
Date: Wed, 18 Mar 2020 18:27:22 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>
In-Reply-To: <20200316100319.27935-3-jaskaransingh7654321@gmail.com>
Message-ID: <alpine.DEB.2.21.2003181826560.2979@hadrien>
References: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
 <20200316100319.27935-3-jaskaransingh7654321@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 18 Mar 2020 18:27:25 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 18 Mar 2020 18:27:23 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH 02/26] parsing_cocci: AST: Add ParenType and
 FunctionType to SmPL ASTs
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

> ParenType and FunctionType are types present in the C AST that
> are not present in the SmPL AST. In the pursuit of aligning
> both the C and SmPL ASTs, add these types to the SmPL ASTs.

It would be nice to extend the log message to give an example of how these
constructors would be used.

julia

>
> Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
> ---
>  ocaml/coccilib.mli           | 6 ++++++
>  parsing_cocci/ast0_cocci.ml  | 3 +++
>  parsing_cocci/ast0_cocci.mli | 3 +++
>  parsing_cocci/ast_cocci.ml   | 3 +++
>  parsing_cocci/ast_cocci.mli  | 3 +++
>  5 files changed, 18 insertions(+)
>
> diff --git a/ocaml/coccilib.mli b/ocaml/coccilib.mli
> index 5a913099..e5409a97 100644
> --- a/ocaml/coccilib.mli
> +++ b/ocaml/coccilib.mli
> @@ -2709,6 +2709,9 @@ module Ast_cocci :
>        | Pointer of fullType * string mcode
>        | FunctionPointer of fullType * string mcode * string mcode *
>            string mcode * string mcode * parameter_list * string mcode
> +      | ParenType of string mcode (* ( *) * fullType * string mcode (* ) *)
> +      | FunctionType of fullType *
> +          string mcode (* ( *) * parameter_list * string mcode (* ) *)
>        | Array of fullType * string mcode * expression option * string mcode
>        | Decimal of string mcode * string mcode * expression *
>            string mcode option * expression option * string mcode
> @@ -3353,6 +3356,9 @@ module Ast0_cocci :
>        | Pointer of typeC * string mcode
>        | FunctionPointer of typeC * string mcode * string mcode *
>            string mcode * string mcode * parameter_list * string mcode
> +      | ParenType of string mcode * typeC * string mcode
> +      | FunctionType of typeC *
> +          string mcode * parameter_list * string mcode
>        | Array of typeC * string mcode * expression option * string mcode
>        | Decimal of string mcode * string mcode * expression *
>            string mcode option * expression option * string mcode
> diff --git a/parsing_cocci/ast0_cocci.ml b/parsing_cocci/ast0_cocci.ml
> index 77dc46f0..0acbeaa4 100644
> --- a/parsing_cocci/ast0_cocci.ml
> +++ b/parsing_cocci/ast0_cocci.ml
> @@ -203,6 +203,9 @@ and base_typeC =
>    | FunctionPointer of typeC *
>  	          string mcode(* ( *)*string mcode(* * *)*string mcode(* ) *)*
>                    string mcode (* ( *)*parameter_list*string mcode(* ) *)
> +  | ParenType       of string mcode (* ( *) * typeC * string mcode (* ) *)
> +  | FunctionType    of typeC *
> +                  string mcode (* ( *) * parameter_list * string mcode (* ) *)
>    | Array           of typeC * string mcode (* [ *) *
>  	               expression option * string mcode (* ] *)
>    | Decimal         of string mcode (* decimal *) * string mcode (* ( *) *
> diff --git a/parsing_cocci/ast0_cocci.mli b/parsing_cocci/ast0_cocci.mli
> index 274c6bc2..33bd12b2 100644
> --- a/parsing_cocci/ast0_cocci.mli
> +++ b/parsing_cocci/ast0_cocci.mli
> @@ -194,6 +194,9 @@ and base_typeC =
>    | FunctionPointer of typeC *
>  	          string mcode(* ( *)*string mcode(* * *)*string mcode(* ) *)*
>                    string mcode (* ( *)*parameter_list*string mcode(* ) *)
> +  | ParenType       of string mcode (* ( *) * typeC * string mcode (* ) *)
> +  | FunctionType    of typeC *
> +                  string mcode (* ( *) * parameter_list * string mcode (* ) *)
>    | Array           of typeC * string mcode (* [ *) *
>  	               expression option * string mcode (* ] *)
>    | Decimal         of string mcode (* decimal *) * string mcode (* ( *) *
> diff --git a/parsing_cocci/ast_cocci.ml b/parsing_cocci/ast_cocci.ml
> index ba6ec29e..f8e6dee6 100644
> --- a/parsing_cocci/ast_cocci.ml
> +++ b/parsing_cocci/ast_cocci.ml
> @@ -343,6 +343,9 @@ and base_typeC =
>    | FunctionPointer of fullType *
>  	          string mcode(* ( *)*string mcode(* * *)*string mcode(* ) *)*
>                    string mcode (* ( *)*parameter_list*string mcode(* ) *)
> +  | ParenType       of string mcode (* ( *) * fullType * string mcode (* ) *)
> +  | FunctionType    of fullType *
> +                  string mcode (* ( *) * parameter_list * string mcode (* ) *)
>    | Array           of fullType * string mcode (* [ *) *
>  	               expression option * string mcode (* ] *)
>    | Decimal         of string mcode (* decimal *) * string mcode (* ( *) *
> diff --git a/parsing_cocci/ast_cocci.mli b/parsing_cocci/ast_cocci.mli
> index 5f21664b..7fb54e4d 100644
> --- a/parsing_cocci/ast_cocci.mli
> +++ b/parsing_cocci/ast_cocci.mli
> @@ -325,6 +325,9 @@ and base_typeC =
>    | FunctionPointer of fullType *
>  	          string mcode(* ( *)*string mcode(* * *)*string mcode(* ) *)*
>                    string mcode (* ( *)*parameter_list*string mcode(* ) *)
> +  | ParenType       of string mcode (* ( *) * fullType * string mcode (* ) *)
> +  | FunctionType    of fullType *
> +                  string mcode (* ( *) * parameter_list * string mcode (* ) *)
>    | Array           of fullType * string mcode (* [ *) *
>  	               expression option * string mcode (* ] *)
>    | Decimal         of string mcode (* decimal *) * string mcode (* ( *) *
> --
> 2.21.1
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
