Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF72C61D97
	for <cocci@archiver.kernel.org>; Sat, 28 Jan 2023 13:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=47ehqdfUDvOFR6OdL8xdCWq/BUoG+YXXS7EYwEOTO7Y=;
  b=HKk2xDrPbuXvggQLa+2XwYrZWqO+ZnXE8CWkj8Xi3aTDFzwH7zE+5y1C
   vHgjd/YELizFKAg70bJ3nXNwQl/manOwhwHQ6OID0hBfwl7d1Iy+1kUc6
   roaAD/vDNBx1lAQiB4wG7Dql1siydmNiT/rvaMZzQk0AtX7E/lpQrb4CR
   I=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.97,254,1669071600"; 
   d="scan'208";a="89871383"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2023 14:33:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EC8DDE0280; Sat, 28 Jan 2023 14:33:28 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CA2A0E027E
	for <cocci@sympa.inria.fr>; Sat, 28 Jan 2023 14:33:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=47ehqdfUDvOFR6OdL8xdCWq/BUoG+YXXS7EYwEOTO7Y=;
  b=vSVLOyzODSRBZp1MC7YAniP7CoTPY49ONsPD9pgtpwneanihrzaG/PoT
   /S5BUYbOQihFH8pzpd0WFMUkzbbICZTUoqegMeDAm8CPENC8A3boeRrYm
   3pj6A41KZ4YAvPpyfOs800eZf/2WBQzFWXDAUZWISd/wZrwkHP7G/9utI
   w=;
X-IronPort-AV: E=Sophos;i="5.97,254,1669071600"; 
   d="scan'208";a="46247699"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 14:33:23 +0100
Date: Sat, 28 Jan 2023 14:33:22 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Luca Coelho <luca@coelho.fi>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
In-Reply-To: <8f3f48170bab688aff69571913dbe27fc195fe1f.camel@coelho.fi>
Message-ID: <alpine.DEB.2.22.394.2301281432120.2822@hadrien>
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>  <alpine.DEB.2.22.394.2301272148570.4094@hadrien>  <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi>  <808cd549-f96d-872d-a4db-30ea33095207@web.de>  <alpine.DEB.2.22.394.2301281048270.2822@hadrien>
 <8f3f48170bab688aff69571913dbe27fc195fe1f.camel@coelho.fi>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-25426016-1674912803=:2822"
Subject: Re: [cocci] Searching for special function implementations with
 SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 829
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
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/alpine.DEB.2.22.394.2301281432120.2822%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-25426016-1674912803=:2822
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 28 Jan 2023, Luca Coelho wrote:

> On Sat, 2023-01-28 at 10:49 +0100, Julia Lawall wrote:
> >
> > On Sat, 28 Jan 2023, Markus Elfring wrote:
> >
> > > > @@
> > > > identifier nested_macros.nm;
> > > > function f;
> > > > identifier dev_priv;
> > >
> > >
> > > How do you think about to use the following SmPL code variant instead of
> > > the metavariable type “function”?
> > >
> > >
> > > identifier dev_priv, f;
> >
> > Good suggestion,  Function is not really supported.  I think it behaves
> > just like identifier, but it would be better to just use identifier.
> > Function was an idea thta never actually got implemented.
>
> Good idea, I generally don't use function, but I'd been trying lots of
> different things before I reached out for help. 🙂 I guess I tried with
> function at some point and then ended up leaving it there.
>
> Now I tried with f as identifier, but it didn't make a difference.
>
> I can actually match _one_ of the occurrences now, but there are many
> other ones that are not matching...
>
> This is what I'm using:
>
> @macros_noargs@
> identifier m;
> expression e =~ "dev_priv";
> @@
> #define m <+...e...+>
>
> @nested_macros@
> identifier macros_noargs.m;
> identifier nm;
> @@
> #define nm(...) <+...m...+>
>
> @@
> identifier nested_macros.nm;
> identifier dev_priv, f;
> expression e;
> @@
> f(...) {
> 	...
> -	struct drm_i915_private *dev_priv = e;
> +	struct drm_i915_private *i915 = e;
>
> 	<+...
> 	nm(...)
> 	...+>
> }
>
> ...and this is the command line:
>
> spatch --sp-file ~/dev_priv_i915.spatch -I drivers/gpu/drm/i915/display \
>  --recursive-includes --in-place --dir ./drivers/gpu/drm/i915/display
>
> ...and this is the only match I get:
>
> HANDLING: ./drivers/gpu/drm/i915/display/intel_display.c
> diff =
> diff -u -p a/intel_display.c b/intel_display.c
> --- a/intel_display.c
> +++ b/intel_display.c
> @@ -3943,7 +3943,7 @@ static bool bxt_get_dsi_transcoder_state
>  					 struct intel_display_power_domain_set *power_domain_set)
>  {
>  	struct drm_device *dev = crtc->base.dev;
> -	struct drm_i915_private *dev_priv = to_i915(dev);
> +	struct drm_i915_private *i915 = to_i915(dev);
>  	enum transcoder cpu_transcoder;
>  	enum port port;
>  	u32 tmp;
>
> Many other files are handled, but there are no matches, though I
> believe there should be.

Sorry, but it's not obvious how to debug this without any idea of what
should be found,  Maybe the proper macro definitions are not being found.
Maybe the proper uses are not being found.  Do you have a concrete example
where a change should happen?

thanks,
julia
--8323329-25426016-1674912803=:2822--
