Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BF3F3382F
	for <cocci@archiver.kernel.org>; Tue, 17 Mar 2026 09:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=pZj8f0JboyjKt94J8KB7OLIiCOoml43GOZ4w8rDpLPA=;
  b=Zhr4NmWKxbn39CpW5GZWFCFwzV78YPHp+1aAbCJu9nuv7kMqWQDMJK3X
   JkX4mHZWV5hpMwNkyW0NNs2xWvLOr+0oqu8doyJHd0RUYj6lxLIw4coOF
   gRv5yYOESJ1C1YQvwN9BABqIi9bEU/6XqSbBbsyghGjBAe0nuWjrKu8Iz
   A=;
X-CSE-ConnectionGUID: 6KWOCIZgQmafgDFtShRowA==
X-CSE-MsgGUID: MVzloNY+QzaxkQJLpEFQ0w==
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
   d="scan'208";a="268119423"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Mar 2026 10:40:46 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 1889582300; Tue, 17 Mar 2026 10:40:46 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 7712782274
	for <cocci@sympa.inria.fr>; Mon, 16 Mar 2026 23:11:00 +0100 (CET)
X-CSE-ConnectionGUID: GL56eqXwQxGktNE6Dsm6kQ==
X-CSE-MsgGUID: HGeXpK1jR/2SM2gyUgkh5w==
IronPort-SDR: 69b87ff3_d1ExqRPpX4545+yjj8xAcC8J28aMbxRqL+CqyUbfSohp9Aq
 lbweVsg4jdmnyrEw/SN7dqSd1qJMoMdvVH5q6vg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0F1AgACf7hphYqsqGdaglmCQYFlNAcISZZPoBcCDwEDA?=
 =?us-ascii?q?Q1RBAEBAwEDhQACjSMCHwYBBDMGDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQIQAQEBAUBJhk8Ngls7cYElAQEBAQEBAQEBAQEBAR0CCGMBH?=
 =?us-ascii?q?wEBAQIBJxMGAQE3AQQLCw44VgYTgwKCIwEGIycCtzOBATOBAYIMAQEG3CqBZ?=
 =?us-ascii?q?wkUAYE4hW+CZQGFWhobhF8nG4INgRWDKj6ECoQtglCCJoEOiFKKMkgKeBwDW?=
 =?us-ascii?q?SwBVRMNCgsHBV5FQwM1EioVI0sFLR2BIyEdFxQfWBsHBRIhKk54ggEPhmV5A?=
 =?us-ascii?q?y5eGg4iAjlcSj4LUgWCLAJWAwsYDUgRLDcUGwQ+bgeNTTyCMwEBgQ2WDQORU?=
 =?us-ascii?q?WuhDoQmgWSfdE2BS5YFkxsuh2WQc6lBgX4kgVx9CIMiTwMZD446g2eFE8IxJ?=
 =?us-ascii?q?zI+AQcCBw4CgXOQADSBSwEB?=
IronPort-PHdr: A9a23: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
 gAN3au+KIkILYT02kptZ191nYLHXUHXWIIUyhA=
IronPort-Data: A9a23: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
 abZiIyErIyGpZbNLPtd
IronPort-HdrOrdr: A9a23:C7DAH6496mL4lFL3RwPXwCHXdLJyesId70hD6qm+c20yTiX+rb
 HRoB17726KtN91YhxNpTnuAtjkfZqiz+8X3WB8B8bHYOCighrSEGgA1/qf/9SDIVyHygc178
 4JGMIOauEYT2IK9/oSizPIaurIruP3l5yAtKP74zNVVgd6e8hbjztRO0K+PglOXw9WFd4SHI
 aH6qN8xgaISDAyQoCBCnMIX/fOqrTw+q7OUFojK1oc5A6CgSjA0tHH+mCjr2ojbw8=
X-Talos-CUID: 9a23:E1SPBmCM0a1ovUP6EwZDqRAZA/A6S23yz2v2DhGUEmM3S4TAHA==
X-Talos-MUID: 9a23:stPqHQkODNxVwzNQSiUBdnpCG8pY+4f3CnpKy64j4caVCCNzO2qC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,124,1770591600"; 
   d="scan'208";a="141490766"
X-MGA-submission: =?us-ascii?q?MDHA0ziLcCPOGOzbfE/Luhj2SUlVZB6gPshpt0?=
 =?us-ascii?q?PPBkemd04rjGmo7zDeQXpk8lZSYb6RDQMwfrBcWeunv/qA0DqK+PGdaU?=
 =?us-ascii?q?NCR7TQuo72WzOOVD29CIbGsFswm690fmXXg1Wcxcwbif3GwAD7Nmzzjy?=
 =?us-ascii?q?SjNg5t4DIluhN0A0l5fUNq9w=3D=3D?=
Received: from flow-a3-smtp.messagingengine.com ([103.168.172.138])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 23:10:59 +0100
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 96E81138028E;
	Mon, 16 Mar 2026 18:10:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 16 Mar 2026 18:10:56 -0400
X-ME-Sender: <xms:73-4aYdtUUIQC679P0YPl8k6UZ10Tz8-qTD319yDZEtXusdBhZuXRA>
    <xme:73-4aTUav9FvduIIOmc0jldmINr5W_MhUsWQFGzP1fBm1dpf8ggOxSMvCMHniLmCu
    LbRPk360ujIo39hLA6fsP95YlnCLki5WcrUsiuRyEwh6NcxWlxF>
X-ME-Received: <xmr:73-4aSY56rJyFtQwMFw-H9dfM29zbbMWxWkWrpi3kYaZ1kbqDyXdf5bHU5U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleelheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfesthejre
    dtredtvdenucfhrhhomheptehlvgigucghihhllhhirghmshhonhcuoegrlhgvgiesshhh
    rgiisghothdrohhrgheqnecuggftrfgrthhtvghrnhepvdekfeejkedvudfhudfhteekud
    fgudeiteetvdeukedvheetvdekgfdugeevueeunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhgpdhnsg
    gprhgtphhtthhopeehhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhrghh
    nhdqohhsshesrghvmhdruggvpdhrtghpthhtoheprghmugdqghhfgieslhhishhtshdrfh
    hrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopegrphhprghrmhhorheslhhishht
    shdruhgsuhhnthhurdgtohhmpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtvghphhdquggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegtohgttghisehinhhrihgrrdhfrhdprhgtphhtthhopegumh
    dquggvvhgvlheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopegurhhiqdgu
    vghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtohepgh
    hfshdvsehlihhsthhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:73-4aQltNdDVIdEqvCmz7Mlt0qW50NA4CHgJQUMNlacMN4MGiVKHfA>
    <xmx:73-4acHdFw15OLpR73_B1AdIXJMG-pYssiD_C0T2dj2N-8ux7fVHFg>
    <xmx:73-4aU6P6J2BtdvPwSPzfrUNjz9-qYacHOOWBucSAMlha23fXDTcIg>
    <xmx:73-4aaO5YEqAXlnOLRO88GZx1RbxPW8QtXAeqZQNaqmxlgOL7PgFkQ>
    <xmx:8H-4abIvs_QYur641c9BpnDuFQ6ssCC-7-o-rPLEHWyRxStBDxJEr6SL>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 18:10:52 -0400 (EDT)
Date: Mon, 16 Mar 2026 16:10:50 -0600
From: Alex Williamson <alex@shazbot.org>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
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
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
 alex@shazbot.org
Message-ID: <20260316161050.01c82973@shazbot.org>
In-Reply-To: <20260310-b4-is_err_or_null-v1-46-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
	<20260310-b4-is_err_or_null-v1-46-bd63b656022d@avm.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 46/61] vfio: Prefer IS_ERR_OR_NULL over manual
 NULL check
Reply-To: Alex Williamson <alex@shazbot.org>
X-Loop: cocci@inria.fr
X-Sequence: 3444
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/iRi3KmEh64Lb5hlFuOAg7g>

On Tue, 10 Mar 2026 12:49:12 +0100
Philipp Hahn <phahn-oss@avm.de> wrote:

> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Change generated with coccinelle.
> 
> To: Alex Williamson <alex@shazbot.org>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  drivers/vfio/vfio_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 742477546b15d4dbaf9ebcfb2e67627db71521e0..d71922dfde5885967398deddec3e9e04b05adfec 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -923,7 +923,7 @@ vfio_ioctl_device_feature_mig_device_state(struct vfio_device *device,
>  
>  	/* Handle the VFIO_DEVICE_FEATURE_SET */
>  	filp = device->mig_ops->migration_set_state(device, mig.device_state);
> -	if (IS_ERR(filp) || !filp)
> +	if (IS_ERR_OR_NULL(filp))
>  		goto out_copy;
>  
>  	return vfio_ioct_mig_return_fd(filp, arg, &mig);
> 

As others have expressed in general, this doesn't seem to be cleaner
and tends to mask that we consider IS_ERR() and NULL as separate cases
in the goto.  This code looks like it could use some refactoring, and
likely that refactoring should handle the IS_ERR() and NULL cases
separately, but conflating them here is not an improvement.  Thanks,

Alex
