Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BE3C021B2
	for <cocci@archiver.kernel.org>; Tue, 25 Feb 2025 21:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:in-reply-to:references:message-id:date:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=pLp9Ea62UroP9Hu5zCjkj8kz5zOw20u3Q4aJrEzL0tk=;
  b=Tsy2jLlt1T0AqQ+D5N6Ert1A/aBwnkU9bjOUqzz6lppGOi6lW5/aaJHV
   tHUtAUO8mOKgBzC8kYhhdGvIcbsxK79ELrQgJgg7JeNgAbRVZ+ZSmIg/a
   RJCYr7Mnr/Pns3Qx7FMLF8wKZVsLba8/vDwQXO+szaVf7PbuzUEMyap+V
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel-dk.20230601.gappssmtp.com
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="210047112"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2025 22:17:08 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6E1D3E0D1E; Tue, 25 Feb 2025 22:17:08 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 180CEE0260
	for <cocci@sympa.inria.fr>; Tue, 25 Feb 2025 21:30:42 +0100 (CET)
IronPort-SDR: 67be2871_uvZ+HyleWyX9BtNBTugYJCiYlWsLgp2v1Ej+ouOfVNzrx7i
 9LerxCxCwtYWO/ESte7yPUaMhmZM8ejyFLsT4CQ==
X-IPAS-Result: =?us-ascii?q?A0FbAACWJ75nfK6mVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UIEAQELAYJDgVczBFOEVo9PgiScPoJ7A1YPAQMBCwEBRAQBAQMEhQACixICH?=
 =?us-ascii?q?gcBBDMGDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEiGQcOE?=
 =?us-ascii?q?imFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQImZQEBAQMSER0BATcBDwsOCgICJ?=
 =?us-ascii?q?gICMwEFAQwQBgE0hUUDozWBBUKLPoEygQGCDAEBBt4FCQkBCoEGLgGITgGBb?=
 =?us-ascii?q?IN/O4NCeicbgg2BR4J4PoRYg0aCaYEUgR+BboM+mg+EeYhZCT8KexwDWSwBV?=
 =?us-ascii?q?RMNCgsHBWRFEDgDIAoLDAsSHBUCFA0QDwYQBGoFNAo3OoILaUk6Ag0CNYIeJ?=
 =?us-ascii?q?FiCK4IdgjeEQ1wvAwMDA4Mqgj9RgkKCEXFvAwMWDwGCMG93HIR/g2MdQAMLG?=
 =?us-ascii?q?A1IESw3Bg4bBj0BbgegYYg/km6EGo1La6EEhCWEb5xzBC+DcJNUFJJ9Lodlk?=
 =?us-ascii?q?GoiqGQCCgcGESOBWiSBXDMaCDCDIk8DGQ+OIYN6jz0BvFojNQI6AgcLAQEDC?=
 =?us-ascii?q?YZIiVSBSwEB?=
IronPort-PHdr: A9a23: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
 hJF9U5gT1XCdSyC/oyJGw==
IronPort-Data: A9a23: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
 E4bn1ew3l0=
IronPort-HdrOrdr: A9a23:6aYmIaq5k9b1bdPEf3D1WWMaV5r7eYIsimQD101hICG9vPbo8/
 xG+85rqSMc6QxhJU3I/OrrBEDuewKmyXcY2/hyAV7mZniAhILKFvAZ0WKd+UyZJ8SWzIc0vt
 YCT0E9MqyXMbETt6bHCWKDYq8dKbe8gcWVrNab4XMoYw8CUc5dBsRCZjpz0HcaeOCLP/QE/e
 Knl7V6TvObGEgqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3Aw7+mqWpNgpT/+OOEgYzXpkvmUZgKLnuC73n3H26?=
 =?us-ascii?q?bGHc2Qo2NFmHXxooxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AR2nh3Q2H/2kgtbiX0v/TkcwHijUj8oCiERwqrKg?=
 =?us-ascii?q?869jcMyFuJzuFiwmma9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="210044394"
X-MGA-submission: =?us-ascii?q?MDHexqVZqwmfJ6GROqiP+9PoNunHBfeU3zpLvx?=
 =?us-ascii?q?YvmJJIQ4PbbnMO+cIWEmkTKmI0+PYiox+voxPO+lWDw+YFrKJN3+VV5g?=
 =?us-ascii?q?aDI6e/ZR0h1WAil/xTFVJbBz6EyXR7+jVZ2MeEI/Yvn4iCHUiKz41Lmx?=
 =?us-ascii?q?V3rhV2tyIMu+/NDvNrY2ZnVQ=3D=3D?=
Received: from mail-il1-f174.google.com ([209.85.166.174])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 21:30:41 +0100
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3cfc8772469so19427965ab.3
        for <cocci@inria.fr>; Tue, 25 Feb 2025 12:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740515440; x=1741120240; darn=inria.fr;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLp9Ea62UroP9Hu5zCjkj8kz5zOw20u3Q4aJrEzL0tk=;
        b=FdMUfhr2U2/1yOkvObNn2Q1UCKA2cL7j831QKyIqz/xJC26XlHKP4/gKkqZTS367Sg
         ZLnRdIPwvNEMSYkSZrKVZ6ygF8ziQBjqmcLGPXHVxl+ikZnv1S/LLxmg9iZ/ceBPRbqC
         Ay+NBWKwTB2pm30hFZiuqJrvwPyXXqjC2UbiATpLeezpKMnZb21dnY8cYV/XbGsXXPcc
         VZqN/wexRCcKI99I8MkVrKGB91WbINzoZQoqn3jLwk0npxu7LLY/92kqMGtkoe9wFWFy
         K2qt5QHKeSFu23hdAm+XzdJZVqlaU9IHz70GuK6mRZUtjObc+3i/mCxucVqF9lBvSC9l
         6+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740515440; x=1741120240;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLp9Ea62UroP9Hu5zCjkj8kz5zOw20u3Q4aJrEzL0tk=;
        b=N9iheglrlof957zsxbeeyFEnW+QODmNhhHUlWamnfZeOiCNCgmhurSZ6Ueewnm/ncK
         hLYbm9tbDEmHuEmFlc84v1RKOkBsLJxHZxVY/DUV2lO1Eq9DTU4HqY3SXjT5uUEAeOLJ
         fIJoyWG7gr0BC2hm5Sq9/lnzbGr2JUm0NtQ+k0EbMSj0DD29AaTAIMDXxqSRwg/ZpmYm
         MS0BGxOswUgw/+l3yYZDt0YoFwjmk/axoEtd6hVni1121p8URStvWlmFAIt4lstEb/6R
         ABw14XkSxWQWri0X4gq0NAsZD4iiR2jdbJ+qi97k3UXdCG65YR++yTEFzpkcmqo4/avz
         9uXw==
X-Gm-Message-State: AOJu0YwpX47e5WOn156dXoljA5WJcDAw5ICEgaGZq28Oen7Mz8W4S1Mf
	ThEDMaUir8Bo9SRwzvZCzdkceXD0dCKuU+b6kSH6lNjEjj0kCJyOIYM0uCtchDE=
X-Gm-Gg: ASbGncvoV0qWWTzkhDVpCC9CG/eTLpTOhpzA3m4UzMEStsL0ZAkZSARiBYxoUIvTJJB
	zXM8ebwcCteV9+6auhlWrYooMSD/w6VZzKegGbsmPoTJSPTPyTNBc49heVVDJpbHMrFd+BQeyLQ
	SmvZGHYGmufmymX0F1Qm4SjIXjgxUp3XNLaIt+2i4TyfhSTmVgoXAuOxQkl20JDK65FBfPgJ67o
	0gWOV4XaCHhHEosv9BmAKu7mYON0ceGwJp6yguwRmgzbzKuWXdgnEkzvpzkF+yHHSfa+CJ45BWj
	rXcKK4nnJG7bNKtM
X-Google-Smtp-Source: AGHT+IEI1HpA9fGHJ1GdkYmfu92FscKbuH3o9L2lVKiqa4D5puwjeIXVc4djLm6mFSVg2XH039gtQg==
X-Received: by 2002:a05:6e02:b2a:b0:3d1:968a:6d46 with SMTP id e9e14a558f8ab-3d3d1f40415mr9808255ab.6.1740515439644;
        Tue, 25 Feb 2025 12:30:39 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d361ca3896sm4764255ab.53.2025.02.25.12.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 12:30:38 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
 James Smart <james.smart@broadcom.com>, 
 Dick Kennedy <dick.kennedy@broadcom.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Xiubo Li <xiubli@redhat.com>, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Carlos Maiolino <cem@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
 Selvin Xavier <selvin.xavier@broadcom.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org, 
 linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
 ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org, 
 Takashi Iwai <tiwai@suse.de>, Carlos Maiolino <cmaiolino@redhat.com>
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
Message-Id: <174051543709.2186691.13969880655903967909.b4-ty@kernel.dk>
Date: Tue, 25 Feb 2025 13:30:37 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] (subset) [PATCH v3 00/16] Converge on using
 secs_to_jiffies() part two
Reply-To: Jens Axboe <axboe@kernel.dk>
X-Loop: cocci@inria.fr
X-Sequence: 2452
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/174051543709.2186691.13969880655903967909.b4-ty%40kernel.dk>


On Tue, 25 Feb 2025 20:17:14 +0000, Easwar Hariharan wrote:
> This is the second series (part 1*) that converts users of msecs_to_jiffies() that
> either use the multiply pattern of either of:
> - msecs_to_jiffies(N*1000) or
> - msecs_to_jiffies(N*MSEC_PER_SEC)
> 
> where N is a constant or an expression, to avoid the multiplication.
> 
> [...]

Applied, thanks!

[06/16] rbd: convert timeouts to secs_to_jiffies()
        commit: c02eea7eeaebd7270cb8ff09049cc7e0fc9bc8da

Best regards,
-- 
Jens Axboe



