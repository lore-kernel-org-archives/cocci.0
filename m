Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7027C46CD3
	for <cocci@archiver.kernel.org>; Sun, 24 Dec 2023 16:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Twn8cup2xWue/7O4warf42kElngTfW23Gvee42zIdg4=;
  b=mWeoKYPsk+Fhi6v4Lc3ek8ojvA1g547ulL6WefsXIdRpLiy0MNn1Vtk7
   idlbWHZt6PG0L7FsTcdv/kuxbj0XnuU7/YIgJ/jVshr8UK6GfZwSve2fC
   ct+cl9CeNzWMFRct1lsKHkruiitlGhCJ5c8SvHzu0aCR21LPZUT3yWGhI
   I=;
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
   d="scan'208";a="143934661"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Dec 2023 17:40:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 20365E0CCA; Sun, 24 Dec 2023 17:40:34 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8AED1E004E
	for <cocci@sympa.inria.fr>; Sun, 24 Dec 2023 17:40:32 +0100 (CET)
IronPort-SDR: 65885eed_At0JUY1ejMw/q/I0wOyd/jo5Xa1KzH4jvSpMseL31Hjvsq4
 F7K17TSGn1xiGWtp200eziRByvWyMyRek6Drwfw==
X-IPAS-Result: =?us-ascii?q?A0EzAACXXohlewMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYI4f1MyBAtIhFORNjCEO4c1h0yEa4QEgVaBQD4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEOIRHAoc2Ah4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBJBgGDhAnhWwNglwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAkdCA?=
 =?us-ascii?q?wMjBBkBAREmAQ8fAQUCJgICVgYBEgIBAYJ8gisBAzEHrzB/M4EBggoBAQaCZ?=
 =?us-ascii?q?qxyHywiVoFgCYEaLgGIGgGFZ4NBeicPgVVEgTwLgQmCLYgegmiJHQcyghyDJ?=
 =?us-ascii?q?ymRWn0FQXAbAwcDfw8rBwQwIgYJFC0jBlAEKCEJExJAgV2BUgp+Pw8OEYI+I?=
 =?us-ascii?q?gIHNjYZSIJYFQw0BEZ1ECoEFBeBDm4bEh43ERAFEg0DCHQdAjI8AwUDBDMKH?=
 =?us-ascii?q?QshBVYDRQZJCwMCGgUDAwSBMAUNGgIQLCcDAxJJAhAUAzsDAwYDCjEDMFVED?=
 =?us-ascii?q?E8DaR8YGgk8DwwaAhseDScjAixCAxEFEAIWAyQWBDQRCQsoAywGOAISDAYGC?=
 =?us-ascii?q?V0mBw8JBCUDCAQDKykDI3QRAwQKAxQHCwdcAxkrHUACAQttPTUGAwsbBj4Cp?=
 =?us-ascii?q?kqBDnKCAgKiQaJANAeCNIFggWEMnysGEy+XJg4GklQuh1CQTyCoRoFkATiBX?=
 =?us-ascii?q?DMaJIM2TwMZD44gDBaECY8JAT1ANTsCBwsBAQMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:vfEOOK7VlgxAl7l/QAPXwBzXdLJyesId70hD6qm+c20wTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhX4tKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkYNDSaNzhHZKjBkWyFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3AIYi9pGmllk3D57MGhU8YSMRvYAjXOSHs4yeKOVf?=
 =?us-ascii?q?7NVZGS5DPa12/3YlbgtU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AfodQ6w4zNd3Hhs7gPNuclR1TxoxHvbaoEGxdr6w?=
 =?us-ascii?q?PutaaOC9uKmnNlG+oF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,301,1695679200"; 
   d="scan'208";a="75293197"
X-MGA-submission: =?us-ascii?q?MDEHzWpxuoKWh+geuLdkQQ9pNlb5YTDyBx68mT?=
 =?us-ascii?q?eU9p9/InyjHO+9T4dyT/5RAjNgHXoH4Nt4FRs8VDtxAfHlnIsjRJQ/iB?=
 =?us-ascii?q?OZ/xzVioiPLQy7n38mvxGZ9PNVfQuGGW66uv7u4OiNjhVn6DOxX6crYV?=
 =?us-ascii?q?rTmVGH9xQ3lvCF2v7rrJ4N5A=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 17:40:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703436009; x=1704040809; i=markus.elfring@web.de;
	bh=VvcPb3zTVCi+fRkNHAv6TVW423QWVXeGKi1oD5ImWcI=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=LscfqP9UCsXC+p+Bea5/LMhWXBrT84uXK4HjQsQ0cZPXo8sOMHm8oYGbm1sC4/5D
	 rFKcYYpIAMwcDmpqDp0W2GxH8DYgYoM7S+Tv7wdlROfKkpw8hrySzW9w7VfqZG2mE
	 3H3b/dt0O16K5pYQVDxOI8P6kNTBGZHNhtCG4+KaEekxVm9+KyV2Fgr+oNBvRik4Z
	 cQd9BKPVy+tgKEd3F98ICVgsWl3kb9ILRda8BFfpsJDMYNgR6dhlEq5zFRzD89ELg
	 epDbvggFfrq3xfK/HrW5yeo+22ZeIQFYkfUy7dFWTuRL4Z4tLdb3VU9WtD6Vk2/Pj
	 23P1cNF7oYXckh07xw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MuFD7-1qz4iq1mP7-00u6nC; Sun, 24
 Dec 2023 17:40:09 +0100
Message-ID: <159195e8-a382-48ab-8159-0c473ec38ad2@web.de>
Date: Sun, 24 Dec 2023 17:40:08 +0100
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
X-Provags-ID: V03:K1:2vXjRt4bOptLQGsxvaUmJtLomLSQyrX0M9nCcPmXcy1A3BcrvMx
 ImTo7wCvKnUSbuhzGHn8Ej/JxVfgbh5EWGsN/A7Tq65TzIghgmO83Cx0XabRYjcStueZjdS
 x9Jv9s3Av3hQBbUba3TyV/g25q2ejgN+eD87Fjnoog/4gOMhR7bXD/Nu37pg+vLmCffVQ4z
 UbYpjbBXQKaSdkT7RuSVQ==
UI-OutboundReport: notjunk:1;M01:P0:iK6Nj6+3/mw=;zNeXTuolSeAqzD1ZGuX/uvybDV5
 CEpxweIH7h0PJMUKWOIJPuUglHdMd/+mx1NSrN6orAW9IDcAVJZ98T8Of0n999ZvGygH7pvNN
 VDqQbFfYI8v5y1uNgkOoDabS/yW9cg/+q9JGBfnOq6UEtMs7CxcD16vAqUSV8QBqYb8v52f3Q
 BXl4nQ+Wb1A4vglq18P1w7+8maIEJiQf85+k7uLBeDzX5ej3pltKmTJ13zBr2e0wzvaMcCRev
 xAKQqD3ilbyHFaljCr6jj/d6q0OQa6j705J4ViqmXD6OpLxjdpjrhuW5x6lMK1NCiCyFUqB4C
 ZCPaJWbM0J6JSkdEc+UiYJLSRMrmtx6+VUZ09G7qaIwtSToJj38hDeWyn9Un5YzC345KcXwme
 py8dIzJRCZbZE3uKTBXc0Kq92pJt1Hz2K4iUmGfVHiwwbO6sA9R0g80Kjb+g2WZClfB4x8imJ
 fm/RVL+faT0yPySu946bORv4QaUP/0PY9DBbhIzpdC/YEzE8Q1ZJSYLuT5gTnEaMKAtf+nUas
 8qFaupDaYMCyPVea02m2a9x03LroUUZ0woASD1TK+8mJy620NacERG8A9vQZpOfUX9C28gyBA
 kH5GvrunioV4J15m+NSMuJGW8k/YXH4G85YXUzdxMRyX3jCVneLUFckjhh6OlC1J7YXE8X7pN
 cUjkCT8QzQkLYDJJRXv/elB+Z5mjCRM9HBJPH16M8OpLivo8VZM0J3vib/YORV/cHhdQGu0Ho
 Fv59sOrB2SD8ucAW3uRCeV9Qw5KxSxvXkcO+56uAj4ynUGNWbBLi/IVnpU0rPtaOWJSCuQboO
 LPE86NV28ny7n7/koMWeuOk49LQJil1ynt1xHy4xEMZYBXpFXzd5NsaU4Nao2DYlV59lsiR22
 LM5qzZHFEkQrIcW7Q/L5uEGzM9OEnRPyKZFuosTKH6UDI5EqhKqo02EYUGpQzSzDmnJphKpFV
 o094AXEJaVkx4Iml7TOh8fs9qvI=
Subject: [cocci] [PATCH 03/10] clk: ti: Use common code in
 omap_clk_register_apll()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1371
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/159195e8-a382-48ab-8159-0c473ec38ad2%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 24 Dec 2023 12:40:59 +0100

Use another label so that two function calls can be better reused
at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/ti/apll.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ti/apll.c b/drivers/clk/ti/apll.c
index d2be672521a3..406326883741 100644
=2D-- a/drivers/clk/ti/apll.c
+++ b/drivers/clk/ti/apll.c
@@ -163,16 +163,15 @@ static void __init omap_clk_register_apll(void *user=
,
 	clk =3D of_ti_clk_register_omap_hw(node, &clk_hw->hw, name);
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-		kfree(init->parent_names);
-		kfree(init);
-		return;
+		goto free_names;
 	}

 cleanup:
 	kfree(clk_hw->dpll_data);
+	kfree(clk_hw);
+free_names:
 	kfree(init->parent_names);
 	kfree(init);
-	kfree(clk_hw);
 }

 static void __init of_dra7_apll_setup(struct device_node *node)
=2D-
2.43.0

