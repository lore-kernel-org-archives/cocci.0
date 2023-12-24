Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19166C46CD2
	for <cocci@archiver.kernel.org>; Sun, 24 Dec 2023 19:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:cc:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=YOYYXyFTLSudua6nzEyPeLKBENkxL6WPxhrpQsA2si4=;
  b=f4jItQVkMpU5wfYa9fQ4kMnY/B1Ks7wsj9KfyjMoNy4OJHBwMHiRtXzz
   9wz1lSI4nDOZQyC4J/7neImpGBx1z5ziTii2aopNfZ6UTLvbbVe1/xzDy
   Jzfm8H36eXf9HzsHrE3J/SuYCuOrWfJCDQzYTNmGsF7S5FVrDuNdHoY54
   g=;
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
X-IronPort-AV: E=Sophos;i="6.04,301,1695679200"; 
   d="scan'208";a="143941876"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Dec 2023 20:56:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AFDE3E0CCF; Sun, 24 Dec 2023 20:56:25 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EC01EE004E
	for <cocci@sympa.inria.fr>; Sun, 24 Dec 2023 20:56:24 +0100 (CET)
IronPort-SDR: 65888ce8_LIjlZXHHe534kkcjR4I1zF5so2Jz2noHiugDlVpm44IP5h5
 HedjL5IpinB/ALLmKSLuZhdV7diXhXx9XnyXfNQ==
X-IPAS-Result: =?us-ascii?q?A0FlAACujIhlewQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYI4f1MyBAtIhFORNi2EPoc1jDeEBIFWgUA+DwEDAQ1BAQIEAQEDB?=
 =?us-ascii?q?DcBgVOBYIEUhzgCHgcBBDEIDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQEkGAYOECeFbA2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR?=
 =?us-ascii?q?2sEGQEBESYBLgEFAh8HAl4BEgIBAYJ8gisBAzEHrzV/M4EBggoBAQavWB8sI?=
 =?us-ascii?q?laBYAmBGi4BiBoBhWeDHIFGD4FVRIEVJ4NBiB6CaIkdBzKCHINQkVp9BUFwG?=
 =?us-ascii?q?wMHA38PKwcEMCIGCRQtIwZQBCghCRMSQIMvCn4/Dw4Rgj4rNjYZSIJYFQw0B?=
 =?us-ascii?q?EZ1ECoEFBeBDm4bEh43ERAFEg0DCHQdAjI8AwUDBDMKHQshBVYDRQZJCwMCG?=
 =?us-ascii?q?gUDAwSBMAUNGgIQLCcDAxJJAhAUAzsDAwYDCjEDMFVEDE8DaR8yCTwPDBoCG?=
 =?us-ascii?q?x4NJyMCLEIDEQUQAhYDJBYENBEJCygDLAY4AhIMBgYJXSYHDwkEJQMIBAMrK?=
 =?us-ascii?q?QMjdBEDBAoDFAcLB1wDGSsdQAIBC209NQYDCxsGPgKmSlMoE0yCKhwRxFQ0B?=
 =?us-ascii?q?4I0gWCBYQyfKwYTL5cmDgaSUwEuh0AQkE8gqEaBZAE4gVwzGiSDNk8DGQ+OI?=
 =?us-ascii?q?AwWFoNzjwkBPUA1OwIHCwEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
 ZP+9xp9
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:jZWr7aHHyvzd4+uapLqEMMeALOsnbusQ8zAXPo5KOHhom7+j5q
 OTdZMgpHnJYVcqKRYdcLW7U5VoLkmyyXcY2/hyAV7AZmfbUQmTQL2KhLGKq1Dd8kbFh4tgPM
 lbE5RWNP21K0RmhsDn5wSCH88n28TvytHSuQ6T9RZQpRoBUdAY0+6VMHfiLqX8KTMtOaYE
X-Talos-CUID: =?us-ascii?q?9a23=3A0EE5rGreTmuSAEDy/w3yhnTmUf01ciDNx2noH3W?=
 =?us-ascii?q?bDkRSU+Wkc3uypZoxxg=3D=3D?=
X-Talos-MUID: 9a23:pRvNHwYDFEODnuBT7A7cgWhNLptS4vqqUwcGya8Ho9jcDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,301,1695679200"; 
   d="scan'208";a="75296975"
X-MGA-submission: =?us-ascii?q?MDEIfNUmPtRu+Ge0qVQ4IF+GNtOkCYHGKQ8gvj?=
 =?us-ascii?q?itRXWBZ01edg6YyhD5avmfa142WM/rkYTOcxgV1dzvYpRETCUJh4Uxiu?=
 =?us-ascii?q?qII0jlfsRhV+xVJeV3WO0m1PW7t7+DF+1BkMwiGrlO+VbU+aBHM0Xo2T?=
 =?us-ascii?q?dDm5xpo57EX8/Y4Fc4SSKdcw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 20:56:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703447762; x=1704052562; i=markus.elfring@web.de;
	bh=cm+fIZLlDlbOzuqZGb6TsofPaKLKFGH0UKkUeJ6PVQI=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=QoZIYXi9cZqtNGtvF4UCvUpoCNwOxR8e3FLbju/ydTYgpkVlGSLCy5MC8nVGT41d
	 eResBJliME/ri5g5oXcpGtQd7eN/tTvbli+mycPuwFfAAEpCYPv8bFFpmcWBLUZ+A
	 M1E4tfznDYRUXyX/fTG/K//nt3lCGAOz2gskuUMd+dPhYyRfMbOgIT5O8xlvrpe9j
	 kj1gTCRZ1uGzPVOtzG7VUm8SuIOZuY32IdW8pcMq8q59rfsq76B94swfYIVlX4K4S
	 0RObHdyPjK6Jfb4r07GwvwAVFrg3aDQw6uV3QIzkWhBmAhK8U6JXyFXDEdAkt+G82
	 REFyZpZ7q9FVI2T+tw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7xeZ-1rDu1x2ZpT-014bII; Sun, 24
 Dec 2023 20:56:02 +0100
Message-ID: <2413f22f-f0c3-45e0-9f6b-a551bdf0f54c@web.de>
Date: Sun, 24 Dec 2023 20:55:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: virtualization@lists.linux.dev, linux-crypto@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Gonglei <arei.gonglei@huawei.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:js4ydb7183jogO2zNXAOsnmwRjTJkFts4230ojusF5s86M+AW5+
 R5GJtNhXdNtM4tEDbq+iQg1RPiFfkUqzLSGBlTwOtVrdN81X0QdPgkZwQOUuzk5G6JgcA2/
 a9bXWU4zIOkvteJDFZzgqHxnSoSM5vjhMP+WvH/mLObV2o2cMeoKp3S7dg2xNq5LAjTBtMO
 gxGXiKX2GEOup1Ii5BzbA==
UI-OutboundReport: notjunk:1;M01:P0:WbQ2yg1lmBc=;3P3aWHeDFAyqdOaqJJeKgIAbuWq
 IaQuiX66fOG4HO1fbgWMKF56zCIYOlf1AD/+aEXdGYWKqhXFP09cN9kpPPdfEShTApKnr6BWB
 OBGdTNc/CPS36kVuShgdvl6opR6/xO359mXEID+rkcOltIguEUYU2CITRnsfLCRZSQ0E//dKh
 IXtHvmiBcN6iEiektNZQDOKynYCUCBBps2/cHdgz0qtl3KxEgKhbyrPRSZeQMFybO2F/5xFtt
 p0y2gz506LIVL0Z+76Fyr/WQAUqwFVBvqylEhEJaWnhlg7tjc8JHXoLkfqazE8//fxucj0rzd
 9C2tARpcByUWLK1rMuufdESRp6PZi+WnZXuJb+hQiWvcnPtZ4tmVIRs5TnZi0tFfuC/euHMRo
 NraWgvInU3jVsmCI//aiVaC8snV1L/ZY7i9A14A30bQoxtgao3NIR0ONSAqE95d04LblUro1d
 hRzksKgd17O0eknBO6fIbO+He7glZ8dbMZQGmX7yrMKEZT6PRYtc2mLJP2LbHorzed4YXR+1d
 IYpBsO7e65qV7dpR739Wo4SO+I14ReGMPJzC1dflQ/hmg8jwpUkiHkt/njIbGAKLKx/9wFgKS
 EjSVQ5YZ1iVI39XMUnPUcNaog3hVm4xnsZLJR32H9Od9xyY6upJ5/eex2a6SCLGBq5pthhaJA
 rKkFNI0hbwchKG59NklNFDR6FOBOESDr9TjazPDUTtrY1BxFQr9Mf6l6R9vZ+ckSZyyzp6aDA
 JktyzBrAQlO6KNOQUYxLkUdPYWigCLlRRvz45mv+vYTHm4WsnRQPoYfX7wVRbOsdr4cwWlaJ5
 SvB5fkElpx88XTzd8X0oPqsrZ81am9pzI4lThisgJXALB4sD1xBBYOCdfkPZpw5NlLSdmo8yI
 MsvPcbhr2uh59j20gkLG3pcXm9dQ7ixm67c1pklP9d9ccELRpnpWxsmdEq7JPbQliKyiT9syi
 20AXhQ==
Subject: [cocci] [PATCH] crypto: virtio - Less function calls in
 __virtio_crypto_akcipher_do_req() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1379
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/2413f22f-f0c3-45e0-9f6b-a551bdf0f54c%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 24 Dec 2023 20:42:19 +0100

The kfree() function was called in up to two cases by the
__virtio_crypto_akcipher_do_req() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Adjust jump targets.

* Delete two initialisations which became unnecessary
  with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers=
/crypto/virtio/virtio_crypto_akcipher_algs.c
index 2621ff8a9376..15dbe67f0d31 100644
=2D-- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -224,11 +224,11 @@ static int __virtio_crypto_akcipher_do_req(struct vi=
rtio_crypto_akcipher_request
 	struct virtio_crypto *vcrypto =3D ctx->vcrypto;
 	struct virtio_crypto_op_data_req *req_data =3D vc_req->req_data;
 	struct scatterlist *sgs[4], outhdr_sg, inhdr_sg, srcdata_sg, dstdata_sg;
-	void *src_buf =3D NULL, *dst_buf =3D NULL;
+	void *src_buf, *dst_buf =3D NULL;
 	unsigned int num_out =3D 0, num_in =3D 0;
 	int node =3D dev_to_node(&vcrypto->vdev->dev);
 	unsigned long flags;
-	int ret =3D -ENOMEM;
+	int ret;
 	bool verify =3D vc_akcipher_req->opcode =3D=3D VIRTIO_CRYPTO_AKCIPHER_VE=
RIFY;
 	unsigned int src_len =3D verify ? req->src_len + req->dst_len : req->src=
_len;

@@ -239,7 +239,7 @@ static int __virtio_crypto_akcipher_do_req(struct virt=
io_crypto_akcipher_request
 	/* src data */
 	src_buf =3D kcalloc_node(src_len, 1, GFP_KERNEL, node);
 	if (!src_buf)
-		goto err;
+		return -ENOMEM;

 	if (verify) {
 		/* for verify operation, both src and dst data work as OUT direction */
@@ -254,7 +254,7 @@ static int __virtio_crypto_akcipher_do_req(struct virt=
io_crypto_akcipher_request
 		/* dst data */
 		dst_buf =3D kcalloc_node(req->dst_len, 1, GFP_KERNEL, node);
 		if (!dst_buf)
-			goto err;
+			goto free_src;

 		sg_init_one(&dstdata_sg, dst_buf, req->dst_len);
 		sgs[num_out + num_in++] =3D &dstdata_sg;
@@ -277,9 +277,9 @@ static int __virtio_crypto_akcipher_do_req(struct virt=
io_crypto_akcipher_request
 	return 0;

 err:
-	kfree(src_buf);
 	kfree(dst_buf);
-
+free_src;
+	kfree(src_buf);
 	return -ENOMEM;
 }

=2D-
2.43.0

