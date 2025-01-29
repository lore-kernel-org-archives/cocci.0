Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECDDC02192
	for <cocci@archiver.kernel.org>; Wed, 29 Jan 2025 17:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:cc:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=pYh2yn40lkpaqAG8En7hcsBez+8JKaFCGsBWiD832tE=;
  b=pXCN5MwXgIkdxk5I5t63Gq2vVmN4RJ/KSqX/mT/7NQ+sHTdb1xAJqJF4
   EmDKVsC16J7lZyKpbO0apBFRA3xfwapIpYKHwKeIGD98EE7Geh/q4bY4U
   yWjpwjnmOPCs52y7Qr85Cjd6ntRyLApEkA69r3bc1K6VuHJPC/0BQAB5p
   g=;
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
X-IronPort-AV: E=Sophos;i="6.13,244,1732575600"; 
   d="scan'208";a="205641469"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2025 18:13:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C373CE0D1E; Wed, 29 Jan 2025 18:13:00 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6087FE0260
	for <cocci@sympa.inria.fr>; Wed, 29 Jan 2025 18:12:56 +0100 (CET)
IronPort-SDR: 679a6196_cz0nlZ2zklrHg0x4xWpq8SIkgcWYGhYChGKD6f6PDaVqcQo
 SMk+O90AIo++ABg/B07pXNkmEGVsLlOU6caXYGA==
X-IPAS-Result: =?us-ascii?q?A0F3AQDmYJpnhbaaTQ1aHgEBCxIMQIFIC4JEgVczBwhIh?=
 =?us-ascii?q?FaRcxOLYJIkgUA+DwEDAU4BAgQBAQMEhQACinUCHwYBBDAJDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAUBJhXsNgmIBgSRRDUgBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAR8BAQEDERIEGQEBNwEPCw4KAgImA?=
 =?us-ascii?q?gJWBhUBAYJ+gmUGAqQmAYdgAQECiyN/M4EBggwBAQbcH4FkCYEaLohOAYVrh?=
 =?us-ascii?q?HcnG4FJRIE8DoJ1PoRYg0aCaYIzSoEpg0ChQFJ7HANZLAFVExcLBwWBKUgDg?=
 =?us-ascii?q?REjgSYFNQo3OoINaUk6Ag0CNYIefIEdgQ5rBAWBLYI7hEVgLwMDAwODNoVbg?=
 =?us-ascii?q?hSBZQMDFhABgyd4HII1HUACAQttPTcJCxtDnimEAoNOlnMBjhJrnkCCQ4Qlo?=
 =?us-ascii?q?UsGDwQvg3GTZ5J7LodkkGqofIIYOoFcRgcjFYMiTwMZD44hGYNhyX0iNTwCB?=
 =?us-ascii?q?wsBAQMJhUYBAYpPgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 w==
IronPort-HdrOrdr: A9a23:WQ9OQKHqRV/8Mh22pLqE2MeALOsnbusQ8zAXPo5KKSC9Afbo8P
 xG+85rrSMc6QxhIU3J+7i7UpVoJEmwyXcb2+Ys1NuZLW3bUS6TXedfBOjZrQEIeReTygc178
 4JGJSWSueAaGSS5vyKgzVQfexQouVvvJrIudvj
X-Talos-CUID: 9a23:aXdGSW4ffE6WUE+QntssxEwqAOJ4diznyCnJPk+kOWRPTqGbRgrF
X-Talos-MUID: 9a23:xkckXwt/gNziZCsnQ82ntBZmOZhm5byUDlknjc83oOaGCTwqAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,244,1732575600"; 
   d="scan'208";a="107686557"
X-MGA-submission: =?us-ascii?q?MDHkgGycsJ4Tt8sUtUaHJzZ1Ipe2f50kSHZDro?=
 =?us-ascii?q?Hk1LtsDZCakPkGXL71fkF02UU/ZVglqWNiE3MWwhZzF8cPbpbZZ6CsQm?=
 =?us-ascii?q?PFzHvY+pEnw69wu85xJekYkKbElo9ZrGJowO6lwVb/YSP0Bawml0ftsv?=
 =?us-ascii?q?ToXvgnCf3160QeIENCmxYmgg=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 29 Jan 2025 18:12:55 +0100
Received: from [100.65.130.94] (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id AC3D420591A1;
	Wed, 29 Jan 2025 09:12:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AC3D420591A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738170772;
	bh=pYh2yn40lkpaqAG8En7hcsBez+8JKaFCGsBWiD832tE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Rak3F2+8fD36df/6R9W6FIe4vLPlHDgpiHFKAtGMBHH6D5mOcR2hxxoOHOyUlYT1e
	 yDP0p8wAmOL/TcaLg32uBJFdZTn7tWe8PR5xNYjJ+B3J6emo7glJ0gq+pyY27z7ZrW
	 RsCXOpUAqjEEHyM/3gJpHfkTqWPKNwTSH7U1jcB0=
Message-ID: <3e4a8a44-483b-457a-b193-4119e4adfa85@linux.microsoft.com>
Date: Wed, 29 Jan 2025 09:12:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Andrew Morton <akpm@linux-foundation.org>,
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
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
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
 linux-rdma@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128-converge-secs-to-jiffies-part-two-v1-9-9a6ecf0b2308@linux.microsoft.com>
 <20250129052108.GB28513@lst.de>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20250129052108.GB28513@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] [PATCH 09/16] xfs: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2312
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/3e4a8a44-483b-457a-b193-4119e4adfa85%40linux.microsoft.com>

On 1/28/2025 9:21 PM, Christoph Hellwig wrote:
> On Tue, Jan 28, 2025 at 06:21:54PM +0000, Easwar Hariharan wrote:
>>  		else
>> -			cfg->retry_timeout = msecs_to_jiffies(
>> -					init[i].retry_timeout * MSEC_PER_SEC);
>> +			cfg->retry_timeout = secs_to_jiffies(init[i].retry_timeout);
> 
> This messes up the formatting by introducing an overly long line.
> 
> Otherwise the change looks fine.

I'll fix this in v2. Thanks for the review!

- Easwar (he/him)
