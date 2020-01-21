Return-Path: <SRS0=kxF3=3K=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467AEC33CAA
	for <cocci@archiver.kernel.org>; Tue, 21 Jan 2020 06:28:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E128D22522
	for <cocci@archiver.kernel.org>; Tue, 21 Jan 2020 06:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E128D22522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00L6SHYW009614;
	Tue, 21 Jan 2020 07:28:17 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E758C77E1;
	Tue, 21 Jan 2020 07:28:16 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B31E277DB
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 07:28:14 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00L6SEnI008497
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 07:28:14 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.70,344,1574118000"; d="scan'208";a="432302668"
Received: from unknown (HELO hadrien) ([167.98.102.107])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Jan 2020 07:28:13 +0100
Date: Tue, 21 Jan 2020 06:28:13 +0000 (GMT)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>
In-Reply-To: <20200119134610.31961-1-jaskaransingh7654321@gmail.com>
Message-ID: <alpine.DEB.2.21.2001210626540.2301@hadrien>
References: <20200119134610.31961-1-jaskaransingh7654321@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 21 Jan 2020 07:28:17 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 21 Jan 2020 07:28:14 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] parsing_c: Handle case of macro before typedef
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



On Sun, 19 Jan 2020, Jaskaran Singh wrote:

> For the following case:
>
> <macro> <typedef> <identifier>
>
> A case in parsing_hacks.ml sometimes mislabels <macro> as a
> typedef ident.
>
> If typedef is a known typedef (such as u8 or *_t), then label
> <macro> as a CppMacro. Subsequent cases will then label <typedef>
> correctly.

OK, I see that you are now using is_known_typdef in a more interesting
way.  Could you add a test case that shows what has improved?  I would
still know to know why the number of passed tokens increases.

julia


>
> Following are results of --parse-c on the Linux Kernel v5.5-rc4:
>
> Before:
>
>   nb good = 18956150,  nb passed = 134061 =========> 0.70% passed
>
> After:
>
>   nb good = 18956150,  nb passed = 134062 =========> 0.70% passed
>
> Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
> ---
>  parsing_c/parsing_hacks.ml | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/parsing_c/parsing_hacks.ml b/parsing_c/parsing_hacks.ml
> index 8374731b..23d675cf 100644
> --- a/parsing_c/parsing_hacks.ml
> +++ b/parsing_c/parsing_hacks.ml
> @@ -2184,6 +2184,41 @@ let lookahead2 ~pass next before =
>        && ok_typedef s && is_macro s2 && is_type type_
>          ->
>  	  TIdent (s, i1)
> +
> +  (* xx yy zz : xx is a macro *)
> +  | (TIdent (s, i1)::TIdent (s2, i2)::TIdent(_,_)::_ , _)
> +    when not_struct_enum before
> +	&& ok_typedef s2
> +	&& is_known_typdef s2
> +        ->
> +	  TCommentCpp(Token_c.CppMacro, i1)
> +
> +  (* xx yy zz : xx is a typedef ident *)
> +  | (TIdent (s, i1)::TIdent (s2, i2)::TIdent(_,_)::_ , _)
> +    when not_struct_enum before
> +	&& ok_typedef s
> +        ->
> +      msg_typedef s i1 2; LP.add_typedef_root s i1;
> +      TypedefIdent (s, i1)
> +
> +  (* xx yy * zz : xx is a macro *)
> +  | (TIdent (s, i1)::TIdent (s2, i2)::ptr , _)
> +    when pointer ~followed_by:(function TIdent _ -> true | _ -> false) ptr
> +	&& not_struct_enum before
> +	&& ok_typedef s2
> +	&& is_known_typdef s2
> +        ->
> +	  TCommentCpp(Token_c.CppMacro, i1)
> +
> +  (* xx yy * zz : xx is a typedef ident *)
> +  | (TIdent (s, i1)::TIdent (s2, i2)::ptr , _)
> +    when pointer ~followed_by:(function TIdent _ -> true | _ -> false) ptr
> +	&& not_struct_enum before
> +	&& ok_typedef s
> +        ->
> +      msg_typedef s i1 2; LP.add_typedef_root s i1;
> +      TypedefIdent (s, i1)
> +
>    (* xx yy *)
>    | (TIdent (s, i1)::TIdent (s2, i2)::rest  , _) when not_struct_enum before
>  	&& ok_typedef s && not (is_macro_paren s2 rest)
> --
> 2.21.1
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
