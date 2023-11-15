Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FF7C07548
	for <cocci@archiver.kernel.org>; Wed, 15 Nov 2023 09:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=3y6oY/hT4F23hFAF8jTdSysi7fZOAzKnxjgC2CmxphM=;
  b=rkgjK7tZbZPgS/1Mo2V74Id9UCutnW4u0sotNbA4YTzLfMM+ZjzqIo82
   S6NTi1brykCwGmTW3lH2+/ugBV9VqHKpgpKACkJ4RAQodfG0pHKTAdNP4
   RIo6GAqSgVkfeBus5/FumPm4pWR+2OquYtD7R5hYoN7oMuApqAWzbPpLD
   A=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.03,304,1694728800"; 
   d="scan'208";a="136465802"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2023 10:11:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 37B67E0138; Wed, 15 Nov 2023 10:11:24 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4EAC6E0133
	for <cocci@sympa.inria.fr>; Wed, 15 Nov 2023 10:11:22 +0100 (CET)
IronPort-SDR: 65548b39_pEj3MncWgbcVpuePZ29h4kdA1NwqOLBW0Gzz1CLr9Zg8Z9m
 Kb+6te4z3MGL0FZ0aa4gFgeSAwolJToTiyvZvgg==
X-IPAS-Result: =?us-ascii?q?A0FpBACcilRl/07ASNlaHgEBCxIMQIFEC4I5B3NWMAQLS?=
 =?us-ascii?q?ASET489gXUtA4Q7l22BVoFAPg8BAwENOwYBAgQBAQMEOIRHAocpAh4HAQQyB?=
 =?us-ascii?q?w4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECgQYThWgNglwBEIEMg?=
 =?us-ascii?q?R4BAQEBAQEBAQEBAQEBAQEBAQEXAg06QgYjBBkBAREmAQ8fAQUCJgICVwYBE?=
 =?us-ascii?q?gIBAYJ8AYIpAQMxBw2uEX8zgQGCCQEBBq9VHywiVYFfAwaBGi6IDQGFWYM7e?=
 =?us-ascii?q?icPgVVEgTyBFIE3B2+CYQSBPAEBg3uCaINvhToHMoIigykpjXZ/BUJwGwMHA?=
 =?us-ascii?q?38PKwcELSIGCRQtIwZRBCgkCRMSPgSBY4FRCn8/Dw4RgkAiAj02GUiCWxUMN?=
 =?us-ascii?q?ARGdhAqBBQXgRFuGxUeNxESFw0DCHQdAhEjPAMFAwQzChINCyEFVgNCBkkLA?=
 =?us-ascii?q?wIaBQMDBIE2BQ0eAhAtJwMDE00CEBQDOwMDBgMLMQMwVUQMUANrHzYJPA8MH?=
 =?us-ascii?q?wIbHg0nKAIyQgMRBRICFgMkGQQ2EQkLIwQOAxkrHUACAQttPTUGAwsbBj4Cn?=
 =?us-ascii?q?xc7gycBexMsWIFykmuTD55iNAeCMYFfgV8MihaVDQYTL5ciDgaSTi6YEiCLU?=
 =?us-ascii?q?oF1mm2BaQE2gVkzGiRPgmcTPAMZD44ghCuEYYooAT1ANQIBOAIHCwEBAwmFR?=
 =?us-ascii?q?gEBg1qBQAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 FhVjOPK4Q==
IronPort-HdrOrdr: A9a23:4D32+a1BKFkKabiKioNCzQqjBGYkLtp133Aq2lEZdPWaSL37qy
 ncpoV+6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: =?us-ascii?q?9a23=3A1YEna2oGE94Izke8stgT+MfmUdgbLF76wEqOGnS?=
 =?us-ascii?q?pLG1KELvLcHG9pJoxxg=3D=3D?=
X-Talos-MUID: 9a23:OkrfbQTLNKjGT+EbRXTVrjQ/KZdCx5+AFUAvlIw3pNi/aHVZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,304,1694728800"; 
   d="scan'208";a="136465797"
X-MGA-submission: =?us-ascii?q?MDECJ7g8WGOkB5bfNlvV0FCbrk6NH1T8GlrGLP?=
 =?us-ascii?q?+b0cO4UJMKv2LmTPDp6DDGpP+V2PZ1LpvN/8+7b1TxRCfRqYwJoYnuxB?=
 =?us-ascii?q?ZrvUltR3NgstzzoxLMY4CYicVF172vdN9k9F7ZnEbq/8/08Rpgch+sz7?=
 =?us-ascii?q?fpKWYQ3gVE9eyyAJSdTHl+jQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 10:11:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700039466; x=1700644266; i=markus.elfring@web.de;
	bh=8WDhLtoKLy35+5PZZkcN/p57I6TCKqVmJkti5fQEovQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=uvB2hYHE1ss1gh45DyYuVHCQ+SFSnwdYkgCcfdjHbDEo1ZjSL7hQAtmJnLDirxNs
	 44dv0yBjXSFTG0gqdt4bfkB5FI7kNDOt/AfaD60eOiTSec9Vn20fBcMYhw0rSEWay
	 pCy+CCt3U6i4sDWT1BtIv2+OjOCkDtHDQl5NXQFL11mVm86n99eDj6vKjos8zBBbf
	 biwCFyrgCNwWeVmsNR2NMaBkPIBeNp26X6PEIEjQF/gtypFiCkmHyXTHTJ+feKyuV
	 RiALRyZNtn5mPGhRYgd6hDmtVH1I286Vryqbv2Ft/w8akwNlkHv5VvxnzvnbmgToB
	 GvKoKZNmug36i1L2oA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MfKtN-1rasmg3irj-00gYZt; Wed, 15
 Nov 2023 10:11:05 +0100
Message-ID: <38279cb8-ff60-427e-ae9f-5f973955ffa6@web.de>
Date: Wed, 15 Nov 2023 10:10:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Justin Chen <justin.chen@broadcom.com>, Jakub Kicinski <kuba@kernel.org>,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Simon Horman <horms@kernel.org>
References: <0b2972cb-03b2-40c7-a728-6ebe2512637f@web.de>
 <20231106145806.669875f4@kernel.org>
 <dce77105-47ab-4ec7-8d46-b983c630dad8@web.de>
 <CALSSxFYRgPwEq+QhCOYPqrtae8RvL=jTOcz4mk3vbe+Fc0QwbQ@mail.gmail.com>
 <4053e838-e5cf-4450-8067-21bdec989d1b@broadcom.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4053e838-e5cf-4450-8067-21bdec989d1b@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I94ylgcLIavmxXuQAjZzu347c3BuJq6r19TRqpcys5o9rMY4Z07
 cAe5iF72kk3KOacACYzxzkvgLhtpWsiiyiXl3hTtYY13LrFw5d+gq/MGGl2IAK4xwWuNpBn
 yaEhUa/rpnzdLidZi1Dvx40gaefJbIBko4pYP4t5IQu4ZNa+KWnf1hdk2DIdXlnmH6InOKv
 OwprYWJD/jDe2p1/5l9fA==
UI-OutboundReport: notjunk:1;M01:P0:UJzgLR3r644=;9l9e178ekyfMaX4XD04XVuMv49K
 7Mqj3jLbG/s8KWo5KoO353ouaqHxVb8NIAPrlv6Iv4eTjtTbQUhoE1u0xxEXnN1fHlOyu455X
 +NzyYFHDPvL/m+X4NXIUfxAdTEZKEk3Mc4wRApdjKYtdQcjJN+FJnYzkoMwJFiDJ6LYKOCVcE
 Ox5K+gMhA8az5HP/A8rGx0zEyvlPuhiHfljkRVMpEBMy+AqldPSSHSj6QwCdLm/bdF8kVkM3B
 pxOhIF3Yzw/hOYCSExtG6bdNlH6sUE2tO8U6aQWPqQ+2Z2cfnRiyTaszxe0DH4h5RUVMBSkCH
 GgKkENeHonmWLxeqZdjXVziEAfX7Ja9pACo6HqViksHQp66XHCDERFBvO9nomEwQzA3Xo+mBF
 W5Gh41uw4jfLjs5PDWt91HifPyLRwaGHSADyRoxTpwhECRChXpw62o76UbUNx/wF60SsHfACT
 KqwJyOnFdTSmSMNCI/af2JvQL+k0eLv4xitOZVvhuGU0DAm8tOKmXZmBC6Ks+mk0LnXlO50v5
 c5EfF9SaPFephv4xAhRO8OfDlmqF9mbr2Em7WaB9WmzhBEf4P+ipOqjVULJnHb9ljxfwt8fK5
 eawnf/G7DhEM0pbr9J2Pvxb72Q+FvojKDdxIQdkzBY2Mbwko2B0ERDja9OEbL/g1TixZESdUI
 yd/OCnocPqbKjyw7eskYipEc8eIuGDhtDCHY/+CBtlbXS04UW+OQVAa/aMw5pBqUBWjTfvxWR
 C7QH1I4wCHvBAHQL3C18j8SQ7q2QpJlEQMAJ8A1lFE0XOc1EaOzQ9EG75aBKvEE7revZ5qTna
 L0lSw/851jTxXgNg2PhqQwGh3oznLblL4VLAerGfUr7cxhr5u1MrMdfRWdn3Tqdmahnz2tn8r
 j0lsq23i5B+9AuWF2adW8OA7PThueej38kETISwB75vWm/q9aZmttyvP5fsGLLx5VdLq+CaVI
 7C61Cw==
Subject: [cocci] [PATCH v2] net: bcmasp: Use common error handling code in
 bcmasp_probe()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1295
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/38279cb8-ff60-427e-ae9f-5f973955ffa6%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 15 Nov 2023 09:38:56 +0100

Add a jump target so that a bit of exception handling can be better reused
in this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

v2:
Special expectations were expressed for the previous patch size.

* Jakub Kicinski
  https://lore.kernel.org/netdev/20231106145806.669875f4@kernel.org/

* Justin Chen
  https://lore.kernel.org/netdev/CALSSxFYRgPwEq+QhCOYPqrtae8RvL=3DjTOcz4mk=
3vbe+Fc0QwbQ@mail.gmail.com/

* Florian Fainelli
  https://lore.kernel.org/netdev/4053e838-e5cf-4450-8067-21bdec989d1b@broa=
dcom.com/


Thus another change variant can eventually be integrated.


 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/eth=
ernet/broadcom/asp2/bcmasp.c
index 29b04a274d07..7d6c15732d9f 100644
=2D-- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1304,9 +1304,8 @@ static int bcmasp_probe(struct platform_device *pdev=
)
 		intf =3D bcmasp_interface_create(priv, intf_node, i);
 		if (!intf) {
 			dev_err(dev, "Cannot create eth interface %d\n", i);
-			bcmasp_remove_intfs(priv);
 			of_node_put(intf_node);
-			goto of_put_exit;
+			goto remove_intfs;
 		}
 		list_add_tail(&intf->list, &priv->intfs);
 		i++;
@@ -1331,6 +1330,7 @@ static int bcmasp_probe(struct platform_device *pdev=
)
 			netdev_err(intf->ndev,
 				   "failed to register net_device: %d\n", ret);
 			priv->destroy_wol(priv);
+remove_intfs:
 			bcmasp_remove_intfs(priv);
 			goto of_put_exit;
 		}
=2D-
2.42.1

