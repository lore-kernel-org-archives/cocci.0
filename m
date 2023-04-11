Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315EDC77B6F
	for <cocci@archiver.kernel.org>; Tue, 11 Apr 2023 13:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ssHZYuhYJ4oDuobkfaIZv09h5zMMPnz87ESwQKZ67pI=;
  b=TP+0ZHst5JZSBVgOdabU1QY7qoWhlQp9Il7gnO7Xqq7JBtyF1YCoXCD4
   M/EMtligaoijWi+mlzbRJ86CVNqAbZtQfj6Lh5IMn3Poz2MPz+AFcy5Je
   sa7jOjkmAbwMkIj7nxE271SCopzh0a8DdtxbRIFaGtwHfcc/tpZriZ+6x
   8=;
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
   d="scan'208";a="102453816"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Apr 2023 15:44:08 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6D2B5E7315; Tue, 11 Apr 2023 15:44:08 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9E33BE72F8
	for <cocci@sympa.inria.fr>; Tue, 11 Apr 2023 15:44:04 +0200 (CEST)
IronPort-SDR: 64356424_Ch4hsQM/S3hZNInzReKMoqcqFO3yUbqAX8MGBWlo5frvaTT
 x0NK9f6sN30hLwLempUyxUbjjafN7yOeXqT5Hvw==
X-IPAS-Result: =?us-ascii?q?A0EqAABrYzVkhwQP49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YItgUsvBAtGhFOIHokPA4Qwhy6QKYFWgUA+DwEDAQ1BAQIEAQEDBDiBU4J0A?=
 =?us-ascii?q?oU9Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECEAEBA?=
 =?us-ascii?q?RoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICR?=
 =?us-ascii?q?z4DAyMEGQEBESYBDx8GAh8HAgJXBgEMBgIBAYJ6gigBAzEHrGF/M4EBgggBA?=
 =?us-ascii?q?QacCx8sIlSBXgmBFC0BjQmDNnonD4FVRIEVJ4EVgiyIH4JnkWOISwqBNHaBI?=
 =?us-ascii?q?A6BPYEEAgkCEWuBEAhmgXlAAg1kCw5xgUljTIF7BAIUOiUEDgMZKx1AAgELO?=
 =?us-ascii?q?zo/NQYDCx8GWGsCCSMREwUDCxUqRwQIOAYbNBECCA8SDyxEDkI3MxMGXAEpC?=
 =?us-ascii?q?w4RA0+BRwSBDXwKBgEmJJ15cgFSO0wwgXqSO7B7NAeCK4FWgVkMnw0GEy+XC?=
 =?us-ascii?q?Q4GkiUul0Ugp3+BYzqBXDMaJIM2TwMZD44gGR6Dbo8JAT4/ND0CBwEKAQEDC?=
 =?us-ascii?q?YVGAQGFfQEB?=
IronPort-PHdr: A9a23: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
 GvfoAmljw==
IronPort-Data: A9a23:dEtnRKD3ZKL0txVW/znnw5YqxClBgxIJ4kV8jS/XYbTApDor0TYPy
 WZLXG+Hb/ffNDP8fd13aoS//UMC65WAmodjOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yM6j8lkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/ouOaDdJ5xYuajhPs/7a8Us11BjPkGpwUmIWNagjUGD2zCF94KI3fcmZM3b+S49IKe+2L
 86rIGaRows1Vz90Yj+Uuu6Tnn8iGtY+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0usyxVEFL0OavHJSxjSCc53PBYkrU2OowMFx1HJ0p6MQqHztD2
 uNNfVjhbjjb7w636Le8V/UqmckpasXmVG8dkis5l3eDV6lgGM2FH80m5vcAtNs0ruVHB/XDf
 Iw0bTR1bRLPSwJCMBEbBfrSmc/13SGuLGAD9Dp5o4Jv3lf/wSJjgYG0D+vJYd/RaZ5spB6x8
 zeuE2PRW0xGaoXGl1Jp6EmEjejEliLTQ5MXDLT+9/hwgVTVyHZ7NfENfV68vOX/lUO0Hd5SQ
 6AJxsYwhZY15X2TVcajYwD7gW61rDxBRYBdPPJvvWlh1ZHoywqeA2EFSBtIZ9onqNI6SFQWO
 rmhwYKB6dtH7+X9dJ6NyluHhW7rZ3NEfAfucQdYE1JfvrEPtalp1kqnczp1LEKipvvRcd0a6
 wKHsiU4jbgJgsMNv0lQ1QyY3WjESnThaAkv+gWfdHis5Ap/eOaYi2GA7F/G8bBfIYzfQlTpU
 Jk4dyq2vbhm4XKlznXlrAAx8FeBuqbt3Nr03A8HInXZ327xk0NPhKgJiN2EGG9nM9wfZRjia
 1LJtAVa6fd7ZSX6NPYqOt7rVZh0lMAM8OgJsNiLMbKihbAuK2e6EN1GPhH4M53FzRVzyvhmU
 XtlWZ/zXS1LYUiY8NZGb75AjeFyn35WKZL7HN6ihxWhzbeEYnOJAb4KWGZinchphJ5oVD79q
 o4FX+PTk0s3eLSnPkH/rNBPRXhXcylTLc6s96R/KLXZSiI4Qz5JNhMk6eh8E2CTt/8JzbigE
 7DUchMw9WcTclWec1XaOi89NeyzNXu9xFpiVRER0Z+T8yBLSe6SAG03LfPbpJF3q7Qx/u0+V
 PQfZcSLD9JGTzmNqXxXboDwoMYmPF6njB6HdXjtKjUuXY9SdyqQ8P/dfyzr6HYvCAizvpAAu
 LGO7F7QbqcCYAVAN/zoTsyT4Wm/hlUjvd5jflDpJ4BTcXr88YIxJC3WiOQ2Ev42Kh7C52W70
 l+IDSchuOWXnY4R9ePNpKGbrrWGF/l1MVpaElL6s5e3F3j+1UiyzbBQVN2neWjma1r136G5d
 8B5/urZItReuHpr6q1SS61Ky4A67PvR/45q9BxuRij3Xg76G4FeLWmj9ugRkK90n5tymxa8A
 2CL8flkYYS5AtvvSgMtFVB0f9a49K8mnxfJ5q4IO2T83ih8+YSHXWh0PxWhjC98LqN/ALg6w
 NUO6dIn1AiitiUEatq2rDhY12CpHEwyV68KspI7AoiyhDE7lXBEQ5jXURHt7L+1Nt5jD0gNI
 x2vvpTkuYhy/ET4TicMJSD/5tYF3ZUqkzJW/WAGPGWMy4bkhOdo/Rh/8gYXbwVyzzcc4d1SJ
 1pECkxRDoeN9gdOm8JscT2NGQZAJRvB4W336QIDu1P4RnmSdF7mDTMCK8OS2nsG4kRgfjR/1
 5OJ+lbPCDrFUpn44XovZBRDtffmc+1UyiTDv8KWR+K+AJgwZGvesJ+EPGYnhUPuPpIsuRfhu
 +JvwedXbJ/7Pw42p4kQKdGT9ZYUeSC+CF1ye9NT14JXIjiEYxC34yaEFG6pcMAUJ/Dqz16xO
 /YzGu1xDSaBxAS8hRFFI55UOLJlvu8b1PxbcJPRGGM2mb++rD1ojZHuyhbDlFIbG9VDrMJsB
 b7SJhSjE3ORj0R6g2XijtdJEUvmbMgmZD/T5vGU8uIIG8g9scVpS0UT06S1jVqRIgBI7xKZh
 yKdRq70nshJ65VgoJvoKYpHXz6LENLUUP+a1SyOqPFMUI//CtjPvAYrtVXXBQRaEr8PUdBRl
 77WktrI8G7anbQxCUb1poKgEvRX2MCMQ+ZnCML7A31Ely+kWsW3wR8i+Xi9GKNZguFm+cira
 AupWvSeLedPdY9m+0RUTCxCHzI2Kaf9NP7grBzgicW8MEEW1AifIe638XPsU3pgSRYJHJ/AW
 z/E46PkopgSqYlXHxYLCs13G5IychepRaIicMa3rjWCSHWhhlSZoLb5iB488nfxB2KZFNrhq
 4fwLvQkmM9eZImTpD2Yj2BzgvHTJHN6nPV2YU8XvdJ749x/4KjqMsxFWajqyLkN+sAx6H08T
 C7AZi0uBE0RmBxaJA7k7o2Lshi3X4Qz1xSQGtDt11yZYWG6CetsxVenGjhIux9LR9co8A1rx
 RzyNJE90thdD6yFndou28E=
IronPort-HdrOrdr: A9a23:Pzsc+qE+XFJhAgVvpLqEPMeALOsnbusQ8zAXPo5KOHhom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/hyAV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs9D4bbLbWSS4/yKhTWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,336,1673910000"; 
   d="scan'208";a="53097534"
X-MGA-submission: =?us-ascii?q?MDHzNLbdXXVdCT8DJID9LbKJNFL2UU0UPqnRcU?=
 =?us-ascii?q?8NRICP/4TwVvHCZ8FUNQIUZ2+O8Alqp3Q/yDOLskvScHhfW5eUxuUl49?=
 =?us-ascii?q?fDF664qYO07hM4YxmgdgRNo6YXx5Wp+nr/6b8VX28PwuBd1HOyFM99P8?=
 =?us-ascii?q?pzBuNHVas+Eq1Ob9d4HWr0eA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 15:44:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681220630; i=markus.elfring@web.de;
	bh=7QMVGNLkemqceAqBuvWC+EimKfuSgO/00Je536TRm9Y=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=TNbeE3ytFDGYp1ad5equCMWRYcyu6KB2oYURomUJlIoPZoIO/KN54tb1SfxL6BqLq
	 l/AYUVrEa6hBQj3RMMMQOF4qj+r7j/hhvQYR1N25TWaPMIijjfzu5RR3nHG1bsW8C5
	 e90IUwjLq+nj2ijxljzvKl11s0DtzqOV6y8KIUuumr0nI343XLaxhtW38s+7OOw5tB
	 /5GjVvG5EwZXQoo+2YkYUtpF5yle1KUrAYmeYrM2EEV3G+afwxwAiW5NbS9BeWmRkC
	 uj+vGn/63pZiLlAhwkoVsYCsOwXZZMmWZdWSZtXeAEcFpcF2yrSw1D6UhthD/m0XMg
	 ZbPGuyVtmkgJQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MC0PR-1peE4x0VmH-00CVOk; Tue, 11
 Apr 2023 15:43:50 +0200
Message-ID: <89048a5f-2dbb-012c-41f5-7c300e8415f5@web.de>
Date: Tue, 11 Apr 2023 15:43:48 +0200
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
X-Provags-ID: V03:K1:PqPz95aENc2yY4ywu1s1GTinq81kvAZt6m4fTsE0rOeI88+DpZU
 h65mIHIHhsh1du5/3FvC1i+ZotOzl1F8SpGJu+FuqahoYLTdb3RXneyQLNSpRbcUL3U0tC2
 Zmaa4JSg35REbB3IqmGjTNAATjBYHPmvG7mASbc8cdbNoecMOBRRBsQT3gLNEa0JoYyuLD0
 MPKJ2lk12ufmrxTcHgRyg==
UI-OutboundReport: notjunk:1;M01:P0:Qx+AswJDC80=;EGkA7B18JdiviSfPLVea3rozgG2
 2RIVxfybNO+4m31FcnHVIKyDa6rnqKNDmiVXxPLqQZU0h1y5rjWx444VRFYoob46lhh+b5a20
 +54IS/teRxhSvI09Ng1nHqycTcPBns9oY2+U0JLH/Fqwys8GDA1LmnmfCQLJKz/MyzNAECerx
 6qDoKWwIBNGVRC4YVZcHvRlhAvy5lr+wP0bOTe/eWnTDV+qnTcsTal4F1cEzgWfjtzaYAkP+X
 zQc99Bbe2NXv1LhO9LigMQFD04QNQkDbxT1TsofT9u0pDvMI11U5hOTIAacm7FmT5uy3hSaaG
 /angXBm+xe3EFcdYfrF89xEVyJJ3mm8btP39hNv+Z5hvuoRI0cSvIIDC2j6e1GQTkaYgxer5j
 8D2YOcMTdOeqRRW3LieuaeCxz5Nwtv1ZlIs4qjSXabTO7g0lfxvIL7e06df8t18VjahTY2kVZ
 A7yNXFUe6Tj3XXM4nsAjmKZPJzUQhmsmUzS4aFHDQihKewLLKB9SeCXDZD1NvEOiae16tjlRz
 16iWbNm8daZ+vOIIP96hapZAMvjLh1pRw/8NYEOEjwZXSIqkDL2t4Xu13XQToY3+96bPCec1U
 NKo8BFcMeqSo4Cn4GALJVNMMHHE+G2XZnNKM33besDS5YpqwuHit+plx3H49KR8kE0waj8nSi
 QNQOD/BQ9TciNiAA2twZA2ucsqd08loqZ/I/8gfLP/9nJPLVkB0zwqENECpfk2TJdgl56TEKL
 +5+r6QFKBsQjccf+AtZMaF6hOuwx/7h7j9kS0z6fpHfvatcnPUsKJId3cIBMJRWjrUfDWhjSP
 27ZBHWFkZ8OK+6xjSIqsMvXcUwGaGoYMDeeYf39PmTuyl+PdLhGraKP+WHY0p3YT++Z6Nla6y
 0stSTVLGh5Fb2ZJGH1SzasRGut01NgMIqsk0ZGgD+XDtLBFZpPAX36YfK
Subject: [cocci] [PATCH 2/5] drm/amd/display: Move three variable
 assignments behind condition checks in trigger_hotplug()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1030
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/89048a5f-2dbb-012c-41f5-7c300e8415f5%40web.de>

Date: Tue, 11 Apr 2023 11:39:02 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Ctrigger_hotplug=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for three local variables behind some condition checks.

This issue was detected by using the Coccinelle software.

Fixes: 6f77b2ac628073f647041a92b36c824ae3aef16e ("drm/amd/display: Add con=
nector HPD trigger debugfs entry")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 827fcb4fb3b3..b3cfd7dfbb28 100644
=2D-- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1205,10 +1205,10 @@ static ssize_t trigger_hotplug(struct file *f, con=
st char __user *buf,
 							size_t size, loff_t *pos)
 {
 	struct amdgpu_dm_connector *aconnector =3D file_inode(f)->i_private;
-	struct drm_connector *connector =3D &aconnector->base;
+	struct drm_connector *connector;
 	struct dc_link *link =3D NULL;
-	struct drm_device *dev =3D connector->dev;
-	struct amdgpu_device *adev =3D drm_to_adev(dev);
+	struct drm_device *dev;
+	struct amdgpu_device *adev;
 	enum dc_connection_type new_connection_type =3D dc_connection_none;
 	char *wr_buf =3D NULL;
 	uint32_t wr_buf_size =3D 42;
@@ -1253,12 +1253,16 @@ static ssize_t trigger_hotplug(struct file *f, con=
st char __user *buf,
 		return -EINVAL;
 	}

+	connector =3D &aconnector->base;
+	dev =3D connector->dev;
+
 	if (param[0] =3D=3D 1) {

 		if (!dc_link_detect_connection_type(aconnector->dc_link, &new_connectio=
n_type) &&
 			new_connection_type !=3D dc_connection_none)
 			goto unlock;

+		adev =3D drm_to_adev(dev);
 		mutex_lock(&adev->dm.dc_lock);
 		ret =3D dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
 		mutex_unlock(&adev->dm.dc_lock);
=2D-
2.40.0

