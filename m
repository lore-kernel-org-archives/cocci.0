Return-Path: <SRS0=DNKl=N2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC312C43441
	for <cocci@archiver.kernel.org>; Thu, 15 Nov 2018 21:30:05 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79F712087A
	for <cocci@archiver.kernel.org>; Thu, 15 Nov 2018 21:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F712087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wAFLTqhe026322
          ; Thu, 15 Nov 2018 22:29:52 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 490DC76D2;
	Thu, 15 Nov 2018 22:29:52 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 20D3376CB
 for <cocci@systeme.lip6.fr>; Thu, 15 Nov 2018 22:29:51 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wAFLTncT001194
 for <cocci@systeme.lip6.fr>; Thu, 15 Nov 2018 22:29:50 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.56,237,1539640800"; d="scan'208";a="355897127"
Received: from unknown (HELO hadrien) ([64.114.255.114])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Nov 2018 22:29:48 +0100
Date: Thu, 15 Nov 2018 13:29:46 -0800 (PST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Timur Tabi <timur@kernel.org>
In-Reply-To: <CAOZdJXVLMv-5_u1uOq6re+1O3vADsrTK0+J3Fat-XN4_2DEp4w@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1811151327420.2372@hadrien>
References: <CAOZdJXVLMv-5_u1uOq6re+1O3vADsrTK0+J3Fat-XN4_2DEp4w@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 15 Nov 2018 22:29:53 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Thu, 15 Nov 2018 22:29:50 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Can the current function name be passed to a Python
 snippet?
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



On Thu, 15 Nov 2018, Timur Tabi wrote:

> Is it possible for a Python code snippet to be passed the name of the
> current function?  I already have Python code in my .cocci file that
> cleans up the text of some string literals.  I want to add more code
> that removes the current function name from the beginning of a string
> literal.  So for instance, If I have
>
> void myfunc(void)
> {
> ...
>     NV_PRINTF("myfunc: xxx\n");
>
> I want to replace the NV_PRINTF line with:
>
>     NV_PRINTF("xxx\n");
>
> To do that, the Python code would need to given "myfunc" as a
> parameter of some kind.

The name of the current function at a given match is available in a
position variable bound as part of that match.  A position variable should
have a current_element field.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
