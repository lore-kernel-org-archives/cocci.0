Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AFEC47073
	for <cocci@archiver.kernel.org>; Wed, 27 Dec 2023 17:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=IxwSQST7HNjtOdOb2AtzNcuTs+5ksSiVOO0PU4T20Zc=;
  b=XdVN3nFK7ibE7z/7iHO2g1/OSeWHKFtPN6H42uiyGegt+huQ9g0ddxwB
   39lRQVO/nEpTs0FjQpBYEWdZYgR2ObCO44dhu6eza7POFn+p01l25cx0P
   VEsrYazbhtRRNjtHa/g7ubdJ/XXfJHcDxgtWdyNsK+/22lRZETniX5o2/
   Y=;
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
   d="scan'208";a="144151898"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Dec 2023 18:16:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B6F8BE0AF1; Wed, 27 Dec 2023 18:16:47 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8E446E004E
	for <cocci@sympa.inria.fr>; Wed, 27 Dec 2023 18:16:41 +0100 (CET)
IronPort-SDR: 658c5bf9_j2g07XNKgSYAoFF701kUs/HcypSfXVromJX59ZrI4lrMcKk
 X5e+6gi9gywiq5KPKLohYYWz/Qfdd8NK62vB3JA==
X-IPAS-Result: =?us-ascii?q?A0EvAADlWoxl/wMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4B3hTMgQLSIRTiB2HJIF1LQOEO4c1h0yEa4QEgVaBQD4PAQMBD?=
 =?us-ascii?q?UEBAgQBAQMEOIFTgnQChzYCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQKBBhOFbA2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR?=
 =?us-ascii?q?0IGIwQZAQERJgEPHwEFAiYCAlYGARICAQGCfIIrAQMxB64zfzOBAYIKAQEGr?=
 =?us-ascii?q?1gfLCJWgWAJgRouAYgaAYVng0F6Jw+BVUSBPAuCQHaECoQUgmiDZoU2BzKCH?=
 =?us-ascii?q?INPkVZ9BUFwGwMHA38PKwcEMCIGCRQtIwZQBCghCRMSQIFfgVIKgQE/Dw4Rg?=
 =?us-ascii?q?j4iAj02GUiCWBUMNARGdRAqBBQXgQ5uGxIeNxEQBRINAwh0HQIRIzwDBQMEM?=
 =?us-ascii?q?woSDQshBVYDQgZJCwMCGgUDAwSBMAUNGgIQLCcDAxJJAhAUAzsDAwYDCjEDM?=
 =?us-ascii?q?FVEDE8DbB8yCTwPDBoCGx4NJyMCLEIDEQUQAhYDJBYENBEJCygDLAY7AhIMB?=
 =?us-ascii?q?gYJXSYHDwkEJQMIBAMrKQMjdBEDBAoDFAcLB1IDGSsdQAIBC209NQYDCxsGP?=
 =?us-ascii?q?gKmRgdTKBNMJoIEsECUQTQHgjSBYIFhDJ8rBhMvlyYOBpJULodQkE8gqEaBY?=
 =?us-ascii?q?z2BWTMaJIM2TwMZD44gOINzj0dANTsCBwsBAQMJhUYBAYMmNIFGAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:krVBbKv9bPsMQO69zvKNRg5n7skDotV00zEX/kB9WHVpmwKj5q
 STdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniFhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD9HZK3BgDVQfexQpeWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:6M0p9m8luHh2k1I9SpSVvw0PO8V7c03+9WzdIGKfKnhTS+CxbmbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AQdPfWw1Dn+VnLAGyzzkq6HLOmDUj3LyBTxxKtLU?=
 =?us-ascii?q?6nsCBGyNKAmex0zCtTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,309,1695679200"; 
   d="scan'208";a="144151897"
X-MGA-submission: =?us-ascii?q?MDHMoV2XOorloz1xObYm/77CUnmbCjR8ymks/b?=
 =?us-ascii?q?JLZ50Opm7v6eOR4NHYKOvcyTWPKB5+1G1X/98UwidO+NV7od3BpRbdtl?=
 =?us-ascii?q?Izwr64z2LOZRFZWxzG00AgtNqCmk82UPtRYfMA3OXzDY6wadolowG+B1?=
 =?us-ascii?q?APfXLG4o1xkD25vajZBJWWqw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 18:16:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703697387; x=1704302187; i=markus.elfring@web.de;
	bh=Ov3WUUWTNVb8pj2W5+dHtNGdRbRpUFyvJpbrqjNl4bo=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=tWfJQwkpYzQP81B7bnS5jI0nTEdOhhAroQ2+21LxQmHXV0tzhK/DT/xEjrgbQkY5
	 H7yYKJi85517fV/EYIjO6/5E1w9AI1FbkJv2QE0klkUDPo4VAxN06fzraISrBFYb5
	 F2r0l+ySP4a72aWn42pTmpCUDbjUNSrrxE2A5UQPLUvbsETBXpKat9NNTgUbB4Hqs
	 37Nz0/BnQPtmcYOSgTPw9rj9R1IsdECdIThFwD0VIMcmRqmjxvW7eskauoNCUob2y
	 CrnLfWxJ5TPowAiSSZ2MPXQc99DirK9wH8vbKC+KWA95s7/hvKhhTKtw0XxmpWqXe
	 OGkPX4xKHT4yQmZDgg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYLig-1rnpk10N4U-00Vobh; Wed, 27
 Dec 2023 18:16:27 +0100
Message-ID: <831d0d61-6d45-4184-81fc-38828f9e5d29@web.de>
Date: Wed, 27 Dec 2023 18:16:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-nvme@lists.infradead.org, kernel-janitors@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 James Smart <james.smart@broadcom.com>, Sagi Grimberg <sagi@grimberg.me>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <6b821c46-7248-4882-aa6b-0279803f4235@web.de>
In-Reply-To: <6b821c46-7248-4882-aa6b-0279803f4235@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yx3du+OOx5YLfc/sgw4RHGZO88uZ4TXt5NhsVF1iHNlgdNQxYUg
 n6S5yHZS8L4deNN2JL5azTRMtGRQK98/lFwDLYmNKz8ekNH4Bsv+RWudE+cp7vvBnChZ3CD
 Zmf/uLVPzMf7DFedQxCpM1epbL7yfemhWt25pIKevtgBL8YfsYAUfESpALWGS+ETqJZKfkt
 agYPPePhlfX/O1l9xagYg==
UI-OutboundReport: notjunk:1;M01:P0:gHNqSJy4XnE=;ypyqEJVSwQ+0OZ2Q2o0ASwJchcx
 6wajWPplosHaaRquh7mV0AT6F9lUteP0042PxkHW6fRLUWfRincqHGRzbPyBnEqP2SmPCAsU3
 V4vD8MgQcPnWjgl/7j1eiIZSozrW0P6d4abn1Ngmanftt/0On+MzSJVZugPRLjPNKcg+6AXRQ
 tTLQzKYSpywc6dpZ8k6hZj9SVrJhUfqsBzBKscB+H3VF5hq1RjZ1AaIhNiIkokVjI6JPXRhF3
 ziBEOyyKq6AmpxeQGmpDbrUcoHCJEU3UklkcblKW5EFSI7++e8gNKkiqXeZNpG/r4whvpeN65
 9ePXhiiErOWtDOMkHcmliB6l9GvT53AbY3KW2NVWfBMCZrvmmgU7/w74vwAXF02iqm3zs+jK0
 X809OArp+dRTGFZvBjxgdC+hsjm15KsmY5i+ChDSdGk7b838dh1edu0sW6Q0sQoC6W3E3f8h8
 hOndXmOHbx2CcqD854qIP8/9guiHFve9W2aWDn/Ng50v3eVqhtQBCRuKJoq0o6fc0mL00Nyyr
 n+wynAWbLd+HSFMdHAvzGoB6B77VQTm2AfbasBsQG9Q1W1+wkwCYTOPBvp7gwfH1ngldtLow7
 hwpLcF54iHlrmYeihnzaX70eMNajIS8WCVXsvJWpi5caZ9ehFv5zgUkYTjtts+4l3wI0oMw2/
 Zvp9Q1JgnglZVeqE3OEN2k/gtJ/zfQdyC0bdeTG0gWFy3L0BB2Eb90XS+ZT72DbQOsRH9p473
 70airwvBeVCFBp22Q1qDF0M4LzSnfiAh3chSjWklw4KdRsQD1KYp5GSOrRQJA9ZbzKe5NXk/x
 rILbN0KeEmDI438SGPc6zX9+6J0+3LsOFixWGBI+joeU2EX3p/SAhgo01JMpI9jaBgiXuXn+q
 KDgr6Nars/LjBIeyp+KD59KWx8R3wmc15elb/ILri0uoU7scJll0lvcDtetLH0ttcxffufk+U
 PUafcA==
Subject: [cocci] [PATCH 1/2] nvmet-fc: One function call less in
 nvmet_fc_alloc_ls_iodlist() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1420
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/831d0d61-6d45-4184-81fc-38828f9e5d29%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Dec 2023 17:52:46 +0100

The kfree() function was called in one case by
the nvmet_fc_alloc_ls_iodlist() function during error handling
even if the passed data structure member contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus use another label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/nvme/target/fc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index bd59990b5250..856a68404f32 100644
=2D-- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -553,7 +553,7 @@ nvmet_fc_alloc_ls_iodlist(struct nvmet_fc_tgtport *tgt=
port)
 				       sizeof(union nvmefc_ls_responses),
 				       GFP_KERNEL);
 		if (!iod->rqstbuf)
-			goto out_fail;
+			goto out_delete_entry;

 		iod->rspbuf =3D (union nvmefc_ls_responses *)&iod->rqstbuf[1];

@@ -568,6 +568,7 @@ nvmet_fc_alloc_ls_iodlist(struct nvmet_fc_tgtport *tgt=
port)

 out_fail:
 	kfree(iod->rqstbuf);
+out_delete_entry:
 	list_del(&iod->ls_rcv_list);
 	for (iod--, i--; i >=3D 0; iod--, i--) {
 		fc_dma_unmap_single(tgtport->dev, iod->rspdma,
=2D-
2.43.0

