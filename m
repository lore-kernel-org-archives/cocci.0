Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77586C6FD1F
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 14:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=nNlQVNrANCwcha98/KNZe0Btlpm0T9EqK/F3q16ZJew=;
  b=rxCi5nIqxrbEYOj23oZg3glnvVHvHjzzbs3lycwYjsCE6hv50Y7k1tMy
   pxo8dHX94qe0Ak6nOezT1EY6I4k45vhiADdjWiJOUm2a7FABC9SFZOH9K
   m+IpIKqF1qTFYTS+hJLtnIEvpHMHkeDKN1/H3BVh2xEgRl41GemSo+LPm
   k=;
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
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99065369"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 15:00:39 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 89E4FE0D45; Sat, 25 Mar 2023 15:00:38 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 464D4E0D41
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 15:00:33 +0100 (CET)
IronPort-SDR: 641efe80_++YDO7dLZkUXEga1l8hWWG6HzNsr179WYUcNd6RkEaejPxQ
 YstNu6CX/xaDOP1zlSR+gQuTSLuZT4YkszpGlEQ==
X-IPAS-Result: =?us-ascii?q?A0FCAABU/R5khw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYItgUsvBAtGhFORAS4DhC+HLJAjgVaBQD4PAQMBDUEBAgQBAQMEO?=
 =?us-ascii?q?IFTgnMChToCHQcBBDIHDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEA?=
 =?us-ascii?q?QECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARICR1M9AwMjBBkBAREmAQ8fBgImAgJXBgEMBgIBAYJ6gigBAzEHsTJ/M?=
 =?us-ascii?q?4EBgggBAQaCY5knHywiU4FeCYEULQGNBIM2eicPgVVEgRUngRWCLIgcgmeCK?=
 =?us-ascii?q?IdWhyWILwpZW3VrNQ6BPYEEAgkCEWuBEghAK4F9QAINZAYFDm88gQ4CZEyBH?=
 =?us-ascii?q?iUEDgMZKx1AAgELOzo/NQYDCyAGWFEaAgkjERMFAwsRBCpHBAg5Bhw0EQIID?=
 =?us-ascii?q?xIECyxEDkI3NBMGXAEpCw4RA1CBRwSBCoEBBgEmJJpxAgGCZwFSKBNMJoF3D?=
 =?us-ascii?q?ZJYEZIvng40B4IogVWBWQyfDAYTLpcIDgaSIy6HLZAPIKd6gWoLKIFcMxokg?=
 =?us-ascii?q?zZPAxkPjiAMDQmEA48JAT1ANDsCBwEKAQEDCYVGAQGFewEB?=
IronPort-PHdr: A9a23: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
 mR7OT2CS78D1tNd
IronPort-Data: A9a23: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
 D3GxkDNAw==
IronPort-HdrOrdr: A9a23:e19XsKNXWqgfQ8BcThWjsMiBIKoaSvp037Dk7TEUdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFg7X5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YGT0EUMr3N5DZB/KPHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="51232843"
X-MGA-submission: =?us-ascii?q?MDFqIb0+gH6xGXnzyPFzzmwo1nyaZg5d+ZFmHF?=
 =?us-ascii?q?n/mJt5LertzTlVPZ1/m4BhY0wZy+Meq0qIHcVCQI7mj2OnGsJ/pxAdkA?=
 =?us-ascii?q?bH3703sldqWgjKTAyNGI05+VLnfbSSmw1oalVzVCy64bHOV9O+3lNb5j?=
 =?us-ascii?q?tq7ubtkn4xsiQF8dVEJHVsAw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 15:00:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679752829; i=markus.elfring@web.de;
	bh=/4D0LAH8JFPvNyEoaT1K7FQCFpgtGoSwmfUbWYWwspM=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=GJnauCRU6oiDmlehiWi3GVD/eufes2bDXEZ9g2R9r4i3zQErkUmypC3EeirGWGCFp
	 EEbH36Z39ptwa6gaHp1AFJfg2nThNBdll+WecQgnSP2nf1yuEmfVNCJ970rctBKBu2
	 4UuLpC6RDDq5tp/9pyY8bO118VOsam94u7ZqG0BRv1XaYM6NLyV627gxEpoCb2ctac
	 6+asVFvd0c0Iq1hZOy9rpb+8diWwXfAwYS4AxbkxLQabM1KzmwlI0B2clI1wT5/7CJ
	 Njqy/thQiaIVTedIzUBzJfNqtZ3VzayCX5WU104s0HNZDeahGKqeqkj66gi2N2Z5pj
	 +ufbZxvV+eP+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MkVwo-1qK21C3kje-00m1VV; Sat, 25
 Mar 2023 15:00:28 +0100
Message-ID: <8653a783-c03f-42cf-c998-d71e6684d706@web.de>
Date: Sat, 25 Mar 2023 15:00:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, dmaengine@vger.kernel.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Grant Likely <grant.likely@secretlab.ca>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sylvain Munaut <tnt@246tNt.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vinod Koul <vkoul@kernel.org>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <eaa9f90f-c91b-dc87-51a1-d97f99fc5b4b@web.de>
In-Reply-To: <eaa9f90f-c91b-dc87-51a1-d97f99fc5b4b@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lH9nFqMQObdmB+QyX8uoo3YSq3qa56h4AprXrQT/xwbOQkFZMIm
 WT1oXsnq7fMajYQneux/wQB1dgFn2vAIxzOWsFEeS3yYWptgCe51GkoUamgpSAEM7lgK/5d
 pLfYOqS62aocInakj0TB01g/WyTpc/0DKZaERlFWfz74l0/mQlcQZkle37eGE9TwmkmYCXe
 d0z+LsqhLy2QQbgI3w0HQ==
UI-OutboundReport: notjunk:1;M01:P0:ptquvMHIKIo=;JC0OtdUhA+yfypCGq/2hQwFSBlD
 JJmN2rUR07jg3xLV/JkBa420E5ZJBjPCvDmFZthsUpzBtTlF18Zal5C888g6NsoFbZoR50u91
 LCX7ZIbdcBprmKoXMiW9fX7DVtqW6oVc4u5IeTcXWEkUu94RWAD4KR+L08ST1qcFqvD6V3/X7
 CSyWM9xr08sBI3x6925Vmtvmv8ANcrDXHrQ13ExVp4eYFlouv+yziNGYvSqb9od96MwJFCpaE
 y3/EqkOc1beIjmLgOcULw/kU46oYzEszgd6t0KoOj2GriI6f4HXcZ4dk4bC1M8kWhzVKaB62y
 NMASeDQ6YvPCgltujVw0DIRrAh5j0Set6S7IxmJXW58iPWuR4SQuoTQcB5+YN93C5OhExFtxv
 fsvwhfQu4VbV0GOqssM9Z/h28JGku5joxqHLdpikKRroyepyvulTmMREGr8Oavx9gZdmek5vr
 Lw+7pKsHz1ReFdwHms57/pJE6J5VdfmRqfYxt3Cv+LLdoIhSiKjQGes8AR3/rZ9hao7nOL2/d
 sx9hIQzCTV6QVKxM2wNwcoBFgP1EOpWAJIXklPb6UyyOmId82g37uNmOi/Qw3cFheQW9FddUT
 7OhYdivCNo1SXhNNtX5zoWVNKgDxOBJsWWbKLPW1+M3kYWViHKrK1ckvjrlqnhzapsytHrXdc
 2eM8UyYmZSvaXLP5UYPVDfFJdUhPnpiNDijR1LkP4dwAYgYrfE0QlTLZV2Cce6JhwNUh7tkQg
 ZKOwz+XXY/7ngcI3rhT4qRDSEeO2tvdkwGSyPUvawfPBsfRvO5XbQ4PPxoMU6CQefRo+CPfmp
 KO5p2/McNMTj5xJ80iUOH5d3n+WpZIuttfP0RWqLFves8tRM8cklNhCNfJSuM8ffsyazIj3gp
 A/LC4GajtXc1dRxao+0R5bE0VnVTj/1GHPa2MsvDTv9Na7HMAOwXqCock
Subject: [cocci] [PATCH resent] dmaengine: bestcomm: Fix exception handling
 in bcom_task_alloc()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 946
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/8653a783-c03f-42cf-c998-d71e6684d706%40web.de>

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

Fixes: 2f9ea1bde0d12d8fb5a7bdc7ab6834275d456262 ("[POWERPC] bestcomm: core=
 bestcomm support for Freescale MPC5200")
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

