Return-Path: <SRS0=Nj+g=JC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73746C433B4
	for <cocci@archiver.kernel.org>; Mon,  5 Apr 2021 21:58:21 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5824F613C0
	for <cocci@archiver.kernel.org>; Mon,  5 Apr 2021 21:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5824F613C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 135LwHa1026653;
	Mon, 5 Apr 2021 23:58:17 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1BDAE3CA1;
	Mon,  5 Apr 2021 23:58:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1566D3B62
 for <cocci@systeme.lip6.fr>; Mon,  5 Apr 2021 23:58:16 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 135LwFSY019303
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 5 Apr 2021 23:58:15 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ADLs5e6vMU/KaGEAjO7aYAZQh7skDl9V00zAX?=
 =?us-ascii?q?/kB9WHVpW+afkN2jm+le6A/shF8qKRUdsP2JJaXoexjh3LFv5415B92fdSng/F?=
 =?us-ascii?q?ClNYRzqbblqgeAJwTb1spwkZhtaLJ/DtqYNykese/f7BOjG9gthPmrmZrJuc7k?=
 =?us-ascii?q?w31gTR5nZshbhm9EIz2WHUFsSA5NCYBRLuv+2uN8uzGidX4LB/7UOlA5WYH4y+?=
 =?us-ascii?q?HjqIjrelovCRIh9WC1/FGVwY+/Ilyj0hASXygn+9of2GLO+jaX2pme?=
X-IronPort-AV: E=Sophos;i="5.81,307,1610406000"; d="scan'208";a="501634119"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Apr 2021 23:58:15 +0200
Date: Mon, 5 Apr 2021 23:58:15 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Michael Walle <michael@walle.cc>
In-Reply-To: <80c602de0af4fd3c578714dc837bb6fe@walle.cc>
Message-ID: <alpine.DEB.2.22.394.2104052356580.2981@hadrien>
References: <acfc6d2f0a7ea90f451de6d1185a0383@walle.cc>
 <CALogXGVkTv8eDpNxDnh38qPk0jwMHNpE0HShb4tmGZS3CSF-gQ@mail.gmail.com>
 <80c602de0af4fd3c578714dc837bb6fe@walle.cc>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 05 Apr 2021 23:58:17 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 05 Apr 2021 23:58:15 +0200 (CEST)
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



On Mon, 5 Apr 2021, Michael Walle wrote:

> Hi Mansour,
>
> Am 2021-04-04 19:48, schrieb Mansour Moufid:
> > On Thu, Apr 1, 2021 at 4:13 AM Michael Walle <michael@walle.cc> wrote:
> > >
> > > Hi,
> > >
> > > so first I need to say I've never used coccinelle before,
> > > so please bear with me ;)
> > >
> > > To make of_get_mac_address() work with DSA ports (and a nvmem
> > > provider) I'd need to change the semantics of of_get_mac_address().
> > > Right now it returns a pointer to "const char *", I'd need to change
> > > that so a buffer will be passed as a parameter in which the MAC
> > > address gets stored.
> > >
> > > (1) Usually the call is something like:
> > >
> > >    const char *mac;
> > >    mac = of_get_mac_address(np);
> > >    if (!IS_ERR(mac))
> > >      ether_addr_copy(ndev->dev_addr, mac);
> > >
> > > This would need to be changed to:
> > >
> > >    of_get_mac_address(np, ndev->dev_addr);
> >
> > Here is one possible approach, doing the API change first then
> > handling the conditionals. It seems to work.
> >
> > @a@
> > identifier x;
> > expression y, z;
> > @@
> > -   x = of_get_mac_address(y);
> > +   x = of_get_mac_address(y, z);
> >     <...
> > -   ether_addr_copy(z, x);
> >     ...>
> >
> > @@
> > identifier a.x;
> > @@
> > -   if (<+... x ...+>) {}
> >
> > @@
> > identifier a.x;
> > @@
> >     if (<+... x ...+>) {
> >         ...
> >     }
> > -   else {}
> >
> > @@
> > identifier a.x;
> > expression e;
> > @@
> > -   if (<+... x ...+>@e)
> > -       {}
> > -   else
> > +   if (!(e))

Maybe try the above line without the parentheses around e?


> >         {...}
> >
> > @@
> > expression x, y, z;
> > @@
> > -   x = of_get_mac_address(y, z);
> > +   of_get_mac_address(y, z);
> >     ... when != x
>
> Thanks a lot!
>
> See also
> https://lore.kernel.org/netdev/20210405164643.21130-1-michael@walle.cc/
>
> There were some "if (!(!IS_ERR(x))", which I needed to simplify
> manually. Didn't noticed that in my previous script. I'm just
> curious, is that also something coccinelle can simplify on its
> own?

You can certainly write another rule for it:

- !(!e)
+ e

julia


>
> -michael
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
