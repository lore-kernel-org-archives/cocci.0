Return-Path: <SRS0=15MF=5F=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD4AC4332B
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 08:53:13 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4CFA20752
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 08:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CFA20752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02K8qrXP016793;
	Fri, 20 Mar 2020 09:52:53 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DFF8E780E;
	Fri, 20 Mar 2020 09:52:52 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 32B6A77F9
 for <cocci@systeme.lip6.fr>; Thu, 20 Feb 2020 14:35:08 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 01KDZ49U026145
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 20 Feb 2020 14:35:06 +0100 (CET)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Feb 2020 05:27:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,464,1574150400"; d="scan'208";a="269585550"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
 by fmsmga002.fm.intel.com with SMTP; 20 Feb 2020 05:27:42 -0800
Received: by stinkbox (sSMTP sendmail emulation);
 Thu, 20 Feb 2020 15:27:41 +0200
Date: Thu, 20 Feb 2020 15:27:41 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Julia Lawall <julia.lawall@inria.fr>
Message-ID: <20200220132741.GX13686@intel.com>
References: <20200219172849.GU13686@intel.com>
 <alpine.DEB.2.21.2002192335560.2565@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2002192335560.2565@hadrien>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Mar 2020 09:52:53 +0100 (CET)
X-Greylist: Delayed for 00:07:19 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Thu, 20 Feb 2020 14:35:07 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Fri, 20 Mar 2020 09:52:51 +0100
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

On Wed, Feb 19, 2020 at 11:37:03PM +0100, Julia Lawall wrote:
> =

> =

> --- Please note the new email address ---
> =

> =

> On Wed, 19 Feb 2020, Ville Syrj=E4l=E4 wrote:
> =

> > Hi all,
> >
> > I was trying to do the following transformation:
> > @@
> > identifier M;
> > expression E;
> > @@
> > - struct foo M =3D E;
> > + struct foo M;
> > + copy_struct(&M, &E);
> >
> > but without inserting the function call in the middle of the
> > declarations and instead pushing it past them.
> >
> > This is one attempt:
> > @decl@
> > identifier M;
> > expression E;
> > @@
> > - struct foo M =3D E;
> > + struct foo M;
> >
> > @copy@
> > identifier decl.M;
> > expression decl.E;
> > declaration D;
> > statement S;
> > @@
> > struct foo M;
> > ...
> > D
> > + copy_struct(&M, &E);
> > S
> >
> > The copy rule fails to match anything when I have !=3D 1
> > declarations after the struct. So the ... doesn't seem
> > to eat the extra declarations for some reason.
> =

> @copy@
> identifier decl.M;
> expression decl.E;
> declaration D;
> statement S;
> @@
> struct foo M;
> ... when any
> D
> + copy_struct(&M, &E);
> S
> =

> Otherwise, ... doesn't match code that includes what is before or after
> it, ie struct foo M or D.

This one still inserts the code after all declarations in nested
blocks. Also misses cases where there are no extra declarations.
So not quite what I need.

> =

> Aternatively:
> =

> @copy@
> identifier decl.M;
> expression decl.E;
> declaration D;
> statement S,S1;
> @@
> struct foo M;
> ... when !=3D S1
> + copy_struct(&M, &E);
> S

This on the other hand seems to work very nicely. Thanks.

Earlier I tried to play around with some '... when !=3D' stuff,
but this double statement trick did not occur to me.

-- =

Ville Syrj=E4l=E4
Intel
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
