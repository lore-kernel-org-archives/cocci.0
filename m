Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE661F3382D
	for <cocci@archiver.kernel.org>; Tue, 17 Mar 2026 09:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=5ZuqlSrxX8r0RJlIlalGnSaHgtTRi6oi0YhWSDJolTI=;
  b=eHji7OcjQgusFKgDKuwxjorJwQgPj6Q96q0wm+W7iEpaYa78leNyK9zB
   mLr8jMjuVI4IRQAa8Dda/DZF4hwHkhGv57yNakD36mvB6208YIAV0oLd5
   kuuinj2tTwGHeaPoVu/K6nNPbFPP7C+ZQFNhCblnZqs/6C0lk6AnLxWp5
   s=;
X-CSE-ConnectionGUID: mgS/flsLTYqTiT6X2JyTtA==
X-CSE-MsgGUID: VOwl/6DZQ+O+XYEGZQ4aGg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,124,1770591600"; 
   d="scan'208";a="268119387"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Mar 2026 10:40:44 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 2859A822FF; Tue, 17 Mar 2026 10:40:44 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 2054080E26
	for <cocci@sympa.inria.fr>; Mon, 16 Mar 2026 14:30:34 +0100 (CET)
X-CSE-ConnectionGUID: TrRS/lU6Q7qTTCjfSvip+w==
X-CSE-MsgGUID: vi1O6qADRean0d2/iTV4QA==
IronPort-SDR: 69b805fa_2z7w9JzvNpcTrM3dqHEt3FdzN+B4Z64SJDoZQIv6j1PyVq8
 mZHkDdzLVNyjh44mPqj88Pccd6aY+JsitIwhLwg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HwAQAEBbhphaxujNlaglmCQYFlNAcISYRYkXQDhDuYC?=
 =?us-ascii?q?oNUDwEDAVsBAgQBAYUHAo0jAh8GAQQzBg4BAgQBAQEBAwIDAQEBAQEBAQEBD?=
 =?us-ascii?q?QEBBQEBAQIBAQIEBgECEAEBAQFASYZcgmIBg38BAQEBAgEjBBFBBQsLDgoCA?=
 =?us-ascii?q?iYCAlYGARICAQGCfoJNJwe2Tnp/M4EB3j6BcBQBgQouhW+CZQGFWhobIIQ/J?=
 =?us-ascii?q?w+BVUSBFScLgng+hAqEFIJpBIIigQ6IUoNDhlxSeBwDWSwBVRMXCwcFgSMQM?=
 =?us-ascii?q?wMgCi8tAhQNEBIPBBYFLR1wDCcSDx0XFB9YGwcFEiEqTniBZhsPhmV5Ay5eG?=
 =?us-ascii?q?g4iAigRA1lKPgtSBYIsAicCAQttPTcGAwsbBD2OLTyCMwEBgQ2CKVGTFZFSo?=
 =?us-ascii?q?UU0B4QfgV4GDJ9tBhMvhASNE4ZPkwUuh2WQcyKrHSSBXDMaI4M3TwMZD44tD?=
 =?us-ascii?q?QmTG7oTRjI+AQcCBw4CgXODXAEBjCI0gUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 P0hoYfs5egRndiJTPkk3OneYw==
IronPort-HdrOrdr: A9a23:iec5JKgZIR+fzrSw3Gf9aq/GmnBQXwp23DAbv31ZSRFFG/FwyP
 rCoB1L73XJYWgqM03IwerwQ5VpQRvnhP1ICPoqTM2ftWjdySGVxeRZgbcKrAeQfBEWmtQ96U
 4kSdkHNDSSNyk2sS+Z2njfLz9I+rDun86VbKXlvg5QpGpRGsNdBnJCe2Km+zpNNWx77PQCdK
 a0145qtjCgcXMYYoCBAGUZX+/MntvPlJj3Sx8LDRwq5WC1/H+VwY+/NyLd8gYVUjtJz7tn2W
 /Zkzbh7qHmn+CnxgTa32rz6Y0TvNf60NNMCOGFl8BQc1zX+0iVTbUkf4fHkCE+oemp5lpvuN
 7Qoy04N8A2x2LNcnqzqR7N3RCl9Do18XftxXKRnHOmi83kQzARDdZHmOtiA1TkwntlmOs5/L
 NA3mqfuZYSJwjHhj7B69/BUAwvvlaooFI5+NRjz0B3YM87Uvt8vIYf9ERaHNMrByTh8r0qF+
 FoEYX1+OtWS1WHdHrU11Mfg+BEH05DXCtucHJy/vB94AIm20yRCHFogvD3q01wsa7VjaM0vt
 gsfJ4YzI2mBfVmEJ6VTN1xPfdfTFa9AC4keVjiX2gOGMw8Sg3wgo+y77Mv6O6wfpsUiJM0hZ
 TaSVtd8XU/YkT0FKS1rdR2Gz32MRKAtA7Wu7djzok8vqe5SKvgMCWFRlxrm8y8o+8HCsmeX/
 qoIppZD/LqMGOrQO9yrkbDcogXLWNbXNweu949VV7LqsXXKpfyvuiedPrIPrLiHTstR2u6CH
 oeWzr4ItlG8ymQKzfFqQmUX2modl30/Jp2HqSf9+8PyJIVPokJqQQRgUTR3LD+FdSDiN1CQK
 JTGsKVrkrgnxjGwY/h1RQYBjNNSkBI/b7nT3RG4QcXLkKcS8dwh+mi
X-Talos-CUID: =?us-ascii?q?9a23=3Asbhd/2vdJ0RvRJjijMneSlWg6IsZaEfmi3PtfXb?=
 =?us-ascii?q?nEFpVY7+bckGR4OB7xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AjBnCEAyukwH7I8pJvGL3p3tPcfqaqLqvUWdTiLw?=
 =?us-ascii?q?qgcSNM3R8YXCcsArre6Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,124,1770591600"; 
   d="scan'208";a="267977918"
X-MGA-submission: =?us-ascii?q?MDGJBrpe6oqOp+lTjjcVDF8d2oKKSVv9mYiMx7?=
 =?us-ascii?q?ou3EPT+KVRBVKcNNFeww9qkEwXfWc9AwQNudHpeXQah+ZQZd7CgdmBQK?=
 =?us-ascii?q?krD+NufeIKN3RP8PapyRoh7RCIRTE2KSuaiwlmxtPjXSRWPGHuSfnl/6?=
 =?us-ascii?q?C+yTTRaiz3bvrzLrRVG6NqEA=3D=3D?=
Received: from foss.arm.com ([217.140.110.172])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 16 Mar 2026 14:30:33 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 357291477;
	Mon, 16 Mar 2026 06:30:25 -0700 (PDT)
Received: from [10.57.61.116] (unknown [10.57.61.116])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D4953F778;
	Mon, 16 Mar 2026 06:30:22 -0700 (PDT)
Message-ID: <2c7466f5-d952-4356-9b55-9d2ebb3471f2@arm.com>
Date: Mon, 16 Mar 2026 13:30:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org,
 apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org,
 cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-50-bd63b656022d@avm.de>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260310-b4-is_err_or_null-v1-50-bd63b656022d@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 50/61] iommu: Prefer IS_ERR_OR_NULL over manual
 NULL check
Reply-To: Robin Murphy <robin.murphy@arm.com>
X-Loop: cocci@inria.fr
X-Sequence: 3443
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/Xe_AxUw0bB6PExUw_QVnLA>

On 2026-03-10 11:49 am, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.

AFAICS it doesn't look possible for the argument to be anything other 
than valid at both callsites, so *both* conditions here seem in fact to 
be entirely redundant.

> Change generated with coccinelle.

Please use coccinelle responsibly. Mechanical changes are great for 
scripted API updates, but for cleanup, whilst it's ideal for *finding* 
areas of code that are worth looking at, the code then wants actually 
looking at, in its whole context, because meaningful cleanup often goes 
deeper than trivial replacement.

In particular, anywhere IS_ERR_OR_NULL() is genuinely relevant is 
usually a sign of bad interface design, so if you're looking at this 
then you really should be looking first and foremost to remove any 
checks that are already unnecessary, and for the remainder, to see if 
the thing being checked can be improved to not mix the two different 
styles. That would be constructive and (usually) welcome cleanup. Simply 
churning a bunch of code with this ugly macro that's arguably less 
readable than what it replaces, not so much.

Thanks,
Robin.

> To: Joerg Roedel <joro@8bytes.org>
> To: Will Deacon <will@kernel.org>
> To: Robin Murphy <robin.murphy@arm.com>
> Cc: iommu@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>   drivers/iommu/omap-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 8231d7d6bb6a9202025643639a6b28e6faa84659..500a42b57a997696ff37c76f028a717ab71d01f9 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -881,7 +881,7 @@ static int omap_iommu_attach(struct omap_iommu *obj, u32 *iopgd)
>    **/
>   static void omap_iommu_detach(struct omap_iommu *obj)
>   {
> -	if (!obj || IS_ERR(obj))
> +	if (IS_ERR_OR_NULL(obj))
>   		return;
>   
>   	spin_lock(&obj->iommu_lock);
> 

