Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF5FC77B7A
	for <cocci@archiver.kernel.org>; Sat, 10 Jun 2023 11:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=rg9r7HQiU8oIPImAPLVJugLl6xbSC7vG2hXbbDbFCW8=;
  b=G5rCTvlX920GCGq62j026FRqQkaIe2H4exchvggPSWJyJkWT7p82hFe+
   Jmuf2e4IwNuBlvhOfmQc7Aenpm/8XBKLO2j59O77iygcjxnP4ktLg1O9g
   0Cr3WOM+00g76vgdtUglEF/aQissLbPXEpTK7wffVPH7kl/Vdvg4dXDu6
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
X-IronPort-AV: E=Sophos;i="6.00,232,1681164000"; 
   d="scan'208";a="112220147"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jun 2023 13:37:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 962A7E0AF1; Sat, 10 Jun 2023 13:37:10 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C985BE00BA
	for <cocci@sympa.inria.fr>; Sat, 10 Jun 2023 13:37:06 +0200 (CEST)
IronPort-SDR: 64846062_w0sA0CEMmDHPKrJntjDGkQv8hLT8sHc6uGWxh1WmkoEwgMY
 KZWBZeBEhg1o/NTYXvB+yaJhOJU35LQRtmGdL/g==
X-IPAS-Result: =?us-ascii?q?A0FMAACZX4Rkh07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIueFMwBAtHhFKIHYcNgXYxhDSHMIdFhGiEBIFWgUA+DwEDAQ1BA?=
 =?us-ascii?q?QIEAQEDBDiERwKFdQIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECA?=
 =?us-ascii?q?QECBAUBAhABAQEjFwcOECeFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBEgJHPwMDIwQZAQERJgEPHwEFAiYCAlcGAQwGAgEBgnqCKAEDMQetE?=
 =?us-ascii?q?n8zgQGCCAEBBpwOHywiVYFfCYEVLQGNLoM3eicPgVVEgTwMgkAHb4gfgmeJI?=
 =?us-ascii?q?4UTj1+BKG+BHoEifwIJAhFngQgIYoFyQAINVAsLY4EdUj2BRgICETwUBU17H?=
 =?us-ascii?q?QMHBAKBBRAvBwQyCR4GCRgvJwZRBy0kCRMVQgSDWgqBD0AVDhGCWygCBzZGG?=
 =?us-ascii?q?yIlBA4DGSsdQAIBC3A9NQYDCx8GQgKCAIEHcAokJKIFgQ6CdpYCi3OiCjUHg?=
 =?us-ascii?q?jCBW4FdDJ8cBhMvlxQOBpIsAS6XaCCoF4FjOoFcMxokgzZPAxkPjiAZHoNwj?=
 =?us-ascii?q?wkBPj80OwIHAQoBAQMJhUYBAYV+AQE?=
IronPort-PHdr: A9a23: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
 +SPzufPqOWOVpE6byVCNrY=
IronPort-Data: A9a23:gvmSn6qpEzHc3Ab2LnEQ9F/YUjpeBmJJYRIvgKrLsJaIsI4StFCzt
 garIBnXb/qCMTD3LttybY3go09Uv5PQm4AxQAtp+SwzEiwS9+PIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKiefHoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqqUzAnf8s9JPGjxSs/rrRC9H5qyo42tG5wRmPpingXeH/5UrJMJHTU2OByCgKmVkNrbSb
 /rOyri/4lTY838FYj9yuuuTnuUiG9Y+DCDW4pZkc/DKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzdFSfqV/wmWfG0YAzcmCA2kxG6E2/MxOM1tD9
 KU2Bik0UiKohs65lefTpulE3qzPLeHuO54D/G5tx3fVAJ7KQ7iZGvqMuoUehWZqwJ8edRrdT
 5JxhT5HSR3aYABUfHoTBog/muiAmXT1NTFVwL6QjfNuuTKJlFUtitABNvKWUN/QXdVYsX+1v
 2vA41jACwFdd/+AnG/tHnWE37KTw3qiBur+DoaQ/flhi1y73X0WEBRQVF2hoPD/hFTWZj5EA
 0kT5zZosqU4skCmJjXgY/GmiHmikjAaceNiKeA7sS+j05Po0S2YKmdRG1atd+canMMxQDUr0
 HqAkNXoGSFjvdWpdJ6NyluHhW7rY3lEdgfucQdVEVpcu7EPtalp1kqnczp1LEKipvHYcQwcL
 hiPqzUiwaoeh4gH2s1XHGwrYRr89/AlrSZvvm07u15JCCsnPOZJgKT1uTDmAQ5odtrxc7V4l
 CFsdzKixO4PF4qRsyeGXf8AGrqkj97cbm2C2gUyQ8NwrGTyk5JGQWy2yG4uTKuOGplUEQIFn
 GeI5mu9GbcOYiD2MPIfj3yZUZ1wnfKI+SvZugD8N4cSPMEoKmdrDQk3KxfY3mbxnVIqnL13M
 JjzTCpfJSZyNEiT9xLvH711+eZzmEgWnDqPLbillE7P+eTFOxaopUItawbmghYRt//f/204M
 r93a6O39vmoeLagPnaGq9dPfQBiwLpSLcmelvG7v9WremJOcFzNwdeIqV/4U9w6x/Zmha3T8
 2ujW0RV7lP6iDeVYU+Jc31vIvenF5p2sXtxb2RmMEeKykoTR9+lzJ4eUJ8rIpgh1uholsBvQ
 9c/Js6vP/VoSxb8wQo7U6XTloJZWSqOuROvJAugOTg2QI5hTVfG+/jiZQreyxMNBSuW6+o7+
 qOs5jrGTcA9RiBnNsL3ae2u/Xy1r3MyiOJ/ZGqWA9hxKWHH0plmFDz1tdAze/ozEBTkwiCI8
 iqnGjIKjLDpj65s1/eRnoGCjYOiM9UmL3pgB2OBsIqHb3jLzFSs0aprcbiufwmEcEjW5a/7R
 +Fe78+kAc09hFwQ7rZNSed6/5kfuenqiaRRlDl/PXPxaF+uNLNsD1+G0eRLtYxP3rVpghS3a
 G3e5uhlPai1B+29HG4zPAYFasGx5cMQkBTW7tU3Jxz03z8o3bylVU4JAQKAphYAJ5RIMaQk4
 9wbhugo1yKFhCAXb+m21hJvyzzUL1grcbkWiZUBMYq61isp0g5jZLLfOA/X4baOSY5+DWg3E
 BCphY7ppbdV9mzdeVUdSFnP2ut8g8wVmRZolVUtGXWAquDntNQWgiJD1CsRdRtE6ClH38ZYG
 HlZB2csKYqgpz5X1dV+BUayEAR/NTil003WyWpRslbGTkOtB1f/HEdkNcmjpEkmon9hJB5F9
 7SlyUHgYzbgXOf1+gAQAUdFifjSfeZdxz34uvKMPpq6RsEhQD/fnKWRS3ICqELnDeMPlUT3n
 7RW09gqW5LrFxw7gvMdO9GB2KUyWSK0AjVIYctc8ZMjGUDefzCP2gayFX2hR/MVJ9H39R6XN
 s8/AONOSBW06wiWpB85G6MnAuF5jdwp1vU4a5LpIm8K6YWeij9TtLPR6SnMq2s5SPp+kcsGC
 93wdhDTNkeylHdri2v2g80cAVWBYP4Afx/Z8N2u1ec0S6I4r+BndH8t3ouOv3m6NBVt+zSWt
 ljhY5D64vNDy4M2uafRCYRGWhuJLO3sWNSy8Ayct8pEafXNO5zssyIXslzWABRED4AOWthYl
 aW/j/Cv5Rnr5I0JamH+n4WNM4Jr5s/oBepeDZ/RHUlgxCCHXJfh3gsH92WGMqd2qdJ65Pf2d
 zvgPYH0PZQQVsxGzXJYVzlGHlxPQ+7rZ6PnvmWmo+7KFhEZ1hfdIci68WPyK1tWbTIMJ4a0H
 zqcVyxCPTyEhN8k6N446/Ba71tQJVj+Re05ete3uTTw4qxERL+dkuOKqPbiwWij5rq4/ALS/
 p/PABTzHPh3kL+d18lX6uSeoTVOZEuQQoAMkoY15NN8zTy3ZILDwSLxLr1eYqxpfufOOF0Uq
 d0DgKbOyckwYNicTSjB3Q==
IronPort-HdrOrdr: A9a23:gzfzeqFhRjLNPEPPpLqEPMeALOsnbusQ8zAXPo5KOH9om7+j5q
 STdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLfD1HZKjBgDWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: 9a23:lp1T/m2XYCymNQZY/FQwjLxfHeYJXHv39UXqLk7hJ0hwcYGnYl689/Yx
X-Talos-MUID: 9a23:fhPO5Qp0j31wnmDXHoQez3JIN51w86mBMW0UmJMah/CNJWszGCjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,232,1681164000"; 
   d="scan'208";a="112220142"
X-MGA-submission: =?us-ascii?q?MDF0IerdfroZ3EAhEWr1aC6I2tsfE2wlH0A9FZ?=
 =?us-ascii?q?ajiq84HhrWhYPM75521uRfg5G5P+edpAO6k3RpgW9POgdj4j20MJCuuj?=
 =?us-ascii?q?q3Fx/FnD6nro4vImCmiin/ny8aZI0Le8OSHbd1nBdE85QGBsmWVlmPnS?=
 =?us-ascii?q?ng/QcwxOwWnj2gMcSlqjEP5g=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2023 13:37:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1686397000; x=1687001800; i=markus.elfring@web.de;
 bh=Am+vzGKmVo0IASHZdwq/uvtpaB5ByDkRqBV+FrBhOPM=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=reRkaaCozxCo6zzLNtBBJQBMLLJS1x6NpknoO1Hon5t++OLBVOArcUtxN4ApPCZPo9TicJm
 rOfgPMQdH+V9Zq/ToD5KWZGT4slpPPdCN7gGOe8PXX2X41/JqMzWTXnprexCMEoa+MBBakgJA
 mJqAhTildhvwQh6ONYN4FP3WhxttGkjUHWY7Xu+u7WlZczUVgBYi8bvCnSY/S8Mse1mNY8LPv
 puRQqxl0IxfE7XqtBEAceszYAFtQZSXKfhpgpF+xGo0g++nMbBNSe7ECdBGJcPdnmat1CFMSo
 o/t/S6gzw3ZZDn7DDebqqYjiZKB9O1WGN5DMlPPXPkwHwiMvlpzw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlL9z-1pj2kM3gGz-00lm4Y; Sat, 10
 Jun 2023 13:36:39 +0200
Message-ID: <3a7476b6-2ae9-494e-1840-0915ddf47c2f@web.de>
Date: Sat, 10 Jun 2023 13:36:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org,
 sound-open-firmware@alsa-project.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Jaroslav Kysela <perex@perex.cz>,
 Jyri Sarha <jyri.sarha@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Dan Carpenter <error27@gmail.com>
References: <20230322181830.574635-1-jyri.sarha@linux.intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230322181830.574635-1-jyri.sarha@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wH7mt4BmBOHl2bT+2stSVV504BUjp0cScJU4RPbli9haTm1LPjS
 yEjz82eswp9H9eqLP8TPErdJ3OsYof91tMhb1Hj2gGOefWbCT1l2HNMdNQ8IMMWScwjiBhl
 t+NCeoGXQIM2PixuSttZRtOx+YuR75LCIEdn5NU2mp45GBwHRD/efJtIKVDVo/x4v5dZPND
 GBDvwXBpw7oVLyFrx+y+A==
UI-OutboundReport: notjunk:1;M01:P0:swMfz+U+qwQ=;xPmNxZHmQ9wMqTfQ1A4Y+b68NUI
 B2D2xmQK6pq2x95GThKnWl091GVzVqFFxZqRR2v3JE67vLD+0qDjDY/kxvsHGPpz6bOVolrUI
 MwX3/9eeJ9quQrCo8F8UMwk/V5VEDfs2UScKfHK2UVL0d4cF2Bv7klPx2/m0nyWN8/e21E10C
 Ps7a1A9PtehSaSih1Omw8HNm+E06PXxEeAc0gQwekoX7bLeIeUDOU/ijFU+qvJ6yHHwbMg1wF
 OOQbAwIgFeh0/MO52V0Ey4SoDSDmzBxyA3VaR7mmwWF7sWtV31Skl8Pq3qVdTWZ6EZj0k1VKK
 hUlCCDY8I9OwTpmKu54uDW6xh0Sev1WnmWEAfTheTUNrrI0vhPebwjNvJul1Ai4OinQWU0AvE
 GdiFIw9TZ+AZ5v30e/7dC3vVx38FvqYpbGsXnzI/4/66PHsUe2XB2eI+r+py1SbVZFwBy7LHh
 LmTiwqUvsgzf3IvpfICmzvABcfoh/ME6fs2X/hKIGOsiTkJjJmAZ6hSRnMK8eCmIKFrf8LLJP
 bmOlaiHMBLEny9v/T9cRRuXbHnAu68Ip6WEzhvyeijrk8vmwEjwmwQX1XrKm4VpKwV39US/4C
 GiTc4+9AwNrN2qAxKUnSEAavh5lIXYeTQus34xJ2puJ6GItjwNinvY2SIMiyZanmOeoEnu2kU
 m5PU3wSDGGjzGYQaoc8Fl3VSn0Vhxa1wSNNsCm+GyE+g723CMQa9AD5oSbb9STnqxHKNCWJ0n
 t4WusowhqtTun5lQEYwwI/Bf10EzqtRGcuRpPRTCMWKIRZ14//91HZGQhfJvZ5/z4xBBIRDFN
 F8K02Rvx+DOgL74bsZKWCPYv0Ll+kTXgxFixmk2a3ch/GSmdXZtwSpbZAUeCvBg1MZqQ5giJC
 dJhJrOFYC+cQjM5RhlYSIbO5evaoCLiJc+aM8+EBrvbRBmGpVuvD5nvgXJ2Fn0EG8ebPodYXc
 bSpSZ9NHtx6mFymKz3eMAR87unc=
Subject: [cocci] [PATCH] ASoC: SOF: ipc4-topology: Improve unlocking of a
 mutex in sof_ipc4_widget_free()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1174
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/3a7476b6-2ae9-494e-1840-0915ddf47c2f%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 10 Jun 2023 12:40:09 +0200

Add a jump target so that a call of the function =E2=80=9Cmutex_unlock=E2=
=80=9D
is stored only once in this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 sound/soc/sof/ipc4-topology.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index a4e1a70b607d..f0fd1dfa384e 100644
=2D-- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -2300,8 +2300,7 @@ static int sof_ipc4_widget_free(struct snd_sof_dev *=
sdev, struct snd_sof_widget
 		if (pipeline->use_chain_dma) {
 			dev_warn(sdev->dev, "use_chain_dma set for scheduler %s",
 				 swidget->widget->name);
-			mutex_unlock(&ipc4_data->pipeline_state_mutex);
-			return 0;
+			goto unlock;
 		}

 		header =3D SOF_IPC4_GLB_PIPE_INSTANCE_ID(swidget->instance_id);
@@ -2326,7 +2325,7 @@ static int sof_ipc4_widget_free(struct snd_sof_dev *=
sdev, struct snd_sof_widget
 		if (!pipeline->use_chain_dma)
 			ida_free(&fw_module->m_ida, swidget->instance_id);
 	}
-
+unlock:
 	mutex_unlock(&ipc4_data->pipeline_state_mutex);

 	return ret;
=2D-
2.41.0

