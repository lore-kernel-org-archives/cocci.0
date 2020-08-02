Return-Path: <SRS0=zfpL=BM=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3EBC433DF
	for <cocci@archiver.kernel.org>; Sun,  2 Aug 2020 14:34:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C6EB20759
	for <cocci@archiver.kernel.org>; Sun,  2 Aug 2020 14:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C6EB20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 072EYW1O021446;
	Sun, 2 Aug 2020 16:34:32 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B5FFD76BF;
	Sun,  2 Aug 2020 16:34:32 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6F58B4084
 for <cocci@systeme.lip6.fr>; Sun,  2 Aug 2020 16:34:30 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 072EYTLw013627
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 2 Aug 2020 16:34:29 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.75,426,1589234400"; d="scan'208";a="462185994"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Aug 2020 16:34:29 +0200
Date: Sun, 2 Aug 2020 16:34:28 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <065fee88-5206-5d9b-c83c-4e6a20aefd85@web.de>
Message-ID: <alpine.DEB.2.22.394.2008021632210.2531@hadrien>
References: <e4f3c4e8-03e8-dbc2-5871-0d111b3086a4@web.de>
 <alpine.DEB.2.22.394.2008020904310.2531@hadrien>
 <eead5e2a-da8d-83cd-eeb4-f193702b800f@web.de>
 <alpine.DEB.2.22.394.2008021348430.2531@hadrien>
 <82af6b44-ea09-b86f-81f7-e96e8594a31d@web.de>
 <alpine.DEB.2.22.394.2008021513010.2531@hadrien>
 <065fee88-5206-5d9b-c83c-4e6a20aefd85@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1188531943-1596378869=:2531"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 02 Aug 2020 16:34:33 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 02 Aug 2020 16:34:29 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] [00/43] cocci: Add support for meta attributes to SmPL
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

--8323329-1188531943-1596378869=:2531
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 2 Aug 2020, Markus Elfring wrote:

> >> Will the Coccinelle software itself present a warning like “metavariable __attr__
> >> not used in the - or context code”?
> >
> > No.  It's not a metavariable.
>
> How do you call the following items in the update step “[PATCH 42/43] tests:
> Add test case to match meta attribute”?
> https://lore.kernel.org/cocci/25fb4894-65d3-dc57-dbfd-93d3482d8fee@web.de/
> https://systeme.lip6.fr/pipermail/cocci/2020-July/008036.html
>
> attribute name __attr__;
> attribute a;

attribute a; declares a metavariable that matches attributes.

attribute name __attr__; declares that __attr__ is the name of an
attribute.

These "name" declarations can be used in the parsing of the C code as a
hint that __attr__ should be parsed in a special way.

julia
--8323329-1188531943-1596378869=:2531
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1188531943-1596378869=:2531--
