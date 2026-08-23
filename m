Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2588C5DF81
	for <cocci@archiver.kernel.org>; Sun, 23 Aug 2026 17:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=SkhO46d2ljKBTJNslkVa6uOxCIcy3CWJo768Hp//HGM=;
  b=leYBfRfUgKzI8OimSKjhhX7qYZhHp4QA6RMf7y7xGBigl9m8fD+BTJDh
   FzrylxWaQyJecV+KNTS3LouMnmlscm6ihtW71fvHn+vZYJkJDR3jvt0k2
   iLbhhsOtTk3te0QZtISCf/0SZVj6kngq0wsEc3moUcOKZxjWuCh5fHQ4R
   U=;
X-CSE-ConnectionGUID: XrkgkK1MT4Wh6zgK+2K0TQ==
X-CSE-MsgGUID: xx/eu8PZQ9OQ1gbQaV7hdQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.25,239,1779141600"; 
   d="scan'208";a="291145981"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Aug 2026 19:06:00 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 3E5C380E7D; Sun, 23 Aug 2026 19:06:00 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id AA3E380E6A
	for <cocci@sympa.inria.fr>; Sun, 23 Aug 2026 19:05:58 +0200 (CEST)
X-CSE-ConnectionGUID: c5PgaPgiSb+AAMXPQtkW5w==
X-CSE-MsgGUID: cZvFnlMOSi+WpPdWzCrwmg==
X-IronPort-AV: E=Sophos;i="6.25,239,1779141600"; 
   d="scan'208";a="291145969"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 19:05:58 +0200
Date: Sun, 23 Aug 2026 19:05:58 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
cc: Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
In-Reply-To: <20260823161826.3805598-2-ekffu200098@gmail.com>
Message-ID: <18e653f-8171-8039-489e-52ff8b8f902e@inria.fr>
References: <20260823161826.3805598-1-ekffu200098@gmail.com> <20260823161826.3805598-2-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH 1/7] coccinelle: remove obsolete
 pci_free_consistent.cocci
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3690
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/_elKIEhqwP3jcid2-UcHPQ>



On Mon, 24 Aug 2026, Sang-Heon Jeon wrote:

> pci_alloc_consistent() and pci_free_consistent() were removed by commit
> 7968778914e5 ("PCI: Remove the deprecated "pci-dma-compat.h" API").

Thanks.

There are a lot of other references to these things:

Documentation/scsi/ChangeLog.arcmsr:**						8.replace pci_alloc_consistent()/pci_free_consistent() with kmalloc()/kfree() in arcmsr_iop_message_xfer()
arch/alpha/kernel/pci_iommu.c:	DBGA2("pci_free_consistent: [%llx,%zx] from %ps\n",
arch/sparc/kernel/ioport.c: * <zaitcev> Now, driver calls pci_free_consistent(with result of
drivers/net/fddi/defxx.h:	char				*kmalloced;					/* pci_free_consistent this on unload */
drivers/parisc/ccio-dma.c: * This function implements the pci_free_consistent function.
drivers/scsi/3w-xxxx.c:   1.02.00.029 - Add missing pci_free_consistent() in tw_allocate_memory().
sound/pci/asihpi/hpios.h:Need all info for parameters to pci_free_consistent

Documentation/scsi/53c700.rst:  used for the pci_alloc_consistent() and pci_map_*() functions.
Documentation/scsi/ChangeLog.arcmsr:**						8.replace pci_alloc_consistent()/pci_free_consistent() with kmalloc()/kfree() in arcmsr_iop_message_xfer()
Documentation/scsi/ChangeLog.megaraid_sas:	   pci_alloc_consistent replaced by dma_alloc_coherent. With this
Documentation/scsi/ChangeLog.megaraid_sas:	> pci_alloc_consistent() just goes and assumes GFP_ATOMIC, whereas
arch/alpha/kernel/pci_iommu.c:		printk(KERN_INFO "pci_alloc_consistent: "
arch/alpha/kernel/pci_iommu.c:	DBGA2("pci_alloc_consistent: %zx -> [%p,%llx] from %ps\n",
arch/alpha/kernel/pci_iommu.c:   be values that were returned from pci_alloc_consistent.  SIZE must
arch/alpha/kernel/pci_iommu.c:   be the same as what as passed into pci_alloc_consistent.
arch/powerpc/platforms/pseries/iommu.c:	 * a power of two (due to pci_alloc_consistent requirements).
arch/sparc/kernel/ioport.c: * <rth> zait: as long as pci_alloc_consistent produces something addressable,
drivers/misc/genwqe/card_utils.c: *               page_list and pci_alloc_consistent for the sg_list.
drivers/net/wan/wanxl.c:	 * and pray pci_alloc_consistent() will use this info. It should
drivers/net/wan/wanxl.c:	printk(KERN_DEBUG "wanXL %s: pci_alloc_consistent() returned memory"
drivers/parisc/ccio-dma.c:** o SAFE_DMA must be set for "memory" allocated via pci_alloc_consistent().
drivers/parisc/ccio-dma.c:#define HINT_SAFE_DMA   0x02UL	/* used for pci_alloc_consistent() pages */
drivers/parisc/ccio-dma.c: * This function implements the pci_alloc_consistent function.
sound/pci/asihpi/hpios.h:/** Details of a memory area allocated with  pci_alloc_consistent

julia



>
> So remove the obsolete script.
>
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  .../coccinelle/free/pci_free_consistent.cocci | 53 -------------------
>  1 file changed, 53 deletions(-)
>  delete mode 100644 scripts/coccinelle/free/pci_free_consistent.cocci
>
> diff --git a/scripts/coccinelle/free/pci_free_consistent.cocci b/scripts/coccinelle/free/pci_free_consistent.cocci
> deleted file mode 100644
> index e062b9ba09ff..000000000000
> --- a/scripts/coccinelle/free/pci_free_consistent.cocci
> +++ /dev/null
> @@ -1,53 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/// Find missing pci_free_consistent for every pci_alloc_consistent.
> -///
> -// Confidence: Moderate
> -// Copyright: (C) 2013 Petr Strnad.
> -// URL: https://coccinelle.gitlabpages.inria.fr/website
> -// Keywords: pci_free_consistent, pci_alloc_consistent
> -// Options: --no-includes --include-headers
> -
> -virtual report
> -virtual org
> -
> -@search@
> -local idexpression id;
> -expression x,y,z,e;
> -position p1,p2;
> -type T;
> -@@
> -
> -id = pci_alloc_consistent@p1(x,y,&z)
> -... when != e = id
> -if (id == NULL || ...) { ... return ...; }
> -... when != pci_free_consistent(x,y,id,z)
> -    when != if (id) { ... pci_free_consistent(x,y,id,z) ... }
> -    when != if (y) { ... pci_free_consistent(x,y,id,z) ... }
> -    when != e = (T)id
> -    when exists
> -(
> -return 0;
> -|
> -return 1;
> -|
> -return id;
> -|
> -return@p2 ...;
> -)
> -
> -@script:python depends on report@
> -p1 << search.p1;
> -p2 << search.p2;
> -@@
> -
> -msg = "ERROR: missing pci_free_consistent; pci_alloc_consistent on line %s and return without freeing on line %s" % (p1[0].line,p2[0].line)
> -coccilib.report.print_report(p2[0],msg)
> -
> -@script:python depends on org@
> -p1 << search.p1;
> -p2 << search.p2;
> -@@
> -
> -msg = "ERROR: missing pci_free_consistent; pci_alloc_consistent on line %s and return without freeing on line %s" % (p1[0].line,p2[0].line)
> -cocci.print_main(msg,p1)
> -cocci.print_secs("",p2)
> --
> 2.43.0
>
>
