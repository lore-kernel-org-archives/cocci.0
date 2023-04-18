Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699AFC77B71
	for <cocci@archiver.kernel.org>; Tue, 18 Apr 2023 10:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6zfF4qkQrppPIntgrkLxo/StwsBkwU5A8cH0Sy1P/UM=;
  b=CunIt4LX8eXmFZFME/uWSja/Te5+ts2l9zle9VliFaPmqpwaBsREiZDz
   abHyV3K1dhsjJfkePnXbmwwJh69Z9csT6BzTywNrVddaCnRpKw1EoDVRS
   5yLbm7ZDFxBIjvrumiJg2ngIcJkn5eDsPWd6naHLaCqKd88e92GglfbKu
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
X-IronPort-AV: E=Sophos;i="5.99,206,1677538800"; 
   d="scan'208";a="103584742"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Apr 2023 12:02:35 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8B23AE033B; Tue, 18 Apr 2023 12:02:35 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E878AE00A8
	for <cocci@sympa.inria.fr>; Tue, 18 Apr 2023 12:02:25 +0200 (CEST)
IronPort-SDR: 643e6ab1_axftArZmmZfwBTBCp1RBLNF4NjZuQlVy4X+2PudJE1LKLA4
 OJmkw7+qwOc6h0plGVY1yV18vXZ7z8mKZqMfcCg==
X-IPAS-Result: =?us-ascii?q?A0EOAADyaT5khwQP49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBOwYBAQELAYItdVYvBAtGhFOIHYhkMYQwjmyEZ4QDgVaBQD4PAQMBD?=
 =?us-ascii?q?TsGAQIEAQEDBDiERwKFPAIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBA?=
 =?us-ascii?q?QECAQECBAUBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQESAg06PgMDIx0BAREmAQ8fBgImAgJXBgEMBgIBAYJ6AYInA?=
 =?us-ascii?q?QMxBwysJoEygQGCCAEBBoFAAZpKHywiVIFeAwaBFC0BjEs/gzZ6Jw+BVUSBP?=
 =?us-ascii?q?IJTb4gfgmeaKUWBNHaBIA6BPIEEAgkCEWuBEAhrOYFAQAINZAsOcYFJY0wfg?=
 =?us-ascii?q?VwEAhREDhgQJQQOAxkrHUACAQs7Oj01BgMLHwZWawIJIxETBQMLFSpHBAg4B?=
 =?us-ascii?q?hw0EQIIDxIPLEQMQjczEwYFVwEpCw4RA06BIh8GBCRnfAoGASYknFGCZAGBD?=
 =?us-ascii?q?SxQgXrDPjQHgiuBVoFZDIoNlQAGEy+XCQ4GkiUuhzKQFyCLRIFvmkyBYzqBX?=
 =?us-ascii?q?DMaJIM2TwMZD44gGR6DboRhimc/NAI7AgcBCgEBAwmFRgEBgyYtgioBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 u3yNpE90tZdD32pqSsuCiSHvNpa
IronPort-HdrOrdr: A9a23:Pkq9dayBy4pOWGdllwxfKrPw+L1zdoMgy1knxilNoNJuA6ilfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bBYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebrN5DNB7foSjjPIduoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: =?us-ascii?q?9a23=3AQQ3Fr2vI1snBklovtNYmO+996IsOYyX75lzyD3S?=
 =?us-ascii?q?YKjdlaIONYmO51qlrxp8=3D?=
X-Talos-MUID: 9a23:nwIzjAql1G87s07zbXwez29uJN01woqIMx0My44dktKraQlgNB7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,206,1677538800"; 
   d="scan'208";a="53642284"
X-MGA-submission: =?us-ascii?q?MDH5m8Hn3wfgodWRUWuou0TbJ45r/mdYgrmAWN?=
 =?us-ascii?q?TYqb7raS9C2NXRPvoqmI1yH5UWkGYOgVZ7K663SqNeFqou3TpJBQr8OM?=
 =?us-ascii?q?v2r8BD63FkV7y4VF1NKtgzwzTtcDpySSWTO5IW3sKaAXxWhrNwZ8y2SL?=
 =?us-ascii?q?ir5BfdA6d8jMjHZJVt9K0tgA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 12:02:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681812139; i=markus.elfring@web.de;
	bh=fLSFT9v+iTWya2/XO9XySCNXu7S5c07pMbzP+9M0jXE=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=s4GL6pbyARsZXULms6G6Kbc1m35oACnS6UabFEWVs2Kag4IGWfbZYzyAoRnwXh6LS
	 oFHlprMFloXV36eOjaKwsGhy5KsKzje4dNKEZ48pEsHmGQ5joWd3qD1YCF7g0Kh8z4
	 LHppAsGSTe6EmyPVGInaU7mCDBBI7OS5P8henJYflazAbkygAIJt51pQvD2p4cAQLk
	 h0fyrZR0HKZWLF8fe3H20ALg9sos30gV09iD3GfUfLPBwNAmZQWcdlta7nJhF6haxZ
	 D0F+kb7Mq9Dam+7KjjCmTDHOG4q5Lf7o8WB05APtjW5L3pb45t1VgE/jE7r6RUj0YD
	 ZLBSKT0R/hGOg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mf3ug-1qGu2r1weA-00gcnV; Tue, 18
 Apr 2023 12:02:19 +0200
Message-ID: <fb22f604-0a99-898b-8d4a-f529cf61b392@web.de>
Date: Tue, 18 Apr 2023 12:02:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-media@vger.kernel.org,
 Hans Verkuil <hans.verkuil@cisco.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <1137fa2f-3253-0f16-aadf-69166e11bd68@web.de>
 <1a27c4c2-5e44-c399-9092-a36c12ee20bc@web.de>
In-Reply-To: <1a27c4c2-5e44-c399-9092-a36c12ee20bc@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UDo58TILdpW7nwUxQCFsr8m0lGKiSmuF9hMnodq2/vlW3HTI2RQ
 x4UId407AvbSyLvdC4R28HbvJtY9SP12c8Q76qvr7Fjof0nspNKM+GcJWWAn7lzUz3vqdOn
 NlNv7A/9QeJHzCt4O8HRmbexgR+LeCJp4aY5i0UXvU5Nmy30osp0XWrPop7CJFFV+Gm2nKY
 LQqrtYoLYvBK5WKbn2aCw==
UI-OutboundReport: notjunk:1;M01:P0:wfPez0vAEPo=;ele/SsOioIqWOPWinURxyiHsIGU
 bH3XeZR0mR84Y+bfqkO5s48H1BD6uHl7bKTR07rhPYOniJ9wzK2xh1RcNV0cefKeV7hGrmV5N
 92v6GV/YFXEdzRemZILcMHvGBIaTwzYGFq2BTXMAfimARdReGuI3CKa7iukmKF6GOuLGqCwov
 VjwwTGzYy8JcyGltXPIoOQaqPpFMukS6Z24G6Ytft+2xZdx1vWR7ts9E/nwJuSIsC3yuJnw4l
 9jrgP4WZbvIEPPhjeLRbYTnrwdyCZDjshcF62XAqLpI154O4BPeb7em/cEFrJmo4UJW3OuQqM
 UYfXgOBN/sYYqmPZxNcgLznmnPPAsLHUtrQ+ViaGnUR1jbApZVJHzG9Rpah9Oynb84yVodKMT
 yyanyc9oDfFCI5awUwFe3Xf/NM/JTFzyGmdSBonxmyPIzbFHMl7S973aMIrk4psJe4lTo2rIa
 IDBzvivmZ0+GjH910/OHD46m3YAGqxLCTBXomvNliW+qCy5Q9JNb/R6qfPuySBjPNQzoAAByG
 7DC5wsLKh6YUaoYG990P/8C6oCuxTU+d1lqPz0BEK5H/D5qT4jb3oNN0jdayyZnXhl/bXFDeH
 8DmLBJbTMW/lUYiVMJrOCZE68Jh2n54t3bwAjWsZTyavlQFm4XH4vXp1VTy/JL6HlYu26K4ld
 M+SKGZdrkTCGa3iQd5Syrv8qOdAZtCKqJQ8yPI99MsM5tS2R3l8WiAKC4FaWqJ0ZYpwPqWhpF
 WcpN7gsN0WZPoUIFGdJKJaTOLvd6WHTC9DpK3iiFgr9wvkywOHcsadc8D9LKjgMcMuJp2RICr
 KRJn3PjVGmCFwxBIvv9Q7bavjMlIYi0ZvstSpS2HD1tk8nqnCxDwtkACOXy5/CzFIs2m9Qi5V
 Z8SmI1AlM1XZsDw3K/IEsVGx5xnABvMbIMwkb6I1egTXe7aCtfzPTc1oL
Subject: [cocci] [PATCH v2 1/3] media: adv748x: Delete a null pointer check
 in adv748x_hdmi_query_dv_timings()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1085
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/fb22f604-0a99-898b-8d4a-f529cf61b392%40web.de>

Date: Tue, 18 Apr 2023 09:11:39 +0200

An extra null pointer check became unwanted
for the input parameter validation in the implementation of
the function =E2=80=9Cadv748x_hdmi_query_dv_timings=E2=80=9D.
Thus omit an if statement at the beginning.

Link: https://lore.kernel.org/kernel-janitors/8153cc88-2cea-0528-9d54-bda7=
2cbaac5b@xs4all.nl/
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/media/i2c/adv748x/adv748x-hdmi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/media/i2c/adv748x/adv748x-hdmi.c b/drivers/media/i2c/=
adv748x/adv748x-hdmi.c
index 400d71c2745c..b10263f4c0c0 100644
=2D-- a/drivers/media/i2c/adv748x/adv748x-hdmi.c
+++ b/drivers/media/i2c/adv748x/adv748x-hdmi.c
@@ -278,9 +278,6 @@ static int adv748x_hdmi_query_dv_timings(struct v4l2_s=
ubdev *sd,
 	int pixelclock;
 	int polarity;

-	if (!timings)
-		return -EINVAL;
-
 	memset(timings, 0, sizeof(struct v4l2_dv_timings));

 	/*
=2D-
2.40.0

