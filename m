Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32B8CCF9F0
	for <cocci@archiver.kernel.org>; Thu, 30 Oct 2025 10:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=OZ4N9TczEkaWQXX9FpGdKspSCW0r/hMNwWOBLZCuSrs=;
  b=TjDEYlMtsEBnxuk9f+8U4+a5JKvfA1PezPEq+977rX4yoRhXZqkECuBd
   /7O4wJLI8TbQbNUjWh9r5THlf5wHQS2WYqCHuzgCuvzbjeh5Y1Ge1mzKI
   kFYaldAJ8FOamunWTBC5ZL0CByobtxOxiSEFnhSZG2ce12A/a+DGBUwHp
   I=;
X-CSE-ConnectionGUID: zAAy+gfcTyajAXwVCt69Yg==
X-CSE-MsgGUID: 7HzS49RvQ1+QRSm9QTijfQ==
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
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="246827824"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Oct 2025 11:12:35 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1F2B4E0B0D; Thu, 30 Oct 2025 11:12:35 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 89D22E0171
	for <cocci@sympa.inria.fr>; Thu, 30 Oct 2025 11:12:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OZ4N9TczEkaWQXX9FpGdKspSCW0r/hMNwWOBLZCuSrs=;
  b=STmAOGFg523OPd9WWo7cjqFjVPZcRPz4YC/+Vp2bGwXlazF9SCG5VVOS
   ObaF0NosRzBAOYxYEyEQF8Cl80ejq51i3uZZSHz7+g0nTYN/rNhzTYaGd
   +mbqCp6aWhvgxv66pMHPqVA8Rn4popEtb/41B98qPPIf16+V7nZ2w1FB5
   0=;
X-CSE-ConnectionGUID: b6XOW0K3QAumCM59nBlBQw==
X-CSE-MsgGUID: EdasjcjUSZaDJxmSMsgotQ==
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="246827816"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 11:12:33 +0100
Date: Thu, 30 Oct 2025 11:12:33 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>, 
    kernel-janitors@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <62441255-45fc-4edb-a8e5-c208b36ca2c2@web.de>
Message-ID: <53e91f9f-bfe5-5c57-157c-fc456bd430ca@inria.fr>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de> <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr> <62441255-45fc-4edb-a8e5-c208b36ca2c2@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1019221123-1761819153=:3629"
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments
 from memcpy() calls with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3116
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/53e91f9f-bfe5-5c57-157c-fc456bd430ca%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1019221123-1761819153=:3629
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 30 Oct 2025, Markus Elfring wrote:

> >> It can be determined then from the generated diff file that mentioned
> >> implementation details can be transformed in 304 source files at the moment.
> >> Thus I became curious if it would be supported to adjust any places there
> >> according to (Linux) coding style preferences.
> >
> > If you have a concern, you have to say what it is.
>
> I expressed something for further development considerations.
> The source code analysis result can be interpreted in some directions.
>
>
> >                                                     It doesn't seem it is
> > about the running time,
>
> Not directly in this case.
>
>
> >                         so why do you include that information?
>
> Further software users can compare such a measurement with other observations.
>
>
> > I should not have to repeat your experiment to figure out what you are
> > asking about.
>
> You can recognise recurring development challenges, can't you?
>
> * Change resistance
>
> * Varying coding style preferences
>
> * Code improvement possibilities
>
> * Development resources
>
> * Pretty-printing issues
>
>
> Another test result representation for your convenience:
> https://elixir.bootlin.com/linux/v6.18-rc3/source/arch/arm64/kvm/arm.c#L2554-L2726
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --max-width 100 --no-loops …/Projekte/Coccinelle/janitor/use_memcpy_assignment.cocci arch/arm64/kvm/arm.c
> …
> @@ -2600,8 +2600,8 @@ static int __init init_hyp_mode(void)
>                         goto out_err;
>                 }
>
> -               page_addr = page_address(page);
> -               memcpy(page_addr, CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_percpu_size());
> +               page_addr =
> +               memcpy(page_address(page), CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_percpu_size());
>                 kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu] = (unsigned long)page_addr;

This is all I wanted.  The rest is complete noise.

I think you would get a more satisfactory result by just removing all of
the code and adding it back. Then Coccinelle would take charge of laying
out the whole thing.

thanks,
julia

>         }
>
>
> real    0m0,606s
> user    0m0,576s
> sys     0m0,030s
>
>
>
> Another SmPL script example might become helpful.
>
> @replacement2@
> expression object, size, source, target;
> @@
>  target =
> -         object; memcpy(target, source, size)
> +         memcpy(object, source, size)
>  ;
>
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --max-width 100 --no-loops …/Projekte/Coccinelle/janitor/use_memcpy_assignment2.cocci arch/arm64/kvm/arm.c
> …
> @@ -2600,8 +2600,8 @@ static int __init init_hyp_mode(void)
>                         goto out_err;
>                 }
>
> -               page_addr = page_address(page);
> -               memcpy(page_addr, CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_percpu_size());
> +               page_addr =memcpy(page_address(page), CHOOSE_NVHE_SYM(__per_cpu_start),
> +                                 nvhe_percpu_size());
>                 kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu] = (unsigned long)page_addr;
>         }
>
>
> real    0m0,626s
> user    0m0,588s
> sys     0m0,037s
>
>
> Regards,
> Markus
>
--8323329-1019221123-1761819153=:3629--
