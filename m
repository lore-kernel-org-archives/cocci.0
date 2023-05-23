Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFDDC7EE2E
	for <cocci@archiver.kernel.org>; Tue, 23 May 2023 20:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=WTiJ4XwL1fOhBtieZZJjLAa5tQmxfPLiLmJLQdLZ/P8=;
  b=vBik+hKbYN6QKy+GjbCAl4t39Wf8rgdG+QGPpOJj/FtIWnrDnZ+84FqG
   EWrTnxXTcu5607zzNTx/YVMG3YC49j4v7XnHZX/9LuU6pVeyzTzW14Csj
   KXRNGaurf8KkaIy1npaaMVosNWKFdtoCPDeZtVjDlblpLizbbJ+EmlzBE
   4=;
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
   d="scan'208";a="109317262"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 May 2023 22:15:58 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B1613E033A; Tue, 23 May 2023 22:15:58 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AEB17E00A8
	for <cocci@sympa.inria.fr>; Tue, 23 May 2023 22:15:53 +0200 (CEST)
IronPort-SDR: 646d1ef9_KdLmgnf2j7kwpeihWQyDTMNWTxVlDCSz+7ULTjGVZzZzmcQ
 GuA6VHhmawB0kyBkG5cjY0LYgseOwnzLgQnmZsg==
X-IPAS-Result: =?us-ascii?q?A0EyAAAjHm1khw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYIueFMwBAtGhFKRCTGEM4cwh0SEZ4QDgVaBQD4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEOIRHAoVbAh0HAQQxCA4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEB?=
 =?us-ascii?q?QECEAEBASMXBw4QJ4VoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAkc/AwMjBBkBAREmAQ8fAQUCJgICVwYBDAYCAQGCeoIoAQMxB61rfzOBA?=
 =?us-ascii?q?YIIAQEGgmWZKB8sIlWBXgmBFS0BjSyDN3onD4FVRIE8g0KIH4Jnjy2NDIEwc?=
 =?us-ascii?q?oEjgSiBAgIJAhFngQ4IZoFzQAINZAsLbIE7WkMfgUoCAhFCDBUEAVgCgQQQA?=
 =?us-ascii?q?RMDBwQCgQ4QMQcENwshBgkdNS0GXQcvJAkTFVMHhCsDCgooJQQOAxkrHUACA?=
 =?us-ascii?q?Qs7Oj01BgMLHwYmHwKCAwSBCXsGASQkoDSBDoJ2w3I1B4IugVqBXQyfFgYTL?=
 =?us-ascii?q?5cRDgaSKi6HNJAnIKgQgWUBN4FcMxokgzZPAxkPjiAZhA2PSD80OwIHAQoBA?=
 =?us-ascii?q?QMJhUYBAYV+AQE?=
IronPort-PHdr: A9a23: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
 5cEDLNWBgRd/hIyD0N4AJodLZ0xUj52ydam
IronPort-Data: A9a23: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
 RHyN0Ac5iSM/6w=
IronPort-HdrOrdr: A9a23:BmVSy6sQyvEIdQ4ZW3F7ACAO7skDotV00zEX/kB9WHVpmwKj5q
 STdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniFhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD9HZK3BgDVQfexQpeWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:1gIJ+m1mdJBh/T9KzMW6nrxfHMYid3PUnCzrGE77U19nV6fFaGbJ0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3AdHqDuQ9nJCIWiOJoY/Estc2Qf9VO+YH3EnIhqLY?=
 =?us-ascii?q?pvdbbPgFhHi+t0h3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,187,1681164000"; 
   d="scan'208";a="109317257"
X-MGA-submission: =?us-ascii?q?MDHjUz9+PxCk1ZBPamUfODq0Gd8Rs27r9FbUls?=
 =?us-ascii?q?LMZA+ue7jQcp0WEfq0wHUOTqVsOfqr+OLzwfu8a6vgawCWN75hyEr1XA?=
 =?us-ascii?q?eiF6jW0JtsxkhlgbppsSjJ1w8/tFKbSmlTC+3iQmJBO23xhzOrsrl/za?=
 =?us-ascii?q?0LgBeNcRg+mOsz5H3mJQXhBw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 22:15:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1684872952; i=markus.elfring@web.de;
	bh=dP9NEE68fMXgefx6pKhxB5p1osjqrBzoDEtHTj9tjIM=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=vbPgmz1TSd9Ppy38ipV9/vV8ausVuRaFJZcWvu+HDrlXqSVwsoP9ZoVOAZ3PEtwJQ
	 /xTTE4L2jYzDIiLa28gtMpyPjU0jPMTrpkm4pDZqyqH9bqV/5mITT230JqQgsXJ4s8
	 ljTw3G32xl3zGt7pwSD1mVkmqcUcb705nvCBbOlTQHVgffC2DifICowlzGBUtUGA7o
	 wgMdnk60z04CeII2Wi/SSciRvBOvJ9yrtnHl1mwsbdZsyY8rDSnubsUrkRMQwcOqXr
	 nWqRd/yuFTA2+geJxw+0JqrQYw/TvvknWkPp3zZ6nC2ECjmuGGqp/vxCTHX7AtsUDV
	 G9RXFeiXUn8xA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2gkl-1pyW192EzX-004AVb; Tue, 23
 May 2023 22:15:52 +0200
Message-ID: <341b4af7-5c6c-cbd2-6fe3-c0e4e58f3c7d@web.de>
Date: Tue, 23 May 2023 22:15:52 +0200
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
X-Provags-ID: V03:K1:N6s5Lw4mbVcOlOXvuMubk1Fi2yEuD367sj0sv7jeo2DHKQeiS6N
 GwTP6/D4PSqEMuTa7Jp6IXSRDBe7BVYrPSjPjW5O800IFBshyaalrn278LxpHmIzh7EQsl7
 U3nJDC8Es8uMlv+Nf6Y4gpzdKFRfryyHi/MGe5Rd2iQpkx+sdLAVb6SjV7ds+IvBKAJmNMx
 VnRt8wG1Mvb7QX8GZRCUQ==
UI-OutboundReport: notjunk:1;M01:P0:DICDXp1wkjk=;D9PKtH4ZgPG5jBhG8KVdz7M4qDs
 sD3I8DjPsh69bi198lXTMgdX6E9affEuhiN78qQm55sv6h6Ewh9J9xNPG97doY08obyUmCy6B
 sY8KGvhQbbYiZPNBpbbCQcydtMpzuCG2DQyQMbldyb8QX8zaiFHwoAylJFmaFJf1TB0wqNxq8
 ahSCBDxOIaBEWXcr4rI8qj9ZvdYAXs8CfKsIKBC/4C0D5SWgbkD74z9Bn5VNS+FawT7GgOcBR
 Mp4vubS4OozoabRIi0jHLoXn63GujQdUL/R/SFlB5zJhdCuOwub76qJ40UnyfqbbxGICy6+oo
 y0v3ILie8tUySBleBn7mC6ZNbXLyJfP6h3mYp3//LaUCwv+omKaxpzfXduzc9AYrU9EYDJVVX
 /l2Jg1sD5uJFbPDBsi432O7B9a5Bqf2aR2UwmZT/JkXLt3ETraWnkEAYQ8z3KObjoBWA+J2RV
 JsIwct3xSAa82R64WgK17RTuqtWz+ioKcNQcbydvkEX4gPrDA112tVFFIleCHbRcRcA1W7uPs
 64tY0MR4bRU7i6Sl7y2AScRe/7vBioQAaInX0fejGgnC+idPvGMTOhjvGPKTuNd4lSJdeA7KH
 38h7AgTSafNOVh4MmgAXbMoS2M5Mc+jji/CGOLUaKwlbKtGxQ0nCA8+SbubvTAAP40z3GD8Bm
 owri5rkHuWHL7E1FzV0bweeAID+Cncmas2Zji9G1u4If3Kcezem4nmC66FxeSVkPjRokZctzZ
 5Hsol9qOcsyNcXDGmyn/ShYJPyAE8c2xqtOXXjmCBqnGoZr3ONkDLfkN+XRMrJXxPyJ6nb0cy
 nOk+9eDcXcu0qgdMPBrIqvxP98fDE1ULll97CI4og1Fh5JpDi4eyej4OsjGRxL1sZ6RzHVLTU
 S0rN2pEyToSoGxFrwN8il8vF7RTck6h+Q6kSgZKA0OWs+S42mEd1DX1PAhs/d68+nd7+SM4ej
 J5akBA==
Subject: [cocci] [PATCH 1/2] fbdev: Move two variable assignments in
 fb_alloc_cmap_gfp()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1153
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/341b4af7-5c6c-cbd2-6fe3-c0e4e58f3c7d%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 23 May 2023 21:30:29 +0200

Move the assignment for the local variables =E2=80=9Csize=E2=80=9D and =E2=
=80=9Cflags=E2=80=9D
because the computed values were only used in a single if branch.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/video/fbdev/core/fbcmap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcmap.c b/drivers/video/fbdev/core/=
fbcmap.c
index ff09e57f3c38..5c1075ed28ab 100644
=2D-- a/drivers/video/fbdev/core/fbcmap.c
+++ b/drivers/video/fbdev/core/fbcmap.c
@@ -91,16 +91,17 @@ static const struct fb_cmap default_16_colors =3D {

 int fb_alloc_cmap_gfp(struct fb_cmap *cmap, int len, int transp, gfp_t fl=
ags)
 {
-	int size =3D len * sizeof(u16);
 	int ret =3D -ENOMEM;

-	flags |=3D __GFP_NOWARN;
-
 	if (cmap->len !=3D len) {
+		int size;
+
 		fb_dealloc_cmap(cmap);
 		if (!len)
 			return 0;

+		size =3D len * sizeof(u16);
+		flags |=3D __GFP_NOWARN;
 		cmap->red =3D kzalloc(size, flags);
 		if (!cmap->red)
 			goto fail;
=2D-
2.40.1

