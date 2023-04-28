Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E54C77B61
	for <cocci@archiver.kernel.org>; Fri, 28 Apr 2023 15:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=YYvX4T0b3CwWQsRW3tTeyOqCoiuakEr9yiu7F/p+X9I=;
  b=q0yNwfCDVoJUGJPMQev+KoKNJXireiGHKYG5gycbQnnlNWbkoEEnjExD
   r1irY/LV1a0mqpZbjs+ZtB6/NcFmwqrECyNsp/O5oseUHjWHQ4z5upkRK
   a4wSTgXwlnotTmb0YQTpoFS8KNFzUl5OTuq4EeweBtq9W+cIK1iP6dJiT
   k=;
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
X-IronPort-AV: E=Sophos;i="5.99,235,1677538800"; 
   d="scan'208";a="105457571"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Apr 2023 17:55:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8F6A1E0D49; Fri, 28 Apr 2023 17:55:48 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E23B3E0D40
	for <cocci@sympa.inria.fr>; Fri, 28 Apr 2023 17:55:45 +0200 (CEST)
IronPort-SDR: 644bec82_Dv9Ygkz6RvMD09BPjOYZfoamR9OCe917LhkViuu8JvtTzDA
 dAjRWvcp6ja9c0B7oMi8yRU9FY3Ic/McEDYj3yA==
X-IPAS-Result: =?us-ascii?q?A0ErAABl60tkhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIteFMvBAtGhFOIHYZzgXYuA4QwhXWBOYwlhAOBVoFAPg8BAwENQ?=
 =?us-ascii?q?QECBAEBAwQ4gVOCdAKFPgIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBA?=
 =?us-ascii?q?QECAQECBAUBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQESAkc+AwMjBBkBAREmAQ8fAQUCHwcCAlcGAQwGAgEBgnqCK?=
 =?us-ascii?q?AEDMQexeX8zgQGCCAEBBpwNHywiVIFeCYEULQGMYD+DN3onD4FVRIEVJwyDN?=
 =?us-ascii?q?oQLhBSCZ45vh2RFgTNygSeBL4EEAgkCEWuBEAhjOYE7QAINZAsLboFFX0aBb?=
 =?us-ascii?q?wQCFEIMFwVZAnYOBwYIFQEYAwcHAgELJQQOAxkrHUACAQs7Oj01BgMLIAZEA?=
 =?us-ascii?q?oFgHwYEJGN7BgElJJgycgFSO0yCKpI8nQeUBzUHgiuBVoFZDJ8NBhMvlwoOB?=
 =?us-ascii?q?pIlLocykBsgqAKBYzqBXDMaJIM2TwMZD44gDA0JFYNujwkBPj80PQIHAQoBA?=
 =?us-ascii?q?QMJhUYBAYMkglkBAQ?=
IronPort-PHdr: A9a23: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
 g==
IronPort-Data: A9a23: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
 T3TFrMc8/RxLlxUqT4v28GG
IronPort-HdrOrdr: A9a23:95BYU65OLN5bZF24igPXwBzXdLJyesId70hD6qm+c202TiXqrb
 HLoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:eaVxj2EfsdxC45JTqmJ9rmE+MZ15TUSMyUXIOkyaVHpEUKCKHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3A7dUbrw+bLssdeubzJ6qa4iiQf+VCw/2qVAMNq58?=
 =?us-ascii?q?phcelBwVrAQ20rDviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,235,1677538800"; 
   d="scan'208";a="105457565"
X-MGA-submission: =?us-ascii?q?MDG6VvUda7RhYkRI01OQhx+Ep42/Y6B17TZfNW?=
 =?us-ascii?q?JdsuLYWmQo8kwmx0MfHllMES9YngkIGVu9FAVNd4KEPrt7F5QogHcOjn?=
 =?us-ascii?q?ct5Ejq0BStA2w/bx2Gnsz8t83VU/jy5nj+Ki8w+pzar2Jmwdwp7LBxxk?=
 =?us-ascii?q?gQPMGllWuV9Toi5paDHGHITg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 17:55:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1682697337; i=markus.elfring@web.de;
	bh=kvezJ209ikMxtDva7A5XsAYen8uuu1lgjSi7/a9lTp8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Fl1VywDLibIGQpfhBTzVktxEkaJ1GCLZyAg2XawtjP/sJZw2ChZH8gTaJneRIpWra
	 sm12a1uf4zBhJDTPK2SszzxDfNokgTDvVYuWfggEFGNFlg1Gfv5BL7RDSXGkkXyCtW
	 /dhf6FKaqgAyjzcyeQMyrwkdeHdHlF6sFpoA5X3H7hF88D3eT1VFD71ogPN1ZcIOas
	 UHlfTZLSyKw5JJ+fAVfF8UV3bC3s6STe/GmJwnTcSCPvOazOQ/nWsZQEUmAhKQmztr
	 P7+16b/KkUR1jbp1doyWT6OvAPwOGfGFnbgWAGa1AVzRCVXD8T5gyRVOBqWh2bSDcp
	 EZTr2dPMvKtmQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJnvp-1pYH7w1ZNp-00KBuC; Fri, 28
 Apr 2023 17:55:37 +0200
Message-ID: <fa69384f-1485-142b-c4ee-3df54ac68a89@web.de>
Date: Fri, 28 Apr 2023 17:55:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
To: kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Hermes Wu <hermes.wu@ite.com.tw>, Hsin-yi Wang <hsinyi@chromium.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <14636275-4d26-d639-5f6e-293fc6d1c4c6@web.de>
 <CAN6tsi7caOQZLLvbL7phMEtNvBLaWgJuHLkLo3YWdqQw7Vxnaw@mail.gmail.com>
 <6f758653-36c9-91a2-7bbc-278ae3f8ccee@web.de>
 <CAN6tsi4WBDOyzvXJ8vV=xJYay1JbBGo+UzZ+vudTBm5Fk5nB=A@mail.gmail.com>
 <14083012-2f19-3760-a840-d685fcedc15e@web.de>
 <CAN6tsi7263VnTba+WUUWR171Y+CsOKAb=it8cofPQGRk26K=aA@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAN6tsi7263VnTba+WUUWR171Y+CsOKAb=it8cofPQGRk26K=aA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dx1Md9h5hfxKHvfh7saoWqSlEiZQdQnZ2ZefsxCeWBpWc9IC3/j
 aUgfyxT751Xfez2r3ZYGHvuN0tdaIppX7zn5qnit6rbH4a6b0DRofgPC80Z9eR4izYInJXL
 TlwQnPOb21zp4nJg5KKMBU1IMgfvJAv1JBZDfoCGjBJRsQjQnlDHF3+nfWYkIWpgt8xE5vb
 dFgnsPojK2/VMc0to4Tpw==
UI-OutboundReport: notjunk:1;M01:P0:+Co1tYJEdIs=;VPZVqdaKivsLb011GvoatTV92TH
 2WMVARjLnfmRHV+aIR9k21+uaPsVovoFAQFy+56IHduGwAqjggAAPdvz3UdbkH13bICS5R6RP
 Le++zRnQSLjsLEm+wHl7nwR7oeBiOmcT12XfixrvEA+7cf6EbGuPy4yVZYSP6Zaa22XMScMGZ
 oBiOpb3MUIFM2v465mdoM4Y4H+YqOwjn5gpTXHvrILzCPZPn6v9L+W/rIYu/a7weKnM0Hg1uo
 2ZzcRfpLhy2oW/pnJPZeLtRfujeF2O0rir3ICXtsb7YTfrlgh4uF6j1UVUyeQhGSuiqvBhGkR
 nkH0BVSZDC9CK6BlUAVo9oOmjAwtdhYzmSwUYOjyoXVso4T74Ox+/HjOJtXXEVUzg1CX8lnN8
 lRTTcr8TGawjUbFsYX3nHtMjAPb8cMN84Li8Q1s0wF2G5+ODucBVeuERly05Qh4uGp4Zqtvap
 8JEJzb/u7pPHukCrgchWFfPsyA0016WUHMp4eyurk1m6IhbHc+PfKTSpIt6fI7pAzM3g3Spu2
 1Le8oRRvvaFLbXZ/HtlkbKAzbhme4psDD4oDx1MtsYOYYO1ULQy8aSxtn4fO1Ce6x4ByDLnbz
 8uHWH6pGKv2XLFJWbJwyHVyGJVSswW4D+mOdBqSg8HD/pcIb5KGlc6U99q/NI3JHTLQo8KUAR
 lTNlnnBGuRaEdDaG1NCA9ndotkVn9SQDUP9HQEHU/afsbtsPiXy0pKpTTk5U20j8xqGRSdxXX
 P+7ai+YgXT2A58vuj3ylx5BhHuF5ZSlHterajeoW+mLAe+uNBDoQDYXIW89TIEm3DwHXqNeKl
 aI5vyH1iqJW/yEJnYD9JasX87z+5mflHDF1ChGkSLs74q1fVG0g1LSChRQFqzyYF/l+DVjGuZ
 UdYe9qbwW6CYz4G0xxWDrmXD7BjBkXnv9xaAcR/n8M/m93xouMnN3rNFaKomY2q/ABVD+DRZi
 JKHQEQ==
Subject: [cocci] [PATCH resent] drm/bridge: it6505: Move a variable
 assignment behind a null pointer check in receive_timing_debugfs_show()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1135
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/fa69384f-1485-142b-c4ee-3df54ac68a89%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
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

