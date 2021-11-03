Return-Path: <SRS0=6LBi=PW=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE545C433EF
	for <cocci@archiver.kernel.org>; Wed,  3 Nov 2021 21:03:59 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B96C461053
	for <cocci@archiver.kernel.org>; Wed,  3 Nov 2021 21:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B96C461053
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3Au1xBXa0iVHQxM+IBYvbD5cJwkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJhjorgTUCzjZJDzyOPP3ZYWLxe9AnbIi0/RgA6pHdnIA2QQE+nZ1PZyIT+?=
 =?us-ascii?q?JCdXbx1DW+pYnjMdpWbJK5fAnR3huDodKjYdVeB4EfyWlTdhSMkj/jRH+KnULW?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YDdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?+g7PjewsLRKTTNE6AkBK6WYD72EgE93d0i/hhcqNCMS+7iB3Q9zx14N5KvpexD?=
 =?us-ascii?q?AA2OKDWsOUbSRhRVS9kVUFD0OaXcSLm75f7I0ruNiGEL+9VJEoxNoYZ0u9tCmF?=
 =?us-ascii?q?P6/ECbjMAdBaOg6Sx2r3TYuNtnd8yIsfDM4YWu3UmxjbcZd4tRp3FTqPi6tpR3?=
 =?us-ascii?q?TN2jcdLdd7Sbsxfa3xwbRDEYhRKIX8YDZs/mKGjgXyXWzFRtlOZvq0x72bcyCR?=
 =?us-ascii?q?+1bHsNJzefdnibclY2F2fu3DPuW/+GBwcKN2Z4TWA+3OowOTImEvTU5kPELmp3?=
 =?us-ascii?q?vFth1KXyyoYDxh+fVG2p/S1i02ic9JSKkoZvDAppqspnGSgSt76RDW6oHWAuRk?=
 =?us-ascii?q?HHdFXFoUS5AiLy6fQpQKUFGMNSDlpbN0gvdUxAzsw2TehlNPzBCdzt6WVD3ia+?=
 =?us-ascii?q?7eRsjq2NSUPBWsDYyUFUU0O5NyLnW2ZpnojVf57Cqm5y9n0Ai392C3T/G4/ga8?=
 =?us-ascii?q?ShIgFzc2GEZn8q2rEjvD0osQdv207hl6Y0z4=3D?=
X-IronPort-AV: E=Sophos;i="5.87,206,1631570400"; 
   d="scan'208";a="1882163"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Nov 2021 22:03:57 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DC5A3E006A; Wed,  3 Nov 2021 22:03:56 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 40128E004C
	for <cocci@sympa.inria.fr>; Wed,  3 Nov 2021 22:03:50 +0100 (CET)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ac11IxqB98uZ4CkblHemr55DYdb4zR+YMi2TD?=
 =?us-ascii?q?tnoBLSC9HfbyqynDpp4mPFrP6Qr5O0tQ/OxoWpPhfZq0z/cc3WBSB8bAYOCMgg?=
 =?us-ascii?q?WVxe9ZgbcKjweQeRHWx6ptkZ1tdKVzE7TLYGRSh8yS2maFL+o=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="398173650"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 22:03:49 +0100
Date: Wed, 3 Nov 2021 22:03:49 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jakub Kicinski <kuba@kernel.org>
cc: Gilles Muller <Gilles.Muller@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, 
    Michal Marek <michal.lkml@markovi.net>, cocci@inria.fr
In-Reply-To: <20211103135714.6bfcd45c@kicinski-fedora-PC1C0HJN>
Message-ID: <alpine.DEB.2.22.394.2111032200510.3289@hadrien>
References: <20211103124001.68e76017@kicinski-fedora-PC1C0HJN> <alpine.DEB.2.22.394.2111032134360.3289@hadrien> <20211103135714.6bfcd45c@kicinski-fedora-PC1C0HJN>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Best way to run coccinelle in a CI?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 65
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/alpine.DEB.2.22.394.2111032200510.3289%40hadrien>



On Wed, 3 Nov 2021, Jakub Kicinski wrote:

> On Wed, 3 Nov 2021 21:37:07 +0100 (CET) Julia Lawall wrote:
> > On Wed, 3 Nov 2021, Jakub Kicinski wrote:
> > > Hi folks!
> > >
> > > I'd like to run coccicheck on all patches before they are committed
> > > to Linux networking trees. Is there a recommended way of doing that?
> > >
> > > I'm looking for a way to run the checks only on files which were
> > > touched and in the fastest way possible..
> >
> > I had an intern who worked on an extension to Coccinelle to take a patch
> > and then only apply spatch to that file.  Perhaps I can resurrect that
> > code.
>
> That'd be quite useful, thanks! Would it have any impact on the
> performance as well? I see running coccicheck M=net/core/ takes
> 2 minutes now, for a 15 patch series that adds up quickly.

I think it should be helpful.  If most files are completely ignored, the
performance should improve.  On the other hand, I don't known if it would
be practical to treat diferent patches in parallel.  So the speedup might
not be that great.  It depends on how many files are actually being
parsed,

> I could run the check on all patches in a series to speed things
> up. Would it be possible to feed it a git range?
>
> > [Note the new mailing list: cocci@inria.fr]
>
> Thanks, FWIW I was going by addresses in MAINTAINERS in Linus's tree.

Yeah, I need to send him a pull request...

julia
