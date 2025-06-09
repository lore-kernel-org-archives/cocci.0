Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5ADC5B552
	for <cocci@archiver.kernel.org>; Mon,  9 Jun 2025 07:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=97rwl5tQ9kVnE87DvY09ZWlkxcPn81NrBCP78VTLnE8=;
  b=StXa3VM5XDB7cEFuTGqlAYz6eSU8nxwfvesklzHt5RfG3+51xMrjWi9S
   0mlAX07CTWuua3EuZcKb/J3Yq/VaNnKVzUloMAtSYDLOBtCu8FEEIvyKK
   sBbfaIQnRtaFOWxV+M/R6bBjhUTb5/lkSzMjqmcldapE89ScmqD5pGXpE
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.16,221,1744063200"; 
   d="scan'208";a="225872275"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Jun 2025 09:09:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 70B70E02E4; Mon,  9 Jun 2025 09:09:39 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 89DBCE0131
	for <cocci@sympa.inria.fr>; Mon,  9 Jun 2025 09:09:37 +0200 (CEST)
IronPort-SDR: 684688b0_Jw2jMOees1ToJmAMdfsUO2JjqrazOUYbgquUDFDnDFlGLoF
 ROPw5Gsyx3NTSbE3XrbEdn93c2TDIbz4kZYJfAQ==
X-IPAS-Result: =?us-ascii?q?A0FDAACsh0ZogA4P49RaHQEBAQEJARIBBQUBQIFBBgELA?=
 =?us-ascii?q?YJDgVozBAtJhFWPUIIhA4Q7hzyMQ4QHgVWBfQIPAQMBDU4BAgQBAQMEOIFUg?=
 =?us-ascii?q?nQCi2QCHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QE7Bw4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAgEDIwQZAQERJgEPH?=
 =?us-ascii?q?wEFAiYCAlYGARICAQGCfoIiAQYQAQMyB60bfzOBAYIMAQEG2l4fLCJXgWUJg?=
 =?us-ascii?q?RsuAYVsgmMBhWw7g0J6Jw+BVUSBFAEnC4M2hGmDNYJpgiiBAhSgfoFKHANZL?=
 =?us-ascii?q?AFVExcLBwWBMDMDIAo0FAQZAhQcARIPBBYyHYINgi1Pgh2CEnCBF4IlhTuBI?=
 =?us-ascii?q?4RJK0+EJXxMWoNfJHIPG0ACAQttPTcGAwsbBj2YYoNvAQFSOwFCCSaCBJMOE?=
 =?us-ascii?q?ZNgnyI0B4I4gWaBZAyfaAYTL5dLDgaTAi6HZZBxIqkWgW8DMIFcMxokgzZPA?=
 =?us-ascii?q?xkPjiE+g3WPCgGoG0E1PAIHAQoBAQMJhUYBAYsDgUsBAQ?=
IronPort-PHdr: A9a23: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
 Hnlpg7Tz7CvatsHOcAWMmNQcUPDqHhh/1U=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:35Pbl6DHkBnTAPPlHel455DYdb4zR+YMi2TDGXoBKyC9Afbo8/
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFpSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: 9a23:GYxBA2DPJCJcpZH6EzFG2GgIQZoKS0Dm3nfuEhCqNz1jeoTAHA==
X-Talos-MUID: 9a23:YSzohASTVEog/p5zRXTvm3Yla/VBvZ+OEVkQkKkhnMWAKBxJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,221,1744063200"; 
   d="scan'208";a="118527084"
X-MGA-submission: =?us-ascii?q?MDGvaZEPwB+f8qUPbiZnD/bhqBMZzFc893bQ7F?=
 =?us-ascii?q?z9fgzIKwwpDa5goOjeFriV+riV23AuInD37ySmUllvOsuR9VnsfVrcoq?=
 =?us-ascii?q?SlJU/6OM/V2Pj9nk7FuMORYpONfaohV7BE7utGpuIvRYH/DRIE2woNdS?=
 =?us-ascii?q?x5/lliTmFtBpwbax5348lANg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 09:09:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1749452969; x=1750057769; i=markus.elfring@web.de;
	bh=97rwl5tQ9kVnE87DvY09ZWlkxcPn81NrBCP78VTLnE8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DiXklsIHJVh1r2U3/aWMRFKaEibfOJWK6l2plIFmw9A5rZ5BmrHupDvVMyiYvdW9
	 LTnwn1s0BR8IT81kUTgyPywQR+A8GKYKUSvuGn9UQ63ZhKaXEXAS6bQTDYK/So7C9
	 Jo+Pp/Iyfw6aIBiZCBFjN0uNiBZ1s6mrHWvlJQqRdRzNNzhqlMUEj4WSGPiW1TiMa
	 Effyc04rEYeoZqCDqRq18ALySELxeOnXh3gmFKRjUtv/B+wyNwOzqa5FoLwH0nbWI
	 JhUaOx48KIjFHDGwKjTFg/X2cT7rRXq5fw+b2+rnz4qODjoBsq3vSKaYvwFJ7sZSi
	 8BrovvhvYafiPG6mnw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.233]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPaMQ-1uArff0iZe-00WLGy; Mon, 09
 Jun 2025 09:09:29 +0200
Message-ID: <da489521-7786-4716-8fb8-d79b3c08d93c@web.de>
Date: Mon, 9 Jun 2025 09:09:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <roman.li@amd.com>,
 Simona Vetter <simona@ffwll.ch>, Stylon Wang <stylon.wang@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 cocci@inria.fr, Melissa Wen <mwen@igalia.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <e6656c83-ee7a-a253-2028-109138779c94@web.de>
 <ea0ff67b-3665-db82-9792-67a633ba07f5@web.de>
 <32674bac-92c2-8fc7-0977-6d2d81b3257f@amd.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <32674bac-92c2-8fc7-0977-6d2d81b3257f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6WzgLsEkjsIjvTLIR4U7D19tKLt5E132l1qOf077lk/8aBWo85M
 nU3Ja69SBe97sd2HOryn91M/B2ySJ4DQMB1pKp+WqJdHeX1XnMAM466bE+BSE1QcSIKgtCE
 YwOjS7ShwfKaDWo1DzT6c95H/Dvas3gfxrqPWDYtkAMDvSOh6OyJi0hkyQqvrAsDXY1gqb4
 QN7cyJ9awZ5WsysmdpKcg==
UI-OutboundReport: notjunk:1;M01:P0:y0k/sSibveY=;ESAXnnwwFanhSHIz8fDPov5gqBO
 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
 /7Hs+M4OURCeJalENzUT4TnG0VDeg==
Subject: [cocci] [PATCH v2] drm/amd/display: Fix exception handling in
 dm_validate_stream_and_context()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2750
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/da489521-7786-4716-8fb8-d79b3c08d93c%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 9 Jun 2025 08:21:16 +0200

The label =E2=80=9Ccleanup=E2=80=9D was used to jump to another pointer ch=
eck despite of
the detail in the implementation of the function =E2=80=9Cdm_validate_stre=
am_and_context=E2=80=9D
that it was determined already that corresponding variables contained
still null pointers.

1. Thus return directly if
   * a null pointer was passed for the function parameter =E2=80=9Cstream=
=E2=80=9D
     or
   * a call of the function =E2=80=9Cdc_create_plane_state=E2=80=9D failed=
.

2. Use a more appropriate label instead.

3. Delete two questionable checks.

4. Omit extra initialisations (for the variables =E2=80=9Cdc_state=E2=80=
=9D and =E2=80=9Cdc_plane_state=E2=80=9D)
   which became unnecessary with this refactoring.


This issue was detected by using the Coccinelle software.

Fixes: 5468c36d6285 ("drm/amd/display: Filter Invalid 420 Modes for HDMI T=
MDS")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

V2:
* The change suggestion was rebased on source files of
  the software =E2=80=9CLinux next-20250606=E2=80=9D.

* Recipient lists were adjusted accordingly.


 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/g=
pu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 78816712afbb..f8aa1c541678 100644
=2D-- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7473,19 +7473,19 @@ static enum dc_status dm_validate_stream_and_conte=
xt(struct dc *dc,
 						struct dc_stream_state *stream)
 {
 	enum dc_status dc_result =3D DC_ERROR_UNEXPECTED;
-	struct dc_plane_state *dc_plane_state =3D NULL;
-	struct dc_state *dc_state =3D NULL;
+	struct dc_plane_state *dc_plane_state;
+	struct dc_state *dc_state;
=20
 	if (!stream)
-		goto cleanup;
+		return dc_result;
=20
 	dc_plane_state =3D dc_create_plane_state(dc);
 	if (!dc_plane_state)
-		goto cleanup;
+		return dc_result;
=20
 	dc_state =3D dc_state_create(dc, NULL);
 	if (!dc_state)
-		goto cleanup;
+		goto release_plane_state;
=20
 	/* populate stream to plane */
 	dc_plane_state->src_rect.height  =3D stream->src.height;
@@ -7522,13 +7522,9 @@ static enum dc_status dm_validate_stream_and_contex=
t(struct dc *dc,
 	if (dc_result =3D=3D DC_OK)
 		dc_result =3D dc_validate_global_state(dc, dc_state, DC_VALIDATE_MODE_O=
NLY);
=20
-cleanup:
-	if (dc_state)
-		dc_state_release(dc_state);
-
-	if (dc_plane_state)
-		dc_plane_state_release(dc_plane_state);
-
+	dc_release_state(dc_state);
+release_plane_state:
+	dc_plane_state_release(dc_plane_state);
 	return dc_result;
 }
=20
=2D-=20
2.49.0


