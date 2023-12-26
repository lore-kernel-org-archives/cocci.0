Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1129AC46CD3
	for <cocci@archiver.kernel.org>; Tue, 26 Dec 2023 15:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=HHNqf5XS0FcF5HMYUg9+sP9gDKCSbYWKtRv6mb5NvKE=;
  b=D1bkXsek/ac6tBL1/EHDmB3/dzB3uj69JFFdb2PbBaF8TsLMU8Cyau2O
   D2RecES5KWHyXA7qkK1qkwYvFqiOoME7LyhJr5l4tRpZnF7xpz0EVGsRp
   eufYIekWD2KHbJzmI4XnCv+xjU89hPnGAFjHo+ZFizTg6FNWxXK5FktUx
   Q=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,306,1695679200"; 
   d="scan'208";a="144062706"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Dec 2023 16:58:32 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 15BF9E0AF1; Tue, 26 Dec 2023 16:58:32 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1FC70E004E
	for <cocci@sympa.inria.fr>; Tue, 26 Dec 2023 16:58:29 +0100 (CET)
IronPort-SDR: 658af824_it6XZG1GtvpceH7I3lTbyn8zq9QBWzozigW8PTKOWfNgWbC
 kGMMOgnWbTiIncd1SaBZpGu28ZrJls+Aine3b8g==
X-IPAS-Result: =?us-ascii?q?A0FyAAAL94ple07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYI4f1MyBAtIhFOPQYF1MIQ7hzWHTIhvgVaBQD4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEOIRHAoc2Ah4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBJBgGDhAnhWwNglwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAkdCA?=
 =?us-ascii?q?wMjBBkBAREmAQ8fAQUCJgICVgYBEgIBAYJ8gisBAzEHrmV/M4EBggoBAQaCZ?=
 =?us-ascii?q?qxyHywiVoFgCYEaLgGIGgGFZ4NBeicPgVVEgTyBFIE+b4gegmiJGwcygh2DU?=
 =?us-ascii?q?JFXfQQBQXAbAwcDfw8rBwQwIgYJFC0jBlAEKCEJExJAgV2BUgqBAT8PDhGCP?=
 =?us-ascii?q?iICBzY2GUiCWBUMNQRGdRAqBBQXgQ9uGxIeNxEQFw0DCHQdAhEjPAMFAwQzC?=
 =?us-ascii?q?hINCyEFVgNCBkkLAwIaBQMDBIEwBQ0aAhAsJwMDEkkCEBQDOwMDBgMKMQMwV?=
 =?us-ascii?q?UQMUANpHzIJPA8MGgIbHg0nIwIsQgMRBRACFgMkFgQ2EQkLKAMsBjgCEgwGB?=
 =?us-ascii?q?gldJgcPCQQlAwgEAyspAyN0EQMECgMUBwsHUgMZKx1AAgELbT01BgMLGwY+A?=
 =?us-ascii?q?qZMexOCdpJyj0+DTp5yNAeCNIFggWEMnysGEy+XJg4GklQuh1CQTyCoRoFqC?=
 =?us-ascii?q?imBXDMaJIM2TwMZD44gOINzjwkBPUA1OwIHCwEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 vlGkkDN0tONLl2FiArdCjFXQQuq+x8C+k81xA==
IronPort-HdrOrdr: A9a23:zIZe/qPST3W/S8BcThWjsMiBIKoaSvp037Dk7TEUdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFg7X5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YGT0EUMr3N5DZB/KPHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: =?us-ascii?q?9a23=3ApdLhsmgzoTM/fbqvDnqMV7kNzTJufUzXzy7wDBW?=
 =?us-ascii?q?BGUV4bYSlYk+3oYF4nJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3A0aLnoQ4ISxc3w7G+wj0//u8fxoxLxqevC2EdjK8?=
 =?us-ascii?q?hque/aBQuByqwjD+oF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,306,1695679200"; 
   d="scan'208";a="75369955"
X-MGA-submission: =?us-ascii?q?MDFCgHD7N+9IqgkVc+sTQdticz8DldX4l5l1nB?=
 =?us-ascii?q?EvYkxFD8JBhoMmq47rBm6fjB9LdtJIKqDJfsJ4z/JS6vT0pEWoflCwXW?=
 =?us-ascii?q?vzp1Ngc5mqL+2uQEMCGNXV/tEqB+oiJq5nQZGYU1pQPhzy02eM3qcgzp?=
 =?us-ascii?q?vPEeZtIdh7frkHC/hNLFcs5Q=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 16:58:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703606290; x=1704211090; i=markus.elfring@web.de;
	bh=UsBoPuZPdqnwWrn8IhaxnLaYVK5pnPZrOKNApu8djQA=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=FCGmIfEiJPrC8OBQ9kHS5k/aWkC20OdHyG9Je0vmrj+6/Vtue12cVYPQSJYrewj6
	 uSNOaUtB31vmAU7i7pAcLxAWh9zSGBlhGsb+zeG4pZfmPbLkz8xLM79VdVZHU6Dfp
	 sVKvk3m56IRfESXcjbXjfwJ0hzQkwsl6Gnly8ZMT8hperGSwgyJnaHrtkvaZYjer0
	 tuyBYiiyrXxYi1lhE0UZ0a+VVCKycuUXJ2FnWEdVBMW+U2RxFe5FAsiFNGG0HOtSt
	 wOne3iDLl7oZd07khpKMvqJ2+rciTejn+J1SsuhW2mX445ElbY/pwHn02y05Eed10
	 QWfPPra8AeYbAnwjpw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3Gga-1r8ZQh3d5e-0109x3; Tue, 26
 Dec 2023 16:58:09 +0100
Message-ID: <85f8004e-f0c9-42d9-8c59-30f1b4e0b89e@web.de>
Date: Tue, 26 Dec 2023 16:58:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <12b3e9cb-3241-40cc-b7a4-43c45b9eedc9@web.de>
In-Reply-To: <12b3e9cb-3241-40cc-b7a4-43c45b9eedc9@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vj7nPubO/RtGZEW4DXmzQkH71f56f8vMzM5kuMez9/zuKsQ8EX4
 K02qYH4QSrdZS5YpEBjlzkaAL8PHX2R8OGLpKOdxwqXU02rFIWtgKSrsHhrIWCbWmX5OxWn
 zRinZwnnZ6PBinF6bxElAAgsaEk/jv7J5lcKGn+WjsPW8LsILG3Yu+opM3fcTVDUfPJCnI3
 r+eYb9cvQ5i04R94niE3A==
UI-OutboundReport: notjunk:1;M01:P0:YyuitqbQW/U=;Kfwc98S8YFQzqqgDFSOv1ipPVfx
 2jb0vX4kV9xuSkxnHnDHhvmHuvwvJ5Uv7nPMH4SYE5edYIjosRAf2y+/a5Kdv5qbidquv8Mh6
 PCzTF2ONHNSh7jZTmpgAnsPfRhtv4YYZ1rVZzcrFr/HnMG43TUvVVFPeEeiHZ8v6h0N4hLoN3
 d5otP0tsJLWZmhQl5cNqoDp/0aAWU20oD1o8+xalenJhh7qbsKbbDFgtCKicoF4NLGRmQ88lf
 8Bb6SpyXpd0kN5he+3YO+YEnO8UV3dmz8VWv5SVQphn60jNLIDJS1u6iROic5GptURJyvRpw1
 VPKPbIdyArJvp+Q4jlUOzLIwnTZBJILQjlBP9xalU03XP0CKJxsRMZQRMd3Aq+v9zisDPCjDc
 FisV9VDss6bicviXTra0J+moNy5WO5iMOcd3s/fXcwThXknjb0GomztuZGZbDZFy4zf0Twyon
 5G3cQoCzKuOWeDJuR3Xt5329nYpb1xRDzUsJnJTQprtevTQJ/acvrcmshldKQ5dcHqM06gpEF
 0j+hXqe4rvheMpLOa+LWg6b2Q1vXQSZrm7GZ/BHN44FIvGC4V+SnkdkC8r8H0e9ER58oYb89Y
 s5dtUdavEcP1qCM0+63IqmHokE+SZBK6GQeOA7d/vj0Kg+ks929O2q7gpTIwp6gf1PkDoRF/r
 6Uor71voT+hNFQxF0RM2cMoNdu1u7Lp7imGzH7gaELzR3OGgjLx/xlpGC6EtMfTTEjKTrvPxf
 jorq+JCoOsYUG4Pt2X0uKyZvpzwCkKGLfd+Vuov5ZCd9SliTNF4NrjznvJrx+48nFlJbZYHkL
 CKKMU7o0i/JrKkvOdj4Y3y0AbT30FKXTbw6wOOP3VHs2hj5nhDb1QQefAMPByNqQ7LNddJVqt
 2tZTB70AfK7EbM645fu8ExaSby1N6q8m/xAAEQK7eMp2cpljuKL6IbAk2TqNJdC1ZcQ2e+DcR
 cUsKFw==
Subject: [cocci] [PATCH 2/2] drm/sched: Return an error code only as a
 constant in drm_sched_init()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1400
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/85f8004e-f0c9-42d9-8c59-30f1b4e0b89e%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 16:37:37 +0100

Return an error code without storing it in an intermediate variable.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/scheduler/sched_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sche=
duler/sched_main.c
index b99d4e9ff109..1abbcdf38430 100644
=2D-- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1249,7 +1249,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
 		   long timeout, struct workqueue_struct *timeout_wq,
 		   atomic_t *score, const char *name, struct device *dev)
 {
-	int i, ret;
+	int i;

 	sched->ops =3D ops;
 	sched->credit_limit =3D credit_limit;
@@ -1285,7 +1285,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,

 		sched->own_submit_wq =3D true;
 	}
-	ret =3D -ENOMEM;
+
 	sched->sched_rq =3D kmalloc_array(num_rqs, sizeof(*sched->sched_rq),
 					GFP_KERNEL | __GFP_ZERO);
 	if (!sched->sched_rq)
@@ -1321,7 +1321,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
 	if (sched->own_submit_wq)
 		destroy_workqueue(sched->submit_wq);
 	drm_err(sched, "%s: Failed to setup GPU scheduler--out of memory\n", __f=
unc__);
-	return ret;
+	return -ENOMEM;
 }
 EXPORT_SYMBOL(drm_sched_init);

=2D-
2.43.0

