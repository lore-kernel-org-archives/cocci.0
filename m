Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12010C07E9D
	for <cocci@archiver.kernel.org>; Mon, 26 Sep 2022 21:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=/E7l3V6iAoyPITlFHSKw6AQ/gaIMFbIqPubEFNJJasw=;
  b=HwgnkE9V/n8ktSgE34G+59S/u6ROGSqgTEnfRpeY1AvHU74sf1u4v4VM
   hSH/+4Vw2JPLx21lue1a5qTT/KeFoDaiaDKHqCjiIi2VWQ//slvKmuwKw
   7R3+RMNyD9jCS/FEKgJvRtid+zsp0+YbdQiHrHWE1O998LV/9yqX+ILpQ
   s=;
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
X-IronPort-AV: E=Sophos;i="5.93,347,1654552800"; 
   d="scan'208";a="54616145"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Sep 2022 23:14:59 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D11A7E0091; Mon, 26 Sep 2022 23:14:58 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 773B8E0090
	for <cocci@sympa.inria.fr>; Mon, 26 Sep 2022 23:14:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/E7l3V6iAoyPITlFHSKw6AQ/gaIMFbIqPubEFNJJasw=;
  b=bvLR09n8WHAMS72p1u6XMZvq9CTPRfifhB6gRZe5dddq1/ijBtE212In
   eI6WozVww4sVdZ4mXwa70uOMm+rsNS1oxiJLWbGPk44P+9X1PwZfz/i3l
   EqGqqT1OIgjxiHoVZ42V+52GPMptqKnNFQbTq9tTtBMbEIfwWKj4SukyO
   E=;
X-IronPort-AV: E=Sophos;i="5.93,347,1654552800"; 
   d="scan'208";a="54616142"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 23:14:55 +0200
Date: Mon, 26 Sep 2022 23:14:55 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Kees Cook <keescook@chromium.org>
cc: cocci@inria.fr, linux-hardening@vger.kernle.org, 
    "Gustavo A. R. Silva" <gustavoars@kernel.org>
In-Reply-To: <202209260912.8DCCD70@keescook>
Message-ID: <alpine.DEB.2.22.394.2209262259030.2915@hadrien>
References: <202209260912.8DCCD70@keescook>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] spatch --jobs N missing matches?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 591
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/alpine.DEB.2.22.394.2209262259030.2915%40hadrien>



On Mon, 26 Sep 2022, Kees Cook wrote:

> Hi,
>
> I have been unable to figure out what is going wrong with spatch doing
> what seems like a simple match, but not finding correct results. Here is
> the .cocci file:
>
> ----
> // "level1" matches a struct ending in a flexible array.
> @level1@
> identifier inner, flex;
> type T;
> @@
>         struct inner {
>                 ...
>                 T flex[];
>         };
>
> // "level2" matches a composite flexible array struct (struct ending with "level1")
> @level2@
> identifier level1.inner;
> identifier outer, compflex;
> @@
>         struct outer {
>                 ...
>                 struct inner compflex;
>         };
>
> // match memcpy() which has a composite flexible array struct as the destination
> @memcpy_compflex_dest depends on level2@
> identifier level2.outer, level2.compflex;
> struct outer *PTR;
> expression SRC, SIZE;
> @@
>
>   memcpy(
> *       &PTR->compflex
>   , SRC, SIZE)
>
> ----
>
> I am using spatch on Ubuntu 22.04.1 LTS:
>
> $ spatch --version
> spatch version 1.1.1 compiled with OCaml version 4.13.1
>
> But I've also tried this with the latest from git with (worse?) results
> (see below).
>
> I'm using the same "include" options as generated by current Linux builds:
>
> $ INCLUDES="-I ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/compiler-version.h --include ./include/linux/kconfig.h"
>
> And here are the other common arguments:
>
> $ ARGS="--very-quiet $INCLUDES --cocci-file compflex-simple.cocci"
>
> I'm running this against linux-next (20220923).
>
> The first issue I encountered, was that the default didn't match for a
> known case:
>
> $ time spatch $ARGS net/sched/cls_u32.c | grep ^---
>
> real    0m0.096s
> ...
>
> Also it didn't work with "--all-includes":
>
> $ time spatch $ARGS --all-includes net/sched/cls_u32.c | grep ^---
>
> real    0m1.150s
> ...
>
> In reading the documentation carefully, it seem the desired option is
> actually "--recursive-includes" option, which _does_ work:

--recursive-includes is a good choice, and it is understandable that it
should be much slower.  It is parsing all of those recursively included
files.

I likewise see the following puzzling behavior:

i44:~/misc: spatch.opt ~/linux-next/fs/dlm/requestqueue.c flex.cocci  -I
~/linux-next/include
init_defs_builtins: /home/julia/main_cocci/standard.h
HANDLING: /home/julia/linux-next/fs/dlm/requestqueue.c
diff =
--- /home/julia/linux-next/fs/dlm/requestqueue.c
+++ /tmp/cocci-output-2281212-d01f89-requestqueue.c
@@ -44,7 +44,6 @@ void dlm_add_requestqueue(struct dlm_ls

 	e->recover_seq = ls->ls_recover_seq & 0xFFFFFFFF;
 	e->nodeid = nodeid;
-	memcpy(&e->request, ms, le16_to_cpu(ms->m_header.h_length));

 	atomic_inc(&ls->ls_requestqueue_cnt);
 	mutex_lock(&ls->ls_requestqueue_mutex);
i44:~/misc: spatch.opt ~/linux-next/fs/dlm flex.cocci -I
~/linux-next/include
init_defs_builtins: /home/julia/main_cocci/standard.h
(ONCE) Expected tokens memcpy
Skipping: /home/julia/linux-next/fs/dlm/recoverd.h
HANDLING: /home/julia/linux-next/fs/dlm/ast.c
Skipping: /home/julia/linux-next/fs/dlm/user.h
HANDLING: /home/julia/linux-next/fs/dlm/config.c
HANDLING: /home/julia/linux-next/fs/dlm/rcom.c
Skipping: /home/julia/linux-next/fs/dlm/lockspace.h
Skipping: /home/julia/linux-next/fs/dlm/dir.h
HANDLING: /home/julia/linux-next/fs/dlm/netlink.c
Skipping: /home/julia/linux-next/fs/dlm/dlm_internal.h
Skipping: /home/julia/linux-next/fs/dlm/memory.c
HANDLING: /home/julia/linux-next/fs/dlm/lowcomms.c
Skipping: /home/julia/linux-next/fs/dlm/util.h
Skipping: /home/julia/linux-next/fs/dlm/recoverd.c
Skipping: /home/julia/linux-next/fs/dlm/lowcomms.h
Skipping: /home/julia/linux-next/fs/dlm/lock.h
Skipping: /home/julia/linux-next/fs/dlm/recover.h
HANDLING: /home/julia/linux-next/fs/dlm/plock.c
HANDLING: /home/julia/linux-next/fs/dlm/lockspace.c
Skipping: /home/julia/linux-next/fs/dlm/main.c
Skipping: /home/julia/linux-next/fs/dlm/member.c
HANDLING: /home/julia/linux-next/fs/dlm/dir.c
Skipping: /home/julia/linux-next/fs/dlm/requestqueue.h
Skipping: /home/julia/linux-next/fs/dlm/debug_fs.c
Skipping: /home/julia/linux-next/fs/dlm/midcomms.h
HANDLING: /home/julia/linux-next/fs/dlm/lock.c
HANDLING: /home/julia/linux-next/fs/dlm/midcomms.c
HANDLING: /home/julia/linux-next/fs/dlm/requestqueue.c
Skipping: /home/julia/linux-next/fs/dlm/lvb_table.h
Skipping: /home/julia/linux-next/fs/dlm/ast.h
HANDLING: /home/julia/linux-next/fs/dlm/user.c
HANDLING: /home/julia/linux-next/fs/dlm/recover.c
Skipping: /home/julia/linux-next/fs/dlm/member.h
Skipping: /home/julia/linux-next/fs/dlm/rcom.h
Skipping: /home/julia/linux-next/fs/dlm/config.h
Skipping: /home/julia/linux-next/fs/dlm/util.c
Skipping: /home/julia/linux-next/fs/dlm/memory.h

So it worked when I tried only one .c file, but not when I tried the whole
directory.  When I put some tracing (--debug --show-trying) it seems to be
considering only the .c file in the full directory case, not the header
file.  I will look into it.

In the short term, you could try using the option --selected-only to get a
list of files considered to be relevant, and then run Coccinelle on each
of them individually.

julia




>
> $ time spatch $ARGS --recursive-includes net/sched/cls_u32.c | grep ^---
> --- net/sched/cls_u32.c
>
> real    0m25.332s
> ...
>
> This takes _much_ longer to run, though. (25 seconds vs 1 ...)
>
> However, if I run this in parallel (using the options shown in the
> kernel's build), it does _not_ find the hit in net/sched/cls_u32.c (?!)
>
> $ time spatch $ARGS --recursive-includes --jobs 36 --chunksize 1 --dir . | grep ^---
> 6594 files match
> EXN: Sys_error("./sound/firewire/fireworks/packets-buffer.h: No such file or directory") in ./sound/firewire/fireworks/fireworks_command.c
> EXN: Sys_error("./sound/firewire/bebob/lib.h: No such file or directory") in ./sound/firewire/bebob/bebob_command.c
> EXN: Sys_error("./sound/firewire/fireworks/packets-buffer.h: No such file or directory") in ./sound/firewire/fireworks/fireworks_transaction.c
> --- ./fs/dlm/requestqueue.c
> --- ./drivers/w1/w1_netlink.c
> --- ./drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
> --- ./drivers/platform/surface/surface_acpi_notify.c
> --- ./net/nfc/hci/hcp.c
> --- ./drivers/s390/net/qeth_l2_main.c
>
> real    8m50.993s
> ...
>
> With the latest from git, it additionally misses "fs/dlm/requestqueue.c",
> (but it takes half the time):
>
> $ time ~/.local/bin/spatch $ARGS --recursive-includes --jobs 36 --chunksize 1 --dir . | grep ^---
> 6594 files match
> --- ./drivers/w1/w1_netlink.c
> --- ./drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
> --- ./drivers/platform/surface/surface_acpi_notify.c
> --- ./net/nfc/hci/hcp.c
> --- ./drivers/s390/net/qeth_l2_main.c
>
> real    4m39.263s
> ...
>
> If I run it _not_ in parallel it is obviously MUCH slower, but ends up
> finding _no_ hits at all!
>
> $ $ time spatch $ARGS --recursive-includes --dir . | tee /tmp/slow.log | grep ^---
> 6594 files match
> EXN: Sys_error("./sound/firewire/bebob/lib.h: No such file or directory") in ./sound/firewire/bebob/bebob_command.c
> EXN: Sys_error("./sound/firewire/fireworks/packets-buffer.h: No such file or directory") in ./sound/firewire/fireworks/fireworks_command.c
>
> real    66m49.620s
> ...
>
> Do you have any idea what is going on?
>
> --
> Kees Cook
>
