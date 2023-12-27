Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854ACC46CD4
	for <cocci@archiver.kernel.org>; Wed, 27 Dec 2023 20:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=nt9E0VDdjsXcwXz87SEOlsow/Ov97+a/2SQrtzhaO60=;
  b=X7dHsfBIl6Te7y7I41vEez7KW4Lw3KH/fmYOAcNsWXgtTE0TeCeyX0N/
   uxn5PhYj6PYEj5KIbjCkwmZ60WkzcZsplkavG/s2FZMVYPpwSzw79GqXu
   wicO1O1H266P2af6AWtP8zYM1dAdBsLrgaBXEzD7ZKS42J740xLUl6LW+
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
X-IronPort-AV: E=Sophos;i="6.04,310,1695679200"; 
   d="scan'208";a="144160141"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Dec 2023 21:30:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A13E7E0AF1; Wed, 27 Dec 2023 21:30:28 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 99B96E004E
	for <cocci@sympa.inria.fr>; Wed, 27 Dec 2023 21:30:26 +0100 (CET)
IronPort-SDR: 658c8961_6OS/wwu59T1GyTPwYOOSWCEaTwDNODG+eIPRSRJngqNFpko
 QxqDrntjc1UGDvt0SsoPDq30BSnp2Uop8MK+DTw==
X-IPAS-Result: =?us-ascii?q?A0FiDABliIxlew4P49RaHgEBCxIMQIQIgVIyBAtIhFOPQ?=
 =?us-ascii?q?YF1LYQ+hzWMN4QEgxY+DwEDAQ1BAQIEAQEDBDcBgVOBYIEUhzgCHgcBBDQTA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABASQYBg4FCyeFbA2CV?=
 =?us-ascii?q?RiBDIEeAQEBAQEBAQEBAQEBAQEBAQEBFwJHawQZAQERJgEuAQUCJgJeARICA?=
 =?us-ascii?q?QGCfIIrAQMxB65dfzOBAYIKAQEGr1gfLCJWgWAJgRouiBsBhWeDQYEhD4FVR?=
 =?us-ascii?q?IEVJ4EUgi2IHoJog2aFNgcyghyDKSaRVn0FQXAbAwcDfw8rBwQwIgYJFC0jB?=
 =?us-ascii?q?lAEKCEJExJAgzEKgQE/Dw4Rgj5hNhlIglgVDDQERnUQKgQUF4EObhsSHjcRE?=
 =?us-ascii?q?AUSDQMIdB0CESM8AwUDBDMKEg0LIQVWA0IGSQsDAhoFAwMEgTAFDRoCECwnA?=
 =?us-ascii?q?wMSSQIQFAM7AwMGAwoxAzBVRAxPA2wfMgk8DwwaAhseDScjAixCAxEFEAIWA?=
 =?us-ascii?q?yQWBDQRCQsoAywGOwISDAYGCV0mBw8JBCUDCAQDKykDI3QRAwQKAxQHCwdSA?=
 =?us-ascii?q?xkrHUACAQttPTUGAwsbBj4Cpk0BUigTFDiBAIEqkwOxfjQHgjSBYIFhDJ8rB?=
 =?us-ascii?q?hMvlyYOBpJTAS6HUJBPIKhGgXojgVwzGiRPgmdPAxkPjiA4g3OPR0A1OwIHC?=
 =?us-ascii?q?wEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:njl7K6wNNjacqJpW5PWlKrPw9L1zdoMgy1knxilNoNJuA66lfr
 OV7ZcmPHjP+VAssRAb6Le90cy7Kk80mqQb3WB8B8bGYOCEggWVxeNZgbcKqgeIc0DDH4VmpM
 NdmsZFaOHYMXg/q9rm6w+lFNsazMCA673Av5ak854gd2BXg7oL1XYBNu93KDwPeOHMaKBSKK
 ah
X-Talos-CUID: 9a23:dEybr27LTQN1N9jh0tssylIZQdsdaFbm61j5EmKqK2tWaq+xYArF
X-Talos-MUID: =?us-ascii?q?9a23=3AJwCUiw2tdyZSFj4VJ23ss4auuzUj/vnyJB8DiJY?=
 =?us-ascii?q?6kpO5EQ9WEguUnh2ea9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,310,1695679200"; 
   d="scan'208";a="75422747"
X-MGA-submission: =?us-ascii?q?MDEFh+YrFpcxVVr0jY5ZjQK+RYA+HFU/BAFeMO?=
 =?us-ascii?q?gwTv7a+UUISTNSmo+Koyo/tT4UREzI32d/AN6hfo3vpBwTq8FBnckuxl?=
 =?us-ascii?q?OgQFR7VkdOW03MCYJ7JSYPU9V15HNS/gzK7gAgnBZMU88Wme3DbsMfFC?=
 =?us-ascii?q?MTZIw5yciyDN4oEfpuqRCwYA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 21:30:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703709024; x=1704313824; i=markus.elfring@web.de;
	bh=3e+8QRChfVb09sDrJsxnoK5ykgPCKLhPa32lTc9es10=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=UNjV79qzogBTjGdqiZ0euZ44SodPIeei0/XLX0Uud4zFijZfCY5yucJ+LbI80PUH
	 rGOPpBg/A3VVNhdFt9K35o0M6mEfgBYaDwYcQOYuNkB7Mfr8SjVbJW8QUCSEDwazz
	 SbqmhpS8ewiNFJIUks3NKq07AgswEIQbqZgCmXMliH0SamBrf/Kfp3N4l+FMLDfnq
	 JX9kMMfFXYznH5uA+IKCj9ykB9828njTqISukYtuHX83g0ijTfGMll4yjFH8glk9p
	 Va/gULPrawy1UojlIzACPCojz8njo9vaVAJZXs1Gg1teaaSTwWigdeDCtSTbDbzO7
	 9VUmFseiYn2RofPVMw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N30dV-1r6izN0e1F-012z0o; Wed, 27
 Dec 2023 21:30:24 +0100
Message-ID: <d0a481c0-89ea-48ad-add7-5871d12bf804@web.de>
Date: Wed, 27 Dec 2023 21:30:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: devicetree@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m86qlpsvLCmHOR8Ift9YFMKmHZVSvX/D0xpjcbjNaEeqpznf/d6
 9U2eFisQAIkQG7GeWkq4ivCFJHbJjn+ZcdZs6Ld8eK+7U5xky4sKkdZqpWpvbIBys8uqD/A
 zddn1awvMFLS8+l1Df2TFBVNacgotB82B0r8jt/v48vox1p9FMFLi+0MO2ujZfLlVK2yTCo
 K24Bk2UBs/qd+p+CSBl9Q==
UI-OutboundReport: notjunk:1;M01:P0:mG3OEyBhpRI=;GnZ/IxrdZ5m9z3sapBfs9ly6BZn
 M3bs8oW/TjOX5EUE+m1up9BDXMxGO94lCYCy/+ypnROpvH7Xqp51mtk16PDRx8aH8WF7D/woj
 dd8GUK4IHZAYPEb7eBTAk2SQQr5jeuHrypTnGz1n177v+zGh/1W6GMAg8aW9DHEYp/0UFtDP+
 1xsOzXT2roKxnvpkd3WKji6F1Rv+Yz6F74Ob30l+IQ7wCWzrF4ULRPZAOESPHyG0Ngh8G+Rh/
 H5JjdqkUqf6NqD4qzJoxXX3WySIxBxKOe/lrjRUr7kvz2G9gGk/36aME8sJtkmoAS0HuGnGJe
 vZQaYQZZ/wThhEFEJjhCG4ACyF2Eni6XzVkHLXIUfXucaO0C9Zi++0fPUH+egG+KrufbdYrXL
 qI4huzrXPBAikr96mo77lafuJoTUvV2SgqWws7/s5zVmd/Y2YQaGi1fnhxFEp0TmwKKcIKCuf
 BWJZdhBql1X8InSBXHtEo4oZxQhul7kPAYvJn5529QIySxIIyYonCeeB2oOIudD4ACPsoKar1
 LkAAGTKSJcF45nhmkPaPV4DdNuDg9CKXStCT1BPN7cFA5srnr7/JHPhsCyCBWwsGkM202SN9P
 MC8c7Vof634auMROJBAFWVB19au1gTi7ORCVbD98vGXKBGWC+uq2MLsaOLKRkfeoqIMVzDINf
 hKGoFKd1NkMZFnaqMZtf64d/OBX+sORAGW3xDN3gLDfUUzbrtLDcn828ItvEoA4tjzbN0p5jM
 PGnI+OAcLadhQ84tuUlQBSqfJJytqvVKXAqCWHijwcfNR9QYCmv6XAvHAU7TKOmo3zedZaZwD
 dD3sZEth7G9LKPbiCfXNzngq+T28WQ+QG1PDd2QLh3p4wL8XJi1eDKxsaZ007uw/koqCye/C9
 2/TsVdEAVWgBXn0BJQCKLtTKX5lCmsPaZKpf6BgSsMEj6HoJ+jsH/2tyLqirWFRkr1mS3cw0m
 5QLLkHMDvCSrXBjfPkR2RADMppw=
Subject: [cocci] [PATCH] of: Less function calls in
 of_parse_phandle_with_args_map() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1423
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/d0a481c0-89ea-48ad-add7-5871d12bf804%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Dec 2023 21:21:41 +0100

The kfree() function was called in up to four cases by
the of_parse_phandle_with_args_map() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Adjust jump targets.

* Delete three initialisations which became unnecessary
  with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/of/base.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 8d93cb6ea9cd..b0723d017912 100644
=2D-- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1341,8 +1341,7 @@ int of_parse_phandle_with_args_map(const struct devi=
ce_node *np,
 				   const char *stem_name,
 				   int index, struct of_phandle_args *out_args)
 {
-	char *cells_name, *map_name =3D NULL, *mask_name =3D NULL;
-	char *pass_name =3D NULL;
+	char *cells_name, *map_name, *mask_name, *pass_name;
 	struct device_node *cur, *new =3D NULL;
 	const __be32 *map, *mask, *pass;
 	static const __be32 dummy_mask[] =3D { [0 ... MAX_PHANDLE_ARGS] =3D ~0 }=
;
@@ -1362,26 +1361,26 @@ int of_parse_phandle_with_args_map(const struct de=
vice_node *np,
 	ret =3D -ENOMEM;
 	map_name =3D kasprintf(GFP_KERNEL, "%s-map", stem_name);
 	if (!map_name)
-		goto free;
+		goto free_cells_name;

 	mask_name =3D kasprintf(GFP_KERNEL, "%s-map-mask", stem_name);
 	if (!mask_name)
-		goto free;
+		goto free_map_name;

 	pass_name =3D kasprintf(GFP_KERNEL, "%s-map-pass-thru", stem_name);
 	if (!pass_name)
-		goto free;
+		goto free_mask_name;

 	ret =3D __of_parse_phandle_with_args(np, list_name, cells_name, -1, inde=
x,
 					   out_args);
 	if (ret)
-		goto free;
+		goto free_pass_name;

 	/* Get the #<list>-cells property */
 	cur =3D out_args->np;
 	ret =3D of_property_read_u32(cur, cells_name, &list_size);
 	if (ret < 0)
-		goto put;
+		goto put_cur_node;

 	/* Precalculate the match array - this simplifies match loop */
 	for (i =3D 0; i < list_size; i++)
@@ -1393,7 +1392,7 @@ int of_parse_phandle_with_args_map(const struct devi=
ce_node *np,
 		map =3D of_get_property(cur, map_name, &map_len);
 		if (!map) {
 			ret =3D 0;
-			goto free;
+			goto free_pass_name;
 		}
 		map_len /=3D sizeof(u32);

@@ -1416,27 +1415,28 @@ int of_parse_phandle_with_args_map(const struct de=
vice_node *np,

 			/* Check if not found */
 			if (!new)
-				goto put;
+				goto put_cur_node;

 			if (!of_device_is_available(new))
 				match =3D 0;

 			ret =3D of_property_read_u32(new, cells_name, &new_size);
 			if (ret)
-				goto put;
+				goto put_new_node;

 			/* Check for malformed properties */
 			if (WARN_ON(new_size > MAX_PHANDLE_ARGS))
-				goto put;
+				goto put_new_node;
+
 			if (map_len < new_size)
-				goto put;
+				goto put_new_node;

 			/* Move forward by new node's #<list>-cells amount */
 			map +=3D new_size;
 			map_len -=3D new_size;
 		}
 		if (!match)
-			goto put;
+			goto put_new_node;

 		/* Get the <list>-map-pass-thru property (optional) */
 		pass =3D of_get_property(cur, pass_name, NULL);
@@ -1465,15 +1465,18 @@ int of_parse_phandle_with_args_map(const struct de=
vice_node *np,
 		of_node_put(cur);
 		cur =3D new;
 	}
-put:
-	of_node_put(cur);
+put_new_node:
 	of_node_put(new);
-free:
+put_cur_node:
+	of_node_put(cur);
+free_pass_name:
+	kfree(pass_name);
+free_mask_name:
 	kfree(mask_name);
+free_map_name:
 	kfree(map_name);
+free_cells_name:
 	kfree(cells_name);
-	kfree(pass_name);
-
 	return ret;
 }
 EXPORT_SYMBOL(of_parse_phandle_with_args_map);
=2D-
2.43.0

