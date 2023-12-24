Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5322AC46CD3
	for <cocci@archiver.kernel.org>; Sun, 24 Dec 2023 16:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wsYj+krag6xuo5qp/BHeEjwmyWE6KE6inZIwGD71AHY=;
  b=ZZsjNNxBqzw5zaK9nm5yPKwNckyFxd7tvSWbxLzG3YQ+OCEWxHew3inI
   uG7FYhpxZDxkVZCBXX1p+yJYF7q8Vakm6Hgez2iHKcPz2/jrryh+mPN+e
   AfVzkMxwf9Xdzpxp3I/7ZmN7CfAU33IsvByydU0l2mAVRB96vmeycuxP+
   w=;
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
   d="scan'208";a="143934854"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Dec 2023 17:44:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BEB95E0CCA; Sun, 24 Dec 2023 17:44:17 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6AB93E004E
	for <cocci@sympa.inria.fr>; Sun, 24 Dec 2023 17:44:16 +0100 (CET)
IronPort-SDR: 65885fe0_c/osI1iXUGkn1CkQpDboV7RVGYV+cuhXvnlno7dts9qs/Ne
 PHjrO676w+9Rkc0fsAL8N3ow/rUfTXo3dv+8IAQ==
X-IPAS-Result: =?us-ascii?q?A0EmAACXXohl/wQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4B3hTMgQLSIRTiB2JGS0DhDuHNYdMhGuEBIFWgUA+DwEDAQ1BA?=
 =?us-ascii?q?QIEAQEDBDiBU4J0Aoc2Ah4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECgQYThWwNglwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAkdCB?=
 =?us-ascii?q?iMEGQEBESYBDx8BBQImAgJWBgESAgEBgnyCKwEDMQevMH8zgQGCCgEBBq9YH?=
 =?us-ascii?q?ywiVoFgCYEaLgGIGgGFZ4NBeicPgVVEgTwLgzaECoQUgmiJHQcyghyDUJFaf?=
 =?us-ascii?q?QVBcBsDBwN/DysHBDAiBgkULSMGUAQoIQkTEkCBXYFSCn4/Dw4Rgj4iAj02G?=
 =?us-ascii?q?UiCWBUMNARGdRAqBBQXgQ5uGxIeNxEQBRINAwh0HQIyPAMFAwQzCh0LIQVWA?=
 =?us-ascii?q?0UGSQsDAhoFAwMEgTAFDRoCECwnAwMSSQIQFAM7AwMGAwoxAzBVRAxPA2kfG?=
 =?us-ascii?q?BoJPA8MGgIbHg0nIwIsQgMRBRACFgMkFgQ0EQkLKAMsBjgCEgwGBgldJgcPC?=
 =?us-ascii?q?QQlAwgEAyspAyN0EQMECgMUBwsHXAMZKx1AAgELbT01BgMLGwY+AqZDB1MoE?=
 =?us-ascii?q?xQ4JoIEsECUQTQHgjSBYIFhDJ8rBhMvlyYOBpJULodQkE8gqEaBYz2BWTMaJ?=
 =?us-ascii?q?IM2TwMZD44gOINzjwkBPUA1OwIHCwEBAwmFRgEBgyY0gUYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:SwmGcqxVORcngZXhfSwLKrPw+L1zdoMgy1knxilNoNJuA6ilfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bBYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebrN5DNB7foSjjPIduoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:oZTcEW/bfwFb6DGEANaVv3JJAcQfU1HM9WrvHW6XM0Z0FYykQHbFrQ==
X-Talos-MUID: 9a23:eT5NKArvGrFbc1ZpJaoez28lLvZSyefpMn0cr5YequvebidsZR7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,301,1695679200"; 
   d="scan'208";a="143934852"
X-MGA-submission: =?us-ascii?q?MDHuOsM0u+Ox692kmrIL4q9tSGmXn48hZxx6/z?=
 =?us-ascii?q?QJ7cAjZElVHxUtQgw5tN4vwaOjawtqxXSyhWUZb9bjfWeQ6CkckbqdtK?=
 =?us-ascii?q?ZOltu0uu0zYw4Hvn4p1dSW+sWkrKVDs64KeP14NgPKM1Osl3RCO9HnCf?=
 =?us-ascii?q?I9TqdpgaEXMuUdU3/KGcHn1w=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 17:44:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703436243; x=1704041043; i=markus.elfring@web.de;
	bh=Zjk3kgsKNF6CsWK02KUE6jMlFvAiyO4Gho2qFghKcKs=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=Hqu4UcUaOrw87RsWVlIy8U1+gjQ7zfGE6CnY5d8NnAryM6ZNqcB0O2etaNiI7gil
	 nLe9JSwIGKKbFziTZIaisfpKxxwihHyRVhS06ePczm9P8esri1EioaLev/Rvf7P60
	 wNz0XFn1teJ04zusd7JLkBvlPc6eUtDPtMqP6GyO59OVXrQUDWvive9XRXWbylJCX
	 zGY9Efij+L5VM0hJbUmOUmIZv26olhFxDYXsjYdpiFuZXnXLw420dx/9wrBVMDuV3
	 Dvy7c/jff6btR+c46RnyFZvfc/Y2QTtcRC6Qr2DE2VnqthWiTRjMyZLS+PwHV0bhq
	 rXmfBr00q1/mmWlJow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUU68-1rho8Z23xQ-00QqXu; Sun, 24
 Dec 2023 17:44:03 +0100
Message-ID: <f0f00368-9985-4517-8019-010f744a0e39@web.de>
Date: Sun, 24 Dec 2023 17:44:02 +0100
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
X-Provags-ID: V03:K1:UBp6FJtixv/LocTBx22eQdkrXLyPsrH437F+wg757/SvLLcqXYi
 cEP/Ok44Yhwdi7ekjQIre6glYcW+sC41Em43GGSfaWxYTvmnJdlOL+k7MmWacyMyW+PglzD
 83qp/H0axL0uPwWYH7ryzKDfB8AqeOxEZFdxhkMo6bJHjQnW7iWlaEvR7Lb4wY39UOuQBk9
 YCxNVMKqnnagrbtWG5+/g==
UI-OutboundReport: notjunk:1;M01:P0:gfIzGhCG8vs=;Af2OqGuJpj6NMu8KvFm8tK6zD3A
 tMSjSwQhZ0kFr/oqIs5v9QgMNkwIexNV6AZKa8L3YDejI+ReonrbE/QCB7IXb/9wOtRWxqBbm
 8ONdmdCoi9njmoOo2LP0gUluXOvG9k3u/L/KLVvDkxFzkdIpT08tai7HmTIt9WMBQmYesr4/z
 i900TvsAJisZoUvi/x86IG0UIyZ7Zvnw90oGQXqz7Ye7vt5mkao0pI3/zIGXp8FpfWsAN6HNx
 WRpY7WnPYnzyMajzjLBo5+kNXlIQOJ0Pzfkv/RUZYx/XEr0/V5uhERrXLNOIEQgIz5IJhgcoD
 MfSi7yw+PQ26Q/6l0c7+cYzZ7h+DtjE32bEDjaQsRHsMLH2bQVdm7J9oTh4pAZCzdyqMq0S7n
 0MleTUWEPUs2ziJOhJJV9DIvbP+ruLphXexA6XRKwv4iFzsKTb6FTg4Kd57NJvLJr2/gzsPJ/
 PezFow+Z6BVGD0fgys+8ZGWl2DRuUwXf+Xx5h5k1tDF1Yrgp4NRw8XM6kSATJ3DAAtF6RMYdU
 qKhrg//DcjJRUylaXD/n8k7mX8/2/8u5FQ45N2ZefEC+ZrTpohAPJflEAq4efGB1d4zIWggea
 9q7z9nsSKTNhDlidP3eOwo1GdYt2ep+FlOnukcfHQ8mjUuATER/op45ofPG3KAm77nbHCNsil
 +dGZ5Zi4N4Vru5DYIrfKezZwWxQCmXlBfrFpoPh58blbnKpZaj3pRU7FFev51TVJysgKwtWFO
 16HmLNEM2CB67xeJIepYEYO1XZj/7ItI7C22XeTlsysmz9ssEMelp6BDxRnnrntMLE9eZRodJ
 aguKXMI5AMYZ7860tq1j3ejQUpn5UD5zlwdcrEcXVuLNG06rdwyjDaeRAYY8XXvV66AvEPsLw
 4Gf4LE8vQh1IJhK9WFhGhYE9vQ6zVkP0NphVJXQYmfmvPZ5hcm/peO6p2gkCrMAVGM+J6T+3k
 9xSjz0kXLH1EoJEMGaF8dMGWMhY=
Subject: [cocci] [PATCH 05/10] clk: ti: One function call less in
 ti_fapll_synth_setup() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1373
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/f0f00368-9985-4517-8019-010f744a0e39%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 24 Dec 2023 14:05:41 +0100

The kfree() function was called in one case by
the ti_fapll_synth_setup() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus use another label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/ti/fapll.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
index e9956e3ccd65..d4674ec3d7e9 100644
=2D-- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -504,7 +504,7 @@ static struct clk * __init ti_fapll_synth_setup(struct=
 fapll_data *fd,

 	synth =3D kzalloc(sizeof(*synth), GFP_KERNEL);
 	if (!synth)
-		goto free;
+		goto free_init;

 	synth->fd =3D fd;
 	synth->index =3D index;
@@ -524,6 +524,7 @@ static struct clk * __init ti_fapll_synth_setup(struct=
 fapll_data *fd,

 free:
 	kfree(synth);
+free_init:
 	kfree(init);

 	return clk;
=2D-
2.43.0

