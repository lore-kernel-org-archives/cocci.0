Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82ACD68BDC
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=h0tYENsGaJFO8JDAStk6yXv0HXHF9Ts4iNM+HpTmVVA=;
  b=nxHMSxGaZA8SOq2zVs802GWCCAy1rD4ZfTOE8qBi8mrwOlxzmT/09Yao
   2IrMY0OI53pjy9jwDlgAGS52qWq5UUUlph2tEQfCF2BLjpqJ7R4kJvnCD
   2BzZlH/kKpA4eqmfVJDajcbhC7SM4M6JKiplgbfiUYQPkjGgccjbVO+Ll
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@quicinc.com
X-IronPort-AV: E=Sophos;i="6.12,158,1728943200"; 
   d="scan'208";a="194170240"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:36:23 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A7FE5E0E2F; Fri, 15 Nov 2024 23:36:03 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9121BE00B7
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:31:10 +0100 (CET)
IronPort-SDR: 6737bd9e_uK2HwiUFvuxx/B8tqk3BjVKErVYZEqM2/XszaWcxsL+cfZT
 OWEwb4bw2CquF6Lo714CEG/txwVRnIqbJX5kjRw==
X-IPAS-Result: =?us-ascii?q?A0ERAADcvDdng4Oo3M1AGhwBAQEBAQEHAQESAQEEBAEBQ?=
 =?us-ascii?q?IE/BwEBCwGCQ32BDQQLSB2EOYgdX4ZRgiEDhDuYBYFWgX4PAQMBCwEBOwkEA?=
 =?us-ascii?q?QEDBIUAAopLAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBAQE5B0mFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQIIBV4BAR4BAQEDE?=
 =?us-ascii?q?hEdAQE3AQ8LDgoCAiYCAlYGAQ0FAgEBHoJaBAEBgjADMQMFDAakK0NngQMBg?=
 =?us-ascii?q?SBCiRIBAQF4gTKBAYIMAQEG3gMDBoEaLgGBYYZqAYFsg307hDwngiiBPIMDP?=
 =?us-ascii?q?oFShkyCaYJFLYRmJYh/hzoChFuNbAlJexwDWTIBVRMXCwcFgSkRECwDIm9qT?=
 =?us-ascii?q?n+BNoFRAUGCTi8bIQtcgSl9HRQGFQSBDgU3Cj+CSmlLNwINAjaCJCRZgk+BJ?=
 =?us-ascii?q?QQFg2yBC4NhZy8DAwMDgzyCTmQ6HUACAQttPTUGAwsbBqA6AUaEblBBNE+Wc?=
 =?us-ascii?q?o4La6EADYQXjBaVMgYTL5dUknouh2SQZSKLZYF4mn4CBAIEBQIXgWc6EIFMM?=
 =?us-ascii?q?xojgzdPAxcCD44hGYNhhRSKKgG2PyI1AgE4AgcLAQEDCY9XLoEdAQE?=
IronPort-PHdr: A9a23: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
 GC33p4sUUiglOx2Ig==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:BdDunaBQO7fjaaTlHek955DYdb4zR+YMi2TC1yhKOHhom7+j5r
 mTdZMgpGXJYVcqKQodcLW7UpVoLkm8yXcY2/h2AV7mZnifhILKFuFfBOnZrQEIcheWnoUxuc
 hdmupFebrN5DNB/KTHCWeDYrMdKZW8gcOVbbC09QYQceg8UdAc0y5JTj+BFEt4XQ9HAod8Oq
 a9y6N81kudUEVSV9+8AHYdWejFupnsr7LJJTA7JzNP0nj/sduPgISKYSRwGi1uLUI9/Z4StV
 Duswvl6r6lu/TT8G6i61Pu
X-Talos-CUID: 9a23:OdFE9m6y7K+3sttpatss6h4tRs8oKyfk0ynIBReEIkNQGe24RgrF
X-Talos-MUID: =?us-ascii?q?9a23=3AjU1oOQxGRcF6PnmhYCexG8y/9BSaqJSOS0IX0st?=
 =?us-ascii?q?FgPmvFjdLJhidlgy5bZByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="194166260"
X-MGA-submission: =?us-ascii?q?MDFNCtkZE9AFupQQo8yuCy3DLmBE95XHKWLv9P?=
 =?us-ascii?q?1bil7lq16dD+rkpvMfHeIyhAQWgoqG2r+6YfxEUezsUkb26mjiREMsjd?=
 =?us-ascii?q?1FbOgdwtM0KNT9La2jrPsZ2TVozak/9RfOd12I0nnCSWLnj+5YIAGiez?=
 =?us-ascii?q?KXYXMNcg/MxkEeWGU3CnOF8w=3D=3D?=
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 22:31:09 +0100
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFBRrRp005627;
	Fri, 15 Nov 2024 21:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h0tYENsGaJFO8JDAStk6yXv0HXHF9Ts4iNM+HpTmVVA=; b=ECCtKwq6Cy4NLuZL
	j2WUeZYNsdHGYwCwotl4/Q3JJFWUcWHz7gsSnNDB+iL7po1zl5LllV34Rd8BicSR
	9ZhaW0psyAjm90yO+xdBZAQR2N+BNsxWv7rLBNXjlQiIPWBa1yvitZRPCxTpPbfw
	Cg+cd7DCPZpNjEahimwlyHuvXlt8vqPlFUL5VktjnMqhWF5hDijj5bAtLxhAD0oc
	D1i3vFAs+GUMNPK5b3Rv4wJqmmGh4qZDucIdWFwnin1FB9/KAmxpYybkULOapKD8
	Gey6OqqdHevsuhCW6YMpiT4CXpP2hs6x9/0dOyqFe/2DN0Iw3Eca3M+RZSonp9bg
	YT7Xyw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42wex8wcg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 21:30:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AFLUgSW012417
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 21:30:42 GMT
Received: from [10.111.176.23] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 15 Nov
 2024 13:30:38 -0800
Message-ID: <e1ff4b71-7abf-4ac6-8b82-86aad5394de6@quicinc.com>
Date: Fri, 15 Nov 2024 13:30:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
        Pablo Neira Ayuso
	<pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix
	<nicolas.palix@imag.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang
	<haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell
 King <linux@armlinux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle
	<svens@linux.ibm.com>, Ofir Bitton <obitton@habana.ai>,
        Oded Gabbay
	<ogabbay@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo
 Vivi <rodrigo.vivi@intel.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Shailend Chand
	<shailend@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        James Smart
	<james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James
 E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen"
	<martin.petersen@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
	<roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>, Kalle Valo
	<kvalo@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jack
 Wang <jinpu.wang@cloud.ionos.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui
	<rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Xiubo Li
	<xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Josh Poimboeuf
	<jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes
	<mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
        Joe Lawrence
	<joe.lawrence@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King
	<linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner
	<christian.gmeiner@gmail.com>,
        Louis Peens <louis.peens@corigine.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao
	<naveen@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
CC: <netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cocci@inria.fr>, <linux-arm-kernel@lists.infradead.org>,
        <linux-s390@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <intel-xe@lists.freedesktop.org>, <linux-scsi@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-mm@kvack.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-staging@lists.linux.dev>,
        <linux-rpi-kernel@lists.infradead.org>, <ceph-devel@vger.kernel.org>,
        <live-patching@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <etnaviv@lists.freedesktop.org>, <oss-drivers@corigine.com>,
        <linuxppc-dev@lists.ozlabs.org>,
        Anna-Maria Behnsen
	<anna-maria@linutronix.de>,
        Michael Kelley <mhklinux@outlook.com>,
        Thomas
 Gleixner <tglx@linutronix.de>,
        Luiz Augusto von Dentz
	<luiz.von.dentz@intel.com>
References: <20241115-converge-secs-to-jiffies-v1-0-19aadc34941b@linux.microsoft.com>
 <20241115-converge-secs-to-jiffies-v1-22-19aadc34941b@linux.microsoft.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241115-converge-secs-to-jiffies-v1-22-19aadc34941b@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: h43h8EgANEiwtjVrnKtKVRWKc8bYM2XJ
X-Proofpoint-ORIG-GUID: h43h8EgANEiwtjVrnKtKVRWKc8bYM2XJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=893 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411150180
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 22/22] jiffies: Define secs_to_jiffies()
Reply-To: Jeff Johnson <quic_jjohnson@quicinc.com>
X-Loop: cocci@inria.fr
X-Sequence: 2050
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/e1ff4b71-7abf-4ac6-8b82-86aad5394de6%40quicinc.com>

On 11/15/2024 1:22 PM, Easwar Hariharan wrote:
> secs_to_jiffies() is defined in hci_event.c and cannot be reused by
> other call sites. Hoist it into the core code to allow conversion of the
> ~1150 usages of msecs_to_jiffies() that either:
> 
>  - use a multiplier value of 1000 or equivalently MSEC_PER_SEC, or
>  - have timeouts that are denominated in seconds (i.e. end in 000)
> 
> It's implemented as a macro to allow usage in static initializers.
> 
> This will also allow conversion of yet more sites that use (sec * HZ)
> directly, and improve their readability.
> 
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Link: https://lore.kernel.org/all/20241030-open-coded-timeouts-v3-1-9ba123facf88@linux.microsoft.com

your signed-off-by should be last.

and you have a patch ordering problem since this patch must come before all
the patches that use secs_to_jiffies(), otherwise this series cannot be bisected

