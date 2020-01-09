Return-Path: <SRS0=T4Xf=26=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CECC32771
	for <cocci@archiver.kernel.org>; Thu,  9 Jan 2020 10:47:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0F122067D
	for <cocci@archiver.kernel.org>; Thu,  9 Jan 2020 10:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F122067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 009AlR3o011113;
	Thu, 9 Jan 2020 11:47:27 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DE56477DB;
	Thu,  9 Jan 2020 11:47:26 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 27A673784
 for <cocci@systeme.lip6.fr>; Thu,  9 Jan 2020 11:47:25 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 009AlOnX008950
 for <cocci@systeme.lip6.fr>; Thu, 9 Jan 2020 11:47:24 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.69,413,1571695200"; d="scan'208";a="430596588"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Jan 2020 11:47:23 +0100
Date: Thu, 9 Jan 2020 11:47:23 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>
In-Reply-To: <20200108150518.6241-1-jaskaransingh7654321@gmail.com>
Message-ID: <alpine.DEB.2.21.2001091147060.10786@hadrien>
References: <20200108150518.6241-1-jaskaransingh7654321@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 09 Jan 2020 11:47:27 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 09 Jan 2020 11:47:24 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org, cocci@systeme.lip6.fr,
        skhan@linuxfoundation.org
Subject: Re: [Cocci] [PATCH] parsing_c: Handle case of annotation in
 function proto/def
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
> [const_vol] <type> [ptr] <annotation> <identifier> <open_par>
>
> The lookahead function in Parsing_hacks would mislabel <annotation> as a
> CppDirective, causing pretty printing errors.
>
> Add a case in the lookahead function for handling this case.

Applied.  Thanks!

julia

>
> Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
> ---
>  parsing_c/parsing_hacks.ml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/parsing_c/parsing_hacks.ml b/parsing_c/parsing_hacks.ml
> index 43421647..3f031f21 100644
> --- a/parsing_c/parsing_hacks.ml
> +++ b/parsing_c/parsing_hacks.ml
> @@ -2066,6 +2066,20 @@ let lookahead2 ~pass next before =
>  	&& is_type type_ ->
>  	  TCommentCpp (Token_c.CppDirective, i1)
>
> +        (* tt xx yy ( : xx is an annot *)
> +  | (TIdent (s, i1)::TIdent (s2, i2)::TOPar _::_, seen::_)
> +    when LP.current_context () = LP.InTopLevel
> +	&& (is_struct_enum before || is_type seen)
> +	&& s ==~ regexp_annot ->
> +	  TCommentCpp (Token_c.CppMacro, i1)
> +
> +        (* tt * xx yy ( : xx is an annot *)
> +  | (TIdent (s, i1)::TIdent (s2, i2)::TOPar _::_, ptr)
> +    when LP.current_context () = LP.InTopLevel
> +	&& pointer ptr
> +	&& s ==~ regexp_annot ->
> +	  TCommentCpp (Token_c.CppMacro, i1)
> +
>  	(* tt xx yy; : yy is an annot *)
>    | (TIdent (s, i1)::(TPtVirg _|TEq _)::_, TIdent (s2, i2)::type_::rest)
>      when (is_struct_enum (type_::rest)
> --
> 2.21.1
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
