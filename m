Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C2CC46CD4
	for <cocci@archiver.kernel.org>; Wed, 27 Dec 2023 16:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=WiJFBBsloAxibDUTqP46X7vHAqEkxxN2BnwJaMXcZhQ=;
  b=llSXrgpiq67jBuuxZH4YL/ka++QyCJ63jYcLKTn9wTo5FvYUsyzGqA1C
   vjQl7/c8hiAe/RnATq5id40G0af90z3+oh8E8DaCtp+EUFYTYmYiH6xI1
   e/kT9WeXxD7m9tboP8SHBZJectqT75mNpVOAAEAyJT5unetC96WB7oLai
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
X-IronPort-AV: E=Sophos;i="6.04,309,1695679200"; 
   d="scan'208";a="144147225"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Dec 2023 17:02:11 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 24582E0CCA; Wed, 27 Dec 2023 17:02:11 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0D752E004E
	for <cocci@sympa.inria.fr>; Wed, 27 Dec 2023 17:02:06 +0100 (CET)
IronPort-SDR: 658c4a7d_d50Re7Qh8Cn5YuZwAlczMKNiINW+8TpJECEjCShRRTs22X/
 qCOOAw3FPVu98vBv8jHEdAo4YTFEr3TPM6qP7Yg==
X-IPAS-Result: =?us-ascii?q?A0EqAACzSYxlewQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4f1MyBAtIhFOIHYckgXUtA4Q7hzWHTIhvgVaBQD4PAQMBDUEBA?=
 =?us-ascii?q?gQBAQMEOIFTgnQChzYCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQEkGAYOECeFbA2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RcCR0IDAyMEGQEBESYBDx8BBQImAgJWBgESAgEBgnyCKwEDMQeuNH8zgQGCC?=
 =?us-ascii?q?gEBBoJmrHIfLCJWgWAJgRouAYgaAYVng0F6Jw+BVUSBPINBiB6CaINmhTYHM?=
 =?us-ascii?q?oIcg0+RVn0FQXAbAwcDfw8rBwQwIgYJFC0jBlAEKCEJExJAgV+BUgqBAT8PD?=
 =?us-ascii?q?hGCPiICBzY2GUiCWBUMNEp1ECoEFBeBDm4bEh43ERAFEg0DCHQdAhEjPAMFA?=
 =?us-ascii?q?wQzChINCyEFVgNCBkkLAwIaBQMDBIEwBQ0aAhAsJwMDEkkCEBQDOwMDBgMKM?=
 =?us-ascii?q?QMwVUQMTwNsHzIJPA8MGgIbHg0nIwIsQgMRBRACFgMkFgQ0EQkLKAMsBjsCE?=
 =?us-ascii?q?gwGBgldJgcPCQQlAwgEAyspAyN0EQMECgMUBwsHUgMZKx1AAgELbT01CQsbB?=
 =?us-ascii?q?j4CpkYHUygTTIIqknKTHZ5yNAeCNIFggWEMnysGEy+XJg4GklQuh1CQTyCoR?=
 =?us-ascii?q?oFjOoFcMxokgzZPAxkPjiA4g3OPR0A1OwIHAQoBAQMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
 7IRR7UdWFFnT5sn
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:gQ66Pa5yMc/S8otvowPXwBzXdLJyesId70hD6qm+c20wTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhX4tKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkYNDSaNzhHZKjBkWyFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3Ah8PTBmuWBiDz4q0w5o5kX2M86It0biLF9yj6DXW?=
 =?us-ascii?q?mGElLWaW4RwKQ5PlNxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AiKp4aA6W3OvpiHETU8TkqegTxoxvxrijAloLrqk?=
 =?us-ascii?q?alPC0NzZgBR6bsi6oF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,309,1695679200"; 
   d="scan'208";a="75415213"
X-MGA-submission: =?us-ascii?q?MDGvYTruFoTy7zn6RXcWzkCoAHX/tuj590wbyM?=
 =?us-ascii?q?eXP6F0JXbghvGaw5+HzieSHeEMq3Un85OsCamnpzBRR3Ybw8I50DWz+V?=
 =?us-ascii?q?nalzIEBZCXPiHww4YSukxMrfFbDqdSU76u1v2RCOPyokjEqALgBj4q/B?=
 =?us-ascii?q?OoS4LRHtJcOoULwdnZ7xk6zg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 17:02:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703692924; x=1704297724; i=markus.elfring@web.de;
	bh=16Blx+9N7z4bjqF+m7XVewE8iR9w3Nt9BYK+5r91TuE=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=nXKyQupFmo4m64oK7Py/UPodRNB3Pkrvj3shcnAfO2VQxs7d9/u5Ag3vc20ym/GO
	 8T6B/pCtyLiaT5LUVgZpD4AZTmoi5L4QF/bVf+xqET27S5e0ACm6PY7Q0x6+/TSBK
	 kDuqYBwr9jiHYPXH+AE7bTapOzwThYXh/HBJZcPMmkLc2OhLVtBRuwxKTAVSqQw/E
	 92xQqq93cZhiQs0MwCQ6Jg5yLqlRraQceUdCULwYzPX1QxZoe14Ox4NOaGhLcJx9q
	 uR0Y9PwZ7HvjZGNlGtUdNhcHC6kA9bqmOqQENrZIgCtAgawxp1/WaH1GBZD+ZyORm
	 ucvyUHan+B2/NBlxzg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7QUL-1rBDIP0ksn-017MNO; Wed, 27
 Dec 2023 17:02:04 +0100
Message-ID: <0a98d3b6-e0ec-408a-aa2d-f2b23dcff26f@web.de>
Date: Wed, 27 Dec 2023 17:02:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <9a683f73-c5a2-4b80-af1b-01540834a3dd@web.de>
In-Reply-To: <9a683f73-c5a2-4b80-af1b-01540834a3dd@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W/Z8o/ebT8qpjn7mjOZHqGDXLydJr/iUnte/oPoN9Zad6aSwnd7
 oNHLsGSs4G2L5LWejGRz55i4BzHmghDJS26wD0kCFK1fQ14uOyh5V6eysxyvezJtsDqZqhT
 6+h7hUlmjX5oCaUBtQ2wH6Kg/wQU58+EWPUZlz1eVHEY5APPwLTiKJtgKflCal6fhmnODBd
 2m9sNG/OAtgrng0ux2Gfg==
UI-OutboundReport: notjunk:1;M01:P0:RwLqXCnTS9U=;WB/CrvRL8cCZcbwoyAyBMq31xJZ
 Yh+p0YHY2Z9lkWI3ozXZwEXCOK6KYLocBXOlpsf6A9hcfX0vbGz36Cj4t3JnValiIhhFNk/lK
 g4L7ZpP8o6aIpEo44fl/Nm25vBrgBWCPxX4Lu4csC8mlkblRhsPSoXhAPDSxyaiJPVFzr9R8r
 5lV6YA43DJi9v4OMdT5DuqAReYNWrEVDq8bXAP8Hy9sFbM0712pW8ub5Hf0CZejYH1vdG8zNC
 755xYwVuODj+XXWrAt+ENVw6l6RXWF/qPbGQlVoN6TGRpjLkOMhb+kLir/LXOIeb7HYnB7xb6
 nhYkHXsaZhZFMIU63pt+J8ALoqgnht36er8APhCQAyh+0slogvBcXMDa1bU0X7aDSGPfqIyhH
 bwwnARIiu7SGKCpAjtOhYNg31qDzZDm2pKxS7DGO/KolIUNKlpl4G7aPOSVsl925Z8MvMSMql
 OFfgm5+GzmxWd9PsyJnxQk0OlZ9Qy73VAEo8jH+w3NO9BAqMtTycWPjGTQVAjgg44D9l2oLJl
 oY5VtNRIg+RDXBxOLj8FVYl1kDcpWqPyDQRZJZs7PYKhef4BzjzMV4PAe0bX7OGB66/TsVheC
 BSQeq+v8mWQdk76d/KHRwkYXdoKG76K1cmVnb+aMcgpuxF5Zb+jn73CJbK3FEFD/BKT5OIkGP
 n3aE98Gj68goGUmdKgQUyLbX8URiTlB1hoDtGUiBIXkB6kgjtXI8T+8AuYxVZnnsnAxyGtKI8
 6tOi9yLiKQl1FADwfc78SCEMRUSot4ao5aaZx4a/qqa8ToDGXUzH1WiPt6DZCiix9Tea3T6/A
 rttbihdh3TuZe8kA7MUkAaTVgZ/UtUi/yBNtELjRnysQqOkJCEdXKc1khazNnOCPrZ8jZ6BBo
 DS9RxW15Ishhxbz/azlCMVLuCJVigNJzWo/GEvSbj+Q9xBr6lrKoK1Dhk2H+7Verwpruq6fdY
 wfcTXw==
Subject: [cocci] [PATCH 1/2] nfc: mei_phy: Return directly after a failed
 kzalloc() in mei_nfc_send()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1417
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/0a98d3b6-e0ec-408a-aa2d-f2b23dcff26f%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Dec 2023 16:30:20 +0100

The kfree() function was called in one case by
the mei_nfc_send() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus return directly after a call of the function =E2=80=9Ckzalloc=E2=80=
=9D failed
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/nfc/mei_phy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nfc/mei_phy.c b/drivers/nfc/mei_phy.c
index f9cca885beec..937f229f4646 100644
=2D-- a/drivers/nfc/mei_phy.c
+++ b/drivers/nfc/mei_phy.c
@@ -208,10 +208,9 @@ static int mei_nfc_send(struct nfc_mei_phy *phy, cons=
t u8 *buf, size_t length)
 	u8 *mei_buf;
 	int err;

-	err =3D -ENOMEM;
 	mei_buf =3D kzalloc(length + MEI_NFC_HEADER_SIZE, GFP_KERNEL);
 	if (!mei_buf)
-		goto out;
+		return -ENOMEM;

 	hdr =3D (struct mei_nfc_hdr *)mei_buf;
 	hdr->cmd =3D MEI_NFC_CMD_HCI_SEND;
=2D-
2.43.0

