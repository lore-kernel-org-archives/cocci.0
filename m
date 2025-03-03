Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8940C282CD
	for <cocci@archiver.kernel.org>; Mon,  3 Mar 2025 16:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=OFQZ49YdvADU6Nc4Pf1BbEN1CX9rshRjpAinWBUXCLg=;
  b=jv3GBQsFgfYA4307KgcrjJ1msXWik7QjbG+jw850+RUEPEwkEd/Fitkl
   g8lB8npJKhjreRXfvkaCwvQIHrAtVMgkbOIRGmrtPoErAUlWWwaJeaiRt
   1Olic2jSzF6yyR7NNwCSCIAogj+BlhqBU0K6bP4efOZhVwGhC14C5Z5a2
   I=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,330,1732575600"; 
   d="scan'208";a="210943735"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Mar 2025 17:36:37 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B4CE7E0264; Mon,  3 Mar 2025 17:36:37 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9883FE0260
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 17:36:35 +0100 (CET)
IronPort-SDR: 67c5da92_etKzk7tQSfbJxlIGEZp92EgedkP3Cl2mj2ZzpGlkCIHVbTQ
 Ii/t14sH2DrsxSg7TeAlXXTptKBTNCU2BBcyjWw==
X-IPAS-Result: =?us-ascii?q?A0HTAABl2cVnfg4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBAtIhFaIHYcygXQtA4Q7hzuQSIFWgX4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEOIFUgnQCixUCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQE7Bw4JATGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAIBAyMEG?=
 =?us-ascii?q?QEBESYBDx8BBQImAgJWBgESAgEBgn6CMAEDMQevYn8zgQGCDAEBBoJp13MfL?=
 =?us-ascii?q?CJXgWUJgRouAYVrgmMBhiaEPCcPgVVEgRUnC4EJgi2IHoJpgjOBaoM9mgWOU?=
 =?us-ascii?q?4FNHANZLAFVExcLBwWBOTgDIAo0FAQZAhQsBhAEMDp6gkVpSToCDQI1gh4kW?=
 =?us-ascii?q?IIragQFg1uEPYRAgj9RgkKCEXGBF4IxhVGBLYRqHUACAQttPTcGAwsbBj2hb?=
 =?us-ascii?q?jqEQQFSKBNMJoF3DZMMEZNYnx00B4I4gWaBYwyfXgYTL5dFDgaSfAEuh2WQa?=
 =?us-ascii?q?iKpD4FnOoFcMxokgzZPAxkPjiEMFoQLjwoBuRJCNTwCBwEKAQEDCYVGAQGKV?=
 =?us-ascii?q?IFLAQE?=
IronPort-PHdr: A9a23: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
 Et5KHHbSrgXg7YyLQhW
IronPort-Data: A9a23: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
 4T4qaCojXxXkXLMLPs=
IronPort-HdrOrdr: A9a23:VjFZ5q4YVQ7viQZiYAPXwBzXdLJyesId70hD6qm+c20xTiXqrb
 HIoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhXotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkbNDSaNzhHZKjBkWuFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:RtM2pmFnIPGDbFtAqmI4pU00QvgiWUHwxWvgIEbmVnZRFI+aHAo=
X-Talos-MUID: 9a23:5xJ6FQb6gmy/HuBT72bJiy87be5Su4eILxtRk7sN/JaCOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,330,1732575600"; 
   d="scan'208";a="110529598"
X-MGA-submission: =?us-ascii?q?MDFAVylou48GBzYwKJucHDLSne9gh+U82cUUiB?=
 =?us-ascii?q?IY2zpxp0ZzCrbz/VIGUTSOpSddBdv+qm3phneTj7i/eQSgbvKs4ZgVVf?=
 =?us-ascii?q?zEBBYlsCgjCfquf4mVvmC0ZqhQAXz56LIWAnjeP5rYLedHLeqTebuOA1?=
 =?us-ascii?q?S+RWi2Kj4ii7SUBMk0Y2NmGQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 17:36:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741019779; x=1741624579; i=markus.elfring@web.de;
	bh=OFQZ49YdvADU6Nc4Pf1BbEN1CX9rshRjpAinWBUXCLg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FDW/YnXM0hAx1ytQKRuVepa4q/Yk1/taEO2v9otzRqw11e6h6fYH1CUSlR+c2fd+
	 XvNV3xOeb40RL03pVe4sb28xZVYspGssu6WnJB0KVBcL5e+9RHepqi4t3GGjqpAax
	 WrJMABHzhJVLOMkbawy4CfRjJqHV1odxf3bT/vomhbjjr1ACGULuxaKTJb1+vVxhC
	 fe4mNvB5/g3q4ugIcsU84RLfXKpsWx6Vvd/p3hCxNmiGQPoKP5bZVj6Swgg0Pqk1f
	 KVzqxb9OfUhuLyEcr4mQ4nVPS26X3L7oAvI+my96l389JZVpCGpaRD0VbeoLX+T1p
	 zim60Xqrt1gan6/kmA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8T7E-1ttWUt2ZdY-000rld; Mon, 03
 Mar 2025 17:36:19 +0100
Message-ID: <d75665ec-e3e4-4f4f-8096-f81bacd390d1@web.de>
Date: Mon, 3 Mar 2025 17:36:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, dmaengine@vger.kernel.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Grant Likely <grant.likely@secretlab.ca>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sylvain Munaut <tnt@246tNt.com>, Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <eaa9f90f-c91b-dc87-51a1-d97f99fc5b4b@web.de>
Content-Language: en-GB
In-Reply-To: <eaa9f90f-c91b-dc87-51a1-d97f99fc5b4b@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Lg0A9+SPlbftQZwLLCIf63ojz/imADE3ZJO7xRpovtYdB7DIdrg
 HON6lDfWKOVBBNwbA9b/0O6yuUjCHX5azHxTZ+0GPzP/Aabr+Bxm/Kra5o/I05hzg3HOLlG
 yABF5SkJpsQs/MLEP0Jwa7OHkn/TMY9Nntz+R+VLEeNwfGIspEZNUfMrzykSCce0tf2HAbm
 2iA0gWF8fF6YCEu+qgyag==
UI-OutboundReport: notjunk:1;M01:P0:pspEfkEslvQ=;TvmhTkW+mvGvRsBBAka4S55Lhvq
 AyoE1Q917+OCUVC2G5g0M//Sz0DOGV9UnUXIt1fX85a90rWmCi4hrvEOq2nY54lN86Ixs/n/d
 R7RV0vKowBqtcPJeUcZyPnP5dJBxwUYFeaLfLNLCjnoUxdhz2g0tvcye9pHo5KyeqdXmOdbaT
 tKCUluofU51Xxv1phRbH86QKqOkg3uBnu3JsL/SyDXImtL71Lo2sAZwwbrG9oZHEMfDjW2B+0
 YM+xBvV2UDWnbOTY9/s2Fl7NZ2bf3fBWXIkjpVWGWUKR1xrgVQYEQlZLtyzuhtALe3s2EruFV
 r1P6PY8N9gTfHcLSJ9YUnkspWaFN+s+Iz7Ybbj3RYwup8uKtsaio238EGPVotVNSssP9Mcvst
 aifwqz1N5/eldTeH+6i67PRIOm1eyoj0qgfDV5i7rpsEc3LCGVMJSs1hhBhSG6KhET3EokgSj
 rCTlTb2WhxKjyf1nGI9tfYf+mKrSPz1BaTAn79ZKFxbAk9JMukgik0aA0Nhehh4K27tz8svRh
 1IEMKr8xi1RjeKBT1nLT65535PAKbCcB5j41UjbtdGZMMZqiAxnsPzQV7j7zt04i2EzSLjNCo
 EL/bGg3ccwCYUSk678vFl7IYzEy76DlWoS9Iz7ACrFAmoSrMO0rNrs8xM1kFCeWSRF+RO8aJP
 4Q+ekGpuP6nnhVtH9ok0m13jYrCTsdiq8ZtaFE7ITJSium6JWgEe7RJfCmklCf7fwGxe08we0
 2LKuf+Va2NhRK+RV4Bl60OP+S9hHORLn2rvWvN3QeK1cHDFVPm8iZpbRmII9c6G13RWh7DVct
 G989Qnk2TeNHkW3evLfJTHIfgoaaQ/Jn3u7j5aPVXSRCQq53qpdfGbAOxY5ZaYS4XXSVowyDe
 MZnOs9Qs2Z3jPmxBIowps8WieZ02hSxAtZWeeXAyLb6L+qNFtJPmjKkYFvR5Z7vuVTyfHZsNH
 Wmyv+6HjFw/kIo37kqwpOXzS7sAlPwj1j7hKB+g9FSTDW5S34nrzyzmHAcQR86icnCBngPkXd
 NfgXkBduQOB8UZP9jEXGmWuJEa9kw17Z0SHcoTLG7tFr4eg+VFM8haf2FnJ0D1EaNf2Z4rC2u
 6Vb47BkstfiYI/sId70+LVK+dn3CdUch/La4ei8exAr/U4Qeb+oWp06zueNZobixXEsjaVB9X
 a4HIDwayi1IzyLW477kWh8WeREm9urV4ywGIY1VvgKfqbdCCvvGRQHiNIDr4bwtd/UThZ0Hec
 ZPBO4eB4sYl2hS/9hLYvnvL/jUJ4endz4+BUyW8a2rJ0+XiKrfgGBrwmVGXGahyBM2rR5Bskh
 oJufOuTqanlDSC4VyI9SDXjp5FDvgmdtACQoVRhWomESz+Py0EZmJ1bd0S3Z6xxMbHpDi45Ej
 091Lt6yCjy84wWnSv+5OrR+T+Cpv5KnDqkr8aH3jEaGbQ2DBh55cyIZSWiDg+7A+1dMyMS+7Z
 ddIZjVu88GvH7IXRpr0j9s1jiRRo=
Subject: [cocci] [PATCH RESEND] dmaengine: bestcomm: Fix exception handling
 in bcom_task_alloc()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2482
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/d75665ec-e3e4-4f4f-8096-f81bacd390d1%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 18 Mar 2023 14:55:02 +0100

The label =E2=80=9Cerror=E2=80=9D was used to jump to another pointer chec=
k despite of
the detail in the implementation of the function =E2=80=9Cbcom_task_alloc=
=E2=80=9D
that it was determined already that the corresponding variable
contained a null pointer (because of a failed memory allocation).

1. Use more appropriate labels instead.

2. Reorder jump targets at the end.

3. Omit a questionable call of the function =E2=80=9Cbcom_sram_free=E2=80=
=9D

4. Delete an extra pointer check which became unnecessary
   with this refactoring.


This issue was detected by using the Coccinelle software.

Fixes: 2f9ea1bde0d1 ("[POWERPC] bestcomm: core bestcomm support for Freesc=
ale MPC5200")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/dma/bestcomm/bestcomm.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/bestcomm/bestcomm.c b/drivers/dma/bestcomm/bestco=
mm.c
index eabbcfcaa7cb..7d6a92d34871 100644
=2D-- a/drivers/dma/bestcomm/bestcomm.c
+++ b/drivers/dma/bestcomm/bestcomm.c
@@ -72,7 +72,7 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_size=
)
 	/* Allocate our structure */
 	tsk =3D kzalloc(sizeof(struct bcom_task) + priv_size, GFP_KERNEL);
 	if (!tsk)
-		goto error;
+		goto reset_stop;

 	tsk->tasknum =3D tasknum;
 	if (priv_size)
@@ -81,18 +81,18 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_si=
ze)
 	/* Get IRQ of that task */
 	tsk->irq =3D irq_of_parse_and_map(bcom_eng->ofnode, tsk->tasknum);
 	if (!tsk->irq)
-		goto error;
+		goto free_task;

 	/* Init the BDs, if needed */
 	if (bd_count) {
 		tsk->cookie =3D kmalloc_array(bd_count, sizeof(void *),
 					    GFP_KERNEL);
 		if (!tsk->cookie)
-			goto error;
+			goto dispose_mapping;

 		tsk->bd =3D bcom_sram_alloc(bd_count * bd_size, 4, &tsk->bd_pa);
 		if (!tsk->bd)
-			goto error;
+			goto free_cookie;
 		memset_io(tsk->bd, 0x00, bd_count * bd_size);

 		tsk->num_bd =3D bd_count;
@@ -101,15 +101,13 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_=
size)

 	return tsk;

-error:
-	if (tsk) {
-		if (tsk->irq)
-			irq_dispose_mapping(tsk->irq);
-		bcom_sram_free(tsk->bd);
-		kfree(tsk->cookie);
-		kfree(tsk);
-	}
-
+free_cookie:
+	kfree(tsk->cookie);
+dispose_mapping:
+	irq_dispose_mapping(tsk->irq);
+free_task:
+	kfree(tsk);
+reset_stop:
 	bcom_eng->tdt[tasknum].stop =3D 0;

 	return NULL;
=2D-
2.40.0

