Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CF2C6FD1C
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 10:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=G9b85FhBUOqy2L+pYRazCi0tXurb7zV3u7hJ0kM3iKY=;
  b=KvsD2Zg9jx+dB8Il1mWBMxsmp99CgmCOipGHXQFDSce44JgwImZykPHP
   4aKCKce3X4NhVMKCLXuNYcgzdv9jra0KI37LZ2Fmoqjfo2VKyn5eYgABl
   mVF3m9Aca20bxzLB66anZbQOSRiQIBMfmdIv1pJgePVGYl2FguQJ+RPII
   I=;
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
   d="scan'208";a="99051467"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 11:31:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E51E6E0D45; Sat, 25 Mar 2023 11:31:03 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AC000E0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 11:31:01 +0100 (CET)
IronPort-SDR: 641ecd65_LdcTxJjj4Z3AGEFedabsM+NWQbQBlDJAZg073pcV2yE2o59
 DF2NtUWxdaH5j/MHBTUaabYru/s1jASVFR6CK9Q==
X-IPAS-Result: =?us-ascii?q?A0EdAADEyx5khwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIH4hiLgOEL4csjCGEAoFWgUA+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBDiBU4JzAoU6Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBA?=
 =?us-ascii?q?QIEBAEBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQESAkdTPQMDIwQZAQERJgEPHwYCJgICVwYBDAYCAQGCeoIoAQMxB?=
 =?us-ascii?q?7EcfzOBAYIIAQEGgmOZJx8sIlOBXgmBFC0BjQSDNnonD4FVRIEVJ4EVgiyIH?=
 =?us-ascii?q?IJngiiHVocliC8KgTR1gSAOgT2BBAIJAhFrgRIIa4F9QAINZAsOb4FKAmRMg?=
 =?us-ascii?q?R4lBA4DGSsdQAIBCzs6PzUGAwsgBlhrAgkjERMFAwsVKkcECDkGHDQRAggPE?=
 =?us-ascii?q?g8sRA5CNzQTBlwBKQsOEQNQgUcEgQqBAQYBJiSacQIBgmcBPBY7TCaCBJJYj?=
 =?us-ascii?q?naDSp4ONAeCKIFVgVkMnwwGEy6XCA4GkiMuhy2QDyCneoFjOoFcMxokgzZPA?=
 =?us-ascii?q?xkPjiAZHoNuj0dANDsCBwEKAQEDCYVGAQGFewEB?=
IronPort-PHdr: A9a23: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
 Kc=
IronPort-Data: A9a23:SLiFyqmk+0gSycARpoT2/0no5gzpIkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIfWT2GafjbYGage9tzPtiyox5VvJHTzodmGVY4+3o8RltH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvymTrSs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82MyYzJ8B56r8ks156yp4m5A5zTSWNgS1LPgvylNZH4gDfrpR5fIatE8NvK3Q
 e/F0Ia48gvxl/v6Io7Nfh7TKyXmc5aKVeS8oiI+t5uK3nCukhcPPpMTb5LwX6v4ZwKhxLidw
 P0V3XC5pJxA0qfkwIzxWDEAe81y0DEvFBYq7hFTvOTKp3AqfUcAzN0+LlhnO4Y/3dpcCGdt6
 PYBA3cdQwyc0rfeLLKTEoGAh+wmK9T3epwSsDdswFk1D958GMqFGf+Vo4YFmmtYasNmRZ4yY
 +I8YCBscQ+GThlBIFYRB7ohke3uinSXnzhw9QvP//FpvjC7IApZzbfBYfrsXO6wFcwOoFSk/
 mzL3F7hK0RPXDCY4WPYriz137GncTnAcIkVH7a53uV7hUWagG0VEhwfE1WhycRVkWa7XM9Db
 VMZ8GwioMDe6XBHUPGtfQTppnWjmSI3UtxzDucjw0ad57bLtlPx6nc/chZNb9kvtckTTDMs1
 0OUk96BOQGDoIF5WlrAr+nP/GLa1Tw9cTFbP3JsoR4tuYG7yLzfmC4jWf5FNMZZZPXHFC/9x
 TqHticzgd3/ZuZXiPvhlbwrqxSrvITJBiQv7w/eWH7N0++UTIuiepDu9lXRq/pNRGp4crVjl
 ChU8yR9xLlfZX1oqMBraLhddF1Oz6vUWAAweXY1Q/EcG82FohZPh7x47jBkP1tOOc0ZYzLva
 0K7kVoPu84NbCH1NvcmPtPZ5yEWIU7ISoSNuhf8MYUmX3SNXFTYlM2TTRPNgDu0ySDAb4lma
 c/KKK5A8kr2+Yw+kWboHr5DuVPa7nlwnCvSQ4z21RKqzfKXaxaopUQtYDOzghQCxPrc+m39q
 o4BX+PTkkk3eLCgPkH/rNBCRXhUdyRTLc6t8aR/KLXcSjeK7Ul6Vpc9N5t6J9c690mU/8+Ul
 kyAtrhwkgSv2CWaeFnVNBiOqtrHBP5CkJ7yBgR0VX7A5pTpSd/HAH43J8dtL4o0vvdu1+B1R
 PQjcsCNSKYHADfe9jhXKdG3oIV+fV75zUiDLgi0UggZJpRAfg3u/sO7Xw3N8CJVMDG7m/Fjq
 JKd1yTaY6E5eSJcMOjsZsmC9WiB5UompLoqXm/jAMViR0H3wY07dw3zlqAWJu8PGzXixxyb9
 V2kPjYFl8bwoqse0trAtYabpaiHTsp8GUt7GTHAzLCUbCP1wEuq8bViYs2pIw+EDHjV/oemb
 sVrl8DMCuUNxgt2gtAtAoRVwrIbzPqxgb1jlyBPPmjBNnavAZNeeki259FF7PBx9+UIqDmNe
 xy9//dBMu+0I+LjKlkaITQlYsml1f05njrz7+w/EH7l5R1Yraa2bkFPAyai0CBtDqN5EIcA8
 9cTvMQ77w+eiB1zPO2W0QFS1WCHdUIbX4sd65o1PY7MiygQ8G9kX6DyMCHNza+qV8RtKWgve
 z+du7rDje9Tx23EaHsCKkLO1ut827UL4Q5G/GYfKw63m/7AvPsW3QJQwxszXA963hVK6MMtG
 2lJZmleB7SCwCdsv+dHB1uTIgBmAAaL32DDx38itnzrf2PxWkPjdGQCaPuwpmYH+GdiTx1n1
 bC/yle9dw31fcv0jxAAaWQ8p9PNFdVOpxD/wua5FMG4Hr4/UzrvoomqQUEq8xLHI8cAtHfrl
 NlQ3tRbSPPEbHYLgqgBFYOl+6waS0mEKEx8UPhRxv41Ml+GSg6i+wqlCh6XSptWKu3o4H2IL
 ZVkBvhyWiSU0AeMqTEmBpAwHYJkoc5x2v08fuLEGG1XlZqesTtjj7zI/AfcmmIAYotjgOQ9G
 KzrZhOAFW2c30VVv2r3qOhFJWuKTt0WbyLs3O2O0bsoFrBSlMpOYE0Nwr+PkHHNCzRe/jWQo
 A/nTI3H/dxIkIhDsdPlLfReOl+SN9j2atWtzCmylNZ/NfX0LsbEslIumGnNZgh5E+MYZIVqq
 O6rrtXy4ULiuYQ2WUD/n72qNfFAxee2bdptHvPHFltotgrcZ5a0+DoGwX6yFrJRmtAE5sWHe
 RqxWPHtSfErAeVi1F9nQAkANSZEB6rOO/Kq4Wv3qvmXERES3DDWNN7tpzejcWhfcTROIJHkT
 BP9v/G1/N1DsYBQH1k+Cup7B4NjakrWMUf8mwYdaRHDZoVpvr+DhlcmvR8n9C2NFXSOVsr3i
 X4Aqt4Sazzq0JwkDvkA22CxgvHTJGlwi688cyrxPvZo3iuiAjduwfs1aP0751I9rsA2/I71b
 nfBYQPOzMk7sStsKX3B3TgoYutT6iHi9Ds0yvzFMn54sxuLOb4=
IronPort-HdrOrdr: A9a23:9hmAC6+IRF4/sK4KVNRuk+AMI+orL9Y04lQ7vn2ZhyYlFvBw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNWftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOb+EYZmIbsS+V2njcL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="51223650"
X-MGA-submission: =?us-ascii?q?MDFOdGQOuVNCsnEG/slUZAbA0V//Kr8vyPmJ0a?=
 =?us-ascii?q?ec54tr9tIRf9UVJD4G+Forov79Z7gg2O89diSvaig/GILZFPa0JwiiU4?=
 =?us-ascii?q?jYSQvEsuCWMSJXybVxsu1nRIfKwHI1JfaU/9L+mf3AhDFd8Hix0DTfKT?=
 =?us-ascii?q?IQSxxQdB6nbufK9rLTKAhxCw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 11:31:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679740235; i=markus.elfring@web.de;
	bh=Uu4h+1bI4A6IzctScHkKJNROKiz7KV9Tc+AWc8YB9rg=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=Ng/jaFa5Wbi7c3x/15tQKnepYPxzQ3hAJSI7UGBjeJJqhA3RWrMeBFRJblsOwUuIQ
	 9ot4p81G6GBMGFKIHdwe1UQU4IKbUrjO5sv05zTRlYfCuPurvToDS5Dn1W3Kpo0vaZ
	 eSPSYfou3pXY2KYboyk1DYLWyoAVok9HTXBSpb5NTVAEZ3M8MANJueGwmIkxptKomy
	 rEuoU2luzTfht2JgZ7GF9TfEcrkwNcOegYhWvYrJQqrtx6t7qlVEcJh6S9DCGUr+yW
	 D5cvmzBKJKXRLVnhcaHCqLW5hGzHt8mpGumlh7rFhqwwbdjuIOXYq6aGoYbE/0Qeyz
	 muNROUfngRP1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6HKG-1pZQWp1U2i-006cSc; Sat, 25
 Mar 2023 11:30:35 +0100
Message-ID: <38b543d6-e024-ddfe-b268-98c646df7fb2@web.de>
Date: Sat, 25 Mar 2023 11:30:34 +0100
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
X-Provags-ID: V03:K1:qTBtdetWYoY+Duah/gw6i/kQWWYWb/Ej/+PBQBoEMmZkl1duZQx
 pFknO4DLnUFP+VwZWmzTNFimGgjCzAsw5rqlcTR6XcB1+oRe6S69kQjXM3gh07G8cyFc9vx
 97Lf+iSiFT8MQWb+2gPd3fKi89bXMbEnVsqqMnbNd/x7DN9KGZthIJHtahogkUhilulSkY4
 vRrhsGrpI74MovN0HnygA==
UI-OutboundReport: notjunk:1;M01:P0:1wTAYHYexVQ=;XzNeG6CWoZ9hi6qEXa0w92Z701u
 2fpDTo7kXhRGgUbQK42e8Jn3fTlqrfctAFDzr1SfjUDA6ELuyk5zZGzIvfjIsAd2R31UIs2mb
 Ql8ba5jVbNnN9G5/RP5rUxm1FQb9s70p+xbo+FSmW4GLa/8BWR5airsU0v46a6jEne+j4VAXJ
 qFgFE5nFEQNRcHws9qfrXIwIGbVq8WVymCEMP6P2ZlBCbrLEm9dL/mxaF78cJLr5bWuUSvqr/
 tTueQUFXs/jIoN4PWCVL5mQV1mCMb/0Uy/8EPXZBYf+a+JAHuvnwPDNzgZ+HtkzYKxtXBxk6u
 WiRODO4bQQI85mkDVz6KcsZDfmGAGN42DIfst/Od80yj3jFuNk4X11yHUccwj+NshtehlcaER
 8+zEgKAp5PC9+zJQbHQ0iT2gWqdetjaDn6JP8j2NkUmT449EnjGdoS34JYpykQYaoAqp8oasI
 G3ZVYFP0nafacA6Q2ikeUet3Wxt8IzBj77J5f7k+h5eysB6nt+jm+9S2374qEdhzL3hvu2Ec7
 1k82rmxUdcS584PBRsKL367Yw9b9dml5SggfN//7U52gNVqqTY2PAVzXvxiA0snEOVFHHhnXZ
 PhKwAqVrfiJ6gn7LZJdb+oIhWqCCVxXhzGnRtPwzjLtRO/YH9LAzO5GOzcGYKtUTdi13vSbQE
 SjPEouAQUuw++9nGOTMQ1Vmpd/OJtD269U0FvVzpDGaVmy60BUaU/ngs5Kf26qNOCgzQFueLd
 3AQ4as9WOqKtEWNYCBEN7XoJ7XCQvBsr2w+lOrsQwPHyQM6qqPNeplznxMd7sfbrtcaU7R5sq
 g5BraURYcOeQeBtOQdxA3argELAJ7UNpc8wTg5co+ah9zKCPfgus85cJLcnQPRIOCwcTjm1hp
 1MPk+OI2VpJFOjQQTGV6bvnF7Ll7ptmbVMnZmFJquROriS1+peTv3IKZm
Subject: [cocci] [PATCH resent 2/2] irqchip/gic-v4: Fix exception handling
 in its_alloc_vcpu_sgis()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 940
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/38b543d6-e024-ddfe-b268-98c646df7fb2%40web.de>

Date: Sun, 19 Mar 2023 20:28:52 +0100

The label =E2=80=9Cerr=E2=80=9D was used to jump to another pointer check =
despite of
the detail in the implementation of the function =E2=80=9Cits_alloc_vcpu_s=
gis=E2=80=9D
that it was determined already that a corresponding variable contained
still a null pointer.

1. Thus return directly after a call of the function =E2=80=9Ckasprintf=E2=
=80=9D failed.

2. Use more appropriate labels instead.

3. Delete two questionable checks.


This issue was detected by using the Coccinelle software.

Fixes: 6d31b6ff985dbd144b2c4d519cf573b8f81865d9 ("irqchip/gic-v4.1: Add VS=
GI allocation/teardown")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/irqchip/irq-gic-v4.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
index d98d58298e9e..f68560bfd094 100644
=2D-- a/drivers/irqchip/irq-gic-v4.c
+++ b/drivers/irqchip/irq-gic-v4.c
@@ -125,11 +125,11 @@ static int its_alloc_vcpu_sgis(struct its_vpe *vpe, =
int idx)

 	name =3D kasprintf(GFP_KERNEL, "GICv4-sgi-%d", task_pid_nr(current));
 	if (!name)
-		goto err;
+		return -ENOMEM;

 	vpe->fwnode =3D irq_domain_alloc_named_id_fwnode(name, idx);
 	if (!vpe->fwnode)
-		goto err;
+		goto free_name;

 	kfree(name);
 	name =3D NULL;
@@ -137,19 +137,19 @@ static int its_alloc_vcpu_sgis(struct its_vpe *vpe, =
int idx)
 	vpe->sgi_domain =3D irq_domain_create_linear(vpe->fwnode, 16,
 						   sgi_domain_ops, vpe);
 	if (!vpe->sgi_domain)
-		goto err;
+		goto free_fwnode;

 	sgi_base =3D irq_domain_alloc_irqs(vpe->sgi_domain, 16, NUMA_NO_NODE, vp=
e);
 	if (sgi_base <=3D 0)
-		goto err;
+		goto remove_domain;

 	return 0;

-err:
-	if (vpe->sgi_domain)
-		irq_domain_remove(vpe->sgi_domain);
-	if (vpe->fwnode)
-		irq_domain_free_fwnode(vpe->fwnode);
+remove_domain:
+	irq_domain_remove(vpe->sgi_domain);
+free_fwnode:
+	irq_domain_free_fwnode(vpe->fwnode);
+free_name:
 	kfree(name);
 	return -ENOMEM;
 }
=2D-
2.40.0

