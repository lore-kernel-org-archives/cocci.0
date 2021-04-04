Return-Path: <SRS0=NM3K=JB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C32C433B4
	for <cocci@archiver.kernel.org>; Sun,  4 Apr 2021 18:34:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B7866135D
	for <cocci@archiver.kernel.org>; Sun,  4 Apr 2021 18:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7866135D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 134IYiSw004153;
	Sun, 4 Apr 2021 20:34:44 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4E00A77D0;
	Sun,  4 Apr 2021 20:34:44 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A619074DE
 for <cocci@systeme.lip6.fr>; Sun,  4 Apr 2021 20:34:42 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 134IYf3P007026
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 4 Apr 2021 20:34:41 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A3TuekKirrpUtwaY5fKErYBLa+3BQXjsji2hD?=
 =?us-ascii?q?6mlwRA09T+WzkceykPMHkSLlkTp5YgBFpfmsMLSNKEm2ybdb+o8UVI3JYCDHvy?=
 =?us-ascii?q?+SIJhm/c/exVTbehHW0s54+eNef7NlCNv2ZGIK6PrSxAWjCd4vzJ2m3cmT5dv2?=
 =?us-ascii?q?9HtmQQF0Z6wI1W4QNi+hHkJ7XwVAD5YifaDshfZvnSaqengcc62AaEUtYu6rnb?=
 =?us-ascii?q?H2va79bQVDLxAq7xTmt0LL1JfKVynd5BsYXj9VqI1OzUHOmWXCiZmejw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.81,304,1610406000"; d="scan'208";a="377732556"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Apr 2021 20:34:40 +0200
Date: Sun, 4 Apr 2021 20:34:40 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Mansour Moufid <mansourmoufid@gmail.com>
In-Reply-To: <CALogXGVkTv8eDpNxDnh38qPk0jwMHNpE0HShb4tmGZS3CSF-gQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2104042033070.2958@hadrien>
References: <acfc6d2f0a7ea90f451de6d1185a0383@walle.cc>
 <CALogXGVkTv8eDpNxDnh38qPk0jwMHNpE0HShb4tmGZS3CSF-gQ@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 04 Apr 2021 20:34:45 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 04 Apr 2021 20:34:41 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] changing of_get_mac_address() to pass a buffer
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



On Sun, 4 Apr 2021, Mansour Moufid wrote:

> On Thu, Apr 1, 2021 at 4:13 AM Michael Walle <michael@walle.cc> wrote:
> >
> > Hi,
> >
> > so first I need to say I've never used coccinelle before,
> > so please bear with me ;)
> >
> > To make of_get_mac_address() work with DSA ports (and a nvmem
> > provider) I'd need to change the semantics of of_get_mac_address().
> > Right now it returns a pointer to "const char *", I'd need to change
> > that so a buffer will be passed as a parameter in which the MAC
> > address gets stored.
> >
> > (1) Usually the call is something like:
> >
> >    const char *mac;
> >    mac = of_get_mac_address(np);
> >    if (!IS_ERR(mac))
> >      ether_addr_copy(ndev->dev_addr, mac);
> >
> > This would need to be changed to:
> >
> >    of_get_mac_address(np, ndev->dev_addr);
>
> Here is one possible approach, doing the API change first then
> handling the conditionals. It seems to work.
>
> @a@
> identifier x;
> expression y, z;
> @@
> -   x = of_get_mac_address(y);
> +   x = of_get_mac_address(y, z);
>     <...
> -   ether_addr_copy(z, x);
>     ...>
>
> @@
> identifier a.x;
> @@
> -   if (<+... x ...+>) {}
>
> @@
> identifier a.x;
> @@
>     if (<+... x ...+>) {
>         ...
>     }
> -   else {}
>
> @@
> identifier a.x;
> expression e;
> @@
> -   if (<+... x ...+>@e)
> -       {}
> -   else
> +   if (!(e))
>         {...}
>
> @@
> expression x, y, z;
> @@
> -   x = of_get_mac_address(y, z);
> +   of_get_mac_address(y, z);
>     ... when != x

This seems like a good approach.  It would also be possible to have
special cases for when the removed call is in a {} by itself, but it seems
like a lot of trouble for little benefit.  Presumably the existing code
doesn't contain {}, so the only code that would be affected by the cleanup
rules would be the code that was introduced by the first rule.  Thanks for
th suggestion.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
