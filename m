Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8252DC0218A
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 21:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=3umHLMGrcLo5C0gV5DfFSpcRm6HAQK73Bd3Y1mC2uB4=;
  b=gT2OClyC7p9GlZk/4I3gr2KgpwOJ/G06KpVUIPafuoTjbMdWR529O+i4
   SfcTgilDzCqz+Cz0oiuywUg4OEBSIVtgrgXVf0RxnRwSzrRxp26kQiFBg
   C4oof6165KYRNnbNgwZT2rMJFp4APbv2laFNNZfNosn89YiDak8YJ7meB
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205461077"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 22:03:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9C7DCE0D1D; Tue, 28 Jan 2025 22:03:31 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3EB91E00A5
	for <cocci@sympa.inria.fr>; Tue, 28 Jan 2025 22:03:26 +0100 (CET)
IronPort-SDR: 6799461d_TOSH1q1jW5kKYJ7D6Z9y65tCfsTtXhlZG2CJ73x+pfbaaaA
 CTew521irCNC10UV/V5/O4uIqeOAeckZT1Kcjbw==
X-IPAS-Result: =?us-ascii?q?A0GXAgCURZlngAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UAGAQELAYJDYnUzBAtIhFaPT4F0MIQ7hzuHVoh2gVYUgWoPAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEggyCdAKKdQIeBwEEMQgOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABATsHDgoxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdA?=
 =?us-ascii?q?QERJgEECwsODAIRFQICVgYBFAEBgn6CMAEDDiMHtHyBMoEBggwBAQbaWx8sI?=
 =?us-ascii?q?leBZAmBGi4BhWqCYwGFazsJgzl6Jw+BVUSBPAuBCYFvPoN8Rz+DHIJpgjOBD?=
 =?us-ascii?q?4IOgS9nhzWFd4IWJXuFVQQRWmyJFlJ7HANZLAFVExcLBwWBKUgDKjYxI4EmB?=
 =?us-ascii?q?TUKNzqCDWlJOgINAjWCHiRYgitrBAWBLYI7hEVgLwMDAwODNoVbghSBZQMDF?=
 =?us-ascii?q?hABgyd4HIIYHUACAQttPTcJCxsGPZ4ahD+DHB6TDoM7Aa9MNAeCOIFmgWMMn?=
 =?us-ascii?q?1wGEy+XRA4Gknsuh2SQaiKjPYVOgWkDNYFcMxokgzZPAxkPjiGELclDQjU8A?=
 =?us-ascii?q?gcBCgEBAwmFRgEBil2BSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:yPXGOKz5kUWoZfcGXkF7KrPw+L1zdoMgy1knxilNoNJuA6+lfr
 OV7ZAmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFeb/N5DNB/KPHCWeDc+oI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:I0zvCG1iYI5MpmI9nabd47xfO+o+a3nW5k7sf2imD2BmEYSwag+9wfYx
X-Talos-MUID: 9a23:+Yj1PwYQG10VpuBTqgSwp254KMtR7eeLAVsiq7hfvpOrKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205461076"
X-MGA-submission: =?us-ascii?q?MDHVOZfGdooRo5SXnLni4pVayyN5gSPi6U6coq?=
 =?us-ascii?q?nB+wo55qjx8xBGx11W4yuSD3W0/ffsF41CggOMYnqXt73+hBRfQSAnrQ?=
 =?us-ascii?q?WJ4XG8xU5p8JM2x+upPsXD/Cny1iBrHCIzrMa28fNSfxGSkxj2+DxfxR?=
 =?us-ascii?q?iYtVhqBVNKe48+l8/KtbMvHA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 22:03:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738098159; x=1738702959; i=markus.elfring@web.de;
	bh=3umHLMGrcLo5C0gV5DfFSpcRm6HAQK73Bd3Y1mC2uB4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lugd+JElfIBEVWJEly/xpiC37xATW6N6QL/mFXzaImqmdRiGu9El4suaNDc5SBIJ
	 f7yuPAtB4XVuylj3u7G5BczelJ5/emDxHQ30PDVNcC9rtRKBhqRseJy6OASoL+Iq9
	 ArcQ3FyUW9yd6zl6HvZ2Xlf0WV4HKCmnClbV719vvUnC+rm0ypbfdtPwsGGbVAZnj
	 WkCAfzZcvm0TYZkxsVNFrodDO6tQZu6OcvhdWzOTgMDymVvgzqDR+mTdyiZV8tA4+
	 QU/te2bbCzVTLcIj2amNj5TwWzdApX4spmArstqfs3lmriJ7U+3XkJ3feVPqxmnLX
	 mxBXcCqystTm/wZ5ww==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.40]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mi4z5-1szA8E0tNZ-00bwwr; Tue, 28
 Jan 2025 22:02:39 +0100
Message-ID: <565fb1db-3618-4636-8820-1ca77dad07a2@web.de>
Date: Tue, 28 Jan 2025 22:02:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Easwar Hariharan <eahariha@linux.microsoft.com>, cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-xfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 imx@lists.linux.dev, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org,
 Andrew Morton <akpm@linux-foundation.org>, Carlos Maiolino <cem@kernel.org>,
 Chris Mason <clm@fb.com>, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 David Sterba <dsterba@suse.com>, Dick Kennedy <dick.kennedy@broadcom.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>,
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 James Smart <james.smart@broadcom.com>, Jaroslav Kysela <perex@perex.cz>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
 Josef Bacik <josef@toxicpanda.com>, Julia Lawall <Julia.Lawall@inria.fr>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Ilya Dryomov <idryomov@gmail.com>,
 Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nicolas Palix <nicolas.palix@imag.fr>, Niklas Cassel <cassel@kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>, Ricardo Ribalda <ribalda@google.com>,
 Sagi Grimberg <sagi@grimberg.me>, Sascha Hauer <s.hauer@pengutronix.de>,
 Sebastian Reichel <sre@kernel.org>,
 Selvin Xavier <selvin.xavier@broadcom.com>, Shawn Guo <shawnguo@kernel.org>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Takashi Iwai <tiwai@suse.com>,
 Victor Gambier <victor.gambier@inria.fr>, Xiubo Li <xiubli@redhat.com>,
 Yaron Avizrat <yaron.avizrat@intel.com>
References: <20250128-converge-secs-to-jiffies-part-two-v1-1-9a6ecf0b2308@linux.microsoft.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-1-9a6ecf0b2308@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iHXXXI1GgZe21qv8LaB36WZ2Vsbh+30ctHdeuhjL58pow7ObI/n
 WkL1BRfcGc3xPTE7WTH/8blOzYTn9sr9kmiu0JlwbK+4b714M1NEuSxTjO0wec15e2/vSDy
 uDaoXgXEnc15+k7LwhSrDlieAakHXlujaBdoTKMERuZeGqcF/lr7wB/BevoNLo+FU7wzIqQ
 aOajvgo+YHQHBAbcH9fBg==
UI-OutboundReport: notjunk:1;M01:P0:rl1+EWWMtaU=;EqS9WTtqlVexMZSa5Jv6osEpxMn
 hvF5ExxFi69MshCqN0iCQJ9CsPgR4dRizBjf15Nun4PB2G1xVTkt8gPKouGwCsVTv8Wm+WqU2
 TfM0O0GAReZpmFXq82LdrG2sTl+5GS7MW/XeczWoOvfmlQZGUTxAeiabHe982tQ5sjQ7pvBjj
 b6JYk30LAwHaptKVJlAyYDTQrNqQmKm1fInHh1R0BqLWD7yAbmIhzOgsGDyapCyRzZ/6L58Kd
 qMLJCmj8kp6OcGrtC6qyfn6vENJ3sKXUzDCjeFjZsblLj6AZqVFqPaGkr3WDBvgVlzknwCsuL
 dTDBwwDzhXWZDpsnaBHnS8iI6b9y60B0/WwOzfqaZ2vol6lFD69SHUFtYn0ZgHvwiCZm9xktA
 JWX2pS3My9yJ+hVoYQ8Roh/du8QDa/Pm1AN3y4siXvV4Vd2p4r7avPuVYF89xPfhqeOiCUyim
 74txrmxIhNJtDI2TJ2SHQYS2r1gUY8+ioCwT2SsVmzxEdV795ccbiiKzw3KT1teQ1CRIhkeZF
 k+me759e21qqFhzCA+W+kKa3oNrQvnrx3MFGbr/WoIwLxlyqLG25aVhqwuWvn7yyDaFQ60QKw
 tMPxLX6+iV8IWzhIUyb4CtEkcgWiVVNm59osGitJw6HZJgsmDNDR4zs4DWL+Q5VGOpmwSVC0x
 Q+nvkt0/jEV6wgWG8uEad4c+rNAUrw9rtdYU5HViYfJzdE2v/knRfZBUzOkgi6O5iMZtJ3Lxi
 rKMYnBh+OfDHRaOKzTHuD/jxsBh2wri3J7QnuWvzCczLpsppJHq+CGdZvNevnxIcUGmYGqYZs
 K5WU8xokNX6ip+Z6iQRZjHliRbfF3LPa1bz58C8lLJ8UJMr2uicwiVhyCmJXfhfnTsF1UEjV3
 2Bjsxn/TOrbOtdszIeVMV7ChLFk0OwufgZxaGxw/3gOyHaPOUZ3Mz/eBUr3BiSQtFPFl4bvd4
 GwFqEoazTKVX6f87q5CL/ThpkFTHi+muon/dhBj6NFEXz0Vk7JlO2YBAbv+PnanDfW0BCvaKH
 DuZIBZebVIcC++l0MdC0iSdO+kNr3TXnRpRd2Pyhqn0qD+C8W+jzV6x520UF9whVDkCQlAjr8
 R1OTygelS4A8CdLcvmF1P6DSPVs1dfnOMm4gzJp4/NcmbxhgSRgtg23Df90/CTB3FnVaeTOWC
 m6owGzbKvieq3OLAkE+SPXE4/jRQF+NmzzaRCayhBpQ==
Subject: Re: [cocci] [PATCH 01/16] coccinelle: misc: secs_to_jiffies: Patch
 expressions too
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2293
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/565fb1db-3618-4636-8820-1ca77dad07a2%40web.de>

> Teach the script to suggest conversions for timeout patterns where the
> arguments to msecs_to_jiffies() are expressions as well.

I propose to take another look at implementation details for such a script=
 variant
according to the semantic patch language.


=E2=80=A6
> +++ b/scripts/coccinelle/misc/secs_to_jiffies.cocci
> @@ -11,12 +11,22 @@
>
>  virtual patch
=E2=80=A6
> -@depends on patch@ constant C; @@
> +@depends on patch@
> +expression E;
> +@@
>
> -- msecs_to_jiffies(C * MSEC_PER_SEC)
> -+ secs_to_jiffies(C)
> +-msecs_to_jiffies
> ++secs_to_jiffies
> + (E
> +- * \( 1000 \| MSEC_PER_SEC \)
> + )

1. I do not see a need to keep an SmPL rule for the handling of constants
   (or literals) after the suggested extension for expressions.

2. I find it nice that you indicate an attempt to make the shown SmPL code
   a bit more succinct.
   Unfortunately, further constraints should be taken better into account
   for the current handling of isomorphisms (and corresponding SmPL disjun=
ctions).
   Thus I would find an SmPL rule (like the following) more appropriate.

@adjustment@
expression e;
@@
-msecs_to_jiffies
+secs_to_jiffies
 (
(
-e * 1000
|
-e * MSEC_PER_SEC
)
+e
 )


3. It seems that you would like to support only a single operation mode so=
 far.
   This system aspect can trigger further software development challenges.


Regards,
Markus
