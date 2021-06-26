Return-Path: <SRS0=ELdy=LU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F7BC49EA6
	for <cocci@archiver.kernel.org>; Sat, 26 Jun 2021 20:16:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B35D619C3
	for <cocci@archiver.kernel.org>; Sat, 26 Jun 2021 20:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B35D619C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 15QKFxOv016974;
	Sat, 26 Jun 2021 22:15:59 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 897934108;
	Sat, 26 Jun 2021 22:15:59 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A13513783
 for <cocci@systeme.lip6.fr>; Sat, 26 Jun 2021 22:15:58 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 15QKFvrc008605
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 26 Jun 2021 22:15:58 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A7ODs7KEPDnBm+VZOpLqE78eALOsnbusQ8zAX?=
 =?us-ascii?q?PiFKOHhom6Oj/PxG8M5w6fawslcssRIb6LW90cu7IU80nKQdibX5f43SPzUO01?=
 =?us-ascii?q?HHEGgN1+ffKnHbak/D398Y5ONbf69yBMaYNzVHpMzxiTPWL+od?=
X-IronPort-AV: E=Sophos;i="5.83,302,1616454000"; d="scan'208";a="386249508"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Jun 2021 22:15:57 +0200
Date: Sat, 26 Jun 2021 22:15:56 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <edc2fdb429d184d05a70956ced00845bca2d4fe9.1623871406.git.christophe.jaillet@wanadoo.fr>
Message-ID: <alpine.DEB.2.22.394.2106262215080.3562@hadrien>
References: <edc2fdb429d184d05a70956ced00845bca2d4fe9.1623871406.git.christophe.jaillet@wanadoo.fr>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 26 Jun 2021 22:16:00 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 26 Jun 2021 22:15:58 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: michal.lkml@markovi.net, kernel-janitors@vger.kernel.org,
        nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] Coccinelle: Update and rename
 api/alloc/pci_free_consistent.cocci
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



On Wed, 16 Jun 2021, Christophe JAILLET wrote:

> 'pci_alloc_consistent()' is about to be removed from the kernel.
> It is now more useful to check for dma_alloc_coherent/dma_free_coherent.
>
> So change the script accordingly and rename it.

There also seem to be a lot of false positives, where the value is used in
unexpected ways, such as:

        for (i = 0; i < nr_pages; ++i) {
                cpu_addr = dma_alloc_coherent(dma_dev, PAGE_SIZE, &dma_addr,
                                              CIO_DMA_GFP);
                if (!cpu_addr)
                        return gp_dma;
                gen_pool_add_virt(gp_dma, (unsigned long) cpu_addr,
                                  dma_addr, PAGE_SIZE, -1);
        }

Maybe the rule should be dropped?

julia

>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Not sure that the script works.
> There are 718 'dma_alloc_coherent' calls in 5.13-rc6. It is surprising
> to have no match at all, not even a single false positive.
> ---
>  ..._consistent.cocci => dma_free_coherent.cocci} | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>  rename scripts/coccinelle/free/{pci_free_consistent.cocci => dma_free_coherent.cocci} (52%)
>
> diff --git a/scripts/coccinelle/free/pci_free_consistent.cocci b/scripts/coccinelle/free/dma_free_coherent.cocci
> similarity index 52%
> rename from scripts/coccinelle/free/pci_free_consistent.cocci
> rename to scripts/coccinelle/free/dma_free_coherent.cocci
> index d51e92556b42..75f159e7b6d7 100644
> --- a/scripts/coccinelle/free/pci_free_consistent.cocci
> +++ b/scripts/coccinelle/free/dma_free_coherent.cocci
> @@ -1,10 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/// Find missing pci_free_consistent for every pci_alloc_consistent.
> +/// Find missing dma_free_coherent for every dma_alloc_coherent.
>  ///
>  // Confidence: Moderate
>  // Copyright: (C) 2013 Petr Strnad.
>  // URL: http://coccinelle.lip6.fr/
> -// Keywords: pci_free_consistent, pci_alloc_consistent
> +// Keywords: dma_free_coherent, dma_alloc_coherent
>  // Options: --no-includes --include-headers
>
>  virtual report
> @@ -17,12 +17,12 @@ position p1,p2;
>  type T;
>  @@
>
> -id = pci_alloc_consistent@p1(x,y,&z)
> +id = dma_alloc_coherent@p1(x,y,&z)
>  ... when != e = id
>  if (id == NULL || ...) { ... return ...; }
> -... when != pci_free_consistent(x,y,id,z)
> -    when != if (id) { ... pci_free_consistent(x,y,id,z) ... }
> -    when != if (y) { ... pci_free_consistent(x,y,id,z) ... }
> +... when != dma_free_coherent(x,y,id,z)
> +    when != if (id) { ... dma_free_coherent(x,y,id,z) ... }
> +    when != if (y) { ... dma_free_coherent(x,y,id,z) ... }
>      when != e = (T)id
>      when exists
>  (
> @@ -40,7 +40,7 @@ p1 << search.p1;
>  p2 << search.p2;
>  @@
>
> -msg = "ERROR: missing pci_free_consistent; pci_alloc_consistent on line %s and return without freeing on line %s" % (p1[0].line,p2[0].line)
> +msg = "ERROR: missing dma_free_coherent; dma_alloc_coherent on line %s and return without freeing on line %s" % (p1[0].line,p2[0].line)
>  coccilib.report.print_report(p2[0],msg)
>
>  @script:python depends on org@
> @@ -48,6 +48,6 @@ p1 << search.p1;
>  p2 << search.p2;
>  @@
>
> -msg = "ERROR: missing pci_free_consistent; pci_alloc_consistent on line %s and return without freeing on line %s" % (p1[0].line,p2[0].line)
> +msg = "ERROR: missing dma_free_coherent; dma_alloc_coherent on line %s and return without freeing on line %s" % (p1[0].line,p2[0].line)
>  cocci.print_main(msg,p1)
>  cocci.print_secs("",p2)
> --
> 2.30.2
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
