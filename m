Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8C7C636CC
	for <cocci@archiver.kernel.org>; Tue, 31 Jan 2023 16:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=5J6qXDdSOGgWLNuNAxT4UDzu8Pe+KY5MRXD58akK8tE=;
  b=D9J6OgS93wbf84gztmugIU+O3botfV3arD8jk9DUdOuXL38JvsL8tR9X
   U4BYWymPIFPq6Vvkjvj4L3cudUNoZTuCwCbzjojcMy/zT0RU4GmA/vkfv
   sLhXxwqm5ElM24xJGDqYjEnn+LRiAyFwsMZjs+6IUQ6I9IaBLVXRtsWR4
   U=;
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
X-IronPort-AV: E=Sophos;i="5.97,261,1669071600"; 
   d="scan'208";a="90353136"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 31 Jan 2023 17:10:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2A4FEE743E; Tue, 31 Jan 2023 17:10:10 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1DFCAE743E
	for <cocci@sympa.inria.fr>; Tue, 31 Jan 2023 17:10:09 +0100 (CET)
IronPort-SDR: 63d93d60_tKWzHSrGtxE1ewiNn6k6XHdijk+ETml/oymAA/PVq6nXKWo
 sKmKyhIe8XIofbytEpRn3IuvTBFTGLvFGHir/2A==
X-IPAS-Result: =?us-ascii?q?A0FxAgApPNljjEYpCbBaHgEBCxIMQIFEC4ItgV4uBAuFF?=
 =?us-ascii?q?Ih+iCQRnS2Bfg8BAwENRAQBAYUHAoUlHgYGMgcOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QMBAQUBAQECAQECBAQBAQIQAQEBAUBFhXWCNykBg38BAgMjBFIQCxgCAiYCA?=
 =?us-ascii?q?lcGgxGDIwcBq1x/M4EBhHOaZoFngRQsiRGIFUOCDYEVgyo+hESDWIJnBIEIm?=
 =?us-ascii?q?n8KgTl2gSUOgUaBDwIJAhFILHI3AxkrHUADCzsyCj81CwtKEBsaGweBBiooF?=
 =?us-ascii?q?QMEBAMCBhMDIgINKDEUBCkTDScmaQkCAyJiAwMEKC0JIB8HFREkPAdWNwEFA?=
 =?us-ascii?q?g8fNwYDCQMCH09yLhETBQMLFSpHBAg2BQYcNhICCA8SDwYmRA5CNzQTBlwBK?=
 =?us-ascii?q?QsOEQNQgU4EL4FiBgEpJqBlEwEvggCiB6Fkg3+BUp8ZMoFEoHKGeZdPolqFO?=
 =?us-ascii?q?YFpATKBXDMaCDCDI04DGQ+OOZYpP28CBwsBAQMJjCMBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:+iwA4qCitwLyiuTlHemT55DYdb4zR+YMi2TDGXofdfUzSL37qy
 nOpoV56faaslgssR0b9OxofZPgfZq+z+8Q3WByB92ftWDd0QPCEGgh1+vfKlbbalXDH4BmuZ
 uIP5IObeEYFWIK6voS+jPIderI3uP3iZyVuQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,261,1669071600"; 
   d="scan'208";a="90353127"
X-MGA-submission: =?us-ascii?q?MDFYmDDsETmJfOyEpFm/iUaRtWHielIWOWO6K1?=
 =?us-ascii?q?075PmZOZ1lFvy+LUFj4+NlqsnrTpPfd/g34SYP9KyNrUdG+H7wwsMaKx?=
 =?us-ascii?q?HQb8T7tluHlDg1KnE4kNxogO7TapivhlOJ8Tmab/E0eq1mWQQn8Fp4FM?=
 =?us-ascii?q?3pDmjjK7Xm+cBybAqt8PfRbA=3D=3D?=
Received: from paleale.coelho.fi (HELO farmhouse.coelho.fi) ([176.9.41.70])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 17:10:07 +0100
Received: from 91-155-255-60.elisa-laajakaista.fi ([91.155.255.60] helo=[192.168.100.137])
	by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <luca@coelho.fi>)
	id 1pMtCv-0061dq-Li;
	Tue, 31 Jan 2023 18:10:07 +0200
Message-ID: <e907e583ef32ddeaccc5a016bfd3276a2fff6ed5.camel@coelho.fi>
From: Luca Coelho <luca@coelho.fi>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
Date: Tue, 31 Jan 2023 18:10:05 +0200
In-Reply-To: <df5d799a-941c-1afa-fee2-db2ec89abb19@inria.fr>
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>
	  <alpine.DEB.2.22.394.2301272148570.4094@hadrien>
	  <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi>
	  <808cd549-f96d-872d-a4db-30ea33095207@web.de>
	  <alpine.DEB.2.22.394.2301281048270.2822@hadrien>
	 <8f3f48170bab688aff69571913dbe27fc195fe1f.camel@coelho.fi>
	  <alpine.DEB.2.22.394.2301281432120.2822@hadrien>
	  <a1eed78f1f3f24c20fc11bb7328c3cb05db1611c.camel@coelho.fi>
	  <alpine.DEB.2.22.394.2301291826510.2852@hadrien>
	  <543612938885a445d33ca5ae6d04a06a753c1caf.camel@coelho.fi>
	 <2338a91ffe751ceb6325e76bc526b84ca85fc4c8.camel@coelho.fi>
	  <alpine.DEB.2.22.394.2301292109320.2852@hadrien>
	  <3f376cb31e9050d005417809a9fa51d92cdc57d6.camel@coelho.fi>
	  <dc9d939d-e1bb-8447-e950-deacc7a3645a@inria.fr>
	  <13bf65ac8504fa5ebcaf69539422fcd38bf157d1.camel@coelho.fi>
	 <23ba4681-0b9e-cf60-5422-64526cdf462a@web.de>
	  <e1ebf2b582bd97d42e8573471fac83578d47ef17.camel@coelho.fi>
	  <079efecb-91da-e111-1a28-2c883b69af7b@web.de>
	  <99bb02f6fdcb711102ef0b544fd6cf5a5dd90f97.camel@coelho.fi>
	  <4ce77f5f-2433-bb99-9270-f66267a84432@inria.fr>
	 <9f4c958a4bf370f7eb5fe49ac2be380ada6d9ac5.camel@coelho.fi>
	 <48a02a321c06093966bc9999f9e8333f391475d7.camel@coelho.fi>
	 <df5d799a-941c-1afa-fee2-db2ec89abb19@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
Subject: Re: [cocci] Searching for special function implementations with
 SmPL
Reply-To: Luca Coelho <luca@coelho.fi>
X-Loop: cocci@inria.fr
X-Sequence: 859
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/e907e583ef32ddeaccc5a016bfd3276a2fff6ed5.camel%40coelho.fi>

On Tue, 2023-01-31 at 17:08 +0100, Julia Lawall wrote:
>=20
> On Tue, 31 Jan 2023, Luca Coelho wrote:
>=20
> > On Mon, 2023-01-30 at 12:59 +0200, Luca Coelho wrote:
> > > On Mon, 2023-01-30 at 11:47 +0100, Julia Lawall wrote:
> > > > It doesn't find the file with the definition.  You may need to give=
 more
> > > > paths.
> > > >=20
> > > > I have the impression that the result is improved with
> > > >=20
> > > > -I drivers/gpu/drm/i915
> > > >=20
> > > > Maybe -I drivers/gpu/drm/i915/display is necessary also.  If you ad=
d the
> > > > argument --relax-include-path then just -I drivers/gpu/drm/i915 may=
 be
> > > > sufficient.  With that option, it will just hunt around in and unde=
r the
> > > > various include paths for a unique file that has the required name.
> > >=20
> > > Alright! That _does_ improve things! Now I can see lots of DPLL match=
es
> > > in that file!
> >=20
> > These files I'm trying to parse are so complex that I keep bumping into
> > other parsing errors.  Here's one of them:
> >=20
> > parse error
> >  =3D File "./drivers/gpu/drm/i915/i915_drv.h", line 385, column 1, char=
pos =3D 9644
> >   around =3D 'for',
> >   whole content =3D       for ((id__) =3D 0; \
> > badcount: 7
> > bad: }
> > bad:
> > bad: /* Simple iterator over all initialised engines */
> > bad: #define for_each_engine(engine__, dev_priv__, id__) \
> > BAD:!!!!!       for ((id__) =3D 0; \
> > bad:         (id__) < I915_NUM_ENGINES; \
> > bad:         (id__)++) \
> > bad:            for_each_if ((engine__) =3D (dev_priv__)->engine[(id__)=
])
> > ERROR-RECOV: found sync end of #define, line 395
> >=20
> >=20
> > I believe the parser is getting confused by an iterator inside an
> > iterator's definition... I already tried to add them both with the
> > "iterator name" directive, but it didn't help...
> >=20
> > Any idea what I can do about this?
>=20
> If you don't care about finding things in this code, you can just ignore
> it.

I don't, but this seems to be included from intel_display_power.c and
I'm not getting the matches I expect in this C file... Maybe there are
other hints in the debugging output?

--
Cheers,
Luca.
