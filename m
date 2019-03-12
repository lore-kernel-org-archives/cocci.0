Return-Path: <SRS0=3qPg=RP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D096C43381
	for <cocci@archiver.kernel.org>; Tue, 12 Mar 2019 13:59:13 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F210E2087C
	for <cocci@archiver.kernel.org>; Tue, 12 Mar 2019 13:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F210E2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2CDx0Nj013672
          ; Tue, 12 Mar 2019 14:59:00 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BB7547719;
	Tue, 12 Mar 2019 14:59:00 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3D9A57714
 for <cocci@systeme.lip6.fr>; Tue, 12 Mar 2019 14:58:59 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2CDwwlo021089
 for <cocci@systeme.lip6.fr>; Tue, 12 Mar 2019 14:58:58 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.58,471,1544482800"; d="scan'208";a="298985535"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Mar 2019 14:58:58 +0100
Date: Tue, 12 Mar 2019 14:58:55 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Maxime Ripard <maxime.ripard@bootlin.com>
In-Reply-To: <20190312135257.covmumxsrezrehka@flea>
Message-ID: <alpine.DEB.2.20.1903121455330.4097@hadrien>
References: <20190312083143.sko2syivudpawqk7@flea>
 <alpine.DEB.2.21.1903120950170.2728@hadrien>
 <20190312135257.covmumxsrezrehka@flea>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 12 Mar 2019 14:59:01 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Tue, 12 Mar 2019 14:58:58 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Substitution of function call to structure parameter
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr



On Tue, 12 Mar 2019, Maxime Ripard wrote:

> On Tue, Mar 12, 2019 at 10:03:57AM +0100, Julia Lawall wrote:
> > >
> > > @@
> > > identifier fb;
> > > @@
> > > ...
> > > struct drm_framebuffer *fb;
> > > ...
> > > - drm_format_num_planes(fb->format->format)
> > > + fb->format->num_planes
> > >
> > > // This one seems to work properly
> >
> > How about:
> >
> > @@
> > struct drm_framebuffer *fb;
> > @@
> >
> > - drm_format_num_planes(fb->format->format)
> > + fb->format->num_planes
> >
> > That is, you don't need to insist on there being a local variable
> > declaration, you just want an expression of the right type.  This will
> > also be much more efficient.
>
> I have an extra question on that one. Are function parameters also
> considered expressions with that syntax?
>
> Let's say for example, I want to replace the call to drm_format_info
> by drm_get_format_info in that function:
> https://elixir.bootlin.com/linux/v5.0/source/drivers/gpu/drm/omapdrm/omap_fb.c#L340
>
> That snippet doesn't work:
> @@
> struct drm_device *dev;
> struct drm_mode_fb_cmd2 *cmd;
> @@
>
> - drm_format_info(cmd->pixel_format)
> + drm_get_format_info(dev, cmd)
>
> with spatch producing the following warnings and errors:
>
> warning: rule starting on line 1: metavariable dev not used in the - or context code
> error: rule starting on line 1: dev appears only in + code
>
> Does that mean I have to explicitly have the function prototype as
> context?

It has nothing to do with function parameters.  You have plus code that
refers to a metavariable (dev) that doesn't appear in the - code.  So
Coccinelle has no idea what you want it to be.

There is no shortcut to match both a local variable and a function
parameter.  You need to have a specific rule matching the form of the
function:

f(...,struct drm_device *dev,...) {
<+...
- drm_format_info(cmd->pixel_format)
+ drm_get_format_info(dev, cmd)
...+>
}

You could use either <... ...> or <+... ...+>.  <+... ...+> indicates that
a call to drm_format_info is required, which will cause Coccinele to
mostly skip processing of functions that don't contain it.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
