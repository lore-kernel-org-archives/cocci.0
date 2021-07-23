Return-Path: <SRS0=70je=MP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4230FC4338F
	for <cocci@archiver.kernel.org>; Fri, 23 Jul 2021 19:35:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C6C160F21
	for <cocci@archiver.kernel.org>; Fri, 23 Jul 2021 19:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5C6C160F21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 16NJZFdP003164;
	Fri, 23 Jul 2021 21:35:16 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DF5117783;
	Fri, 23 Jul 2021 21:35:15 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3FE633783
 for <cocci@systeme.lip6.fr>; Fri, 23 Jul 2021 21:35:14 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 16NJZDcU028460
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 23 Jul 2021 21:35:13 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AiWkPO69LuKcTORzibhduk+DbI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFPBw8vrFoB11726XtN98YgBCpTniAsi9qBHnhPtICOAqVN/IYOCBgg?=
 =?us-ascii?q?uVxepZnO/fKlPbakrDHy1muZuIsZISNDQ9NzdHZA/BjjWFLw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,264,1620684000"; d="scan'208";a="521330012"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Jul 2021 21:35:13 +0200
Date: Fri, 23 Jul 2021 21:35:13 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: =?UTF-8?Q?Andrew_=F0=9F=91=BD__Yourtchenko?= <ayourtch@gmail.com>
In-Reply-To: <CAPi140Ns4Qo1V=MqSUS46oJvO_0jgG5rPFuu0EvNrYw_3LoN0g@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2107232131030.2938@hadrien>
References: <CAPi140Mgk8zEk9vStbBU4Hh6oEMU2i6Kaji502AojELjFCR1OA@mail.gmail.com>
 <alpine.DEB.2.22.394.2107222203110.42931@hadrien>
 <CAPi140Ns4Qo1V=MqSUS46oJvO_0jgG5rPFuu0EvNrYw_3LoN0g@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 23 Jul 2021 21:35:19 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 23 Jul 2021 21:35:13 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] how to make substitutions at the end of the function,
 vs. the end of each block ?
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

> I missed the fact that the "return ERR" were actually not replaced on
> this example at all,

This is because there are no occurrences of return ERR; in your code.
Probably you expected ERR to be a metavariable, but it's not.  Actually,
fully capitalizing your metavariables is not a good idea.  Coccinelle
expects that fully capitalized things are constants, as in #define ERR -1,
and so when they appear at random places, it doesn't comment about that.
If it had been in lowercase and used as the argument of a return (or as a
function argument, right-hand side of an assignment, etc), Coccinelle
would have printed a warning wondering if you expected it to be a
metavariable.

If ERR is declared as an expression metavariable, then lots of returns are
replaced.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
