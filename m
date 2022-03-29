Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF48C433FE
	for <cocci@archiver.kernel.org>; Tue, 29 Mar 2022 09:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:in-reply-to:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=mYcOwwGuFMXAZUtkmOnACyQwwdPgM9hs1R/oKr7Eu4M=;
  b=MfmiXlSjBq0dR4Wd+7fRRQKQq93g3hzn12lQ2HjZnSLS2sqUK5Oj/JgQ
   wyM6T5az16UjjZUZnZYxxn5Jy4NMKjgLppdhOk8F412O+EKVpaAXy8fvl
   blXJHw24giEddAOPTRRrsNpd/ohTNzytIAwjUOulZ9mJ3e/JPrHKw5R3f
   A=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@oracle.onmicrosoft.com
X-IronPort-AV: E=Sophos;i="5.90,219,1643670000"; 
   d="scan'208";a="28849481"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Mar 2022 11:17:13 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 34BE2E4370; Tue, 29 Mar 2022 11:17:13 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1C797E436E
	for <cocci@sympa.inria.fr>; Tue, 29 Mar 2022 11:09:41 +0200 (CEST)
IronPort-SDR: R+j3vzIaRj86/+T6TYyIoCHJ6JPaObVtWc/LHgIR/W+QY3PcPXyFRIKCqdEMhAOhQiuE2uaJyy
 sU61NSmqghwaxMEKgS6zASTw4PKeYiHglbSMttibFZMcMGPdy1kvJ01X2qusts/XO5O3eF5XcT
 rvYVJpLhB3kyWW14AVjjh3HNfx8ZR38XfY1mhdIPq6YFm8rQky90/QMhPz1pZEST0hZ10vwIzc
 f89eS5x9VGxilRKw0QpPQ7CRQMv66kPqGN9R3eDzXXRMN8WWOzzLw/BGSco0S7b+C7ozjG2gEP
 bjat467NWdUPyw1w4RaSwkN6
X-IPAS-Result: =?us-ascii?q?A0ABAgC4y0JihyCx3M1aHQEBAQEJARIBBQUBQIFagVJWg?=
 =?us-ascii?q?gAEC0SIHwEBhTmZWIxHA1QLAQMBCwEBQwQBAYUHAoRQAh0HAQQ0EwECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEBDQsJBQgKBw4QBTxkgQgBg?=
 =?us-ascii?q?U4BgVMLAzENgjUpAYNkAgEDEigGAQE3AQ8LRhQeKxMigmKCZgMuAQMBAaIRC?=
 =?us-ascii?q?wGBOgKBDgeJCQEBAXaBM4EBgggBAQaFExhcgVwJgTyDEYs5JxCBVUSEPz6BU?=
 =?us-ascii?q?4hPIr84nWs0B4NMgTsGDJ4OTRGDUQGkZIR0kWmmXgIEAgQFAg4BAQaBeIF+T?=
 =?us-ascii?q?QQfgzlOAQIBAg0BAgIDAQIBAQEJAQEBAY4dGYNZimFyOAIGCwEBAwmRYAEB?=
IronPort-PHdr: A9a23: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
 MM3htl0qlqin6+EzT81CHJz
IronPort-Data: A9a23:r1kWO6MIRBy4yDzvrR1lkcFynXyQoLVcMsEvi/4bfWQNrUol0WcCz
 jROCD2PPvaJY2X0KIwgbIm/o00B6JGEmt5mGXM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8kk/jgqoPUUIYoAAgoLeNfYHpn2EoLd9IR2NYy24DiWVLV4
 LsenuWGULOb824sWo4rw/nbwP9flKyaVOQw4zTSzdgS1LPvvyF94KA3fcldHFOkKmVgJdNWc
 s6YpF2PEsw1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB2DxYtg8
 tNn6qC6cldwGqLXmKMebjZhRnQW0a1uoNcrIFC6oZSZihWeKyW9za00SlkuPYoD5ut7R2pJ8
 JT0KhhXNk3F3bjuhuvkFa833KzPL+GzVG8bkn1py3fSBOw+TJbfTr/i4sVR1zM9wMtJGJ4yY
 uJIOGMwM0qfC/FJEgwYOqlitb3wvXjEdgAEiWi34vo2/3eGmWSd15C2aoaPIITULSlPpW6To
 WnN/kziExQCPZqezyCE+zSinIfycTjTXZJKHvjgrqY00VPLnCoLEB0RTke2rb+yjUvWt89jx
 1I88HB1vJI03hOXROKtBjm3u37DvSMzYo8FewEl0z2lxq3R6gefI2ELSD9dddAr3PPaoxR1h
 zdlePu5XVRSXK2ppWG1rejL8GvjUcQBBSpTOn9eFFptD8zL+dlr1nryosBf/LlZZ+AZ9Bn10
 2iA6XBm3+tCg5ZRkb2j/Vfcnz+g4JPOS2bZBzk7vEr6sGuVh6b/PuREDGQ3C94cc+51qXHc5
 BA5dzC2trxmMH10vHXlrB8xNL+o/e2ZFzbXnERiGZIsnxz0pSLzIdgNsGkmfxk5WirhRdMPS
 BCC0e+2zM8LVEZGkYcrC25MI551lPO+fTgbfqmJPoUWCnSOSON31Ho0ORTKhz6FfLkEibs4P
 pmDdseqETJSCKJsilKLqxQ1gdcWKtQF7TqLH/jTlkz5uZLHPSL9YepbbDOmM75ohIvZ8FS92
 4sObKOilkQPOMWgOXO/2dBIcjg3wY0TXs2eRzp/LbLYfWKL2QgJV5fs/F/WU9E8x/0OzLaRp
 BlQmCZwkTLCuJEOEi3SAlgLVV8ldcwXQasTMXN+MFC29WIkZIrzvq4Te4FuJesg7uVoyfMyR
 P4AIp3SDvNKQzXB2jIccZig/dM6KE7z3VqDb3i/fTwyX598XAiVqNXqSQ3iqXsVBS2tuMpi/
 rCtj1uJQZcKSwl4ItzRbfajkwG4sXQHwbogWFHBKd1ePk7r9dEyeSD2i/Y2JeAKKAnCm2rFj
 1rMWU9AqLCU8YEv8dTPiaSVlKuTErNzThhAAm3WzbeqLi2GrGCt9olNDbSTdjfHWWKopaiva
 LkHz/z4N/Fbzl9Gv5AmTeRu3fo0ooO3/+ELwFw+Wm3Tb1OwFr5sZHKB2JAX5KFKw7ZYvyqwW
 16Oo4AKZezQZp26SlNBdhA4aumj1O0PnmaA4PkwJnL87nAl8beCV3JUIBTR2jdWK6F4Md9+z
 Op96tQa7Rez1kgjPtqc1H4G8nTUJDlYC/15559CWsnzkgos0U1PbdrXDSqvuMODbNBFM08LJ
 D6IhfOb1+gFnxScLCA+RSrXwO5QpZUSoxQVnlIPIlK+nNCa1PI62Rtm9ys6E1ZOxRJd3uMvY
 WVmOiWZ/0lVE+uEWSSCY4ytJ+2FLBiJoka0kwNRyjzXFxPuTnTNK3YhNOrL90ccm46Zkv634
 5nAoFsJkx6zFC0y4sf2cUl/ovfnQJp68QiqdAWPAZGeB5djCdb6qvbGWIfLwicLxes2nkTMo
 eQs9+F1AUE+2ej8vIVjY7SnOX8spNxo6YCMrTyNPE/EII0ERAyP5A==
IronPort-HdrOrdr: A9a23:MvzVHa8wI75RbcDCUjluk+Fzdb1zdoMgy1knxilNoENuEvBwxv
 rOoB1E73HJYfgqKQgdcPS7SdW9qBLnhONICOwqV8bAYOCIghrNEGgP1/qE/9SkIVyAygc/79
 YRT0EdMqyKMbESt6+Ti2TVfKdDsby6GeKT9J3jJhxWPHlXgs9bnmFE40qgYzNLrF4sP+tJKH
 PQ3LsNmxOQPVAsKuirDHgMWObO4/XNiZLdeBYDQzoq8hOHgz+E4KPzV0Hw5GZSbxp/hZMZtU
 TVmQ3w4auu99m91x/nzmfWq7BbgsHoxNdvDNGFzuIVNjLvoAC1Y5kJYczJgBkF5MWUrHo6mt
 jFpBkte+x19nPqZ2mw5SDg3gHxuQxenUPK+Bu9uz/OsMb5TDU1B45qnoRCaCbU7EImoZVVzL
 9L93jxjesXMTrw2ADGo/TYXRBjkUS55VA4l/QIsnBZWYwCLJdMsI0k+l9PGptoJlO11GkeKp
 gsMCjg3ocVTbvDBEqp+1WHgebcEUjbJy32AnTr4aeuonxrdHMQ9Tpu+CVQpAZGyHsHceg32w
 31CNUaqFhwdL5iUUtcPpZJfSLlMB2EffrzWFjiVWgPUpt3d07lmtrP+7My6/iteJsUiLUPuL
 mpaiIBiUcCP3v0D8uAxZtK9Q2IZl6cc3DC9uFyjqIJ4YEVYtLQQHS+oZQV4o2dn8k=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,219,1643670000"; 
   d="scan'208";a="9917767"
X-MGA-submission: =?us-ascii?q?MDH9ttnouyR9i65l9ybAU3tUYWS8E+kJQNWw7d?=
 =?us-ascii?q?9uu22110myQXtd2fbUImw5F/IkTcRR/uJ9srVkJ/8QO28gxs8B3Vfwa0?=
 =?us-ascii?q?96ywmzv3jcf6a7MX8pR44WgyiZA10XKVFvuUU24WyWFN8xaRvM5VZ1T0?=
 =?us-ascii?q?0vudX1X2gvEbHGnA5sIsl7AA=3D=3D?=
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 11:09:38 +0200
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22T8oVco017301;
	Tue, 29 Mar 2022 09:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=mYcOwwGuFMXAZUtkmOnACyQwwdPgM9hs1R/oKr7Eu4M=;
 b=OnwqHKBRZmnIHTjfncG+RT7x1ZF+YbdN5E5sWW+gIrbGV7JqHPklS4rVavj+FzlJzk3t
 8kpKnaOYQjnxUwF3LyOAwq/3pqrjUv82T/FIQXNJEmhq78+Krl72DGsCKfcV8zRb58K/
 QSKShJb7ffTESFgtMk9dRFo11hjHWF28CDqJ6t0zrh0KKb0jTUslxFBAKchcpMbgcPRM
 Jyc/6f+a2N7dJXBD3es93gC/cqwNqM4YH+JwYuufyV70U6hXjisLRDIxFFBjZ6aMY70u
 FqTtHMA3VvXbSHF5O3pUTtNJZcLvHIdWKkP72b2GRKL+d0bVNUWJw7g4n+pRqbemaj1A xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by mx0b-00069f02.pphosted.com with ESMTP id 3f1s8cnxdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Mar 2022 09:09:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22T97370107870;
	Tue, 29 Mar 2022 09:09:34 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
	by aserp3020.oracle.com with ESMTP id 3f1tmyjrxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Mar 2022 09:09:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaqm0+UjtEQixYASu7jdpcpJTtYSHl28BbC3TaC75WAy3xNEMi5a8ne1JIxrlY+qHFEx1LJrjG5xSuedT9vqFuibmeiZq/NYHS+psTxUGWnYQBsZxvPhTyGeI/ezOE5cB9e1aYlmSPv+NbkwTmM/MAuULRNMfpvGEOM6PF95yAdWzgCOyyfOPdUsAOq2jTf3iCL1yJSl6iAshamm91o8c8QgYNF5drd6uFGS4VtQn4CfIul8qeRah8MN3mIvpVGxtTcwrtc+CVtuTETeD8fYOS5v2IWX3gK5mnsOa9iJYBb+2h3ONfJ8xnrbPDeQn/7X4B3wcPHeLl5kNEStmg5RGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYcOwwGuFMXAZUtkmOnACyQwwdPgM9hs1R/oKr7Eu4M=;
 b=h2tNmZZP+9WzxVxwd/29MFoeTeQG8QU7Q1ObcdumoS6VBvaYWxrOTmWjfmCTw6wXcvZ03SvOjwlNgb1mcnhunM8WwpO6PebUIeoCtkYOz+FXjMkaQfnY0H2qEgVC6HvcecOf82KtvI9mEl4CmrPiYkETz8WrGfB7OqD+VkfvftaNmTLYNNTNEvZhZE6dKSCf3VFyRnniZ2CxjShgKp9CAArd2ICRNCGhn0HoLxWegjgMb1hNcyR8hQmMURy/DksuX+Qef2t6hucwpcPAuF3A1UDPWZnCV8pFwHZIPYFcgwdCHjKSY0FWei23nmxW+au1t3sfa+dwqxgIUeoN3nDmiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYcOwwGuFMXAZUtkmOnACyQwwdPgM9hs1R/oKr7Eu4M=;
 b=Niz0/tP1XGxIL6p8cbvk4M9qXFNTdr1/cEruTCPhmN6Th/G+lF5vNzPK1Ysci7RNbTDpHkuPSOzfUFLcj8p7hpFX8KJ7lE38ehnj6+8ed+ovaJSBktgR7bA/ThhecYo/TPxrY7835D+QfNvu2m2NMpRRU5DKmRLMoWAwWrV/GCI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB2523.namprd10.prod.outlook.com
 (2603:10b6:5:b2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Tue, 29 Mar
 2022 09:09:33 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Tue, 29 Mar 2022
 09:09:33 +0000
Date: Tue, 29 Mar 2022 12:09:11 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: corbet@lwn.net, mchehab+huawei@kernel.org, dlatypov@google.com,
        davidgow@google.com, linux-doc@vger.kernel.org,
        linux-sparse@vger.kernel.org, cocci@inria.fr, smatch@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Message-ID: <20220329090911.GX3293@kadam>
References: <YkImfPbNOzQBq5ZD@marsc.168.1.7>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkImfPbNOzQBq5ZD@marsc.168.1.7>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0041.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e656210-99df-46c6-88d3-08da1163d6c1
X-MS-TrafficTypeDiagnostic: DM6PR10MB2523:EE_
X-Microsoft-Antispam-PRVS: 
	<DM6PR10MB25239F904DA5780547A28FF58E1E9@DM6PR10MB2523.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yr615by9iVbkK74FICqpcDzCefLgxvkcz06JCQ7Z7L4hpgDG3sL4e/G45iEldqjo10ubfpvbvsc6rNCL7RcSr4Ul0mi1eXJzQ+OqNBEmZJQAETk0kAVFtwBd4myU1JlrHja4t3WZFihxvvv93yl3Em8uEAsXTLNfK4wy2XSwflS9cCYfIrNHibQnJg12/4fKfozywTH0YT8JJeSOTCzaN/LdqKoGRYxEyxlsv4aB3hMISLmI2qcc5wO+06wsj+GfMWZX7TsEf6pVvaR/g5tRw73R5Yee7cITp3zRsGVtDwhvaV0fWmeMLyCte0WmUs5xRyqR9h+kuBPditd0sEKOvSpzsDyl7b78k1CHhOXcYzOrfJZMNLO5v5v06tSbbLDvaATMBeqNH4iJrhFuPDJU6EzdamxHBcexGQnJZYG+xpmBD+na2GMzT8VTeDjI/fF6vajejKvA6w5PbvRaPLXG6Um8tx/IwpxSF3+bFOMf7isLzCWJKgPJZZh5f+qqt0mqJTwZUwTrA7lWaCikRwwOn0/TzXcefR668WZHyoUIcaZEu7mKQtKcygQCkQRrJRsf3krz0rK3FW6YOTjpSBsTvIvyhdzIdC8b+yUDjOx1cEg+NyMvzgjaieZl5lduoYI4/drM+2DUwNjde2ErpFy853nMEeaDlaKlWfiQ+gCD0QxZEXO6fjLpfXQhUcZP5DswDuNq9pLgCPWytVAIa5AOyg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38350700002)(38100700002)(7416002)(5660300002)(2906002)(8936002)(44832011)(19618925003)(186003)(6512007)(9686003)(33716001)(66556008)(6506007)(6666004)(33656002)(86362001)(66476007)(4326008)(558084003)(8676002)(52116002)(4270600006)(316002)(66946007)(6916009)(508600001)(1076003)(26005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cQkYICMb+D5h9furewZSGSxKoSmyzF6kPL7AN/AQBr7FcAc4zvLjRGkQlRVl?=
 =?us-ascii?Q?49RTRCw8zVm1ojWxYRZUmbI565ZnjxKJujeAMppOmzRKuuUePTLAn5SOpiLo?=
 =?us-ascii?Q?Bi2BgKlKuR/Llakv5zObYYNTOKCOSifeK4z1Il+bsdyEpEuiU+25QlgOuamk?=
 =?us-ascii?Q?FTGuvQTKA/8amsOPolEyS61a8XWQUZEBlpWq0Ad0qWn5/jeYxXTCN8m7wmqC?=
 =?us-ascii?Q?HwX7ZBG4kZ0uIfizmulo9qwBKNj42yGV1lWYtMAxMVxbaULQ+MaWI4syoWOa?=
 =?us-ascii?Q?fvBBVqufokAJmQotIEy0H/DktLCTOsY/dZJJdg+pecRBuPpTl7IsjqG6U4O2?=
 =?us-ascii?Q?OBOKfIizg9wJMyM0stkqgheSvPF9gctUIpjg/P49dPh6CDCBJlj1utBr7dEG?=
 =?us-ascii?Q?+ATRX/7kOPvA/Dweat003K3P7+1PR/GvpvLAv7qPbbNUygcBXRN3wpc7/2fU?=
 =?us-ascii?Q?uSYF61xP2FmKw4Y5HGBmPFjqB6bO57BmdfBxKowlFAz3XU5sUUTQ3XAxJfvw?=
 =?us-ascii?Q?FdI66b1V1VJrt6CtWHwv07Q1D4DsZ2V8HjJ6OuaOBDhGBYACR+eKRYz3CTJw?=
 =?us-ascii?Q?izgl4L6dQZ/M20Vo7L36mgKJUCQNMJ+j0kxmlv5aByIF9SJ4VpUWqbvg1RMy?=
 =?us-ascii?Q?3Igx9JFRbHJrJIPylFeZl4VvGoyTxj1mXAGbFsUOIjxqWYjn7ZM7XQSeFYVM?=
 =?us-ascii?Q?AxkDuvOqyD7rlh7BF7tNRAlBz+hUbxvEKdh4+At3Ldrn+aagKGXRJEeDPv0B?=
 =?us-ascii?Q?X9k/92IYhoHlI2Yv3g4Tf3JhRLe4NZ/DN9KmzpVRl8AY95NWl1BROW6zv/Id?=
 =?us-ascii?Q?EWisomp/mh+4itTfUHXaQgzBueklzCDDDtP2FrBBUVk5yE9mkRAZtbgCXrVf?=
 =?us-ascii?Q?5whAW3JPewMlD/4rfwSrU3KDQBrvxgtZctgaFZHifXiP84rU4GWHAngURLnb?=
 =?us-ascii?Q?N/uduYuUXBQGIk6OXOcq/daEHQ6zjbU0JV4/r0mghma9NEGJb060Y14iiZFL?=
 =?us-ascii?Q?k3rkSqyeVLSKGu1nGE0I82X1KgQn1QCfSEJu+yPQJVf3b2Scx21Y49QO+twt?=
 =?us-ascii?Q?RUxZTYAierIQiMpSNU92zSfn9POE7o/5CihFlCUxvVTYr/VTQ/RSFdKV9SA7?=
 =?us-ascii?Q?SD7Kqd73Z1iZ6P3Pfxf4LAwSsyuzTrEqLiDazm6njnyZOPHI1n+HCs7PWA2m?=
 =?us-ascii?Q?fMZjFWKlEobobmdEat5gqyKqUx6nF8NWbgNj1Yz1llSdfIESZ/QV/4AdAaaw?=
 =?us-ascii?Q?NJsTXHU6kGzTyipL6sM2CEImYcH92MqPy0VKePToIwBCbi2m/FnFWymGyIas?=
 =?us-ascii?Q?pw2W96Mz7CGXu0YoH56LxAydxn3gRBnqMkibxV1lucWWH8niiLRVBr6eUB4j?=
 =?us-ascii?Q?jevEKJyegHieLd0eOhj0DG5a08w4tbCdE8VLZ4HXp5ZshjqXNwJ64Vp2VLZv?=
 =?us-ascii?Q?grR6WoBwXhAQumIN8ynCa/ut2a41BWlbsJaHGnZqcLvuabJFZ6OH2nV5i8IM?=
 =?us-ascii?Q?bvNPZbVacMXYeZivPwCSIChanglJjs7w7VOAD0QXHHdN55rG6euNMLuqMA8O?=
 =?us-ascii?Q?/J/4HAs0l5tQ7nR4vPy3srwQucu6t3AWOuDxXgfzh6lKbd6+oeIuwDlK98q7?=
 =?us-ascii?Q?u/YWZ0uv9C6hH8HYBqENCgTyWxeDOicHwk7ay1iPcyL/oI5aLoKldvQAJj6G?=
 =?us-ascii?Q?nNnz81eJE8g06j5CRGfMP3k/PNQONEZrn4ovQ84flsdDN+DZP03NSSGnhuUR?=
 =?us-ascii?Q?TqQyQxwa0rvpPRCgdTECt2yGk09ysxw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e656210-99df-46c6-88d3-08da1163d6c1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 09:09:33.0038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ESeQaeypIGQk5bAmboESrtw0C+cn10S4pDCW/QpKPAVYvvL/U332JX/1Xvhn/C14EuwcaJJrdfaSBVMx7h5Iiphowoopk7oBh4mTu7KaMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2523
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10300 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203290054
X-Proofpoint-GUID: jP5RZU7VQ1fbj1xI3Q9W20n-rbzR40pD
X-Proofpoint-ORIG-GUID: jP5RZU7VQ1fbj1xI3Q9W20n-rbzR40pD
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] Documentation: dev-tools: Add a section for
 static analysis tools
Reply-To: Dan Carpenter <dan.carpenter@oracle.com>
X-Loop: cocci@inria.fr
X-Sequence: 305
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/20220329090911.GX3293%40kadam>

Acked-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

