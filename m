Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26891C3DA6E
	for <cocci@archiver.kernel.org>; Mon, 25 Dec 2023 17:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=0JAXjYlK/hdDxyqwIJiZjYIRM0b+Neb+hXqSKlRvM/4=;
  b=ti3bE8NyyrbMcwsMBh2ybghCRcR14EpVt5qc3V3EPr2JVr73Wv8HudRN
   cST+xftqWpLKUTG7OwA6DkDZTPyYqoXiExcZau/RDj0UcWbGviH5msbsq
   NvovA9Ztr4aSIHQeP6L7iSM2fuE29fHIfMaRZsmfx7CaQYJZJTiZiGROt
   c=;
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
   d="scan'208";a="143989939"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Dec 2023 18:38:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 68402E0CCA; Mon, 25 Dec 2023 18:38:54 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D8634E004E
	for <cocci@sympa.inria.fr>; Mon, 25 Dec 2023 18:38:52 +0100 (CET)
IronPort-SDR: 6589be2c_ndyKn69Ybj5pk3VQyeDYx/BCjGuPJaKQMPiOo46qp63lz92
 89Htzs4ob1jFnXVPfVwrv8rlqEoDAJup1W8J9fQ==
X-IPAS-Result: =?us-ascii?q?A0GWAAAIvYllfQsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYI4gVIyBAtIhFOPQYF1MIQ7hzWHTIhvgVaBQD4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEOIRHAoc2Ah4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBJBgGDgULJ4VsDYJcARCBDIEeAQEBAQEBAQEBAQEBAQEBAQEBFwJHQ?=
 =?us-ascii?q?gMDIx0BAREmAQ8fAQUCJgICVgYBEgIBAYJ8gisBAzEHryOBMoEBggoBAQaCZ?=
 =?us-ascii?q?qxyHywiVoFgCYEaLgGIGgGFZ4NBeicPgVVEgRUnglJviB6CaIkcBzKCHINPk?=
 =?us-ascii?q?Vl9BUFwGwMHA38PKwcEMCIGCRQtIwZQBCghCRMSQIFegVIKfj8PDhGCPiICP?=
 =?us-ascii?q?TYZSIJbFQw0BEZ1ECoEFBeBDm4bEh43ERAXDQMIdB0CESM8AwUDBDMKHQshB?=
 =?us-ascii?q?VYDQgZJCwMCGgUDAwSBMAUNGgIQLCcDAxJJAhAUAzsDAwYDCjEDMFVEDFADb?=
 =?us-ascii?q?B8yCTwPDBoCGx4NJyMCLEIDCQoFEAIWAyQWBDYRCQsoAywGOAISDAYGCV0mB?=
 =?us-ascii?q?w8JBCUDCAQDKykDI3QRAwQKAxQHCwdSAxkrHUACAQttPTUGAwsbBj4CpkuBD?=
 =?us-ascii?q?oFFgTHFATQHgjSBYIFhDJ8rBhMvlyYOBpJULpgfIKhGgWUCNoFcMxokgzZPA?=
 =?us-ascii?q?xkPjiAMFoQJjwkBPUA1OwIHCwEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
 FAiKzrOAb5c3eMInYVDlwLW/5dCS6Y0cA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:IgL3sq9Nsasl8GRMy6duk+AMI+orL9Y04lQ7vn2ZhyYlFvBw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNWftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOb+EYZmIbsS+V2njcL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: 9a23:QmrDtW78hlvyN2EaLNssy09LQN0dfWXn03bzGhClEltNZbSYRgrF
X-Talos-MUID: =?us-ascii?q?9a23=3AEclkhg870MvqAOisVxFEo4WQf9pVpLSvNFsMq5M?=
 =?us-ascii?q?LpJe4Oggoawqnrh3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,303,1695679200"; 
   d="scan'208";a="75326271"
X-MGA-submission: =?us-ascii?q?MDEQ7L4OhBTd9kQBBEt6mdiGG3Gsj1OxAvtV1p?=
 =?us-ascii?q?koV5QkEIQMlsXOVvKbVGG5NedGYHhxCxEVombqaBpfcyYRWqSGhs+kBX?=
 =?us-ascii?q?FT4GIAJFExxnFRk0CuCtkVTeCy+INoE2+QxhVNbEqIryfSGf951D3HeR?=
 =?us-ascii?q?4SlWf0ppP3DVnYoRQMGc1Xgw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 18:38:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703525892; x=1704130692; i=markus.elfring@web.de;
	bh=j0FKcxvxQfC448I2h8pj0eT4D4GEbJBlPEXrdpAO+2I=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=RA6P1cns5bH5XZAkWogysVVZpXDL1ov0hIdI0dFSrPlsRyIuZIfbGUCfsg4muGLu
	 TJWuZ08G/CTjYcRju2Ioh8wjetls2Bzi1MpREpq2PFGfRM1m/TfLvvT9no7InrjfM
	 ZmR2bKpHQqiWMTJbo22X/iIc8oWgcDs7xpN5e/+XuqI/P6duTzRHFYIom5USDcvvs
	 jGAsK+lFh/YWX4cqA58g+WS52yUecM3UyPCU6z4nGfqC+Ib0+vfebvYDcm5VHauMS
	 cWmXMY/CRJb2hT9UqEVoql+5D9m6x3U3unHpt5QJSHtsLam8KEM0ITOMBjAoCD9/H
	 /mmjw5Qnbl+ETXlDDA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M59nK-1rIupc0ws8-001dTT; Mon, 25
 Dec 2023 18:38:12 +0100
Message-ID: <644d3bff-5a21-47d2-9e36-06475d472253@web.de>
Date: Mon, 25 Dec 2023 18:38:11 +0100
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
X-Provags-ID: V03:K1:0IDoyUT/jRJx6zuJyc7dROs6A+EuRf113hAyHyLWMNk2psUzfIS
 lvXFoI0/RHVmz5d7VHoNzISVCQ0DAj8CVtcrfZ5JRT6sZWv4ShYtb/sOpYe+9k+CDeQHKOJ
 zLSSnGl4ulTmfO0A38teQpm/1wAlWmg3hQ14Z+5TapRyVUpYirAq2Go+kcFl4816vUHcWfk
 6TCTgWKRI3sWk4kgXPc+Q==
UI-OutboundReport: notjunk:1;M01:P0:eOaklonjYc8=;Oz4K9nCLExNKL/flrq3Vuiou9BZ
 5FcXhLT2nr90iWusB8FZiCLXHhZL8CYzHLLoud/gPkFzCsVyu6pqNDyqqe3/H6zV7sRMrIUmb
 gy7C42jBqpLGslXnl5CVMTvGiteJdYrveFaRqUYW/bsXIp45mjIOWdnAqYcC1EE3SaZYqQ+9u
 EoTcJX5VPG/LjI7QPSv44vKSYUASIym1XyN0Q//n8iRc4tDGwTEqeis1ScivKEpXiYzkdsW2N
 dhBmZtF6zo9H3wHcnoxyksiYOiB0Q0phYBBU35VoxTjDzQnSWzAxheGYL53PXq4AhUKimq9to
 vpZ10WuZ7zVszRJlngNIGjf6dFvZ8l7gFfmJqjrpcQMb/W9xAk3z7o0CcYmDyLNDCvA5lCE8K
 Ks7ALexQW7bDXUFvPjbbOU/scVd4ulxUqpTcmumfNsA45G7+7rCN+2vaO2vY0Itpki2CqryWK
 Eo1Nz+nn7Wh00NzniVhOZVhzsE7WifAThccd6hqFeGyT5DUqw05DURVKp02xMoZYSULZfQxi9
 yUAXVoh5QVHCjEj3k6QFwWvRXza2P3EgogDs91Ajbyu8WuZXOOMybUzzKQrhWPFI1PkaNc6L/
 ZUrkDc6sp8Ekctw6xcq7V4yW3fWYX8irzXET7vgF/XKPbQIoBkDC+PlYJLXVmVfvbDvQ2mKkw
 Spzf9/OpAVDsK1aPSdvu47UHgHbrOjQ6bGvh7kJAvw1tQl13oy+cYq1dKN9UExurm5MRi52uW
 xI1xOPdCoDi8aq7kM39WlQ9O3LHF9Uw36kXXbrKrdu6Ren4xhUgfmEVT0nD7eXi97VlfoI8cV
 IBoW0u/chcni7viCbaQNqOMvIuqiUdv4kQuwqiAvzHTbGZAPBKtRzxbHiMJ2l5/BFo6Ut3fEZ
 g2me4qOyZPnsl4HOksOKc6sgcv9Zfm4/07S6ppuXvFlGCnOk1QAE7fO0cpu/jlIlqxdRZgBCf
 VMe70w==
Subject: [cocci] [PATCH 3/7] EDAC/amd64: Merge two if statements into one in
 amd64_edac_init()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1387
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/644d3bff-5a21-47d2-9e36-06475d472253%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2023 16:45:37 +0100

Two if statements were connected with the same return statements.
Thus merge their condition checks into one statement.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/edac/amd64_edac.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 8a27a4af7121..49f3d9b54902 100644
=2D-- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4406,10 +4406,7 @@ static int __init amd64_edac_init(void)
 	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
 		return -EBUSY;

-	if (!x86_match_cpu(amd64_cpuids))
-		return -ENODEV;
-
-	if (!amd_nb_num())
+	if (!x86_match_cpu(amd64_cpuids) || !amd_nb_num())
 		return -ENODEV;

 	opstate_init();
=2D-
2.43.0

