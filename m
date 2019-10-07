Return-Path: <SRS0=Cozf=YA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F65EECE58C
	for <cocci@archiver.kernel.org>; Mon,  7 Oct 2019 20:44:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C91062084D
	for <cocci@archiver.kernel.org>; Mon,  7 Oct 2019 20:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91062084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x97KiWL9014446;
	Mon, 7 Oct 2019 22:44:32 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 247D977A9;
	Mon,  7 Oct 2019 22:44:32 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3EBB576ED
 for <cocci@systeme.lip6.fr>; Mon,  7 Oct 2019 22:44:31 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x97KiUkS013324
 for <cocci@systeme.lip6.fr>; Mon, 7 Oct 2019 22:44:30 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.67,269,1566856800"; d="scan'208";a="405127194"
Received: from 81-65-53-202.rev.numericable.fr (HELO hadrien) ([81.65.53.202])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 22:44:30 +0200
Date: Mon, 7 Oct 2019 22:44:30 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <f4d2b005-5d5f-5d5b-430e-9921eba80b6e@web.de>
Message-ID: <alpine.DEB.2.21.1910072244150.2578@hadrien>
References: <f4d2b005-5d5f-5d5b-430e-9921eba80b6e@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2031708665-1570481070=:2578"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 07 Oct 2019 22:44:32 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Mon, 07 Oct 2019 22:44:30 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Adding code after function return types with SmPL
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

--8323329-2031708665-1570481070=:2578
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Mon, 7 Oct 2019, Markus Elfring wrote:

> Hello,
>
> I would like to try the following transformation approach out with
> the software combination “Coccinelle 1.0.8-00004-g842075f7”.
>
> @addition@
> identifier f;
> type rt != void;
> @@
>  rt
> +__must_check
>  f(...);
>
>
> elfring@Sonne:~/Projekte/Coccinelle/janitor> spatch --parse-cocci use_must_check.cocci
> init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
> plus: parse error:
>   File "use_must_check.cocci", line 7, column 1, charpos = 64
>   around = 'f',
>   whole content =  f(...);
>
>
> @is_void@
> identifier f;
> position p;
> @@
>  void f@p(...);
>
> @addition@
> identifier f;
> position p != is_void.p;
> type rt;
> @@
>  rt
> +__must_check
>  f@p(...);
>
>
> elfring@Sonne:~/Projekte/Coccinelle/janitor> spatch --parse-cocci use_must_check2.cocci
> init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
> plus: parse error:
>   File "use_must_check2.cocci", line 14, column 1, charpos = 137
>   around = 'f',
>   whole content =  f@p(...);
>
>
>
> Will the addition of such an annotation in a function declaration
> become supported for the semantic patch language?

Perhaps some day.

julia
--8323329-2031708665-1570481070=:2578
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-2031708665-1570481070=:2578--
