Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE12C7EE39
	for <cocci@archiver.kernel.org>; Sun, 29 Jun 2025 18:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=3QlepdHGQEBoaKuz27e9dMYy4UKAdjf3XxDU9ptevcA=;
  b=B3jbexq/d+hGmovCdf/+l/QhuXu8MeJOknYmRrbY0iChRj1pW2cG3B/J
   54LbOUO5/oDKDI/VoBnMysvB4ASTeSW0lsMqbx0YJu2eQM3HulTIAWAnU
   8iVvb8WE8wG/cIWBiIKr/2BWTZIk488QrU7AVBVUXzbFxNkpZHspeMktJ
   4=;
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
   d="scan'208";a="229475744"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jun 2025 20:58:57 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C64A1E0157; Sun, 29 Jun 2025 20:58:56 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C02B5E0131
	for <cocci@sympa.inria.fr>; Sun, 29 Jun 2025 20:58:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3QlepdHGQEBoaKuz27e9dMYy4UKAdjf3XxDU9ptevcA=;
  b=AyAk3pi3VpDTdfdwSb8RLpheuk6kodOy8HHYgriUkrQBlWRp0uY8tuE6
   E64+DQNH83lar0YgSgkBqpZSdNmJQoDeVLB0XiVakyTZ/cx+V3zdt8vLz
   bLiNMFWs2BPMGBCgOoVXBOpiN7wPA60y/HjUGruEmQThxJkH+UeK6yMvV
   M=;
X-IronPort-AV: E=Sophos;i="6.16,276,1744063200"; 
   d="scan'208";a="229475737"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 20:58:55 +0200
Date: Sun, 29 Jun 2025 20:58:54 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: devnoname120 <devnoname120@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <55f3b1f1-2537-4bc3-88d3-d7da1136060a@Spark>
Message-ID: <alpine.DEB.2.22.394.2506292057190.95572@hadrien>
References: <7c65be39-dfc3-4b9c-9acd-dd94d1225db8@Spark> <alpine.DEB.2.22.394.2506291925100.95572@hadrien> <55f3b1f1-2537-4bc3-88d3-d7da1136060a@Spark>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1280957916-1751223534=:95572"
Subject: Re: [cocci] [HELP] Using macro `randomized_struct_fields_end` as
 context?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2819
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/alpine.DEB.2.22.394.2506292057190.95572%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1280957916-1751223534=:95572
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 29 Jun 2025, devnoname120 wrote:

> Here is my new semantic patch:
>  
> @depends on file in "include/linux/sched.h" exists@
> declarer name randomized_struct_fields_end;
> @@
>
>  
> struct task_struct {
> ...
> +#ifdef CONFIG_KSU_SUSFS
> + u64 susfs_task_state;
> + u64 susfs_last_fake_mnt_id;
> +#endif
> randomized_struct_fields_end
> ...
> }
>  
> And here is the error:
>  
> ❯ spatch --sp-file include/linux/sched.h.cocci --in-place --linux-spacing include/linux/sched.h
> init_defs_builtins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coccinelle/standard.h
> SPECIAL NAMES: adding randomized_struct_fields_end as a declarer
> SPECIAL NAMES: adding u64 as a type
> minus: parse error: 
>  File "include/linux/sched.h.cocci", line 12, column 0, charpos = 247
>  around = '...',
>  whole content = ...
>  
>  
> If I add a semi-colon after `randomized_struct_fields_end` in the semantic patch:
>  
> ❯ spatch --sp-file include/linux/sched.h.cocci --in-place --linux-spacing include/linux/sched.h
> init_defs_builtins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coccinelle/standard.h
> SPECIAL NAMES: adding randomized_struct_fields_end as a declarer
> SPECIAL NAMES: adding u64 as a type
> minus: parse error: 
>  File "include/linux/sched.h.cocci", line 11, column 28, charpos = 246
>  around = ';',
>  whole content = randomized_struct_fields_end;

The problem is that getting the semantic patch to parse is not enough
anyway; the associated C code has to be parsed as well.

But I have the impression that you want to do something at one specific
place in sched.h.  Why not just make the change by hand?

julia

>  
> Paul
>  
> On Jun 29, 2025 at 19:26 +0200, Julia Lawall <julia.lawall@inria.fr>, wrote:
>
>
>       On Sun, 29 Jun 2025, devnoname120 wrote:
>
>             Hello,
>              
>             I'm trying to insert two fields inside a struct, right before the use of the macro `randomized_struct_fields_end`. You can find more information about the macro here: https://stackoverflow.com/a/72675757
>              
>             Here is the unified diff that I'm trying to convert to a semantic patch:
>              
>             diff --git a/include/linux/sched.h b/include/linux/sched.h
>             index 9ea614e09f56..c153abffd4c5 100644
>             --- a/include/linux/sched.h
>             +++ b/include/linux/sched.h
>             @@ -1467,6 +1467,10 @@ struct task_struct {
>                   * New fields for task_struct should be added above here, so that
>                   * they are included in the randomized portion of task_struct.
>                   */
>             +#ifdef CONFIG_KSU_SUSFS
>             +    u64 susfs_task_state;
>             +    u64 susfs_last_fake_mnt_id;
>             +#endif
>                  randomized_struct_fields_end
>              
>                  /* CPU-specific state of this task: */
>              
>             Here is the file that it applies to: https://github.com/devnoname120/kernel_xiaomi_sm6150/blob/fce5582771e1254af065aaa2778940659e246611/include/linux/sched.h#L1470
>              
>             I tried the following semantic patch:
>              
>             @depends on file in "include/linux/sched.h" exists@
>             @@
>              
>             struct task_struct {
>             ...
>             +#ifdef CONFIG_KSU_SUSFS
>             +   u64 susfs_task_state;
>             +   u64 susfs_last_fake_mnt_id;
>             +#endif
>             randomized_struct_fields_end
>             ...
>             }
>
>
>
>       You can try putting in the metavariable section
>
>       declarer name randomized_struct_fields_end;
>
>       But I suspect it will still object due to the lack of a ; after
>       randomized_struct_fields_end.
>
>       julia
>
>              
>             However I have the following error:
>              
>             ❯ spatch --sp-file include/linux/sched.h.cocci --in-place --linux-spacing include/linux/sched.h
>             init_defs_builtins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coccinelle/standard.h
>             SPECIAL NAMES: adding u64 as a type
>             minus: parse error: 
>              File "include/linux/sched.h.cocci", line 11, column 0, charpos = 194
>              around = '...',
>              whole content = ...
>              
>             I also tried the following code:
>              
>             @depends on file in "include/linux/sched.h" exists@
>             identifier END =~ "randomized_struct_fields_end";
>             @@
>              
>             struct task_struct {
>             ...
>             +#ifdef CONFIG_KSU_SUSFS
>             +   u64 susfs_task_state;
>             +   u64 susfs_last_fake_mnt_id;
>             +#endif
>             END
>             ...
>             }
>              
>             But it yields the following error:
>              
>             ❯ spatch --sp-file include/linux/sched.h.cocci --in-place --linux-spacing include/linux/sched.h
>             init_defs_builtins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coccinelle/standard.h
>             SPECIAL NAMES: adding u64 as a type
>             minus: parse error: 
>              File "include/linux/sched.h.cocci", line 11, column 0, charpos = 209
>              around = 'END',
>              whole content = END
>              
>             I'm not sure why I have this error and I couldn't find an answer after looking on the internet and reading the Coccinelle grammar.
>             Could you help me figure this out?
>              
>              
>             Thanks!
>             devnoname120
>
>
>
--8323329-1280957916-1751223534=:95572--
