Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AB4C6FD1F
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 14:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ftZSTjuZeooSte7FW2K6sZ2YKeYe4dU/hnZ6yIYLqEA=;
  b=s6pVv78f8b3EGWgggLdXxpFiCguN+7dafLPSkQbIFuBT1A3/uCoTGZEx
   w0nB7BUeX8HB6Faa0PqYGPfP4xI9liyiRtjMdeamYcOlCrFnaMppP6hSl
   5kT6x8OkWPddxobJPPriBbriGij5AfRyDIx3UT0Y1FAVSd4loYUclL69k
   U=;
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
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99065747"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 15:05:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5BA13E0D46; Sat, 25 Mar 2023 15:05:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 69760E0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 15:05:24 +0100 (CET)
IronPort-SDR: 641eff9d_YgJ7cv5qlCIH+Gikk3PyCvr3SVOra6sVrQZlewLoRlzrKS5
 jfVBKRu/tY2hqnSKm03i4XwCRTywoFnpynbGlTg==
X-IPAS-Result: =?us-ascii?q?A0ErAADv/h5khwQP49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YItgUsvBAtGhFOIH4hiLgOEL4csjCGEAoFWgUA+DwEDAQ1BAQIEAQEDBDiBU?=
 =?us-ascii?q?4JzAoU6Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBA?=
 =?us-ascii?q?hABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAkdTPQMDIwQZAQERJgEPHwYCJgICVwYBDAYCAQGCeoIoAQMxB7E0fzOBA?=
 =?us-ascii?q?YIIAQEGgmOZJx8sIlOBXgmBFC0BjQSDNnonD4FVRIE8gRWCLIgcgmeCKI57i?=
 =?us-ascii?q?C8KgTR1gSAOgT2BBAIJAhFrgRIIa4F9QAINZAsOb4FKAmRMgR4lBA4DGSsdQ?=
 =?us-ascii?q?AIBCzs6PzUGAwsgBlhrAgkjERMFAwsVKkcECDkGHDQRAggPEg8sRA5CNzQTB?=
 =?us-ascii?q?lwBKQsOEQNQgUcEgQqBAQYBJiSacQIBgXRzAVI7TCaBdw2SWAoHki+eDjQHg?=
 =?us-ascii?q?iiBVYFZDJ8MBhMulwgOBpIjLpc8IKd6gWM6gVwzGiSDNk8DGQ+OIAwNCYQDj?=
 =?us-ascii?q?wkBPUA0OwIHAQoBAQMJhUYBAYV7AQE?=
IronPort-PHdr: A9a23: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
 aSBHCjJTfRdguk4HV0=
IronPort-Data: A9a23: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
 D3GxkDNAw==
IronPort-HdrOrdr: A9a23:rzJfuaBFUCziRkblHel455DYdb4zR+YMi2TDGXoBLSC9Afbo9P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkOss1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFJSWY+eRMbEVt7ee3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99065738"
X-MGA-submission: =?us-ascii?q?MDHitPIVOovJWjM1QN8MRuazqjmWIEHVRdBqt6?=
 =?us-ascii?q?0CfNTP9LICXJ4D5XsqVMnGKRIMnXJ+d8m28P1FnHQLqEi90IYydqKVEP?=
 =?us-ascii?q?WH7Uzi5z40/HGnfajhdz78xXvQS2ZeAkS6x+V6pEG4Y/T8DNuCBUeitR?=
 =?us-ascii?q?8udjiwJeEzuYwWdKVB5zMBpg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 15:05:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679753111; i=markus.elfring@web.de;
	bh=7sqfY1AC0lxmDISvcZR/B1nVQ2OCqHB3UuwFODLG3o8=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=D9crxBSSLpW4R479Lkr6agkDrGVp600WFn3S+UFtTeh/OmsHh+FyQSHm/IXIHSv4N
	 xLVYcu0jMee9Pt31Z+H7SNr3zoEw/IcbvU5U2BLO97CVAsd7Z+tWDV5TCmpnY6uEDK
	 E9FFMM6J7MjJ5p+3y8h5uZP+O7pb+ehmai3llXr+lwLCIuymjEKpSnC4JecPlg0fsK
	 JFURL52RlkQHVdwr9INwMQvdqDEIZ7uYCisb9J08c1qK6KYvcmA2dXbIC6V4oJgiXx
	 u3fdCyCbkAav0xjRYbSmLqPQz2BbjvcWsdhw3B44RAdQl3rG1awisOu+gYZcsXyorL
	 iTj8W20+Zizrw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mrwrx-1qIeKQ1WDN-00nyAl; Sat, 25
 Mar 2023 15:05:11 +0100
Message-ID: <9e3705dc-7a70-c584-916e-ae582c7667b6@web.de>
Date: Sat, 25 Mar 2023 15:05:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Stephen Boyd <sboyd@kernel.org>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <5ed1bc78-77a1-8eb8-43f9-6005d7de49c8@web.de>
In-Reply-To: <5ed1bc78-77a1-8eb8-43f9-6005d7de49c8@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hlQ92EaiJHlztMXECQzhYQuLvPvUT72QgaUpxu0Yo0QtefrrZ4S
 7sBEBaKGb/GtREncIARiyW9xlKunc+oG+ytgc7JRNFvaTtfnmgfG+XY9Y0OiuQn8j8FaK+N
 OfsZ8CWUdp1SBp6s09VjWyM7k+0zjc2nNNPS8DusTWdMoHX6HO+PCXhm4LudcXUMgUnacrn
 xK2UZXCfRIzmr9KziwHqQ==
UI-OutboundReport: notjunk:1;M01:P0:0p2joeq4bjs=;KskENKywRzsfH8cZV9VPn03EtPU
 Zd/nyWdQXq4JB+BtZPGL9Dj2JZMvKWb2dK81DqjGdXhXXDgBqNIiYQI5frghmUbG9rxvXGWlp
 aM2GYFrrvYrlImjKuEZnEeIZWeiVWYbuYvkG43bojDNt00SCuzXK2HRSZicv4fIZeE8G8yBFS
 jT+MzEW4nR5th4jne7AC8ktr/eYZIqGb6HlqZTp/BFgBBN8HoigXGl9jPQPtJX9XUqA3WLDYm
 w+iB/u6rUSzwJUfFLIiesY4/y/6l1lF9gLsdBQalznkLib2HhSSv5apTk1t48pJGrAwIS0k9C
 viy4z+7FY/xnhbZtBTjyT8b0dt6WQYseAKaskrHNJQehfKmUvySy8DGdIDyNFhjKu1HVYUNf3
 D7KF4PzpsRt38H0kqrdafFHkO7G8svcx5YodbIS1yIfYR/z0OLvV4kSPKeZY+/VjHdVBrGGmX
 o57U3oXWgqcUjBr6zpq4q1oQCzoQrK/XQrWPsX3hsVc9VGjbFJ96Jl0VDNKnBPyVVcTx+S6sG
 VNuwScItfSaN3Q7Rmw67kNMklVQAx/pVQeSbHciJgJY7pCITq93uKCoNfVnXO3mmz9FWSQMo8
 /I118e1H5B480s/kYAO3/AK7rf6NhUBHv1rq6oQBg71wnsylKFMrlg4cn73mfMAAExlaDLzZk
 8bjqgeWRK9rFUcbZ3hfbSiGqCxB8L8l3d+D/H/Kv6FirSf8jIRkikQVBwrRAkeOw8d8VSpNVn
 nqKtPwDhW1a6cQISHj8LIkghTle7nV7AvZMPT/OXKpkCOgHCw6NRJrFcyz/naAb9VLEZ6vQrM
 QGfpo0NDFkW0/7rFo1nxVD6H3/5LZ/ZuSPkg7qwxrowX0vuRnKkbscEPrOmCKBJy0tQUij/Vl
 pADbOXRUuV0JBnOjSqkd54ntRW/sqWdF3PMECg9RXZhwZ6D5K5AzXcyGj
Subject: [cocci] [PATCH resent] clk: at91: sama7g5: Add two jump labels in
 sama7g5_pmc_setup()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 948
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/9e3705dc-7a70-c584-916e-ae582c7667b6%40web.de>

Date: Fri, 17 Mar 2023 20:02:34 +0100

The label =E2=80=9Cerr_free=E2=80=9D was used to jump to another pointer c=
heck despite of
the detail in the implementation of the function =E2=80=9Csama7g5_pmc_setu=
p=E2=80=9D
that it was determined already that the corresponding variable contained
a null pointer (because of a failed memory allocation).

* Thus use additional labels.

* Delete an extra pointer check at the end which became unnecessary
  with this refactoring.

This issue was detected by using the Coccinelle software.

Fixes: cb783bbbcf54c36256006895c215e86c5e7266d8 ("clk: at91: sama7g5: add =
clock support for sama7g5")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/at91/sama7g5.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index f135b662f1ff..224b1f2ebef2 100644
=2D-- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -927,25 +927,25 @@ static void __init sama7g5_pmc_setup(struct device_n=
ode *np)
 			    (ARRAY_SIZE(sama7g5_mckx) + ARRAY_SIZE(sama7g5_gck)),
 			    GFP_KERNEL);
 	if (!alloc_mem)
-		goto err_free;
+		goto free_pmc;

 	hw =3D at91_clk_register_main_rc_osc(regmap, "main_rc_osc", 12000000,
 					   50000000);
 	if (IS_ERR(hw))
-		goto err_free;
+		goto free_alloc_mem;

 	bypass =3D of_property_read_bool(np, "atmel,osc-bypass");

 	hw =3D at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name,
 					bypass);
 	if (IS_ERR(hw))
-		goto err_free;
+		goto free_alloc_mem;

 	parent_names[0] =3D "main_rc_osc";
 	parent_names[1] =3D "main_osc";
 	hw =3D at91_clk_register_sam9x5_main(regmap, "mainck", parent_names, 2);
 	if (IS_ERR(hw))
-		goto err_free;
+		goto free_alloc_mem;

 	sama7g5_pmc->chws[PMC_MAIN] =3D hw;

@@ -987,7 +987,7 @@ static void __init sama7g5_pmc_setup(struct device_nod=
e *np)
 			}

 			if (IS_ERR(hw))
-				goto err_free;
+				goto free_alloc_mem;

 			if (sama7g5_plls[i][j].eid)
 				sama7g5_pmc->chws[sama7g5_plls[i][j].eid] =3D hw;
@@ -999,7 +999,7 @@ static void __init sama7g5_pmc_setup(struct device_nod=
e *np)
 					  &mck0_layout, &mck0_characteristics,
 					  &pmc_mck0_lock, CLK_GET_RATE_NOCACHE, 5);
 	if (IS_ERR(hw))
-		goto err_free;
+		goto free_alloc_mem;

 	sama7g5_pmc->chws[PMC_MCK] =3D hw;

@@ -1128,12 +1128,11 @@ static void __init sama7g5_pmc_setup(struct device=
_node *np)
 	return;

 err_free:
-	if (alloc_mem) {
-		for (i =3D 0; i < alloc_mem_size; i++)
-			kfree(alloc_mem[i]);
-		kfree(alloc_mem);
-	}
-
+	for (i =3D 0; i < alloc_mem_size; i++)
+		kfree(alloc_mem[i]);
+free_alloc_mem:
+	kfree(alloc_mem);
+free_pmc:
 	kfree(sama7g5_pmc);
 }

=2D-
2.40.0

