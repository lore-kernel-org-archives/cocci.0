Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3FCC02192
	for <cocci@archiver.kernel.org>; Sat,  1 Feb 2025 00:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:cc:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=URcW5d1wFUuTsZZ61zIwPjo02bqd3Xwwrj5siI/ejR4=;
  b=ui9/MQlHQmwqxcSjngeID1/vWgJXwJ2wFrxkvOx/kbXszfd8FpsWTRo2
   OhGnLQJlcBQrwmCLXqBqkz7BlYqSHp0fiQStn+SdgOZ/YcGXDBxjfB51j
   NLMwArMfQpjZWAhSGZI/VbyDhcV0KujR+WNnv1v1RUjSKYvLHGYiwXGIZ
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
X-IronPort-AV: E=Sophos;i="6.13,250,1732575600"; 
   d="scan'208";a="206047589"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Feb 2025 01:11:45 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6533CE0D1E; Sat,  1 Feb 2025 01:11:45 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 13856E0261
	for <cocci@sympa.inria.fr>; Sat,  1 Feb 2025 01:11:43 +0100 (CET)
IronPort-SDR: 679d66bd_b0eJgX/ZF1EMY0LB7prRb+Al0lbfY/fUlNbqQat3XZdYll4
 76WNgGYMXrU6WHcdJKy89H8SQDXFqcI077gP9cQ==
X-IPAS-Result: =?us-ascii?q?A0EEAADiZZ1nhbaaTQ1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFBAwEBAQELAYJDfVozBwhIBIRSkXOLc5IkgUA+DwEDAUgGA?=
 =?us-ascii?q?QIEAQEDBIUAAop9Ah8GAQQyBw4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBAQFASYV7DYJiAYEkUQ1IAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBEQINXgEBHgEBAQMREh0BATcBDwsYAgImAgJWBhMCAQGCfgGCZAYCDKU5A?=
 =?us-ascii?q?YdgAQECiyOBMoEBggwBAQbcH4FlAwaBGi4BiE0BhWsbhFwnG4FJRIE8CwOCd?=
 =?us-ascii?q?T6EWINGgmmCM0qBKYNAokJSexwDWSwBVRMXCwcFgSlIA4ERI4EmBTUKNzqCD?=
 =?us-ascii?q?WlJOgINAjWCHnyBHYEOawQFgS2CO4RFYC8DAwMDgzaFW4IUgWMDAxYSAYMne?=
 =?us-ascii?q?ByDIh1AAgELbT03CQsbQ54jPYRLfSCWAYJnAY4Ta6EEhCWMGJUzBg8EL5dYk?=
 =?us-ascii?q?nsuh2SQaowLgXmVXIUdgh8HLIFcRgcjFYMiTwMZD44hDA0Jg1iFE8QEIjUCO?=
 =?us-ascii?q?gIHCwEBAwmFRgEBimmBSwEB?=
IronPort-PHdr: A9a23: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
 pmp/Sso5g==
IronPort-Data: A9a23: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
 NWzyyBWOXlp43y9FFFbJcvlNn6xvr8x4+n1sTPC
IronPort-HdrOrdr: A9a23:7oUSS61o+JxoUHBbFsCnzwqjBIIkLtp133Aq2lEZdPWaSKylfr
 OV7ZMmPHjP+U4ssRAb6Km90MvpexnhHPtOjLX5Uo3MYOCLghrNEGgm1/qF/9SCIUPDH4xmuZ
 uIGpIWYLbN5BpB/KPHCWKDYrUdKbe8gcKVbKvlrktQcQ==
X-Talos-CUID: 9a23:s25HZmyvZCsPPrjQkzKNBgU6JvA5SlD4503UABGBTkNuE+TEZGCfrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AZmcthg9ezjdz0UZ+mmPURleQf+Za8ee0FW8TqqQ?=
 =?us-ascii?q?tltCnDHxSFQjGph3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,250,1732575600"; 
   d="scan'208";a="107909999"
X-MGA-submission: =?us-ascii?q?MDGAbuv7gQlrN/zMB30/3Gkk4pKSG4Hf+3Qcel?=
 =?us-ascii?q?UbG2E4SB/17PpDxwrlK9uq/NUuudR2Pwkd/foGpQHDjyKpuiuEd4niA5?=
 =?us-ascii?q?Bad/Mh2am0ClldVJMpH8E94XXcGXSqJBlpCGpEequ5LOHD8TjD/nRULe?=
 =?us-ascii?q?XW8JDRQemWY6gV+fQV/fWFBw=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 01 Feb 2025 01:11:41 +0100
Received: from [100.65.234.206] (unknown [20.236.11.185])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7E312210C329;
	Fri, 31 Jan 2025 16:11:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7E312210C329
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738368698;
	bh=URcW5d1wFUuTsZZ61zIwPjo02bqd3Xwwrj5siI/ejR4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=VAieKTRUQduuqC4WMWksNFGAWFpl7wH2vcfIqWTtocImegfQz7yg09xx/uVhF84+8
	 X7djRP48uKGESU6HAg1NDd667oKEWQCkly+4NL3U6jOR2q4YvgMKiwE4cdu5TQF7bE
	 8JEcr4WkbAHOc5PABGxI8dv7PLkq6NUdzzexdebM=
Message-ID: <632be2db-78d2-4249-92f0-3f60e0373172@linux.microsoft.com>
Date: Fri, 31 Jan 2025 16:11:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cocci@inria.fr, kernel-janitors@vger.kernel.org,
 eahariha@linux.microsoft.com, LKML <linux-kernel@vger.kernel.org>,
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
 Yaron Avizrat <yaron.avizrat@intel.com>,
 Ricardo Ribalda <ribalda@chromium.org>
To: Markus Elfring <Markus.Elfring@web.de>
References: <20250128-converge-secs-to-jiffies-part-two-v1-1-9a6ecf0b2308@linux.microsoft.com>
 <e06cb7f5-7aa3-464c-a8a1-2c7b9b6a29eb@web.de>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <e06cb7f5-7aa3-464c-a8a1-2c7b9b6a29eb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] [PATCH 01/16] coccinelle: misc: secs_to_jiffies: Patch
 expressions too
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2327
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/632be2db-78d2-4249-92f0-3f60e0373172%40linux.microsoft.com>

On 1/30/2025 3:01 AM, Markus Elfring wrote:
>> Teach the script to suggest conversions for timeout patterns where the
>> arguments to msecs_to_jiffies() are expressions as well.
> 
> Does anything hinder to benefit any more from a source code analysis approach
> (like the following by the extended means of the semantic patch language)?
> 

Thank you, this is much more useful feedback, specifically due to the
suggested patch below. I did intend to learn about the other modes and
progressively upgrade secs_to_jiffies.cocci with them in the future once
the existing instances were resolved, to help with future code
submissions. The patch below will be super helpful in that.

As it stands, I'll fix up the current rules in v2 following your
suggestion to keep the multiplication in each line to allow Coccinelle
to use the commutativity properties and find more instances.

I'll refrain from implementing the report mode until current instances
have been fixed because of the issue we have already seen[1] with CI
builds being broken. I would not want to break a strict CI build that is
looking for coccicheck REPORT to return 0 results.

[1]:
https://lore.kernel.org/all/20250129-secs_to_jiffles-v1-1-35a5e16b9f03@chromium.org/

<snip>

Thanks,
Easwar (he/him)
