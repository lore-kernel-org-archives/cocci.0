Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB66C4332F
	for <cocci@archiver.kernel.org>; Thu, 20 Oct 2022 05:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=YqeDH2g2tPjSVgZS463Jr6mr8ukXfdumrGfuj5YcSdI=;
  b=I73M2jnEapAa7meDrxaG0rovzrJTTgeVy4HURhfowr7gKWnbz8f+JvDY
   olrFhObDdJL8gbSnWLLlVckYN5iefTr72TI8NTcjtZbSYoG27hCnnyZhv
   Vtsb9VpeiDDLwoKGEYO39gneW/zAICPYED+6b4H241Fbd+kUMVPy81EM3
   U=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.95,198,1661810400"; 
   d="scan'208";a="66069524"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Oct 2022 07:23:38 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 54204E013D; Thu, 20 Oct 2022 07:23:38 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D0B18E004E
	for <cocci@sympa.inria.fr>; Thu, 20 Oct 2022 07:23:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YqeDH2g2tPjSVgZS463Jr6mr8ukXfdumrGfuj5YcSdI=;
  b=f4G92yt4y1RvIuOOddBAtxXOTIhJ3PJZVOhBhrLEvNXHK9ZhA6ZV1YWV
   Jb9siDrsflUw37zr1PO+UFRHpa7LO83CFfa0zwCsWqCcM7BQHQSerWHkf
   LGVXnEMJmPsQR0F2Kc+vFSubhHUEVzKZwwVFUJ2/l3a3FfonxOZsq1oi0
   4=;
X-IronPort-AV: E=Sophos;i="5.95,198,1661810400"; 
   d="scan'208";a="66069521"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 07:23:34 +0200
Date: Thu, 20 Oct 2022 07:23:34 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Kees Cook <kees@kernel.org>
cc: Kees Cook <keescook@chromium.org>, cocci@inria.fr, 
    "Darrick J. Wong" <djwong@kernel.org>
In-Reply-To: <BCF9DF09-DF10-48AC-B689-B97C03900CC5@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2210200723020.2988@hadrien>
References: <202210191620.171E11C@keescook> <alpine.DEB.2.22.394.2210200639050.2988@hadrien> <BCF9DF09-DF10-48AC-B689-B97C03900CC5@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] coccinelle is skipping include files?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 658
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/alpine.DEB.2.22.394.2210200723020.2988%40hadrien>



On Wed, 19 Oct 2022, Kees Cook wrote:

> On October 19, 2022 9:43:35 PM PDT, Julia Lawall <julia.lawall@inria.fr> wrote:
> >> The example I'm looking at is fs/xfs/xfs_bmap_item.c, which starts with:
> >> #include "xfs.h"
> >> #include "xfs_fs.h"
> >> #include "xfs_format.h"
> >> #include "xfs_log_format.h"
> >> ...
> >You may want to start with the option --verbose-includes for such
> >problems.
>
> Ah-ha, thanks!
>
> >The problem is that Coccinelle can't find the file.  Your .c file is in
> >fs/xfs, and despite the lack of a complete path, the header file is in
> >a subdirectory: fs/xfs/libxfs.  So you could add -I fs/xfs/libxfs to your
> >command line.
>
> Ugh, yes, I see this now. It looks like we need to parse the Makefiles? :(
>
> >Another solution is the option --relax-include-path.  This should cause
> >Coccinelle to look over the entire kernel to see if it can find exactly
> >one file named xfs_log_format.h.  If only one exists, that has to be the
> >one you want.
>
> Interesting solution, and would work here. I wonder if there needs to be a "fail I Coccinelle fails to find a header" option? Hmmm

What do you mean by fail?  Do you want spatch to stop completely, or the
file to just be ignored?

julia
