Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50D9C433F5
	for <cocci@archiver.kernel.org>; Thu, 19 May 2022 12:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:from:cc:to:date:message-id:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=zCS0kJvJL8X/23um0veR9CkYFtWeGtJdAH5PzEYlJ24=;
  b=W92VHDYVuG2ZUkh0PLBgNEgF7+GdRVkYkyLuvWJQQBsDwvUa2YN7VVnt
   toCKhjatM3/UeFsNTQNvl3lZnhy3Bm8XsiGsQZESmtmEq/ZvvoqrV3mjR
   g/4c1j4wQU/MX+TU95nnwFGtPvTnV8sMekO2450H3YNl4aRC0d/UJxPll
   c=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="5.91,237,1647298800"; 
   d="scan'208";a="37116910"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 May 2022 14:19:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 43FCAE4374; Thu, 19 May 2022 14:19:03 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id F1309E001A
	for <cocci@sympa.inria.fr>; Wed, 18 May 2022 22:32:46 +0200 (CEST)
IronPort-SDR: 6mxH1Fs/2gXVH0L1kOaOIHQ0Dwykap9yCo52gMok3QZgrh+/iGc9OC1t7eELDRI7Xnr6dV918u
 RnOFyf+1OM7Zj+ldvadYPzghA11g6rXJIGlx0Ey7rIeqQ68nbsS5vjhEyRSkXEoOGVA+rVmdKR
 EB8LR4EL7uelXV1gRjem22o933OWtngzjESQd9tCyOstd2yY7waER7sVz8ARhEQzzWiTnPXin1
 H7NedHaMC/vMSfWu6lM9MS2IAsxjaKoQo7NrGXN53ME14jVVxXoi/WT4Lb5cwf5ZM94XvqmiMo
 vwprsdQ7PWekYuPTDSdqN7NF
X-IPAS-Result: =?us-ascii?q?A0AjAADLV4VikEtEKJFaHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YIjgVMtBAtDhE6JAIgPlxSFUIF8CwEDAQ1CBAEBhQIChT8CHQcBBDIHDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEBAQEWCQ0REA4FPGRog?=
 =?us-ascii?q?U+BdAs0DYI1KQGDYwEBAQECASMbAgEBNwEPCxgCAgUhAgILAjoQBgGDD4J0J?=
 =?us-ascii?q?wGsKnqBMYEBgggBAQaGCYFcCYEQLIc+glkvhBsnHIFJRIEVNoJEMD6BD4NKg?=
 =?us-ascii?q?0E3gi6VSh07Axw0OxKBIXEBCAYGBwoFMgYCDBgUBAITEU0GHQITBQcKBhYOF?=
 =?us-ascii?q?BwSEhkMDwMSAxEBBwILEggVLAgDAgMIAwIDIwsCAxgJBwoDHQgKHBIQFAIEE?=
 =?us-ascii?q?x8LCAMaHy0JAgQOA0MICwoDEQQDExgLFggQBAYDCS8NKAsDBQ8PAQYDBgIFB?=
 =?us-ascii?q?QEDIAMUAwUnBwMhBwsmDQ0EHAcdAwMFJgMCAhsHAgIDAgYXBgICGVgKKA0IB?=
 =?us-ascii?q?AgEGAQeJRMFAgcxBQQvAh4EBQYRCQIWAgYEBQIEBBYCAhIIAggnGwcWGR0ZA?=
 =?us-ascii?q?QVdBgsJIxYGLAsGBQYWAyZSKAUOKAEbApdOgSmCIzuWE4xTni2DV59xGjGWU?=
 =?us-ascii?q?JIJLZEMhS4gpwqBaAEygVszGggoCIMjTgECAQINAQICAwECAQIJAQECjh0MD?=
 =?us-ascii?q?QkViE+FaiE0OwIGCwEBAwmPHwEB?=
IronPort-PHdr: A9a23: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
 YqW/J8=
IronPort-Data: A9a23:iqUVoaPKgvyc0DHvrR2/kcFynXyQoLVcMsEvi/4bfWQNrUonhDZVz
 jQWXGDSM/qIZ2WmLd0kaIq0/EgGv8fWy99qHXM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8kk/vgqoPUUIYoAAgoLeNfYHpn2EsLd9IR2NYy24DkWlPV4
 7senuWGULOb824sWo4rw/nbwP9flKyaVOQw4zTSzdgS1LPvvyF94KA3fcldHFOkKmVgJdNWc
 s6YpF2PEsw1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB2Yssx7x
 tBdtqaeQF5uM/DHn/s+aDpXRnQW0a1uoNcrIFC2tNfV1ErbaXDhhfZjFkc7Ocsf4Okf7WNmr
 KBFbmxVKE7Twb3rqF64YrEEasALN8PsLY83uXx6yzzdS/E8TvgvRo2Ru44Jhmlq2KiiG97DW
 8RHMTVVdS/sciRAH1lIBb8Fs+G30yyXnzpw8wvO/fdvuwA/1jdZ1LHyOd7RUs6LQM9PlwCZo
 HjH9iL3GHkyP9uUwjut6WOpnuaJnCXhWYtUGqfQyxJxqFSW3SoIDwAMXlb9ovSjjEO6HdVFJ
 CT45xbCs4Aj2VChQNztXCeWqSfDs0MXXMVzKM41vVTlJrXv3y6VAW0NTzhkYdMgtdMrSTFC6
 mJlj+8FFhQy6ubKFCP1GqO88WPjZnV9wXoqP3dscOcT3zX0iKcX5v4lZv9mC7K4lNH8HFkcK
 BjT9HFk71n/pegMzbm7tXDAhzaloJShc+LYzgzSRSS+6R5jb4PjZIGy71Xfq/FaI+51r2VtX
 lBbwaByD8hUV/lhcRBhps1QRdlFAN7YaFXhbaZHRcVJythU0yfLkXpsyD9/Plx1Fc0PZCXkZ
 kTe0SsIusIJbCLwN/MrM9/tYyjP8UQGPYm7PhwzRocTCqWdiCfalM2TTRDJgzy1+KTSufpmZ
 f93jvpA/V5BUP8/kWLuLwvs+acizSMz2SvTQovnpylLIpLDDEN5vYwtaQPUBshgtfPsiFiLr
 753apXboz0CAbaWSneMq+Y7cwtVRUXX8Liq96S7gMbYelI+cIzgYteNqY4cl3tNxPoJx7+Vp
 CDkAye1CjPX3BX6FOlDUVg7AJuHYHq1hS5T0fUEMQn61n49T5yo6atDJZI7caN+rL5gwORyQ
 v1DfN+PW6wdRjPC8jUbTJ/8sI0yKUv03FreZ3KoMGolYpptZw3V4du4LAHhwy8DU3isvswkr
 rz8iw7WGMJRRwlrAMvMRuioyle94SoUlO5oBhOaIdRJfkjoto9wJHWp3PMwJsgNLzTFxyebh
 1vJXk5A9bGVrtZsotfThK2Co4O4KMdEHxJXTzvB8LK7FSjG5W7/k4VOZ+CFIGLGX2Tu9aT+O
 OhYwq2uMPADm1oW4YNwH6wxlPA34sCpvLhH1A9pWnbGdVKmDvVnOHbfhZtDsahEx7l4vwqqW
 xLSpYYDYeXRYM61QkQMIAcFb/iY0a1GkDfl6/locl7x4zV6/ebaXEgObQOAjjdRcOl8PI8/m
 75zscsNrRe4lwAhP5CFgzpS+mDKKWYPCv11upYfCY7tqwwq1lASPMODU3emuMmCO4dWL00nA
 j6In66e1b5S8UzPLigoHn/X0OsB2JkDtXimFrPZy4hlRzYEuhM24PGV2T0yVUJOyQhd2O81O
 WVxMUBxY6KU8F+EQSSFs3+EQ2l86N+xoyQdCGflUEXaQlOuW2iLK3cyUQpI1F5M6HpSJ1C34
 5nBoFsIkl/WkAXZ3SYoX0Nh7fv5QrSdM+EEdN+PR6y4InXxXdYpbmJCq4bFR9sLzP7dXHH6m
 NQ=
IronPort-HdrOrdr: A9a23:CVFTlKCLnxRiqIzlHemp55DYdb4zR+YMi2TDGXoBLCC9Ffb3qy
 nOppgmPHrP5Qr5N0tQ/uxoVJPwI080sKQV3WBzB9iftXfdyRKVxehZhOOIqQEIWRefygc379
 YCT0ERMqyVMbE3t7ed3DWF
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,235,1647298800"; 
   d="scan'208";a="36992626"
X-MGA-submission: =?us-ascii?q?MDGVev+i4nlNMTmTcI9njKaQY2xl0nc2m67MjB?=
 =?us-ascii?q?Xfm9+CqVCT2l3a6uGPy4Y4HWFAnWUUIK5+EZ++/mtPASBFONGdP3mIFD?=
 =?us-ascii?q?j5sTJRAJuTdWtf4E3/m+pW63A+M61UTfa0F6pO/KMAPUzCJQmt3ubQWF?=
 =?us-ascii?q?BDAKsu9IVSoHgHhHR02DK26A=3D=3D?=
Received: from ams.source.kernel.org ([145.40.68.75])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 22:32:42 +0200
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id C0F5DB820BF;
	Wed, 18 May 2022 20:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713D0C385A9;
	Wed, 18 May 2022 20:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1652905960;
	bh=lQY8rBKqCR2LcVnBZJjAqb/f37nH3O7VSD5+PGGpbYQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=IYyBdnAx6e1mBYKgv9xh9B2DOZYlWH8QlqEhbGkx4EAOYau34Gc15k5Z/5qXJ3UtF
	 BYqL1BMubT59HZUcHWqqwuq+cC37fgaV7sF1KV7R0gD3wKG2zbs20WGix2qdUkl4zU
	 CnT78qYivToAGPFDgJNPktx7/gcRjuhOeETnYUHCGl95HbCSiwS4wCSh9rYH3AjJs/
	 YnOHWkqcUgcb6iBdvrusVBqca8INXg56eFd5Wx3wPT3YnFIU2IOAYfHIpXdNc8NHFA
	 RAGm5udF6YjqXyyKzFbqS82wa4w/xMdfk+K3gwK1jnUx2+bIjTpe9eF6MTqpcJhnY+
	 Ov41Xzr8MDdsw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <TYYPR01MB7086FB249443BFFB382BE006F5D19@TYYPR01MB7086.jpnprd01.prod.outlook.com>
References: <20220517133556.6934-1-phil.edworthy@renesas.com> <20220518183314.112E7C385A9@smtp.kernel.org> <TYYPR01MB7086FB249443BFFB382BE006F5D19@TYYPR01MB7086.jpnprd01.prod.outlook.com>
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org <linux-clk@vger.kernel.org>, cocci@inria.fr <cocci@inria.fr>
To: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Phil Edworthy <phil.edworthy@renesas.com>
Date: Wed, 18 May 2022 13:32:38 -0700
User-Agent: alot/0.10
Message-Id: <20220518203240.713D0C385A9@smtp.kernel.org>
X-Validation-by: julia.lawall@inria.fr
Subject: RE: [cocci] [RFC] coccinelle: Add test for unnecessary check before
 calling clk_disable_unprepare()
Reply-To: Stephen Boyd <sboyd@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 397
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/20220518203240.713D0C385A9%40smtp.kernel.org>

Quoting Phil Edworthy (2022-05-18 12:05:25)
> On 18 May 2022 19:33 Stephen Boyd wrote:
> >=20
> > Skipping the check for NULL makes sense to me because a NULL clk pointer
> > is still a valid clk. I'm not so sure about IS_ERR() though. Do the
> > various implementations of clk_disable() and clk_unprepare() check for
> > IS_ERR() there?
>=20
> clk_disable_unprepare() just calls clk_disable() and then clk_unprepare().
> This consists of:
>=20
> void clk_disable(struct clk *clk)
> {
>         if (IS_ERR_OR_NULL(clk))
>                 return;
>       ...
>=20
> and:
> void clk_unprepare(struct clk *clk)
> {
>         if (IS_ERR_OR_NULL(clk))
>                 return;
>       ...

That is the implementation in drivers/clk/clk.c correct? What about the
other implementations of clk_disable()

	$ git grep "void clk_disable("
	arch/arm/mach-omap1/clock.c:void clk_disable(struct clk *clk)
	arch/m68k/coldfire/clk.c:void clk_disable(struct clk *clk)
	arch/mips/bcm63xx/clk.c:void clk_disable(struct clk *clk)
	arch/mips/lantiq/clk.c:void clk_disable(struct clk *clk)
	drivers/clk/clk.c:void clk_disable(struct clk *clk)
	drivers/sh/clk/core.c:void clk_disable(struct clk *clk)

>=20
> i.e. there is no point in checking the clk ptr before calling
> clk_disable_unprepare() like this:
>=20
> if (!clk)
>      clk_disable_unprepare(clk);
>=20
> or any of these variations:
> if (clk !=3D NULL)
> if (!IS_ERR(clk))
> if (!IS_ERR_OR_NULL(clk))
>=20
> I've had review comments before saying that the check is unnecessary, so
> thought it would be good to catch it with coccinelle.

Maybe those drivers never run on these architectures that haven't
converted over to the common clk framework (i.e. drivers/clk/clk.c).
