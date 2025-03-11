Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4E7C35FF8
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 09:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=DpzCarWmeMfBwSWeZiWSfmCFOtEoyAGB9/rlV34qIyY=;
  b=uC0H97yYFZsSYenlwBnYJ1nZKZmnmM5OERUSdgHffhtqLkRFm69qs9qG
   VGxhiVzWkNKGXR3szFuSo9Acqd+naLriHK8wuS9ZRRG4gaJ1c2F6FDoMZ
   m/dTtDiarH8tLY7IUPeWmat2g5Beg8vyijCzK9rMhujippoAZyFW4/RTW
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux-foundation.org
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="213419070"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 10:11:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2DB56E0D20; Tue, 18 Mar 2025 10:11:54 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7B645E0260
	for <cocci@sympa.inria.fr>; Tue, 11 Mar 2025 03:08:12 +0100 (CET)
IronPort-SDR: 67cf9b0a_ng3zUrqw1tI5+P54S6Q4WctZITbDDBhQahg3v2eUBw8mMiF
 XcXUImhWUaYZj9y0581ZUPuyWgpEVwDIas0hMUA==
X-IPAS-Result: =?us-ascii?q?A0FwAACLmc9nj1vBS5NaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBUwKCQn1aMwQLSI1ShlOCJGmBVAGJNZQfDwEDAQ05CwQBAQMBA0OEP?=
 =?us-ascii?q?QKLGgIeBwEENBMBAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBA?=
 =?us-ascii?q?QEBATkFDjuFew1JARABggcBM2ARdDABKgINfQEBAQECAScTBgEBNwEECwsRA?=
 =?us-ascii?q?wECAS5OCAYTgwIBgkEjAxGvJ3iBATOBAYIMAQEG3CCBZQMGgUiITwGFa4N9e?=
 =?us-ascii?q?icbfYEQhD8+gkqBQIZ9gjOBaQGDPakZSAp7eCwBVRMNCgsHBWFIQwM1DAsuF?=
 =?us-ascii?q?SOBIwU0Cjc4ggtpSToCDQI1ght8giuCF4I2hDxcLwMDAwODKIVOghGBXQMDI?=
 =?us-ascii?q?gGCMG93HIRBPIRhLjIdQAMLGA1IESw3FBtEbgehEQE6hEOBDiyCSpJvg1ABj?=
 =?us-ascii?q?hZrn2WBIYQljBiVME2XRpMRLodlkGuOBZsugX4jgVwzGggoCIMiTwMZD44hD?=
 =?us-ascii?q?A0JiGvBeSM1PAIHCwEBAwmKE4VVNIFLAQE?=
IronPort-PHdr: A9a23:B4qtzhZh4uI22rh6IstpXNX/LTFq2YqcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1wWPBd2Qsqgc2rWempujcFJDyK7CikxKSIZLWR4BhJdetC0bK+nBN3fGKuX3ZTcxB
 sVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBxrwKxd+KPjrFY7OlcS30P2594HObwlSizewb61+I
 A+qoQnNucUanJVuJro1xxbLv3BFZ/lYyWR0KF2cmBrx+t2+8Jl//SpOpvkv7dRAUaL0f6Q5S
 bxXEjErOH0r6cPoqBfOUxKB6mMTXWsKnBVIBRPF7AzhUZfqriT6rOt91zKEMsDwULs5RC6t7
 6ZvSB/vlScHKzs0+3zZh8BskK5Wpg+qqgdhyIDIfo6aKPt+frvcfdwEQ2pBQt1RXDFFDo+lc
 ocDE/YNMeNeooLgpVUBsAG+CBGiCu3v1DFFmGL406443OQvFg/J0xAvEd0VvXTIrtj4LrseX
 +KpwKXWyzjIcvNY2S366IjNah0svfeMUq9qccXPx0gkCgTLjlKKqYz5ODOV0PkGvm+B4OpjT
 eKvjnUqqwVwojip28cthZDFhowSylDZ8yV23Zw6JcG5SE58Z96oCpxQtzuVN4ZvRM4pXm5nt
 jogxLIcpZ67YDYFyI4hxxPHafGKbpaE7w/jWuuTITl1mn1rda6/iRiy/0as1+zxW8e73lpUr
 SdJjN3Bu3QP2hLc5MaKSv9w80O81DuAywze6OdJKl06m6rcLp4u2L8wlpwLvETAACD2gkP2g
 7GSdkk+/eio8evnb7P7rZGfL495khzyP6ssl8ClA+k1MhICU3Wf9OmyzrHu+VD1TK1XgvEqj
 qXVqpLXKMQBqqO9HQNZyIYu5hW5Ajy7ztkYmWQHLElZeB2ZlYjnJlDOIfHmAvqnn1ihlipgy
 ercMb37GJrNK2DOkLf/crZ57E5R0AwzzNBD6J5OEbEBJ+/zWlXtu9PGFBM5MBK7w/zhCNpj0
 oMSQ2WPArWWMK/KsF+I4PwgI/WUaYMItzvwKeIp6vzugHMjhFMQeaek0YETZXylBvhmJl+WY
 XvogtcPC2cKuQ8+QfTwh12BST5TYm2/X6Y95jE9FYKnAp7PRo6qgLyc2ie0A4dZZnxHClCLF
 3fkbYKEW+0DaC6KJM9uiSQLVaK9RI85yRGuqAj6xqJ5IubM4C0XqYrj1MRp5+3UjRwy8SZ7D
 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
IronPort-Data: A9a23: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
 wRAO0QDOXk=
IronPort-HdrOrdr: A9a23:4M/EV6ys8mxuwldDvuRUKrPwKb1zdoMgy1knxilNoNJuE/Bw8P
 re5cjztCWE7gr5PUtMpTnuAsW9qB/nmqKdpLNhX4tKIjOW21dAXbsSircKqgeIc0aVygce79
 YET0EUMr3N5DZB4/oSmDPId+od/A==
X-Talos-CUID: 9a23:tMmb02A4mjpt6KH6EytGzEVOOMYdS2Pcwyfzf0yeD2dlYoTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AW4AvrA0d4l2g4l4XQTVk5GU5TTUjs5yFJ2UMjZY?=
 =?us-ascii?q?9n5eiKR1tNArNp3OTa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,237,1736809200"; 
   d="scan'208";a="111199747"
X-MGA-submission: =?us-ascii?q?MDGdaPLiUoiRfxjqRKcXuEiWHWbLAxQUfkLk7v?=
 =?us-ascii?q?hP6a34Z/xO3Q/ukOk1wMazAidafd08zrRUjrmo9Umg74+aKKGodZOPzg?=
 =?us-ascii?q?+pfGhvY/k4HTyOk73uUim8kzcEzA5wp3JvLZDaprGdQzO6pI7oMrgDJv?=
 =?us-ascii?q?c2gw9OXxJHAMSBkAJBaf/fSw=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 03:08:10 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8CA06A4656C;
	Tue, 11 Mar 2025 02:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872A9C4CEE5;
	Tue, 11 Mar 2025 02:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741658886;
	bh=EO2y2EASnimfmC0To8IgjADGLB03IrpBXSrBRgvMOXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wQfQZG6IKVV4Tew+S+0o+lnw12y0URQfWSPems1i8x5dKQTaPMYHdQMJDIg/0LCcq
	 9ysqdCzIccJgUTy5+1XImjyPHewrVrCASW3U/ThAkRtkSNX1mJCMOLQBPQJNwR3UZE
	 sXCoysWhDTs3Eikr7+eLtWHhOyIiad0yrUckBntM=
Date: Mon, 10 Mar 2025 19:08:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay
 <ogabbay@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix
 <nicolas.palix@imag.fr>, James Smart <james.smart@broadcom.com>, Dick
 Kennedy <dick.kennedy@broadcom.com>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Ilya Dryomov
 <idryomov@gmail.com>, Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens
 Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>, Damien Le Moal
 <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Carlos Maiolino
 <cem@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Sebastian Reichel
 <sre@kernel.org>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
 <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Frank Li
 <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Hans de Goede
 <hdegoede@redhat.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Henrique de Moraes Holschuh
 <hmh@hmh.eng.br>, Selvin Xavier <selvin.xavier@broadcom.com>, Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, Easwar Hariharan
 <eahariha@linux.microsoft.com>, cocci@inria.fr,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org,
 linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
 linux-rdma@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Carlos Maiolino
 <cmaiolino@redhat.com>
Message-Id: <20250310190803.aaf868760781c9ae3fbe6df1@linux-foundation.org>
In-Reply-To: <174165504986.528513.3575505677065987375.b4-ty@oracle.com>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
	<174165504986.528513.3575505677065987375.b4-ty@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] (subset) [PATCH v3 00/16] Converge on using
 secs_to_jiffies() part two
Reply-To: Andrew Morton <akpm@linux-foundation.org>
X-Loop: cocci@inria.fr
X-Sequence: 2597
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250310190803.aaf868760781c9ae3fbe6df1%40linux-foundation.org>

On Mon, 10 Mar 2025 21:19:03 -0400 "Martin K. Petersen" <martin.petersen@oracle.com> wrote:

> On Tue, 25 Feb 2025 20:17:14 +0000, Easwar Hariharan wrote:
> 
> > This is the second series (part 1*) that converts users of msecs_to_jiffies() that
> > either use the multiply pattern of either of:
> > - msecs_to_jiffies(N*1000) or
> > - msecs_to_jiffies(N*MSEC_PER_SEC)
> > 
> > where N is a constant or an expression, to avoid the multiplication.
> > 
> > [...]
> 
> Applied to 6.15/scsi-queue, thanks!
> 
> [02/16] scsi: lpfc: convert timeouts to secs_to_jiffies()
>         https://git.kernel.org/mkp/scsi/c/a131f20804d6

Really, an acked-by would have been much easier all around, but whatever.

Did you get my fix?

From: Andrew Morton <akpm@linux-foundation.org>
Subject: scsi-lpfc-convert-timeouts-to-secs_to_jiffies-fix
Date: Tue Feb 25 07:32:03 PM PST 2025

fix build

Cc: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: James Bottomley <james.bottomley@HansenPartnership.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/scsi/lpfc/lpfc_sli.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/lpfc/lpfc_sli.c~scsi-lpfc-convert-timeouts-to-secs_to_jiffies-fix
+++ a/drivers/scsi/lpfc/lpfc_sli.c
@@ -3954,7 +3954,7 @@ void lpfc_poll_eratt(struct timer_list *
 	else
 		/* Restart the timer for next eratt poll */
 		mod_timer(&phba->eratt_poll,
-			  jiffies + secs_to_jiffies(phba->eratt_poll_interval);
+			  jiffies + secs_to_jiffies(phba->eratt_poll_interval));
 	return;
 }
 
_

