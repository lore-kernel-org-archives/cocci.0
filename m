Return-Path: <SRS0=Ssaw=JS=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4682CC433ED
	for <cocci@archiver.kernel.org>; Wed, 21 Apr 2021 15:01:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D4AC61422
	for <cocci@archiver.kernel.org>; Wed, 21 Apr 2021 15:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4AC61422
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 13LF1aCr010326;
	Wed, 21 Apr 2021 17:01:36 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 19DE677D8;
	Wed, 21 Apr 2021 17:01:36 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EE8203E3B
 for <cocci@systeme.lip6.fr>; Wed, 21 Apr 2021 17:01:34 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 13LF1WWt000361
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 21 Apr 2021 17:01:32 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AfNyNHK1/8LYLv+dXOwAdWgqjBFMkLtp033Aq?=
 =?us-ascii?q?2lEZdDV+dMuEm8ey2MkKzBOcskd0ZFgMkc2NUZPqfVry7phwiLN6AZ6DW03ctH?=
 =?us-ascii?q?KsPMVe6+LZogHIPw3b2qpj2bx7c654YeeAaGRSqcrh+gG3H5IB7bC8kJyAvuvV?=
 =?us-ascii?q?w3dzQQwCUcgJ0y5DBgmWCUFwTgVdbKBJd6a03NZNpDarZB0sAPiTO39tZYT+ju?=
 =?us-ascii?q?HQmImjSRALAANP0njtsRqYrI+/KRSe0xsEOgkj/Z4p+wH+/DDE2g=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.82,240,1613430000"; d="scan'208";a="504349227"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Apr 2021 17:01:14 +0200
Date: Wed, 21 Apr 2021 17:01:14 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Fuad Tabba <tabba@google.com>
In-Reply-To: <20210421105756.3430220-1-tabba@google.com>
Message-ID: <alpine.DEB.2.22.394.2104211654020.13358@hadrien>
References: <20210421105756.3430220-1-tabba@google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1245013000-1619017274=:13358"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 21 Apr 2021 17:01:37 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 21 Apr 2021 17:01:32 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] Fix parse error in presence of symbols named far
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1245013000-1619017274=:13358
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Wed, 21 Apr 2021, Fuad Tabba wrote:

> Hi,
>
> I just started using Coccinelle yesterday, and I can already see
> it saving me a lot of time and agony. Thank you.
>
> I ran into a problem, and I think that this patch might fix it,
> hopefully without causing other problems. I did some sanity
> checking on my kernel tree, and it seems to be fine.

Thanks very much for this.  I have applied the patch.

To check this sort of thing, you can do spatch --parse-c linux_path > old
then make your change
then spatch --parse-c linux_path > new

Then look at the end of old and new.  If you successfully parsed more
files and have fewer bad and passed tokens, then all should be good.

julia

>
> There are quite a few variables named "far" in the kernel, e.g.,
> arch/arm64/kvm/inject_fault.c. Coccinelle has special treatment
> for "far" as being linkage related, which causes parse errors in
> their presence. I've grepped for "far" in the kernel tree, and
> haven't noticed where it's used like that, but I could have
> missed it.
>
> To reproduce:
>
> cat > test.c << EOF
> int main(void)
> {
>         int far = 0;
>         int x;
>         x = 10;
>         return x;
> }
> EOF
>
> cat > test.cocci << EOF
> @@
> identifier x;
> @@
> - x
> + y
> EOF
>
> spatch --sp-file test.cocci test.c --debug --verbose-parsing
>
> Signed-off-by: Fuad Tabba <tabba@google.com>
> ---
>  scripts/coccicheck/cocci/notand.h | 1 -
>  standard.h                        | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/scripts/coccicheck/cocci/notand.h b/scripts/coccicheck/cocci/notand.h
> index 3da8c303..91fa6c96 100644
> --- a/scripts/coccicheck/cocci/notand.h
> +++ b/scripts/coccicheck/cocci/notand.h
> @@ -302,7 +302,6 @@
>  #define  fastcall
>  #define  asmlinkage
>
> -#define  far
>  #define  SK_FAR
>
>  // pb
> diff --git a/standard.h b/standard.h
> index 7a7f96ea..936b19c3 100644
> --- a/standard.h
> +++ b/standard.h
> @@ -298,7 +298,6 @@
>  #define  fastcall
>  #define  asmlinkage
>
> -#define  far
>  #define  SK_FAR
>
>  // pb
> --
> 2.31.1.368.gbe11c130af-goog
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
--8323329-1245013000-1619017274=:13358
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1245013000-1619017274=:13358--
