Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016AFC54798
	for <cocci@archiver.kernel.org>; Thu,  7 Mar 2024 20:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=WJaUMQ5ckWX8gkxAh4JvDOGXE3GnveOPIUoqwZ02u3k=;
  b=QVpadnmSsmN+HE03mL62mc4gGeRwU/kG01WA6m5yoE81MD2pM1NypVrD
   /vdxxpRAEZis0LIBSmRAS4DbqL+/tQVsVuY1hyPnubjXe2yd3IVFqB5K2
   sI4VxF7W8YGKsPxpPq4fWP6x0Y476rXhVU1GLwP0OBK54REwt4VC/FWml
   U=;
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
   d="scan'208";a="155569153"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Mar 2024 21:59:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3C974E0CD5; Thu,  7 Mar 2024 21:59:15 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B4693E0035
	for <cocci@sympa.inria.fr>; Thu,  7 Mar 2024 21:59:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WJaUMQ5ckWX8gkxAh4JvDOGXE3GnveOPIUoqwZ02u3k=;
  b=vlVhFF2uBaf/SCnFEWml0jOq8wd/QIOwJnY1hkblP9VUr4iL9WBIYORo
   bs1MAXYZMcz6q757xSmHmTXstRBKHY4mskUbN6kJZ7amITOL/jXGaHiIC
   exy3xu0bQ6VXGUYAnR1TZhmHqtdNLFEw8BYbIJIclWewzTz9xTg4xHnHq
   s=;
X-IronPort-AV: E=Sophos;i="6.07,107,1708383600"; 
   d="scan'208";a="155569152"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 21:59:12 +0100
Date: Thu, 7 Mar 2024 21:59:12 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>
cc: Julia Lawall <julia.lawall@inria.fr>, "cocci@inria.fr" <cocci@inria.fr>, 
    "peterz@infradead.org" <peterz@infradead.org>, 
    "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
    "Brady, Alan" <alan.brady@intel.com>, 
    "Keller, Jacob E" <jacob.e.keller@intel.com>
In-Reply-To: <CO1PR11MB49149F1167679926A2917E0997202@CO1PR11MB4914.namprd11.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2403072154550.3161@hadrien>
References: <CO1PR11MB49149F1167679926A2917E0997202@CO1PR11MB4914.namprd11.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1462085857-1709845152=:3161"
Subject: Re: [cocci] question about kernel cocci and cleanup.h
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1610
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-03/alpine.DEB.2.22.394.2403072154550.3161%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1462085857-1709845152=:3161
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 7 Mar 2024, Brandeburg, Jesse wrote:

>
> Hi Julia and team, I had a question about whether it’s possible to use coccinelle/spatch to start to identify functions which are able to use inline destructors (__free or DEFINE_FREE()) from include/linux/cleanup.h
>
>  
>
> To some extent a missing kfree logic is already part of the scripts/cocci, but what I was curious about is whether spatch can find
>
>  
>
>  1. Function that allocates a stack variable which is a pointer (or has one passed as a pointer argument)
>  2. Function calls *alloc
>  3. Function calls kfree() before return in all paths after alloc
>
>  
>
> There is also a variant of the above cleanup.h macros for functions that acquire a lock but need to release it before returning.
>
>  
>
> I know this would be nearly impossible to auto-patch, but having a “grep” for this pattern would be super helpful.
>
>  
>
> Would someone be interested in looking at this for the kernel? It seems like a valuable help to find refactoring locations.

I tried the following semantic patch:

@@
identifier i;
type T;
statement S;
@@

*T i = \(kmalloc\|kcalloc\|kzalloc\)(...);
<... when strict
     when forall
     when != i = NULL
if (i == NULL) S
...>
*kfree(i);


@@
identifier i;
type T;
statement S;
@@

(
*T i;
|
*T i = NULL;
)
 ... when != i
*i = \(kmalloc\|kcalloc\|kzalloc\)(...);
<... when strict
     when forall
     when != i = NULL
if (i == NULL) S
...>
*kfree(i);

It doesn't make any changes, just finds opportunities.  It reported on
code in over 300 files.  I looked a few of them, and they seemed
plausible.  However, I have the impression that quite a lot of manual
effort would be needed to make these conversions.  The of_node_put ones
seem much simpler.  For kmalloc etc, I see a lot more code that makes one
wonder whether there is a dangling pointer somewhere, so in many examples,
it would be necessary to check a number of other called functions.

julia
--8323329-1462085857-1709845152=:3161--
