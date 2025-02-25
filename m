Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D62FC021BB
	for <cocci@archiver.kernel.org>; Tue, 25 Feb 2025 20:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:cc:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Jyr1W2i0apHpLVaBAxpMdrionoJIfFMi72X+ip6bMMQ=;
  b=beIA/jZsNS1dhn7xbe/cl/KPgUmLdK4kJMrEUsbdFxaNNKLFxaiLzdYN
   TIK1t0byiUQxkk3u0u76f4Pl4MdWc4PALkGcx8++3PA8I08UXeiY08Lty
   y+oOLHrBrO+swkXXjaxS6u1vCKFkv5FiPRwMoEzp6IqN6a97m4kql2DM3
   s=;
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
   d="scan'208";a="210044169"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:28:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DDC85E0E42; Tue, 25 Feb 2025 21:28:04 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 92C9BE0260
	for <cocci@sympa.inria.fr>; Tue, 25 Feb 2025 21:25:04 +0100 (CET)
IronPort-SDR: 67be2720_YXeb7EhUFk+Qdd4SVbR42qIyXeBEMIjNbAeD1U3RuWYW8QG
 Rb3bqU2OwML14TN3QwtL4YgBNYUw/p6FlNRXUXQ==
X-IPAS-Result: =?us-ascii?q?A0EMAACUJb5nhbaaTQ1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBQQQBAQELAYJDfVozBwhIBIRSkXMTi2CSIYFAPg8BAwFIBgECBAEBA?=
 =?us-ascii?q?wSFAAKLEgIfBgEEMgcOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABAQEBQEmFew2CYgGBJFENSAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARECD?=
 =?us-ascii?q?V4BAR4BAQEDERIdAQE3AQ8LDgoCAiYCAlYGARICAQGCfgGCZAYCDJ0hAYdgA?=
 =?us-ascii?q?QECiyOBMoEBggwBAQbcIIFlAwaBGi4BiE4BhWsbKYQzJxuBSUSBPAsDgnU+h?=
 =?us-ascii?q?FiDRoJpgjNKgSSDPqdhUnscA1ksAVUTFwsHBYEpSAMqNDEjgSMFNAo3OoILa?=
 =?us-ascii?q?Uk6Ag0CNYIefIEdgQ5qBAWBKoI3hENcLwMDAwODKoVSghGBYAMDFg8Bgx93H?=
 =?us-ascii?q?IR/g2MdQAIBC209NwkLG0OhGgE8hXVzCJQ9g1ABjhRroQSEJYwYlTUGDwQvl?=
 =?us-ascii?q?1iSfS6HZZBqIotqgXmaeoIfAzCBXEYHIxWDIk8DGQ+IAIYhGYNhhRPHAiI1A?=
 =?us-ascii?q?joCBwsBAQMJhUYBAYpUgUsBAQ?=
IronPort-PHdr: A9a23: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
 CRZ
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:x7hiia9yFw+EGXvv8qNuk+DoI+orL9Y04lQ7vn2ZhyY0TiXqrb
 HIoB19726NtN9xYgBYpTjjUJPrfZq4z/NICOYqUotKMDOW3FdAabsSi7cKoAePJ8SdzIJgPM
 5bGsAUNDSzNykesS+Q2njaLz9P+qjkzEnlv4bj80s=
X-Talos-CUID: 9a23:5xiqLmAydF2jyrL6EzNbxA0VSuR7SyPU7jDeLlHkMXZzcLLAHA==
X-Talos-MUID: 9a23:PBUzYwbc/t7jeuBThiDmmTVpaoRRzp+QIxo/wZ8KudKvHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="110053581"
X-MGA-submission: =?us-ascii?q?MDF8a/VWiFVL8107CCgU84rd6AlDAp796ZOv8Z?=
 =?us-ascii?q?517AnH8Yk8I0ae1pivubDolck9WPy4BAfT9aHzmH61/BUeuEZskEdzpt?=
 =?us-ascii?q?48qrp+jsgzYSq2NNibMEzl1Wf75oQok7l0HZYMEhGbC8eA/NwJN1zRF8?=
 =?us-ascii?q?u718JDINZzjdAvM9RnaA9vOg=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 25 Feb 2025 21:25:04 +0100
Received: from [100.65.162.92] (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5191F203CDFA;
	Tue, 25 Feb 2025 12:25:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5191F203CDFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740515101;
	bh=Jyr1W2i0apHpLVaBAxpMdrionoJIfFMi72X+ip6bMMQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=V/Rh9+nle434EIbuopM9xYrJYNBYrbLOW3WlEQkOknOqiCToz7hMLQUIFrnG8DXvX
	 yvhD7z2wBqkGseO+sg4I4fJv6ATebbI1vRErjd+f0KCKZCXRNZme7+k0ebhA+Gn/ng
	 4eDWKrdedP1lm6ZmqWkXb2DlKrIKwrjZudbMNMKQ=
Message-ID: <ff51bcfc-10c8-4461-9f82-ea1d5ed784f8@linux.microsoft.com>
Date: Tue, 25 Feb 2025 12:24:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay
 <ogabbay@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, James Smart
 <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>,
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
To: Andrew Morton <akpm@linux-foundation.org>,
 Damien Le Moal <dlemoal@kernel.org>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
 <20250225-converge-secs-to-jiffies-part-two-v3-8-a43967e36c88@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-8-a43967e36c88@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v3 08/16] ata: libata-zpodd: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2448
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/ff51bcfc-10c8-4461-9f82-ea1d5ed784f8%40linux.microsoft.com>

On 2/25/2025 12:17 PM, Easwar Hariharan wrote:
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplication
> 
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
> the following Coccinelle rules:
> 
> @depends on patch@
> expression E;
> @@
> 
> -msecs_to_jiffies
> +secs_to_jiffies
> (E
> - * \( 1000 \| MSEC_PER_SEC \)
> )
> 
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---

This was meant to carry Damien's ack once the subject line was fixed[1], but I fixed
the subject line and missed adding the ack in. Damien, would you like to ack again?


[1]: https://lore.kernel.org/all/f39cde78-19de-45fc-9c64-d3656e07d4a7@kernel.org/

Thanks, and apologies,
Easwar (he/him)
