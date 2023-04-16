Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0E9C77B76
	for <cocci@archiver.kernel.org>; Sun, 16 Apr 2023 09:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=PFO7k6pa0c10cfRT4w5GxQQvVGeVJyGHR4sgW3JIgFY=;
  b=u7d3zhSgKDzeteIVu1mFc2ZR+TBzO6+ZjHgSQ/SXpsCMjz+0iRVOEO1U
   EFFCfkhxAgZsJbbzV/WrkC/hEu/SlN+ASGDzsolavoECxUj2UTwHeTKYU
   ZRzOif5b9iEA39jE9QilbL1Q3r5Me6SoAgtYoti4EaIhUgZFQqfQP1OfO
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
X-IronPort-AV: E=Sophos;i="5.99,201,1677538800"; 
   d="scan'208";a="103271363"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2023 11:36:25 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 64CE2E033A; Sun, 16 Apr 2023 11:36:25 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3D7C9E00A8
	for <cocci@sympa.inria.fr>; Sun, 16 Apr 2023 11:36:23 +0200 (CEST)
IronPort-SDR: 643bc196_ukQgoYQr8lSNN4kUGC1BdE5hHoj4kPnckQFmlaBp8b/O+22
 sCz5VzeHaJOl7hGiGuow3CBmwehNV1ASLSSqwXQ==
X-IPAS-Result: =?us-ascii?q?A0EFAAAWwTtkhwMP49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE7BQEBAQELAYItgUsvBAtGhFOIHohkLgOEMIcuhz6EZ4QDg?=
 =?us-ascii?q?VaBQD4PAQMBDUEBAgQBAQMEOIFTgnQChTwCHQcBBDAJDgECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBEgJHPgMDIwQZAQERJgEPHwYCHwcCAlcGA?=
 =?us-ascii?q?QwGAgEBgnqCKAEDMQeuBn8zgQGCCAEBBpwLHywiVIFeCYEULQGMSz+DNnonD?=
 =?us-ascii?q?4FVRIE8DIJHb4QLhBSCZ5FviCJFgTR2gSAOgTyBBAIJAhFrgRAIajmBQEACD?=
 =?us-ascii?q?WQLDm+BSWNMgXsEAhREDh0lBA4DGSsdQAIBCzs6PzUGAwsgBlZrAgkjERMFA?=
 =?us-ascii?q?wsVKkcECDgGGzQRAggPEg8sRAxCNzMTBgVXASkLDhEDToEiHwYEJGWBAQYBJ?=
 =?us-ascii?q?iSeLnIBMCI7TIIqkjuxAzQHgiuBVoFZDJ8NBhMvlwkOBpIlLocykBcgp3+BY?=
 =?us-ascii?q?zqBXDMaJIM2TwMZD44gDA0JFYNujwkBPj80PQIHAQoBAQMJhUYBAYMkglkBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
 lgphwE4bel/rF/R
IronPort-Data: A9a23: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
 T3SFrAc8PR8LlGFiNv/PsCGvNo=
IronPort-HdrOrdr: A9a23:g8iV9qgd+85bwA5t8W/lIsB3HHBQXg4ji2hC6mlwRA09TyVXrb
 HLoB1p726WtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW2ldAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykcsS+Q2mmF+rgbsby62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: 9a23:oaxRFmxgA0lta0ABwpgKBgUzJMYIeXCElUuXCFCWIlljdpbJeVWPrfY=
X-Talos-MUID: 9a23:4EKozQsArf65pNn2K82nhz5+PfZR6YOXDXtKg4s8vcqcNiVdEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,201,1677538800"; 
   d="scan'208";a="53467114"
X-MGA-submission: =?us-ascii?q?MDGhqAKIjrYHWKL9kWjlK/AXS0/h5eGRw6XYVn?=
 =?us-ascii?q?sxLIYsK0Myf8gNc6HzlUhD0gkt7ghtp1KO7jMQ8Z0oEmyAwYg35UxDb/?=
 =?us-ascii?q?OEsCAEuZkLbaaDBn3aw3kzXmrlh0/XAcP6sBpT7v85R5XeBannarPk8Q?=
 =?us-ascii?q?qKW5OxZqM+aVtiMC1hoo7Vug=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 11:36:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681637778; i=markus.elfring@web.de;
	bh=VbiCcvFD+Qi96Uu3AYsuuKIDaQ41gEUacwhrpgjbDtQ=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=bvRVPl4Ia3xvqrEI3P3GXwhY8OMAq1uk4d3kGw3Z/UgPtnsxa3zXyzBzyAmg9Xyh7
	 bb7AVKFDsABp9fevq51mXfAvo/WFHxs3LHvcLyBt8rKj21TeE8G1/eMhKkDiiMO7Kw
	 z5f1u08cCNZ/NvrJDrj36fRTHUu2kpRv5CFAbWNd+msb/nlpD2jTyg7rX6Cnsd9CBL
	 pd5MKh//ksGqNZdNry9t9gJobWkjNs874uEwMy5raDdwiHhMQyDMz9UX2nHMr/htcV
	 woQvJAbmFexADhQOV+EM0uf2411KwDBi3mcCNRKW4oEQYA17YZkDT+C4FZhlmTZcpo
	 OtqUsluEc8eVA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MA4fW-1pcTYe2hli-00C1jS; Sun, 16
 Apr 2023 11:36:18 +0200
Message-ID: <5b7b99f7-1692-74e5-4b1e-cfa14dad7c57@web.de>
Date: Sun, 16 Apr 2023 11:36:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <2a746461-844a-2ad6-7b52-03f13fe1b9bf@web.de>
In-Reply-To: <2a746461-844a-2ad6-7b52-03f13fe1b9bf@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AJ9D9+EKDgZDPgbcMafxaHj4mOgWlvC+BvY25gB1NZGB6gNVx+O
 xhlki1nbLNhebMQqVZC12o1VYHnC/hTtQPF1DAizUyk2o7v3fn2fPTUi/m+RNs0cM8+MNFf
 ohoDmlpNTR62CxT6BFNOCtonYB30A9B+2zGYwJaAbi6U2WStWeJhow8NUeolN5fEtVgp6P3
 RRdDPeBeF+6FzYAzg1i2w==
UI-OutboundReport: notjunk:1;M01:P0:QjjVPRb86F8=;fu40QwhhZ7krKM5qzzhEljFcUJK
 XerCFtOp0fprmtouuw68y0HUJO9Jegsz2JrA4BHlR5GU756/y/E6zWAC9H29uMm7FtP5fKoZI
 7pKW0IHcJCXhiBPdhiEH2ajrSpKrl9WBotycGDRW3S8zXOQ1uINwnJeagFf+mXX0OfujxBfzv
 qb6whXfUiLq4l7Nbr1IwQAd0mdeXZvScB1xim1dbi/eLaa6GSvqksHXxZ5KQYB8wF3Kl+rUQW
 J8l++5TQpRpwkkyW6Bfx5AvV53P9H364AmzfRvY/6OgkPfyeSiv8R5TEE3u2LPeCOO7aabTHf
 zUk9adxyNn1RZKg3qOv7MwiRnullLjK3wlPoQfGKjpzYbXp1AnX7EsyLrt7I9YJUHoNOG02XG
 w8q40jBhVw0iiYDJDNDvxLbBiTtYj6buaHy+ueOVV6CO7qQ5UxCmNq4kS1epywh6q0rDeHMf2
 uzGY1Ru8eIwdcNc+0fvyv2n63+KPgSy/1fO5kXFndfZWWdkH0IKZ3fQnYRxf4PvZH8VKtozfw
 L71nAqtuTWY8vd75ZrEgo7Iz6O1IDOz15aBqRvGe6nSkdhFeOkzg4+a6P4Aa2Qp6jEjDW5f+L
 //xfF1lQnP1otd9jFZE3dA5jCGRu6gVS9bXnftKSrYJ+sO/HXcvRugBVTqJM5Xp3XRR+pw81N
 ateYnAQHL9R2JpRVlq+tRqA2HdqiYOi8FaEUedqFagm6Y5gEdyfYIE3cf+ZZiv/6ASfegVRnh
 ZP21M/lIkKA1lp75LnXDgb//doYV6cbI8B5OME5YezLQnM2gVK5lS+ekurWURA4yfeoot1Bqg
 UFoxXK1RNMljJ6aBuqD14SXtO84OKNsst3VrARHG0dif0qc3yE5R0qO4imYi1vZLyi7V22665
 +wCVUfGaBt7nL9y7yLmurSZTrjOReeG7OgPz2BPe5+hrXKppTHOZdQape
Subject: [cocci] [PATCH 2/9] drm/nouveau/debugfs: Move a variable assignment
 behind a null pointer check in nouveau_debugfs_pstate_get()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1062
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/5b7b99f7-1692-74e5-4b1e-cfa14dad7c57%40web.de>

Date: Sat, 15 Apr 2023 21:24:43 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Cnouveau_debugfs_pstate_get=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variable =E2=80=9Cctrl=E2=80=9D behind the null pointer check.

This issue was detected by using the Coccinelle software.

Fixes: 6e9fc177399f08446293fec7607913fdbc95e191 ("drm/nouveau/debugfs: add=
 copy of sysfs pstate interface ported to debugfs")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/n=
ouveau/nouveau_debugfs.c
index 44e26b6e74c7..a859a086f308 100644
=2D-- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -73,13 +73,14 @@ nouveau_debugfs_pstate_get(struct seq_file *m, void *d=
ata)
 {
 	struct drm_device *drm =3D m->private;
 	struct nouveau_debugfs *debugfs =3D nouveau_debugfs(drm);
-	struct nvif_object *ctrl =3D &debugfs->ctrl;
+	struct nvif_object *ctrl;
 	struct nvif_control_pstate_info_v0 info =3D {};
 	int ret, i;

 	if (!debugfs)
 		return -ENODEV;

+	ctrl =3D &debugfs->ctrl;
 	ret =3D nvif_mthd(ctrl, NVIF_CONTROL_PSTATE_INFO, &info, sizeof(info));
 	if (ret)
 		return ret;
=2D-
2.40.0

