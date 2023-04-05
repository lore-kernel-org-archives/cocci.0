Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B1CC76188
	for <cocci@archiver.kernel.org>; Wed,  5 Apr 2023 20:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=iG5JpyLShxu7FVuI5j88uzzotom7k2JuSXrTEfXtCeM=;
  b=TFisTzC1W1kYqQViezVyTpwPn4t/gER9IU5y69kTpnT+0c6Xv7+yx5vh
   BEGvnHwD5n46HQiWh4eWCRa3rqeMyDNPA45F4yJhnFUas+yM0IDQ0FL+w
   qZzIUN7Vj3QGL/rj+KLrh7rwxjnbsBzoMJtNRsFU1yJAG5rUDSaq0ZYT4
   0=;
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
X-IronPort-AV: E=Sophos;i="5.98,321,1673910000"; 
   d="scan'208";a="100958767"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Apr 2023 22:10:23 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 39A54E03AE; Wed,  5 Apr 2023 22:10:24 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 052FBE0157
	for <cocci@sympa.inria.fr>; Wed,  5 Apr 2023 22:10:18 +0200 (CEST)
IronPort-SDR: 642dd5a9_96XLaKh1K57H9NWU2b9RAAY7gXW4KD6ilehuNiq2G2B98zu
 61S+bO6Laj2D33a1+hCRpGTudwjMXznj3NvBchg==
X-IPAS-Result: =?us-ascii?q?A0EcAACO1C1khwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIH4kQA4Qvhy6QKIFWgUA+DwEDAQ1BAQIEAQEDB?=
 =?us-ascii?q?DiBU4J0AoU9Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEB?=
 =?us-ascii?q?QECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARICRz4DAyMEGQEBESYBDx8GAiYCAlcGAQwGAgEBgnqCKAEDMQetUn8zg?=
 =?us-ascii?q?QGCCAEBBoJjmSgfLCJUgV4JgRQtAY0JhDAnD4FVRIEVJ4NBiB+CZ4Irh1KHY?=
 =?us-ascii?q?4hDCoE0dIEgDoE9gQQCCQIRa4EQCGaBeUACDWQLDm+BSmNMgXsEAhQWJQQOA?=
 =?us-ascii?q?xkrHUACAQs7Oj81BgMLIQZYawIJIxETBQMLFSpHBAg4Bhw0EQIIDxIPLEQOQ?=
 =?us-ascii?q?jc0EwZcASkLDhEDToFHBIELgQEGASYknlABUigTTCaBdw2SWJJFnhM0B4Iqg?=
 =?us-ascii?q?VWBWQyfDQYTLpcJDgaSJAEuhzCQFCCnfoFjOoFcMxokgzZPAxkPjiAZhAyPS?=
 =?us-ascii?q?D80PQIHAQoBAQMJhUYBAYUeXgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:xRrEkawasnE7jGLrc2K7KrPw+L1zdoMgy1knxilNoNJuA6ulfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bBYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebnN5DNB7foSjjPIduoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,321,1673910000"; 
   d="scan'208";a="52283704"
X-MGA-submission: =?us-ascii?q?MDElsy3Nw5VQ371BNGaFETWHP3qRadEXam8kIb?=
 =?us-ascii?q?K4bIcjCTB0m9p0PUoo4f3N/jTuE7yPy22569K49VcFddiRhNswxxWvza?=
 =?us-ascii?q?oJvvSW2u8nY3CJXnl2boHmlrMI3vymve/ppnHnPyAcOh7q3Idwnkc2kR?=
 =?us-ascii?q?DE3c/MjUAK3z7SCDW2LiAswA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 22:10:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680725413; i=markus.elfring@web.de;
	bh=r9cMMDa8l5YOvWJW+ICwbfkpgZcbEvm5JZZjaOYeeH0=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=VoNMPbJh7YnJ890eEKv6pHGxIPNnq8skzTi1prqY3noqygLl1egFwEGOPJwT8+X8d
	 if/wEiw41SNeEYcSIez8MPDIHtvhgJOSYct9JYguGJ7daFPTADWCZg9vvWybYEIJUm
	 4qSDxCZdNyb/bVwhpMifnBf+55H2KuryeefXzUhUan3Fym2lX092ay+OLc75LNuURJ
	 2rmuQYcy8mSpKxOn/Et7yj6TyDY+vN9lgkcJBmhaP54roaWpbCQdHwICp27zMFQM8K
	 OTBW7ezy9AkNZ5MtvArZB79kAbRSySHH7Nvgto4kHJaxyuCQ0ccUlPAPQ5mqAJuWZN
	 nVif51gXryEWQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mc1VF-1qGBxK1Fkt-00dEis; Wed, 05
 Apr 2023 22:10:13 +0200
Message-ID: <f1eaec48-cabb-5fc6-942b-f1ef7af9bb57@web.de>
Date: Wed, 5 Apr 2023 22:10:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Tero Kristo <kristo@kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <8f785de5-ebe2-edd9-2155-f440acacc643@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <8f785de5-ebe2-edd9-2155-f440acacc643@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o57QYOW9BaxSczMGrkrf2rb2nCYebWEf6LNyxCDdCgC7xJwozyR
 kP19wA0aQxHXJXXVLFS6sDUKtMR4ZvX1aNB/RIrD/6Dupq7IZT/NszOG6cETG6pnlR1l+qg
 hbJnbYqswZWoLGbu8HWdmkmig1gd5ymaIq+NTPb8wqepEEgcTHs5b46yGRivs5Jy8KxwMft
 wgmK50gwBqVRC5SX7TUlw==
UI-OutboundReport: notjunk:1;M01:P0:DGCeGnR9leg=;a+M1j7UTp9oAeRd5NKp0Bl++VYH
 WSqxLqnc0UBS9Qaj8bvK0O5oPZho2koYI1wszSlz3A37WHg5oz5rw0CAXA6BT5c4/O1WzecxA
 NyYXMSHH7Wu2QY1+AtRR5lZWo6YHaSFZ4YUJlnqijz5aBsXGtDhchV4S18TeASOwmUfmxSS/u
 8P5d2cVLyZCpcWL076Fn7xkF2I+ywmm48KWQLSZFHhG5uP0uPhOYohc414xFc6HOaDDGTiByG
 eSPWJVErq4mk6fDbzL21+3Ud3x0ri5/WF1I/jnBUP4sYJFALWOwr3Ee6IlyexEfMPNovU22ZP
 8xuFl8nHzgymYbAB7c5hCm9RhGM4W+83LoV/2GZtyey6AaNSRWiWaTsbbs8VHouLc7vF5yLH5
 IlilJwLtYPo6bYuJ7wPO1O8fab4kchgQdYS/EJ/JHyPioWPFBikYo66mWbDN9KP6dElc8U4sU
 h9y/LAkBrtM+AitjJwWhBpUH6ZMd48eU3CT2qAMmGIieIARR3AVvDjTLXIo8jlrOJB0K7slbn
 pcB8pUghqXmV8Ic/t0V9TkxOf1n5czXo0xxwi7LGjygKIRSSkJJ+JcZV6KVFuhoFkJUQNuhUE
 HuHUyUj9E2itIreE1qaeGwVH9wJ9pS1DfKmUVyB8qU0LtIOqfDV59nozvDiYqwsOrjGzlxIgI
 OeVvaSFEPuldJlRoTOkviavGSxYeyqGuYU0NId81tx7Nfur2hzcgNK/U+3NITBEHR9Arf7rGA
 sTMP67LgPDzNybpwReuTnfrsaSrR0oYywl8Qv0NJQXGEUujvD52dUNuVHGM9G/4bDRPnB2o8r
 NOfzRyllTRxMBTupWgtI7P+VvHrvXDWVY68TkfKn9ba9+mFsFb33LWAjiUKr12yu69djGWKbL
 +e3m1j6l0jv2Mfa1k2SsTPWIzo/GhaLFKsCrtwiy4fhnl2fsYXqWoszry
Subject: [cocci] [PATCH] firmware: ti_sci: Fix exception handling in
 ti_sci_probe()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1005
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/f1eaec48-cabb-5fc6-942b-f1ef7af9bb57%40web.de>

Date: Wed, 5 Apr 2023 22:00:18 +0200

The label =E2=80=9Cout=E2=80=9D was used to jump to another pointer check =
despite of
the detail in the implementation of the function =E2=80=9Cti_sci_probe=E2=
=80=9D
that it was determined already that the corresponding variable
contained an error pointer because of a failed call of
the function =E2=80=9Cmbox_request_channel_byname=E2=80=9D.

* Thus use more appropriate labels instead.

* Delete two redundant checks.


This issue was detected by using the Coccinelle software.

Fixes: aa276781a64a5f15ecc21e920960c5b1f84e5fee ("firmware: Add basic supp=
ort for TI System Control Interface (TI-SCI) protocol")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/firmware/ti_sci.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 039d92a595ec..77012d2f4160 100644
=2D-- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3433,18 +3433,18 @@ static int ti_sci_probe(struct platform_device *pd=
ev)
 	info->chan_rx =3D mbox_request_channel_byname(cl, "rx");
 	if (IS_ERR(info->chan_rx)) {
 		ret =3D PTR_ERR(info->chan_rx);
-		goto out;
+		goto remove_debugfs;
 	}

 	info->chan_tx =3D mbox_request_channel_byname(cl, "tx");
 	if (IS_ERR(info->chan_tx)) {
 		ret =3D PTR_ERR(info->chan_tx);
-		goto out;
+		goto free_mbox_channel_rx;
 	}
 	ret =3D ti_sci_cmd_get_revision(info);
 	if (ret) {
 		dev_err(dev, "Unable to communicate with TISCI(%d)\n", ret);
-		goto out;
+		goto free_mbox_channel_tx;
 	}

 	ti_sci_setup_ops(info);
@@ -3456,7 +3456,7 @@ static int ti_sci_probe(struct platform_device *pdev=
)
 		ret =3D register_restart_handler(&info->nb);
 		if (ret) {
 			dev_err(dev, "reboot registration fail(%d)\n", ret);
-			goto out;
+			goto free_mbox_channel_tx;
 		}
 	}

@@ -3470,11 +3470,12 @@ static int ti_sci_probe(struct platform_device *pd=
ev)
 	mutex_unlock(&ti_sci_list_mutex);

 	return of_platform_populate(dev->of_node, NULL, NULL, dev);
-out:
-	if (!IS_ERR(info->chan_tx))
-		mbox_free_channel(info->chan_tx);
-	if (!IS_ERR(info->chan_rx))
-		mbox_free_channel(info->chan_rx);
+
+free_mbox_channel_tx:
+	mbox_free_channel(info->chan_tx);
+free_mbox_channel_rx:
+	mbox_free_channel(info->chan_rx);
+remove_debugfs:
 	debugfs_remove(info->d);
 	return ret;
 }
=2D-
2.40.0

