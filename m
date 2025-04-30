Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF04C369D9
	for <cocci@archiver.kernel.org>; Wed, 30 Apr 2025 13:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=pByqRttMg7/luFlzJy9AwmWSvo/S9wtfXceCLHe7Eek=;
  b=kCptyHsDjvVaGIylWc91iQwUpsFztXFdRlt9GTfxDt5Z6+QrdPbEIRwE
   VXqDruZl/N8lKeeqd9ZZ81MQQa0ni1d4hAR9x6lJeJ4yCuHQCW5ovf/zg
   CouZEDEnN1Zf3dHXPM6DC5myRy5eKM9+MDvHVidVC+GDXCjVHM6q1RxzR
   8=;
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
X-IronPort-AV: E=Sophos;i="6.15,251,1739833200"; 
   d="scan'208";a="220190831"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Apr 2025 15:51:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B1FB8E0261; Wed, 30 Apr 2025 15:51:31 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 07546E007A
	for <cocci@sympa.inria.fr>; Wed, 30 Apr 2025 15:51:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pByqRttMg7/luFlzJy9AwmWSvo/S9wtfXceCLHe7Eek=;
  b=R/pNGJk7rFwBlg/+wc4lIGtekUMqPZlTeJJEPjbOt/zUhX7j+/9BISP/
   Vt5lsbUa0Z/2sZBjy9HC0L2nwW6jwN9h4QT0fYb8Ck3SyEkrryo+9JFfZ
   3tGWfi0Muk1QayEE1JhG6R50UPeZ32mSanobBW8svRFS99HE0rHhzIUvl
   s=;
X-IronPort-AV: E=Sophos;i="6.15,251,1739833200"; 
   d="scan'208";a="115578503"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 15:51:26 +0200
Date: Wed, 30 Apr 2025 15:51:26 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <09b11b9c-21af-4c9d-b818-b0029bca5b9d@web.de>
Message-ID: <101ac934-7955-4266-4691-d834aec286c@inria.fr>
References: <09b11b9c-21af-4c9d-b818-b0029bca5b9d@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2051463971-1746021086=:3426"
Subject: Re: [cocci] How to delete selected redundant null pointer checks
 with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2727
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/101ac934-7955-4266-4691-d834aec286c%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2051463971-1746021086=:3426
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 30 Apr 2025, Markus Elfring wrote:

> Hello,
>
> I noticed also the contribution “[PATCH] drm/amdgpu/userq: remove unnecessary NULL check”
> by Dan Carpenter.
> https://lore.kernel.org/kernel-janitors/aBHZuejTTKkdnGaZ@stanley.mountain/
> https://lkml.org/lkml/2025/4/30/389
>
> I got into the mood to convert the source code adjustment approach into another
> script variant for the semantic patch language.
>
> @deletion@
> identifier member, object, pointer;
> expression e;
> @@
>  pointer = &object.member;
>  <+... when != pointer = e
>  (
> -pointer &&
>  ...
>  )
>  ...+>

I think you want to see if such a thing exists, not ensure that it occurs
on all paths.  You can say:

@deletion exists@
identifier member, object, pointer;
expression e;
@@
pointer = &object.member
...
- pointer &&
  ...

julia

>
>
> Questionable test result (also with the software combination “Coccinelle 1.3-00083-g4093aad2d”):
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> git checkout next-20250430 && spatch …/Projekte/Coccinelle/janitor/delete_redundant_check.cocci drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> …
> deletion: position variables or mixed modifs interfere with comm_assoc iso
> bool (pointer && ...)
> …
>
>
> Unfortunately, the known patch is not generated at the moment.
> How will development interests evolve further?
>
> Regards,
> Markus
>
--8323329-2051463971-1746021086=:3426--
