Return-Path: <SRS0=NeE8=PE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CA0C43387
	for <cocci@archiver.kernel.org>; Thu, 27 Dec 2018 19:59:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A48C6208E4
	for <cocci@archiver.kernel.org>; Thu, 27 Dec 2018 19:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A48C6208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBRJxQBp011842
          ; Thu, 27 Dec 2018 20:59:26 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B65A776DC;
	Thu, 27 Dec 2018 20:59:26 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 000B076DA
 for <cocci@systeme.lip6.fr>; Thu, 27 Dec 2018 20:59:24 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBRJxOvp014993
 for <cocci@systeme.lip6.fr>; Thu, 27 Dec 2018 20:59:24 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.56,406,1539640800"; d="scan'208";a="290296278"
Received: from abo-91-111-68.mrs.modulonet.fr (HELO hadrien) ([85.68.111.91])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2018 20:49:57 +0100
Date: Thu, 27 Dec 2018 20:49:57 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: SF Markus Elfring <elfring@users.sourceforge.net>
In-Reply-To: <36f19c49-a6e9-11f1-2bb8-c22ad3ca8e54@users.sourceforge.net>
Message-ID: <alpine.DEB.2.21.1812272049150.2393@hadrien>
References: <61e8d3e3-e445-fc51-a9cc-c982dbb73bdb@users.sourceforge.net>
 <alpine.DEB.2.21.1812251444350.8365@hadrien>
 <a6c91cf5-4ff3-9088-0b58-b0039e495d58@users.sourceforge.net>
 <alpine.DEB.2.21.1812251700080.8365@hadrien>
 <88be4433-a617-056e-3dee-495a41e46110@users.sourceforge.net>
 <alpine.DEB.2.21.1812251734590.8365@hadrien>
 <afd513b0-e16a-a5ca-088f-244a31097f9d@users.sourceforge.net>
 <f1884111-1762-b96e-7f08-c327704e5ba0@users.sourceforge.net>
 <alpine.DEB.2.21.1812251823440.8365@hadrien>
 <ff650b4e-5058-e2d6-9815-4f8372ed32c1@users.sourceforge.net>
 <alpine.DEB.2.21.1812271622350.2457@hadrien>
 <36f19c49-a6e9-11f1-2bb8-c22ad3ca8e54@users.sourceforge.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 27 Dec 2018 20:59:27 +0100 (CET)
X-Greylist: Delayed for 00:09:26 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Thu, 27 Dec 2018 20:59:24 +0100 (CET)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr



On Thu, 27 Dec 2018, SF Markus Elfring wrote:

> > If you have a problem, provide a complete example.
>
> Do you find software development difficulties easier
> to clarify based on source code analysis by a SmPL script
> like the following?
>
> @find@
> identifier f, x;
> type ft, xt;
> @@
>  ft f(...)
>  {
>  ... when any
>  xt x;
>  ... when != x
>  }
>
> @show@
> identifier find.f, find.x;
> type find.ft, find.xt;
> @@
>  ft f(...)
>  {
>  ... when any
>  xt x;
>  ...
> *x
>  ...
>  }

I don't know what you expect the second rule to do, but it will only match
when there exists a control-flow path through the function where x is
referenced exactly once.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
