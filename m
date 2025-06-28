Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED21C54ED1
	for <cocci@archiver.kernel.org>; Sat, 28 Jun 2025 19:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=lUkQ4FsOQtQektmqVu5QGp+0KX4r390uoq8hom5JN+E=;
  b=pdMp/D4aTxn5O/vnk8wUYIXpcmPYEORO+F9AwVm7/o5IrqNDirahzv0L
   IlSwBuCyci8kOdpTNvGVCBug0J3/+LNOE/qi1K5Q4e4dl0YraSSTqh+Xv
   quV02QpNZIBSj67TuCQUHx73I7uUn9jGtClyURZd5YxyCUm3vbfugsAr5
   c=;
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
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; 
   d="scan'208";a="229433953"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jun 2025 21:32:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BF1A4E01A8; Sat, 28 Jun 2025 21:32:28 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6F213E0131
	for <cocci@sympa.inria.fr>; Sat, 28 Jun 2025 21:32:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lUkQ4FsOQtQektmqVu5QGp+0KX4r390uoq8hom5JN+E=;
  b=tQ8C937MYNX1aVYpQ6kLDr7G7dZXjZetqDQLIBaNGkSsQhrflPRH5Ddt
   NsdQxzxa2dSyAbifglEsd7txzb2KXFiQHI+JxLJxyyQ9njNj3+s9ixke5
   g8sAM9i1okOo+yVBDy+B7KCtHlW0aJpZOUSvHnyR+y9CVZZrLdEOR7Fme
   E=;
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; 
   d="scan'208";a="229433952"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2025 21:32:24 +0200
Date: Sat, 28 Jun 2025 21:32:24 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <1f3bd2ed-0252-4347-835f-5fecda857cf0@web.de>
Message-ID: <alpine.DEB.2.22.394.2506282132040.50494@hadrien>
References: <2038c080-a429-44bb-a572-c1f9e733320d@web.de> <alpine.DEB.2.22.394.2506281638300.50494@hadrien> <1f3bd2ed-0252-4347-835f-5fecda857cf0@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Avoiding metavariable confusion for duplicate
 identifiers?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2800
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/alpine.DEB.2.22.394.2506282132040.50494%40hadrien>



On Sat, 28 Jun 2025, Markus Elfring wrote:

> >> @replacement@
> >> @@
> >> -msg -> msg [ 0 ] & 0xf
> >> +cec_msg_destination(msg)
> >>
> >>
> >> Now I wonder which metavariable selections would be appropriate for such
> >> an use case.
> >
> > I'm not sure what the concern is.
>
> Data processing configuration challenges might become clearer.
> I suggest to take another look at corresponding case distinctions.
>
>
> >                                    If you want a metavariable that can
> > match both occurrences of msg,
>
> This is probably unlikely if I would like to refer to a single
> function input parameter.
>
>
> >                                then that would be an identifier.
> I would prefer to distinguish a function argument from a data structure
> member (despite of identical names in this case).
> Can a manual rename be avoided here?

If you want a metavariable name that is different, then use a different
name.

julia
