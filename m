Return-Path: <SRS0=HsoC=QA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACECC282C3
	for <cocci@archiver.kernel.org>; Thu, 24 Jan 2019 20:20:16 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1E8C217D7
	for <cocci@archiver.kernel.org>; Thu, 24 Jan 2019 20:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E8C217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0OKJuIi004607
          ; Thu, 24 Jan 2019 21:19:56 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 46E8F76EA;
	Thu, 24 Jan 2019 21:19:56 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 85F6476E9
 for <cocci@systeme.lip6.fr>; Thu, 24 Jan 2019 21:19:54 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0OKJr8U016549
 for <cocci@systeme.lip6.fr>; Thu, 24 Jan 2019 21:19:53 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.56,518,1539640800"; d="scan'208";a="293207746"
Received: from 208.124.14.109.rev.sfr.net (HELO hadrien) ([109.14.124.208])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Jan 2019 21:19:53 +0100
Date: Thu, 24 Jan 2019 21:19:53 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Timur Tabi <timur@kernel.org>
In-Reply-To: <CAOZdJXUg+1M-ii-tEtYdjDyXuEUYbmHYSf-EqfzFh+OtuWLP7A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1901242119310.2415@hadrien>
References: <CAOZdJXUg+1M-ii-tEtYdjDyXuEUYbmHYSf-EqfzFh+OtuWLP7A@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 24 Jan 2019 21:19:57 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Thu, 24 Jan 2019 21:19:53 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Blank space in front of function definition name
 confuses spatch
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



On Tue, 22 Jan 2019, Timur Tabi wrote:

> If I have a blank space in front of the return parameter and function
> name, spatch gets confused and rejects the file.  I've attached a
> test.c and my nv_printf.cocci.  If I remove the blank space before
> "NV_STATUS" and "mycrazyfunc", everything works.  But with the blank
> space, it causes this error:
>
> ERROR-RECOV: found sync '}' at line 14
> parsing pass2: try again
> ERROR-RECOV: found sync '}' at line 14
> parsing pass3: try again
> ERROR-RECOV: found sync '}' at line 14
> parse error
>  = File "/home/ttabi/test.c", line 1, column 1, charpos = 1
>   around = 'NV_STATUS',
>   whole content =  NV_STATUS
> badcount: 13
> BAD:!!!!!  NV_STATUS
> bad:  mycrazyfunc
> bad: (

This should be fixed in the version on github.  Please try again.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
