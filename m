Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CF71049523
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=H6ZMmP62ZGGoBnJAVDBydLgmrjhW3AY3g1J2nIlXoXs=;
  b=r14MwnRCm5bDw5qol4n5VvP/DkkjKyZ9LmOZhlT6602Zr+GC1kihKMtZ
   BW2JQ5dj25GNeIXAuZVbMexHx17zWp0UJXU+PsgE5K/bIrzfuGEPutmdF
   0QpNB90vWLWjFswSWIHFrwnXVWY+1wHxvE2bH9eFxAskUEezZDK5Nq/Zx
   4=;
X-CSE-ConnectionGUID: jPOzKh5/T6mPdAc3ZQctKw==
X-CSE-MsgGUID: NiJmV8PATxu5cRL4rz5EOg==
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
   d="scan'208";a="267246327"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:46:35 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 7484D818CB; Wed, 11 Mar 2026 10:46:35 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 84D5D818A5
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 10:22:29 +0100 (CET)
X-CSE-ConnectionGUID: XQKwxPStSpS2rmPeR8DbVg==
X-CSE-MsgGUID: oKuAGOqHSiyiNTzbBlmGOA==
IronPort-SDR: 69b13456_55ANQQfnXD5dklgQVcLROhFHlD+M2dUGW9rSLX89UOgl9A8
 7oDOL3PpkETBBKqDXMArdZZ1cEBB6cOh6vXNx1Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ENAAAdM7FpjwlBr8ZaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwHAQELAYFtU4FoMQRUhFiDTAOETYlYA4ETm1yBK4ElAxg1CAIPAQMBCwEBL?=
 =?us-ascii?q?iABAgQBAQMEhQACFo0NAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBB?=
 =?us-ascii?q?QEBAQIBAQIEBgECEAEBAQEBATkFSYZPDYJiAYEkXgcJOAEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBARECDV4BAR0BAQEBAwEREREMAQE3AQsEAgEIDgMEAQEDA?=
 =?us-ascii?q?iYCAgIlChUICAIEAQ0FCBqCYIIjAQZKAwECAqIrAYE9AooqeoEygQGCDAEBB?=
 =?us-ascii?q?gQE3gkJCQEKAYEKLgGFO4MXAQGBcIJKgSABGYQAeieBZUOBFUKCMDg+hEUVg?=
 =?us-ascii?q?0Q6gi+DNIxNhlYJSXgcA1ksAVUTFwsHBWFCEDMDIAovLQIUDRASDwQWBS0dc?=
 =?us-ascii?q?AwnEg8dFxQfWBsHBRIhKgeBQXiBZhsPhmh5Ay5eGg4iAigSAzIEI4EGC1oFg?=
 =?us-ascii?q?iwCHAMLbT03Bg4bAwQ6ewWNaz2CFB8BAYENgQc9fBiWY0mvVgMEA4QcmVyIM?=
 =?us-ascii?q?heqay6HZZBzIqh0AgQCBAUCEAEBBoFoOjyBIHCDN08DGQ+OIRklg0KPPQG5e?=
 =?us-ascii?q?kUzPAIHCwEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:mFjJEaBvjb/eEhVW/0fnw5YqxClBgxIJ4kV8jS/XYbTApGt0g2MHx
 mcZCGDVaK7YYDfxKN9wPoni9kwGv5fdzt83OVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG86yQ6jOfQG+eU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEAHjgWUc3l48sfrZ9ks05a2q4Vv0g3RnDRx1lA+G/5UqJMlHTU2BByOQapVZGOe8W
 9HCwNmRlkvF/w0gA8+Sib3ydEsHWNb6ZWBiXVILM0QKqkEqSh0ais7XBtJEAatko2nhc+RK9
 Tl4ncfYpTHFkUH7sL91vxFwS0mSNEDdkVPNCSDXXce7lyUqf5ZwqhnH4Y5f0YAwo45K7W9yG
 fMwGAkucQC7vP6N2InhUOxUi/5zAMPVM9ZK0p1g5Wmx4fcORJ/KRqzL4ZlZ2is9goZFGvO2i
 8gxMGs/Kk2fPlsRZxFGYH49tL/Aan3XejlVq0mco6YtpWzUzxBw177qLvLUfMCHQYNemUPwS
 mfupTqmWEpKaozCodaD2nWPm8bgujrbY4MDFZuE5PRAhFi84UVGXXX6UnPm/qbm1yZSQel3I
 Esf8SsGtrk37EXtT9/nXhT+rmTsg/IHc99fGugz6QXLy6zI7gLfDW8BJtJcVDA4nP8PZiM67
 mSVpMvSXyZqiLCvGV6XyLjB+FteJhMpwXk+iTjopDbpDvHmr4g2hxPLCNdlDKOxyNbyHFkcI
 gxmTgBh3d3/buZShs1XGGwrZRrw+vAlqSZpvG3qspqNtF8RWWJcT9XABaLnAQl8wHaxEwbe4
 yVsdzm27eYSAJXFnyuXWOIXFa2o4PDtDQAwdWVHRsF7nxz0oibLVdkJsFlWehwzWu5aImCBX
 aMmkV8KjHOlFCfxNfcvC29wYux2pZXd+SPNDKCPMIYQPskrKmdqPkhGPCat4owkq2B0+YlXB
 HtRWZ/E4a8yWPo9ngmlDfwQy6EqzS0YzGbeD8KzhRe+3LbUIDbfRb4ZORHcJqo0/YGVkjXzq
 tx/DsqtzwkAcevcZiKMz5UfA2pXJlcGBLf3ifdtSMi9HiRcFloMMcThmYEaR9Q9noB+tPv5w
 XWma0oJlHv9nSLmLCuJWFBCaZTuf451q0g/NwdxP1zyg3kHSqSs5Zc5aJEYU+QG9uti7PgsV
 NgDWZyKLcpuQwT92QY2TMfCvq07UzrzniOIHS6uQAZnTq5aXwaTp+PVJFr+xhcBHg+clJUYo
 YT58ij5XJBaZQBpLPiOWcKV11nr4EQswrNjbXDpfOtWVl7nqrVxCirLifQyHcEABDPDyhae1
 CeUGR0onvbMkaBk7Oj2gb24kKnxH9tcBkZ6G0zp3YSyPwTe/UuhxtZke8SMdjb/Smj12fuDY
 cN48vLCC8AEzW1669dEL7VWzKwF94TOoZ1exV9aB3nlVQmgJY5hBXik5vNxkJNx6IVXgzbrZ
 XLXyOJmYe2IHOjHDG8uIBEUa7Xf9PMMxRjXw/cHAGT7wy5V5LCBa0FYFESOgnYFLZ9eEoAs8
 cE+suE4ti29jRsLNI6dryZ2rm6jEF0JY58FhLo7XrD5q1MM5AlZQJr+DiTW3sm+W+9UOBN3H
 g7O1bvwubtM42HjLVwxLCHp9shAj80svBtq8gczF26RkICYus5tjQxjyhVpfAF71R4d7vlSP
 FJsPEhLJamj2TdkqcxAfmK0ETF6Gxyr1R3t+mQNiVHmYRGkZk7VIE05HNS9zkQT3mZfXzpcp
 ZWz6mLuVxT0d8DQgAo2f2NYqMLYcN8gzT2axfibHPmEEaIqPhvjoKulPlQTpzXdXMgeuUzgp
 MtRxthWV5HVDyArjpMeN5i7zpUVERCNG3xDS6pu/YQPBmDtRwux0jmvdWG0I8V8GKXK+HCnF
 sVRe5p9aAuj5XzfshEaGq8+DLtml9E55Nc5W+3KJExXl5C9vzZWoJbr2Symv1ASQvJqitcbF
 oPdUxmgA16gryJYtEGVpfYVJ1fiR8cPYTPN+dyc8cILJsoli/5te0Rj6YmElSyZHyU/9i3Fo
 T6ZQbHdytFj7oFen4HMNKFnLCfsIPPRUNW4yiyCg+5sX/jub/iX7xg0r2P5NTt4JbESAtR7t
 Yqcue7NgX/qguwEbHD7qbKgSY9y+sSAbMhGOJnWLV5bvxe4du3C3h8hw128eLt1yI5zx8/+S
 wWBPZ76MZZfXtpG33RaZhRPCxtXWey9cq7kojj7tPiWTAQU1QvcNt686Hv1didhezQVP4HlQ
 BrB0xp0Cgu0cKwXbPPFOx1nP3O8CFrsUK4vdtm3tD+EA23uiVSH0lcnedzM9hmTYkRo0u6ji
 X4GevQ6XBW0pKzMitpetuSeezUJWW1lj7BYkl01orZLZvPTMILCBeUbLZgCTJpTl0QeEX0+i
 C7lNAMfNMk2YdiIndgQLjgussdzy9Hi4uvEGwE=
IronPort-HdrOrdr: A9a23:ks45X6A5gD1QinjlHeigsseALOsnbusQ8zAXPh9KOGdom52j5r
 iTdaogpGbJYW4qKQcdcdDpAtj/fZquz+893WB3B8b6YOCGghrvEGgG1+DfKlLbal/DH4JmpN
 tdmu1FearN5DtB/J7HCWuDYqMdKbC8mcjH9IKuqwYLPGcaEdAc0+46MHfuLqQffngSOXNTLu
 vs2iMznUvSRZ1hVLXKOpBqZZm9m/T70LjdTVotARkh5AOSjTWuxoLbPnGjtHYjegIK640PtU
 zenSLExojLiZza9jbsk0PD5ZVfn9XsjuBEGNGNjcYtLDDtgBaDZYhqWbGO1QpF+91Hr2xa8+
 UkpS1NULUQ11rhOkWO5Tf90Qjp1zgjr1X4z0WDvHflqcvlABonFston+tiA0HkwntlmOs5/L
 NA3mqfuZYSJwjHhj7B69/BUAwvvlaooEAljfUYgxVkINYjgf5q3NAiFXFuYck99RHBmdEa+S
 5VfZHhDcNtAAynhrbizzpSKZKXLyYO91y9MwA/U4SuonNrdTZCvh8lLYUk7z093YN4RJ9e6+
 veNKN00LlIU88NdKp4QPwMWM2tFwX2MFfx2c2pUBra/Yw8SjHwQqTMkfcIzfDvfIZNwIo5mZ
 zHXl8dvWkue1j2AcnL2JFQ6BjCTGi0QDyok6hllt9Ek6y5QKCuPTyISVgoncflq/IDAtfDU/
 L2PJ5NGffsIWbnBI4M1QzjXJtZL2UYTaQuy5IGckPLptiOJpzht+TdfvqWLL3xESw8Ume6GX
 cHVCibHrQB0qlqYA64vPH8YQKjRqWkx+M8LEHzxZle9LQw
X-Talos-CUID: 9a23:jfflk2Ac6ndT5J36Exle11EEIvs5SWXmlm3VG0KCWUpjdrLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3ARosf1g1oqL66IPd0Iw9aWZf4FzUj5IezIW8qiLU?=
 =?us-ascii?q?9utiFExBiMR2ZiRuQa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267238685"
X-MGA-submission: =?us-ascii?q?MDFUhtqsWZrzEbaQUK4U5c3q5uStPXDrBiqou/?=
 =?us-ascii?q?NdMyCYMVnwoCVnOy78oaUrcFYnDpCNAN5b+q41O3OjHsK/npPvwD6GsD?=
 =?us-ascii?q?FVCmk7D+Yu9pYg6tlMZdqnGD3LmJ2vp+4bQW1GmHNJqArcmFjcjCHeGP?=
 =?us-ascii?q?kW3/s1mF5yANJR/YaOeJW8Jw=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.9])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 10:22:29 +0100
X-CSE-ConnectionGUID: HlVbSsQkSCahKjmoe7+IOw==
X-CSE-MsgGUID: jDW081hzT++kD+xqxYeZeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="96899140"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="96899140"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:22:27 -0700
X-CSE-ConnectionGUID: SIJp3t8jTg+0sPOg1FzqMw==
X-CSE-MsgGUID: hJQx9mgjTWuL23NK3z4+SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="220353685"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:22:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:22:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:22:25 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.27)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:22:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vASBVaMpzIm06ceB/scxlJEznniYt5pxjd6NOKFOD79z9rJB1P1qMHAEJQYOaMeXqv+Pesl30EiR4R4+sJz3qei2yYQqUUxEKxjTzeyFYXVzFgyn6aEnOgb0m3YmaNFoTmA1bQOJZS74q3seYqxW0gtsDtwY8ER66H1i8sdKJZPQg/qYapbqJCJ2oytR63+cjaPeBwy0MTndLiVyBUOFd1TOXWeAkWhQU89e4UNXJEE/YpSwhawQNKUwQHQpfFxutIXjQ4saRV15OIKlQUhlSaKLNdFm/n9TEfDJfOUaoxacc170Il9YkZNdylcxqIn2OJJq3O4//AnTBOMu7c1Uvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6ZMmP62ZGGoBnJAVDBydLgmrjhW3AY3g1J2nIlXoXs=;
 b=jZQAJSG0EixaXIJpci1hZobEnzuy2JIXFBwt3fdUd72i6AflLKq+z5pV5LoziZOnZnnV9l6NJwxjwJ46uMlH5gRF5G6O3PEdqKjNceYzlnqjk5Nm01jE+LKYWeMSqNC/DpOlUArEcHUtlfqYwTSwsK4nvVGEtLqnXHB4dwbDFDcPyq/O6s+5yFtop3vsiKlOZjoBkCy6njnuxJZhPSax9lBhvy21KnnWzec2hZm1/JHbwDY1uiCrD+x17jttidfKQdtdRnJxdTNN6ECTtS2a5ps3OlHWyY0IkFsnJzCWvYF9ZG3TgX2H4mgzqC2dpsujmFmb/1h1OXFZdmMLwALrzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB7897.namprd11.prod.outlook.com (2603:10b6:930:7d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 09:22:21 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:22:21 +0000
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
CC: "Hadi Salim, Jamal" <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>
Thread-Topic: [Intel-wired-lan] [PATCH 28/61] net/sched: Prefer IS_ERR_OR_NULL
 over manual NULL check
Thread-Index: AQHcsKKXKbLvNRaSjkqr+6oyWSzc/LWpD88A
Date: Wed, 11 Mar 2026 09:22:21 +0000
Message-ID: <IA3PR11MB8986B4E436132BCDF617CD4AE547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-28-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-28-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB7897:EE_
x-ms-office365-filtering-correlation-id: 1d8c86ee-8235-4df5-c4b4-08de7f4fb316
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: lYTKhjmQY11Of1Xl+ydZd4yONcxgMTy4iHeBLMM9WUap0vDWuq/kRYJXEzMFDSH9UeiigqOQUt3OxTudans7ZFEPJAkiwS2axmcWoW/lnmEsT2o3BlZOfSwdacO/Ye6mH80vOkCcu382RyglV66jBPHKF1IoYS3czvfi/w5YLoTZBRCMgmy+OWPnwBloOfcod+2VpJ7aQnBvbsWFfGm3JOpqDI7K9jt3zDrG3mVJSK8rbbYD1kvJR73A7Brta40GId69c8upkLO8ewfXL0wp8T3wF2l02gMw6+/PRP2bdMQHlYLEBOKSoggABC/lp0075L3q/CiwDjr5p1IFLGURnGqen1/386TDweVGWf+8E1Mz7uYaTKABljfLoo8N4IgBacUCz8gL1pQNPPOzMh4haS47z88W1kuJTlPMJO5MXjtA+pDyaldjMBTZs9TJjaRoQTwbOgEWYPqQ/3PXEyZvuarj6EsNPsGx09VVhX+m4q9uMkNYmrESUMT8OvtFfTR5Ba8JCFgKxqSX/rofQWwKow5HaUToV0jX5x9T9XvJszQ3ruZSXnxqTvGvg45ywMKd59xbm38+/cS2UmBt0Zde/nxiFthY/3iRYhSgEeDde5AqCaGkaD8/i+eN6stimUv3iFAnHfdeGs5EiPkg/QUbR/+PzuMOD2E57q6c14IKEKtyp5JIFjBFCYUPRj/k2OM5pYqUjPt1554DALitLWA4gamM6l/2uJYJn11rqLASADzQB2lS/+RDNe1JYs9ahNo+a8cODNXYwPwvOKPfHgh/TUzTwtD8iYgeA8GTLP+UnCjouub/aOwbo6ZBFR65s9Km
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3krSFVqUkUyRkRDdkZDQlYyZlBJZld1STlDTkNrTm1WODRnNHVJckpSdWpX?=
 =?utf-8?B?VTJpaVRCQzErWW8rMEZwOGtVcmh1NXk0NkdKa1pGMUhjN2JmSktia0x0Yzgw?=
 =?utf-8?B?VU8yMG1sR0Y2VXJNTjBMQjIzVUdxSXBrU2p6QTIvU3pxV3BjK0s0b1Vrako1?=
 =?utf-8?B?K0dFWVJIZTRieVd5UkxRbUZHeXJlcEs2ZVd2VDRmSW0yYXk0SW9sWHFrbzFC?=
 =?utf-8?B?Z2xnM1VUWkwrZFRFNDM5ZnFxS045MmVIS0hGQXBvaVQwa3NmUzJiekZuYldt?=
 =?utf-8?B?dmpEQnh4UllyOUFVVTJBeUFHUzMxRWZMTG0vZ1k3Vng5TUpSbDVvVWNySzVL?=
 =?utf-8?B?cDV3OTlvRlkwVExrbWlpWUpDclkwM25FYVlhQVErcGFnV1FLWEpiM3pWdGpo?=
 =?utf-8?B?bkZYcGkrM1lQVVZmOVJIQ1doVzNwSVdDRlVGSmlrM0loWEZNYlgxSXZxMnJu?=
 =?utf-8?B?eEhjdC8vK0p6dm9OTk5MNHZMYndpdi8xZnFUa3l1RkpEeW15dFNicG1yOWtS?=
 =?utf-8?B?cHlBUkQzQkgxNDVHOTkrMDJlMUNQYm5KMDM1T1F0VE5EbHZDUytaRVZKTms4?=
 =?utf-8?B?b052dFkzTGprTWw0OEUzeFlkUGVjVXhvaEd0OExkZEZFbWJPVnR6c01vb0Jz?=
 =?utf-8?B?ZTlWakwzWTYyVmw0VFUxNUk4cm1NTDBGSnpvWnQ1NEVaeGFoaFlNVlRwWXhz?=
 =?utf-8?B?U0YwdmFUYUgxT2xObkUrbDF4cUdzSW9vdGF1U0FubEUxWldCRm9VM081OUJw?=
 =?utf-8?B?K1JWQjFFSVArVkZNeTlEWHArK1UrdHIxQWJ4VkF3N3MrTkp5NGpubnJIL21n?=
 =?utf-8?B?NVcvdDcvcmhhTTNNcVhjRGxYMXBtZFpEQU1DaDU2VmVXNlkyTGlFUTlWMmd2?=
 =?utf-8?B?RTBST1NQM0ZmalhKV1orNHNqQndlRGJmZ0cwb2VGWE1oTUMrejZBREpDdzR2?=
 =?utf-8?B?OHpZeUtXYS90eFZPdTc0S3RxSnFqRUN3dCtsV2RsbkhRcHBVd3FIODNiQ0Ro?=
 =?utf-8?B?elJLR2U0RmJpV21BKzV2Z2tkeEJOV3NNQ2VYSW9NMExCSE5jSmhQRjlvcHY4?=
 =?utf-8?B?S3liZ1hURjVwNzVzTGlJTUFqNFNRclN5SHQ0SFhHcWN6Tk9nQzZRVlZBZ0dz?=
 =?utf-8?B?eVJVWXBld2FNRGExb2R4N2ROYzRsUGxmbENrSzFxM2VmZVdmUEFEeDcwUWFH?=
 =?utf-8?B?UzlheHhJelliK0RMakhYUjV4cGZxSTZTSlRLU0Z1VWVobnRqT2xWQVJqTHVk?=
 =?utf-8?B?YUtSd0hxL3psTFN3WnBXb1kyVHh0UVFNUS9QRUpLTmh3LzNPNVNKM001UTFJ?=
 =?utf-8?B?WGpveHR6U0dHeXc2SkV3ck9PY01yU1lxNnUyTW1IN0NpMUd3LzdFQ3E1OFFR?=
 =?utf-8?B?YmdUMW9yMTJKVGpNejhlUTZ1cU4xNjdFZ1lpekVqL1lhb3lVR3VxMHNUL2pv?=
 =?utf-8?B?VE5SbG1OWjhPejhOS2ZvajBsT2NGaGxaeVFFelVXWmVWUFN1TUhCWDZ6S1dm?=
 =?utf-8?B?SVlxQmJSOHcwR2FiYVZtMklxMkx5cVVLZjJIOHdrUkdqdHVidHFncGFnRGlh?=
 =?utf-8?B?RjVnZEtmdjBjUUk3dkN6bFJYc3ZFMXpYNTNBVERzaDhvZUJnR1h4V2lGVHZE?=
 =?utf-8?B?M3JPaDl2TVRaSEJ3QWFkRVlMZ1hnVS9vdC93UDZQbmdBQ1AydjFEeU9xaDhE?=
 =?utf-8?B?djd0bnF1S2U1bkRQSE1GdXYvbUlpQmRrNEswUFBRUlpSSmw5WDk3dVpVY01y?=
 =?utf-8?B?M0FYL2hMbzlTL3FwQXpXdnVOeThaVDBSWFhGSTZTS096cXlmYWZjOVlMaGs0?=
 =?utf-8?B?YlFNWWUyYVRLN01jWmp6aGJITHo2QWhqNHRBNjZqVnJ1dzFaNzBpcExTa3FT?=
 =?utf-8?B?TmlXYnJTdjNLRjFXcitZRmdXT1NEVGtwVStMcnZ1MGNQRjFNcG0xMlBjWlJF?=
 =?utf-8?B?dHNOS1gvQWNDZEhvR0x2T1ZFbGRaNlk0M3pwaFhQbldYOWxQc3dkQWFsRG9x?=
 =?utf-8?B?Ukt4RVpueHpwZlJ0RDBKL2JSWkJYUkRDc3lsRkhrOWxyR1VmajlCSXU4K0V0?=
 =?utf-8?B?aS9Ydk1WTHlPMTdLaExaZldzRlFNZWRuR3JxVFRqVEtadmRtTmtqbkxnQjZG?=
 =?utf-8?B?alhjTi8wWWNEVXBQbGVyOC96RFUreHQ5Vm81K3dJNlpLRUYwTXlPaDQ3cS81?=
 =?utf-8?B?OWIvdXZXeGJwL0pDTFY2d0tBSHBUeTNjZVVlTXByWWZuRzU2WkhMMTJUY2xI?=
 =?utf-8?B?b2FKSXUzK2IyVnB5Tk84TXhEMEJBUUp5SUtQdjJXVnNTdDBIbXBEUHEyaXkx?=
 =?utf-8?B?WkdVV2wvaTEvRTM2djdxZTFNYVg3VEsxQitZWEEyOXA1UVBsR2tZczBQK3Rj?=
 =?utf-8?Q?TbjYjr9ffGvAw+9E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Kq1lx9DENBc8+VcNgYj/D6gMPOX8ZBlVF3Rat7fquqmPSpZyoMd2kGVMm4Uc5rr1vtMPb2Bg+9DbUhZdKAfAq4i4egfAuSr3wHNCt89bfV3Xqt1joyzlmKAkyPPs8x+5KJCrj+s7OCcoUEtW5TV3S/e26LRsX6ZfP7L2GOSXRvcP3UFODJ5O8Iv3wTkU4AqtLYlZb+uc8/QaCxQljRmPjMp/aeIh1puaQWQ5Uhlw4IQWk2zj244pbD3FI4LYp2/WX8DbHJ6VybajGY3K9Ovf/nKxpL8iwrsoXX9H7UkzUohR+4nyYPsxr/3WZ+JKTv3ydW3lrt37+4BgigMCvrTH9A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8c86ee-8235-4df5-c4b4-08de7f4fb316
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:22:21.6416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ARGHiSh1aqJ99bPF9Ir1SfmdEA460X+vovmjgAKmEGwapctThjGdeMWI5LUI/zhc3VzMNi5q26EVkXPnkhnYaIMY0FKQyo1zDrRg1q0n3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7897
X-OriginatorOrg: intel.com
X-Validation-by: victor.gambier@inria.fr
Subject: RE: [cocci] [Intel-wired-lan] [PATCH 28/61] net/sched: Prefer
 IS_ERR_OR_NULL over manual NULL check
Reply-To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 3405
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/KBo7S_vF_p_gmjgI1eumow>

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
bS5kZT4NCj4gQ2M6IEhhZGkgU2FsaW0sIEphbWFsIDxqaHNAbW9qYXRhdHUuY29tPjsgSmlyaSBQ
aXJrbw0KPiA8amlyaUByZXNudWxsaS51cz47IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldD47IEVyaWMNCj4gRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtp
Y2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbw0KPiBBYmVuaSA8cGFiZW5pQHJlZGhhdC5j
b20+OyBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFtJbnRlbC13
aXJlZC1sYW5dIFtQQVRDSCAyOC82MV0gbmV0L3NjaGVkOiBQcmVmZXINCj4gSVNfRVJSX09SX05V
TEwgb3ZlciBtYW51YWwgTlVMTCBjaGVjaw0KPiANCj4gUHJlZmVyIHVzaW5nIElTX0VSUl9PUl9O
VUxMKCkgb3ZlciB1c2luZyBJU19FUlIoKSBhbmQgYSBtYW51YWwgTlVMTA0KPiBjaGVjay4NCj4g
DQo+IENoYW5nZSBnZW5lcmF0ZWQgd2l0aCBjb2NjaW5lbGxlLg0KPiANCj4gVG86IEphbWFsIEhh
ZGkgU2FsaW0gPGpoc0Btb2phdGF0dS5jb20+DQo+IFRvOiBKaXJpIFBpcmtvIDxqaXJpQHJlc251
bGxpLnVzPg0KPiBUbzogIkRhdmlkIFMuIE1pbGxlciIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+DQo+
IFRvOiBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+DQo+IFRvOiBKYWt1YiBLaWNp
bnNraSA8a3ViYUBrZXJuZWwub3JnPg0KPiBUbzogUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQu
Y29tPg0KPiBUbzogU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPg0KPiBDYzogbmV0ZGV2
QHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBT
aWduZWQtb2ZmLWJ5OiBQaGlsaXBwIEhhaG4gPHBoYWhuLW9zc0Bhdm0uZGU+DQo+IC0tLQ0KPiAg
bmV0L3NjaGVkL2Nsc19hcGkuYyB8IDYgKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC9zY2hlZC9j
bHNfYXBpLmMgYi9uZXQvc2NoZWQvY2xzX2FwaS5jIGluZGV4DQo+IDQ4MjljMjc0NDZlMzM2OWFk
MmFlOWIzZmNiMjg1ZWNhNDdkNTk5MzMuLjQyMDgyMjVlN2E0YWNhZjBjMzMxMDk2ZWJmOTQNCj4g
MWY2OGNjMmVkOTkyIDEwMDY0NA0KPiAtLS0gYS9uZXQvc2NoZWQvY2xzX2FwaS5jDQo+ICsrKyBi
L25ldC9zY2hlZC9jbHNfYXBpLmMNCj4gQEAgLTI0NDQsNyArMjQ0NCw3IEBAIHN0YXRpYyBpbnQg
dGNfbmV3X3RmaWx0ZXIoc3RydWN0IHNrX2J1ZmYgKnNrYiwNCj4gc3RydWN0IG5sbXNnaGRyICpu
LA0KPiAgCQl0Y2ZfY2hhaW5fdHBfZGVsZXRlX2VtcHR5KGNoYWluLCB0cCwgcnRubF9oZWxkLCBO
VUxMKTsNCj4gIGVycm91dF90cDoNCj4gIAlpZiAoY2hhaW4pIHsNCj4gLQkJaWYgKHRwICYmICFJ
U19FUlIodHApKQ0KPiArCQlpZiAoIUlTX0VSUl9PUl9OVUxMKHRwKSkNCj4gIAkJCXRjZl9wcm90
b19wdXQodHAsIHJ0bmxfaGVsZCwgTlVMTCk7DQo+ICAJCWlmICghdHBfY3JlYXRlZCkNCj4gIAkJ
CXRjZl9jaGFpbl9wdXQoY2hhaW4pOw0KPiBAQCAtMjYxMiw3ICsyNjEyLDcgQEAgc3RhdGljIGlu
dCB0Y19kZWxfdGZpbHRlcihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KPiBzdHJ1Y3Qgbmxtc2doZHIg
Km4sDQo+IA0KPiAgZXJyb3V0Og0KPiAgCWlmIChjaGFpbikgew0KPiAtCQlpZiAodHAgJiYgIUlT
X0VSUih0cCkpDQo+ICsJCWlmICghSVNfRVJSX09SX05VTEwodHApKQ0KPiAgCQkJdGNmX3Byb3Rv
X3B1dCh0cCwgcnRubF9oZWxkLCBOVUxMKTsNCj4gIAkJdGNmX2NoYWluX3B1dChjaGFpbik7DQo+
ICAJfQ0KPiBAQCAtMjc0MSw3ICsyNzQxLDcgQEAgc3RhdGljIGludCB0Y19nZXRfdGZpbHRlcihz
dHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KPiBzdHJ1Y3Qgbmxtc2doZHIgKm4sDQo+ICAJdGZpbHRlcl9w
dXQodHAsIGZoKTsNCj4gIGVycm91dDoNCj4gIAlpZiAoY2hhaW4pIHsNCj4gLQkJaWYgKHRwICYm
ICFJU19FUlIodHApKQ0KPiArCQlpZiAoIUlTX0VSUl9PUl9OVUxMKHRwKSkNCj4gIAkJCXRjZl9w
cm90b19wdXQodHAsIHJ0bmxfaGVsZCwgTlVMTCk7DQo+ICAJCXRjZl9jaGFpbl9wdXQoY2hhaW4p
Ow0KPiAgCX0NCj4gDQo+IC0tDQo+IDIuNDMuMA0KDQoNClJldmlld2VkLWJ5OiBBbGVrc2FuZHIg
TG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCg==
