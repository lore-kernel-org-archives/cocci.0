Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4536EC35FFC
	for <cocci@archiver.kernel.org>; Wed, 19 Mar 2025 14:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=47L2G/AWzgIVfdo4KHoS5lGsFoy3tvb2EOyiVEpN4Cw=;
  b=pE1S+tn0ojnQGI+nuGZg7Lb0aEYeFEyz4g6i6pNS6Kl5EyryZlm7VCvl
   s+ndDPf64owfm3Tf9ZSCvJRjC4Z7UAZbiHvyOPcRJ2zemggJD8gW4aXdQ
   TNxxlep+E0TJtg31/UOUurQaaew38JA9rif9k/uc4UfZDyxgz8zOg1YZD
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213725553"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2025 15:22:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A8B42E0D1E; Wed, 19 Mar 2025 15:22:04 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EA29CE007A
	for <cocci@sympa.inria.fr>; Wed, 19 Mar 2025 15:21:59 +0100 (CET)
IronPort-SDR: 67dad307_uhWGWCX4wo93sl22wcqEHelH6sc7H+9r5YrVokisuom4Pjc
 risG6txgdK723wypU1oNTfeAT5f71vnORGTtv7Q==
X-IPAS-Result: =?us-ascii?q?A0FTDQB60dpngAQP49RagQmBU4JEfVozBAtIhFaPUIF0M?=
 =?us-ascii?q?IQ7jw6IdYNUDwEDAQ09BAECBAEBAwMBhQACiyACHgcBBDMGDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYV7DYJiAYEkgSYBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQINOkQBAQECA?=
 =?us-ascii?q?SMdAQERJw8LGgImAgJWBgEUAQGCfgGCLwEDDiMHDa5WgTKBAYIMAQEGgU4BD?=
 =?us-ascii?q?BjYaR8sIleBZQMGgRouhW2CYwGGJ4Q8Jw+BVUSBPAuCeD6EQ4NbgmmCM4RBZ?=
 =?us-ascii?q?5l4kEdSexwDWSwBVRMXCwcFgSlDAyo0MSOBIgU0PzgpgWNpSToCDQI1ghskW?=
 =?us-ascii?q?IIoagQFgSSCNoQ+hECFUIIRgV0DAyIBgjBvdxyDS3Y/hGEtUIIWHUACAQttP?=
 =?us-ascii?q?TcJCxsGPaJ8NTuFUSxQgQ/HADQHgjiBZoFjDIoplTUGEy+DcJNWDgaSfZh+I?=
 =?us-ascii?q?o1jlXOFO4F9JIFcMxokgzZPAxkPji0Wg1gzgQuzd0I1CzECBwsBAQMJhUYBA?=
 =?us-ascii?q?YpUgUsBAQ?=
IronPort-PHdr: A9a23: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
 HLvYrpcSUBzCf4QTEhoToRqHQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:h1W+0KAf+KfmUsvlHely55DYdb4zR+YMi2TDpHoBLCC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOlNK1vp
 0BT0ERMqySMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:CZFPsG3+gzdk65WQmIh0vrxfAMsFQnbbwnDqAFaZNmBOaa2WW3qx0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3ArjAVsAxoMXcSwZJd1ZKKZO1OX1yaqPuDNkZQq40?=
 =?us-ascii?q?9gvWNbgZ8OQWBpRS3BaZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="112038939"
X-MGA-submission: =?us-ascii?q?MDFdTT8xkdrkuccj+lDrK8enLVxTiQAwx2nkP0?=
 =?us-ascii?q?Etbx+uVk8Z6GBg54WoIGEb+SNPDmteFJBm2K/a+ElV5nLAc+k4lWmdrs?=
 =?us-ascii?q?vlLF3Z8ujz016lnonfCDT1qrkBq/YmP7LxiC6ipWwNGplsUQupmUXNmw?=
 =?us-ascii?q?Ju68cci7rSNtpUwnd5QHIFZw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 15:21:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742394118; x=1742998918; i=markus.elfring@web.de;
	bh=47L2G/AWzgIVfdo4KHoS5lGsFoy3tvb2EOyiVEpN4Cw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=e+7Gyi2p7a3WiRYG4vitNvuV1ctgRPWM/JnonYb6RDSRJhw3D5D78tk3nyMasjCK
	 i/Xc2W9VchtqHLC9E8P64u1YMevmbdja2gTcg7hXruczZHyXbKWCagDKFkzF5d1NI
	 UiGiS5davv9oZ4GdhwWKip0UzbrIdcDrhf8queEdxne6XEhD80vzRTebM/rwGUZvq
	 rbHpE250ONldFpyyTR/yEratQvKA5RBkfp38y3h4iSUDev2lsd+R+OIQNMcqQ51Ip
	 9gIc7uFL+vsIizhTSN+mSIEH03W2W7mXI0RVXD73yavETzSegavwX4rTSPIkLx7D1
	 14O/J0fOvaiX8VYHIQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.16]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdO56-1tLZYM22Mq-00cZpB; Wed, 19
 Mar 2025 15:21:58 +0100
Message-ID: <6c9bf30d-8166-4bb7-bf0d-f2ea8dd7fbe4@web.de>
Date: Wed, 19 Mar 2025 15:21:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Victor Gambier <victor.gambier@inria.fr>, cocci@inria.fr
References: <8886034f-43ac-4475-9f16-faa2db8de5de@web.de>
 <cbc0e8ca-fca0-4533-9351-859dd98bca25@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <cbc0e8ca-fca0-4533-9351-859dd98bca25@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Tv3gZ+wVeJ27/hAwm6jn/jBqO5t61/qY8DdvPm0GLUPU7n/NV+e
 U9cIizS/DSVqa9uMA+GoQGfViq8SGMdpDSWsjHAll/brOlkQ5z29igsmIDtVAlU6R53pRSL
 7lGI7tDZ42cq8dSAo56RaIUtb/8NrvM1gvYWzW9RZbAobSOeMTCHWrQ+XYKVEGmHgrJHjVR
 oyPg4jihz7VQ3NHFxpsNg==
UI-OutboundReport: notjunk:1;M01:P0:Tg5ugXV5XzU=;F3TtQjzOz9HAdxXUghcAXj+k1sJ
 bmDVPEi0z+yAiyXG0qMV4cqPTkKNJLHUYGbdEKnSyMtglkkdBEM2k84ItGjsF+IsFNFm32rUL
 zks/WGaovt97doMkSoRqdnw+Q1/JWLVYJ4xDLG/CyPyaGFVlFcs1pOUq5Yom6jWhTXYjeCm9R
 9IWj5wyqoqzUTOn5JOfCrYjVp32P6+g3yUqqqKrIdVa1VrjZkxx+iBIvU6m8WEKN+MKlrzuad
 PdG5C0dBM1Dcli7qD6kwR6MO7ByLfp8RXhkusOZVuR5YsgScr/MSSKkxPI/DiPVi8dLBa8xLf
 2btnrhg3Evxe3KFH0L08NSIfvRNSZFLEZKCa6KDpvCTBSyHstzvLC9QBzEKWA4jyiZA+7v0E5
 b5EGI3Z4wzRklNfeXLc+w70je8X8giI7HIoOx9N/hoQiDXY958eVRynSqtb8ib0cg4CGzFYV0
 ZK8w/afQv9ERiKAyr0jDs07o3ubKdET3+ZzBVb4XLvJ5He4oNZ+y09gcnAatEBR5DgCd69E4R
 wC4q4juRfdsBMYcNcZ5KuJ3/LBp2kOXnuI+im3WKqKknrIDL2s7GlhLd1yS4s47n6u4p10Wr0
 d3s/KFcacSXId/uU9SWCKBgEwSmFQ2hao0Ot+b7xNgPTfZeH8Fpq1YVkX5hgTSlG9vk1bt0QL
 oh7KqfFvdBY+BzgdaiP0PHP2SemYz9+hjv9ys0jpx+SOsyALBh5PD3V43jE8/+FnNzVhNo4zQ
 ZD9t/8Abyp1kv3htShhWIuheP6IILuUIuJSsR1sFsboMym9T2vPjB80tD0SR0lvc3Dww0BgD5
 P0IQw7H+ULwb1KnXBpr0Capg9UFv1uHSL+v4xsGMlvcDejLrsW3m833oeX0iyHxBZd/p64rkB
 X2g44kuELmPe/S6RPkQgV33ToqQzrSQonB+xgohHvPlszdJrrl9csADEhlEMhbjV2nA1dwTw0
 q/Tk0I0jQMWEvaIksnazWPk4vODPJUwxSTnRLcx5B1zOqggSoG33gtx/trCe0Dy1WVT0HP9+m
 jJxUMd9oGtj7i8wIR2MWyUOIhXr+eyGD/+pHSuaGDh0GY99FIZkvpzVSalDENYIRDtfVK81c4
 Fd1TlOgXjO2gKCfFpQjtyo+bAXnxOUw8OBLn7ZAbCXGl0dAyJE0bYcOibFLs/tCVkHaA8lcSR
 YEEuvhMifi+jhNmfvKfPJyZcPPsQNRUy8yb0vzsD535wk9rl0mBrv7UCr0BiEsASqhQxorifn
 ykK8XtBj+YU5z8ns6lDgY4MfprDzoHxIKhGmH9PI5UVNRZGQTRUqb1R7aNHuU64LvN2v+MQtP
 wfUBNxpFlpMtaOMu4dmj5owsA/1eLjN7cLiS+QLywSHB3xPntsWkeP5HoHdUwP95eI5DliAJI
 1hz6cDmbY2TEFut80ZKDSO7soAE9hLy+nYG5BNQtWmybxvD4xi+1sll/uKcCY9ntZ/o8MfZO1
 YuCkjFb7wLyZ35hLFJi3+JfOt5QeHNTwoaeXhETTBxHGHN0xXQRiax9Bcl9EcCpGWgeqmLA==
Subject: Re: [cocci] Improving find commands?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2658
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/6c9bf30d-8166-4bb7-bf0d-f2ea8dd7fbe4%40web.de>

>> How do you think about to enclose file filters by single quotation char=
acters
>> (instead of double quotes)?
>> https://unix.stackexchange.com/questions/170179/whats-the-difference-be=
tween-using-single-quotes-or-not-in-find-command
>
> What would be the point of using single quotes? I also don't think you u=
nderstand what's being said in that link.
I imagine that existing knowledge can be better reused also for affected c=
ommand constructions
(in referenced OCaml source code).
https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/67d1b7c071a65f154f9=
4c1193ab2d14f8d1bd3bc

Regards,
Markus
