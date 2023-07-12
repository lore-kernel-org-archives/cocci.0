Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AA1EB64D9
	for <cocci@archiver.kernel.org>; Wed, 12 Jul 2023 07:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9yxLzqqoTu1hh3mSKDek/dT+ntWKWbYAc5cRJ6U51GU=;
  b=HJhl22EH5bd4S4XsoJVoA96/O6zd8mwt/ywdgsbfgUhg5RncyNmxJmJ9
   ICd64rwvA6zF1nW6xoqHk6j/FbjPtOdr1hP6jUakXEiLQF7zi5FgdW+6q
   vaXZ0uHC8P8VpKHvzX7ZmY0l+s+76j1FcQ6DsmnYqWFjmiHWuJrESQlCX
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.01,199,1684792800"; 
   d="scan'208";a="117211670"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jul 2023 09:12:30 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BB85DE004E; Wed, 12 Jul 2023 09:12:29 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 47E5DE0133
	for <cocci@sympa.inria.fr>; Wed, 12 Jul 2023 09:12:26 +0200 (CEST)
IronPort-SDR: 64ae5259_46aWZbKVWPcnMtdIs+vYpg70oLRbJ8Ji8pOmTJ+ABv9lL3K
 Dh0xgYdUOHhHQpy+9X+SjdO9I+8B7bxlnIH7j2A==
X-IPAS-Result: =?us-ascii?q?A0F4CAD4UK5khwwR49RaHgEBCxIMQIFEC4IzdQNTMAQLR?=
 =?us-ascii?q?wSETpFaA4Q2hx+HWoRphASBVhSBLD4PAQMBDTQNAQIEAQEDBDiEAUYChiECH?=
 =?us-ascii?q?QcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBIxcHD?=
 =?us-ascii?q?gULJ4VoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBFwINOj8BAgIBIx0BA?=
 =?us-ascii?q?REmAQ8LGgIfBwICISURBgEMBgIBAYJ6AYInAQMOIwcNqGqBMoEBggkBAQavV?=
 =?us-ascii?q?B8sIlWBXwMGgRUth2IeAYMigVxDgzt6Jw+BVUSBPIMEPoIgKxcBAxiBEQESA?=
 =?us-ascii?q?SGDW4JnjiOFVgeDUoopgSdvgR6BHnoCCQIRZ4EICF+Bbj4CDVULC2OBHFI5g?=
 =?us-ascii?q?UICAhEnExQFTngbAwcDgQUQLwcEMgcWCQYJGBgXJQZRBy0kCRMVQQSDUwqBC?=
 =?us-ascii?q?D8VDhGCUCs2OxtNgmoJFw41B0x+EDEEFB2BEQQOAxkrHUACAQtwPTUGAwsbB?=
 =?us-ascii?q?kICJ4FXMFRwJCSifQOCNjBEgRUkgV5UCawyl0Q7NQeCMYFdgV0MihSVCQYTL?=
 =?us-ascii?q?5cVDgaSMC6HQJA4IItLgXSWMIQvgWM6bHAzGiSDNhMMMAMZD44gGR6DcIRhi?=
 =?us-ascii?q?mc/NAIBCDACBwsBAQMJhUYBAYYAAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 c42ohXNA/R6/n2lqSv/KBB2bSeLC842Hk41xH0=
IronPort-HdrOrdr: A9a23:GMvek6HhQnaGVzCxpLqEPMeALOsnbusQ8zAXPo5KOHlom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAsxD4bbLbWSS4/yKgjWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3AOmSYTmskED6nyUk6+cISsR7K6IsZX3jDnSfAMnS?=
 =?us-ascii?q?ySjtZVb+JFXSP1Z5rxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AKvDeig3ZYcRBL9oao37jbq0/ezUjyavyGGEItJQ?=
 =?us-ascii?q?6sJOaNmsoNQiDlA67e9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,199,1684792800"; 
   d="scan'208";a="61198438"
X-MGA-submission: =?us-ascii?q?MDG7n9EXrsClpFhg5tMQd3Xu1EOkqSUU2TJlUP?=
 =?us-ascii?q?8cKEVhgg9ycWhI+BMxdtHe/jRz+dty2prb5dJrBctkVfGS1rep0oFAau?=
 =?us-ascii?q?fIH7/qtPUx3QWQbCZffd+cCWqkU0jXHir6ElfGxIuGKd3gG1uVblTsFE?=
 =?us-ascii?q?AzIRQq1pZdQKmxHekZB9zf6g=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 09:12:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689145940; x=1689750740; i=markus.elfring@web.de;
 bh=ka47nA1pHrHZoUIpzgA7YMmScd195c8oe90t/DUyUjU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=EunQt7pqbPdxUGObntpTyFlWnIabm1R0RBPydmfgI5DZx3L5svLr4cBzk3xtqc9viOyHjfs
 eDjNsIa64QjqwIrwfiiWc2b7OTxMuNf9gNVT8wEnChXI+7/hIfGAmHnsGXMZCiyy/hZXq+8d3
 zKJUWwjGsYsszzbf4pKwIHBwWeqShbaRn0DnSFLSnieQujuBz52zPtEI3JalIMj+fhIu49IgK
 UKXkxTEK1Lql4kUA/UePqMFdDld0RY2HqBdWALaxbtKlRyiao7u0GWirCOIxWbnvzBUgxaqXr
 u3cPCu6JQuWhF9YHYIzspuqYCV5AlrM133Wn8J9tzUDoTXF75fzA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqqTb-1pgJik3njV-00mWxG; Wed, 12
 Jul 2023 09:12:19 +0200
Message-ID: <fd1959e5-b0c7-0d0a-d037-d5e05b550765@web.de>
Date: Wed, 12 Jul 2023 09:12:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-GB
To: Sean Christopherson <seanjc@google.com>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicolai Stange <nicstange@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Julia Lawall
 <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230710170652.473788-1-seanjc@google.com>
 <a1679697-827b-0e3a-0948-c84510fcbecc@web.de> <ZK1jYI/wyaxWnXrz@google.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZK1jYI/wyaxWnXrz@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4LCIdoCvOSXSil6kJfNuuAEe9X+H32NYY6pcSugRqZoaKEmqG5o
 O1AuuCqYTaRd790XdlwkEnbPHTVN2ECi4adyE0Hgj8ycCd4pGZNMZI7VmEkNc+fGhotD/BG
 EwQQ2q8U6AECBtXc0bpnkWcVx8qlIBER/dGyC3cpIYmLX2KPEFUu1G/S9g87+nBseuJi95P
 TCW2bWS440xZpwivmkGkQ==
UI-OutboundReport: notjunk:1;M01:P0:4crXLZoUj3E=;jyhafow9sTzA0TebU3kVciSuDWY
 2RLN/nSkaZr5rk/UDLMRmYHr0Od4j1tJn2Qci0Qf39BYl3gCJDKYQgUwMdnwoXzQB+/YZuUhw
 igzowU0szWfdoeZfMmfpVxlWlr2GkP/LSv0GIKS2Sz+nSGPQeQpS3Ea/S8dvQMV70WZ54Aig5
 NaBct64NEuTiQSGvYAPt+AN2N/8lmxq3kOfl06mPT5HFEqzqtGMWd0jEczKPfoaBX+Sf+ukSp
 +t73D155Qd9WFCgpTSZ5JKeAiWEe4WH/naa7P9H7yaaxpsct0KHBK8nuXt6OzquCL9LgOii2g
 /DWQqeQKxb8WCVgu6p26osyVPEOcrcU4yIBgb2EpRrrTXsVrgHck71P1C7jFAMJ1kOQLL8Xpy
 T4m0FBP7rcnbJdWahU8lmkqU6OjK9cLqqEm692s8mftMBpOvTdGNzMbtI/1kGaAX8l+RZnmdR
 UixMiUOAhCSd518r6RXiDHhnLzKjzvZa9QS/Ur7NBC49TChS/k4PG74xLljPzYDEHCAFm4Xfn
 HKfGUe+2iHrYzFoRMr5/JQuVIGVsDLzyNpHn9ohsmo/zu9gVa6nggGI47TPqXkp90AIoIkYxW
 kwx9iPEC01Khf81RAClSj780AgioXwcAKKn+j6M6uKo6zeYLaY2Fz2fL4QwhhS46s7FemgzgY
 JvL1r3ce+egYsSZy78i5l2BOkDF8yjMBYpvvA8ItVGBfPsRioezrTxWTRwGwcD7dFD/3q+kic
 jK/9pxG6XzrxMI2EawnguICaOipLvH0u/JIXZYEWc1tjKgXuirEUQMVEk0xMRUeltqsmZYCqU
 +xB8IUsIhzfIvTxr89kn1DMPUhDvZ3yh09ZRDr1sDP9iwzo4PZwczAlidxa4ogPCHYT8Pr7zn
 UVXNIMg5+Enh9b8uzcDMPZbTaJ01AlKSAsA+XEB+B0v1A93LHib8DBlYa6xxYKfj8QfpGrhSq
 ymXDXnEBfztpC8gugA5fHfNZRKs=
Subject: Re: [cocci] [PATCH] Revert "debugfs, coccinelle: check for obsolete
 DEFINE_SIMPLE_ATTRIBUTE() usage"
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1216
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-07/fd1959e5-b0c7-0d0a-d037-d5e05b550765%40web.de>

>>>                                        Regardless of whether or not th=
e
>>> "significant overhead" incurred by debugfs_create_file() is actually
>>> meaningful, warnings from the script have led to a rash of low-quality
>>> patches that have sowed confusion and consumed maintainer time for lit=
tle
>>> to no benefit.  There have been no less than four attempts to "fix" KV=
M,
>>> and a quick search on lore shows that KVM is not alone.
>>
>> Will such information trigger any further clarification?
>
> I don't quite follow the question.  What information, and what clarifica=
tion?

I imagine that additional experiences can be shared and discussed for
a contribution by Nicolai Stange from 2016-03-22.

debugfs, coccinelle: check for obsolete DEFINE_SIMPLE_ATTRIBUTE() usage
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci?id=3D5103068eaca2=
90f890a30aae70085fac44cecaf6
https://lore.kernel.org/cocci/1458652280-19785-5-git-send-email-nicstange@=
gmail.com/
https://lkml.org/lkml/2016/3/22/412

Regards,
Markus
