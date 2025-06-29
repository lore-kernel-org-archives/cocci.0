Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1F1C7EE39
	for <cocci@archiver.kernel.org>; Sun, 29 Jun 2025 17:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=BM6/xf2QiI50UcGEtVwcBmRNznF6X31TYAxE5EBPIeg=;
  b=TMjgfblGIOzoUA/NtRY+4PksSD0Uq5IKszTIDSyRqFFnAu4C5YDNeyG5
   kyeRTnQiqUn4cbl/6kkYikMuhUUTHFHBmNxDzqSe5TmsFNfWqTMbv1YFg
   NpbPyC/mO6yoOdMCGMLNCTImbX5/zIH35xnOfoVGdAmWZTrn5O9g0ohNb
   o=;
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
X-IronPort-AV: E=Sophos;i="6.16,275,1744063200"; 
   d="scan'208";a="229472329"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jun 2025 19:26:21 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D0C7BE01A8; Sun, 29 Jun 2025 19:26:20 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8D5A1E0131
	for <cocci@sympa.inria.fr>; Sun, 29 Jun 2025 19:26:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BM6/xf2QiI50UcGEtVwcBmRNznF6X31TYAxE5EBPIeg=;
  b=u1HZfMKPuNxUqw8lNm0JBzyWev2GBH+3hJ12sE/duFYZ2d2NtBJd9CBI
   0EXHEbDPVYRZ80EdQMEAi1PDolUdIlX9xqqLAlK8+/Fr9AVAUxhteeNaO
   EGjfPUl7obBUZMIrYvBxjxXuqVKf8hQt7D2Te0reQ3crjeHbKHxWEvowf
   w=;
X-IronPort-AV: E=Sophos;i="6.16,275,1744063200"; 
   d="scan'208";a="229472328"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 19:26:18 +0200
Date: Sun, 29 Jun 2025 19:26:18 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: devnoname120 <devnoname120@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <7c65be39-dfc3-4b9c-9acd-dd94d1225db8@Spark>
Message-ID: <alpine.DEB.2.22.394.2506291925100.95572@hadrien>
References: <7c65be39-dfc3-4b9c-9acd-dd94d1225db8@Spark>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2054766398-1751217978=:95572"
Subject: Re: [cocci] [HELP] Using macro `randomized_struct_fields_end` as
 context?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2818
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/alpine.DEB.2.22.394.2506291925100.95572%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2054766398-1751217978=:95572
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 29 Jun 2025, devnoname120 wrote:

> Hello,
>  
> I'm trying to insert two fields inside a struct, right before the use of the macro `randomized_struct_fields_end`. You can find more information about the macro here: https://stackoverflow.com/a/72675757
>  
> Here is the unified diff that I'm trying to convert to a semantic patch:
>  
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 9ea614e09f56..c153abffd4c5 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1467,6 +1467,10 @@ struct task_struct {
>       * New fields for task_struct should be added above here, so that
>       * they are included in the randomized portion of task_struct.
>       */
> +#ifdef CONFIG_KSU_SUSFS
> +    u64 susfs_task_state;
> +    u64 susfs_last_fake_mnt_id;
> +#endif
>      randomized_struct_fields_end
>  
>      /* CPU-specific state of this task: */
>  
> Here is the file that it applies to: https://github.com/devnoname120/kernel_xiaomi_sm6150/blob/fce5582771e1254af065aaa2778940659e246611/include/linux/sched.h#L1470
>  
> I tried the following semantic patch:
>  
> @depends on file in "include/linux/sched.h" exists@
> @@
>  
> struct task_struct {
> ...
> +#ifdef CONFIG_KSU_SUSFS
> +   u64 susfs_task_state;
> +   u64 susfs_last_fake_mnt_id;
> +#endif
> randomized_struct_fields_end
> ...
> }


You can try putting in the metavariable section

declarer name randomized_struct_fields_end;

But I suspect it will still object due to the lack of a ; after
randomized_struct_fields_end.

julia

>  
> However I have the following error:
>  
> ❯ spatch --sp-file include/linux/sched.h.cocci --in-place --linux-spacing include/linux/sched.h
> init_defs_builtins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coccinelle/standard.h
> SPECIAL NAMES: adding u64 as a type
> minus: parse error: 
>  File "include/linux/sched.h.cocci", line 11, column 0, charpos = 194
>  around = '...',
>  whole content = ...
>  
> I also tried the following code:
>  
> @depends on file in "include/linux/sched.h" exists@
> identifier END =~ "randomized_struct_fields_end";
> @@
>  
> struct task_struct {
> ...
> +#ifdef CONFIG_KSU_SUSFS
> +   u64 susfs_task_state;
> +   u64 susfs_last_fake_mnt_id;
> +#endif
> END
> ...
> }
>  
> But it yields the following error:
>  
> ❯ spatch --sp-file include/linux/sched.h.cocci --in-place --linux-spacing include/linux/sched.h
> init_defs_builtins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coccinelle/standard.h
> SPECIAL NAMES: adding u64 as a type
> minus: parse error: 
>  File "include/linux/sched.h.cocci", line 11, column 0, charpos = 209
>  around = 'END',
>  whole content = END
>  
> I'm not sure why I have this error and I couldn't find an answer after looking on the internet and reading the Coccinelle grammar.
> Could you help me figure this out?
>  
>  
> Thanks!
> devnoname120
>
>
--8323329-2054766398-1751217978=:95572--
