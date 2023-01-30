Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9213C54EED
	for <cocci@archiver.kernel.org>; Mon, 30 Jan 2023 08:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=RCW5B8bwADKkVRqaA0THSHAvgr/8n82FXNlFbKMiy8E=;
  b=kLEaSn3MR3+/SI1AerDlX0uJMZ6dlWe6Tz1N7zEW70F5GerAh3fTmkkQ
   SzEJzPHUa1Ty7WjXpUjOSttzR6qnjBBi0CvloSt8GzfOyltkUqpIO8fMH
   jBf/adi83NMxEiwW5LWIWtcVDVC1u6TP5qZ2iN2wQcpm5duqnLFOPphtE
   Y=;
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
X-IronPort-AV: E=Sophos;i="5.97,257,1669071600"; 
   d="scan'208";a="89997697"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Jan 2023 09:56:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8B5CFE7440; Mon, 30 Jan 2023 09:56:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9F4C1E743E
	for <cocci@sympa.inria.fr>; Mon, 30 Jan 2023 09:56:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RCW5B8bwADKkVRqaA0THSHAvgr/8n82FXNlFbKMiy8E=;
  b=VHqz3+iuCG0J6ldkbLnTwU5xZE0lMPWLIo9SV4ML2nRogQdRQRxNnd0P
   ngsxw+aAgd0+V+yqkFJuM0YC/38tA9zLHIuq9KXZeJBZdFzKZ0YbXLTA/
   ktKhnCFdwh6PLve6W6Lc8Ak2qy4RNmOSgRZsQlr93VHG3xUNEJL2uEyAs
   k=;
X-IronPort-AV: E=Sophos;i="5.97,257,1669071600"; 
   d="scan'208";a="89997681"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 09:56:27 +0100
Date: Mon, 30 Jan 2023 09:56:27 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Luca Coelho <luca@coelho.fi>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
In-Reply-To: <13bf65ac8504fa5ebcaf69539422fcd38bf157d1.camel@coelho.fi>
Message-ID: <2fecadea-70f4-d4c0-d280-8776e5e12cb1@inria.fr>
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>    <alpine.DEB.2.22.394.2301272148570.4094@hadrien>    <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi>    <808cd549-f96d-872d-a4db-30ea33095207@web.de>   
 <alpine.DEB.2.22.394.2301281048270.2822@hadrien>   <8f3f48170bab688aff69571913dbe27fc195fe1f.camel@coelho.fi>    <alpine.DEB.2.22.394.2301281432120.2822@hadrien>    <a1eed78f1f3f24c20fc11bb7328c3cb05db1611c.camel@coelho.fi>    <alpine.DEB.2.22.394.2301291826510.2852@hadrien>
  <543612938885a445d33ca5ae6d04a06a753c1caf.camel@coelho.fi>   <2338a91ffe751ceb6325e76bc526b84ca85fc4c8.camel@coelho.fi>   <alpine.DEB.2.22.394.2301292109320.2852@hadrien>  <3f376cb31e9050d005417809a9fa51d92cdc57d6.camel@coelho.fi> 
 <dc9d939d-e1bb-8447-e950-deacc7a3645a@inria.fr> <13bf65ac8504fa5ebcaf69539422fcd38bf157d1.camel@coelho.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for special function implementations with
 SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 845
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/2fecadea-70f4-d4c0-d280-8776e5e12cb1%40inria.fr>



On Mon, 30 Jan 2023, Luca Coelho wrote:

> On Mon, 2023-01-30 at 09:37 +0100, Julia Lawall wrote:
> > > Sorry, false alarm.  I was running spatch by itself on an inner
> > > directory (.../i915/display), but when I used find, I was using
> > > .../i915, so there was one more match happening there.
> > >
> > > So, it seems that the latest head _does_ work fine! And I'm gettign
> > > all
> > > the matches and changes that I expect.  Thanks!
> >
> > Great news :)
>
> Maybe I celebrated a bit too early.  There is still one instance that
> is not matching...

Probably it's a parse error.

Try putting the following in your semantic patch, egin the metavariable
list of macros_noargs:

iterator name with_intel_display_power_if_enabled;

If that is still not sufficient, try running

spatch --parse-c file.c

for the file of interest and see if it says BAD or bad on the lines of the
function that you expect should be matched.

julia

>
> I currently have these rules:
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
> identifier list il;
> @@
> #define nm(il) <+...m...+>
>
> @@
> identifier nested_macros.nm;
> identifier dev_priv, f;
> expression list el;
> @@
> f(...) {
> 	...
> 	struct drm_i915_private *dev_priv = ...;
>
> 	<+...
> 	nm(
> +	dev_priv,
> 	el)
> 	...+>
> }
>
> @@
> identifier nested_macros.nm;
> identifier dev_priv, f;
> expression list el;
> @@
> f(..., struct drm_i915_private *dev_priv, ...) {
> 	<+...
> 	nm(
> +	dev_priv,
> 	el)
> 	...+>
> }
>
> And then we have this function in
> drivers/gpu/drm/i915/display/intel_display.c:
>
> void vlv_wait_port_ready(struct drm_i915_private *dev_priv,
> 			 struct intel_digital_port *dig_port,
> 			 unsigned int expected_mask)
> {
> [...]
> 	switch (dig_port->base.port) {
> 	default:
> 		MISSING_CASE(dig_port->base.port);
> 		fallthrough;
> 	case PORT_B:
> 		port_mask = DPLL_PORTB_READY_MASK;
> 		dpll_reg = DPLL(0);
> 		break;
> 	case PORT_C:
> 		port_mask = DPLL_PORTC_READY_MASK;
> 		dpll_reg = DPLL(0);
> 		expected_mask <<= 4;
> 		break;
> [...]
> }
>
> The DPLL macro is defined like this (in
> drivers/gpu/drm/i915/display/i915_reg.h):
>
> #define _DPLL_A (DISPLAY_MMIO_BASE(dev_priv) + 0x6014)
> #define _DPLL_B (DISPLAY_MMIO_BASE(dev_priv) + 0x6018)
> #define _CHV_DPLL_C (DISPLAY_MMIO_BASE(dev_priv) + 0x6030)
> #define DPLL(pipe) _MMIO_PIPE3((pipe), _DPLL_A, _DPLL_B, _CHV_DPLL_C)
>
>
> So it should match like the other instances, but it doesn't.  I copied
> the macro definition and the function to stand-alone files (i.e.
> without the rest of the code) and it matches, but in the real code,
> running cocci like this, it doesn't:
>
> ~/public/coccinelle/spatch.opt --sp-file ~/dev_priv_i915.spatch --all-includes intel_display.c
>
> I noticed some parsing errors when using --debug (output attached), so
> maybe there's some parsing issues with the real file that prevents the
> rule from applying?
>
> Any clues?
>
> --
> Cheers,
> Luca.
>
