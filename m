Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330BEC021B8
	for <cocci@archiver.kernel.org>; Wed, 26 Feb 2025 11:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=sTX8xi6LRWxYofvmbcRQIPwzk4BhNjim5Kc1TZCgi5I=;
  b=WCpyj/mclFTQvzSP7U4LPQsWe7Lx+/3yk6o6MRCE62j0W3ruUHIgcFb2
   ZYZCUf1H1TGUKFaubo7FsWAv48FAajUCXahNMIs2vYZvjLPhbQZN7QLBT
   xo+7sDCSyqEwLnHwwlrRUbUhJ89DSq+TYneAzrmboOnr/tEXAvd/yFFY0
   A=;
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
X-IronPort-AV: E=Sophos;i="6.13,317,1732575600"; 
   d="scan'208";a="210157124"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Feb 2025 12:56:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D30DAE0D1E; Wed, 26 Feb 2025 12:56:46 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 522D1E0260
	for <cocci@sympa.inria.fr>; Wed, 26 Feb 2025 12:56:45 +0100 (CET)
IronPort-SDR: 67bf0175_th9LcIFekFdMNu1VeFEHsDNfu4Glho3mhoKp5BEAuvEm4D7
 XP5c7BdQPV20Y7epiU4jP5E7LO6jPrUDh0IsYWA==
X-IPAS-Result: =?us-ascii?q?A0HiAwDcAL9ngwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAQGCQn1aMwQLSASEUo9PgXSEa48OiHWBVoF+DwEDAQ09BAECBAEBA?=
 =?us-ascii?q?wSFAAKLEgIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABAQE6Bw4KMYV7DUkBEAGCBwGBJIEmAQEBAQEBAQEBAQEBHQINOkQCAQMjH?=
 =?us-ascii?q?QEBESYBDwsODAImAgJWBgESAgEBgn4Bgi8BAzEHDbAKgTKBAYIMAQEG2lwfL?=
 =?us-ascii?q?CJXgWUDBoEaLgGBYYQKgmMBhWs7CYQzJw+BVUSBFSeDAz6EQ4NbgmmCM4RFZ?=
 =?us-ascii?q?5oPjgJSexwDWSwBVRMXCwcFgSkQOAMgCjQUHQIUDRAPBhAEagU0Cjc6ggtpS?=
 =?us-ascii?q?ToCDQI1gh4kWIIragQFgSqCN4RDXC8DAwMDgyqCP1GCQoIRcW8DAxYPAYMfd?=
 =?us-ascii?q?xyDUYEuhAUdQAIBC209NwYDCxsGPaE1PYQ8gTuCH5MZsyA0B4I4gWaBYwyKK?=
 =?us-ascii?q?ZU1BhMvhAONB4Y6DgaSfS6HZZBqIotqgXmbK4FuDiWBXDMaJIM2TwMZD44hG?=
 =?us-ascii?q?YQUhGCKKgG7GkI1AgE5AgcBCgEBAwmFRgEBiGGBc4FLAQE?=
IronPort-PHdr: A9a23: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
 6U0nqufYUfLOWaNoYa5Tj4=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:pU4+HK5YXs1t6gS+8APXwBzXdLJyesId70hD6qm+c20zTiXqrb
 HKoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWYtKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkdNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:VLjfXm/yF4VVao6pbK2Vv1EOP9l+SSzR91P7I229GT5VbrDLTXbFrQ==
X-Talos-MUID: 9a23:56vWhwnWNU/H+hv0T+DIdnpaDOh6yqb+DnwCros3qY7fDSVyfBak2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,317,1732575600"; 
   d="scan'208";a="210157112"
X-MGA-submission: =?us-ascii?q?MDFwO8aB+hfOnAX6biZkP8tFOKEZDk+KVONKYC?=
 =?us-ascii?q?P/+LyAV4pxRBEd1AhAFODJ0+hQ7ww1MK8wnlJ7//UY7vyLJpE81451xa?=
 =?us-ascii?q?b7U7bbBeiJ4NkQ6u2i3X6LeeJe1cwoqrxngvFsRyioYvQ/zLNxpzOvHF?=
 =?us-ascii?q?eYSPpkoDy1WB//f/1RYEmNFw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 12:56:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740570931; x=1741175731; i=markus.elfring@web.de;
	bh=sTX8xi6LRWxYofvmbcRQIPwzk4BhNjim5Kc1TZCgi5I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FgF5BQbol86RnWL2Sk24p7qdL5tQLOeT6f07Kvxk4P0VuErz4WgTRL7pn6j/9HBZ
	 z+cak2KgFRXeyXt7h/+BTqXGvv0hTXqqct+9+hLjPcNj3botKQ3pCtj1zGcH4ifEh
	 yFa3sBuphYKHeZZwVQaSV3wyFrLsvWanJ3Z6ukLmBSFQ8+HjJKTN807sEt43aEoUg
	 HbB2HsK30RgebgKAq9z+FLUxZ7GFREklxLf4JkReYQU8HhTTePiNS5BpbM3Q4Iq3/
	 /8xzXq7fVNqYLas56fa9vFIZ5anQ0OIXKnqjBE+M5zkQbuCHIU124L0CnFIHiM9E2
	 ngho7wBag929Q1fQLw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.43]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M604f-1tfrLt2zXv-00E5Ph; Wed, 26
 Feb 2025 12:55:30 +0100
Message-ID: <5495665a-774b-4bc5-8eb2-a9680d09b0be@web.de>
Date: Wed, 26 Feb 2025 12:55:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Easwar Hariharan <eahariha@linux.microsoft.com>, cocci@inria.fr,
 Andrew Morton <akpm@linux-foundation.org>,
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
 Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Selvin Xavier <selvin.xavier@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
 <20250225-converge-secs-to-jiffies-part-two-v3-4-a43967e36c88@linux.microsoft.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org,
 linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
 linux-rdma@vger.kernel.org, kernel@pengutronix.de,
 Takashi Iwai <tiwai@suse.de>
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-4-a43967e36c88@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ucYXuYgBQVTEWaObV/mFjtsvpzQ/KO5i5l5ZjdohfyGQ4hlxvcY
 sTVdlsTl9fld7Rgr2WyDph9nJLEmgybCGSVtuMLyhQK485ALORk88bsJZJIOfByFUNZedr7
 Tig7GhQucLbNWxtaLBapV3p7oWArgHdIII/eRzvvtip6IPoz+StdW8P4rzipPjdrxqJNq7V
 w9kH46OLKD2fAu1DJ4I4g==
UI-OutboundReport: notjunk:1;M01:P0:NqOsrw7wXz4=;wwgFpUfWgrNKqonaHrxuK0zBMVo
 mDjqDBwUTGC2TEakQ0FQpQb+jPeq8+VUsHA9FysNiUMcu9jvRYzUnVW/cePngei1HuxUi+9jB
 gzwpaGWWDjDgiqloN8NkKw7fK1k9aiq9WO2QV+FahFVJxKCiEOht1QwMKGQlNmk9KSfqrx+xY
 /ZLupqHBoI8IrXEf4BLPHHel92dIDpHQKboSzjjYqqe+D17jNVvkdG6fNPyA61KaW3VNs4cNO
 VvTz7objQwY3sXV9VVKfi5xn57PHN9mTjtQuIqd+Fkmo2WDIvSm1qZXwIHn3nMByQ+tt7svzC
 Q8spwoR/tPpS2RHogJczvjm/AJwifCv3M4zmOA7P6thgwODVRmcvR/4vF01uKQLuK9qMgFlyc
 bcgjRUxbqZme7tOe+3/skv2xiRyQEbhJKJtGN5D+YuDiSWxugE0waVrKszeAKPmktude+e3Wm
 hb6pdZnYZCt8B9GbDEP5Vb/mlwKymujzJht1qssYcn8d3Ml1SMkSc3vuwSRHDX6T7apEaslxL
 H1ldZBfcHAqqxfpa5LbXdHASW4m4p3H0K1hJHORXZqCUnOEcZxDWNffnSEspRVYifgrFqGv4y
 Kj26KhRIVUoBKuigt9Q2mdl8jTmWXytY3VzlUIiR7tUQHVdIIbUdCyTnywoOmuD6VO0yepr5x
 bLQ4dW/TIsHMfmgenog//zbU7q2CO3bneqDQJPNt+SnDmx59ilBfNjed2YgZwvn4cQlSdaI0L
 F6NIFthjhreE3/Mi2NLvYEGxVUZoOMS2U7r5bxeagKeTc2gxxXa1GQVKaGa4DKQrDpFctrZO+
 VgS1EfusE5lk8m0igJwjGV8T5jJ4yK8zBmXHUgf2B7xsqbzIVsymf73VTGRYna5d8fpSlwFol
 Z7qd+KqzL47eifD09GmZjoE4UJBGc7zuzHDS6dRLZAuI/Zl84ps/Ym32YxhbN/YAsutAmmp+v
 TOkjv6MdafHxETdnQKdh/rPigxuHdcazx7XB6EEgDKbDg3iSQfzRgSR4xQ4NJ8AZ2iLg0mWum
 0vXgI8wXv34gMt9O2p3er2RQWDsVcZ08cX04PIZdsztxTjwu0CPkBaXXuUyTd+ZnGMu5xuqJ6
 NVigR36nr3N2Z8mQFMK5WqrimZH+EH+M90+yC79G0/T7t0PPocKOZnJL41HJTo+LovTIveleV
 HWrp9ctFsgjPDj6UJNJTykjtt8NgQ82/CLAEHggdCeEf/T9E6KPlLG59U+DvbDeDV1a/KcYk6
 oIKY/n0w1wj9RkAu6PcR+vZ6tUptSyjIto4BLBRON4Vu2xjOkAgT2n2QCgRNb4wktwpFOdB2t
 dil/Pn0qWsKxuLlEMj/YzfiGEHQVObo/J888IPK+k+5H0DLKihuIJZ57xoknHewbhE68lpmcV
 rG+nfMuo4dycdcDOCDQ3IWqIkBsiusNZFDRDG0JStERTtnEkvLAd8i/CYVJdEg4hKBw+fpLvN
 wNpIdlENtYji5zVvncyHslb0goYM=
Subject: Re: [cocci] [PATCH v3 04/16] ALSA: ac97: convert timeouts to
 secs_to_jiffies()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2462
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/5495665a-774b-4bc5-8eb2-a9680d09b0be%40web.de>

=E2=80=A6
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci wi=
th
> the following Coccinelle rules:

Is only a single SmPL script rule relevant here?


> @depends on patch@
> expression E;
> @@
>
> -msecs_to_jiffies
> +secs_to_jiffies
> (E
> - * \( 1000 \| MSEC_PER_SEC \)
> )

I would miss two space characters in the first text column.
Please avoid typos also in such SmPL code.
Would you like to compare your contributions with a previous change sugges=
tion
like =E2=80=9C[PATCH v3 03/16] accel/habanalabs: convert timeouts to secs_=
to_jiffies()=E2=80=9D
once more?
https://lore.kernel.org/cocci/20250225-converge-secs-to-jiffies-part-two-v=
3-3-a43967e36c88@linux.microsoft.com/

Regards,
Markus
