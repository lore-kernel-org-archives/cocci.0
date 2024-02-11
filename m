Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC81C4829B
	for <cocci@archiver.kernel.org>; Sun, 11 Feb 2024 13:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=arrn6wKfyr5sB6peVRuy7KXtX8TvXqWi2a49LazDjQ0=;
  b=SiFN6+krf1Q8Ofl+Pl1n5V17Ms+XyeGtSkBBLGpfonU0kG6/XNZkGcN0
   8+dd0k8BRCEErdiunmRUDv1dwotU4i8DHmaOt7Vbk6cSgWucfqHPcfea0
   e0Qz1YP2kG3AxL4/xVp9Aj39c+82OCp5EZ06r32oQARVzFq2yFhZfwM6s
   I=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.05,261,1701126000"; 
   d="scan'208";a="151359796"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Feb 2024 14:54:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B7204E00B7; Sun, 11 Feb 2024 14:54:33 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 300C7E008A
	for <cocci@sympa.inria.fr>; Sun, 11 Feb 2024 14:54:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=arrn6wKfyr5sB6peVRuy7KXtX8TvXqWi2a49LazDjQ0=;
  b=hCVuA6s+urE75gV/wbbLN5R5u3MGbrdAUu2mZhr4fLMZCA6Gz39UGHFK
   c/U8BM3uwMe5H2S57qWl2OOzA5+5QjdI/9GVF+1vfA09j8tGiaTnl6oJq
   5sm1fVf4O6fugjz83mVNEzQB7SchNj1EmPpRwuDzqzuyhER7rCrHIhwZW
   g=;
X-IronPort-AV: E=Sophos;i="6.05,261,1701126000"; 
   d="scan'208";a="79314270"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 14:54:28 +0100
Date: Sun, 11 Feb 2024 14:54:27 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <b6318c80-5ced-4ae1-bf26-52826fbfbe7f@web.de>
Message-ID: <alpine.DEB.2.22.394.2402111454200.53569@hadrien>
References: <d4abffb5-6221-4109-9316-acb5c3720c31@web.de> <alpine.DEB.2.22.394.2402100936350.53569@hadrien> <1c2bfc73-cf2e-4949-bf60-6fc432ef67a8@web.de> <alpine.DEB.2.22.394.2402101124030.53569@hadrien> <501ef7d8-223c-4647-a302-7aeee083af14@web.de>
 <alpine.DEB.2.22.394.2402101421490.53569@hadrien> <836e2ebd-a9cf-4644-9619-2526bddae0bd@web.de> <alpine.DEB.2.22.394.2402101554070.53569@hadrien> <400ced6a-bf8b-4ddc-afea-a5d0bb49234b@web.de> <alpine.DEB.2.22.394.2402111426580.53569@hadrien>
 <b6318c80-5ced-4ae1-bf26-52826fbfbe7f@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-68382014-1707659667=:53569"
Subject: Re: [cocci] Extending handling of position information for SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1548
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/alpine.DEB.2.22.394.2402111454200.53569%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-68382014-1707659667=:53569
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 11 Feb 2024, Markus Elfring wrote:

> …
> >> @rename@
> >> identifier f;
> >> position x;
> >> @@
> >> -f
> >> +g
> >>   (x,x)
> …
> >                    A position variable has to be attached to something.
> > And anyway, there is no hope that the two arguments of a function will be
> > in the same position.
>
> Would you like to offer clearer error messages for such special cases?

OK
--8323329-68382014-1707659667=:53569--
