Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA40C433EF
	for <cocci@archiver.kernel.org>; Wed, 30 Mar 2022 08:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Nm3/83BLfTxqbB3yVdH7/M2MnTWGa1QQjPe4ZcE+AfI=;
  b=c/WTBM9ZD5EbSypG+TW0WAUYfX96w0w+ioKzVjp3/7LugNw3A718ml+N
   Y1H7c/xtlJH7soVdLEtS9ImRnGwy2v9B+BuIPYttOZQt+1Feqdzy4Z17v
   myczv7sUOnr7/GBNBW/lSEjIk7Eyp1yWiizZijMilQb9+ZgeX8At6ZHzL
   0=;
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
X-IronPort-AV: E=Sophos;i="5.90,222,1643670000"; 
   d="scan'208";a="29030043"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Mar 2022 10:06:27 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3292EE7D85; Wed, 30 Mar 2022 10:06:27 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4CC29E7D80
	for <cocci@sympa.inria.fr>; Wed, 30 Mar 2022 10:06:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Nm3/83BLfTxqbB3yVdH7/M2MnTWGa1QQjPe4ZcE+AfI=;
  b=UX3JBE9liSJh7Y+T/Jw9kwqCp9Zx6vLskMGz+amWhPNDl5SlH6/MG1w+
   ubDYAppUXDwZFxOqCUYh7tzVyr2ANH5ptq3/pI4teqGMfPTPDHO0jwxS+
   pF63br6F2cX0DV7C4TTVldTld4Jk3GWrTjHystm+YZZEt6FYRe8hMAnZr
   o=;
X-IronPort-AV: E=Sophos;i="5.90,222,1643670000"; 
   d="scan'208";a="29030020"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 10:06:22 +0200
Date: Wed, 30 Mar 2022 10:06:22 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
cc: corbet@lwn.net, mchehab+huawei@kernel.org, dlatypov@google.com, 
    davidgow@google.com, linux-doc@vger.kernel.org, 
    linux-sparse@vger.kernel.org, cocci@inria.fr, smatch@vger.kernel.org, 
    linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
    dan.carpenter@oracle.com, julia.lawall@inria.fr
In-Reply-To: <11f4750c6d4c175994dfd36d1ff385f68f61bd02.1648593132.git.marcelo.schmitt1@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2203301005010.2592@hadrien>
References: <cover.1648593132.git.marcelo.schmitt1@gmail.com> <11f4750c6d4c175994dfd36d1ff385f68f61bd02.1648593132.git.marcelo.schmitt1@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH v2 2/2] Documentation: dev-tools: Enhance static
 analysis section with discussion
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 314
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203301005010.2592%40hadrien>

> +Strong points of Smatch and Coccinelle
> +--------------------------------------
> +
> +Coccinelle is probably the easiest for writing checks. It works before the
> +pre-compiler so it's easier to check for bugs in macros using Coccinelle.

pre-processor

> +Coccinelle also writes patches fixes for you which no other tool does.

writes patches fixes -> creates patches

> +
> +With Coccinelle you can do a mass conversion from

you can -> you can, for example,

julia

> +``kmalloc(x * size, GFP_KERNEL)`` to ``kmalloc_array(x, size, GFP_KERNEL)``, and
> +that's really useful. If you just created a Smatch warning and try to push the
> +work of converting on to the maintainers they would be annoyed. You'd have to
> +argue about each warning if can really overflow or not.
> +
> +Coccinelle does no analysis of variable values, which is the strong point of
> +Smatch. On the other hand, Coccinelle allows you to do simple things in a simple
> +way.
> --
> 2.35.1
>
>
