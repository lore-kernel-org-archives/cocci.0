Return-Path: <SRS0=pejK=5M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AE6C43331
	for <cocci@archiver.kernel.org>; Fri, 27 Mar 2020 15:47:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D4A220748
	for <cocci@archiver.kernel.org>; Fri, 27 Mar 2020 15:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D4A220748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02RFlXXk022809;
	Fri, 27 Mar 2020 16:47:33 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 935FC7812;
	Fri, 27 Mar 2020 16:47:33 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BDAAC780C
 for <cocci@systeme.lip6.fr>; Fri, 27 Mar 2020 16:47:32 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02RFlWuT020978
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 27 Mar 2020 16:47:32 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.72,313,1580770800"; d="scan'208";a="344058277"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Mar 2020 16:47:31 +0100
Date: Fri, 27 Mar 2020 16:47:31 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?Christoph_B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <b86347f3-69d3-0801-c91f-87c3424e71dc@linbit.com>
Message-ID: <alpine.DEB.2.21.2003271645370.2709@hadrien>
References: <b86347f3-69d3-0801-c91f-87c3424e71dc@linbit.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-847250489-1585324051=:2709"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 27 Mar 2020 16:47:33 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 27 Mar 2020 16:47:32 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Matching against a declarer macro
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

--8323329-847250489-1585324051=:2709
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 27 Mar 2020, Christoph Böhmwalder wrote:

> Hi again,
>
> I'm having a little trouble matching against this line of code:
>
> RB_DECLARE_CALLBACKS_MAX(static, augment_callbacks, struct
> drbd_interval, rb, sector_t, end, NODE_END);
>
> This is especially tricky because it contains a lot of macro magic.
> I think the biggest problem is the first argument, which is the keyword
> "static". What do I use to match against this? expression? identifier?
> symbol?
>
> Also, the "augment_callbacks" is not really an identifier either, it
> just gets used to generate the function names. But what is it? An
> expression?
>
> @@
> typedef sector_t;
> declarer name RB_DECLARE_CALLBACKS_MAX;
>
> identifier augment_callbacks;
> identifier rb;
> identifier end;
> identifier NODE_END;
> @@
> -RB_DECLARE_CALLBACKS_MAX(static, augment_callbacks, struct
> drbd_interval, rb, sector_t, end, NODE_END);
>
> Nothing I have tried has made it match yet.
>
> Any ideas on how to solve this would be appreciated, thanks!

Are you sure that the C code is parsed successfully?  I'm not at all sure
that static is allowed in an argument list.  Types are allowed, bu static
is only part of a type.

For augment_callbacks, either identifier or expression would be fine.
Coccinelle has no idea what is going to happen to augment_callbacks
afterwards.  It just sees a sequence of characters and classifies it as an
identifier.

julia

>
> --
> Christoph Böhmwalder
> LINBIT | Keeping the Digital World Running
> DRBD HA —  Disaster Recovery — Software defined Storage
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
--8323329-847250489-1585324051=:2709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-847250489-1585324051=:2709--
