Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1419AC46CD3
	for <cocci@archiver.kernel.org>; Sun, 24 Dec 2023 16:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lf6niPI1qx+/6bQFEp2dcy0x/1Y0IDhQjgwtFdsHBWM=;
  b=JXgL55igD2NIlf6U9d3zEhdrY9/Q7jSQQEC1Kr/eIGshG3evXlBDvuNq
   C0kS8DLAVG7U6MU6lXtLGrUOPuXqGCMdY+siFNY1mvJ+iOwE2r+BTXR5g
   ewTXOp6b2Y4azx8fNIFmcMB9wki5c46qhoucrNZl8h+bHZkfoUIqF3/5q
   A=;
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
   d="scan'208";a="143934585"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Dec 2023 17:38:52 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 653A9E0CCE; Sun, 24 Dec 2023 17:38:52 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0302BE004E
	for <cocci@sympa.inria.fr>; Sun, 24 Dec 2023 17:38:46 +0100 (CET)
IronPort-SDR: 65885e96_ED+5ZZUqx7JgsckIrWXxr57P6w36XTadCGuzigxkbpfyVem
 2LY0wPu05sa93+EEwubUxcELMhsLQR/X8DwDx+Q==
X-IPAS-Result: =?us-ascii?q?A0GlAgAkXYhlewMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+COX9TMgQLSIRTkTYtA4Q7hzWMN4QEgxY+DwEDAQ1BAQIEAQEDBDiBU4J0A?=
 =?us-ascii?q?oc2Ah4HAQQ0EwECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEkG?=
 =?us-ascii?q?AYOECeFbA2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR0IDAyMEGQEBE?=
 =?us-ascii?q?SYBDx8BBQImAgJWBgESAgEBgnyCKwEDMQevL38zgQGCCgEBBoJmrHIfLCJWg?=
 =?us-ascii?q?WAJgRouiBsBhWeDQXonD4FVRIEVJwuBCYItiB6CaIkdBzKCHINQkVp9BUFwG?=
 =?us-ascii?q?wMHA38PKwcEMCIGCRQtIwZQBCghCRMSQIFdgVIKfj8PDhGCPiICPTYZSIJYF?=
 =?us-ascii?q?Qw0BEZ1ECoEFBeBDm4bEh43ERAFEg0DCHQdAjI8AwUDBDMKHQshBVYDRQZJC?=
 =?us-ascii?q?wMCGgUDAwSBMAUNGgIQLCcDAxJJAhAUAzsDAwYDCjEDMFVEDE8DaR8yCTwPD?=
 =?us-ascii?q?BoCGx4NJyMCLEIDEQUQAhYDJBYENBEJCygDLAY4AhIMBgYJXSYHDwkEJQMIB?=
 =?us-ascii?q?AMrKQMjdBEDBAoDFAcLB1wDGSsdQAIBC209NQYDCxsGPgKmSgFSKBNMgigCk?=
 =?us-ascii?q?wOxfjQHgjSBYIFhDJ8rBhMvlyYOBpJULpgfIKhGgXojgVwzGiSDNk8DGQ+OI?=
 =?us-ascii?q?AwWFoNzjwkBPUA1OwIHCwEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:TtoBqKBdG7xgAO/lHel455DYdb4zR+YMi2TDGXoBLSC9Afbo9P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkOss1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFJSWY+eRMbEVt7ee3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: 9a23:MygJ6GAqlCNWgoj6Ewla3WEPFMs3TibUzFjAIkyxFD9uE6LAHA==
X-Talos-MUID: 9a23:Jhf79gaRoBcrNeBTuCDdnTxyZMNTsofwIVFKs54DvZW7Knkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,301,1695679200"; 
   d="scan'208";a="75293175"
X-MGA-submission: =?us-ascii?q?MDH4M20r4bGXGNM+2LKqiGDbZzrxdcLnY1p9IU?=
 =?us-ascii?q?+wLWkuwminY36K0VJsKrqjSeWmh4yLcAnJ2ykA/heLQtUBdkFByZ9XY5?=
 =?us-ascii?q?BOVDY8f4eQJ7k7okOWiqi5MKVODFmSSARqVIm6xhiiZDgkSVxqSzkuBt?=
 =?us-ascii?q?nS7itN1BHPuXEv3fEB74Qtcg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 17:38:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703435921; x=1704040721; i=markus.elfring@web.de;
	bh=CAB4VQvQ8vvQgycqUYcZEZDvRj1YXXBaD0h2ZtqUKNk=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=M1W+/3hU0SXqPb0RjBVtvbE+VZL1bLI4eHMUM8OglLo7SrFbIPZzStzubCBn0/8j
	 TvZ2oD8WHtwqnbMyhDL6w9hVD1ZCUNeBqGn8baenssLx5nVa5xykeCUyzAC8b8A23
	 87S78NeOLg0W8eNAer/4d2gx9c7kMnedGAwZ/LEBmXrQPJ1y0L6ogAmfMYEI9tcZv
	 m3wjVlNU3yK3Lka9WaD/NSIYtid2sR2xsev74/7rvx+maBtk8BwA/TprgpeDJjhvf
	 pBKuVQ79V7swSyThB+TfgI40EDhCN7MN8Al90K4c5jNToh4iwOwvLfcDcFEHSxb0l
	 KwgD30iO6Ig8ws2vGQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4N98-1rAODG3JJO-011YvB; Sun, 24
 Dec 2023 17:38:40 +0100
Message-ID: <6f3b159f-a3cc-4072-aae8-9792c9d274cd@web.de>
Date: Sun, 24 Dec 2023 17:38:39 +0100
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
X-Provags-ID: V03:K1:0iUr9rY3KOdtRUuHpaTnIE9UM3Ofnc+IVxrPkfGbkvwxqOwawbz
 7QZbl4YM2pyuLyOwskzMe0smfHmXUXiO1mrMToTpXvdOPL1Zexz3liAbnWZ9XgTBe0/ghkw
 GhWbDDprQR3vy9WUrd0pVptMrpZTaFNFx4s7yzGMFHg0Wc+4jWnwVlwcmL1kbH5a9TLvtGJ
 UMvosAlxJlr3lByLehkzQ==
UI-OutboundReport: notjunk:1;M01:P0:wNYY4Bv+5RY=;k4r5glqF+IDQmcblxV+FmhkJKeC
 akNtHh7j9RuPCJ5AJRHcRrx3X4xmH+j7MKnqiN75sZCvJ1vxYrHgvgmeM3GVZLS2LgcWou4NT
 sn8kQ9hEoseFSLsELpIPloXGyQKPov3sGs8TO4njzi88kO31F8dF2QB2ydayDoBfl90LsNd45
 rIXCtQ3bgAnY64XQKRUvm3gBrr6FAZVzdJYhlSgdIXlcCw1ILRhLCRPonOdIWnHqaqeT1jtqw
 dRCjHDn5EfS2nrTlpGooS5taw8uclJkjLjIuApTFfenktBqTLwPjH2hrvCRUx9VL4qGskFJ46
 fyeYtOSM3xeMespOU8ggufJZ9WpltmfUGq95mXLCy/SXAY7YdfNgFVqEY1n/Y/nZkx9LetJj4
 r5eIvDf+hjdHFYC8OWzShsa1yRllAYYJi2hkQBPDjyLV0wnV6EPS91noF9SbAvpvZUq4HENvI
 N6vgMVrFddPViKeS23l0ekktFFcdJRkC+hzR9KnD/cGyf6gUHjSQFIZO0rwxtjY4ukzp8PgVP
 PZIychVq9YU1O3/9omGBVT21wL6EtDyPPKIfQvryw1K+j0RiMG3dDVnWRoRyhSVXHg+sKfaCH
 TIWrGS+6o83gXD+e8B/pQfjjDQl3sQy1jJUGqj5Zf4WfLoV6vZIEGEd8hBf5gyY3HcQkDMYHD
 ELWJCthfCZi4knZVf0vWO4fT/mpCUF+N+QzOstY2klU7cF5cwgqESet52Cs1X7KMYX8GIZZEI
 9S3CfFknzZe4SqtE1Mlf+7htqS/0OyoOuPYv8KBrmFsWQH2KdXVF2GIwDQ0n3gg4dz0kUvZMz
 d8LW3mUsrzyYs1bythnlYZrnFU3Z/n0cJwlArRezZ3yDTo29bTFmZ6PGpUQEw3UBU4hvwHxf1
 NZ0HOBspcHL0nl+S7RMRybsRIXCyw8BCUU097mRDAK4U6Tz0wDeiZ7fCUpTi5QEDHtcE4DkF+
 MD4p9g==
Subject: [cocci] [PATCH 02/10] clk: ti: Less function calls in
 of_dra7_apll_setup() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1370
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/6f3b159f-a3cc-4072-aae8-9792c9d274cd%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 24 Dec 2023 12:27:09 +0100

The kfree() function was called in up to four cases by
the of_dra7_apll_setup() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Split a condition check.

* Adjust jump targets.

* Delete four initialisations which became unnecessary
  with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/ti/apll.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/ti/apll.c b/drivers/clk/ti/apll.c
index 929c021f0cdb..d2be672521a3 100644
=2D-- a/drivers/clk/ti/apll.c
+++ b/drivers/clk/ti/apll.c
@@ -177,17 +177,22 @@ static void __init omap_clk_register_apll(void *user=
,

 static void __init of_dra7_apll_setup(struct device_node *node)
 {
-	struct dpll_data *ad =3D NULL;
-	struct clk_hw_omap *clk_hw =3D NULL;
-	struct clk_init_data *init =3D NULL;
-	const char **parent_names =3D NULL;
+	struct dpll_data *ad;
+	struct clk_hw_omap *clk_hw;
+	struct clk_init_data *init =3D kzalloc(sizeof(*init), GFP_KERNEL);
+	const char **parent_names;
 	int ret;

-	ad =3D kzalloc(sizeof(*ad), GFP_KERNEL);
+	if (!init)
+		return;
+
 	clk_hw =3D kzalloc(sizeof(*clk_hw), GFP_KERNEL);
-	init =3D kzalloc(sizeof(*init), GFP_KERNEL);
-	if (!ad || !clk_hw || !init)
-		goto cleanup;
+	if (!clk_hw)
+		goto free_init;
+
+	ad =3D kzalloc(sizeof(*ad), GFP_KERNEL);
+	if (!ad)
+		goto free_clk_hw;

 	clk_hw->dpll_data =3D ad;
 	clk_hw->hw.init =3D init;
@@ -198,12 +203,12 @@ static void __init of_dra7_apll_setup(struct device_=
node *node)
 	init->num_parents =3D of_clk_get_parent_count(node);
 	if (init->num_parents < 1) {
 		pr_err("dra7 apll %pOFn must have parent(s)\n", node);
-		goto cleanup;
+		goto free_ad;
 	}

 	parent_names =3D kcalloc(init->num_parents, sizeof(char *), GFP_KERNEL);
 	if (!parent_names)
-		goto cleanup;
+		goto free_ad;

 	of_clk_parent_fill(node, parent_names, init->num_parents);

@@ -223,8 +228,11 @@ static void __init of_dra7_apll_setup(struct device_n=
ode *node)

 cleanup:
 	kfree(parent_names);
+free_ad:
 	kfree(ad);
+free_clk_hw:
 	kfree(clk_hw);
+free_init:
 	kfree(init);
 }
 CLK_OF_DECLARE(dra7_apll_clock, "ti,dra7-apll-clock", of_dra7_apll_setup)=
;
=2D-
2.43.0

