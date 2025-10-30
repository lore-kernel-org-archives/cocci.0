Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E28ECCF9F0
	for <cocci@archiver.kernel.org>; Thu, 30 Oct 2025 12:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=40ecY0U9Xo+6IKV4rUw0adOO0P61BYlJqCroRoMWneM=;
  b=JHML+S4eAphffYrzO1RcCb1CRveKIEYnzefDMdf4iFnUhg5HvJBwwOvC
   aPYk9rJTBHlImCf2uwNUVv2qyTcJ2S4U5GengP+JpP0mtiL0YH8VdvWSk
   4utzBj2M7ctYxrAMP/HJhZz2DJzi3XfgOd1qJTOG5N95ImLNadRziDcAU
   g=;
X-CSE-ConnectionGUID: mk9Zs5/iRJyh6JD6z+a0Jw==
X-CSE-MsgGUID: n9RQmUF6RnCg69im1DfhKg==
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
   d="scan'208";a="246851496"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Oct 2025 13:31:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E5EF3E0BE9; Thu, 30 Oct 2025 13:31:54 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9C22AE0171
	for <cocci@sympa.inria.fr>; Thu, 30 Oct 2025 13:31:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=40ecY0U9Xo+6IKV4rUw0adOO0P61BYlJqCroRoMWneM=;
  b=MTlJW8I0ODjFo79UiGZmY5uf1x+SUtqmsTH4R9eflHzxmMxgQ0UgWNYx
   zOm8hZv/WZ/IXYWL5hXeRa1Ad5tm04qDt9NRzZGnG6UkXGPvnCDay4YRj
   gU1X12Y6OOjW0m5bBjwZg0AYo6+OZMbU9So6MSpK3hia9/psIrMEz5ErJ
   U=;
X-CSE-ConnectionGUID: +seXBmm7Th+ESK2tzrllMg==
X-CSE-MsgGUID: jw7W0DflTi+GhrOvNeeePg==
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="129496016"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 13:31:50 +0100
Date: Thu, 30 Oct 2025 13:31:49 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>, 
    kernel-janitors@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <60f881dc-979d-486b-95be-6b31e85d4041@web.de>
Message-ID: <aa99eded-be51-af3b-414-7c3bbaddea4a@inria.fr>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de> <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr> <60f881dc-979d-486b-95be-6b31e85d4041@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-937884858-1761827509=:11598"
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments
 from memcpy() calls with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3120
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/aa99eded-be51-af3b-414-7c3bbaddea4a%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-937884858-1761827509=:11598
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 30 Oct 2025, Markus Elfring wrote:

> > If you have a concern, you have to say what it is.  It doesn't seem it is
> > about the running time, so why do you include that information?
>
> How will remaining open issues be resolved?
>
>
> > I should not have to repeat your experiment
>
> It would be nice if further software users would occasionally reproduce
> presented data processing possibilities.
>
>
> >                                             to figure out what you are
> > asking about.
>
> I “accidentally” tried also the following SmPL script variants out.
>
> A)
> @replacement3@
> expression object, size, source, target;
> @@
>  target =
> -object; memcpy(target, source, size)
> +object; memcpy(object, source, size)
>  ;
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --max-width 100 --no-loops …/Projekte/Coccinelle/janitor/use_memcpy_assignment3.cocci arch/arm64/kvm/arm.c
> …
> @@ -2600,8 +2600,8 @@ static int __init init_hyp_mode(void)
>                         goto out_err;
>                 }
>
> -               page_addr = page_address(page);
> -               memcpy(page_addr, CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_percpu_size());
> +               page_addr =memcpy(page_address(page), CHOOSE_NVHE_SYM(__per_cpu_start),
> +                                 nvhe_percpu_size());page_address(page);
>                 kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu] = (unsigned long)page_addr;
>         }
>
>
> real    0m0,578s
> user    0m0,524s
> sys     0m0,047s
>
>
>
> B)
> @replacement4@
> expression object, size, source, target;
> @@
> -target = object; memcpy(target, source, size)
> +target = object; memcpy(object, source, size)
>  ;
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --max-width 100 --no-loops …/Projekte/Coccinelle/janitor/use_memcpy_assignment4.cocci arch/arm64/kvm/arm.c
> …
> @@ -2600,8 +2600,8 @@ static int __init init_hyp_mode(void)
>                         goto out_err;
>                 }
>
> +               memcpy(page_address(page), CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_percpu_size());
>                 page_addr = page_address(page);
> -               memcpy(page_addr, CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_percpu_size());
>                 kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu] = (unsigned long)page_addr;
>         }

Not sure what is the point of all this.  Try:

- target = object; memcpy(target, source, size);
+ target = memcpy(target, source, size);

Then it will add newlines in the argument of memcpy if needed to stay in a
reasonable number of columns.

julia

>
>
> real    0m0,565s
> user    0m0,533s
> sys     0m0,032s
>
>
>
> Would you like to reconsider implementation details accordingly?
>
> Regards,
> Markus
>
--8323329-937884858-1761827509=:11598--
