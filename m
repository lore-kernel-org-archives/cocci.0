Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCC0C38142
	for <cocci@archiver.kernel.org>; Sat, 28 Jan 2023 09:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=q7moBeNZb9mBO2SowNKICaHSNCl4XIkEejZnYHFByrI=;
  b=TYidfVcmDkHHg40pzl6Wrz16fNEVbi0Mq5CUpAefRpfM01H3rQxYpKKM
   EJE7XiL6kB+Oax3UajCdtVxwx0q7jOx4iDY2KNijk1Qyc3AFNL8nXHg/d
   JMRfEzLxcEhDKUo69iJFFWLtiW/ih/nyaSTOUbT+acHwHPy1L2Er/w14J
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.97,253,1669071600"; 
   d="scan'208";a="89858168"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2023 10:19:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A3A18E027E; Sat, 28 Jan 2023 10:19:10 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 91CD5E027E
	for <cocci@sympa.inria.fr>; Sat, 28 Jan 2023 10:19:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=q7moBeNZb9mBO2SowNKICaHSNCl4XIkEejZnYHFByrI=;
  b=IJIvMlpjvGv6FP3O2gB06MnI22pE5A6Ovaxwkl8YH37lcE1CyVyH7SFy
   Oqloy5qJ2X9dm+/fh6qUHEOh8jZy2VibOy2NFkOsAMSX5BC1nqUn7Tx0A
   B66tjM3/18gp7reKaz6a+oO3F2xc/9POxwUDSgCDsWWfNFr1rzGXTo8Sd
   s=;
X-IronPort-AV: E=Sophos;i="5.97,253,1669071600"; 
   d="scan'208";a="89858167"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 10:19:09 +0100
Date: Sat, 28 Jan 2023 10:19:09 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Luca Coelho <luca@coelho.fi>
cc: cocci@inria.fr
In-Reply-To: <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi>
Message-ID: <alpine.DEB.2.22.394.2301281015360.2822@hadrien>
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>  <alpine.DEB.2.22.394.2301272148570.4094@hadrien> <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1039402493-1674897549=:2822"
Subject: Re: [cocci] Nested macros
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 824
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/alpine.DEB.2.22.394.2301281015360.2822%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1039402493-1674897549=:2822
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 28 Jan 2023, Luca Coelho wrote:

> On Fri, 2023-01-27 at 21:52 +0100, Julia Lawall wrote:
> >
> > On Fri, 27 Jan 2023, Luca Coelho wrote:
> >
> > > Hi,
> > >
> > > I've been struggling with a change I want to make, so I hope someone
> > > can help.
> > >
> > > Basically I have something like this in the code:
> > >
> > > /* regs below are bits 15:0 */
> > > #define _MIPIA_HSYNC_PADDING_COUNT     (_MIPI_MMIO_BASE(dev_priv) + 0xb028)
> > > #define _MIPIC_HSYNC_PADDING_COUNT     (_MIPI_MMIO_BASE(dev_priv) + 0xb828)
> > > #define MIPI_HSYNC_PADDING_COUNT(port) _MMIO_MIPI(port, _MIPIA_HSYNC_PADDING_COUNT, _MIPIC_HSYNC_PADDING_COUNT)
> > >
> > > As you can see, these macros assume that the calling functions have a
> > > local called dev_priv, and I want to fix that.
> > >
> > > So, I'm trying to find all users of macros that have this construct.
> > > My problem is matching the nesting in the macros.
> > >
> > > I have tried this:
> > >
> > > @macros_noargs@
> > > identifier m;
> > > expression e =~ "dev_priv";
> > > @@
> > > #define m <+...e...+>
> > >
> > > @nested_macros@
> > > identifier macros_noargs.m;
> > > identifier nm;
> > > @@
> > > #define nm(...) <+...m...+>
> > >
> > > @@
> > > identifier nested_macros.nm;
> > > @@
> > > -nm
> > > +foo
> > >
> > > (this last rule is just for testing if anything is matching, obviously)
> > >
> > > But the "nested_macros" rule doesn't seem to work.  Does anyone know
> > > how I can solve this?
> >
> > I think that it works already.  If you add the following code to the .c
> > file, then the call gets changed:
> >
> > int main() {
> >   MIPI_HSYNC_PADDING_COUNT(12);
> > }
> >
> > I think that the problem is that a rule that replaces an identifier by
> > another doesn't match a macro definition.  Is that actually the precise
> > thing you want to do?  Or do you want to do something with the uses of the
> > macro.
>
> This is the initial thing I want to do:
>
> @@
> identifier nested_macros.nm;
> function f;
> identifier dev_priv;
> expression e;
> @@
> f(...) {
> 	...
> -	struct drm_i915_private *dev_priv = e;
> +	struct drm_i915_private *i915 = e;
>
> 	<+...nm(...)...+>
> }
>
> And it indeed works with a handcrafted file for testing (attached as
> i915_cocci_test.c), but it doesn't work IRL, for instance in the
> drivers/gpu/drm/i915/display/vlv_dsi.c file in the kernel (also
> attached)...
>
> I would expect there to be a match in the static void
> bxt_dsi_get_pipe_config() function...

To match the function, the semantic patch has to be able to see the macro
definitions.  They are not in the .c file.  Maybe you need a command line
argument like --all-includes (take into account all of the files mentioned
with #include, but not what they include) or --recursive-includes.  You
can give a search path if needed with -I.

You can use --debug to get some information about what rules are being
matched successfully.

julia


>
>
> > If you want to change the definition, you can also add a rule like this:
> >
> > @@
> > identifier nested_macros.nm;
> > identifier list is;
> > expression e;
> > @@
> >
> > -#define nm(is) e
> > +#define foo(is) e
>
> This is not what I actually want to do, I just created the simplest
> rule I could come up with to actually see the match (and replacement)
> happening. 😉
>
> --
> Cheers,
> Luca.
>
--8323329-1039402493-1674897549=:2822--
