Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B6FC021B2
	for <cocci@archiver.kernel.org>; Tue, 25 Feb 2025 20:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:cc:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=CjdDB9uvZBBF3c03e9VylpCG5WkQPsjk1qSKlO3MQtE=;
  b=mWqoZrB9w0MPbBEP7VKACaLduON1uW808vyB+7gMih5B7LxzX6k3TJFc
   qVB0wI+2h3cQMnFirozbpcTSwHAdb6+sse9rmlouIkUBGgp7f9Ok9/KI0
   CurdBLWqly3NuQ+wfsp0d1oFfeVhWYF3ZTh1zAgqD9hfsz77DHfJ9XxJf
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.microsoft.com
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="210043612"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:27:58 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D2E02E0D1E; Tue, 25 Feb 2025 21:27:58 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0B56CE0260
	for <cocci@sympa.inria.fr>; Thu, 13 Feb 2025 18:45:47 +0100 (CET)
IronPort-SDR: 67ae2fc9_PjLfOhgzDkuK9KB1h8z630THeqauNkAeC+6s8qUxfNRkUMe
 THfgV7COB91BjGWjnrvsOM2GlJRYlOZLK0490cA==
X-IPAS-Result: =?us-ascii?q?A0FuAQD7Lq5nhbaaTQ1aHgEBCxIMQIFIC4JEfVozBwhIB?=
 =?us-ascii?q?IRSkXADi3OSIYFAPg8BAwFKBAECBAEBAwSFAAKLCgIfBgEEMAkOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEBQEmFew2CYgGBJFENSAEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBARECDV4BHwEBAQMREh0BATcBDwsOCgICJ?=
 =?us-ascii?q?gICVgYTAgEBgn4BgmQGAgydWwGHYAEBAosjgTKBAYIMAQEG3CCBZQMGgRoug?=
 =?us-ascii?q?WKGbQGFaxuEXCcbgUlEgTwOgnU+hFiDRoJpgjNKgSSDQKUCUnscA1ksAVUTF?=
 =?us-ascii?q?wsHBYEpSAOBESOBIwU0Cjc6gg1pSToCDQI1gh58gR2BDmoEBYErgjmEQ14vA?=
 =?us-ascii?q?wMDA4MyhViCEoFgAwMWEAGCMXB4HIUXNR1AAgELbT03CQsbQ59BATyEJjKBC?=
 =?us-ascii?q?TBJgVGSboNQAY4Ta6EEhCWMGJUzBg8EL5dXknsuh2SQaowLgXmaeYIYOoFcR?=
 =?us-ascii?q?gcjFYMiEzwDGQ+OIQwNCYNYhRPCLSI1AgEBOAIHCwEBAwmFRgEBinBqYQEB?=
IronPort-PHdr: A9a23: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
 w5wjwp1e+M28znwpVwwIwiTzBY=
IronPort-Data: A9a23:iiRSAaMthm2ZnunvrR0Dk8FynXyQoLVcMsEvi/4bfWQNrUok1mAEm
 DYaXz2Bb/uPMGOkf4p1b46zpkMB75eAm9NhGXM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8mk/vgqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvU0
 T/Ji5OZYQTNNwJcaDpOtvrZ8Ug355wehRtB1rAATaAT1LPhvyJNZH4vDfnZB2f1RIBSAtm7S
 47rpF1u1j6xE78FU7tJo56jGqE4aua60Tum1hK6b5Ofbi1q/UTe5EqU2M00Mi+7gx3R9zx4J
 U4kWZaYEW/FNYWU8AgRvoUx/4iT8sSq9ZeeSUVTv/B/wGX/fyXHgKRXLnocfrEK4dxLLVxPt
 ucXfWVlghCr34pawZq/S+9xloImLcLxO5gYtG0mxjbcZRokacmYBfqVo4YFgHFp1pom8fX2P
 6L1bRJiZRTJeRxPM38TCZQjjKGth3LldCZfpk7Trq0yi4TW5FUpgeC2b4KFJrRmQ+1HlViY/
 ViFzl6nLSACGsSUlGK3rF6F07qncSTTA9lISOLQGuRRqFma2WUXDDUEVF6xu/D/i0ikWtsZJ
 VZ80iEppqMz3Fe6S8H0GRy+un+N+BAGM+e8CMU+6QeQ2uzR4g2DAXMDQCIHY9sj3CMredA0/
 maFwfiqVAVNi5fWdWCGzIu4kDLxIidAeAfuehQ4ZQcC5tDipqQ6gRTOUstvHcaJYjvdRmCYL
 9ei83lWulkDsfPnwZlX6rwuvt5BjpzISBMloADWVXii9QR3eMiuYInABbnnARRoctjxorqp5
 SNsdy2iAAYmUcvleMulHL1lIV1Rz6zZWAAweHY2d3Xbyxyj+mS4Yadb6yxkKUFiP64sIGCyM
 RSD5FoMu8ELbBNGiJObharhWqzGKoCwRLzYugz8MIUVOfCdiSfbon4zPRLOgwgBbmB1y/lja
 czLGSpTMZrqIf88lmbpLwvs+boqzTo53mTdWdjwyA6/uYdyl1bEIYrpxGCmN7hjhIva+1+92
 4gEaKO3J+B3C7aWjt//qtVLdQhiwLlSLcyelvG7gcbTelQ2RjB/UKK5LHFIU9UNopm5X9zgp
 hmVMnK0AnKl7ZEeAVzSMi4xW6ClRptls3MwMAolOFviiTBpYp+i4O1bP9E7dKUuvr4rh/Nlb
 eg3S+PZCNR2SxPD52s8a7v5p9dcbxiFv1+FEBekRzkdRKReYTL11OXqRSbVzxlWPBGL7ZM/h
 5aCyjLkRYEyQlU+LcTON9Oq4VCDnVkcv+NQREL3f4BeUxjw+bdMOiaqqOEFJfgRGE+S2hqby
 AekLhMKrsbdo4IO0YfohILVi6yLAudBDk5hMG2D1omPNA7e5XiG7bJbdeS1IQDmS2L//Zu9a
 dVvz/3TNOMNmHBIudFeF4lH4L0f5dy1gZNn1SVhQWv2amq0BoNaInWp2ddFsotPzOR7vSq0Q
 ke+xclIC46WOc/KEE8jGyR9V76tjcorozj16eg5BG7Y5yUtpbqObhh0Dim20SdYKON4DZMhz
 eIfo/Up0g2YiCcxE9O4nytRpnWtLHsBbv0djaskIrTX0ygl9lITRqbnKH7SwIqOYNByIEUVM
 meqpK7dtY99mGvGUVQOTEbo48QMpK4zqChrzUADLWungtDqpOE69zwP/CUVTjZ69ARm0eVyM
 EdvKkFFKriEwDNqj80STWr2KVllATuH8HfQ0HoMrnXSFGOzZ1zOLUo8GOeDx18Y+GRiZQpm/
 KmU5WLmcDTyduTj93IWdW88jNK7Vv131AnJuP7/LvS/B5NgPAbU2P6/V1QHuz7MIJ0XhnSeg
 cJI4ewpS6nwFRBIkp0BE4PAiIghEkGVFldjH8Nk0rgCR1zHWTeI3jOLFUC9V+VNK9HO8m66E
 8ZeHd1OZTvvyBexqi0nOoBUL49WhPIJ4P8wSoHvL0MCsJqdqWNNm7DU/S7cmmQqYotPleAQF
 4DvTA+BQ1eg3SZsp2zwrcd/KjWZZ/sAb1bCx+ybyrgCOK8Cl+BOSnsM9IWIkU+bCjY6wCLMj
 jj/P/fX68dA1bVTm5DdF/QfJgesdvL2eue60CGylNVsdtrwbJ7DnF4Jo2bBLg4NG6UjXe1qp
 O7crP/2w0L3k7IkWE/Jm5S6Nvdo5OfjeMF1I87IPH1hsi/aY/DV4jwH4HKdBaFStdFguvmcW
 AqzbfWvee4vW9tywGNfbw5cGU0/D5vbQ7jBpyTnidixETkYjBL6Ke24+U/TbW10cjECP7v8A
 FTWv9es/tVpk5ReNiQbBv1JA45KH3G7YPEIL+bOjDi/CnWkpnigubG4zBop1mztO0m+Sc3/5
 crIewj6eBGMo5r39dB+sbFpnxgpHX140PgRfEUcxoZMsAqELlU6dMYTDZZXLatvsH3C5MmtL
 nWFJm4vEj70Ujl4YA3xqoarFBuWAusVfMz1PHo19keTcD27H56EHKAnzCp7/nNqYXH2+YlL8
 z3FFqHYZXBdA62FRNr/ItS/gOF61rXfx3kS/lv6ndC0CBEbaVnP/GI0BxJDDEQrDOmU/Hgn5
 0BsLYyHfK1/YUrwF9twPXtUEwsepzTh03MjaiLnLBP3pdCA1OMZoBHgE7ib71DABfjm4JYKR
 HXqVy2I4muM3WcUt7dvsNUs6UOx5TRnAeDiRJLeqcYuc21cJ4jp0w7uXcbCcS36xDNiLg==
IronPort-HdrOrdr: A9a23:4uAAxKPLRyUuZ8BcTvGjsMiBIKoaSvp037Dk7SBMoG9uA6ulfq
 eV7YwmPH7P+U8ssBNJo7q90cy7LE80mqQb3WB8B8bHYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 xdmupFebjN5DNB/KXHCWeDYrQdKZW8kZyVuQ==
X-Talos-CUID: 9a23:NnTirGHbMh4mjpQaqmJe+BA/WZEcUEb3j0vCOHWEJVtoC6aaHAo=
X-Talos-MUID: 9a23:waIhZgYLT53qquBTpTTyhGpYd/ZSvYufEG4VmsheiZeoHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,282,1732575600"; 
   d="scan'208";a="109037084"
X-MGA-submission: =?us-ascii?q?MDFMtiXimnoolaYtcsth1LBfp2hDt7dcA4tfJx?=
 =?us-ascii?q?WBEJpW+zWA1E0lm90OiQDteZxzCExijSkTXPtFIuDx4Lwe8AVCUDPiZp?=
 =?us-ascii?q?S2WniV6nStmkBd0whUTwUga3JDnYFg3H9bMnl8PWhT7/jcWtX6S5+yta?=
 =?us-ascii?q?bE+snxVKRUkT0mCCSavtdBbw=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 13 Feb 2025 18:45:44 +0100
Received: from [100.65.1.94] (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id D7186203D61D;
	Thu, 13 Feb 2025 09:45:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D7186203D61D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739468742;
	bh=CjdDB9uvZBBF3c03e9VylpCG5WkQPsjk1qSKlO3MQtE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=MqwOKrlM0wNKTlUgCtpn9gJKIpfGiwVh9dHGNNF4ycPmXa/idcQ30iiksOd4FJJaH
	 jrqNCD9r00CbzdjGOPFOZ+MnFU6woy29/+YEkOfP14iTKCcgK64o8pGQaLxlVNUpHe
	 bIb4sXQD9rr6g8CsvFcC34/zgx+kxX5/LItW+SLg=
Message-ID: <8f80b65e-724c-439c-a094-4bfbb1e296f1@linux.microsoft.com>
Date: Thu, 13 Feb 2025 09:45:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Yaron Avizrat <yaron.avizrat@intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, James Smart
 <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>,
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
 Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Selvin Xavier <selvin.xavier@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 cocci@inria.fr, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org,
 linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
 linux-rdma@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128161643.289d9fe705ef2fdba0b82a52@linux-foundation.org>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20250128161643.289d9fe705ef2fdba0b82a52@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 00/16] Converge on using secs_to_jiffies() part
 two
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2429
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/8f80b65e-724c-439c-a094-4bfbb1e296f1%40linux.microsoft.com>

On 1/28/2025 4:16 PM, Andrew Morton wrote:
> On Tue, 28 Jan 2025 18:21:45 +0000 Easwar Hariharan <eahariha@linux.microsoft.com> wrote:
> 
>> This is the second series (part 1*) that converts users of msecs_to_jiffies() that
>> either use the multiply pattern of either of:
>> - msecs_to_jiffies(N*1000) or
>> - msecs_to_jiffies(N*MSEC_PER_SEC)
>>
>> where N is a constant or an expression, to avoid the multiplication.
>>
>> The conversion is made with Coccinelle with the secs_to_jiffies() script
>> in scripts/coccinelle/misc. Attention is paid to what the best change
>> can be rather than restricting to what the tool provides.
>>
>> Andrew has kindly agreed to take the series through mm.git modulo the
>> patches maintainers want to pick through their own trees.
> 
> I added patches 2-16 to mm.git.  If any of these later get merged into
> a subsystem tree, Stephen will tell us and I'll drop the mm.git copy.

Hi Andrew, I don't see these in mm-nonmm-unstable. Did these get dropped in the confusion around
casting secs_to_jiffies() to unsigned long[1]? That has since been merged in 6.14-rc2 via tglx' tree,
and I have a v2 for just the ceph patches that needed some fixups at [2].

[1] https://lore.kernel.org/all/20250130192701.99626-1-eahariha@linux.microsoft.com/
[2] https://lore.kernel.org/all/20250203-converge-secs-to-jiffies-part-two-v2-0-d7058a01fd0e@linux.microsoft.com/

Thanks,
Easwar (he/him)
