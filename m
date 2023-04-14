Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCEFC77B71
	for <cocci@archiver.kernel.org>; Fri, 14 Apr 2023 16:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KeFvc3FlxN2D6GWyjWHFQyEfPG57SVDLYKZEEaUYWSk=;
  b=a3nS0z8wosgeNahRsPGGvQqVmzsHnBcwCHLWrici57NT7IR1c4UYe47R
   6OSlO5Z0X/Ubz5Z+cskqCA4l2Gl/UNHb3GOlVhckap6aS2RQN1B27S2TK
   yg0/XujZfuYMsp+d9l6O1PZ3Ycru44f/PV2c5gHksjjBPa2k1fL0LgUIX
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
X-IronPort-AV: E=Sophos;i="5.99,197,1677538800"; 
   d="scan'208";a="103158372"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Apr 2023 18:30:33 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B7AE9E7315; Fri, 14 Apr 2023 18:30:33 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 66E3CE0171
	for <cocci@sympa.inria.fr>; Fri, 14 Apr 2023 18:30:32 +0200 (CEST)
IronPort-SDR: 64397fa7_srzCKhmgDJFXjIcA06YNmkFIhtFbu7nEFrZQEkWf6pV9+Pp
 xlj29pccP3JFjwVXlmsEm7zxdvrzWswK2RmOU4A==
X-IPAS-Result: =?us-ascii?q?A0FTAAANfzlkhwMP49RSCBwBAQEBAQEHAQESAQEEBAEBQ?=
 =?us-ascii?q?IE9BQEBCwGCLYFLLwQLRoRTkQIuA4QwhXWBOYwlhAOBVoFAPg8BAwENQQECB?=
 =?us-ascii?q?AEBAwQ4gVOCdAKFPQIdBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECA?=
 =?us-ascii?q?QECBAUBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQESAkc+AwMjBBkBAREmAQ8fBgIfBwICVwYBDAYCAQGCeoIoAQMxB?=
 =?us-ascii?q?685fzOBAYIIAQEGnAsfLCJUgV4JgRQtAY0KhDAnD4FVRIEVJwyBCYE+b4QLE?=
 =?us-ascii?q?oQCgmeRdYheCoE0doEgDoE8gQQCCQIRa4EQCGqBeUACDWQLDm+BSWNMgXsEA?=
 =?us-ascii?q?hREDhQlBA4DGSsdQAIBCzs6PzUGAwsgBlZrAgkjERMFAwsVKkcECDgGGzQRA?=
 =?us-ascii?q?ggPEg8sRAxCNzMTBlwBKQsOEQNOgUcEgQmBAQYBJiSeJXIBUjtMgiqSO50Ck?=
 =?us-ascii?q?340B4IrgVaBWQyfDQYTL5cJDgaSJAEuhzCQFyCnf4FqAjGBXDMaJIM2TwMZD?=
 =?us-ascii?q?44gGR6Dbo9IPzQ9AgcBCgEBAwmFRgEBgySCWQEB?=
IronPort-PHdr: A9a23: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
 PLmpZdEWVZzGv5IUyxY
IronPort-Data: A9a23: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
 R3yN5E+0tVdAn2keArL2sGGvA==
IronPort-HdrOrdr: A9a23:3AEsGqxoOiJ5NUKJz5Y/KrPw+L1zdoMgy1knxilNoNJuA6ulfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bBYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebnN5DNB7foSjjPIduoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: =?us-ascii?q?9a23=3AgbgqDmrUsM/Ggy6/ghgkmFPmUd19b3SFwFuAGUi?=
 =?us-ascii?q?pFmdzbOOxdEKP47wxxg=3D=3D?=
X-Talos-MUID: 9a23:WksgLQiyGBYDvcNHkReoesMpboBp566NL0Uxg6om6/aiaSt0OxKcg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,197,1677538800"; 
   d="scan'208";a="103158368"
X-MGA-submission: =?us-ascii?q?MDGeX9PiFCt4kA5IXFmp8Fw+ItHCT5zaONl/pV?=
 =?us-ascii?q?Ptua2LmAVbESN/E3BRF+Q5TzPKDlLLoltXuRDPoJiLygBcgvYJANiQFr?=
 =?us-ascii?q?gJmrpQDKlsC/Be+ScT5NLG25cHCfSGj5R/L5TQeImidmzlp4GucwIsUR?=
 =?us-ascii?q?DeOAMloHUnq41W1qPJFpy32A=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 18:30:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681489831; i=markus.elfring@web.de;
	bh=d6kaXZM5dIRu75L68i+1z8XvTZWvHhUtR8gydZK8/YY=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=gnzIfhFUB9DgBwXAr0llj5Pq0qquMLJafgxPmhOgqdLnchlBBEndyd3FZX5L4iJsF
	 gHfxO/Q/r/+NdUAvY+QbB6siP/vtoQhAPypOk1TARYyr9HZaGC83poFDWI4QwyL8Re
	 JMjlS1FMjW2M/Y+zG4CBY9Q/y4ttKS2W5aBuy5ohty1r/vyuubZT3Ohvc/ZSgSon77
	 hPYZj5gyLVn4KAjSu2U13IG1FO8dES6rropzlV+NYfNtmEjkrmIH/CVK9EqZdQQr7x
	 hZqH+hkFPOyLlVkJ8zxpdu/uMBGicnI/+Mc/9LzlCwvmIka9UCo2AhJxOQANMhQA8f
	 fh7Iawduc/AMQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2BI2-1qUpDd1SAQ-013e2y; Fri, 14
 Apr 2023 18:30:31 +0200
Message-ID: <aa9d02cd-6178-036d-a785-c8d886dccacd@web.de>
Date: Fri, 14 Apr 2023 18:30:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-media@vger.kernel.org,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y3McYZ7k8XAm8lUU+xhe3Jz7krAtuLqGaO9OF03lDni8TXd7JB0
 5F9MSB6pNnv4vgahKgM6BOJ0VF14azVkc+jE1PF+NcHmpqgIUBaJnoGJiONDiFhkhTj85lf
 aCtCLuedMTqt68jD1fMgY3+0f+aTfKRn4LB/IJe+UDoq/o80YITuHLqbKjSjHIcnnt0cMDA
 X/3j26CaMjsEYOaDo+cBg==
UI-OutboundReport: notjunk:1;M01:P0:ietHPioanBs=;WmrZifGDqwkydl9tHYDwm45d+K0
 R/BPgZEa8+P+wwg3yQ1pYe19dfAvoHr5k313qM/FYGSDXhayZZ8T8251RT/Bhc5PRIgeSV99v
 7VkXi7GP0yIZAwVH2EV36WlbnyDgktFwB58t3Z/qyEzf19ArlY1ooHpBVAAtl4bKuiUDZzmn9
 zeCSuGNoHI2cpEEu1RQvrPlsisRewtVqDPyCCCfK/yAO4LsKhq/r4qwCxcXspYQsI0uJkV1xb
 RTCuAlnnV9pPPZ2boNy1/mU1B+eoKtmLLflUm/prvtKEbiBQxFHTopfkBBcnE4XeQNfR3q6qB
 sBfsUf+Wjux7NEHJE5XR5DMRVSyDc1uFqaUtq1Ciu+M35DayEPvR50L5w+Xp21S4bUhUnJ+V+
 WvUpeE0QLwMkIqMGEmEGI0tIB4m59PKIXROWbQkmraUbSW9Omdla6EgIEsZrx1NP4ekUxm5NU
 BxnMAu+D89VScDbbjeWHn/PADSv77xpGCuLVKUe3SICWXlcjwSJkogW/5yGQbfnZH1sgacAFV
 3Y5ikg9QBDFA3/mADZaJxQ4KpViAfkKoHi+zfrboCugF9tv9MrjVuPF9I8R0R+ONCb79HzsfK
 Yr3NrLDC6y6THK/oPnT9O2vgYFK3CxwpBpguspcdpqQm/XIsrLw66jqlI/7AAly2hKOK2Nt2u
 izo6xYrFPpNA82hkIdHwp+/6SPDWQ8RzUrfSutR/3NKWLa+CdtMf4Ku6GcwfreLArfouUJbiv
 vaDy2MvIpcb4vkO1IvCb6vomf31XDv5F2a9ysOpNGXogr8Z6WdLpAG+yBQyiCffR3yONPqUvX
 7SvLBkwdMjZYf+yi7DBZ2ZRBtmUgzRv/8TMZmu7vN6MY8e1zx/w1Z5LnRHopfckyrYtD+LrAu
 RM+eyvdgwpaZ20CSTNtJssIIwGf2Mr/LNaUoAX7eY5TvBcnufUC11WoJc
Subject: [cocci] [PATCH] media: adv7604: Move a variable assignment behind
 condition checks in adv76xx_query_dv_timings()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1048
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/aa9d02cd-6178-036d-a785-c8d886dccacd%40web.de>

Date: Fri, 14 Apr 2023 18:26:08 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Cadv76xx_query_dv_timings=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variable =E2=80=9Cbt=E2=80=9D behind some condition checks.

This issue was detected by using the Coccinelle software.

Fixes: 54450f591c9927496b3d41c041fa802d0ef96885 ("[media] adv7604: driver =
for the Analog Devices ADV7604 video decoder")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/media/i2c/adv7604.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/adv7604.c b/drivers/media/i2c/adv7604.c
index 9d218962d7c8..ed4ec2151d68 100644
=2D-- a/drivers/media/i2c/adv7604.c
+++ b/drivers/media/i2c/adv7604.c
@@ -1562,7 +1562,7 @@ static int adv76xx_query_dv_timings(struct v4l2_subd=
ev *sd,
 {
 	struct adv76xx_state *state =3D to_state(sd);
 	const struct adv76xx_chip_info *info =3D state->info;
-	struct v4l2_bt_timings *bt =3D &timings->bt;
+	struct v4l2_bt_timings *bt;
 	struct stdi_readback stdi;

 	if (!timings)
@@ -1581,6 +1581,8 @@ static int adv76xx_query_dv_timings(struct v4l2_subd=
ev *sd,
 		v4l2_dbg(1, debug, sd, "%s: STDI/SSPD not locked\n", __func__);
 		return -ENOLINK;
 	}
+
+	bt =3D &timings->bt;
 	bt->interlaced =3D stdi.interlaced ?
 		V4L2_DV_INTERLACED : V4L2_DV_PROGRESSIVE;

=2D-
2.40.0

