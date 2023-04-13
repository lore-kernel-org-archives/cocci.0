Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2876FC77B61
	for <cocci@archiver.kernel.org>; Thu, 13 Apr 2023 12:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=b2i0sUhBxNgZmJvcwz0j9oWqUxHsVsz+HakEyutqp+U=;
  b=sMJxUAOkFhGJpPpHhTMZ3fP7QCoW/DJ2pdbUGK4UqbOc2HfYK916/JDy
   pEmSyCHsBhmnKEFj83xf2rzTbIxXTC7EsNcTaMkH8aTcHioVpP31jy/T0
   K297J2iGuBBKD74CpkjDSbHCgZWtugW1BhqkST0DvGRUDc3CsqDW7uuy5
   Q=;
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
X-IronPort-AV: E=Sophos;i="5.99,341,1677538800"; 
   d="scan'208";a="102902114"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Apr 2023 14:11:13 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 53D26E0172; Thu, 13 Apr 2023 14:11:13 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C39CFE0171
	for <cocci@sympa.inria.fr>; Thu, 13 Apr 2023 14:11:09 +0200 (CEST)
IronPort-SDR: 6437f15d_QLRozx6sMbsZ46W2bGm6JnFIpiGRNYJcw9p+z7kjLweiV64
 IJlyA5v4r3uxKua18B36hVP5No5a4X7hazdmhMw==
X-IPAS-Result: =?us-ascii?q?A0EcAADz7zdkhwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIHokPA4Qwhy6QKIFWgUA+DwEDAQ1BAQIEAQEDB?=
 =?us-ascii?q?DiBU4J0AoU9Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEB?=
 =?us-ascii?q?QECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARICRz4DAyMEGQEBESYBDx8GAiYCAlcGAQwGAgEBgnqCKAEDMQetBX8zg?=
 =?us-ascii?q?QGCCAEBBpwLHywiVIFeCYEULQGNCYQwJw+BVUSBPIEVgi2EC4QUgmeRZ4haC?=
 =?us-ascii?q?oE0dIEgDoE8gQQCCQIRa4EQCGmBeUACDWMLDm+BSWNMgXsEAhRFFiUEDgMZK?=
 =?us-ascii?q?x1AAgELOzo/NQYDCx8GVmsCCSMREwUDCxUqRwQIOAYcNBECCA8SDyxEDEI3M?=
 =?us-ascii?q?xMGXAEpCw4RA0+BRwSBCoEBBgEmJJ4ScgFSO0yCKpI7sQA0B4IrgVaBWQyfD?=
 =?us-ascii?q?QYTL5cJDgaSJAEuhzCQFyCnf4FjOoFcMxokT4JnTwMZD44gGR6Dbo8JAT4/N?=
 =?us-ascii?q?D0CBwEKAQEDCYVGAQGDJIJZAQE?=
IronPort-PHdr: A9a23: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
 O6/mw==
IronPort-Data: A9a23:XCBcwaMngZ0MVWXvrR2/k8FynXyQoLVcMsEvi/4bfWQNrUp03zwBn
 GFKWmzQP/yNMzTxfI8nadnk8UoGvsWEyIdhGnM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8mk/vgqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvU0
 T/Ji5CZaQ7NNwJcaDpOsPrf8Ug35ZwehRtB1rAATaAT1LPhvyJNZH4vDfnZB2f1RIBSAtm7S
 47rpF1u1j6xE78FU7tJo56jGqE4aua60Tum1hK6b5Ofbi1q/UTe5EqU2M00Mi+7gx3R9zx4J
 U4kWZaYEW/FNYWU8AgRvoUx/4iT8sSq9ZeeSUVTv/B/wGXHUVr+zaVrIXpxHo5fvbctXHBw3
 8UHfWVlghCr34pawZq+TfRwwNsuJo/nMevzuFk6lGufV6x5B8mcBfyTjTNb9G9YasRmOP/EZ
 NcCLxdrYg7BZRJnJVodTp4z9AutriCnKWwA8grE/sLb5UCP8z1N27/kaebJc+GyQNVbzm2x4
 TnJqjGR7hYybYHDl2PcrBpAnNTnliTwU4M6D6y97vcsgVuJx2VVBgd+aLegify+l1L4RN9Vb
 UAZksYzkUQs3E2Jb8vzDxiVmzmnvVlbCoANAtMQ0R7Yn8I4/D2lLmQDSzdAbvkvu8k3WSEm2
 ze1czXBWmUHXFq9Fir1y1uEkd+hEXREdTdZPkfoWSNVv4O8/OnfmzqWFo4LLUKjsjHiMR3dq
 9xghAs3nbEIl9ML2s1XFniY3Wv3+fAloiYf7wnaWCea8xlleIOgbYGy5jDmARtoKYGEUh+es
 XJCl8X2AAEy4XOlxHzlrAYlRunBCxO53Nv03wcH834JqmXFxpJbVdoMiAyS3W8wWir+RRfnY
 VXIpSRa74JJMX2hYMdfOtzhUp9wkfK6RYS8DZg4i+aihLAuJGdrGwkxOiatM5zFyxhEfVwXZ
 MrEKp/1ZZrkIf03lmrsLwvi7VPb7nljmT2KHM6TI+WPiPTHLH+TVbofNlaSJuk2hJ5oUy2Fm
 +uzw/Cikk0FOMWnOne/2ddKcTgicCZnbbir9Z0/XrDbf2JORjt9Y9ePmulJU9I+wMxoehLgp
 SzVtrlwkwCu3RUq6GyiNhheVV8Ydcwl9S5gYXV0Yw3ANrpKSd/H0ZrzvqAfJdEPnNGPB9YuJ
 xXcU5XfWqZ8WX7c9i4DbJLwioVneV75zUiNJiepKnx3NZJpWwWDqJeucxrN5Rs+KHO9lfI/h
 Lm8iSLdY54IHDp5AOjsNfmA8lKWvFomotxUYXfmGNdoVX/XwNBYEBCp1v4TCOMQGCrH3Qqfh
 lq3Aw9HhOzjoL0V0djuhILfnbiIDtlRI0t+NEvY5IaQKiP10DeCw4hBceDQZhHbdjr+15uDb
 NVv7cPXEaM4jnNVlbFjApBXza4azPn+lY9wlwhLMi3CUAW2N+lGPHKD4/hqioRM4b1o4S2NR
 UOF/4hhC4WjYc/KPgYYG1s4U76ly/oRpzj16MY1KmXc4Atc3uKOcWdWDim2pB1tFplHG6J7/
 r55o+8T0RK1tTQyONXfjix0yXWFHkZdb4oZ7KMlEK3ZoSt17GEaepHNKD7E0LfWYfV2D0QaC
 Du1hq3Durdi+nT/Y0cDTUbq4+4MqqkN6TZrzUADLWungtDqpOE69zwP/CUVTjZ69ARm0eVyN
 jJVNmlwH6Gv/ihptudHTWuDCwFMPzzH203Tmn8itnzVcFmsbUPJdFYCAOeq+FsL1k5hZR1Zw
 e2o83nkWjPUY83B5Cs+dkp7ofjFT9Yq1An9tO24PsaCRb8WXCHEh/KwWG82tBfXO8M9q0nZr
 +1M/uwrS6naNzYVkpIrGbuhyrUcZxCVFlNsGcg70vsyIljdXzWu1RylCUO7IJpNLsOX136IM
 ZVlI8YXWimu0CqLkCsgOpcNBL1KzdoJ/9sJf435KVEW64W/qiVbi7OO1yzcqlJyffBQv5ccE
 L7BTxODDW2aulVMkUDvssRvGzS1cPsEViLGzcG39+QDKMNavMoxKnMN86aGkEiUFCBF/Bukm
 hzJSIGL7u5lyKVqx5DNFIcaDSqKCNrDbsa62yHtjMZrcvXOLtXrmz4Oj1vaYzRtIroaXupom
 YS3sNLY2F3PuJA0WTv7n6atOrZo58LoesZqKePycWdnmBWdVP/W4xcs/36yLbpLmoh/4uilX
 w6JV9uiR+UKWttyxGxnVAYGKkwzU5/IV6bHoT+xi9+uCRJHiAzOE46BxE/TNGpecncFBo36B
 grKoM2R39F/rrodNC9cUrsiS9V9LUT4UKQrS8zpuHPKRiO0i1eFof35mQBm9TjPDWKeHd3n5
 Y7eACLzbwm2pLqC2eQxX1aeZfHLJC0VbSgMkkMhFxpejjenECgZIO5bPZhu5lS4VMDt/MmQW
 d0PRDJK5ebBsfBsbhj2ptjuNutaLvJbIc/3f1TF4GvNAxpbx+q87H9J6SpqpXt7EtcmICdLN
 vlGkkDN0tONLl2FiArdCjFXQQuq+x8C+k81xA==
IronPort-HdrOrdr: A9a23:q/6NJahT2pUM3EpMkRE/D+qbgXBQXiwji2hC6mlwRA09TyX5ra
 uTdYcgtCMc7wxhI03I+OrwXJVoLkmwyXcY2/hyAV7mZniChILKFu1fBOnZqQEIcheWntK1l5
 0QEJSWY+efMbEVt6bHCUWDfOoI8Z296rmhgeqb531xTQdsApsQlztRO0KhCFR/QAQDPYY0CJ
 bZxscvnUvHRV0nKv+gH3EAUqz4q8bVmImOW29gOzcXrDOWhTekrIX3CQScw34lIkpy/Ys=
X-Talos-CUID: 9a23:1hpRVWC9LsWp9oD6EyhF1VwaSsUISTr+zzCXchXlGFhDcaLAHA==
X-Talos-MUID: 9a23:BhEddAT0YtLl2SAsRXSwuwBeP8BhupiyAX01lIUI6+Ktcnd/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,341,1677538800"; 
   d="scan'208";a="102902093"
X-MGA-submission: =?us-ascii?q?MDHanF5UKgjouOgXI9W+UrBQfXY6RvBY2RBu6a?=
 =?us-ascii?q?rianqka9UUiPZf4dWJyweA7Z9CKL6FzauJ8Ha/NugzZdnqVZrtm5bykY?=
 =?us-ascii?q?TzCeGrgrp/Js1eWuQQigiVX23qO+8WbEN84bfYf5Y71dZYs+2PiiZB96?=
 =?us-ascii?q?v2kH2JOdwWoiX5niUxHIllzw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 14:11:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681387852; i=markus.elfring@web.de;
	bh=f6nYDA5zDRXQnkwED6X9yup3CORZV103/yGCf4txjPc=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=tKjlRPdZjPKBAdf7fBm3uzaI1qFHgTU0nzidZX94t4vdiqa/NW4jLZkxTlIP81xSG
	 dMdSG4j2/TXRsWRlIKKRIIOuVztqMyD0pJVrUCMd1rkznj0ttY0kRwvnK1pkgBYDw7
	 99Nycmd5CjsgN41diirZPtzMDMf4RXlgh7jFfgJ3bM3u+TWPksJXDFoBl/yMnkFLSg
	 BuVjx7TeJNGvvcZh5Ri7dPF3bp5Z0FZbWcryODPkj+CsXRA1dZ+PHNH4cXfQhcxWZ7
	 vb/0Q78dkP5qz5eILH1bfBH/CGn/SlrDzMyZB05Eeo7Kcj15AhkDT/kRxetdC7bvFY
	 2mxeKp2t8R12Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mvbn2-1qbsVu1Z5C-00szHQ; Thu, 13
 Apr 2023 14:10:52 +0200
Message-ID: <46d8e10e-25dc-dfd7-3e39-92b86058126a@web.de>
Date: Thu, 13 Apr 2023 14:10:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org,
 sound-open-firmware@alsa-project.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Jaroslav Kysela <perex@perex.cz>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Keyon Jie <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Jl8V/9KAdzFRpvpfkQ77MacaWQTbsQVWDIxp9a6wDHu/uFJ6E0K
 wrnq8t9va+6xer9T+IgUPfTITJurni3ae6KdAmI2E+md4NCvSinWzw3+xvTc/RDb28CUj4w
 HNwdAU9Sim6wlfoLqbVFKie1SgubPls8/hPURw/Gqew3Lxco2rtWKomirG6tPQOVjlRtn4C
 htR1uE0iGve8rHfDMe2WA==
UI-OutboundReport: notjunk:1;M01:P0:1rUQBhxaU1g=;htIlgbUHh7Ouq5VoS3wyz8BV2jR
 ARn+fkYyic62xVTX7XdqFjZkl8s2ekhbbUQs91Ve177CSlIj4SYljG9CL5gCOxurZE4jD2cOT
 xr7aQaaQ2O4Gf0Rqtu9Uwl4a1SgRnPEU+5NjHOAINDCi2cSPRAIZNk6IlsPLfT9s2R7HZb1Je
 l6wrvL5c3nBDz9HQWxe6Ddl/UfbzSEEEgFcCWCOU9Xe0h9BMjRDCuY7RUve9sZdyZFI5+et1V
 7mBrHogZGTgrhgxUL/KGB73n14zdPabzkO97VkABEUK8LE1MnKQGY70ClmXdozcQvQl6jPW/c
 a2+E4aUi9lCosVTfn8lgTo/C5sCVjyumOBK4zQnjP8euEQSsRWYiqjRWd4fjOEjewFk7DpJUN
 zWSEQzdBMLGmwmzZpJ+BdEpY+2NFCiwlsoOLCBO1bqS9yOQUX4wEo+dneT5SL2IZgsYEQpbQL
 nYM6t+ApeMYnKQwL0xX+EDEAjY6Na9ADXL5yxYWNo6plCf9V6iptSDM4pIYfqmkj0819lrMmL
 tFkHxRX/7CayZASNnn7QA2QN5EL2s8A6lzX9t9ZykBYhEtBqME4Nv1wDIXyG8vOY5Xm2kYQG/
 iHCdO5ByR8tz7r9sGn6glElofiqa3/4eTKNau6Heo0/o7ZCA/z5n2Y1qrJ/qsslljc5MpRe/y
 IwJZWT2e2DSVsCa6Wg/g4QFzXdHF3HLPr1n8zXquONmevH4bTJr1ADI2i9rMtelryJJGs0dyo
 k8D4GdtYLLMRJ7pOe02RxImCqz7RIFFjqffGf1d+q0ezTwtdV8lNvDVvKS9BUcPfdbTJNRrzX
 tx70Y9SCJlgIixKGD83vhg9NOOdaEsjOgaFxo9/DoF6UomkUjPHKeuykO1SlJ6bcuWnMUSNME
 gOpV7452deRG7GiGBOonwrTf1mRBu+sRJlRF4QmhA65NAmmJuGOmmF7Vp
Subject: [cocci] [PATCH] ASoC: SOF: topology: Move a variable assignment
 behind condition checks in sof_dai_load()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1039
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/46d8e10e-25dc-dfd7-3e39-92b86058126a%40web.de>

Date: Thu, 13 Apr 2023 13:56:44 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Csof_dai_load=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the local variable =E2=80=9Cprivate=E2=80=9D behind some condition che=
cks.

This issue was detected by using the Coccinelle software.

Fixes: c5232c0171428f005a3204e1c264231fb5999b28 ("ASoC: SOF: topology: par=
se and store d0i3_compatible flag")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 sound/soc/sof/topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index d3d536b0a8f5..3fffe3826160 100644
=2D-- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1680,7 +1680,7 @@ static int sof_dai_load(struct snd_soc_component *sc=
omp, int index,
 	struct snd_sof_dev *sdev =3D snd_soc_component_get_drvdata(scomp);
 	const struct sof_ipc_pcm_ops *ipc_pcm_ops =3D sof_ipc_get_ops(sdev, pcm)=
;
 	struct snd_soc_tplg_stream_caps *caps;
-	struct snd_soc_tplg_private *private =3D &pcm->priv;
+	struct snd_soc_tplg_private *private;
 	struct snd_sof_pcm *spcm;
 	int stream;
 	int ret;
@@ -1716,6 +1716,7 @@ static int sof_dai_load(struct snd_soc_component *sc=
omp, int index,
 	dai_drv->dobj.private =3D spcm;
 	list_add(&spcm->list, &sdev->pcm_list);

+	private =3D &pcm->priv;
 	ret =3D sof_parse_tokens(scomp, spcm, stream_tokens,
 			       ARRAY_SIZE(stream_tokens), private->array,
 			       le32_to_cpu(private->size));
=2D-
2.40.0

