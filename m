Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381DEC77B6F
	for <cocci@archiver.kernel.org>; Tue, 11 Apr 2023 13:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=yuT1ONtgjIStTe11yWRFo/Dh1dV2qsFCDbO7xYUn24w=;
  b=ktdpcl+RxeOSQxoomx9mu34moAfFU8A+Xm7qKbC6n4itPHHOLuYBtfzX
   9/Y6fjlYJ5la4tATA5VzSf5wA1GN6TTfYf1Ko/G2SFaOklnjt6JKuDjS8
   9dM1OBYHekLFYpNsNdyhySGJuzIW4gBvxynzArvFdZ7x5XhERA6Vl4M6J
   w=;
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
X-IronPort-AV: E=Sophos;i="5.98,336,1673910000"; 
   d="scan'208";a="102454382"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Apr 2023 15:46:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E59B1E7314; Tue, 11 Apr 2023 15:46:23 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AF5A5E72F8
	for <cocci@sympa.inria.fr>; Tue, 11 Apr 2023 15:46:21 +0200 (CEST)
IronPort-SDR: 643564ad_loUq4QAJtA1L8IJWPZYVT45Px2nGc9JhCY4ufrgcSIL199+
 BxTKjawLYkK2WP0x0euSNZZ5X4GmUkQosoElI3A==
X-IPAS-Result: =?us-ascii?q?A0E/AABrYzVkhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYItgUsvBAtGhFORMIQwhy6HPohrgVaBQD4PAQMBDUEBAgQBAQMEO?=
 =?us-ascii?q?IRHAoU9Ah0HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECE?=
 =?us-ascii?q?AEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RICRz4DAyMEGQEBESYBDx8GAh8HAgJXBgEMBgIBAYJ6gigBAzEHrGF/M4EBg?=
 =?us-ascii?q?ggBAQacCx8sIlSBXgmBFC0BjQmDNnonD4FVRIEVJwyBCYIsiB+CZ5ouCoE0d?=
 =?us-ascii?q?oEgDoE9gQQCCQIRa4EQCGaBeUACDWQLDnGBSWNMgXsEAhQ6JQQOAxkrHUACA?=
 =?us-ascii?q?Qs7Oj81BgMLHwZYawIJIxETBQMLFSpHBAg4Bhs0EQIIDxIPLEQOQjczEwZcA?=
 =?us-ascii?q?SkLDhEDT4FHBIENfAoGASYknmuBDnyBesM2NAeCK4FWgVkMnw0GEy+XCQ4Gk?=
 =?us-ascii?q?iUukgeFPiCnf4FqDSaBXDMaJIM2TwMZD44gGR6Dbo8JAT4/ND0CBwEKAQEDC?=
 =?us-ascii?q?YVGAQGFfQEB?=
IronPort-PHdr: A9a23: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
 njf+BbBvwItl9o=
IronPort-Data: A9a23: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
 R3yN5E+0tVdAn2keArL2sGGvA==
IronPort-HdrOrdr: A9a23:ii60DqyQzjN0898ReTGBKrPw+L1zdoMgy1knxilNoNJuA6ilfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bBYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebrN5DNB7foSjjPIduoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,336,1673910000"; 
   d="scan'208";a="53097836"
X-MGA-submission: =?us-ascii?q?MDFRSDupsdbErGqAadmtYJCZeED/h3sCKEhQr2?=
 =?us-ascii?q?PKZ2atu/0Qvwl9hNBx4RbpaULRefGYzmIQE+WMOE2BBeHX2rTutFkX7i?=
 =?us-ascii?q?qH5X6ybYn8hFZw+7ke/UTiUSjB7nY4xkbd0IUkKT0ISGaIUToy93BpZx?=
 =?us-ascii?q?naJctPX7gkwdijLlmK5IV/BA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 15:46:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681220763; i=markus.elfring@web.de;
	bh=UmXfEwjkGD/rVmjQKSe4E0UbAXydT0j9qkxZgnZJ+3w=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=aeAjcezU9SpnI86W3rEWETjVghG+BUjtoGlGqRk+XUJjj32Vw+vNkw1fIN+m08MKs
	 a/nxNwFPXPhPHuN9WBcaFOtMnKTX1MK8JQchLG2Bg9qiM8H6KFC1vtwflq5oW97K3M
	 wl18fx95/GSiF13PiMaFouZc58Kd+b0WGVguoygDPyKVowAXN3SiY0CTml1mAi3AhP
	 WtVIeXNceToEBFy3SNXT5gLLwbHWmLeGQ6PG9k/duQk6KRv41SrWv0WL0idfPCZDHV
	 +mzfEIsUsK8/v5Iuy5QejsE2F9ad2yNgGoU7eg68F0v6f5DOlc2pu77SpktzDYmm0c
	 OPhO5wIQX1BhA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MyvB8-1qZGSv1rbG-00w6KT; Tue, 11
 Apr 2023 15:46:03 +0200
Message-ID: <dd420968-47f1-1839-02e8-d06ffef6c0c3@web.de>
Date: Tue, 11 Apr 2023 15:46:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alan Liu <HaoPing.Liu@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>,
 Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Bhanuprakash Modem <bhanuprakash.modem@intel.com>,
 Candice Li <candice.li@amd.com>, Charlene Liu <charlene.liu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 David Tadokoro <davidbtadokoro@usp.br>, Eryk Brol <eryk.brol@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, hersen wu <hersenxs.wu@amd.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Jun Lei <jun.lei@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mikita Lipski <mikita.lipski@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Tom Rix <trix@redhat.com>, Victor Zhao <Victor.Zhao@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
 Zhan Liu <zhan.liu@amd.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <2258ce64-2a14-6778-8319-b342b06a1f33@web.de>
In-Reply-To: <2258ce64-2a14-6778-8319-b342b06a1f33@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mfR682QWIB15jomI2vo/3Z1VdYVfDYwQO9OXdo8EDMvcQgHyx/z
 eApczEwxVZzgBSCmh8Kd+M3yBz0dM3Cy4eyNfHIt+qTBdmkMBXeQ/l3SnK8lqi6qi9M5tQU
 IYcdOGnmHCPbUwv1U3z7dUYG6dmGviiViwLoln1Y+kjVFkUC0mNG/Nd966zNnZLDvXzVAdA
 y5+Rvy7tcuUBSHX9uGJKg==
UI-OutboundReport: notjunk:1;M01:P0:vqGhnX+j9qg=;kwMl01xOIqacGYDb9vukb2sItW/
 BwIc6yyMLzSg3cNKYYBo1FzmmVyo6rq8Hx4X2CFaHIkTR56hoe3Stf57DsoRPQEjZ2UoWzsyg
 +RPcZrRJiwbzsUrBu91HYD2FsGqueE8XCBfO8a4MG7DFy4p3rP2Q5ROsPdUb4WFJsyxRYHxm1
 UdL+YxwSjlqFP6IChVsjC5+NIQyvfG7yvkHr21Z+9zlRe/bttCtqqfW9QgMPcZJVsp9GLtzZN
 dwIMQ2MhhaYQk3E3VNFS86AAIirSRTpokn+26d8JALNhZjWi3G3OFNsSMZMrckycbgYDa31ue
 pjJfcPIvHk+xs0MS2IDcaKdDax0tWA5ukUuphTd8N8uyhF4zW14/Tb5Y87CDt2too1XfeX6p4
 pe/t4J9/hAESsmvwKAUKnz8ihmejoowIFnFABy+hng6Pwvf4/bh+TgV69zhQwDOesA/oRjEs3
 6mXnu7CS2xkILAfgMxh48FajfgumjTszZoDlHoxlz0vAc/OD5YrMhFUy8lMp4mhfz6Q73Qzje
 Hf701mWB7Ef0f+vM6j3vMnB4CX16gHWbpIA9Jgw28tKhk58dLSRfq3AlyR8+jyqbFQxWtT77f
 CZlabKfhQWPxG23OVqz3q3iCtJEk5G/ixyj0wu5D5S3NDSRiuF7gbLwQRgPOdyZ2A4Py6IzHE
 96LVah1CZBcXnEe5Ej7MHLk1SwIl+AAEku8EoY0atRwcLC0q2e9ebSz2EFGo/lm7HFDCgBiOk
 /qVPBmQ+tuhNtnD03ByH8EWBiZcuDXYwXFhkvTwApoqJDRwpikexbaDsuH4N4uPAZY0VeEWcM
 2LDqMMUOKTMDdVKQc1MIA9HveKcwHVFWvvmYXNdc4ZlEmB8NTZoW99KRhCyIk/AaDVJRk/PKY
 SjMJuxwsYsnVrmDNoreDa7y9jn2gxs8cZJo2Q5WEpOK+MJs/4S1aRAEab
Subject: [cocci] [PATCH 3/5] drm/amd/display: Delete three unnecessary
 variable initialisations in trigger_hotplug()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1031
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/dd420968-47f1-1839-02e8-d06ffef6c0c3%40web.de>

Date: Tue, 11 Apr 2023 12:34:42 +0200

The variables =E2=80=9Clink=E2=80=9D, =E2=80=9Cwr_buf=E2=80=9D and =E2=80=
=9Cret=E2=80=9D will eventually be set
to appropriate values a bit later.
Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index b3cfd7dfbb28..a37d23a13d7b 100644
=2D-- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1206,16 +1206,16 @@ static ssize_t trigger_hotplug(struct file *f, con=
st char __user *buf,
 {
 	struct amdgpu_dm_connector *aconnector =3D file_inode(f)->i_private;
 	struct drm_connector *connector;
-	struct dc_link *link =3D NULL;
+	struct dc_link *link;
 	struct drm_device *dev;
 	struct amdgpu_device *adev;
 	enum dc_connection_type new_connection_type =3D dc_connection_none;
-	char *wr_buf =3D NULL;
+	char *wr_buf;
 	uint32_t wr_buf_size =3D 42;
 	int max_param_num =3D 1;
 	long param[1] =3D {0};
 	uint8_t param_nums =3D 0;
-	bool ret =3D false;
+	bool ret;

 	if (!aconnector || !aconnector->dc_link)
 		return -EINVAL;
=2D-
2.40.0

