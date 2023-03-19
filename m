Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB83C7618A
	for <cocci@archiver.kernel.org>; Sun, 19 Mar 2023 14:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+l5VlC184Y681yK1HWjn5Zgi7sHACk6rdch8DUbPtcs=;
  b=alR/f4YKCW4U5j0tHodHLRziqzN3LccFtS1H2uOnQT/t4ZPRNi/szJK7
   8AttjV20RoLiSHo3bXItMoeHeQ9VhpUCXzCzaV3afJZohNiITLk1gTpAE
   o1CGLSzcM7xKTKTGrUEHwwQqJRjvQud5yc/nXQyz3T3sHv3bXI/y8igFM
   0=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,273,1673910000"; 
   d="scan'208";a="97942357"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2023 15:00:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C3102E0AEF; Sun, 19 Mar 2023 15:00:30 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 08BDDE0A9B
	for <cocci@sympa.inria.fr>; Sun, 19 Mar 2023 15:00:29 +0100 (CET)
IronPort-SDR: 6417157c_qhCSXh2SrWMY+I46Tgk9DE8j7aYD//sLADmtSIEyV7z6CY8
 PT0cnOc5SW5ZIt79/8eOrnq0zWP0dKc9REbxWsQ==
X-IPAS-Result: =?us-ascii?q?A0GzDQApFBdkh07ASNlaHgEBCxIMQIFEC4IudVYvBAtGh?=
 =?us-ascii?q?FOPCoF3gRqDRo5mhGeEAoFWgUA+DwEDAQ09BAECBAEBAwSEfgKFNQIdBwEEM?=
 =?us-ascii?q?gcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBGAsXBw4FC?=
 =?us-ascii?q?wUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICDToYOz0DA?=
 =?us-ascii?q?yMEGQEBESYBDwsaAiYCAlcGAQwIAQGCegGCJwEDMQcMszR/M4EBgggBAQacC?=
 =?us-ascii?q?h8sIlOBXgMGgRQsjG0XgzZ6Jw+BVUSBFSeDAz6CSxcEGIFGg1iCZ41zix0Kg?=
 =?us-ascii?q?TR1gSAOgT2BBAIJAhFrgRIIZ4F9QQINZQsOdoFLAmVPJyUEDgMZKx1AAgELO?=
 =?us-ascii?q?zo/NQYDCyEGWGsCCSMREwUDCxUqRwQIOQYcNBECCA8SDwYmQw5CNzQTBlwBK?=
 =?us-ascii?q?QsOEQNPgUcEL158CgYBJiSdDIEjGCDFUDQHgiiBVYFZDIoMlQAGEy6XCA4Gk?=
 =?us-ascii?q?iMuhy2KUoU9II0ymkiBaQcsgVwzGiSDNk8DGQ+OIBmEDIRhiigBPUA0AgEBN?=
 =?us-ascii?q?wIHAQoBAQMJhUYBAYV7AQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 N0BgKbOx8kwsfSovCgQOOjeYzo=
IronPort-HdrOrdr: A9a23:7PM9Sa9JAgJLH6Jrhspuk+AMI+orL9Y04lQ7vn2ZhyYlF/Bw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObOEYZmIbsS+V2njbL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,273,1673910000"; 
   d="scan'208";a="50609310"
X-MGA-submission: =?us-ascii?q?MDEbrCbn5qbB/EO6pjFWZFUTCqrtcmoVV8sjDf?=
 =?us-ascii?q?ywtajzEF/9PCnJ2S+uBH9ijYo7qizd4HbSvL+r5DU1H1iiEedENqMLCi?=
 =?us-ascii?q?HhnAbLsSqECuvrASVV/MtRN+Ki7lnKfZ6RBr0eR+SoY2P9ocYouLS0XM?=
 =?us-ascii?q?ekJ5K8lt5XxsdkQImr7OR8FA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 15:00:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679234421; i=markus.elfring@web.de;
	bh=+l5VlC184Y681yK1HWjn5Zgi7sHACk6rdch8DUbPtcs=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OhUC/JDHlg66peLyWCZdg81Nqpa+k5IgaiRonen2bIzBKAhYqaqYGLyrZm4pTvF86
	 yguckOuJYxxIBQLOjrdZj2MMYyQpM8AdXFeUQrj4eeRyfMLymS+2ZFrKzP5YopaY2B
	 +4ElaVSBixPWOo55s9z9wjk7N4Qq0GTJXAxSSmgcu/p/Y4/hEh/SB51VTO5ozbYzW8
	 GXPfeOeqnm+MLZduI49VNNszfjH6MSP8t4EIvxf+sW6gYvXfKIqUAEKXII8emXx2hG
	 TH0guu0NMKGGgsKoo0MMp8CQblj4Wi/LqcyBbQyCG6MSNF6TY95mjvbN+LByaIOvY0
	 Q1T/o9Q1S6GgA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLifq-1pvYxR35gO-00HquY; Sun, 19
 Mar 2023 15:00:21 +0100
Message-ID: <425606aa-13c3-0d67-542d-c1a40f4205d9@web.de>
Date: Sun, 19 Mar 2023 15:00:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
To: Cheng Xu <chengyou@linux.alibaba.com>, kernel-janitors@vger.kernel.org,
 linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Kai Shen <kaishen@linux.alibaba.com>, Leon Romanovsky <leon@kernel.org>,
 Yang Li <yang.lee@linux.alibaba.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <f0f96f74-21d1-f5bf-1086-1c3ce0ea18f5@web.de>
 <167179d0-e1ea-39a8-4143-949ad57294c2@linux.alibaba.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <167179d0-e1ea-39a8-4143-949ad57294c2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rGbArgSty3bg6YdNte+FmbDfKFy90QZP9d/WRcvQn+d34c0+Ell
 YDdWMts/v0PZlr5K24wDYXn+vjNlTzx4o1iksxtFfKFHC5nS4xtB62i8dRuKxh9DLOZPSZB
 Pgf3okwu3li7KHlbxFdOIiLSGVNlPTbmEIbAltrKJ+xVeRo91M2XrMhD48uIQdzsI8MNaoq
 dqEPLPBanb7NE+Gz819Ww==
UI-OutboundReport: notjunk:1;M01:P0:L0D1uohwLzY=;uhHr/WRe2VoYOT860fD2oF3gIzm
 3A95TvBNz/m8kYfc140wR3NQSLzfDkXKZ3Iz5hFgkjkbHMHL+0MBsQ+kbaTcNC/x+SvtEaSia
 +NQCnYJBTbqVnS+k8QqABuZdER6BdIO0C2B5J+ePJaHoBlQBQkLbCiR5MQ9adQFN9T/pb1Vsm
 18PTa5RNpOh1mbHKuUfywpGrjzfBw+oxZ3SXoHX5T59+KyBuNu+nfTIJ1dnzor3ScXSxgEYK+
 4UAY3h+6FyZIIsUfLn2iOXFaLt578oCCXVOovHUNOQtrgod6B+bdRw0/o0ia7WllPXMmTM1IA
 +1vol5hg83o//KJjaVfeUVK7igf619Pg2GgFjbnUz91aHK/qU79MlLbJ7J0Jta6zf4Yea2hyN
 UjOpWbcb94+RyEYaRAl7uCAaAlEW4vsm/HSPeBCzWsOL24bBwovOoDON9CBNyxl8WDoHuySz5
 LaIbjvjVjeySZO3pKdJtgw4DBwaEpOKPGiVQ3nDRdBbjJXmpTevx9yfVd1d8ScWCfohT3TX0F
 b2/TIypLhio0Bm9BmlVVzhSr5fOoqoIzvsf26tv/Cp/deU1ddEFcr56c32GmSxq18FbCI0pK9
 9f1JjgQEFuVm/jLYKf8dsH8MAm1737TiWS8GXqUDDbxD8E+DBvQyeuRSRPxdn/bqR7v5gpwyA
 PzyWwp/AE4F8umyf3qjPuXpbPzIYTVNDrCxKpl+c5XU0+pUlJgI6PM22QPQilTw1lGz9rTnSk
 4ByOlZ2kkrJ9/LU/wXXS89BfIsVz9qRMA+Y1C45bDld3/GnDzDiYoLRJ+O8VEZI8pc6Kgbtm7
 ORDv/b6UPGwzzwDvi9WKYNIB4BmIgiOS/tJusLkQIPhWMCi8KEOgErXcLrBCN/CN3yYp2KVs+
 HVydBdxAJIDLs/1TAxVFv0HhDFkGhRbpKDacDxkN/cP79vdCqUkeb1Tf5JsluDnBMazHYFHJk
 VHokLQ==
Subject: Re: [cocci] [PATCH] RDMA/erdma: Fix exception handling in
 erdma_accept_newconn()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 898
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/425606aa-13c3-0d67-542d-c1a40f4205d9%40web.de>

>> +disassoc_socket:
>> +=C2=A0=C2=A0 =C2=A0erdma_socket_disassoc(new_s);
>> +=C2=A0=C2=A0 =C2=A0sock_release(new_s);
>> +=C2=A0=C2=A0 =C2=A0new_cep->state =3D ERDMA_EPSTATE_CLOSED;
>> +=C2=A0=C2=A0 =C2=A0erdma_cancel_mpatimer(new_cep);
>> +put_cep:
>> +=C2=A0=C2=A0 =C2=A0erdma_cep_put(new_cep);> +=C2=A0=C2=A0 =C2=A0new_ce=
p->sock =3D NULL;
> Thanks, but this causes an use-after-free issue because new_cep will be
> released after last erdma_cep_put being called.


How do you think about to omit the statement =E2=80=9Cnew_cep->sock =3D NU=
LL;=E2=80=9D then
which I preserved (in my change suggestion) according to the currently act=
ive source code)?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/infiniband/hw/erdma/erdma_cm.c?h=3Dv6.3-rc2#n702

Regards,
Markus

