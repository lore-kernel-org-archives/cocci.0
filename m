Return-Path: <SRS0=tjLV=SO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D3CC10F0E
	for <cocci@archiver.kernel.org>; Fri, 12 Apr 2019 10:33:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76CAD20850
	for <cocci@archiver.kernel.org>; Fri, 12 Apr 2019 10:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CAD20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3CAX1rl026242
          ; Fri, 12 Apr 2019 12:33:01 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 139977727;
	Fri, 12 Apr 2019 12:33:01 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B7528771D
 for <cocci@systeme.lip6.fr>; Fri, 12 Apr 2019 12:32:59 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3CAWwme007931
 for <cocci@systeme.lip6.fr>; Fri, 12 Apr 2019 12:32:58 +0200 (CEST)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.60,340,1549926000"; d="scan'208";a="378365459"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Apr 2019 12:32:27 +0200
Date: Fri, 12 Apr 2019 12:32:19 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e927e2b4-9ab3-81e2-80fc-e355bf608e06@web.de>
Message-ID: <alpine.DEB.2.20.1904121230480.4091@hadrien>
References: <8d40a536-c2fe-7d6b-58d5-840e013665f1@web.de>
 <alpine.DEB.2.20.1904121143510.4091@hadrien>
 <e927e2b4-9ab3-81e2-80fc-e355bf608e06@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-582942602-1555065139=:4091"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 12 Apr 2019 12:33:01 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Fri, 12 Apr 2019 12:32:59 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci]
	=?utf-8?q?Checking_the_=E2=80=9Cdisplay=E2=80=9D_of_last_?=
	=?utf-8?q?two_statements_in_code_blocks?=
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

--8323329-582942602-1555065139=:4091
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Fri, 12 Apr 2019, Markus Elfring wrote:

> >> @@ -3015,11 +2859,6 @@ static int init_slave(struct gbe_priv *g
> >>         }
> >>
> >>         if (of_property_read_u32(node, "link-interface",
> >> -                                &slave->link_interface)) {
> >> -               dev_warn(gbe_dev->dev,
> >> -                        "missing link-interface value defaulting to 1G mac-phy link\n");
> >> -               slave->link_interface = SGMII_LINK_MAC_PHY;
> >> -       }
> >>
> >>         slave->node = node;
> >>         slave->open = false;
> >> …
> >>
> >>
> >> Now I wonder about the suggested change for the if statement here.
> >> Should any more software adjustments be considered so that it will be avoided
> >> to delete only a questionable part from a function call within a condition check?
> >
> > I don't understand the problem.
>
> I suggest to take another look at the details in this test result.
>
>
> > You put *s on the { } and two statements, and you get - on the lines
> > that contain the { } and the two statements.
>
> This is the general analysis approach.
>
>
> > Nothing is being deleted anyway.  The -s are just a concise way to
> > indicate the lines on which you requested a match with the *s.
>
> I am using the asterisk functionality of the semantic patch language
> as usual.
>
> These minus characters indicate lines for possible deletions according to
> the diff format, don't they?
>
>
> I doubt that such code can be still compiled after an incomplete
> removal of the shown block would be applied because of the generated
> update suggestion.

The asterisk functionality has no goal of making code that compiles.  It's
goal is to show you the lines of interest.  If you use emacs, you can use
emacs diff mode to jump to those lines in the affected files.

If you want to actually remove the lines, then use - instead of asterisk.
- and + have the goal of making code that compiles.  * does not.

julia
--8323329-582942602-1555065139=:4091
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-582942602-1555065139=:4091--
