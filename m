Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6121049516
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:in-reply-to:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=JAqErPuH8jvSz3S3uW1/upneO2POe6vZLbo48MwocK4=;
  b=gxzpZDgMmOHGOC9A3FyfS88cMKHKFKEVVym1JpJWLb3xXlOEwCA50YLN
   QP+qLeHOKnBv/EBuE1uwkUOGmawWTMB5JrMA9kOB5RKhoK7hPsT+NVwnu
   mrh8HEdLfs9q5U78wgHN8wc7L20oaiImfRA+4qV8eujAMTj0GwoaqMcFo
   A=;
X-CSE-ConnectionGUID: fMXTZkvkQmCRVBouVqdkiA==
X-CSE-MsgGUID: by+04tmvQeWt9+uNx5UCxQ==
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
   d="asc'?scan'208";a="267245420"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:45:58 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 8C02E818D0; Wed, 11 Mar 2026 10:45:58 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 9EE80839BC
	for <cocci@sympa.inria.fr>; Tue, 10 Mar 2026 15:45:42 +0100 (CET)
X-CSE-ConnectionGUID: XFMI+XzhS2SOkBvxrNihSg==
X-CSE-MsgGUID: NNgttavsSeatpRF07OEdaQ==
IronPort-SDR: 69b02e97_/zuSkvMMZiAEl7QjoqbMx3qz55Gth35Pt2qnjlMNaXdhd7Y
 Rxz+Gy7YdI/XZdF7e69iRtKzM+ECZSKugDC9UGA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EaAACfLbBpeXZkZTRaHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?W1TgWcyB1GEWINNAQGETV+IeQOSa4svgX8IBwEDAQgDAlEEAQGFBwKNIiAGA?=
 =?us-ascii?q?QQwCQ4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBQg47h?=
 =?us-ascii?q?lyCYgGEAAEBAQMSEVYQCw4KKgICMSUGEwgagmGCcwQCoHMBgT0CAosigTKBA?=
 =?us-ascii?q?YIYBNwigV4SCQEKAYE4AYFXhnAMAYFdg30ahHpCQIEJRIEVgiiBAj6ECoQUg?=
 =?us-ascii?q?mkEgiKBDokKihZSgRQDWSwBSwo1DDNwQwOBKUsFN2USPyEdKx85AjgHBRIhE?=
 =?us-ascii?q?RmBSXiCAQ+GankDIwteGg4iAigSXEo+ZQWCPwN4PTcUG4xeECENgg8+gi0GA?=
 =?us-ascii?q?QGBDVuCG6M1jhiVF4QmlH+McEkDqlUuh2WQc6kWAgQCBAUCEAEBBoFoOjyBI?=
 =?us-ascii?q?DMaCBsVgyJPAxkP23EoNDwCBwsBAQMJkWo0gUsBAQ?=
IronPort-PHdr: A9a23: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
 mhqDm0/RBmXio+Ru2aR
IronPort-Data: A9a23:NoFXxqmqKVLktD5XCFiXHd3o5gyULURdPkR7XQ2eYbSJt16W5oA//
 9YtKSrfbaHbJie3LscnK96GQXl26JaAyNMyTQZuqS9kFyMWosOVWYzEfhirYi6ZcMefRh864
 Z1EOtTOJsxoEXLVrxn1P7W49SIgjazWGufyU7TJa0idKeMcpAIJ0HqPzMZp2dUAbaGFPj6wV
 fPOT+z3Mlb+h24sY2hMtKnT8B9h5q+jsjgW4lBmaP4UsgSCnic8AcNEL8ldDVOoG9gORrbSq
 8XrlezioDuBp3/BLvv/z94Xp2VTGua60TCm0ycQBu77xEAf+0Te645jXNIEc0Bblj6VqN54z
 dRJpPSYRBwgVkH2sL11vyJwTWckZsWqxJedeSLh6ZfKlxWfG5fR66wG4H8ebdVwFtlfWjkmG
 cwwcFglch2FjuSq97O3IsEErtgjNsTiILQEsXhmyzzDZd5+KXwUa/iiCXdwhV/ct+gWdRrsT
 5JxhQlHMHwsVyZy1mI/U/rSqgsHak7XKFW0oHrNzUY+DvO6IAZZiNABO/KNEjCGqFk8cu91a
 Qsq8kygaiz2OuBzxhK13FeNxd/dnRihY6URPqOo7NhrgGackzl75B0+DTNXoNGStX6GAYwCA
 HFMontoqrUu/ku2SNW7Rwe/vHOPoh8bXZxXDvE+7waOjKHT5m51BEBZFHgYMIVg7ZduA2Vzh
 jdlnPuxbdBrmLSJTneZ97G8pC+1PCwUKykJYipsoQ4tuYe8+dto1kOTJjplOIiTgcHpEC/r+
 D2DsDAEqe1MquMH3pzuqDgrhBr3/cKVEWbZ/D7/VWWu5QJRf5+gf4Xu6F7B7P8GIpzxc7Wal
 H0Nmszb8eMRAIqRnT6KRrxUROvwvq/VdjrBnVRoAp8tsSy3/GKudpxR5zc4I1p1NsEDenniZ
 0q7VR5tCIF7DFWPTOxHcYKKUf8NzoL+Bc7DV/DvYY8bCnRuTzNr6h2Ccma/9QjQfKUElKg+P
 dKGctmhFmoTG6NhlWPuHb5EiO9twT0iz2TOQ5y91w6gzbeVeH+ST/ECLUeKaec6qqiDpW05E
 uqz1ePVln2zs8WnOEE7FLL/y3hWcxDX4riq9qRqmhareFYOJY3YI6a5LUkdl3NZc1R9zbySo
 i7Vtr5wzVv0n3rcLguWIntkcquHYKuTWUkTZHR2VX7xgyhLSd/2sM83KcFrFZF5r7YL5aAvE
 JE4lzCoWK0npsLvoW5FNcGVQU0LXEjDuD9iyAL8P2FgJ8M5GlCWkjImFyO2nBQz4uOMnZNWi
 9WdOsnzGPLvniw7VJ6IOsG8hUi8p2Yck+9UVk7FaIsbMkb1/YQgb2S7gvYrKoteYV/O1xmL5
 TawWB04nOjqp5Nq0d/rgavfkZylPdEjFWVnHk7az42MCw/kwkSZz7Rtat24JQLmaDus+YGJR
 /lk8PXnAfhWwHdIq9VdFpho/4If5vzuhb9W4VV4FlrPcnCuLK1qGVid/Mx1rqYW7KRoiQi3f
 UOu+9dhJrSCPv3+ImMRPAYIauei1+keqgLN7P8wHlr21BV38JWDT09WGRuG0w5ZE5dYL6Inx
 r0HlPMNygnilCcvDMmKvhpU+0uIMHYEdact7bMeIY3zjzsU2kNwWoPdBgD28aOwRY11aGdyG
 QCthY3Gm7h47WjBeSBqFXHygMxsta5XsxVOlFI/N1CFn+TevcAO3TpTzC8WSzpExRAWwsNxP
 WlWb3dOH5usxAsxpsZ/XDGLITpjVTm54U36zmUbmFLJF3eIUnP/F0xjGOKv0n1AzUdiUGl1w
 LWqxlzhcw7WR+Dq/y5rWUdau/3pFtNw0QvZmfGYJceOHrhkQD/L2qX0PHEBlEf6MJlgmGzGu
 uhY0+JiYoLrNSMrgvMaCqvL8Z8yWRy7NGh5bvU5x5wwHEbYZD2W8hqfGXCbI89iCaTDzh6lN
 pZIOMlKaSWb6A+PiTIqXYg3PL5+ma8S1uooI7/ECzYPjOqCk2BPrpnVyynZgV0rSfVIleIWC
 NvYVxCGI1yqqUpkoU3/h+gaBTPgevgBXhP2486t+uZQF54jjvBlQXtv7pSK5UeqIClV1DPKm
 jjcZp3m7f1okqVtuIrOLp9tJSuJLfHLaeDZ1zzr7vpva4vUPNbspjEljADtHz5rMIs7X/V1k
 rWws+DL4n7VgYZuU07ltsmAM4Jr+fSNWPFmN5OrDXtCwgqHdszewzoC3GGaBaIQkOp45Pj+f
 lKFd+6cdsMfAOkF9XgEMiJbKgsWK4bpYojepy+Sq+qGC0UD3Tz9N9n9pGXNaEdFfBQpILz7M
 Bf/4Ny11+BbraNNJR4KPO5nCJlGO23eWbMqWtnylDuABEy6qwqmlpq7sjE/sxfZDnWgO+Tr0
 6LvHxTRWky7h/DV8Yt/rYd3gCwyMF98pusVJWc25N98jmGBPl4sdOgyH80PNcBJr3bUypr9W
 TDqaVkiAwXbWRBvU031wPbnbzelKt0+APXLDR13wBrMcAazPp2KP5V5/CQ543tWRCrq/Nv6F
 f4goE/PLjqD6bA3Y90M586Lo/ZtndLb4XMqxXrTseLPBzQmPLFb80A5QSRsU3XLHfiYwQ+Pb
 SIwSHtfSU62dV/pHIwyMzRJERUep3X0wy9ucS6Lx83Ftp6GyPFbjsfyIPz3zqZJefFiyGTin
 p8rbzDlD6GqNn0vVW8BkO0ZufUqVNm2RpDraqj+WQcVgqe8rHw9ON8PljYOS8dk/xNDF1Tal
 X+n5H1W6IGtNhVKwLPPoekW08sZb57OJ2ihYM3DSfvumAA+ytzYfV6hyweTxVTYtf34p0sBK
 NsNRB/5nrBV3QcIYRF3qvMeol2BR8oWEBEol8zuoozayn+RdYOWKFytP4zWGT6cHL2oC7i4r
 Jqs7ug=
IronPort-HdrOrdr: A9a23:mkVAaKpIXUccgrrhXOtJHiEaV5vRL9V00zEX/kB9WHVpm5Oj+v
 xGzc5w6farsl0ssREb9exo9pPwI0800aQFmLX5XI3SOjUO11HIEGgP1+vfKnjbalXDH41mpN
 pdmspFebnN5DFB5K6UjjVQUexQp+VvmJrY/9s2pE0dKD2CBZsQjDuQXW2gYzZLrUR9dO8EPa
 vZwvACiyureHwRYMj+Ln4ZX9Lbr9mOsJ79exYJCzMu9QHL1FqTmcnHOind+i1bfyJEwL8k/2
 SAuwvl5p+7u/X+7hPHzWfc47lfhdOk4NpeA86njNQTN1zX+3KVTbUkf4fHkCE+oemp5lpvuN
 7Qoy04N8A20H/VdnHdm2qc5yDQlBIVr1Pyw16RhnXu5ebjQighNsZHjYVFNjPE9ksJprhHoe
 l29lPck6ASIQLLnSz76dSNfQptjFCIrX0rlvNWp2BDULEZdKRaoeUkjQto+a87bW/HAb0cYa
 VT5Jm23ocYTbraVQGRgoBX+q3nYpxpdS32DHTruaSuoklrdT5CvgolLfck7wk9HaIGOuV5Dt
 v/Q9tVfZF1P7wrhPFGdZU8qI2MexrwfS4=
X-Talos-CUID: =?us-ascii?q?9a23=3AtWiOHmmMuxnPoDbdzPXNgJvA73jXOU3z6VaTE12?=
 =?us-ascii?q?4MjxSb76/V0+K3qJkqMU7zg=3D=3D?=
X-Talos-MUID: 9a23:FkXpPgjSCg6HBSrTjHJ1rcMpEuFn/7inFls2nJwao/OqbXNXFjuUtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="asc'?scan'208";a="267123094"
X-MGA-submission: =?us-ascii?q?MDFR/s4q1x/74d59bu7PSHhYv7uIbMyAX2u0tF?=
 =?us-ascii?q?xrxt/o9aP7xxAPDNMUww0K1nvZrLlntu91ZvQa+gp0BW0cIexUQhxOBk?=
 =?us-ascii?q?sgk/Ny3D98HENAqJ9jX8z6ceK0NObZcQ1v66ne7YIP8gIJBk1NXxXwUd?=
 =?us-ascii?q?yWuWYbtYX/8OgV9TuhiP/xsA=3D=3D?=
Received: from mail-ukwestazon11021118.outbound.protection.outlook.com (HELO CWXP265CU009.outbound.protection.outlook.com) ([52.101.100.118])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 15:45:42 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wB3Xfg8fFKEFvKlN8/Fj9g4pkeaVtXn0kkDv06O/WSlvfRmYmXzgWxSHv/glXmpgWjTZmDQlgN6XQtexxgcXW1W3VL/TLBetRYLY+B0ZV+vUVrCE48T2TIf40hP5rOs6WTQ7mys9HRZ+1AY1OvWdkf82/IykWL/OF4A+EYy6VjDR2OHgY9tSg7ChErbiQ3cYlgp7LRs1+gUG8oz3MmZ8f87tinkxAlWUEiyIEYKB0ncf/zELL6vWI41RbzVzDg2PiDOv7VyMNBtlJHN7zzrYdtM2wpxx31mXGg7KPaEOEKyIvGxE9pmt0WWUaZE4NxXaxmjdGfClh+8Ek0cFT+UH+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAqErPuH8jvSz3S3uW1/upneO2POe6vZLbo48MwocK4=;
 b=W7tN4kfmd1B4jfJhRrUU6g4HsnWTQgFcjxfu8uf5dskX9ZbOcsBt430GAQhCKU8RgliHekyDzVdtGLYNkozrOO6SD2vWf4qf8y8niwVpCVoOOGsGHOzd80vtscok3K+fUCblknwTOHpHEiaywOV7qny2C0CogV32hxhE8dxV7Tq4Wq/YUNb2j9iwjREaJEIkKWo7nfWO/XYQXuJneWwzmE7r626rMP84ru1sLQzsKq7frVNFpBeZl8i8bshHULXeIkAad5lsnmOQcGAdgsVX9wqpjlsdXovsGplhJS5y8yvgeyXsiFIw0qc/e9C8Bq3IiywnSpp6TSnFye1QIK6rYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB4117.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 14:45:39 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9678.017; Tue, 10 Mar 2026
 14:45:39 +0000
Date: Tue, 10 Mar 2026 10:45:35 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, gfs2@lists.linux.dev, 
	intel-gfx@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, target-devel@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>
Message-ID: <qtwmj2mcbokwa7gexs5oqasjuitoaajiawc4d6dwcc224lmvbo@syjg6j6jggwy>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-17-bd63b656022d@avm.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iksijtbqwcym3dge"
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-17-bd63b656022d@avm.de>
X-ClientProxiedBy: BN0PR04CA0148.namprd04.prod.outlook.com
 (2603:10b6:408:ed::33) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB4117:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b40275-3529-4e12-fb2e-08de7eb3b274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	eS8vfNxIlcveoUfBbC1f0b/7XDyt042g0NrOSeRHjPQz8SGF8XhnduWnhSq6w/jRCubBJWCQ0em9JSqFUpfcMToM52skjTdNeFfaYr/iVSsKAWiaW3DO/bcnqdcpaQuiI02eS0+aO+CkNT1YH1QQ6E7Q57u6/qaWaQ20N+1FIBcJZS1mBzIioruuLmthEo0gpbRvPUw85MZ4BuTbyxgwfUdq297KnZNKBcxR51k+1QwxfVuZq9j/tn2i89QI1rer6MizYsOjruF/dbbHjCey+BSjf4ODjERjtTz7wyRciY2SWDagpg72iLn9KVmzZVKExW68zMr/l9NtJWoTedOYUByiSKXbyY/3JV9xRnX1MzB9BgBZzT1xIV+5HlUy2YjMHl/3dJLaD2oBPxNWLURA8Z08rKBhZiJO2xeSiCI4mtWcnPeq3oEWmmY/WeHCI/B3o7JWziYbmH0QC8uqLAo/mQeRtn2TDgHIlkcKjGfALzMiD8xYPzjGT5P2vIR5K1BknKS+wJWav08f2MBfPRpwDPe50D0F6uw8UO3X9XH+2FvKXluY6iP9bBIpwnIhpFLltJGAWJ97kBcunctHO08msp59QGCLa7B9KyIGa5ySuwKbRsiH6EO7wMRDJH8WU49ueWwW1LGly9m6jhK5/yiuwnls2+tKU53my80py9Z/IAQ4MsIkAQLyj3EYcQb0F1EbNzlO4n0fZQx8QozYXcKQrvPpY9dpMBAU9AUK3jolnXE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjlvdnlwWk1CSFZIUGxWVloyKzB5bUNjN2lRU1ZhM1hLSHQ0V2Flc3Iwd0VL?=
 =?utf-8?B?bXArd0JIN2tZVzZLUGpqcHBUbWNFZzAwc2o1TmRuYkFRMnBERWo0OVk4L2JH?=
 =?utf-8?B?M01qcWhaNDU3SDMxYnZDcThyUkNHMjYrZ0dtR1F3V0ZIVTVrUnRKN1dOOHR2?=
 =?utf-8?B?RHpPcTI5V3R6azVuanpHZmg3U3dOd3lZRk94MUpZd2N2UFZnMitFcXdwbGtM?=
 =?utf-8?B?MVBDd0xUODEzK21Ma2FQSnZNQVNYMnNGU2xJbmhqOHdmb3RhYm82alo0MVlQ?=
 =?utf-8?B?VzEweHRPTGZxV25GM0ZwQ1BUcytpRGJIY3hVVk5KR0ZBbzhrUHd0YnJVMjdy?=
 =?utf-8?B?T3JWUFFPdzZJVitQVWE1b0RnRkNLbHlmVCtkS295eVFOa1FyMTB4aVFPTzli?=
 =?utf-8?B?V2hUMW52U2ZGa0N6TTF4UWZqejVMc0RPa05rbHluMUFBUVJQRTJZRGM3clEr?=
 =?utf-8?B?Vmc2aGVzb01QenlhdGlYc0NLMWY5WUVJQ1JIUHFYcWs1a1pEN2JORDVjTlFN?=
 =?utf-8?B?YjRTRUkwcitrUHM4blJac05MdDY3VXJTSStuZUhpcDZsV1EvazZkMGRYME1q?=
 =?utf-8?B?ZFI3eWtGN3NEc0RCcGNhQTErRXB2cjRXWnRzbVpTcWtISDh4Y213SVhnMU01?=
 =?utf-8?B?QjlCaTltWWgwUFFmb3VuaGQ3dDVKMkVwdVphRTNMR1hvVDkrbXBSMFNMUlVa?=
 =?utf-8?B?M0JHVmRmaHdxcFg5QlgxaXNtckQ2SGIzRWJzYnZuTzViVWsxQlZHQmlDNExl?=
 =?utf-8?B?Z1ptTVlDVVE2ZWQwMGdDZEk5Y0Q3NnFyWVltd0N0cDRUa2lXZ2h1R09tTGNT?=
 =?utf-8?B?T0owTUk0UFc2SkljekM3QlZsVzJiWVBpVkZtaHFMK0FBOEg2aEovOGd6RnBW?=
 =?utf-8?B?LzNsZkJmUU92bC9XUU5jZ05SbWNXZ3B5VXRzRVUzTm4vQWtVWFFqRnRYekY3?=
 =?utf-8?B?L2E4TXpUV1ZCZGxZbitRS1RPYlBZVU9Yb0NDQUNEQnMvcTllUGltK1MyN2tZ?=
 =?utf-8?B?WXNuc2hBelVVbVNtWUtYSi9SYzhWa095dy9RS1F6bHdibjNQYUpITTlhVTNo?=
 =?utf-8?B?SFhldlpnYjYza082ZmFKRjZKd0h4LzJkTXRpclQxazNrQm9zTG5ReEQ0anhT?=
 =?utf-8?B?S2s2L3ZiYUZzZU8rMHFEQkczZElUeW5KcEFRWnFHMVV1RXNsTzUvR1hNaG1Z?=
 =?utf-8?B?T052eUI1MlpyTUNiWkNHbFI2dFBOQ29rNS9hcjltTStCVVUveDZTNHFtVXlK?=
 =?utf-8?B?Smc3cmFlakdnVmtTak8zOHo4VHhzT0x6WmEwK29HckR1b1VPNUtiYlQ2SHIy?=
 =?utf-8?B?a2VCRGJzM0IrZUJnSlVVNSs2Z1ozTWdJTEc2TWg0dklnenRxbHBVNkRiS2Q1?=
 =?utf-8?B?VWdRbWlCTVRVZDZtQ0txNW1pYzVLVVd2L21mSElOMUhvUk90VWNYR3JFNUFy?=
 =?utf-8?B?VkdFOTRTUTlrN2c3T3dpMUhhWVJOYnNZR3UydnU1UEpUMlAwdTczT1FyS2NI?=
 =?utf-8?B?NUVlYVJ5R3R2K2tyYSt0RGdaVlZDSUJjVmNlYS8zZm1PWDQ4K3ZOT1BrQ1Ay?=
 =?utf-8?B?MHRNaUswa2thTDR3cGZuN1R4ZzBUVHI0ZkdpM2F0N0dGWHJ6bGt6T3hyU2NH?=
 =?utf-8?B?U1hJWHdweVpZcXU0RmRkejFLQXo4OGRNa0NiNmwwMzlFbGk4UklOaWtLSkRF?=
 =?utf-8?B?UkpkRklXeHFRUzNxRFcrWWtGRXVuYXR3ZFloTkR5YUtSeWUzUjJhMGF0UktE?=
 =?utf-8?B?RytHVTR5ODNjL2dpQjNMUkxMRm1QZmluWVJCWkt5VTZ3VW5vSXE0MitqU1k4?=
 =?utf-8?B?aGJxc2hOZEsxdnJXMVg4N0lYZE0yalpJS3hYR25lQUw4VlBUWVpkWExhRGND?=
 =?utf-8?B?UE5BQlkrajhVRWk1REJvWTBoeXdIRnJyQVl5ZDlTeEwyWWJrWEhGR2cvTG9N?=
 =?utf-8?B?UktDRDM3dXhLWGlLL3pCcWp4UVNrSEN5clNLYmNLUFp4NjlxTldpUWppRXVi?=
 =?utf-8?B?bERrcGUwdmR1K1AzUEVOdzYwaUgraVBkRUtUdEVIeEYweVQ3WnpKcHFsUjhp?=
 =?utf-8?B?ck9wYlVlS1FGNUtINUxaMzZSUTdBZkhkdHEzOC9jNUg4WWRHUTEzZ1VEc1hn?=
 =?utf-8?B?R0JxTFNOZ3VMMldjamx0Wll2MnJ1M2dzSjVNTlVUSnV4ZXh2b3prY0d4bzVK?=
 =?utf-8?B?alRna2ROMW0zdzVCZWxoQXpqSXplVUpINE9jbFdpOTRMT2l6bDBFWGxpTVBD?=
 =?utf-8?B?NkVGRWlFYXVZdEI2SEZsdmJpa253N0NYMlNVeVd4UmZVVlJLUWIyUk5BaFdn?=
 =?utf-8?B?elM3bSs1cmluUGdxWTRDdEVRU1JVNm1PR0llU1djMEZsdGdRb0hWUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b40275-3529-4e12-fb2e-08de7eb3b274
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 14:45:39.3587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwFautavIbFqmN5YwHCFfTVUxc9gxa3cpwndmicLa0FlANQgRiCX3WWVzDmT9lbq0RC4/eZ8BgFQOpVQW1fLOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB4117
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 17/61] module: Prefer IS_ERR_OR_NULL over manual
 NULL check
Reply-To: Aaron Tomlin <atomlin@atomlin.com>
X-Loop: cocci@inria.fr
X-Sequence: 3385
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/j4uN7vlfyPUnfjeYzyUZig>

--iksijtbqwcym3dge
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 17/61] module: Prefer IS_ERR_OR_NULL over manual NULL
 check
MIME-Version: 1.0

On Tue, Mar 10, 2026 at 12:48:43PM +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>=20
> Change generated with coccinelle.
>=20
> To: Luis Chamberlain <mcgrof@kernel.org>
> To: Petr Pavlu <petr.pavlu@suse.com>
> To: Daniel Gomez <da.gomez@kernel.org>
> To: Sami Tolvanen <samitolvanen@google.com>
> To: Aaron Tomlin <atomlin@atomlin.com>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  kernel/module/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c3ce106c70af165e2dc1a3c79f5a074a5c3e3d34..7f62f0620dcd75960e431f7af=
3d1cadf4cc41e4b 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1551,7 +1551,7 @@ static int simplify_symbols(struct module *mod, con=
st struct load_info *info)
>  		case SHN_UNDEF:
>  			ksym =3D resolve_symbol_wait(mod, info, name);
>  			/* Ok if resolved.  */
> -			if (ksym && !IS_ERR(ksym)) {
> +			if (!IS_ERR_OR_NULL(ksym)) {
>  				sym[i].st_value =3D kernel_symbol_value(ksym);
>  				break;
>  			}
>=20
> --=20
> 2.43.0
>=20

Hi Philipp,

Thank you.

Have you considered other users of IS_ERR() in kernel/module/main.c too?

Perhaps it might be best to prepare a clean up for each applicable
subsystem in isolation.


Kind regards,
--=20
Aaron Tomlin

--iksijtbqwcym3dge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmmwLosACgkQ4t6WWBnM
d9aU9xAAqqgNT5SoU+VYtTZ80wOUwEE2OMdLBYzCI0mjnqJPXnb4U+JQX0SteStv
Wd+zDAGE5Me5p/CfEt/+aiyKOuiZL7yQucXzvUMGKxqLMQFwqPvA3WtSoTVFL+rF
LkaH0u5Q5L3fR1LqaiKYIZuzVEvau4J1yxwpr3TSOVVjsiNOir78WKYMWkbywt9w
2ZGJmWlqCHaicR+MbDxwYxmj6A8vWK4lMNrf9/bSNlRcevwMRBi5MEVCXNAmi8/K
HL+Lff4iFQayNqX+KHvqO+d71PuZJ6uRoZtmn2TOsqPFvRhSEwOCORUQRwprUwHK
1AXthzlvxw54scM7jH/H7EVz4b/StJaeHqfZLJ4y6QJv7HWYccOTXqVPj5yDF4AS
LNEe/UEO2rZOSVwqm8USG03ipXDhoZ7is3ump24r9vmbuJ4Ut/UkZnPPM2f1V8YS
AiWpOQ5tGWd+85RvZUyJfbagqS9XcCxV1Ec+y4MXwaab2ddu81t86xc5nbRANS/k
juKrG81J7nYvlpvQajkCU6tK/ZZsalYBs/BCg2IAYhG1V5SqGHR6o/a3KjVtmdwP
5t9pTp1q1bD8/UPf4bSgjULpyVSusQkcdm6aoNJD80Jqi8vPQSuZUDFw9gdbbWdT
6f5kQv0sOH33oz8IDL0pTNDmWbOF3HKDQCX5nbTnNtfG048XNxo=
=x/q5
-----END PGP SIGNATURE-----

--iksijtbqwcym3dge--
