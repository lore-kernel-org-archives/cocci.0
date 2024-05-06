Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83C7C25B4F
	for <cocci@archiver.kernel.org>; Mon,  6 May 2024 19:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=y4WGMO9bryRqHzdvXqX8JHN1xbU3NgS8boIGtDt6Syk=;
  b=QWgA2Cblu8shlv+iMxKOD3woDGWqVt5xLFYjJ73+3dwGnhuLaRHZOGNm
   EFdmGs5o/tCDaX0PxPe2mUkTQSL7SWj/8yGzCpVLhee+IyOurufNL74sE
   VSjXiD7SkI4EFGmaMaAFOV4k44UMLG+qBisng7EImTW2Q9aNjG1CfqNdZ
   Q=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.07,259,1708383600"; 
   d="scan'208";a="164743588"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 May 2024 21:42:40 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E1AE9E0145; Mon,  6 May 2024 21:42:39 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B8306E0035
	for <cocci@sympa.inria.fr>; Mon,  6 May 2024 21:42:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=y4WGMO9bryRqHzdvXqX8JHN1xbU3NgS8boIGtDt6Syk=;
  b=NF5FoZQVHSBu6L3rCTziShyF9iRcUDtTfIWq+LXu/shPNICSD5DSS5yn
   pTYwl7j9gea38muYWE0OsMjL9UjQUT4g+OsU/4yuY4hWSK9lQoeSCRW+y
   cp9zMvgA+IUXB5jvVA7Wiv0rTvpYv2sRPoThdddqav5LEcU/+MTDj+AIj
   0=;
X-IronPort-AV: E=Sophos;i="6.07,259,1708383600"; 
   d="scan'208";a="86505903"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 21:42:34 +0200
Date: Mon, 6 May 2024 21:42:33 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Lukas Wunner <lukas@wunner.de>
cc: Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
In-Reply-To: <ZjkZBvuXlZAodPAU@wunner.de>
Message-ID: <alpine.DEB.2.22.394.2405062136410.3284@hadrien>
References: <ZjkZBvuXlZAodPAU@wunner.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] coccinelle matching of identifiers
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1709
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/alpine.DEB.2.22.394.2405062136410.3284%40hadrien>



On Mon, 6 May 2024, Lukas Wunner wrote:

> Dear coccinelle maintainers,
>
> Linux kernel commit 5c6ca9d93665 ("X.509: Introduce scope-based
> x509_certificate allocation"), which is queued for v6.10 in this repo ...
>
>     https://git.kernel.org/herbert/cryptodev-2.6/c/5c6ca9d93665
>
> ... triggers scripts/coccinelle/null/eno.cocci:
>
>     ./crypto/asymmetric_keys/x509_cert_parser.c:69:9-15: ERROR: allocation function on line 68 returns NULL not ERR_PTR on failure
>     ./fs/gfs2/inode.c:1850:6-12: ERROR: allocation function on line 1842 returns NULL not ERR_PTR on failure
>     ./fs/smb/client/cifsfs.c:1186:6-12: ERROR: allocation function on line 1173 returns NULL not ERR_PTR on failure
>
> The first of these three errors is newly introduced by the above-linked
> commit, the other two already existed before.  All are false-positives.
>
> I would like to silence the newly-introduced false-positive and have
> attempted to do so using the small patch below.
>
> However the result is that *only* the newly-introduced false-positive is
> found and the other two are no longer found.  So the other way round than
> what I'm aiming for.
>
> I find this bewildering.  What am I doing wrong?
>
> FWIW, coccinelle version is 1.1.1.
>
> The newly introduced false-positive is triggered by the statement:
>
>     assume(!IS_ERR(cert));
>
> Which is a macro that expands to:
>
>     do { if (!!IS_ERR(cert)) __builtin_unreachable(); } while(0);
>
> The macro gives the compiler a hint that variable "cert" is not an error
> pointer, which prevents the compiler from adding an unnecessary check
> for that condition.
>
> Thanks!
>
> Lukas
>
> -- >8 --
>
> diff --git a/scripts/coccinelle/null/eno.cocci b/scripts/coccinelle/null/eno.cocci
> index 7107d6c8db9e..79112d51bee8 100644
> --- a/scripts/coccinelle/null/eno.cocci
> +++ b/scripts/coccinelle/null/eno.cocci
> @@ -26,10 +26,12 @@ x = \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|kmem_cache
>  @r depends on !patch exists@
>  expression x,E;
>  position p1,p2;
> +identifier assume;
>  @@
>
>  *x = \(kmalloc@p1\|kzalloc@p1\|kcalloc@p1\|kmem_cache_alloc@p1\|kmem_cache_zalloc@p1\|kmem_cache_alloc_node@p1\|kmalloc_node@p1\|kzalloc_node@p1\)(...)
>  ... when != x = E
> +    when != assume
>  * IS_ERR@p2(x)

The problem is that ... is searching along control-flow paths, and
Coccinelle only considers control-flow at the statement level, not within
expressions.

Maybe a reasonable solution would be just to consider that we really just
want to protect against if tests?  So

*x = \(kmalloc@p1\|kzalloc@p1\|kcalloc@p1\|kmem_cache_alloc@p1\|kmem_cache_zalloc@p1\|kmem_cache_alloc_node@p1\|kmalloc_node@p1\|kzalloc_node@p1\)(...)
... when != x = E
* if ( <+... IS_ERR@p2(x) ... +> )
  S1 else S2

where S1 and S2 are declared as statement metavariables.

Another option is:

x = \(kmalloc@p1\|kzalloc@p1\|kcalloc@p1\|kmem_cache_alloc@p1\|kmem_cache_zalloc@p1\|kmem_cache_alloc_node@p1\|kmalloc_node@p1\|kzalloc_node@p1\)(...)
... when != x = E
(
assume(!IS_ERR(x));
|
* IS_ERR(x)
)

In this case, only the IS_ERR is marked with a *, because if we also
marked the initial assignment, that would get highlighted regardless of
which branch of the disjunction was matched.

julia

