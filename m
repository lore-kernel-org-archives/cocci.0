Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A1AC46CD3
	for <cocci@archiver.kernel.org>; Sun, 24 Dec 2023 16:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=B3gAoNY77mrsywf2C4mzd0Fudr0IoQTeObwUXjNcWXM=;
  b=veDf8262mWVPbrwshp1foJKs5LbdQRt1FBDuPXyhipSDkiV/Yr7X8Wqb
   eYMaZ7IcSIhOOVCI4Enq+mv6QKwCqSAWSmidncBxMbr5SRgQJuKdbfbG3
   zQZSyovubhxlug1eMRt4aFhqC0jbzbSZBCQ39U383gE7CEKBMRPM6E7kX
   Q=;
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
   d="scan'208";a="143935022"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Dec 2023 17:47:11 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0D304E0CCE; Sun, 24 Dec 2023 17:47:11 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id F0407E004E
	for <cocci@sympa.inria.fr>; Sun, 24 Dec 2023 17:47:05 +0100 (CET)
IronPort-SDR: 65886089_QDeEWd8T8nCNbglV2Q8uH/hDX4IFkeLBW4G3K5Z3bD1q5no
 rzId41oeOE3j9VQ/kc21g7iA6wKJ4t4WP3pq0Uw==
X-IPAS-Result: =?us-ascii?q?A0E3AQCQX4hlew4P49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBT4I5f1MyBAtIhFORNjCEO4c1h0yEa4QEgxY+DwEDAQ1BAQIEAQEDB?=
 =?us-ascii?q?DiERwKHNgIeBwEENBMBAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBJBgGDgULJ4VsDYJcARCBDIEeAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgMDI?=
 =?us-ascii?q?wQZAQERJgEPHwEFAiYCAlYGARICAQGCfIIrAQMxB68wfzOBAYIKAQEGr1gfL?=
 =?us-ascii?q?CJWgWAJgRouiBsBhWeDQXonD4FVRIE8g0GIHoJoiR0HMoIcg1CRWn0FQXAbA?=
 =?us-ascii?q?wcDfw8rBwQwIgYJFC0jBlAEKCEJExJAgV2BUgp+Pw8OEYI+IgI9NhlIglgVD?=
 =?us-ascii?q?DQERnUQKgQUF4EObhsSHjcREAUSDQMIdB0CMjwDBQMEMwodCyEFVgNFBkkLA?=
 =?us-ascii?q?wIaBQMDBIEwBQ0aAhAsJwMDEkkCEBQDOwMDBgMKMQMwVUQMTwNpHzIJPA8MG?=
 =?us-ascii?q?gIbHg0nIwIsQgMRBRACFgMkFgQ0EQkLKAMsBjgCEgwGBgldJgcPCQQlAwgEA?=
 =?us-ascii?q?yspAyN0EQMECgMUBwsHXAMZKx1AAgELbT01BgMLGwY+AqZKexOCdqJBokA0B?=
 =?us-ascii?q?4I0gWCBYQyfKwYTL5cmDgaSVC6YHyCoRoF6I4FcMxokgzZPAxkPjiAMFhaDc?=
 =?us-ascii?q?48JAT1ANTsCBwsBAQMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:e6ZiJ65FMOwvHPt8UgPXwBzXdLJyesId70hD6qm+c20wTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhX4tKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkYNDSaNzhHZKjBkWyFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3AtYNEXWiYKjqrhf0UIGLtRsNQHTJuWULFyCreLn+?=
 =?us-ascii?q?BO29YZ6yWThiz/o1EnJ87?=
X-Talos-MUID: 9a23:KtPpwQrOmvVYj4lWcFEez25iZJYx7qm3MU0Uuow7g+rbGBVBOg7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,301,1695679200"; 
   d="scan'208";a="75293344"
X-MGA-submission: =?us-ascii?q?MDEpEguixPyVyDamvnLMF/SdW0790w/S5ag3JM?=
 =?us-ascii?q?idTxR7RocGxtw1A6fjwhdoID5xtMw+WFB0BWphPOfdvHyIbqegL34x8u?=
 =?us-ascii?q?3IXwZURzk97/XHBBoTicxxPZb8yDVtzClEOtzuUYuXgabDH1n/E+6mDj?=
 =?us-ascii?q?eKXPAH7U/Q5IH+VQfrjYAUog=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 17:47:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703436421; x=1704041221; i=markus.elfring@web.de;
	bh=EoQGOCcDaM4+Ixsw81K6brIiYRjh/R6KiMGIqZjOQN8=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=Be00ZAz0q80WOxH/zPlihloDIsoIBArOTi+T2sigd+FI/ks9dQTzpLWb0r4DfMQk
	 HKVgew8rCCPHvDhdCPqB9gSBzVl1ygcAawL6Msux7QdNDjS5QMTW+x4/sChiUtF9z
	 tnEk3kqAkwjXlNfgid5Lb3efYOCZse9VkgGwffuIftQgbCRMXqlD0ykKRzFFm496s
	 1vLamSoTZYSfpBwYioTDHcQ3+tjd9nvx3KyG/d7X4ccOWB3F+VmX0795OZ1Wzi++6
	 5AU6rjWg/ispq9qPECjZNt/m7J7y7COh3xxaa2afBjQnxOEIxIlhHKydRJO3crucq
	 /ftkPfOYOp96Je2/vQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M91LW-1rNWAl0ZMs-006YG8; Sun, 24
 Dec 2023 17:47:01 +0100
Message-ID: <b4bbcc24-b6ca-4fd3-b8cf-7a2088c67795@web.de>
Date: Sun, 24 Dec 2023 17:47:00 +0100
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
X-Provags-ID: V03:K1:mT4mgdDbP7kJOD75VlWL+dv/P6+ReJspjNxOXgs+MnT/XZ5861g
 ByvEFoUqQtzEYGsLC/Ehh50iodVxf8js+XDAzsuDLuyDMnTzUI7ONqdDUsCm2v2/EVbFr3b
 GPxVApgwAeFIrdYETA9PRtiVQMT5eQOX2Sq+FcBSTbYz8v1N61AMVv7CcOeQuu13ZRvcjPr
 AxrlzZeNRBfowBg3Awxgw==
UI-OutboundReport: notjunk:1;M01:P0:rJk7DYD2fyc=;i3/9r49VTokzDt6oWsAGi0UsBe7
 ie8E5hQQMgVmqqdrnGnfFhpb+zaw/VnJiCM8Im8uJf1FBFvRffxnUKufpDjboz76cXTsyKcPv
 bUcFf11uv5lbiulCFSneINgBwuUCFO/YW28uQZI3ANT/9eJUpSP9RviWFLsjiWpycWgRwakqM
 42XXgW+gCtKK0bOETVAiwCPa291I5i+svqQ17eQaZy8Age//4JKVRyOwe6AygCEB+biL6xSGq
 5EIASH1dSuvt9B6rVlghxAm9snl23j6XxlXDGFZI5sK8M9LQ/vOkB1kjfXuLbCVmzWWWf2tk+
 aqC8rW2FGnQNyWFzZNBYTGCoF/cssqhrvRXnMN8QC/ZSvt2/hU1aaK/6+4onzNpnMZp9JXeHv
 KkRcempGQjxPu+8oZZtd3+iz2C4iArW1bkPGzN4OuswWNXSIMX2TsWpeW8ixvKHeM9fzevqbE
 9QMeSpC1Yepvx2VwWYnHnVJqI0/rJGDThQe91Vv23saZwEWwqaBOOAUa9m/tcK40IUoC2qvSN
 yX+HHl+7yvfBphl/LuBhseTHeXbm3JAIqcwnRcNAcqeniWQ41Nz6MIBGzhVydYc5/XafrTWxN
 E1NpiEeB/we1aXBFgL31D1pDePENH3wtHFlzSlkSpVtx4pQjkvX5NVDdp+Q6QKhlRyduy4LoC
 SE3182wree+QWi5w9IJC8iT0AORRbhViKAHkveyvZKMkfGsIe9SKtLzYLwiGW9Q3JnxGX5Azj
 cj4kk4fWkVrny/8AHQl93iLUPlUqmf7XmO861k17WZQq56YF3fZO8xJ3Yu9c7mS4ASn3x7oEy
 zZIRln9eMIPDZSPVxBTDniYByQat1lbbLZjTqjm7dXZMAP2/tKVRGRXBvrWvuPBHZM/yFSy/D
 qmbmldUF3B1nnPFeDxie3mE4e15tb1A+OzqErT5HktLrWZ142sjgk/cLrAg77gDCVBi5IcuFg
 BIN0Ag==
Subject: [cocci] [PATCH 07/10] clk: ti: Less function calls in
 _ti_omap4_clkctrl_setup() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1375
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/b4bbcc24-b6ca-4fd3-b8cf-7a2088c67795%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 24 Dec 2023 15:46:04 +0100

The kfree() function was called in a few cases by
the _ti_omap4_clkctrl_setup() function during error handling
even if the passed variable contained a null pointer.
Thus adjust jump targets.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/ti/clkctrl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 607e34d8e289..82b48548818b 100644
=2D-- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -681,11 +681,11 @@ static void __init _ti_omap4_clkctrl_setup(struct de=
vice_node *node)
 						   reg_data->offset, 0,
 						   legacy_naming);
 		if (!init.name)
-			goto cleanup;
+			goto free_clkctrl_name;

 		clkctrl_clk =3D kzalloc(sizeof(*clkctrl_clk), GFP_KERNEL);
 		if (!clkctrl_clk)
-			goto cleanup;
+			goto free_init_name;

 		init.ops =3D &omap4_clkctrl_clk_ops;
 		hw->hw.init =3D &init;
@@ -711,10 +711,12 @@ static void __init _ti_omap4_clkctrl_setup(struct de=
vice_node *node)
 	return;

 cleanup:
-	kfree(hw);
+	kfree(clkctrl_clk);
+free_init_name:
 	kfree(init.name);
+free_clkctrl_name:
 	kfree(clkctrl_name);
-	kfree(clkctrl_clk);
+	kfree(hw);
 }
 CLK_OF_DECLARE(ti_omap4_clkctrl_clock, "ti,clkctrl",
 	       _ti_omap4_clkctrl_setup);
=2D-
2.43.0

