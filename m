Return-Path: <SRS0=abNn=XD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEFAC433EF
	for <cocci@archiver.kernel.org>; Sun,  8 Sep 2019 08:24:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5190A206CD
	for <cocci@archiver.kernel.org>; Sun,  8 Sep 2019 08:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5190A206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x888O1gc005908;
	Sun, 8 Sep 2019 10:24:02 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CE15976D9;
	Sun,  8 Sep 2019 10:24:01 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 73B0E76C8
 for <cocci@systeme.lip6.fr>; Sun,  8 Sep 2019 10:23:59 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x888NxQb004227
 for <cocci@systeme.lip6.fr>; Sun, 8 Sep 2019 10:23:59 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.64,481,1559512800"; d="scan'208";a="400736864"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Sep 2019 10:23:58 +0200
Date: Sun, 8 Sep 2019 10:23:58 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9666134d-0ff6-81eb-b088-f0086a0e61b1@web.de>
Message-ID: <alpine.DEB.2.21.1909081019020.3340@hadrien>
References: <9666134d-0ff6-81eb-b088-f0086a0e61b1@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-349894428-1567931038=:3340"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 08 Sep 2019 10:24:02 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sun, 08 Sep 2019 10:23:59 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
        Yi Wang <wang.yi59@zte.com.cn>, Petr Strnad <strnape1@fel.cvut.cz>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        LKML <linux-kernel@vger.kernel.org>, Wen Yang <wen.yang99@zte.com.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Allison Randal <allison@lohutok.net>
Subject: Re: [Cocci] Coccinelle: pci_free_consistent: Checking when
	constraints
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

--8323329-349894428-1567931038=:3340
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 8 Sep 2019, Markus Elfring wrote:

> Hello,
>
> I have taken another look at a known script for the semantic patch language.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/coccinelle/free/pci_free_consistent.cocci?id=950b07c14e8c59444e2359f15fd70ed5112e11a0#n2
>
> The following SmPL code is used there so far.
>
> …
> ... when != pci_free_consistent(x,y,id,z)
>     when != if (id) { ... pci_free_consistent(x,y,id,z) ... }
>     when != if (y) { ... pci_free_consistent(x,y,id,z) ... }
> …
>
>
> It is specified that a specific function call should be excluded
> in a source code search.
> I do not see a need to repeat the specification twice that such a call
> could eventually happen also within a branch of another if statement.
> How do you think about to omit possibly redundant SmPL code at this place?

Have you actually run the rule and checked the impact of your proposed
change?

The when exists below these lines has an impact.  I believe that the rule
is ok as is.  A single path may have no call to pci_free_consistent, but
if it has that call under one of the mentioned ifs, then the path is still
ok, and not something that an error should be reported about.

julia
--8323329-349894428-1567931038=:3340
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-349894428-1567931038=:3340--
