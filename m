Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF6BC02196
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 18:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=OqPAwTULz/ylA5SQSCmsIKYH/79lvRoXFrBfI1CqqYw=;
  b=isaRekOZP6IgXaCgd4f3a24dYb9O4bk4ZFSYjmZq+82MOogeedVFPZW4
   PHOzSl/aEQ8jK65TU38PzIhGPy8buJgaa6xzO9YjRxreKh6rm2X06vT1V
   7axKf6IqCbSEi/npT3MnC+QAAqhEa/fHhizpknWoIiGx97b/n/ByV8ikD
   M=;
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
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205450170"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 19:22:16 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5A43FE0D22; Tue, 28 Jan 2025 19:22:15 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 98493E00A5
	for <cocci@sympa.inria.fr>; Tue, 28 Jan 2025 19:22:04 +0100 (CET)
IronPort-SDR: 6799204c_U3lHUtnEQ+gKiNiBmMIn4uVRY7Cz7Z7MknXcJwdPytBveBY
 uKJP2KCCq2EEaW5MEQMJTbeMo1rcc8/hgU5TNxg==
X-IPAS-Result: =?us-ascii?q?A0EgAACtH5lncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVJkE+BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?nUCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIdAQE3AQ8ZDAImAgJGEAYBEoMCgmUGAqIyAYdgAQECiyOBMoEBggwBAQaCZ?=
 =?us-ascii?q?9k4gWQJgRouAYhNAYFsg387CYM5eicbgUlEgUqBBoIthApOg0aCaYIzgUWDb?=
 =?us-ascii?q?6EdCT+BBRwDWSwBVRMNCgsHBWRVOAMgCwsMCxQcFQIUHQ8GEARtRDeCR2lJN?=
 =?us-ascii?q?wINAjWCHiRYgR2BDoRchEVgLwMDAwODOIJFVIJEghR6gReGQh1AAwsYDUgRL?=
 =?us-ascii?q?DcGDhtDAW4HnF08hAOBDoEnlDyEGY1JoW6EJaFgATKqUy6HZJBqIqhaghg6g?=
 =?us-ascii?q?VxGByMVgyJPAxkPiACGIYN6jz0BugtDNTwCBwsBAQMJhUYBAYodNIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:10a8Wqm7tJ6n5fw9Lq61OrHo5gwaIkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIYCD2PbvmNNmXxf9x+bdnl9E4H65PSzYRjSFRrq3gxF1tH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvymTrSs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82Ayazl8B56r8ks14ayr4mNA4jTSWNgS1LPgvylNZH4gDfrpR5fIatE8NvK3Q
 e/F0Ia48gvxl/v6Io7Nfh7TKyXmc5aKVeS8oiI+t5uK3nCukhcPPpMTb5LwX6v4ZwKhxLidw
 P0V3XC5pJxA0qfkwIzxWDEAe81y0DEvFBYq7hFTvOTKp3AqfUcAzN0xMX4wZLxE0N1tGGZw9
 9sjdSoEQUq60rfeLLKTEoGAh+wnLc/2LMUau3p6yireA+pgSpfGK0nIzYYDmmhvwJkTQbCHN
 5BxhTlHNHwsZzVCM1ceEpM+lc+sh3/iY3tdqVmPorEw7XSVxwt0uFToGIONJYHaFZ8Kwy50o
 ErhokbkAQ06aeC44j3ayXauq8jkp3rCDdd6+LqQraUw3AL7KnYoIBkfSlK/pdGri0u0QdsZK
 koO+yNoo7Ja3EesRdL8dwappWaN+B8aQdtZVeMggDxh0YLQ4gCEFi4BTzVbb8chutNwTjsvv
 rOUoz/3LWNSj7vMeC63za2Nqg2wHhNIN2YtPxZRGGPp/OLfiI00ixvOSPNqH6i0ksD5FFnML
 9ai83VWa1I70pBj6kmrwW0rlQ5AsXQgc+LYzgHWWH+1qAZ4b5SifIum9R7Q6vMowGelorup4
 iZsdyu2tblm4XSxeMqlGrRl8FaBvKntDdEkqQQzd6TNDhz0k5JZQahe4StlOGBiOdsedDnib
 Sf74FwKtMcLZiT0MPMrOepd7vjGK4CwRLwJsdiEPrJzjmRZKlTdpkmCmGbMgT+wyBRyzcnTx
 7/HL5n9Uy9y5VtbIMqeHLxHjeBDKtEWwGLYX5fgyBq7mbGZfmb9dFv2GArmUwzN14va+1+92
 4gEaKO3J+B3CbGWjt//qNJLdQhiwLlSLcyelvG7gcbaclA2Qjt6VKaIqV7jEqQ895loei7z1
 inVcidlJJDX3xUr8C3TMig9OoD8F41yt2w6NiEKNFOlkSprK4W24atVM9N9cbA7/aYxhbR5X
 tsUSfWmW/5vczXg/yhCTJ/fqIc5Sg+nqzjTNAWYYR8+XaVaeSr3xvHecDHSqRY+VhiMiZNmo
 pmL9B/qfp4YdgEzUOfUcK2Oyn2yj1g8mcVzfVDBHYQKdW6x7IFVDT371dkpEcc1NCSZlye71
 hmXMzgct+Lis484y/iXpKGm/qOCMfpyIVpeJEbftY2JDCj9+nGx5KN9S8OKQGztb3z186Cce
 ull9fHwH/kZllJssYAnMbJU4Y8hxtno/Zl28x9FGSjVUlGVFb9QGHmK8s1RvKlrxLUCmw+XW
 FqKy+ZKK4eyJ8LpP14AFjULNt3Z+6kvpQDTyvApLGHRxix9puOHWHoPGSi8snVWKb8tPb41x
 eskhtUt1DW+rRgXKfeDsDFf8jWdD34HUph/jKogPq3QtlMJxG1BMLvmMQ2nxLGUat5JDFsmH
 S/MuorGmIZn5xTjd1gdKCHz+NRz1LU0hQBy7V4dJl62tMLPqd0p0TZwrzkmbARn4S9W8uB0O
 2JEM1B5FaqT9QhshsNGDnKmQTMZIBi/5EbK6kAokVfBRBKCTV39L2waOMeM8nsG8mlaQCNpw
 bGAxEvhUhfoZMvUzAJrfWJE8tvNFcdQ8C/Gk+CZR/W1JYEwO2fZs/X/dFg2pAvCKuJvok/+/
 M1B3vt6MI//Pg4u+5wLMZGQj+kseUrVNV55YK9T+Y0SFjvhYxC04z+FLn6xdu5rJ/Dn9UyZC
 dRkFvlQViaRhTq/kTQGOZEie7NEvuYlxN4nSIPZIWQrt7i+rD0wlLny8iP4pnEgQvQwsMIbB
 77SSQm/ET2rtSMJo1POkchKAXrnQN8mYAan4vu53t9UHL0+scZtU3oI7J2Kg1uvPjBKxSmk5
 DH4W/eOzshJ65hdoI/3I6ASWyS2MYzSUcqLwiCSsvNPT8jGDpqXuihItlDYGRVcZp0PadJOi
 IXX4cLW3VzEjpkyQWv2i5mMLIgXxMSQDc58ENP7E2lepgSGAPTT2hok/3uqDLB0i/Zf25WXf
 BS5Y86OatIlYddR63lLYSx4ERxGKaDIQor/hCG69dKgNwM81FHZEdaZ6nPZV2FXWSsWMZnYC
 AWvmfKP5MhdnbtcFi0/GPBqLJ9pEmDNAZJ8WYXKigCZKW20jnepmLjoz0Mg4A6WLEi0Kp/x5
 JadSyXucBi3hrrz8+hYlI5PpTwSMmd2hLghX0Aa+uMusQuAMkw9Eb0/P6kFW7ZuqQ6j5KGgM
 XuJJCEnBD7mVDtJTQTk7Z6xFk2DD+gJIZHiKiZv40qQbDysCZidBKd6sB1t+GpyZiCp2dTPx
 QvyIZEsFkPZLlBVqecvCjiTheZh2+Ocw3MD40fmlMLuRR0ZBN3mEVR/SRFVW3Wv/97lzS32y
 aodHAiog31XjWb1EMB9azhQGRoDuyjowSluZiCKqDoak5vO1/VOkZUTJMmquoDur602yHomQ
 XLxWnvL5mGdwHsIvqU1/dkuhMeYzB5N8teSdMfeeOHZo018BqnL8S/PcerjgfzOIDJiLm4=
IronPort-HdrOrdr: A9a23:dp9ycKn0mFANmuQAR+IJcfYqh37pDfIW3DAbv31ZSRFFG/FwWf
 re+sjzsiWE6wr5OUtBpTjjUJPrfZq4z/NICOYqUotKMDOLhILsFvAH0WKA+Vzd8lPFh4xgPM
 5bGsAUNDSzNykesS+Q2meF+rgbsb66GdiT9J7j80s=
X-Talos-CUID: 9a23:+0ABn26MFNA72lTBG9ssq3MrHJkULlfm1m7XHU2fMjtzQZLPcArF
X-Talos-MUID: =?us-ascii?q?9a23=3Aj55rmw6z1lzr5LonK5RMX3uBxoxPvoazC1wtzKk?=
 =?us-ascii?q?hkM7bDihyFhC2tm2OF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="107588275"
X-MGA-submission: =?us-ascii?q?MDEEAT3MO7YdxrBLytNHUViutekuDYpREmEqFD?=
 =?us-ascii?q?v4EWuUEwMNxoYSL9g/DQL2Q3JgAaO5y/+/K9I1QBH3e4MhEaMCshKAZA?=
 =?us-ascii?q?ChYlXP5imevcTSA1g+rxLHKzCjADVpLqH1E/82yP9XvOIs+bFMff2Zpm?=
 =?us-ascii?q?Gqd1Dj/fC37oDkcAfa+OdbLg=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 28 Jan 2025 19:22:04 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 598502037184;
	Tue, 28 Jan 2025 10:21:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 598502037184
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738088519;
	bh=OqPAwTULz/ylA5SQSCmsIKYH/79lvRoXFrBfI1CqqYw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jXfb9M/Cehjh0rKk4/gwmJMdgUjXncg0HDEC39xVRFWQkuiYphjidp7M9lcy47Bum
	 gUNDvi3+taG7qq0jtJSKlDz1ymYX6/HH0DskMWFPIdQPzlPn2zSfXJ32Gn2cCN+9lW
	 iIDOVi+CXaME0UAmvAJpRjEmzopqE4zm0lQ/NWzM=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 28 Jan 2025 18:21:58 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-converge-secs-to-jiffies-part-two-v1-13-9a6ecf0b2308@linux.microsoft.com>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
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
 Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
 Selvin Xavier <selvin.xavier@broadcom.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org, 
 linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
 ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2
Subject: [cocci] [PATCH 13/16] spi: spi-imx: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2284
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250128-converge-secs-to-jiffies-part-two-v1-13-9a6ecf0b2308%40linux.microsoft.com>

Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
secs_to_jiffies().  As the value here is a multiple of 1000, use
secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.

This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
the following Coccinelle rules:

@depends on patch@
expression E;
@@

-msecs_to_jiffies
+secs_to_jiffies
(E
- * \( 1000 \| MSEC_PER_SEC \)
)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/spi/spi-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index eeb7d082c2472f954001045295b349bc2eb53197..832d6e9009ebe741779acd58c3a9450c231151bb 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1449,7 +1449,7 @@ static int spi_imx_calculate_timeout(struct spi_imx_data *spi_imx, int size)
 	timeout += 1;
 
 	/* Double calculated timeout */
-	return msecs_to_jiffies(2 * timeout * MSEC_PER_SEC);
+	return secs_to_jiffies(2 * timeout);
 }
 
 static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,

-- 
2.43.0

