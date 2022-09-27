Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FD4C54EE9
	for <cocci@archiver.kernel.org>; Tue, 27 Sep 2022 20:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=UhtfSf1oNY1PjuuP3yhQrZHiIbrG6zhdHtNhL3Yo1WA=;
  b=Jhf4EqmtqCdAr2UFvdQn1qZGaLg4EpZXPxxWNe88Z7+YE0ZnTchnY0fn
   GUj0sU1Q5O4n2Vfn+nI1hYdvKKRHxqaFxqV4Hb8Xq1EoRPHz2uMpcRZqL
   SH/Z54JM3vI/nyddAt2Hir7lFIV1WAdv3ErS7wJvzldTa/E8i9fefqWEp
   8=;
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
X-IronPort-AV: E=Sophos;i="5.93,350,1654552800"; 
   d="scan'208";a="54822599"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Sep 2022 22:37:17 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 244C3E0241; Tue, 27 Sep 2022 22:37:17 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E0255E0076
	for <cocci@sympa.inria.fr>; Tue, 27 Sep 2022 22:37:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UhtfSf1oNY1PjuuP3yhQrZHiIbrG6zhdHtNhL3Yo1WA=;
  b=ctYDkUKDVkVbpR8RySPD8NCof7WlFK51sTdxNPpoFCFyK8ok1QhDS0ID
   Y4QswNTF4z89dbhyi4ik/eLzAKU7QBbYyxj8K8xSYXsyi9nVbO/1K/z7o
   f8Zxk8dojh+ujwp0B4bKmfLq1K20vYkMI0pGnunIqFjNHIhTAxq/hGtS+
   c=;
X-IronPort-AV: E=Sophos;i="5.93,350,1654552800"; 
   d="scan'208";a="24846320"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 22:37:08 +0200
Date: Tue, 27 Sep 2022 22:37:07 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Kees Cook <keescook@chromium.org>
cc: cocci@inria.fr, linux-hardening@vger.kernle.org, 
    "Gustavo A. R. Silva" <gustavoars@kernel.org>
In-Reply-To: <202209261505.9AE38B8@keescook>
Message-ID: <alpine.DEB.2.22.394.2209272235060.2842@hadrien>
References: <202209260912.8DCCD70@keescook> <alpine.DEB.2.22.394.2209262259030.2915@hadrien> <202209261505.9AE38B8@keescook>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] spatch --jobs N missing matches?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 592
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/alpine.DEB.2.22.394.2209272235060.2842%40hadrien>



On Mon, 26 Sep 2022, Kees Cook wrote:

> On Mon, Sep 26, 2022 at 11:14:55PM +0200, Julia Lawall wrote:
> > I likewise see the following puzzling behavior:
>
> Okay, that's a relief -- I'm usually holding it wrong. :P
>
> > [...]
> > So it worked when I tried only one .c file, but not when I tried the whole
> > directory.  When I put some tracing (--debug --show-trying) it seems to be
> > considering only the .c file in the full directory case, not the header
> > file.  I will look into it.
>
> Thank you! If you end up with patches, I'm happy to try them out. I've
> got a fresh build of the latest cocci git tree building, so I can easily
> test changes.

The problem is fixed in github.  Coccinelle was doing some caching of
header files, that was not desirable in the case where one actually wants
to match the code, and not just get type information.

The change may affect any semantic patch that uses --recursive-includes.

julia

>
> > In the short term, you could try using the option --selected-only to get a
> > list of files considered to be relevant, and then run Coccinelle on each
> > of them individually.
>
> Ah-ha! I hadn't noticed --selected-only, that's nicer than my
> sorta-by-hand version of just using "git grep memcpy | filter...", but
> yes, that's what I ran a while ago. I see it just finished after two
> hours. :) But it found (what I hope is) the full set!
>
> --- ./drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c
> --- ./drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
> --- ./drivers/platform/surface/surface_acpi_notify.c
> --- ./drivers/s390/net/qeth_l2_main.c
> --- ./drivers/w1/w1_netlink.c
> --- ./fs/dlm/requestqueue.c
> --- ./net/sched/cls_u32.c
> --- ./net/wireless/nl80211.c
>
> real    111m15.762s
>
> Thanks for taking a look at this!
>
> --
> Kees Cook
>
