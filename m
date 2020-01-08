Return-Path: <SRS0=sKaj=25=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EBEC282DD
	for <cocci@archiver.kernel.org>; Wed,  8 Jan 2020 13:01:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 355DE20643
	for <cocci@archiver.kernel.org>; Wed,  8 Jan 2020 13:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355DE20643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 008D0kNR000172;
	Wed, 8 Jan 2020 14:00:47 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D6FFD77DB;
	Wed,  8 Jan 2020 14:00:46 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A15157718
 for <cocci@systeme.lip6.fr>; Wed,  8 Jan 2020 14:00:45 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 008D0e0e005917
 for <cocci@systeme.lip6.fr>; Wed, 8 Jan 2020 14:00:40 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.69,410,1571695200"; d="scan'208";a="430430169"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Jan 2020 14:00:40 +0100
Date: Wed, 8 Jan 2020 14:00:40 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>
In-Reply-To: <20200108113112.26209-1-jaskaransingh7654321@gmail.com>
Message-ID: <alpine.DEB.2.21.2001081359400.2069@hadrien>
References: <20200108113112.26209-1-jaskaransingh7654321@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 08 Jan 2020 14:00:47 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 08 Jan 2020 14:00:40 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org, cocci@systeme.lip6.fr,
        skhan@linuxfoundation.org
Subject: Re: [Cocci] [PATCH] parsing_c: Handle case of annotation and ;
 or = after ident
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



On Wed, 8 Jan 2020, Jaskaran Singh wrote:

> For the following case:
>
> [const_vol] <type> [ptr] <identifier> <annotation> <semicolon|eq>
>
> The lookahead function in Parsing_hacks would mislabel <identifier> as a
> CppDirective.
>
> Add cases in the lookahead function for handling this case.
>
> Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>

Looks good.  There are a lot of __ro_after_inits that now get properly
recognized as attributes.  The patch is applied.

julia

> ---
>  parsing_c/parsing_hacks.ml | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/parsing_c/parsing_hacks.ml b/parsing_c/parsing_hacks.ml
> index 56857f3c..43421647 100644
> --- a/parsing_c/parsing_hacks.ml
> +++ b/parsing_c/parsing_hacks.ml
> @@ -1887,6 +1887,11 @@ let not_struct_enum = function
>      (Parser_c.Tstruct _ | Parser_c.Tunion _ | Parser_c.Tenum _)::_ -> false
>    | _ -> true
>
> +let is_struct_enum = function
> +  | (Parser_c.TIdent _)::
> +    (Parser_c.Tstruct _ | Parser_c.Tunion _ | Parser_c.Tenum _)::_ -> true
> +  | _ -> false
> +
>  let not_opar = function
>      TOPar _ -> false
>    | _ -> true
> @@ -2061,6 +2066,32 @@ let lookahead2 ~pass next before =
>  	&& is_type type_ ->
>  	  TCommentCpp (Token_c.CppDirective, i1)
>
> +	(* tt xx yy; : yy is an annot *)
> +  | (TIdent (s, i1)::(TPtVirg _|TEq _)::_, TIdent (s2, i2)::type_::rest)
> +    when (is_struct_enum (type_::rest)
> +	|| is_type type_)
> +	&& s ==~ regexp_annot ->
> +	  TCommentCpp (Token_c.CppMacro, i1)
> +
> +	(* tt * xx yy; : yy is an annot *)
> +  | (TIdent (s, i1)::(TPtVirg _|TEq _)::_, TIdent (s2, i2)::ptr)
> +    when pointer ptr
> +	&& s ==~ regexp_annot ->
> +	  TCommentCpp (Token_c.CppMacro, i1)
> +
> +	(* tt xx yy; : yy is an annot, so xx is an ident *)
> +  | (TIdent (s, i1)::TIdent (s2, i2)::(TPtVirg _|TEq _)::_, seen::_)
> +    when (is_struct_enum before
> +	|| is_type seen)
> +	&& s2 ==~ regexp_annot ->
> +	  TIdent (s, i1)
> +
> +	(* tt * xx yy; : yy is an annot, so xx is an ident *)
> +  | (TIdent (s, i1)::TIdent (s2, i2)::(TPtVirg _|TEq _)::_, ptr)
> +    when pointer ptr
> +	&& s2 ==~ regexp_annot ->
> +	  TIdent (s, i1)
> +
>  	(* tt xx yy *)
>    | (TIdent (s, i1)::TIdent (s2, i2)::_  , seen::_)
>      when not_struct_enum before
> --
> 2.21.1
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
