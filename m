Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78583D68BE8
	for <cocci@archiver.kernel.org>; Sat, 16 Nov 2024 11:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qNk0UpPCfP9jVOvfKBxvQukY6QfemQfuOfHWSW3FEps=;
  b=rrxOkZVEy2Rkkz1/HrOMvRfn2nF22i541rHxy1CCn33U+q/baHTa5QnE
   Ag3wawTopekC4lyZc8tqccRxVqNMYgdIfnusZVqB6cxh77sP65l03bFUg
   jx53m26HBBxJUTdsIikLfnVH6H1z3uU7+rXObpHjGrLdmYGeNFDbpIHuR
   w=;
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
X-IronPort-AV: E=Sophos;i="6.12,159,1728943200"; 
   d="scan'208";a="194204499"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2024 12:26:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DB637E0D65; Sat, 16 Nov 2024 12:26:23 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 46DD2E00B7
	for <cocci@sympa.inria.fr>; Sat, 16 Nov 2024 00:00:38 +0100 (CET)
IronPort-SDR: 6737d281_XWr8g9/ox82jK1fkiNaNmAwWNV3c4hOM065+C+s+mCMjWow
 11+DDNcFj1BAThE+bXRgmCSF5hHHC/ckQ6J1RqQ==
X-IPAS-Result: =?us-ascii?q?A0ERAABB0jdng4Oo3M1AGhwBAQEBAQEHAQESAQEEBAEBQ?=
 =?us-ascii?q?IE/BwEBCwGCGyiCCgQLSB2EOYgdX4ZRgiSEO5gFgVaBfg8BAwELAQFEBAEBA?=
 =?us-ascii?q?wSFAAKKSwIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABAQEBOQdJhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CCGMBAR4BAQEDEhEdA?=
 =?us-ascii?q?QE3AQ8LDgoCAiYCAlYGAQ0FAgEBHoIHWIJlAwWkN0NngQMBgSBCiRIBAQF4g?=
 =?us-ascii?q?TKBAYIMAQEG3gMJgRouAYhLAYFsg307hDwngiiBPIEUgW8+gVKCOIQUgmmHW?=
 =?us-ascii?q?CWIf4dGh0OLBglJexwDWTIBVRMXCwcFgSkRECwDIm9qTn+BNoFRAUGCTi8bI?=
 =?us-ascii?q?QtcgSl9HRQGFQSBDgU3Cj+CSmlLNwINAjaCJCRZgk+BJQQFg2yBC4NhZy8DA?=
 =?us-ascii?q?wMDgzyCTmRKHUACAQttPTUGAwsbBqBERoMuB4EOmTKOC2uhAA2EF6FIBhMvh?=
 =?us-ascii?q?ASTUJJ6LodkkGUigjShA4UkAgQCBAUCF4FnOoFcMxojgzdPAxcCD44hGYNhj?=
 =?us-ascii?q?z4BtjEiNTsCBwsBAQMJjyM0LoEdAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:OTkhGaE28+l7DUjKpLqEeceALOsnbusQ8zAXP0AYc20wTiXqrb
 HWoB19726PtN9xYgBapTnkAsO9qBznlKKdjbNhW4tKGTOWwFdAT7sD0WKB+VPd8kTFn4Y3uM
 sOT0E9MqyWMbEQt7eZ3ODXKadE/DDKytHKuQ+IpE0dMT2CPJsQkjtRO0KjCUtxSxBBBZ0lUL
 ShxucvnUvRRV0nKv2hAH8LRu7CoMCOsqnHT1opOz4LgTP+/A9BztbBYmqlN9MlIk0/sosKwC
 z8uSz/+6m5tPm/oyWsqFPu0w==
X-Talos-CUID: 9a23:6ZIdE2OP6tiYEu5Dd25H8kgsC8MeTieBkWzCE3KHFnlLYejA
X-Talos-MUID: =?us-ascii?q?9a23=3AFhhfQw9A0bQ/QypChWeuq7eQf9Zs44iiDEAsqpg?=
 =?us-ascii?q?DhMCnZCxIGQzHjh3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,158,1728943200"; 
   d="scan'208";a="194171591"
X-MGA-submission: =?us-ascii?q?MDF57/iFL/a1YYkX4qU3xneX2HTiE261EAa3qQ?=
 =?us-ascii?q?2gdANESmb/9wdtH5Lvdl3g78RyA+4imGmjxCGKmqD3+VOLPrThdGI01F?=
 =?us-ascii?q?WGhsn7GkjuxYIU3ZYhMELK7hjYqXcug+u5S82ZiTBrtlYEHnJkM2tAAr?=
 =?us-ascii?q?1DEG+BhvxTWJNw7xmtluMG4A=3D=3D?=
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 00:00:17 +0100
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFGrkEN010333;
	Fri, 15 Nov 2024 22:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qNk0UpPCfP9jVOvfKBxvQukY6QfemQfuOfHWSW3FEps=; b=XgPHjXXU5/THf7Zv
	KSmEXbUKuVLvM2dvj9amuR/JpE4K7+0IZR+xH9KidBF9+O9FKfr4/RUa/5gBJ298
	8bu5+Pifed2F8BrM6Oj34ss7B6Y5ixfwwTCGx3ktfPO3tYNyIm+GzJX1Har9+TZ4
	4wo2SothME4kGgPVm+iavuzfNOA1bUUjgotBOhuR+MSwdpD83jTCA42dW+fTyNsK
	0Y7MINWD+oYbpCz6GaMvi+6nMNjQF5NolpB3yUFR7K5UpAeriFXlTu2nWQWaBMqt
	XRR46sptjfsXIH4xCJQEeuBlwiD0DiBQ6ykoF2SjYaU/c5KX5zmumxMdD4uA+akh
	YLxA7A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42xa7ngs0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 22:59:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AFMxttC025526
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 22:59:55 GMT
Received: from [10.111.176.23] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 15 Nov
 2024 14:59:51 -0800
Message-ID: <d2d2c07b-666d-4b37-a428-2d73ce8aeb5b@quicinc.com>
Date: Fri, 15 Nov 2024 14:59:51 -0800
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
	<anna-maria@linutronix.de>
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
 <20241115-converge-secs-to-jiffies-v2-15-911fb7595e79@linux.microsoft.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241115-converge-secs-to-jiffies-v2-15-911fb7595e79@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9NJi18BY7F7RS1ijvJie2T9SzXH5WHC4
X-Proofpoint-GUID: 9NJi18BY7F7RS1ijvJie2T9SzXH5WHC4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411150193
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 15/21] wifi: ath11k: Convert timeouts to
 secs_to_jiffies()
Reply-To: Jeff Johnson <quic_jjohnson@quicinc.com>
X-Loop: cocci@inria.fr
X-Sequence: 2058
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/d2d2c07b-666d-4b37-a428-2d73ce8aeb5b%40quicinc.com>

On 11/15/2024 1:26 PM, Easwar Hariharan wrote:
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

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>  drivers/net/wireless/ath/ath11k/debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
> index 57281a135dd7fa6b8610636f47873c8bba21053c..bf192529e3fe26a91e72105a77b4c6f849b905ec 100644
> --- a/drivers/net/wireless/ath/ath11k/debugfs.c
> +++ b/drivers/net/wireless/ath/ath11k/debugfs.c
> @@ -178,7 +178,7 @@ static int ath11k_debugfs_fw_stats_request(struct ath11k *ar,
>  	 * received 'update stats' event, we keep a 3 seconds timeout in case,
>  	 * fw_stats_done is not marked yet
>  	 */
> -	timeout = jiffies + msecs_to_jiffies(3 * 1000);
> +	timeout = jiffies + secs_to_jiffies(3);
>  
>  	ath11k_debugfs_fw_stats_reset(ar);
>  
> 

