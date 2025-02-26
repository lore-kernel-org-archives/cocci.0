Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1031C19777
	for <cocci@archiver.kernel.org>; Wed, 26 Feb 2025 08:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=e+5RpPRvvzjuUY81vTPZnqHz+79gde+49pmE6RhCRX0=;
  b=VOW73HhVhC+DueqvjNalhX0ikOCOWf6R2nBYDmxSjNhBeNniywpQmA/m
   AKcroAsVef1s1RESBHoaGOf7wSzbROMnmShJlHNru5xcZuCup/bU87LYd
   BYqBoXBYKDMSqldlk1NS/7F8xfc1gcZH2y7QTPMbAXW/ErGafy4Edxxwz
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.13,316,1732575600"; 
   d="scan'208";a="210104155"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Feb 2025 09:59:04 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 25BEDE0260; Wed, 26 Feb 2025 09:59:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 28BF9E0260
	for <cocci@sympa.inria.fr>; Wed, 26 Feb 2025 03:00:57 +0100 (CET)
IronPort-SDR: 67be75d8_yJbt/0/ZpipZQLpDeBAwL0auKpLUSNBhp3cYkJVXd5/BnLm
 nWl6UDksb2MJIXjUbfskqrYvM7qA+CeNKi6nJUg==
X-IPAS-Result: =?us-ascii?q?A0EDAABkdb5nj9lUsotaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDgVczBAtIhFaIHV+GU4F0MIQ7mVmBfg8BA?=
 =?us-ascii?q?wENRAQBAQMEhQACixICHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQEBAQEBOQVJhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDX4BA?=
 =?us-ascii?q?QEDIx0BATcBDwsOCgICJgICVgYBEgIBAYJ+gmUDr12BMoEBggwBAQbcIIFlC?=
 =?us-ascii?q?YEaLgGITgGFa0SDOXonFQaCDYE8gwM+hFiDRoJpgjOBboM+p31SexwDWSwBV?=
 =?us-ascii?q?RMXCwcFYUhIAyo0MSOBIwU0Cjc6ggtpSToCDQI1gh58gitqBAWBKoI3hENcL?=
 =?us-ascii?q?wMDAwODKoVSghGBYAMDFhCDH3cchH+EAB1AAgELbT03CQsbBj2hLjyFFIFWC?=
 =?us-ascii?q?JQ9g1ABjhRooQeEJaFNBg8EL5dEkxEuh2WQaiKpDoFnOoFcTTAIgyJPAxkPi?=
 =?us-ascii?q?ACGIRmIdMYqNDU8AgcLAQEDCZAcgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:Z4lbJK5uYM4HhLyNqGzPxgxRtLnDchMFZxGqfqrLsTDasY5as4F+v
 jBNCmCGaf6Oa2P8fdl+PduyoUgFvZWEzoRmQVM+ry9jZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOC6UoYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE0
 T/Ii5S31GSNhXgtaQr414rZ8Eky5K6o5mtB1rADTakjUGH2xyF94K03fvnZw0vQGuF8AuO8T
 uDf+7C1lkuxE8AFV7tJOp6iGqE7aua60Tqm0hK6aID+6vR2nRHe545gXBYqhei7vB3S9zx54
 I0lWZVd0m7FNIWU8AgWe0Ew/y2TocSqUVIISJSymZX78qHIT5fj69gwIWw7IKs1w/kpRkBI7
 8AyNQgIax/W0opawJrjIgVtrsgtM4/wO54FsXwmzjzDC/siB5fZTM0m5/cBh2Z2358eW6aCI
 ZBANlKDbzyYC/FLElsTBZc5leOAhXTldTBc7lWPqsLb5kCJlVQpjuG8b4q9ltqiFPxRmR3Dv
 m392HXyCz5BNfGGxgW62yf57gPItXimANxCS+TQGuRRqFma2WUXDDUEVF6xu/D/i0ikWtsZJ
 VZ80iEppqMz3Fe6S8H0GRy+un+N+BAGM+e8CMU25h7L0a3J+Q2UQGsJVDhMbJohrsBeqSEWO
 kGhso3EKDFylpCsViza17GOkRmvAS0QIjpXDcMbdjct797mqYA1qxvASNd/DaK45uEZ/xmun
 FhmSwBg290uYd436kmtwbzQb9uRSnXhQgAqoB7QQ3iu40V6aZSjaoju7kLUhRqhEGp7Zgbd1
 JTns5HPhAzrMX1rvHDSKAnqNO3xj8tpyBWG3TZS82AJrlxBAUKLc4FK+y1ZL0x0KMsCcjKBS
 BaM5VsMvM8IYib3NvMfj2eN5yICk/iI+TPNCKy8UzaySsEhL2drAQk/PxfOhwgBbmBwzPtgU
 XtkTSpcJS1HUfo3k2PeqxY13KY2xyY/1SvISIrlzh+qyvKfYnXTIYrpw3PQBt3VGJis+V2Pm
 /4GbpPi40wGAIXWPHKNmaZNdg9iEJTOLcytwyChXrLYelI+cIzgYteNqY4cl3tNxvgKx7mZr
 iziACe1CjPX3BX6FOlDUVg7AJuHYHq1hStT0fUEbAb2iUswK52i9rkefJYRdLwqvr4rh/1tQ
 vVPP43KDv1TQ36Vs34QfLvsnrxELR6LvAOpOzb6QT4de5U7eRfF1OW5dSTS9Q4PLBGNi+0An
 5Oa2Dj2e6EzHzZZMJ6OadaE7U+AgnwGqecjA2rKOoZyfWvvwqhLKgvwrOUFE+MRGyrc2zHB9
 QC3AAgZl8bJsYQa4NnEvoHajoaLQs9VPFtWIHnf1pmybRLlx2uExZQadvSlZhXfaT/Ew7qjb
 uBr0P3MCv0Ls1JUuY5aEbww76YBy/bwhr1dlCJIIW7qagm1N7ZePXW258lDmalTzLt/uwHte
 Eau+MFfCIqZKvHeD18dCwo0XNutjchOtGHp0s00B0Hm6Atc3rmNCxxSNibRrh1tFuJ+NYd9z
 NoxvMIT1ReEtSMrFdS7lQFRyXWHKy0Rcqcgt6xCOrTRtCgQ9ghgb6DfWwjM27PeT/VXM0IvH
 C2Yu7qauZRY2Xj5UiQSEVrj4LNjoKog6TFw8U86BlWWm9D6qOc98z9P/B8WEAlE7BV1/NhiG
 2psNn9aF/6q+RF2iPhhXVKXRhtzND+EyHPu1lFStmv4TlapZEPJPmYSKeaAx2FH0mN+Lxxw3
 qCU93bhahnuJPrO5yoVXVU/je7OVvlzy1Hyo9+mFMG7AJUKWzrprauwb24uqRG8I8cOqGDYh
 OttpsBcVLbaMHMOnqgFFIWq77QcZxSaLmhkQ/s63qcoH3nZSQ6iywq1NEG9VcNcFcPkqXbiJ
 ZRVGftOcBCi2AKljDMRX/cMKoApus8Z3oMJf7ezKFMWt7eakCFSj6vR0SrDn04ufcRllJcsC
 4HWdg/aKFequ1lvpzbvovVHa02CWvtVQC3n3euwzvcFKIJbjsFobnMJ8+WVu1e7DVJZ2iy67
 S3/Y53Y9ehA8bhXvpDNF/xDDjqkKNmoW+Wv9huygut0btjOEJnvsh8RoVy6Ow59YKUaXt92s
 Z+vs9fH+lzPk5hrcmLemriHT7Jo4+frVsVpE8vHFltotgrcZ93duD445HGeFZxFtPh/9/uXb
 VK0R+XofOFERuoH4mNebhZvNio0CoP1X//Gnjy8pfHdMSot+1XLA/3//EC4cFwBUDEDPqD/L
 QrGu/yOwNR8h6YUDT8mA8BWObNJEGXBa4AHKeKo7SK5C1O2iGysorHhzBosyQ/aA0m+TfrV3
 8j3eQjcRj+T5ofz09Brg65jtEY2DVF8o9UKUGAzxtpUsw2+XUk6dbkzEJNfBp9tx3m4kNmyY
 TzWd2ItBBnsRTkOI122/N3nWRzZHeAUfMvwIjsy5U6PdiOqH8W6DaB88jt7qWJDEtc5IDpL9
 flFkpExAvSw/n2tbeod+bqghvp9zf6cxX8S/0351cvoDH7yxFnMOGNJRGJwue7vSqkhV3kn4
 UA2SHpCTUX9TlT+eSqlU2AAAwkX5VsD0B1xBRpiA7/jV0Gzz+BazvD7febp3dXvqSjMyKEmH
 RvKeodG34xaNrH/d0fkVxLFTJKY0c62I/U=
IronPort-HdrOrdr: A9a23:y1L9na4sMlthEB97nwPXwPnXdLJyesId70hD6qm+c202TiXqrb
 HIoB19726OtN9xYgBZpTnkAsS9qBznmqKdjbNhWYtKGTOWwVdAT7sN0WKB+VHd8v3Fh4hgPM
 5bGsAUYuEYT2IK6PoSizPZLz9P+qjlzEnlv4bj80s=
X-Talos-CUID: =?us-ascii?q?9a23=3ABHeDgGmVSdk0zHSoDg6uC+fGpvvXOVCD4VrdPmm?=
 =?us-ascii?q?VMHk3D5yTU2O65ZthlsU7zg=3D=3D?=
X-Talos-MUID: 9a23:MurWkghbUWd9xq07hnHiiMMpZf5s5P/1EE82toQNsubfNAFpNAiipWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,316,1732575600"; 
   d="scan'208";a="210061978"
X-MGA-submission: =?us-ascii?q?MDFhVtpqf1obclOOKPb6UXKnZljKceOP6pl27T?=
 =?us-ascii?q?kpIUsd34fdnEdY2QvWSg5/7REMeByRPtmiZNr2X8h/AjGqRMtN0RmbKP?=
 =?us-ascii?q?CHN1hGZlOI+UFnd9zfxIu1O5M/I68XdlydyVnHIpIGvAbikPmbnClwZF?=
 =?us-ascii?q?GHbIKMU0Uzg4pMVQ0zFBHOFA=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 03:00:56 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1AA8D5C5675;
	Wed, 26 Feb 2025 02:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76A4C4CEDD;
	Wed, 26 Feb 2025 02:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740535253;
	bh=QOAgMMGKbnJ6hZHvx6ZJYTRK+iZXq18TAlHT3acDveU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lbvJaOgPkZbnkOP5hNZv3kt8F37sM5wVNdz5pQoKBOvWJpcWyMv2mVC7qw0zww0FC
	 tw0rFBZp3tLMdImqLCpGhcY34tv8uho+Lu2q/YVztsAQwyT0nOq0d2HlE+yumDi+2G
	 NnGD4V7HBDpFdEYrgDp0+8hLWBlWldNGcN9+JQ1uf7k8Z8tTkCxsl34NLWQ8Vawbdb
	 K9795FHlijgsdEKshsQNQoxr3/DEjO/bi0eHV3p1/sO3PbUu61pZGpWQwOCIptZowS
	 rIy49xymFJKzj4FXwPSz54+5ZyqnT56OBQv1abO0kJMDp0bQ7XnwlRxW3/2snteMgS
	 vdipJDYHPyQ2Q==
Message-ID: <2632bed9-4e4a-494a-bb89-d5aac64f854e@kernel.org>
Date: Wed, 26 Feb 2025 11:00:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
 Andrew Morton <akpm@linux-foundation.org>
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
 cocci@inria.fr, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org,
 linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
 linux-rdma@vger.kernel.org
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
 <20250225-converge-secs-to-jiffies-part-two-v3-8-a43967e36c88@linux.microsoft.com>
 <ff51bcfc-10c8-4461-9f82-ea1d5ed784f8@linux.microsoft.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ff51bcfc-10c8-4461-9f82-ea1d5ed784f8@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 08/16] ata: libata-zpodd: convert timeouts to
 secs_to_jiffies()
Reply-To: Damien Le Moal <dlemoal@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2458
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/2632bed9-4e4a-494a-bb89-d5aac64f854e%40kernel.org>

On 2/26/25 5:24 AM, Easwar Hariharan wrote:
> On 2/25/2025 12:17 PM, Easwar Hariharan wrote:
>> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
>> secs_to_jiffies().  As the value here is a multiple of 1000, use
>> secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplication
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
> 
> This was meant to carry Damien's ack once the subject line was fixed[1], but I fixed
> the subject line and missed adding the ack in. Damien, would you like to ack again?

Looks like Andrew already applied the patch, which is fine.
But nevertheless:

Acked-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
