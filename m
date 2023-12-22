Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C7BC41535
	for <cocci@archiver.kernel.org>; Fri, 22 Dec 2023 16:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=3h5e3Rjcx8AcqioVhPpjUHXzXpXJC/eyHEDiLizKzSA=;
  b=tpQXVMBpj3G3FcgZInHPX+IvD79zursUl7PU7VbfIygWxw1XYSvvovkn
   ZQLOg9az07vjFTiFdkfiwmSL+PsmAybSOABSFnkN5cbB+4Zar7e/RIT4n
   kxI+gJV3KTweJJoxQfrs8oolKwPUk0ybZzrV4NOpRWZvdxa8CLKRToc+B
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
X-IronPort-AV: E=Sophos;i="6.04,297,1695679200"; 
   d="scan'208";a="143797896"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Dec 2023 17:36:12 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 90223E0CCE; Fri, 22 Dec 2023 17:36:12 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0C5D8E004E
	for <cocci@sympa.inria.fr>; Fri, 22 Dec 2023 17:36:09 +0100 (CET)
IronPort-SDR: 6585baf9_ZfsNjhpoKmTLATe5lLuIfO+Q0UBj9vvwqVbI/MB37pfwAuw
 5HunpWJs57FfXpiWqxgjcnRPf2saeOOB6rQlB0Q==
X-IPAS-Result: =?us-ascii?q?A0EmAABMuoVl/wwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4B3hTMgQLSIRTiB2HJIIlhDuHNYw3hASBVoFAPg8BAwENQQECB?=
 =?us-ascii?q?AEBAwQ4hEcChzQCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQKBBhOFbA2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR0IGIwQZA?=
 =?us-ascii?q?QERJgEPHwEFAh8HAgJWBgESAgEBgnyCKwEDMQeuen8zgQGCCQEBBq9YHywiV?=
 =?us-ascii?q?oFgCYEaLgGIGgGFZ4NBeicPgVVEgTwLgzaIHoJoiR0HMoIcg1CRYH0FQXAbA?=
 =?us-ascii?q?wcDfw8rBwQwIgYJFC0jBlAEKCEJExJAgV2BUgp+Pw8OEYI+IgI9NhlIglgVD?=
 =?us-ascii?q?DQERnUQKgQUF4EObhsSHjcREAUSDQMIdB0CMjwDBQMEMwodCyEFVgNCBkkLA?=
 =?us-ascii?q?wIaBQMDBIEwBQ0aAhAsJwMDEkkCEBQDOwMDBgMKMQMwVUQMUANpHzIJPA8MG?=
 =?us-ascii?q?gIbHg0nIwIsQgMRBRACFgMkFgQ2EQkLKAMsBjgCEgwGBgldJgcPCQQlAwgEA?=
 =?us-ascii?q?yspAyN0EQMECgMUBwsHUQMBDgMZKx1AAgELbT01BgMLGwY+AqZVexOCdqJBo?=
 =?us-ascii?q?kA0B4I0gWCBYQyfKwYTL5cmDgaSVC6HUJBPIKhGgWM9gVkzGiSDNk8DGQ+OI?=
 =?us-ascii?q?DiDc48JAT1ANTsCBwEKAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
 gGI3TdOKjFkvxsCp/V36gUiNu7Gwy+yi9Z+
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:YaJcxq6N4pVkrsEV2APXwBzXdLJyesId70hD6qm+c20wTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhX4tKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkYNDSaNzhHZKjBkWyFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3AR62mr2hnK+BlMCfwPckx3NTPzDJuI3zFwWyXCmK?=
 =?us-ascii?q?DI1lmaIGFZU+2oqBKjJ87?=
X-Talos-MUID: 9a23:oOY1CQkozxqjLWs/h3/kdno7PcEy47mgUHlWlJMc5ZWfPh5RECek2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,297,1695679200"; 
   d="scan'208";a="143797865"
X-MGA-submission: =?us-ascii?q?MDG//QsMNsmWwEBLlY7qKHv/SKRqfIjYVUssVD?=
 =?us-ascii?q?r/iHZm2BDjSpH+CZZpGcAP5+gWRilJ1y6GmY/llonQjuubAvbIO6I0fM?=
 =?us-ascii?q?Xmscukh9ekv4xAtf710FsuBBgJUM1R1vWSLtjQrO2Xsy1zqnOfcKGygi?=
 =?us-ascii?q?7ZCZI7KX/sljXwWr5Xewcfmg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 17:36:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703262954; x=1703867754; i=markus.elfring@web.de;
	bh=hGP8tPk4MgeQkC4qAQyOA8Ei+y7T+/UNmzFqrcccYrE=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=lDIg7aRDDh34j6zbkdf6CqgXZBbESv7YKB2zqIgdiqT+uNNk8lY+hHNWweK2m1bO
	 qz3APVm7iQlKX1IuG++i09NKEGz1o4/pNGa9317fvWM5jSt6hOEXFuR/B5C0G6Lh8
	 PKfNHa0kfs4S7GJVhqVKZiZ3q4xRb6+xGm9jBn35DXMSGf5dY0xwsN8pJRjeWYzdN
	 MIfWmq/Ep5dWOLm5TK+y2gVWWoUZsPZYnqBsfIUazWw4SkGzMABoQsusNkl8dEZQb
	 D0zEAeDH43DGeZPZAv4UDIsHfg9PWM+WE4dgW04SMkV+UpgFioVrF3tXxWvfjjLax
	 DKY4+Hx54IdGSoEnNw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCol0-1rPTvW2oIC-009Ilg; Fri, 22
 Dec 2023 17:35:54 +0100
Message-ID: <147ca1e6-69f3-4586-b5b3-b69f9574a862@web.de>
Date: Fri, 22 Dec 2023 17:35:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: Abel Vesa <abelvesa@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, kernel@pengutronix.de, linux-imx@nxp.com,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <1d494176-2238-4430-bc26-4e4c78fe4ede@web.de>
In-Reply-To: <1d494176-2238-4430-bc26-4e4c78fe4ede@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0VWpmmx7o1yt73QWfIGaaqlY5F4i6zRgEqXuglALwGa18bIXKW8
 AOqDAUNW2Cjsz06QxmYHDoTBLM99qSfkA8gpV2Eep67T8N2XvumNoBvMSDZL+MVcICEknKr
 8vh3ggCJemhW9bVcaXt9ybA+0LXlevWtdmdzBDNCUp3uslBto9tV0ddzLPIX7kIkd/LqhoU
 t1UQ7qde2xsX9YWyhSWCw==
UI-OutboundReport: notjunk:1;M01:P0:uXnSM6Y3y2Y=;ZqW32hB+ptk2kYuDiM61wjVdQAm
 aL3BOWuDVDmj/GqfYIOBsNosFuxpsJAIF76ShhehyftRzyOf6yL5ej9V0Osq5eHdjvPbL0pYW
 69y+VjNrOqLWmgi8elxKtmmlmx2dxH/kBvOYeSQQyqTyApK+rRRDlDgHwMO3kqzTgV0c19G3i
 HG2/5wIgQ1cUJmr8cQgqiMMR0nuYspFk6UVN3jJxiwBMMu+8AoPykeq7CGp+pfgJhms/Lm8oX
 PvssBnTr/X2ml35RXgK+pjW4l7Zl0GBgnl+sRv3M7pqhxkVPWWBY2+C9h6TtiOMjTJqhHDBYG
 hIs7zhMy4fLuwOKu0oX+KvqhLhvE2SlDuelguWgy8fCKlHIId/35lrgiu7WG0vGKv+Hil8cR+
 l6vXjvpd6HKf8Klc6mUWg5SZjOB5QAe9Tsj5ip9+QWO46DNN6cPySxaXWL2f3I5euzw0QJjhV
 wCFqGq4oqy81Byb9nRUx6EVd1eQooS1AVRGrNf+elEl7N2nvPQxaeb1OGAzvRLl6t3bAFDb/0
 JRtMWEgE59ziYYefEjIvex4DDgnx03Js86TG52IqI334FvTtp6RIK28Mkyo+dSfVsWIYp1Ow0
 B4j1Z2RuLe4LwY0V4+hylU5M2QwFOCejlk7YSWydaSxEVKHBW/1CtLzYpRPjcOPESYxNCF5S1
 +tyyF45iz0PlFvaz8QFSDuoqVGr9Zf8hfhMHXYw8qUglcG5B8Lfq5HPjk2npQoH+8+tIdptms
 HQIebkSco+YYHh3fCZOlKQWNcgNcvN6cV90LjKZWrmxmcxvknesnwFKQxbk/sROz9zoTcWOsV
 tbXYC+SuKi7RtOwpVWGF8bafesB3iRctdCLylup3wAFM2U4vMKNB0lDKbhn+eNjTdKjlE1kUV
 7urRWbSX7kOfqglzfS3fNXVmV1pAmiU1nUpqYQ7ROr7xEBJ5eEPH2Ju8SQ9SdFA6hqC+EI6D4
 I4p6rw==
Subject: [cocci] [PATCH 1/2] clk: imx: composite-8m: Less function calls in
 __imx8m_clk_hw_composite() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1361
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/147ca1e6-69f3-4586-b5b3-b69f9574a862%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 22 Dec 2023 16:48:24 +0100

The function =E2=80=9Ckfree=E2=80=9D was called in up to three cases
by the function =E2=80=9C__imx8m_clk_hw_composite=E2=80=9D during error ha=
ndling
even if the passed variables contained a null pointer.

Adjust jump targets according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/imx/clk-composite-8m.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-comp=
osite-8m.c
index 27a08c50ac1d..eb5392f7a257 100644
=2D-- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -220,7 +220,7 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *na=
me,

 	mux =3D kzalloc(sizeof(*mux), GFP_KERNEL);
 	if (!mux)
-		goto fail;
+		return ERR_CAST(hw);

 	mux_hw =3D &mux->hw;
 	mux->reg =3D reg;
@@ -230,7 +230,7 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *na=
me,

 	div =3D kzalloc(sizeof(*div), GFP_KERNEL);
 	if (!div)
-		goto fail;
+		goto free_mux;

 	div_hw =3D &div->hw;
 	div->reg =3D reg;
@@ -260,7 +260,7 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *na=
me,
 	if (!mcore_booted) {
 		gate =3D kzalloc(sizeof(*gate), GFP_KERNEL);
 		if (!gate)
-			goto fail;
+			goto free_div;

 		gate_hw =3D &gate->hw;
 		gate->reg =3D reg;
@@ -272,13 +272,15 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *=
name,
 			mux_hw, mux_ops, div_hw,
 			divider_ops, gate_hw, &clk_gate_ops, flags);
 	if (IS_ERR(hw))
-		goto fail;
+		goto free_gate;

 	return hw;

-fail:
+free_gate:
 	kfree(gate);
+free_div:
 	kfree(div);
+free_mux:
 	kfree(mux);
 	return ERR_CAST(hw);
 }
=2D-
2.43.0

