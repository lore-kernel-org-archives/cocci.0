Return-Path: <SRS0=prLC=PX=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81BDC433F5
	for <cocci@archiver.kernel.org>; Thu,  4 Nov 2021 19:46:44 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0F8B61241
	for <cocci@archiver.kernel.org>; Thu,  4 Nov 2021 19:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E0F8B61241
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,209,1631570400"; 
   d="scan'208";a="2064040"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Nov 2021 20:46:43 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5D3F3E0295; Thu,  4 Nov 2021 20:46:42 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E0169E004C
	for <cocci@sympa.inria.fr>; Thu,  4 Nov 2021 20:46:40 +0100 (CET)
IronPort-Data: =?us-ascii?q?A9a23=3ApdWe06kMmd4hVeLz3tayl4fo5gxzJERdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bpzZVmmBKXGuDM6qDYDf9c9pya4+29hhUupLQnNViSQtk+CA2RRqmi?=
 =?us-ascii?q?+KVXIXDdh+Y0wC6d5CYEho/t63yUjRxRSwNZie0SiyFb/6x8hGQ6YnSHuClUbe?=
 =?us-ascii?q?cZngrLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82Yc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTckQGWL/fO2BiiFIGBu780l4b/HV0i/lgXBYfQR4/ZzGhnc11ydwLsZWvQ?=
 =?us-ascii?q?AMtFqzKguUUFRdCe817FfcepuOfeiXXXcu7iheun2HX6/ZzBkgePoAC/OtzR2Z?=
 =?us-ascii?q?U+pQwJzUQahSOncqkwbexUOAqh8I5LcCtMpl3kndhxjbdBO1gWZnHQrXi5NpR0?=
 =?us-ascii?q?3E+nKhmGPfVZ8MdLz5saRDoZhRVOVAJCdQ4kfvArnL4eDZZgEmEoLI+pWnV1g1?=
 =?us-ascii?q?4lrb3WOc50PTiqd59xxnD4DucpiKnUldKaZqFxCTD6Xy2wOnCgUvGtEspPOXQ3?=
 =?us-ascii?q?pZXbJe7nwT/0CEraGY=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AYzMKEqvy8K7WAqulCP02TdWr7skDa9V00zEX?=
 =?us-ascii?q?/kB9WHVpm62j5qOTdZsgpHrJYVoqNk3I+urhBED/ewK/yXcd2+B4Vt2ftW/d2V?=
 =?us-ascii?q?dAR7sP0WKN+VDd8lXFmdJg6Q=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,209,1631570400"; 
   d="scan'208";a="2064035"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 20:46:41 +0100
Date: Thu, 4 Nov 2021 20:46:40 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jakub Kicinski <kuba@kernel.org>
cc: Gilles Muller <Gilles.Muller@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, 
    Michal Marek <michal.lkml@markovi.net>, cocci@inria.fr
In-Reply-To: <20211104104343.3fe15f62@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <alpine.DEB.2.22.394.2111042045180.3001@hadrien>
References: <20211103124001.68e76017@kicinski-fedora-PC1C0HJN> <alpine.DEB.2.22.394.2111032134360.3289@hadrien> <20211103135714.6bfcd45c@kicinski-fedora-PC1C0HJN> <alpine.DEB.2.22.394.2111041612130.2680@hadrien> <20211104102448.4c97e7e6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <alpine.DEB.2.22.394.2111041827060.2680@hadrien> <20211104104343.3fe15f62@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Best way to run coccinelle in a CI?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 72
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/alpine.DEB.2.22.394.2111042045180.3001%40hadrien>



On Thu, 4 Nov 2021, Jakub Kicinski wrote:

> On Thu, 4 Nov 2021 18:30:10 +0100 (CET) Julia Lawall wrote:
> > > Great, sounds like the exact thing I need.
> > >
> > > And I would pass these to coccicheck as
> > >
> > > SPFLAGS="--use-patch-diff $hash1..$hash2"
> >
> > That looks like a reasonable guess.  I'm not sure how it will interact
> > with what make coccicheck wants to do though.
>
> In terms of what make does? So running ./scripts/coccicheck directly
> would be better?

Not sure.  Basically, the ideal thing would be if spatch sees the
directory of your git tree.  Because it is going to be picking the files
it wants to consider by itself out of the commit.  But it might be fine.

julia
