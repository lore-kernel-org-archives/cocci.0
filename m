Return-Path: <SRS0=7Jgl=4H=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34ED9C5ACC4
	for <cocci@archiver.kernel.org>; Wed, 19 Feb 2020 22:37:19 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E0FC20656
	for <cocci@archiver.kernel.org>; Wed, 19 Feb 2020 22:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0FC20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 01JMb5P0003398;
	Wed, 19 Feb 2020 23:37:05 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3125377F6;
	Wed, 19 Feb 2020 23:37:05 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 23EC277EE
 for <cocci@systeme.lip6.fr>; Wed, 19 Feb 2020 23:37:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 01JMb3oW023488
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 19 Feb 2020 23:37:03 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.70,462,1574118000"; d="scan'208";a="436805588"
Received: from abo-105-123-68.mrs.modulonet.fr (HELO hadrien) ([85.68.123.105])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Feb 2020 23:37:03 +0100
Date: Wed, 19 Feb 2020 23:37:03 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
In-Reply-To: <20200219172849.GU13686@intel.com>
Message-ID: <alpine.DEB.2.21.2002192335560.2565@hadrien>
References: <20200219172849.GU13686@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1449002602-1582151823=:2565"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 19 Feb 2020 23:37:05 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 19 Feb 2020 23:37:03 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Inserting code after specific set of declarations?
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

--8323329-1449002602-1582151823=:2565
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



--- Please note the new email address ---


On Wed, 19 Feb 2020, Ville Syrjälä wrote:

> Hi all,
>
> I was trying to do the following transformation:
> @@
> identifier M;
> expression E;
> @@
> - struct foo M = E;
> + struct foo M;
> + copy_struct(&M, &E);
>
> but without inserting the function call in the middle of the
> declarations and instead pushing it past them.
>
> This is one attempt:
> @decl@
> identifier M;
> expression E;
> @@
> - struct foo M = E;
> + struct foo M;
>
> @copy@
> identifier decl.M;
> expression decl.E;
> declaration D;
> statement S;
> @@
> struct foo M;
> ...
> D
> + copy_struct(&M, &E);
> S
>
> The copy rule fails to match anything when I have != 1
> declarations after the struct. So the ... doesn't seem
> to eat the extra declarations for some reason.

@copy@
identifier decl.M;
expression decl.E;
declaration D;
statement S;
@@
struct foo M;
... when any
D
+ copy_struct(&M, &E);
S

Otherwise, ... doesn't match code that includes what is before or after
it, ie struct foo M or D.

Aternatively:

@copy@
identifier decl.M;
expression decl.E;
declaration D;
statement S,S1;
@@
struct foo M;
... when != S1
+ copy_struct(&M, &E);
S

julia


>
> Also tried some other tricks with <... ...> but that just resulted
> in the code being inserted into every if block in the function.
> Not what I wanted.
>
> I guess what I might need is something along the lines of:
> @copy@
> ...
> declaration list[N] D;
> @@
> struct foo M;
> D
> + copy_struct(&M, &E);
> S
>
> but that's not supported it seems.
>
> Is there any way to achieve this atm?
>
> --
> Ville Syrjälä
> Intel
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
--8323329-1449002602-1582151823=:2565
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1449002602-1582151823=:2565--
