Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2001EC46CD3
	for <cocci@archiver.kernel.org>; Sun, 24 Dec 2023 16:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=nz/6D8rQnPHg+KwVj5qoX8k32p/L3WUbDz0lwQsNKdU=;
  b=CoF8nNUGodpqRzQ1qWDyxqnl+ZTSvbWNkJRaJkRR4glBsFU6mrKetmyh
   C24bgKqZmwzrjaJHaHhf3jZ+HH+jlxD632Zi4lpXc7uCxsfsb8j8W2jUj
   3mZCGVhI4UnL3ro90OMeH8HUgneBF+VAlkBfOqvO3Uz76F/6cvAyPw5iC
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
   d="scan'208";a="143935138"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Dec 2023 17:48:39 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 88009E0CCE; Sun, 24 Dec 2023 17:48:39 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 905DFE004E
	for <cocci@sympa.inria.fr>; Sun, 24 Dec 2023 17:48:34 +0100 (CET)
IronPort-SDR: 658860e3_YUPEJ6wI6JlC7CZt282BOHvA9SovhPL61oX74aps6C0m4Cm
 p7/uvg5GLaPH6lXaAFKDI4S2R4LR4defXcAGSCQ==
X-IPAS-Result: =?us-ascii?q?A0FPAAAGYIhl/wQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYI4B3hTMgQLSIRTkTYwhDuHNYw3hASBVoFAPg8BAwENQQECBAEBA?=
 =?us-ascii?q?wQ4hEcChzYCHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QKBBhOFbA2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR0IGIwQZAQERJ?=
 =?us-ascii?q?gEPHwEFAiYCAlYGARICAQGCfIIrAQMxB68wfzOBAYIKAQEGgmasch8sIlaBY?=
 =?us-ascii?q?AmBGi4BiBoBhWeDQXonD4FVRIE8C4JAB2+IHoJoiR0HMoIcg1CRWn0FQXAbA?=
 =?us-ascii?q?wcDfw8rBwQwIgYJFC0jBlAEKCEJExJAgV2BUgp+Pw8OEYI+IgI9NhlIglgVD?=
 =?us-ascii?q?DQERnUQKgQUF4EObhsSHjcREBcNAwh0HQIyPAMFAwQzCh0LIQVWA0UGSQsDA?=
 =?us-ascii?q?hoFAwMEgTAFDRoCECwnAwMSSQIQFAM7AwMGAwoxAzBVRAxPA2kfMgk8DwwaA?=
 =?us-ascii?q?hseDScjAixCAxEFEAIWAyQWBDQRCQsoAywGOAISDAYGCV0mBw8JBCUDCAQDK?=
 =?us-ascii?q?ykDI3QRAwQKAxQHCwdcAxkrHUACAQttPTUGAwsbBj4Cpkp7E4J2kwOPPqJAN?=
 =?us-ascii?q?AeCNIFggWEMnysGEy+XJg4GklQumB8gqEaBag4ogVkzGiSDNk8DGQ+OIAwWF?=
 =?us-ascii?q?oNzjwkBPUA1OwIHCwEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:BHaxuqu1pOZFEN4W7/KyBA2h7skDotV00zEX/kB9WHVpmwKj5q
 STdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniFhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD9HZK3BgDVQfexQpeWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:DHYuJGHiFi50+BQlqmJrqXIeQcogTUSMyVKTelboJGhsU+yaHAo=
X-Talos-MUID: 9a23:20mDggnIAxyGIKpXIpOFdnplaJxS5piiBnkQjKhFkeijbQ4tGhyC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,301,1695679200"; 
   d="scan'208";a="143935135"
X-MGA-submission: =?us-ascii?q?MDFyTW4DxvIbkiAKaF0XkzNAaGFqXTJ2Lx9w53?=
 =?us-ascii?q?mCuwsB07+mcGfduMNn5xED7TFiHtiQIuC1OfrXOQA65FGfbqdszmRb9d?=
 =?us-ascii?q?ttaLXjUCNmYtIT+6yd/Kw10FpvB6KSUPd7ziC3KxMtawvakgOh1ZF1eC?=
 =?us-ascii?q?TV2TKUU4lhIMC8yvvefVC9Vg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 17:48:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703436502; x=1704041302; i=markus.elfring@web.de;
	bh=fer0npM9x++5IlF6KQWWoivekp1DBR9tflb/ZiR/dXA=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=BQC3R0l4dJB7droV1PcxJ+qkpaEfjBV2qiJVn8WPDTj++zBskW+qj84vAhhe8VpO
	 1bWOnjqdNPGZ6e0RwBtOtVRtGKyYv6ISDt24/6C6Ro+y64de+yzKATIZh2SbMDcs7
	 aQ1PWPDMRPDkwf838+4StruLz866jebSr5ErD2wXHPlu8NX2nWyo4tpvBL49WVB3y
	 RnSwdMabDCR+6DIxqx+Jp5XvZrfml8q9C+Bq+bNUoWa4Rh7evq1mEwMtn4nYpthwL
	 dBq5WWY4crTOUmvR2UDDcuDARFptvAJ4DOpwiqVFUmZrUooSclmhtaVgYy4Mw8Dv/
	 XeP+oFk0em+uOxwlTg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3V26-1rHzsd3QJO-0011xE; Sun, 24
 Dec 2023 17:48:21 +0100
Message-ID: <0a9cd717-0909-4bc2-b78c-73fe9f661156@web.de>
Date: Sun, 24 Dec 2023 17:48:20 +0100
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
X-Provags-ID: V03:K1:eokwazI7oC0F6W7Kup8Jd63Lo0nLI7yBgMcHCMI9YWI79wiE0SJ
 LENS88H4VP2YwYihRAUtWIUnURHjK+pf2+EVgeC7zVnUOARgsOpjl62NfuZJScXfcVTMiHc
 0aGZ1S8LmPh7rQaTcgQhPVGqTQob2YhOMBDkI/ijlBCvY0BJ/ILKvZj6x2OwwR2EAp9TqEE
 8PDAGQQFBnyEUQiI+k7kQ==
UI-OutboundReport: notjunk:1;M01:P0:0yddZSuIJUw=;rcgSNkMomWPs6nh+rAyPw7L1Z44
 UAnRXoW+vxvufYZjwR/FJpdnYBKVzzdk9buA6iM3KJU7D8w3tkPpRDOHBEfiS5ZWYvaHhT+CO
 SZfP/vKfb7yIO1l1cF3SLxRgc7fFuprB/egnqbYp1GwzrRwVo4Q84vjhDfkBlcTCdIuizu7oc
 v5QX1+nsltp2qgNJc+YWfBxz6pZZhooBZbUJM57lfRi53FNqV4WzKMfb0K8lyJrCMibKHPdUA
 JsvIPX6LVa5sKI7ja3A6fsAWybmA4xLCBMH/tIc5rpeufnN9JcnCSNNUPHeANr05kwztSX6C3
 9QU5SbAni+G5nnW/O9bJaa903G1e1bzWlaoNNAYt5RuYY5Dh266cM8XTrGd26nV5gyTDe5B7l
 14WiIXuovalBBYnc2sw7qT8YePtvlqHAhS0Z9hPS7T0HsXD3x9bkw/A20Dd/WV//FPtFcDXwe
 NG7/0+gfiEbjK0Ou/HFZrbNnPon6+g+x7OsmeDh8AOtdw7xlBmFrWkDTqXsGBXJHGfjE5kYEO
 56Sj78TrZdLarSYvzOYA1yZ4S4YtUMWS//mLHE4UkB3zOSAUFtFZ933m4+OLsLvm3jlRlTPWC
 bflCmWZPchcmKruzvoaRTyI6eUn90b5mE0IWHszIapFIhp5mP+sfhaama9e9x+5aHdqnHfxec
 2PfJB6J8ZZuUjUIQ0rk3xBqeHkFPFbLqKAWN6N2j+ebIAC3OBClaP/5ek5s3BsS3QcISAjSZt
 pHxraHXyP5m7BmPU8JCKwsml6dHIh1gEnTfS0y7t9OWcDJLljnL2PsXU6EQxvieayVVm++yI3
 UHPYBTgikwByklR6dG7d29BR8nv83tzvQDfPQaq148MWgs3Rvhmplm1fIyZeeUFBiy5agFECc
 kcH0Fhq8HyObSaPTLXxjwOQfl+uV5keFPpu7HnvCB1DpivtJgZFY0VXCqw071vNvd/9QdLUjT
 7ep7ng==
Subject: [cocci] [PATCH 08/10] clk: ti: Use common error handling code in
 _ti_omap4_clkctrl_setup()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1376
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/0a9cd717-0909-4bc2-b78c-73fe9f661156%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 24 Dec 2023 15:56:08 +0100

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/ti/clkctrl.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 82b48548818b..5a1bd176160c 100644
=2D-- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -590,10 +590,9 @@ static void __init _ti_omap4_clkctrl_setup(struct dev=
ice_node *node)
 	if (clkctrl_name) {
 		provider->clkdm_name =3D kasprintf(GFP_KERNEL,
 						 "%s_clkdm", clkctrl_name);
-		if (!provider->clkdm_name) {
-			kfree(provider);
-			return;
-		}
+		if (!provider->clkdm_name)
+			goto free_provider;
+
 		goto clkdm_found;
 	}

@@ -603,10 +602,8 @@ static void __init _ti_omap4_clkctrl_setup(struct dev=
ice_node *node)
 	 */
 	if (legacy_naming) {
 		provider->clkdm_name =3D kasprintf(GFP_KERNEL, "%pOFnxxx", node->parent=
);
-		if (!provider->clkdm_name) {
-			kfree(provider);
-			return;
-		}
+		if (!provider->clkdm_name)
+			goto free_provider;

 		/*
 		 * Create default clkdm name, replace _cm from end of parent
@@ -615,10 +612,8 @@ static void __init _ti_omap4_clkctrl_setup(struct dev=
ice_node *node)
 		provider->clkdm_name[strlen(provider->clkdm_name) - 2] =3D 0;
 	} else {
 		provider->clkdm_name =3D kasprintf(GFP_KERNEL, "%pOFn", node);
-		if (!provider->clkdm_name) {
-			kfree(provider);
-			return;
-		}
+		if (!provider->clkdm_name)
+			goto free_provider;

 		/*
 		 * Create default clkdm name, replace _clkctrl from end of
@@ -710,4 +705,8 @@ static void __init _ti_omap4_clkctrl_setup(struct devi=
ce_node *node)

 	return;

+free_provider:
+	kfree(provider);
+	return;
+
 cleanup:
=2D-
2.43.0

