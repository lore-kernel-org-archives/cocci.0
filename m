Return-Path: <SRS0=oZAC=4P=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA437C4BA24
	for <cocci@archiver.kernel.org>; Thu, 27 Feb 2020 09:45:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6628524672
	for <cocci@archiver.kernel.org>; Thu, 27 Feb 2020 09:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6628524672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 01R9jW2o017628;
	Thu, 27 Feb 2020 10:45:32 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C6BBA77FC;
	Thu, 27 Feb 2020 10:45:32 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BC59077FA
 for <cocci@systeme.lip6.fr>; Thu, 27 Feb 2020 10:45:31 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 01R9jV8P028343
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 27 Feb 2020 10:45:31 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.70,491,1574118000"; d="scan'208";a="437860783"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Feb 2020 10:45:31 +0100
Date: Thu, 27 Feb 2020 10:45:31 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
In-Reply-To: <65ec26be-3b40-4248-4fc6-e30f6785f9b1@univ-grenoble-alpes.fr>
Message-ID: <alpine.DEB.2.21.2002271044550.4309@hadrien>
References: <786d2ea9-621f-bcc4-b626-aed6454784e2@yaerobi.com>
 <alpine.DEB.2.21.2002041556540.3345@hadrien>
 <909d202d-9a8a-d010-107b-80c07febcb0f@yaerobi.com>
 <65ec26be-3b40-4248-4fc6-e30f6785f9b1@univ-grenoble-alpes.fr>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1847078973-1582796731=:4309"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 27 Feb 2020 10:45:32 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 27 Feb 2020 10:45:31 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] coccinelle depends on unmaintained pygtk
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

--8323329-1847078973-1582796731=:4309
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Thu, 27 Feb 2020, Nicolas Palix wrote:

> Hi Emmanuel,
>
> Instead of porting to GObject directly,
> can we use PyGTKCompat ?
>
> https://wiki.gnome.org/Projects/PyGObject/PyGTKCompat

The problem is resolved by removing the python file that relied on the
unavailable library.  I don't think that that python file is useful.

julia

>
> Regards,
>
> Le 04/02/2020 à 16:25, eamanu a écrit :
> > Hi!
> >
> > On 04/02/2020 11:59, Julia Lawall wrote:
> > > On Tue, 4 Feb 2020, eamanu wrote:
> > >
> > > > Hi everybody,
> > > >
> > > > Sorry if this issues is duplicated, I am new in the mailing list
> > > > and in a very quickly searching I didn't found about this issue.
> > > >
> > > > I am working on Coccinelle package on Debian
> > > Thanks!
> > >
> > > > and currently
> > > > exist the next bug [1].
> > > >
> > > > There is any plan to port to use GObject Instrospection?
> > > >
> > > > [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=885267
> > > I think we should just drop the code that depends on it.  It was added for
> > > a MS thesis more than 10 years ago, and I don't think anyone has used it
> > > since.
> > >
> > > I will look into it.
> >
> > Great, if you need help, I can help :-)
> >
> > I will wait for any news. Thanks
> >
> > eamanu
> > >
> > > julia
> >
> > _______________________________________________
> > Cocci mailing list
> > Cocci@systeme.lip6.fr
> > https://systeme.lip6.fr/mailman/listinfo/cocci
> >
>
>
> --
> Nicolas Palix
> http://lig-membres.imag.fr/palix/
>
--8323329-1847078973-1582796731=:4309
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1847078973-1582796731=:4309--
