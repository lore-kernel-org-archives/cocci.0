Return-Path: <SRS0=lRSE=SP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CADBC10F11
	for <cocci@archiver.kernel.org>; Sat, 13 Apr 2019 16:03:48 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCD882084D
	for <cocci@archiver.kernel.org>; Sat, 13 Apr 2019 16:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD882084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3DG3ZE9004933
          ; Sat, 13 Apr 2019 18:03:35 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 480FE7727;
	Sat, 13 Apr 2019 18:03:35 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6CC0F7725
 for <cocci@systeme.lip6.fr>; Sat, 13 Apr 2019 18:03:33 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3DG3W5q021223
 for <cocci@systeme.lip6.fr>; Sat, 13 Apr 2019 18:03:32 +0200 (CEST)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.60,345,1549926000"; d="scan'208";a="302788132"
Received: from abo-75-106-68.mrs.modulonet.fr (HELO hadrien) ([85.68.106.75])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Apr 2019 18:03:32 +0200
Date: Sat, 13 Apr 2019 18:03:32 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <566b0019-021a-0415-4b98-b5d8c74beb83@web.de>
Message-ID: <alpine.DEB.2.21.1904131802270.2536@hadrien>
References: <ce2b0c4c-bc85-0341-ca0a-9b158804943a@web.de>
 <alpine.DEB.2.20.1904111728380.3143@hadrien>
 <88620f8c-3762-ac4e-5e0f-6115a21635fc@web.de>
 <alpine.DEB.2.21.1904131737540.2536@hadrien>
 <ada8fea1-1b56-1c58-5a78-8fc95006d203@web.de>
 <alpine.DEB.2.21.1904131743330.2536@hadrien>
 <566b0019-021a-0415-4b98-b5d8c74beb83@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1880859259-1555171412=:2536"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 13 Apr 2019 18:03:35 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sat, 13 Apr 2019 18:03:32 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking influence of loops?
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

--8323329-1880859259-1555171412=:2536
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sat, 13 Apr 2019, Markus Elfring wrote:

> >>>>> Your ifs may be in a loop.
> >>>>
> >>>> Does your technology treat this control flow in special ways?
> >>>
> >>> No.
> >>
> >> Would the quoted information be irrelevant then for the discussed use case?
> >
> > No idea what the above means.
>
> It seems that there is another communication difficulty involved.
>
> Your feedback indicated concerns for the handling of loops
> in the shown source code search results, didn't it?
>
>
> > There are control flow paths that cause ... to connect things.
>
> I guess that these “connections” need further clarifications.
>
>
> > The process of matching doesn't know if the connection is due to a loop,
> > and if, a goto, or anything else.
>
> Should two search specifications (with SmPL ellipses) between them
> be kept separate for the desired diff output?

I don't understand any of your answers precisely.

If you have a pattern like

AAA
...
BBB

The AAA and BBB might match the same code if there is a possible flow of
execution from the match of AAA to itself.

julia
--8323329-1880859259-1555171412=:2536
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1880859259-1555171412=:2536--
