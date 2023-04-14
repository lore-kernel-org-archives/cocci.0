Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DE6C77B6E
	for <cocci@archiver.kernel.org>; Fri, 14 Apr 2023 15:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=3WXCV1nfKknMfrc+s+6IR5VLQSRqgh4KXPHPDArwBBs=;
  b=LQ9KvsrLajZNXYwURdYipS6rm7BmEm/OvbinUNDMwnLCHrRemHSXwuT0
   imhIfd906rZDdiulP1VhV1qGhFCxswMS2lVymNCPC2cT7djICjPHLi4ZY
   +XRckSpZ2xLt+vg7b81yAPaYMvymXEHqcKdnAtpemekRp3vmsBnT/yA4T
   M=;
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
X-IronPort-AV: E=Sophos;i="5.99,197,1677538800"; 
   d="scan'208";a="103143705"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Apr 2023 17:02:37 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A05DBE7316; Fri, 14 Apr 2023 17:02:37 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7C26DE0171
	for <cocci@sympa.inria.fr>; Fri, 14 Apr 2023 17:02:35 +0200 (CEST)
IronPort-SDR: 64396b0a_Ot0p1WytIzTTxQlGuCcRZOUaVgK2gXAdNll5rdJj0O8qIgo
 i38N2iovf8AvQFTYplQVrsDKIBdfrjSwnJ98KaA==
X-IPAS-Result: =?us-ascii?q?A0EkAAA9ajlkhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIHohkLgOEMIcujCWEA4FWgUA+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBDiBU4J0AoU9Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBA?=
 =?us-ascii?q?QIEBQECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBARICRz4DAyMEGQEBESYBDx8GAh8HAgJXBgEMBgIBAYJ6gigBAzEHr?=
 =?us-ascii?q?yJ/M4EBgggBAQacCx8sIlSBXgmBFC0BjQqEMCcPgVVEgTwMgkdviB+CZ5F1i?=
 =?us-ascii?q?F4KgTR2gSAOgTyBBAIJAhFrgRAIaoF5QAINZAsOb4FJY0yBewQCFEQOFCUED?=
 =?us-ascii?q?gMZKx1AAgELOzo/NQYDCyAGVmsCCSMREwUDCxUqRwQIOAYbNBECCA8SDyxED?=
 =?us-ascii?q?EI3MxMGXAEpCw4RA06BRwSBCYEBBgEmJJ4lcgFSO0yCKpI7sQA0B4IrgVaBW?=
 =?us-ascii?q?QyfDQYTL5cJDgaSJAEuhzCQFyCnf4FjOoFcMxokgzZPAxkPjiAZHoNuj0g/N?=
 =?us-ascii?q?D0CBwEKAQEDCYVGAQGFfQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:xxxbkKsI2J4RpG03qppRuPqHpOfnVEZaMUV32f8akzHdYApBsoF/q
 tZmKW/TPv+Pa2D1fYx0bIS09BkAuZbRz9BlHgpu/ntnFHtBgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTrSCYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbyRFuspvlDs15K6p4G9B4gRkDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNz94X2mVTKlLjFVDmZkh+A8BOsTAezsAG6ZvXAdJHAathZ5plqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJEpvE5Eg4LlGPWxfy
 PoxKz80VCvat+3jldpXSsE07igiBMzsIZ9ZpXxqiz3UZRokacqaGeOQv4AehWp22qiiHt6GD
 yYdQR9mdhfdeFtiPlkNCZQxtPiljD/zflW0rXrI/vFnvzKPlGSd1pDGE+uEeoOra/l+n3a4j
 XLIwnzwPzwzYYn3JT2tqy/w2LaWw0sXQrk6H7qz/f9Cm0yW3mVVCRsMVFL9r+PRt6Klc9dYN
 lBS5Sck66Q/nKC2cjXjdxbhjmK8pEEtZ9dBLusT6w608JGN0wnMUwDoUQV9QNAhscY3Qxkj2
 VmIg87lCFRTXFu9Fir1GlC882LaBMQFEYMRTXJdE1BUsrEPtKlv0EuVE76PBYbv1oWdJN3m/
 9ydhA4a71n5pfwGyai9913djD+qznQiZlJquF+/so6NyARjeI7tTZah41Hd8Z59wGuxS16co
 D4blsLY4O1m4XCxeM6lELVl8FKBva/t3NjgbbhHQcFJG9OFpi/LQGyoyGsiTHqFy+5dEdMTX
 GfduBlK+LhYN2awYKl8buqZUpp6lPS5TYq/CKqINLKih6SdkifYrEmCgmbPgAjQfLQEyvFX1
 WqzLJvzVi9DYUiZ5GPmGbZFuVPU+szO7TqOGc6ilkrPPUu2PTDMAbYDLFaUaO0lpKqLyDg5A
 P4PX/ZmPy53CbWkCgGOqdB7BQlTcRATWM6qw+QKKL/rClQ8RAkJVaSLqZt/INMNokigvryVl
 p1LchQEkwWXaLyuAVniV02Pn5u0A84v9CNlbX1yVbtqslB6CbuSAG4kX8NfVdEaGCZLlJaYl
 tFVJJ3SMecFUTnd5TUWYL/0qYEoJlzhhhuDM2DhKHIzdoJpDV6BsNL1XBrdxA9XBAqOtOw6v
 +KB0CHfSsE9XAhMNpvdR8+u6FKThkIjvtxOcXHGGfRtXXn90ZNLLnXxh8AnIstXJhTkwCCb5
 jmsAhwZhLfsptYr/OnwmKzekYaNFtF6P0tFHlv06aS9Gjna81GCn65BcresVhLMWFzk/J6NY
 b1u8Mj9F/kcjnNmgpFZAZ8y6Y4fvvzB/6R7yCZgF1X1N2WbMKtqeCS67JMep59zya98kirof
 EC2o/1xG6iDYeHhG34vfDsVVPyJj6woq2OD/MYOARvI4QFs9+C6SmRUBR6HjRJdIJZTMI8Ix
 eQAutYc2zegiygFY8q3sSRJy1uidnAwcb0rlpU/Mr/ZjgAGzlJjY5uFBBTmv7CJSdFHaXcxL
 hGu2aHturV7x2j5SUQVK0Tj5+RmqK41iEh492Naf1WtsfjZt8AzxyxUoGgWTBwK7xBp0NBTG
 2lMNm8uF5qv4gVHuclndEKvEjFnGxe21BHQyVwItWuBVGiudDXHA1McMNa33nIy0jxjbB1E2
 oqH2UDZUTrOV+Pg7BsYAEJKhaTqco1sy1fkhsuiIfWgI7A7RjjU2omVemsCrkrcM/Mb3UHoi
 7Fjw7dtVPfdKyUVnqwcDrua35Q2TDSvBjRLYdNlzZMzMVDsQhOA8hnQFBnpYeJIHeLAzmGgA
 c83Js5vaQW35BzTkh8lX5wzM51Gt993wupaYb76B380g53GpBpTjZ/g3CzfhmgqftZQrfgAO
 r7hLwylLGjBqkZXyknsrdZFMFWWedMrRhPx98Hr/fQrF6AsivBNc0Yz3uGKvlGQCg9G/g2Vj
 izHdaT53+xv8qUyvorOQ4FoJRS4FsP3b8uMqDuMitVpacjdFOvzrCYXlwXXBBtXNr4vRNhHr
 7SBn9rp1kfjvrxtcWTmt7SeNqtOv+OeYfF2N5/pEXxkgieyYs/gzB8d8WSeK5YSstd85NGid
 jSoevmLat8ZdNdM9kJ7MxEEPU4mNJ32SaP8qQeWjfeGUEEd2DOaCuKXzybiaGUDexIYP5H7N
 BTPhM+vwdJm/bR8XEpOQ7ksBpJjO1bsVJc3b9C753HSEmCshUjEobf40wYp7TbQEHSfDcLm+
 tT/SwPjcAip8rT9pD2DX1eeYjVMZJq8vQUxQq7Z09txliz8E2MMa+gQWXnD5le4jQSqvKwUp
 hmUBIfhNck5dStJe1Pw7bwPmy+BU/cWNI6RyiMBpiuphuTfOG9EKKRs/GFs7h+av9clIP6Pc
 bkjx5E7AvR9LlyFiwreCjxXTNqLHs/n+08=
IronPort-HdrOrdr: A9a23:a0coxaoaJi6wxmPsBKIG7SwaV5r/eYIsimQD101hICG9vPbo8P
 xG785rtiMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLWvbUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaWSS5vyb3ODXKadE/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: =?us-ascii?q?9a23=3AXyj1ZmnK7GJpyp2lwwZh573sqB3XOXaE4mvoORC?=
 =?us-ascii?q?JNWt4dbu8SlCpwpg9o8U7zg=3D=3D?=
X-Talos-MUID: 9a23:8qM7JgXEEjgUxkbq/BTPtWBia+ZG34+vOGAmgZs7o8C5GAUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,197,1677538800"; 
   d="scan'208";a="53384240"
X-MGA-submission: =?us-ascii?q?MDEJNUriJXjvciPXUd6v6A/+PCcAEHnieDUecw?=
 =?us-ascii?q?X89VgHJO65/tJW2M0Ic5brpIXQy28KcBk+aDnVaCBto2T9IJ6mQdPpyt?=
 =?us-ascii?q?HKN7RGbZ6YAbc1wbUQLAIuxDXgmCeNbayy/EmOdAnMpx1043Fz5/p3iK?=
 =?us-ascii?q?CMi0U3aShX3eF3RspQ0TEr8w=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 17:02:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681484551; i=markus.elfring@web.de;
	bh=57NmuiGJ/jycFeNu25s3d0TG50v2VGtINKojNPu2A9o=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=XT3DfdIAdBfVyaV/qoEyZPJsEMvZxAOLn+mpDtSEJvxud2KgvBO3RMzyCElo0ndWD
	 4ZKVflf+W4g8b4Ina9rOPWuczcC8pQ8wqpDUElfMAKZYpdqOiDm7XwloS4EauNLUqW
	 L2nNN3jFiCxjh9ogCVf5pLhH+k9T+1A9m55GYwsCh0ommHugfMrn9U+8chD2/ukY+m
	 To2Y8TI51dtkPtACOYyn6KcDvwyl2PA8FwYMTJyr4PHRpdbSbinErXwPgOd/KJE//B
	 v8lmD3cJbyb6/mu7orHtA2YgepVLhoqoPXZSgpBzujOgXfIILllUUbyFxIwp32rdlf
	 RuhwN4LbBpjbQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4KJR-1pn3pO11Kj-000ADK; Fri, 14
 Apr 2023 17:02:31 +0200
Message-ID: <1137fa2f-3253-0f16-aadf-69166e11bd68@web.de>
Date: Fri, 14 Apr 2023 17:02:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-media@vger.kernel.org,
 Hans Verkuil <hans.verkuil@cisco.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lkaAgJG8K3zqOLlO4FfLUyjAzf9nSC+x+UID0omTNKBeBEFWABF
 8egkM4WaFNjZsr3CuSa/hTZvDpw15Qon7nqngqVqsfi31d/OsBuM+NqVHUaTfxP8zuPHuY1
 RUK4W2t5Ebw++cZkTVINO6JWKutUS23MoerL8trd6cnzrjySTPjdtrD9Spuif7Qr3iUwcR6
 55n+JGO8uPpd9y6fkFJdg==
UI-OutboundReport: notjunk:1;M01:P0:NqxLs2JN3ho=;WOVAQQnwIUvTTSMMFveTtTXmqHD
 sOCT/s+k8Uehb1KWOd4C4LI5TPsZy8xyMWt3GQVVmP6vXbPI+rpUDaqo2UPyMPlLxIWiYN9vK
 I/0UL4VOd89ZxQUgOnLeh1l7mzGFe+WmPh0Z/6gArWPeLrCWVMBSE+ZVY1URJkqzrB3kBRVHQ
 1OSJUoPHv164CXcatC5an367m7eQnPC1BIfzMAe5zMBvt1d1gRh5NcEgQTkxBIA2WF7JeYn/V
 bfzd7eqfW4fkUgongNIV9mG2WgoCdUYHSgNaznJMHizuuAY7ODRhURdvsKlVdp2xSkVWdK15i
 ekSssxe0HurUd9ZOuh9X9XHqGoj1LZX2zlKY+VEBtCfMMzHTTj7c2YZJ6KreIsNLQIJ/4G4YV
 +HLFEv6+xXw4GEeSExdhpYX6ATcNhTUvtSGTxCiSGxE+mzk+ksv76Gm+8EraxtqesLcJd/CRw
 Q5iK359C0jHD6wW7kcXN1ZLsDswWnrErZFQZOO9FrpNhxWnEhbCFaMkwk2YBObTkGZBu6XvZN
 3a21C2k8+6kzooZ8zYhn35bfoejJinD4vqiRMo46FSm9nWv0UWpGjYCM1pt89oXS8q7BRy48b
 JLnVJn1u2+TPQHuJTfM2+rlHfWZuiAilVbhONRz/Gxw6R2wmsGWxILZs3d4qbbZNyGxI7Jnbl
 wxWB9Pr9RJPZdo3AZAyg8HcCZ7FeU69E/PFROvR7jSTATogsys7YGS3VBlnMAGs/LTjmUXerc
 3Ni1wdgGpUVTFJr4Kay20LpAGZhw53s7hYokx/G830+J++nauR34QM2V0r6L+WSTMBe+gApcr
 HeBRAQHKa7doJ8I7+sBtbd1++jeR2jzLiDQ8wDCXD3q0xH1Bl525JWhWlepzZh3uXQzOpMI82
 FAxGexBhO2ePyQ6u//wpI/+dG2qpyxZ+hc8+ig0o0bPVyK1JZbbNEu5C8
Subject: [cocci] [PATCH] media: adv748x: Move a variable assignment behind
 condition checks in adv748x_hdmi_query_dv_timings()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1047
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/1137fa2f-3253-0f16-aadf-69166e11bd68%40web.de>

Date: Fri, 14 Apr 2023 16:56:07 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Cadv748x_hdmi_query_dv_timings=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variable =E2=80=9Cbt=E2=80=9D behind some condition checks.

This issue was detected by using the Coccinelle software.

Fixes: 3e89586a64dfd2860d596db0c84ec999d2eb5591 ("media: i2c: adv748x: add=
 adv748x driver")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/media/i2c/adv748x/adv748x-hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/adv748x/adv748x-hdmi.c b/drivers/media/i2c/=
adv748x/adv748x-hdmi.c
index 52fa7bd75660..28757a5efd6d 100644
=2D-- a/drivers/media/i2c/adv748x/adv748x-hdmi.c
+++ b/drivers/media/i2c/adv748x/adv748x-hdmi.c
@@ -274,7 +274,7 @@ static int adv748x_hdmi_query_dv_timings(struct v4l2_s=
ubdev *sd,
 {
 	struct adv748x_hdmi *hdmi =3D adv748x_sd_to_hdmi(sd);
 	struct adv748x_state *state =3D adv748x_hdmi_to_state(hdmi);
-	struct v4l2_bt_timings *bt =3D &timings->bt;
+	struct v4l2_bt_timings *bt;
 	int pixelclock;
 	int polarity;

@@ -291,7 +291,7 @@ static int adv748x_hdmi_query_dv_timings(struct v4l2_s=
ubdev *sd,
 		return -ENODATA;

 	timings->type =3D V4L2_DV_BT_656_1120;
-
+	bt =3D &timings->bt;
 	bt->pixelclock =3D pixelclock;
 	bt->interlaced =3D hdmi_read(state, ADV748X_HDMI_F1H1) &
 				ADV748X_HDMI_F1H1_INTERLACED ?
=2D-
2.40.0

