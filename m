Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522CFFD2D93
	for <cocci@archiver.kernel.org>; Tue, 10 Mar 2026 13:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:to:cc:references:from:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=0wHimKomilJLoyXBh4UYx8NImrmifztyqfE3GbkvMk0=;
  b=mWLP/d9DySOqHAs/G5skpkUqDCBmjh4Nz7jskO8YiR93t3bpB5I8CEYD
   Lw0kL7Lw9Emc34KyMhwRXAaqLXF7rvKSft7gkoZ3bNJXUvyBoLq3fqq+M
   tAYsQhwG0vIxeRMFjEvL7FCyO8++6DFWYoXrWX/Ox5Rbl43G0lxcBGg/z
   s=;
X-CSE-ConnectionGUID: sEJytOhNSdWRoxH1jIby5Q==
X-CSE-MsgGUID: 9vw33Ln0Sr2fPunRvZIl1g==
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
   d="scan'208";a="267107321"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2026 14:48:36 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id E4F1683424; Tue, 10 Mar 2026 14:48:35 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id AD004833E1
	for <cocci@sympa.inria.fr>; Tue, 10 Mar 2026 14:24:08 +0100 (CET)
X-CSE-ConnectionGUID: dof//JCYQ0WhoxFT5yMCKA==
X-CSE-MsgGUID: vUNaxW3oRw6QvkiJQJkvow==
IronPort-SDR: 69b01b78_omFH+H9vmwrnbSUir8dIqomwjU3FyXQYj4/VYVk64c78cKw
 rPo3la0r7H0tkgnpTcbbSH7c5aJWv4AXvaCeDwQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EBAAAPGrBpjyCl3M1AGhoBAQEBAQEBAQEBAwEBAQESA?=
 =?us-ascii?q?QEBAQICAQEBAUCBPQQBAQEBCwGBbVNBAYFXBAtJhFiDTQEBhSyGWIIkhDuYC?=
 =?us-ascii?q?oFVgSUDGD8PAQMBCwEBUQQBAQMEhQACjSECHgcBBDEIDgECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBAQEBOQUOO4ZPDYJiAYEkUQ1IA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEQINKDYBAR4BAQEDEhEEGQEBNwEPC?=
 =?us-ascii?q?w4KAgImAgIxJQYBEgIBAR6CYIIlBBIDNgMBAp8uQ2cLARs2IwFIAlZCiREBA?=
 =?us-ascii?q?QF4fzOBAYIMAQEG2y8YY4FnCRQBgQouAYN8gXKCZQGFWho7hD8nD4FVRIEVJ?=
 =?us-ascii?q?4MDPoFSgwaDRoJpgiaBDokKihZSeBwDWSwBVRMXCwcFgSMQMwMgCi8tAhQNE?=
 =?us-ascii?q?BIPBBYFLR1wDCcSDx0XFB9YGwcFEiEqgUl4gWYbD4ZqeQMuXhoOIgIoEgNZS?=
 =?us-ascii?q?j4LWgWCPwIBC209NwYDCxsEPY5qPoItBgEBTz6CQJZ7jHCBNqFFNAeEH4FeB?=
 =?us-ascii?q?gyfbQYPBC+qay6HZZBzIqh0AgQCBAUCEAEBBoFpATg8gSAzGgQfgzdPAxkPj?=
 =?us-ascii?q?iEMDQmDXo89ugNcPAIHCwEBAwmSHoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:tZJe36isp4hN3YTKl9F+HWNYlHBQXrQji2hC6mlwRA09TyX4ra
 GTdZsguiMc5Ax6ZJhCo7690cu7Kk80nKQdibX5Vo3PYOCJggaVEL0=
X-Talos-CUID: =?us-ascii?q?9a23=3AvrwvUGkiNDb79faHVHlv/f9K7wzXOXHawjCXAWS?=
 =?us-ascii?q?JMD5WSLqFZ2PN6YZPsOM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Acn5WxQyBNOUGwGleZB/EcHFoZlKaqLqTLkkdrs4?=
 =?us-ascii?q?BgdbaDDJzOhWkrjepRZByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="140927588"
X-MGA-submission: =?us-ascii?q?MDE+heacUHIG1dfpiIEptjLlhWqretc98/Y03S?=
 =?us-ascii?q?q/JDHBZKdwHQJ4nFXZtJsUt/JEClZM5WAePd8OT74SKUZaOQJPKs2TMS?=
 =?us-ascii?q?2lPysdr1zL6HsH+gaCS+uoBVwAE91rvbaSUD8si+F/c95keVbE9NYHx7?=
 =?us-ascii?q?ZOHPwoI5Y5aHY10XAdOFEDhw=3D=3D?=
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 14:24:06 +0100
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A9uX0Q1628282;
	Tue, 10 Mar 2026 13:23:57 GMT
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csmps2t4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 13:23:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62ABsDoD040456;
	Tue, 10 Mar 2026 13:23:55 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4crafa4v28-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 13:23:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wk6KL+hC1gRypI01qHiG1iXN0tsNLXeu1d3hCVSJOcrw+EoW6ay1oVKMsI962qXqjPT7C4g0XQYtioMVVHCTGgr+TBI7r5ukesDszE5OhLB/kVmIMeJPLXhk2Vw6kpqPC+GyKNUgwMcwD95CJ0d6uvcCvFFQvAl2h3z6k546KT9ku5qfOitxsrq39dzHxoAUk3NhEw03dayGL+bjHrSJLhN048DN1pXFQXA3d95Xv3QiO5PNXy3wT78JwzCTwdfl94UdIiaS9nHOlcSvHQ80l2UiErbAtE+3nkgkMtoGUoiv6BbbcsD0LepLc096VIU3xfDA229HFWla0xXnfUBt4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wHimKomilJLoyXBh4UYx8NImrmifztyqfE3GbkvMk0=;
 b=Ay0RaAgDqWK4MZTSeRiWTkw91LPj9NH+3Yrh/iW8c7Cnw/oRHuDS84M0I9NL2eoF6xJaeoLnMjIhhBvD6JeVplASFlPU/5nkjvdvvwPWx0iLj3c2GO+SvRXVXSN+qCIa8B6a1sBj7Oj3V/w1YiP82GPBv8Qnb24WD8i+OZRlBZmgjvSDKd2TwQxERxr5sEnRJBz6M9LdOFHDl4SxCsRXH/Pi/7ZoXIY1pUH+4SbPTFpX3fu18ISEd145br7wZ1o4Uolzf6BtFNshc3HgajLGwOhYN9hJS3lG4tzsrlB0Uu8Wf495KeME9PBKdxQ/j8iQtC3mIlJt4qeSPABst7dwIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6688.namprd10.prod.outlook.com (2603:10b6:208:418::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Tue, 10 Mar
 2026 13:23:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 13:23:47 +0000
Message-ID: <d807a2d5-75f2-4d67-b2d1-dfb6b9c6dbcc@oracle.com>
Date: Tue, 10 Mar 2026 09:23:42 -0400
User-Agent: Mozilla Thunderbird
To: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org,
        apparmor@lists.ubuntu.com, bpf@vger.kernel.org,
        ceph-devel@vger.kernel.org, cocci@inria.fr, dm-devel@lists.linux.dev,
        dri-devel@lists.freedesktop.org, gfs2@lists.linux.dev,
        intel-gfx@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org,
        iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-sctp@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
        sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-30-bd63b656022d@avm.de>
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <20260310-b4-is_err_or_null-v1-30-bd63b656022d@avm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0016.namprd19.prod.outlook.com
 (2603:10b6:610:4d::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: dd21a29a-1151-4daa-d79b-08de7ea842e6
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|22082099002|7053199007;
X-Microsoft-Antispam-Message-Info:
 c5p0iL+8MlDzs+ZovlT5nmOTEU9H91XUrfEXWFRBohtH2yIpTc9x1mr45OcD2q+aW4pxUtQ2Lzev1w44JgzGsTULVnKbjkpQ66Nw3dsuRrflFq5eyUxrciecC0qDbGvUXj4wPESnIGXNyT8RAPnMhwHAfbfqfeoqo7L12QtjK0gyXeJpSk6Wxz8UxthlnVvM6l8TwCDti1zn9h2JtWrZZaNmbtNw/R7Ou9fz9mcbSio92X+KdHpKbExkZmbfLlf9ZLHmjnzHiBdmPZlBXsozBgJypouHCAopP46rOy9ckxyJe1a1vuE4GQVpVoyHtal6YhpW3XtYV8uQykUVBmTCRBO1greHlJia2aiUcdrxyYhqAzszvuxrsnkZ6eIaZJZaMp0YBCtrFPSVbKj7sg/+peK7I1RAQRtxScZkd7/h+wAGKARMNEpTWwh8F74h5XPaRDtv8rK/aH+c8LuVoOKOF2rAJ3f478Vcbcsjq46mAKAZt+CLVpdyCUHXJJa9tsWv3Kr6wajO6bAvwi6lPINPoAtcV46xpUFighDAsjNTD840e0PrvhWcLuhCZ2JXj/rEnCFLoULTpIl99TDUCnEXpM9SUcYwp2vlkYwe7e/q6vaeDupw0vkZdiNU3DtJAfB1Qwvrqjjt+n/PWxO/oknZk7JN1h/FgHGqDbKcjfTmpUz7Zjn899NgZ5d/TTU+5ps0MThXa53xitH6uQ7x/mv3iVCSvYlqRMlasnuq5N+V+9HcMBIubAbTIPaA3ffaL5uE1HfLE6dDAIH9caTr8YP4LA==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(22082099002)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aUkvb3BmQXlycFFyYms3cFIxK1BscVVNVk42MW9DeGI2SURjdmIyMkw1eWtm?=
 =?utf-8?B?WGVva08rQkgzVGVERjhaUHRRSXpUSFBOTW5UVGdGbXhUMGF1WEpvSkk4QXFw?=
 =?utf-8?B?clVZOTZnWWduTmFkazE0dDE1clQ4aUlwcTRWaEU3QVdNUEhIRW43SXdOWVZ5?=
 =?utf-8?B?NmpNMVN4NFpQYU9lY1owUnNuYVdEYUhNbm9jTGpoOGZYWGlVVVlUVXNBLzNu?=
 =?utf-8?B?aWl6N1BkNzB1YzhnM2d2akJObVg2N0V6dDRISnVmS1R6Ykx5RitOc1h1QTFE?=
 =?utf-8?B?Yk0wckVrejQxSzcxdGJhdXhKWURERXRkeVNxMFZqakY0NjZ3VHlJVDFXTUFM?=
 =?utf-8?B?aVFITnlyT2JxOTZ5RUV5RFVUQmcyNkR3bFV4VEkvdmRyc3NPZHdvVlhaU3JE?=
 =?utf-8?B?TnVwNzNzdEQ0cG5iMG1TMmxRMnJ2dUN1bVFxd05NQnZ3ZkZDcytFazVsY2Jh?=
 =?utf-8?B?R2lFUEZZTEh3ZTlFcFVvdmpwc2pBN04zVlpJZ0NtVUZXWmVVbWRpOUx1Ym9y?=
 =?utf-8?B?bm93bjg1VG5ma25Iak5UbG1mOFhLVHVmRHpRd2Q3Q05vOWhTbkpCR015L1dZ?=
 =?utf-8?B?QWxUS0Q1azlueTRIeVBGR2UzQXJ1OU8yV25NdjQ1eSsxdUhSVWc2dEExU241?=
 =?utf-8?B?NGc4VW4zaUdJT083RWlydjJyME9TTXcwQkEwVjNXQTFRdjNGc3o5VFhHTkJZ?=
 =?utf-8?B?VWs5Mzc1SE1xejFOdlhTNHhIOUNRbForaFhHTjQ0UU5YOS9FekYzSWkrUnd4?=
 =?utf-8?B?ZnNhTnZkdG9iOGtJUXdhRER4UzBKVzVsVHZqdS9EN2dmR0FZOXBlNkd3R3pz?=
 =?utf-8?B?b2tVbEQ5cE5mZ3dQOGZlUldxdUozTDRQejFlNWM1UFBpRmpHWDQ2UEs1YkNr?=
 =?utf-8?B?QTlDNWtBdkc3amF1Z1pJU1hobHNRV0VXRWZhVlliUDYwbmpFK2RJR0J0Y0k1?=
 =?utf-8?B?bnFjbU5BTm51SCszZFdTRnVtcC9jMU02Tm83VWdUTDIxcFhwYXl0eDMvN05r?=
 =?utf-8?B?bXByUk81YUZRL3RMQUptdGwvZms5QncvZGdacGtqeFJGYzNQUnRZTWVUb2Rs?=
 =?utf-8?B?YjFhakVubmFoK3NNM2VLR2F1NDF6K0RMcC85TkZ5TE5SdEFyZ04rQXNKUGMv?=
 =?utf-8?B?OWN2bW9yVzFVK2phekZBNFJhcVZKZUd0YStSSlRXMCt2WkNsQUdUUGNycWhT?=
 =?utf-8?B?UXhyM1RxTEQ0dVFXb0tlL3U0WVBWOXAyZjlyU1ZOYUJ2ZFRVUDRqQldhUmRR?=
 =?utf-8?B?cUg5c3NFSXhocmRlVFlEb1pxRjFSbkZza2JIS2ZvRmxGdmJpRjkzWlFqQ0Rj?=
 =?utf-8?B?QkZEa01sdFhVRUZrZmZpa0p2YkNOMk16UUZhaEIrbUViREVjZVhwd2RBQ0Vo?=
 =?utf-8?B?d1o1UlR4MFQ0MzRpa1kxYVI2OTI4bklldCtZaE00TjRGbkVJKzczYXI4RVhI?=
 =?utf-8?B?bCthWXVERlJKUGlrZXQ3YmUvT3djZDN2bVZRRlRGSjhHNzBJY0todVBEeWI4?=
 =?utf-8?B?TS9nQmRsRXpLdHdnU2R4Q2laQ0FZUTRsNXNMdWpvSVdIU0RuVytWQVlZcHZR?=
 =?utf-8?B?aStIUjEwTW1Mb3dDdGJvblVBRjUrSEJwN2xLYmxYM0I5T2ZVZUNSRlU0NlBY?=
 =?utf-8?B?MHM5eE96QjVJSEY1NVM4MUF5SFYvck5qeGNJbVZVN05ZVHlsaGxoUTFiRlNp?=
 =?utf-8?B?SzgzNUllVkJLUFdnWTNDWFE3SjY1cU1YeElCQTh2V0wvSktDUVQ3OFRrMW9V?=
 =?utf-8?B?Nml0dE12ZlF1TkR6M2R2anB3cWJld1QzT2ttZTBJZDlNVUpwN1pTbjBLUVNE?=
 =?utf-8?B?d2Z3QXdURkNEcGpkK2QzbzAvd0xaS01FM0hGZUMvL29uenJ0Ylp6TzJjYnBS?=
 =?utf-8?B?QmVKRFZ2MlhQaEhkMjQwOWpMeDVNL0JYS1RtbzlUSldEZHFxM2FGVCtNYWlv?=
 =?utf-8?B?MjVMR2htYk1kUkRlMGtOem0vZSs0aFBsaUk0RVdaZ2VsbitmQ2psQ3c3bk1x?=
 =?utf-8?B?QU1Qa2VNQ1EzNStZemdaTWRPcGoxcGNHOFZGVkdkVEpxWGZJVTYzQUQ5czJs?=
 =?utf-8?B?L3J0MEV4N3Ewa05wZ1dsTnpZaWhPenhFUHZzdWFUUCsra3ZNVDRZNC9PdHp1?=
 =?utf-8?B?VHh4emdlZmo1SnBCc2R2bGlpWDJobmI1S0NtZlZiTmJFaVdhRlU1VWlEYlFS?=
 =?utf-8?B?NW85WktJTWdZUU1DR2M5bnJoZGs2cEdrNzllb2psTklYTCtMTTFDOS8yeUpl?=
 =?utf-8?B?dnZvZWRHckhMQUcreFhQdjNjdU1nbkwzbElYc05oVGFNYlFIeGxGdG14eWFp?=
 =?utf-8?B?STFwd0Z5NTVwT0NwaDNvaEJWSnlYbTc5QVlZeWEwTjNXaWczUG1HZz09?=
X-Exchange-RoutingPolicyChecked:
	czu9TR8cCjos8TNlV//uV5R5UyW+YnY6mPT6ik164ohnQ64LjUt0KI3sioks1wiudyeKOK0T8jnT17p+I84uLJ9gicu25do+PN3lmzMrRHvzBNDUNLJdfsISpAYheKGPrbzNm68DRTb89Mtim9feKdXVfUC9hCiFUYcikosxcsuxjz3o2OOOMqnDp2wG3e2WVMZ3R9WrUZGKodbV9jlwXJosdQWOTdx7YfTP3EW2WDNwGFVIQOsdXNiwAZ6vXdaTlQiZLIFLbC9FkdX/mXOdO4gym7Ebk7nN5VHisY3B/+aAoKLjyglTUB0MgA/TcbZawRngvdaEgYufRs43pvHWIg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FYJTUfdyiGADLR8GtYrzgw2uJf8HiMCbfqlP9llNLeCVn/3CjRBL66dz18nFaWRhYz3ZBxgEo8mLK4jKzZjA5TZe/82YMAGF+1K6Wqax+vvPlkm3GWij/HZx3FeDeaFYYONbbqVV8owCBAFE56sNXIzaxZiUa3LkSmvEUP5EqJT7yxCp1rjc/qm4m/9TvcZFZb1DA/dIaEm2szKtc6hth65MLLztbdJlOYldGyUL9cfxBjASksnQIENGyaahc993RzHV8L6EpDmQAPnwQnYVt8VbBOCalZNhvSPhivEbuIqvmMNGM/xlew/ev/oxZ5vkxy7MokbWNZKjmrSE3+pBWZsZj2He5AK2U0FX0fhiMrQeMVjWvbZNxXHnvHHxmH/ZPbns0HVu/YWii7x3WNXlrq60GMCjWyQeKjSQWtU5WPDLom8iuxuTzRAprL9WjAjFCQ+ZZcuaczDy4ZGikvjpNxwzjOa+kqyYngC/CUMSKk0oSa7O8PD8mjFvQpUidmlZmHcREkfVp8AAAbQst5ma2PJOAm5rUG0BEnXnqI5Y6b8H3tPiw+nwt+krmF8X93AGY1XjNsK7IdW7c1pze55NN5f9xrA2bIInPVLlp84nXzU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd21a29a-1151-4daa-d79b-08de7ea842e6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 13:23:47.7645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7Gfp+Vyo1cEa8SDflP/dFNKhZZU3QS9Fa3d0ys560KjPROZeMkKBZtPdBCPFI140+zhSh6CX+OsbyH6C6s+LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6688
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603100117
X-Authority-Analysis: v=2.4 cv=IJQPywvG c=1 sm=1 tr=0 ts=69b01b6c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=SEc3moZ4AAAA:8 a=J1Y8HTJGAAAA:8
 a=1XWaLZrsAAAA:8 a=WYXT4c1WSOa8yzFlF54A:9 a=QEXdDO2ut3YA:10
 a=5oRCH6oROnRZc2VpWJZ3:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDExNiBTYWx0ZWRfX5kW/ZEh0g+Mr
 zuHaAr04pNn8pa6GbkRj7lsRFaXSweNq5wOsBbUghEl/5IGOhZLI1sKiTA5sEhY01+ctxumrV0T
 aoHf9ECZH7CCxsh84M3bcQF+HkKoJWaymeL9KqEVy+krzFc+9PQXSHrQoZZTFQlz0DlviAzcium
 3RUksKkEK8L/6sQB/lU70w3asKfLkgJGpdEzaWUtnA34BXsf0jQ6g7RZGEbyezJgvF2ULFxzNwv
 7uDZLGdMC8b8v0kJQOqt06/DDVNnWseR1JVSNGcIW/nA0zlfZzJeKylJ3gLQT4w8rc46VUPuoay
 50kl/8ZtoVmX/JV+Gc/zCtsB5IiKoElpL0OLDyNIn6fV99/Gxea9fca5Y1xmv3OSQAH3VdTZ32R
 zN6hHU0FwYgGcnxQTbfvj606mKB0akYR4bwul4XhguXoy6EcxjT7I5ux2bet2JupQqpAJr2MZSL
 sLFLOph9nLMt5Be1qWw==
X-Proofpoint-GUID: YdKhX_TEJkvQ0hIir4tA4pR62ilMwcrS
X-Proofpoint-ORIG-GUID: YdKhX_TEJkvQ0hIir4tA4pR62ilMwcrS
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 30/61] net/sunrpc: Prefer IS_ERR_OR_NULL over
 manual NULL check
Reply-To: Chuck Lever <chuck.lever@oracle.com>
X-Loop: cocci@inria.fr
X-Sequence: 3376
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/V08qZPGSrjLWSYeYQgp6ng>

On 3/10/26 7:48 AM, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Change generated with coccinelle.
> 
> To: Trond Myklebust <trondmy@kernel.org>
> To: Anna Schumaker <anna@kernel.org>
> To: Chuck Lever <chuck.lever@oracle.com>
> To: Jeff Layton <jlayton@kernel.org>
> To: NeilBrown <neil@brown.name>
> To: Olga Kornievskaia <okorniev@redhat.com>
> To: Dai Ngo <Dai.Ngo@oracle.com>
> To: Tom Talpey <tom@talpey.com>
> To: "David S. Miller" <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Simon Horman <horms@kernel.org>
> Cc: linux-nfs@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  net/sunrpc/xprtrdma/svc_rdma_transport.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> index 9b623849723ed0eb74b827881c6f32d3434c891b..b4d03e59a8202f20360cff1e2e79b1e325396517 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -578,7 +578,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
>   errout:
>  	/* Take a reference in case the DTO handler runs */
>  	svc_xprt_get(&newxprt->sc_xprt);
> -	if (newxprt->sc_qp && !IS_ERR(newxprt->sc_qp))
> +	if (!IS_ERR_OR_NULL(newxprt->sc_qp))
>  		ib_destroy_qp(newxprt->sc_qp);
>  	rdma_destroy_id(newxprt->sc_cm_id);
>  	rpcrdma_rn_unregister(dev, &newxprt->sc_rn);
> @@ -608,7 +608,7 @@ static void svc_rdma_free(struct svc_xprt *xprt)
>  	might_sleep();
>  
>  	/* This blocks until the Completion Queues are empty */
> -	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
> +	if (!IS_ERR_OR_NULL(rdma->sc_qp))
>  		ib_drain_qp(rdma->sc_qp);
>  	flush_workqueue(svcrdma_wq);
>  
> @@ -619,16 +619,16 @@ static void svc_rdma_free(struct svc_xprt *xprt)
>  	svc_rdma_recv_ctxts_destroy(rdma);
>  
>  	/* Destroy the QP if present (not a listener) */
> -	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
> +	if (!IS_ERR_OR_NULL(rdma->sc_qp))
>  		ib_destroy_qp(rdma->sc_qp);
>  
> -	if (rdma->sc_sq_cq && !IS_ERR(rdma->sc_sq_cq))
> +	if (!IS_ERR_OR_NULL(rdma->sc_sq_cq))
>  		ib_free_cq(rdma->sc_sq_cq);
>  
> -	if (rdma->sc_rq_cq && !IS_ERR(rdma->sc_rq_cq))
> +	if (!IS_ERR_OR_NULL(rdma->sc_rq_cq))
>  		ib_free_cq(rdma->sc_rq_cq);
>  
> -	if (rdma->sc_pd && !IS_ERR(rdma->sc_pd))
> +	if (!IS_ERR_OR_NULL(rdma->sc_pd))
>  		ib_dealloc_pd(rdma->sc_pd);
>  
>  	/* Destroy the CM ID */
> 

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever
