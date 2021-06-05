Return-Path: <SRS0=/Ux4=K7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92271C47082
	for <cocci@archiver.kernel.org>; Sat,  5 Jun 2021 19:51:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A862F611C0
	for <cocci@archiver.kernel.org>; Sat,  5 Jun 2021 19:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A862F611C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 155JprQ6000389;
	Sat, 5 Jun 2021 21:51:53 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 11BE17501;
	Sat,  5 Jun 2021 21:51:53 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 76AAB74E8
 for <cocci@systeme.lip6.fr>; Sat,  5 Jun 2021 21:51:51 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 155JpoJn002337
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 5 Jun 2021 21:51:50 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AllAKkKBkIACGBDvlHelN55DYdb4zR+YMi2QD?=
 =?us-ascii?q?/1lpUhpLfsHdvNDGppsmPZ6YskdgZJhAo6H6BEDkex7hHPFOkPQs1NuZLXfbUI?=
 =?us-ascii?q?XBFvAq0WPNqweQbhEXboVmpNFdm0IXMqyGMbECt7eP3ODaKadZ/DDkytHTuQ6E?=
 =?us-ascii?q?9QYecegCUcgJhWsWa3f5Yy8GITWuY6BJaKZ0jvAtm9OOQwVpUi3RPAh1YwGsna?=
 =?us-ascii?q?y5qHskW29gO/fk0njrsdpl0s+dL/FQ5GZmb9qR+9cfzVQ=3D?=
X-IronPort-AV: E=Sophos;i="5.83,251,1616454000"; d="scan'208";a="511914976"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Jun 2021 21:51:50 +0200
Date: Sat, 5 Jun 2021 21:51:50 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
In-Reply-To: <YLvDVI9TCEVoL16r@zx2c4.com>
Message-ID: <alpine.DEB.2.22.394.2106052149580.32368@hadrien>
References: <CAHmME9rRQmSLkU6ELNiC=pr-D7CGjdyw27_oXdBp+hMdn8WQ5Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2106051335410.25155@hadrien>
 <YLvDVI9TCEVoL16r@zx2c4.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 05 Jun 2021 21:51:53 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 05 Jun 2021 21:51:51 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] struct type renaming in the absence of certain function
 calls on members
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

Try making a file def.h:

#define CK_LIST_HEAD(x,y) int
#define CK_LIST_ENTRY(x) int

and then add to your command line

--macro-file def.h

There seem to be a few other such macros that are needed.

Unrelatedly, you can also add --very-quiet to the command line, to have a
less verbose output.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
