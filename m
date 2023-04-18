Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC32C6FD18
	for <cocci@archiver.kernel.org>; Tue, 18 Apr 2023 17:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=T+lJwG9My18Hd4Yud470jDvdiWa++FYJ2f4WTc4WvqM=;
  b=acuMTFCR5c1bDOw+f30wiMJG/4EKeOdif9iHmPTQJbqylXvaSjKPUf5F
   SUu6q47xwuKh8kPaFApVkQ7RgneLdSNvbBkhHd8I1PhGDV24O9UpBgZYX
   LDZi73/dS4KifHo7yTPzH+SneR4EmIexEtw3n+5P9XMc5HAvsa+gnA6em
   E=;
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
X-IronPort-AV: E=Sophos;i="5.99,207,1677538800"; 
   d="scan'208";a="103677853"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Apr 2023 19:49:00 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 15BEBE033A; Tue, 18 Apr 2023 19:49:00 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9F731E00A8
	for <cocci@sympa.inria.fr>; Tue, 18 Apr 2023 19:48:55 +0200 (CEST)
IronPort-SDR: 643ed807_ITtpr6PIRIzQiZfOQRTNBMkdfazmAuEW1yHQCkgNNWLiIgD
 bOUdZAzSgPNvYoPO1I0R8B8+mWsBpAoda1lMroQ==
X-IPAS-Result: =?us-ascii?q?A0FPAAAw1j5khwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYItgUsvBAtGhFORBTGEMIcuhz6EZ4QDgVaBQD4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEOIRHAoU8Ah0HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEB?=
 =?us-ascii?q?QECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARICRz4DAyMEGQEBESYBDx8GAh8HAgJMCwYBDAYCAQGCeoIoAQMxB6wvf?=
 =?us-ascii?q?zOBAYIIAQEGnAsfLCJUgV4JgRQtAYxaNoM2eicPgVVEgTyBFYIthAuEFIJnm?=
 =?us-ascii?q?mmBNHaBIA6BPIEEAgkCEWuBEAhqgXlAAg1kCw5xgUljTIF7BAIURA4YBg4lB?=
 =?us-ascii?q?A4DGSsdQAIBCzs6PTUGAwsfBlZrAgkjERMFAwsVKkcECDgGGzQRAggPEg8sR?=
 =?us-ascii?q?AxCNzMTBlwBKQsOEQNOgUcEgQt8CgYBJiSfESCBDoJ2wz40B4IrgVaBWQyfD?=
 =?us-ascii?q?QYTL5cJDgaSJS6FU4FfkBcgp381gTUNJoFcMxokgzZPAxkPjiAZHoNuj0g/N?=
 =?us-ascii?q?D0CBwEKAQEDCQGBVYNwAQGDJIJZAQE?=
IronPort-PHdr: A9a23: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
 HsmT7hGSBoqG/lcBkk3RLQ/
IronPort-Data: A9a23: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
 z0B0iWYAyVdCa2FiQreCjJXTAunKj7nKqo0xH3A
IronPort-HdrOrdr: A9a23:aHj2vqqxxnMZSIiAGaonYPEaV5r/eYIsimQD101hICG9vPbo8/
 xG785rtiMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLWvbUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAamSS5vyb3ODXKadE/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: =?us-ascii?q?9a23=3ACnN6FGrnTpyYLYbbMKhm453mUfJ9SyPP8U6AGlO?=
 =?us-ascii?q?pJUkwSZ+nDmCL97wxxg=3D=3D?=
X-Talos-MUID: 9a23:r0IEfQg0aaA5t74jyefi5sMpKMRGzqPyCkc3tZxZi+uvKXJVaybNtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,207,1677538800"; 
   d="scan'208";a="53689852"
X-MGA-submission: =?us-ascii?q?MDFCVHORyZv9X+4v3Fj5sgg4lz1fQKpjPF9qyz?=
 =?us-ascii?q?X+QIlcYKnOCn04ETkq2Eu6z01Z6+9N5buFEOoOMvXzYUUpTUfRkmPyVk?=
 =?us-ascii?q?NVVZmVYBbG2Qlzqsrzys0dDXJNzSuB51ldZyBB3Yv1tj17BCYMqbViPi?=
 =?us-ascii?q?f5eY2OUvyRGIe8GFf9RfEY5g=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 19:48:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681840134; i=markus.elfring@web.de;
	bh=GLwHwEnRfDWEZRzRT71l+M+1GjexQsfjaWOR2t70x1A=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=EX0vin9Xxj6KNBTuZFGSvfSbAKXF0U302ODthnTlaZiEX/XWCXHr218OdMVZD9w/4
	 xjXnnVLbU0IPdhugfj1mUrm0P7knEEzsRRjFtZjV24r9TLvF3R+1fzVv0swGG8U8nC
	 7svfKsYs7X9fjEYc38fPAclNgrU4E91Mn1a2NJyURrG9XGDxRwYKxCZnKB4QsXHneS
	 Rdnw0BOAeaQSaC82RgeSGYmg4k8DNQjoR1Jwan3328i9/pz8crCFt5pq9Aso0YEd9V
	 yf4yQ9YmxgcaytHuiljpAA49MREiZ1ll54DYDfs378OfsOCFGYdnqDHILv5fDQ/sLJ
	 poaZSV5CJlFQA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4KNf-1pp6Yx1vk1-0006Br; Tue, 18
 Apr 2023 19:48:54 +0200
Message-ID: <5d0cfa1c-7def-655e-0df1-10cd2dc1b447@web.de>
Date: Tue, 18 Apr 2023 19:48:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-media@vger.kernel.org,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <aa9d02cd-6178-036d-a785-c8d886dccacd@web.de>
 <6ba017ab-2d9d-623d-9b55-917d89bc7708@web.de>
In-Reply-To: <6ba017ab-2d9d-623d-9b55-917d89bc7708@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wuGXvWKUUinx5+Tnw6GVnxjHR2ZZSo2/uDIjYTGOXMj26jaEoqz
 mBGrt2UR93X0QhHBHD3sniAwux3fnl4bej9/TXasaBnnSC/+aqaEgE+ZxOaRb2L2Jsnk/HG
 EO6ubIrXI3rzy0McsTlt2dk5kwGw7odfjon7AibqRnOE1u2Jc8jIn+rStzO4xNNi0UIvSLk
 +twH1H5Q2CXCUDoFgjj7w==
UI-OutboundReport: notjunk:1;M01:P0:UN2iQre1bW8=;iqahsrJDCvZQjTRv0UNilPZY3Mv
 B0c1Xwg8kRM4PYtOAoC5LsgRVCwf+lG5ywFhdG6GzZxsbAzsGRyu8/sPR4WdytDvlvI+pJuIB
 kBB66Jevqzo9pc7rhzlM8VMG/BW+FwQ/CbHNRdfV9McmfzlhZFbDqOrhuNVyQNJQMIQhcnyQa
 ivbpOPHc5ZQlCTKkUy2Yb7gy/ylQnpjF8UXLaB75j0WHjSvA1oZHBGoehF+cbp3EGtpj6DfP1
 1EBfInBXzNyY3kcccsvZ0BkAuuPy5WR5qpLyqMYcacPtbzoVD/I5tnZpYRX9bcBUHixeCgoXj
 SdhEJ1U8gze1NPZXCxm10ZJJHGIb7J5b+4Fvhaz3PfRtrqADhVnWohvBLFg/ZABAG+EKe6bYZ
 xoIPunIiWa327vckMYS7EZzqQeqntDxAHpxyA1cDqDKRiufqmk8ryqnUrIDbgggeKm4piEtlu
 eHH+Z22v8DV881KEyxPWeoGMO/+jNFl7UwdIbz5P+K1MJAjr5kb4suTHNOazZBzZMg2MgnHNi
 RW3FnowC19jybQpPyjoKm9Ys2loL3tFVhXEZQ8PghLFnDchZVdzqoFnR/GgbuIentECf2rWEL
 AxuiLOMMd/fdOp9WBnWyMfHAadlf9uCnBzJMz6Anqu9zehdqhrDQI+NRLDTvMvfEw+mfg6A0F
 x/edkOmOh16RE0OnJQCiIVhpLCa2t+/7wX6SGy4FUQSlCIYwQSnQRMCtH9560eK0dXtGHb08P
 29TZ3MJwf9sQ9Apqptmps4LuKci44+vlsrs/t9SvihQVQo4nL+ygHk7Fo0N6Dz99JgvYDXce/
 r3mV0mC4u+cD7YRTcUKd0hEQIzTDpQjjaKyMrT8vLXgBDGHlpqR5Uma1Bml3aLuaxDyQOgJMB
 7MazZVw0Vw03YRcoDtcm1aie//p3H6IU/f/GGFQjLmXTrJkiL6yxMshE2
Subject: [cocci] [PATCH v2 4/4] media: adv7604: Reduce scope for the
 variable =?UTF-8?Q?=E2=80=9Cinfo=E2=80=9D?= in adv76xx_query_dv_timings()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1092
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/5d0cfa1c-7def-655e-0df1-10cd2dc1b447%40web.de>

Date: Tue, 18 Apr 2023 19:00:10 +0200

A local variable was used only within an if branch.
Thus move the definition for the variable =E2=80=9Cinfo=E2=80=9D into
the corresponding code block.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/media/i2c/adv7604.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/adv7604.c b/drivers/media/i2c/adv7604.c
index 4d0df7f325db..a693427e8f45 100644
=2D-- a/drivers/media/i2c/adv7604.c
+++ b/drivers/media/i2c/adv7604.c
@@ -1561,7 +1561,6 @@ static int adv76xx_query_dv_timings(struct v4l2_subd=
ev *sd,
 			struct v4l2_dv_timings *timings)
 {
 	struct adv76xx_state *state =3D to_state(sd);
-	const struct adv76xx_chip_info *info =3D state->info;
 	struct v4l2_bt_timings *bt;
 	struct stdi_readback stdi;

@@ -1586,6 +1585,7 @@ static int adv76xx_query_dv_timings(struct v4l2_subd=
ev *sd,
 	if (is_digital_input(sd)) {
 		bool hdmi_signal =3D hdmi_read(sd, 0x05) & 0x80;
 		u8 vic =3D 0;
+		const struct adv76xx_chip_info *info =3D state->info;
 		u32 w, h;

 		w =3D hdmi_read16(sd, 0x07, info->linewidth_mask);
=2D-
2.40.0

