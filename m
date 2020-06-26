Return-Path: <SRS0=6oUL=AH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9736C433DF
	for <cocci@archiver.kernel.org>; Fri, 26 Jun 2020 18:50:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F7CA206E9
	for <cocci@archiver.kernel.org>; Fri, 26 Jun 2020 18:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7CA206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05QInrin011895;
	Fri, 26 Jun 2020 20:49:53 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4406B7773;
	Fri, 26 Jun 2020 20:49:53 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 19A003D0F
 for <cocci@systeme.lip6.fr>; Fri, 26 Jun 2020 20:49:52 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05QInpPc022097
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 26 Jun 2020 20:49:51 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.75,284,1589234400"; d="scan'208";a="456949790"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 20:49:51 +0200
Date: Fri, 26 Jun 2020 20:49:51 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <840038ec-2fbf-131f-b87f-58e7f835b65b@web.de>
Message-ID: <alpine.DEB.2.22.394.2006262049210.10382@hadrien>
References: <9725bf1f-06ea-63f3-2322-ffcce21cb218@web.de>
 <alpine.DEB.2.22.394.2006262019430.10382@hadrien>
 <c5ef6ff2-2ea5-ba9c-82be-305ecc9ab877@web.de>
 <alpine.DEB.2.22.394.2006262034080.10382@hadrien>
 <bc30f73a-c346-2592-bd74-8ac73ad6907f@web.de>
 <alpine.DEB.2.22.394.2006262042310.10382@hadrien>
 <840038ec-2fbf-131f-b87f-58e7f835b65b@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 26 Jun 2020 20:49:53 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 26 Jun 2020 20:49:51 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking the parsing for a nested SmPL disjunction
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



On Fri, 26 Jun 2020, Markus Elfring wrote:

> >>>> I assumed that I may omit the semicolon in such a SmPL code.
> >>>> Can the specification of a SmPL nest construct ever be sufficient here?
> >>>
> >>> No.  <+... ...+> matches a subtree of an AST.  For a variable
> >>> initialization, there is no subtree of the AST that includes both the
> >>> right side of an = and the ;.
> >>
> >> Can the abstract syntax tree be adjusted accordingly?
> >
> > No.
>
> Can such a rejection mean that software development efforts look undesirable
> (while adjustments for the data model would eventually be possible)?

No, it means that it makes no sense and it is not going to happen.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
