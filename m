Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CBFC433FE
	for <cocci@archiver.kernel.org>; Mon, 21 Mar 2022 20:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:content-id:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=+iAje8HwoTKVVLsYWwFwzmevqMzSU+vHd9tB8rvnpPo=;
  b=cqdSoKDxjo6/1AREaG+IDTB/dwnbi8fnL1cleDDxOTp4H0vI+zmMuCvN
   ve6gLkAz13afH37D1lmlREsRNXagszFP6IUje9+i81dJyIPRCL/rK7cUP
   0q1s17AP3puOhFRupDJAW/21OgJDUrLj+Zqs7sYmKKIJFGtPzy6J0oPn3
   c=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.90,199,1643670000"; 
   d="scan'208";a="27317262"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2022 21:49:00 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4D2F5E0219; Mon, 21 Mar 2022 21:49:00 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9741EE0069
	for <cocci@sympa.inria.fr>; Mon, 21 Mar 2022 21:48:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=+iAje8HwoTKVVLsYWwFwzmevqMzSU+vHd9tB8rvnpPo=;
  b=Dx/BdeKDKr6Jz7BFJAQVU4IP344Oqgt4621CERh1G1ZOrKNgWjuQFXS0
   TgszBxQo9BVrNkSWTe/MYkTtjTTJ6UWNTsl0eswAGkKY8QiT1cC6dh8e6
   hTgXwe4yxyWfN2ZOYAuNZcZ8eZijxucPeaoCXpl7x6bJL26PCQUMUbUJO
   c=;
X-IronPort-AV: E=Sophos;i="5.90,199,1643670000"; 
   d="scan'208";a="27317259"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 21:48:55 +0100
Date: Mon, 21 Mar 2022 21:48:55 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
cc: Jani Nikula <jani.nikula@linux.intel.com>, dri-devel@lists.freedesktop.org, 
    intel-gfx@lists.freedesktop.org, Nicolas Palix <nicolas.palix@imag.fr>, 
    cocci@inria.fr
In-Reply-To: <YjjKnUbcJRpcoxoI@intel.com>
Message-ID: <alpine.DEB.2.22.394.2203212147050.3189@hadrien>
References: <20220218100403.7028-1-ville.syrjala@linux.intel.com> <20220218100403.7028-19-ville.syrjala@linux.intel.com> <877d8upbsp.fsf@intel.com> <YjjKnUbcJRpcoxoI@intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1112260562-1647895664=:3189"
Content-ID: <alpine.DEB.2.22.394.2203212148250.3189@hadrien>
Subject: Re: [cocci] [Intel-gfx] [PATCH 18/22] drm/i915: Use drm_mode_init()
 for on-stack modes
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 281
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203212147050.3189%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1112260562-1647895664=:3189
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2203212148251.3189@hadrien>



On Mon, 21 Mar 2022, Ville Syrjälä wrote:

> On Wed, Mar 16, 2022 at 10:00:06AM +0200, Jani Nikula wrote:
> > On Fri, 18 Feb 2022, Ville Syrjala <ville.syrjala@linux.intel.com> wrote:
> > > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > >
> > > Initialize on-stack modes with drm_mode_init() to guarantee
> > > no stack garbage in the list head, or that we aren't copying
> > > over another mode's list head.
> > >
> > > Based on the following cocci script, with manual fixups:
> > > @decl@
> > > identifier M;
> > > expression E;
> > > @@
> > > - struct drm_display_mode M = E;
> > > + struct drm_display_mode M;
> > >
> > > @@
> > > identifier decl.M;
> > > expression decl.E;
> > > statement S, S1;
> > > @@
> > > struct drm_display_mode M;
> > > ... when != S
> > > + drm_mode_init(&M, &E);
> > > +
> > > S1
> > >
> > > @@
> > > expression decl.E;
> > > @@
> > > - &*E
> > > + E
> > >
> > > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> >
> > I wonder if that cocci could be added to scripts/coccinelle or something
> > to detect anyone adding new ones?
>
> Maybe.
>
> Julia & co, would you be open to having drm subsystem specific
> coccinelle scripts? If so where should we put the?
> scripts/coccinelle/drm perhaps?

That would be fine.  It is possible to make a script only apply to a
specific directory, but I think that that is not necessary in this case,
since you mention types that are only relevant to drm code.

julia
--8323329-1112260562-1647895664=:3189--
