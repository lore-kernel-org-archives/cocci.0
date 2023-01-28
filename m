Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56DBC38142
	for <cocci@archiver.kernel.org>; Sat, 28 Jan 2023 10:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=AnyX7tYL3g4HdDlH1HEnHYTcPWSVDxo+A0Lr0537HQ4=;
  b=sfY5Qq2cL4S/UiKV5UsR1YUcrY05/Dgf6X/f1PWlBbKtoBAeQ9/w9H5N
   bik0RfFGDXPh7jZ7UrCwdbhMbwmvwk8pJ4JckeEct/3VhAiogJGXpsELU
   BBD5VBmjNyw3gPopQm57dbIM6TuxIkFqZg8iC5PYvgWucgVpKK1L7Cvvx
   I=;
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
X-IronPort-AV: E=Sophos;i="5.97,253,1669071600"; 
   d="scan'208";a="89863460"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2023 11:42:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CC11DE0367; Sat, 28 Jan 2023 11:42:37 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 21D8FE027E
	for <cocci@sympa.inria.fr>; Sat, 28 Jan 2023 11:03:50 +0100 (CET)
IronPort-SDR: 63d4f305_ndwbdTVouydAQ8oBLe1QsFXX7QWxucAplpwJb2oVx9T22ys
 PIGhl2H7/zEomWrDNXnES1btQd2eQkvwaCN7C6A==
X-IPAS-Result: =?us-ascii?q?A0EdBABQ8dRj/0YpCbBaHQEBAQEJARIBBQUBQIFPgi2BX?=
 =?us-ascii?q?isDBAuFFIh+iCQRm1aDVA8BAwENRAQBAYUHAoUmHgYGNBMBAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBAQIEBAEBAoEGE4V1gjcpAYN/AQUjBFIQCQIYAgImA?=
 =?us-ascii?q?gJXBgGGMwcBjROcF38zgQGEc5pmgWeBFCyJEYNlhDBDgg2EPz6ERINYgmcEg?=
 =?us-ascii?q?QiaZwqBOXiBJQ6BRoEPAgkCEUgsQjcDGSsdQAMLOzIKPzULC0oQGxobB4EGK?=
 =?us-ascii?q?igVAwQEAwIGEwMgAg0oMRQEKRMNJyZpCQIDImIDAwQoLQkgHwcVESQ8B1Y3A?=
 =?us-ascii?q?QUCDx83BgMJAwIfT3IuERMFAwsVKkcECDYFBhw2EgIIDxIPBiZEDkI3NBMGX?=
 =?us-ascii?q?AEpCw4RA1CBTgQvgV0KBikmoE4BG5U5sESDfoFSnxgygUSna5dPIKdwgXkmg?=
 =?us-ascii?q?VkzGggwgyNOAxkPogU/bwIHAQoBAQMJjCMBAQ?=
IronPort-PHdr: A9a23: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
 OmdgCZ+bzhZhMtk+A==
IronPort-Data: A9a23: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
 c42ohXNA/R6/n2lqSv/KBB2bSeLC842Hk41xH0=
IronPort-HdrOrdr: A9a23:wKIG0qBw6+HxSV7lHemT55DYdb4zR+YMi2TDGXofdfUzSL37qy
 nOpoV56faaslgssR0b9OxofZPgfZq+z+8Q3WByB92ftWDd0QPCEGgh1+vfKlbbalXDH4BmuZ
 uIP5IObeEYFWIK6voS+jPIderI3uP3iZyVuQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,253,1669071600"; 
   d="scan'208";a="46240815"
X-MGA-submission: =?us-ascii?q?MDEe5LBIqlDcmcoXwINYQ/ELIehSfue+rUl6yI?=
 =?us-ascii?q?cBQsN1q3sAVahod7ofOT4c9IPmo82hhyhlUdI9wlKjlpy8olUPP2ktIT?=
 =?us-ascii?q?XXfCoXm4xLAS5GX3nbGNHv2E3QxBvdZ2wCjgLIdgMAt5HYa9HDq10NPY?=
 =?us-ascii?q?U0Ug5nVhklvUdB9hiFKh/17Q=3D=3D?=
Received: from paleale.coelho.fi (HELO farmhouse.coelho.fi) ([176.9.41.70])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 11:03:49 +0100
Received: from 91-155-255-60.elisa-laajakaista.fi ([91.155.255.60] helo=[192.168.100.137])
	by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <luca@coelho.fi>)
	id 1pLi3l-005yne-Bt;
	Sat, 28 Jan 2023 12:03:47 +0200
Message-ID: <8f3f48170bab688aff69571913dbe27fc195fe1f.camel@coelho.fi>
From: Luca Coelho <luca@coelho.fi>
To: Julia Lawall <julia.lawall@inria.fr>, Markus Elfring
 <Markus.Elfring@web.de>
Cc: cocci@inria.fr
Date: Sat, 28 Jan 2023 12:03:44 +0200
In-Reply-To: <alpine.DEB.2.22.394.2301281048270.2822@hadrien>
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>
	 <alpine.DEB.2.22.394.2301272148570.4094@hadrien>
	 <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi>
	 <808cd549-f96d-872d-a4db-30ea33095207@web.de>
	 <alpine.DEB.2.22.394.2301281048270.2822@hadrien>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Searching for special function implementations with
 SmPL
Reply-To: Luca Coelho <luca@coelho.fi>
X-Loop: cocci@inria.fr
X-Sequence: 828
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/8f3f48170bab688aff69571913dbe27fc195fe1f.camel%40coelho.fi>

On Sat, 2023-01-28 at 10:49 +0100, Julia Lawall wrote:
>=20
> On Sat, 28 Jan 2023, Markus Elfring wrote:
>=20
> > > @@
> > > identifier nested_macros.nm;
> > > function f;
> > > identifier dev_priv;
> >=20
> >=20
> > How do you think about to use the following SmPL code variant instead o=
f
> > the metavariable type =E2=80=9Cfunction=E2=80=9D?
> >=20
> >=20
> > identifier dev_priv, f;
>=20
> Good suggestion,  Function is not really supported.  I think it behaves
> just like identifier, but it would be better to just use identifier.
> Function was an idea thta never actually got implemented.

Good idea, I generally don't use function, but I'd been trying lots of
different things before I reached out for help. =F0=9F=99=82 I guess I trie=
d with
function at some point and then ended up leaving it there.

Now I tried with f as identifier, but it didn't make a difference.

I can actually match _one_ of the occurrences now, but there are many
other ones that are not matching...

This is what I'm using:

@macros_noargs@
identifier m;
expression e =3D~ "dev_priv";
@@
#define m <+...e...+>

@nested_macros@
identifier macros_noargs.m;
identifier nm;
@@
#define nm(...) <+...m...+>

@@
identifier nested_macros.nm;
identifier dev_priv, f;
expression e;
@@
f(...) {
	...
-	struct drm_i915_private *dev_priv =3D e;
+	struct drm_i915_private *i915 =3D e;

	<+...
	nm(...)
	...+>
}

...and this is the command line:

spatch --sp-file ~/dev_priv_i915.spatch -I drivers/gpu/drm/i915/display \
 --recursive-includes --in-place --dir ./drivers/gpu/drm/i915/display

...and this is the only match I get:

HANDLING: ./drivers/gpu/drm/i915/display/intel_display.c
diff =3D=20
diff -u -p a/intel_display.c b/intel_display.c
--- a/intel_display.c
+++ b/intel_display.c
@@ -3943,7 +3943,7 @@ static bool bxt_get_dsi_transcoder_state
 					 struct intel_display_power_domain_set *power_domain_set)
 {
 	struct drm_device *dev =3D crtc->base.dev;
-	struct drm_i915_private *dev_priv =3D to_i915(dev);
+	struct drm_i915_private *i915 =3D to_i915(dev);
 	enum transcoder cpu_transcoder;
 	enum port port;
 	u32 tmp;

Many other files are handled, but there are no matches, though I
believe there should be.

--
Cheers,
Luca.
