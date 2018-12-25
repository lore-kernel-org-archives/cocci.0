Return-Path: <SRS0=i97o=PC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CC6C43387
	for <cocci@archiver.kernel.org>; Tue, 25 Dec 2018 13:45:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2F30217D4
	for <cocci@archiver.kernel.org>; Tue, 25 Dec 2018 13:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F30217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBPDj86t017985
          ; Tue, 25 Dec 2018 14:45:08 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 32F6576DC;
	Tue, 25 Dec 2018 14:45:08 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BEA4360D7
 for <cocci@systeme.lip6.fr>; Tue, 25 Dec 2018 14:45:06 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBPDj613002055
 for <cocci@systeme.lip6.fr>; Tue, 25 Dec 2018 14:45:06 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.56,396,1539640800"; d="scan'208";a="361750786"
Received: from abo-91-111-68.mrs.modulonet.fr (HELO hadrien) ([85.68.111.91])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Dec 2018 14:45:06 +0100
Date: Tue, 25 Dec 2018 14:45:05 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: SF Markus Elfring <elfring@users.sourceforge.net>
In-Reply-To: <61e8d3e3-e445-fc51-a9cc-c982dbb73bdb@users.sourceforge.net>
Message-ID: <alpine.DEB.2.21.1812251444350.8365@hadrien>
References: <61e8d3e3-e445-fc51-a9cc-c982dbb73bdb@users.sourceforge.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1949509920-1545745506=:8365"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 25 Dec 2018 14:45:08 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Tue, 25 Dec 2018 14:45:06 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Deleting unused declarations for variables with SmPL?
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

--8323329-1949509920-1545745506=:8365
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 25 Dec 2018, SF Markus Elfring wrote:

> Hello,
>
> I have tried another simple script out for the semantic patch language.
>
> @deletion@
> identifier x;
> type t;
> @@
> -t x;
>  ... when != x

f(...) {
   ... when any
   t x;
   ... when != x
}

julia


>
>
> elfring@Sonne:~/Projekte/Linux/next-patched> spatch ~/Projekte/Coccinelle/Probe/delete_unused_variable1.cocci init/main.c
> …
> @@ -101,22 +101,6 @@
>
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/initcall.h>
> -
> -static int kernel_init(void *);
> -
> -extern void init_IRQ(void);
> …
>
>
> Now I wonder about the generated change suggestions.
> Does such a transformation approach need any extensions for the safe handling
> of function declarations?
>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
--8323329-1949509920-1545745506=:8365
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1949509920-1545745506=:8365--
