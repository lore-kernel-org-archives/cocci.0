Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6FCC46CD3
	for <cocci@archiver.kernel.org>; Tue, 26 Dec 2023 10:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ZAB+J1xAcPCl5XnIwRI2285jEua7xmigQbkEuidfN1Q=;
  b=YdRklwVjoRinbHeKMDoZAkvEpZzQ4NCq/zeN7kidTn2dncb1e0F4qG4w
   5d5dDmEkfqu9XhyVlr81AmuwAk2yHBernqxv28eAMVamIOIhY1DdDVauM
   HnFvEdB+JjnAzlPTEYvgxBwC3O9XaeXbgG/P9FSeRIvuS7TTH2P2Ni2cw
   o=;
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
X-IronPort-AV: E=Sophos;i="6.04,306,1695679200"; 
   d="scan'208";a="144036873"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Dec 2023 11:13:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 61A26E0CCC; Tue, 26 Dec 2023 11:13:00 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1E3F7E0D74
	for <cocci@sympa.inria.fr>; Tue, 26 Dec 2023 11:12:59 +0100 (CET)
IronPort-SDR: 658aa72a_tlV2fbzKbnJuo9/vrG+eF4U5acaOsbYkMliMv5caFrZmAuG
 /8Zkr4ElpPHPMgu77+pUC4ijRzw89VlfqqD/LVA==
X-IPAS-Result: =?us-ascii?q?A0F1AADipYplewwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4f1MyBAtIhFOIHYkZLQOEO4c1jDeEBIFWgUA+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBDiBU4FggRQChzYCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQEkGAYOBQsnhWwNglwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEXAkdCAwMjBBkBAREmAQ8fAQUCHwcCAlYGARICAQGCfIIrAQMxB65ifzOBA?=
 =?us-ascii?q?YIKAQEGr1gfLCJWgWAJgRouAYgaAYVngxwleicPgVVEgRUnC4M2iB6CaIkbB?=
 =?us-ascii?q?zKCHYNQkVl9BUFwGwMHA38PKwcEMCIGCRQtIwZQBCghCRMSQIFdgVIKgQE/D?=
 =?us-ascii?q?w4Rgj4iAgc2NhlIglgVDDUERnUQKgQUF4EPbhsSHjcREAUSDQMIdB0CESM8A?=
 =?us-ascii?q?wUDBDMKEg0LIQVWA0IGSQsDAhoFAwMEgTAFDRoCECwnAwMSSQIQFAM7AwMGA?=
 =?us-ascii?q?woxAzBVRAxQA2wfMgk8DwwaAhseDScjAixCAwkKBRACFgMkFgQ2EQkLKAMsB?=
 =?us-ascii?q?jgCEgwGBgldJgcPCQQlAwgEAyspAyN0EQMECgMUBwsHUgMZKx1AAgELbT01B?=
 =?us-ascii?q?gMLGwY+AqZPUygTTCaCBBwRxFQ0B4I0gWCBYQyfKwYTL5cmDgaSVC6HQBCQT?=
 =?us-ascii?q?yCoRoFjOoFcMxokgzZPAxkPjiAMFhaDc48JAT1ANTsCBwsBAQMJhUYBAYNag?=
 =?us-ascii?q?UYBAQ?=
IronPort-PHdr: A9a23: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
 TE=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:zNqfqatgJMRT+kvrjiji4/A77skDgNV00zEX/kB9WHVpm6yj/P
 xG785rsSMc7wxhI03I+OrwXZVoLkm8yXcY2+Ys1PKZLWvbUQiTXeJfBOnZrQEIcheWntK1l5
 0NT0EUMrfN5DZB4PoSrDPZL/8QhOKc6aitiKP3xWpsSwYCUdAZ0y5JTj2AC0VzSU1/GZYkGN
 6966N81lydUEVSVd6jDn0JG9LOvMLGj/vdEHk7Li9i0hCHiT7t07LhDx2Ety1uKg9y/Q==
X-Talos-CUID: =?us-ascii?q?9a23=3A5llqLmp8hmLCv5fdEOCncsHmUeUvKVuGlSvMGWC?=
 =?us-ascii?q?9GD4yD5analCU4poxxg=3D=3D?=
X-Talos-MUID: 9a23:5ManGATi9fA5G/1iRXS0uik+Pupw3Z6TN2AztIQ24+yPaDxZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,306,1695679200"; 
   d="scan'208";a="75353488"
X-MGA-submission: =?us-ascii?q?MDHqR0/6pM0+MWc8s9r4I2z1ts4nagBl4gkAlM?=
 =?us-ascii?q?uuEvE/lCkQeES/bq8w66nz+uHlXHQYXpvtJeMiqKW7rex0bwuJwwKcx5?=
 =?us-ascii?q?P69qIyvd1pPouRCMrcfF89XmE0Ta1wyFRGaru18wNfgcBwTF+mPTe90Q?=
 =?us-ascii?q?8we9sNp/aTJ7k7KazVgAUt2A=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 11:12:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703585548; x=1704190348; i=markus.elfring@web.de;
	bh=dPv4vm2V0dtNM9i6ea9tTX3+xLFfWPWmI5QeWJPTnZk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=qctTj9H1YVuIc3m8+kAdWWGMz52a5nerjKipKUSb6X8ybQ8HqLI6Fm7K+JOA1q/j
	 chiHL60LtJaQG8B58YOM4rEr9Xx+MEj4DQLXr80xtHmwVA+t2Lzh4Juxb/xXQLn/8
	 JUBotIqKsiDzTLSsPto/n+/GwCINXYPM13DmwzXE3nBTKZ+uqlOqTu4ESJcHDKrKB
	 o/oPJWLn42XMytEJk9QA5fSpUPH3u+Ga9weIjWDsGTDlmxjN/45/L3ayhy8ZxKW7l
	 NbMKFMb2jaAQxa7Z6K9Os2ldxslTommCScCEiAI7p6J++Oe1zU6KUu5yMo0Y+dwts
	 Ih+seoMJWTukJthKvw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgzaR-1qmKZd2f09-00h0gW; Tue, 26
 Dec 2023 11:12:28 +0100
Message-ID: <7bf9a4fa-1675-45a6-88dd-82549ae2c6e0@web.de>
Date: Tue, 26 Dec 2023 11:12:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: kernel test robot <lkp@intel.com>, virtualization@lists.linux.dev,
 linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Gonglei <arei.gonglei@huawei.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <2413f22f-f0c3-45e0-9f6b-a551bdf0f54c@web.de>
 <202312260852.0ge5O8IL-lkp@intel.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <202312260852.0ge5O8IL-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YN0MO2vfA1atqF0nbfqn3SUIOjqrjmmzVaCGbVBzhr1uK75lo+t
 Z+XanIEq02qD07l7cGh0qCNmrpZhVE1z34Lyp8XzjJZz1NMCNGi0WvNA0YgL+CUCd3AkrUH
 u4m7w4Ne71OdUv3nbMx76OomPu4ThXd6ZHN3zMk7meKGBNwTcpJaMKYb1ZhMM9nhYIGQd72
 CDypDzv2I327qYKzDGLtg==
UI-OutboundReport: notjunk:1;M01:P0:8nuqnBAmzpc=;fggNP23Hu6H5jAMVog3j6WuwsVy
 SNSPoYpjKMwrNPMQKvNUF2W2BCNiSMXM6+szPZlgk5czdie42gPPZHtJ7lVD+Ve9gzqracOJ/
 vJ5Nm0XtiPrhTYtne9KKJkgViiSJ9VRdwEOQg6qSSh0Mb6GF61My09Xu6t5blbdrTD8JCW+hi
 ZTyonCXTwrNSC5ybEZGjj1n1oSG7o6W0ZyXTEGYjlWq1Uw0g/0LYWTSyw0Ul4AyVOp9mf5bar
 LyyuaOfeY/6x8vmc4qN2V+wcRolHAdWvCkMblNmdfH5VNDTOO/6vgqOkQJ+4I+RmhODXe5aEk
 zcSDuO/zOLanNfFuqFZDqVUBziTSeoqXMdbMmvR+VbZse1YRLch5Kgaddv1kU57k/LvAdCeV/
 jITnam948vgtGL4CSq8sG+SNxwq7haNKwfXVlqMV0PvdcaZKULiS7OwcIu+JAjAExqHxn9VhC
 sQxEIQsHz0Vros/asQqPXaV9By64fZ4xZV9YTcYW9kYUMzFbACzWecX2MxryUt7VZdNL0hAKD
 h8b9hiub2b7uHr2lWE6sgLF0Lza1HRxLQE4P1gx/2/FK+TdMtwfi6fdlCUq0YAtkVAjhJ3Itc
 7IQDzC6bKhG423ry4K5JJNPQrTieQVnchifFCJs9ji2RXXV7XAHJXJVTFsCMbvMSzqAYgrCjE
 ju2Lwc6iP4UF7ZT3PH1U5EkOjtkCUdjCEKcUxI9LG/RG9IQd4xrfJgOvxzxFRAa0hNFbco+mU
 3K0PdeaQhY/3yQPOjtIfTCJAM0mn9o5LiJ/TwzfQnF6fBQgzwjZPllvg7PJdAgRahw1GDP0AU
 4q0P9MY9OqRHgjCkBcqICAHF0Pb6L3gb166r70ry43nveXIZQuABdfP9ZVueBQ6dIV4gzclr9
 T3QMf/bkPp2VN9TN5sd/4dEflY8gfYX/vQqODRKtrK+Izhm70lJna8tRR0QH1TcGjBgoTUfi3
 VOtIf1J/PSAE+RJkUJCU2HoAB14=
Subject: [cocci] [PATCH v2] crypto: virtio - Less function calls in
 __virtio_crypto_akcipher_do_req() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1397
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/7bf9a4fa-1675-45a6-88dd-82549ae2c6e0%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 11:00:20 +0100

The kfree() function was called in up to two cases by the
__virtio_crypto_akcipher_do_req() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Adjust jump targets.

* Delete two initialisations which became unnecessary
  with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

v2:
A typo was fixed for the delimiter of a label.

 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers=
/crypto/virtio/virtio_crypto_akcipher_algs.c
index 2621ff8a9376..057da5bd8d30 100644
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
+free_src:
+	kfree(src_buf);
 	return -ENOMEM;
 }

=2D-
2.43.0

