Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7C3C433FE
	for <cocci@archiver.kernel.org>; Sun, 20 Nov 2022 16:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=nmtUIjJlykQ/TyFslyEtOtEBxBAIqQoqeN6dDW/dnPU=;
  b=Mtnez74z3mfJ9jTqR4LbEz7VgXVUiSCpBv4Ux1aTOXEfz0T+xE+43C8o
   SgCfuJXbbSBAICsNaxlZz0IwQDvtSDfUaMFTqWhZepen3wCsVQMDf/jI8
   j5WRAkCP+YLG7HRoGdslN5paINW/00a2++py+OiPCq6LHGseiaLAagyJQ
   M=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,179,1665439200"; 
   d="scan'208";a="79132669"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Nov 2022 17:00:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3352DE027C; Sun, 20 Nov 2022 17:00:24 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DAC17E027C
	for <cocci@sympa.inria.fr>; Sun, 20 Nov 2022 17:00:21 +0100 (CET)
IronPort-SDR: 637a4f15_KpK4pTEctqSuH/Dzq1X8bHdueQaLbOnHb/dvdXnIA+PtqAe
 MJmdEChmLipu18TTL8NUl+Q09+GnpisJ957KWKg==
X-IPAS-Result: =?us-ascii?q?A0HGDgB9TnpjhwsR49RaHQEBPAEFBQECAQkBFYEqJ4FDA?=
 =?us-ascii?q?maBB1MuBAtFhE+QbDGEKYchhzCMNQ8BAwENFAEsAQIEAQEDBIILgnMChQICH?=
 =?us-ascii?q?QcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBGQkXB?=
 =?us-ascii?q?w4QBSKFaA2CNSkBdYEIAQEBAQEBAQEBAQEBAQEBAQEBARYCR1M9AQICASMdA?=
 =?us-ascii?q?QERJgEPCxoCJgICVwYNCAEBgnmCbgEDDiMHsk+BMoEBgggBAQacBh8sIlOBX?=
 =?us-ascii?q?gmBFCoCAQGQFHonEIFVRIE8glMwPogbgkUijnSJCSUEDgMZKx1AAgELOzIKS?=
 =?us-ascii?q?hsxJw4JHxwKBBcNBQYSAyBsBQo3DygvZyscGweBDCooFQMEBAMCBhMDIgINK?=
 =?us-ascii?q?TEUBCkTDSsnbwkCAyFlBQMDBCgsAwkhHwcWESY8B1Y6AQQDAg8gOAYDCQMCI?=
 =?us-ascii?q?lVzAi4RFQUDCxUlCAVLBAg5BQZTEgIKEQMSDwYmRQ5IPjkWBidCATEODhQDX?=
 =?us-ascii?q?oFpBDVmgQsKnRqlTp9ZNAeCH4FMgU0MnmYGEy6DZQGTCA4GkhQdlxeneIF5I?=
 =?us-ascii?q?4FcMxokgzZPAxkPjjmEDIosQDQ7AgcLAQEDCYVHAQGFGQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 VQIeF0=
IronPort-HdrOrdr: A9a23:CLU0EaBUbURNnhTlHel455DYdb4zR+YMi2TDGXoBLCC9Afbo9P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QF5SWY+eRMbEVt7eZ3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,179,1665439200"; 
   d="scan'208";a="79132665"
X-MGA-submission: =?us-ascii?q?MDG8ByTvQov+TdGmKhWzrjDNRe8VG9DU0jMjui?=
 =?us-ascii?q?mBlQxcAgfq01+cKYIUfFaLrXuKP3KmFvZdW6fo3hqrlXijga6mgvmsL7?=
 =?us-ascii?q?0CILzgUx4tTuW9l4M8mA1vGU6B4d0XQie6Hks3yzndbF4V/wkU6FkR1O?=
 =?us-ascii?q?NDEuSpz86Rb8AgTb2gCKdHrw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 17:00:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1668960020; bh=nmtUIjJlykQ/TyFslyEtOtEBxBAIqQoqeN6dDW/dnPU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=rbkhtOFizRIeyl6mT84a9ZyPKGnGK3/X+ebv6fO8Dnu12kxgc+8AGLduKEBwZpd0X
	 s+8tSibmdcUgWjvrcR4NhBz2IFHxTeZUgqtTM/xDtpEzb8TBonJhFwHAkCZDTt8Zl0
	 sHkYUWCPw2+NFORIEj5h1K81aEjec2X2VRKJDQKFqKZ4p9y+FI62iEi2N0vqC3AjLJ
	 kMA37XEjVu4SldRwj8cblwtvtsyXxPUEOylaqk09EyKeAV9viV9IXwzsu9BIKqIq7Q
	 pFd0J2qVVRsYvJHHJH2Y1R13BZLF814zfGJiSlw717VMGYUJdNNMdtI8/UHeizrEQs
	 zEAZNPDPK4z/Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Melax-1pXUTB2hrJ-00ab06; Sun, 20
 Nov 2022 17:00:20 +0100
Message-ID: <fd1e099a-986b-b528-7cd0-d1d0c3d51ca3@web.de>
Date: Sun, 20 Nov 2022 17:00:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <dce20c86-de6b-92ef-3bc3-af39ca99b5c4@web.de>
 <alpine.DEB.2.22.394.2211201641340.40755@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2211201641340.40755@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jI4njgYGQOlge+/jJKeV3e0wkpnZvahkvrSk/0SfNdAyx2x8dH0
 m2UdXuqPCdjsnX8qZVEkdHczMz3koY4zvWBO3/lj2YX4YiBBMjI4IayCMIcIWA23tVrgSUh
 W6inkYMkduwpm/yXveNiHBU0n+TE7CASGMKXPrJqNnTw8JuYrljlDd2fjMUJGBkJVGeeFp4
 64Nprlhq6c0S7Ku0AYAVw==
UI-OutboundReport: notjunk:1;M01:P0:bCXrExe7L78=;a0POyxCV1C+z77G3KS9g5v6+mTQ
 vs0h1P4KLqrkdCTkanlo/32wvkzOsu51arTxysAeU1bUSrdLn8v6ub9XOflD702CiM+CgrF05
 hNT5/FUQy9KuNmlyxHxT5tgukVK09Yj9SXR1Db2XGb7HQbrW7K9KRxC3lhWpbW1T7aryVFwy4
 LvriSrs6AG9qkkrkQPXsqAGC+qiFEClfHAk9pck49lYjnb5QPEHXqU8tJWLjKJ1hehsZ8N1xg
 TUgrcsxqQ4aYZuAmPrBdaoh0YyMIXCdcsGQgodjHsLz2sBTvwIsauXavsZdf5vkhXz1Ie7ds6
 Xg8Y/FjbbXaVMaFzgouC5nWeWmkHbd+4E5b6e4/Aj7g4jyLcr8hz74qouRr1P23eX8zQEb43s
 Cp4YRLRvHWwRvaD4qRE+KS3gX8CrT7rXMUPnR3YO3oe7EameOjmOuu9402I4bWhNL3COtZEWR
 XWzj8Mt10SmLqHJoVO6YO3WNFG8FJPDZf5D9VZ7qooVTStJEBm4ZZcRQWvH+vmeL6FBOOG6S7
 tKeQwhuykTdMajbqmwHwjcURca08JEbRUXetVcMefIS9E105RtBjWvlIhkc7S15MpSdOfUfgW
 ksfre1D+Dk+f5Y24fY8q1yY+MtcApquMAYK37iWjG/bifeyk051vx1UU3opT7QmLNDkFcxv5u
 UKqr0yMIiD210nnj4gHwzaUbX2w0lB7QQ1/sljrkjGj68ga/Ke3t09pZ62mq4pcH+13GBEg1T
 /UMEeakQOkcBb/OYkGtmVXFpVNbvrwEsvIRnF7zyboWdetMlvZ12R1I3y/sG51lu52aU7OZGl
 R1wkLULbtand7/521h6ZrZtjci3/2p/q7xPil4MkOPh5KkfOIzkfqIOBIFrM8JToW+2J++bMI
 CXVUcqjkj2ncs05rWEO9JVCd0MiFGMu9MxPDEXeOm1l9xRAw3YrAoX7Dqp4tdeR4IDhV6BQNt
 S+9YFg==
Subject: Re: [cocci] Data structures for source file analyses
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 753
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/fd1e099a-986b-b528-7cd0-d1d0c3d51ca3%40web.de>

>> How do you call the intermediate data representations according to the involved
>> processing pipelines?
> Abstrat syntax tree? Control-flow graph?

Do the following data representations matter for you?

* Abstract semantic graph

* Parse tree


How are they mapped to components which are provided by the Coccinelle software?

Regards,
Markus
