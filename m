Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9ADC282D0
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=to:cc:from:in-reply-to:message-id:references:date:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=btDV4ppvtC97SDL88Tadt2S0/80U6CObJHZY0tXAoCU=;
  b=NydlhGKrbSIVANd9tscasaloRC7DtOUK27xZ8V5/bQACFFziqquzO+Zk
   pMKVadazgQilrcDcKCXMlIY5O6uxCHo7LMko/VM3PKPpkmnYgxF10i+oB
   t0Hmld29rRCDLZ5/AXjjlsO7HOiwzDjK9hwoMawhjh3bp2l0EXKevMOK2
   8=;
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
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211070281"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:59:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0E611E17AB; Tue,  4 Mar 2025 10:58:47 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4DC54E0260
	for <cocci@sympa.inria.fr>; Tue,  4 Mar 2025 03:11:43 +0100 (CET)
IronPort-SDR: 67c6615e_N9XrbjMEzX5O1uogjvsQ/e509Av2McwN8K4ScsbYd6HK/D1
 SPhm1hQP466csq+Yfh48Q0If4RNutCXx1HybCjw==
X-IPAS-Result: =?us-ascii?q?A0FTAgAVYMZngyCl3M1AGh4BAQsSDIIICwKBcFKCCgQLS?=
 =?us-ascii?q?IgjAQGFLYZTgiSeFIElAxg+DwEDAQsBAUQEAQEDBIUAAosVAh4HAQQxCA4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAQE5Bw47hXsNSQEQA?=
 =?us-ascii?q?YIHAYEkUQ1IAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEQINKDYBHwEBAQIBE?=
 =?us-ascii?q?i4BATcBBAsLDhMlDwEhJQY1gmCCMQMOIwMBoQ5DZwsBHlkBSAJWQokSAQEBg?=
 =?us-ascii?q?iqBAYIMAQEG2ycYgkYJgUiDfIRTAYVrhHcngWREhD8+gVKJNYIzhSeoW1J7e?=
 =?us-ascii?q?CwBVRMXCwcFgSlIA4EPI4EjBTQKNzqCC2lJOgINAjWCHnyCK4IXgjeEPVwvA?=
 =?us-ascii?q?wMDA4MphVSCEYFdAwMWEIMfeRyEeYRrHUADC209NxQbom6FPIE6lD6DUAGPA?=
 =?us-ascii?q?KEGBwOEG6IVg3ABpmUuh2WQaqkHAgQCBAUCDwEBBoFoATiBXFEfgzdPAxkPi?=
 =?us-ascii?q?ACGIRmDYch0WjwCBwsBAQMJiyCEfIFLAQE?=
IronPort-PHdr: A9a23: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
 0NWkL2gd8ILLo38wFBvZh9xm4GYQyLt
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:bqdgNK4HNGFjdG8pZQPXwcuCI+orL9Y04lQ7vn2ZFiY0TiXIra
 GTdaoguyMcRgxhP03I+OrwR5VoJEm3hP1ICOYqTMuftWXdyRKVxcRZnPPfKl7balzDH4xmpN
 1dmnhFeabN5DFB5K6QjWXWYrRQpeVvsprY+Ns2pE0dKz2CBZsQizuQXW2gYzNLrUR9dNMEPa
 vZwvACiyureHwRYMj+Ln4ZX9Lbr9mOuIP6bQUADxsH7hDLqT+z8rb1HzWRwx9bClp0sPof2F
 mAtza8yrSosvm9xBOZ/2jP765OkN+k5spfCNeKgs01LCyprgqzfoxuV5CLoThwiuCy71QBls
 XKvn4bTo5OwkKUWlvwjQrm2gHm3jprw3j+yWWAiX+mhcDiXjo1B+dImIocK3LimgEdleA59J
 gO83OStpJRAx+FtCPh5+LQXxUvskavu3ItncMaknQae4oDb716q5AZ4SpuYd89NRO/zLpiPP
 hlDcna6voTWVSGb0rBtm0q+9CoVmRbJGbzfmEy/uiulxRGlnFwyEUVgOYFmG0byZ47Q55Yo8
 zZL6VBjth1P44rRJM4IN1Ebdq8C2TLTx6JGnmVO07bGKYOPG+Ig4Lr4Y8y+PqhdPUzvdUPca
 z6IRBlXFMJCgDT4ZXk5uwPzvmNehTzYd3V8LAf23Aj0YeMAIYCMkW4OSUTeoWb0rIi6/bgKo
 SO0aJtco/exFTVaPV0Ni3FKu5vwColIbsoU5AAKh6zi/OOE5btsOPDdvbVOf7CLRYIM1mPWU
 crbXzLP8NH4VmsWnjkxD7re12oVHDe0PtLYfDnF8568vlVCmSJiHlStWiE
X-Talos-CUID: 9a23:nByR/29vwv341Pk7E4OVv0gNM8M0cHbP93LZE3OeJ017Yq2PW3bFrQ==
X-Talos-MUID: 9a23:wz8AGQpSCF5+laf9v8cez2hiFc0z+6SxNBkilo4Fi/WoFilvfCjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="210983761"
X-MGA-submission: =?us-ascii?q?MDFLR4GYIk+YV6Ap+iE4TDFHq+9RXq/L0QP5L+?=
 =?us-ascii?q?bNwKPmc2zAmh9YequI5R9ejZ/4HJPLOVu4oBC3g2IZZUzsP/dS8NZmZh?=
 =?us-ascii?q?Yh4gcre5K+Q2CitRuG8khxFN6+XIcNmeCZxgFYY6nbZBnh64hNv83V13?=
 =?us-ascii?q?PfGZiLeYU5NQEepuhn2E6uig=3D=3D?=
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 03:11:42 +0100
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5241NNMT017408;
	Tue, 4 Mar 2025 02:11:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=btDV4ppvtC97SDL88T
	adt2S0/80U6CObJHZY0tXAoCU=; b=bLvvq2GRXibq3664FbYfVltKTgsWdHaGwa
	52qOfSsSMq3IYzH6nQ8foBIKYM1ZTeANjeYj/zr3IKWpIQBZHiN0he0aS4D4uJpA
	oasLnuqKa4MvMTbihykaHXWx4aFHdgH08OF8G/CoXbM+UhTLMGQMfe2YMpkYEUjc
	+9Hrco3ypGlS+Y8jkgZqu/nX0vuamK/Y3YJlVaG91cNf/qYuo98NMMa8hJ3EZQc7
	fcREpxjTK+Z8M17LoW6dW6QcyU7J/6yVZ5jxuzMorBb85XahyBj5XDYH5JI3Lsze
	/bfLTDUMi280ppv6HHurWw2jSpiso/6dknQyfVVYu67i2UxtlXOA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u9qc2kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 02:11:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5240vLfM010984;
	Tue, 4 Mar 2025 02:11:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rp9u882-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 02:11:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3OnGnuHCLOHIa1OtA5jbPtJM8+ka+JvudW+M32g086O7kicw7S//x0oMT+htXBrxdq+J2AiOG9e7LIje5cubrKdjRnFyBJPir0lc0I3OOpyNgvJw5ImADqiLZWsBcm5sCnRp2vWMqd0IgChJ0ZhW/zW0P8J4w96h+/0pudiIsZh2NYns0I1ZgHjyvZ/qnm41fJW2UhIt04auyQz/VP4H+50gvEMnx9mSetNZf1kTDFYEQ0VI3CKDcfBByyj//tnh5un2WRjnQxXduhNOL3hdW/byz9hXvVstmsrtXg75Aqc7BsIDSJkHp7rCNg3yJtoAdyfM84M9ossgJo7uy9tMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btDV4ppvtC97SDL88Tadt2S0/80U6CObJHZY0tXAoCU=;
 b=YteUOX2U1V1h/+wHhVv3x4OdzoOAlry5j1oWnX5bC7vIYgqkQWZLRBidG4Kq/Au9PoxujAynR6wsPlF6OA4raX7AcbnRkVqBPy7ZUUBUXT2CDIAlSSCb39UGIxpWGkRDvwF9s2upWoyXpvng0LjYhbv0UprvuKcAN9sa/Gbp6O+z357ARWPla3hco5j7Uwanuc40lsn4Z4illm6OKstZGWgVs55M42vwTe/3lX8tkS2SM4KGIvODQ6aRqn77t+FhJzpRVor9PbnBYtN1ZUp9V2qeRkGeSwt8Ig25jmXgmoRjbwtuU7z4n1BdZYgywj/NTKyfMpHHoh0pTeN1jdl+Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btDV4ppvtC97SDL88Tadt2S0/80U6CObJHZY0tXAoCU=;
 b=iLF5tb4KEK7ymS1wB+6kq1WCOhXpylbvj2hYilemS8QZmACA1ULpxfyDOiU8zqpSK0ULIA+MmietFeh8Q+gb2nERNPy6/VlAi9f48jL8eDoV0NCI3zMsQwbeJC3y1sgHSJGh8KMuaNr0dmyVif2BxRy3F/pfPKjy/BnX6z+YScM=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by BLAPR10MB4964.namprd10.prod.outlook.com (2603:10b6:208:30c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 02:11:16 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%4]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 02:11:16 +0000
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Ilya Dryomov
 <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Jens
 Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
        Damien Le Moal
 <dlemoal@kernel.org>,
        Niklas Cassel <cassel@kernel.org>, Carlos Maiolino
 <cem@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Sebastian
 Reichel <sre@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Frank Li
 <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>,
        Shawn Guo
 <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam
 <festevam@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Hans
 de Goede <hdegoede@redhat.com>,
        Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
        Henrique de Moraes Holschuh
 <hmh@hmh.eng.br>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        cocci@inria.fr, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-spi@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org,
        ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-2-a43967e36c88@linux.microsoft.com>
	(Easwar Hariharan's message of "Tue, 25 Feb 2025 20:17:16 +0000")
Organization: Oracle Corporation
Message-ID: <yq1plixv94t.fsf@ca-mkp.ca.oracle.com>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
	<20250225-converge-secs-to-jiffies-part-two-v3-2-a43967e36c88@linux.microsoft.com>
Date: Mon, 03 Mar 2025 21:11:13 -0500
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:a03:180::21) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|BLAPR10MB4964:EE_
X-MS-Office365-Filtering-Correlation-Id: 4477a3e9-1c12-4e9c-6031-08dd5ac1d872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fkuNL2W/44rIQ36y3j4VyYZzmNHoyrz+X7QmvP+wCWjDBcP9CO6hUjimURrs?=
 =?us-ascii?Q?/2yIlKh6BROK1BzDf5c8KYUgO4ODG17maaX3V+8F0W5JMfjBvizI+JjvQ1BN?=
 =?us-ascii?Q?f3Gv7o1QEXMxEKdOrbcbnd3xpEbW34JBZzb7+UFvnRZnhAddGKX12LlMQUju?=
 =?us-ascii?Q?HUrPxd2sL3G0NFSNgbUtXAxmzs1GAQVc+T4NdtvD03tzo/YZ06dc/YInEuO2?=
 =?us-ascii?Q?r94Oqq25HIOR5Q7Wb/16W7LfqjY/3nrSj/jOlGDvYXKxPmusNQM/t6H4GZm8?=
 =?us-ascii?Q?HorTJKJ4MeNEQrahYDJbOyQ5JO8LX1CIR7SSdc+ImIIvZh+7W50OGJL7q4N/?=
 =?us-ascii?Q?Pg5tyhcHADXcJkLh0KXV+ErogP2oFHFbQtnin4XJBpro5Vvu3eTQpEUpGuwR?=
 =?us-ascii?Q?bn9ejvLe7CleNxZYqgu/rCNb/FxFlnaytLxku/h3GIFfkYZC99TOcm4u1Og6?=
 =?us-ascii?Q?FW3zhgsnkH/6eW8d9OFRvItfzJf8mWPxm0gfU3yJPJ9HApMhU1r80BHDdbT5?=
 =?us-ascii?Q?t5xKKUQwly267yC3RAesEYpWPtjz1j+vRFwLgZyGqMwUpCLmTZ1ud6En/qru?=
 =?us-ascii?Q?8LF70T3Cn4IqqyZMK5HX2vfirYBD1ovSH8S/T00OHF9zbfGC55hrDhnHW3hM?=
 =?us-ascii?Q?h+ZgSmMVBzICA4u65WJS1ta2keojmVlLIzmQfKM0nOzdMmMXal/QIhiurLKj?=
 =?us-ascii?Q?Qlm0u5Qk/q9MBeYsR+idO41gAM2CWeCIsnSEZIWOqqTI2Va7hlFzzD/AS5qB?=
 =?us-ascii?Q?jhEBlvJfqpt+Tbq/uv3w7xW4gtWS0mL8VwWo+mFhwkIjF9lOFX4fewbPc9El?=
 =?us-ascii?Q?rUMRD3l5KTjJIBU2qS9G5QRzoeeNvtUKtqZ+5YYE9LOP3XOIy/lYY9EkBnTy?=
 =?us-ascii?Q?5sTxQ2f/li+X9Qz8+Y2+glfOImfvp1rlE6UJ5YxI2PPoPCznwMUVlJf02fnq?=
 =?us-ascii?Q?cYFbe1FCH1oe9doptdgv57xuVsE8jkeyWy7x6KR81sp1VQ84S/aQPIMrf6cn?=
 =?us-ascii?Q?xrCCzAedoxvyKi2HWQnUKTjgkyX7AD+UyBMpReuOQmFvoIQvCGOM3EwjGWvH?=
 =?us-ascii?Q?tH7v2WDAAYOY3cGFyJ4A7psTUDQIKxQw+/bP2X9O6d0Wf0MwZOs3IH8ptc7N?=
 =?us-ascii?Q?DLtnZxSZ08BkkrXP3Tre7YP5Nc15h4sya+1KNTAC84anXhctkJZnHonJQKQU?=
 =?us-ascii?Q?nhHpB6mWkQpdThfhzdeAvUl6DZyvi7hhHEJUPhhH1LA0rz75jx3j+2eEI66z?=
 =?us-ascii?Q?hFikRN/EFBg4nxiicwTNO25oqhQG9233C0jUAPYcRYmOO085mPzemBtq9yjn?=
 =?us-ascii?Q?0by2iocuI4stOf4CwEPH8kDgsl0j5khXTrtEsotCNO5kqX6HBuM2OQpmznOC?=
 =?us-ascii?Q?/4fE9ubocMLYibmBoM894mO4x8KU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F6LDMBO3njMdYHS+V34aVtKp9FBPYV4i6Du7LViu+khaKyDQ4rCyQr3kkjjl?=
 =?us-ascii?Q?TI8d0EDr7unCjwnKYFGogJyRHNH2/tVJW18E7SImWz4ySUniKhad24YZ2DSN?=
 =?us-ascii?Q?qjwD3N+nZBsXeBcVMC0HX7Fh/M8Q+6Gq3+cBzWMTejP1yCB4t7R32ID+p+em?=
 =?us-ascii?Q?HB4ElBNbGDWoZ7nd4YOhuJNs09Alt8BObJ6Rz6Qt2pV4RQSMA9DcGuwBtVp1?=
 =?us-ascii?Q?NrMSX8YnZrQPXYHs4fP7O2GbvQGZD4nJq4cU2vdwDlYXDA/l2J2QJZiCTVuw?=
 =?us-ascii?Q?Dni/1Pb3xycYct1sZQ0UYy+j5y6geY3qoyqHxlNDVja/oqPx5XChRmRc61VK?=
 =?us-ascii?Q?OUtmwTMZySI/WgbL5KNQd7+duavQNs1q6e0Y3lYYOPP4aBVeUpAN/ffPmYdK?=
 =?us-ascii?Q?Qrh7qUCwOD3dWE7VPWHhf197gD78OUR8ptGmjUDOaJuVjRQC3ItUWunkr+ME?=
 =?us-ascii?Q?uNZx9vXMH9FBY5TKkdq65skrWtrC0UmTcFlq7QCA9k2WUXyXL5QGW9qwsZLs?=
 =?us-ascii?Q?15eQQzSbFJIqwYozD8t7muFr2nEtzm6pqqwbtwB++6o9AwSmf0xzJwXsbFuj?=
 =?us-ascii?Q?/ySZ2tzFOdfzZUkukQM5poR7T4JC4OIBuuyJ+onazDU+/5eQTQ1ioxP19ugD?=
 =?us-ascii?Q?A+h+GP0PtBfi9zyGGfVjNLrWy97ff/tu+fMIVPMT7AIiusc7aUC09+BvCi0K?=
 =?us-ascii?Q?cBq7rWTRENn/XBpIjxFC2w9uT1FMaFBaREovnhcFZY75FxRgmpPFA+rGwo88?=
 =?us-ascii?Q?/LHYo+nzB9+qJkNRV2lSGrE/opEBHThYMyIlHY4qkCLyF7jDwNqN6gT4byf8?=
 =?us-ascii?Q?BP0e6hF2QJUqwH0EN9+xkSo/aA0dMzrCLjWVDZ2ebQu/Dm55P3IvM8LulEMQ?=
 =?us-ascii?Q?H2yFEhcAE7BOcz7+Zpz6WPztURA8Wp3Yj/Veb9quPgl0mys9rj5u5gsuOLZh?=
 =?us-ascii?Q?xWLGxLL/HS3qMUus8Sq4EL9pPwWLDckoQZvv3wsS1PtLplvlNFx9DFNKoSHs?=
 =?us-ascii?Q?hBFWyu9b8/U6eKGGX51cJFR2RZlDQ9xa3EDqM86IcsZASag3575ELrUSofGy?=
 =?us-ascii?Q?hYVNkX9saL0NAkVMK3Cb3CAUgEkDv7qPXRtk9eje8Jn2YNQJCVzM68gVd+Di?=
 =?us-ascii?Q?eohr6r5heCgq+wdFCfowiWGdCT0k+/i61FzsRL3jtJPEMoXy+Pjm/0fFcZ1q?=
 =?us-ascii?Q?FbV9bGkT8mF0bDcmYFR6/GCOKnLDaiJ85nP6PCNpPZ3Tmfq9ZrISarQxZPmn?=
 =?us-ascii?Q?j9x8LgznV8/auRm9ZCeMAQh11/Wl8uo5Z9AOgj0oczytUqvIaq68bsdAiNdE?=
 =?us-ascii?Q?Ru73ng06V/ZoLThAxQNY6qcPRDpR2kBsnZS0gPf3y9VfSS83Wpaq98iT2MpN?=
 =?us-ascii?Q?s/sfvlo8RVbQgzyXRZNGbnUE3OntWNGU3rxWdwEwLXO7sITJFbIzesUA2uuP?=
 =?us-ascii?Q?TF+/6P/GD/LSSVVoCQStVLztKVOpiF2uiMuJoSZTLu1aeqHH26QoDvGUSa3X?=
 =?us-ascii?Q?5tzfd/o+DH1sbGmt40NffOJkLSrbWdRNYgi6SLDajB2+8+TGuBd5C5MRyELB?=
 =?us-ascii?Q?YGblPReY+GloKgk/3C6n9CuCB0knmQzHPRfzMTZ6QXiyu6BhXopX9+F/gkDR?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UsJ50NUebHDcNSW1WXThU/+QL5KxeyLwFqjwbmJuXaaUXVgMsLsT8QiX1AuwOUjTBwALSA6zkmOVBVglOEUra2di7ZgBHvVyfsuwW2hwObz6hntyj8inpy2AxS3pt1W/KCUB7qUITZjd9PE+msZ+RGQekARzAH3mCWKfxCwe7A99ZxyZ5ebSZQbduQ9hTCukkJ71+JQA/lEG8X/X6Qml6gMeLNIAELYfEp++UddcZcgjqKSaEVIQTonfOnrsCh3EwmUNX4rHLL/7lgpyCygkZzkR12iTXhNyHBrZzORmhjNJtw0lepOgBKdT5ZKyOqzsRpHcbfJ/pA3jShsq3/eBCf4tQ+ipNnx+KeLx/ONvBIoXzJHsRxbesA/MUFxm7ffP970bFuuZij2GuRlBKNpkQ65bsO9t7vKg5DjAnmkr8HzTNAgeJCFMtZhOpbKPYXoIrVPFrSZ7SHlCV2qK2ej/irRe/pZsixTPCN0dl/T5otCA3G8+GjjH0vw9rhobQjNqxQEXkYMW5L2zp3dqkPBXpYd9SLBHBlj8DkY18uzCVtFh5lP+x+PRHL6RQO/zt+m/ESEEk3S9781KTMvTYtUrJ8KSKcRCs8zH652wiYvl3+M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4477a3e9-1c12-4e9c-6031-08dd5ac1d872
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 02:11:16.4304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4y4oI4DvmtMpSrmreJPVtPCbXkxGJv7rxr1qDYlmeAc2id73OuvHtQOtP3ksJw+fyFBoZMmFIkkZqPYbTol+b6qI2w9x+M4q2AreXiDuZgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4964
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_01,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=813 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503040017
X-Proofpoint-ORIG-GUID: hhfOBlo0AVpdxJFTPFYr8mXXDbnXlZ2R
X-Proofpoint-GUID: hhfOBlo0AVpdxJFTPFYr8mXXDbnXlZ2R
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 02/16] scsi: lpfc: convert timeouts to
 secs_to_jiffies()
Reply-To: "Martin K. Petersen" <martin.petersen@oracle.com>
X-Loop: cocci@inria.fr
X-Sequence: 2520
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/yq1plixv94t.fsf%40ca-mkp.ca.oracle.com>


Easwar,

> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies(). As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies() to avoid the
> multiplication

Fixed compilation error and applied to 6.15/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
