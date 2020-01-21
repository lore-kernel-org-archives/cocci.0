Return-Path: <SRS0=kxF3=3K=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF643C33CAA
	for <cocci@archiver.kernel.org>; Tue, 21 Jan 2020 06:20:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D5D21734
	for <cocci@archiver.kernel.org>; Tue, 21 Jan 2020 06:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D5D21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00L6KSOZ009403;
	Tue, 21 Jan 2020 07:20:28 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0774577E1;
	Tue, 21 Jan 2020 07:20:28 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 673CF77DB
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 07:20:26 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00L6KLRw004559
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 07:20:21 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.70,344,1574118000"; d="scan'208";a="432302135"
Received: from unknown (HELO hadrien) ([167.98.102.107])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Jan 2020 07:20:21 +0100
Date: Tue, 21 Jan 2020 06:20:21 +0000 (GMT)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>
In-Reply-To: <20200119134812.32748-1-jaskaransingh7654321@gmail.com>
Message-ID: <alpine.DEB.2.21.2001210619100.2301@hadrien>
References: <20200119134812.32748-1-jaskaransingh7654321@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 21 Jan 2020 07:20:28 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 21 Jan 2020 07:20:22 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] parsing_hacks: Add bool to list of known
	typedefs
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

> bool is widely used in the Linux kernel. Certain cases of
> parsing_hacks.ml would mislabel bool.
>
> Add bool to the list of known typedefs.
>
> Stats of --parse-c on Linux v5.5-rc4 are as follows:
>
> Before:
>
>   nb good = 18956150,  nb passed = 134062 =========> 0.70% passed
>
> After:
>
>   nb good = 18956150,  nb passed = 134073 =========> 0.70% passed

Why did nb passed increase?  These are tokens that will not be able to be
transformed by a semantic patch.

julia

>
> Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
> ---
> The above diff has been obtained after applying
> https://www.mail-archive.com/cocci@systeme.lip6.fr/msg06706.html
>
>  parsing_c/parsing_hacks.ml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/parsing_c/parsing_hacks.ml b/parsing_c/parsing_hacks.ml
> index 685a4908..5e3301a0 100644
> --- a/parsing_c/parsing_hacks.ml
> +++ b/parsing_c/parsing_hacks.ml
> @@ -61,7 +61,7 @@ let is_known_typdef =
>        | "u_char"   | "u_short"  | "u_int"  | "u_long"
>        | "u8" | "u16" | "u32" | "u64"
>        | "s8"  | "s16" | "s32" | "s64"
> -      | "__u8" | "__u16" | "__u32"  | "__u64"
> +      | "__u8" | "__u16" | "__u32"  | "__u64" | "bool"
>          -> true
>
>        | "acpi_handle"
> --
> 2.21.1
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
