Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB28C6FD1F
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 10:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=7pUCt5prjHt+mxab9AS29YFUFS+CsnG4Nu8N1HSaCQU=;
  b=dahAhX+1a1pVLl43YMZeGVCRSCHEqGWXTsYwcXns5uTEYCoNjsrj+4QL
   TMDqVOhWdN0DndSJm9bRRaUublyUhR3ksRXkYgFlg87ve5JxGj9W5VaWb
   JCPKfkabHs92J5mzPCLlS9v/35lmI5zHUhWsY53NaA0DP9zN1TVaW4g5W
   M=;
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
   d="scan'208";a="99051243"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 11:27:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 17654E0D45; Sat, 25 Mar 2023 11:27:41 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 02B4AE0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 11:27:36 +0100 (CET)
IronPort-SDR: 641ecc98_H3LUAwuct9mauw8fIsLkR1zSdSvUUHmMCf28Krvx4pLlQlj
 oKtYnuYCKnSAy1fXqTs9d3YAMkmIX2xgSrLEIfA==
X-IPAS-Result: =?us-ascii?q?A0ErAADEyx5khwMP49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YItgUsvBAtGhFOIH4hiLgOEL4csjCGEAoFWgUA+DwEDAQ1BAQIEAQEDBDiBU?=
 =?us-ascii?q?4JzAoU6Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBA?=
 =?us-ascii?q?hABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAkdTPQMDIwQZAQERJgEPHwYCJgICVwYBDAYCAQGCeoIoAQMxB7EcfzOBA?=
 =?us-ascii?q?YIIAQEGgmOZJx8sIlOBXgmBFC0BjQSDNnonD4FVRIE8gRWCLIgcgmeRI4gvC?=
 =?us-ascii?q?oE0dYEgDoE9gQQCCQIRa4ESCGuBfUACDWQLDm+BSgJkTCN7JQQOAxkrHUACA?=
 =?us-ascii?q?Qs7Oj81BgMLIAZYawIJIxETBQMLFSpHBAg5Bhw0EQIIDxIPLEQOQjc0EwZcA?=
 =?us-ascii?q?SkLDhEDUIFHBIEKgQEGASYkmnECAYJnATwWO0wmggTDJjQHgiiBVYFZDJ8MB?=
 =?us-ascii?q?hMulwgOBpIjLoctkA8gp3qBYzqBXDMaJIM2TwMZD44gGR6Dbo9HQDQ7AgcBC?=
 =?us-ascii?q?gEBAwmFRgEBhXsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:JYUcs67VQto9tXGI5gPXwBzXdLJyesId70hD6qm+c20wTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhX4tKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkYNDSaNzhHZKjBkWyFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="51223520"
X-MGA-submission: =?us-ascii?q?MDHJfv2q2+CdnSHzivZ61iNaE1yycBICMHoIr2?=
 =?us-ascii?q?aPiSD0CamYxntDpBvT8S2Y/Lv1pRpPHVqDQxY9WMclzqc1GOajhBqKrg?=
 =?us-ascii?q?dy9tbLt22pO7REimT0xD8QYIfEMZXTHR8pj9Pi21TlXKUH/Zn/rKUwsZ?=
 =?us-ascii?q?d0vSWqQ3o+DErkSvVOxRumeQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 11:27:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679740048; i=markus.elfring@web.de;
	bh=7eD956rwXg73vZInuV5jIKTgX/dJDpHyzdrb0s+4vNE=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=SEJCC1CmCOFhXYwky4igELfX8iado2PDR8m+9m3ZRzhtEJQJ9+2HL5psV9o31gOvF
	 Fp1/YyVpONOcEcSaW4DvBwccPoF1tDdvwsnvFB7QfoyhRliSeWb1IjsJ7/rab2w4ax
	 pGQ1zzj+d14/ZDPHbrjv4PsdYMR7wcQ7xL8RtFV+XDWMGFHQ9HyLaFfznCUm87y1so
	 w57RyTjkgRtr3COvRsLfQ8tATFWCkkje7QoLq+vEjRDAf3+BJPxXNu6jikjtyYhU8N
	 CxuMxZQObvTW0CSM/pS/cY55FBLo5pRd0ayc9UbyPaudIgXlr/G4ZKGbIkBElUvOrQ
	 HCz4SAp4eTzYQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MlLA1-1qKsG52ZsT-00lkRe; Sat, 25
 Mar 2023 11:27:28 +0100
Message-ID: <d5ba6279-81bc-fd72-8d03-45f78ff304b6@web.de>
Date: Sat, 25 Mar 2023 11:27:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Zenghui Yu <yuzenghui@huawei.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <5f9ad9bd-2626-90cd-2b4b-2640a210c500@web.de>
 <f7057212-eb4b-55cf-48f7-1bbbd1519fcc@web.de>
In-Reply-To: <f7057212-eb4b-55cf-48f7-1bbbd1519fcc@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rWMUXZY4u8c4oph1FydkBuSrtp4eVdpeVvuz0+GXeHAFxXMQYpY
 bn5k02xT6AFMEBC9KxqPNvQNmh6WtGLayZnKGplwk1QftLN37ngCJ0wchDyrri0aIXxRlNH
 B8QY0K61DDS5Ngl8osLuDb3D3qD2GWIZsJRyuMiSxQVmfCU0WnLbXoWBAw5tGSMs5AzcI69
 dPim2U3XfXyHMmmBLHz2g==
UI-OutboundReport: notjunk:1;M01:P0:uLwcEqI6Ecs=;gxanFZ2i0IvMRrsy+pMu8xwfHXU
 DNffG/MTJUjSToYhppLMF6Xgcl5kuenCkAxa2yORgxMNct0V7Uim8uaVZa8CIJ122rXUlz7Uj
 Wh2W4xhS/r9kjmsqy665G9rqawRnEYngu/Xi/YCQ+UB3UouZqbd2hF+9ep9gT0M1XB1P6wZ5T
 9sShhZySQCeLVA/AnfuoIA6uYZldyxALRfigH+qnrrptqU58+k3wyfQuXOffiM7kdgiBMqRI+
 oc/Lla447/6luNWBnWI1y4MAm/07SGLhkJa3yvDjosuu0uymAE1b0KbysuDWTx4kWm1z3BmDL
 Ue2GVSU8d7iVnmnYiTvNF920NYBJrTYP9jT8+h0ckVQorWLNQmWST2lCLrWxcmmdZ0/W0qzGs
 FE817EqoKOjU5hiraFn1NUnKE7IO7+vqw9hGAX8qdFaFT5JJg9IIBRcS5djmfvvXyUcxHEykz
 UuGotEiQeewvLUpYvTpC0vMeXF1DD8wPa9tOHN2+F3zDOsDLbygwbfeyFsqQIaOtM8ir3YW3y
 pY0Gcob38BZY6BmcmgQs+l3IEo6822UBc5umIcwQuplhUWFtvLPKms1ao1aaHcU2lMb34SBF8
 42APIFPVs3qs5wkeBYhzbOJAs0LjAWdOx9xwXKOmnZF9kGObffJjTgnbxWn5Jf5VDwAL2sfUk
 Dx0JHkLDtOg3suRvZGskQgUZmy3yrLNjBEF5E/3pejiqco5ixDD5a4l53Pykta+vpxxKZjPa+
 cACa9btiGt9gg6InvEApsDIMX/H2vt1KtPMgNFL2btWQEXPE/U5hh5/awLM55/T+yXOdC1ECU
 rpEBHlrFJXdHOYxYdXW0eUbX0x4P5Z+btq+Uui+QsqHd6F+6QnZiIIMR/WAxZR94BS73GydE2
 Cp/ngAhEXVl4Fuz3n98/Mk8ioo8MZmc0deA76sjU9S6Lt+AilJYccaQLP
Subject: [cocci] [PATCH resent 1/2] irqchip/gic-v4: Fix exception handling
 in its_alloc_vcpu_irqs()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 939
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/d5ba6279-81bc-fd72-8d03-45f78ff304b6%40web.de>

Date: Sun, 19 Mar 2023 20:05:21 +0100

The label =E2=80=9Cerr=E2=80=9D was used to jump to another pointer check =
despite of
the detail in the implementation of the function =E2=80=9Cits_alloc_vcpu_i=
rqs=E2=80=9D
that it was determined already that a corresponding variable contained
still a null pointer.

Use more appropriate labels instead.

This issue was detected by using the Coccinelle software.

Fixes: 7de5c0af9c7c717f9052e6d75b24f90050e6a56e ("irqchip/gic-v4: Add per-=
VM VPE domain creation")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/irqchip/irq-gic-v4.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
index 94d56a03b175..d98d58298e9e 100644
=2D-- a/drivers/irqchip/irq-gic-v4.c
+++ b/drivers/irqchip/irq-gic-v4.c
@@ -161,13 +161,13 @@ int its_alloc_vcpu_irqs(struct its_vm *vm)
 	vm->fwnode =3D irq_domain_alloc_named_id_fwnode("GICv4-vpe",
 						      task_pid_nr(current));
 	if (!vm->fwnode)
-		goto err;
+		goto recheck_domain;

 	vm->domain =3D irq_domain_create_hierarchy(gic_domain, 0, vm->nr_vpes,
 						 vm->fwnode, vpe_domain_ops,
 						 vm);
 	if (!vm->domain)
-		goto err;
+		goto free_fwnode;

 	for (i =3D 0; i < vm->nr_vpes; i++) {
 		vm->vpes[i]->its_vm =3D vm;
@@ -177,22 +177,25 @@ int its_alloc_vcpu_irqs(struct its_vm *vm)
 	vpe_base_irq =3D irq_domain_alloc_irqs(vm->domain, vm->nr_vpes,
 					     NUMA_NO_NODE, vm);
 	if (vpe_base_irq <=3D 0)
-		goto err;
+		goto remove_domain;

 	for (i =3D 0; i < vm->nr_vpes; i++) {
 		int ret;
 		vm->vpes[i]->irq =3D vpe_base_irq + i;
 		ret =3D its_alloc_vcpu_sgis(vm->vpes[i], i);
 		if (ret)
-			goto err;
+			goto remove_domain;
 	}

 	return 0;

-err:
+recheck_domain:
 	if (vm->domain)
+remove_domain:
 		irq_domain_remove(vm->domain);
+
 	if (vm->fwnode)
+free_fwnode:
 		irq_domain_free_fwnode(vm->fwnode);

 	return -ENOMEM;
=2D-
2.40.0

