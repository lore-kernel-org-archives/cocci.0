Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D8AC41535
	for <cocci@archiver.kernel.org>; Fri, 22 Dec 2023 09:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=CJB6+ksANUoJz+D1yNOe50ESu3JvTpm1Ijm8PAHeE5k=;
  b=iMn2Qs8D7n1XhTj56cnuYnIaqwPEILFtPFvN+WWf2MBuq3Vpoy+J2q++
   qymZqpweqO3HnZBbB+DxCxFemZPfWUSH2Mp8xZodU6N3763DWJNCOt/Tb
   IWy4U2VzPMrnwAkfCKwYOUYLaoixMtZP1SKJJyJCom09Es3/lu2fnV0mN
   o=;
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
   d="scan'208";a="143707221"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Dec 2023 10:23:37 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6ACD9E0CCE; Fri, 22 Dec 2023 10:23:36 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A67B4E004E
	for <cocci@sympa.inria.fr>; Fri, 22 Dec 2023 10:23:28 +0100 (CET)
IronPort-SDR: 65855592_KG0h8/QmC9ucY9ehO7dIS/GQZXG6R0xjl6j+kwTEd9SgAeL
 1uxwnZdJOTc+OmzaxLurkukQY1joxWaHbdaOd4A==
X-IPAS-Result: =?us-ascii?q?A0EvAAALVIVl/07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4B3hTMgQLSIRTiB2HJIF1MIQ7hzWHTIRrhASBVoFAPg8BAwENQ?=
 =?us-ascii?q?QECBAEBAwQ4hEcChzQCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQKBBhOFbA2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR0IGI?=
 =?us-ascii?q?wQZAQERJgEPHwEFAiYCAlYGARICAQGCfIIrAQMxB65wfzOBAYIJAQEGr1gfL?=
 =?us-ascii?q?CJWgWAJgRouAYgaAYVng0F6Jw+BVUSBFSeCUm+IHoJoiR0HMoIcg1CSB30FQ?=
 =?us-ascii?q?XAbAwcDfw8rBwQwIgYJFC0jBlAEKCEJExJAgV2BUgp+Pw8OEYI+YTYZSIJYF?=
 =?us-ascii?q?Qw0BEZ1ECoEFBeBDm4bEh43ERAXDQMIdB0CMjwDBQMEMwodCyEFVgNCBkkLA?=
 =?us-ascii?q?wIaBQMDBIEwBQ0aAhAsJwMDEkkCEBQDOwMDBgMKMQMwVUQMTwNpHzIJPA8MG?=
 =?us-ascii?q?gIbHg0nIwIsQgMRBRACFgMkFgQ2EQkLKAMsBjgCEgwGBgldJgcPCQQlAwgEA?=
 =?us-ascii?q?yspAyN2EQMECgMUBwsHZQMDCiILAxkrHUACAQttPTUGAwsbBj4Cpn57E3KCB?=
 =?us-ascii?q?JJ7AY9FokA0B4I0gWCBYQyfKwYTL5cmDgaSUwEuh1CQTyCoRoFjPYFZMxokg?=
 =?us-ascii?q?zZPAxkPjiCEK48JAT1ANTsCBwsBAQMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
 hGe3SROci4AWqhyyhqF3lwwMaKMwnC5u4M=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:og59I6PuoWBcEMBcTsWjsMiBIKoaSvp037BN7TEWdfU1SL3+qy
 nKpp4mPHDP6Qr5NEtOpTniAtjjfZq/z+8Q3WB5B97LMDUO3lHYT72KhbGI/9SKIUPDH4BmtZ
 uII5ISNDWzZWIK6PrH3A==
X-Talos-CUID: =?us-ascii?q?9a23=3AEBd1qGhlKtdN620t9XqXxwG5tTJudFb/3HfUIUC?=
 =?us-ascii?q?BJmdTbZK0SUeq87pcup87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AfiXAHw/d6Oj2kSeiEpwA842Qf+ptzPmMEVIiq9Y?=
 =?us-ascii?q?Xsfeoawdbag+6syviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,296,1695679200"; 
   d="scan'208";a="143707193"
X-MGA-submission: =?us-ascii?q?MDGAVfnJDdn52+3NkJ45Nkyd3LGHRiQVsgIqzN?=
 =?us-ascii?q?xkFn9iO+tqA6yrTR6HuZFvLWK/ffxMxIwO2msYJS+QdsgSMi0F5opeRF?=
 =?us-ascii?q?ScX42WjTvVKmSUJ3k/BeGJKBsJJOwpTnPmL3S7rwUBx1CDT5lioMqCKJ?=
 =?us-ascii?q?Xgw3QeAzJ0wSRqCOHqxnEMGg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 10:23:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703236995; x=1703841795; i=markus.elfring@web.de;
	bh=3ig45DHXiib9kb5XvzHMPJQLjNR+DPC4+AqNcZPSRqU=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=TtPklQtkl8+oC25Zf6mbd5TyMgo+6lOKU0OQ6BPWEXukGcGhAXOsA2ujSMIG/Gap
	 0FjgjScqL6XlK4aTVnaZ3HJHxRZL1aQsjq823KBj8V91BGqSR1LjzMCqrL6/2et+8
	 8C8s+MlA3/d5BFFoRC67FqXKoQNXhHKlEk/d2kAn+xFrqfFkzBo/8AR3PF3FlETlJ
	 woXXx67SuJbhvZELQHW62xpEIZLkBVJ3+qx6QwKbhB1PqifE/yC6Kq4i7xceVXgG0
	 X8LxdwPsXOIqB60V6Zl8O6AKnnj6wJnHsgviuBOYQ/yTm8XoPX25SZflNmBJ3S3NK
	 mnVgOzkuBZcCKFkc0w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYu1C-1rlM3f2aSe-00VDQ7; Fri, 22
 Dec 2023 10:23:15 +0100
Message-ID: <0e906ec6-fe73-4dbd-b555-a2c03b6e1030@web.de>
Date: Fri, 22 Dec 2023 10:23:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kuan-Wei Chiu <visitorckw@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
 Fabio Estevam <festevam@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, kernel@pengutronix.de, linux-imx@nxp.com,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <20231210171907.3410922-1-visitorckw@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20231210171907.3410922-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bbmJkcNnDotFtiTs26dlJsi1vk2huEHcKia+9MBq1a39yWTPgMS
 jxhFdyB5D51I7V2INVG9+gNjPJfG3zdMnWzRIcEGYjtCXTTONE0KJFmWATS5l+g4+RrFe6t
 DKdM+bHpWvYpqx44h6Wp9m6v153RG55/R0H/TVxNvJ+j2z+15+3ZnVwS2zp+LQsm4Cnl4xp
 h2vs1+itu0+fUskgWwFQw==
UI-OutboundReport: notjunk:1;M01:P0:zIfadAQeSq0=;U6exYvAg99UQJpr3sFbuqp6wy5Y
 CzjzhyjdOylHww44g9D/ghe4CCwUAJ8X4Qrp+cOuxiGcvCMon3Z3NT+OchSlMoBNgl7S1w/bT
 w21jCQqNaSib2HSsOVCmrtMqmCV5XSbdKUPpc/vDoO8/liVbmrC5RK5r9oiygrPVhQ/4Smu4R
 2E4/sTzLKZxxdgi2Q3OhKc/Qjq8RNnBc+xkfFTL/ELmNXQYe4cl9sPBXnfrgNun6VdZ7DFCFD
 sgrnOPBDY6x5LuumfxDBv79iIebR/OEjqIsNWc32xt+xBRQft4QxPT1kK/XjsJXqQo9q5V15s
 mMeEcee8BfcruREOc8JOQUi1OFu/YJMbgNL9Qn/g4Q948GnL+PPUO45LhWbBMiefoO59AwTuz
 +OUd5WRPfKpQobxz2X8VA8r+7vSkHZEx8eoIBRhJEazt/q7Y2rsW1MSKOimfOhCSBvxLSpyPq
 69Iga/Ok0uZ0hwf6+bsJksn1VT1CJvgp7s9lbbvEhSkqnmUpZBiZ0wegh7EAxE9vVB5/eGKnb
 zcqunlyunsIgHCMgIpTw3Q04GCzTSnUQUTC6UZpv6G7ob8ABWv/j04NCRfc/+hGrianQEe8rn
 ON5sYyyGZi6BYrg7rodUEw0FNKKfxSIp2W5ZZxWNALPzbc8G4uyjT55x4kiuImWAJ/TJls++r
 ghulBoXWNBFC3X+kKOW8/Zb0OV+CUnjLFsewyKU07UqjXSQ6OwsQ7nZQvRFdPUAzFQ04HFbsW
 8reCagSpVVsaHYOLOsNLL+L1uiQIDjDfKnceKE+cFZy0n18xSkgyEzBIEUw/AHSEROeECcAVZ
 9wBStI85eq529BwxCNeu6ljkQCebwd1cQLB669/DS8SvWZRj5GNVkqvETh68RuCEojcD78eJx
 LzVzBSh3bdLaVbgU2BU8zp2Z/aqsi14cTVHCSmqbZ/XfQ4uEmOpdDsuFTaBcu8sNYCd5q5Zo8
 NfNhaQ==
Subject: [cocci] [PATCH] clk: imx: scu: Use common error handling code in
 __imx_clk_gpr_scu()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1358
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/0e906ec6-fe73-4dbd-b555-a2c03b6e1030%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 22 Dec 2023 10:05:32 +0100

Use another label so that a bit of exception handling can be better reused
at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/imx/clk-scu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index e48a904c0013..4ca9dccf3d3b 100644
=2D-- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -882,19 +882,19 @@ struct clk_hw *__imx_clk_gpr_scu(const char *name, c=
onst char * const *parent_na
 		return ERR_PTR(-ENOMEM);

 	if (!imx_scu_clk_is_valid(rsrc_id)) {
-		kfree(clk_node);
-		return ERR_PTR(-EINVAL);
+		ret =3D -EINVAL;
+		goto free_clk_node;
 	}

 	if (!imx_clk_is_resource_owned(rsrc_id)) {
-		kfree(clk_node);
-		return NULL;
+		ret =3D 0;
+		goto free_clk_node;
 	}

 	clk =3D kzalloc(sizeof(*clk), GFP_KERNEL);
 	if (!clk) {
-		kfree(clk_node);
-		return ERR_PTR(-ENOMEM);
+		ret =3D -ENOMEM;
+		goto free_clk_node;
 	}

 	clk->rsrc_id =3D rsrc_id;
@@ -922,6 +922,7 @@ struct clk_hw *__imx_clk_gpr_scu(const char *name, con=
st char * const *parent_na
 	ret =3D clk_hw_register(NULL, hw);
 	if (ret) {
 		kfree(clk);
+free_clk_node:
 		kfree(clk_node);
 		hw =3D ERR_PTR(ret);
 	} else {
=2D-
2.43.0

