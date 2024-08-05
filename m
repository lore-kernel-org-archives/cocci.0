Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43074C3DA4A
	for <cocci@archiver.kernel.org>; Mon,  5 Aug 2024 16:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=3Lrhlh6sIkdrEilXnOWBgnt2BAPo9LtsdDv4l0eF+fc=;
  b=VkevKzKmDeU9Ed7f1d5dwAjBb6v96fJXJoXSxGsiJj7krJK6mjtbJeCP
   bcGovVGMtqGwgsC70fh/Y6yraIXWRz7dYv/M2dAgq13P1z9CWrKeCZDx0
   fRbLnG817F2FEChMGbB87rGi0VQHOPurR3kKcSdBE/qYI8OV59XGyJEQl
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.09,265,1716242400"; 
   d="scan'208";a="178169684"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Aug 2024 18:02:35 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2FE50E0141; Mon,  5 Aug 2024 18:02:35 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 52B1EE0035
	for <cocci@sympa.inria.fr>; Mon,  5 Aug 2024 18:02:29 +0200 (CEST)
IronPort-SDR: 66b0f794_8nussZ0tGOOHhk/oKsc+GpYTdQh+Uwu2mpwNJI2CA8rXXtY
 +khH8tgDDEuMvs4oQYlF/ZlbXxPMroJF4GPem6w==
X-IPAS-Result: =?us-ascii?q?A0EgAADR9rBmh07ASNlaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YJDYiFUMwQLSIRWiB2HL4F1MIQ7hzqHUYh1gVaBQD4PAQMBDUEBAgQBAQMEg?=
 =?us-ascii?q?guCagoCiUoCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAQEBOgcOO4V1DYJnARCBEoEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHRAEBA?=
 =?us-ascii?q?QIBIx0BAREmAQQLCxoCJgICVgYBFAEBgnyCMAEDDiMHrVaBMoEBggwBAQbaW?=
 =?us-ascii?q?R8sIleBYwmBGi4BiEkBhh6DQXonD4FVRIE8gwM+iB6CaZImi3smkDtSexwDW?=
 =?us-ascii?q?SETAVUTFwsJBYlLCoMjKYFLJoQYCIEtFYNlDYFeDGGHcmKBDoE+OIEnAUmCd?=
 =?us-ascii?q?0qDZxyBY4EDgmNXHUACAQttPTUJCxsGPdEAoS00B4I2gWKBYwyfTwYTL4NyA?=
 =?us-ascii?q?ZNJDgaSbiyYRCKodIFnOoFcMxokgzZPAxkPjiEZhBTHL0E1OwIHCwEBAwmFR?=
 =?us-ascii?q?gEBhlyBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 ITteV15fQ==
IronPort-HdrOrdr: A9a23:hFD2+6G5VY8aR29epLqEPMeALOsnbusQ8zAXPo5KOH5om7+j5q
 STdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: 9a23:iQ0Thm841RV1B1LfmuKVv2QtJoMLLViC8Fj7PhbjNU9AY7HLUkDFrQ==
X-Talos-MUID: 9a23:4Cq1AwWkyttKChbq/Af22wx6bPxN2v+JUUFKuK1fvsXdNRUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,265,1716242400"; 
   d="scan'208";a="93610622"
X-MGA-submission: =?us-ascii?q?MDHt7tOA4aCdUvx8CAxHHMe0DW5R3SekUoaPo1?=
 =?us-ascii?q?U9SVd5p3DVo/11tQEIQa8ULF7XMCKS/ql5Fz/GR9DCeFaDQq5NZFQcCx?=
 =?us-ascii?q?fcCpKV/HVq+x1k/IADkCOXxuKky07MvU/yZ45TvynhUC4DwgXcejiYm7?=
 =?us-ascii?q?gSjyR4U9hpJ6RP5s9lR5cltg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 18:02:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722873746; x=1723478546; i=markus.elfring@web.de;
	bh=3Lrhlh6sIkdrEilXnOWBgnt2BAPo9LtsdDv4l0eF+fc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bCUq/l6lX26s+PvcJR4j1PkiW+8WT2jzTGEsa14k/gMOXCmc5huAVFsIgPsRHca9
	 ECMWCRqd5amTuWj+a36Io2eN5jg8fHcsZPofKRX/lZkRbL/IP9tmoOp9+qb7j8TKZ
	 qacCsBTM8rGN5i2QUKOeJ5EfpSyPsB6xLNrKGp/iYfGtJdabOArbq92B0Sa/F+fqs
	 Go+wsyeSEj8LdpbCOXWUZCK36HKb1wj2XQCTtXesg9zExUFPD/dnowwp8p6RYWbMh
	 OBipLWBP0F2W2qrz2yL7VG5p7OCHXXnFoiP7D0i6ewaYAaqQz1JYEnLJFHd6wFlTV
	 aS106XW1j0IOY1hEjQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3m5B-1sbp6w48Op-003fqq; Mon, 05
 Aug 2024 18:02:26 +0200
Message-ID: <583a6ed8-16db-4a5d-8a07-3f8b7c2c752b@web.de>
Date: Mon, 5 Aug 2024 18:02:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Ricardo Ribalda <ribalda@chromium.org>
References: <CANiDSCvmboKBK=Z7uS9tnN_LcPA16rx0j_iWeEoQ=jO+pEgLiA@mail.gmail.com>
 <98a94966-14c6-45c4-99d8-471f65b292ea@web.de>
 <CANiDSCuJHTsHsFLbMGC1S47myfReZX7JBfGZFVknj8y=4-QLCA@mail.gmail.com>
 <fdc397c4-8823-46c3-b471-382ebb483900@web.de>
 <CANiDSCuqX7yRyJfvEJeV99fr1wEwANtg2Ak7MNogfYNEqMJ6Hg@mail.gmail.com>
 <c05b066f-af9b-49c1-9bdb-9167d24e3d3b@web.de>
 <c48956e7-f98f-407b-a4c1-29aa417c7474@web.de>
 <acb79b2d-a040-bdc4-9d5a-faafc3fc7d66@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <acb79b2d-a040-bdc4-9d5a-faafc3fc7d66@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Hzkc7Nyyl2ELwHfhL7kO6QlWK5GipBMiUxHWLLc0rRKLmcmE3c+
 9X8ij8a7d6FV6Yo23uHNaQv9kdKKWzU47S/ZdZM6Q/5qtPdn9znoWE4s5ExNyYZs3vJxPZ9
 GOwXUaayatllV6erg6G+GrZ2GfpIHIMcQou3bb0l39aaVoDBQnGpUvH1FiFe9Gfp58vlQQk
 /5mnXRtPc6QIZkre+nplg==
UI-OutboundReport: notjunk:1;M01:P0:Uzp66gRe9ho=;XEpw1nr0FfuAFUC+eX4jxquK78l
 AQgAbOCQf+Tq8fj3n6XVbJA6WV3pELOjUebPJrsiZ/YSNL3P6LpQ+HmmOQh061pDPL0nxjqOz
 +lgnxVztB4sgqH2rDv73sy+wPpob4ASF5NzCYwdbdMKiZoOnJ/hsUTSRKOe4vMhAxPfudjKzT
 CpwAx2bfCyaA1ab4WYGAzeg3H9n/uHeznJ0XkWqnkLDbWqN77lMvUqNmg0ackjuDUl1WS++rJ
 xaBAIciDthJFoycFUJxSMhwHpSDaJM23LdzQWlmlXaALUSA9TtkiQcZJGIp5nojMJi8xF3vTQ
 dwCFDfpMn6QNRJ9PBxFRXu1m+HTHPnGAV1BoYaz7BFqDRApGyHEhwzlFqTDdJND2KeEX/p8lu
 Un8qyJ2lmDPJMyFdM/veJysfS+Qpqp2dlRN8EzvszRkRjeLjyIfo4KTxAvOkaGoAOsbBCiqWV
 cNmEBX7SfKp8UDt7klqgSHXL/MlpZ8BN06nbP7K6RqkNXbhQa1xXCwEk6SNEr/9ihScEVkA1g
 Oxf4Ye67UwYMGErY4u7SBPqGOG88/IMgxvHyetw2f4fcVm7nYUnaWMuEd4wr+v8UhEeyYJzlo
 G8J0Z0GqwiTsBJgveR7ePPGi6sAsqwXBFFWyeMhVerD87mlbve2yISZwRMJfi1fIuvXpnVTV5
 4KoMMIJooqalb5Mk4dkZvJHyLTgkz+N5IT2tGAayardzO640HjPkqX3lYvupb4t5RlYO7CwOn
 wqSMi03GP5lnmS6fGjVZPQccbsN7ThIA1XNI55DbPgrhWOSGX8qwR5HCe9uByskKLAUOHfjNW
 KNEByXlJHwmIqtJsW+R5lDmA==
Subject: Re: [cocci] Questionable run time characteristics for SmPL scripts?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1841
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/583a6ed8-16db-4a5d-8a07-3f8b7c2c752b%40web.de>

> I don't need any more information.

Are you looking for further helpful data based on advanced software profiling?

Would you like to determine which SmPL scripts contribute the most
according to observed run times?

Regards,
Markus
