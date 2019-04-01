Return-Path: <SRS0=4bC8=SD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62270C43381
	for <cocci@archiver.kernel.org>; Mon,  1 Apr 2019 20:05:00 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43FE20857
	for <cocci@archiver.kernel.org>; Mon,  1 Apr 2019 20:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43FE20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x31K4PFQ025194
          ; Mon, 1 Apr 2019 22:04:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 46A297728;
	Mon,  1 Apr 2019 22:04:25 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3D3DA7715
 for <cocci@systeme.lip6.fr>; Mon,  1 Apr 2019 22:04:23 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x31K4LSp023512
 for <cocci@systeme.lip6.fr>; Mon, 1 Apr 2019 22:04:21 +0200 (CEST)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.60,297,1549926000"; d="scan'208";a="301442042"
Received: from abo-75-106-68.mrs.modulonet.fr (HELO hadrien) ([85.68.106.75])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 22:04:20 +0200
Date: Mon, 1 Apr 2019 22:04:20 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <94e2410b-d474-be9e-a69f-3851e609eed3@web.de>
Message-ID: <alpine.DEB.2.21.1904012203490.2530@hadrien>
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
 <179bbdd1-3fcb-bba5-52b3-7f96973c7650@web.de>
 <alpine.DEB.2.21.1903232104030.5660@hadrien> <20190326084512.GC32590@kadam>
 <alpine.DEB.2.20.1903261037320.5021@hadrien> <20190326101103.GH32613@kadam>
 <alpine.DEB.2.20.1903261115300.5021@hadrien>
 <CAK7LNAT9gKvEX9520Sd50vrS7Gug1JQCMx_TJO_KPQjhjPORXw@mail.gmail.com>
 <94e2410b-d474-be9e-a69f-3851e609eed3@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 01 Apr 2019 22:04:26 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Mon, 01 Apr 2019 22:04:21 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr,
        Wen Yang <wen.yang99@zte.com.cn>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [Cocci] Coccinelle: put_device: reduce false positives
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr



On Mon, 1 Apr 2019, Markus Elfring wrote:

> > I added Fixes: tag,
> > and applied to linux-kbuild/fixes.
>
> Will this extension trigger further adjustments for similar SmPL scripts?
>
> Example:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/scripts/coccinelle/free/pci_free_consistent.cocci?id=f7b167113753e95ae61383e234f8d10142782ace

If there are false positives caused by this or other scripts, feel free to
submit a patch.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
