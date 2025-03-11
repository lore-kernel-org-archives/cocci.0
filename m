Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AE7C28B28
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 09:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=to:cc:from:in-reply-to:message-id:references:date:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=tqFeD7mIYRdpvLkCVMuiLZRytZbJF1U5FAZmk7Xrn0w=;
  b=ouj8erjGHW29WU3fIqwjfUPoS8uSoXDcYwlveZ/Dc9+Z5KpFkLzIl4T2
   sKKWkHLW0BYgyBvAbTjhSZLPX23cQBgbFB3QL1aZwHqByDywsLPRj4lqr
   WXVvVF34SZp+EVVBaOJduFkzLPllCNLIgCpIpOccJPyKxMUGqEmdQ9mR+
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@oracle.onmicrosoft.com
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="213419132"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 10:11:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2AC1CE0D48; Tue, 18 Mar 2025 10:11:55 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 24B2AE0260
	for <cocci@sympa.inria.fr>; Tue, 11 Mar 2025 03:29:42 +0100 (CET)
IronPort-SDR: 67cfa017_Gsnukgb9nwscXMkOFoKPsT6qe9oz288TV2Z54iLtj1SQlHJ
 D3V5N35r5WEDsEQgb7SBMeKVGNqm+KaITvFFI4w==
X-IPAS-Result: =?us-ascii?q?A0GAAgDNns9ngyCl3M1AGh4BAQsSDIIICwKBcFKCCgQLS?=
 =?us-ascii?q?IgjAQGFLYZTgiSRR4xNgSUDGD4PAQMBCwEBRAQBAQMEhQACixoCHgcBBDIHD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBATkHDjuFew1JA?=
 =?us-ascii?q?RABggcBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg0oNgEfAQEBA?=
 =?us-ascii?q?gESLgEBNwEECwsOEyUPASElBjWCYIIxAw4jAwGiFENnCwEeWQFIAlZCiRIBA?=
 =?us-ascii?q?QGCKoEBggwBAQbbJxiCRgmBSIN8hFMBhWuEdyeBZESEPz6BUok1gjNFhGKGT?=
 =?us-ascii?q?IZ9m1BSe3gsAVUTFwsHBYEpQwOBDyOBIwU0Cjc4ggtpSToCDQI1ght8giuCF?=
 =?us-ascii?q?4I2hDxcLwMDAwODKIVOghGBXQMDI4Iwb3cchEE8hGEuMh1AAwttPTcUG6MFn?=
 =?us-ascii?q?wYBmnWVEgcDhBuaRodPg3ABX6RigSUuh2WQa6NjCwOFGAIEAgQFAg8BAQaBb?=
 =?us-ascii?q?gMwgVxRH4M3TwMZD44hDA0Jg1jHDlw8AgcLAQEDCYsghHyBSwEB?=
IronPort-PHdr: A9a23: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
 3PgLpv/N40YMoC90EtnOAASoQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:v+9iOap2ea2N7I9wpO5QvNYaV5soLNV00zEX/kB9WHVpm5Oj9/
 xGzc576farslgssb8b6Le90ci7MAzhHPtOi/hzAV7MZnibhILFFvAa0WKm+UyZJ8SczJ8t6U
 4DSdkFNDQhNykAsS+S2mDReLtNr6jkgcWVbKXlvgpQpGpRGsddBmlCe2Km+hocfng5OXN1Lu
 vU2uN34x6bPVgHZMWyAXcIG8DFut3wjZrjJTIWGhI97wGKrDWwrJr3CQKR0BsyWy5Ghe5Kyx
 mJryXJooGY992rwB7V0GHeq7xQhdva09NGQOCcl8QPLT3oqwCwIKBsQaeLsjwZqPymrHwqjN
 7PiRE9ONkb0QKaQkiF5T/WnyXw2jcn7HHvjXeenHvYuMT8ABY3EdBIi451egbQrxNIhqA27I
 t7m0ai87ZHBxLJmyrwo/DOShFRj0Kx5V4vi/QagXBzWZYXLJVRsYsc1kVIF4poJlOz1KkXVM
 1VSO3M7vdfdl2XK1jfo2lU2dSpGk8+Gx+XK3JyzvC94nxzpjRU3kEYzMsQkjMr75QmUaRJ4O
 zCL+BBiKxOZtV+V9M9OM4xBe+MTkDdSxPFN2yfZX79ErscBn7Lo5nrpJ0o+eCRfoASxpdaou
 WObLphjx9wR6vSM7zN4HUSmSq9BVlVHA6dhf223qIJ+oEVH9HQQGm+oFNHqbrUnxxQOLydZx
 +JAuMlPxbSFxqfJW935XyMZ3BzEwhobCRHgKdMZ7vJmLOGFqTa8tXBdvDdPbzsFithdF/eLx
 I4LWPODfQF11usXHDghhjXRjfKQWzQubxNMIWyxZlK9GAqXrc86zT9TW7JoP22FQ==
X-Talos-CUID: =?us-ascii?q?9a23=3ASSvsHmiTY0TqvcfVfgc8r5aOyTJuLkDM1UbPPHW?=
 =?us-ascii?q?BGUVlRoHIGVS9/bI5up87?=
X-Talos-MUID: 9a23:fZf74QmXXBQFI+pTwSsjdno6K8114YqgD3wpqtYclPaLL2t2AhO02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,237,1736809200"; 
   d="scan'208";a="212195828"
X-MGA-submission: =?us-ascii?q?MDFnr8PH81ER34oikgXmtgKaoeiOoe5h6L/n0N?=
 =?us-ascii?q?14TYluup1njxSIX4DHd5tCS8IwYuWCxYgvZYW+4eOTQvfMumOr8Dw3+p?=
 =?us-ascii?q?BOxzvApJICT6WEsOIVsdwe91UAaVvFA5V5ZZ8aO9p3r7iz6QImv81IXX?=
 =?us-ascii?q?u21bfs6N9ZsKJIpqtnTMXW9w=3D=3D?=
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 03:29:42 +0100
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B1fvcj021401;
	Tue, 11 Mar 2025 02:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=tqFeD7mIYRdpvLkCVM
	uiLZRytZbJF1U5FAZmk7Xrn0w=; b=LyoxO2gaQkRt6atcZh9TA05SOOeOmMDEfe
	H0tt8aMaKWEbxhVq+Q38FDrm0l3p/fq7Dlf/CBBV64oZ0pYTvTbu7Ggzevi3sVIE
	RYU83M8kAVHgQxAgpAWXE4sya0xklSqcvcKi8kcl1+UWiar/Y/B+ckypbvNVbsh3
	8zijtf9a4gK0ePX7czCx6eSochWRJRcW15D1Rsy0MX+joHuOP36hALqCMVy8Bq9G
	Z7oGUDCF3nwk3Vh5hONnr9jrd67cL0g0TDXYqVKZdSgbfh9h1jHOtDtoa5pDCANe
	wqTHYlqFWX8G4CervMi2d4Z+qli2F39x4r8DL6IV35QVl2YVw6eA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458eeu3wv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 02:29:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52B010t0020152;
	Tue, 11 Mar 2025 02:29:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458cb8dv5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 02:29:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtRlPUPL8APeW+iHXZAzWdUGaD+ni8MmC2XJeip9bDM9aNLP8qEzuot5CMSM4fa+aXESLe+kZfejn8GK5uJqmuyAKf5tDvJekFkA9nVRPMS/igYHQGy4ZZcHMPXvQWn4RASnx6FfKJmS/glhHPycZMILMTNYF8fLKKxATolWsIXx5uVk+87dBYXcGdHOYre6ki27vx56MQjL5GRO4XQKuEGH+NxvgIOgNhEZserxODjN7mfKsP8qf0kttB7xhCPICf+4FK8uk3p+TYqsKONP9YAvVcVFjDciyuI4JdIs7Vgk4XvPWVzZz/DzBCVwedGn2NVy9Y+MKDWk/r5VqMrlqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqFeD7mIYRdpvLkCVMuiLZRytZbJF1U5FAZmk7Xrn0w=;
 b=JzrI9O6NqpnbSp8A0xjIpN063+eeeHshlHC8W5ECwGNiBAs0N2WedMbDJhOUPbVmQEkt6jYKucZWbG9GoFktXvTED0oFwWaOtkK4J62rfaz79cCAdhWX4GeNOItiaOEVTm4e5mVmkpGgK1xcFaHrSum0qb7MT9NWaYETee4ps9cBfBlqbJ5fjHAqcwRQQViE2ZSOS3AS3jp9wLpIoSo4zVE6/59EgIjW4b0r29L/8iudDn4Ezge2+kDKy3rbrgvA9Ct20YNrFBr/83W22H8GF+XzAV477rDHKCMUbWiKnavx6FtC5LejTQ9dK4q6UUyaToCOCMDrpJH9CdmmOrziCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqFeD7mIYRdpvLkCVMuiLZRytZbJF1U5FAZmk7Xrn0w=;
 b=DvExvqpWiLV2gEAFRYSzJn4Gixqrg5uW3Cyr2/RQqUI4D8LAp0lBxizRBzLd8a0DzOv2Y5cmNBLhckDAHRkFbXBWP9g/O+XYX4UrL9s2w5vgMxzA7d9nZwicyIoZXt4p9AZJ7ijLdhK9srWNwFH9ybyKU04Fw1smDGcz9L5Fks4=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by PH3PPFAF33AAF2A.namprd10.prod.outlook.com (2603:10b6:518:1::7c0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 02:29:15 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 02:29:15 +0000
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Yaron Avizrat
 <yaron.avizrat@intel.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Julia
 Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy
 <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>,
        Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Chris Mason
 <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba
 <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang
 <dongsheng.yang@easystack.cn>,
        Jens Axboe <axboe@kernel.dk>, Xiubo Li
 <xiubli@redhat.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Niklas Cassel
 <cassel@kernel.org>, Carlos Maiolino <cem@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Keith Busch
 <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>,
        Frank Li <Frank.Li@nxp.com>, Mark Brown
 <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer
 <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team
 <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Shyam
 Sundar S K <Shyam-sundar.S-k@amd.com>,
        Hans de Goede
 <hdegoede@redhat.com>,
        Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Selvin Xavier
 <selvin.xavier@broadcom.com>,
        Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Easwar Hariharan
 <eahariha@linux.microsoft.com>, cocci@inria.fr,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-spi@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org,
        ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>, Carlos Maiolino <cmaiolino@redhat.com>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250310190803.aaf868760781c9ae3fbe6df1@linux-foundation.org>
	(Andrew Morton's message of "Mon, 10 Mar 2025 19:08:03 -0700")
Organization: Oracle Corporation
Message-ID: <yq1wmcwnw1k.fsf@ca-mkp.ca.oracle.com>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
	<174165504986.528513.3575505677065987375.b4-ty@oracle.com>
	<20250310190803.aaf868760781c9ae3fbe6df1@linux-foundation.org>
Date: Mon, 10 Mar 2025 22:29:12 -0400
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::10) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|PH3PPFAF33AAF2A:EE_
X-MS-Office365-Filtering-Correlation-Id: 24bdb8ba-d380-47f4-4153-08dd60448485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?miNS8jRlGSyPGCyDWQw54ZoHWlxmyd6vOWYdyGTCyV/lj30JiQwTraS4M5Bb?=
 =?us-ascii?Q?f7sQUtwsxn1Ei4G7C5TzQE1+fT/+nLoRSWVuf4XDwJwFJ+Nfp9jyrfmNI3OJ?=
 =?us-ascii?Q?ZgaOcHANxKIZco28TEaTYdddTFnTLWfaYovDIGpLNYPNcyI7zULJ5kyDLzNm?=
 =?us-ascii?Q?j12B1QGfP7bLnmfdRbuJtGzk0XhH3CoDW996iDWHigj1qB6tFaEqr5k3o7Qq?=
 =?us-ascii?Q?vNLKU2NjOV2VifB4I7gaa6CSD3/LAFA9uie57KifDG81nGbFi5hXNMqnvNE7?=
 =?us-ascii?Q?r3gSbzoyt6PVz2BbOMbq/93BhjDRJ5HNpNuEpR/gqznL4ZNtDnODMUKspXix?=
 =?us-ascii?Q?uGoo3r4W4E0XqqXcFpZjwM/HjCQJtOenxdHZ4ypdCvA7RLqIOF63SEdTd2KF?=
 =?us-ascii?Q?zgTJNqHEcmro5gVU0xhspf5IjaT4nYhP/AgQzJwQhJOwV0hE6YQn76t4nrK+?=
 =?us-ascii?Q?Xy4ebp95OqyMMP6ZLNUmyxzQuJxYTk9j2WISH6rsi1Gw1icE8YxK3I8Fd5Jx?=
 =?us-ascii?Q?Ktnjdsac7NH7rwV0/W2Yoo/C0a+cW2yvzqzjK0RfO0yT6bQdql4xcKEcNpfa?=
 =?us-ascii?Q?EQyEipXXg0W0V87mU+aeaZHhFDODn1vgwAXvRKtcN4+09IYjCufDpqw44SuF?=
 =?us-ascii?Q?BCrnwnOV9EKIKMnT8XrAp7VqZV/m5otPw3ijfLTcY8C+nbdp+tV6YBtL87mp?=
 =?us-ascii?Q?5BbuIOpTXofp10o2s3qezqQ43Su8n1l4E6qWLyfuAxEL1d/tfnSKwXpgjgHg?=
 =?us-ascii?Q?XOAUPzjnfpsQCAyrSIKqMncrb5dATHUFZfe3Uv9xwkDnRhWv3eJvX5PVmxqi?=
 =?us-ascii?Q?mnpYSm26UnFw/Y7316noZ4kIJmCPamMAi3Qb4FcsvaL4hvSIm1gNYQQvyLL/?=
 =?us-ascii?Q?tJAdzf1ffMJqahvSGDUMU53/coXdfheDiX9eeo56eBKQGcwnBkryQq5IaS7A?=
 =?us-ascii?Q?WaN4Lh/sBJZniZHtBmswTcZ5QlE9q/JQhlJA7FUpyYKfdXscT0XOd4Qoa6iu?=
 =?us-ascii?Q?aCogdVyvmSujgNKQEmPe5TDwMr5YPVmFpcvncl03BkM1Jr7qn33cwE/3OqpU?=
 =?us-ascii?Q?MGm095ZF14TnNAIHkQ5eNEJX+hoDAru8auoAt4/nhcpG5Slu7QPme6j4rfuA?=
 =?us-ascii?Q?eHh31BqsCbLSgbexbenxvi3pgWtXbclJWEUXiH31ox6lo6FO6OrrbZcB7Y0I?=
 =?us-ascii?Q?d7ufWR8l/uVuc1F2zWjxMlbm+hasZLbEIE2hB5Bk576DrtHiHSrwNsSpfLx9?=
 =?us-ascii?Q?G5iCk6sGyHgCgxBM7u2M98P0xVD5ylb+Dd2uaQeX8mXeIURnMgq5h9myGA5D?=
 =?us-ascii?Q?kq+qTPp2Fq9EZ39b1arqzGLZCuXq1kSnxvp7x3XfAsRjeCfaKHNCIhz9rErn?=
 =?us-ascii?Q?gStfhoWNt7XBTof7+jC+wY+M0zzB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tetoXBIFiXpETEk31phOe40dVggTdp2pFf1ck713UAuPkMSDISTXCBynHl1r?=
 =?us-ascii?Q?OQpufwsGqYuHgdzDr2GVs8lhNTXb9UA2Uoi+Cvm1LKX3qMp74eZxevbEbrbw?=
 =?us-ascii?Q?gCt8E2GvAEUwKZGcth+7VJ3RvTy2aicGj7JyN3eO49xsxCBM9OBCQkmp7LkY?=
 =?us-ascii?Q?GAqqT1QCpT9t9WvXmyZ/TU5M2hm2pPDkbk5naIGnRum55bz4QaUBac7DblXG?=
 =?us-ascii?Q?D28hr2fY53qdJ4Sqgz8/s1wWwtQn0M1zAJ/zbSv+GwSe6QYlziuh+xjmm55n?=
 =?us-ascii?Q?QND1d+q4YKuW+liAHSxjFAS4TiWt8a8l8MnnH/IH0ZqTX5RTnt6LkG7xlLxy?=
 =?us-ascii?Q?J8bX2CySsa3EnMt2tkgq86s3MdSNBP+iOvpkOOxk9e13K5r/NN59GGktc0e6?=
 =?us-ascii?Q?mcc+a5+ZWqSQ9RH19LEW0vlzf4pU7vuaXGyxUfrcp/ABoQKHyn/i99nmQ1sy?=
 =?us-ascii?Q?QVT6f491ylrrPg7g+AF6uiPSw86lca8vi8DS9ljmLSitfzIg2xMKekN7n5xn?=
 =?us-ascii?Q?ALfY3VYL/6tBCJE7KPF69m36mWhY71q2j3YS6Ykof6mP5TumJssE7V5cw07b?=
 =?us-ascii?Q?3G2TzmtWQuQpzNdxK1RC01nAV3sfuruwfzXIbX8Pv3SsZTNLocT0ndl0skEn?=
 =?us-ascii?Q?KFlcclm//xLjxeUvGkAvHmE5Hvytz6Og43lwyQZX7+cF50sMqgjs7Mtxxf0u?=
 =?us-ascii?Q?71iVr6DRr4k5PYvbWamTzxGL622HLd1TaMHgmnNmNnxMIyfJxcKl8qyJPV4Z?=
 =?us-ascii?Q?rx2p+RG97X7u6q8CsMSnrH7p2j/k+OD8RgEGEV+zEURMkPV/taZ59/MHdH/u?=
 =?us-ascii?Q?0dDJxStWVpM6FeW4R5esLnFUFnYedIfgXoi1wVbxIavCfTkhxVrRFGS7qNqh?=
 =?us-ascii?Q?slpT71Jc3ZKYUZb86sg2Hs1LsEsRI5wgkyqle+V/YGNfcRXYSC5Q6A/cfbbq?=
 =?us-ascii?Q?9YbD1QLMVsrZ29wvReaJ9qyGucJ5CW/auD9c6DuwjFstPvw56SBOrebx9Bt1?=
 =?us-ascii?Q?i+/43urEFlcOmJd9F/4TwTyXVP77vEEG5li+cyeyWyvnvnTGlldKqj8GToNx?=
 =?us-ascii?Q?e2jnWaHrcarTDDH5U3yfntxRMBV+fr1jskU9GppHdIQZI7x2tC6wX0KCHTnQ?=
 =?us-ascii?Q?2M9Y78LsXhFIPFn4X/r/W4PPf0BRgtWJrf04NUQnJwTTJzCiYC4fGM9IxCYB?=
 =?us-ascii?Q?91bHI+LOTVkDqUyZlto2qWJyj2wyrGP/RiBw6vSh5LD+cfv7M1+ky+FlQRV0?=
 =?us-ascii?Q?NXoMvrWW4wjYGOsB0mY+3PRuzOxH4sZbmmCM3VjQR+lp8yUg4HM1jlFe3SvI?=
 =?us-ascii?Q?auGw907hC/la5NCWMijHl+1vf4azcAJVphOwl2uCzlSzEL3M378OohsDVQFW?=
 =?us-ascii?Q?Xg7AlWGZ/tbigCKElXDNTgFj1q2odYXCZ/b3boiuU25hn/o5eu5u+KMDYJwj?=
 =?us-ascii?Q?fLh9tZcN5agGB44Nus5mVNWaXGlF7FCqNVlX1UWVR/SlW3YrMxaTr9lGNk4z?=
 =?us-ascii?Q?vjZEtdBSiTYIt9FwLzz3D2S0jzkE80vw6I4fgZfd5/Dg0+sNHnJGILvGXezv?=
 =?us-ascii?Q?c9xgitft/Xl2LoPpa1k5JxHbXKUZ7Z0dl3Fm7ITSKhKHRL4Vc4cMDfa0tBY2?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jIBhPqEtbMIzsCbm+wWqMW0mNl+hLZk7OStywOA6LaJwq5ZivrzcNkZQ2XwiJQaTAWCgR5NrmAsqH9qBGInGw5y/uKR87O9EOL6dNCB13gRnkpv36HOSICEVniQYSNmpHuej8KqJ05kAvNoQxs1EqGMorNMvCCNiGZ7nWwbOe0HNqNm81KOQWuplL3+4xNuZ6rR5KdLVVt39BTI80tGIHLmawKVh9fqtSbsV/nVg/6r2ViMH2809IvNjViV7yil5SBzuU3oEBsSyhU9G0yJblEGLU79IG22U6jsDwwO3yS8u07FSW6nVHHD9so5ssbr5hanP3iEAWBRish07XKCNhww0RrlqxhFBuXScrywpG4wcaAPsWSJNqp87kQG5jGhva1gnEQsQtcaYagAJpAHyk5BiTz9TjXtXD+Xdrv/X0qKc49YXImAKDatX6dgvhFpxdiB82SUgWiyhzMElndrzExNxVJBqIOr/UYlucNxu0yR7HPawU3AuhdHk3wQ7uEmDLHrzw5HxHuBsluaZGuEBuPJdd782GYbViI+JZyAFi4n8C5BtmmWKAdnw3XueoCNxMr/xwJqNPAPYg/tpY9T0wZ2lE7Xs76jCZQCBP+f3D/E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24bdb8ba-d380-47f4-4153-08dd60448485
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 02:29:15.5888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2BEULhv1mmEhVd2TvZX7+YTUHhOzQNB5EYsZ7oC0gAvsnJ22fqIOfmZ/26+s3eFdWu+tSaYSQCNv36ctsNk9/CGkw5bxVoGDdUYKe23kqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFAF33AAF2A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=927
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503110016
X-Proofpoint-ORIG-GUID: v2kP1NyYUbmIhHNEMbAtzo1Ha-jyPSgI
X-Proofpoint-GUID: v2kP1NyYUbmIhHNEMbAtzo1Ha-jyPSgI
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] (subset) [PATCH v3 00/16] Converge on using
 secs_to_jiffies() part two
Reply-To: "Martin K. Petersen" <martin.petersen@oracle.com>
X-Loop: cocci@inria.fr
X-Sequence: 2598
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/yq1wmcwnw1k.fsf%40ca-mkp.ca.oracle.com>


Hi Andrew!

> Really, an acked-by would have been much easier all around, but
> whatever.

Hard to keep track of which of these kernel-wide series go through one
tree and which ones don't. I generally err on the side of picking up
things which may conflict with driver updates in my tree.

Judging by the commit message, I did notice the missing parenthesis.

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
