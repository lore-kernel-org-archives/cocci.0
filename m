Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCA8C4828E
	for <cocci@archiver.kernel.org>; Fri,  2 Feb 2024 20:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Q2m/2wszr55453umWWxAgsLwrfW/dmW8Ii0UsK5l6PM=;
  b=ULj4bULkklFfJqC+KQVq34cZwkvjGT4Jyf4JLXI7whVkRfnNUMLAFHKR
   iI3xagX2X9RTmJuAq8CUfWPP7P2+xBglIBMbhMh12IVhT84qfv26SmxL1
   0VWOokC6MQVGfhhodN++51/6PFApgEYkS3unZa/rI+e58ZsjaL8HTTM76
   U=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.05,238,1701126000"; 
   d="scan'208";a="150052631"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Feb 2024 21:22:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 564F8E008A; Fri,  2 Feb 2024 21:22:15 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8DB5FE008A
	for <cocci@sympa.inria.fr>; Fri,  2 Feb 2024 21:22:12 +0100 (CET)
IronPort-SDR: 65bd4ed7_Z6FTcSDI7S3LUfnyjlemw26O0o0k9fNX8BXi+aEhHE5s2E8
 MpDQvvU+RNWVy5H9ki3VK8ThIzizCuZmVh019RQ==
X-IPAS-Result: =?us-ascii?q?A0EmAgB6Tr1lhwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+COYFSMgQLSIRTj0WCJYQ7hzaHToRrhAWDFj4PAQMBDUEBAgQBAQMEhH8Ch?=
 =?us-ascii?q?1UCHgcBBDQTAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjF?=
 =?us-ascii?q?wcOECeFbA2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR0IBAgIBIx0BA?=
 =?us-ascii?q?REmAQ8LGgImAgJWBgEUAQGCfIIrAQMOIwe2GYEygQGCCgEBBq9aHywiVoFhC?=
 =?us-ascii?q?YEaLogmAYVug0F6Jw+BVUSBPAuCRzE+hEODW4Jom0FUfx0DgQYEXA0bEB43E?=
 =?us-ascii?q?RATDQMIbh0CMToDBQMEMgoSDAshBVUDQAZJCwMCGgUDAwSBMAUNGgIQGgYMJ?=
 =?us-ascii?q?gMDEkkCEBQDOAMDBgMKMTBVQQxQA2QfMgk8DwwaAhsbDScjAixAAxEQAhYDI?=
 =?us-ascii?q?hYENBEJCyYDKgY2AhIMBgYGXSMHDwkEJQMIBAMrKQMhdBEDBAoDFAcLB3iCC?=
 =?us-ascii?q?YE+BBNEAxCBNAaFSmcDGSsdQAIBC209NQYDCxsGIgEdAp4ffIEFgTwwljQBr?=
 =?us-ascii?q?ng0B4I0gWCBYQyfNAYTL4NyARKMd4YxDgaSXi6HVZBSIKhQgXojgVwzGiSDN?=
 =?us-ascii?q?k8DGQ+OIBmEFI9HQDU7AgcLAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
 JdcEtdm
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:bXj9/6m+Fvv785skA/EwN1IgYUzpDfL43DAbv31ZSRFFG/FwWf
 re/sjzpiWE7Ar5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6PoSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3AjivqqWokpGviBQDYNsldxOHmUdgDY0Dfi3eNGRS?=
 =?us-ascii?q?bMmFmYryWUmbP/awxxg=3D=3D?=
X-Talos-MUID: 9a23:L9CbGgjpMs8alWBnR7gVscMpMd1v2+eRDmc3vtYHkfaDGwFZJSvNk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,238,1701126000"; 
   d="scan'208";a="78611743"
X-MGA-submission: =?us-ascii?q?MDHIN1DoprHDOsul3NiXnR5dIOkpTcnPQIy01X?=
 =?us-ascii?q?OxqGgXtxsimPAa2CGHNQKrFl6Nqo04GpA0YSjDmtrBbpPS8L4/GOWe74?=
 =?us-ascii?q?Wvq/cFkSP469ftZq1nNTHRn2LnufuevVu4pwDpTtalg7juMkQECFMHCs?=
 =?us-ascii?q?cyrsahtA2orIC5SF+QFDpf9g=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 21:21:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706905298; x=1707510098; i=markus.elfring@web.de;
	bh=Q2m/2wszr55453umWWxAgsLwrfW/dmW8Ii0UsK5l6PM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=G8C10djeXh5lOZvU247Dn+9Cm7OL0cH/D1Bl7WRpbIO2WUKq6yMS521XEpMvH11G
	 WRc1JCbYGrSI15XggN2RCra71OGpZkOw/2pMmYBAyRP02aCEoaMjo17NonpG7dho1
	 yMhEmSatRaN1UzQVYk3O0LFCT0q8ylU80Dg71ThxyrJ6FmDQIZHPGmNNoF3FfSEYk
	 isnxm9vgAhHTnXuxxAg3+TNrXnCN7Ub6cRk4KYRxDOmY6Ym36usxl903tLabYsvNv
	 SjkoKSBKfbZoeLvoa2+xR1kYH6sc07rftcALRcZ+fYHMe5Qk4zhVfR4o1fssmy9li
	 +yh3SSzuItAQLfhwEg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlbLM-1qoioK00NG-00iZ9I; Fri, 02
 Feb 2024 21:21:38 +0100
Message-ID: <1a3c05b8-45f8-4205-8cb5-3b8f2d791877@web.de>
Date: Fri, 2 Feb 2024 21:21:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Abel Vesa <abel.vesa@linaro.org>, kernel@pengutronix.de,
 linux-imx@nxp.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
 Fabio Estevam <festevam@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 cocci@inria.fr
References: <20231210171907.3410922-1-visitorckw@gmail.com>
 <0e906ec6-fe73-4dbd-b555-a2c03b6e1030@web.de> <Zb04UUeE/cU9HtKZ@linaro.org>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <Zb04UUeE/cU9HtKZ@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CSJNiI+KQkY3wXk46J8sqBLCgeytL9YGPMpnE6bhxbHLS1ujsvH
 WtIcKGpQpstSECuHkRUVRn7udhpV/cp9kKG3djHijk+tDqEvugBIpO3jvDiEAqjrmsEDchj
 EB/bFJ8Rrbp+rgxqrwcoYmApEj+c4vj/lGSZtItFepLt/wAggTQ5pyAma0iq4NKvir+Oe1Q
 K195UfBoLASAs8DyCP3XQ==
UI-OutboundReport: notjunk:1;M01:P0:wMEpts7wPes=;A2mzpRYQ4imzka4vF4y/w2Bur/w
 +FcbRBULuHCiHAEiLUmpDmxYIoiEltOqt4+UAk/GlKEpka4Jn5xgjW1J+CEP9gFrwJB3OlNFj
 FJr4Ol1aVJgaGQ+I3MuQYaZOCVyjPu69gnwqMW8PAoBRa3z8C8bthaxs/4GvWMAmhWSpUCj4M
 K8TumhrqIE+EdrRpNSOiUe0gCQLuB3kFtQvIvhjHiWB8O98aP8if4f1E0KD5sj7ZJC7TzYlxy
 CjC4T1SDfC3Aiu9wwDuQbqzh0MB1vGCueyN6gBcoqrrrckDnwkUAaYEP5L/NWLM6/Kwp+mWks
 aMlsR0gYgdFWcCZmF3y3zlGgLeHfZ5Dm+gy1Zms2zcwWokaTBClVb/NCL32Vdir/5vKhdmouv
 PGBVxFZ77RhVflIUxRMPQiyAbfQzb/Coghset1BFN5oKKZV6GXUZP9b+DERLK9p4Bg3hS5IXf
 WckBsAsM6SRD1eXkK3sHAfX50iFQHIEQ4MKOpHQFEZuU0H5zFP/Ku/6oEXISDQ3MVa1jNUzAB
 F94sq+123wtyPRNE7ozcyCqYsPRU+zrmf7meIQpP5n8ALO8XSA86QlQh/YgE7o2abTUggMKfh
 XaPy+YMek2mKIegRxReEA6k4bjJHfVsMzxccWG+3LwXzDgx0fNNASGZxHBR1M7Ko1DdnAYQeg
 GkRwilOySYpq3y+oaBWb18XmC11HyOKkIwYkgsZ8ZexZ3B3rYcsSSpYplPZ8Hk9mjoYPZGpcJ
 YhCslGURNYJTpxQOU5y0V+K7LV1Fv7wgpLLc0lPOj+sI/hnMnGZN/bNP4SWTuSkw/ThjnYK2R
 5/y3ncMmAVC/iinfzzKk+KQynOb3EdQWFAZGl/bFksZyQ=
Subject: Re: [cocci] clk: imx: scu: Use common error handling code in
 __imx_clk_gpr_scu()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1497
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/1a3c05b8-45f8-4205-8cb5-3b8f2d791877%40web.de>

>> Use another label so that a bit of exception handling can be better reu=
sed
>> at the end of this function.
>
> Please don't send patches as reply to other(s) patches.

This is a general possibility to connect an information sources with
a corresponding change idea.
Will the acceptance grow for the presented source code transformation?

Regards,
Markus
