Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B52C4345F
	for <cocci@archiver.kernel.org>; Fri, 19 Apr 2024 07:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=lZKIvqMY0yDjmj+RCqXjIQ/hqzgZ/plMeZWor4/tnHs=;
  b=Ezks1Ojr+SNqYNnfr5mvOJl8GEqnhE5/W9/FxTvVBKGQ3fmTp+kqyMd2
   FSeNIqYxYsV3RZeO40jH2qKJ6NTinBmY7ioHJwn5HqzrIqr20JC6p2J7x
   uLx7VQSXIQTWv7geWY1euV59qXx7FJpo41vPY2WYKbxMjx6Ruwr3eZhGS
   w=;
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
X-IronPort-AV: E=Sophos;i="6.07,213,1708383600"; 
   d="scan'208";a="162354925"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Apr 2024 09:01:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C924FE013D; Fri, 19 Apr 2024 09:01:23 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5E7D4E0035
	for <cocci@sympa.inria.fr>; Fri, 19 Apr 2024 09:01:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lZKIvqMY0yDjmj+RCqXjIQ/hqzgZ/plMeZWor4/tnHs=;
  b=oCh4lCzCaB7R0QO/V04lwiVU73U/Zo2jCNbiyE/o/OC+QqodUUY3CPTy
   BH2N4kJIVz14Et7EVqH0NVWjaRr6JlwQ0VzCydDxlB4AltgQCGkB4uabX
   Vc7b+zr2HDtXO/bV4H7uZggCl5IKCUhOWxQ9e61p9P2VTxiZJn3o/J98E
   4=;
X-IronPort-AV: E=Sophos;i="6.07,213,1708383600"; 
   d="scan'208";a="85211701"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 09:01:22 +0200
Date: Fri, 19 Apr 2024 09:01:21 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, 
    Ricardo Ribalda <ribalda@chromium.org>, Denis Efremov <efremov@linux.com>, 
    Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <f1f47166-00d7-49f3-9b80-34aa7b7b5510@web.de>
Message-ID: <1530259-fe0-eb35-6f8a-58f272adef5@inria.fr>
References: <20240415-minimax-v1-1-5feb20d66a79@chromium.org> <alpine.DEB.2.22.394.2404182255010.3213@hadrien> <f1f47166-00d7-49f3-9b80-34aa7b7b5510@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-533158061-1713510082=:3432"
Subject: Re: [cocci] [PATCH] coccinelle: misc: minmax: Suppress reports for
 err returns
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1675
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/1530259-fe0-eb35-6f8a-58f272adef5%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-533158061-1713510082=:3432
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 19 Apr 2024, Markus Elfring wrote:

> >> Most of the people prefer:
> >>
> >> return ret < 0 ? ret: 0;
> >>
> >> than:
> >>
> >> return min(ret, 0);
> >>
> >> Let's tweak the cocci file to ignore those lines completely.
> …
> > Applied, thanks. (Coccinelle for-6.10 branch).
>
> Was a planned code adjustment published?

There is no "planned code adjustment" if there is no patch.

I can check the dependencies again.

julia

>
>
> …
> >> +++ b/scripts/coccinelle/misc/minmax.cocci
> >> @@ -50,11 +50,26 @@ func(...)
> >>  	...>
> >>  }
> >>
> >> +// Ignore errcode returns.
> >> +@errcode@
> …
> >> -// Don't generate patches for errcode returns.
> >> -@errcode depends on patch@
> …
>
> How does such a change fit to the usability of the coccicheck operation modes
> “context” and “org”?
>
> Should dependencies be reconsidered any more for the desired consistency
> of involved rules for scripts of the semantic patch language?
>
> Regards,
> Markus
>
--8323329-533158061-1713510082=:3432--
