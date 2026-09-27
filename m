Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25D6C9830E
	for <cocci@archiver.kernel.org>; Sun, 27 Sep 2026 09:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=+WZh0bb5NmAt10ymsdHTt1ccdu2nJSsz3CMDIj2iZIg=;
  b=Aynums5cFpsBLOnzy1MNCAb8NcgZXTUsZSEMpXCTwPp7XYr2HCKYcRca
   w0JD5WIdwFl8yLFDJcCeMUgY5JbdDaayL1ETvLDqKYE39UXazjSFBrySb
   VA95YhQExkQAUOZbMAiMMonKmA+MF/1PAXsdMky+HiTi8HZ7Z23k0BPsR
   g=;
X-CSE-ConnectionGUID: i/NzpNmWQf+81XPHYiAnIQ==
X-CSE-MsgGUID: lq/EbyjrQ1S+XxiKjfWFkA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,126,1787004000"; 
   d="scan'208";a="297136920"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Sep 2026 11:44:03 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 9E00E81611; Sun, 27 Sep 2026 11:44:03 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 50C3A80F6C
	for <cocci@sympa.inria.fr>; Sun, 27 Sep 2026 11:44:00 +0200 (CEST)
X-CSE-ConnectionGUID: lu/urvJ4RFetAVR7Z3J3XA==
X-CSE-MsgGUID: Dncj5/fgS+COWeoMAM9T3Q==
X-IronPort-AV: E=Sophos;i="6.27,126,1787004000"; 
   d="scan'208";a="158108361"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 11:44:00 +0200
Date: Sun, 27 Sep 2026 11:43:59 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Ella Ma <alansnape3058@gmail.com>
cc: nicolas.palix@imag.fr, linux-kernel@vger.kernel.org, cocci@inria.fr
In-Reply-To: <20260924162522.912050-1-alansnape3058@gmail.com>
Message-ID: <ec578f57-a7f5-7afc-ec2-9156c336187@inria.fr>
References: <20260831134336.45540-1-alansnape3058@gmail.com> <20260924162522.912050-1-alansnape3058@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH v2] coccinelle: free: add a checker for
 `__cleanup(kfree)` usage
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3742
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-09/BTTeOckyYiCo-9kU7w9GTw>



On Thu, 24 Sep 2026, Ella Ma wrote:

> Using __cleanup(kfree) will pass the stack address of the annotated
> local variable to kfree functions. This will lead to invalid
> deallocation issues. Inspired by CVE-2026-45959 and similar bugs
> recently detected.

Thanks for the semantic patch.
I think it would be good for the error reports to be more explicit about
what the issue is, ie the relationship to the presence of absence of
DEFINE_FREE.  Otherwise, it is hard to completely understand the problem
without looking at the comments in the semantic patch.

julia

>
> Signed-off-by: Ella Ma <alansnape3058@gmail.com>
> ---
>
> Changes in v2:
> - Add virtual rules `report` and `org` as suggested by Sashiko
> - Remove `kvfree_sensitive` from rule `cleanup` as suggested by Sashiko
> - Add `free_percpu` to rule `free`
> - Add `kfree_const` to rule `cleanup`
>
> Currently, the five functions in the `free` rule are all the functions
> of `void (*)(const? void *)` type with a `DEFINE_FREE` definition in the
> code base. So I adopted all of them.
> Function `kfree_const` is added as it is of the kfree family and used
> more frequently than other kfree-family functions (even more frequently
> than some of those having a `DEFINE_FREE` definition).
> https://elixir.bootlin.com/linux/v7.3-rc3/A/ident/kfree_const
> (found in 64 files in v7.3-rc3).
>
> This cocci script can report the bug fixed in
> https://lore.kernel.org/lkml/20260617142632.3298984-1-vulab@iscas.ac.cn/
>
>  scripts/coccinelle/free/cleanup-free.cocci | 112 +++++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 scripts/coccinelle/free/cleanup-free.cocci
>
> diff --git a/scripts/coccinelle/free/cleanup-free.cocci b/scripts/coccinelle/free/cleanup-free.cocci
> new file mode 100644
> index 000000000000..63216ec5d865
> --- /dev/null
> +++ b/scripts/coccinelle/free/cleanup-free.cocci
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Find __cleanup(kfree)
> +/// Using __cleanup(kfree) will pass the stack address of the annotated
> +/// local variable to kfree, causing an invalid free.
> +/// I.e., `T v __cleanup(kfree);` --> `kfree(&v);`
> +/// Such usage is impossible to be correct.
> +///
> +// Confidence: High
> +// Copyright: (C) 2026 Ella Ma
> +// Options: --no-includes --include-headers
> +
> +virtual report
> +virtual org
> +
> +// Suggesting using __free for the functions with a DEFINE_FREE definition.
> +// Update this list when new DEFINE_FREE definitions are added.
> +@free@
> +attribute name __cleanup;
> +symbol kfree, kfree_sensitive, kvfree, kvfree_atomic, free_percpu;
> +type T;
> +identifier v, n;
> +position p;
> +@@
> +
> +(
> +  T v __cleanup@p(
> +(
> +  n
> +&
> +(
> +  kfree \| kfree_sensitive \| kvfree \| kvfree_atomic \| free_percpu
> +)
> +)
> +  );
> +|
> +  T v __cleanup@p(
> +(
> +  n
> +&
> +(
> +  kfree \| kfree_sensitive \| kvfree \| kvfree_atomic \| free_percpu
> +)
> +)
> +  ) = ...;
> +)
> +
> +@script:python depends on report@
> +p << free.p;
> +n << free.n;
> +@@
> +
> +coccilib.report.print_report(
> +  p[0], f"ERROR: found `__cleanup({n})', do you mean `__free({n})'?")
> +
> +@script:python depends on org@
> +p << free.p;
> +n << free.n;
> +@@
> +
> +coccilib.org.print_todo(
> +  p[0], f"ERROR: found `__cleanup({n})', do you mean `__free({n})'?")
> +
> +
> +// Reporting __cleanup usage for the functions without a DEFINE_FREE definition.
> +// The following list only contains frequently used functions. Supplement it if
> +// necessary.
> +@cleanup@
> +attribute name __cleanup;
> +symbol vfree, vfree_atomic, kfree_const;
> +type T;
> +identifier v, n;
> +position p;
> +@@
> +
> +(
> +  T v __cleanup@p(
> +(
> +  n
> +&
> +(
> +  vfree \| vfree_atomic \| kfree_const
> +)
> +)
> +  );
> +|
> +  T v __cleanup@p(
> +(
> +  n
> +&
> +(
> +  vfree \| vfree_atomic \| kfree_const
> +)
> +)
> +  ) = ...;
> +)
> +
> +@script:python depends on report@
> +p << cleanup.p;
> +n << cleanup.n;
> +@@
> +
> +coccilib.report.print_report(
> +  p[0], f"ERROR: `__cleanup({n})' will free the annotated variable, rather than its pointee")
> +
> +@script:python depends on org@
> +p << cleanup.p;
> +n << cleanup.n;
> +@@
> +
> +coccilib.org.print_todo(
> +  p[0], f"ERROR: `__cleanup({n})' will free the annotated variable, rather than its pointee")
> --
> 2.34.1
>
>
