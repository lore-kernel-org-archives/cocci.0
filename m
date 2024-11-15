Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D45D68BDB
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:cc:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wnbSeh3nrxkUpLpUNInI53zipJdSc2F6sttOVAgMzpE=;
  b=BMXc2yhPtOnwAL2C3TRBb5CrM9hXK5Z48UlDuuiBhKB2Y40/H5fLT5Wv
   BAn2zA4SImzooMSEb1VOdgtVAil3vAciUG7QqqI7YxoYttxNIJ1smKaHR
   Il+UjGWsXSctNXVl5K1G0SxZFJpwS6pWpHD1TD7ycrFk4IFX/ruNWEg3y
   k=;
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
X-IronPort-AV: E=Sophos;i="6.12,158,1728943200"; 
   d="scan'208";a="194170213"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:36:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 30E4CE0D8B; Fri, 15 Nov 2024 23:36:03 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D5940E00B7
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:29:14 +0100 (CET)
IronPort-SDR: 6737bd2a_pb1TMZ1Xuw+/Ecgrplf77vTFixYXty6rHAqs77nG2b+bZSF
 uB2FyjL3Dyto0y2F4PBhN3GVSj6kngGmw9QYNJQ==
X-IPAS-Result: =?us-ascii?q?A0EhAADnuzdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDfVozBwhIBIRSiB2JUQOLc5BNgVaBQD4PAQMBSAYBAgQBAQMEh?=
 =?us-ascii?q?QACiksCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?YEMhXsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeA?=
 =?us-ascii?q?QEBAxESHQEBNwEPCxgCAiYCAlYGARICAQGCfQGCZAMDAgwGnzkBh2ABAQKLI?=
 =?us-ascii?q?4EygQGCDAEBBtwfgWQDBoEaLgGBYYZqAYVpGyCEPCcbgUlEgTwLA4J1PoRYg?=
 =?us-ascii?q?0aCaYJFhRMlTYgyjBeNZ1J7HANZIREBVRMXCwcFgSkRECwDIm9qTn+BNoFRA?=
 =?us-ascii?q?UGCTi8bIQtcgSl9HRQGFQSBDgU3Cj+CSmlLNwINAjaCJCRZgR2BMoElBAWDb?=
 =?us-ascii?q?IELg2FnLwMDAwODPIJOZDIdQAIBC209NQYDCxtDn3kBRoJCgixQIx6BAjekR?=
 =?us-ascii?q?2uhAIQkjBaVMgYPBC+XVJJ6LodkkGUii2WBeJVzhQSCGDqBXEYHIxWDIk8DG?=
 =?us-ascii?q?Q+OIYN6hRSKKgG2PyI1AgE4AgcLAQEDCYVGAQGKD4FLAQE?=
IronPort-PHdr: A9a23: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
 n90kwznTKMyQySbv1jAy2I/d+gdclBv0Lo=
IronPort-Data: A9a23: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
 wSR
IronPort-HdrOrdr: A9a23:nzH7ZaMxo6uAScBcTvGjsMiBIKoaSvp037Dk7SBMoG9uA6ilfq
 eV7YwmPH7P+U8ssBNJo7q90cy7LE80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 xdmupFebjN5DNB/KXHCWeDYrQdKZW8kZyVuQ==
X-Talos-CUID: 9a23:6THISWPBehxqLu5DSW5m2EUSPfIZdUaa/jTdA1OeBUxGV+jA
X-Talos-MUID: =?us-ascii?q?9a23=3Afo8QqwxWfXsLqXp8vfm3usgRT5maqPmgUEcOqa1?=
 =?us-ascii?q?Fge6BLi4pfBi0qyaMaYByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="194166155"
X-MGA-submission: =?us-ascii?q?MDHaEskZY4c3X9FXs/NvWbI/0vvC61+bA4bsjy?=
 =?us-ascii?q?AACdrq++SokvL5u2qjOkDTo03nkAstiofAykggsJ/U8q1MOE7E/3xjw9?=
 =?us-ascii?q?vJd6JChkOiqeshnan1jHu7dQShBRSPpuKup3A1AMWgiEWMfNWvQNK70I?=
 =?us-ascii?q?ai8hVfmn6/lhNp917kOUuBpA=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 15 Nov 2024 22:29:13 +0100
Received: from [192.168.35.166] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id B73912064AE5;
	Fri, 15 Nov 2024 13:29:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B73912064AE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731706152;
	bh=wnbSeh3nrxkUpLpUNInI53zipJdSc2F6sttOVAgMzpE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Ln07f5EjuuPfHntHC8suz+6+bwoC2E7y6o04KXRcULiHkp6gj2wE4/Oxay8L3v7dX
	 32Fibc4wGoz91tHZWM06yjj0Mb1XO7WrI+T+Asla6tiIZ1Uqdsk33jPpXiuJrOb0nL
	 YRieCLrDI2dHjOFiqFcQWPRpE20rYHgeg/0+hfKE=
Message-ID: <10ee4e8f-d8b4-4502-a5e2-0657802aeb11@linux.microsoft.com>
Date: Fri, 15 Nov 2024 13:29:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, cocci@inria.fr,
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, linux-mm@kvack.org,
 linux-bluetooth@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-rpi-kernel@lists.infradead.org, ceph-devel@vger.kernel.org,
 live-patching@vger.kernel.org, linux-sound@vger.kernel.org,
 etnaviv@lists.freedesktop.org, oss-drivers@corigine.com,
 linuxppc-dev@lists.ozlabs.org, Anna-Maria Behnsen <anna-maria@linutronix.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, Daniel Mack <daniel@zonque.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Russell King
 <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Ofir Bitton <obitton@habana.ai>,
 Oded Gabbay <ogabbay@kernel.org>, Lucas De Marchi
 <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Shailend Chand <shailend@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Jens Axboe <axboe@kernel.dk>, Kalle Valo <kvalo@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jack Wang <jinpu.wang@cloud.ionos.com>, Marcel Holtmann
 <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Xiubo Li <xiubli@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Louis Peens <louis.peens@corigine.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 00/21] Converge on using secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2049
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/10ee4e8f-d8b4-4502-a5e2-0657802aeb11%40linux.microsoft.com>

On 11/15/2024 1:26 PM, Easwar Hariharan wrote:
> This is a series that follows up on my previous series to introduce
> secs_to_jiffies() and convert a few initial users.[1] In the review for
> that series, Anna-Maria requested converting other users with
> Coccinelle. This is part 1 that converts users of msecs_to_jiffies()
> that use the multiply pattern of either of:
> - msecs_to_jiffies(N*1000), or
> - msecs_to_jiffies(N*MSEC_PER_SEC)
> 
> The entire conversion is made with Coccinelle in the script added in
> patch 2. Some changes suggested by Coccinelle have been deferred to
> later parts that will address other possible variant patterns.
> 
> CC: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> 
> [1] https://lore.kernel.org/all/20241030-open-coded-timeouts-v3-0-9ba123facf88@linux.microsoft.com/
> [2] https://lore.kernel.org/all/8734kngfni.fsf@somnus/
> 
> ---
> Changes in v2:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v1: https://lore.kernel.org/r/20241115-converge-secs-to-jiffies-v1-0-19aadc34941b@linux.microsoft.com
>

Apologies, I missed out on editing the changelog here. v1 included a
patch that's already been accepted, there are no other changes in v2.

Thanks,
Easwar
