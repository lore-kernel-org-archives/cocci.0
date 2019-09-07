Return-Path: <SRS0=qZnA=XC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2445C43331
	for <cocci@archiver.kernel.org>; Sat,  7 Sep 2019 16:05:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 321A5218AE
	for <cocci@archiver.kernel.org>; Sat,  7 Sep 2019 16:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321A5218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x87G5WHF006561;
	Sat, 7 Sep 2019 18:05:32 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7D70B7799;
	Sat,  7 Sep 2019 18:05:32 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2E87B7797
 for <cocci@systeme.lip6.fr>; Sat,  7 Sep 2019 18:05:30 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x87G5Tdh018585
 for <cocci@systeme.lip6.fr>; Sat, 7 Sep 2019 18:05:29 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.64,477,1559512800"; d="scan'208";a="400701616"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2019 18:05:29 +0200
Date: Sat, 7 Sep 2019 18:05:29 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <c8e0db8a-1f96-dac0-791c-43e2d1e1cf05@web.de>
Message-ID: <alpine.DEB.2.21.1909071804090.2562@hadrien>
References: <c8e0db8a-1f96-dac0-791c-43e2d1e1cf05@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-185961993-1567872329=:2562"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 07 Sep 2019 18:05:33 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sat, 07 Sep 2019 18:05:29 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Allison Randal <allison@lohutok.net>
Subject: Re: [Cocci]
 =?utf-8?q?Adjusting_SmPL_script_=E2=80=9Cptr=5Fret=2Ecocc?=
 =?utf-8?b?aeKAnT8=?=
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-185961993-1567872329=:2562
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sat, 7 Sep 2019, Markus Elfring wrote:

> Hello,
>
> I have taken another look at a known script for the semantic patch language.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/coccinelle/api/ptr_ret.cocci?id=1e3778cb223e861808ae0daccf353536e7573eed#n3
>
> I got the impression that duplicate SmPL code can be reduced here.
> So I tried the following approach out.
>
> …
> @depends on patch@
> expression ptr;
> @@
> (
> (
> - if (IS_ERR(ptr)) return PTR_ERR(ptr); else return 0;
> |
> - if (IS_ERR(ptr)) return PTR_ERR(ptr); return 0;
> )
> + return PTR_ERR_OR_ZERO(ptr);
> |
> - (IS_ERR(ptr) ? PTR_ERR(ptr) : 0)
> + PTR_ERR_OR_ZERO(ptr)
> )
> …
>
>
> Unfortunately, I got the following information then for a test transformation.
>
> elfring@Sonne:~/Projekte/Linux/next-patched> spatch -D patch scripts/coccinelle/api/ptr_ret.cocci drivers/spi/spi-gpio.c
> …
> 29: no available token to attach to
>
>
> It seems that the Coccinelle software “1.0.7-00218-gf284bf36” does not like
> the addition of the shown return statement after a nested SmPL disjunction.
> But the following SmPL code variant seems to work as expected.
>
>
> …
> @depends on patch@
> expression ptr;
> @@
> (
> - if (IS_ERR(ptr)) return PTR_ERR(ptr); else return 0;
> + return PTR_ERR_OR_ZERO(ptr);
> |
> - if (IS_ERR(ptr)) return PTR_ERR(ptr); return 0;
> + return PTR_ERR_OR_ZERO(ptr);
> |
> - (IS_ERR(ptr) ? PTR_ERR(ptr) : 0)
> + PTR_ERR_OR_ZERO(ptr)
> )
> …
>
>
> How do you think about to reduce subsequent SmPL rules also according to
> a possible recombination of affected implementation details?

There is not going to be any change with respect to this issue.  It's fine
when replacing one statement by another, but introduces complexity when
removing something more complex.  And there's not point to have something
that works in only one special case.

julia
--8323329-185961993-1567872329=:2562
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-185961993-1567872329=:2562--
