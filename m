Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466A0C77B70
	for <cocci@archiver.kernel.org>; Tue, 11 Apr 2023 13:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=bI1+GoxPbXKiViuKaQcDq76Z33aR2GcP0GL02T+ZuP0=;
  b=Q3c6AGFrkPwyQW/Thwu0Q85uYgsaIbNS4FrGRXea9ASBWJgqISeFbdUk
   HcXAV29KBbo6t5VtozBdtRsuB1pj6wC5BV5wfXUmYIG2WYpYblgePczra
   sQLo/SQnPxZbm204q2kwTaShJYqSE/Me4en8T9jB8su9QCH72CSabAdu7
   g=;
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
   d="scan'208";a="102452015"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Apr 2023 15:37:19 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E164BE7312; Tue, 11 Apr 2023 15:37:19 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 879D8E72F8
	for <cocci@sympa.inria.fr>; Tue, 11 Apr 2023 15:37:17 +0200 (CEST)
IronPort-SDR: 6435628b_OxMJYHgGbwgUqAtni6JmWumQrKxDbAQJsuqMZ4fBRKvm8VW
 Vz9FgGV0ELZ+R5a05ZM38H9TPlosqvVNftl45Ww==
X-IPAS-Result: =?us-ascii?q?A0EpAADMYDVkhwQP49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YItgUsvBAtGhFOIHokShDCHLoc+iGuBVhSBLD4PAQMBDUEBAgQBAQMEOIRHA?=
 =?us-ascii?q?oU9Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECEAEBA?=
 =?us-ascii?q?RoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICR?=
 =?us-ascii?q?z4DAyMdAQERJgEPHwYCERUCAlcGAQwIAQGCeoIoAQMxB6xggTKBAYIIAQEGg?=
 =?us-ascii?q?mOZKB8sIlSBXgmBFC0BjQmEMCcPgVVEgTwMgzWDfYEGgxyCZ4EMmSIKgTR2g?=
 =?us-ascii?q?SAOgT2BBAIJAhFrgRAIZoF5QAINZAsOcYFJY0yBewQCFDolBA4DGSsdQAIBC?=
 =?us-ascii?q?zs6PzUGAwsfBlhrAgkjERMFAwsVKkcECDgGGzQRAggPEg8sRA5CNzMTBlwBK?=
 =?us-ascii?q?QsOEQNPgUcEgQ18CgYBJiSeawGBDsYrNAeCK4FWgVkMnw0GEy+DfZMMDgaSJ?=
 =?us-ascii?q?ZdzIIIupVGBYzqBXDMaJIM2TwMZD44gGYQMjwkBPj80PQIHCwEBAwmFRgEBh?=
 =?us-ascii?q?X0BAQ?=
IronPort-PHdr: A9a23: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
 CHe/wKV2m0=
IronPort-Data: A9a23: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
 u3yNpE90tZdD32pqSsuCiSHvNpa
IronPort-HdrOrdr: A9a23:tZtpT6+9+I8//6PxTWhuk+AMI+orL9Y04lQ7vn2ZhyYlFfBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNSftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njbL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,336,1673910000"; 
   d="scan'208";a="102452005"
X-MGA-submission: =?us-ascii?q?MDGDjnR7Kp/rcTu7O/3IMb316Du8lCUWF1ip2l?=
 =?us-ascii?q?hgzvHlTlD3H2U9kHSHcAvLEBqSgUuwWy22LsooUDQH2rd5B5wXsq08tZ?=
 =?us-ascii?q?igpBf5SzrNsEw2aS2KfydgEfInmdxGWfbpEsBTKVTAF6lbrnsFWesVg/?=
 =?us-ascii?q?PbVET+tM7EHN0/X65a5A4coA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 15:37:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681220206; i=markus.elfring@web.de;
	bh=OgaLLOQi3BLhTZK7PXXmygRTTkKNgw64HGqUqvj1wCI=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=KT7iQ92Xle1Il2GXjGRKPNk6oQpe4BLuyn9x1KP+8hwB7EEkFf+GSUlUoxy5/ZNSq
	 E88Yko10tZYLkvlrhbCRL5K29dSQ3RYFpkcNP23i0SKicwFOAtoxhsovWEMWKk9Hci
	 56iwAAppnkLuGJBD1iWXTpQuRsnuv0wI2fJa+Vvba33gVFS8qaZHt1D6vhrqubh1Hy
	 aPKCO0tXAsd2zTPgX0W7E6OjzVWTtooGREnVG4VcyfYQcvkuP4rQDVmcN/n6kd5paO
	 nKTdvh1VlF2s9wsg8CKNNpc34POVX3mOsU+nYHOWZcLcqt+IxHp2zH/znhBNprn88E
	 cYmK08mV08oeQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M43KW-1pmEAw1S6a-000RFh; Tue, 11
 Apr 2023 15:36:46 +0200
Message-ID: <2258ce64-2a14-6778-8319-b342b06a1f33@web.de>
Date: Tue, 11 Apr 2023 15:36:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
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
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Language: en-GB
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wsv7nBnFp1BYjqo/ByyaPrBnKZPriMlSmoRCWlDHk0on2YSaRs8
 4cMs4oUIBAwmnnWXpHtRTHBSJi8QMKFcHU7avEDVgcbe0s3aEu6GupXXHhCePuqY9pdFjnS
 a3wIAMsbpUVnfSNoUATeoayKxFqUNwe9TpTbGlf3KmopmSSS3rXdhXAvfVqZzUDcM9XChah
 PbP8tgwGn68yzSPB/hATA==
UI-OutboundReport: notjunk:1;M01:P0:zM6KziwaR2s=;KZVITbcbBvWrDDYSFy6wHSp/1rL
 MFglw2jeFD99Pt7sKbcuo3pl6SEq1/Rhc7ve+KqWgcR1q0XNIsDz5G5Jw7xHbAQzWBQ3052WU
 QI/tSzynRZiVV8kz+QF3XpKJ8q+Q4vUqBYozN2jI9S7Aku7MWwwxlxBh3OgPBqAB6V7sDduxR
 TXE9BV328bXs678nFh2IJ3A7FmtjAUWivFXN3e6uptNTfgrbjKEfbNSqK3aYG2tCSbF3DzrqU
 omdLoldFuv5+XcW/pqdAL6BVytH77qvSRoy3CILN6Q6vmVfqIPGw6bYmUzHm3iFs6pZ/yIE5X
 7i0wFZhYvvG4wY0WuS03RcDhOWIFkjnZ12FlXTWoUOHEFGzF8ywYnqyZmoIIXbuu3OdF9N07D
 a4HvjFxjztbeOcUSHZ22YTKvgXafc10c1NFBf0/LJtxvPqz+GwWLpiaeIh0dU64AdsWSLJ2TU
 0Dt5g+tKToX3PgQIKW+MCHgEov+A6ijNYOLl8IwvDp7Tl2iTg8HZFjqZqAjN8dxQsRHob5iwE
 Wb7TbZuMEWb0QtncdkKYlo3chL/IIml4Fcqy4Y/knldcyxQwUw48oN402/fCR1458TLxPaPjE
 FVSe3Btyl+oQzE7/IUkMGlN3Y/N8zKa5dwBbi3M7DKcFMI/yhQWO0pVcswvX3qEEmcxD/YI9S
 qjZGjrHPzX7EzDfiFO3UJJPknTVwHUAfWDnkelFmbYHW7arHqQ9vpQxXZ51w2HiLdNtkTdVFV
 8NKwDC3FTUGfYUTR1DSpeamHJDhgEMbUJKE20EmOXlZk+56+REFP4Mif1tm8KOAmAlvqfTcVy
 CmEnOmRoSN169ii/AOwRGcbTDPDKd8J5t8rgmg0HwZvPDCBynI73cz4f9E0RY9CsYbxvFs3dj
 9fG89x/85dENBLo9ZA5uuOTxC/mHpHl0YWqzKckTrHaN+3qRoermX6g+U
Subject: [cocci] [PATCH 0/5] drm/amd: Adjustments for three function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1028
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/2258ce64-2a14-6778-8319-b342b06a1f33%40web.de>

Date: Tue, 11 Apr 2023 14:36:36 +0200

Some update suggestions were taken into account
from static source code analysis.

Markus Elfring (5)
  amdgpu: Move a variable assignment behind a null pointer check in amdgpu=
_ras_interrupt_dispatch()
  display: Move three variable assignments behind condition checks in trig=
ger_hotplug()
  display: Delete three unnecessary variable initialisations in trigger_ho=
tplug()
  display: Delete a redundant statement in trigger_hotplug()
  display: Move an expression into a return statement in dcn201_link_encod=
er_create()

 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  3 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 19 ++++++++++---------
 .../amd/display/dc/dcn201/dcn201_resource.c   |  4 +---
 3 files changed, 13 insertions(+), 13 deletions(-)

=2D-
2.40.0

