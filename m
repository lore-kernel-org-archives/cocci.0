Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70160C46CD4
	for <cocci@archiver.kernel.org>; Tue, 26 Dec 2023 15:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=xhhg3WPx2g0PhvAE2QQCgOf1wg9vVvmvPY4xU04oKug=;
  b=aZ4mWJuBJutdKhAlBVejoRua5uzXLNY3HMW1j21Amdax7M2QisH09XNA
   jg0vuaYZmO2HNOLQBS/OWX8DqjJ6Jgulw66tW8dASUXYhAhU+4r+ytGIo
   BlUHHSj8DLdQzlTu6qrReSaxv2dA8MViVf+XkbtbnxD8Q8NPw8Uguk/Rc
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
X-IronPort-AV: E=Sophos;i="6.04,306,1695679200"; 
   d="scan'208";a="144062626"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Dec 2023 16:56:50 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DCF63E0CCE; Tue, 26 Dec 2023 16:56:49 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CD6A1E004E
	for <cocci@sympa.inria.fr>; Tue, 26 Dec 2023 16:56:46 +0100 (CET)
IronPort-SDR: 658af7bf_TY+VUAO9HqDP3DtUIIaqbirshebVOxUTbT0ollbaR5GF194
 6xq4L/0nbwoujOy+zi2H6C7X8Arc+9fUvFAP9XQ==
X-IPAS-Result: =?us-ascii?q?A0FFAACA9opl/07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4B3hTMgQLSIRTiB2HJIF1LQOBE4MohzWQO4FWgUA+DwEDAQ1BA?=
 =?us-ascii?q?QIEAQEDBDiBU4J0Aoc2Ah4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECgQYThWwNglwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAkdCB?=
 =?us-ascii?q?iMEGQEBESYBDx8BBQImAgJWBgESAgEBgnyCKwEDMQeuZH8zgQGCCgEBBoJmr?=
 =?us-ascii?q?HIfLCJWgWAJgRouAYgaAYVng0F6Jw+BVUSBFScLgQmBN3aIHoJoiRsHMoIdg?=
 =?us-ascii?q?1CRV30EAUFwGwMHA38PKwcEMCIGCRQtIwZQBCghCRMSQIFdgVIKgQE/Dw4Rg?=
 =?us-ascii?q?j4iAj02GUiCWBUMNQRGdRAqBBQXgQ9uGxIeNxEQBRINAwh0HQIRIzwDBQMEM?=
 =?us-ascii?q?woSDQshBVYDQgZJCwMCGgUDAwSBMAUNGgIQLCcDAxJJAhAUAzsDAwYDCjEDM?=
 =?us-ascii?q?FVEDFADaR8yCTwPDBoCGx4NJyMCLEIDEQUQAhYDJBYENhEJCygDLAY4AhIMB?=
 =?us-ascii?q?gYJXSYHDwkEJQMIBAMrKQMjdBEDBAoDFAcLB1IDGSsdQAIBC209NQYDCxsGP?=
 =?us-ascii?q?gKmRQdTKBNMgiqScpMdijGUQTQHgjSBYIFhDJ8rBhADL5cmDgaSVC6HUJBPI?=
 =?us-ascii?q?KhGgWM9gVkzGiSDNk8DGQ+OIDiDc48JAT1ANTsCBwsBAQMJhUYBAYNagUYBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:2iloMqyZP3NTrzZd6sZ5KrPw+L1zdoMgy1knxilNoNJuA6ilfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bBYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebrN5DNB7foSjjPIduoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:ODj7L2OAnvtqbO5DWTdF+Q0rRc0cbmDGlSbhORGSNzh0R+jA
X-Talos-MUID: =?us-ascii?q?9a23=3AVDI8lg9kdaKUfpOtUg6xUJCQf5YyzaiMGX8Nras?=
 =?us-ascii?q?H/OeDCCJzIibGoB3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,306,1695679200"; 
   d="scan'208";a="144062621"
X-MGA-submission: =?us-ascii?q?MDFENBrWFUuO20WLiwf5FqFF6MAN56DpN6Zy9b?=
 =?us-ascii?q?WG2+BqnrHulIhT61NEGiOojd8XMZa4Sjt1VUrj/5Gk25FUdJ6TObckbP?=
 =?us-ascii?q?NA1a+p/9Gs/34zB3XDxOb7MlZ4LmmO228SUMfLoamM2SspEVz+8sUdwW?=
 =?us-ascii?q?URXaWfUG3OE2P42xGQcpv22Q=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 16:56:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703606191; x=1704210991; i=markus.elfring@web.de;
	bh=uWBMhje7ZnzueSLD7LuYeqWtZzVY1uT5I4jy8esiVbk=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=m6qaxfUaiAQ/owAQgBLoODQqGpf2+ppC7/X2Z8mm5JlP/stKKFIzyHU1Ksje0D+Y
	 nywqF1yvOm0qlSpLarVuWBK31QHGAfgz+oeHD5pvvP7REk4usU1hAWYEciLkK9WqA
	 AZ+9AqGbs24tMhv0GAohedrTWLxqaKTkjjqB05JIJLlYzgR92XI73+LwZfBjVXJYd
	 whsv27bM/WxFpPfLW7hlpAYbWtZ9UfHWOXLtOAwyoQp+BQJ2TJ9BCUw1apL4zFZVR
	 iSDM6uMbhiu+IBH/W6qVTQYigWCjylm/ja0V5Z9o3MvgGrjAWi2fSHPzc0hoRmb17
	 5o+Eew0h5NOTNI8rBg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVrg7-1rjp0s2pAz-00Rv8A; Tue, 26
 Dec 2023 16:56:31 +0100
Message-ID: <85066512-983d-480c-a44d-32405ab1b80e@web.de>
Date: Tue, 26 Dec 2023 16:56:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <12b3e9cb-3241-40cc-b7a4-43c45b9eedc9@web.de>
In-Reply-To: <12b3e9cb-3241-40cc-b7a4-43c45b9eedc9@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kFHY9yzY0ytYPPNU9cHVZlo/ERarFH9Ioj7KihE9pad6kKHxIsk
 ar7pLsPSyAM659MpM2okcf9zWYIir43459sPBCIw8RFGfPE2vfDLenLDFBrVaj//o0/MUx7
 Tmit/ZcHm7Ezwnppn4xKBRiv1j9wbAzOUXe+/xzfTQ72d7VLa4ySFCK7ApzFSrVhaJKhfDG
 /ynRvpJKJSLxAs5hKgIpA==
UI-OutboundReport: notjunk:1;M01:P0:N9GZXRsOf+Q=;QML2pte76YXDPlKHPaBzAAwpJSc
 SXf7TY/2ebPLuHjIFTcB4EMl0/eTkBOpr34V/BEH8GljMMlV2D9saR5zF/s9xhYmHOKZIju1d
 uP5zqwr2y+gn2yUP4YU1cF+UUtJCfMRDLgm7VFPBFv+B1WwSIk3JEkWW3datKMZMB6QTC3Ao2
 jOtfAtd8mf08LwLPCLKalPPjWtUz2B6OkZKZuIYJIvBDcVBMco6kyNBIF31ILr03TUXAQs7Dm
 Cyd4xFg4B8P4eoxF7EnDX0lR3Gc6HcdjcGc30NfajJ9PThCazXNufcCWxIYYwh65y+7AY2fPt
 PTTvgsypNAH7vigHKFitd1lFt/kgv+Z8OKxUpM4NrdpM6YMis0++afgWk1Z50WO4KFrYmCA7D
 cULfbWjOnc1Axnima1T4dSLJMeAdZhPaoQMNsb89Hvil9I8i8H0teUEptDRt7LtVnml1Xv/Q4
 R3Z0nUFGqnd8NSDB6AwFZgBD1MKrVP32KA8VYcOTiVfOhVeLpugqTNk9mSPDst92uPk+xQmXG
 fMAjhLjqyf9NqNOCviXyJRvRuN4lMn1AyNZnsaAyQfuSrZ+hZAMBLulEDLpG09iFMUynJeBL9
 62ooIfW5SBvqa56s+tFxyC/7mE+iycFUjMznrbuHsbs4nxxWEyMG1yHkzEg06AyAnuP0It8kV
 GgimqiRBXmyEm1UG7UiaJoGWlOENPo9U9RW3X5UhuabE5Ac7LiR5XVMiMr85twnmq2suSt+HF
 RZNTsjXn/N8D4aRlHD/mPBqsC7TlynxJEQVDaaw6jbbCnmaxxgMj6Vqg6pSbnxG8lXW+jU6G3
 zJB9TR/WzO9zCqfSMjzbCygPxjGeXrg+FAJECSJzJ+WBPcRsw3998Ium9dSH4U/S1dt/dy3t5
 RVJjcMc8WxDDWhe2AC4UMSUeuqLGU7VOLYyXlzkWm3y/QP5inuvyhdha/8aWD3+nW8UZSgfH7
 B8glyA==
Subject: [cocci] [PATCH 1/2] drm/sched: One function call less in
 drm_sched_init() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1399
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/85066512-983d-480c-a44d-32405ab1b80e%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 16:30:25 +0100

The kfree() function was called in one case by the
drm_sched_init() function during error handling
even if the passed data structure member contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus adjust a jump target.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/scheduler/sched_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sche=
duler/sched_main.c
index 550492a7a031..b99d4e9ff109 100644
=2D-- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1289,7 +1289,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
 	sched->sched_rq =3D kmalloc_array(num_rqs, sizeof(*sched->sched_rq),
 					GFP_KERNEL | __GFP_ZERO);
 	if (!sched->sched_rq)
-		goto Out_free;
+		goto Out_check_own;
 	sched->num_rqs =3D num_rqs;
 	for (i =3D DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++) {
 		sched->sched_rq[i] =3D kzalloc(sizeof(*sched->sched_rq[i]), GFP_KERNEL)=
;
@@ -1314,9 +1314,10 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
 Out_unroll:
 	for (--i ; i >=3D DRM_SCHED_PRIORITY_KERNEL; i--)
 		kfree(sched->sched_rq[i]);
-Out_free:
+
 	kfree(sched->sched_rq);
 	sched->sched_rq =3D NULL;
+Out_check_own:
 	if (sched->own_submit_wq)
 		destroy_workqueue(sched->submit_wq);
 	drm_err(sched, "%s: Failed to setup GPU scheduler--out of memory\n", __f=
unc__);
=2D-
2.43.0

