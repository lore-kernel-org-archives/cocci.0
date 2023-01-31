Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131D9C636CC
	for <cocci@archiver.kernel.org>; Tue, 31 Jan 2023 15:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=IBTzm2aosrpYLzb7jldZLmOVuFfzW/9RUenE7rD6fBw=;
  b=JUckqIiSgXlBAhJ4KdhJGUJ5GiSubA3UIkNrOg5zPODKm4tluwKJGnmi
   BvL1OTUjvyEtshBe3bn09vg7+vkMhHozKnafoLegzGX1WpCEikxdDRXdo
   2q0VwQc/wI0TstX4ovlrM/wmjS1C2MLVXAcAXzTzO9sPgxOqyqUnnnuVx
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
X-IronPort-AV: E=Sophos;i="5.97,261,1669071600"; 
   d="scan'208";a="90350325"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 31 Jan 2023 16:58:08 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C60F8E7442; Tue, 31 Jan 2023 16:58:07 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 614EEE743E
	for <cocci@sympa.inria.fr>; Tue, 31 Jan 2023 16:58:03 +0100 (CET)
IronPort-SDR: 63d93a8a_TGe8TEkqGhSzYGGEqgnxvmYGCt2C/Jt/4n8qcbVkGFid2Ry
 yLuFqaE4k9YE1uY1+CXzPm3DmqGhFb5Xxn5LvGQ==
X-IPAS-Result: =?us-ascii?q?A0FyAgA7OtljjEYpCbBagQmBT4ItgV4uBAuFFIh+iCQRn?=
 =?us-ascii?q?S2Bfg8BAwENRAQBAYUHAoUlHgYGMgcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBA?=
 =?us-ascii?q?QECAQECBAQBAQIQAQEBAUBFhXWCNykBg38BAgMjBFIQCxgCAiYCAlcGgxGDI?=
 =?us-ascii?q?wcBq19/M4EBhHOaZoFngRQsiRGIFUOCDYEVgyo+hESDWIJnBIEImn8KgTl2g?=
 =?us-ascii?q?SUOgUaBDwIJAhFILHI3AxkrHUADCzsyCj81CwtKEBsaGweBBiooFQMEBAMCB?=
 =?us-ascii?q?hMDIgINKDEUBCkTDScmaQkCAyJiAwMEKC0JIB8HFREkPAdWNwEFAg8fNwYDC?=
 =?us-ascii?q?QMCH09yLhETBQMLFSpHBAg2BQYcNhICCA8SDwYmRA5CNzQTBlwBKQsOEQNQg?=
 =?us-ascii?q?U4EL4FiBgEpJqBlEwGCL6IHoWSDf4FSnxkygUSgcoZ5l0+iWoU5gWkBMoFcM?=
 =?us-ascii?q?xoIMIMjTgMZD445lik/bwIHCwEBAwmMIwEB?=
IronPort-PHdr: A9a23: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
 Po23kpEG354SZyxc9AnQCsakyLKKcCa9k/Uxw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Uua/dqjVNGqzkVycOqkxbi9kQ3BQXuUji2hC6mlwRA09TyVXra
 +TdZMgpH3JYVcqKRIdcL+7VpVoLUmwyXcx2+gs1NSZLW3bUQmTRr2KhLGKq1bd8m/FltK1vp
 0QC5SWZuedMbE3t7ee3OChKadG/DCcytHPuQ7B9QYVcT1X
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,261,1669071600"; 
   d="scan'208";a="46493834"
X-MGA-submission: =?us-ascii?q?MDEDYNXBWw35EG+Pzl8ZTwcFnxvMG343pzRPHo?=
 =?us-ascii?q?KskhSi0eFfKj7jl1bcAK7Z8Bt/FTqicWVGi6x/2V06mllLgOh09+IIbQ?=
 =?us-ascii?q?K4fyc1DhkZ0I7oXBvZXMHqS5lhB+Mnn1BYg9zGcitkYQqWHn33c8QvmB?=
 =?us-ascii?q?Ott8hk1ec5aICnBZqB6SYb3Q=3D=3D?=
Received: from paleale.coelho.fi (HELO farmhouse.coelho.fi) ([176.9.41.70])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 16:58:02 +0100
Received: from 91-155-255-60.elisa-laajakaista.fi ([91.155.255.60] helo=[192.168.100.137])
	by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <luca@coelho.fi>)
	id 1pMt1B-0061cT-Un;
	Tue, 31 Jan 2023 17:57:59 +0200
Message-ID: <48a02a321c06093966bc9999f9e8333f391475d7.camel@coelho.fi>
From: Luca Coelho <luca@coelho.fi>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
Date: Tue, 31 Jan 2023 17:57:57 +0200
In-Reply-To: <9f4c958a4bf370f7eb5fe49ac2be380ada6d9ac5.camel@coelho.fi>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
Subject: Re: [cocci] Searching for special function implementations with
 SmPL
Reply-To: Luca Coelho <luca@coelho.fi>
X-Loop: cocci@inria.fr
X-Sequence: 856
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/48a02a321c06093966bc9999f9e8333f391475d7.camel%40coelho.fi>

On Mon, 2023-01-30 at 12:59 +0200, Luca Coelho wrote:
> On Mon, 2023-01-30 at 11:47 +0100, Julia Lawall wrote:
> > It doesn't find the file with the definition.  You may need to give mor=
e
> > paths.
> >=20
> > I have the impression that the result is improved with
> >=20
> > -I drivers/gpu/drm/i915
> >=20
> > Maybe -I drivers/gpu/drm/i915/display is necessary also.  If you add th=
e
> > argument --relax-include-path then just -I drivers/gpu/drm/i915 may be
> > sufficient.  With that option, it will just hunt around in and under th=
e
> > various include paths for a unique file that has the required name.
>=20
> Alright! That _does_ improve things! Now I can see lots of DPLL matches
> in that file!

These files I'm trying to parse are so complex that I keep bumping into
other parsing errors.  Here's one of them:

parse error=20
 =3D File "./drivers/gpu/drm/i915/i915_drv.h", line 385, column 1, charpos =
=3D 9644
  around =3D 'for',
  whole content =3D       for ((id__) =3D 0; \
badcount: 7
bad: }
bad:=20
bad: /* Simple iterator over all initialised engines */
bad: #define for_each_engine(engine__, dev_priv__, id__) \
BAD:!!!!!       for ((id__) =3D 0; \
bad:         (id__) < I915_NUM_ENGINES; \
bad:         (id__)++) \
bad:            for_each_if ((engine__) =3D (dev_priv__)->engine[(id__)])
ERROR-RECOV: found sync end of #define, line 395


I believe the parser is getting confused by an iterator inside an
iterator's definition... I already tried to add them both with the
"iterator name" directive, but it didn't help...

Any idea what I can do about this?

--
Cheers,
Luca.
