Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAFDC7EE2D
	for <cocci@archiver.kernel.org>; Sun, 26 Feb 2023 20:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=GxO2uYWlsxAHA3bGuVbRNRMMLQdwnwKGZfXabY8QhIY=;
  b=G0Zm7qO2ucnRR9hOKbx/5q6ArGjtjTP2kdNbOz4Z5PZmqvZjAM8UptHF
   oW3H20pe23UCUnux9n5hDQdKt0/u3YtS5gk/+DgeMWQdDiPfGOL9Adrel
   NZbQSRLOBxEdXzS1OFIZHCLcoUatJjbq77rYNW6u9Ftknx/fhsdsF/bd6
   g=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.97,330,1669071600"; 
   d="scan'208";a="94405373"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Feb 2023 21:33:41 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 22E95E0128; Sun, 26 Feb 2023 21:33:41 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 98BCFE00A1
	for <cocci@sympa.inria.fr>; Sun, 26 Feb 2023 21:33:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GxO2uYWlsxAHA3bGuVbRNRMMLQdwnwKGZfXabY8QhIY=;
  b=ZnJmDUlwY1uAsx3eps5CukAYOqu+Ac9GIL0vmKQuL27+YOVEdnYDGD+y
   Ko2q8O7KF/zWHtOlzj76MrtlZ09jMkMn+3Irg1sPgMRJF478QaYuIdTqn
   rJFIYtHaWtMnJe+n0llLg3lre6o0U1cG9dznGGhtlRniQRJLQzkfed/iH
   8=;
X-IronPort-AV: E=Sophos;i="5.97,330,1669071600"; 
   d="scan'208";a="48664654"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 21:33:35 +0100
Date: Sun, 26 Feb 2023 21:33:34 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Deepak R Varma <drv@mailo.com>
cc: nicolas palix <nicolas.palix@imag.fr>, cocci <cocci@inria.fr>, 
    linux-kernel <linux-kernel@vger.kernel.org>, 
    Saurabh Singh Sengar <ssengar@microsoft.com>, 
    Praveen Kumar <kumarpraveen@linux.microsoft.com>
In-Reply-To: <Y/u/mV6GUC5+l3m6@ubun2204.myguest.virtualbox.org>
Message-ID: <alpine.DEB.2.22.394.2302262130430.2761@hadrien>
References: <Y+/DQ6l0pDcxC2c3@ubun2204.myguest.virtualbox.org> <597798313.18813704.1677352621708.JavaMail.zimbra@inria.fr> <Y/u/mV6GUC5+l3m6@ubun2204.myguest.virtualbox.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH] coccinelle: put_device: Include of_node_put to
 avoid false positives
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 865
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-02/alpine.DEB.2.22.394.2302262130430.2761%40hadrien>



On Mon, 27 Feb 2023, Deepak R Varma wrote:

> On Sat, Feb 25, 2023 at 08:17:01PM +0100, Julia Lawall wrote:
> > > The node reference increased by of_find_device_by_node() can also be
> > > released by using a call to of_node_put(). Hence when this exists, the
> > > script should not trigger a warning, which otherwise will be a false
> > > positive.
> >
> > Could you explain more about why of_node_put is sufficient?
>
> You are right. In fact, I think calling of_node_put() for a prior
> of_find_device_by_node() is buggy as a call to of_find_device_by_node()
> increments the kref for the device embedding the node and not the kref of the
> node. Hence a call to put_device() is required to decrement the device kref.
> Calling the of_node_put() attempts to decrement the kref of the node, which I
> think is not correct.
>
> May I request any comment on my understanding?

I think that decrementing a kref and reaching 0 would trigger some cleanup
action.  I don't know what that cleanup action is in this case.

Did someone tell you that of_node_put was good enough?  Perhaps that
person could provide more explanation.

In looking quickly though the code, the focus seemed to be on the device.
The of node is just used for comparison to check that we have the right
one.  But I don't know if cleaning up the of node could somehow trigger
cleaning up the device as well.

julia

>
> Thank you,
> deepak.
>
> >
> > thanks,
> > julia
> >
> > > Also, improve the warning message to include of_node_put too is missing.
> > >
> > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > > ---
> > > scripts/coccinelle/free/put_device.cocci | 4 +++-
> > > 1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/scripts/coccinelle/free/put_device.cocci
> > > b/scripts/coccinelle/free/put_device.cocci
> > > index f09f1e79bfa6..259195b501aa 100644
> > > --- a/scripts/coccinelle/free/put_device.cocci
> > > +++ b/scripts/coccinelle/free/put_device.cocci
> > > @@ -18,8 +18,10 @@ type T,T1,T2,T3;
> > >
> > > id = of_find_device_by_node@p1(x)
> > > ... when != e = id
> > > +    when != of_node_put(x)
> > > if (id == NULL || ...) { ... return ...; }
> > > ... when != put_device(&id->dev)
> > > +    when != of_node_put(x)
> > >     when != platform_device_put(id)
> > >     when != if (id) { ... put_device(&id->dev) ... }
> > >     when != e1 = (T)id
> > > @@ -42,7 +44,7 @@ p2 << search.p2;
> > > @@
> > >
> > > coccilib.report.print_report(p2[0],
> > > -                             "ERROR: missing put_device; call
> > > of_find_device_by_node on line "
> > > +                             "ERROR: missing put_device or of_node_put; call
> > > of_find_device_by_node on line "
> > >                              + p1[0].line
> > >                              + ", but without a corresponding object release within this function.")
> > >
> > > --
> > > 2.34.1
>
>
>
