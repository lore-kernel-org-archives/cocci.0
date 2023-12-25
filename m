Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC2BC3DA6E
	for <cocci@archiver.kernel.org>; Mon, 25 Dec 2023 17:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=euE6wipWVqr1dlKu/ekpCg4FTnHikvpBzI5hIwBpMGc=;
  b=U5NxKo/BuqK4WvoRpY5kYa6OKXWoIewNYQgg3UlpEJfvvIcJtaRk4nzz
   bnPgBLAfHRAvzzMHylgggVlXAiGqYkHKcw6In/D54Z0YFBGm4jWSvotoC
   DDd4pT0cafd1N9x8SjcJV2OhHgJqjFThtPDXtaUIB1ckTOVFynt7wDmvl
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
X-IronPort-AV: E=Sophos;i="6.04,303,1695679200"; 
   d="scan'208";a="143990129"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Dec 2023 18:44:36 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5EEC5E0CCE; Mon, 25 Dec 2023 18:44:36 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 92874E004E
	for <cocci@sympa.inria.fr>; Mon, 25 Dec 2023 18:44:31 +0100 (CET)
IronPort-SDR: 6589bf7f_sirGXuv7vlQkydQ47HgP6qoPtMYoz4c5bNMLfw/sLKyFrRF
 GRHeOGbEmAMm9f70DFe8rjYhHPQl60AsWBtHf9w==
X-IPAS-Result: =?us-ascii?q?A0FABQAJvoll/wwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+COQeBSzIEC0iEU49BgXUwhDuHNYdMhGuEBIMWPg8BAwENQQECBAEBAwQ4h?=
 =?us-ascii?q?EcChzYCHgcBBDQTAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAoEGE?=
 =?us-ascii?q?4VsDYJcARCBDIEeAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgYjBBkBAREmAQ8fA?=
 =?us-ascii?q?QUCJgICVgYBEgIBAYJ8gisBAzEHryR/M4EBggoBAQavWB8sIlaBYAmBGi6IG?=
 =?us-ascii?q?wGFZ4NBeicPgVVEgRUng0GECoQUgmiJHAcyghyDT5FZfQVBcBsDBwN/DysHB?=
 =?us-ascii?q?DAiBgkULSMGUAQoIQkTEkCBXoFSCn4/Dw4Rgj4iAj02GUiCWxUMNARGdRAqB?=
 =?us-ascii?q?BQXgQ5uGxIeNxEQFw0DCHQdAhEjPAMFAwQzCh0LIQVWA0IGSQsDAhoFAwMEg?=
 =?us-ascii?q?TAFDRoCECwnAwMSSQIQFAM7AwMGAwoxAzBVRAxQA2wfMgk8DwwaAhseDScjA?=
 =?us-ascii?q?ixCAwkKBRACFgMkFgQ2EQkLKAMsBjgCEgwGBgldJgcPCQQlAwgEAyspAyN0E?=
 =?us-ascii?q?QMECgMUBwsHUgMZKx1AAgELbT01BgMLGwY+AqZLgQ6CdsUBNAeCNIFggWEMn?=
 =?us-ascii?q?ysGEy+XJg4GklQuh1CLAIVPIKhGgXomgVkzGiSDNk8DGQ+OIAwWFoNzjwkBP?=
 =?us-ascii?q?UA1OwIHAQoBAQMJhUYBAYMmNIFGAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:SWHzVK0W6o2KRzCf9EteOAqjBGYkLtp133Aq2lEZdPWaSL39qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SPjUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyWMbEQt6bHCWeDYrMd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:D3nDVWxPpz79yfb2qgkWBgUPIvsBU1OE0E7ZMkmfGVpMV762Ug6prfY=
X-Talos-MUID: =?us-ascii?q?9a23=3Az95MkA/KVFEqewoArghleNSQf+lX072fUEYWqpc?=
 =?us-ascii?q?DldanHwhgGgrAqB3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,303,1695679200"; 
   d="scan'208";a="143990125"
X-MGA-submission: =?us-ascii?q?MDGLHAfIFClGn6z3fDch20R+gk6x5mCUovjbBz?=
 =?us-ascii?q?2uTWMTyYOVZpD+RH5ML/BRS534lZSvg4lWXOwfb9fmWIqqAXrNg55AqE?=
 =?us-ascii?q?NDYgD3LUS3JUZdggPgJDK0auSkuOPxbV6ICDPYSjv622+fwpjl0WZgI4?=
 =?us-ascii?q?AlOZDlCKSO0H/4ozLni9cmjw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 18:44:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703526253; x=1704131053; i=markus.elfring@web.de;
	bh=RztvVJkiqN6k6MAkMSOfzbHfNuTEw4Oiqcl/UjOdytc=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=BRgVjKbCkwimRPbV0xi6sn4JfyUN/SzJgjz8cOM5S2JoP1OXON/UwUFDpHauZHqm
	 tOeczZtc4kAH3h4oeMjhT3RatwqgHxRckDEQotpj7/t1W4nnTUE52FbQ4LPyWpwLF
	 Vj/4cq0CClA8GU9SDN/M7dktQakpZRwz4FQk2QPvjz/AKZJHJ4WwQcIIJwhypHHc0
	 g1cBzDutd44pLitRq4V5q90wCspsx6tQMOPRLqBst0+TlzyV1N68otNR18xCnFbpQ
	 AuaYYK/gZmuBQIcjmGDDk+Qzc1I467ySsCaA/X+9sZky8tToIjTWrA8EAbH9OEqiV
	 1dvx5Apk+4BxMxvZvg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVaYw-1rjLj72n6y-00Re9o; Mon, 25
 Dec 2023 18:44:13 +0100
Message-ID: <d6e6c098-ccee-4cf0-9dbf-714989945196@web.de>
Date: Mon, 25 Dec 2023 18:44:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-edac@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter
 <rric@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Muralidhara M K <muralidhara.mk@amd.com>
References: <8c9e2c01-9ed0-4392-af40-4e8eb393cb67@web.de>
In-Reply-To: <8c9e2c01-9ed0-4392-af40-4e8eb393cb67@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tguqig1/d9Gquv0duF+HYbD6u0Nq0ecs9k3puuWqEaduLqMP8OF
 G4a21omXnXOFpHBg2wi7+aR92clYLkKHm1+9XBeRYSheetn+JsHA9uKBjG0dgaq+zaaR3xY
 OtNVeH+++yTq54V7fXUILiAmNH9KD2CfeSSAN2G7H1ksOx+KX7WY1kSqHu5L+eu8PhfsrBn
 AZVC3bVkjhOI0ERjx1mhA==
UI-OutboundReport: notjunk:1;M01:P0:XsXR/k+e8AY=;T5v8XO6GeyaX87PWrmzvSBStT/Z
 nLPSHKRzZdcS7j+BOOU6XYHJfHX1wiezd1OFxQpG04KJse2qPMYEBRJKh4nAI+bHvMxwVAIAB
 vjBwcnsnm5jDO2NosbNcJFc58yGMZm3GMJewRe9lG+yE20eM601t+CGiAMsCPdxiP7G6OrVHJ
 gsE22naXBT+dxpwcQjDQJL/xRol1qfyDWyiLAvDTmeZQ88DNjKogIyszaSqrEtpIMo/FK5TIo
 x0T2Odztm+LGQKYNH2MfiN71BIh28whLF9lK7LZCOuu2Ky5I4xplJSNsQtVstIDFSW65VE87P
 GSyfpghMAUhhgIP58YwemmIUADW4elWCCyzzhDd+kMJuZ+qx0eMksumHfknPMrJ6bg86T58GA
 5HZ4wpfDv/xTfxA8Fyu1X/ENw7SVc7iSi0A4ei4R93BpqO85dVatdGQxhHeLPqiQtbawtR4Fy
 Xm7/emiaHBOoXF0XotHtHcG9UphMCPmQGZ7pVPQd3WFARZtMUDs9ECXLDXnEc8frWyxduR6Ub
 hc3C7/sO71h/8MIonMNgBkdKaOeIBSryK9IE/c1uSCrbT7wtp2NgU4HCA2k7FefpYhCbSEYt3
 EPUgbU0ZEC0QOm62+IAvASGMbV93JXtKN3qto+mDHqwjVE0YbWwKFS/iIsRWqYqVioX1yJfqu
 4JtY1OKNFrN97jBU3/bYOZ7H/CO+nS1D44D5A8Va+dTAJBS8/TTRJwrkrW59VTQsQBj+1UitU
 FH6Qmyvlx76pVpTSySZyc1icdN4OprxM/R2IedGGIXOmJ8yEnnSA3EcYz+Mifc5hgqBHj4OK+
 GbW0U2f/bKMB/zbkuuOal0pBVgxSDpgkPdIOxZQdL3ASKerCoA954gVltfxLrRIPoqGCtghuy
 Y7PVG5mqy+L+fhAsbtG3KAl0KAsiNASLtXLzGErxqdu5epnuOdOMyKrK4FnyqgJ4L0rbVnoqO
 F4dysw==
Subject: [cocci] [PATCH 6/7] EDAC/amd64: Delete an unnecessary variable
 initialisation in probe_one_instance()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1390
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/d6e6c098-ccee-4cf0-9dbf-714989945196%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2023 17:34:35 +0100

The variable =E2=80=9Cpvt=E2=80=9D will eventually be set to an appropriat=
e pointer
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/edac/amd64_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 7536236df542..698cde573847 100644
=2D-- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4264,7 +4264,7 @@ static bool instance_has_memory(struct amd64_pvt *pv=
t)
 static int probe_one_instance(unsigned int nid)
 {
 	struct pci_dev *F3 =3D node_to_amd_nb(nid)->misc;
-	struct amd64_pvt *pvt =3D NULL;
+	struct amd64_pvt *pvt;
 	struct ecc_settings *s;
 	int ret;

=2D-
2.43.0

