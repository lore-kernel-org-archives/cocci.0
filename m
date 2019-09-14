Return-Path: <SRS0=oroW=XJ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE16EC4CEC9
	for <cocci@archiver.kernel.org>; Sat, 14 Sep 2019 20:00:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E3720678
	for <cocci@archiver.kernel.org>; Sat, 14 Sep 2019 20:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E3720678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8EK0jY5023350;
	Sat, 14 Sep 2019 22:00:45 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7E68F7797;
	Sat, 14 Sep 2019 22:00:45 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7655376D9
 for <cocci@systeme.lip6.fr>; Sat, 14 Sep 2019 22:00:43 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8EK0gmL023799
 for <cocci@systeme.lip6.fr>; Sat, 14 Sep 2019 22:00:43 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.64,506,1559512800"; d="scan'208";a="319412408"
Received: from 81-65-53-248.rev.numericable.fr (HELO hadrien) ([81.65.53.248])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2019 22:00:42 +0200
Date: Sat, 14 Sep 2019 22:00:42 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?Christoph_B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20190912123435.ztwsymd7m4s4n6hq@gintonic.linbit>
Message-ID: <alpine.DEB.2.21.1909142158560.2490@hadrien>
References: <20190912111304.2fu3lcqmtgbnolpx@gintonic.linbit>
 <alpine.DEB.2.21.1909121330300.2876@hadrien>
 <20190912123435.ztwsymd7m4s4n6hq@gintonic.linbit>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-411413525-1568491242=:2490"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 14 Sep 2019 22:00:46 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sat, 14 Sep 2019 22:00:43 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] const in parameter lists
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

--8323329-411413525-1568491242=:2490
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 12 Sep 2019, Christoph Böhmwalder wrote:

> On Thu, Sep 12, 2019 at 01:31:52PM +0200, Julia Lawall wrote:
> >
> > Sorry, it's not clear to me what you want to do.  Do you want to verify
> > that there is a const before renaming the parameter?  Could you do
> >
> > const unsigned
> > -a
> > +b
> >
> > ?
> >
> > julia
>
> I'll try and outline what I'm actually trying to do.
>
> Here's what I have:
>
> int drbd_submit_peer_request(struct drbd_device *device,
> 			     struct drbd_peer_request *peer_req,
> 			     const unsigned op, const unsigned op_flags,
> 			     const int fault_type)
> {
> // ...
> }
>
> This is what I want:
>
> int drbd_submit_peer_request(struct drbd_device *device,
> 			     struct drbd_peer_request *peer_req,
> 			     const unsigned rw,
> 			     const int fault_type)
> {
> // ...
> }
>
> And this is my cocci patch:
>
> @@
> identifier op, op_flags;
> struct bio *b;
> @@
> drbd_submit_peer_request(...
> -    , const unsigned op, const unsigned op_flags
> +    , const unsigned rw

Const was not supported in front of signed or unsigned (as opposed to
signed int or unsigned int).  I have fixed this, but am not able to
update github due to a build issue.  But your semantic patch will work if
you put unsigned int in each case.  It will not require the int to be
present in the C code.

julia

>  ,...)
> {
> ...
> }
>
> This gives an error:
>
> minus: parse error:
>   File "drbd/drbd-kernel-compat/cocci/req_write__yes_present.cocci", line 35, column 22, charpos = 548
>   around = 'op',
>   whole content = -    , const unsigned op, const unsigned op_flags
>
>
> Doing it without the consts yields this:
>
>  int drbd_submit_peer_request(struct drbd_device *device,
> -                            struct drbd_peer_request *peer_req,
> -                            const unsigned op, const unsigned op_flags,
> +                            struct drbd_peer_request *peer_reqconst,
> +                            unsigned rw,
>                              const int fault_type)
>  {
>
> Notice the stray "const" behind "peer_req".
>
> So -- to answer your question -- my priority here is to get the code
> compiling; I don't actually care about any of the consts. Best case
> scenario would be to have it remove whether or not the consts are there
> and always add the new parameter with a const.
>
> --
> Christoph Böhmwalder
> LINBIT | Keeping the Digital World Running
> DRBD HA —  Disaster Recovery — Software defined Storage
>
--8323329-411413525-1568491242=:2490
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-411413525-1568491242=:2490--
