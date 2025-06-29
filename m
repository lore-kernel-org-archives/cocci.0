Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC8AC7EE39
	for <cocci@archiver.kernel.org>; Sun, 29 Jun 2025 20:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=fgSo4/p5Z38PJx0oo0rZPZWCtfuVxFo70RmNEd2RwGY=;
  b=g4OrTQmc6sA1kCxvwc6I605RS8X+dO8bNzR9rXj7DB9tmKs1jesbgSEu
   x/uBrUVkbt/UIrUxvrw2eXCYsKa1rcrq/eMZWzfDKyfGuAM7rNEvHLpcc
   xXdaWkVYdv1zUiVs0Xfkye7dwoQhZFl7EzVOLiBtdDz7i3/4LfzT04JaE
   0=;
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.16,276,1744063200"; 
   d="scan'208";a="229478603"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jun 2025 22:11:38 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A67EDE01A8; Sun, 29 Jun 2025 22:11:38 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9B09CE0131
	for <cocci@sympa.inria.fr>; Sun, 29 Jun 2025 22:11:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fgSo4/p5Z38PJx0oo0rZPZWCtfuVxFo70RmNEd2RwGY=;
  b=aYdC0fTistpPpTj2Mj/epFjaJbmyMQgT6rRkZXjOquIj2/XUp3KPC8sj
   FcwllbwKtZjxO7HWBHzoUb/yX0JaSy2HHjcqMbGjzRbdHiGuVA+RSfWs8
   vKMqq5GPpNTku99dpY6MmdUvXdR4Fk/cgD15CpztgU7kI2+mirNuR5IHJ
   0=;
X-IronPort-AV: E=Sophos;i="6.16,276,1744063200"; 
   d="scan'208";a="120234930"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 22:11:34 +0200
Date: Sun, 29 Jun 2025 22:11:33 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: devnoname120 <devnoname120@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <1a234d32-e87d-414b-8566-490618417f6c@Spark>
Message-ID: <alpine.DEB.2.22.394.2506292210480.95572@hadrien>
References: <7c65be39-dfc3-4b9c-9acd-dd94d1225db8@Spark> <alpine.DEB.2.22.394.2506291925100.95572@hadrien> <55f3b1f1-2537-4bc3-88d3-d7da1136060a@Spark> <alpine.DEB.2.22.394.2506292109470.95572@hadrien> <1a234d32-e87d-414b-8566-490618417f6c@Spark>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-887714852-1751227893=:95572"
Subject: Re: [cocci] [HELP] Using macro `randomized_struct_fields_end` as
 context?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2821
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/alpine.DEB.2.22.394.2506292210480.95572%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-887714852-1751227893=:95572
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 29 Jun 2025, devnoname120 wrote:

> Unfortunately this solution adds it to the very end of the task_struct struct.
>  
> @r depends on file in "include/linux/sched.h" exists@
> field f;
> @@
>  
> struct task_struct {
> ...
> f
> };
>
> @@
> field r.f;
> @@
>  
> struct task_struct {
> ...
> f
> +#ifdef CONFIG_KSU_SUSFS
> + u64 susfs_task_state;
> + u64 susfs_last_fake_mnt_id;
> +#endif
> ...
> };
>
>
> ❯ spatch --sp-file include/linux/sched.h.cocci --in-place --linux-spacing include/linux/sched.h
> init_defs_builtins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coccinelle/standard.h
> SPECIAL NAMES: adding u64 as a type
> HANDLING: include/linux/sched.h
> diff = 
> --- include/linux/sched.h
> +++ /tmp/cocci-output-56533-5a9482-sched.h
> @@ -1471,6 +1471,10 @@ struct task_struct {
>
>        /* CPU-specific state of this task: */
>        struct thread_struct            thread;
> +#ifdef CONFIG_KSU_SUSFS
> +       u64 susfs_task_state;
> +       u64 susfs_last_fake_mnt_id;
> +#endif
>
>        /*
>         * WARNING: on x86, 'thread_struct' contains a variable-sized
>  
>  
> It needs instead to be added right above randomized_struct_fields_end, which is what closes the anonymous struct.

OK, they were the same in the version of the kernel I had...

I will try one more thing...

julia


>  
> Thank you,
> Paul
> On Jun 29, 2025 at 21:18 +0200, Julia Lawall <julia.lawall@inria.fr>, wrote:
>  
>       Coocinelle has a file standard.h thta gives dummy definitions for some
>       macros.
>
>       This file already contains
>
>       #define randomized_struct_fields_start
>
>       So it seems quite reasonable that it should also contain
>
>       #define randomized_struct_fields_end
>
>       which then enables sched.h to parse.
>
>       With that change, you can use the following solution:
>
>       @r@
>       field f;
>       @@
>
>       struct task_struct {
>       ...
>       f
>       };
>
>       @@
>       field r.f;
>       @@
>
>       struct task_struct {
>       ...
>       f
>       + int something;
>       ...
>       };
>
>       That is, first match the last field in the structure. Then inherit thta
>       field into another rule and place the new stuff after it. The final ...
>       is important to force the added code to be attached to f. This will keep
>       it on top of the end marker, and on top of the associated comment as well.
>
>       julia
>        
>
>
>
--8323329-887714852-1751227893=:95572--
