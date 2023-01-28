Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2724C27C76
	for <cocci@archiver.kernel.org>; Sat, 28 Jan 2023 09:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=IteiP6sYXpXaMKVfr1qdQ2tTXYW7uhJZWhhCkT0My7g=;
  b=vikiAe9gTpbXL9ThQf/jlx+wyQJptpqz9ZzU2jJ48M27olbUWB7tu1UD
   LLEaJbANvUZcZ0rp0NPmiCi/9UWzxDSjIB431AkTDacN9bX6uihFHq19j
   4o+Cucz5UQ2oP6pj34GQyPMT22cCzW109FTunjaQcF4L4plIF4KQTkKW6
   s=;
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
   d="scan'208";a="89860322"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2023 10:50:03 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1066EE0367; Sat, 28 Jan 2023 10:50:03 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5BE6AE027E
	for <cocci@sympa.inria.fr>; Sat, 28 Jan 2023 10:25:08 +0100 (CET)
IronPort-SDR: 63d4e9f3_1D77MX8UFNaRezFchJq19+MpFzmPK9+YLpdDz0WbtSdKHxs
 tiont5+AIvT2s71mEFAuSgfh6GcFklnFiF9MXow==
X-IPAS-Result: =?us-ascii?q?A0H0BAAN6dRj/0YpCbBaHgEBCxIMQIN8gV4rAwQLhRSIf?=
 =?us-ascii?q?oghAxGdQIFqDwEDAQ1EBAEBhQcChSYeBgY0EwECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgQEAQECgQYThXWCNykBg38BBSNWEAsYAgIRFQICVwaGNAcBq?=
 =?us-ascii?q?TWBMoEBhHOaZoFngRQsiRGIFUOCDYQ/PoN9Rz+DGYJnBIEFA5FqJ4hWCoE5d?=
 =?us-ascii?q?4ElDoFGgQ8CCQIRSCxCNwMZKx1AAws7Mgo/NQsLSisaGweBBiooFQMEBAMCB?=
 =?us-ascii?q?hMDIAINKDEUBCkTDScmaQkCAyJfBQMDBCgtCSAfBxURJDwHVjgFAg8fNwYDC?=
 =?us-ascii?q?QMCH1ByLhETBQMLFSpHBAg2BQYcNhICCA8SDwYmQw5CGB80EwZcASkLDhEDU?=
 =?us-ascii?q?IFNBC+BXQoGKSaee0QBgQ4BgXBaKy3CdoN+gVKfGDKBRKdrl0+oEIF5JoFZM?=
 =?us-ascii?q?xoIMIMjTgMZD44sFpNDP28CBwsBAQMJjCMBAQ?=
IronPort-PHdr: A9a23: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
 aVTMqtrU3ljHsTehi4CDScQmibNaIiVpUXkkhA=
IronPort-Data: A9a23:OxBd2K1FomPInmS1mPbD5ch1kn2cJEfYwER7XKvMYLTBsI5bpzwCn
 2EdXGmPa67bNzf3f9EgYIi28EkA7MCGnIRqTgJu3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/vOH9IQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/b3ZRn0hFaYDkpOs/jY8Eo17Kyr0N8llgVWic5j7Ae2e0Y9V8p3yZGZdxPQXoRSF+imc
 OfPpJnRErTxon/Bovv8+lrKWhViroz6ZWBiuVIKM0SWuSWukwRpukoN2FXwXm8M49mBt4gZJ
 NygLvVcQy9xVkHHsLx1vxW1j0iSlECJkVPKCSHXjCCd86HJW1i0nPBrF2UaB4Yd3+0pPnB03
 t8JOglYO3hvh8ruqF66YudlnMEjK9TwMcUUvXxkzTafA/dOrZLrGvqUo44egG522Zgm8fX2P
 6L1bRJrcR/JSxZIN1MXD9QwnY9Eg1GvIm0F+A/M+sLb5UDM/glf7LrjPeHEIIzTStQFo3+5t
 lnvqjGR7hYyb4XClmHeqRpAnNTnmSrkUYYWPK+58/RwiRuSwHYSAVsYTzOTqv6ygU+WQMNaM
 0VS+yw0rKF0+lbDczXmdwWxpHONuhNaUN1dF+09rg+MokbJ3+qHLktcETtEc/gKjsQzYDd06
 U6ztPD4FwU65dV5Vkmh3ruTqDqzPw0cImkDeTIIQGM5Dz/L8NhbYvXnHowLLUKlsjHmMWyon
 GrR8UDSk51K1JVQh/XTEUXv3mr0zqUlWDLZ8S37cwpJBCtDeYKiY5e04FTHhRqrBN7GEgHe1
 JTos/Se8foPC56MnUSwrAglBLit6v+BPXvXhlNrH55n+TXFF5+fkWJ4u2gWyKRBaJ5sldrVj
 Kn741s5CHh7ZSbCUEOPS9jtY/nGNIC5fTgfatjab8BVfr96fxKd8SdlaCa4hj6yzBhwzftlZ
 87AIK5A6Er274w3lVJaoM9Ni9cWKtwWnjy7qW3TlU/9iebEOhZ5t59VbgXUNojVE59oUC2Oq
 osAbJDRo/mueO3zfjvR/JRbKlYOLH42TZ/zocw/SwJwCloOJY3VMNePm+9JRmCTt/kNzr+gE
 7DUchQw9WcTclWbc1rSMCo5NOK0NXu9xFpiVRER0Z+T8yBLSe6SAG03LvPbpJF3q7Ax/u0+V
 PQfZcSLD9JGTzmNqXxXboDwoMYmPF6njB6HdXjtKjUuXY9SdyqQ8P/dfyzr6HYvCAizvpAAu
 LGO7F7QbqcCYAVAN/zoTsyT4Wm/h0VAp9IqbXD0eoFSXG7O7LlVLzfAi65rAsMUdjTG6Dio9
 yeXJhY6p+OXnZQ834nUt6WHrqOCMeh3LmxFFUb1sJe0Mij7+DK44IliCeynQxHUZFnWyo6DO
 9pH7qvZHqUcvVBot4FcLe5a/Zgm7YGym44AnxVWInrbSn+KVJViGyCi9utSvPRvwrR5h1OHa
 niX8IMHBYTTadLXK39PFg8Lde/Z6Oo1nAPV5vELIEnXwi970b6EcEdKNSm3ly1vA+ppAbwh3
 NselpYa2y6nhjouF+S2vCRe2mCPD34HCqscps47Bq3vgVEV0V1sW8HXJRL3x5CtUO9yFHcWD
 AWav4f4vIQE9HH+KyIyMVPvwdtigY8/vUEW7V0aeHWMtNn3pt42+xxz8z5tcB9c4UVa4edwO
 0xAFU58FYOR9RhG2elBWGGNHVlaJRu7o0be9XoApFf7fWKJCFPfDTcYF76W3UY792l8QGBqz
 IuAwjy4bQewLdDD4CQifGVE9drhdIVV3S/fkpmFG8+lIcELUQD9iPXzWVtS+grVOuJvtkjpv
 uIwwf1Rb5f8Pisuo6EWLYmW+LATaRKcLlx5XvBT0/IVLF7YZQ2N92CCG2KpduNJAs76w0uyJ
 shtB8BIDhqFxHmvqBIfDvUyOLNapqMiy+cDXbLJHlQ4lYWjgABni7/u0xTvpXQKRoxumPktK
 4mKeDOlFHeRtERumGTMjZdlP1i4atxdYwen4vKHy7gLHcg9q+hDIVwA17i1m163MwJX2Q2ek
 y2eRq3Rzs1kkZ9Nmam1GIp9JgyEE/HBf8XWzxKWrPFPcsLpM+3Ckyg3u2vXFV1aEpVJUusmi
 InXlsD82X30mYofUkfbqsGnLLZI78DjZ9hnGJv7A1cClBTTRfK2xQUI/l25Dpl7kNl9wM2Db
 CngYeuSce8lYfts9Ed3WQN/TSlEU7/Wa53+rxyTt/6PUxgR8TLWJeOdqEPGUztpST8qCbbfV
 CnE4vqg34UN5sAEThoJHOpvDJJEMUfuE/luPcH4sT6DSHKkmBWes7/ljgAt8izPFmLCKsvh/
 JbZXVLrQXxeYk0TIA1x6OSefyH7DUqRRcE+d1gY+9lrkD38B2kLKeQad5sHYn2Rfuoey7mgD
 AwhrkN7Yck+YdiAWR777dDjWUGRB4Ti/zs/yiMBpyuphuTfOG9EKLBm+yNg5DF4e1MPCQ1hx
 c42ohXNA/R6/n2lqSv/KBB2bSeLC842Hk41xH0=
IronPort-HdrOrdr: A9a23:dEpPj606UYhuiPnecsmfeAqjBI0kLtp133Aq2lEZdPWaSKOlfq
 eV7ZYmPH7P+VUssR4b9+xoVJPsfZqYz/9ICOoqTNOftWvd0ldARbsKheDfKn/bexEWndQtrZ
 uIHZITNDS9NykesS/j2njeLz87+qjgzEm3v5am80tQ
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,253,1669071600"; 
   d="scan'208";a="89858517"
X-MGA-submission: =?us-ascii?q?MDFm84v3AKhA34tU6kWShOniWwzM1j5DnIzeg8?=
 =?us-ascii?q?d1hw1sGtOTUf2TTcKOndaIYF6tualOwl1s9LEztOAs2uA0c3VzEGrhNl?=
 =?us-ascii?q?Mc9ssOWby3u/KEJjTBf1BJv1eKUAhQzB68H3JKpvRwXeQg0TsQ+InC2h?=
 =?us-ascii?q?rzPZaiJlbHdtG467kruOhswA=3D=3D?=
Received: from paleale.coelho.fi (HELO farmhouse.coelho.fi) ([176.9.41.70])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 10:25:07 +0100
Received: from 91-155-255-60.elisa-laajakaista.fi ([91.155.255.60] helo=[192.168.100.137])
	by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <luca@coelho.fi>)
	id 1pLhSL-005ym7-2d;
	Sat, 28 Jan 2023 11:25:06 +0200
Message-ID: <81b7faa1de8fcc932dc59403b5bf96aa6f204a6f.camel@coelho.fi>
From: Luca Coelho <luca@coelho.fi>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Date: Sat, 28 Jan 2023 11:25:04 +0200
In-Reply-To: <alpine.DEB.2.22.394.2301281015360.2822@hadrien>
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>
	  <alpine.DEB.2.22.394.2301272148570.4094@hadrien>
	 <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi>
	 <alpine.DEB.2.22.394.2301281015360.2822@hadrien>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Nested macros
Reply-To: Luca Coelho <luca@coelho.fi>
X-Loop: cocci@inria.fr
X-Sequence: 827
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/81b7faa1de8fcc932dc59403b5bf96aa6f204a6f.camel%40coelho.fi>

On Sat, 2023-01-28 at 10:19 +0100, Julia Lawall wrote:
>=20
> On Sat, 28 Jan 2023, Luca Coelho wrote:
>=20
> > On Fri, 2023-01-27 at 21:52 +0100, Julia Lawall wrote:
> > >=20
> > > On Fri, 27 Jan 2023, Luca Coelho wrote:
> > >=20
> > > > Hi,
> > > >=20
> > > > I've been struggling with a change I want to make, so I hope someon=
e
> > > > can help.
> > > >=20
> > > > Basically I have something like this in the code:
> > > >=20
> > > > /* regs below are bits 15:0 */
> > > > #define _MIPIA_HSYNC_PADDING_COUNT     (_MIPI_MMIO_BASE(dev_priv) +=
 0xb028)
> > > > #define _MIPIC_HSYNC_PADDING_COUNT     (_MIPI_MMIO_BASE(dev_priv) +=
 0xb828)
> > > > #define MIPI_HSYNC_PADDING_COUNT(port) _MMIO_MIPI(port, _MIPIA_HSYN=
C_PADDING_COUNT, _MIPIC_HSYNC_PADDING_COUNT)
> > > >=20
> > > > As you can see, these macros assume that the calling functions have=
 a
> > > > local called dev_priv, and I want to fix that.
> > > >=20
> > > > So, I'm trying to find all users of macros that have this construct=
.
> > > > My problem is matching the nesting in the macros.
> > > >=20
> > > > I have tried this:
> > > >=20
> > > > @macros_noargs@
> > > > identifier m;
> > > > expression e =3D~ "dev_priv";
> > > > @@
> > > > #define m <+...e...+>
> > > >=20
> > > > @nested_macros@
> > > > identifier macros_noargs.m;
> > > > identifier nm;
> > > > @@
> > > > #define nm(...) <+...m...+>
> > > >=20
> > > > @@
> > > > identifier nested_macros.nm;
> > > > @@
> > > > -nm
> > > > +foo
> > > >=20
> > > > (this last rule is just for testing if anything is matching, obviou=
sly)
> > > >=20
> > > > But the "nested_macros" rule doesn't seem to work.  Does anyone kno=
w
> > > > how I can solve this?
> > >=20
> > > I think that it works already.  If you add the following code to the =
.c
> > > file, then the call gets changed:
> > >=20
> > > int main() {
> > >   MIPI_HSYNC_PADDING_COUNT(12);
> > > }
> > >=20
> > > I think that the problem is that a rule that replaces an identifier b=
y
> > > another doesn't match a macro definition.  Is that actually the preci=
se
> > > thing you want to do?  Or do you want to do something with the uses o=
f the
> > > macro.
> >=20
> > This is the initial thing I want to do:
> >=20
> > @@
> > identifier nested_macros.nm;
> > function f;
> > identifier dev_priv;
> > expression e;
> > @@
> > f(...) {
> > 	...
> > -	struct drm_i915_private *dev_priv =3D e;
> > +	struct drm_i915_private *i915 =3D e;
> >=20
> > 	<+...nm(...)...+>
> > }
> >=20
> > And it indeed works with a handcrafted file for testing (attached as
> > i915_cocci_test.c), but it doesn't work IRL, for instance in the
> > drivers/gpu/drm/i915/display/vlv_dsi.c file in the kernel (also
> > attached)...
> >=20
> > I would expect there to be a match in the static void
> > bxt_dsi_get_pipe_config() function...
>=20
> To match the function, the semantic patch has to be able to see the macro
> definitions.  They are not in the .c file.  Maybe you need a command line
> argument like --all-includes (take into account all of the files mentione=
d
> with #include, but not what they include) or --recursive-includes.  You
> can give a search path if needed with -I.
>=20
> You can use --debug to get some information about what rules are being
> matched successfully.

Thanks a lot, Julia! I'll try to play around with the includes.

--
Cheers,
Luca.
