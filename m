Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31253C61D97
	for <cocci@archiver.kernel.org>; Sun, 29 Jan 2023 17:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=SZ8syD4gZjD/WkVDuLGorygi8wuwmJPEy6SXFeJgC2U=;
  b=noVMiVAAHThecKclN0hXHoyNblXshgIpz81WaGbYCCKqg9t3mFC0a6Et
   rEnMql3SfF4S2RGQytIyLLC4Ddc9hGAvcITwncKyIF/vQorNhgbHi4qFg
   +5TrcwVXGoQQP29oaa0FTeVkzMuPY/ugfvjXsMAqhLmbP9vMeiio/Nx1P
   k=;
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
   d="scan'208";a="89934809"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2023 18:59:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 07751E7440; Sun, 29 Jan 2023 18:59:46 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 623BCE743E
	for <cocci@sympa.inria.fr>; Sun, 29 Jan 2023 18:55:17 +0100 (CET)
IronPort-SDR: 63d6b306_AwkyyQ46QLTl2f0Im3ke0kV54q+xAJlFTaeKKbF9h6cc+iT
 0Fs1fiBDKBwoAlgZHIsVWaE0C0+pi26ir04kYNw==
X-IPAS-Result: =?us-ascii?q?A0FSAwChstZj/0YpCbBaHgEBCxIMQIFEC4ItgV4rAwQLh?=
 =?us-ascii?q?RSIfogkEZ0sgX4PAQMBDUQEAQGFBwKFJh4GBjIHDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEDAQEFAQEBAgEBAgQEAQECgQYThXWCNykBg34BAQEBAgEjVgULCxgCAiYCA?=
 =?us-ascii?q?lcGhhEjBwGnQnqBMoEBhHOaZoFngRQsiRGIFUOCDYEVgyo+hESDWIJnBIEIm?=
 =?us-ascii?q?lwKgTl1gSUOgUaBDwIJAhFILEA3AxkrHUADCzsyCj81CwtKEBsaGweBBiooF?=
 =?us-ascii?q?QMEBAMCBhMDIgINKDEUBCkTDScmaQkCAyJiAwMEKC0JIB8HFREkPAdWNwEFA?=
 =?us-ascii?q?g8fNwYDCQMCH09yLhETBQMLFSpHBAg2BQYbNhICCA8SDwYmQw5CNzQTBlwBK?=
 =?us-ascii?q?QsOEQNQgU0EL4FiBikmoEYBS4EleDrCeIN/gVKfGDKBRKdrl0+oE4FpBDKBW?=
 =?us-ascii?q?TMaCDCDI04DGQ+kYj9vAgcBCgEBAwmMIwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 vlGkkDN0tONLl2FiArdCjFXQQuq+x8C+k81xA==
IronPort-HdrOrdr: A9a23:/UDC1q+IdwUcaphKE0tuk+DnI+orL9Y04lQ7vn2ZhyY7TiX+rb
 HNoB17726WtN9/Yh8dcLy7VZVoBEm8yXcX2/h0AV7BZmPbUQKTRekI0WKh+V3d8kbFh5ZgPM
 lbH5SWROeAaGSSlfyKhzVQCexQpuVv7prY/Nvj8w==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,256,1669071600"; 
   d="scan'208";a="89934677"
X-MGA-submission: =?us-ascii?q?MDGn13XOFw3MChLteHyuEthksDRHjxk0d2X+ol?=
 =?us-ascii?q?D1jqp3nlPqwWr8D1eVAzJ32ONYKPj/+TvZwHsEn6OSyrn74KGiQN5xN2?=
 =?us-ascii?q?Vp/vHMiJzvNm0vUeOAjpMWdSxn5A7tY92GlGhusG8Doh+MBnE5YmFj9B?=
 =?us-ascii?q?nqld4MncDojCWeI6lS28xAVQ=3D=3D?=
Received: from paleale.coelho.fi (HELO farmhouse.coelho.fi) ([176.9.41.70])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 18:55:17 +0100
Received: from 91-155-255-60.elisa-laajakaista.fi ([91.155.255.60] helo=[192.168.100.137])
	by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <luca@coelho.fi>)
	id 1pMBta-005zfR-11;
	Sun, 29 Jan 2023 19:55:15 +0200
Message-ID: <543612938885a445d33ca5ae6d04a06a753c1caf.camel@coelho.fi>
From: Luca Coelho <luca@coelho.fi>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
Date: Sun, 29 Jan 2023 19:55:13 +0200
In-Reply-To: <alpine.DEB.2.22.394.2301291826510.2852@hadrien>
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>
	   <alpine.DEB.2.22.394.2301272148570.4094@hadrien>
	   <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi>
	   <808cd549-f96d-872d-a4db-30ea33095207@web.de>
	   <alpine.DEB.2.22.394.2301281048270.2822@hadrien>
	  <8f3f48170bab688aff69571913dbe27fc195fe1f.camel@coelho.fi>
	  <alpine.DEB.2.22.394.2301281432120.2822@hadrien>
	 <a1eed78f1f3f24c20fc11bb7328c3cb05db1611c.camel@coelho.fi>
	 <alpine.DEB.2.22.394.2301291826510.2852@hadrien>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Searching for special function implementations with
 SmPL
Reply-To: Luca Coelho <luca@coelho.fi>
X-Loop: cocci@inria.fr
X-Sequence: 836
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/543612938885a445d33ca5ae6d04a06a753c1caf.camel%40coelho.fi>

On Sun, 2023-01-29 at 18:28 +0100, Julia Lawall wrote:
> > After mangling a lot with the rules, I can see that this now works,
> > but
> > only if I select the vlv_dsi.c file alone, like this:
> >=20
> > spatch --sp-file ~/dev_priv_i915.spatch -I
> > drivers/gpu/drm/i915/display \
> > =C2=A0--all-includes --in-place ./drivers/gpu/drm/i915/display/vlv_dsi.=
c
> >=20
> >=20
> > If I try to run the rules in all files in that directory, only the
> > intel_display.c file is affected:
> >=20
> > spatch --sp-file ~/dev_priv_i915.spatch -I
> > drivers/gpu/drm/i915/display  \
> > =C2=A0--all-includes --in-place ./drivers/gpu/drm/i915/display
> >=20
> >=20
> > Of course, I can work around this by using find and running spatch
> > individually in every file... But not ideal.
>=20
> OK, so perhaps the problem is not actually the rules, but rather the
> way in which the header files are being collected.

Yeah, after banging my head on the rules, I realized that the rules
themselves were not really the issue.


> What version of Coccinelle do you have?  Someone (Kees?) reported a
> problem with the collecion of header files at one point fairly
> recently, and I think I fixed it.  It should be available in the
> github version of Coccinelle.

This is what I have:

luca@kveik:~/gfx/linux-drm-tip$ spatch --version
spatch version 1.1.1 compiled with OCaml version 4.13.1
Flags passed to the configure script: --prefix=3D/usr --sysconfdir=3D/etc -=
-libdir=3D/usr/lib --enable-ocaml --enable-python --with-python=3Dpython3 -=
-enable-opt
OCaml scripting support: yes
Python scripting support: yes
Syntax of regular expressions: PCRE

It's the standard one from Debian testing.

I'll try the github version.  Thanks for pointing out!

--
Cheers,
Luca.
