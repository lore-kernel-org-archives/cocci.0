Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A676C76196
	for <cocci@archiver.kernel.org>; Fri,  7 Apr 2023 06:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=fDCQFXDg6MKYzrGC0lWMPEFO6BGXZ0GoprCYQz8z4JA=;
  b=CSR2GeJS8urS4BGqbk1wbb3E/lOY/DO50qnyJg9emeT9kQIK6htCi7eC
   b5gnuSVhBACYOTwKLkC5kMF8HpEatenmLGSomzpLUVI3TrQa7qHZqF5Ji
   vxlTaCsWXRwky/9cWHI3gtcWOSqRUVRoVQbauP0vtWhYGciXbw/eA3iDs
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
X-IronPort-AV: E=Sophos;i="5.98,326,1673910000"; 
   d="scan'208";a="101440943"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Apr 2023 08:23:21 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DCA9BE7312; Fri,  7 Apr 2023 08:23:21 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 210DEE72F8
	for <cocci@sympa.inria.fr>; Fri,  7 Apr 2023 08:23:18 +0200 (CEST)
IronPort-SDR: 642fb6d5_CyRlruV6YIubnZYwOq+CxqOmbQb8LwRE4GihSaUX9cDLZRe
 lODlEgREo9ehFBn8v74ZR2glWGETgcEEyjMs88A==
X-IPAS-Result: =?us-ascii?q?A0EcAABotS9khwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIH4kQA4Qvhy6MJoQDgVaBQD4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEOIFTgnQChT0CHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBA?=
 =?us-ascii?q?gQFAQIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBEgJHPgMDIwQZAQERJgEPHwYCJgICVwYBCQMGAgEBgnqCKAEDMQesQ?=
 =?us-ascii?q?38zgQGCCAEBBoJjmSgfLCJUgV4JgRQtAY0JhDAnD4FVRIEVJ4NBiB+CZ4Ish?=
 =?us-ascii?q?1CHaIhNCoE0doEgDoE9gQQCCQIRa4EQCGqBeUACDWQLDm+BSmNMgXsEAhQdJ?=
 =?us-ascii?q?QQOAxkrHUACAQs7Oj81BgMLIAZYawIJIxETBQMLFSpHBAg4Bhw0EQIIDxIPL?=
 =?us-ascii?q?EQOQjc0EwZcASkLDhEDT4FGBIEKgQEGASYknlYBUgchE0wmggSSWI57g0qeG?=
 =?us-ascii?q?TQHgiqBVoFZDJ8NBhMvlwkOBpIkAS6HMJAVIKJehSGBYzqBXDMaJIM2TwMZD?=
 =?us-ascii?q?44gGYQMjwkBPj80PQIHAQoBAQMJhUYBAYV9AQE?=
IronPort-PHdr: A9a23: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
 4GhpTRM1lA7BOM=
IronPort-Data: A9a23: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
 RoiFrEc8/R/LlyFhQre2xBjvdpa+w==
IronPort-HdrOrdr: A9a23:pV67eaBFPxLzjtjlHel455DYdb4zR+YMi2TDGXoBLiC9Afbo8/
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkOos1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFpSWY+eRMbEVt7eZ3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,326,1673910000"; 
   d="scan'208";a="52427150"
X-MGA-submission: =?us-ascii?q?MDHH52eJRuE5iFkn3JEG3Ie8/nzBol3srZPxD8?=
 =?us-ascii?q?uW9Hi9k8DpeQz5wPtWhh2O/dy1tKGkiXm2X5A/0MPCKNpmSKAvYWBf9R?=
 =?us-ascii?q?iiuQK3B/1//Swq7Tw38zUexcCDdgmIlLv3F3EdNm/Vh9PLazBqZ4MvWL?=
 =?us-ascii?q?dtGjZPxIWYw36YuMLc0lRs1A=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 08:23:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680848580; i=markus.elfring@web.de;
	bh=Q07bSq+vKNvcQzVSQ4b4EDli2tQSjN9qtpe+7WIT/sw=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=gTOUGWmnRalwMG8N5oA9uqqWJzltGvvmW7W/mg5MQGup8Zqhe+8IcxFDi0ooYtlka
	 5Iw3BM6huDJJr0WhHGKIxvW/EVkcoG87MkwcP6GU6jHUdClb2bg1DgE3YuD5hDRCXC
	 e7ry5XC1uGSoarHoSMT8KGQIt40IBtohf9gN5xElvlQn0Yo6ANgDgHEmlbQuyrvYjM
	 IGcR0GjJj/2A89SRLd+WwUM1vaJfOBmyDGZEyE2JZKMi2hKekkUQR5zA5d3COdLL86
	 qUv4JBKs5xaZFS9DtJXokJu937wr6Y40RoZ6WqyxT/3iLqezZJsu80IrdsNyBNK6h7
	 reZLqQr32jGlg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mpl4z-1qBhvt2u3p-00qE7u; Fri, 07
 Apr 2023 08:23:00 +0200
Message-ID: <82aebf6c-47ac-9d17-2d11-6245f582338e@web.de>
Date: Fri, 7 Apr 2023 08:22:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Mark Brown <broonie@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Yang Yingliang <yangyingliang@huawei.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <8f785de5-ebe2-edd9-2155-f440acacc643@web.de>
Content-Language: en-GB
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <8f785de5-ebe2-edd9-2155-f440acacc643@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6oy7YoYoFrpIkRnQd8A3LwdEpt1ogKfSbyN03ICHz79PNH74dV3
 Yj+Nif/hVoFxu92IpmvpKIpayy3G9YaKwokrorPJLYvUulZstFW1cYc4acH2nTk959/Wy44
 0rZKneblBQ1Uqjafj8uJtPLDlQ1C/CQjq1pEMbP3sW+cPP/Y95XgspScv8vsW0lGDSd9E8q
 W8P8r7nr9cJBGShWyxYmQ==
UI-OutboundReport: notjunk:1;M01:P0:znbifOoJL0E=;c1X1Tnnob0NlNlMyGSY4ypfH3b3
 32d4+zdkBBn+/1T1kt6la8+25iFOTUtRs+5S12u69LmeyxFXEpHR9A3byfX/mpFNLgCyrQRiK
 bXvN+Xrihbobiln/J/mPmZBAnAZDqhLoD9j/a21fw7Ri81VNS9xEe50rhrcW2zp9Xl3j6YbVw
 15hI5eCFBVsE2uQep0BcN0yBXLE4VT2sQhR686yz4AhJK35qTmGP7TEPprh/GM6RS7dqjjUfJ
 uXKOR6t4a2jGeHfdgqy5YZY2/RkzN4WgcsOy3UiHE4foTipbI/4jZVIiucH72hJClmja7k4Kf
 mkqmtrZXHtYYD4qelbZZtp8sDYeXjzDOC7BfwjQ32vB8vnRop3U8Nvp90gI57yidK7SNa7f5n
 iHVCGZN1PuwdhWcJ9p++FYP7EStJoKF1f8m6vAkVHAli6oj42POYD3sP0qWXPeyj4TibVB50+
 joI9zGmzdrEvIrVfMNgrLhBrgonE14WK1XXvAWvgeOeeseYtmmvwUzHjSAwIjbzVDRUrpVEN2
 vW3vVUdkEJ9baalPSCdfyzeRCly0FCyxXEv//tVBvNQLc4YAf3oQ0gJAWQX/KzAQ8OANcIjap
 adrxfpOu+jezqkfIXU/5m3No99///r0AEkjYg+6SjnwxCp6FfMMSzGaN+z84uoI06yPG4L3Fu
 bjqZUx1TFn2wpLs1BriHxra2Wm0T6pRpOm6GixJLMUzwD/Iiiy6m/L8eDThCemR/WiSmwUbD+
 076cOVmJplDk1Bp5wfgM1iq0yfZCRSA09JuwUT6Esln5DYme5Iikja5kYGX9TECzKQtNo+Q9r
 ivL+GAb0LwGMb9ACEqLVGJYhHeZY3QO9U4b1pqd7r9Gcl7nMwgEQUokLDPJbF3PcmtBqwlGPa
 N3xR6NTRzIiI/eC7gYWcIeznbhLJ8o4ttEW/eRmvXsEl8j30RseKv0cRJ
Subject: [cocci] [PATCH] spi: atmel: Improve exception handling in
 atmel_spi_configure_dma()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1010
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/82aebf6c-47ac-9d17-2d11-6245f582338e%40web.de>

Date: Fri, 7 Apr 2023 08:08:59 +0200

The label =E2=80=9Cerror=E2=80=9D was used to jump to another pointer chec=
k despite of
the detail in the implementation of the function =E2=80=9Catmel_spi_config=
ure_dma=E2=80=9D
that it was determined already that the corresponding variable
contained an error pointer because of a failed call of
the function =E2=80=9Cdma_request_chan=E2=80=9D.

* Thus use more appropriate labels instead.

* Delete two redundant checks.


This issue was detected by using the Coccinelle software.

Fixes: 398b6b310ec85eef9d98df5963d5ded18aa92ad8 ("spi: atmel: switch to us=
e modern name")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/spi/spi-atmel.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 7f06305e16cb..ed8dc93c73e5 100644
=2D-- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -511,12 +511,12 @@ static int atmel_spi_configure_dma(struct spi_contro=
ller *host,
 		 * requested tx channel.
 		 */
 		dev_dbg(dev, "No RX DMA channel, DMA is disabled\n");
-		goto error;
+		goto release_channel_tx;
 	}

 	err =3D atmel_spi_dma_slave_config(as, 8);
 	if (err)
-		goto error;
+		goto release_channel_rx;

 	dev_info(&as->pdev->dev,
 			"Using %s (tx) and %s (rx) for DMA transfers\n",
@@ -524,11 +524,11 @@ static int atmel_spi_configure_dma(struct spi_contro=
ller *host,
 			dma_chan_name(host->dma_rx));

 	return 0;
-error:
-	if (!IS_ERR(host->dma_rx))
-		dma_release_channel(host->dma_rx);
-	if (!IS_ERR(host->dma_tx))
-		dma_release_channel(host->dma_tx);
+
+release_channel_rx:
+	dma_release_channel(host->dma_rx);
+release_channel_tx:
+	dma_release_channel(host->dma_tx);
 error_clear:
 	host->dma_tx =3D host->dma_rx =3D NULL;
 	return err;
=2D-
2.40.0

