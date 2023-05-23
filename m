Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CFCC7EE26
	for <cocci@archiver.kernel.org>; Tue, 23 May 2023 20:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6jxdNTqpj25B5CYVbC0nbc4vU1GUATx0pdEPKn2i2Ng=;
  b=UWlvunhiGdo9lvU6qIDRkViY7cKviPknFi/jGsKdkmLDLkxZyRXUBGru
   FHCnAzhqM+0G4czYK0IYf09yIyYxscqqpHG6H+0o/w1pNh/9PR8NtLeub
   4KHgY+0vLqVMzNS8iSJdOHhIbmBpP8V33LsTfjlZcSq+ahWiDQGGd1eS+
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.00,187,1681164000"; 
   d="scan'208";a="109317361"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 May 2023 22:18:20 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3DE01E033A; Tue, 23 May 2023 22:18:20 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C9A92E00A8
	for <cocci@sympa.inria.fr>; Tue, 23 May 2023 22:18:17 +0200 (CEST)
IronPort-SDR: 646d1f89_wuuVTG5USo9Za1b/Zkk8MjE+czXNQRBo0QA0YBJ/545GGn6
 c+jKbQn0yq6GoPiACIuv29FnlzMHKaeMY8ZjF5A==
X-IPAS-Result: =?us-ascii?q?A0EfAADUHm1khwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIueFMwBAtGhFKIHYhsMYQzhzCMK4QDgVaBQD4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEOIRHAoVbAh0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEB?=
 =?us-ascii?q?QECEAEBASMXBw4QJ4VoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAkc/AwMjBBkBAREmAQ8fAQUCHwcCAlcGAQwGAgEBgnqCKAEDMQetan8zg?=
 =?us-ascii?q?QGCCAEBBpwNHywiVYFeCYEVLQGNLIM3eicPgVVEgRUngRWBPm+IH4Jnjy2DG?=
 =?us-ascii?q?Il0gTBygSOBKIECAgkCEWeBDghmgXNAAg1kCwtsgTtaQ4FpAgIRQgwVBAFYA?=
 =?us-ascii?q?oEEEAETAwcEAoEOEDEHBDcLIQYJHTUtBl0HLyQJExVTB4QrAwoKKCUEDgMZK?=
 =?us-ascii?q?x1AAgELOzo9NQYDCx8GJh8CggMEgQl7BgEkJJ9Bc4EOcoIEw3I1B4IugVqBX?=
 =?us-ascii?q?QyfFgYTL5cRDgaSKi6HNJAnIKgQgWM6gVwzGiSDNk8DGQ+OIBkeg2+PSD80O?=
 =?us-ascii?q?wIHAQoBAQMJhUYBAYV+AQE?=
IronPort-PHdr: A9a23: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
 J8JV6MdS1E/UP8XWBwNIQ==
IronPort-Data: A9a23:D48cR6DT+xIVIxVW/yfnw5YqxClBgxIJ4kV8jS/XYbTApGwk0j0Gm
 mBOWzjTOayCNjD9Kdl0Ptvn9R4B6MDWmoViOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yM6j8lkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/YuHYDdJ5xYuajhPs//Z80s01BjPkGpwUmIWNagjUGD2zCF94KI3fcmZM3b+S49IKe+2L
 86rIGaRows1Vz90Yj+Uuu6Tnn8iGtY+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0usyxVEFL0OavHJSxjSCc52HPKGH8yqlvNxtsH9VH9MhwWFlI3
 PNNfVjhbjjb7w636Le8V/UqmckpasXmVG8dkis5l3eDV6lgGM2FH80m5vcAtNs0ruVHB/XDf
 Iw0bTR1bRLPSwJCMBEbBfrSmc/12CauLGIJ8Tp5o4IW81T41Tx96IHxH8bfRfuSRP0W3U+X8
 zeuE2PRW0xGaoXGl1Jp6EmEjejEliLTQ5MXDLT+9/hwgVTVyHZ7NfENfV68vOX/lUO0Hd5SQ
 6AJxsYwhYQ7r1a7R4X8ZEfigibbsDAbAuJWOuJvvWlh1ZHoywqeA2EFSBtIZ9onqNI6SFQWO
 rmhwYKB6dtH7uz9dJ6NyluHhW7rZ3NEfAfucQdYE1JfvrEPtalp1kqnczp1LEKipvvRcd0a6
 wKHsiU4jbgJgsMNv0lQ1QyY3WjESnThaAkv+gWfdHis5Ap/eOaYi2GA7F/G8bBfIYzfQlTpU
 Jk4dyq2sr5m4XKlznXlrAAx8FeBuqft3Nr03A8HInXZ327xk0NPhKgJiN2EGG9nM9wfZRjia
 1LJtAVa6fd7ZSX6Mf8pPdzqVZhxlMAM8OgJsNiLPrKihbAuJGe6EN1GPh74M53FzRZ3zfxiU
 XtlWZ/9VCxHYUiY8NZGb75AjeFyn35WKZL7HN6ihxWhzbeEYnOJAb4KWGZinchphJ5oVD79q
 o4FX+PTk0s3eLSnPkH/r9RPRXhUdiJTLc6t9KRqmhureVcO9JcJUKOKntvMuuVNw8xoqws/1
 ivgCxQEkQOi2SWvxMfjQikLVY4DlK1X9RoTVRHA937xs5T6SdbwtPUsZNEscKM59edu6/dxQ
 rNXM4+DG/lDAHCPsTgUcZC3/sQoeQWJlDC+GXOvQAE+WJp8GC3P2NvvJTX0+Ac0UyGYiMoZo
 p+b7D39f6YtfQpYMZvpWKqd9G/p5Xk5s8BubnTMOehWKRnN8pA1Cinfjc0XAsArKDeY9AS7y
 jS5PBY8jsvOqr8T79Pmq/2lrYCoMu0mBWtcPTDRwoiXPBng3FiI4NF/QsOXWwvCRUXI+KmGT
 sdE/cHWafEosg5DjNthLuxN06k72erKm5Zb6QZVRFPwcFWhD+JbEEmshMVgmPVE+e5EhFGQR
 EmKx9h9PIeJMuPDFHo6BlIsTsaH5MEutgji19YHC2Sk23Yv55uCa1tYADeUgi8ELLdVDpIs8
 d18hOEosT6AmjgYGffYqBAM7GmdDG0yY4N+vLEgPYLboA4KyFZDXJ/iNhHL8Ky/M9ViDmR6I
 xu/prbzuLBH90+TL1sxDSfs2MRet7QvuTdL7kMIfGrRvtzJgs42gR5jyhUsbwFv1h4c+flCC
 mtqEExUJKu14DZjgvZYbV2sAw1sAB64+FT77kkgzkn1alaObXPcClE9NcKm3lErw0gFchd1p
 LinmXvYCxD0d8TP7w4OcE9Cqc27a+du9wfHyfuVL+7cE7YUOTPa07KTP0wWoB7aAOQ0tk3Nh
 c9u2M1SMaTbFyohk5cXOrmg94Y7aU67fTRZYPRb4qk2M3nWe2iy1RiwOkmBQJ5xCMKQw3CoK
 f5FB5xpZ0yl2TesvwIrI/cGA4VJkc4D4PsAfbLWJlA6jYaPkwoxsL/t8nnRuWx6ZfRvjsc3F
 a3JfR2gDGG7pCVZik3NnuZ+K0u6ZtgIPjP9+OWP9MQICJMxn+V+em4i0raPniu0MSk22zm2r
 Q/8d6vt4Og68rtVnqzoCbdmKzivDNHOCNSz7wG4tupRYeP1Mcvhsx0frn/lNV90OYQ9dstWl
 7PXlvLKx2LA4agLVl7Gl6m7F6Vm4du4WMxVOJnVKFhYhS6zZ9/+0SAc+myXKY17r/0F35OJH
 zCHUcqXccIZf/x/x3cPMihXLEs7OpTNN6zloXuwkuSIBh0jyjf4FdKA90G4XVEDI2VMc9f7B
 xTvsvmj2sFAoc4eTFUYDvVhGNljLEWlRaIicMbruCKFCnWzxGmPoabmiQFq/ASj5qNoyyomy
 cmtqtnCmBWOVGXgydZEr8ptsxdRAHsVbSzcuK4C04Yettx4JDduwSch3VEuFZxe1CD/vH09T
 C+Yd3MsUE0RQhwdGSgRI73fssO3GeEEfNv0TtDsE4V4dA/ubL697HBdGuuMLpu4lvYPDA1qF
 D3GxkDNAw==
IronPort-HdrOrdr: A9a23:eeZM6K7pFA2gBbV39wPXwBzXdLJyesId70hD6qm+c20wTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhX4tKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkYNDSaNzhHZKjBkWyFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3AjY3nrWoaLxSxrOa0taekN8PmUewsKWfNxSvRGBX?=
 =?us-ascii?q?iKz42RpOSEGeW0awxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AowzijgwLTC+bSA1XiNRnHqNA4PmaqIW+NGsUoZk?=
 =?us-ascii?q?+gtWrKSZPHC+ctHf0S4Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,187,1681164000"; 
   d="scan'208";a="56797791"
X-MGA-submission: =?us-ascii?q?MDEkoF93q9lrai9lpwCqFZx/xgDQghiNSiz54P?=
 =?us-ascii?q?h9OmuDuJeQ/nOgOExNmPqdOIjmVmczzOcXQE1T5mne0ZvkugF9GklXRz?=
 =?us-ascii?q?6mX2W6LJDJ/CsnDq1YwT9nfEGOs29Hh2hlLUiz30m1JES7LLO6Yqd+BC?=
 =?us-ascii?q?bmjJR6FM1UlhN8x711devn2g=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 22:18:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1684873095; i=markus.elfring@web.de;
	bh=m3QJbalgg7JZn8ypxh1cFSjroTKeCpK66hg6yV7/E5Q=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=eZt3QhNa3iJH1lY8aFqBQf1hHjlhbz1Ps3RtMuKhtOlrzcLMKuCOxW1g2If2R4+Lz
	 AShEsnla/KweIALum3wxX0uV223Yj9A33syHDntII5cXd+xw99ugMLujS4kCGpwPwM
	 QbuEH0NWYmDNYOUjmx1N70GBu551fgv+pMyI4Slx9lBPSa25Wceu7KGSnb7qQN1Mhh
	 +kh0oM/cxPOfTA+jQoZMvkODudsdfVlzxJ4iVOjI86P7kg5kVisz3goBv8HItrXE7f
	 4E/UCoir+wPGCBDPEnE54FePYdaFrXoxZE9EexqLrsnXrRIYoCsV5X3SBa+JKRrQ8o
	 sWqaOnsCmEIJg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MyNwm-1qKQh92GNQ-00ylN5; Tue, 23
 May 2023 22:18:15 +0200
Message-ID: <3a44f5a3-3fed-86a6-d862-1da7a201061c@web.de>
Date: Tue, 23 May 2023 22:18:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Helge Deller <deller@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <8f0bcb48-7677-340d-282e-27f6fe063c6b@web.de>
In-Reply-To: <8f0bcb48-7677-340d-282e-27f6fe063c6b@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q4IsZ0zZs8axUh+c+JGQDeH6z6Pc3Bmh7/C3YoMFCV/9u9xv4Bc
 rpGbfr35JeoY7xseECqW+d9O9p+7QZxvRI5mYR2C2ZHpl1nsjdrvuIUvdB2xd26D1Wrbach
 zG1a9wofdEuboBeyEoXY+1VrszQqh8qsCiq/vMqN5eoCIzVpfjjGsox89L65UNQavfbCsiV
 QkJAnppxDElQDRHzSqOSw==
UI-OutboundReport: notjunk:1;M01:P0:mQlZ2sxC/HM=;9u5R9R5XH+HK6Rs/T7zpvefD7kI
 gbx5u8Gwf+l+Ev6CN/50v0z6M0Nz1o7P15TlD9olUI3dfIvlWeg/x4X2Da2vuRuomfDlO5kv2
 npQccs+plkWN0nsUo4b96xY3poSAHYLOk5Pllj2fBd8w5xNwJHMNxoum2R/HwClmsddKjB65u
 s2e1q4+eCJtvzV+UjQu8/M+wOoQi3lo+DnfedYPG/IavxWkrHKb23GVo+iNStT133Sdla+oNN
 psqtKgGg/5dYfYYTnZDdSOIcwItVJomhj8Rurg6VEHwiCNip97OZkCCkenBEJcsuFbH5hetry
 Dk6xf43eibjHcMEfFSM1t5zbinFcXLWo82fbScP5kUQ7QMdwoiEqUmEDMAt6JmMis/jD6//lq
 MLrLsPrtYRUJJTocyxJ0g5TulbVknEDRdbqUgYW1rk7zwXyCcLE4VQpgDGEjuc3/8KceGB+on
 mPpGQsJeCcLznIzq+Lu1uZuu1eADSQgy7jh9Mc9vbN0PryziSxvZBskIGt/C7zAHRothRBoyz
 fzi9PFMiS7Nb6fWTClWjRs2OpFUKij8CO/owVoUZs4971CJ2vgA7laiASNRO0VssErMdhl3IK
 a4EPt7wQF/8K1tqJiDxB3xOdbHHjdJRVsUiMo85hf+ZeN3AhQ9gjoIwYPY+5Vs7mFa0c6cIci
 zeS4U/fJGWlivPiv84eL7Gv+ixPzUi9uiMMrJerAj3zUazgH10ZPTYzikodkdnG7YQtmAzasR
 551fBY8QcRumFJJ2O98mxDAIfm/tIMPMk15zVhWOpt00X9Xutzka0uUGTCAtUkPWJYzWK00BJ
 h6PnDxolGj6hUk66oAAOAnyZ/+QDoY1AIru4HaHttQ8bLFRhj2heGP/mREHQyDMynJMDJmHOm
 +N6vDjsiWSZKiEEqr+NuNYyP4WRduY8VUdj2DiTypTfsA4OIIwGSHqAx9SrItLqKWTemkZwsj
 kERldg==
Subject: [cocci] [PATCH 2/2] fbdev: Convert a variable initialisation into a
 later assignment in fb_alloc_cmap_gfp()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1154
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/3a44f5a3-3fed-86a6-d862-1da7a201061c%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 23 May 2023 21:56:55 +0200

* Assign the value =E2=80=9C-ENOMEM=E2=80=9D to the local variable =E2=80=
=9Cret=E2=80=9D only for
  the exception handling.

* Use an additional label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/video/fbdev/core/fbcmap.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcmap.c b/drivers/video/fbdev/core/=
fbcmap.c
index 5c1075ed28ab..fbe82a64cf73 100644
=2D-- a/drivers/video/fbdev/core/fbcmap.c
+++ b/drivers/video/fbdev/core/fbcmap.c
@@ -91,7 +91,7 @@ static const struct fb_cmap default_16_colors =3D {

 int fb_alloc_cmap_gfp(struct fb_cmap *cmap, int len, int transp, gfp_t fl=
ags)
 {
-	int ret =3D -ENOMEM;
+	int ret;

 	if (cmap->len !=3D len) {
 		int size;
@@ -104,17 +104,20 @@ int fb_alloc_cmap_gfp(struct fb_cmap *cmap, int len,=
 int transp, gfp_t flags)
 		flags |=3D __GFP_NOWARN;
 		cmap->red =3D kzalloc(size, flags);
 		if (!cmap->red)
-			goto fail;
+			goto e_nomem;
+
 		cmap->green =3D kzalloc(size, flags);
 		if (!cmap->green)
-			goto fail;
+			goto e_nomem;
+
 		cmap->blue =3D kzalloc(size, flags);
 		if (!cmap->blue)
-			goto fail;
+			goto e_nomem;
+
 		if (transp) {
 			cmap->transp =3D kzalloc(size, flags);
 			if (!cmap->transp)
-				goto fail;
+				goto e_nomem;
 		} else {
 			cmap->transp =3D NULL;
 		}
@@ -126,6 +129,8 @@ int fb_alloc_cmap_gfp(struct fb_cmap *cmap, int len, i=
nt transp, gfp_t flags)
 		goto fail;
 	return 0;

+e_nomem:
+	ret =3D -ENOMEM;
 fail:
 	fb_dealloc_cmap(cmap);
 	return ret;
=2D-
2.40.1

