Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3141C282E5
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=gcNOncFZdUs+yNeq8pr7D0R7rzSHI/mcL2lr8MRssiE=;
  b=GVIttRLsLml/CJ9QkrIYsqwDbzHfnZ1tw7nmlYMeXlsEVLDQsH5CF0xd
   Jn2VeovFSkctq3VAGrcTCxv7Sya/jgHC+ZJIQZ/MVJQGnkhwLn1c7dfMe
   7tnBTrSOLgVLgMS0TWafI2sgGG09zIf46oeC+39pBXBvgETrNxAKFoRPq
   c=;
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
   d="asc'?scan'208";a="211069443"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:58:57 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7418EE0EAC; Tue,  4 Mar 2025 10:58:44 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B2824E0260
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 10:19:10 +0100 (CET)
IronPort-SDR: 67c5740e_pDZswRj+ZynVFQyTpxif4aG6KtaGc0pH9NOPibBiLCUIXC/
 9rRuj754yPO0rG2n17TBJW5yI1/LvqvDBtsoNWw==
X-IPAS-Result: =?us-ascii?q?A0ETAACDc8VngS+AVdFaHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBgkOBVzMEU4RWiB1fhlOCIQOSaIVQhAaBVoElA14HAQMBCAMBAUICB?=
 =?us-ascii?q?AEBAwSCDIJ0ixcCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQEiGQcOO4V7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAiZkAQEBAQMSE?=
 =?us-ascii?q?R0BATcBDwsUAQMjBwICMwEFARwGEwgagmGCZAMEog+BBUKKRHqBMoEBggwBA?=
 =?us-ascii?q?QbcZYEZBwkJAQqBNAGBV4ZdDwsBBW1og3gZg316J4IohD8+hGODO4JpgRSBH?=
 =?us-ascii?q?4FpAYM9mgWFAXWIXVKBFwNZLAFLCjUMOXBIA4EyD4EUBTQKcYILgTI6Ag0Cg?=
 =?us-ascii?q?kBwHzGEEYI3hD2DMIEQgWODb4IRgV0DAxYQgx93HIR8hGodQAN4PTcUG54EG?=
 =?us-ascii?q?nyCKm06g09zUiFmgiqSbzyDFbAGB4QeinSWa0kDly8MkwUumE+jWoUtAgoHB?=
 =?us-ascii?q?hEjgUQ6gVxwgzdPAxkPjiE4g0LIZUI1AjoCBwEKAQEDCYI5gwomE0yJVIFLA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 Rkz2FMWXA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:o+T++KAF2hcvQsnlHelp55DYdb4zR+YMi2TDGXoBLyC9Vvbo6/
 xG/c5rqCMc7Qx6ZJhOo6HkBEDtewK5yXcx2/hvAV7AZnidhILLFvAb0WKK+VSJcFydygce79
 YaT0EXMqySMbEQt7eC3ODXKadG/PC3tI+vnvnX1HpgQEVHbKt6/x5lBgvzKCFLbTgDK558Op
 T03KR6TvmbFkj/rP7XOpDIZYn+ThTw9K7bXQ==
X-Talos-CUID: 9a23:K/lHCW1rRdhtCBggOa+HWrxfOZgKYkfd61vpJF63Ezo2baaSW1KNwfYx
X-Talos-MUID: 9a23:xT3mLAtV/3Xf/tELas2nvW84EtxG3aCUC3tSsZEAvu26HBNgJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="asc'?scan'208";a="210815950"
X-MGA-submission: =?us-ascii?q?MDHlGySTVWVn0JNRtHA0w4PWmxE8Sw4Be3xsaQ?=
 =?us-ascii?q?GEdCSC17tdg8uqIz8hY+W4X4lzmm6oMohm+V5qouX0nhIfWc5eRQ0fUw?=
 =?us-ascii?q?+j9XcyXh0dY74ZWwSHc4HRkrcNWxzch0uYArJ9q4hWvEql1zjf7ofzsb?=
 =?us-ascii?q?A7VhFUxu/uF3GXyvy6K4bBiA=3D=3D?=
Received: from mail-wm1-f47.google.com ([209.85.128.47])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 10:19:10 +0100
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43690d4605dso26193245e9.0
        for <cocci@inria.fr>; Mon, 03 Mar 2025 01:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740993549; x=1741598349; darn=inria.fr;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gcNOncFZdUs+yNeq8pr7D0R7rzSHI/mcL2lr8MRssiE=;
        b=FL2XjfjCvLiRzhppYn/z3fvYr5e/Xf2LiHSCzExnh0MPO1NrH5FpVJYt2yfEWtsSJs
         SS9fJjuDmDjgjZuN2ftTGDE5pqYF4IpC8tMzPGpHW1oVoQAhgTDJ1p9JzeqMAdHUkTLm
         M+ocJuEAbKQ6wwFhsVcujCnAy1QoWKJUneC1l6qrlZnjAwbMCwewZi5cd6BkjjN+U0wD
         q5/QM8NSU7XJYGoZYkVN3vDowh8Dernc1NmQJuZrp2/p2L9wU9hDaVwoLXgXj30Vy4DA
         L7fO5CWSbCGwdQTuQe3qAzeA8iuxEsOfX1n0Zc5Jm02u8Wl2qw9UlFgKAPPuS+Y4Ik1F
         rI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740993549; x=1741598349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcNOncFZdUs+yNeq8pr7D0R7rzSHI/mcL2lr8MRssiE=;
        b=iYTGpe7w+im5bnJ7CV5+xIJyeRHS8j5M5kLaAsU03XnxzkLV/8qjxP8WSKJH65Lmh0
         fYg43eDTaUkswCJNLaJPYm0rYbVmBu9sDS17E+RBoM8kPjbzfhbxO6tmgejIP6/fZ/zO
         mOJmj1W4emuanqpMJu9uxzl6oa4d7uYABcD5d7O2jT6AE6O3B6DIDQ2e0Bs/xdp3umuA
         hrEHA+dWdoTXqPR5ZungjGQC6oV4z8hyE3V6oWEOUHu5O7T3z6ZGpRzFAzxjmM0UD8tB
         xmbg1QaVgnHlsac47B7lyqkBla9MAAeWQQ0vvWOawSJ180eWD1gzzM/r0C17xPUp8xQw
         40Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUvqGEZmPzYs8hCUNo0/A8puWNxZbmK5vCHIauEscRo9sq/WfpYdHBYOU6K9NZ2BJbqXPVnuA==@inria.fr
X-Gm-Message-State: AOJu0YzcQsedXyEFrZ2G3ChyjUN8p0STpgxSPjnJVA3YQxCNpPfQkm9Z
	i/rOm28/cFZgnpRxKlzh+aNVRyVVAbf5y6ITY6dQOSYLP5eFo6dw1Y+i6tLknHSFc2AZ6zzrp+j
	uRjM=
X-Gm-Gg: ASbGncvidHmNvixvO5v55D3Va5+eF/L+tSI9nq4Un2Rjr66OD1SzCwIatWMQEuIARk8
	WHQGmBluGVaAz4jCiEqfghAuEQnQ8KRQ2Kv3FkyGhSYkyqHcnF1U9Nt37PFiw8dqeZf22WBnkQD
	UoAeKwvKwunGwS1XLTqQN4iyhyxfsCu131cGIog+47My3rxr3szJk8jyM3c/wA6Le44C2BRkxPT
	+U7Qtf9CPExx+Y4OcvoDDqsm3TJ+LVtn27QgZXnnKiC6lwbX8vbfY3cb2chnumcrNnvUQmwxlmh
	LC+1AtdI/5xwqthMPD9l1SFJYeWHzeMyV4bll/xB07KQ8tlMjhuxZXp0tmbQgEnD4Y8BQv+2wsj
	Kv+n354+drDjGwCISkhhjW9H9/w==
X-Google-Smtp-Source: AGHT+IEgqURih64QQq878LAlpoiWUHZ5SF6g+OaiNjsjRHNfpFnMktBq587o0TTR3FHczDy3N5hAQQ==
X-Received: by 2002:a5d:47c3:0:b0:38d:b610:190b with SMTP id ffacd0b85a97d-390eca377a4mr9441525f8f.46.1740993549456;
        Mon, 03 Mar 2025 01:19:09 -0800 (PST)
Received: from localhost (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6a87sm14038348f8f.32.2025.03.03.01.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 01:19:08 -0800 (PST)
Date: Mon, 3 Mar 2025 10:19:06 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Antonino Daplas <adaplas@pol.net>, Helge Deller <deller@gmx.de>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Yihao Han <hanyihao@vivo.com>, cocci@inria.fr, 
	LKML <linux-kernel@vger.kernel.org>
Message-ID: <ugymllbkcsg22ffgyofvkquh5afbvoyv2nna5udmy3xfhv2rjz@jhgghzldzm4u>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <86551e6f-d529-1ff6-6ce6-b9669d10e6cb@web.de>
 <3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b5ssf4zg6xgpebyg"
Content-Disposition: inline
In-Reply-To: <3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH RESEND] video: au1100fb: Move a variable
 assignment behind a null pointer check in au1100fb_setmode()
Reply-To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
X-Loop: cocci@inria.fr
X-Sequence: 2507
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/ugymllbkcsg22ffgyofvkquh5afbvoyv2nna5udmy3xfhv2rjz%40jhgghzldzm4u>


--b5ssf4zg6xgpebyg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND] video: au1100fb: Move a variable assignment
 behind a null pointer check in au1100fb_setmode()
MIME-Version: 1.0

Hello,

On Sun, Mar 02, 2025 at 07:02:12PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 13 Apr 2023 21:35:36 +0200
>=20
> The address of a data structure member was determined before
> a corresponding null pointer check in the implementation of
> the function =E2=80=9Cau1100fb_setmode=E2=80=9D.
>=20
> Thus avoid the risk for undefined behaviour by moving the assignment
> for the variable =E2=80=9Cinfo=E2=80=9D behind the null pointer check.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Fixes: 3b495f2bb749 ("Au1100 FB driver uplift for 2.6.")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Should also get

Cc: stable@vger.kernel.org

to ensure this is backported to stable.

Best regards
Uwe

--b5ssf4zg6xgpebyg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfFdAgACgkQj4D7WH0S
/k6Ubwf+PAWfTbo0e8l6pPMYDWTrIlWDVs6P8JwsxmPeNHmuw2L+6JmiXLUt4r8K
BVOnwleXuUC4G/EKeAKqCwELLweDzt6QsmUWLUCsc6MWiQ1O3QDCv13Fty9auThY
kk47fq5PjnBwjmIVoMGXAgkBlbRg7kL3mHisr4Znw6RGM/T4kW4GGSSRKBNUDTy3
3zTnFrB5Yu6Kzu4JeU34zrCMxKAvQQoBWC61PkTfjcagCj/XrRG86KI818e+6ZPr
P65IgsUOVTGAFKASeg4ZDgvdvaMnvoOH2w4RENMNeHuYWCe4wJaW/bn5brGZq1eP
MJFndsnaHk7DCh94RiyWcyZ7veHiLQ==
=VPpv
-----END PGP SIGNATURE-----

--b5ssf4zg6xgpebyg--
