Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBFCC0218D
	for <cocci@archiver.kernel.org>; Wed, 29 Jan 2025 18:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:cc:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=tZu7Aqdcq4BHW7QoklKujtbGCaxot/XApiLegvlW9Cg=;
  b=NnMQQLbaZjyBmvso+PH0pRGzYVmg/gFBrO4wbBf6S3aT4IaJfZC1mSHa
   21WQUQyXq1lSiAiEeALF9BsSMczmmOmzC5iLQX96KEVHeKJqF/1lyRGB/
   NxVFJ95YbupZ2oZZ0mTL/nOfVQcyW4OeyAPj3V2nWNvqbUJzd2RJJBTdH
   Y=;
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
   d="scan'208";a="205650794"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2025 19:14:50 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CA0F8E0D1D; Wed, 29 Jan 2025 19:14:49 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A98F4E0260
	for <cocci@sympa.inria.fr>; Wed, 29 Jan 2025 19:14:43 +0100 (CET)
IronPort-SDR: 679a7012_ohoZUhBb378Fz5NcZ6hF+11vK0gq0oL/pJ7KaASRhaED/bW
 P5UrW2t0ROIAbPCm/blNaXOtvHtrT9sK3ujpBeg==
X-IPAS-Result: =?us-ascii?q?A0F3AQBKb5pnhbaaTQ1aHgEBCxIMQIFIC4JEgVczBwhIh?=
 =?us-ascii?q?FaRcxOLYJIkgUA+DwEDAU4BAgQBAQMEhQACinUCHwYBBDAJDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAUBJhXsNgmIBgSRRDUgBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAR8BAQEDERIEGQEBNwEPCw4KAgImA?=
 =?us-ascii?q?gJWBhUBAYJ+gmUGAqROAYdgAQECiyN/M4EBggwBAQbcH4FkCYEaLohOAYVrh?=
 =?us-ascii?q?HcnG4FJRIE8CwOCdT6EWINGgmmCM0qBKYNAoUFSexwDWSwBVRMXCwcFgSlIA?=
 =?us-ascii?q?4ERI4EmBTUKNzqCDWlJOgINAjWCHnyBHYEOawQFgS2CO4RFYC8DAwMDgzaFW?=
 =?us-ascii?q?4IUgWUDAxYQAYMneByCPR1AAgELbT03CQsbQ54thAIygxyWcwGOEmueQIJDh?=
 =?us-ascii?q?CWhSwYPBC+DcZNnknsuh2SQaqh8ghg6gVxGByMVgyJPAxkPjiEZg2HKDCI1P?=
 =?us-ascii?q?AIHCwEBAwmFRgEBik+BSwEB?=
IronPort-PHdr: A9a23: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
 Rkz2FIWXA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:OtW1EKOkqmQTD8BcTvGjsMiBIKoaSvp037Dk7SBMoG9uA6ulfq
 eV7YwmPH7P+U8ssBNJo7q90cy7LE80mqQb3WB8B8bHYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 xdmupFebjN5DNB/KXHCWeDYrQdKZW8kZyVuQ==
X-Talos-CUID: =?us-ascii?q?9a23=3ARoOKwGnQi6JerLldj0Z6ldSpDQTXOVuMw2uTL2v?=
 =?us-ascii?q?jMzdOYZabbEW31695sMU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AdZGfNAwPOg1C4V9+WWiwiOEOhhyaqP2cJU0ju5M?=
 =?us-ascii?q?5h5WVPzQrZimgvmyRZaZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,244,1732575600"; 
   d="scan'208";a="107691953"
X-MGA-submission: =?us-ascii?q?MDHKuJoqSb635f40IvwYuwarPN8P03sD9nIAyJ?=
 =?us-ascii?q?1xroctt6DoY9hztZVqTPQ5VO2+7VbP27GFFwkgmJCwH9VpGvsuLWPRAL?=
 =?us-ascii?q?LdSDjoFDuMOGrGW6rkG2zfy3oBSAbWZHYQMv/Epfc8m0DgANHVuWGZzT?=
 =?us-ascii?q?RHSuS1Zf4+ZtQS96qKWiJgaA=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 29 Jan 2025 19:14:42 +0100
Received: from [100.65.98.224] (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 28F3F2066C1F;
	Wed, 29 Jan 2025 10:14:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 28F3F2066C1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738174479;
	bh=tZu7Aqdcq4BHW7QoklKujtbGCaxot/XApiLegvlW9Cg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=aAf9IIr/I90cgqgEBczLilZ7bdtCYRLZiEJHEhBdKJpSoOCumeMDEGeLf0xioaxnU
	 Cxs0rQCB+cTOuTBJEpsGVDSTUnsyW+Sqnpdni5YRWUzescyOcAANxe89dy6cL7UnK5
	 9o+lRZL0v3hO8jHtI+YxGsr5kQTHif7tO+OZbuMk=
Message-ID: <670dbe5b-cf5b-4994-9a47-53b0b52a4b20@linux.microsoft.com>
Date: Wed, 29 Jan 2025 10:14:40 -0800
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
 <3e4a8a44-483b-457a-b193-4119e4adfa85@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <3e4a8a44-483b-457a-b193-4119e4adfa85@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] [PATCH 09/16] xfs: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2315
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/670dbe5b-cf5b-4994-9a47-53b0b52a4b20%40linux.microsoft.com>

On 1/29/2025 9:12 AM, Easwar Hariharan wrote:
> On 1/28/2025 9:21 PM, Christoph Hellwig wrote:
>> On Tue, Jan 28, 2025 at 06:21:54PM +0000, Easwar Hariharan wrote:
>>>  		else
>>> -			cfg->retry_timeout = msecs_to_jiffies(
>>> -					init[i].retry_timeout * MSEC_PER_SEC);
>>> +			cfg->retry_timeout = secs_to_jiffies(init[i].retry_timeout);
>>
>> This messes up the formatting by introducing an overly long line.
>>
>> Otherwise the change looks fine.
> 
> I'll fix this in v2. Thanks for the review!
> 
> - Easwar (he/him)

Andrew seems to have fixed it up in his copy, so I'll skip this change
in v2. Thanks Andrew!

- Easwar
