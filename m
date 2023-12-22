Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9510DC46CD4
	for <cocci@archiver.kernel.org>; Fri, 22 Dec 2023 16:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6w2QoILX7JeDhO3Qvr6hg2L7YBAxrRiIGGI0PsDQ4eY=;
  b=tj4uf+ZazD7vxsacRQClC4NTLxg4KFlLlPUg1jfAgLflQnEZIub9pjTF
   i2oWo5TsObLT2k/NnhxrfypSN+994BHS7LO5DEAgh2iC3udRoJGKItIKA
   gVL0IMkbuDg3hnXWa/16b9V2txCkK8JDock03C+jGI3oynWiFo3Swdvaw
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
   d="scan'208";a="143798203"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Dec 2023 17:37:56 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A6519E0CCE; Fri, 22 Dec 2023 17:37:56 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 463EFE0AF1
	for <cocci@sympa.inria.fr>; Fri, 22 Dec 2023 17:37:54 +0100 (CET)
IronPort-SDR: 6585bb61_oHa9ZX60xjzVqCg71FfSLLudRD/cHs9AuNiX4OpqDM5C8D2
 lWp2163R44MG3vScz4YJ8W1tHosgPWLvSL1753w==
X-IPAS-Result: =?us-ascii?q?A0EiAABMuoVlfQsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4f1MyBAtIhFOIHYckgiWEO4c1h0yEa4QEgVaBQD4PAQMBDUEBA?=
 =?us-ascii?q?gQBAQMEOIRHAoc0Ah4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBJBgGDhAnhWwNglwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXA?=
 =?us-ascii?q?kdCAwMjHQEBESYBDx8BBQIfBwICVgYBEgIBAYJ8gisBAzEHrnqBMoEBggkBA?=
 =?us-ascii?q?QavWB8sIlaBYAmBGi4BiBoBhWeDQXonD4FVRIEVJwuDNogegmiJHQcyghyDU?=
 =?us-ascii?q?JFgfQVBcBsDBwN/DysHBDAiBgkULSMGUAQoIQkTEkCBXYFSCn4/Dw4Rgj4iA?=
 =?us-ascii?q?j02GUiCWBUMNARGdRAqBBQXgQ5uGxIeNxEQFw0DCHQdAjI8AwUDBDMKHQshB?=
 =?us-ascii?q?VYDQgZJCwMCGgUDAwSBMAUNGgIQLCcDAxJJAhAUAzsDAwYDCjEDMFVEDFADa?=
 =?us-ascii?q?R8yCTwPDBoCGx4NJyMCLEIDEQUQAhYDJBYENhEJCygDLAY4AhIMBgYJXSYHD?=
 =?us-ascii?q?wkEJQMIBAMrKQMjdBEDBAoDFAcLB1EDAQ4DGSsdQAIBC209NQYDCxsGPgKmV?=
 =?us-ascii?q?YEOgnaiQaJANAeCNIFggWEMnysGEy+XJg4GklQuh1CLAIVPIKhGgWM6gVwzG?=
 =?us-ascii?q?iSDNk8DGQ+OIDiDc48JAT1ANTsCBwsBAQMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
 e2qnjxeZC4TWvBsrv84rivV3syfwiim37MRciiM
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:FPnTSKCAF/3TBZPlHel455DYdb4zR+YMi2TDGXoBLSC9Afbo9P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkOss1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFJSWY+eRMbEVt7ee3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3AYtJNHWlGp1i7Ykns5dpWKGJBeSvXOV/Cl03SBHf?=
 =?us-ascii?q?jMFlWZ4fSGAaLyrhHzcU7zg=3D=3D?=
X-Talos-MUID: 9a23:k5WFTwn71A0qNrJEdcZmdnozL81B/IigUHoQvqRFg86bF3ZKYA6S2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,297,1695679200"; 
   d="scan'208";a="75209899"
X-MGA-submission: =?us-ascii?q?MDHkjuwHRDDe9jtwgoD485aPv57jF+4X8LbeVt?=
 =?us-ascii?q?MBvgH1RQBGa5E679+b6xmOh7L53JQrA0MPn89vD0as4YB7IbbB7MeoU/?=
 =?us-ascii?q?94DYly3weF4bCXD6DAP9lq39+92hgYXTkYnHWA9DtqEvNh8VNI1fRMK0?=
 =?us-ascii?q?oY9WePJNwQ9SPxDvYwyODNwQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 17:37:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703263071; x=1703867871; i=markus.elfring@web.de;
	bh=v9wsO4hBMKaYP4jfM0OembEpsGFWQxtzsw3ZTzzqTD4=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=AKXU6OZLEN8VvHj8rNjOWKQyKiT0wyk1c4d7UmwymM6esWyG97jFAwalvuhYTx98
	 GeNBCXYHOnlMSH64LOXoHnXbhmFa8reXHRSfMsgBsm3RhXG43YP36oOKG18Q89B/C
	 m8NT+f8zdUDdBiU0j7HdKifjpS9VgXwpFf7Q7dztF5z5UlsRCZgQx/OP7u9Il8SJI
	 SLUoGRT9d2Tlgj70S9WUuetVelspUE9xv8PPgxd2CpCHQj4Sloz4y97agf+9Hv8t/
	 SVn30alM2FZlvDjgq5C6BnQbf5j4/C6vSIdL30gOtb/jGjXDyhpLjTJ+0GFOsJ6jy
	 yjNU/wb81xVNLP5yew==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXoYQ-1rmczK2fvQ-00YFjv; Fri, 22
 Dec 2023 17:37:50 +0100
Message-ID: <6604590e-d0f7-4798-a1b9-b2f474f3a642@web.de>
Date: Fri, 22 Dec 2023 17:37:49 +0100
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
X-Provags-ID: V03:K1:D+hRhIGTK8aStCOJ4/CTmR4XIynD0hvKNWsh/EXmXF5nGjX+fKy
 L1EIRb2Q/nJZKSH9LASVJyHGxATwbJMQKr4C8ZHDxTcdmoiwNBHHGD6dBHT++3Ige5U6L9J
 YbxrIKRvcckfvescYp7Sfekcy+soKVrs0KE++hlOa+MZVrmTMgtl3Mlkndhwn8/WJhM1FHd
 f0eySxAgXj3/ZW03A8HXw==
UI-OutboundReport: notjunk:1;M01:P0:SujinENInQQ=;w2IzoUAeX5pp8p2u84Zb/qKh2i9
 zBTq3+IRxhpwyqD4mK24y6zREu8WH/sj+rZdtGcnwAdw04meKlf4kqwF0Iae36C9otmkC6PSF
 6uH6/7WlQRROqsXja8ax4rV1WY+ps4vtTZty7Hg+LGQZC8VWiIkV/uLwwZWy5spzWEV/OtX5g
 c0LVw+Vcz4kgTKQsbIcUVu34PLFtGfT5XUw7QCQlHeXU0C+zGFSjpL63l4N6uWk94LXKGyl2U
 fJV95dcDIjAejovxCHXOQHzXwDC5KCiaQSiE9TytieEk253ulVOQwmJnKEry7CwLLNrBNa7AN
 NFxE88sF2K0OubysXPVdJg5osqmG5tYNpCHbyBFr9xN9wcvdF6puV/g9jbInLwVBEvp6aurfS
 epr1Rniscpo9OhUz+SHsGf9nZzrqUuzs/yw/0FwWfmm+n1ONwI4vkD/AO73Ws9u+lYgudGSDg
 mXujF8s3duJcI4dsj6GnE5lROfB6B7268S4NW5GeQkHJhIf0kBVTEee2MqMR+NhnH+lLyB+E+
 GbARBgokg9V0+cNh0TA3cxrKOCh48rJK10qd9QmHdcpBzWYtNfKzyWvvZI5vaibnDXZIf8g1Z
 C7+gVBolPfP65ESBfje7TFqR8VsxW3ueO0TrwICuqzDoeSSm/ge05WzFwJSYj3lecAznkTYs0
 GYsTXsAiK0+ex9/OmZgQwzXTf3r0v6nXjpvw2W//NVi2+pzy/ghLB7k/AIZvUYjK1DlAAYqFM
 JjGg3FukiwaajfbZHRQoyoziibI1ruaFuTycSJgQGvz21LVf4ZwU+99nkcKxMTAVdrvltEutS
 YO8u6EytTiyS49mqTfr/misIK1puqMoz71K4thAo0NwQ81CRyqXE9PaSONxS+AZuvTVbQZIxD
 EIRaSjpMpacbk1PPVwd75LRlZ5DPZgsI1HgWZHcqcwJ2mghmreqeF7jUymx4IivU8qVNlx0KX
 nkXBOg==
Subject: [cocci] [PATCH 2/2] clk: imx: composite-8m: Delete two unnecessary
 initialisations in __imx8m_clk_hw_composite()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1362
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/6604590e-d0f7-4798-a1b9-b2f474f3a642%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 22 Dec 2023 17:11:03 +0100

Two local variables will eventually be set to appropriate pointers
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/imx/clk-composite-8m.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-comp=
osite-8m.c
index eb5392f7a257..8cc07d056a83 100644
=2D-- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -212,9 +212,9 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *na=
me,
 {
 	struct clk_hw *hw =3D ERR_PTR(-ENOMEM), *mux_hw;
 	struct clk_hw *div_hw, *gate_hw =3D NULL;
-	struct clk_divider *div =3D NULL;
+	struct clk_divider *div;
 	struct clk_gate *gate =3D NULL;
-	struct clk_mux *mux =3D NULL;
+	struct clk_mux *mux;
 	const struct clk_ops *divider_ops;
 	const struct clk_ops *mux_ops;

=2D-
2.43.0

