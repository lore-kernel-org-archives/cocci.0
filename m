Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36E51049523
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6tbQO6yGCv8N8ouulw89rMIOzkRWnTreTX8yvsT+jIw=;
  b=M6o9SttIWAdXtyQzdvpk3PgZ4RjkGg+Csu1H/mVLdJj/x1wlFZuqMN78
   Zw0FG25GNMTJoReD4EAbwzbnEXtowIwh89hSAzGPPD6Dgi9M9MHVz6JQi
   MC64XbRH9Q19OIAasOOvwhx2Jwrjv2CnkVDpvk1ABRRML8Q4A+J1Pm5NX
   Q=;
X-CSE-ConnectionGUID: f7Gi1v+dSninPDpbu6aj0Q==
X-CSE-MsgGUID: cbhAB2RcTCSiUguxoeqcrQ==
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
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267246456"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:46:42 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 6B9FC818DC; Wed, 11 Mar 2026 10:46:42 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 0C35E818A8
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 10:25:48 +0100 (CET)
X-CSE-ConnectionGUID: Y19EVRN0S9edbEsnUkINww==
X-CSE-MsgGUID: bG+zKtRITjqxpDM22hf20g==
IronPort-SDR: 69b1351d_yNyFbBKq0QfnBKNG/xyfu0qwWVU9KPf9GMI+9vA2oUTO4Tp
 eUyV2XJEmsu47lff1L2VYOH8cEO8jPhcu4iaeBw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EZAQAINLFpjwpBr8ZaHgEBCxIMQIFFC4FuU4FoMQRUh?=
 =?us-ascii?q?FiDTAOOJQOBE5tcgSuBQDUIAg8BAwELAQEuIAECBAEBAwSFAAIWjQ0CHgcBB?=
 =?us-ascii?q?DAJDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBAQEBO?=
 =?us-ascii?q?QVJhk8NgmIBgSReBwk4AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEQINXgEeA?=
 =?us-ascii?q?QEBAQMBEREEDQwBATcBCwQCAQgOAwQBAQMCJgICAiUKFQgIAgQBDQUIGoJgg?=
 =?us-ascii?q?iMBBkoDAQICoi8BgT0Ciip6fzOBAYIMAQEGBATeCQkJAQoBgQouhTyDFwEBg?=
 =?us-ascii?q?XCCSoEgARmEAHongWVDgRVCgjA4PoQKOxWDRDqCL4M0jE2GVglJeBwDWSwBV?=
 =?us-ascii?q?RMXCwcFYUIQMwMgCi8tAhQNEBIPBBYFLR1wDCcSDx0XFB9YGwcFEiEqB4FBe?=
 =?us-ascii?q?IFmGw+GaHkDLl4aDiICKBIDMgQjgQYLWgWCLAIcAwttPTcGDhsDBDp7BY1rP?=
 =?us-ascii?q?YIUHwEBgQ2BBz18GJM1A4N0r1YDBAOEHJlciDIXqmsuh2WQcyKodAIEAgQFA?=
 =?us-ascii?q?hABAQaBaDqBXHCDN08DGQ+OIRklg0KPPQG5bEUzPAIHCwEBAwmFRgEBjCI0g?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:OXGxHa6Sa4+nDPDCfuLlfwxRtFHDchMFZxGqfqrLsTDasY5as4F+v
 mUcCj/Vb/mDNGqgcth+bo2x/RsCvMODyoQ2SwpopCtkZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjVAOe6UaicZ30ZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqqUzAnf8s9JPGjxSsfnrRC9H5qyo5mtD5wVmPJingXeH/5UrJMJHTU2OByCgKmVkNrbSb
 /rOyri/4lTY838FYvu5kqz2e1E9WbXbOw6DkBJ+A8BOVTAfzsCa+v9T2Ms0MS+7uR3R9zxC4
 IklWaiLdOscFvakdNLx/PVvO3oW0aVuoNcrKJUk2CCZ5xWun3DEm52CAKyqVGGxFyke7Wxmr
 JQlxD4xgh+rtrvn7YyBbLFX18kvJuTwOr4cm1d/0mSMZRomacirr6Ti4NBR2T4xgoZPG+rTY
 4wSbj8HgBboOkwffA5IVdRgwaHx3hETcBUAwL6RjaMz7mvIxQp9yv7pN9nJe9uMQtt9n0CEq
 2aA9GP8av0fHIbBlmDeoyz32ocjmwvxd8EAN6GC18JomU2L6klJUh0YDwO09KzRZkmWBo0Ad
 BF8FjAVhaM1/0eqZsLsWgWx5n+CpB8VHdRKe9DW8ymIxaPR6gedQGkCUjNFLtchsafaWADGy
 He4xoLEOwZJ6IbERH6X26ySkDCTHzcKeDpqiTA/cecT3zX0TGgOYv/nS9lqFae0ipv0Hy39x
 3aBqy1Wa1QvYSwjiP/TEbPv2mPESn31ougdvVW/soWNslkRWWJdT9b0gWU3FN4ZRGpjcrV+g
 JT0s5XBs79TZX18vC2LXOgJVLqu/e6CKjTAgFlpd6QcG8CW0yf7J+h4uWgmTG8wa5ZsUWGyO
 if751gOjKK/yVP2NseblartUJxylcAN1L3NCpjpUza5SsIhL1Hbon0/PxD4MqKEuBFErJzT8
 KyzKa6EZUv2w4w+pNZvb7ZDi+0Y1WolyHnNRJv26R2i3PDMLDSWULoJeh/GJOww8KrO8k2f/
 sd9Jvm67UxVcNT/RS3Lrq8VD1QBdkYgCb7M9sd4S++kIyhdIl8HNcP/+70aVrJAo7V0jcbNp
 3G0ZV9ZwgHwhFrBMgS7VUpgY7LOA7d69HQKAnUsNGm3xnEcPN6d07gCRsFmYZgm6+1R4vpmR
 NYVe8i7I6puSxaW3x8/fJXCvIhZWxDzvj23Pg2heykZQ55sYyfr6+3UVFLj2wdWBxXmqPZkh
 aOr0z3qZKYqRiNgPZ7wU+2uxVbghkotsrt+cGWQK+YCZXi21pZhLhHwqfoFI8ssDxHn7RnC3
 ia0BSYon8X8k7UXwvLo25/d95yIFtFgFHV0B2PYtLa6FRfL91qZnLNvbry6QiD/ZkjVpoOZe
 uRn/9PtOqYmnXFLkbZGPZRF8KYc3+br9phmlllKPXOTdFm6KKJSEl/f1+l1i6B97Lt4uwy3Z
 0GxxudnKYi5YMPILVpACzcmP8Ki1O4VkAb89f4aAlv3zw4p8aulUXd9BQitiitcJYQoaLEa3
 voQ4p8Kyg2giygFNsSNoTBU+l+tcF0BcfQDnbMLDLD7jjEEzgl5XqXdLSvt8beza9loGWs7E
 A++3abtqexV+RvfTiAVC3PI49t4ub0PnxJ7lHk5OFWDn4v+tM8dhRF+32w+cVVI809hzel2B
 2lMMn91L4Wo+xNDppBKf0KoKjF7KCypwG7D4HpXqzSBVGitbHLHE0MlM+XU/Ew5zXNVTgIGw
 J6mklTaQRTYV+Cv+BAtWHxVie3pFv1w0QzgpPqJPeq4G7sCXD60pZP2OEQprUP8DNITlX/3g
 7Bg3NxNZJ3RMQ8SpKwGCLem64kAdSDcGkt8RaBOwaBYO0DdZzC45haWIW+TZM5mBqLH4G24O
 eNUN+NNUBW363vWnA8EGJ9WcqNVneEo1vUGaLjENW4LiJrBjztL4bb71Dnyu38vePpqyf0CE
 4L2cymTNFCQiV9/uX7/nOMdNkWWOdA7NRDBhsar++A3Jrc/meBLc3Bq9ICrvn+QYTBVzzjNs
 CztP6bpnvFfk6JylI7RE4JGNQW+CfX3cM+qqAmTkdB/XenjAPf0lTE+iwfYZlxNHL4rRd5Iu
 6yHs4f30GP7rb8GaT3ltKfbJZZZx/eZfbRxCd32Hkl4jCHZec7L4jk/wU6aB6FNsutg4piAe
 1PlRuq2LNIbYoIIjjkdIS1TCA0UBKnLf7/t73H15eiFDh8GlxfLNpW7/HvudntWbTIMJ4a4M
 ALvpvKy/ZpNmeyg3vPf6y1OWPeU4WMPWJfKs/X0ujCdB2isxFKEprbm0xEn7Fknz5VC/NnSu
 fr4qtrWLXxee50kCPlYtZB/ulscC3MVbSwYYBcG49Av49ylJDduEAneWKnqzrlVlDD/0NfzY
 zSlgK7Oz8nidWwsTCgQK+gPkutS6iLi9zs5yvEUE5uoVhqL
IronPort-HdrOrdr: A9a23:oB882q5I3kVtGoh1GwPXwd6CI+orL9Y04lQ7vn2ZFiYlCfBwxv
 re5MjziyWE8Qr5AEtQ7+xpOMG7MA3hHO1OkMAs1NCZLU/bUQqTXcZfBO7ZqAEIdBeOhNK1uZ
 0QD5SWTeeAemSS7vyKuTVQcexQteVvmZrA7YmuqgYIPGYaDdAbnnpE40SgYzlLrWF9dMgE/f
 Gnl7t6Tk+bCAcqh7OAdwk4tob41qL2vaOjSyQrQzQg7w6Dhy6p7rnVLzi0ty11Mg9n8PMJy0
 SAtxb2yJmCnpiAp3/h/l6Ww4VdmdPnxNcGP8qRl8gTJAzrjwajdK5hV7eBsD1dmpD21L9sqq
 iun/4nBagdmhHsV1DwhSGo9xjr0T4o5XOn40Sfm2HfrcvwQy9/I9ZdhKpCGyGpsHYIjZVZ6u
 ZmzmiZv51YAVfrhyLm/eXFUBlsiw6dvWciq+gOlHZSOLFuMoO57LZvoX+9Iq1wQx4S27pXTt
 WGy/ustcq+RGnqM0wxeFMfkOBEEE5DTStuCXJy8vB9mwIm10yRiXFokfD3101wvq4VWt1K4f
 /JPb9vk6wLRsgKbbhlDONEWsevDHfRKCi8cl56DG6XVJ3vAUi96KLf8fEw/qWnaZYIxJw9lN
 DIV05Zr3c7fwbrBdeV1JNG/xjRSCHlNA6djv129tx8oPnxVbDrOSqMRBQnlNahuewWBoneV+
 yoMJxbDvf/JS/lGJpP3Qf5R55OQENuFfE9q5I+QRaDs8jLIorluqjSd+vSPqPkFXI+Vmb2Eh
 I4LXnOzQV7nw6Ws1PD8VfssinWCwHCFLpLYeTnw9Q=
X-Talos-CUID: 9a23:DGZzRW7fxDKbKrjJXtssxRdFN/4fVCXmnXrcKWKjD1tqaZuKVgrF
X-Talos-MUID: 9a23:gYnvlQl1pts9OMVaKGpRdnpoG4R6wLiUKXwPiIUel+zebyx+YW+S2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267239634"
X-MGA-submission: =?us-ascii?q?MDH7ygacteAeP6/4xR8ASfdUkWyT1mGUrc5kcT?=
 =?us-ascii?q?76e87YCMKh+thH6NwE6/TLiSzI2XztbdRVPsiA4rP+PL7xpqhpSoPe70?=
 =?us-ascii?q?MKm1PFGO61acvb6BvsM3Rm4kBqamQQ313fj2YMq/uMxwj1svJze3NsnL?=
 =?us-ascii?q?VrlFV8X86MsGTXfyohqhTK1w=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.10])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 10:25:48 +0100
X-CSE-ConnectionGUID: klKbWTxrSzu4PAxSSNa8bw==
X-CSE-MsgGUID: Rt9UVrwsSay5a6hLcytb6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="91665682"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="91665682"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:25:44 -0700
X-CSE-ConnectionGUID: SeyEpxAdRfKJdobfw95FZg==
X-CSE-MsgGUID: +WNep8C1RFOCCFDhvBjEIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="216680976"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:25:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:25:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:25:41 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.10) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:25:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gW7OiJ/Vub6V5xTra/ISXVlXWhIT515YR6o9UWl/udHMC20jLQvrj8nFa/PS8DIIepyiaCG7xOVGsr8BbAXQBGQt1qn6UEPw2rOBw5w+E+IycMaBKlFzJ0MvVbxEI2I/zxUSZCJMfWE3Cc6RT/WW2yJsVR5BrEZcNknypHx9j/UtdK3k3oenT1hqvwXBbVnu8pgyD4zskIfel6K9+2y+QtBUHq/E2D0Nq8/0zbw0L0TVoofcWxetLyTwuv98sbQbRasji7oAFF5McjHGNBpPPXGRBZ6jobvKU7DVFLqYXgd7hypEb3zqU6Lx5p9q8NklQfZ8D1ts/7Mj85MVkzbaMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tbQO6yGCv8N8ouulw89rMIOzkRWnTreTX8yvsT+jIw=;
 b=I3Thht5AdfSZtHdfajJ7eIVunnxE5CRvAwCbGR56ueiIf41wcbjW+t2KkXE/dbaJEEKCaiVddoATrP10ijwVcfOBsHecxOvNpl+NBL/f4CshphkIFQ/Fy3VZzqa/+x2AfDCHe8D6GgjyIQBujr5VNcYw3UQ09ZWLk52OVHIy61cUmBn1r6EShc3SBcjP+k4XxKUsR8Go1HpE0AQLlxpNcTsgLcv5z+C0FIsM09dHPG8BtEIgyqg3PAjPZPq56EMV92VbRknBrPTpe0c0lJRqoNrqaL0lGEk+qujM8+SGOrA8HRGCl8w8tVm5r+sdoRD/Y50jFsrNNJTk2QHw0dlmfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB6836.namprd11.prod.outlook.com (2603:10b6:510:1ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Wed, 11 Mar
 2026 09:25:32 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:25:32 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Philipp Hahn <phahn-oss@avm.de>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "apparmor@lists.ubuntu.com"
	<apparmor@lists.ubuntu.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "cocci@inria.fr"
	<cocci@inria.fr>, "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"gfs2@lists.linux.dev" <gfs2@lists.linux.dev>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-cifs@vger.kernel.org"
	<linux-cifs@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>, "linux-ext4@vger.kernel.org"
	<linux-ext4@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-leds@vger.kernel.org"
	<linux-leds@vger.kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-mips@vger.kernel.org"
	<linux-mips@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "linux-sh@vger.kernel.org"
	<linux-sh@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ntfs3@lists.linux.dev"
	<ntfs3@lists.linux.dev>, "samba-technical@lists.samba.org"
	<samba-technical@lists.samba.org>, "sched-ext@lists.linux.dev"
	<sched-ext@lists.linux.dev>, "target-devel@vger.kernel.org"
	<target-devel@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "v9fs@lists.linux.dev"
	<v9fs@lists.linux.dev>
CC: Alex Williamson <alex@shazbot.org>
Thread-Topic: [Intel-wired-lan] [PATCH 46/61] vfio: Prefer IS_ERR_OR_NULL over
 manual NULL check
Thread-Index: AQHcsKJzVlY0YaDH1UWzLB4DgG1n+LWpELCQ
Date: Wed, 11 Mar 2026 09:25:32 +0000
Message-ID: <IA3PR11MB8986D7F17B8E72F94006F48EE547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-46-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-46-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB6836:EE_
x-ms-office365-filtering-correlation-id: 90d04f78-f9a8-4250-9905-08de7f5024c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|921020|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: PSa5Y/PRV2m/kBT405RyAaoUJSX5xxpx3lXjof6vmQpQmRNVaVIATI8WjW50wiW5w9NTDPVVyaNBrQ7GCG8kuJz4NzT9+GWO58CZB/MdOrAvvlxH1/wqcUH+UbgPV+WOfNbdLrCQK2qG2X0Hha3IOjShHNNIcCITQlMaE04JBDrstdeeBgFUwl/imZDKfAoLOX0iTzyxjZmfMCgg8ZjSplg6uJ3X4pZdna1n53VyS7k4r8JFU0z26QeggH6qVfEi5j2YZ8NWkMH8cjNYaYYaHFPchGvS3j547P5kmjcvcDN0jvjGZkOczaBz+ZOcloldMjJcdUl+V6jze/Z1+Txs/Bl1IamV0Y+i1TcMzNJms/9izJCqv5lalfuD5eINGmiIDrSSeND6V0ZUV09j+ZByyu3fmIZHUE200vw84Kj+vrBaWPzqXZfM/LzwAHGXNJ4pt9OpvXxqhwLopyo01OE3zLCZyf7tvGdt/tvvnZka/gZ4vanhaNBS4sSMtyYRSYbkkfAZ6Rtbtnlr3JBixVkWbLaslCvPzUWkJ8VAqRwMDTvCO4yMsDe5FWvQAFZpU0CMQKJlnGcD6Ar6qUx0KSjfJf2d9QPi2VC/AcilJSteFrdEdjJnD79WBYeeT2+AlBimbEDh3vw9eydSvxZXqwzkd3d5qalNQhocxZYvg6swL2YwkVmIrqLM2wR4fnX1l4owl+/UcnQcZUdiss+ftKZOPLdPuEBmEy5WzKNok4xpdncbA9Qw8W6wGIHot5EaqQWnMpN7u9S2DQ0iwsCf/dM95INa6yxB7kaztB5gh5XjcuEfZWTyqw34mZOkj4N6KU5Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aC9nY0o2RGxpeXRncjZMZVM4QjBOL3NMSWc3Kzh1SGllL2IyTHoxU2c4ZEc4?=
 =?utf-8?B?eVlpalJqaUV2d1lESHdwNFV5blUrVlBlQUtoQlNXV0ZQeFFUTDVVaEVpd3hG?=
 =?utf-8?B?c1V1Q3BiR0djZzc5WVJkM1lnWmgvbW9uNU9xQlkvYTQ4bkJreVkycXF5RUEx?=
 =?utf-8?B?VFZQNGRiWmowMHhTWGQrcWdtdTMvQnkyVFd3S1BqMmZJMVh3YzAzRGo2dnpZ?=
 =?utf-8?B?R3JhOWhQWm50TWVCd1prY3B5VTlGblcyUU42NkRxWWlEVy9JbG92NHgweVZC?=
 =?utf-8?B?YkhRKzJ2RzQrUC9MMmE5YzF4U3hJQmdteFF5eDZXUWtacDd2djg5R3laMUoy?=
 =?utf-8?B?WWNQZXRlQ1gxeGVEa3VMNmpJODNEZEVYUzFqYkRLMmtuOE1lRXE0WndLWFdT?=
 =?utf-8?B?eDdNMU9tOGtKREdGYUo2eGNyYy9ERG1WdTVDMCt3STQyYmdrZldjQ2tKZlZW?=
 =?utf-8?B?RmVLQnRFUVpneUdRd1h6b0NidG5PaGpjZEdaV2VJNi9NZkpvbWNKM3hzVitD?=
 =?utf-8?B?V3ROVy9ydFZLY204YkxXWTdpQVNPNTVJQk0wMDEzQiswa25RYVB2T0J5dVhq?=
 =?utf-8?B?bk5OOUV6ajdIQk5jRFRSMW9Cc2UwbVpvY25BL2lBRWpRVmIvTWErQTJzcC82?=
 =?utf-8?B?Qmp3YmJGT1FDVk8xK1kwV1FUZGdCRkNBREJKb3JRc2toMWFBRnlVZzBZcHBi?=
 =?utf-8?B?QlQ0YnUyeVZpMEFxdm8xakhlSm5sL0lxRkN5akRVMThDREdzMy9OV0RNZ1lE?=
 =?utf-8?B?Z0lpQnZVdTJ1eXdPVXJZN0xUUjBRSE5kSXcwK3RnK3J0WitQbitMNysyMHhv?=
 =?utf-8?B?bGFPSlU0TFdWUWkwVFNVSXlxUHc1dTNEVzYyMmxYYm5sdmlaNXFyYnVsdE44?=
 =?utf-8?B?ZmhQeG0xSlo3THZMRVlYUGZPSWVtQ3ZySjB4SkVQdUxNWHNrdGE2TkdneEwy?=
 =?utf-8?B?YTY0WmV0N1hSU3FOQmhIeXd3aUwvUkhrK3JLdUIvaEtXYW5OVWNNUzdldzNU?=
 =?utf-8?B?V1ZabjgwcEtFTWlhSnNTbGIwWURHM1BvUCtqWVY4Q2Y5NlcwWWR2MXhsUDVF?=
 =?utf-8?B?Vjk3Y2JCRUR0M2hOdVVUK0VRSXpxbTRnRWEwUnA4aU83bW1FdjJOMjg0YUMy?=
 =?utf-8?B?TWI3SmdQa3E3cGNRV3RCL09GeU1JSEZ0aGdaOFZFL0d0cGlZeCtlQTJoWUkv?=
 =?utf-8?B?aHh5ZTNCaitGZmhYTk1XQ1o5Lys2R290QWRsd1F4RDhkWjduSnFCbG5mU1Va?=
 =?utf-8?B?THVRSkpGU0VnNTByNkZjZStUZW9OSUxYTWJ4dFZML2tNWXFqVHFiOXBqbFMw?=
 =?utf-8?B?d3lzK0dMSU5IZlplUk1PL2NGSmR6UU9TcE1vanVTZU1qVGc2aGdZT1VQemRh?=
 =?utf-8?B?Y1l4V0NFZnR2L0xmTlh3UnRVVTQySEJvSVdUVGRiSGFXaTB1M3NieldUUjlz?=
 =?utf-8?B?RE93N2x3SjZjVjZZOW5DTUZnMWpaaXRpVHFFTFV4Yy8wVnU2bWdUQzFnYisr?=
 =?utf-8?B?VWt0ZXJoalpLU2F2ZWh2OXZnTXQyc2txMWFLOG9JNGNUempsUlo5NE9WQWho?=
 =?utf-8?B?VllNOXJSYlFJWUJoclkzRTBZeVNxemE2MU1VRXFIeGFNU0FRTlNyb0Rucm5U?=
 =?utf-8?B?V1IwS24yNWtBOFR1M3labWh5QXpnbFNUT2o3bEV4MnprbzFvc1FWb1J2Wll5?=
 =?utf-8?B?anFnUVJxdWhEY0JRaUtOazF2NFBPSGt3QXhnd1k1MUpaSExtUFFoZ1hEWi85?=
 =?utf-8?B?RkxMRCszRi81OFpMNWlUTDNGY2owbkVDOUk4Z0w5bk1RMnNkTGE0MGN1N3hj?=
 =?utf-8?B?NkJOV29hVDN6RjVhVldRd2N2UTAwN1ZVbDhSTktnMEk3Zk43ZHZYdmsyTG5q?=
 =?utf-8?B?WVJHYXczOVlTREVNcklZS0FoUzkzRjdOdTB1RDZQckNVdnYzMFl4TWZVY0lB?=
 =?utf-8?B?SVZWYi8yMGNJbkpHWkhaY0RIZnZXdXpBam55UktHd2wwSFZZbktGQTh0MkF4?=
 =?utf-8?B?RUN3RDU5WTNZd1dTVVRnb3hMd1pucTBMd3YrMXRLWXVXZXZNOEFXL1NKUWZs?=
 =?utf-8?B?RTZuVWUxWDZzbWRsWWRHWTNmOGtDb0QvdWFUbndSWUVrR3VaQ1Q1WSt5NitK?=
 =?utf-8?B?U01ZMExwMjYxRFlObXJ6WGxnVWVXbXlrdmtndWVHbGlVQjJPUUdHS2J4TDNu?=
 =?utf-8?B?K1VMakM5Q2l3MXJXdjVkc01GQ284TDZmTzVaa2NFV1UwNUZ2U2c1eDBZY3g4?=
 =?utf-8?B?ZUlSNGpnWG12Mkl6NmhNS3hsOFg4bG1PLzY2WjZFME5MRGF0ZU5QTUIwT0dw?=
 =?utf-8?B?NUUyTlhEQWNDRi9ZcXZQMmxraW8rS1kzRU9iaEJwT241cUEzTkdySVNleGlT?=
 =?utf-8?Q?4Jl7dbELKf/NIoBY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qxLMk7b7Z4VaRlU/blG3DwPF+9DSKvWLDG8L40xgYD2idsB68FPTpw82p42vVz1K/Okj4Ka3poKyal4FgGaFj4PRs9ridMbhEqcd2D7L5JEhE2WoaPdMSB5ZRZmdP/VDOVzgrQH4dfjtDnh5HS4SOleEwdh81jcCnm7Io3RyAY3SQq7jAgWjySlw5s5slQEbvkrsakuI+Hk5bGu1lmwS6nBqU4zmHNQAitzVitGNZE1Tvw1aSdHfIOdt1eQnCH8+Wj5VlCgajHkzCxzBYiPnfaynRjrVdAgn52jYlQNVQ/whbFgnJ1idVgszD7bR/hDb5v5wBqgV+zJ5F7EPLGAuTg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d04f78-f9a8-4250-9905-08de7f5024c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:25:32.4108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +1pvfJK+0PL7J+YO35gTM9aZY86krg7i/7eFOzQKqaNkODxRVunAAG46KrZVxBvpu4/YFbLZrR5XM6UINBHaOiQshgEsxK66oYYWbE1iQ8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6836
X-OriginatorOrg: intel.com
X-Validation-by: victor.gambier@inria.fr
Subject: RE: [cocci] [Intel-wired-lan] [PATCH 46/61] vfio: Prefer
 IS_ERR_OR_NULL over manual NULL check
Reply-To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 3409
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/RIm5xsBrQoP2Wo3RyJLElw>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgUGhp
bGlwcCBIYWhuDQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDEwLCAyMDI2IDEyOjQ5IFBNDQo+IFRv
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgYXBwYXJtb3JAbGlzdHMudWJ1bnR1LmNv
bTsNCj4gYnBmQHZnZXIua2VybmVsLm9yZzsgY2VwaC1kZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IGNv
Y2NpQGlucmlhLmZyOyBkbS0NCj4gZGV2ZWxAbGlzdHMubGludXguZGV2OyBkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnOw0KPiBnZnMyQGxpc3RzLmxpbnV4LmRldjsgaW50ZWwtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsgaW50ZWwtd2lyZWQtDQo+IGxhbkBsaXN0cy5vc3Vvc2wub3Jn
OyBpb21tdUBsaXN0cy5saW51eC5kZXY7IGt2bUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtYmxvY2tAdmdlci5rZXJuZWwub3Jn
Ow0KPiBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnOyBsaW51eC1idHJmc0B2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPiBjaWZzQHZnZXIua2VybmVsLm9yZzsgbGludXgtY2xrQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtDQo+IGVyb2ZzQGxpc3RzLm96bGFicy5vcmc7IGxpbnV4LWV4dDRA
dmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWdwaW9Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gaHlwZXJ2QHZnZXIua2VybmVsLm9yZzsg
bGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtbGVkc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBtZWRpYUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LW1pcHNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7
DQo+IGxpbnV4LW1vZHVsZXNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tdGRAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgbGludXgtDQo+IG5mc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW9tYXBAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC0NCj4gcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXBtQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtDQo+IHJvY2tjaGlwQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxp
bnV4LXMzOTBAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gc2NzaUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LXNjdHBAdmdlci5rZXJuZWwub3JnOyBsaW51eC1zZWN1cml0eS0NCj4gbW9kdWxlQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtc2hAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gc291bmRA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1zdG0zMkBzdC1tZC1tYWlsbWFuLnN0b3JtcmVwbHkuY29t
Ow0KPiBsaW51eC10cmFjZS1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC11c2JAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC0NCj4gd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnOw0KPiBudGZzM0BsaXN0cy5saW51eC5kZXY7IHNhbWJhLXRlY2huaWNhbEBs
aXN0cy5zYW1iYS5vcmc7IHNjaGVkLQ0KPiBleHRAbGlzdHMubGludXguZGV2OyB0YXJnZXQtZGV2
ZWxAdmdlci5rZXJuZWwub3JnOyB0aXBjLQ0KPiBkaXNjdXNzaW9uQGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldDsgdjlmc0BsaXN0cy5saW51eC5kZXY7IFBoaWxpcHAgSGFobg0KPiA8cGhhaG4tb3NzQGF2
bS5kZT4NCj4gQ2M6IEFsZXggV2lsbGlhbXNvbiA8YWxleEBzaGF6Ym90Lm9yZz4NCj4gU3ViamVj
dDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIDQ2LzYxXSB2ZmlvOiBQcmVmZXIgSVNfRVJSX09S
X05VTEwNCj4gb3ZlciBtYW51YWwgTlVMTCBjaGVjaw0KPiANCj4gUHJlZmVyIHVzaW5nIElTX0VS
Ul9PUl9OVUxMKCkgb3ZlciB1c2luZyBJU19FUlIoKSBhbmQgYSBtYW51YWwgTlVMTA0KPiBjaGVj
ay4NCj4gDQo+IENoYW5nZSBnZW5lcmF0ZWQgd2l0aCBjb2NjaW5lbGxlLg0KPiANCj4gVG86IEFs
ZXggV2lsbGlhbXNvbiA8YWxleEBzaGF6Ym90Lm9yZz4NCj4gQ2M6IGt2bUB2Z2VyLmtlcm5lbC5v
cmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTog
UGhpbGlwcCBIYWhuIDxwaGFobi1vc3NAYXZtLmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMvdmZpby92
ZmlvX21haW4uYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmZpby92ZmlvX21haW4uYyBi
L2RyaXZlcnMvdmZpby92ZmlvX21haW4uYyBpbmRleA0KPiA3NDI0Nzc1NDZiMTVkNGRiYWY5ZWJj
ZmIyZTY3NjI3ZGI3MTUyMWUwLi5kNzE5MjJkZmRlNTg4NTk2NzM5OGRlZGRlYzNlDQo+IDllMDRi
MDVhZGZlYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy92ZmlvL3ZmaW9fbWFpbi5jDQo+ICsrKyBi
L2RyaXZlcnMvdmZpby92ZmlvX21haW4uYw0KPiBAQCAtOTIzLDcgKzkyMyw3IEBAIHZmaW9faW9j
dGxfZGV2aWNlX2ZlYXR1cmVfbWlnX2RldmljZV9zdGF0ZShzdHJ1Y3QNCj4gdmZpb19kZXZpY2Ug
KmRldmljZSwNCj4gDQo+ICAJLyogSGFuZGxlIHRoZSBWRklPX0RFVklDRV9GRUFUVVJFX1NFVCAq
Lw0KPiAgCWZpbHAgPSBkZXZpY2UtPm1pZ19vcHMtPm1pZ3JhdGlvbl9zZXRfc3RhdGUoZGV2aWNl
LA0KPiBtaWcuZGV2aWNlX3N0YXRlKTsNCj4gLQlpZiAoSVNfRVJSKGZpbHApIHx8ICFmaWxwKQ0K
PiArCWlmIChJU19FUlJfT1JfTlVMTChmaWxwKSkNCj4gIAkJZ290byBvdXRfY29weTsNCj4gDQo+
ICAJcmV0dXJuIHZmaW9faW9jdF9taWdfcmV0dXJuX2ZkKGZpbHAsIGFyZywgJm1pZyk7DQo+IA0K
PiAtLQ0KPiAyLjQzLjANCg0KUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtz
YW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0K
