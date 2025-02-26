Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED49C282D3
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:in-reply-to:references:message-id:date:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=bNT3SqYbucAlR7qbMunpmZCuKttGP2Nc5+3c81hKZzI=;
  b=a+KLgIvpbu/gZM4udLM2LN2oUHtul1q2YcPrFzh8TV8XC+uesHxLFneh
   flrjmRP00xvQ5oScQEPq2jydoqNA4b41pTq1K+6Y+B+GSX/yjfskPjk7h
   H0YX4tpvuCX5+mPzHvQwvNPhamB4GbovwOs2VU9Xh9W8HI3iE+eOR9oQS
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211070342"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:59:19 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A5C9AE177F; Tue,  4 Mar 2025 10:58:47 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 26FDBE0260
	for <cocci@sympa.inria.fr>; Wed, 26 Feb 2025 17:48:24 +0100 (CET)
IronPort-SDR: 67bf45d7_5B89ph+VPYuCul7xiPqf3R5k6DVXCNzembxBkQCE8s6KQGL
 +paU2iTPOxGT0d7oIjR5/uIs34vVvk+nl5+T2Lw==
X-IPAS-Result: =?us-ascii?q?A0EEAABkRb9nj9lUsotaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYJDfVozBAtIhFaIHV+GU1wBBoE+A4tzkEuBVoF+DwEDA?=
 =?us-ascii?q?Q05CwQBAQMEhQACixICHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQEBAQEBOQVJhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDX4BA?=
 =?us-ascii?q?QEDIx0BATcBDwsOCgICJgICRhAGAYMUAYJkAxEGsEuBMoEBggwBAQbeBQMGg?=
 =?us-ascii?q?RouAYhOAYFsg38bIINCeicbfYEQgUeCeD6CQweBVwEBNYNGgmmCM0qBJIFUg?=
 =?us-ascii?q?WqGUYcGmkIJPwp7HANZLAFVEw0KCwcFYQNFEDgDIAoLDAsSHBUCFA0QDwYQB?=
 =?us-ascii?q?GoFNAo3OoILaUk6Ag0CNYIeJFiCK4IdgjeEQ1wvAwMDA4Mqgj9RgkKCEXFvA?=
 =?us-ascii?q?wMWDwGCMG93HIR/hAsdQAMLGA1IESw3Bg4bBj0BbgegRz2ECHJaHwQiNgSBK?=
 =?us-ascii?q?A8fGCuSQ4QajUuMXpURhCWEb4cplUoEL4QDjQcDhjeTES6HZZBqIo1jmyuBZ?=
 =?us-ascii?q?zqBXDMaCCgIgyJPAxkPWI1JGYh0iioBuypDNQI6AgcLAQEDCZAcgUsBAQ?=
IronPort-PHdr: A9a23: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
 d8=
IronPort-Data: A9a23:f51+WqIv7Qa6CVWNFE+RUJElxSXFcZb7ZxGr2PjKsXjdYENSgz0En
 2AcWGyBbPrbZ2r1eN4gb4jk/BtS6pfVzYVjQQMd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6j+fSLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWBfgb+s9JIGjhMsf/b8kkx5K6aVA4w5zTSW9gb5DcyqFFOVPrzFYnpR1PkT49dGPKNR
 uqr5NlVKUuEl/uFIorNfofTKiXmcJaKVeS9oiY+t5yZv/R3jndaPpDXmxYrQRw/Zz2hx7idw
 TjW3HC6YV9B0qbkwIzxX/TEes3X0GIvFLLveBCCXcKvI0LuY1/I8vptAkEKZogV5OB2PFx/x
 6A7EWVYBvyDr7reLLOTRudzwN8kMdPgMcUct2tmwDWfCuwpKXzBa/yRtJkBg2d21pwIR6+BD
 yYaQWIHgBDoaQdIPVEWBbo9kf2ui325dCdXwL6QjfBuuzKKnV0pj9ABNvKSI8CsT+BxmX2Iv
 z/41HTYOiMYc962nG/tHnWE3bKXw3OkAer+DoaQ8vd1iVmX7n4SDRcMXB26p+O4gwiwQbp3I
 Esf8SsGtrk37EXtT9/nXhT+rmTsg/IHc9ZeDKsh7xyXwaeS4AuDAGUACDlbZ7TKqfPaWxQ68
 nu4kNDnBQA0tbCLT3Ogy4am8RCLbH19wXA5WQcISg4M4t/GqY41jw7SQtsLLEJTpoOqcd0X6
 27WxBXSl4kuYdg3O7JXFG0rbhqgqIePVQko/A7aGGGo9AV0YMiifYPABbnnARRoc9rxorqp5
 Slsdy2iAAYmUc7leMulHL1lIV1Rz6zZWAAweHY2d3Xbyxyj+mS4Yadb6yxkKUFiP64sIGC1O
 BKL6VgPucIIYBNGiJObharvW6zGKoC+SbzYugz8N4oVCnSMXF7dpX82DaJu9zywyhdEfV4D1
 WezKpv0UyZFUMyLPRK7Xvoc1747jjsz333STp3ghxWh2vz2WZJmYeltDbd6VchgtPnsiFyMq
 753bpLaoz0BC7eWSneMruYuwaUicSNT6Wbe95cPLrbrz8sPMD1JNsI9Npt4ItA0xfkOy7mXl
 px/M2cBoGfCabT8AV3iQhhehHnHBP6TdFpqbXJ+DkXiwHU5f4ek4YEWcpZ9L/Ft9/VuwbQwB
 7MJctmJSKYHADnW2SUvXb+kpqxbdTOvmV2vOQiha2MBZJJOfVHC1eLlWQrNzxMwKBSLm/Ewm
 YD96TODc6E/H1xjKO30dMOQy0iAuClBueBqAGrNDNphWGTt14lIMR7BrOIFHN4RI07hwBqby
 AekLhMKrsbdo4IO0YfohILVi6yLAudBDk5hMG2D1omPNA7e5TCF06JbdeS1IQDmS2L//Zu9a
 dVvz/3TNOMNmHBIudFeF4lH4L0f5dy1gZNn1SVhQWv2amq0BoNaInWp2ddFsotPzOR7vSq0Q
 ke+xclIC46WOc/KEE8jGyR9V76tjcorozj16eg5BG7Y5yUtpbqObhh0Dim20SdYKON4DZMhz
 eIfo/Up0g2YiCcxE9O4nytRpnWtLHsBbv0djaskIrTX0ygl9lITRqbnKH7SwIqOYNByIEUVM
 meqpK7dtY99mGvGUVQOTEbo48QMpK4gmh5wyH06G2+ogfvA3/8+4w1Q+284TyNT1RR27NhwM
 WlKaWxwOaGF+mpsjuMeQWupEABlLz+a83zX1FEmujD4TU6pd2qVN0w7G7+H0344+lJmXApw3
 e+n2le+dA31befN3icWcmx0mczJFNBe2FXLp5G6Ip6jAZI/XwvAvoavQmg58z3cHsI7gRz8l
 9lApepfR/XyCn8NnvcdFYKf6LU3TSKELkxkRdVK3vsAPUPYSQGI9Qm+EWKDUeITGKWS6m69M
 dJkGexXXRfn1CqukCESNZRRH5BKxswW9PgwUZK1A1UZsomvjCtj67PR0SncuFUFYftTleQFF
 4eAUA7aT0KxgyNPln7vvft0HDOyQeM5aT3W2MG39+Q0FKw/jtx8THFq0pWIkiWUFCBF4yOru
 BjyYv6K7u56lqVpsYjeMoRCIASWKuH1X/mDqlHquNFoaffKLcPFsl4RoHK6IQ9TNro1cPZ0n
 ISrr9TY8h7kvrE3cmaBgLiHNfBDyvuTVdptEPDcDSdljxrZffTz8j0/+2ycAr5YouN3v8WIa
 VOxV5qtSIQzRdxY+kxwVwFfNBQsU4LMcabqoHKGncSmUxQy/1TOE4K6yCXPc2peSy4vPq/+A
 C/Sv9KFxIhRjKZINS8+K8BWOb1KC369ZvJ+bPz0jyeSMUewiFDburfCqwsp2QuWNla6SvTF8
 bD3bTmgUi+tuZP47sBT6K1zmRw1MExTo8cNemAlxtonrAziUUAnK70RP6xTX9sQ2mb32Yrjb
 T7AUHo6BG+vFX5YeBH7+5L4Uh3ZGuUKPczjKyc0+1+PLR27H56EHKAr4xIID62aodc/5LrPx
 RAiFnzM0tyZzp92A/0U++awjKFky+ncy3ZO/lry+yA379DyHp1SvEGN3iIUPcAELy0JvEbGP
 244QSZDWk7TpYvZD5N7Y3AMcP0GlGqH8tjrBBtjBP7ctp+dwekGz+fwUw02Pnvvc+xSTIMzq
 bjLq6dhLoxYNrH/eUfkhj7xvZJJNA==
IronPort-HdrOrdr: A9a23:YB0vEqrd4DIutGcZBTdc7FMaV5oueYIsimQD101hICG9vPb3qy
 nIpoV86faUskd3ZJhEo7290ca7MBbhHPJOjbX5eI3CYOCEghrNEGgd1/qB/9SIIUSXnYRgPO
 VbE5SWY+eAbmSS4/yU3ODBKadY/OW6
X-Talos-CUID: =?us-ascii?q?9a23=3ArW0UgmjAFk9+JtiocKMoG1gRJTJuYln5/XjTLU+?=
 =?us-ascii?q?EUmNkVruUdGKhyv9Hqp87?=
X-Talos-MUID: 9a23:QNfV8Qku0G8zn897B/8ldnolbdtO6YGKD3sdiMg4kNmlDR5yfDW02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,317,1732575600"; 
   d="scan'208";a="210219907"
X-MGA-submission: =?us-ascii?q?MDHPIH7dVDk9xu7r/cXROj/pNHIY4iuIQPilQF?=
 =?us-ascii?q?KIjRU5+Jq2RB1pxdQImUnwTh1ygKDtZVzyQCaf+NCxFaW+r1fVv4pAjX?=
 =?us-ascii?q?jNtxi88DM2cCrBCzlSlVNf8x+dvhFH772wIF1nXkq0fAEZtk1Td18BHS?=
 =?us-ascii?q?gVXTETAlBjBPeHyvbmHH1hHw=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 17:48:23 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8EAC05C729C;
	Wed, 26 Feb 2025 16:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F78BC4CED6;
	Wed, 26 Feb 2025 16:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740588501;
	bh=FxcvaHDtQk+aPNgLOpA1kKCuwEvZ/n4I9xwMBDMNjMM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gJBntMAWa9qiB6go6MBAYuIpUQmIV8zM3P7hOz/BcMP2byX2P+MCVmwTOF8y59cTA
	 /dmsi2YnkvFk7WCs/BqmuQVZJqyuuK6B2L34n/nlGh5Fb/IjbLtuJF7xfHrd7ckNHI
	 3aOmoTcDg9MwCwDV+lRzSbk3kKgtk7sY2T2rRnxcQXeSOKkWWTO2TN5iDQ7y45VEK4
	 FrA2VRbWMMiI+WJDNW4z9L9r47+ekdDK20fY6zi5lQvVIKVd30Jsj0qJQM2+iV2vYy
	 04RjgTb6SA4Au/0pUEMYaZh350XZsbrokrKevACKRy5XTZGyf9486J5GRsNNv9vMzQ
	 71NtfIvQwN7Lw==
From: Mark Brown <broonie@kernel.org>
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
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>, 
 Xiubo Li <xiubli@redhat.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
 "Darrick J. Wong" <djwong@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Frank Li <Frank.Li@nxp.com>, 
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
Message-Id: <174058848717.58970.18340675342808865020.b4-ty@kernel.org>
Date: Wed, 26 Feb 2025 16:48:07 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] (subset) [PATCH v3 00/16] Converge on using
 secs_to_jiffies() part two
Reply-To: Mark Brown <broonie@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2524
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/174058848717.58970.18340675342808865020.b4-ty%40kernel.org>

On Tue, 25 Feb 2025 20:17:14 +0000, Easwar Hariharan wrote:
> This is the second series (part 1*) that converts users of msecs_to_jiffies() that
> either use the multiply pattern of either of:
> - msecs_to_jiffies(N*1000) or
> - msecs_to_jiffies(N*MSEC_PER_SEC)
> 
> where N is a constant or an expression, to avoid the multiplication.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[12/16] spi: spi-fsl-lpspi: convert timeouts to secs_to_jiffies()
        commit: 32fcd1b9c397ccca7fde2fcbcf4fc7e0ec8f34aa
[13/16] spi: spi-imx: convert timeouts to secs_to_jiffies()
        commit: 1d2e01d53a8ebfffb49e8cc656f8c85239121b26

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

