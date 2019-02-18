Return-Path: <SRS0=dehY=QZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83781C43381
	for <cocci@archiver.kernel.org>; Mon, 18 Feb 2019 06:43:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D61632147C
	for <cocci@archiver.kernel.org>; Mon, 18 Feb 2019 06:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61632147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1I6hXBi022333
          ; Mon, 18 Feb 2019 07:43:33 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2929E764A;
	Mon, 18 Feb 2019 07:43:33 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F381F75FF
 for <cocci@systeme.lip6.fr>; Mon, 18 Feb 2019 07:43:30 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1I6hRw9015927
 for <cocci@systeme.lip6.fr>; Mon, 18 Feb 2019 07:43:27 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.58,383,1544482800"; d="scan'208";a="296474504"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2019 07:43:26 +0100
Date: Mon, 18 Feb 2019 07:43:26 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: wen.yang99@zte.com.cn
In-Reply-To: <201902181122502228026@zte.com.cn>
Message-ID: <alpine.DEB.2.21.1902180740550.3111@hadrien>
References: HK0PR02MB36344E2B29CEB195892F6420B2610@HK0PR02MB3634.apcprd02.prod.outlook.com,
 52c07e7c-eec7-792b-0b03-b5cb46ddeab3@web.de <201902181122502228026@zte.com.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2117660207-1550472207=:3111"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 18 Feb 2019 07:43:34 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Mon, 18 Feb 2019 07:43:27 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: kernel-janitors@vger.kernel.org, michal.lkml@markovi.net,
        yellowriver2010@hotmail.com, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, Markus.Elfring@web.de,
        cheng.shengyu@zte.com.cn, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [v6] coccinelle: semantic code search for missing
	put_device()
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

--8323329-2117660207-1550472207=:3111
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 18 Feb 2019, wen.yang99@zte.com.cn wrote:

> > > when != e = id achieves this behavior.
> >
> > I can not agree to this view completely because of the meaning that is connected
> > with these variable identifiers.
> >
> > Both metavariables share the kind “expression”. So I can imagine
> > that there is an intersection for the source code match possibility.
> > But one was intentionally restricted to the kind “local idexpression” so far.
> >
> > Which data element should not get reassigned here (before a corresponding
> > null pointer check)?
> >
>
> Thank you for your comments.
> We did some experiments:
> +id = of_find_device_by_node@p1(x)
> +... when != e = id
> ...
> Or:
> ...
> + ... when != id = e
>
> The number of issuses found by these two methods is the same.
> When != e = id achieves this behavior.

They are the same because neither issue arises.  I would have a hard time
saying which one is more reasonable to test, since both are extremely
unlikely.

julia


>
> In addition, we feel that we should probably accept this patch first, use it to find more memory leaks, and solve the actual problems in the kernel code.
> As for the patch itself, we can continue to pursue perfect in the process of using it to solve practical problems.
>
> Regards,
> Wen
--8323329-2117660207-1550472207=:3111
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-2117660207-1550472207=:3111--
