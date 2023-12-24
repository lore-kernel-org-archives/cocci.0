Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7434C46CD2
	for <cocci@archiver.kernel.org>; Sun, 24 Dec 2023 16:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=8GtRlQ0Iy8eqw7h5lgVbAp/su+Y6nfeXw22wm90ErQc=;
  b=QavGpA9uraq0nNU/lsoZWX4rkK7dLeKCCESuwJda1QfLJ1ddoLJhhzqK
   RZTJ1JFUsgjgIsYqRONuhe+qky0zdya0Aq29Xyx05oOyNoccKqx9zkZyu
   b6hTrj5lG/1RXbWGSzprLrkaSP/WvaPDVrM9zFhq3aQBptLDEpQu3dEBt
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
X-IronPort-AV: E=Sophos;i="6.04,301,1695679200"; 
   d="scan'208";a="143935321"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Dec 2023 17:52:19 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 02129E0AF1; Sun, 24 Dec 2023 17:52:19 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 67EB2E004E
	for <cocci@sympa.inria.fr>; Sun, 24 Dec 2023 17:52:16 +0100 (CET)
IronPort-SDR: 658861bf_LkmWZvbwaFsLButdQDtRJdDqAcHL2i79BC9EFotB+yQOdiV
 0wGgt/xsm+8jxk52UYAomAl6mOjQRt2UABJ8wDg==
X-IPAS-Result: =?us-ascii?q?A0FuAgD6YIhlewQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+COXwDUzIEC0iEU4NPjWcwhDuPAYRrhASDFj4PAQMBDTEQAQIEAQEDAQM4h?=
 =?us-ascii?q?EcChzYCHgcBBDQTAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?SQYBg4QJ4VsDYJcARCBDIEdAQEBAQEBAQEBAQEBAQEBAQEBARcCR0IDAyMEG?=
 =?us-ascii?q?QEBESYBDx8BBQImAgJWBgESAgEBgnwBgioBAzEHrzF/M4EBggoBAQaBB4Ffr?=
 =?us-ascii?q?HIfLCJWgWAJgRouiBsBhWeDQXonD4FVRIEVJ4NBhAqEFIJoiR0HMoIcg1CRW?=
 =?us-ascii?q?n0FQXAbAwcDfw8rBwQwIgYJFC0jBlAEKCEJExJAgV2BUgp+Pw8OEYI+IgIHN?=
 =?us-ascii?q?jYZSIJYFQw0BEZ1ECoEFBeBDm4bEh43ERAXDQMIdB0CMjwDBQMEMwodCyEFV?=
 =?us-ascii?q?gNFBkkLAwIaBQMDBIEwBQ0aAhAsJwMDEkkCEBQDOwMDBgMKMQMwVUQMTwNpH?=
 =?us-ascii?q?zIJPA8MGgIbHg0nIwIsQgMRBRACFgMkFgQ0EQkLKAMsBjgCEgwGBgldJgcPC?=
 =?us-ascii?q?QQlAwgEAyspAyN0EQMECgMUBwsHXAMZKx1AAgELbT01BgMLGwY+AqQQAYI5g?=
 =?us-ascii?q?Q6CdqJBokA0B4I0gWCBYQyKGJUTBhMvhVeRTw4GklQuh1CLAIVPIKhGgXojg?=
 =?us-ascii?q?VwzGiSDNglGAxkPjiA4g3OEHoprAT1ANTsCBwEKAQEDCYVGAQGDJjSBRgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:IzCJEaPvt0OS+8BcThWjsMiBIKoaSvp037Dk7TEUdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFg7X5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YGT0EUMr3N5DZB/KPHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: =?us-ascii?q?9a23=3ADhxtomvWklYq2josCRXGz2986IsqeCLzyVf8enW?=
 =?us-ascii?q?lAFlOUp/KQ1W3p/5Nxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A77ESKQxIBLbLIbCSN61IwGQcnI2aqIuWI1AxsJw?=
 =?us-ascii?q?ggeuFBwZWPzGwjDG7ZKZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,301,1695679200"; 
   d="scan'208";a="75293512"
X-MGA-submission: =?us-ascii?q?MDHxkreiWtbCGJNPsO11sTUAXPBVH2DSWub0YJ?=
 =?us-ascii?q?lEdWx5IgRhJR4HZqtHJNiDMMQPN9OHdsg7KvsDREgBT81iW6v1AJ5vuM?=
 =?us-ascii?q?2UP4pK+T9VrVFTPScq+40yRtrVwAm8AUUFkTV3WQRNUsNaP3B13d3okf?=
 =?us-ascii?q?vuCrt4CsH4k5Fth75X3FLQxA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 17:52:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703436732; x=1704041532; i=markus.elfring@web.de;
	bh=JVdUzdLpgaC7hin98rECoi2XLdapoOWFd5N0xpU61Ps=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=R3f2pxMtgGsapI2wHzZEJ6wtTmgobGpUwnMfkpJ4NY+T+PUQxcjMUTQrQ6C5WH72
	 Vc7AWqorzLtIxE8KsqCaPGzh7Bm0u3kxLd0jyQB5zTVRST4+g16ul3AxOTPHTg73J
	 +UnnY4brCUC++ti/y2xpawndiOX5prxyHzAKpUSo9ppJN/bq6fTMOGajdxC84qvAC
	 VkJ3jPVudtR/zTZNI2dKK+BZw6R2GMIaoRGhMvGuLw6Npochihs6XyxekF3zVHLhc
	 7bgaboOhIqxBi1QR/R7sLs9VkL1MvH0mm9/uWL+BXRkhux2ZriNes31ydTYzI/x5A
	 CccQ2nsGKhy/x6C3Eg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQgp0-1rf389465e-00O91k; Sun, 24
 Dec 2023 17:52:12 +0100
Message-ID: <8f58f1c4-3fdb-49ed-b747-5e1a4852875a@web.de>
Date: Sun, 24 Dec 2023 17:52:10 +0100
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
X-Provags-ID: V03:K1:fgN0ExXBwyzGUMbTgjTQTsyg844rAOWLjjsZLqPYyF+g0El0wjS
 fpdJ3gzSpTdZjq3ca1tmrQTdzYiAQSHKYsU90V6eMg2QY36o/KHmAB+nJo40lWPx/hyclBB
 dFFLiAJETpj76bkIKBCB7lqaRwF9GFsMBiKg9quyxL/ojHx2GhbW9iEvjMHGQy4cZ8EhTrr
 26Phs5wT05dErm3m7QyvA==
UI-OutboundReport: notjunk:1;M01:P0:m0YkNs4BJnc=;rLK0KQfeIZqGmWNAPNEF+Fnjc/+
 oIoU2FJwEEhd+GLZENUUL3z/llOdruLcq85PAZYcVTQYxKEkpP55ADk09wwocDbFDjHXyw8N8
 BK3CP5bZ5Q7s+0XOyEOy3Q197VJuugi7AE1xaE4WaxTu3x92HUdbnPhzBXpmHJukZrQ2acMQW
 Sr6dnLeliQMN1wCh24yKIiMwao4mAfofzfiaqCiQVNZSretEUX8psBH1lpvWIor+hDGayYo6T
 AJhZdDoNPctqvUlf9J02eGBrEzarYsrICUjd0CHEGetZpPJ74glzK82UouT//U9zldv0xQipQ
 t7Pzzww9z27xIaszolzIRn0OUA4Kn2nFfz8Um7tEm6q7yaDXQGtD53RmBPfaIcYjEcWsxKMbg
 HX4lpZnHVLy1v0DobKBKhhqkcancJZT0eByg2wPZGbgfyAXJJyTe7LRCLB14quu3WAiqSDaHf
 JdqX6ZJ2Slhh3srMA4GK2J0Co1XRnwB4hnTGXuQ1vdad/TL+aJCG/xnae7vGRcgK+9lsIsayu
 zTb6fjsnlM3Idk40ohL5HoexwHx6D6A02Z3xWi6vX3hP4niUQn7+v3KV3oUCKE+8aKl3x+vbE
 8C+IkVjk2guVTSrahTh0rOmoyz3uBDcQ8t+HOYb3y0ykJXEBvnwkDZUDg1frwWUtle30Rlkdb
 NyP/9CYeBxEbtrRX67KQA1MIRz1t5f/X5TCpb18XYqlu7vUAmIfYaBOhwhx7YCG5BCpF+iyUY
 VH/1qWQIIvBdkt5heHnXdS5NLJ02BxM3YEWo8Gk5BomVWKDogPIuLdOgE3NrtcKqe9Czj1L7G
 m6Ga35Eic9iqfZDBM1sVQhSC6qObIOIryqDUpur7KI1ut0z863hr3A/52l6+N6TxFBv9IEX5b
 ml8tZTKg/VgpedtZijJBMLo8IK5+sdmhEsjYDrSlFcrT/1R0UTZRX3cO7pfiNAaZK9JmSyyMI
 ROIhxg==
Subject: [cocci] [PATCH 10/10] clk: ti: Delete an unnecessary initialisation
 in _ti_clkctrl_clk_register()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1378
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/8f58f1c4-3fdb-49ed-b747-5e1a4852875a%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 24 Dec 2023 16:27:33 +0100

The variable =E2=80=9Cret=E2=80=9D will eventually be set to an appropriat=
e value
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/ti/clkctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index cdc3cf1ddddf..b9df75c6cc50 100644
=2D-- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -291,7 +291,7 @@ _ti_clkctrl_clk_register(struct omap_clkctrl_provider =
*provider,
 	struct clk_init_data init =3D { NULL };
 	struct clk *clk;
 	struct omap_clkctrl_clk *clkctrl_clk;
-	int ret =3D 0;
+	int ret;

 	init.name =3D clkctrl_get_clock_name(node, clkctrl_name, offset, bit,
 					   ti_clk_get_features()->flags &
=2D-
2.43.0

