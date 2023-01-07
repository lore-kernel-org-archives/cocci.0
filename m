Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B384C46467
	for <cocci@archiver.kernel.org>; Sat,  7 Jan 2023 13:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=W+CcvarYtUhboeMLWdBO26vQVT4W1wqsHLpOeYOLI9o=;
  b=VTmABS2LVv07XV8fzpXJQw8zmxXT6XU0MtaTgJ7d19MMIB5lXA0A5S79
   J8S2SixmZCa1ub496Z2sUrlGnUyPU3uDWbDkUr5Uo20jXmBtf6TfWMFgv
   hDhWy6nR71jB+/yEem8NBYl60FlLFlZXoRaKB+XN7b2vPRQH0iroO0U1R
   c=;
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
X-IronPort-AV: E=Sophos;i="5.96,308,1665439200"; 
   d="scan'208";a="86416139"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jan 2023 14:35:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8490BE5A73; Sat,  7 Jan 2023 14:35:04 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9E9EBE5A70
	for <cocci@sympa.inria.fr>; Sat,  7 Jan 2023 14:34:59 +0100 (CET)
IronPort-SDR: 63b97503_dREsis5oIShot1mL6V2Hwxy4SBnjY/5q6/Mu6vDPPckTuz3
 aHtrLez3bqQVQyZ7eBKV8A1vWe42U+u7sntADTQ==
X-IPAS-Result: =?us-ascii?q?A0GHCACuc7ljhwQP49RaHQEBPAEFBQECAQkBFYEqJ4FDA?=
 =?us-ascii?q?maBXS4EC0WET5EihCuHJYcxi3g+DwEDAQ0UASwBAgQBAQMEhH4ChRICHQcBB?=
 =?us-ascii?q?DQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBGgkXBw4QB?=
 =?us-ascii?q?SKFOwglDYI4KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESAkdTPQECA?=
 =?us-ascii?q?gEjHQEBESYBDwsaAiYCAlcGDQgBAYJ6gm4BAw4jB7BLgTKBAYIIAQEGnAgfL?=
 =?us-ascii?q?CJTgV4JgRQqAgEBkCV6JxCBVUSBPIMDPoQuFoNXgmePFYpECoE9fIEnDoFJJ?=
 =?us-ascii?q?QQOAxkrHUACAQs7MgpANQkCC0srGhsHgQoqKBUDBAQDAgYTAyACDSgxFAQpE?=
 =?us-ascii?q?w0nJmsJAgMiYQUDAwQoLQkhHwcVESQ8B1Y3AQQDAg8fNwYDCQMCH1BwAi4RE?=
 =?us-ascii?q?wUDCxUqRwQINgUGGzYSAggPEg8GJkQOQjc2EwZcASoLDhMDUIFOBC9efwoGK?=
 =?us-ascii?q?SigGqJ7oSc0B4IjgU+BUAyecQYTLoNmAZMPDgaSGx2XLKgCgXkjgVwzGiRPg?=
 =?us-ascii?q?mdPAxkPjUN2hAyKLEA0OwIHAQoBAQMJhUcBAYQCglgBAQ?=
IronPort-PHdr: A9a23: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
 cXT0r3+InFO/oCMlfY=
IronPort-Data: A9a23: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
 VUIeA==
IronPort-HdrOrdr: A9a23:sUmfM6tkzPB91M7fCMMVR+YN7skDotV00zEX/kB9WHVpmwKj5q
 WTdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDxHZK3BgDVQfexQouWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,308,1665439200"; 
   d="scan'208";a="44405496"
X-MGA-submission: =?us-ascii?q?MDFwNG0QeIG/rx/vmHgYtTivFhW80ilrcRw9wT?=
 =?us-ascii?q?zT+YTetIshU8kF5nxOX26+yi/1vslQU7c0oXdJv5fR8/NHPcGMPgf7w0?=
 =?us-ascii?q?daZtwB9VEopL1SezwDMsKRTHmEPn5AjfuKxm4Kw6AyuaPBr3ilNigWtj?=
 =?us-ascii?q?5oiKIOaMWmjahiw1Uc4gut2Q=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2023 14:34:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1673098498; bh=W+CcvarYtUhboeMLWdBO26vQVT4W1wqsHLpOeYOLI9o=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=wgFA5qLXf91ZqF26zVpFbbzyIRJZO+ONKDuiCl0FFC+HuVwL/zRzad27v5izsad2S
	 mixEYaz9kcizkK5ohLRR1OT/jGaxCADn27RxngrEFzZPjJFzhk2ejgraCE9bR4WXk7
	 ucFo5zN9bhOCjPGgCNqSmjxXvCaKS1Avx4B0IRb+pjZ1sP3epXUr2AMOwXKELW/qYs
	 X0iRYBbZqB4raKO2BirN20RySwfWRU25nRYbt8MQr3nTqn6AimnZP/57NoekcEonVA
	 WSNtmm6DP+clxPEQg+RZQwc4rnpCVFm5C1/AwFVTs6vcSW2sY5+zW5KjTjTtGdZvn6
	 2K821hpUxSSsQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MS17v-1pKvnt1E9D-00TVML; Sat, 07
 Jan 2023 14:34:58 +0100
Message-ID: <38da3db5-0aea-e05b-b105-d4943b64ffc5@web.de>
Date: Sat, 7 Jan 2023 14:34:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <7da2d07d-c1fb-1a58-8b57-3d1248f70c87@web.de>
 <alpine.DEB.2.22.394.2212260740380.2980@hadrien>
 <ae73c3b9-1f8e-4069-5bce-9380a187e1ac@web.de>
 <9fcc50af-da1a-6d71-934-b87d383ed38c@inria.fr>
 <c8d60641-ae23-948b-5b03-ceb9fc16210e@web.de>
 <alpine.DEB.2.22.394.2301071354000.2795@hadrien>
 <cfa05a5d-1835-c58b-dc28-4b017cebe2f2@web.de>
 <alpine.DEB.2.22.394.2301071423590.2774@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2301071423590.2774@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cIJROwdE1S3e08TDyesIL7Pi5rM0GLo+/SoQILRDXTDrW40ev5a
 O1eAFq9iJVB+w477GcrvQ25qLiRNStpJ0e/pceTyS8ErjfiG/XqebKLCmFHnRX6T+NxSBjp
 jYVJI74EInd2bohOWdT2N47XCZh46KPzDgzFLK9phj7Y6wvGxm+INsDhb44PVlRi+e5sbBN
 EFJTbiWIXGm0zY3z/Chzg==
UI-OutboundReport: notjunk:1;M01:P0:vxwW44Vq+34=;ltfxdxV1/Wxz7Njj4jl2oKmQULt
 BsKRlDCo2qt8AkVdR3yiwna0t2/VjQRPfZ11jzEGen+MZkNLSgupG+8lTGvGbAgG1+h3SEfNz
 wyxRrN4YFzBZUSs9w4XHlLOXjkTIrdgW6IiPy9DeypOfcMBJv7MyWNrOFFP2O7GayU6h9BihY
 c+0R7zTV4aHqqTdOVNcC8sAccbY4DL5k+O6fI0dSv4ebq5YKq/tOpYLoXooDpwjT0MEXGwLnW
 dLr16rzsOwP/4k+og/9PXEPMGZi0EX0VdQpBZQnge9Bco/blBwG6BwA/o129uw87+zh28U37u
 sLHOQthbTPNHwtnK5x08j6hE4Q1tW5UT5GVWHznZzeueSYF4CKIv9PrRUTuw9Au73txRyRcRh
 CoD5ct3ASn74wzkOdnAgvXy8Gx6s1VzphH9zWSYNMosx/gTMzpuLGYSsdyDU/MX7HqZq9sHXn
 mHR7wV7eLCHIIH7FBE7A1GSV3SJrwuYHj9kHAYUKt2w9pmkEt97wpuUzLtFsaVemQpZOkOosA
 ykENRiYQWdgWQS4quEV3rqinDm9I4J0/VdjIxtToqoxH5C3GnEECRKuAvZLeOchxX5oz2m2jF
 InH4//1ZFszjhIw1kCIT+nYtX/FX4DeFAwkSdcqlMwrif0Lt7+c5xoe2a86LNZGYO5KPP+FR4
 ADKVeFueH4TouOkgVTiYIeOuamp4W3xTsCJtZZ99v7AlQ3NCh/xD7FsR3prq4E41qi0TQKK7Z
 I6h0mg7az4tYkud6UUK6C10WR4gjYZs9geHXeJvXM6W2ruA0kmrTrLpB1Pvfrc5IVAuqG0Z9u
 cyDCpF1aLot3lEDohaySV41AyX9gj/i0R6ltqrIlqSvFgaH8gBBMlnOaKtXLRapJFhUAKyERH
 4O5nyxhASfF3ejAiDamnSPFADFUdSsRnFT5T+JVaQGzulKBfNN/uK2/9bJoyI9Fgi/d/IlXrN
 ZM2eYvydVOjAC2V9jLFDkiAaz2I=
Subject: Re: [cocci] Working with filled data structures
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 810
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/38da3db5-0aea-e05b-b105-d4943b64ffc5%40web.de>

>>> or make a pattern that contains one element followed by a list.
>> Would this design variant need pairs of metavariables?
>>
>>
>> How do you think about the possibility to add a corresponding metavaria=
ble
>> type like =E2=80=9Carray=E2=80=9D?
> Array does not suggest to me anything like what you are asking for.

Which data type name would you find more appropriate for the ordered stora=
ge
of a varying number of items?

Regards,
Markus
