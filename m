Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB2DCE8D49
	for <cocci@archiver.kernel.org>; Thu, 19 Sep 2024 06:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=OZuqA97ej9SOaI/vTpBcIYBQJ5KlkVSZ9zI8F+YYuaU=;
  b=X/3pfJmLkZ7kCnHeX09tRLgAn75BQvFqCn7isI3G5la/CstS3YGHu5uV
   1OA3fQkIJPa1GQnun+X/DQfKFuMEbPP/ZGhUngCHB8KBrXXbkhuzhBoyt
   HC2lb0+q86cExYvIgZBu+DGnJ9jPHs3TbJkDhZ0ZVJSnBj7R4FHoSjED3
   k=;
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
X-IronPort-AV: E=Sophos;i="6.10,241,1719871200"; 
   d="scan'208";a="183915533"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Sep 2024 08:25:50 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1A7A0E0AF1; Thu, 19 Sep 2024 08:25:50 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 621F4E0131
	for <cocci@sympa.inria.fr>; Thu, 19 Sep 2024 08:25:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OZuqA97ej9SOaI/vTpBcIYBQJ5KlkVSZ9zI8F+YYuaU=;
  b=Uaor4ODMo0xIGJjysiw9ZeyqHd/Ux+wD8s1CRB0biQYN+mIK8HIJ4vI+
   JILyBGZmvCsX4UfM7PstDlIeFb4j4qLBYQX9wFR7Yt+teQOyRh1fN6TzO
   Nq2nQ7mHTbvKIjQtJAk12lLfUzg26A/cDC17eJlGzxwvdJVNq9vRuCXxC
   Q=;
X-IronPort-AV: E=Sophos;i="6.10,241,1719871200"; 
   d="scan'208";a="96784530"
Received: from 81-223-29-78.static.upcbusiness.at (HELO hadrien) ([81.223.29.78])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 08:25:46 +0200
Date: Thu, 19 Sep 2024 08:25:45 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Hongbo Li <lihongbo22@huawei.com>
cc: kees@kernel.org, andy@kernel.org, nicolas.palix@imag.fr, 
    linux-hardening@vger.kernel.org, cocci@inria.fr
In-Reply-To: <20240911010927.741343-2-lihongbo22@huawei.com>
Message-ID: <2aefba9e-f04e-4ee6-60cb-a139c0641ff1@inria.fr>
References: <20240911010927.741343-1-lihongbo22@huawei.com> <20240911010927.741343-2-lihongbo22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH -next v3 01/10] coccinelle: Add rules to find
 str_true_false() replacements
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1870
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/2aefba9e-f04e-4ee6-60cb-a139c0641ff1%40inria.fr>



On Wed, 11 Sep 2024, Hongbo Li wrote:

> After str_true_false() has been introduced in the tree,
> we can add rules for finding places where str_true_false()
> can be used. A simple test can find over 10 locations.
>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  scripts/coccinelle/api/string_choices.cocci | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
> index 5e729f187f22..6942ad7c4224 100644
> --- a/scripts/coccinelle/api/string_choices.cocci
> +++ b/scripts/coccinelle/api/string_choices.cocci
> @@ -85,3 +85,22 @@ e << str_down_up_r.E;
>  @@
>
>  coccilib.report.print_report(p[0], "opportunity for str_down_up(%s)" % e)
> +
> +@str_true_false depends on patch@
> +expression E;
> +@@
> +-      ((E) ? "true" : "false")
> ++      str_true_false(E)
> +
> +@str_true_false_r depends on !patch exists@
> +expression E;
> +position P;
> +@@
> +*      ((E@P) ? "true" : "false")

Hello,

The semantic patch is quite slow.  Actually it tests a large number of
cases, eg where the parentheses are present and where they are not.

A small optimization is possible in the non-patch case.  The outer
parentheses are not needed, because you will already get the same
information whether they are there or not.

In contrast, for the patch case, the outer parentheses are needed, because
if they are there we want to remove them, since they are not needed for
the function call.

Could you update the depends on !patch cases to remove the outer
parentheses?

Also, just one patch would be fine.  There are many changes, but they are
all sort of the same, so it would be easier just to see them all at once.

thanks,
julia


> +
> +@script:python depends on report@
> +p << str_true_false_r.P;
> +e << str_true_false_r.E;
> +@@
> +
> +coccilib.report.print_report(p[0], "opportunity for str_true_false(%s)" % e)
> --
> 2.34.1
>
>
