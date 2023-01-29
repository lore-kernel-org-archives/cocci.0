Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF93C61D97
	for <cocci@archiver.kernel.org>; Sun, 29 Jan 2023 17:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ysj8Mwrgb5R1ir0cQHGIrS+nM65dPheewiao3MSB3P0=;
  b=rkm7qEO/O6pvS5upheGiPy6TuJji9fE1F9GAdhvRFAoiZENehR16fqxs
   kekxCmBfujxChnckahze8Flu/zeXwjmbH1Fiphrq1qAZ5il6//R4hcNmL
   j3r6rtkpdGaU6yxOzq59VTftT+4FK/UYWG2BPOljWhRSxdwWHvbhdLaTn
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.97,256,1669071600"; 
   d="scan'208";a="89933404"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2023 18:26:44 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6EA2DE7440; Sun, 29 Jan 2023 18:26:44 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 646B5E743E
	for <cocci@sympa.inria.fr>; Sun, 29 Jan 2023 17:39:56 +0100 (CET)
IronPort-SDR: 63d6a15b_wZLor+8azojWkSuWlzYp5lHd4EWq2n/BIJ4blmmN88mCqss
 0HHzk5EbSZC0pcg5is4NGUArqpp67UE+KIjYXsA==
X-IPAS-Result: =?us-ascii?q?A0H5AwA2oNZj/0YpCbBaHgEBCxIMQIN8gV4rAwQLhRSIf?=
 =?us-ascii?q?ogkEZ8qDwEDAQ1EBAEBhQcChSYeBgY0EwECBAEBAQEDAgMBAQEBAQEDAQEFA?=
 =?us-ascii?q?QEBAgEBAgQEAQECgQYThXWCNykBg38BBSMEUhAJAhgCAiYCAlcGhjQHAYwUn?=
 =?us-ascii?q?Bd/M4EBhHOaZoFngRQsiRGIFUOCDYQ/PoREg1iCZwSBCJpcCoE5dYElDoFGg?=
 =?us-ascii?q?Q8CCQIRSCxANwMZKx1AAws7Mgo/NQsLShAbGhsHgQYqKBUDBAQDAgYTAyICD?=
 =?us-ascii?q?SgxFAQpEw0nJmkJAgMiYgMDBCgtCSAfBxURJDwHVjcBBQIPHzcGAwkDAh9Pc?=
 =?us-ascii?q?i4REwUDCxUqRwQINgUGGzYSAggPEg8GJkMOQjc0EwZcASkLDhEDUIFNBC+BY?=
 =?us-ascii?q?gYpJp83gQ8BGzCCV5IysEaDf4FSnxgygUSna5dPqBOBeSaBWTMaCDA7gmhOA?=
 =?us-ascii?q?xkPpGI/bwIHAQoBAQMJjCMBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:rgNBq6DqJA2JruTlHemT55DYdb4zR+YMi2TDGXofdfUzSL37qy
 nOpoV56faaslgssR0b9OxofZPgfZq+z+8Q3WByB92ftWDd0QPCEGgh1+vfKlbbalXDH4BmuZ
 uIP5IObeEYFWIK6voS+jPIderI3uP3iZyVuQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,256,1669071600"; 
   d="scan'208";a="46286305"
X-MGA-submission: =?us-ascii?q?MDHytHzt9zYvN0CsUApRuLr4/zWCPtpIa1nGz4?=
 =?us-ascii?q?mgLdPaZQUr1gaQDQsunBwgRJWm3fdHEgJjo9xh+CUteldtHYE2m6gTJg?=
 =?us-ascii?q?pLULaO1tRppCgf9M21NCwP26CHieBYvXN8ErCGSTRb3kV6F8Zhrrsqvx?=
 =?us-ascii?q?CZoN/NGzBdGs34ah3q/KzmnA=3D=3D?=
Received: from paleale.coelho.fi (HELO farmhouse.coelho.fi) ([176.9.41.70])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 17:39:55 +0100
Received: from 91-155-255-60.elisa-laajakaista.fi ([91.155.255.60] helo=[192.168.100.137])
	by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <luca@coelho.fi>)
	id 1pMAie-005zdE-4i;
	Sun, 29 Jan 2023 18:39:53 +0200
Message-ID: <a1eed78f1f3f24c20fc11bb7328c3cb05db1611c.camel@coelho.fi>
From: Luca Coelho <luca@coelho.fi>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
Date: Sun, 29 Jan 2023 18:39:51 +0200
In-Reply-To: <alpine.DEB.2.22.394.2301281432120.2822@hadrien>
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>
	  <alpine.DEB.2.22.394.2301272148570.4094@hadrien>
	  <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi>
	  <808cd549-f96d-872d-a4db-30ea33095207@web.de>
	  <alpine.DEB.2.22.394.2301281048270.2822@hadrien>
	 <8f3f48170bab688aff69571913dbe27fc195fe1f.camel@coelho.fi>
	 <alpine.DEB.2.22.394.2301281432120.2822@hadrien>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Searching for special function implementations with
 SmPL
Reply-To: Luca Coelho <luca@coelho.fi>
X-Loop: cocci@inria.fr
X-Sequence: 833
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/a1eed78f1f3f24c20fc11bb7328c3cb05db1611c.camel%40coelho.fi>

On Sat, 2023-01-28 at 14:33 +0100, Julia Lawall wrote:
>=20
> On Sat, 28 Jan 2023, Luca Coelho wrote:
>=20
> > On Sat, 2023-01-28 at 10:49 +0100, Julia Lawall wrote:
> > >=20
> > > On Sat, 28 Jan 2023, Markus Elfring wrote:
> > >=20
> > > > > @@
> > > > > identifier nested_macros.nm;
> > > > > function f;
> > > > > identifier dev_priv;
> > > >=20
> > > >=20
> > > > How do you think about to use the following SmPL code variant inste=
ad of
> > > > the metavariable type =E2=80=9Cfunction=E2=80=9D?
> > > >=20
> > > >=20
> > > > identifier dev_priv, f;
> > >=20
> > > Good suggestion,  Function is not really supported.  I think it behav=
es
> > > just like identifier, but it would be better to just use identifier.
> > > Function was an idea thta never actually got implemented.
> >=20
> > Good idea, I generally don't use function, but I'd been trying lots of
> > different things before I reached out for help. =F0=9F=99=82 I guess I =
tried with
> > function at some point and then ended up leaving it there.
> >=20
> > Now I tried with f as identifier, but it didn't make a difference.
> >=20
> > I can actually match _one_ of the occurrences now, but there are many
> > other ones that are not matching...
> >=20
> > This is what I'm using:
> >=20
> > @macros_noargs@
> > identifier m;
> > expression e =3D~ "dev_priv";
> > @@
> > #define m <+...e...+>
> >=20
> > @nested_macros@
> > identifier macros_noargs.m;
> > identifier nm;
> > @@
> > #define nm(...) <+...m...+>
> >=20
> > @@
> > identifier nested_macros.nm;
> > identifier dev_priv, f;
> > expression e;
> > @@
> > f(...) {
> > 	...
> > -	struct drm_i915_private *dev_priv =3D e;
> > +	struct drm_i915_private *i915 =3D e;
> >=20
> > 	<+...
> > 	nm(...)
> > 	...+>
> > }
> >=20
> > ...and this is the command line:
> >=20
> > spatch --sp-file ~/dev_priv_i915.spatch -I drivers/gpu/drm/i915/display=
 \
> >  --recursive-includes --in-place --dir ./drivers/gpu/drm/i915/display
> >=20
> > ...and this is the only match I get:
> >=20
> > HANDLING: ./drivers/gpu/drm/i915/display/intel_display.c
> > diff =3D
> > diff -u -p a/intel_display.c b/intel_display.c
> > --- a/intel_display.c
> > +++ b/intel_display.c
> > @@ -3943,7 +3943,7 @@ static bool bxt_get_dsi_transcoder_state
> >  					 struct intel_display_power_domain_set *power_domain_set)
> >  {
> >  	struct drm_device *dev =3D crtc->base.dev;
> > -	struct drm_i915_private *dev_priv =3D to_i915(dev);
> > +	struct drm_i915_private *i915 =3D to_i915(dev);
> >  	enum transcoder cpu_transcoder;
> >  	enum port port;
> >  	u32 tmp;
> >=20
> > Many other files are handled, but there are no matches, though I
> > believe there should be.
>=20
> Sorry, but it's not obvious how to debug this without any idea of what
> should be found,  Maybe the proper macro definitions are not being found.
> Maybe the proper uses are not being found.  Do you have a concrete exampl=
e
> where a change should happen?

Yes, sorry for not being clear enough.  The issue I'm trying to solve
is that we have bunch of macros, such as MIPI_CTRL(), that implicitly
uses dev_priv, so it must be declared as a local in the function
calling it.  I want to make this explicit, so I want to do exactly
this:


@macros_noargs@
identifier m;
expression e =3D~ "dev_priv";
@@
#define m <+...e...+>

@nested_macros@
identifier macros_noargs.m;
identifier nm;
identifier list il;
@@
#define nm(il) <+...m...+>

@@
identifier nested_macros.nm;
identifier list il;
expression e;
@@
-#define nm(il) e
+#define nm(dev_priv, il) e

@@
identifier nested_macros.nm;
identifier dev_priv, f;
expression e;
expression list il;
@@
f(...) {
	...
(
	struct drm_i915_private *dev_priv =3D e;
|
	struct drm_i915_private *dev_priv;
)

	<+...
-	nm(il)
+	nm(dev_priv, il)
	...+>
}


The idea is that all the macros that are implicitly using dev_priv,
will have a new argument where dev_priv is passed.

So, eg. in drivers/gpu/drm/i915/display/vlv_dsi.c, the following code:

static bool glk_dsi_enable_io(struct intel_encoder *encoder)
{
	struct drm_i915_private *dev_priv =3D to_i915(encoder-
>base.dev);
[...]
	for_each_dsi_port(port, intel_dsi->ports) {
		tmp =3D intel_de_read(dev_priv, MIPI_CTRL(port));
		intel_de_write(dev_priv, MIPI_CTRL(port),
			       tmp | GLK_MIPIIO_ENABLE);
	}
[...]
}

Would become:

static bool glk_dsi_enable_io(struct intel_encoder *encoder)
{
	struct drm_i915_private *dev_priv =3D to_i915(encoder->base.dev);
[...]
	for_each_dsi_port(port, intel_dsi->ports) {
		tmp =3D intel_de_read(dev_priv, MIPI_CTRL(dev_priv, port));
		intel_de_write(dev_priv, MIPI_CTRL(dev_priv, port),
			       tmp | GLK_MIPIIO_ENABLE);
	}
[...]
}


And the macro definition:

#define MIPI_CTRL(port)			_MMIO_MIPI(port, _MIPIA_CTRL, _MIPIC_CTRL)

Would become:

#define MIPI_CTRL(dev_priv,port) _MMIO_MIPI(port, _MIPIA_CTRL, _MIPIC_CTRL)


After mangling a lot with the rules, I can see that this now works, but
only if I select the vlv_dsi.c file alone, like this:

spatch --sp-file ~/dev_priv_i915.spatch -I drivers/gpu/drm/i915/display \
 --all-includes --in-place ./drivers/gpu/drm/i915/display/vlv_dsi.c


If I try to run the rules in all files in that directory, only the
intel_display.c file is affected:

spatch --sp-file ~/dev_priv_i915.spatch -I drivers/gpu/drm/i915/display  \
 --all-includes --in-place ./drivers/gpu/drm/i915/display


Of course, I can work around this by using find and running spatch
individually in every file... But not ideal.

--
Cheers,
Luca.
