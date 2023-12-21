Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DA6C46CD4
	for <cocci@archiver.kernel.org>; Thu, 21 Dec 2023 09:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=n2eDoQJ56NKEr5AMgIaOyJ3twHdIc48FKW3CM3tKb/c=;
  b=blowE+1Kes0y7faIGPX2Thy0qZvYsi8DiVDCPr3dDW74P6/8fGkVBQ7B
   wGQ7cCgLIj0wTmoPAr6MQbXWCGmfnj90SnloO7YwdiEjSGJtCFFwUDrts
   +f0XRgwRJvuZ7ahR/gMEdo5JzGcUjbLeiPBvLJDD3KgoIibgKj7godB5E
   Q=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.04,293,1695679200"; 
   d="scan'208";a="143481490"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Dec 2023 10:01:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 07C0AE0CCE; Thu, 21 Dec 2023 10:01:10 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8D29FE004E
	for <cocci@sympa.inria.fr>; Thu, 21 Dec 2023 10:01:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=n2eDoQJ56NKEr5AMgIaOyJ3twHdIc48FKW3CM3tKb/c=;
  b=ePza51eb/fMPj1ER3sQXcvUjBdbmZlGibiOFE7AqPXZcV8zzWPCmZjcg
   LTU0EnvoCHqcenFx05oh6wDDfjRnoDUkP6aXd77He5zSfkmKE4MeoucKz
   A2Lg60UOyfvUHj/xSFurA5BebGqjotQMj5tfvzwDb4/iPGyoOwOvMzhB6
   s=;
X-IronPort-AV: E=Sophos;i="6.04,293,1695679200"; 
   d="scan'208";a="75044407"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 10:01:05 +0100
Date: Thu, 21 Dec 2023 10:01:04 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: cocci@inria.fr
In-Reply-To: <db0e2b-9ddd-542d-5a59-ed15ffd594b8@linux.intel.com>
Message-ID: <155979e7-bf8-a7da-4762-749cb9eba1d@inria.fr>
References: <db0e2b-9ddd-542d-5a59-ed15ffd594b8@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-362979933-1703149264=:3356"
Subject: Re: [cocci] Spatch corrupting struct variable
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1353
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/155979e7-bf8-a7da-4762-749cb9eba1d%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-362979933-1703149264=:3356
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT



On Thu, 21 Dec 2023, Ilpo Järvinen wrote:

> Hi all,
>
> I'm at total loss what coccinelle/spatch is trying to do here:
>
> @@
> struct resource *res;
> expression size;
> @@
> - res->end = res->start + size - 1;
> + resource_set_size(res, size);
>
> Spatching against Linux kernel tree results in this corruption:
>
> HANDLING: drivers/bus/fsl-mc/fsl-mc-bus.c
> diff =
> diff -u -p a/fsl-mc-bus.c b/fsl-mc-bus.c
> --- a/fsl-mc-bus.c
> +++ b/fsl-mc-bus.c
> @@ -736,7 +736,7 @@ static int fsl_mc_device_get_mmio_region
>                         goto error_cleanup_regions;
>                 }
>
> -               regions[i].end = regions[i].start + region_desc.size - 1;
> +               resource_set_size(regions, region_desc.size);
>                 regions[i].name = "fsl-mc object MMIO region";
>                 regions[i].flags = region_desc.flags & IORESOURCE_BITS;
>                 regions[i].flags |= IORESOURCE_MEM;
>
> ??? How did that [i] vanish from regions? Why spatch thought . and -> are
> equal?

There is an isomorphism that does that.  Maybe it should be removed...

In any case, you can put @disable ptr_to_array@ in place of the initial @@
in your rule.  Or if your rule has a name, put the disable ptr_to_array
after the name.

julia

>
> $ spatch --version
> spatch version 1.1.0 compiled with OCaml version 4.11.1
> Flags passed to the configure script: --prefix=/usr --sysconfdir=/etc --libdir=/usr/lib --enable-ocaml --enable-python --enable-opt
> OCaml scripting support: yes
> Python scripting support: yes
> Syntax of regular expressions: PCRE
>
>
> --
>  i.
>
>
--8323329-362979933-1703149264=:3356--
