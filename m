Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A01C77B6F
	for <cocci@archiver.kernel.org>; Tue, 11 Apr 2023 13:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=L+Fs6TspIjxcWWzxZkIvOuDD7tqbSDmPe5FyfWZrAaI=;
  b=gScf5qb1wipIzgUHsN3FiaQuGcK842lb39Ix9HGX6iPLAC6ebLFKfxyE
   XSiO3cu2BpQf6kruTfCGfnU6tMgCULZqI67AtBodwm62dyfYuYixmvgCO
   gRB26UmgFmqFQ9pB6cMUR2bBuGf5F7maTOH9RHasQnoV/uGfgzq0yL1e2
   U=;
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
   d="scan'208";a="102454881"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Apr 2023 15:48:43 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 18BAAE7314; Tue, 11 Apr 2023 15:48:43 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2C4E3E72F8
	for <cocci@sympa.inria.fr>; Tue, 11 Apr 2023 15:48:41 +0200 (CEST)
IronPort-SDR: 64356538_S0SfdzsloK3T6hbXJJ4m/AIblgBOtWtzBHRaT9Yt91g5uzz
 MEDkjShEN0bR7SvHaQJBaHB78dX9A059w7KhnqQ==
X-IPAS-Result: =?us-ascii?q?A0EjAwB7ZDVkhwMP49RaHQEBAQEJARIBBQUBQIFPggYog?=
 =?us-ascii?q?UsvBAtGhFORLQOEMIcukCmBaoEsPg8BAwENQQECBAEBAwQ4hEcChT0CHQcBB?=
 =?us-ascii?q?DQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAhABAQEaCRcHDhAFI?=
 =?us-ascii?q?oVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESAkc+AwMjBBkBA?=
 =?us-ascii?q?REmAQ8fBgIRFQICVwYBDAYCAQGCeoIoAQMxB6xffzOBAYIIAQEGgmOZKB8sI?=
 =?us-ascii?q?lSBXgmBFC2NCoM2eicPgVVEgTyBFYIsg32BBoMcgmeBDJkiCoE0doEgDoE9g?=
 =?us-ascii?q?QQCCQIRa4EQCGaBeUACDWQLDnGBSWNMgXsEAhQ6JQQOAxkrHUACAQs7Oj81B?=
 =?us-ascii?q?gMLHwZYawIJIxETBQMLFSpHBAg4Bhs0EQIIDxIPLEQOQjczEwZcASkLDhEDT?=
 =?us-ascii?q?4FHBIENfAoGASYknmsBUjsBe4F6kn2wOTQHgiuBVoFZDJ8NBhMvg32TDA4Gk?=
 =?us-ascii?q?iUuh12PaCCCLqVRgXojgVwzGiSDNk8DGQ+OIBmBDQEBgn2PCQE+PzQ9AgcBC?=
 =?us-ascii?q?gEBAwmFRgEBhX0BAQ?=
IronPort-PHdr: A9a23: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
 D+6zw==
IronPort-Data: A9a23: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
 RzyNJE90thdD6yFndou28E=
IronPort-HdrOrdr: A9a23:H9RtXqmHbglDQ6z3yxNn/eg1W8DpDfOeimdD5ihNYBxZY6Wkfp
 +V8cjzhCWftN9OYhodcIi7Sc+9qeu1z+883WBjB8baYOCAghriEGgC1/qq/9SEIUHDH4FmpM
 NdmsRFaeEYbmIKx/oSgjPIdOrIqePvmM/HuQ609QYPcegeUdAE0+4PMHf4LqQZfml7LKt8MK
 DZyttMpjKmd3hSRN+8HGM5U+/KoMCOvI76YDYdbiRXpDWmvHeN0vrXAhKY1hARX3dk2rE561
 XIlAT/++GKr+y78BnBzGXehq4m1+cJi+EzSvBkuPJlagkEuTzYJ7iJnIfy/gzdldvfqWrCVu
 O85ivIcf4Dr085NVvF2ScFkzOQqwrGrUWShGNwyEGT3PDRVXY0DdFMipledQac4008vMtk2K
 YOxG6BsYFLZCmw6BgUd7DzJmtXf2eP0AgfeNQo/glieJpbbKUUoZ0U/UtTHptFFCXm6Jo/GO
 0rCM3H/v5ZfV6Tcnic5wBUsaqRd2V2Gg3DTlkJu8ST3TQTlHdlz1EAzMhamnsb7poyR5RN+u
 yBOKV1k7NFSNMQcMtGdZA8aNryDnaITQPHMWqUL1iiHKYbO2jVo5qy+7kx7PHCQu168HLzou
 WwbLp1jx9NR6u1M7zz4HRiyGGzfEytGSjxxtBX/dx3obv5ALb7N0S4OSETr/c=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,336,1673910000"; 
   d="scan'208";a="53098051"
X-MGA-submission: =?us-ascii?q?MDETwJS9jOowIf2DU1AB/o08Zaz15d/kXT2K9H?=
 =?us-ascii?q?h49OzoYzXcvRAWnpmI2HuPHM9QXqZPnps2NZo5DZyfTfnlHaY2c+vFHz?=
 =?us-ascii?q?CKdgwywg/hcc0bWSXjmTAsXvMA62AbeBrk2pqkwFsnqfFDEc9HSHb9hK?=
 =?us-ascii?q?ur8jU1UjwijUTG1CjD0dWUVg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 15:48:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681220909; i=markus.elfring@web.de;
	bh=PmartcUcUfUvHCefd8IJ+WPgBwHOSel2Zds0LKRahh4=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=nrVQQa9ygHmJ/UTngS9Q+NhPtrZjxolEMDWtgwbBekoz+YGIiacMtU7RJ/LHhZTUD
	 rcDD6Hzb+hOzDiWZCDBMtv/KWa73OeK//KPLPeGLhReyNrUNiEg0zR98N9BGai7OVf
	 t3wXerofMNlLalhYNDijRHj+UWf8rTpw8zvsoQI38RuHMUIkkcs0LFvbqmrtbweuz9
	 ALsCyQbRvaqbdChOM6aCQ1l2DxCh9TkDu12TH7wHeqpVP73xJt96Zuj9oIh2BQxfox
	 KcXvsIerSHZPILuF6ghFjZnhS20XMxFu1OayLE/hAMpP3iahCKRPKbAP6lHtaVYHwI
	 B2xa4j1XvPAKw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWi5s-1pskkP0uhk-00X2oX; Tue, 11
 Apr 2023 15:48:29 +0200
Message-ID: <c06c97f8-7b5e-ccb7-e634-aab8ed450e7c@web.de>
Date: Tue, 11 Apr 2023 15:48:27 +0200
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
X-Provags-ID: V03:K1:OjNaTpA6rVU38fiTJC0fNNG2t5tB53sqqQBlbcCU5z3ROHPDvcj
 T2gqQXeh8yKLTB4ZZgIdo37z2QE9Bu5ylSF4QIGa0tHspLI264JEP5rudggzyB+U+TjbEfW
 zi/siiBDU2A1X16WR39Av+5hKyI6irY6syLjtUH2HOIP+UU3FzGZ4tgGJTi9x3yo65L0s3S
 yunPLxXOdRyQzStwxTyIg==
UI-OutboundReport: notjunk:1;M01:P0:7EabMdF49OI=;x9HznEdNHgVb/jUMFKku/XplEHV
 xT0XNK29XjKB1UDQ3hGxZ+JoLOhxjVL3VZK2wpb23SJaynAIAyB4utT7Du+0Durlf0cQM3a98
 bhLNqFrRg16PUADKH6PsG0H4gsDl2dDJeEdB5uGjfO35c55Yuwg0mdJ38g8pL+inZL0MkIQFl
 vh3HReLxJ/T5THBM4g1hMQ3OygjIZoZpZyVl9m1PkRyqw8KAED8HeXOTkOInAySM4A4f+Ej4b
 xTBwQLETNnsjMrwJNY0uTZF27D+cx2tCDRUWUaCc47+GuRcdC9noRXQk0EuM9jjuGvtqcB2ZO
 pRgV7plHQsGa0uvA3yYB9n/9RDFRm3dCTVgsJx99C6+3Qwvlz35gUKaJGfEz2+MxCvq0JnAYO
 cRGyP6qW/SXr7aRkQf3ullLO3rmQfboqy3bLbsoS4NLPPkY+pPUnLXJSpASa2fCgQgD/8ieHh
 rSnHM4rIeKwXSmGUI03sLTUgB05VQZ+m27SSR4UnDaIRMHcDa37iBwFfW7nn3uDLkRk7dHkqF
 IPbRodhPIaJN+9ScxT5Ebua2SXIv5vHnSYXp5XlVIHC8jdGq8I2zOB7H7j6QB1N0uAvp/CbFH
 js7q1LOoOv4O/VlT1pkh2bY/AVUTsEC4LMus/fadO2ZangeoXpiUGwJWjiMrGfHaUFdzcL0bH
 AjJfhwZ/fXWhWDH7fxxUgKiyiYZbSSX54NW+PJxf14Jwxl/SWlvwhXiBCgML1ajirOWON5SjK
 +gM32NaEXy+6Q2eTraOO2js2kTrq19pAPhae3ulbe2v5llno09GLPg9FmVEoznUfplXb4mIPC
 xWq2UOIj3/2G5+my4hZeBfCLCQzxnlLXt/HQaql9E/1sTRTmEXwmF6tiBcHhUOFHtrIfye+1H
 CC4E3E5IlJn8FL9NG+WpYfOYzVYkw9cmBFcxqczKMIh4KwBpK5VTLsDdJ
Subject: [cocci] [PATCH 4/5] drm/amd/display: Delete a redundant statement
 in trigger_hotplug()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1032
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/c06c97f8-7b5e-ccb7-e634-aab8ed450e7c%40web.de>

Date: Tue, 11 Apr 2023 13:26:35 +0200

An immediate return is performed by this function after a null pointer
was detected for the member =E2=80=9Cdc_link=E2=80=9D in the data
structure =E2=80=9Camdgpu_dm_connector=E2=80=9D.
This check was repeated within one if branch.

Thus omit such a redundant statement.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index a37d23a13d7b..4805a482dc49 100644
=2D-- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1278,9 +1278,6 @@ static ssize_t trigger_hotplug(struct file *f, const=
 char __user *buf,

 		drm_kms_helper_connector_hotplug_event(connector);
 	} else if (param[0] =3D=3D 0) {
-		if (!aconnector->dc_link)
-			goto unlock;
-
 		link =3D aconnector->dc_link;

 		if (link->local_sink) {
=2D-
2.40.0



Am 11.04.23 um 15:36 schrieb Markus Elfring:
> Date: Tue, 11 Apr 2023 14:36:36 +0200
>
> Some update suggestions were taken into account
> from static source code analysis.
>
> Markus Elfring (5)
>   amdgpu: Move a variable assignment behind a null pointer check in amdg=
pu_ras_interrupt_dispatch()
>   display: Move three variable assignments behind condition checks in tr=
igger_hotplug()
>   display: Delete three unnecessary variable initialisations in trigger_=
hotplug()
>   display: Delete a redundant statement in trigger_hotplug()
>   display: Move an expression into a return statement in dcn201_link_enc=
oder_create()
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  3 ++-
>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 19 ++++++++++---------
>  .../amd/display/dc/dcn201/dcn201_resource.c   |  4 +---
>  3 files changed, 13 insertions(+), 13 deletions(-)
>
