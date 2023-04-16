Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E763C77B61
	for <cocci@archiver.kernel.org>; Sun, 16 Apr 2023 15:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=8mcsk8iXXIchKjrfqTK/eUvrOMBnf+WF/4xVI0WIDpI=;
  b=DSdY/FJfObwAIqDbBiugO8sbG1Fke2tW2C5UkgVnfrEV2Y/u5YI4catl
   NpDLKOdIDvMZt95kIZBr9YrmT2wFQx1izWNao7dgN3j28egb2klq12Y/p
   ZvNFT+sjAW9aeqSVM/dXuH9Q7mgP6Jz4Wg6WANo45MVeWDm3PQiakdJxh
   U=;
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
X-IronPort-AV: E=Sophos;i="5.99,202,1677538800"; 
   d="scan'208";a="103287535"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2023 17:47:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 30F09E033A; Sun, 16 Apr 2023 17:47:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 002AFE00A8
	for <cocci@sympa.inria.fr>; Sun, 16 Apr 2023 17:47:25 +0200 (CEST)
IronPort-SDR: 643c188d_gkkDNj7YmO+/7TBLU9x/2CWWPk/qB4QJYQrwl27wabZTMbu
 f011Jyp7E31D9DCd6Uf2734yUZQPFEAAtvy7i4Q==
X-IPAS-Result: =?us-ascii?q?A0EPAAAgFzxkhwwR49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBOwYBAQELAYItgUsvBAtGhFOIHohkLgOEMIcujCWEA4FWgUA+DwEDA?=
 =?us-ascii?q?Q1BAQIEAQEDBDiBU4J0AoU8Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBB?=
 =?us-ascii?q?QEBAQIBAQIEBQECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBARICRz4DAyMEGQEBESYBDx8GAh8HAgJXBgEMBgIBAYJ6g?=
 =?us-ascii?q?igBAzEHrWV/M4EBgggBAQacCx8sIlSBXgmBFC0BjEs/hDAnD4FVRIEVJwyCR?=
 =?us-ascii?q?2+EC4QUgmeRb4giRYE0doEgDoE8gQQCCQIRa4EQCGo5gUBAAg1kCw5vgUljT?=
 =?us-ascii?q?IF7BAIURA4dJQQOAxkrHUACAQs7Oj81BgMLIAZWawIJIxETBQMLFSpHBAg4B?=
 =?us-ascii?q?hs0EQIIDxIPLEQMQjczEwYFVwEpCw4RA06BIh8GBCRlgQEGASYkni5yAVI7T?=
 =?us-ascii?q?IIqkjudApQBNAeCK4FWgVkMnw0GEAMvlwkOBpIkAS6HMpAXIKd/gWM6gVwzG?=
 =?us-ascii?q?iSDNk8DGQ+OIAwNCRWDbo8JAT4/ND0CBwEKAQEDCYVGAQGDJIJZAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 RoiFrEc8/R/LlyFhQre2xBjvdpa+w==
IronPort-HdrOrdr: A9a23:IoWo6aASxQ03TgrlHel455DYdb4zR+YMi2TDGXoBLiC9Afbo9P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkOss1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QF5SWY+eRMbEVt7ee3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3AmNMg7WsArn+F/OxdBjidTguR6IsFUG3bwVGTe3a?=
 =?us-ascii?q?xAExzY+GZQEfA/Iddxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Au+CMdgwUtX0DwCUlDGtLZ0MZyPSaqIKcUm0Uj8U?=
 =?us-ascii?q?qgeveDRxiYTa4rzqmX4Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,202,1677538800"; 
   d="scan'208";a="103287534"
X-MGA-submission: =?us-ascii?q?MDFrqLt0eq/9AVl5wSWNSLkcC0Dpf9M1epIAAD?=
 =?us-ascii?q?P/nZj8BSDRcUTRz1xHdH+E1TOwKlfjBPBLiVKvtMWLqk7+k8Ren9RWM9?=
 =?us-ascii?q?uDwS6NjCWUMiWA/NUrYLtyqsvHq/lDK0+f3ZmGmbgqdfxijxt4dSKJ4/?=
 =?us-ascii?q?i8jAziiOCRZgH90ADERZ6nKA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 17:47:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681660034; i=markus.elfring@web.de;
	bh=5Z9cALek5Gs82hSIltPE1ilZYcDKTbzXs/wu0sOROGE=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=e9Dfr1fdNFGehRZtBg7quw2w6GhAYMvFzOneypDJVPwSM4LMz9d8hhQx946/V0F39
	 CIXvpghm/IzBK5/4pZ7A3wn0p6oNQV7e5Ry45ONh3QaQT9VLRsb6lio2c0mxQ/o7Bi
	 Cyed94n+Ncpa2OOPB9a+UsdFl6+5wCkqWG3tkz6DGjBjczuhPqn9/VBZ+NY4ncsVUB
	 /KepabJy7HGl5nSBPHgF2HxYB564qLmU2PXZbpZL5Eb/gCcTj0+N/meUee0FZ9ysQ9
	 Q1uTOIPATf3zofcgenlPWu4fbRUPuH8SgnXTS1qKReN4DQOsQjhR1hZXmoVwlI2AiA
	 QfdTD3kuztUtw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MaHWx-1prjvD2hBl-00VwXW; Sun, 16
 Apr 2023 17:47:14 +0200
Message-ID: <14636275-4d26-d639-5f6e-293fc6d1c4c6@web.de>
Date: Sun, 16 Apr 2023 17:47:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Allen Chen <allen.chen@ite.com.tw>, Andrzej Hajda <andrzej.hajda@intel.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Hermes Wu <hermes.wu@ite.com.tw>, Hsin-yi Wang <hsinyi@chromium.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FjZbKKdiIEkoylWiH6qqBLFMBXZpoFS+8+LEERFSWqYFyaQY270
 G6zj166vxXibPIXDcjdrUo50KBBs6Gyzhrmliyl2MQuXv17jTz7ErGoCrGl0GuyeRq+nrSb
 ArzXFLpYq2MxYxeMzOkm8bCIx4M16CBRJZPS0K49jRY+xrkImhBrLBj05Xbvo3wZLxrjg7b
 VCAz54ELXkW9Yp5uoqjvQ==
UI-OutboundReport: notjunk:1;M01:P0:5Ncvf+t3ZD0=;BF3aGfad5gSuVft8UJbpRBFPpjY
 xBm2kpeWas/PlUmZpOutGcn9ATpkhV39iKUORhMegvAckbEhNZqKlPBIFYMO8hJB1NijPqBUM
 oDnChf8rF+J0zmW8kwOtciC4R2WjcNk+JRCHF/ZZ+IPEYDA3mobwmh6EnnTKK8+WM6ulUw62+
 DYmj+elo1XxcAHrCeUjFf0EpfC2ohJVsIhHEtdldXyihl4+srfjoLdGSJEi5VtX7X0eKQVVTy
 cf8/IGWe1uwV1WU2syvINI5gjYWbhrIIL9hJ4vlzeMl94I+SA6k9Hh5BqO5CGSxrqrey8WF6d
 PpS5vhJy02lNbvbRAro/p2LeBLe39RTRaATtbabRM9u9O5QGFxbwXdt5JY9yPdgf3J5T3NC1t
 2Rqc42IodIIyEvtJ1SRYMRQmR6czeNhzIbi4v+4w/IgEsRHURkl2p8qCHOIY7b+s8jsCQ2gbX
 78hCtekG6NAiGAdrAJ1XLSjj5XjJdYlG8cPokNe8/ulpHJ6t26OBQ8OzRghOe8QUolvtusyYK
 92EKes1/ddmm/DO9R3rRfjthbVNO6AXoH38cKqMideGgzHXfwCbHo0NQyi6BScN0ZUdaXHYFw
 1r5TfIFtgLliSbUowWcVBbO5QWhTUAVLIyo7D4PEWHPKEjQNi/4lhiDbwL1XU6IoYQKEOgye3
 MhXa4WtSzuZqagxw9k62pUJyKW8CC3t9XYDEXWjQLOHUiqlp3fgIW2/ABAngvnPqzZGs3SWKv
 rveYhT6fhnh3YCIh6ei47paX4NEZ8XSnL6nYpM1MMP/WX5CsLxK7K8Lwktyq9OHJi5rTkPcbf
 0kmtQFd3s1N0UcPimD6a8pZUh30BcqqiUr2k42sbvkO31RrfZyAa13N3RtIR4I/r74sClMCv+
 y2P8uD27Phid2vhrs17V4nrZpz9PX9NT7KaI0HVNwQ9yu+1c3sxV5cw1b
Subject: [cocci] [PATCH] drm/bridge: it6505: Move a variable assignment
 behind a null pointer check in receive_timing_debugfs_show()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1070
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/14636275-4d26-d639-5f6e-293fc6d1c4c6%40web.de>

Date: Sun, 16 Apr 2023 17:30:46 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Creceive_timing_debugfs_show=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variable =E2=80=9Cvid=E2=80=9D behind the null pointer check.

This issue was detected by using the Coccinelle software.

Fixes: b5c84a9edcd418cd055becad6a22439e7c5e3bf8 ("drm/bridge: add it6505 d=
river")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/bridge/ite-it6505.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/=
ite-it6505.c
index abaf6e23775e..45f579c365e7 100644
=2D-- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -3207,7 +3207,7 @@ static ssize_t receive_timing_debugfs_show(struct fi=
le *file, char __user *buf,
 					   size_t len, loff_t *ppos)
 {
 	struct it6505 *it6505 =3D file->private_data;
-	struct drm_display_mode *vid =3D &it6505->video_info;
+	struct drm_display_mode *vid;
 	u8 read_buf[READ_BUFFER_SIZE];
 	u8 *str =3D read_buf, *end =3D read_buf + READ_BUFFER_SIZE;
 	ssize_t ret, count;
@@ -3216,6 +3216,7 @@ static ssize_t receive_timing_debugfs_show(struct fi=
le *file, char __user *buf,
 		return -ENODEV;

 	it6505_calc_video_info(it6505);
+	vid =3D &it6505->video_info;
 	str +=3D scnprintf(str, end - str, "---video timing---\n");
 	str +=3D scnprintf(str, end - str, "PCLK:%d.%03dMHz\n",
 			 vid->clock / 1000, vid->clock % 1000);
=2D-
2.40.0

