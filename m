Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB32C6FD1F
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 14:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=FAJG3QKfGjbSm3Qdih8pQxR2b0NGaOrjUWpzHcT243k=;
  b=V5UhdVwckZ06jq6tFzzXdAvIJXwkG/g/JIaJjm663ZrH1jtzPcf9HHFo
   YcMxBatkFNy8EXbBBSdGds8m6gEpKRjvGbQXmN4b+KBV2ntiwgIa5FsH2
   9B0Tdeb7HPexhAZaqmQvDdTTMs90njgCpE1iRrsBSeGo4rTlXSayGlAl+
   A=;
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
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99065917"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 15:08:00 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 45039E0D42; Sat, 25 Mar 2023 15:07:59 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5941EE0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 15:07:58 +0100 (CET)
IronPort-SDR: 641f003f_/OSJylEJOTBSCgtrFLrzkMyZZ58xDuM2mIE+HwfIgp0Ey8/
 NefsQOjzT6EuFmuYT0Y6XiqpjKqcZkDpALfiJ7Q==
X-IPAS-Result: =?us-ascii?q?A0EdAADv/h5khwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIH4hiLgOEL4csjCGEAoFWgUA+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBDiBU4JzAoU6Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBA?=
 =?us-ascii?q?QIEBAEBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQESAkdTPQMDIwQZAQERJgEPHwYCJgICVwYBDAYCAQGCeoIoAQMxB?=
 =?us-ascii?q?7E0fzOBAYIIAQEGgmOZJx8sIlOBXgmBFC0BjQSDNnonD4FVRIE8g0GIHIJng?=
 =?us-ascii?q?iiHVocliC8KgTR1gSAOgT2BBAIJAhFrgRIIa4F9QAINZAsOb4FKAmRMgR4lB?=
 =?us-ascii?q?A4DGSsdQAIBCzs6PzUGAwsgBlhrAgkjERMFAwsVKkcECDkGHDQRAggPEg8sR?=
 =?us-ascii?q?A5CNzQTBlwBKQsOEQNQgUcEgQqBAQYBJiSacQIBgkcgAVI7TCaCBJJYkkCeD?=
 =?us-ascii?q?jQHgiiBVYFZDJ8MBhMulwgOBpIjLoctkA8gp3qBYzqBXDMaJIM2TwMZD44gG?=
 =?us-ascii?q?YQMj0dANDsCBwEKAQEDCYVGAQGFewEB?=
IronPort-PHdr: A9a23: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
 AE7gE1ybLZ1nN8Dy0g6LBzGqXlp+HQ=
IronPort-Data: A9a23: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
 D3eFrDN0sCN/6xU
IronPort-HdrOrdr: A9a23:NDw1n6F6Bpch220jpLqEPMeALOsnbusQ8zAXPo5KOHhom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/hyAV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs9D4bbLbWSS4/yKhTWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99065913"
X-MGA-submission: =?us-ascii?q?MDFLnD28Jxwh0nZP4bWHwJ5H5lJui4eb7IBwph?=
 =?us-ascii?q?DvNEKVEIKqTQ9ZjMK5lEZyG8PdH8hdy4310MlrRU5ISV/esfd2Vy6T9O?=
 =?us-ascii?q?E0MFAmmqGZUEadPv+6GwzZOSn5R0WGKpLyGxJcSRtOZaWpcSNVBCKHG7?=
 =?us-ascii?q?lHLnpfuizOPIzZU1rX8ZEVlA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 15:07:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679753275; i=markus.elfring@web.de;
	bh=OYODff41nifZb+8HMbixwFWZeEaw0rpy0IzNNG/XRR8=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=LqrXKgFBZ77GpQPcVRtsGDPQ19SftOk7hthH5izqh1x2P0pzD9tLSrwZRemSdj4P7
	 E1zwFSh4ffV69zd131aNV4XYbGrNeI9pD0Hd/WTbmc5hmmGtv87rv568NmT0ut6pEs
	 +dWP50dvEju50Uc/DXOKiM7QFvutG+riw0gF0mSDH/V7Xy0SRiFdGLekgmP5SCGXrR
	 lkHE/IqN3M2Va23ftaLgOy2HzOwD8hxl2jbecSB1D8MwWQqO5IsNHimb8jqvxw0D/S
	 qxgg++kOd5aZcieIuMfAWaXgZ6Yilb4FI+x4ZnvVnvDEU2if6DawjQXIQlWWmvy8/y
	 Mzh74cLeZH5yA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzCA3-1qRs7M1MV1-00wFiU; Sat, 25
 Mar 2023 15:07:55 +0100
Message-ID: <941709b5-d940-42c9-5f31-7ed56e3e6151@web.de>
Date: Sat, 25 Mar 2023 15:07:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, drbd-dev@lists.linbit.com,
 linux-block@vger.kernel.org,
 =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Jens Axboe <axboe@kernel.dk>, Lars Ellenberg <lars.ellenberg@linbit.com>,
 Philipp Reisner <philipp.reisner@linbit.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <8d193937-532f-959f-9b84-d911984508aa@web.de>
In-Reply-To: <8d193937-532f-959f-9b84-d911984508aa@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EX3CdjLZiBaTSeuHKpmza9MbCEah6E1+RyxQ0U1zGy9E5XBkqnQ
 KBYwCuTevW+vVlgcqNAs4ib9NHg/J9RjWRLHxVO353Lmgq6byW6yLfSyt7F8uN32LDIVssv
 /4aabmdG7jRUXvi6KxMMcunJDE8Yo8+SmFDxVphdCsOD9NYZ05K7ag1oqD4POGhZ1HbWPA+
 TZOIawUirrnSXwEGtrRtw==
UI-OutboundReport: notjunk:1;M01:P0:jBICtmCc/ZU=;JgLIn+egOY4QsU+amJ9NHpgGT3H
 cj08g5wYbvVBN7i3qhaHfFeMbpfPNW2d/K/PIOWH7zxroC+FD5t18JUcoGAjAPNJDPXLcNt3B
 NbpC7suEwHoTniW9YQeqvizRlBWyILq6BXVIdlygg9yHM68nAjmHBJXmLh2of3T7OCEUlaIoG
 q3m76DF3or4gyd5bNiOcPeyCl4RC+zLKTr4eWpHfrNbV39M3xx6RSr0oVHHmqAf+aibaPHWnW
 w3Igb6+YEhUIXcO8YwU8nvqc9ACtvnOuuG9rdJiAWLxq3CkNoYRZztRvw2zZ2S9vojyjRThG5
 k6DeiSDORjrs5U/+8qOC2NQdXSgqeqJ+xHhzAv6PhEW5N1fs1u1ba/10BEFQoUUuUQBgzeCkg
 FXv0EOCoZawSxs8jVpa8NmTmmIbe7vB6I/Z3Np+/gk/jY9/S+TSC/LCDwmDtAmOXB95gMYN1a
 sQ4UnkYQFblJe6pWuxUDGAVIcfM4X6xadHGZGVdhONMXgl5zcaX1MEXFPpJTgXhMQkd+ugxnb
 Wbeg4YEeHL5bAMKRD7cWkzYamxqik/GpinLchyBtiWUa6GCaa+hzH2IyAks7/EgzV9ZziSs52
 sZhINuc27EQ1wwZLLPgp5GxXxrgp5ZZHRdwd2lFouDos75Mpe+k1d65G6vc1u93c/UlNM6aHJ
 HfyManLuCUPU2URNgp1gN02E3UG0lGqL8UYobOmyxncJ9qpv/SzyZ6A1KfxPV83qjg2yAnd5m
 tLDhsZFgbw8I6UxixID/NIHC/eX974ysfwkm8BXV/UV+xIa5jsbfFDviJxg1GGTGUmcaBHI33
 vhzoDzrnwi1LChDiydj38JplOKPZSvZlrpBH7XPIHydXxMHt+K7byNOew/NE5otuYeVvFLbWW
 24HCnlpWCHhYbXAgcgArYNctoKXTLIDp3tAifYvcoKGlKhp8/1t1Oi4mP
Subject: [cocci] [PATCH resent] drbd: Fix exception handling in
 nla_put_drbd_cfg_context()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 949
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/941709b5-d940-42c9-5f31-7ed56e3e6151%40web.de>

Date: Fri, 17 Mar 2023 18:32:05 +0100

The label =E2=80=9Cnla_put_failure=E2=80=9D was used to jump to another po=
inter check
despite of the detail in the implementation of the function
=E2=80=9Cnla_put_drbd_cfg_context=E2=80=9D that it was determined already =
that
the corresponding variable contained a null pointer.

* Thus return directly after a call of the function
  =E2=80=9Cnla_nest_start_noflag=E2=80=9D failed.

* Delete an extra pointer check which became unnecessary
  with this refactoring.


This issue was detected by using the Coccinelle software.

Fixes: 543cc10b4cc5c60aa9fcc62705ccfb9998bf4697 ("drbd: drbd_adm_get_statu=
s needs to show some more detail")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/block/drbd/drbd_nl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index f49f2a5282e1..9cb947127472 100644
=2D-- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -3187,7 +3187,7 @@ static int nla_put_drbd_cfg_context(struct sk_buff *=
skb,
 	struct nlattr *nla;
 	nla =3D nla_nest_start_noflag(skb, DRBD_NLA_CFG_CONTEXT);
 	if (!nla)
-		goto nla_put_failure;
+		return -EMSGSIZE;
 	if (device &&
 	    nla_put_u32(skb, T_ctx_volume, device->vnr))
 		goto nla_put_failure;
@@ -3205,8 +3205,7 @@ static int nla_put_drbd_cfg_context(struct sk_buff *=
skb,
 	return 0;

 nla_put_failure:
-	if (nla)
-		nla_nest_cancel(skb, nla);
+	nla_nest_cancel(skb, nla);
 	return -EMSGSIZE;
 }

=2D-
2.40.0

