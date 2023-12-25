Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EBAC3DA6E
	for <cocci@archiver.kernel.org>; Mon, 25 Dec 2023 17:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=zwkcZlScIHgMX0RdMoUCM38i2C2jaWbEfTfy7qAtlpg=;
  b=QxN4f6EIZwH8AkH3eCzv5b3f+YMASSHQD/FEKl5XTRk9QM8yh+SOu5ul
   EacEOdxnWdvZS8ThdSOHIrxta3G3awsxRcWXRfxDz3DCYkSPN9csu097y
   U14Ojsn/qzvrn3un4pYUtXpPz2GTgH8QRKxgfHYSC+zBCIJ9Og6GT5wYn
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
   d="scan'208";a="143989858"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Dec 2023 18:36:39 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7DDC8E0AF1; Mon, 25 Dec 2023 18:36:39 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D1A83E004E
	for <cocci@sympa.inria.fr>; Mon, 25 Dec 2023 18:36:33 +0100 (CET)
IronPort-SDR: 6589bda0_5wb+dcBGUB+felKSlwNjJ+xEJCRvZQDeMS6tdSbWAwllCwI
 LijLrF7KnjY04c9NZr/sev7325B2BedXm/a/wMQ==
X-IPAS-Result: =?us-ascii?q?A0EgBwAIvYllfQsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+COYFSMgQLSIRTj0GBdTCEO4c1h0yIb4MWPg8BAwENQQECBAEBAwQ4hEcCh?=
 =?us-ascii?q?zYCHgcBBDQTAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABASQYB?=
 =?us-ascii?q?g4FCyeFbA2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR0IDAyMdAQERJ?=
 =?us-ascii?q?gEPHwEFAiYCAlYGARICAQGCfIIrAQMxB68jgTKBAYIKAQEGgmasch8sIlaBY?=
 =?us-ascii?q?AmBGi6IGwGFZ4NBeicPgVVEgRUng0GECoQUgmiJHAcyghyDT5FZfQVBcBsDB?=
 =?us-ascii?q?wN/DysHBDAiBgkULSMGUAQoIQkTEkCBXoFSCn4/Dw4Rgj4iAj02GUiCWxUMN?=
 =?us-ascii?q?ARGdRAqBBQXgQ5uGxIeNxEQFw0DCHQdAhEjPAMFAwQzCh0LIQVWA0IGSQsDA?=
 =?us-ascii?q?hoFAwMEgTAFDRoCECwnAwMSSQIQFAM7AwMGAwoxAzBVRAxQA2wfMgk8DwwaA?=
 =?us-ascii?q?hseDScjAixCAwkKBRACFgMkFgQ2EQkLKAMsBjgCEgwGBgldJgcPCQQlAwgEA?=
 =?us-ascii?q?yspAyN0EQMECgMUBwsHUgMZKx1AAgELbT01BgMLGwY+AqZLgQ6BRYExxQE0B?=
 =?us-ascii?q?4I0gWCBYQyfKwYTL5cmDgaSVC6SUIVPIKhGgXojgVwzGiSDNk8DGQ+OIAwWF?=
 =?us-ascii?q?oNzjwkBPUA1OwIHAQoBAQMJhUYBAYMmNIFGAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ihv9KK5pOobfU79/JgPXwBzXdLJyesId70hD6qm+c20wTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhX4tKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkYNDSaNzhHZKjBkWyFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:0k6Px26QIWk10UUKOdssqUsmPJobSkbh6liLckujGDlVc7SLYArF
X-Talos-MUID: =?us-ascii?q?9a23=3AN1TLpw1UgqL3Ge3OVC4mIn+HujUj/4uFKlsNr5g?=
 =?us-ascii?q?/49itBQNTKgW6og+eXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,303,1695679200"; 
   d="scan'208";a="75326212"
X-MGA-submission: =?us-ascii?q?MDEbRsSxKhpgY+2YSpRk1tXm2zs2HkINgHI5Yk?=
 =?us-ascii?q?8M84RHMhzyf4QLVGm6iogWDyMZJ1u72WlQGxJOr4aF2ZmBRdCWki6BiK?=
 =?us-ascii?q?grV92NzKEtm/Hn7ZXd/OIfnqMdapurWWfQ5IkNK2w9fEj+b8W1yQtFkn?=
 =?us-ascii?q?wgV7Y9zjWMV9T+gehJOpjWbA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 18:36:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703525780; x=1704130580; i=markus.elfring@web.de;
	bh=6YbgzX4IlCp5KaOe1RjzChWQs5gtWK+ZeLnQ6EfDZlc=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=r32ESMkzGobCaa+TbXSVG8ctXjGd5HH5sZKeKPmp6YZK9Vw2Wp0MQHkwKI3TDsNt
	 7IBNMJLrbOIalQcTJPrbEqbDv9QxZR5lQSsVvD5dZN4MSZ+WFZxBjkVhh5AmNiphP
	 0U+6K/aM2e0VPZqo2NRrusfowrLH7dcB8SJDct12W8oVi4zgurjRFi8HFoXzUrq1u
	 wCg9e7D1umq9PmvcHnsaDuLv7UH5ad9srjeIOAwYcbCzCkEHlnVruzwZ7O3yHVrCW
	 9bndfhVeph5PcmClXTKu/cWNtOghOXHbscnMXGAaln4GuuUidfSGtVVF1poBIhx+7
	 p/qudgR5k1aYJEEpXw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPKFD-1rcTt31g33-00PlHa; Mon, 25
 Dec 2023 18:36:20 +0100
Message-ID: <e4c0344e-81b0-47d0-b115-ca7f5590009c@web.de>
Date: Mon, 25 Dec 2023 18:36:19 +0100
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
X-Provags-ID: V03:K1:Cwcco78JixBvWs3sejkpE1/Op33Uc5UEd2qPxoLTasMwqfRd/u+
 2Xe//62EaQWi/BGoga/Kf5B4juLF8Qja7neUpiUujsEqDaCDy3coL6clkDyV9/B96K8ipf6
 jHjPHn2JWPbTtFF1gE9lp+S3nzb47GmCCZAPyYQZDEdBRimYdI8j8uKnnfTfzMeK8Gjn7Fo
 TpIUegBgedkf08+kfVryg==
UI-OutboundReport: notjunk:1;M01:P0:KkYp2qCitf4=;2S7BX8fX6dNziIhWeaAu3J7ZMNO
 LvgHHGbUyT8spp1asXU8Dw0TJ/cd5uIM0cNisH4OvLet2BHItSg2egbsP9/0l/S4mtTQfrwpy
 qLEmImBwSJKw9bGcBFu9wYTHwG4FQTH8WjfJo8GKQXAQ+y/+Ebv10zc/3qO2K3qd7WOK4ikkj
 UQ8S8tO6XYjrMNNwvJWeL7ZkHQEjW8fMHewEJZkt/MjVYY75bfh2a40gi1hlPoiLdiTTKHbYn
 YhQB4FUHPHis10bZK713fqA8tY4hRY92fnUiWhtjXHAl2eckyGji+kLTGbBK/G97YofQIT0f4
 FzChciIrpGT3erPLBYe8f2nkEvb/nvltQ8nPF6FTEF/37WJTdFgT7Vfw2/r7UFx6sUy1iwr4i
 8T8HXhRgB/cCeyjqjss0ppeX2qsH9J8K2l5NiqAMvyM2rs5wauw9M61Ne5xpUwkL1n2+fOI8J
 ql042PMK06KBEJkND8/ju7Bpj2W9OI2ArYiQ3NCYLo4l6+g/A9VHnYLTbq2avlCtX7wS8bpCH
 EoNhMogMInwWuFqlEfNcxl4OMV09ktcSAq6GYDezhFFs+TZPXp9o51asbY02nVviDs55pCCTf
 4FP8QFd/WgzNnWBA6xhFdgMrH9absOWATDeRBXmlZEHxzqnc2k/u+W+85GWk+fwS5rAsQBDUo
 Hy9bs4xvm25eQM3jOqQkM5hz5MsHEZ0Ef5EgJHmK48KODaAreSA+b2kv8rpwJMnjUge2wtlpz
 J/QN9tzt/mKVkX1Z8UUw3VuVF+Vppkpt4svO4i9gDxh47Wj47B5daIx9X3LIIihn9NvZvSsmH
 WfoxAC0iublxZUjUemxuR+4aDP5PqPzoLWYJnUMmuj2t5uzgl8XbkSo2i1V+tb8+sYr+NKgUK
 VdpGcQMT7A7J0eE/CoJeZBEMKoHQtjcM0KMLfyTYWrQVF2WPpn390gYtluHA8AawOnSie5pAk
 0AIq0g==
Subject: [cocci] [PATCH 2/7] EDAC/amd64: Delete an unnecessary variable
 initialisation in amd64_edac_init()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1386
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/e4c0344e-81b0-47d0-b115-ca7f5590009c%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2023 16:33:22 +0100

The variable =E2=80=9Cerr=E2=80=9D will eventually be set to an appropriat=
e value
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/edac/amd64_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index f912cbadefa4..8a27a4af7121 100644
=2D-- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4396,7 +4396,7 @@ MODULE_DEVICE_TABLE(x86cpu, amd64_cpuids);
 static int __init amd64_edac_init(void)
 {
 	const char *owner;
-	int err =3D -ENODEV;
+	int err;
 	int i;

 	if (ghes_get_devices())
=2D-
2.43.0

