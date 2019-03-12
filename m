Return-Path: <SRS0=3qPg=RP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3E7C4360F
	for <cocci@archiver.kernel.org>; Tue, 12 Mar 2019 09:04:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F313A2147C
	for <cocci@archiver.kernel.org>; Tue, 12 Mar 2019 09:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F313A2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2C94QTF011726
          ; Tue, 12 Mar 2019 10:04:27 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C0EDB7719;
	Tue, 12 Mar 2019 10:04:26 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 441677714
 for <cocci@systeme.lip6.fr>; Tue, 12 Mar 2019 10:04:25 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2C94N0c025132
 for <cocci@systeme.lip6.fr>; Tue, 12 Mar 2019 10:04:24 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.58,470,1544482800"; d="scan'208";a="298928367"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 10:03:58 +0100
Date: Tue, 12 Mar 2019 10:03:57 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Maxime Ripard <maxime.ripard@bootlin.com>
In-Reply-To: <20190312083143.sko2syivudpawqk7@flea>
Message-ID: <alpine.DEB.2.21.1903120950170.2728@hadrien>
References: <20190312083143.sko2syivudpawqk7@flea>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 12 Mar 2019 10:04:27 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Tue, 12 Mar 2019 10:04:24 +0100 (CET)
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

> Hi,
>
> I'm trying to do an API rework of DRM, and that rewrite involves
> patching a number of drivers to use a structure field instead of a
> funtion call.
>
> There's a bunch of cases that need to be covered, and I can't get all
> of them to work.
>
> So far, my current script is, with the current shortcomings as comment
> below each rule.
>
> @@
> identifier fn;
> identifier dev, cmd;
> @@
>
> fn (struct drm_device *dev,
>     ...,
>     struct drm_mode_fb_cmd2 *cmd,
>     ...)
> {
> + const struct drm_format_info *info = drm_get_format_info(dev, cmd);
> ...
> - drm_format_num_planes(cmd->pixel_format)
> + info->num_planes
> ...
> }
>
> // This on works on most cases, ie:
> // https://elixir.bootlin.com/linux/v5.0/source/drivers/gpu/drm/armada/armada_fb.c#L87
> // However, for some reason unknown to me, it doesn't match:
> // https://elixir.bootlin.com/linux/v5.0/source/drivers/gpu/drm/tegra/fb.c#L129

... means by default that what comes before or after the ... should not
appear in the ...  fb.c has the call in a loop, so it happens over and
over (... is following paths in the control-flow graph, not the AST.

Replace the first ... by <+... and the second one by ...+>.  That will
replace all calls, ensuring that there is at least once to motivate the
need for adding the declaration of info.


>
> @@
> identifier fb;
> @@
> ...
> struct drm_framebuffer *fb;
> ...
> - drm_format_num_planes(fb->format->format)
> + fb->format->num_planes
>
> // This one seems to work properly

How about:

@@
struct drm_framebuffer *fb;
@@

- drm_format_num_planes(fb->format->format)
+ fb->format->num_planes

That is, you don't need to insist on there being a local variable
declaration, you just want an expression of the right type.  This will
also be much more efficient.

> @@
> expression arg;
> identifier fb;
> @@
> ...
> struct drm_framebuffer *fb;
> ...
> - drm_format_num_planes(arg)
> + fb->format->num_planes
>
> // This one seems to work in some cases, such as
> // https://elixir.bootlin.com/linux/v5.0/source/drivers/gpu/drm/vc4/vc4_plane.c#L490
> // But it also matches in cases where fb hasn't been properly assigned before, such as:
> // https://elixir.bootlin.com/linux/v5.0/source/drivers/gpu/drm/tegra/fb.c#L142

OK, it looks like what you want is:

@@
struct drm_framebuffer *fb;
expression e.
@@

fb = e;
<...
- drm_format_num_planes(arg)
+ fb->format->num_planes
...>

That is, you find an assignment of fb, and then anywhere after that you
have a call, you can replace it.  This is <... ...> rather than <+...
...+> so that it can match several 0 or more occurrences.

>
> @@
> identifier info;
> @@
> ...
> struct drm_format_info *info;
> ...
> - drm_format_num_planes(info->format)
> + info->num_planes
>
> // This one seems to work too

Still it would be better to update it as suggested above.

julia

> I'm pretty new to coccinelle, so I'm not quite sure how to fix these
> errors properly, even though that looks pretty simple.
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
