Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591ACECAAD8
	for <cocci@archiver.kernel.org>; Sun, 18 Sep 2022 19:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=GB7MBOnne7+SW7POk2iwBoBCdPzCXDZqlZgA20s5q8E=;
  b=oKI01vxt4ERC73MB9uGhFxcPZupgMlM4J7Aj6eUEGvqqtI9oTTiFSQ+F
   bwHhFSS2Iq7yi2EJRx/khgoHtFFs728A1u3lmTJnawyiRXaLQeEroJhxi
   EhTSqk/9crZwLFNVtM+3QAx4bjExaOiRVtt2N/2k41yxTQdZhof8LwD3J
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.93,325,1654552800"; 
   d="scan'208";a="53316864"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Sep 2022 21:39:33 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0DBBFE019E; Sun, 18 Sep 2022 21:39:33 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C40B7E0157
	for <cocci@sympa.inria.fr>; Sun, 18 Sep 2022 21:39:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GB7MBOnne7+SW7POk2iwBoBCdPzCXDZqlZgA20s5q8E=;
  b=dAFzZFhhdxTS3/uaaokFFXKfS8shYq5POvhXUTTiq7NEUScwLt4AxtXF
   8mNcrJ3jnooy5kmyimhPrbFkUBnIkN5l9i23kLMW8TScGxuXURNxldvQm
   d2El3PYdIapcJ6yx7ekVvlM32c6EOYpAXeomWWNfoti/szCMyF0OXUi+Z
   w=;
X-IronPort-AV: E=Sophos;i="5.93,325,1654552800"; 
   d="scan'208";a="53316861"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 21:39:28 +0200
Date: Sun, 18 Sep 2022 21:39:28 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Yuan Can <yuancan@huawei.com>
cc: nicolas.palix@imag.fr, cocci@inria.fr
In-Reply-To: <20220916061923.29759-1-yuancan@huawei.com>
Message-ID: <alpine.DEB.2.22.394.2209182132260.3003@hadrien>
References: <20220916061923.29759-1-yuancan@huawei.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH 1/2] coccinelle: locks: add
 missing_mutex_init.cocci script
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 554
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/alpine.DEB.2.22.394.2209182132260.3003%40hadrien>

On Fri, 16 Sep 2022, Yuan Can wrote:

> Find mutex used without init, and point out the
> place the mutex is allocated.

Thank for the semantic patches.

Traditionally, the semantic patches in the Linux kernel have a Confidence:
tag above the Coyright: line.  I would suggest to put such a line in this
case, based on your experience.  From looking at a few results with the
mutex semantic patch (I didn't get any results with the spin lock semantic
patch, is that normal?), I would suggest a Low confidence.  The cases I
looked at seemed to involve calls across different files, and Coccinelle
is looking at only one file at a time.

I would also suggest to print out more information, to help the user
better undestand where the problem may be.  Specifically, it would be nice
to have the name of the lock field, the position of the declaration of
this field, and the position of the call to mutex_lock.  You already have
the relevant metavariables in r3, and can add a position metavariable in
r4.

Finally, you have a * at the beginning of the matched line in r5, so the
rule seems to support the context mode.  But if you want to support the
context mode and to highlight all of the mentioned places, you would have
to duplicate r3 and r4 with a depends on for r5, so that the context is
only shown when all of the conditions are satisfied.  For example, you
could have:

@dupr3 depends on r5@
identifier s, fld;
position r3.p;
@@

struct s {
  ...
* struct mutex fld@p;
  ...
};

Are there some patches in the Linux kernel that are based on these rules?

thanks,
julia

>
> Signed-off-by: Yuan Can <yuancan@huawei.com>
> ---
>  .../coccinelle/locks/missing_mutex_init.cocci | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 scripts/coccinelle/locks/missing_mutex_init.cocci
>
> diff --git a/scripts/coccinelle/locks/missing_mutex_init.cocci b/scripts/coccinelle/locks/missing_mutex_init.cocci
> new file mode 100644
> index 000000000000..bec8ce60d0c5
> --- /dev/null
> +++ b/scripts/coccinelle/locks/missing_mutex_init.cocci
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/// report missing mutex_init()
> +///
> +/// Report mutex used without initialize. False positives can occur
> +/// when the mutex allocation and initialization happens in two
> +/// different files.
> +///
> +// Copyright: (C) 2022 Huawei Technologies Co, Ltd.
> +// Comments:
> +// Options: --include-headers
> +
> +virtual org
> +virtual report
> +
> +@r1@
> +identifier s, fld;
> +struct s *mm;
> +@@
> +mutex_init(\(&mm->fld\|&(mm->fld)\))
> +
> +@r2@
> +identifier r1.s, r1.fld;
> +position p;
> +@@
> +
> +struct s {
> +  ...
> +  struct mutex fld@p;
> +  ...
> +};
> +
> +@r3@
> +identifier s, fld;
> +position p != {r2.p};
> +@@
> +
> +struct s {
> +  ...
> +  struct mutex fld@p;
> +  ...
> +};
> +
> +@r4@
> +identifier r3.fld;
> +identifier r3.s;
> +struct s *mm;
> +@@
> +
> +mutex_lock(&mm->fld)
> +
> +@r5 depends on r4@
> +identifier r3.s;
> +struct s *mm;
> +position p;
> +@@
> +* mm@p = \(kmalloc\|kzalloc\|devm_kmalloc\|devm_kzalloc\)(...)
> +
> +@script:python depends on org@
> +p << r5.p;
> +@@
> +cocci.print_main("Mutex inside the struct malloced here is possibly used without init.", p)
> +
> +@script:python depends on report@
> +p << r5.p;
> +@@
> +
> +msg = "Mutex inside the struct malloced here is possibly used without init."
> +coccilib.report.print_report(p[0], msg)
> --
> 2.17.1
>
>
