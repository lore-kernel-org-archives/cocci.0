Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C241C282C5
	for <cocci@archiver.kernel.org>; Mon,  3 Mar 2025 09:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=WARxepTLbX6z7UXlbBldqqIu0yYUulxOMgywu3vUm8Q=;
  b=KyTnzUl6muIG8HQq5rddxG3DdpW0PDjVA0BUOVrZizLBFo0rypSBKJYG
   cmiclkKWkF0AKNvikj5g2R0woD8Hv+Ltx7qquhGcpAPnLP1IA1XPVYZqh
   vkIMtYtWYD6W2IjLFApQnvaY93J5tWk0nSAJ9RWSPQntIhoUtltxDGJmi
   I=;
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
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="scan'208";a="210813143"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Mar 2025 10:11:45 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 87370E0264; Mon,  3 Mar 2025 10:11:44 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 69E60E0260
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 10:11:41 +0100 (CET)
IronPort-SDR: 67c5724d_70iz5G/+infUpvpePLzRcDOcSzpmz6cetXvdKQy/p8qOnhC
 ilQ3EbAXORSPXm+l7MlmM63nf1aYSBwGM+Zc5Sg==
X-IPAS-Result: =?us-ascii?q?A0GIAQAXccVnfg4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBAtIhFaIHYcygXQtA4Q7hzuMQoQGgVaBfg8BAwENQQECB?=
 =?us-ascii?q?AEBAwQ4gVSCdAKLFQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECA?=
 =?us-ascii?q?QECBAYBAhABATsHDgkBMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAgEDI?=
 =?us-ascii?q?wQZAQERJgEPHwEFAh8HAgJWBgESAgEBgn6CMAEDMQevGH8zgQGCDAEBBtpcH?=
 =?us-ascii?q?ywiV4FlCYEaLgGFa4JjAYYmhDwnD4FVRIE8C4M2iB6CaYQdgz2BbIpTHC2CJ?=
 =?us-ascii?q?ZkrgU0cA1ksAVUTFwsHBYE5OAMgCjQUBBkCFBwQBhAEanqCRWlJOgINAjWCH?=
 =?us-ascii?q?iRYgitqBAWDW4Q9hECCP1GCQoIRcYEXiAKBLYRqHUACAQttPTcGAwsbBj2hb?=
 =?us-ascii?q?jqEISABUjtDCYIdDZJvsyM0B4I4gWaBYwyfXgYTL5dFDgaSfAEuh2WQaiKpD?=
 =?us-ascii?q?4FnOoFcMxokgzZPAxkPjiEMFhaDdY8KAbkmQjU8AgcBCgEBAwmFRgEBilSBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 YT4eIycfHyGdA==
IronPort-HdrOrdr: A9a23:f+NgWKOhCE2MCMBcThWjsMiBIKoaSvp037Dk7TEVdfUnSL3+qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFgrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YFT0EUMr3N5DZB/KTHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:bcI4+GAa0O4GGsf6ExdX81EyN/43SUT6wWuLDRGdEThyUJTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AhKjGvw6W/3JFELAvt+VIi8rNxoxI56KvBV1OmKx?=
 =?us-ascii?q?anO22HAtVJCezjiq4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="scan'208";a="210813138"
X-MGA-submission: =?us-ascii?q?MDE2rEvlrp1E0QIxaX7J/EUapG95urov43eKtM?=
 =?us-ascii?q?iYsF6U/cxauXTw0h5hsibDlxGxaVRF+dDvuK773FTcoK0JyOdFH3H7bM?=
 =?us-ascii?q?jpDh05GX+k77QL2ySIawZVi5r0Ua8BjkuNgskINCeN5/W5j6Yq6eA9AQ?=
 =?us-ascii?q?ApiWu+nwFbParkEtGbap/qhQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 10:11:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740993085; x=1741597885; i=markus.elfring@web.de;
	bh=WARxepTLbX6z7UXlbBldqqIu0yYUulxOMgywu3vUm8Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FzKs2yQ2+Dr9AkXJ6s8AUs3iApm0Qd3ZZqIUDNbtjxegwkj/Z7WgngqpRAhVEP1q
	 E1MbzsmRG8HLcN8bx0DZAab+LWs5uKlToUU0P/paYopVSjO1c0jJSuWwEqEqeEQaC
	 mGXvm4a3Etq/uDv5Fdi8oWom3vPUGfjWWtx82fa+YMZUkIuuyz4DQoPDVrL8Z7jrn
	 k0NIueOlYgbqNp1f15ZdnRuzdhdgJAGGBJHF7qvOxGumeRz5sUF1J/33dSZaCPBkb
	 P3AhDZcjb8pA2PIQXcPK/RAlZ4BOP9+uXCGgb5DHVC+xjrc0iGMMwx50XDMREXGzI
	 JP+3ZMh5yOhu15l45Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0Igl-1t1rWE0UMB-00s8VH; Mon, 03
 Mar 2025 10:11:25 +0100
Message-ID: <35fbbb42-ec9d-4733-b3d6-8584b2faf6a1@web.de>
Date: Mon, 3 Mar 2025 10:11:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-scsi@vger.kernel.org,
 storagedev@microchip.com, Don Brace <don.brace@microchip.com>,
 "James E. J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Joe Handzik <joseph.t.handzik@hp.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Matt Gates <matthew.gates@hp.com>, Mike Miller
 <michael.miller@canonical.com>, Scott Teel <scott.teel@hp.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <fffd36dd-ec5d-4678-9e63-c52b0a711e76@web.de>
Content-Language: en-GB
In-Reply-To: <fffd36dd-ec5d-4678-9e63-c52b0a711e76@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bzWCP865hxjJTEzdBaGK2iRcc7VEhSNq1cYPXvWjRlHm0BJdnLy
 eNlUX2yPhreB/Y/Te31acndeYA/aUJapPjh00mR5T4j/2TGoNjeUt0+HCA+g35t9iSE9AGB
 5OSlbyFze3cHC6D/DMA+WTUTP9lJpe1Fc166mSGQ3ceC+qLQ0J7aSQJAFn2OemjuGMNKxC8
 wIug4eEhPB19n7y8/VuIA==
UI-OutboundReport: notjunk:1;M01:P0:d6HGg8ekmF0=;myk+a3gQ/3PlLho3pKO1Ayta7eU
 8aeyv8FOEjEdidQ1NAMCRKImjLV0xvT0+JPW0Cm4cLrxoOw7VAj7nTKWtKn8gWf3AxDokG081
 atokRK2aySYq2+ek4cv6OLtBNGJLyWkAjCUbTrRSh9Po9bqjyvAGm+iYvtfRO7FcrQzFYP+4s
 QragXsZNdnMtFpNbu6fWwtnQdg35AS28/14KWa2PEfhPQ2ztiXQg6a0NpnEeuTKgwjhJpH+Ei
 5KUCDNISWIePjMDhNJtlX9DyG+scXkTSLdF9wOc4fFZoF7o6GsOVYjPWV4fM41i9Ry6zmL2nd
 5cuE9imOnZHDbR2OSaZsdZBMok6WG96pm9T17ZNTCa3ieSxM/c5dz4KaQVQfelYkyH03ejqJq
 IENXnwFUXnG9e6DcQA1ZzJYabLxkX35O9nTKDRBxMpORmWGN68SQKVicCZ9SKVwbdNHPjM17f
 c1qg+5y2mbH3OHZABpJG7+sRiiDOSwujIXYKe+BrbxB5O+zQEvJzgzkMTffFhB01KV2ZXOA0D
 fHUmYupX0Pa/7bHZmfAg7Yx4OquYIF/7P9+Omr7zDNnUgLxdTLXy/6kE19wYaSuwHoaLRAFNP
 2c53lfxy7EbFCZ9PIHA7cI7r/tW+RO/1uwheEYjooq72xxxi0yYxCmBHW68wzt3MoHfBnkfZA
 ai9NpgQbH7H2DpvDRICQ+mr1sXrwj8brk/IVA1qYtfGwqrJ8oKCrLx/VxuuwjZedaK0PEIOXL
 6JF9JCn6DFwzjWaKhDGO+ifvmDFw0r5A1V87Tc3tHqYUrucivTDknCgJyJaCeYrq9p+acGyoT
 NN7/NUT0yfTxcPiHbBzVm6biSsw3u4zjOyGbId9JBC9znc3F6AQCkwz9DF31oIa1Dzd/QVhzC
 ywqmPuPoPEBraRAwT8n2MdtIPohrIKmozTeuMkL2tkl7zwI6MpHebIAH+ESRDiXuLVGCF5Y8N
 goSNL8NFKVL3yOQhzwT88LPVbcyKrEyFxa4MYSZYC33mU/bOCO6Kgbw1GjMjUm6hWaOjoHMKg
 aOThhuZ6R6krfZP6Nfn2KhulCi0zv8dRZMpRYjKVas0rVXfDu9ugb+PggYZ0NjYgMLahHjGMu
 4x6WToLTBcxSTxeCkoiPnozGzN9g+QypkqiNqR4WT+CQNxxji7dhYnLi7ctKwl6gHdjsNGXij
 X1fAL0nELfsfMyJxFYw59Q8CR1sB/jfRnJ/3uykDsK8Zw4m+1NrFXpwmrEHKXpekNjuOobvIk
 Of69kDom93Fiek1PYFjK975PfYKZIGWfcxh1LQ9SpXXnOHxeBmU1oNElGqm+tSQRjzAAEM8ns
 sef7+/NcuLjsi+R7h1V+e8a84NHDAvdQF0bpLX5mud2pDW/+clmarQ0F7QUtuyoRXNrqLrOoX
 M3URhkyF16uuf1EMRLAWuiS+3OjF3NttBKD22p7aFMloZYrG/DEjZ718DnKpFqUzloXL0+MGX
 P09d/eQ==
Subject: [cocci] [PATCH RESEND] scsi: hpsa: Move two variable assignments
 behind condition checks in hpsa_scsi_ioaccel_raid_map()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2476
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/35fbbb42-ec9d-4733-b3d6-8584b2faf6a1%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 14 Apr 2023 11:00:40 +0200

Addresses of two data structure members were determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Chpsa_scsi_ioaccel_raid_map=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for two local variables behind some condition checks.

This issue was detected by using the Coccinelle software.

Fixes: 283b4a9b98b1 ("[SCSI] hpsa: add ioaccell mode 1 RAID offload suppor=
t.")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/scsi/hpsa.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index af18d20f3079..562bb5eab134 100644
=2D-- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -5104,8 +5104,8 @@ static int hpsa_scsi_ioaccel_raid_map(struct ctlr_in=
fo *h,
 {
 	struct scsi_cmnd *cmd =3D c->scsi_cmd;
 	struct hpsa_scsi_dev_t *dev =3D cmd->device->hostdata;
-	struct raid_map_data *map =3D &dev->raid_map;
-	struct raid_map_disk_data *dd =3D &map->data[0];
+	struct raid_map_data *map;
+	struct raid_map_disk_data *dd;
 	int is_write =3D 0;
 	u32 map_index;
 	u64 first_block, last_block;
@@ -5209,6 +5209,8 @@ static int hpsa_scsi_ioaccel_raid_map(struct ctlr_in=
fo *h,
 	if (is_write && dev->raid_level !=3D 0)
 		return IO_ACCEL_INELIGIBLE;

+	map =3D &dev->raid_map;
+
 	/* check for invalid block or wraparound */
 	if (last_block >=3D le64_to_cpu(map->volume_blk_cnt) ||
 		last_block < first_block)
@@ -5397,6 +5399,7 @@ static int hpsa_scsi_ioaccel_raid_map(struct ctlr_in=
fo *h,
 	if (!c->phys_disk)
 		return IO_ACCEL_INELIGIBLE;

+	dd =3D &map->data[0];
 	disk_handle =3D dd[map_index].ioaccel_handle;
 	disk_block =3D le64_to_cpu(map->disk_starting_blk) +
 			first_row * le16_to_cpu(map->strip_size) +
=2D-
2.40.0


