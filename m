Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8D5D591AC
	for <cocci@archiver.kernel.org>; Mon, 18 Nov 2024 18:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=pofVBIDpbmPXxKdXBZzlW6SKJ1mpQg5f+nyOC0P54ZU=;
  b=VdR+W+KrrfTEdaW5kFbH/eVo9qUahqHZqMW3o12wYAMm4SXq5E6NjJ5B
   jiWJBV4Mk8oj4M8NEvrUm0TVYleJQpuEdbzMqIPbcn2SsREskZDPVaXGL
   urV/W85tkLlHd7kD8wY/IC45Ed+4d61vfMvc/NpvXTrZixBzgN9/AwswC
   0=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@ibm.com
X-IronPort-AV: E=Sophos;i="6.12,164,1728943200"; 
   d="scan'208";a="194516745"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Nov 2024 19:54:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7ECC1E0D1C; Mon, 18 Nov 2024 19:54:26 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 142E9E00B7
	for <cocci@sympa.inria.fr>; Mon, 18 Nov 2024 09:27:09 +0100 (CET)
IronPort-SDR: 673afa49_D9VPo2RtQE5jPu30lZ6yxcnFc1ixH7PWf21d7WQGuP9UiGM
 Oou4SJ/QC1uzAzGyiQ8Xdd/CNx8rZuDlUlUOuHQ==
X-IPAS-Result: =?us-ascii?q?A0EFAADa+TpngwWeo5RAGhsBAQEBAQEBAQUBAQESAQEBA?=
 =?us-ascii?q?wMBAQFAgT8GAQEBCwGCQ4IKBAtIjHNfiHWLc5IkgUA+DwEDAQsBAUICBAEBA?=
 =?us-ascii?q?wSFAAKKSwIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABAQEBOQcOO4V7DYJiAYEkUQ1IAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBE?=
 =?us-ascii?q?QIIYwEBHQEBAQECARIoBgEBNwEECwsOCi5WBhMigl+CQiMDA6ItQ2eBAwGBI?=
 =?us-ascii?q?EKJEgEBAXaBNIEBggwBAQbcH4FkCSuBHQGISwGFaYR3JxuBSUSBSoEGgW8+g?=
 =?us-ascii?q?VKJNYJFhQ8lhQaDeZoLUnscA1kyAVUTFwsHBYEpISwDgkd/gTaBUQGDEEqDL?=
 =?us-ascii?q?oFeBTcKP4JKaUs3Ag0CNoIkfYJPhReBC4NhZy8DAwMDgzyEBB1AAwttPTUUG?=
 =?us-ascii?q?6BLRoM0gQ+ZMAGvdoQkoUMaM4QEjQKZSC6HZJBlqH0CBAIEBQIWAYFnOoFcT?=
 =?us-ascii?q?SMVgyJPAxkPjiEMDQmDWMYmRDM7AgcLAQEDCYVDJhMLAYkRgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 NWzyyBWOXlp43y9FFFbJcvlNn6xvr8x4+n1sTPC
IronPort-HdrOrdr: A9a23:NQPGvaqoaL6EfKGKeIQWzUYaV5reeYIsimQD101hICG9vPbo7v
 xGuM5rqiMc6QxhJE3I/OrrBEDuewK5yXcY2/h3AV7mZniZhILKFvAe0WKB+UyaJ8SWzIc0vs
 oNHMYeaKySfDoK6PoSojPIaerIq+P3iJxA692uqUtFfEVScKdn4B5+CgGHVmNLZCQuP+tLKL
 OsovNdoTyuYHIWadn+IEIkcazsm/3n/aiWESLvIXYcmXyzZPeTmczH+s+jr2Yjbw8=
X-Talos-CUID: =?us-ascii?q?9a23=3AHHgzPGiQELnAooMjUCHRxRgNMTJubnbHlS7TeV6?=
 =?us-ascii?q?CAiV4So+NcgOr3YE7jJ87?=
X-Talos-MUID: 9a23:ERyI5gsMUaCYG/rmmM2nmABOFeBI6LuVIVkrtp8Jl+CfDRUsJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,163,1728943200"; 
   d="scan'208";a="194344300"
X-MGA-submission: =?us-ascii?q?MDFq3HzJmls5pK+6zW+6PDBj0vNi1d+mVOg5D2?=
 =?us-ascii?q?kMEXRYrXcb3gWAhTg1lOYmxXJZTTXnBSSvaTFFsg7QCoDieT+cqd4MuY?=
 =?us-ascii?q?muQnlHVZnM1lklWWac/oPnPKAiuOK+8aGwkKsWt0KxNEVPO7G6yFvXAN?=
 =?us-ascii?q?bcfkTfr72tDNOjy9fR2k4JlA=3D=3D?=
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 09:26:49 +0100
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AHJQVba019294;
	Mon, 18 Nov 2024 08:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=pofVBIDpbmPXxKdXBZzlW6SKJ1mpQg
	5f+nyOC0P54ZU=; b=pVJ5a4SbiQLc7KmL6NMVUat1TeAb+E4P6v1BT086o1mEhk
	asPz+d9pnH3oUetVu+XCwbjmIJgCChQ2Yg76ElBtpMc3MPIe4GEIJkdBOh3EDOTs
	BshLlGoNMECAtRDAXjrNjk0/DJ4p9T1LW6K46OwdwtMNuLDXUx7tw7C0oS59z+J9
	QShMh32WGNHKvTgEgpik3EK5hVK4TsghRPVpOZt4uDmXgH2LYgfrkGGFgYTal2qH
	dz0ScnJgPbYohwDb0fe9yXNM0o6w8EzUNqyOgMmUN0w1gT6xXC0tgw+yBkjkz/Fh
	q242Ut9KG7OxmdBC6tktol2tQuFTw331MM4YUGlg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk20r0qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 08:26:16 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AI7qspR021904;
	Mon, 18 Nov 2024 08:26:15 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk20r0qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 08:26:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI73j1E030931;
	Mon, 18 Nov 2024 08:26:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y63y27mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 08:26:14 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AI8QAR549479982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 08:26:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD6AD20043;
	Mon, 18 Nov 2024 08:26:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A867E20040;
	Mon, 18 Nov 2024 08:26:06 +0000 (GMT)
Received: from osiris (unknown [9.171.77.223])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 18 Nov 2024 08:26:06 +0000 (GMT)
Date: Mon, 18 Nov 2024 09:26:05 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Ofir Bitton <obitton@habana.ai>,
        Oded Gabbay <ogabbay@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Shailend Chand <shailend@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>, Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Louis Peens <louis.peens@corigine.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org, cocci@inria.fr,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-mm@kvack.org,
        linux-bluetooth@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org, ceph-devel@vger.kernel.org,
        live-patching@vger.kernel.org, linux-sound@vger.kernel.org,
        etnaviv@lists.freedesktop.org, oss-drivers@corigine.com,
        linuxppc-dev@lists.ozlabs.org,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Message-ID: <20241118082605.17002-A-hca@linux.ibm.com>
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
 <20241115-converge-secs-to-jiffies-v2-4-911fb7595e79@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-converge-secs-to-jiffies-v2-4-911fb7595e79@linux.microsoft.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QKHZ-v39BQg06Vofd4x3x4GU1DK_WHDZ
X-Proofpoint-GUID: NgDVBRDIQfH0SiruSUxYKOEJ-Wppx020
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=809 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1011 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411180066
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 04/21] s390: kernel: Convert timeouts to use
 secs_to_jiffies()
Reply-To: Heiko Carstens <hca@linux.ibm.com>
X-Loop: cocci@inria.fr
X-Sequence: 2079
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241118082605.17002-A-hca%40linux.ibm.com>

On Fri, Nov 15, 2024 at 09:26:21PM +0000, Easwar Hariharan wrote:
> Changes made with the following Coccinelle rules:
> 
> @@ constant C; @@
> 
> - msecs_to_jiffies(C * 1000)
> + secs_to_jiffies(C)
> 
> @@ constant C; @@
> 
> - msecs_to_jiffies(C * MSEC_PER_SEC)
> + secs_to_jiffies(C)
> 
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  arch/s390/kernel/lgr.c      | 3 ++-
>  arch/s390/kernel/time.c     | 4 ++--
>  arch/s390/kernel/topology.c | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)

...

> diff --git a/arch/s390/kernel/lgr.c b/arch/s390/kernel/lgr.c
> index 6652e54cf3db9fbdd8cfb06f8a0dc1d4c05ae7d7..68021cb38574b122bbe3d9f70e9168305360017b 100644
> --- a/arch/s390/kernel/lgr.c
> +++ b/arch/s390/kernel/lgr.c
> @@ -166,7 +166,8 @@ static struct timer_list lgr_timer;
>   */
>  static void lgr_timer_set(void)
>  {
> -	mod_timer(&lgr_timer, jiffies + msecs_to_jiffies(LGR_TIMER_INTERVAL_SECS * MSEC_PER_SEC));
> +	mod_timer(&lgr_timer,
> +		  jiffies + secs_to_jiffies(LGR_TIMER_INTERVAL_SECS));
>  }

Please don't add a new line break, especially not if the new line
would be shorter than the old one.
