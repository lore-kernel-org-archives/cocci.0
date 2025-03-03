Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2036AC282D3
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=bVbo8Bp188ctbON8ZulP+OSFSxe/rMczkjpmYA+ieRQ=;
  b=UjHIrfIiRlcJU4aYpDJVUl2WxB3a4i/OaoUTLkytmA+V9aS/6AZvrffy
   0Y3200Me0kofgIwL0lTmdUXJef7cPWWfjjFH8aNyaIECd6k/YMiCbuYc/
   rtSL+TwducdgiMDBd3wY4wpAQHnVNNdi0Z/VGvaE9hjZqTLu7kY16GnAW
   8=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@baylibre-com.20230601.gappssmtp.com
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="asc'?scan'208";a="211069751"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:59:03 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BEE5BE0E82; Tue,  4 Mar 2025 10:58:44 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 17AAFE0261
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 11:30:50 +0100 (CET)
IronPort-SDR: 67c584d9_ctSJwgYnRnUklBNpUQaI6o35snYJCi9FtYCaYdVMS7HdFEo
 YBdbmU1homTf6xJqT4lB1eeQP9dAaeScCKbeiMw==
X-IPAS-Result: =?us-ascii?q?A0GtAQDHg8VngSmAVdFaHgEBCxIMgggLgkSBVzMEU4RWi?=
 =?us-ascii?q?HyGU4IhA5JohVCEBoFWgSUDXgcBAwEIAwEBQgIEAQEDBIIMgnSLFwIeBwEEM?=
 =?us-ascii?q?AkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABASIZBw47hXsNg?=
 =?us-ascii?q?mIBgSSBJgEBAQEBAQEBAQEBAR0CJmQBAQEBAxIRBBkBATcBDwsUAQMjBwICM?=
 =?us-ascii?q?wEFARwGEwgagmGCZAMEohuBBUKKRHp/M4EBggwBAQbcZYEZBwkJAQqBNIFYh?=
 =?us-ascii?q?l0PCwEFbWiDeBmDfXongiiBFYMqPoRjgzuCaYEUgR9FgSQBgz2aBYUBdYhdU?=
 =?us-ascii?q?oEXA1ksAUsKNQw5cEgDgTIPgRQFNApxgguBMjoCDQKCQHAfMYQRgjeEPYMwg?=
 =?us-ascii?q?RCBY4NvghGBXQMDFhCDH3cchHyEah1AA3g9NxQbngQafIMXOoNPEEIhUiEuO?=
 =?us-ascii?q?IITF5Jvg1GwBgeEHqFfSQOXLwyTBS6YT6NahS0CCgcGESOBRDqBXHCDN08DG?=
 =?us-ascii?q?Q+OITiDQsh2QjUCOgIHAQoBAQMJgjmDCiYTTIlUgUsBAQ?=
IronPort-PHdr: A9a23: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
 h88kAY4auMopm+E3g==
IronPort-Data: A9a23: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
 G96UXt9aGF6eNcpSfeSexjbSpG67RktKET5
IronPort-HdrOrdr: A9a23:Th//jaEYnwpVoX1vpLqEaseALOsnbusQ8zAXPiFKOGBom6mj/f
 xG885rriMc9wxhPE3I9erwXpVoIkmsiKKdg7NhRYtKNTOO0ADEEKhY4YHj2j3tHDC71uM178
 ldms5FZ+EYImIXse/B4BS1V/YsqeP3kpxA7t2utUuFIzsaEp1I3kNQEwbeM0ttWWB9dPkEPa
 vZzcxaoDCtVXAebsGFCmIeX+7Fzue78a7OUFoqPVoc4g+UgVqTmdnHOind8xsUTz0n+9Yf2F
 mAvwjw5qDmiP25xhXA12nVq7BRldeJ8Lt+7IflsLlrFgnR
X-Talos-CUID: 9a23:OZiD7GCFRLZtRnz6E3Uk0l4pIZgpSX2D1ErPKVTmME9UY7LAHA==
X-Talos-MUID: 9a23:hajK2wZNdOYKwOBTujPBqnJ6a+NSyaG8FGUkyagal+ChOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="asc'?scan'208";a="110481767"
X-MGA-submission: =?us-ascii?q?MDHd5d8u5lN+XfgK6Vo2aXmzpN0SjEsrKgLRCJ?=
 =?us-ascii?q?nxcFKtQHwLBzaHawUAblw0HK1E8LsK5nFPHINVdkLnyzTJIFv8cqUaT/?=
 =?us-ascii?q?tf9s23dEdLZdwTDdeLj73HPZrXlfcD3VqXL7Ruxm9xobP8bHzh5qf1Gd?=
 =?us-ascii?q?Lm5iEp5yRt30EqdVxw7MHkxA=3D=3D?=
Received: from mail-wm1-f41.google.com ([209.85.128.41])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 11:30:50 +0100
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43995b907cfso26534955e9.3
        for <cocci@inria.fr>; Mon, 03 Mar 2025 02:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740997848; x=1741602648; darn=inria.fr;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bVbo8Bp188ctbON8ZulP+OSFSxe/rMczkjpmYA+ieRQ=;
        b=YzRrgVbsnlo0mVfEsyzMjGKBRJF8jpi4bzGChd39p7jsP6pcUPplxPoyfAMMD0nMAa
         24e7M0yVlzOuYHqfWay2aYM05d2nXClFdhEP7EPP2wdFc3nhILCgO5fwSZ7F7xuyBAqw
         TyKw0JuQ/cF5AFATXZu0InvyOWPjR0ATN3XP3/9A/FjtB08FODw+09Gv7Z8+z4MIAFwG
         PcGgYsxkPm529wJ3peAoWU4utySbTnHzHREdFTH3DS6HEQEJuqkP3WUSUgbDA2dQ6b4d
         zCvdd5gR/WI9E97KqvKLse1RROURopCSjBg6zbFnex5rJuWfaGFVxfnbK61vo+EcC/lo
         9ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740997848; x=1741602648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVbo8Bp188ctbON8ZulP+OSFSxe/rMczkjpmYA+ieRQ=;
        b=Tq3VoxBzYpaQiB0FlvgCTvJ04iLw0RflhwRPsSi594Fh10s8LpJDTJxsBJEAQjoHgM
         TiqbXMseI2JYi8+ibzsSPkio6fMm1mTk6BR1befkVtScGrLkFe1Is45T8Eoo9IGPMkV0
         rrQHJxEE7dvPmJV6pwzJhtYWdbWupJceR05Sn2BT7NDprSf277y5mJmqpfVkrTHccKur
         8nK7b5vxCiz3wOJJH/eyHM05Wd8qCH7/T1gmF2WfRzgA2yg6FqovvemgQ59qGjoL27D1
         jH5ZibBkr8DcGiOHKWke24gIwlDIB+9XuhRBwx50LOIWsiqZN7yAvHaD61r8knfrfM+1
         2W3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwPpqLcgKsGJPUgijQIu6dIa5TLSlK2ThQ0TnXJHbox7xkjmVYukBXJrKcB5gdwQpkXtFVVQ==@inria.fr
X-Gm-Message-State: AOJu0YyUwazVAPMpXnWIeFDkaGlX9wwa6YLUBhtHlYzFCG3acGfpghXa
	RJilvfRHCWPew0JTzJxweBozxB4uc2kQW6ZJAwylRE6Bu3o8EbAsg8g4ilgHvCY=
X-Gm-Gg: ASbGncuTpuk8D3HkhRBzQg/2FA3Q3eGwUaZEJNZY2zEayAWkQ6hQ9PUYyS4NBKvErun
	y8N1rGmireB1U1iRCcAuHDbUFT1yjMuAL7lKrD8kJfox6oCgVcLcfmHS9+sGcRnoNujfYc9rTD4
	cXjuew6mT2bDquJbXgjwQBpVrYMc1qr0SL31Cw2LYnGLujgVgpiypwO+zV3RRG0cfSRt5IBQgk1
	h6/5/sSS+N3gImQFuiMRMLAsUS9H8bu6dGV3+uIlSRN9pMRnv8M88YM3y8qSQGTNhv3laWWgy6y
	bG/BveteSJP9etxvPKHaBmSPwIeH9h8OIbepSxBVC3ScLIyQy/zaFbBblxGTJQiPzTC+zi/e7vw
	EpRY2lC502ie0nFZLXko551IxYQ==
X-Google-Smtp-Source: AGHT+IH9VAhW9tJPNhTeqngSyn+en5grFHwVORQOd7xIovLbkp/2JtR0igU6P17pWqd3YNtGaZA2uw==
X-Received: by 2002:a05:600c:3513:b0:439:9f42:c137 with SMTP id 5b1f17b1804b1-43ba66e218emr116219575e9.11.1740997848443;
        Mon, 03 Mar 2025 02:30:48 -0800 (PST)
Received: from localhost (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b737043aasm153133835e9.14.2025.03.03.02.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 02:30:47 -0800 (PST)
Date: Mon, 3 Mar 2025 11:30:46 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, 
	kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Antonino Daplas <adaplas@pol.net>, Helge Deller <deller@gmx.de>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Yihao Han <hanyihao@vivo.com>, cocci@inria.fr, 
	LKML <linux-kernel@vger.kernel.org>
Message-ID: <hwk2nf62owdo3olxrwt5tu7nwfpjkrr3yawizfpb3xn6ydeekx@xwz7nh5ece2c>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <86551e6f-d529-1ff6-6ce6-b9669d10e6cb@web.de>
 <3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de>
 <ugymllbkcsg22ffgyofvkquh5afbvoyv2nna5udmy3xfhv2rjz@jhgghzldzm4u>
 <eebf8c0c-7a6a-405f-aaab-2a8a8c2bd91f@stanley.mountain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w37fhouumevfpx4n"
Content-Disposition: inline
In-Reply-To: <eebf8c0c-7a6a-405f-aaab-2a8a8c2bd91f@stanley.mountain>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH RESEND] video: au1100fb: Move a variable
 assignment behind a null pointer check in au1100fb_setmode()
Reply-To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
X-Loop: cocci@inria.fr
X-Sequence: 2510
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/hwk2nf62owdo3olxrwt5tu7nwfpjkrr3yawizfpb3xn6ydeekx%40xwz7nh5ece2c>


--w37fhouumevfpx4n
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND] video: au1100fb: Move a variable assignment
 behind a null pointer check in au1100fb_setmode()
MIME-Version: 1.0

On Mon, Mar 03, 2025 at 01:08:29PM +0300, Dan Carpenter wrote:
> On Mon, Mar 03, 2025 at 10:19:06AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > Hello,
> >=20
> > On Sun, Mar 02, 2025 at 07:02:12PM +0100, Markus Elfring wrote:
> > > From: Markus Elfring <elfring@users.sourceforge.net>
> > > Date: Thu, 13 Apr 2023 21:35:36 +0200
> > >=20
> > > The address of a data structure member was determined before
> > > a corresponding null pointer check in the implementation of
> > > the function =E2=80=9Cau1100fb_setmode=E2=80=9D.
> > >=20
> > > Thus avoid the risk for undefined behaviour by moving the assignment
> > > for the variable =E2=80=9Cinfo=E2=80=9D behind the null pointer check.
> > >=20
> > > This issue was detected by using the Coccinelle software.
> > >=20
> > > Fixes: 3b495f2bb749 ("Au1100 FB driver uplift for 2.6.")
> > > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> >=20
> > Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> >=20
> > Should also get
> >=20
> > Cc: stable@vger.kernel.org
> >=20
> > to ensure this is backported to stable.
>=20
> It's not a bugfix, it's a cleanup.  That's not a dereference, it's
> just pointer math.  It shouldn't have a Fixes tag.
>=20
> Real bugs where we dereference a pointer and then check for NULL don't
> last long in the kernel.  Most of the stuff Markus is sending is false
> positives like this.

I thought a compiler translating the code

	struct fb_info *info =3D &fbdev->info;

	if (!fbdev)
		return -EINVAL;

is free (and expected) to just drop the if block. I wasn't aware that
this only applies when the pointer is actually dereferenced. Testing
that with arm-linux-gnueabihf-gcc 14.2.0 seems to confirm what you're
saying.

Thanks for letting me know. With that learned I agree that the Fixes tag
should be dropped (and Cc: stable not added).

Best regards
Uwe

--w37fhouumevfpx4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfFhNMACgkQj4D7WH0S
/k5nPwgAstc+P1JFVJcAu2QOmJtpmMvfsusSqi09w0aEnPTXJ7eWgHQj2HCmKJ2A
tpsfvf8kA5JHjm0dDyhnnr8MT+SSDNDnXQX6Ql4rFwC61a+xBBYE+68xUYe5XyHF
98yWGWsnGV5liC6rrj5PcRpur1bml3Wj3UEbsTiGyaTNzOAbQyw8ygwvkHH60sIe
XtvnKO/KgD8nSdHP8GE8uPv//BbKJmM4n/Tnvm9t4W9IeVnwC9RedLmElvgbOimt
YVRPNPNG/KDOW0VIfUv1zmx/xXpnbqUhQmls/wYjc7ZF85CYgjm7eFm3xKhfquTC
sEGbyzVTmAU0THTQ7X7Odz9uKL8q0A==
=j/U6
-----END PGP SIGNATURE-----

--w37fhouumevfpx4n--
