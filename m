Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C235AC7EE39
	for <cocci@archiver.kernel.org>; Sun, 29 Jun 2025 13:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=xo5Rcy7pSsbkSz1YqEL44HyHjkoTSnOOZ0hstvGoRqQ=;
  b=DTEup2vjeJK8veW67noIkmA+L/NQLEQqjsM+7Ae2yXKxrbkt8w/v9VQV
   hIm5Q+Z9usMMekT5jEAVA04sC8a9uh99X4hTv55GUGyRH/zM0lcFPSzB2
   NBlDdWjoSKioMuXAdT01fCnrKjK39Ow2sarcKuNMflX8B7vuP+SxjICrT
   U=;
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
X-IronPort-AV: E=Sophos;i="6.16,275,1744063200"; 
   d="scan'208";a="229462695"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jun 2025 15:29:06 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 81C5CE0157; Sun, 29 Jun 2025 15:29:06 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 67B4DE0131
	for <cocci@sympa.inria.fr>; Sun, 29 Jun 2025 15:29:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xo5Rcy7pSsbkSz1YqEL44HyHjkoTSnOOZ0hstvGoRqQ=;
  b=b7PWGAFxItI9wa/kx9jn0589zev0Bmv0pmF3jZVWcvB7WTiwrQrX6X5t
   9i6H5lNPmWuqtQg7D7ebl5kdj+CcR5hCoGL21CPN631A/1x2U2748h/w3
   1HqzaOB7/BYPa3vXCDNM7T93Ix1ISUe/PupYGG0qQ4DKBG7B3YLRaj5cF
   Q=;
X-IronPort-AV: E=Sophos;i="6.16,275,1744063200"; 
   d="scan'208";a="120223002"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 15:29:02 +0200
Date: Sun, 29 Jun 2025 15:29:01 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <bd0e8447-49a9-4bdc-a642-05cb48d54384@web.de>
Message-ID: <alpine.DEB.2.22.394.2506291528480.95572@hadrien>
References: <bd0e8447-49a9-4bdc-a642-05cb48d54384@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for longer conjunctions (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2811
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/alpine.DEB.2.22.394.2506291528480.95572%40hadrien>



On Sun, 29 Jun 2025, Markus Elfring wrote:

> Hello,
>
> Is there a need to refine a source code search pattern (like the following)?
>
>
> @display@
> expression a, b, c, d;
> @@
> (
> *a && b && c && d && ...
> |
> *a && b && c && d
> )

I don't see the point having both cases.

julia

>
>
> Would you be looking for more powerful data processing systems for further
> static code analysis attempts (also according to Linux source files)?
>
> Regards,
> Markus
>
