Return-Path: <SRS0=Zs5K=OW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF03C65BAE
	for <cocci@archiver.kernel.org>; Thu, 13 Dec 2018 06:25:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AD4120870
	for <cocci@archiver.kernel.org>; Thu, 13 Dec 2018 06:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD4120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBD6P3vA005216
          ; Thu, 13 Dec 2018 07:25:03 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EDBED76D5;
	Thu, 13 Dec 2018 07:25:02 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 822DA76AB
 for <cocci@systeme.lip6.fr>; Thu, 13 Dec 2018 07:25:01 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBD6P0LS003710
 for <cocci@systeme.lip6.fr>; Thu, 13 Dec 2018 07:25:00 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.56,347,1539640800"; d="scan'208";a="288887664"
Received: from abo-91-111-68.mrs.modulonet.fr (HELO hadrien) ([85.68.111.91])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2018 07:24:49 +0100
Date: Thu, 13 Dec 2018 07:24:49 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Max <msuraev@sysmocom.de>
In-Reply-To: <0c0bf80c-56bd-6560-12b8-97a4b1b89963@sysmocom.de>
Message-ID: <alpine.DEB.2.21.1812130724080.2458@hadrien>
References: <0c0bf80c-56bd-6560-12b8-97a4b1b89963@sysmocom.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 13 Dec 2018 07:25:03 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Thu, 13 Dec 2018 07:25:00 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] struct replacement
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



On Wed, 12 Dec 2018, Max wrote:

> Hi.
>
> I have been trying to use spatch to update c struct but haven't found a way to
> do so yet.
>
> For example, we have
>
> struct old_thing {
>
> uint8_t a;
>
> uint16_t b[5];
>
> };
>
> which I'd like to replace with
>
> struct new_thing {
>
> uint8_t x1;
>
> uint32_t x2;
>
> uint8_t x3[11];
>
> };
>
> So pretty much replace every function parameter:
>
> f1(... struct old_thing *t...) => f1(... struct new_thing *t...)
>
> Replace the field access and variable definitions:
>
> ...
>
> struct old_thing t1; => struct new_thing t1;
>
> struct old_thing *t2; => struct new_thing *t2;
>
> ...
>
> t1.a => t1.x1
>
> t2->b => t2->x3
>
> ...
>
> The thing which escapes me is how to make coccinelle treat it like a type?
>
> Do I need to use @@typedef struct old_thing@@? Do I use it as @@identifier
> old_stuff@@ or @@identifier struct old_stuff@@?
>
> Doesn't seem to work for me.
>
> Any links to .spatch examples playing around with structs would be greatly
> appreciated.

Again, please send your attempt.  What you want to do actually looks
straightforward, so it's hard for me to guess where the problem could be.

thanks,
julia

>
> --
> - Max Suraev <msuraev@sysmocom.de>       http://www.sysmocom.de/
> =======================================================================
> * sysmocom - systems for mobile communications GmbH
> * Alt-Moabit 93
> * 10559 Berlin, Germany
> * Sitz / Registered office: Berlin, HRB 134158 B
> * Geschaeftsfuehrer / Managing Directors: Harald Welte
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
