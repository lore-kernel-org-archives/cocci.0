Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F608C46CD2
	for <cocci@archiver.kernel.org>; Sun, 24 Dec 2023 16:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=culm2Qoxata7udHDA4Bf+b5GU0IAzyD48H6j/6DuOb0=;
  b=Shi+DnQYt7zcoDK2avQV6O04MXAlCaAJ/5Eor5QOlouKGNdAluOK4CUw
   TbG27do/X32Q8M57ch/YOJstUZnxT1NIHNH3KsODozEqIGM05EyNoCKvk
   BpghcWg1v1RUbnqofcqE/dfm4algCCW2k4frn3uOXgNox6nhvm2snkrjD
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
   d="scan'208";a="143934735"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Dec 2023 17:42:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A378DE0CCA; Sun, 24 Dec 2023 17:42:27 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2B24BE004E
	for <cocci@sympa.inria.fr>; Sun, 24 Dec 2023 17:42:26 +0100 (CET)
IronPort-SDR: 65885f71_bPD8l6NphmuOBgZ3LXgj+z6ztcn6w/RgZXpejedrfXNthCU
 Vse7JhJJ9pOXCasPTKarVP+rNVxdrIYURp7lKPA==
X-IPAS-Result: =?us-ascii?q?A0E3AQCXXohlew4P49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBT4I5f1MyBAtIhFORNjCEO4c1kDuDFj4PAQMBDUEBAgQBAQMEOIRHA?=
 =?us-ascii?q?oc2Ah4HAQQ0EwECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEkG?=
 =?us-ascii?q?AYOBQsnhWwNglwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAkdCAwMjBBkBA?=
 =?us-ascii?q?REmAQ8fAQUCJgICVgYBEgIBAYJ8gisBAzEHrzB/M4EBggoBAQaCZqxyHywiV?=
 =?us-ascii?q?oFgCYEaLogbAYVng0F6Jw+BVUSBPHCCUYgegmiJHQcyghyDUJFafQVBcBsDB?=
 =?us-ascii?q?wN/DysHBDAiBgkULSMGUAQoIQkTEkCBXYFSCn4/Dw4Rgj4iAj02GUiCWBUMN?=
 =?us-ascii?q?ARGdRAqBBQXgQ5uGxIeNxEQBRINAwh0HQIyPAMFAwQzCh0LIQVWA0UGSQsDA?=
 =?us-ascii?q?hoFAwMEgTAFDRoCECwnAwMSSQIQFAM7AwMGAwoxAzBVRAxPA2kfGBoJPA8MG?=
 =?us-ascii?q?gIbHg0nIwIsQgMRBRACFgMkFgQ0EQkLKAMsBjgCEgwGBgldJgcPCQQlAwgEA?=
 =?us-ascii?q?yspAyN0EQMECgMUBwsHXAMZKx1AAgELbT01BgMLGwY+AqZKexMUgmKTA48+o?=
 =?us-ascii?q?kA0B4I0gWCBYQyfKwYTL5cmDgaSVC6HUJBPIKhGgXojgVwzGiSDNk8DGQ+OI?=
 =?us-ascii?q?AwWFoNzjwkBPUA1OwIHCwEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
 TE=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:IF12sa41u4lnbyV8HwPXwBzXdLJyesId70hD6qm+c20wTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhX4tKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkYNDSaNzhHZKjBkWyFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:JSfFOmEr434o3vEGqmJF7GcrBOsHI0eN61TqB2ixDUBobJCKHAo=
X-Talos-MUID: 9a23:ujhhngi14COfacqeIle3fMMpP+5R/Y+pLh8xlr4B4ZmNBXwqOQa3k2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,301,1695679200"; 
   d="scan'208";a="75293254"
X-MGA-submission: =?us-ascii?q?MDG7loZCSNoTAWFrGUVQ7fu+fEd/6poR9sKF6G?=
 =?us-ascii?q?LfpEm+VMfgGrmZOpyjX0sOt3/h48vZ6mVlFnoR3CJ9a0eXxqgJGypSh4?=
 =?us-ascii?q?v09bQJosvATYFV94qHk42hssU0BgTU35KX4dl3WbdZ9nC+Ed/PJdgzXg?=
 =?us-ascii?q?R4Q8KSZrGAaDabAkOlwysRqQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 17:42:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703436140; x=1704040940; i=markus.elfring@web.de;
	bh=xPOZJwyuU2nZ40HhhBkd6/p4ub+Ys2PvUwGIEA88uOk=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=kI+9RdT9y3YBcqQmU8AnmSqWOLc9pef+PlVwff+u9XrHAUp3YD4nU8cs2H4/wbD2
	 /+iH/U+SXwbAu0HfYudpVRZQFq2MufFD8vuFZ7lv2epRmyZGt+VCl38v37dwkYnI9
	 gqdQfk/pEdykw9n1UhWV/NZAYBxRgLXJaj0OgpSn4Gfl4taJxLdPA1Swlmf+2CtYM
	 08J62D7gJ1vfdLD0969kVMa3+ShInJn4+spZuGBB2qJ0AKzNuXuOjlFs1FoALrCJz
	 no8P7v/S/dSXEqAZcR65q9nOIJzSHwc/YraTlWreDwL6jUrEVJF9WNE1h2X7vj1cZ
	 HytpbcgdY4qaXz+xfQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3V6E-1rHzWI0ix8-000z2J; Sun, 24
 Dec 2023 17:42:20 +0100
Message-ID: <ee5499f6-e06f-4b6a-9483-b73646660117@web.de>
Date: Sun, 24 Dec 2023 17:42:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Tero Kristo <kristo@kernel.org>,
 Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <20849a8e-e0f5-46df-ad8a-9eae6cbe337b@web.de>
In-Reply-To: <20849a8e-e0f5-46df-ad8a-9eae6cbe337b@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZZEXd63kDl+1X6VLV9csl6o6Tolw8zBW2zGW03MPQm51PBoxFmB
 OfVJrS3T2lRZ+Lpev6rZc7KJj2SZ1I1X4uc208XygpBiixeMxL1gAmfw53gY5AGgV3X6u6U
 RNxWEGNw2HslqJqOWwC/RimZForGOuPXfYCVgjsioAOo8zx/EI7wCon85BC4ldckoIVZYsV
 ouKmDtS8wq8lcXtClFGfg==
UI-OutboundReport: notjunk:1;M01:P0:Qc5Akm03OAM=;VwVf1e59LJU+8iW5h/2yXzamYCH
 +R1xK+oIQ4s5cfz2JO2Pbh1F7norfdph3z3VVExYc+WG6cMRBOuxz6U9AgmPrjy/QzXnDStJ5
 Aed7BO1YqnO92NNEbvOr5eUOnx2ejvT7GCzSKKOAIfFH3jGLRlv9Gwq3acYrvvM0R+ojS7QFJ
 YT6dHTENOF7UYhKSWEntlmCr+Nw9FYgPmyGvirTRkxwdodsaJ1/yTZI19hUlj6sNSKjchyuE2
 KouYS5Ahz4RXFW1Iox1NI0NTU0MUWcReio/fcMd8944tCwZLXWrvXcmVSD3zmABFMDqCCS4LG
 mS46E0er/+akh5PdbwrIdmj11ErJHrI2jJOnD45lf4mFFwvTAeshOs8Y0Tuh8k5dnmURi2R8M
 6H3Qt+pHR87c8Z2MDf13y3SC8anYmWgEZmFOcWtqn8MciFhTPLlp+U7oFcZVp0a3d5gH2Ybud
 LJMKrhLrZeifbcwFkz9pBCUxqxrRE8BbfBG6QI0RzMufKdkHMXiAFaK1oK5pXkftK8PxtSBzi
 DvoZ00ph9P/cH9ZB7ipBT6+ASEjBXPL8AxmPiL/W9TEfhrhNALwchEXYUfJP0AUzffsv75Ui9
 OgPiivc824rL2oi96oI3dAzJW/sujs2Hiz2/Fq/E8e2GS8g/6+CEtzt/sXLOuCScGXuppvQEV
 pu4LcaHi1+hYNJsYY47/jgYcwiYh/Lyub5sfAGd39d8cBij+UkjJh6awy3K1yOP7++B4HLG/a
 Jop+KPnIQCBrBunnK6RzyTHAgHPN71PSQN5UfE6xboUd38pGF37AUHc9yBxSONZ7oA8QJ3pFH
 ONJ6eMVtIQqe55Wc1xq6HR0NvmBilq8slcnUjYakRuP/kX6KbOSFGv4xd7OgAFwjhHvL2/m18
 JqXmZIarHlwmhMxWNaC8lhCQTgog1RxoptubxDFTAw/3zYMDT4VNFSA3Uje06J6XhzrW77Zkw
 VM57DdlWmLQsKsOqABrFmWa7ts8=
Subject: [cocci] [PATCH 04/10] clk: ti: Less function calls in
 ti_fapll_setup() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1372
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/ee5499f6-e06f-4b6a-9483-b73646660117%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 24 Dec 2023 13:55:44 +0100

The kfree() function was called in some cases by
the ti_fapll_setup() function during error handling
even if the passed variable contained a null pointer.

* Adjust jump targets.

* Delete two condition checks which became unnecessary
  with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/ti/fapll.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
index 2db3fc4a443e..e9956e3ccd65 100644
=2D-- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -546,11 +546,11 @@ static void __init ti_fapll_setup(struct device_node=
 *node)
 				   MAX_FAPLL_OUTPUTS + 1,
 				   GFP_KERNEL);
 	if (!fd->outputs.clks)
-		goto free;
+		goto free_fd;

 	init =3D kzalloc(sizeof(*init), GFP_KERNEL);
 	if (!init)
-		goto free;
+		goto free_clks;

 	init->ops =3D &ti_fapll_ops;
 	name =3D ti_dt_clk_name(node);
@@ -559,7 +559,7 @@ static void __init ti_fapll_setup(struct device_node *=
node)
 	init->num_parents =3D of_clk_get_parent_count(node);
 	if (init->num_parents !=3D 2) {
 		pr_err("%pOFn must have two parents\n", node);
-		goto free;
+		goto free_init;
 	}

 	of_clk_parent_fill(node, parent_name, 2);
@@ -568,19 +568,19 @@ static void __init ti_fapll_setup(struct device_node=
 *node)
 	fd->clk_ref =3D of_clk_get(node, 0);
 	if (IS_ERR(fd->clk_ref)) {
 		pr_err("%pOFn could not get clk_ref\n", node);
-		goto free;
+		goto free_init;
 	}

 	fd->clk_bypass =3D of_clk_get(node, 1);
 	if (IS_ERR(fd->clk_bypass)) {
 		pr_err("%pOFn could not get clk_bypass\n", node);
-		goto free;
+		goto put_clk_ref;
 	}

 	fd->base =3D of_iomap(node, 0);
 	if (!fd->base) {
 		pr_err("%pOFn could not get IO base\n", node);
-		goto free;
+		goto put_clk_bypass;
 	}

 	if (fapll_is_ddr_pll(fd->base))
@@ -653,14 +653,16 @@ static void __init ti_fapll_setup(struct device_node=
 *node)

 unmap:
 	iounmap(fd->base);
-free:
-	if (fd->clk_bypass)
-		clk_put(fd->clk_bypass);
-	if (fd->clk_ref)
-		clk_put(fd->clk_ref);
+put_clk_bypass:
+	clk_put(fd->clk_bypass);
+put_clk_ref:
+	clk_put(fd->clk_ref);
+free_init:
+	kfree(init);
+free_clks:
 	kfree(fd->outputs.clks);
+free_fd:
 	kfree(fd);
-	kfree(init);
 }

 CLK_OF_DECLARE(ti_fapll_clock, "ti,dm816-fapll-clock", ti_fapll_setup);
=2D-
2.43.0

