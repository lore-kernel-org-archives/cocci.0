Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6500CA5FFC
	for <cocci@archiver.kernel.org>; Wed,  7 Oct 2026 18:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Wgq+kVLiaScSBuYufgs1A4KejF3YRVrCItO6QYXPlSc=;
  b=uvSXrx5wMerjKWUjAw7q/zmVaXmmojPw6hhdnm8jxozq8x/kr+KjIVmk
   dWtpk//4a0KZwRCsX0p/eMGO6vVIlOzixJXXoK7aZPWEW72D6gmK8DBwH
   nUsDNDLOY5/a2xDgYL9NIxiklIpvfU7ye6priZR7fS4fBznHbQyA/W41Z
   U=;
X-CSE-ConnectionGUID: 9rTJ84xmQnap2pJM42r10Q==
X-CSE-MsgGUID: XgiE05VQQNO2Xof4A6aiBg==
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
X-IronPort-AV: E=Sophos;i="6.27,144,1787004000"; 
   d="scan'208";a="299023495"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Oct 2026 20:27:37 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 31F0F81479; Wed,  7 Oct 2026 20:27:37 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 842EB806A7
	for <cocci@sympa.inria.fr>; Wed,  7 Oct 2026 20:27:34 +0200 (CEST)
X-CSE-ConnectionGUID: ++oYlZDdQ8CdBfLQ60/ZBA==
X-CSE-MsgGUID: 7H9QVZziTxGye6MKvPA2jA==
X-IronPort-AV: E=Sophos;i="6.27,144,1787004000"; 
   d="scan'208";a="159154691"
Received: from ip-78-44-132-10.bb.vodafone.cz (HELO hadrien) ([78.44.132.10])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 20:27:34 +0200
Date: Wed, 7 Oct 2026 20:27:33 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Ella Ma <alansnape3058@gmail.com>
cc: cocci@inria.fr, linux-kernel@vger.kernel.org, nicolas.palix@imag.fr
In-Reply-To: <20261007164316.15102-1-alansnape3058@gmail.com>
Message-ID: <f635d9fd-8dd5-47f-7996-239bc74bd828@inria.fr>
References: <ec578f57-a7f5-7afc-ec2-9156c336187@inria.fr> <20261007164316.15102-1-alansnape3058@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH v3] coccinelle: free: add a checker for
 `__cleanup(kfree)` usage
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3748
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-10/V_a8RSjFrwNOC68UZZb5cA>



On Wed, 7 Oct 2026, Ella Ma wrote:

> Using __cleanup(kfree) will pass the stack address of the annotated
> local variable to kfree functions. This will lead to invalid
> deallocation issues. Inspired by CVE-2026-45959 and similar bugs
> recently detected.
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
> Changes in v3:
> - Edit the error messages to clarify the reasons and results
>
>  scripts/coccinelle/free/cleanup-free.cocci | 112 +++++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 scripts/coccinelle/free/cleanup-free.cocci
>
> diff --git a/scripts/coccinelle/free/cleanup-free.cocci b/scripts/coccinelle/free/cleanup-free.cocci
> new file mode 100644
> index 000000000000..48e47ed2186a
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
> +msg = f"ERROR: __cleanup({n}) will cause an invalid free: the stack address of the annotated variable will be passed to {n}; use __free({n}) to free the pointee"
> +coccilib.report.print_report(p[0], msg)
> +
> +@script:python depends on org@
> +p << free.p;
> +n << free.n;
> +@@
> +
> +msg = f"ERROR: __cleanup({n}) will cause an invalid free: the stack address of the annotated variable will be passed to {n}; use __free({n}) to free the pointee"
> +coccilib.org.print_todo(p[0], msg)
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
> +msg = f"ERROR: __cleanup({n}) will cause an invalid free: the stack address of the annotated variable will be passed to {n}"
> +coccilib.report.print_report(p[0], msg)

Hello, this is more words, but is not what I was hoping for.  You explain
the effect, but not the cause.  And to fix the bug with confidence the
reader wants to know the cause.  Here I would have expected something like
"__cleanup usage for a function without a DEFINE_FREE definition. This will cause an invalid free"

julia


> +
> +@script:python depends on org@
> +p << cleanup.p;
> +n << cleanup.n;
> +@@
> +
> +msg = f"ERROR: __cleanup({n}) will cause an invalid free: the stack address of the annotated variable will be passed to {n}"
> +coccilib.org.print_todo(p[0], msg)
> --
> 2.34.1
>
>
