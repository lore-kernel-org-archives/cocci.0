Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3895EC46CD2
	for <cocci@archiver.kernel.org>; Sun, 24 Dec 2023 16:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=T9u4solGEcwZXbgSKeafa5rI8oOhRUXkZHPfzeeWl68=;
  b=lsvhPlmD0+Ky9TAc9vS+pV/wF/EdizByKLBU8GkU/qcU1KDjz2770A2Q
   b+Vmdbdy43kUYMf8ZCZgyShEwcCOrOjLzB4/G5QL1ZAxfk6gixXdakWRl
   gOARL0seWT1pS33g45un3lYm+EwrYtgCluaFgofdbTwReg8OnmduW7WFr
   U=;
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
   d="scan'208";a="143934482"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Dec 2023 17:37:14 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 198D2E0CCA; Sun, 24 Dec 2023 17:37:14 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3AFE4E004E
	for <cocci@sympa.inria.fr>; Sun, 24 Dec 2023 17:37:11 +0100 (CET)
IronPort-SDR: 65885e37_aktCgu0Uqc2gKB2lXCZjDfC0bt6vG9ucqHYi6Tt44xaQlaz
 FnR8HznNCm8C+TxhrXPn/9I3Fakb2orwLCYsGAw==
X-IPAS-Result: =?us-ascii?q?A0HzAACsXYhl/wQP49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBT4I5B3hTMgQLSIRTkTYwhDuHNYw3hASDFj4PAQMBDUEBAgQBAQMEO?=
 =?us-ascii?q?IFTgnQChzYCHgcBBDQTAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBA?=
 =?us-ascii?q?oEGE4VsDYJcARCBDIEeAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgYjBBkBAREmA?=
 =?us-ascii?q?Q8fAQUCJgICVgYBEgIBAYJ8gisBAzEHry9/M4EBggoBAQaCZqxyHywiVoFgC?=
 =?us-ascii?q?YEaLogbAYVng0F6Jw+BVUSBFSeDQYgegmiJHQcyghyDUJFafQVBcBsDBwN/D?=
 =?us-ascii?q?ysHBDAiBgkULSMGUAQoIQkTEkCBXYFSCn4/Dw4Rgj4iAj02GUiCWBUMNARGd?=
 =?us-ascii?q?RAqBBQXgQ5uGxIeNxEQBRINAwh0HQIyPAMFAwQzCh0LIQVWA0UGSQsDAhoFA?=
 =?us-ascii?q?wMEgTAFDRoCECwnAwMSSQIQFAM7AwMGAwoxAzBVRAxPA2kfMgk8DwwaAhseD?=
 =?us-ascii?q?ScjAixCAxEFEAIWAyQWBDQRCQsoAywGOAISDAYGCV0mBw8JBCUDCAQDKykDI?=
 =?us-ascii?q?3QRAwQKAxQHCwdcAxkrHUACAQttPTUGAwsbBj4CpkoBUigTTIIqokGiQDQHg?=
 =?us-ascii?q?jSBYIFhDJ8rBhMvlyYOBpJULpgfIKhGgXomgVkzGiSDNk8DGQ+OIAwWFoNzj?=
 =?us-ascii?q?wkBPUA1OwIHCwEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:vj4er66nGWt0edtoPwPXwBzXdLJyesId70hD6qm+c20wTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhX4tKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkYNDSaNzhHZKjBkWyFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3A/yiFnWsXaOV7sSqbXc47qTNc6IshSWH54Xzucna?=
 =?us-ascii?q?HKm95V7OpV1OW865dxp8=3D?=
X-Talos-MUID: 9a23:Ffw3KQrBW2NUpxySaHUezyFEOcxI4oKNMhoyy84Xvc6gGG9VAB7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,301,1695679200"; 
   d="scan'208";a="143934479"
X-MGA-submission: =?us-ascii?q?MDHTkB25b+yvTsYGliID8YcflnTyzETSML8qE3?=
 =?us-ascii?q?Hlwwm/p5gvmBsBE3DDsUq0xWLM/bNWUFHOa8Fq4Unm2TeyCDfUrw+HB6?=
 =?us-ascii?q?5uNgygm9tk7rLOmcEjjMxFp7h8gorDmi3GSOasJRvO++RwoBrBvmZ6ld?=
 =?us-ascii?q?XT4rxYfZ0XPmdP7seerfEHJw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 17:37:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703435819; x=1704040619; i=markus.elfring@web.de;
	bh=HUtTyqgAjeXilij1EZvW9BI8jaGz1KwDa0ackvdaMP0=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=d2btJZgBjrL9shctEps3kZP6ar2tniPSbSRCDxu5GQKJuq9gCNGhMqPt2GrvewjQ
	 3IDdl8d6sMRsR6RugTGpDyuJ8Ny54xfbFq/osyKsFMDoqUGOqMivCT5iVw/Z8zHCR
	 FCBCHvRnPw6aZ8gdXOOdq/roceRzdW8gN0OxeLcSmzHjeVHdzJjWpkmJTlcvrkJM1
	 MpXaBo0FyGv+8i8VfajSsWx2eCa3MqO94+K6TqEQTinPg0c5MvzpFCSjZwzwGuiIN
	 inQVAyjI0MEE+/MMujKR5HtPxyygugniPGRUwm672dw+rBdOc8rF7ZR+FrPj1pkmA
	 1wzR9sjG78uxX4Lm9A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6HKG-1rJcGY3hhQ-0070lV; Sun, 24
 Dec 2023 17:36:58 +0100
Message-ID: <422c6249-31ac-410e-911d-ec25aeee126a@web.de>
Date: Sun, 24 Dec 2023 17:36:57 +0100
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
X-Provags-ID: V03:K1:5Zlu4vBjOn8y3rhK/v7xJFB3kzVjuBnaLVTVepoXE3uf2IfFtqB
 6rHVkvjJnEO9/UjDh4AgBecn1KYpjrdkyYpVByNrgF+lPLy6EhBHUwttNktZ3HbbeWAY2WZ
 ynEcS9grOUky6y9Lp7PKZHfuvoi7y2yUIAbBhDW+E2l1Vsw6ZCmN0SawMeLTX7aaB1iirtb
 IJSPvsHD6I4Ry1wVjcZig==
UI-OutboundReport: notjunk:1;M01:P0:iocNUSrfeNw=;wYkjPLwi2LIAvzmFQCTm/TVNKNP
 dySDCNs/XyI8mriI9wR/iF0jYz36JlM7n4uOAlurxXlRCek9gBOiFIB4DPPXou0jXevH3ao4E
 Xf1u50XGvq8y7rjPJkSoJ6d+LELHTsmWYthxYMkHtBxRq/ANC3OCHy0uAI+RuuTCGORLDGLxo
 dZ3pJYhcbIMIGaU0w8sikQ/Fh10GhCu3FHR5XDP1O6zRs+K3O3zFk8z/YwEdMIowxBIWioBco
 DY6oUDExpJtAhyExNYuia88lcq3I+uUU2pVj2AM9iygDwQ2ZsdmgowuktDtsGzG0b/ZLADVUR
 QZWswuvVh7GXTGiukDJz3hIoW92R1dLQQc0fBB9r8VpzKustixfEIblNY/+oznttG0dHfvCRU
 ETRz2J3h0/pM/4RIZdfBRwwWnUCMZkGZcSeOpjVDYV5Dv/DT+cZ9gDNX5WPE3LyEXoVxP6ebp
 fVw8OKY74NAL5VJkUsUMpolCNOxhe/lJsHVtipS2CZV8A9nRMnTtzhsg5/IYdq5/X+W/H0uX1
 CTEHoQGXbZn/QqUAtAcm2W53Kb2YBHP7pkaXEGiPzc7ibeEjEk55QYU0FUaF9Kxoy/05HGwVh
 R49G5+LYIIhoO2+YGY4pRkXqYBSHCgV+VWGu7Ht4yXCgEIYI+H/exhGOjbBzyJk6q8dwVgi+x
 2CCEzxT0B+O1v0p+sCFqiV9+fEthbUCTUIVYUtokvxro/4N9Mcox1ArD0a1KEyBbrIt+HsB3D
 VKEhkDIMAHKCKSaa8Am/FZOL4kGUJ/lQTbrYrWqfi8MlrlOS1NW9XaxdmRHtuEWnXyaPAgrxQ
 //78P2kKxNwxGGT0YMqZtAh73NUtZHsHqpMvgqcRwav8/gHR2SpVtLojRZ26IslwieeL69c+f
 e1d8+55MqT1lMAqYo60S1ZZrJAIXHM01vDHTXOoyPnDUQpiJvuq6eJvU1jei1BFT+a/ShrKuM
 jrI4PA==
Subject: [cocci] [PATCH 01/10] clk: ti: Less function calls in
 of_omap2_apll_setup() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1369
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/422c6249-31ac-410e-911d-ec25aeee126a%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 24 Dec 2023 11:15:27 +0100

The kfree() function was called in up to three cases by
the of_omap2_apll_setup() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Split a condition check.

* Adjust jump targets.

* Delete three initialisations which became unnecessary
  with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/ti/apll.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/ti/apll.c b/drivers/clk/ti/apll.c
index 93183287c58d..929c021f0cdb 100644
=2D-- a/drivers/clk/ti/apll.c
+++ b/drivers/clk/ti/apll.c
@@ -338,21 +338,25 @@ static const struct clk_hw_omap_ops omap2_apll_hwops=
 =3D {

 static void __init of_omap2_apll_setup(struct device_node *node)
 {
-	struct dpll_data *ad =3D NULL;
-	struct clk_hw_omap *clk_hw =3D NULL;
-	struct clk_init_data *init =3D NULL;
+	struct dpll_data *ad;
+	struct clk_hw_omap *clk_hw;
+	struct clk_init_data *init =3D kzalloc(sizeof(*init), GFP_KERNEL);
 	const char *name;
 	struct clk *clk;
 	const char *parent_name;
 	u32 val;
 	int ret;

-	ad =3D kzalloc(sizeof(*ad), GFP_KERNEL);
+	if (!init)
+		return;
+
 	clk_hw =3D kzalloc(sizeof(*clk_hw), GFP_KERNEL);
-	init =3D kzalloc(sizeof(*init), GFP_KERNEL);
+	if (!clk_hw)
+		goto free_init;

-	if (!ad || !clk_hw || !init)
-		goto cleanup;
+	ad =3D kzalloc(sizeof(*ad), GFP_KERNEL);
+	if (!ad)
+		goto free_clk_hw;

 	clk_hw->dpll_data =3D ad;
 	clk_hw->hw.init =3D init;
@@ -403,12 +407,13 @@ static void __init of_omap2_apll_setup(struct device=
_node *node)
 	clk =3D of_ti_clk_register_omap_hw(node, &clk_hw->hw, name);
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-		kfree(init);
-		return;
+		goto free_init;
 	}
 cleanup:
 	kfree(ad);
+free_clk_hw:
 	kfree(clk_hw);
+free_init:
 	kfree(init);
 }
 CLK_OF_DECLARE(omap2_apll_clock, "ti,omap2-apll-clock",
=2D-
2.43.0

