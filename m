Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF2CC0015E
	for <cocci@archiver.kernel.org>; Wed, 26 Jul 2023 20:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=OZA55SnNbAmvZEmnAh3o1Vey5rx64nx3FOwYsy8KhWI=;
  b=hNBsg9fk+nw3iZvT90hRueCwhlW/a+Ntk5osuMP0kVhZIu8H1jNdhoAM
   H0MJzBxj0gJI8MNJcylTIh4N5kZMp74L5JDkwNh5sztbMY2l8FMYC/Ead
   LNfDG+heq71tlc6n0Ts2N5O9ylHC+daxeYwfa8xfttWO77QVYchQvS3p6
   E=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.01,232,1684792800"; 
   d="scan'208";a="119229648"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Jul 2023 22:42:38 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 019E3E0138; Wed, 26 Jul 2023 22:42:37 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 258D0E004E
	for <cocci@sympa.inria.fr>; Wed, 26 Jul 2023 22:42:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OZA55SnNbAmvZEmnAh3o1Vey5rx64nx3FOwYsy8KhWI=;
  b=uCEDxfvQKI+OZ89DzhponjbY3VXv/Yryua8IgoxBZ9UIaendxM9D4OwW
   /3hyo6rHOZX3mmqNZc3Ek+iDJgWSyKbZ3hN/Veb92iLre72eWFOy7w/8T
   VUfzwM7DNGiP4hVKDO4iEuPMWGznDh7sQkb8XLv3Ut6S3bC2a6BuOQk5E
   Q=;
X-IronPort-AV: E=Sophos;i="6.01,232,1684792800"; 
   d="scan'208";a="119229647"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 22:42:35 +0200
Date: Wed, 26 Jul 2023 22:42:34 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Sean Christopherson <seanjc@google.com>
cc: Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org, 
    cocci@inria.fr, Paolo Bonzini <pbonzini@redhat.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20230726202920.507756-1-seanjc@google.com>
Message-ID: <alpine.DEB.2.22.394.2307262242160.3129@hadrien>
References: <20230726202920.507756-1-seanjc@google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH v2] Revert "debugfs, coccinelle: check for
 obsolete DEFINE_SIMPLE_ATTRIBUTE() usage"
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1217
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-07/alpine.DEB.2.22.394.2307262242160.3129%40hadrien>



On Wed, 26 Jul 2023, Sean Christopherson wrote:

> Remove coccinelle's recommendation to use DEFINE_DEBUGFS_ATTRIBUTE()
> instead of DEFINE_SIMPLE_ATTRIBUTE().  Regardless of whether or not the
> "significant overhead" incurred by debugfs_create_file() is actually
> meaningful, warnings from the script have led to a rash of low-quality
> patches that have sowed confusion and consumed maintainer time for little
> to no benefit.  There have been no less than four attempts to "fix" KVM,
> and a quick search on lore shows that KVM is not alone.
>
> This reverts commit 5103068eaca290f890a30aae70085fac44cecaf6.

Applied.

>
> Link: https://lore.kernel.org/all/87tu2nbnz3.fsf@mpe.ellerman.id.au
> Link: https://lore.kernel.org/all/c0b98151-16b6-6d8f-1765-0f7d46682d60@redhat.com
> Link: https://lkml.kernel.org/r/20230706072954.4881-1-duminjie%40vivo.com
> Link: https://lore.kernel.org/all/Y2FsbufV00jbyF0B@google.com
> Link: https://lore.kernel.org/all/Y2ENJJ1YiSg5oHiy@orome
> Link: https://lore.kernel.org/all/7560b350e7b23786ce712118a9a504356ff1cca4.camel@kernel.org
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>
> v2: Fix a copy+paste goof in the changelog, add Greg's Ack.
>
>  .../api/debugfs/debugfs_simple_attr.cocci     | 68 -------------------
>  1 file changed, 68 deletions(-)
>  delete mode 100644 scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
>
> diff --git a/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci b/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
> deleted file mode 100644
> index 7c312310547c..000000000000
> --- a/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
> +++ /dev/null
> @@ -1,68 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/// Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE
> -/// for debugfs files.
> -///
> -//# Rationale: DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file()
> -//# imposes some significant overhead as compared to
> -//# DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe().
> -//
> -// Copyright (C): 2016 Nicolai Stange
> -// Options: --no-includes
> -//
> -
> -virtual context
> -virtual patch
> -virtual org
> -virtual report
> -
> -@dsa@
> -declarer name DEFINE_SIMPLE_ATTRIBUTE;
> -identifier dsa_fops;
> -expression dsa_get, dsa_set, dsa_fmt;
> -position p;
> -@@
> -DEFINE_SIMPLE_ATTRIBUTE@p(dsa_fops, dsa_get, dsa_set, dsa_fmt);
> -
> -@dcf@
> -expression name, mode, parent, data;
> -identifier dsa.dsa_fops;
> -@@
> -debugfs_create_file(name, mode, parent, data, &dsa_fops)
> -
> -
> -@context_dsa depends on context && dcf@
> -declarer name DEFINE_DEBUGFS_ATTRIBUTE;
> -identifier dsa.dsa_fops;
> -expression dsa.dsa_get, dsa.dsa_set, dsa.dsa_fmt;
> -@@
> -* DEFINE_SIMPLE_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);
> -
> -
> -@patch_dcf depends on patch expression@
> -expression name, mode, parent, data;
> -identifier dsa.dsa_fops;
> -@@
> -- debugfs_create_file(name, mode, parent, data, &dsa_fops)
> -+ debugfs_create_file_unsafe(name, mode, parent, data, &dsa_fops)
> -
> -@patch_dsa depends on patch_dcf && patch@
> -identifier dsa.dsa_fops;
> -expression dsa.dsa_get, dsa.dsa_set, dsa.dsa_fmt;
> -@@
> -- DEFINE_SIMPLE_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);
> -+ DEFINE_DEBUGFS_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);
> -
> -
> -@script:python depends on org && dcf@
> -fops << dsa.dsa_fops;
> -p << dsa.p;
> -@@
> -msg="%s should be defined with DEFINE_DEBUGFS_ATTRIBUTE" % (fops)
> -coccilib.org.print_todo(p[0], msg)
> -
> -@script:python depends on report && dcf@
> -fops << dsa.dsa_fops;
> -p << dsa.p;
> -@@
> -msg="WARNING: %s should be defined with DEFINE_DEBUGFS_ATTRIBUTE" % (fops)
> -coccilib.report.print_report(p[0], msg)
>
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> --
> 2.41.0.487.g6d72f3e995-goog
>
>
