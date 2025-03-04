Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E6FC021B8
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 20:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=CLyLqQ9mG2OYA4h8XYSBVwHU4gZu0CSL953Y+TKJ5ew=;
  b=dG8NLFlVGvF+joNuNbr2UKxjwqyIXNjzy/w+BHXDRwwbFfF0On+3O/pr
   Ycme8SadlnjjmFMmygeW9As1fIZykU1aX5s6+98aBuUUjItyOfE/0KaOt
   uP6O4g/hFRLgOkz0SHI9LG/yXVE39DbMF4PtzQij2RJmMGVsHujn5E/Gr
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
   d="scan'208";a="211202113"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 21:06:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BA9D5E0D1F; Tue,  4 Mar 2025 21:06:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CDD5EE0260
	for <cocci@sympa.inria.fr>; Tue,  4 Mar 2025 21:06:03 +0100 (CET)
IronPort-SDR: 67c75d2b_k41scgZ2v1NmbVQqTC8MMF3ONx41EHx98VDuLbvmPtt5Nwj
 qr5KkTT2A5zPLHwsK9zalTNk/jIcI5t4sDadUvg==
X-IPAS-Result: =?us-ascii?q?A0H6AAAVXMdngQsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBAtIhFaIHYcygXQwhDuHO4xChAaBVoF+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBDiBVIJ0AosWAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBOwcOCQExhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QCAQMjB?=
 =?us-ascii?q?BkBAREmAQ8fAQUCJgICVgYBEgIBAYJ+gjABAzEHsAN/M4EBggwBAQaCaddzH?=
 =?us-ascii?q?ywiV4FlCYEaLgGFa4JjAYYmhDwnD4FVRIEVJ4NBiB6CaYIzgWqDPahZgU0cA?=
 =?us-ascii?q?1ksAVUTFwsHBYE5OAMqNDGBRnqCRWlJOgINAjWCHiRYgitqBAWDW4Q9hEKCP?=
 =?us-ascii?q?1GCQoIRcYEagjGFToEthHIdQAIBC209NwYDCxsGPaFzOoRCAVI7TCaCBMYSN?=
 =?us-ascii?q?AeCOIFmgWMMn14GEy+XRQ4GknwBLodlkGoiqQ+BZzqBXDMaJIM2TwMZD44hO?=
 =?us-ascii?q?IN1yEBCNTwCBwEKAQEDCYVGAQGKVIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 YT5qa2ojq12pY4d3PuMo0JoJSw=
IronPort-HdrOrdr: A9a23:U6iquKEsxshNLNXppLqEPMeALOsnbusQ8zAXPo5KOHlom7+j5q
 eTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/hzAV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAsxD4bbLbWSS4/yKgjWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3AQq8o4WpnGUluqvNHOrTULoDmUYMVVFmF8nuBHxH?=
 =?us-ascii?q?mGXhJF6WFbhia9Lwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AowvC9w7LU4BVerRv22hKJHPjxoxHzaOSCEQ3oK8?=
 =?us-ascii?q?9oviBaA9+ZB2QjCWoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,220,1736809200"; 
   d="scan'208";a="211202111"
X-MGA-submission: =?us-ascii?q?MDHi4+eXGctNTK65Jt/kdYRHwpUtgNCGFtsmIE?=
 =?us-ascii?q?HVLzIvgp+iWuSUWXZFrvbanRvggonRqh4dyreswux43cM45m7nBJL7l1?=
 =?us-ascii?q?YWzBIZFmOFUAmUUQi+w7hsNdHme7qCFne60hd1d/9cVwQwoEMnEOkgK/?=
 =?us-ascii?q?MDIO84DfVTiAfPCxBZ5cjAqA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 21:06:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741118762; x=1741723562; i=markus.elfring@web.de;
	bh=CLyLqQ9mG2OYA4h8XYSBVwHU4gZu0CSL953Y+TKJ5ew=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LGo3cuhAXykSeTsKONdUxTw39/NeJ+Qnf4CVYXkQRa1IhniSsZ7HZmEfUaQAj1GF
	 PHmPOBx23eFJqhVW3qg60CjUZxscRK6eUkCcsjAWk2++WZJ6mJt02tj5s0LnjNL3u
	 c3mvvkSzonq4DVidZZSi+yrd5Fdw9xqyctk+/xERDfzB/47pk8oTFt1HGZf+xMOL0
	 xC2p8x5aYURgGVWDdHgC807kMft1Duzbu/ewK/p8RIoOu6gaR/AIeVwKOpE+ji90u
	 FACNBn6oTR3lkdH0S671AKPDvjVooShoAdqmnenla2xMH162FqlG+WLwE5Pxiktoi
	 dGtw0OCpZCZXlOKkRw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.64]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPKB5-1td59T1Lw5-00WJ26; Tue, 04
 Mar 2025 21:06:02 +0100
Message-ID: <15374d0b-ac50-4eae-8d94-c870a7c918e6@web.de>
Date: Tue, 4 Mar 2025 21:06:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <15fa53e5-916f-dac8-87fb-9cb81021418c@web.de>
Content-Language: en-GB
In-Reply-To: <15fa53e5-916f-dac8-87fb-9cb81021418c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DXfXVMh3BB0Y7aScUQseE1/ISmriUWWViY8FQyEhmx0RY1npwoy
 MwYFgnmqefCE3QPIq2MKXZZb5k6v9mbvYIwgem1BzFzoOf/0rd/6D59ILDFulKOnu8D8XiO
 6N41aBtg4CykvjvwMcihwaTxo/0IVBgd1Samxc2pU1XpyWoOmerpTtRUOVOID4F25lo17C1
 tXQiLf2HK9UblWPjTqyBA==
UI-OutboundReport: notjunk:1;M01:P0:FTmyyT3rHvE=;fzyggJSmQzfEyN9pXi/rgdPINLF
 yaVsOEUccpvxrIG/+NeGb4m2FuNh3PHB0Ai9dAW5b0v/Keefjwfx+g4XhllV2eMNQLNiq7ia+
 WHnKHAvRM+OJDRAn1YL9bxvEDM8A412Q144ORpL6A07pCxprVHmL9EXsTRxJDrXvZN361JQkD
 zya0GGSSxTF7TJvKs2hafavg34TdxwEyou5eDDSs5gIRysSW23VQxORezCT8mDa9ixhmdUGM6
 o6iimqjovHU/xZiG5nmoWwRRSNtfTK3db8crULMfnNUrJSUr4aIFpI9vC1MTYp9A2xjq+5yS9
 zPtdffJU0+0CXSFEnZ26en6R009NSjrPHI6cw6KgAkZjq8DAKXRTqQmlwoMdAsoo1Qrgh4wXt
 myXsZzPwxUNBkBL0/cb0FQtZyI0qKt4QWvY50TNGJYh7G8rf6jmXTvg35MxPesGqTenK3+rLc
 kfmIhimaFeQJW+lBF5G0SLMGk7GKe1TYCHZOXqMxuChyjGv8Sq9WDimCew0p1yMSA1KNO4Slr
 IuH4ougC/8bGLW55C1ybSlXLKWEDo5gMykYq5p+QVjj1s08RYP9LdGa89eX/HOl5da41bOh13
 bhunuCANprpP78QL2EZq48euLJOgjlYiyv+/T8baN1Qf+tWBVz1udNJEJCCB0FW4YhaDz+GTt
 yr+MZ/3MTysQDJMmbhRUMBMgewK7+0h8N2gllC5HFSFaE9La4xv0OcpXBPZ42KvIrlMqsyKgm
 +3pODzwLVanl1wu53HaIKL3gRXi1F6kDO4M+mMviLy1kNoKTFfAYQBqVnKYCt1FwiCJPaq7yz
 /M/bCx+/yJqe18eeiBRigIDh7W+Vy3B+CPrcegkexGIoIAHQ8V0Wmbm57LvnVfKLvPrwSzVT6
 HPwu7Ckspc9U6ivLdv1bUBvWAqg3zFzbSeiNuLsR+37JgAcHxMA01xEtj1MIzago5lFnlm0pR
 Ulk0RUhjyGxJGR7+0P2qkzgPFCH6XepN1m1uVchW7QqJvpfwobTCeS8TNJa+CZiftiAFqUX1Q
 MblwmcXT6lggbYq/MF1bvuwViPaVtcHXZ6SNjbZ5j5HDRKJMHDeVkiSvJBe3R3qOUICRSeQpJ
 Q/XVnKDgblgMPL+9vy/RKD+aFkAnw4aqMojl0BFXEk4RQ1Dy86m5RQnZHSJKCJESWItghnjPe
 kSwrk8oDnA5NzJEcu+Kg4UK2PtVAsh9v28gtCS7ZLZBkQSVRozRzB0Fafv2n8FU2shwwOeG++
 MErNDWaI9ouifYey0RqpuGch+6P4X+gH3SdOdDf7u+S2PHNjgVKAPZEk21EvwhzEw/WVVe8oh
 c7MzYdzsxj857jXwCFKJgLApHivVVy937qXKTCQxxUAEjOLfSTi6+UuDDNcOn/X6EnMgr5bAG
 vd4xWuJEIEg7KcAN07OG7YYhs51t+Uy7u8m4pU1cEuh5WUqHcaY/7aKCraRB7wlJCzDh1m8vN
 XtVPykMbytJM7CXL0FxvOl6iQqQ4=
Subject: [cocci] [PATCH RESEND] irqchip/partitions: Fix exception handling
 in partition_create_desc()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2537
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/15374d0b-ac50-4eae-8d94-c870a7c918e6%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 19 Mar 2023 21:38:47 +0100

The label =E2=80=9Cout=E2=80=9D was used to jump to another pointer check =
despite of
the detail in the implementation of the function =E2=80=9Cpartition_create=
_desc=E2=80=9D
that it was determined already that a corresponding variable contained
still a null pointer.

* Thus use more appropriate labels instead.

* Delete a redundant check.


This issue was detected by using the Coccinelle software.

Fixes: 9e2c986cb460 ("irqchip: Add per-cpu interrupt partitioning library"=
)
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/irqchip/irq-partition-percpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-partition-percpu.c b/drivers/irqchip/irq-=
partition-percpu.c
index 8e76d2913e6b..80e1c73af87e 100644
=2D-- a/drivers/irqchip/irq-partition-percpu.c
+++ b/drivers/irqchip/irq-partition-percpu.c
@@ -212,21 +212,21 @@ struct partition_desc *partition_create_desc(struct =
fwnode_handle *fwnode,

 	d =3D irq_domain_create_linear(fwnode, nr_parts, &desc->ops, desc);
 	if (!d)
-		goto out;
+		goto free_desc;
 	desc->domain =3D d;

 	desc->bitmap =3D bitmap_zalloc(nr_parts, GFP_KERNEL);
 	if (WARN_ON(!desc->bitmap))
-		goto out;
+		goto remove_domain;

 	desc->chained_desc =3D irq_to_desc(chained_irq);
 	desc->nr_parts =3D nr_parts;
 	desc->parts =3D parts;

 	return desc;
-out:
-	if (d)
-		irq_domain_remove(d);
+remove_domain:
+	irq_domain_remove(d);
+free_desc:
 	kfree(desc);

 	return NULL;
=2D-
2.40.0

