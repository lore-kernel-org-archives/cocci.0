Return-Path: <SRS0=WbyO=62=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FE3C54E8E
	for <cocci@archiver.kernel.org>; Tue, 12 May 2020 12:30:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 354B220675
	for <cocci@archiver.kernel.org>; Tue, 12 May 2020 12:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354B220675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04CCUJ6D021831;
	Tue, 12 May 2020 14:30:19 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 612A07559;
	Tue, 12 May 2020 14:30:19 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8A6D33E6B
 for <cocci@systeme.lip6.fr>; Tue, 12 May 2020 14:30:17 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04CCUHCE028304
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 12 May 2020 14:30:17 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,383,1583190000"; d="scan'208";a="449313073"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 May 2020 14:30:16 +0200
Date: Tue, 12 May 2020 14:30:16 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?Christoph_B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <fa30c7d6-5278-9575-517b-31658b1a37c3@linbit.com>
Message-ID: <alpine.DEB.2.21.2005121429211.3521@hadrien>
References: <fa30c7d6-5278-9575-517b-31658b1a37c3@linbit.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1528527509-1589286616=:3521"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 12 May 2020 14:30:20 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 12 May 2020 14:30:17 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Regression since recent parentypes patches were merged
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

--8323329-1528527509-1589286616=:3521
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 12 May 2020, Christoph Böhmwalder wrote:

> Hi Jaskaran,
> Hi all,
>
> I have noticed a regression in spatch since the recent SmPL improvements
> were merged. Here is a small reproducer:
>
> @@
> struct socket *sock;
> struct sockaddr *uaddr;
> int peer;
> @@
> {
> +int ___addr_len;
> ...
> - sock->ops->getname(sock, uaddr, peer);
> + sock->ops->getname(sock, uaddr, &___addr_len, peer);
> ...
> }
>
>
> This used to parse just fine, however now it errors out:
>
>
> $ spatch --parse-cocci compat.cocci
> init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
> minus: parse error:
>    File "compat.cocci", line 9, column 13, charpos = 98
>    around = 'getname',
>    whole content = - sock->ops->getname(sock, uaddr, peer);
>
>
> I have bisected the problem and it appears that the first bad commit is:
>
> commit c280375635f62dfbe052709e4e47a82140d32ce5
> Author: Jaskaran Singh <jaskaransingh7654321@gmail.com>
> Date:   Fri Mar 20 12:31:32 2020 +0530
>
>      Add parentypes to SmPL
>
>      This allows the SmPL and C ASTs to better match up, which enables
>      more transformations.  The patch is very large, so I have left
>      the different messages as they were proposed in the original
>      patch series.
>
> Which is unfortunately huge, and since it was squashed together I really
> can't be any more specific.

It's huge because any change to the AST affects everything...

>
> Anyways, is this a bug? Or was I doing something wrong in the first place?

It's surely a bug.  Thanks for the report.

julia

> Thanks and best regards,
> --
> Christoph Böhmwalder
> LINBIT | Keeping the Digital World Running
> DRBD HA —  Disaster Recovery — Software defined Storage
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
--8323329-1528527509-1589286616=:3521
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1528527509-1589286616=:3521--
