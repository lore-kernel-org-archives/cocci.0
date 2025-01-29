Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADF4C0218D
	for <cocci@archiver.kernel.org>; Wed, 29 Jan 2025 17:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:cc:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=dNRZE1wRPI3+cVzpq2MiJyQrXak+KjxySL05qBZwi3I=;
  b=IuuB8omj1Qr8UPyH6OrvIUU5Odu6QPMttc9A7V/54XX/fe1fZVOlxoLN
   Ar4wANsF2XZehf+YrfOmPd+GCBRYaSphm3SgHTskUr2uFc1k5S7aBh8t0
   fTTbVW4NKkIevJ/lgxWXS8I33dWZ8XxBtzHFYcj3XiG4aOofWHn/ugHSc
   E=;
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
   d="scan'208";a="205641373"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2025 18:12:23 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 27DFEE0D1E; Wed, 29 Jan 2025 18:12:23 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9522BE0260
	for <cocci@sympa.inria.fr>; Wed, 29 Jan 2025 18:12:20 +0100 (CET)
IronPort-SDR: 679a6174_7P9FQYO3zEvH3rHUxiXUD7hEncUK7oKe9CTOD9CxnDzz2Vn
 DT0AGuqDfgt2U/UJMtPIh46Rr0HiMbRUaQMdeKg==
X-IPAS-Result: =?us-ascii?q?A0EBAADmYJpnhbaaTQ1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDgVczBwgZL4RWiB2JUwMTi2CSJIFAPg8BA?=
 =?us-ascii?q?wFOAQIEAQEDBIUAAop1Ah8GAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECEAEBAQFASYV7DYJiAYEkUQ1IAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBEQINXgEBHgEBAQMREgQLAQ0BATcBDwsYAgImAgJWBhMCAQGCfoJlB?=
 =?us-ascii?q?gKkJgGHYAEBAosjfzOBAYIMAQEG3B+BZAmBGi4BiE0BhWtEhDMnG4FJRIE8C?=
 =?us-ascii?q?wOCdT6BUoI4ET2DRoJpgjNKgSmDQIh7mEVSexwDWSwBVRMXCwcFgSlIA4ERI?=
 =?us-ascii?q?4EmBTUKNzqCDWlJOgINAjWCHnyBHYEOawQFgS2CO4RFYC8DAwMDgzaFW4IUg?=
 =?us-ascii?q?WUDAxYQAYMneByCNR1AAgELbT03CQsbQ51tPIQDgQ6BJx17ZJJAg08Bjn2Lc?=
 =?us-ascii?q?pURhCWhSwYPBC+EBI0Ghk6Sey6HZJBqqHyCGDqBXEYHIxWDIk8DGQ+IAIYhD?=
 =?us-ascii?q?A0Jg1jJfSI1PAIHAQoBAQMJhUYBAYobAScMgUsBAQ?=
IronPort-PHdr: A9a23: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
 lgziwBkZv8q+iuq6FAydAOimQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:SKNfUaqGU0XXldyUjXmEEPsaV5obeYIsimQD101hICG9vPb5qy
 ncpoV96faSskdoZJhAo6H4BEHjKUm3yXcR2+Qs1NiZMzUO1FHYSL2KqLGSpQEIeBeRygc+78
 tdmsFFYbWaMbE5t7ee3ODSKadC/DDoytHLuQ6T9RZQcT0=
X-Talos-CUID: =?us-ascii?q?9a23=3AkUiCtGpW4A9yc+fJQUKS7wLmUcEEQ3+Ek3j7H2X?=
 =?us-ascii?q?mA35nErC6dXOC9Zoxxg=3D=3D?=
X-Talos-MUID: 9a23:0tNMOAQWHfhSuqkMRXTvpxs7c+k23J2NUkBVk5g/kpeFHC5vbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,244,1732575600"; 
   d="scan'208";a="205641358"
X-MGA-submission: =?us-ascii?q?MDF/uSmCUy3eo4kBSrAjnM1wPlbUEGWm3IwGln?=
 =?us-ascii?q?4991PT6ZVMV6zYF1zuWrEUwFuK43Ktt8pLJD/iEcjU53pqeJYywGBCtq?=
 =?us-ascii?q?XGQdFVqrFp6pRSUaIOYuRJjkMTGUQjxfHGp1+WXZknSniIiBFP0r7xgc?=
 =?us-ascii?q?cZDuQrYRCYj15cinDZHcBGPw=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 29 Jan 2025 18:12:19 +0100
Received: from [100.65.130.94] (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id B361C203F2DF;
	Wed, 29 Jan 2025 09:12:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B361C203F2DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738170737;
	bh=dNRZE1wRPI3+cVzpq2MiJyQrXak+KjxySL05qBZwi3I=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=KF5CYJEMAg7wD96ahKvWhkAFA05d2EUsKiRjXm+SrhlcieyjVvtYaExuKNZLJq+g2
	 aBFGl/Q/OmH+pg7BhR5kfVvugzt2v4vFfmJ8RuG1opp/VMgS23ja3qFHYzfub/yGXl
	 hPpNsGrrOx1WOoNEIOcsOUJA+IETCxANclm3bUSY=
Message-ID: <fae29f46-2971-4cab-a54a-f1780abbadda@linux.microsoft.com>
Date: Wed, 29 Jan 2025 09:12:18 -0800
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
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Frank Li <Frank.Li@nxp.com>,
 Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Selvin Xavier <selvin.xavier@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128-converge-secs-to-jiffies-part-two-v1-14-9a6ecf0b2308@linux.microsoft.com>
 <e8207616-6079-be0d-d482-6577616a4cc7@linux.intel.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <e8207616-6079-be0d-d482-6577616a4cc7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] [PATCH 14/16] platform/x86/amd/pmf: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2311
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/fae29f46-2971-4cab-a54a-f1780abbadda%40linux.microsoft.com>

On 1/29/2025 5:12 AM, Ilpo Järvinen wrote:
> On Tue, 28 Jan 2025, Easwar Hariharan wrote:
> 
>> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
>> secs_to_jiffies().  As the value here is a multiple of 1000, use
>> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.
>>
>> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
>> the following Coccinelle rules:
>>
>> @depends on patch@
>> expression E;
>> @@
>>
>> -msecs_to_jiffies
>> +secs_to_jiffies
>> (E
>> - * \( 1000 \| MSEC_PER_SEC \)
>> )
>>
>> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>> ---
>>  drivers/platform/x86/amd/pmf/acpi.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/amd/pmf/acpi.c b/drivers/platform/x86/amd/pmf/acpi.c
>> index dd5780a1d06e1dc979fcff5bafd6729bc4937eab..6b7effe80b78b7389b320ee65fa5d2373f782a2f 100644
>> --- a/drivers/platform/x86/amd/pmf/acpi.c
>> +++ b/drivers/platform/x86/amd/pmf/acpi.c
>> @@ -220,7 +220,8 @@ static void apmf_sbios_heartbeat_notify(struct work_struct *work)
>>  	if (!info)
>>  		return;
>>  
>> -	schedule_delayed_work(&dev->heart_beat, msecs_to_jiffies(dev->hb_interval * 1000));
>> +	schedule_delayed_work(&dev->heart_beat,
>> +			      secs_to_jiffies(dev->hb_interval));
>>  	kfree(info);
>>  }
> 
> Hi,
> 
> So you made the line shorter but still added the newline char for some 
> reason even if the original didn't have one?? Please don't enforce 80 
> chars limit with patches like this.
> 

Sorry about that, I can fix that in v2.

Thanks for the review!

- Easwar (he/him)
