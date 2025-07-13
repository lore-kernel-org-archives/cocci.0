Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB99C83F1D
	for <cocci@archiver.kernel.org>; Sun, 13 Jul 2025 20:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=BftM8nFspFhpjIR7kMr8A4zBM6JLHI/xP7NK4RU9yrk=;
  b=qGmWOaeQSrcjASLZJww5Ctpvw2WrB+8mVRXxpuIwdrHga/chWt3sJkEv
   4AwcdRrdx5EQHWgIr/WAGV5Uml4NrKv4mb8WFSghViE8ctWmcJhfoE7mG
   KEvJvLxGRtu3NbupULH86Bnkft2xX88ihaIbjR2jPbXtJhcJcVhiww34s
   Q=;
X-CSE-ConnectionGUID: Muj0rjl+TWqSoW4oYJQQyQ==
X-CSE-MsgGUID: l9dQIw0eTyOPJSAx5HyUkA==
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
X-IronPort-AV: E=Sophos;i="6.16,309,1744063200"; 
   d="scan'208";a="231512636"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Jul 2025 22:58:23 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 940DEE0CCE; Sun, 13 Jul 2025 22:58:23 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 60B96E0261
	for <cocci@sympa.inria.fr>; Sun, 13 Jul 2025 22:58:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BftM8nFspFhpjIR7kMr8A4zBM6JLHI/xP7NK4RU9yrk=;
  b=Ga0tAuYOtALCkFj/cFDIA5+UHHGOob7j0vW9v+ZE4YF46xS/2eQBgJP5
   EtQk2Z8eltA9GpD4wPNgylWzdEzwywQhI3oiv5ePiIaI/0+zdQ++xxla5
   oZF+Q3sTWAXwNDN1Bf6iRud5lXhGMEdUzTX7QSLCErW04lGckDuZY0JsZ
   U=;
X-CSE-ConnectionGUID: 4NCg7MifSbicLTnlBComsg==
X-CSE-MsgGUID: DEJ+Ip54SMS6wtDo9HKT3A==
X-IronPort-AV: E=Sophos;i="6.16,309,1744063200"; 
   d="scan'208";a="231512629"
Received: from 74-95-99-105-richmond.hfc.comcastbusiness.net (HELO hadrien) ([74.95.99.105])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 22:58:18 +0200
Date: Sun, 13 Jul 2025 16:58:15 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
To: devnoname120 <devnoname120@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <68edca4d-74e7-4b83-9813-03d8fd7eae4e@Spark>
Message-ID: <6ed53f2e-40a4-9e47-a343-fd5f6054a6fe@inria.fr>
References: <7c65be39-dfc3-4b9c-9acd-dd94d1225db8@Spark> <alpine.DEB.2.22.394.2506291925100.95572@hadrien> <55f3b1f1-2537-4bc3-88d3-d7da1136060a@Spark> <alpine.DEB.2.22.394.2506292109470.95572@hadrien> <1a234d32-e87d-414b-8566-490618417f6c@Spark>
 <c08d6fa1-e53c-d21-7892-1132133087fb@inria.fr> <68edca4d-74e7-4b83-9813-03d8fd7eae4e@Spark>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1891018199-1752440298=:3270"
Subject: Re: [cocci] [HELP] Using macro `randomized_struct_fields_end` as
 context?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2864
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/6ed53f2e-40a4-9e47-a343-fd5f6054a6fe%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1891018199-1752440298=:3270
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 13 Jul 2025, devnoname120 wrote:

> I just attempted to run this command on Ubuntu and although it didn't return
> any error, no change was done:
>  
> ❯ spatch --sp-file include/linux/sched.h.cocci --in-place --linux-spacing
> include/linux/sched.h
> init_defs_builtins: /usr/lib/coccinelle/standard.h
> SPECIAL NAMES: adding u64 as a type
> HANDLING: include/linux/sched.h
>  
> Here is the content of `include/linux/sched.h.cocci`:
>  
> ```
> @depends on file in "include/linux/sched.h" exists@
> field f : script:python () { f == "randomized_struct_fields_end" };
> @@
>  
> struct task_struct {
> ...
> +#ifdef CONFIG_KSU_SUSFS
> +    u64 susfs_task_state;
> +    u64 susfs_last_fake_mnt_id;
> +#endif
> f
> ...
> };
> ```
>  
> The `include/linux/sched.h` file remains the same as before.

It all works fine for me.  What version of Coccinelle do you have?

julia

>  
>
> Thank you,
> Paul
> On Jun 30, 2025 at 10:52 +0200, Julia Lawall <julia.lawall@inria.fr>, wrote:
>       randomized_struct_fields_end will soon be supported in the C
>       parser. It
>       is not currently supported in the semantic patch parser, but you
>       can get
>       the same effect as illustrated by the example below.
>
>       I will let you know when this is all available on github.
>
>       julia
>
>
>       @@
>       field f : script:python () { f == "randomized_struct_fields_end"
>       };
>       @@
>
>       struct task_struct {
>       ...
>       + int something;
>       f
>       ...
>       };
>
>
>
--8323329-1891018199-1752440298=:3270--
