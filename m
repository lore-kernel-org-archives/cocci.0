Return-Path: <SRS0=tDau=5O=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9605EC43331
	for <cocci@archiver.kernel.org>; Sun, 29 Mar 2020 11:24:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA3462076A
	for <cocci@archiver.kernel.org>; Sun, 29 Mar 2020 11:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3462076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02TBOhVh002937;
	Sun, 29 Mar 2020 13:24:43 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 64DCB7750;
	Sun, 29 Mar 2020 13:24:43 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 46B5C66CB
 for <cocci@systeme.lip6.fr>; Sun, 29 Mar 2020 13:24:42 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02TBOf0N026712
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 29 Mar 2020 13:24:41 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.72,320,1580770800"; d="scan'208";a="442811478"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Mar 2020 13:24:41 +0200
Date: Sun, 29 Mar 2020 13:24:41 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?Christoph_B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <0d87349e-f919-562e-eeea-fe6b09f44462@linbit.com>
Message-ID: <alpine.DEB.2.21.2003291322190.2990@hadrien>
References: <b86347f3-69d3-0801-c91f-87c3424e71dc@linbit.com>
 <alpine.DEB.2.21.2003271645370.2709@hadrien>
 <1f1a7b29-b767-551c-e2ec-d5cdf5ceecd0@linbit.com>
 <alpine.DEB.2.21.2003271714150.2709@hadrien>
 <2a36722e-c5ff-aa94-fac1-d885b89176d0@linbit.com>
 <alpine.DEB.2.21.2003291118410.2990@hadrien>
 <0d87349e-f919-562e-eeea-fe6b09f44462@linbit.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-877642179-1585481063=:2990"
Content-ID: <alpine.DEB.2.21.2003291324250.2990@hadrien>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 29 Mar 2020 13:24:43 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 29 Mar 2020 13:24:41 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Matching against a declarer macro
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

--8323329-877642179-1585481063=:2990
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.21.2003291324251.2990@hadrien>



On Sun, 29 Mar 2020, Christoph Böhmwalder wrote:

> Am 29.03.20 um 11:20 schrieb Julia Lawall>
> > It's not parsing anything.  You can see that here.  It is passing, ie
> > ignoring, the entire command line.
>
> Right, I misinterpreted that "passed" as "these parameters were passed
> to the macro:".
>
> >
> > I don't remember the exact situation with this code.  Is there no
> > semicolon at the end of the macro line?
>
> This is the exact piece of code:
>
> RB_DECLARE_CALLBACKS_MAX(static, augment_callbacks, struct drbd_interval, rb,
> sector_t, end, NODE_END);
>
> Putting this (and only this) in a test.c file produces the same problem:
>
> $ spatch --parse-c test.c --debug --verbose-parsing
> init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
>
> PARSING: test.c
> Warning: PARSING: type defaults to 'int'; value = [((((0, 2)))); (Tag1 ("",
> (("", 0, 0, 0, ""), -1)), (0), ((0, 0, 0, 0)), 0, (3))]
> ERROR-RECOV: end of file while in recovery mode
> parsing pass2: try again
> TYPEDEF:_handle_typedef=false. Not normal if don't come from exn
> Warning: PARSING: type defaults to 'int'; value = [((((0, 2)))); (Tag1 ("",
> (("", 0, 0, 0, ""), -1)), (0), ((0, 0, 0, 0)), 0, (3))]
> ERROR-RECOV: end of file while in recovery mode
> parsing pass3: try again
> (ONCE) CPP-MACRO: found known macro = RB_DECLARE_CALLBACKS_MAX
> TYPEDEF:_handle_typedef=false. Not normal if don't come from exn
> Warning: PARSING: type defaults to 'int'; value = [[[0]]; ((((0, 2)))); (Tag1
> ("", (("", 0, 0, 0, ""), -1)), (0), ((0, 0, 0, 0)), 0, (3))]
> passed:static , augment_callbacks , struct drbd_interval , rb ,
> passed:sector_t , end , NODE_END
> -----------------------------------------------------------------------
> maybe 10 most problematic tokens
> -----------------------------------------------------------------------
> -----------------------------------------------------------------------
> NB total files = 1; perfect = 1; pbs = 0; timeout = 0; =========> 100%
> nb good = 1,  nb passed = 2 =========> 66.67% passed
> nb good = 1,  nb bad = 0 =========> 100.00% good or passed
>
>
> Does this mean that this is just "unparseable"?

Everything would be fine if the "static" were not there.

Maybe you could use sed to replace (static by (STATIC in your code base,
then run your script, and then use sed to go the other way...

I don't know if it could be possible to allow static in argument lists.

julia
--8323329-877642179-1585481063=:2990
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-877642179-1585481063=:2990--
