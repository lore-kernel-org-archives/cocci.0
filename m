Return-Path: <SRS0=Pg7l=R7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D79C4360F
	for <cocci@archiver.kernel.org>; Thu, 28 Mar 2019 14:20:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8873E2075E
	for <cocci@archiver.kernel.org>; Thu, 28 Mar 2019 14:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8873E2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2SEK1Sl028102
          ; Thu, 28 Mar 2019 15:20:01 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 20E06771A;
	Thu, 28 Mar 2019 15:20:01 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0C0B87719
 for <cocci@systeme.lip6.fr>; Thu, 28 Mar 2019 15:19:59 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2SEJvgs003525
 for <cocci@systeme.lip6.fr>; Thu, 28 Mar 2019 15:19:57 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.60,280,1549926000"; d="scan'208";a="376181427"
Received: from unknown (HELO hadrien) ([195.167.213.123])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Mar 2019 15:19:56 +0100
Date: Thu, 28 Mar 2019 15:19:56 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Masahiro Yamada <yamada.masahiro@socionext.com>
In-Reply-To: <CAK7LNAT9gKvEX9520Sd50vrS7Gug1JQCMx_TJO_KPQjhjPORXw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1903281519470.2438@hadrien>
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
 <179bbdd1-3fcb-bba5-52b3-7f96973c7650@web.de>
 <alpine.DEB.2.21.1903232104030.5660@hadrien> <20190326084512.GC32590@kadam>
 <alpine.DEB.2.20.1903261037320.5021@hadrien> <20190326101103.GH32613@kadam>
 <alpine.DEB.2.20.1903261115300.5021@hadrien>
 <CAK7LNAT9gKvEX9520Sd50vrS7Gug1JQCMx_TJO_KPQjhjPORXw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-504337998-1553782797=:2438"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 28 Mar 2019 15:20:01 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Thu, 28 Mar 2019 15:19:57 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Michal Marek <michal.lkml@markovi.net>,
        kernel-janitors@vger.kernel.org, Nicolas Palix <nicolas.palix@imag.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cocci@systeme.lip6.fr, Markus Elfring <Markus.Elfring@web.de>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [Cocci] [PATCH] coccinelle: put_device: reduce false positives
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

--8323329-504337998-1553782797=:2438
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 28 Mar 2019, Masahiro Yamada wrote:

> On Tue, Mar 26, 2019 at 7:16 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
> >
> >
> >
> > On Tue, 26 Mar 2019, Dan Carpenter wrote:
> >
> > > On Tue, Mar 26, 2019 at 10:38:43AM +0100, Julia Lawall wrote:
> > > >
> > > >
> > > > On Tue, 26 Mar 2019, Dan Carpenter wrote:
> > > >
> > > > > On Sat, Mar 23, 2019 at 09:06:54PM +0100, Julia Lawall wrote:
> > > > > >
> > > > > >
> > > > > > On Sat, 23 Mar 2019, Markus Elfring wrote:
> > > > > >
> > > > > > > > Don't complain about a return when this function returns "&pdev->dev".
> > > > > > >
> > > > > > > Would this information qualify to add the tag “Fixes” to the commit message?
> > > > > >
> > > > > > Fixes tags relate to stable kernels, so that one can see which stable
> > > > > > kernels a particular patch should be propagated to.  There is no need to
> > > > > > propagate patches on semantic patches to stable kernels.  People who run
> > > > > > stable kernels are interested in their behavior, not the bug finding
> > > > > > rules that they contain.
> > > > >
> > > > > The Fixes tag is not just about stable...  For example, we use them for
> > > > > statistics to see how quickly bugs get fixed etc.
> > > >
> > > > OK.  But still do we need fixes tags for bug finding rules?  Perhaps if
> > > > the previous version was really broken, and it would be really undesirable
> > > > to use it.
> > >
> > > It's not worth resending a patch for that, but I probably would use the
> > > fixes tag.  It depends on your definition of "bug" really...  I tell
> > > people not to use Fixes for spelling mistakes and unused variables.  But
> > > I do use the Fixes tag for things like "an off by one in a sanity check
> > > which doesn't affect run time because the index is always correct".
> >
> > OK, thanks.
> >
> > julia
>
> I added Fixes: tag,
> and applied to linux-kbuild/fixes.

Thanks!

julia

>
> Thanks.
>
> --
> Best Regards
> Masahiro Yamada
>
--8323329-504337998-1553782797=:2438
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-504337998-1553782797=:2438--
