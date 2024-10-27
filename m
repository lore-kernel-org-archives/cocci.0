Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01D9D1356C
	for <cocci@archiver.kernel.org>; Sun, 27 Oct 2024 15:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=SoDbtuSX0QLzcHEEAoUdaVp4YZgMG/yHNRZjxeiDS1g=;
  b=B7LNOe8XnKWz3chsXKOtmZSTrUqcrGj+7x8ZY1O8FoLCzxfh67p0Uksl
   ljB+oSqhWg8ipOelFPy8OPFr7x4pU7TKPHi49JHD5raf/sKn18XtCUiJZ
   0CNq8dDSls0T5yDdrb9NOpMWmkI2q3IBoD04EeJGpTvnk72FUw8ngzmcW
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="190922824"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Oct 2024 16:25:57 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3F3E0E0D1D; Sun, 27 Oct 2024 16:25:57 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4F840E00B7
	for <cocci@sympa.inria.fr>; Sun, 27 Oct 2024 16:25:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SoDbtuSX0QLzcHEEAoUdaVp4YZgMG/yHNRZjxeiDS1g=;
  b=LXSLba8rYwX/OY/IATcQ3k0RAUIT+fv8mIwN/3YI+rf1YtZs9BJUBAYc
   OUu5NaDczwGuA2rEqf64eUFIrheaRVUWzuLttPUiKur04LGimoQzEJ29/
   /S4dj4t3AJb5IRQ/HL75GqAB7TMYrTa8JDR8FcieXhq10RaKjoYA+eC0e
   E=;
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="100137520"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 16:25:52 +0100
Date: Sun, 27 Oct 2024 16:25:51 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Andy Shevchenko <andy.shevchenko@gmail.com>
cc: Thorsten Blum <thorsten.blum@linux.dev>, Kees Cook <kees@kernel.org>, 
    Andy Shevchenko <andy@kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>, 
    linux-hardening@vger.kernel.org, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
In-Reply-To: <CAHp75VeeUKWakOWW7ft8BB9Gg=29_z93fCjDk_VGsqd8py878A@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2410271624210.3498@hadrien>
References: <20241027125858.1804-2-thorsten.blum@linux.dev> <CAHp75VeeUKWakOWW7ft8BB9Gg=29_z93fCjDk_VGsqd8py878A@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1609715228-1730042751=:3498"
Subject: Re: [cocci] [PATCH] coccinelle: Add str_off_on() and str_no_yes()
 rules
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1943
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/alpine.DEB.2.22.394.2410271624210.3498%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1609715228-1730042751=:3498
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 27 Oct 2024, Andy Shevchenko wrote:

> On Sun, Oct 27, 2024 at 2:59 PM Thorsten Blum <thorsten.blum@linux.dev> wrote:
> >
> > In addition to str_on_off() and str_yes_no(), add rules to search for
> > str_off_on() and str_no_yes() replacements.
>
> I don't know cocci well enough, but this does simply not scale. We
> also have cases where "Yes"/"No", "YES"/"NO" and all possible
> variations of that.

Andy, are you concerned about the number of such functions in the kernel
or the number of rules in the semantic patch.  There are indeed more
concise ways to write the semantic patch.

julia

>
>
> --
> With Best Regards,
> Andy Shevchenko
>
--8323329-1609715228-1730042751=:3498--
