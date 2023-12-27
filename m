Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB170C46CD4
	for <cocci@archiver.kernel.org>; Wed, 27 Dec 2023 11:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:cc:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=Jjf2osiRuU/THrd8e/01a2S3PlEw5D/q6NqwmcyyG00=;
  b=oUr3RxzfshxgxIReC/ErQxO2GOP0rLY4qVzOblBETnBkKLbFn8CP7hk+
   A0eElCmadNmzKhFBmW743Zy2Ko1qgG9EapJESgUi6l8ZNAU5cbCvpB84Y
   abk7lWJnCdXfnOuoJyvXP3sszEmLPt0v+e5oJWTFaKW1H2dyc3hmyyP13
   Q=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,309,1695679200"; 
   d="scan'208";a="144127548"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Dec 2023 12:51:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D783BE0CCC; Wed, 27 Dec 2023 12:51:17 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1AAE4E004E
	for <cocci@sympa.inria.fr>; Wed, 27 Dec 2023 12:51:09 +0100 (CET)
IronPort-SDR: 658c0fac_cOSJX9llrpI5UaHxhdo0PdMacJyq85weIIJxOPQLfgbnU8T
 SfQBVYTLIzWuZI4hkevlCfqF4x/62OFvci7mu2Q==
X-IPAS-Result: =?us-ascii?q?A0ETAADVDoxlew4P49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBOwYBAQELAYI4f1MyBAtIhFOIHYckgXUtYYNdhzWHTIhvgVaBQD4PA?=
 =?us-ascii?q?QMBDUEBAgQBAQMENwGBU4J0hzgCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQIQAQEkGAYOBQsnhWwNglwBEIEMgR4BAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEXAkdrBBkBAREmAS4BBQImAl4BEgIBAYJ8gisBAzEHrlJ/M4EBg?=
 =?us-ascii?q?goBAQavWB8sIlaBYAmBGi4BiBoBhWeEYg+BVUSBFSeBFIItiB6CaINmhTYHM?=
 =?us-ascii?q?oIcg0+RVn0FQXAbAwcDfw8rBwQwIgYJFC0jBlAEKCEJExJAgzEKgQE/Dw4Rg?=
 =?us-ascii?q?j5hNhlIglgVDDQERnUQKgQUF4EObhsSHjcREBcNAwh0HQIRIzwDBQMEMwoSD?=
 =?us-ascii?q?QshBVYDQgZJCwMCGgUDAwSBMAUNGgIQLCcDAxJJAhAUAzsDAwYDCjEDMFVED?=
 =?us-ascii?q?E8DbB8yCTwPDBoCGx4NJyMCLEIDEQUQAhYDJBYENBEJCygDLAY7AhIMBgYJX?=
 =?us-ascii?q?SYHDwkEJQMIBAMrKQMjdBEDBAoDFAcLB1IDGSsdQAIBC209NQYDCxsGPgKmR?=
 =?us-ascii?q?gdTKBNMgiqScpMdnnI0B4I0gWCBYQyfKwYTL5cmDgaSUwEuh1CQTyCoRoFjO?=
 =?us-ascii?q?oFcMxokgzZPAxkPjiCEK48JAT1ANTsCBwEKAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
 razongG1w8xNbYI
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:MCRQt67uCxrsfYx3uwPXwBDXdLJyesId70hD6qm+c20wTiXqrb
 HMoB19726TtN9xYgBGpTnkAsK9qBznmqKdjbNhX4tKPzOJhILLFu1fBOLZqlWMJ8SUzJ856U
 4PSchDIeHRSX5nkM39/A60KNo4xsKbmZrY/ts2g00NcelwAZsQljuR5zzranGfz2R9b6YEKA
 ==
X-Talos-CUID: 9a23:MuFNymA/T8Ua7tf6E3Z1qEsoGdo+Syz+6VnhAkOKIktwQ4TAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3A0cHdfwxsPg7krMQBed6A1IPMYt2aqJqVJxgAto8?=
 =?us-ascii?q?0gc+jai9/Fze4ixeeSYByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,309,1695679200"; 
   d="scan'208";a="75404071"
X-MGA-submission: =?us-ascii?q?MDGFZ2iJHXJLEEBUvYdJ/wyTIip7TwGaF9cKNz?=
 =?us-ascii?q?WlAaeRszOySdfY6Xle8Y2l3dv+t9CTZIixW92noWUGQLudLSJJuaplP9?=
 =?us-ascii?q?wB/Occ+yxzv+cbJVgAugj3rs/ocKGN7y+VpvNiU+5NB0XUkluYBsj8Bc?=
 =?us-ascii?q?zsd6+wFvtCK4VCSzdUJwogHw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 12:51:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703677852; x=1704282652; i=markus.elfring@web.de;
	bh=/Cj1QNl5NB+eMaP0OCGwd5CQPitw8BtjolyhftxjSoQ=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=poj/qxU7lKy2V5VOfd/iOjzwemtIUc6lMQkG7cxdd8TR5HDw8jS+uRxdc6u1BwSk
	 uLuqTQJlRKtFbRAQ1eHzxunBa5U4OJKVOFjCoz5T5aKF0s1C0740bFmHz8tjFm1BT
	 rvXPZUROLFMYCEleq2zfz0qFRQ0SNg4BojJh2o/ASAUwNTqn6JGUocQUYydig2Ueh
	 lykxq8HKrfKp6fCZO44g6ZBp927NEVhuQDPK9lMZrG4wm3/l6Ek1apGrClPUnW3hK
	 SaZzVIc2Rvf47Y4EI8podxSJtbtujAjPTngUbA8VUWsC42DfJ3PVGhaPOC5cOQIK5
	 ScNznhHkUy39K89CUw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8T7E-1rMsHM16bA-004rUu; Wed, 27
 Dec 2023 12:50:52 +0100
Message-ID: <2aa6bd31-f3d8-41ac-abf1-9ec7cf7e064b@web.de>
Date: Wed, 27 Dec 2023 12:50:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Yang Yingliang <yangyingliang@huawei.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pbZP15ZayWiTe57ZMmiJyPG5siAZDUFivZl7Yc9Hcm6ffgH4sSi
 LzmIkWD3lD33goLIHpB665CkPrARlm42eRACDqs8N2PJEZrbepcu90O4eXAndjg1LkN6MVM
 6tGIcAuKBVpe5Vcij3eoHScl3N/fR2htBRlnwIw9miS8sw9fctUvMK4WihBFQ4JcVZu7m6M
 xwejJlh9gqcLdsKEk3ezw==
UI-OutboundReport: notjunk:1;M01:P0:DtX1kDKmJww=;gYjek4ZqSnhlJtks+e1Rgqp1BJQ
 tr5MT6zvEkGs7wpAwfW3i/+PJ3c0yNlR1SNLyo1M06sPHDQu+wCHJyVWOXDxbw2IT1jNgg5BX
 DkFG42fQxy+oTbKZ7wwtTmezBbXPE/c1t9xp+/G/Llrb8L9umgnyyje2RDKZf+s3jUIHLcfH6
 tLpr3Wq/IJNVKuPdFehRzkhZxsRoBJAvH4d5JoBbrfx2KyplMkf1IbUxZgG7Ok18G7IYLl5ub
 KCPd4QbeuGhHUsJfk4EXIvXjQ2Tm+cMatfkKM5s/Wlo2rHZt4GnDJaV3g0e5MRkY8q6z8kAYC
 GEbmTjq2l9l5DMRqgr91ap1QFdEyhfSCdgaRbGqYQAIpNlVfzHzih+rSA6Qx1qqkF4ZrVtyAf
 h0ste/FuXKFwZX2whkH+i4KypH2JNKKrEetx1+IeYcSVyvi4PcLxZ+3W+LaF+UGdKIG9rzxU2
 j5Sy9VnjzwUFGJWyJOwskP42q/dcELf2V6YyAVaLcceBHyxrP9l0z9cICNfI134P1R0Q/EQwx
 GHp+T9R2i45wWOGQvI15n7TrbanbyPv788SAvGpXO/4eG6YLujnqXJy+NErvpbLmX8uw+PXAv
 fb/A6G4kw3xNlKs923+N6fbtQutrRsL4ZSByqW77+iP5BzRxGbe1TeJ5VHEW34/tNqXWdwH33
 lZBI2XG3bE2jY5ww38aGeA83CyBBVIVF3VklvhWETjBS5L3fdArYvQqV7ApH6/GUCkY/KRPfr
 nkSISBfTWMA6RjOvCVz0SfvPOsWlQdqu/zAn+CLeDa2x7kWB1O+wVLPdt9cPKG1N9hjhLqppa
 TynzatMFJBfxempMysBb4I4TnqCwb8I6dHv8X7Z/XD/FweRhsqTp6uHqYnB1Ldvo63CogGFq8
 qYo2xdbzKjOBixQJKu+u7wOrxmDOjkkKqlWtxh+0ZibueZKX0RF+xvx6691Y3NDIby1sEP0Ej
 XALPWw==
Subject: [cocci] [PATCH] mmc: mmc_spi: Adjust error handling in
 mmc_spi_probe()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1412
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/2aa6bd31-f3d8-41ac-abf1-9ec7cf7e064b%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Dec 2023 12:23:20 +0100

The kfree() function was called in one case by
the mmc_spi_probe() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus return directly after a call of the function =E2=80=9Ckmalloc=E2=80=
=9D failed
  at the beginning.

* Move an error code assignment into an if branch.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/mmc/host/mmc_spi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index b0cccef4cfbf..6e7d8e1e6f38 100644
=2D-- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1349,15 +1349,17 @@ static int mmc_spi_probe(struct spi_device *spi)
 	 * NOTE if many systems use more than one MMC-over-SPI connector
 	 * it'd save some memory to share this.  That's evidently rare.
 	 */
-	status =3D -ENOMEM;
 	ones =3D kmalloc(MMC_SPI_BLOCKSIZE, GFP_KERNEL);
 	if (!ones)
-		goto nomem;
+		return -ENOMEM;
+
 	memset(ones, 0xff, MMC_SPI_BLOCKSIZE);

 	mmc =3D mmc_alloc_host(sizeof(*host), &spi->dev);
-	if (!mmc)
+	if (!mmc) {
+		status =3D -ENOMEM;
 		goto nomem;
+	}

 	mmc->ops =3D &mmc_spi_ops;
 	mmc->max_blk_size =3D MMC_SPI_BLOCKSIZE;
=2D-
2.43.0

