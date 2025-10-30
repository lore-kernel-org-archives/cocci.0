Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AE8CCF9FE
	for <cocci@archiver.kernel.org>; Thu, 30 Oct 2025 13:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=+9GCbyx0nM5jk0KxizZbCcB0mtfNvPzaCv7oLfJtX+4=;
  b=a3ZzaWTFiHb3QTjnGUR8b4zbXGkCebXy4n0GsTjctAeLTj6W2hWdkN11
   ax/IebgcGkouAlJfmqOP3h3e1c+T/CGK4mQpErkgEVcoGE3xifYkRhSr/
   N5pSto/wpi/BfC73XGTA5W5FUc9Nqr5djJcatwP4Rntpmba4QuVotjqnh
   M=;
X-CSE-ConnectionGUID: KdwJlQcIR06JOO3OzV1D2g==
X-CSE-MsgGUID: BLrl5g0RTTOjNCHn8cfZoQ==
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
   d="scan'208";a="246864510"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Oct 2025 14:38:53 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 46C59E0B0D; Thu, 30 Oct 2025 14:38:53 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A710FE0171
	for <cocci@sympa.inria.fr>; Thu, 30 Oct 2025 14:38:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+9GCbyx0nM5jk0KxizZbCcB0mtfNvPzaCv7oLfJtX+4=;
  b=ds0HgokCCDoDNlvWPIfPEeuATpkKsCozTlFlALg91YSlAxw6Scunw9jb
   lmE0o+UviiFrrbcti9BgNG9ckY7t/TBDwxu90W9gJxJ4iTni4bh0tOjqo
   tFn7doJjgXI3FZ43z2m2sXvrKWVoAkKInrWdEMN7GrnVIwfPNHjc25jjN
   0=;
X-CSE-ConnectionGUID: 7cxw7crpQmi9x+ULw5pwKg==
X-CSE-MsgGUID: H4kwkNjnS0K6wtUy73fXGw==
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="129502388"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 14:38:49 +0100
Date: Thu, 30 Oct 2025 14:38:47 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>, 
    kernel-janitors@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <abda1fe0-af59-4fa9-a1ec-efda0f63b3f1@web.de>
Message-ID: <75a9224f-8c8a-da15-3ad7-f49fe3c36cf@inria.fr>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de> <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr> <60f881dc-979d-486b-95be-6b31e85d4041@web.de> <aa99eded-be51-af3b-414-7c3bbaddea4a@inria.fr> <abda1fe0-af59-4fa9-a1ec-efda0f63b3f1@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1183597951-1761831528=:11598"
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments
 from memcpy() calls with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3122
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/75a9224f-8c8a-da15-3ad7-f49fe3c36cf%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1183597951-1761831528=:11598
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 30 Oct 2025, Markus Elfring wrote:

> >> I “accidentally” tried also the following SmPL script variants out.
> >>
> >> A)
> >> @replacement3@
> >> expression object, size, source, target;
> >> @@
> >>  target =
> >> -object; memcpy(target, source, size)
> >> +object; memcpy(object, source, size)
> >>  ;
> >>
> >> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --max-width 100 --no-loops …/Projekte/Coccinelle/janitor/use_memcpy_assignment3.cocci arch/arm64/kvm/arm.c
> >> …
> >> @@ -2600,8 +2600,8 @@ static int __init init_hyp_mode(void)
> >>                         goto out_err;
> >>                 }
> >>
> >> -               page_addr = page_address(page);
> >> -               memcpy(page_addr, CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_percpu_size());
> >> +               page_addr =memcpy(page_address(page), CHOOSE_NVHE_SYM(__per_cpu_start),
> >> +                                 nvhe_percpu_size());page_address(page);
> >>                 kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu] = (unsigned long)page_addr;
> >>         }
> …>> B)
> >> @replacement4@
> >> expression object, size, source, target;
> >> @@
> >> -target = object; memcpy(target, source, size)
> >> +target = object; memcpy(object, source, size)
> >>  ;
> >>
> >> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --max-width 100 --no-loops …/Projekte/Coccinelle/janitor/use_memcpy_assignment4.cocci arch/arm64/kvm/arm.c
> >> …
> >> @@ -2600,8 +2600,8 @@ static int __init init_hyp_mode(void)
> >>                         goto out_err;
> >>                 }
> >>
> >> +               memcpy(page_address(page), CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_percpu_size());
> >>                 page_addr = page_address(page);
> >> -               memcpy(page_addr, CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_percpu_size());
> >>                 kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu] = (unsigned long)page_addr;
> >>         }
> >
> > Not sure what is the point of all this.  Try:
> …
>
> Would you like to acknowledge that undesirable difference displays were generated anyhow
> for these test cases?

Sure.

>
>
> >> Would you like to reconsider implementation details accordingly?
>
> Are we looking for corresponding software improvements?

If time permits.

julia
--8323329-1183597951-1761831528=:11598--
