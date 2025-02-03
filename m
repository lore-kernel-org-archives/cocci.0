Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D32EC02197
	for <cocci@archiver.kernel.org>; Mon,  3 Feb 2025 21:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=E1RprFycDuHJldRn/ezrS+F5IM4jHFkaXUl211fTz08=;
  b=VIA2qmu38QkUvsHuTgbqvz0bh0Nt2aXWRgV/ZHfJyvgwYW1t6223D9Dt
   1nS2q4+lRLeGplgckCtJqSb9JqRNtKaXkuqTM/CVGbY9BIv1DXrfzgw3A
   aXNdbpkGOc13hcyrCDVnFz88M0eWiZymZyD6TQmjAvjPBi3VqNPjkIaV9
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.13,256,1732575600"; 
   d="scan'208";a="206383220"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Feb 2025 22:19:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DD9A9E0D1E; Mon,  3 Feb 2025 22:19:41 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 75F39E0260
	for <cocci@sympa.inria.fr>; Mon,  3 Feb 2025 22:19:38 +0100 (CET)
IronPort-SDR: 67a132e8_Jw0FR+xnoPH+gUa9dSJIxfen4CNoM1U1J/R09VPQ+9AwuHk
 YMOEkp6Ul78bbCUqSrnN0HuMJB737Koh97+JURA==
X-IPAS-Result: =?us-ascii?q?A0E5AACYMaFnfDDYVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYJDgVY0BAtIhFaPT4IhA4t2kiCBQD4PAQMBDUQEAQEDBDiESAKKf?=
 =?us-ascii?q?QIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABASIZB?=
 =?us-ascii?q?w4SKYV7DYJiAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEFAixeAQEBAQIBEhEEGQEbHQEDAQsGBQsDCgICJgICIQERAQUBH?=
 =?us-ascii?q?AYTCBqFEAEDDiMDpXaBBUKKRHp/FgUCFoEBgg0G2lwKGSgNbAOBYgIHFIEGL?=
 =?us-ascii?q?gGEcylcglUBgWyDfxspgzl6JxuBSUSBSoJ1PoRDFYNGgmkEgi9KgSeDQJEJk?=
 =?us-ascii?q?SwmCAEGFwMHBwkFBAkTBgUFAkIJBgUKEgMEAwQEAQILEwkDAwIOAggDAggGG?=
 =?us-ascii?q?QE/EgQTCg0LBwUfCggMEQooAyIEDisPAQIBVwU0AQgGAgIEBAIEAgoCCQICC?=
 =?us-ascii?q?AcCFAMCBAQCAQUSAwsBBQYFAQEEDA4CAgMDAgIBCAICAQECFAEEAwEHAgEEA?=
 =?us-ascii?q?wUDCgEBAQIBBBQGAwUDAwcDBAIDAgYCBAUFAgIDAwIDAQMDAgECAwkQDxYCA?=
 =?us-ascii?q?gMEAgYCAgEEJgIBFQUCAwQCAgcCAgMBAgECAgIEAgQCAgYDCQgBAgIHAQICA?=
 =?us-ascii?q?gMVAgUBBAkDAwUSDCADAgICAgMHCgMFAgEBAgQDAwMDDA0HAgMBAgEDBQMBA?=
 =?us-ascii?q?gECCQMGAgIDAwQSGQUDAg8DAgEFBAIIEAsHAQEPFAUECQUVAwYCAwMWCwQFA?=
 =?us-ascii?q?wMDAQwPDgICCwMXBQEBBwEDDQgDBAQCAwMJAgEQAQMEAgkCBAECCgICAgICB?=
 =?us-ascii?q?AEBBQQCBAMCBQICAQgEAwMDDQQDCAgDBQMMEgICAgkCAwECAwMDBA0IHQUJE?=
 =?us-ascii?q?QsCCQMEDQIEAgIBBgMGCgYVAQIYAgIGDAQDAwgDAgMCAgECAgIBEQICCQgNB?=
 =?us-ascii?q?QkFBgICFQMCAwgBCQMPAwIUAQYCCAMHAQEEAgIKEQoBAQICAQYmAwEBAhQTB?=
 =?us-ascii?q?wMIAgICAgYWDAEFBwMHDwUFBAICFgMDEgQEEAICAwMCAQEUBhUBBQIDBgsBB?=
 =?us-ascii?q?gECBQQCAwQCEgIDDhMDAwQGAwECChACBAIJCgEFBAMHBQIfAwMCAgULAggCA?=
 =?us-ascii?q?gUCBQcDCQ4BAgUDBAkCFAIQAgICAggWAgICBQUYAQImAgQBAgECAQIBAgEKA?=
 =?us-ascii?q?QICDgkDBDoGEQQCAwMCDgECAgsBAgIEAgMBBAcJAwMJCgcBCg0HAgIKCAkQA?=
 =?us-ascii?q?QICDwcDAgICAgYHDgMCEw8FBgYCCgcNCwIBAgIVAgMJBgMFDQMHBAoNAhUCF?=
 =?us-ascii?q?gUDIAIICQsCBxECBRIDDgUDAgIRBAIDBgUDAQcBFwMHCAICDAICAgIFAgUCB?=
 =?us-ascii?q?RcRAQ0EAwMDAggBBBUGAwkIKhsSAQEBBQEJAgMCAwQIAwMDAgMEDAsCAQcIA?=
 =?us-ascii?q?wMGCwgJBgMCBwgZAwUEAwcFCyECBgMCBAUEAQUCEw0CAxkCBgMGFAkMAgYIB?=
 =?us-ascii?q?wkDBwEBAQICAggBBQUSAgMEAgUEBAEBCAMDBAYCAQMCAgIBBAoBAQECCgIIC?=
 =?us-ascii?q?gEJEwQDCAMDAwMDBQECAggEEwUFAgEFDBMMAQoGAwYDBAICAgoBBwIDAwMCB?=
 =?us-ascii?q?wELIwIBAwICBQICAQUDAgIGBAMCAQEJAgMCCAECAgEBAgICBAEHAQQHBgEBA?=
 =?us-ascii?q?gQCAjQCAQMJAgUBAQEOAgIEAgIBAgICBAIEAQIGCwQFDQEBAgECAgEBAQQBC?=
 =?us-ascii?q?AMBAQECAgMDBQMFCA8NAQEXCx0FBAUCAgEBAQEBAhMCAgELAQIBAQMbAgEDA?=
 =?us-ascii?q?wQBCwIBAQQfBBYCAgICAgIEAgMCAgMCAgILHB0CCQMjDwMLCQgTPQELBzIEN?=
 =?us-ascii?q?gEUFAcrIV+dSjyDCGgZBwGBDYEnBYETgneQLoNQAbACaIM9oWAzhASNBplJL?=
 =?us-ascii?q?odkkGqpHREjEoE5DiWBXDMaCBsVbII2TwMZD4gAhiGDeshYRTI8AgcBCgEBA?=
 =?us-ascii?q?wmQNYFLAQE?=
IronPort-PHdr: A9a23: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
 BwHxb6+JoMWZNWTM6NKZVxznYCMEE3VD4klnw==
IronPort-Data: A9a23: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
 tVgD7XSyqhIxIC9FYB6ETk0xq8=
IronPort-HdrOrdr: A9a23:TJRbkaNus+KyHsBcT47255DYdb4zR+YMi2TDiHoBKiC9I/b5qy
 nxppUmPEfP+UgssREb9expOMG7MBXhHO1OkPgs1NCZLUbbUQqTXc1fBOTZskfd8kHFh4pgPO
 JbAtdD4b7LfBZHZKTBkXSF+r8bqbHtntHL9ILjJjVWPH1Xgspbnn5E43OgYzZLrX59dOIE/f
 Snl616jgvlU046Ku68AX4IVfXCodrkqLLKCCRtOzcXrCO1oXeN8rDVLzi0ty1yb9pI+9gf2F
 mAtza8yrSosvm9xBOZ/XTU9Y5qlNzozcYGLNCQi+AOQw+cyjqAVcBEYfmvrTo1qOag5BIBi9
 /XuSotOMx19jf4Yny1mx3wwAPtuQxeqEMKiGXow0cLk/aJAA7SOPAxwr6xtSGprXbIiesMlZ
 6jGVjp7qa/QymwxBgVrOK4Jy2C3nDE0kbK19RjzkC2leAlGeVsRUt1xjIPLL4QWC3984wpC+
 9oEYXV4+tXa0qTazTDsnBo28HEZAV5Iv6qeDlKhiWu6UkfoFlpi08DgMAPlHYJ85wwD5FC+u
 TfK6xt0LVDVNUfY65xDPoIBZLfMB2BfTvcdGaJZVj3HqAOPHzA75bx/bUu/emvPJgF1oE7lp
 jNWE5R8WQyZ0XtA8uT24AjyGGGfEytGTD2js1O7ZlwvbPxALLtLC2YUVgr19Ctpv0Oa/erLc
 pb+KgmdMMLAVGebbqhhTeOKaW6AUNuJfEohg==
X-Talos-CUID: =?us-ascii?q?9a23=3ApgxzkGser3XbVH0xh1lPvq1x6IsOb1ON5nvaIHO?=
 =?us-ascii?q?zGHw2Q5yQFFyT9ph7xp8=3D?=
X-Talos-MUID: 9a23:oaaXFwtpSsXe1RPJR82npihvBMZWzfmVNgMBiLsNvZmlKwosAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,256,1732575600"; 
   d="scan'208";a="108097284"
X-MGA-submission: =?us-ascii?q?MDEYmgDVJndNedQ9bjmmixt4cCf9JEUM8KZid1?=
 =?us-ascii?q?Mrt/u/UrkWZ2MzNBRbYp4OvS4+LOyo4+RrmHd6NuREQbAx2W4kEGz1xc?=
 =?us-ascii?q?RNfk3m7QAwZQtD9OS2h/PI3EB1Tk7kDPM3NT4cFs/3ReROnQt/r4iDLN?=
 =?us-ascii?q?aAKhZr3AggyCpy17e35+TsIA=3D=3D?=
Received: from mail-pj1-f48.google.com ([209.85.216.48])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 22:19:37 +0100
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso8464344a91.0;
        Mon, 03 Feb 2025 13:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738617574; x=1739222374; darn=inria.fr;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1RprFycDuHJldRn/ezrS+F5IM4jHFkaXUl211fTz08=;
        b=j34nCf4iux9nExgMfxE6PA7Dsbc8JtStnwWnp/o9ygiD2MwlVR8Nf6PZD1tlntCdUL
         wODoZSiyHeCyF6gYfM1ADHh92S51Qsu5a/LG6vA8NWEwGyrfEWM31jKD7zOMWqgy2TNx
         THKJgqM29lTwMO/0xU2lzZK/s9+4PcBhUfAvy7y2oxSn3NA05X5BS+yBvL5JB29Xqr1m
         7JcGAKeKG4h9kYuDRmqLe5TXlU2EPMVdNMMYLUMBCCp01SZjYwFxG0KUwWr5+X7DRyak
         Hruj//pc+AlI4jywVNHiLXOnS1Kq+g/d1B2Dr8whwZKHb3p3OmXj1aCiC4vvjKX6E7wv
         gjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738617574; x=1739222374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1RprFycDuHJldRn/ezrS+F5IM4jHFkaXUl211fTz08=;
        b=CDeLghfsgG7Gai/Qts0kwT7dfe7Si5L7sA6C0DmGkzZ4v0itjROIC1IrZkvPqqlQHI
         q9F6WAynDBNxFw88y+AS34VMwE4SpGt5hVp+yv4neO1yhM8IRLfqprcUmR86DbVi89bT
         5KD28oIJgkI2O0is+iWJ0uQg25WMlSutIPVHG5UWCphJEkussE/mmFY+YKmkrD3H+B96
         MtTbfTu3T9K84XlPQV7xe9KsKLlTsQ+WHzwHbjZlYMDNSn5PcKNjfzSQdEpZrTmRuPrZ
         g/e9Mslom6+w77RyhfryvDDHIPh8zv93uJYz5VFxpZVN95lch+mh78gGyFjRqyj9gAj2
         xYww==
X-Forwarded-Encrypted: i=1; AJvYcCU+JD1aC4Pd38kO9gNiiSvjYIJ8Lf7X3WLeTVR6acfHxwTqJcfoiTviI1atPyFPyIxuhej+ah8=@inria.fr, AJvYcCWKs8Txf5auzOswoZROeuH7h0RUE7A8W8JSeqxzq+QH8HVMMLVLiX/WPpJyqpZdsNKQIg1HVS06Qx4TRzQ=@inria.fr
X-Gm-Message-State: AOJu0YwMlVeEbUgkTSnMkJ9nLmBGC11/FhqecLsrWZWLTCYVG1rzKhpK
	9+mlyXMOWMudQXEPu/18IsgLOB0kRO7zd+FirBsp9otal1ana+x0UvU0+Rdv5R8khpaiVOELnKk
	mmHwsNuydTI+UvDA0GrUpH4j23mo=
X-Gm-Gg: ASbGnctrmLf8+ALCzpXu3cuovLz2nn0XM5ln+rtwBIC0pqgTX+dTWBEUg5XARTrKiTc
	QtVs40PqXL1kFxPhh9+I9szUCiSYpBYsphMh5038OMF+G7l/wvo9fwnt8Md1cQAHaI5A/K0Cx
X-Google-Smtp-Source: AGHT+IG/z3EJhnf9SR0K4H9KlI981FGgmyEgJkvQWHpkkih0UJEnWjGg3KJxlOWE94AU8gGejkz3MNO9Uh3+nXXaTBI=
X-Received: by 2002:a17:90b:5146:b0:2ea:3f34:f18d with SMTP id
 98e67ed59e1d1-2f83abdebdfmr37965262a91.10.1738617574433; Mon, 03 Feb 2025
 13:19:34 -0800 (PST)
MIME-Version: 1.0
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128-converge-secs-to-jiffies-part-two-v1-6-9a6ecf0b2308@linux.microsoft.com>
 <dd0358b1-7c8a-4c9e-88c5-2e1db69a3a35@linux.microsoft.com>
In-Reply-To: <dd0358b1-7c8a-4c9e-88c5-2e1db69a3a35@linux.microsoft.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 3 Feb 2025 22:19:23 +0100
X-Gm-Features: AWEUYZmGyX5TH9PuhG1vFlJR4zNh-9wcNWLcslfb_ZiDi-fTNv4o-akZqj7ScMc
Message-ID: <CAOi1vP_UTjuF5y5oEVquk45udBZ41WqxQpHufD5oK2wbQkobhA@mail.gmail.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Dongsheng Yang <dongsheng.yang@easystack.cn>, 
	Jens Axboe <axboe@kernel.dk>, ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, 
	Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	James Smart <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Sebastian Reichel <sre@kernel.org>, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Frank Li <Frank.Li@nxp.com>, 
	Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Selvin Xavier <selvin.xavier@broadcom.com>, 
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, cocci@inria.fr, linux-kernel@vger.kernel.org, 
	linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-spi@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
	ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] [PATCH 06/16] rbd: convert timeouts to
 secs_to_jiffies()
Reply-To: Ilya Dryomov <idryomov@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2330
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/CAOi1vP_UTjuF5y5oEVquk45udBZ41WqxQpHufD5oK2wbQkobhA%40mail.gmail.com>

On Wed, Jan 29, 2025 at 10:03=E2=80=AFPM Easwar Hariharan
<eahariha@linux.microsoft.com> wrote:
>
> On 1/28/2025 10:21 AM, Easwar Hariharan wrote:
> > Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> > secs_to_jiffies().  As the value here is a multiple of 1000, use
> > secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplicati=
on.
> >
> > This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci w=
ith
> > the following Coccinelle rules:
> >
> > @depends on patch@
> > expression E;
> > @@
> >
> > -msecs_to_jiffies
> > +secs_to_jiffies
> > (E
> > - * \( 1000 \| MSEC_PER_SEC \)
> > )
> >
> > Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> > ---
> >  drivers/block/rbd.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
>
> <snip>
>
> > @@ -6283,9 +6283,9 @@ static int rbd_parse_param(struct fs_parameter *p=
aram,
> >               break;
> >       case Opt_lock_timeout:
> >               /* 0 is "wait forever" (i.e. infinite timeout) */
> > -             if (result.uint_32 > INT_MAX / 1000)
> > +             if (result.uint_32 > INT_MAX)
> >                       goto out_of_range;
> > -             opt->lock_timeout =3D msecs_to_jiffies(result.uint_32 * 1=
000);
> > +             opt->lock_timeout =3D secs_to_jiffies(result.uint_32);
> >               break;
> >       case Opt_pool_ns:
> >               kfree(pctx->spec->pool_ns);
> >
>
> Hi Ilya, Dongsheng, Jens, others,
>
> Could you please review this hunk and confirm the correct range check
> here? I figure this is here because of the multiplier to
> msecs_to_jiffies() and therefore unneeded after the conversion. If so, I

Hi Easwar,

I'm not sure why INT_MAX / 1000 was used for an option which is defined
as fsparam_u32 and accessed through result.uint_32, but yes, this check
appears to be unneeded after the conversion to me.

> noticed patch 07 has similar range checks that I neglected to fix and
> can do in a v2.

Go ahead but note that two of them also reject 0 -- that part needs to
stay ;)

Thanks,

                Ilya
