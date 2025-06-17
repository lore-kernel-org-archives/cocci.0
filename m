Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395C0C7114A
	for <cocci@archiver.kernel.org>; Tue, 17 Jun 2025 06:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=W/eYVUsYjhYNAzlFtlDPOabUz5P88wa8dv8eQF4JdOw=;
  b=WLEFeyRRM4cj6ZJvq+nlie6200KUq7ittiL5uXesvIAyrb3l89TeIrlP
   JYmgoS+o0/yPm/DuAC0WWxedBITymzssSrkdSaTZ73n3cz14gpabk47rK
   dqGCbxYZPcfjIgxx/bs/B+tJaeLeRqKJC1/RTIQNLvQcAHK1Uz7TLoHzC
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.16,242,1744063200"; 
   d="scan'208";a="227510108"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Jun 2025 08:40:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 00DC6E0AF1; Tue, 17 Jun 2025 08:40:38 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8FEF0E0131
	for <cocci@sympa.inria.fr>; Tue, 17 Jun 2025 08:40:36 +0200 (CEST)
IronPort-SDR: 68510de3_vi7f9nOz5vWO3OSQEKHpcwk6M//xIUOFb/j9QVWPn8+IHXN
 cFshIYn9/8zBwJbrMfigYXuc1x2bR9yD2g5Z+Ww==
X-IPAS-Result: =?us-ascii?q?A0FyAQC6DFFoeAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UIEAQELAYJDgQAGVDMEC0mEVY9Qhl+PD4RwhAeDUgIPAQMBDUoEAQIEAQEDB?=
 =?us-ascii?q?IQ6RgKLZwIeBwEEMwYOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABQw4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAg06RAIBAyMdAQERJgEPC?=
 =?us-ascii?q?xoCJgICVgYBFAEBgn4BgiEBBhABAzIHDbESgTKBAYIMAQEG2l4fLCJYgWUDB?=
 =?us-ascii?q?oEbLgGFbIJkAYVsO4NCeicPgVVEgTyDAz6CShcEGIFGg1uCaYIogRaEJIQrh?=
 =?us-ascii?q?EdLgl+QbFJ4HANZLAFVExcLBwWBIBAzAyAKNBQdAhQNDwESDwQWBS0dgg2CL?=
 =?us-ascii?q?U+CHR+Bc3BpAwMWDwGCJIFeHINCgSOESStPgyKBA3xMGUGDXx4GcQ8GXEACA?=
 =?us-ascii?q?QttPTcGAwsbBj2ZCYUsgU3HHjQHgjiBZoFkDIotlTsGEy+DcQGTWQ4GkwIuh?=
 =?us-ascii?q?2WQcSKNZZsxgX4kgVwzGiSDNk8DGQ+OIT6DdYRgiioBqBtBNQIBATgCBwEKA?=
 =?us-ascii?q?QEDCYVGAQGKdIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:PyR0QK3gxKPk0zasvss3LgqjBGYkLtp133Aq2lEZdPWaSL37qy
 ncpoV+6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:QJvEH2wljqV5NZWVrbdGBgVLA+ZmbVDn5k2BOhOgJHxmEr7STkKfrfY=
X-Talos-MUID: 9a23:bxHwNwqEUIPFzixtQbYezxxQH59RvJ+DM14curIXvcm/HisoOx7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,242,1744063200"; 
   d="scan'208";a="119223095"
X-MGA-submission: =?us-ascii?q?MDE6kpQXk9jXHP339nXmLOl/EkCpsbksZWURCa?=
 =?us-ascii?q?zswomSHb29ZI7zw+uqQMQmLb+kofoxJE4krT1bs2GNGPXbWWABabKFZU?=
 =?us-ascii?q?8Vb1FyBSEl6jTMvA4eOFVgkAMu6jOrc8k1r4aSgLOKcdx6To2Sv6vlMU?=
 =?us-ascii?q?UhiTu8ylD/G7Ce2PvSlBvZog=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 08:40:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1750142431; x=1750747231; i=markus.elfring@web.de;
	bh=W/eYVUsYjhYNAzlFtlDPOabUz5P88wa8dv8eQF4JdOw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UrMD+QCFTVv8PB+r07tztOzJIRJbG37CPBe6J22wgFUhpavijxjPd62KSa56jZe6
	 5qL79mTj9D2rgHWsf7JtMlFN5DuoGjhgElX7HQF95j3w+xzjp9LVFfi1t2CcX4cnn
	 zMCQUo4jq59GaFYKQjWR7cfzIjzS0pTmUR0HmCZtpk4hfjrPLmW5uhNZdYkCC1w55
	 AZ3mmsn9/IO1vaQv08xoonV7DYjVO0Lw3wtZhYELb8BC0bqYf9lWodCwlET0Bc2yz
	 RNyhwGi63lSF1zI/O9Ylpg0rlK0gcDzcMketaiWvdH74j95bYoWiAoiAtOoEqICp2
	 UCHdfT1kbzAjaIKt5w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.238]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRk0W-1uLStw45Uo-00L8b0; Tue, 17
 Jun 2025 08:40:31 +0200
Message-ID: <f9bffb72-b463-45d0-ac72-9a5ff4daec38@web.de>
Date: Tue, 17 Jun 2025 08:40:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alex Hung <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
 Roman Li <roman.li@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Tom Chung <chiahsuan.chung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 lkp@intel.com, oe-kbuild-all@lists.linux.dev, llvm@lists.linux.dev,
 cocci@inria.fr, Melissa Wen <mwen@igalia.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <e6656c83-ee7a-a253-2028-109138779c94@web.de>
 <ea0ff67b-3665-db82-9792-67a633ba07f5@web.de>
 <32674bac-92c2-8fc7-0977-6d2d81b3257f@amd.com>
 <da489521-7786-4716-8fb8-d79b3c08d93c@web.de>
 <8684e2ba-b644-44c8-adf7-9f1423a1251d@web.de>
 <ba89d859-f132-4e7d-ba29-47331e02152a@amd.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ba89d859-f132-4e7d-ba29-47331e02152a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hnrgU48qW8YbbumGxfVVaCQYutIW5tQhAnG2uxaNogCv+Volpoz
 NtmjNa9mVp1Vuc014Zos4Xx/7c7bXp3juCUjI3normNm47Rk1rswj21iMGDp7AcOX7DblMb
 KwwbP0mep3lNNqI9JxRT3dxZn3UYBMTSkeenIAn3Ux2HAwTpkF0J6NIhXnlxWYwlkXIwnis
 mJXovzuulJoDRcs3vcBIQ==
UI-OutboundReport: notjunk:1;M01:P0:ELls9iipYWU=;wtK+btvYB86GZAQM2s+IwtLUGsZ
 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
 9hm0Da2hm0u85xqH6UL3XzL/PXyQ0N/hOlGj4A==
Subject: Re: [cocci] [v3] drm/amd/display: Fix exception handling in
 dm_validate_stream_and_context()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2789
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/f9bffb72-b463-45d0-ac72-9a5ff4daec38%40web.de>

=E2=80=A6
>> 1. Thus return directly if
=E2=80=A6
> I guess the intention was to reduce goto statements.
=E2=80=A6

Partly, yes.

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.16-rc2#n532

Regards,
Markus
