Return-Path: <SRS0=7Hyx=TN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9900C04AA7
	for <cocci@archiver.kernel.org>; Mon, 13 May 2019 11:37:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E11D20879
	for <cocci@archiver.kernel.org>; Mon, 13 May 2019 11:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E11D20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x4DBawcb025059
          ; Mon, 13 May 2019 13:36:58 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CAAF97751;
	Mon, 13 May 2019 13:36:58 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1EFA8773E
 for <cocci@systeme.lip6.fr>; Mon, 13 May 2019 13:36:58 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x4DBaumh013916
 for <cocci@systeme.lip6.fr>; Mon, 13 May 2019 13:36:56 +0200 (CEST)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.60,465,1549926000"; d="scan'208";a="382892366"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 May 2019 13:36:56 +0200
Date: Mon, 13 May 2019 13:36:52 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <97f32bc1-f7ff-5777-21b5-5c4f85bb7276@web.de>
Message-ID: <alpine.DEB.2.20.1905131333560.1009@hadrien>
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
 <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de>
 <308f5571-68f3-7505-d5ad-59ee68091959@web.de>
 <alpine.DEB.2.20.1905131133570.3616@hadrien>
 <97f32bc1-f7ff-5777-21b5-5c4f85bb7276@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 13 May 2019 13:36:59 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Mon, 13 May 2019 13:36:56 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Wen Yang <wen.yang99@zte.com.cn>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [1/5] Coccinelle: put_device: Adjust a message
	construction
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



On Mon, 13 May 2019, Markus Elfring wrote:

> >> Thus simplify a message construction in a SmPL rule by concatenating text
> >> with two plus operators less.
> >
> > Is there any way to unindent, so that the string doesn't exceed 80 characters,
> > or at least no so much?
>
> How does your concern fit to the string literal tolerance from
> the Linux coding style?

The point of view of the Linux kernel is that if there is no nicer way to
persent the string, exceeding 80 characters is preferable to breaking the
string.  But here, at least if Python was not indentation sensitive, there
are much nicer ways to present the string and not exceed 80 characters.

> > On the other hand, I would have much preferred the original msg = code.
> > I don't understand why it is so offensive.
>
> I suggested again to avoid the use of extra variables in such cases
> (also in the discussed bit of Python source code within a SmPL script).

I realize that you don't like it, although I have no idea why.  Does it
make the code slower? Less reliable? Less readable?  I doubt any of those
things.  I think that staying within 80 characters would be a much greater
benefit that all of these baseless concerns.

julia

>
> Regards,
> Markus
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
