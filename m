Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673B5C54798
	for <cocci@archiver.kernel.org>; Thu,  7 Mar 2024 19:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ytqV8GIHGsssUNmOr+7imHSVJAAKpkErNn47RU5/uXc=;
  b=vxMoTPFCjXumt1j7dUqMxpnKHfbUzbpp46FI5kP26J/tZfmkG5/sWB07
   QZaVJOMLUgNFbp7r+uZrDJo8kJv3Gg6o3TzRiORx7QTm5St06klH/1sxr
   u7EAdb9+9zl4GSPqcjATqaBDkaB7bQLM3vKyNexiOW7W5/jU18SSRi2dO
   s=;
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
X-IronPort-AV: E=Sophos;i="6.07,107,1708383600"; 
   d="scan'208";a="155563466"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Mar 2024 20:12:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 82B23E00B7; Thu,  7 Mar 2024 20:12:18 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A35EBE0035
	for <cocci@sympa.inria.fr>; Thu,  7 Mar 2024 20:12:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ytqV8GIHGsssUNmOr+7imHSVJAAKpkErNn47RU5/uXc=;
  b=bj4VeWVDMvdRQu38BabnaFVM8oGD+TA3BFk4SkGQIfZX2ja2b+CVe/vE
   n4PU7idGFgn+qud4H3VPYEkeOkdUH/scmYSTVuxlS9AliCji19kU5hDMr
   tbSAx1maAHXvpgxQvthiXYM+DAW2vwQGwq4NWdeMXd/zWdr2fQvfVsGGk
   s=;
X-IronPort-AV: E=Sophos;i="6.07,107,1708383600"; 
   d="scan'208";a="155563463"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 20:12:17 +0100
Date: Thu, 7 Mar 2024 20:12:17 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>
cc: "cocci@inria.fr" <cocci@inria.fr>, 
    "peterz@infradead.org" <peterz@infradead.org>, 
    "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
    "Brady, Alan" <alan.brady@intel.com>, 
    "Keller, Jacob E" <jacob.e.keller@intel.com>
In-Reply-To: <CO1PR11MB49149F1167679926A2917E0997202@CO1PR11MB4914.namprd11.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2403072004020.3161@hadrien>
References: <CO1PR11MB49149F1167679926A2917E0997202@CO1PR11MB4914.namprd11.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1482257681-1709838737=:3161"
Subject: Re: [cocci] question about kernel cocci and cleanup.h
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1609
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-03/alpine.DEB.2.22.394.2403072004020.3161%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1482257681-1709838737=:3161
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 7 Mar 2024, Brandeburg, Jesse wrote:

>
> Hi Julia and team, I had a question about whether it’s possible to use coccinelle/spatch to start to identify functions which are able to use inline destructors (__free or DEFINE_FREE()) from include/linux/cleanup.h

Surely.  I did some experiments with of_node_put already, with nice
results (much simpler code).

> To some extent a missing kfree logic is already part of the scripts/cocci, but what I was curious about is whether spatch can find
>
>  1. Function that allocates a stack variable which is a pointer (or has one passed as a pointer argument)
>  2. Function calls *alloc
>  3. Function calls kfree() before return in all paths after alloc

That should all be doable.

> There is also a variant of the above cleanup.h macros for functions that acquire a lock but need to release it before returning.
>
> I know this would be nearly impossible to auto-patch, but having a “grep” for this pattern would be super helpful.
>
> Would someone be interested in looking at this for the kernel? It seems like a valuable help to find refactoring locations.
>
> Thoughts?

The main challenge would be as always knowing what the complete set of
relevant allocation functions is.  Or maybe actually only the freeing
functions are important.  There are cases where the freeing function is
just kfree, but the allocation function is some wrapper.

At least for of_node_put, there seemed to be many cases that could be
patched automatically.  There just need to be some rules to clean up if
branches, gotos that are no longer necessary, etc.

Anyway, I proposed an outreachy internship to work on of_node_put, and
more if time permits.  The point was to have someone who would have time
to focus on it (the intern), but also have someone else to look through
all the patches, check for coding style issues etc, to avoid flooding
maintainers with too many problems.

I'll see what my of_node_put patches come up with for kfree though.

julia
--8323329-1482257681-1709838737=:3161--
