Return-Path: <SRS0=qCdB=PZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A56C43444
	for <cocci@archiver.kernel.org>; Thu, 17 Jan 2019 06:50:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 497EE20856
	for <cocci@archiver.kernel.org>; Thu, 17 Jan 2019 06:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497EE20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0H6odoT017553
          ; Thu, 17 Jan 2019 07:50:39 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2A00B76E3;
	Thu, 17 Jan 2019 07:50:39 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D8A5576E1
 for <cocci@systeme.lip6.fr>; Thu, 17 Jan 2019 07:50:36 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0H6oakY006236
 for <cocci@systeme.lip6.fr>; Thu, 17 Jan 2019 07:50:36 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.56,488,1539640800"; d="scan'208";a="292209537"
Received: from abo-91-111-68.mrs.modulonet.fr (HELO hadrien) ([85.68.111.91])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2019 07:50:35 +0100
Date: Thu, 17 Jan 2019 07:50:35 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Kees Cook <keescook@google.com>
In-Reply-To: <CAGXu5jJCrGmkfzMfPUWKU3GUdScP_coze80sSwWs+jsubt9RHw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1901170748520.2625@hadrien>
References: <CAGXu5jJCrGmkfzMfPUWKU3GUdScP_coze80sSwWs+jsubt9RHw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 17 Jan 2019 07:50:39 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Thu, 17 Jan 2019 07:50:36 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Confused by regex usage
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



On Wed, 16 Jan 2019, Kees Cook wrote:

> Hi,
>
> I have this .cocci:
>
> /// Unchecked use of snprintf() return values can lead to bugs, especially
> /// when returned or used to increment a buffer position. This is because
> /// snprintf() can return how much it WOULD have written, had it not run out
> /// of space. Instead, use scnprintf() which will report only how much was
> /// actually written, keeping any overflows from happening.
> ///
> // Confidence: Moderate
> // Copyright: (C) 2018 Kees Cook, Google. GPLv2.
> // URL: http://coccinelle.lip6.fr/
> // Options: --all-includes --include-headers
>
> virtual patch
>
> @sum_patch depends on patch exists@
> expression LEN, BUF, SIZE;
> identifier FUNC !~ "^\(snprintf\|scnprintf\)$";
> @@
>
> (
>   LEN =
> -snprintf
> +scnprintf
>   (BUF, SIZE, ...);
> |
>   LEN +=
> -snprintf
> +scnprintf
>   (BUF + LEN, SIZE - LEN, ...);
> )
>   ... when != LEN > SIZE
>       when != LEN >= SIZE
>       when any
> (
>   return LEN;
> |
>   FUNC(..., <+...LEN...+>, ...)
> )
>
> It matches net/sunrpc/addr.c:
>
> --- net/sunrpc/addr.c
> +++ /tmp/cocci-output-43547-394eff-addr.c
> @@ -79,7 +79,7 @@ static size_t rpc_ntop6(const struct soc
>         if (sin6->sin6_scope_id == 0)
>                 return len;
>
> -       rc = snprintf(scopebuf, sizeof(scopebuf), "%c%u",
> +       rc = scnprintf(scopebuf, sizeof(scopebuf), "%c%u",
>                         IPV6_SCOPE_DELIMITER, sin6->sin6_scope_id);
>         if (unlikely((size_t)rc > sizeof(scopebuf)))
>                 return 0;
>
> But I can't figure out why. I was trying to exclude matches against
> sc?nprintf, but the FUNC line appears to make things crazy and break
> the "when" check. If I remove the FUNC portion of the pattern, it's
> fine, but then I miss a bunch of cases I *do* want to catch, etc.

Can you send an example of something that you expect to match but don't,
or don't expect to match but do?

I'm not sure that you need a regular expression here.  If there are just
two functions that you don't want to match, you can say:

identifier FUNC != {func1,func2};

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
