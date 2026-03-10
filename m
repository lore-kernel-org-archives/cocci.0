Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0776CFD2D6D
	for <cocci@archiver.kernel.org>; Tue, 10 Mar 2026 12:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:to:cc:references:from:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=gF867SZzGYLT8GRpHbaChcflB30COqiDq6XJ+UvHW18=;
  b=noZZ0+6stpmNbWVT5RTHybs9VATgxDBD7/hFhLLg3JvdsLzlx8zHYgUo
   weSpcoT7NLe2Bdt39AFYm2yHI7+DlaAMxGIQxudzIdU15qlmO36+gFoqI
   LSA4avNuDmvqgETAFRgGGAbB35zZ5W4UbfdXrvWmdnQk6Z0Bu3pGACFva
   w=;
X-CSE-ConnectionGUID: fZW8IBMUS1i8J7cKhj9JPw==
X-CSE-MsgGUID: oj+fvd9rQhKrbjePcYMWAQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="267089967"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2026 13:46:03 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 6C729833BC; Tue, 10 Mar 2026 13:46:02 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 76BCE83058
	for <cocci@sympa.inria.fr>; Tue, 10 Mar 2026 13:09:27 +0100 (CET)
X-CSE-ConnectionGUID: wsoFP/PqSjKd7MaJAfTcIA==
X-CSE-MsgGUID: Kp/HzKV4R3S9nOl8hhMDAA==
IronPort-SDR: 69b009f7_dbOtsTXEbdP6mGBZBJWUEFQbMRGKDFtOTgixxAWebOjghsC
 ZZCLVSI34lUQYvo4FEypfjQV4BG8vxEvFKaKsmw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EpAADuCLBpgQ7EXShaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4FAQELAYFtU0EBgSUyB1GEWINNAQGFLIh8hDuHKZBhgVWBQDUKDwEDAQsCL?=
 =?us-ascii?q?iMEAQEDBIUAAo0iIAYBBDIHDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQE7B0mGTw2CYgGBJF5IAQEBAQEBAQEBAQEBAQEBAQEBAQEBF?=
 =?us-ascii?q?AINXgEBHQEBAQECAQEREQQLAQ0BATcBDwsOCgICJgICIAcKJQYBEgIBAR6CY?=
 =?us-ascii?q?IIlBBIDDycEAqBLAYE9AgKKKHp/M4EBggwBAQYEBNsnDYEzgSIJCQEKAYEKL?=
 =?us-ascii?q?gGINB8Bg2eBcxo7hD+CT4EVJwuCeD6CH4V/gmmCJoEOiQqBB4I/hlBSeBwDW?=
 =?us-ascii?q?SwBVRMXCwcFgSMQMwMgCi8tAhQNEBIPBBYFLR1wDCcSDx0XFB9YGwcFEiEqg?=
 =?us-ascii?q?Ul4gWYbD4ZqeQMuXhoOIgIoEgNZSj4LWgWCPwIBC209NwYDCxsEPY5qPoIzA?=
 =?us-ascii?q?QGBDpVog1EBry5xB4QfmVyCAIYBBhMvqmsuh2WQcyKRcJcEAgQCBAUCEAEBB?=
 =?us-ascii?q?oFvAjGBXHBQgmdPAxkPjiEMFoNejz25Q0M0AjoCBwEKAQEDCYI5j2WBSwEB?=
IronPort-PHdr: A9a23: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
 OGykcexOj4=
IronPort-Data: A9a23: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
 vVALpTw6Ilp6Kyc5VFO9Tg0xg==
IronPort-HdrOrdr: A9a23:cwU01au2j3gAhAXXLAly6hLp7skCmoMji2hC6mlwRA09TyXGra
 2TdaUgvyMc1gx7ZJhBo7+90We7MBThHO1OkPAs1NCZLXTbUQqTXftfBO7ZrwEIdBeOldK1uZ
 0QC5SWTeeAdmSS7vyKnjVQcexB/DDvysnB64bjJjVWPGdXgslbnnhE422gYyhLrWd9dP4E/d
 anl6h6T23KQwVqUi33PAhyY8Hz4/nw0L72ax8PABAqrCGIkDOT8bb/VzyVxA0XXT9jyaortT
 GtqX2w2oyT99WAjjPM3W7a6Jpb3PPn19t4HcSJzuwYMC/lhAqEbJloH5eCoDc2iuey70tCqq
 iEnz4Qe+BIr1/BdGC8phXgnyHmzTYV8nfnjWSVhHPyyPaJMQ4SOo5kv8Z0YxHZ400vsJVXy6
 RQxV+UsJJREFfpgDn9z8KgbWAnqmOE5V4Z1cIDhX1WVoUTLJVLq5YEwU9TGJAcWArn9YEcFv
 V0Bs203ocaTbqjVQGWgoBT+q3sYpxqdS32AnTq+/blmQS+pUoJgHfxn6ck7zQ9HJFUceg32w
 2LCNUrqFh0dL5kUUtMPpZxfSKJMB28ffvtChPnHb21LtBxB5uKke+93IkI
X-Talos-CUID: =?us-ascii?q?9a23=3AFaUdq2rEBBMII0lBP4X2ICLmUd8+dVPli0/JGE2?=
 =?us-ascii?q?bBTlMQZ+8R2Ob2Yoxxg=3D=3D?=
X-Talos-MUID: 9a23:/ImpDwa0Zel3pOBTlCerpCNBCptSuJ//DmcJwZUGnuWtHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="267083145"
X-MGA-submission: =?us-ascii?q?MDHgKQvOTx9M2bRhXXaYKvJO+3qJk2kT5kwMOK?=
 =?us-ascii?q?uOm9NwVdZ5vYdRH/JnCEArbhz+pVt0p+lM44XZNHzQu82OZQEFGYzKTd?=
 =?us-ascii?q?dvBc87Oud1aGXYQj7B3v1zT8DbXTPUeo3ND+hmhEGRo70PL1ZGZv+oZ3?=
 =?us-ascii?q?6ZM1+vLCGw9hdX8LRatyYWiA=3D=3D?=
Received: from mail-southcentralusazon11013014.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 13:09:26 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJsVMBb/tfGS87N6mIm9gRpXLCG42LAurayKGilMpxH/PDAr6bPNORfmCWZdjFU5R7D5YcYVguQFtqfLsyUmX6kxPFEiSnzSsT0X3i0FZTMjFiZB5JSgx61rS8Jiq20+4FG0+Db95lS++3Ok568q+HrUTsjrgmzRIPtYvLHTFAfoIVjW6PkzcMkPY/QZEoyboF3mMAY3EBMYeDlzkyUfQNgv2is2HOBv6kxvpCtksmMrmf2C17YqcNm63uz9PJF3rzu/pXmn+Y/40v82v0CJVF0IRzwjgpXNkpPu70bEE9PhaBjBzo/VB/yBbp3ICmJYmfpH5tnLllbLzWc8qcbqCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gF867SZzGYLT8GRpHbaChcflB30COqiDq6XJ+UvHW18=;
 b=A2Ru6EbP1EMp/PDkCT0cnRgB1/f8s00+cW4TFkcG/EjOacy1+TJQGOWYk0aHUmOpC/iMXYysAj27QcdMd/BifeatINVRALr3MGmWitIvYGtDPpaaAFSeBoN5DEyM2/QJ8S+tpub4ZOorKtpKdyn7FcqVVhHnus1onV+uLNBWMVPmeU0wQqfsudk9uYlLGgmXCwK/gGPYwXxxZiOtCx+KpkS4vkdrkM7hoso3ret+vtforbnCV+dubm12lKmnClHIQ4COIEeapD+O3McKAo0po2MlRrlzp3AwgsZZHp7CBIZXA6ITZnNhl8vT1O4jjw2v7/ovSA3Eojwqo3dIub9S/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8926.namprd12.prod.outlook.com (2603:10b6:a03:53b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 12:09:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 12:09:15 +0000
Message-ID: <e8a328f9-568c-428c-9111-8742e5dc9a4e@amd.com>
Date: Tue, 10 Mar 2026 13:08:57 +0100
User-Agent: Mozilla Thunderbird
To: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org,
 apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org,
 cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Zhenyu Wang <zhenyuw.linux@gmail.com>, Zhi Wang <zhi.wang.linux@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Alex Deucher <alexander.deucher@amd.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-37-bd63b656022d@avm.de>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260310-b4-is_err_or_null-v1-37-bd63b656022d@avm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:408:ee::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: 47f3db0b-99c2-4a41-234d-08de7e9dd8e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|22082099002|7053199007;
X-Microsoft-Antispam-Message-Info:
	rOsxnTx2kr7OFzy5oepnHTPa0Bl5bJUKTo+63luhlotIfFC3KzHLS+E3VMqAH1iHBTKaMYJ2UmsdfGDNZaGu1pbEMDo//hCzcDM4M0QcZ45ZOizgGMHWaZ1ya6xgl3xwPkUvHxqqi0dZr9N6cRTFQsw2jWmjewkDeVuOnYane588HX2iWR3CYWIfa7Br5OJ8iwoNCOeglYq2hmCD+XVye2SYHUtE3Hy4SP9KBI+8BmSMAMQ/VOPLHLKz4RZ9XB2O5YjMjmZNxo77a9Wn4CGVWydbDau3GMYxKNosqPKCKb4Q1CUax6ft49mrg9SC//kqRW1zqMolNibmO7EJ8UrT+8LEQLFweVShgEKu5cPWaq3q4EG/+BJAf1IDt5+JDbViN17XVz70lGDOGZ4jwQRjV4vf9JdhxuB4SEEixCLVEvpCz1BN1wjaMZJjUQJ1rBtYeCl7QcnPw9U0IKylRYTF5xRaKrh7F+9YZM5fq1EYA8ZCM91wDsdBKj5lLGxj8vM0EN2SWbDWewgwDW8HgSigsEvdgly9gfuYdn31TzS0vOH/OX63TN1XP4v6vomPJEuUHP++WLg3pWBA3+DbKgempasoOCVE7DLrw/dyeIIxqkWziHoLnwrgnCzwadYNNG+thV2OSa9TYKcYx215HoD7gpmsNcq0zcO0TS0q9MaYHbyjHNj6G+3J45FlJseURnlO+nW1rf/TKjD52NDMyHLSNSRr9yuLpthUPmg9JNvsnPoFd1Ih5I4yneCQepirDpxfGM+ONzOAPJ8ruHE9n09qdA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(22082099002)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1AwRVFocW41VXIyT21kL25qc09PRmMrUmFOdmVac0U0V1hTYjN6aUpIdDZ5?=
 =?utf-8?B?dkRQb21XQWNhaVdmelNIamQ4SXdCUDFSekF2NklUMC9ycDZyUWFFNXRGM1Q0?=
 =?utf-8?B?d1FUQ2d0b3Zpb3dqK2NNQ1lrUzJGeGlLRU9rekxOcFFhOTlqWWI3bit0TVJ5?=
 =?utf-8?B?V2liamcxbjM5SmRzcFJvTmNkYnpjWm1KSVI0SmZDNWIyV3hwQlNkT0phTUlJ?=
 =?utf-8?B?UUVSRDBpMVZvZ05xVGlNdWN5aC9lNGN4cXplUmVoREZUYzhEOWRUWjlOdlZ3?=
 =?utf-8?B?VlFvMEwzT1Z5TGwraTFMZmJRczdQV0R0emVocTlKUFpuOXA3TWJmRTJVVDJm?=
 =?utf-8?B?M0U2NnROelpvbEJKcWZLK3E3MzZaNXZFUzBxdzZ1NmJzSTZuZ1BrNXc3MitE?=
 =?utf-8?B?Q1FXUmRpR20rOStjVDRzeUxpTUp3VVRhbWVsSFdrV2lmZ0M0SFFDTjBQNERs?=
 =?utf-8?B?Q0dDcXdaVWoySXZNdWh4YVBGUkNPWWcrYTl5ZnRmamhKMks5NEQ4MUtoelBt?=
 =?utf-8?B?SmVITXBjVEwwTkgyTlhSUlVNVUZJOTlJM0ordkZBRUYyZmpNUjNQR0hCdTZ1?=
 =?utf-8?B?Sm9vNmZpMkg2VFc4OFh4VUVOZ1JJL2F0RGhxS3VWZitGVVRKWVQ3MktHOHVs?=
 =?utf-8?B?YnoyT1d2Q3Q0Z1o3MGRTcnpUVFZ3UVVYUTBFcjVSbE01azdaNytsUzQ2WFIr?=
 =?utf-8?B?WUZBZHB0bGIvOXFhV3VjK0xUZ3U4Yjc4OHdKSm5tOUxucFpOMkJjcXZXTVVC?=
 =?utf-8?B?RGJzOU1yU2N1c2tIR09qQW0zQ3AwaWc3OEdqUlQ0S3hubVVORXB4NmdndHFp?=
 =?utf-8?B?RXFwRjJ5cmUvMWRGZVduQk9IUFhXQVc0SjBKUEkzeXFQRU96dHc4VTJxdi92?=
 =?utf-8?B?c0VUNjJuZU85SUN6YXZ5M2cxeStJWkVNMXZrRnFpOGJoSW9XSER4aHkwZFVt?=
 =?utf-8?B?UGRnSkdSREJwNGJuNTh5bmtiS2VXMU1JUzc3OCtHY3VzcVZpUWl2MDByUEJL?=
 =?utf-8?B?TUN1M3pBVXZEcm5KaUdpNTVHZWZwNEZhZHlVbTRwQ1NjWThTa3ZHZ2pKdDF2?=
 =?utf-8?B?bkhmTjBPMEFONkFPeFhzZlVvZ1VRQm5KT1hLYWZEanVvaUlWWGtYUmJ0TCtx?=
 =?utf-8?B?MjRDei95ckRET05hVFFEdjVxcURHYlJleWhCV3Mwd2dZdE01K0t1V2lPeXlM?=
 =?utf-8?B?MXIwZHExd2hyZkNZUVZHYUNHbUxCU2wyVDh5WCtqWmNDRkF1RHJ5alQzVFha?=
 =?utf-8?B?cVpYbDZtMGxJQmpIZ1FkbW9UN2JFNDNCZEV6T09IaUoyUU5YOEN5WXlNN2V3?=
 =?utf-8?B?MkhUaVQ0ZnZFOHFTVFY1NHFJRFNZaStiUlVxamZtajJxTHFaczgzbXR6YmVC?=
 =?utf-8?B?bVNxdlZxUXhLVXBhM3AyRHVZczhxREJYdFdpOWRCajdRZUpDTzR0TTJoS0w2?=
 =?utf-8?B?VTczMUIwN1hnc1IrRldzY1dMdzZuU0NnTjc0cFljbDF2MzZtR1luWWltQmlD?=
 =?utf-8?B?cEw2Y1FEZXFwVjZKdG5xVDRUeGRTaEdpczgvUDEyWlU0b3h6cEFsa3d4bUdp?=
 =?utf-8?B?N2NiOStpMzY4cU1ZZStzWEJuOEplNnFHeFZCYlF5OGo1T0tvRVRKT0JiUERn?=
 =?utf-8?B?WG5PdHFvbWIwSUt2REFYMHh2MVNtUVZSMGJENjZNSXJoeGo4K1FpQVZMTkdw?=
 =?utf-8?B?Vm50bzFicFNuVVFvMUhMRS9tczM1Wk9rejRKanFkcC9SN000cUUxUlZSVzZt?=
 =?utf-8?B?SG01L1NJbWNnc09HSGk4YkNPeEdjaE1kN2FQQUY3VHFtMEpDdDFuclZnUDRR?=
 =?utf-8?B?dzVoWXZrS3hQcEdKMTlwTXQ1VlFjMlFuVnptNmVkRGFyQk9lL29jY0NwcStC?=
 =?utf-8?B?bS9BVGNQak1ka3Vsb0FON0pKbWltdVphN3ZtVm1WNUZ5UEVGM0pqQmRaT3dJ?=
 =?utf-8?B?TjBsaDVzSzhBekl0T3I1RXZGdVhIamNkSy8rdDQzSVFiV1J2U3NDQWx1OVBN?=
 =?utf-8?B?eXk4V3k5R3NpSlRNaktTWkJiNTZiVU1LeGdDZkw4NVBSWDZXRXhSMlErQ0NK?=
 =?utf-8?B?d24xSnZ2U2xOVm9JTjYzdW5qMGZEWWJEamZMMmkwQVhyeXdZUmV4Y0graDFN?=
 =?utf-8?B?V1VxRjBpVmxTaW0xZEswTG12a0pJTjRTU0hlUjZGZnc3SFZmNXZsR0t6QVpQ?=
 =?utf-8?B?TWF6eDBoWDFhcFJJaW9MYnRDUC9hZVRWTi9URVN2ckh1bVQvV0R6R3BXcVBC?=
 =?utf-8?B?QUtWME8vZzk5V3UxZDZUTnU5eHl6Y2ZoZ1hjdXI0MmwyODNZNU5vaEZnS3h2?=
 =?utf-8?Q?DfmazJR2VH3VghHRhw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f3db0b-99c2-4a41-234d-08de7e9dd8e9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 12:09:15.0060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HqRTO+mz3lE4w162bISlJt1G5cnWIiVsGPkfJ+DfwnudZuohoYCt/6AWclzBsAkl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8926
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 37/61] drm: Prefer IS_ERR_OR_NULL over manual
 NULL check
Reply-To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
X-Loop: cocci@inria.fr
X-Sequence: 3369
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/WOvYvTRPVEq9jiOyphQxNA>

On 3/10/26 12:49, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.

Looks like a reasonable cleanup but could be that driver maintainers want to take that through their individual branches to avoid conflicts.

Alternatively when the i915 and rockship maintainers say that they are fine with the change I'm happy to push this to drm-misc-next.

Regards,
Christian.

> 
> Change generated with coccinelle.
> 
> To: Andrzej Hajda <andrzej.hajda@intel.com>
> To: Neil Armstrong <neil.armstrong@linaro.org>
> To: Robert Foss <rfoss@kernel.org>
> To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> To: Jonas Karlman <jonas@kwiboo.se>
> To: Jernej Skrabec <jernej.skrabec@gmail.com>
> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> To: Maxime Ripard <mripard@kernel.org>
> To: Thomas Zimmermann <tzimmermann@suse.de>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> To: Zhenyu Wang <zhenyuw.linux@gmail.com>
> To: Zhi Wang <zhi.wang.linux@gmail.com>
> To: Jani Nikula <jani.nikula@linux.intel.com>
> To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> To: Rodrigo Vivi <rodrigo.vivi@intel.com>
> To: Tvrtko Ursulin <tursulin@ursulin.net>
> To: Alex Deucher <alexander.deucher@amd.com>
> To: "Christian König" <christian.koenig@amd.com>
> To: Sandy Huang <hjc@rock-chips.com>
> To: "Heiko Stübner" <heiko@sntech.de>
> To: Andy Yan <andy.yan@rock-chips.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: amd-gfx@lists.freedesktop.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c       | 2 +-
>  drivers/gpu/drm/drm_sysfs.c                     | 2 +-
>  drivers/gpu/drm/i915/gvt/scheduler.c            | 4 ++--
>  drivers/gpu/drm/radeon/radeon_test.c            | 2 +-
>  drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index ee88c0e793b0416d20105a43448cb4037402e64b..64fa2bc8d28197147ee22b4f74134cc27dd9b32d 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -3608,7 +3608,7 @@ void dw_hdmi_remove(struct dw_hdmi *hdmi)
>  {
>         drm_bridge_remove(&hdmi->bridge);
> 
> -       if (hdmi->audio && !IS_ERR(hdmi->audio))
> +       if (!IS_ERR_OR_NULL(hdmi->audio))
>                 platform_device_unregister(hdmi->audio);
>         if (!IS_ERR(hdmi->cec))
>                 platform_device_unregister(hdmi->cec);
> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index ef4e923a872843339743d21e4877225855da921e..6748acb4163e8f5658c9201a0412b38862c7baab 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
> @@ -600,7 +600,7 @@ struct device *drm_sysfs_minor_alloc(struct drm_minor *minor)
>   */
>  int drm_class_device_register(struct device *dev)
>  {
> -       if (!drm_class || IS_ERR(drm_class))
> +       if (IS_ERR_OR_NULL(drm_class))
>                 return -ENOENT;
> 
>         dev->class = drm_class;
> diff --git a/drivers/gpu/drm/i915/gvt/scheduler.c b/drivers/gpu/drm/i915/gvt/scheduler.c
> index 15fdd514ca836e84f4de95e3207ab45bb9243426..933ec5ffa1f1ebafd687996f167b982490702211 100644
> --- a/drivers/gpu/drm/i915/gvt/scheduler.c
> +++ b/drivers/gpu/drm/i915/gvt/scheduler.c
> @@ -675,10 +675,10 @@ static void release_shadow_batch_buffer(struct intel_vgpu_workload *workload)
>         list_for_each_entry_safe(bb, pos, &workload->shadow_bb, list) {
>                 if (bb->obj) {
>                         i915_gem_object_lock(bb->obj, NULL);
> -                       if (bb->va && !IS_ERR(bb->va))
> +                       if (!IS_ERR_OR_NULL(bb->va))
>                                 i915_gem_object_unpin_map(bb->obj);
> 
> -                       if (bb->vma && !IS_ERR(bb->vma))
> +                       if (!IS_ERR_OR_NULL(bb->vma))
>                                 i915_vma_unpin(bb->vma);
> 
>                         i915_gem_object_unlock(bb->obj);
> diff --git a/drivers/gpu/drm/radeon/radeon_test.c b/drivers/gpu/drm/radeon/radeon_test.c
> index 0b459f7df23bae3eef7e36f4b5f35638fb6f4985..573284c4af60f12d7edec889260fc8a2e2b70420 100644
> --- a/drivers/gpu/drm/radeon/radeon_test.c
> +++ b/drivers/gpu/drm/radeon/radeon_test.c
> @@ -234,7 +234,7 @@ static void radeon_do_test_moves(struct radeon_device *rdev, int flag)
>                         radeon_bo_unreserve(gtt_obj[i]);
>                         radeon_bo_unref(&gtt_obj[i]);
>                 }
> -               if (fence && !IS_ERR(fence))
> +               if (!IS_ERR_OR_NULL(fence))
>                         radeon_fence_unref(&fence);
>                 break;
>         }
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> index 3547d91b25d317c6cad690da7d97a7e5436c0236..8a267de85da9c76c2e29b2ababf1218e400282c2 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> @@ -1095,7 +1095,7 @@ static int dw_mipi_dsi_rockchip_host_detach(void *priv_data,
>         struct device *second;
> 
>         second = dw_mipi_dsi_rockchip_find_second(dsi);
> -       if (second && !IS_ERR(second))
> +       if (!IS_ERR_OR_NULL(second))
>                 component_del(second, &dw_mipi_dsi_rockchip_ops);
> 
>         component_del(dsi->dev, &dw_mipi_dsi_rockchip_ops);
> 
> --
> 2.43.0
> 

