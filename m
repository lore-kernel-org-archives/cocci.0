Return-Path: <SRS0=P13C=WD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAA7C32751
	for <cocci@archiver.kernel.org>; Wed,  7 Aug 2019 21:40:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE6C1217F5
	for <cocci@archiver.kernel.org>; Wed,  7 Aug 2019 21:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6C1217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x77LeDmg017680;
	Wed, 7 Aug 2019 23:40:13 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 00D4D7787;
	Wed,  7 Aug 2019 23:40:13 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4EE7576B2
 for <cocci@systeme.lip6.fr>; Wed,  7 Aug 2019 23:40:11 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x77LeA0k018499
 for <cocci@systeme.lip6.fr>; Wed, 7 Aug 2019 23:40:11 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.64,358,1559512800"; d="scan'208";a="315874224"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 23:40:05 +0200
Date: Wed, 7 Aug 2019 23:40:04 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?Christoph_B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <656aeb1b-9c94-a428-bb0e-4397a0432651@linbit.com>
Message-ID: <alpine.DEB.2.21.1908072337230.2601@hadrien>
References: <b4c91fb8-5606-c06e-e349-5415458cf3b5@linbit.com>
 <alpine.DEB.2.21.1908030841460.2547@hadrien>
 <656aeb1b-9c94-a428-bb0e-4397a0432651@linbit.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 07 Aug 2019 23:40:13 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Wed, 07 Aug 2019 23:40:11 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Make rule depend on comment
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

If you pull Coccinelle from github, you will be able to write the
following.  The code on line 2 probably has to be an ocaml script at the
moment, because I didn't do anything to support python.  You can use the
code that is shown in the example directly.  It checks that the list of
comments between the ) and the { is not empty.  The second scriptcan use
ocaml or python as you like.

@ find_kmap_tagged_function @
comments tag : script:ocaml () { let (c1b,c1m,c1a) = List.hd tag in not
(c1a = []) };
identifier fn;
@@
fn(...)@tag {
...
}

@ script:ocaml parse_kmap_tag @
fn << find_kmap_tagged_function.fn;
@@
Printf.printf "have comment in %s\n" fn

--------

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
