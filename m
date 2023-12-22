Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E82C46CD8
	for <cocci@archiver.kernel.org>; Fri, 22 Dec 2023 12:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=wkFdVUUV5fJ2BBBJj2U2xoHmHA/trnB5XxdlJO0tpTc=;
  b=kRbgKnTgdD2MngIYvy5zMt8mDS5tdPP0aDlEcqkHW8Jp7hp8vrAkrD2Y
   tv4uFer78ycDWuYWPn85CxYAEZYE9+i4jnO1ARODIdYUQ/ez5VwWYgKM9
   f09sE08y/qKUkJIsE/VqAV5+UQfAy5FnaOTun2EftI96JUH+cnSp7H5Cl
   8=;
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
X-IronPort-AV: E=Sophos;i="6.04,296,1695679200"; 
   d="scan'208";a="143746122"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Dec 2023 13:03:36 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 68BA7E0AF1; Fri, 22 Dec 2023 13:03:36 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 880F5E004E
	for <cocci@sympa.inria.fr>; Fri, 22 Dec 2023 13:03:31 +0100 (CET)
IronPort-SDR: 65857b14_Ax/NCzKSsefSkHHlyUXs8g9bqU80DHpX285TG+vqd3S4oGn
 XzHbRc7r13j+xG2aWFU+NXAxLdqEsvIhb0d6ywg==
X-IPAS-Result: =?us-ascii?q?A0HaAADOeYVl/wsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYI4B3hTMgQLSIRTj0GBdYFDgyiHNYw3hASDFj4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMENwGER4c2Ah4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECgQYThWwNglwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAkdrBBkBAREmA?=
 =?us-ascii?q?S4BBQImAl4BEgIBAYJ8gisBAzEHrjZ/M4EBggkBAQavWB8sIlaBYAmBGi4Bi?=
 =?us-ascii?q?BoBhWeDQYEhD4FVRIEVJwuCQAdviB6CaIkdBzKCHINQkV99BUFwGwMHA38PK?=
 =?us-ascii?q?wcEMCIGCRQtIwZQBCghCRMSQIMvCn4/Dw4Rgj5hNhlIglgVDDQERnUQKgQUF?=
 =?us-ascii?q?4EObhsSHjcREAUSDQMIdB0CMjwDBQMEMwodCyEFVgNCBkkLAwIaBQMDBIEwB?=
 =?us-ascii?q?Q0aAhAsJwMDEkkCEBQDOwMDBgMKMQMwVUQMUANpHzIJPA8MGgIbHg0nIwIsQ?=
 =?us-ascii?q?gMRBRACFgMkFgQ2EQkLKAMsBjgCEgwGBgldJgcPCQQlAwgEAyspAyN0EQMEC?=
 =?us-ascii?q?gMUBwsHUQMBCwMZKx1AAgELbT01BgMLGwY+AqZTexOCdpMDgxeMJ6JANAeCN?=
 =?us-ascii?q?IFggWEMnysGEy+XJg4GklMBLodQkE8gqEaBeSeBWTMaJIM2TwMZD44gDBYWg?=
 =?us-ascii?q?3OPCQE9QDU7AgcLAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
 hGe3SROci4AWqhyyhqF3lwwMaKMwnC5u4M=
IronPort-Data: A9a23:dVbjBKLdibuckbuFFE+RtJAlxSXFcZb7ZxGr2PjKsXjdYENS1DAHz
 GFNXmzTPq3cMWWgf94kPNvko09Sup6EydFhT1Ad+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6j+fSLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWBfgf5s9JIGjhMsfna8kk15K6aVA4w5zTSW9gb5DcyqFFOVPrzFYnpR1PkT49dGPKNR
 uqr5NlVKUuEl/uFIorNfofTKiXmcJaKVeS9oiY+t5yZv/R3jndaPpDXmxYrQRw/Zz2hx7idw
 TjW3HC6YV9B0qbkwIzxX/TEes3X0GIvFLLveBCCXcKvI0Luf1K9/dVPAHANHIAS37xPBSZ89
 qZbJ2VYBvyDr7reLLOTT+5xmoI8IcOtMI53VnNIl2iDS6x8HtaaHOOTvLe03x9o7ixKNdPXf
 ckEcnxCaBraYhtAEkgaAtQykY9Eg1GmL2YH9AzM/PVfD277lhRI/JPxEsTsYueAGf5tkR2Uo
 2PN1jGsav0dHJnFodafyVqngeTEnAvgSYcKHfu58ORriRud3AQu5AY+UFymvb+mh0T4V983x
 1EoxxfCZJMarCSDJuQRlTXhyJJdlk9CBYhjAKch5RuTy6HZxQ+cCyJWBnRCcdEq/ot+DzAjy
 lbDzZujCC1NoY+lbyuX1o6VijeuZgkTD2sJPhEfQSU/vtLMnYAUjzD0dOhFLpKbtNPONA/V/
 yGrtwk73rUast4K3f60/HfBmDOdmaLKRQ8UuCTSB3yp3jpkaNSbZqit01z67OlBHqmdXFKur
 HgJoOnAzeEsXLWmtj2Bf/UJJ56tv826CTz7hUV9OrUQ7BG/0ieHUaEJxx8mP2ZvEMIPWQGxU
 X/poQkLuaNiZiq7X5F4c6eaKpoMz5G5Mf/HS/qNTN5FQqYpRT+95Cs0OHKhhTH8onMNz5M6F
 4yQK/u3LHAgDq9i8jq6asEd3ZIvxQE83Wnjfo/6/Tv2zYuhYGOpdpldPGusduwZ6Ia2kDfR+
 ftbNOqIzEx7e8/6aS/174USDA4rKV4WOJPIkPFUJ9WzeldeJGIcCvHq0ewAfa5hlP9rjevmx
 Cy2dXJZ71vdvkf5Dzu2REptU57VZqYnn0kHZXQtGX2Kx0kcZZ2e6fZDVpkvIpgi2u9R7d91a
 PgnIPe/I+l9ZQnG3x8/bpDNipNoWzr2pACJPgujOCMeebw5TSP329bURCnd3whQMTiSqu0Fv
 KyG6gPXZbEhVjZSJp/aR9z3xmzgoEVHvvx5WnX5B+V6eWLuwdBMEDPwhPpmGPM8A0zP6RXC3
 jnHHCpCg/fGprI019z7haqkiYONOMkmF2p4G1jr15qHBRP4zEGCn7AZCP2peArDXlza4K+hP
 OVZ78/tOc09wWpljdBOLKZJ/4kfuf3UuL5o/iZ1Fi7qbnOqKI9aDFuo4M1tjpBJl5hl4VaYe
 0TX4dRLG6S7COW8Gn4rGQcVROCi1/YVpzrs0coIMHjKvBFQwr7WfnhRbj+tiTNcJoRbKIkK4
 /ksk+9I5h2diigFCMenjCdV+z6yL1gFaaEGt44bMqDvmAEE2lFPWr2CKy7UsbWkScRADVkuG
 RCQ3JH9vrV7wlHQVlYODl3P4LZtvosPsxV001MyHVSFtd7bjPsR3hcK0zAIYilK7xdAicRfB
 3NKMhBrGKCw4DtYvshPcGSyEQVnBhfC2EjQyUMMpVLJXXuTSW3BA20sC9mjpHlD3TpnQQFa2
 7WExELOczXgJpjx1xRvf39VkaXoSNgp+zDSnMyiId++IKA7RjjYmY6rW3sDrkr2IME2hXCfn
 9JQwsRLVfTZOxIT8ooBMKvL5YRIHVrAbCZHTOp69awEIXDEdXvgkXKSIkS2YYVWK+aM7Ua8D
 Nd0K9lSUwilkhyDtS0fGbVGNooccCTFPzbeUuiDya86X7qjQv5BtZXN6m7hiWVtT9gGfQPR7
 G/OX2rqL4BSrSI8d6zxQA1sJWeyJ9UJDOE59P7g6/0HTvrvr8k1GXzfEdKIU7G9LwZtuR6Z1
 O8Gi2k60MQ6oblRc0DQ/mmvyul6xR4flAhFzexrj+lzUA==
IronPort-HdrOrdr: A9a23:YBQQOK3b8XVJjARFEENSGgqjBGokLtp133Aq2lEZdPWaSL37qy
 ncppQmPHjP+VAssRAb6Le90cy7Kk80mqQb3WB8B8bGYOCEggWVxeNZgbcKqgeIc0DDH4VmpM
 NdmsZFeb7NJGRbyeDn/QK/D9Es+9Wf9ru07N2utEuFATsKV0l6hT0Jczpz/3cGPDWvjvcCfq
 ah2g==
X-Talos-CUID: =?us-ascii?q?9a23=3Aav6GCGobAivrkE84jEDYJDbmUcwMI0P97XvhGG6?=
 =?us-ascii?q?1A0MzcLnSe1zKu6wxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AubugJg1KQlwJmYZk7lyWGLK/LDUjubyXJGsRs4s?=
 =?us-ascii?q?/o/KOaRdINGyRiTW8a9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,296,1695679200"; 
   d="scan'208";a="143746117"
X-MGA-submission: =?us-ascii?q?MDEeZoDYZOPjPLmbw2ZjxFEJ8SQcvpgdUTJBpY?=
 =?us-ascii?q?MPTfakBcEAIJ0f7PuxR2SdifpLeCVLzcBcHeBXeSqNf1kJL1b4yr3fL/?=
 =?us-ascii?q?ltsRFozpw+98FgdELz9RZpNKq8deh5auwvvuPlLigzCCogXQcSo3qfir?=
 =?us-ascii?q?+62+BRYSUCAEBuHZSmngkloQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 13:03:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703246590; x=1703851390; i=markus.elfring@web.de;
	bh=+/jv+l30EGrAi9nYpLc4XLLYanHvltsf8lsVWJ+WBq8=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=G2BJGfNcZ5Dwi+GePNcsGfk9kf3cmYpUjdmzlUiup2V04tmzmrdaJE+HKtaTFDmy
	 C9iQp9rfhg2NQYHKZNgQPYZKwe2sjR/XOQ9ff5sUMWBk4s8JtFtxWTOhJ2cqublPK
	 Wzq5t9CQvJ7v6pb7gHoEv98ynTWEIBkX2FKA0XaFms5dxCldwO6SOcKV/rqtqJIoy
	 udnlc46e/2LZfWsyFyN/33aw7qhyWFuMuPBXEfX/qfXLk4IQfqBorrbtyS9e7qEII
	 S66iJC+xMmqwbX+gmL99MI0S0BJDZDilZ7LZFc6BL33RLf4/0yKhNtkIHk6jOwGnR
	 u9rnlK7rGD14fPUG8Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYcpt-1rlbDS3zIx-00Vn85; Fri, 22
 Dec 2023 13:03:10 +0100
Message-ID: <01446ce9-c0e8-4467-8b2d-fd736bc5b8e4@web.de>
Date: Fri, 22 Dec 2023 13:03:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Abel Vesa <abelvesa@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, kernel@pengutronix.de, linux-imx@nxp.com,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Kuan-Wei Chiu <visitorckw@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BGjso6szF5OPPe6YkYQSGx3cbiFicSuxRzUDu9gXysZ9LBV5Tvq
 Z6cTffdqrv7UHIX6aoglrjMVMIeKP5pSDKLNvjntsxJd+mL17ws3IVG0GKYnF+pS6T67QvK
 gr8PeMjPqAqlHHGSTj0e9Sv+JKROzNQdbR0YdGn46YScqYKsul9MgsPDHwT9q9FqJxmvmSL
 MRCmKAbKnhmhhobSBf3Qg==
UI-OutboundReport: notjunk:1;M01:P0:C43S6QqDGms=;1AS+ngQDUXyBJhSI0PdTlWudgJL
 JisRmg3aLdq7ySUByZXyBe5ukinU/bozc+P/qge5y9ew5GD6hXlSanaVebEhIvK5moYeqaAyN
 jARiNJ8NQcxgL5JRcanHezbbpdhQauCgEfaO15WtywBI9L6/x2zhjYMhCJZzZTGtzt9a8aA+c
 IzsU18Tsew5MQZ1kKLmcWE5KK9WraLVAaOCzV2j4dd1SrfPHO1I+7LKYNX54eH3wjRgEokM0H
 cltYoCZ/ZQOINV0WjgYBJnK/41T4yBXRlY/jG+hffHdGCBp58di5Wm5Mnsa6yEDzezhx5g42o
 e+aVZlXPZCR5WFBKCiZc92bFrPTkLl8SMmS28l1/SzImDcxjIEAlJoj3cvZefNyesWt+d9YE8
 SY5xhEQKB9nKAbgbNhzXYxk1WqcgphKaXKwO5XPH6wjwBDqYA8L6dqh+9q2WzuMLMqLgevj+l
 guU5+wrpnwYus5cVqXlg602wFAg7k2EHbcCppeGzUxvSqJh5OhZNj1AE06NFw8aotxiljQkyp
 Ai3M13CeYSk3YtkA7oYLnsDxuyZlUa3QkTjHHRBkgv9ZOczKaCy0HLAhFGP+KHmjX1VJ+u2Bc
 SipmOzNgd0gKQog7Fb3Pp9SbjRWzuYe6B25KYb+Lgur8f82pJMzYzQ3c0NAyIP9bKenH/TWM8
 s4GEvRZlmLm/KqBNUsipS8f/JyLhHrlG1uQ+VEH1uMV+p+1MyLAXet8Fqo1kRaWhfXKKvKJgj
 a611lmi/E2kcO1J+mdPHaXo8EWR2fnD51ntCoonYMheu83cySK/J2XsB15IgGEeW1omMY1IZb
 rETu2YO1m6n3HTBmNc0u662Krt0AITpVXxvFAI6IuGxTSMcqKXAKU72osSR4sq4jARRe0qfi9
 qixcAizdkwON+ZXaKKztKXHISzLcATiSZzVAZfqyDIpoixdbaIltFsZpdU27izUtjh8ylcGkq
 JgjelfK58dYaRUc0BOsYkU4sjiU=
Subject: [cocci] [PATCH] clk: imx: scu: Use common error handling code in
 imx_clk_scu_alloc_dev()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1359
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/01446ce9-c0e8-4467-8b2d-fd736bc5b8e4%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 22 Dec 2023 12:56:48 +0100

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/imx/clk-scu.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index e48a904c0013..b1dd0c08e091 100644
=2D-- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -712,17 +712,13 @@ struct clk_hw *imx_clk_scu_alloc_dev(const char *nam=
e,
 	}

 	ret =3D platform_device_add_data(pdev, &clk, sizeof(clk));
-	if (ret) {
-		platform_device_put(pdev);
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		goto put_device;

 	ret =3D driver_set_override(&pdev->dev, &pdev->driver_override,
 				  "imx-scu-clk", strlen("imx-scu-clk"));
-	if (ret) {
-		platform_device_put(pdev);
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		goto put_device;

 	ret =3D imx_clk_scu_attach_pd(&pdev->dev, rsrc_id);
 	if (ret)
@@ -730,13 +726,15 @@ struct clk_hw *imx_clk_scu_alloc_dev(const char *nam=
e,
 			name, ret);

 	ret =3D platform_device_add(pdev);
-	if (ret) {
-		platform_device_put(pdev);
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		goto put_device;

 	/* For API backwards compatiblilty, simply return NULL for success */
 	return NULL;
+
+put_device:
+	platform_device_put(pdev);
+	return ERR_PTR(ret);
 }

 void imx_clk_scu_unregister(void)
=2D-
2.43.0

