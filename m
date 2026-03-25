Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AA5109C02F
	for <cocci@archiver.kernel.org>; Wed, 25 Mar 2026 15:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=NeOwB6eHU3WwgUWA94Pl6627ASGq69dlpDgpb7e9BoI=;
  b=MwD2WBbWEu3PbkNK26QOcrGzmSSGsi1yk12rhc6zwKL3e2KintrzSDgC
   Q9BAjLyus13BSKWOTBTtj0XalycNjJ5r7CE2cosrdE64tk/aTMV6M8t7Z
   xUtNXIhE+dqx5nS2g0TyXIXhCTKcUU+GEC2vtBQznc+zRD1/ZdtgbNWpd
   o=;
X-CSE-ConnectionGUID: OEW4ADKsRaC2HsKtQdnWGQ==
X-CSE-MsgGUID: IhH1rV8jS/S7RSU3zOTfSg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,140,1770591600"; 
   d="scan'208";a="269472348"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2026 16:05:33 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id B9BD482E69; Wed, 25 Mar 2026 16:05:33 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 7CC9382E62
	for <cocci@sympa.inria.fr>; Wed, 25 Mar 2026 16:05:31 +0100 (CET)
X-CSE-ConnectionGUID: 5ZPOR5n7SiOM4sMe9hRbNg==
X-CSE-MsgGUID: p+M3smwVSzmIm4Vu5A7PVg==
X-IronPort-AV: E=Sophos;i="6.23,140,1770591600"; 
   d="scan'208";a="269472333"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 16:05:31 +0100
Date: Wed, 25 Mar 2026 16:05:31 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: "Richard W.M. Jones" <rjones@redhat.com>
cc: cocci@inria.fr
In-Reply-To: <20260325122401.GA16430@redhat.com>
Message-ID: <9b85c0be-c08a-39d4-714-9be5e5ceea3@inria.fr>
References: <20260325122401.GA16430@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Current git URL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3454
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/6GFpOvZ4DLL67j8oV2h3Vw>



On Wed, 25 Mar 2026, Richard W.M. Jones wrote:

> Hi,
>
> We recently patched Fedora coccinelle to support pcre2.  One issue we
> hit was that the website refers to the upstream git repository as:
>
> https://github.com/coccinelle/coccinelle/
>
> See for example the link here on what I assume is the correct upstream
> website:
>
> https://coccinelle.gitlabpages.inria.fr/website/download.html
>
> However, upstream development (and the pcre2 patches) seem to appear
> only on INRIA's gitlab instance.  We actually couldn't find the
> patches or this git repo initially, as the coccinelle website doesn't
> seem to refer to it at all:
>
> https://gitlab.inria.fr/coccinelle/coccinelle
>
> It'd be nice if this was fixed (or the github repo was synchronized).

I updated the github repository.

julia

>
> Rich.
>
> --
> Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
> Read my programming and virtualization blog: http://rwmj.wordpress.com
> libguestfs lets you edit virtual machines.  Supports shell scripting,
> bindings from many languages.  http://libguestfs.org
>
>
