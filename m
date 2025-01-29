Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BB2C0218D
	for <cocci@archiver.kernel.org>; Wed, 29 Jan 2025 17:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:cc:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=32VWyKda36DT3SVOQLKSI+Nu4mFH6I0v9p1Ypx/s/UM=;
  b=BK2M79Uj476aBQYCezuOga4Cjl2zQj2O1dGnA+WbjXsZ0cYmcfZHFDVk
   7Mvsa/A+6mdC16vQDv60h5eodAm8aUnpNGwhV0ohf1zDH29Q9J9dwBO8I
   cYFVwTk6a/uqKmOksV37PYG0Xzd/qlvsf+X9sgVpm0h5li84npm+UsCqu
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.microsoft.com
X-IronPort-AV: E=Sophos;i="6.13,244,1732575600"; 
   d="scan'208";a="205645890"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2025 18:36:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F164FE0261; Wed, 29 Jan 2025 18:36:53 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8701AE0260
	for <cocci@sympa.inria.fr>; Wed, 29 Jan 2025 18:36:48 +0100 (CET)
IronPort-SDR: 679a6725_kQ9SMg3X2N99UmYCbTOfdbU4MLbPa7znP6+NsR7e8IsQUni
 ctB3Pkd7fujZyoDHjtvHPnalqo/gZdWEUsI8ZAQ==
X-IPAS-Result: =?us-ascii?q?A0EiAACqZppnhbaaTQ1aHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?QGCQoFXMwcISIRWiB2JVhOLYJIkgUA+DwEDAU4BAgQBAQMEhQACinUCHwYBB?=
 =?us-ascii?q?DAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAUBJhXsNS?=
 =?us-ascii?q?QEQAYIHAYEkUQ1IAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEQINXgEBHgEBA?=
 =?us-ascii?q?QMREh0BATcBDwsYAgImAgJWBhMCAQGCfoJlBgKkKwGHYAEBAosjgTKBAYIMA?=
 =?us-ascii?q?QEG3B+BZAmBGi4BiE0BhWtEhDMnG4FJRIE8DoJ1PoRYg0aCaYIzSoEpg0ChQ?=
 =?us-ascii?q?FJ7HANZLAFVExcLBwWBKUgDgREjgSYFNQo3OoINaUk6Ag0CNYIefIEdgQ5rB?=
 =?us-ascii?q?AWBLYI7hEVgLwMDAwODNoVbghSBZQMDFhABgyd4HII4HUACAQttPTcJCxtDn?=
 =?us-ascii?q?W48hS2BC4EYkySDTwGOEmuhA4QloUsGDwQvl1iSey6HZJBqqHyCGDqBXEYHI?=
 =?us-ascii?q?xWDIk8DGQ+IAIYhGYNhygUiNTwCBwsBAQMJhUYBAYgagjWBSwEB?=
IronPort-PHdr: A9a23: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
 EZetw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:vCzW8a5eafo5ga9GrwPXwPjXdLJyesId70hD6qm+c3xom7+j5q
 eTdZMgpGfJYVcqKQgdcbLpAsO9qBbnmKKdjrN/AV7PZniDhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8ND4Z/LfD1HZK3BkWqF+rgbsbu6GeyT5Nvj8w==
X-Talos-CUID: =?us-ascii?q?9a23=3A8Gnfomi5lfv+a2NTpmb9326MGzJuYEDR0Ff2f2i?=
 =?us-ascii?q?ED1l7SIGNYFKRpqZnjJ87?=
X-Talos-MUID: 9a23:c1YF8glS8nhBwy5K9+dldnpjPoAy+oetGnoUsqwmoeaeMRNcJziC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,244,1732575600"; 
   d="scan'208";a="205645840"
X-MGA-submission: =?us-ascii?q?MDFDNRAIzFRdaBrHq2NMIiTz6jZVehtI5ZY5wc?=
 =?us-ascii?q?rZ7Hg0X7xBHsB9q/ZWbtdEgfocwNEUYnFPopowi7+r4eMwIsXkQ/653/?=
 =?us-ascii?q?nmanq3rXrF/yGuehGp5m37DtV217LZ7m3NIun23vH5ZUrCI0pvKfLRSQ?=
 =?us-ascii?q?sqLwhhUeR488JHBrlAvd3NmA=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 29 Jan 2025 18:36:36 +0100
Received: from [100.65.98.224] (unknown [20.236.10.66])
	by linux.microsoft.com (Postfix) with ESMTPSA id A3CA2205721D;
	Wed, 29 Jan 2025 09:36:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A3CA2205721D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738172194;
	bh=32VWyKda36DT3SVOQLKSI+Nu4mFH6I0v9p1Ypx/s/UM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=WdTF6heG9MXWg27CPpr2zs00gFmg/LzwKj0Alp7kuExME9ZkmRvd6i5RlINsUJmCj
	 gyW4AT2kMUzCtyC2BYOQAoboe3fZn9gnSQn/nvMf6cJwjiMZFtGWg0RkK4mQ7CXmnv
	 aKvKdhLh7jtgcjd5i92zHQeesuEbYFvcBS4PUXbY=
Message-ID: <f991dba7-79fb-490d-8ac5-6bd14f3209a8@linux.microsoft.com>
Date: Wed, 29 Jan 2025 09:36:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
 Xiubo Li <xiubli@redhat.com>, Niklas Cassel <cassel@kernel.org>,
 Carlos Maiolino <cem@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
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
 eahariha@linux.microsoft.com, cocci@inria.fr, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org
To: Damien Le Moal <dlemoal@kernel.org>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128-converge-secs-to-jiffies-part-two-v1-8-9a6ecf0b2308@linux.microsoft.com>
 <f39cde78-19de-45fc-9c64-d3656e07d4a7@kernel.org>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <f39cde78-19de-45fc-9c64-d3656e07d4a7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] [PATCH 08/16] libata: zpodd: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2313
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/f991dba7-79fb-490d-8ac5-6bd14f3209a8%40linux.microsoft.com>

On 1/28/2025 4:21 PM, Damien Le Moal wrote:
> On 1/29/25 3:21 AM, Easwar Hariharan wrote:
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
> 
> The subject line should be:
> 
> ata: libata-zpodd: convert timeouts to secs_to_jiffies()
> 
> Other than that, looks good to me.
> 
> Acked-by: Damien Le Moal <dlemoal@kernel.org>
> 

Thanks for the review and ack! I'll fix the subject line in v2.

- Easwar (he/him)

