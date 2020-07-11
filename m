Return-Path: <SRS0=jdnp=AW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A352C433DF
	for <cocci@archiver.kernel.org>; Sat, 11 Jul 2020 07:57:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D055E20725
	for <cocci@archiver.kernel.org>; Sat, 11 Jul 2020 07:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D055E20725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06B7v94I006298;
	Sat, 11 Jul 2020 09:57:09 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C92CC3FFB;
	Sat, 11 Jul 2020 09:57:09 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 796CB3D0F
 for <cocci@systeme.lip6.fr>; Sat, 11 Jul 2020 09:57:08 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 06B7v7K8010774
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 11 Jul 2020 09:57:07 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.75,338,1589234400"; d="scan'208";a="354210862"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Jul 2020 09:57:07 +0200
Date: Sat, 11 Jul 2020 09:57:06 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jaskaran Singh <jaskaran.singh@collabora.com>
In-Reply-To: <20200711070035.8483-1-jaskaran.singh@collabora.com>
Message-ID: <alpine.DEB.2.22.394.2007110956170.2364@hadrien>
References: <20200711070035.8483-1-jaskaran.singh@collabora.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 11 Jul 2020 09:57:10 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 11 Jul 2020 09:57:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] parsing_cocci: parse_cocci: Extend
 is_permissible_proto list
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



On Sat, 11 Jul 2020, Jaskaran Singh wrote:

> Add more tokens (binary operators and colon) to the match ladder in
> is_permissible_proto. These cases would otherwise cause parsing errors
> for function calls after these tokens.

Thanks, but it doesn't apply:

Applying: parsing_cocci: parse_cocci: Extend is_permissible_proto list
error: parsing_cocci/parse_cocci.ml: does not match index

julia

>
> Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
> ---
>  parsing_cocci/parse_cocci.ml | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/parsing_cocci/parse_cocci.ml b/parsing_cocci/parse_cocci.ml
> index 598cdc0b..e30039dc 100644
> --- a/parsing_cocci/parse_cocci.ml
> +++ b/parsing_cocci/parse_cocci.ml
> @@ -1052,7 +1052,8 @@ let find_function_names l =
>        ((PC.TMid0(_),_) | (PC.TAnd0(_),_))::
>        (PC.TOPar0(_),_)::_ -> false
>      | (PC.TOPar0(_),_)::rest
> -    | (PC.TCPar0(_),_)::rest -> is_permissible_proto rest
> +    | (PC.TCPar0(_),_)::rest
> +    | (PC.TMul(_),_)::rest -> is_permissible_proto rest
>      | x::rest when is_mid x ->
>          let rec loop = function
>            [] -> false
> @@ -1076,6 +1077,21 @@ let find_function_names l =
>      | (PC.TMetaId(_),_)::_
>      | (PC.TMetaLocalIdExp(_),_)::_
>      | (PC.TEq(_),_)::_
> +    | (PC.TEqEq(_),_)::_
> +    | (PC.TNotEq(_),_)::_
> +    | (PC.TShROp(_),_)::_
> +    | (PC.TShLOp(_),_)::_
> +    | (PC.TSub(_),_)::_
> +    | (PC.TPlus(_),_)::_
> +    | (PC.TMinus(_),_)::_
> +    | (PC.TDmOp(_),_)::_
> +    | (PC.TAnd(_),_)::_
> +    | (PC.TOr(_),_)::_
> +    | (PC.TXor(_),_)::_
> +    | (PC.TLogOp(_),_)::_
> +    | (PC.TAndLog(_),_)::_
> +    | (PC.TOrLog(_),_)::_
> +    | (PC.TDotDot(_),_)::_
>      | (PC.TPtrOp(_),_)::_
>      | (PC.TEllipsis(_),_)::_
>      | (PC.TOEllipsis(_),_)::_
> @@ -1086,6 +1102,7 @@ let find_function_names l =
>      | (PC.TOBrace(_),_)::_
>      | (PC.TCBrace(_),_)::_
>      | (PC.TOPar(_),_)::_
> +    | (PC.TOCro(_),_)::_
>      | (PC.TIdent(_),_)::_ -> false
>      | _ -> true in
>    let decl_or_proto clt info bef aft =
> --
> 2.21.3
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
