Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65955C46CD3
	for <cocci@archiver.kernel.org>; Tue, 26 Dec 2023 19:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=Yz5BNYFI4Mk4f05xYuM6k+XbzVrG3PN+bLt3Unt/YD8=;
  b=hOTp16kBqAH3X4BoWrj6WZeV2J+3d7rBy5efoK+N6/1H0frzA+6lFccZ
   yMBKoIRsZMTPB1LnFAW0F06ozUrUzC3xuI96aSX1NDgEK70qm35446mBd
   KoSAneHUbe4pdDGHqvlvmEg9MWQQnAi8Z4yssrxXyBREm7a0XXxOuQXoy
   w=;
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
X-IronPort-AV: E=Sophos;i="6.04,307,1695679200"; 
   d="scan'208";a="144074620"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Dec 2023 20:43:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 94B5BE0AF1; Tue, 26 Dec 2023 20:43:46 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1FF76E004E
	for <cocci@sympa.inria.fr>; Tue, 26 Dec 2023 20:43:43 +0100 (CET)
IronPort-SDR: 658b2cee_Z5rsb9dS6WGF5LIz4ow4arfgVcVhRmcJ/ozmzhj848OEUqQ
 sCC5tK/TqPdbAuVSk/6EGX/5qOgRilYp+rSupow==
X-IPAS-Result: =?us-ascii?q?A0EoAADOK4tle07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4f1MyBAtIhFOIHYckgXUthD6HNYdMhGuEBIFWgUA+DwEDAQ1BA?=
 =?us-ascii?q?QIEAQEDBDcBgVOCdIc4Ah4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECEAEBJBgGDhAnhWwNglwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEXAkdrBBkBAREmAS4BBQImAl4BEgIBAYJ8gisBAzEHrxZ/M4EBggoBAQavW?=
 =?us-ascii?q?B8sIlaBYAmBGi4BiBoBhWeDQYEhD4FVRIE8g0GECoQUgmiJGwcygh2DUJFXf?=
 =?us-ascii?q?QVBcBsDBwN/DysHBDAiBgkULSMGUAQoIQkTEkCDLwqBAT8PDhGCPis2NhlIg?=
 =?us-ascii?q?lgVDDUERnUQKgQUF4EPbhsSHjcREAUSDQMIdB0CESM8AwUDBDMKEg0LIQVWA?=
 =?us-ascii?q?0IGSQsDAhoFAwMEgTAFDRoCECwnAwMSSQIQFAM7AwMGAwoxAzBVRAxQA2kfM?=
 =?us-ascii?q?gk8DwwaAhseDScjAixCAxEFEAIWAyQWBDYRCQsoAywGOAISDAYGCV0mBw8JB?=
 =?us-ascii?q?CUDCAQDKykDI3QRAwQKAxQHCwdSAxkrHUACAQttPTUGAwsbBj4CpkUHUygTT?=
 =?us-ascii?q?IIqknKTHZ5yNAeCNIFggWEMnysGEy+XJg4GklMBLodAEJBPIKhGgWM6gVwzG?=
 =?us-ascii?q?iSDNk8DGQ+OIDiDc49HQDU7AgcBCgEBAwmFRgEBgyY0gUYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 vlGkkDN0tONLl2FiArdCjFXQQuq+x8C+k81xA==
IronPort-HdrOrdr: A9a23:YSzIOaxYeUNdwSCBVhxzKrPw9L1zdoMgy1knxilNoNJuA66lfr
 OV7ZcmPHjP+VAssRAb6Le90cy7Kk80mqQb3WB8B8bGYOCEggWVxeNZgbcKqgeIc0DDH4VmpM
 NdmsZFaOHYMXg/q9rm6w+lFNsazMCA673Av5ak854gd2BXg7oL1XYBNu93KDwPeOHMaKBSKK
 ah
X-Talos-CUID: 9a23:E/qK1Wzne7Nw4Lb9b1E7BgUPQtg5UCL3xU3pLleoOVl4F6/OEUKPrfY=
X-Talos-MUID: 9a23:T9quzgYeqv7tVuBTrWarqDFAZOtR2I+lNUQ0mo8cp+2VOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,307,1695679200"; 
   d="scan'208";a="75375877"
X-MGA-submission: =?us-ascii?q?MDFrHj8Fgg34AgwtO4jlRXhroQMxv/99oDZvDV?=
 =?us-ascii?q?axYq4vMMemiZPyzp8zlQ6kDXx6HaGmVevQLI8TgZS0tLEdrwoIuNKbzG?=
 =?us-ascii?q?WGhzfcubMonLo2aWEXV00PDNrlTEyQdrDTF2P27+mGjHQvG7ahRidlgH?=
 =?us-ascii?q?ct7+lI6xFpJKHmIyVnzVLEXQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 20:43:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703619819; x=1704224619; i=markus.elfring@web.de;
	bh=kfUrqzz13/SvRJXYn0ERTOI/fh6ulUnX5zFEb1O64Js=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=fBOhzl+rNglrGfAE5U6T/gr7Mcos5BQiia4AiECPLcFxE5boaMpuyvWYg3qXNQo/
	 adlFWcdh/FSb/vR2Lg86/GKHSvAeI0wB1SMZnRyzYwEjw8mm9+EF+uoYyCG5Lofj4
	 fSA+bPafsWBoR2IAZMCUkko4/1aIarO7bKMcqt0NauJmCDebcE2coRytaIVfESeG1
	 KIPMJ51KyTOtB+DUwHSoA5l1uFG/JQfX8Grt5PxKx6zmONmVYO5Bnlut13dYffHsC
	 f+syDNPaKXK/iMN/bEy473NZsaJXd12tdW08Ik3jwGaNLwkaRLg/4vf2qb49tq105
	 q5lVTJXlS4hLCVV/rw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MhFlo-1qn1SL0xuM-00eWrU; Tue, 26
 Dec 2023 20:43:39 +0100
Message-ID: <5088a905-4f29-41d3-a96e-5b66aad551f1@web.de>
Date: Tue, 26 Dec 2023 20:43:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Henrik Rydberg <rydberg@bitmath.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a8q13dW4fWVw2Hjfg84VQkwXU+SMTB/VfKaMZFUi+rSbfT92EII
 2KooLkW2Dt1N9cTE4m8DJ1HBbo4D5rqf0iDdRWR8KpJTnq59BWm8uAfCr2a/hZJHirCNjXJ
 4l9HsAHIOoSz2pE9twVSlBijktomx1LJ3hXmLqLS8OoA7gXYLMDQVJwWKL97573cEZNpkMW
 RxqfNn9aqV3fQjdpHC7Cw==
UI-OutboundReport: notjunk:1;M01:P0:8pD2t0jv3V0=;6PXCgp1FFSxhp3Tffor/temmFSg
 895atRLT+C3nCeMjM3n1oRHwvgFOcktzBWruWZEu5ZsGaxTbuyYtv2rGGKUslWmPgpexSpWL+
 wXULaZMfngAAw6HlTtXgX2N5PgaFtL8hImDr+fnVQYlQ4bArZqprAJXtrpUs5COQSHWfqlIva
 WVUP2Hlo+soijfzzP4Hxi2N6rZXmYYzQIpcHjVSuKcb//ryfLvy2dFeibU1YzAIR6OdRMWVIw
 PScT4n1dy7v+uoIjO2a78SPpJoAkmvKE1JkEPkaqunOmP+PJ3N5SpicZt172/MbIArELY5MB3
 Fxffx5qL8ripKt3ZHJ0NuqUlUR59TnNpeHEwW/NBIK34glXJ0KrIYPCkaxt5uvf2L0ZQXsn5B
 Tis9pVoqRq2nCMZKCEf/zikkeGZEG5pVPgmAyel3u9zK5UTQJGzbTNqGaUM+2VrU8k5/QgAaK
 O1veTuapZJuIYZY/J7GM1Sy3jVVDjfpp9LX9/6w8KZsxuQqgH/aSDOIVh3feJqPcm2Jse6RxD
 hBaK3Y0igDbFy82DRMlqZ+4Bsm0Ky7c3aIQEsz9xfVnAjr1i1Xj0ZvmW21RVlExwVYfjteYln
 DmbvanRgUBMVtAllhsVg45iKkkZDMX4EOtGd2Y3IetOoGMxxuuG7xeMCNShOEd01tWQ85vmv7
 bWRPB9vH5o2o6rsp0q56uXa5kpUaYRPIa2HGQtR3x5Ak7M+thOfifL9PXQyhvh4OaGwh903wH
 ePem5rBifH6vYxAzwSljTbLR/EmbhLaBPmqqdS7EG796xRTBswHFa6B07v91Q5vScFOZpOS5c
 Efd7dLd25gd4f8vambmPhJEErXnP5NdACQ+/a9LO97qNdgNhXmmFXij6tTAuybNdxbNkIF/tM
 XmyBK/Oln1d3IMon2CHHb9avCOFZWG7dXOIArCyAhV2ZUFTDSVXVVgiGYTF1+6ldsB3Tz7C6i
 uPK6oA==
Subject: [cocci] [PATCH] Input: MT - Return directly after a failed
 kzalloc() in input_mt_init_slots()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1404
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/5088a905-4f29-41d3-a96e-5b66aad551f1%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 20:36:09 +0100

The kfree() function was called in one case by
the input_mt_init_slots() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus return directly after a call of the function =E2=80=9Ckzalloc=E2=80=
=9D failed
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/input/input-mt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
index 14b53dac1253..24064447d600 100644
=2D-- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -49,7 +49,7 @@ int input_mt_init_slots(struct input_dev *dev, unsigned =
int num_slots,

 	mt =3D kzalloc(struct_size(mt, slots, num_slots), GFP_KERNEL);
 	if (!mt)
-		goto err_mem;
+		return -ENOMEM;

 	mt->num_slots =3D num_slots;
 	mt->flags =3D flags;
=2D-
2.43.0

