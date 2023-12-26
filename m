Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5F7C4706F
	for <cocci@archiver.kernel.org>; Tue, 26 Dec 2023 19:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=GEMLMY6J2bWk2/OiN2oi+jqnp3wOKqD79Lx63fDJg5M=;
  b=r8SudC9YXWW4uuWVxlY5PjBqDY8urADX2Fg7NkHIeXyLZhW04ah8Yupw
   miDpj6ky1mjRMo+1nRhblEj1mtCN9bkvAQ5LzsYmJf975LLTuQhNA1Bh6
   qwI3gAKD3n1y5n2hDZ5vQEGr2eJVSfi+yj4SyINofWNi0bxtdZhYpdwjY
   s=;
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
X-IronPort-AV: E=Sophos;i="6.04,307,1695679200"; 
   d="scan'208";a="144073397"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Dec 2023 20:09:40 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9EBAFE004E; Tue, 26 Dec 2023 20:09:39 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 730D8E004E
	for <cocci@sympa.inria.fr>; Tue, 26 Dec 2023 20:09:34 +0100 (CET)
IronPort-SDR: 658b24ee_JFy1yK9A8Jw07xdK5gsLdhM8BGJJk+sjuWrEcp0poh6jRQ3
 nsrJH/KZBG9qK9M3CxdfOfYLYbg8BpgVnElfA6w==
X-IPAS-Result: =?us-ascii?q?A0EsAABlI4tl/wwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4B3hTMgQLSIRTiB2HJIF1hGuHNYw3hASBVoFAPg8BAwENQQECB?=
 =?us-ascii?q?AEBAwQ3AYFTgnSHOAIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECA?=
 =?us-ascii?q?QECBAYBAoEGE4VsDYJcARCBDIEeAQEBAQEBAQEBAQEBAQEBAQEBFwJHawQZA?=
 =?us-ascii?q?QERJgEuAQUCJgJeARICAQGCfIIrAQMxB68MfzOBAYIKAQEGr1gfLCJWgWAJg?=
 =?us-ascii?q?RouAYgaAYVng0GBIQ+BVUSBFSeDQYgegmiJGwcygh2DUJFXfQVBcBsDBwN/D?=
 =?us-ascii?q?ysHBDAiBgkULSMGUAQoIQkTEkCDLwqBAT8PDhGCPis2NhlIglgVDDUERnUQK?=
 =?us-ascii?q?gQUF4EPbhsSHjcREAUSDQMIdB0CESM8AwUDBDMKEg0LIQVWA0IGSQsDAhoFA?=
 =?us-ascii?q?wMEgTAFDRoCECwnAwMSSQIQFAM7AwMGAwoxAzBVRAxQA2kfMgk8DwwaAhseD?=
 =?us-ascii?q?ScjAixCAxEFEAIWAyQWBDYRCQsoAywGOAISDAYGCV0mBw8JBCUDCAQDKykDI?=
 =?us-ascii?q?3QRAwQKAxQHCwdSAxkrHUACAQttPTUGAwsbBj4CpkxTKBNMJoIEsECUQTQHg?=
 =?us-ascii?q?jSBYIFhDJ8rBhMvlyYOBpJTAS6HUJBPIKhGgWM9gVkzGiSDNk8DGQ+OIAwWF?=
 =?us-ascii?q?oNzj0dANTsCBwsBAQMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:q8cgZK1h2iqfFrsX/BneSQqjBGokLtp133Aq2lEZdPWaSL37qy
 ncpoV56faSskd2ZJhAo6HmBEDkexjhHPFOjrX5UY3SOTUO21HHEGgB1+ffKlTbckWSygc379
 YFT0ERMr3NJGRbyeDn/QK/D9Es+9Wf9ru07N2utEuFATsKV0l6hT0Jczpz/3cGPDWvjvcCfq
 ah2g==
X-Talos-CUID: =?us-ascii?q?9a23=3A0inkbmoEwpfaiblZGb6PMZjmUfEeMXzwkVTeH2a?=
 =?us-ascii?q?fA1Q0SLjSZwS0pbwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AX0BVJgxJQm/5fU/L4KJnzFVkiMKaqKiFL2w2s6k?=
 =?us-ascii?q?Pge3HLT1BIDCDkQ+FcLZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,307,1695679200"; 
   d="scan'208";a="144073395"
X-MGA-submission: =?us-ascii?q?MDGST5vlVe8B3i4cWAA50riO6O61ezUmZhxpLc?=
 =?us-ascii?q?mU4Zg+wcRqWxuijKw2/M4k4eQ18SI13P+N4hpyhLliRsfZ+TEtgQ4s62?=
 =?us-ascii?q?MXL3fAGDgFglnK1blLmCQpCsy9X5zgVO0F9kWywFd0bU96TBKiTs2fCo?=
 =?us-ascii?q?RD1pOnnck5CoGafnSYpmhXFw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 20:09:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703617762; x=1704222562; i=markus.elfring@web.de;
	bh=e+tBrgtJfsdqXLShYcAxcZWtl8ArgkpUQb9HNhch+6M=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=w6g8HZHEkpbryK5BLDOeQWt+/lpBqoGxbDnbb6dN2GVLEfRNnSHi9bdFdPHFbkCa
	 QhWK+kIgXhjLVN6WqKbTGFrLpPIRDp9BybrEMyeb0i6/3kZsyKlNwHG/j/slAIhPQ
	 oOEJml/hef9AR9qqJv0XjqjwoPu9WUqQvIKObyp8VlnXT/LZL/TjwVkUyvgAtVer5
	 1yIUpVS/PO54spPLEyzKhqLauqEHGrCy4sjZSSwOx2tfgKDmL3Pr5Vx95ZbnzZ+rv
	 UnSzlSkjQt1fszmBObyacSzmqC0KiYFyHE3yN1Nui7flNR4QA1MVr5c37DwACObqn
	 1lGohnSUrYvql7oRlw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQ8Wg-1reI1y1bJg-00MCdT; Tue, 26
 Dec 2023 20:09:22 +0100
Message-ID: <6d97cafb-ad7c-41c1-9f20-41024bb18515@web.de>
Date: Tue, 26 Dec 2023 20:09:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-hyperv@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wPOvhj5sZIFHtakgOhvLyjOxfuTw717tJTZVuzvrrqw47k7mvWx
 CyzpwGDn4gaBT1CJjpK9GVIIMWi/S+S+fIkUTwBRp1cLMH3aCcOGz/YfYnvNQb+99MMh8oI
 tB8wP2yHdAK21v+JUtEchHHOWMoILWeamZmQXeqoP4qlu2NabSKEM484Z3soOjX+jFhTJ4C
 aeh2fY1OkfpLpgsLxcGMg==
UI-OutboundReport: notjunk:1;M01:P0:+GuqX/7+844=;mKtO/t28dF5Noz7+PWV5uyi6UzL
 7/31I3cEvXRYkQWA+hVKFQmOeWLyICCOmKCGX5QtKx+VQzGz5J+xCACsIPokktvmKoVBaUNOl
 xNZkdW643wiWYJnR4le5+YS25/scz34z2OIsXOdVCh2qons627KD1GqYZ3UcvHSZWavrvPYOc
 GrsvfGdSMZaoolsz3DLBivmTL5uaL2KCwkEbR+qHp7CTuvrP1Tdfr+I59JELsF7xpusF++GQ7
 IIEuf0UQDPAGvxV48JJ6ZOvpuBOTe2Lk7sbu8Y6BeD7XNxyU9pFSpLdqEoxfSmeYKakeKgBIJ
 mLkEkLA/hHZOtmywAxIOyCmJ6sMSNjh1DuLqQl14FHXGTs3ShtVGMk+eIaXOXgjhbGFS2bYfE
 wDaQKwDlzYRvw5b6b5oz1tIMVV6eYS/R3Zxjjng3IB/05hx0w8n8Y38G56pzoMi3Ol1ccfCVj
 7aV89aa0n6Wgq1vb2YT4QGcnFQQEY579fhcceHzZF+xl+vRGVYMWtqOUnJydIope45l1hcTjx
 Y6PKyXeU5EcnjGjqpvhSi5dr5l27OA7BYIN4/Lh0uJ6sTd5S+n923nrCs2vnVKmsoGSzMCEXb
 5ShpvJ9SNR8aYqW6E+hyPLSCD6qxZAtgbxrjR2umD4489dOR3+hsr57JNZMIqhqzNZ8/FdDiz
 Nludh6j1qcdUdb/4EnZAt36PhVW46UAD+5SkcfvbDYGl1CJIUkW/U7GDQd9qs5485X7xqbTm3
 DAdMQaJIES6dm3aBZtoKAtKF7LaKKj8n72SiZYMGgyhZtpZLAS0UsAO5DEslJ7mkpPy8ot9n4
 APzpn7lW5qWto/xov4OzKsFlsKOGypiVfz6kco8PRYqkkKsU/OjiQZ4HvOpGkOY2frbVDvkjw
 o7Pk8FS2Wocgqn8Im/UH49p0ICEv9pS6MxMBvLzErm/elfZjIzVD7ItR0pQzksE3Dio8aWDJ9
 x2Lvmw==
Subject: [cocci] [PATCH] Drivers: hv: vmbus: One function call less in
 create_gpadl_header() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1403
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/6d97cafb-ad7c-41c1-9f20-41024bb18515%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 20:00:24 +0100

The kfree() function was called in two cases by
the create_gpadl_header() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus use another label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/hv/channel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 56f7e06c673e..4d1bbda895d8 100644
=2D-- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -336,7 +336,7 @@ static int create_gpadl_header(enum hv_gpadl_type type=
, void *kbuffer,
 			  sizeof(struct gpa_range) + pfncount * sizeof(u64);
 		msgheader =3D  kzalloc(msgsize, GFP_KERNEL);
 		if (!msgheader)
-			goto nomem;
+			goto free_body;

 		INIT_LIST_HEAD(&msgheader->submsglist);
 		msgheader->msgsize =3D msgsize;
@@ -417,7 +417,7 @@ static int create_gpadl_header(enum hv_gpadl_type type=
, void *kbuffer,
 			  sizeof(struct gpa_range) + pagecount * sizeof(u64);
 		msgheader =3D kzalloc(msgsize, GFP_KERNEL);
 		if (msgheader =3D=3D NULL)
-			goto nomem;
+			goto free_body;

 		INIT_LIST_HEAD(&msgheader->submsglist);
 		msgheader->msgsize =3D msgsize;
@@ -439,6 +439,7 @@ static int create_gpadl_header(enum hv_gpadl_type type=
, void *kbuffer,
 	return 0;
 nomem:
 	kfree(msgheader);
+free_body:
 	kfree(msgbody);
 	return -ENOMEM;
 }
=2D-
2.43.0

