Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCC2C021B8
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 19:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=NAqioDBnaCR/fX3O979gDdxkodeOLW6s/eR0SCVTizo=;
  b=Xbv1NabCRky2Iw1XQ8qYPiPH5hHh5MgpuGThbNrTtqQtNHYKVqTxPzTM
   uB5AQdbm2Ur42gSxSSCAEt82Zj3Vd8WgRmJoHkWXDdrRnOnAAh7VodoZL
   04Rl+JnvpYV2R2XF6bsNOOU+rkX0kgl7BWySm9x1By65m2mbsqh4d2yEs
   k=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.14,220,1736809200"; 
   d="scan'208";a="211201135"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 20:50:14 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1969FE0261; Tue,  4 Mar 2025 20:50:14 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 52D35E0260
	for <cocci@sympa.inria.fr>; Tue,  4 Mar 2025 20:50:11 +0100 (CET)
IronPort-SDR: 67c75972_CkEU9HmgNGQWULiEP/3dKOnrZd3xgZ+jmYNY7UEBfkcidj1
 N1R2J2sat9kImZZZKBc96TvLegHPCFWigyCYN2w==
X-IPAS-Result: =?us-ascii?q?A0GKAQA0WMdngQsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UAGAQELAYJDgVczBAtIhFaPT4F0LQOEO4c7kEiBVoF+DwEDAQ1BAQIEAQEDB?=
 =?us-ascii?q?DiBVIJ0AosWAh4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBOwcOCQExhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QCAQMjBBkBA?=
 =?us-ascii?q?REmAQ8fAQUCJgICVgYBEgIBAYJ+gjABAzEHsAN/M4EBggwBAQaCaddzHywiV?=
 =?us-ascii?q?4FlCYEaLgGFa4JjAYVrO4Q8Jw+BVUSBFSeDQYgegmmCM4Fqgz2IXZ98gU0cA?=
 =?us-ascii?q?1ksAVUTFwsHBYE5OAMqNBQEGRYyfkM3gkVpSToCDQI1gh4kWIIragQFg1uEP?=
 =?us-ascii?q?YRCgj9RgkKCEXGBGoIxhU6BLYRyHUACAQttPTcGAwsbBj2hczqEQgFSO0wmg?=
 =?us-ascii?q?gSTDJNpnx00B4I4gWaBYwyfXgYTL5dFDgaSfAEuh2WQaiKpD4FpATeBXDMaJ?=
 =?us-ascii?q?IM2TwMZD44hhC3IM0I1PAIHAQoBAQMJhUYBAYpUgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aXZhYyJfa1jdXPMLA==
IronPort-HdrOrdr: A9a23:11Zdwa7zTsg+GrAQmgPXwBzXdLJyesId70hD6qm+c20xTiXqrb
 HIoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhXotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkbNDSaNzhHZKjBkWuFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3AZgqRKWrxH51uE3mCc54QkivmUYMgfW/SyHj5GET?=
 =?us-ascii?q?mDUJGFrSKQHqM5awxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AgjrikQzdIVraDtjLnFT+MplOE/+aqInxLmkqyZk?=
 =?us-ascii?q?/h9SZHyxSeAm2qx66RoByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,220,1736809200"; 
   d="scan'208";a="110663253"
X-MGA-submission: =?us-ascii?q?MDEQELfXXrj4ZOaf4TM8RhxV5xEZ5zrY7zoyNY?=
 =?us-ascii?q?9V4PJaeFw4iilkHO6tWbvAFOmvcWvo3tdxr2cUB9EFtST+lmB8ZAQk3Q?=
 =?us-ascii?q?MTnyaykhR7jmRpTLQ2Vb+ZLXyPd1Hivo/weYPWRIuqmMGhY2nNEUg/Hf?=
 =?us-ascii?q?jqMXQvXbBb/JzrkWrozdq9kQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 20:50:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741117809; x=1741722609; i=markus.elfring@web.de;
	bh=NAqioDBnaCR/fX3O979gDdxkodeOLW6s/eR0SCVTizo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IfLlcfo42J6gUsPkkOw3qJ+P+aVUjMY8LFIo+hLRmyVLiYH7E3HdddzmsNr7rVFT
	 6FhfK3ifb+4POy3hwuBOohSZb/+e5oMcg4ySc6XCKVMgKvCkWZRMGhxu5jS5Zm1wl
	 fUizJdnxNoUXnaZNko6/mtILCHpgb5CYTphcYFvTgMHDA6Hz3sstnp4UZ9LvyiWgC
	 AnKNcWTRyvCxZaCrKZW86ivZZnEFrR8I+GuvZLC0TPTkrjR+btE2lsnZ2yEyzyhRA
	 QHD/AsCw0gpaqOu1YxiwWsK19XjYblydIMUjrU2tbVUTn7nlVbCPjteJ/aEUe0+r6
	 qpb4yqUXxsELWdNq4g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.64]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9qhD-1tsYwn4A0D-004pJK; Tue, 04
 Mar 2025 20:50:09 +0100
Message-ID: <f7d11fd7-6b41-4dbd-b7dc-518fe6e6426f@web.de>
Date: Tue, 4 Mar 2025 20:50:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, sparclinux@vger.kernel.org,
 Andreas Larsson <andreas@gaisler.com>,
 Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>,
 "David S. Miller" <davem@davemloft.net>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <21e58abb-f215-b9b7-ffe8-236dd40c6bd2@web.de>
Content-Language: en-GB
In-Reply-To: <21e58abb-f215-b9b7-ffe8-236dd40c6bd2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WpWmttFFn8Qub64QBVtRj6aRk7IDFd3+w6lJR6TrfK8BSH156Ot
 hu6UopotRXDpps5+KITM05hQRO91neMEUKBl4E/Pw6c6uVCiQ284/JDE3tl1f+wn3w6lmEe
 d3QuaT3UgtFYU3zm9I+FuqJLOxJY2XWMQ5sHa/OHspiTepFl0WmgNdmPd13G5yEd2wu1kJP
 hGq6cT++PrBjIxK4z51fA==
UI-OutboundReport: notjunk:1;M01:P0:yKktvz9VDmM=;6q/3gbhSNL/sHrPhjt7U2GB+w7U
 vSfEZeDYNAzI8t/grqY9Q3Ww8qIwQBLwtwOuN7hKhmoEJyNI3eqXvMrhlW6Neiq5pcfL0irOe
 zBqEe2HkcqbQ6dt7s8iTxt6tup12+QeN8PoOdvZBIzfxsmPb6F40AOiwe8WBWe+IY/jp4nk30
 Z8RTadRfn6MuP3i1g9DHm5pMpwdAeEScZuIFFvS2MGBdwtKroUUH3PrJpcpc3gElkBFeEXmCf
 F3eSOGTIteRBfTYeO1I4QcCl8HSxLpmsTqzOgUuj8MBVL/qiFL47Lk9y3jF7N1yLMVQasQUaJ
 z0DP7w/Pi77yCZaXf1DsEADgeRjgoGausGvzwrtTE66o8SHwEJ2q9IRjxxF9tuVQJjuBGJSUj
 X4PnTOJ7oK4yrU0JuPmoNZq6PQ3NZeCuhyi8Kuk9GdZk142+2aVpf5821PrfKm+um6yWr3RvF
 +MXFdtN53AEMuHbZD+JPROskKiDQHADgvjTdwV+MIzNUbP0AZvVu6uX8EAZwRVDjnord6cUnp
 NAmFxnwvpXwk6Gmz2d7X5R0KWOhLkYlny1vjVlwq8Hb/NV7AZqjscqf5pnBIAzPfjOioHKVec
 qFAMNKCOSlqgVbBZ+4Qxhbk4jkfGe6ifMDScFxMmo0tCV0WKIasYpPOGeuZ+JsrFvIcCOFzZE
 0FbdCG3DkMzMaOP79kJUrLG7qs4bepuXUURm1oOIeBy9M1CVJb9cT3Vs6akKKpO2oEm2x2E24
 MJJDNGpRWuVXXm8jWRlNEP+utm15nN1j3frwEKvISCfGyxXrmKix2UULVhHU6siPNXsQaSI9H
 VD/u/Z4WThkuTMvD5NjcqexBdHoohH292FJL4rFO2wNH8BOayV2tPLuUKiJ2uqhlVV3Ir3DJv
 d+R9xigG1mM0SaVBVRcSoqNYnFpi45uAVQeQLjKCwlEIn7RWOLNeDMTCWcOMd398u51QCgyyU
 YttK1vWd/boZVkEUe5+3NZSk/d0GQl5rAw9U4E5Q73hhKsiuvGX03nX8+oI/He0hST+65CEtA
 5iaXQhmH44nmqLdUH9RPeWdSXu/pHe1g4TXOJu6HbuSZGel9yhIfaPk0AkqcwM4bwgb85IwEC
 2AdDPkLdixNKpgJS4Q7iYNwErjqjbsv2ep+w/jmTwXffxX3rAzeTca8BEoZWd91ipdDME+9nC
 xWecGi4mXqzfDW8p98GS/Lzml+RcABxEF/ZIIdhKJWrdRFXWnXIhcgDLQIIAeYx1mCsNo/Ddd
 tNDtrvjHQanztPSDcQS1RzBkALmMp/dEZmZFfmkduuE45f4vany5Efx9jKnNC5diFmd/zIYql
 T2mfgaQoo86yPWyO+WmUy06/0Bq/f9tiscQdpnKRgakcDKmq5crk4Q5+70G7QLU11E/QpJx6M
 qQ1pRcB9m/j2+ICHeExgEUmN8wwvjIZOkCWQzYwsnrrZItL0VSB9f2sO1mxMugWhDqZNV+j/v
 t3nSEg19mZvhlcpKG9vmlkol28fM=
Subject: [cocci] [PATCH RESEND] bbc_i2c: Fix exception handling in
 attach_one_i2c()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2536
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/f7d11fd7-6b41-4dbd-b7dc-518fe6e6426f%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 21 Mar 2023 21:12:29 +0100

The label =E2=80=9Cfail=E2=80=9D was used to jump to another pointer check=
 despite of
the detail in the implementation of the function =E2=80=9Cattach_one_i2c=
=E2=80=9D
that it was determined already that a corresponding variable contained
a null pointer because of a failed call of the function =E2=80=9Cof_iorema=
p=E2=80=9D.

* Thus use more appropriate labels instead.

* Delete a redundant check.


This issue was detected by using the Coccinelle software.

Fixes: 5cdceab3d5e0 ("bbc-i2c: Fix BBC I2C envctrl on SunBlade 2000")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/sbus/char/bbc_i2c.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/sbus/char/bbc_i2c.c b/drivers/sbus/char/bbc_i2c.c
index 537e55cd038d..03e29f2760b2 100644
=2D-- a/drivers/sbus/char/bbc_i2c.c
+++ b/drivers/sbus/char/bbc_i2c.c
@@ -306,19 +306,19 @@ static struct bbc_i2c_bus * attach_one_i2c(struct pl=
atform_device *op, int index

 	bp->i2c_control_regs =3D of_ioremap(&op->resource[0], 0, 0x2, "bbc_i2c_r=
egs");
 	if (!bp->i2c_control_regs)
-		goto fail;
+		goto free_bus;

 	if (op->num_resources =3D=3D 2) {
 		bp->i2c_bussel_reg =3D of_ioremap(&op->resource[1], 0, 0x1, "bbc_i2c_bu=
ssel");
 		if (!bp->i2c_bussel_reg)
-			goto fail;
+			goto unmap_io_control_regs;
 	}

 	bp->waiting =3D 0;
 	init_waitqueue_head(&bp->wq);
 	if (request_irq(op->archdata.irqs[0], bbc_i2c_interrupt,
 			IRQF_SHARED, "bbc_i2c", bp))
-		goto fail;
+		goto recheck_bussel_reg;

 	bp->index =3D index;
 	bp->op =3D op;
@@ -348,11 +348,12 @@ static struct bbc_i2c_bus * attach_one_i2c(struct pl=
atform_device *op, int index

 	return bp;

-fail:
+recheck_bussel_reg:
 	if (bp->i2c_bussel_reg)
 		of_iounmap(&op->resource[1], bp->i2c_bussel_reg, 1);
-	if (bp->i2c_control_regs)
-		of_iounmap(&op->resource[0], bp->i2c_control_regs, 2);
+unmap_io_control_regs:
+	of_iounmap(&op->resource[0], bp->i2c_control_regs, 2);
+free_bus:
 	kfree(bp);
 	return NULL;
 }
=2D-
2.40.0

