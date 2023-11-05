Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0E8C41535
	for <cocci@archiver.kernel.org>; Sun,  5 Nov 2023 16:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:cc:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=KNidufU75022a8zW7N42rcnS1pdaBy8xaSNKGngd4jI=;
  b=MGzUPdxKLiLD3gwaICHspGobFdGu5pWP3pannENgFzXnqFaKqXq0xRPL
   JLSUdGj/lfaVW8zM+hheBRVIXnbpn4TrEVvheQ3tqCBcJP9u68vqWjVpI
   dlLxw6SnUi9KuJtIKda2B1OgpKe4JVFvS+5IdaWeA0ioRPCqAQuBcId/c
   o=;
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
X-IronPort-AV: E=Sophos;i="6.03,279,1694728800"; 
   d="scan'208";a="134662408"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Nov 2023 17:34:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F04D1E0205; Sun,  5 Nov 2023 17:34:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 60C51E00B6
	for <cocci@sympa.inria.fr>; Sun,  5 Nov 2023 17:34:03 +0100 (CET)
IronPort-SDR: 6547c3fa_8ON3C/tYlR381OeVylzI4E51zsb7VaZ/R8dPlXrfbqbdXMi
 Os8iH7lui6gsdSZBLMppvyZ8/HjxZ040fQeuGiQ==
X-IPAS-Result: =?us-ascii?q?A0HhBAB0w0dl/wMP49RagQmBT4I5B4FJMAQLSIRTkTGBD?=
 =?us-ascii?q?oNdhzSQOYMWPg8BAwENQQECBAEBAwQ3AYRHhyYCHgcBBDMGDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEDAQEFAQEBAgEBAgQFAQKBBhOFaA2CNysBEYEMgR4BAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEXAkdrBBkBAREmAS4BBQImAl8BEgIBAYJ6gioBAzEHqx9/M?=
 =?us-ascii?q?4EBggkBAQavVB8sIlWBXwmBGi6ICgGFUYRcD4FVRIE8gRSBNwdviB6CaIkuB?=
 =?us-ascii?q?zKCI4NTjHyBAAVCcBsDBwOBABArBwQtIgYJFC0jBlEELSQJExI+BIM0CoECP?=
 =?us-ascii?q?w8OEYI/YTYZSIJVCRUMNARGdhAqBBQXgRJuHRUeNxESFw0DCHYdAhEjPAMFA?=
 =?us-ascii?q?wQ0ChINCyEFVwNFBkkLAwIaBQMDBIE2BQ0eAhAtJwMDE00CEBQDOwMDBgMLM?=
 =?us-ascii?q?QMwVUQMUQNsHzYJPA8MHwIbHg0nKAI1QwMRBRICDAQOAxkrHUACAQttPTUGA?=
 =?us-ascii?q?wsbBj4CnySCdnsTgnaSapMNnmI0B4IxgV6BXwyfIwYTL5cgDgaSSwEumBAgq?=
 =?us-ascii?q?DGBeSeBWTMaJE+CZ08DGQ+OLBaECY8JAT1ANTsCBwsBAQMJhUYBAYNagikBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:Q81aOaDXEiHHe3PlHel055DYdb4zR+YMi2TDGXoBLSC9Afbo9P
 xG+85rsyMc6QxhP03I/OrqBEDuexzhHPJOkOss1NSZMjUO2lHFEGgK1+KLrgEIcBeOk9K1u5
 0BT4FDKJnXEUVwi9r87TK1CtA63bC8gduVbKvlrkuEVmtRGthdBupCe36m+sYafmN7OaY=
X-Talos-CUID: =?us-ascii?q?9a23=3Ad6u2nmlqI4rfm0CsI5lyYa0iNAXXOW/Gzyz+c0K?=
 =?us-ascii?q?+NWwqV6zJbg+ax794usU7zg=3D=3D?=
X-Talos-MUID: 9a23:/yJiggYdJVSUE+BTjBPWhw1nDMNUvLWjNHsdkKUqiurdOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,279,1694728800"; 
   d="scan'208";a="134662405"
X-MGA-submission: =?us-ascii?q?MDGAnrC+O2kVEuMBCD11o/eEU56rQHFsnz91qW?=
 =?us-ascii?q?ddM5fFstYnO+aweZAadt2FasFx4Uq5B+ihOZ+1cSIIE9SxDr3s2jesvc?=
 =?us-ascii?q?7xKVj7nXAU8UdNjnXTLlEg+TOH1rZYuj3XTRmJdjsyjGD81dztxXfl1p?=
 =?us-ascii?q?2E4tzM+yIHoqVJhnx8l9QX8w=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 17:34:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1699202030; x=1699806830; i=markus.elfring@web.de;
	bh=AJzJ0pD7PIrmE6AzU/uMIyD8mCJuDdnySvLzrjiZPgM=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=iFxkHu/LmKUzE7S3sWGb0x4Z0Si2kJw3v9Ae09arSrdgVRc6Fi105NuBq2Z1Ylv9
	 8yR7W77jIKyW5gUFVPDOvZqM0bc+TKfy172l5np+GBShr0twy4uFqgC/GF0SRiPDY
	 DM2Bo3Q8znVpICuMWFI8gorlGul6C0s53EOtngGwvWyF+dWb1RYDuWn0aWLnjK4CH
	 RMOFV5pCyV8mGVbQ77VkzGq+cO3+3IGe1u/FXk/mXKSDGinMX/qEaD72lC626Lsk7
	 edjURE0XZulkQSZ4vK1hc28kJd3FT9oBJiIBoIk+L20uBakjrODYsu1QCWUPAX1qW
	 lUZ0ooU0xBstE0Sd8w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6Jxd-1rWFi30wKv-016iJC; Sun, 05
 Nov 2023 17:33:50 +0100
Message-ID: <0b2972cb-03b2-40c7-a728-6ebe2512637f@web.de>
Date: Sun, 5 Nov 2023 17:33:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <Julia.Lawall@inria.fr>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jakub Kicinski <kuba@kernel.org>, Justin Chen <justin.chen@broadcom.com>,
 Paolo Abeni <pabeni@redhat.com>, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6++zPlahvKLDI/Fdz1N+9LgnJ3iTWU2g1ZWw7sjCgkR189sh42S
 vxLUehhG8l5lgi5q8GrndZwdbXiCmh5iaUD9WkLR/AmFoJmOZDW3DPvmMq5VULEJv/R4aBi
 WKc0kXfXRjmsW5SAIzOgHGKR64T0WbQ0zPoLNIYH0UzM4Gs3ulpp8NbNBwuppkdKOVWtH5V
 SdtkFxUusIPUfqzHtoKMw==
UI-OutboundReport: notjunk:1;M01:P0:Io53oQfVKEs=;rXX/5a1ZB50YgxR0EkBnJzYrQvN
 L+FvVojPLFM3b7oWBkU7AlOl3gUM3ekqmaZuYC7RcNONUzUWJ8noMYWpUEpo85NJJxgSfhE3j
 u4auKRdiSKOaBJEJyitSALkBPHw6lVGfr054SugCmeoWqVkIxoM3l94uPDtqPMLp+CCLpfgM/
 wIogfEzvjN8lC3X/kvls+yA7JO77MDmbM736OzPCa+nlPgJRkLCTucpxgbe4K9B1T7VtGaR7q
 5WzIIC8v7KHu4Ae2tpKwDgnuKFeOC18N8U57AladnM93hO/odtIcDgse7rlKfV2vLOeto9Qtp
 YEsRLpV0D4AdrL/yYSBTIPxvmtoszHEmCdWE4B9325Hc7QVdgL/uVutUvLi1zB9QZxn/Ywy1I
 udLtABZsQpChihcn+QK8DMusaG5KFLtvBuol/tG4es8kQ+hcbvTZo7Pi1za2TV+e7Uxtu3lk1
 UmO6yc51LCQSDLU4k1DNVRA8o5u/jco8JzkMAyBbAg41YOJWBeYp2vtfTuXnJs3feBwO9VsLq
 k/ZrwPsZwyJhBu8S+0GC23ORJt8HoVf+0SJiKApGIAlyjHAHTJVqrgsrlnhRWzEURfiGV0/Aj
 ubI5irwxYo3DZMuJxV9YfABQjw2ztt/dlUmSm5urq1kecriv+TpMkMaETaykfd6hlAGZ+ERsb
 Bk1vmoiF4FyTxllfSZ5XUkdiBS9DeYrdKtT5JV2dYCaY+sbdph5cVXFUVdUClLvHUoYVMN+Nt
 UzsEaCNz1+9a/06SpiC/T6HlGKXvM1JhpbdaNlmBcridp9rHUTPYckUV8hX4tAgxcv+IzGjF8
 n1vxiZMjDCwFfLyYf+D+Cxe47I9H0advvup3Mhc/olt/F5DHdTKX+2v4xsqTNOMnBOCknBIaA
 zgrbN+4aUOxe6QIiyBI8S3Sib1jLVe8uFrbKGkxfs3SyO+ejATdPSDM8+mboYRF/g+65HZKme
 +0rE+w==
Subject: [cocci] [PATCH] net: bcmasp: Use common error handling code in
 bcmasp_probe()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1290
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/0b2972cb-03b2-40c7-a728-6ebe2512637f%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 5 Nov 2023 17:24:01 +0100

Add a jump target so that a bit of exception handling can be better
reused at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/eth=
ernet/broadcom/asp2/bcmasp.c
index 29b04a274d07..675437e44b94 100644
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
@@ -1331,8 +1330,7 @@ static int bcmasp_probe(struct platform_device *pdev=
)
 			netdev_err(intf->ndev,
 				   "failed to register net_device: %d\n", ret);
 			priv->destroy_wol(priv);
-			bcmasp_remove_intfs(priv);
-			goto of_put_exit;
+			goto remove_intfs;
 		}
 		count++;
 	}
@@ -1342,6 +1340,10 @@ static int bcmasp_probe(struct platform_device *pde=
v)
 of_put_exit:
 	of_node_put(ports_node);
 	return ret;
+
+remove_intfs:
+	bcmasp_remove_intfs(priv);
+	goto of_put_exit;
 }

 static void bcmasp_remove(struct platform_device *pdev)
=2D-
2.42.0

