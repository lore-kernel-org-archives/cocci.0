Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504B6C77B73
	for <cocci@archiver.kernel.org>; Wed, 19 Apr 2023 18:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=4+YpQri5typIUPA8nGIZ1sKD6G9H8ynj7p9h/UoaInI=;
  b=XuSJWX2og5SDf9Ttt0M1FEsi86rqDF8W3gqjN1lZtQqHtR06XGl+GxW7
   8xazhYWLSP4055GaOWYalFnaFxMSpTO9TEbLMPhYhk6Sp+A3jX5blygcl
   8YnpdQutCymX+O25PaCkDhckljudUw+GaV/L/mI6NI8vKeCzdQ5/abAWQ
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
X-IronPort-AV: E=Sophos;i="5.99,210,1677538800"; 
   d="scan'208";a="103866221"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Apr 2023 20:55:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3F253E013D; Wed, 19 Apr 2023 20:55:48 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BADB3E004E
	for <cocci@sympa.inria.fr>; Wed, 19 Apr 2023 20:55:43 +0200 (CEST)
IronPort-SDR: 64403928_8KZblmia1zVNEyZnTv+twJQ+VEwx2sTHZq1wo/l8vzPiU1y
 szNSJt8M1e0Vy0K7pfkW8RQxrvv8H9mEeugKbwQ==
X-IPAS-Result: =?us-ascii?q?A0EuAAD5OEBkhwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIHYhoLgOEMIcujCWEA4FWFIEsPg8BAwENQQECB?=
 =?us-ascii?q?AEBAwQ4gVOBYIEUAoU9Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBA?=
 =?us-ascii?q?QIBAQIEBQECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBARICRz4DAyMEGQEBESYBDx8GAh8HAgJXBgEMBgIBAYJ6gigBA?=
 =?us-ascii?q?zEHq0l/M4EBgggBAQacCx8sIlSBXgmBFC0BjROEMCcPgVVEgTyDQoQrg3SCZ?=
 =?us-ascii?q?5IIiHWBNHaBIA6BPIEEAgkCEWuBEAhqgXlAAg1kCw5xgUljTIF7BAIURA4YB?=
 =?us-ascii?q?iAlBA4DGSsdQAIBCzs6PTUGAwsfBlZrAgkjERMFAwsVKkcECDgGGzQRAggPE?=
 =?us-ascii?q?g8sRAxCNzMTBlwBKQsOEQNOgUcEgQt8CgYBJiSeVHIBUigTTDCBepI7sQM0B?=
 =?us-ascii?q?4IrgVaBWQyfDQYTL5cJDgaSJAEuhzKQFyCnf4FjOoFcMxokgzZPAxkPjiAZH?=
 =?us-ascii?q?oNujwkBPj80PQIHAQoBAQMJhUYBAYV9AQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 RoiFrEc8/R/LlyFhQre2xBjvdpa+w==
IronPort-HdrOrdr: A9a23:zwlSe6+8Y6Qet3+6qgNuk+AMI+orL9Y04lQ7vn2ZhyYlFfBw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNWftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObOEYZmIbsS+V2njcL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3A2QC2DGg+ECcwRIMyqaz+aSWTaTJubiT7wi+KEk6?=
 =?us-ascii?q?DV0lbc+SxZXWy3Zxaqp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3A3Z13NQ554sl3Kt8DKNW6qagBxox3zKeREGUDs65?=
 =?us-ascii?q?ZsueOC3J6PCWTrBWOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,210,1677538800"; 
   d="scan'208";a="53798531"
X-MGA-submission: =?us-ascii?q?MDGvkERm1sWZodAQtlU3PBzaSrYh2cVXaNl+TU?=
 =?us-ascii?q?qHsJ+vqsRu4albfRVn2lciLxqo4yr6ixmSIdCyVkLLkezrl+gttDc65p?=
 =?us-ascii?q?zvw9hqTOd7l47HINRDlRBCgIB3rI3vi9NiGKtTkU3sh0tAoRcR7d6vnC?=
 =?us-ascii?q?xfKL27vV8RIDMNensayuS81w=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 20:55:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681930465; i=markus.elfring@web.de;
	bh=meyP3spM9CIaAdQR02aUCe+9EVd6Xh2od0/piibKCs8=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=NklUMVdgYNzfkcgyFD6bhDyQEEonJUvEwjztasQSKwPN0JpqhgjAlvooSVwyyH+Ui
	 QJAqzVS9hISNABomz/tQUxum32IzvLeBfC7ye018pkn1bQnqDrfkTJfGkXrVFSfs67
	 GcAJvmuIolC7E4QUWEhjtNbT0Akl5au4ETmugJjw1J7d/bLXYLVOU0SUtpB7Vq0o3G
	 bmiWK+UgwBOG4vNWGsw6HC68pMSxQ/qMEKfALIQi08TSWBrNw9iwak+FVJijMaeOtj
	 9XiqhKDbZSuO48e293p3yuWo8oVugq5bvTsN2Z1FJQi8l1LJMaz5TEEnMw0etaGPXs
	 4vzBSxFYWcihw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYtwy-1pkpCz2hmq-00Upt9; Wed, 19
 Apr 2023 20:54:25 +0200
Message-ID: <c18331ca-3de9-d433-f477-b04103958b9c@web.de>
Date: Wed, 19 Apr 2023 20:54:23 +0200
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
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IYQBToLg699SAsMkwtAw0odob9fWSTSNOHwQHRH447nzGR634WN
 QkFRK5byuGGDSossG2oXybajbF24CXmxUsCYV+MDL7sMhmeF3phvNyvQgxPGaIxSKJDmmVa
 Y4iB5VjQWMGetWgufQJOFC6dykYk7Ha/INdPSgh8TQnVRKodOtyO8BFfFhqBL279pG6PKlx
 pbTQVavszcavEQtQkL9+A==
UI-OutboundReport: notjunk:1;M01:P0:du4mSU0mPFo=;YlNUYiOYHd8/3bhCe2uueeIAS5l
 RETYmXtt3vfVVqbE0ciX29Qn3DigmJY8oDV+p4ILTJlb7IXHB351rgD3BA9LzMb44bv+cAs3T
 5yn/YEPEI/yyQWwDTDO3zQGzSBtmPwmKq59JJHyboLDEnbBfj/JPPGrnrQyzgm2892Ypu5Bqc
 fHkR6sOauN+7LNh57k8T12Rdj+3q2xKX/JPVoHp1j1L3oajjDTKFNP7zL5u6cUGx4FfxRS7kP
 1LmhN9So6FGDMX1BBZuh8801UUW5VTvWSL9v4Y0gcp3Duz1MmqKLRSqpVNRl+Vp6vyrpYCmit
 d/46tpOOfiM5q72LLrCXdnnUBgcu66K/8gtsewDmFTu69GW71UFZt20BBAdm+j1cxrmea38Ir
 pKjK++g3zJNgqqrKbJbGpUK1hbQ8mEFZ7lk4EHm0Vkx/WeWv7TN2s6KWy86NmD6Tf75eOetmo
 HXZrM9Rmd+YPzaj4I84hg6wwP2dEDbT8MeRk0kSr7NLZoFggjSql7tIZYy/AeuSbBkvSZzOqF
 n2Hw8BdgeERtzgKibiC7SO0Z5sFkaCQv8ze8UjvQQIliNMGBFjObGXRqOiiCL7DCfyKBM4hDm
 NUCwlMwdHQn0MkuuM8bH5lYeXMuS3dc9Yt+82a1qD/lZD/oltpPNhSlxemrPwAv0m8V3vZpSP
 eBLjo8orAaD8zIcIef6K+D0sDNYAUscnfeyMARNBhnolN39Jy6TWJHfmc+u9gBWgXMqzqiv/z
 TC7hCpg57Yli6TeVMAWbG7qCpUAWVj8zHWiu3tpy1oC3M3FoaNtXZlYBpwQXhzgiEciOAfFIn
 S6FKKb6o24/ynaWkSLS1izLrfKBgz61njpibp5XXcwcO0WOrGp6gIEzyiMFu2mPNuJmYOYEyw
 wfbmGS0upLzM5pUZ7KU9Cg47zRgR0GNZcp8bAS3dnt2yMF5yzCfNkMZm3
Subject: [cocci] [PATCH] ASoC: SOF: Intel: hda-stream: Move three variable
 assignments behind condition checks in hda_dsp_iccmax_stream_hw_params()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1098
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/c18331ca-3de9-d433-f477-b04103958b9c%40web.de>

Date: Wed, 19 Apr 2023 20:42:19 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Chda_dsp_iccmax_stream_hw_params=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for three local variables behind some condition checks.

This issue was detected by using the Coccinelle software.

Fixes: 7d88b9608142f95ccdd3dfb190da4a5faddb1cc7 ("ASoC: SOF: Intel: hdac_e=
xt_stream: consistent prefixes for variables/members")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 sound/soc/sof/intel/hda-stream.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-st=
ream.c
index 79d818e6a0fa..9c44127014fc 100644
=2D-- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -407,10 +407,10 @@ int hda_dsp_iccmax_stream_hw_params(struct snd_sof_d=
ev *sdev, struct hdac_ext_st
 				    struct snd_dma_buffer *dmab,
 				    struct snd_pcm_hw_params *params)
 {
-	struct hdac_stream *hstream =3D &hext_stream->hstream;
-	int sd_offset =3D SOF_STREAM_SD_OFFSET(hstream);
+	struct hdac_stream *hstream;
+	int sd_offset;
 	int ret;
-	u32 mask =3D 0x1 << hstream->index;
+	u32 mask;

 	if (!hext_stream) {
 		dev_err(sdev->dev, "error: no stream available\n");
@@ -422,9 +422,12 @@ int hda_dsp_iccmax_stream_hw_params(struct snd_sof_de=
v *sdev, struct hdac_ext_st
 		return -ENODEV;
 	}

+	hstream =3D &hext_stream->hstream;
 	if (hstream->posbuf)
 		*hstream->posbuf =3D 0;

+	sd_offset =3D SOF_STREAM_SD_OFFSET(hstream);
+
 	/* reset BDL address */
 	snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR,
 			  sd_offset + SOF_HDA_ADSP_REG_SD_BDLPL,
@@ -459,6 +462,8 @@ int hda_dsp_iccmax_stream_hw_params(struct snd_sof_dev=
 *sdev, struct hdac_ext_st
 				sd_offset + SOF_HDA_ADSP_REG_SD_LVI,
 				0xffff, (hstream->frags - 1));

+	mask =3D 0x1 << hstream->index;
+
 	/* decouple host and link DMA, enable DSP features */
 	snd_sof_dsp_update_bits(sdev, HDA_DSP_PP_BAR, SOF_HDA_REG_PP_PPCTL,
 				mask, mask);
=2D-
2.40.0

