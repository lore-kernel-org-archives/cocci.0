Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02F1C77B7C
	for <cocci@archiver.kernel.org>; Thu,  3 Jul 2025 10:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/BpHtP6uXUu597hjzNpHlRORCZKXSUMY1LQVy8iWvd0=;
  b=JJhj9zGb/IJVjxAMBCXhNALX5NYyZsEXhPIDPI8yGmr4xWtgVEd5qQKx
   iSjlFnu82hASn4XEjv4UM1JXbSgt8EcsXrDRj5bI2PE40XDb1V98PsX88
   4b/FV2nO9W37y5LVvxwUdviiTziQafDJBrbiqqn6FeQoZZOfdu2P/oW6B
   g=;
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
X-IronPort-AV: E=Sophos;i="6.16,284,1744063200"; 
   d="scan'208";a="230145953"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Jul 2025 12:00:46 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 047F6E01A8; Thu,  3 Jul 2025 12:00:46 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 33341E0131
	for <cocci@sympa.inria.fr>; Thu,  3 Jul 2025 12:00:43 +0200 (CEST)
IronPort-SDR: 686654ca_aSsUHvps9MRko1UuuguKEVU/G323KAgA2SjI5aY3lz/iUgn
 VwASGRKNHtNhsO0mU2rBzW4m7hJRp9h1/hDUi0A==
X-IPAS-Result: =?us-ascii?q?A0FNCgAUVGZogA4P49RaHQEBAQEJARIBBQUBQIFTgkSBB?=
 =?us-ascii?q?lQzBAtJhFWPUIF0MIQ7hzyHU4h3g1ICDwEDAQ1OAQIEAQEDBIUAAot6Ah4HA?=
 =?us-ascii?q?QQ0EwECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYV7D?=
 =?us-ascii?q?YJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBEScECwsaAiYCAlYGA?=
 =?us-ascii?q?RQBAYJ+giIBBhABAw4kB64egTKBAYIMAQEG2l4fLCJYgWUJgRsuhW2CZAGGJ?=
 =?us-ascii?q?4Q8Jw+BVUSBPIMDPogegmmCJoEWhHqTbFJ4HANZLAFVExcLBwWBIEMDKjQxI?=
 =?us-ascii?q?0sFLR2BJ36BTRyDCYEOhCsrT4IkdYF5QRk/g1QeBm0PBoEfG04CAgIFAhVAA?=
 =?us-ascii?q?gELbT03CQsbBj2SdIdfpDOhQjQHgjiBZoFkDJ9pBhMvg3EBk1oOBpMCiEOQQ?=
 =?us-ascii?q?iKpGoF/I4FcMxokT4JnTwMZD44hhDPAZUE1PAIHCwEBAwmFRgEBiAyBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:eFHFxKCN/tNLvhVW/+jnw5YqxClBgxIJ4kV8jS/XYbTApGwl0WFRy
 jAYDWDQOvyDMWTzKognb96/80hTuZ+Bm9UwOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yM6j8lkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/YuGZjdJ5xYuajhJs/3b80s11BjPkGpwUmIWNagjUGD2zCF94KI3fcmZM3b+S49IKe+2L
 86rIGaRows1Vz90Yj+Uuu6Tnn8iGtY+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0usyxVEFL0OavHJSxjSCc52DpSlDs2Ps1N0YnPoRAo/l2JGFRy
 vNNfVjhbjjb7w636Le8V/UqmckpasXmVG8dkis5l3eDV6lgGM2FGvmiCdxwhF/cguhrFOzde
 tFfRD5hdhXGbDVQN11RBJ9WcOKA3CKnKmEF+QjIzUYxy1mK3TxV+p+3C9DQVYyAV/R8lB2Hh
 kuTqgwVBTlBaIzHkmramp62vcfEmijwWaoJBbig/7hrhkeSzyodEnU+UVKkqP29oly/XthFI
 goV/DAvpO487iSWosLVWhqlvDibsxRaV9c4//AGBB+l54XtyAaCCDM/SS9CYYR/q84TRSMV2
 Qrc9z/2PgBHvLqQQHOb076bqzKuJCQYRVPugwdbFGPpBPG8+ukOYgLzczp1LEKipvHYcQwcL
 hiPqzUiwaoeh4gH2s1XHGwrYRr89/AlrSZsuG07u15JCCsnP+ZJgKT2sjDmAQ5odtrxc7V4l
 CFsdzKixO4PF4qRsyeGXf8AGrqkj97cb2CF3Q42RsF6pmj0k5JGQWy2yG4uTKuOGplUEQIFn
 GeP6V0OjHOuFCD7NP4sPepd9exwkfK9S7wJqcw4nvIVPsgpL1/YlM2fTU+X2Wf22FMh+ZzTy
 r/LGftA+U0yUPw9pBLvH7l1+eZymkgWmzmPLbillUrP+eTFPha9F+xaWGZim8hjvMtoVi2Po
 44Hb6NnCnx3DIXDX8Ug2ddMcwlTcyJiXc+eRg4+XrfrHzeK0VoJU5f5qY7NsaQ890iMvraWo
 COOSQVDxUDhhHbKDwyPZzoxIPnsRJtz5zZzdyAlIV/iiTBpbJeN/ZUvUcI9XYAm0+h/kt9yb
 f0OIPubDtp1Fz/oxjU6bLvGlrJESiiFvwy1EhSAXCkeZL9lHgzAxc/ldFDg9Q4IFSuGivE9q
 LyBiCLeGIQPdz1/AJzoadaq9VeQvGccqs12TUDnMtleQ2Sy0YlIegjarO47HNEIEjrHngCl7
 gexBQwKgMX8uKon2YDtqYHdiKnxCMp4PE5RP1eD3IaMLSOAo1aSm95RYtiHbRX2dT3S+pz7Q
 c530vulEvkMvGgSgrpGC7wxkJ4PvYr+lYR7kDZhMm7ANWmwK7VaJXKD48lDm4tNypJduiq0Q
 ki/wcZbC5rYJPLaFEMtGyR9YtShzf00nhzg3cYxKmj+5w51++OjemdWNB+ulidcDeVUNKUI/
 OQfg/MVujeP0kcSDtW7jy5v5zutKF4EWP4ZrZ00OtLgpTcq7VBgWqbiLBHKzquBUegRDXlyE
 ASo3PLDo59+2nv9d2ECECmR/OhF2rULlhN47H4DAFWrwej6p+IF8yBQ1R8VTQ1l6ApN/MwuG
 2psNmxzfb6v+RUxjud9fmmcISNzLzzHxV7U1H0yi3z/c0mkckfvPV8NE7+B025B+l0NYwUB2
 q+TzVjUdArDfebz73MUYlFkofmydu5B3FTOt+7/FvvUAqRgRyTuh5KvQm86qxHHJ8cVr2+fr
 MlI+NdAU4HKBRQykYYaVbbDja8xTSqaLlNsWftipaMFPV/NcQGIhAShFRqDRdNvFdfrr2mDF
 M1cFuBeXU+f1QGPjAwhK4wiHrtWpMMttf0+Iu7FBGheqLaOjCtbgLSJ/AjEuWIbadFPk8E8F
 4DvSwy/AlGg3Xt5pmucg/RHa0yZYMYFbjLSxOqa0vsEPLNdvfBOcXMd6KqVvXKUPFFZ/jaRh
 gfiZrDX/cNm249Dj4vhKYQdJgSWePfYdvWEzxC3iPtKNejwCMbpsxgHj3XaJCFUAOchYMt2n
 rGzr9LH5kPJk7IoWWT/mZPaNa12yeitfehQaOTbEWJ7mHacZcrS/BczwWC0BphXmtd75MP8Z
 Q+ZatO1ROEFSeVm23xZRChPISkzU52tQP/bmhq8iPCQBjw28w/Ndoqn/EC0S1BrTHYDPpmmB
 zLkv/qr2Mtjk71NIx05HNBjPY5zJQ7yeKkhduCpjwKiMEuTvgqgtIfhxD0a0hOaOkncRYy+q
 djASwPlfRu/hLDQwZsL+8ZutxkQFzBmjfN2YksZ/MVshiunCHIda94QKogCFooehxmaOEsUv
 90RRDBK5eTBsTV4ndHU5dP+QkGAC+ZINtqRyvnFOa+LQ3/eOW9CKOIJGuRcD7NeZTbpiu2qQ
 T3b0mOlJQC/m/mFWs5KjsFWQo5bKjfy2X8Cv0zw+yA379DyHp1SvEFc8MFxueAr3i0DeIgn5
 YT4eIycfHyGdA==
IronPort-HdrOrdr: A9a23:rKpPyapCIsuzH7nNeirnL1QaV5oGeYIsimQD101hICG9E/bo7v
 xG+c5w6faaskdyZJhNo6HiBEDiexPhHPxOkO0s1N6ZNWGMhILCFvAE0WKN+UyHJwTOssBYkY
 hte7VjE9HrZGIK6PrS0U2XF5IPzrC8n5xARt2z856ud2xXgm1bgTuRwzz7LnFL
X-Talos-CUID: 9a23:364x92BxT6nhnL/6EwRIzWUUAc5+SXrMz36IelC5LGZ2d7LAHA==
X-Talos-MUID: 9a23:NIl3BQuDaPyy6NZOZ82ntWhzBONCxP6VAkUiwZ8UiuCObjNQEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,284,1744063200"; 
   d="scan'208";a="230145925"
X-MGA-submission: =?us-ascii?q?MDFnWw4qrmqAxjsNWyMxg9JeUpm+5arxBH8jcp?=
 =?us-ascii?q?RfdRZGffP2CHRpa0uPi1eeBGslNbKyianMbEmmwWFqVtmTxAzA/XoCT2?=
 =?us-ascii?q?Bka3IUqWCGijkDqeC1LVceyg7nwj+YqpHz5K5VSQ2CSyFcjUMax7NPpI?=
 =?us-ascii?q?bECj8pii0F6lG6SQTOCyqbdw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 12:00:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751536842; x=1752141642; i=markus.elfring@web.de;
	bh=/BpHtP6uXUu597hjzNpHlRORCZKXSUMY1LQVy8iWvd0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IipOWmSsCEE+/6d2KFHXBudJjfvBuqnqINAMIVvFdAUvYLeAVGhCnMjbWyM8MCa/
	 PxoZw2OHKIX2HcQcbar7z3wG6pNdu+Z0nip2FEZBJgQmbhQQs06WF+qEf2r5mDljZ
	 8aaubAWSQt+SjanAgi21nYQXixxapmTfLy3MGnAKv6tM2TLSG/3VMZ+9Y6AgFSsY5
	 X7ma5Jh/ovhGCvQLm4Z8StSIM0jk0raW3BZmwYUCZHo4mfKBeDjSeJJ2vD0nssPCa
	 l5wdHAVBHXghqd58JU6RRNP/Prm+CFZtdbHBVHx4RHoRi3MIkV7qXmUHYfcpA4hS5
	 q3A6W+RRPiaRaFE+7A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.211]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4NDG-1ueWEh3KVi-00wdd3; Thu, 03
 Jul 2025 12:00:41 +0200
Message-ID: <ab0209a9-fbf7-4bd8-ae78-d6fb337ee294@web.de>
Date: Thu, 3 Jul 2025 12:00:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <3675aefe-7163-4b02-a4ad-07b7a23a4b13@web.de>
 <38ed2bf4-4bb2-4ace-87c8-191e19f8445b@web.de>
 <5ce5048-db22-67f-aceb-a358c54a62ee@inria.fr>
 <65638cec-fc36-44c0-88ce-f9678a0a1d53@web.de>
 <d0fb31c8-2888-47e6-c527-57f0e828f32d@inria.fr>
 <20d8778f-27fa-43ff-97e1-44375755d952@web.de>
 <8a69338-c049-cce1-2d66-a9607c175270@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <8a69338-c049-cce1-2d66-a9607c175270@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/LBUbgTOnJrwUoOdNEq7vFjSBg9fD56W40iLlmFUTKZypFv3yk6
 GlrdL1ud2guCnFoobk2mQZKg/hBQJ840IAS29NwBVCNOsOecPNvc8oR4EJQaZoLGV4mo88q
 jgOPSdAH97KuEs+BdF+XWAoygNCVDqz9x6OE7gnDYxuPDKI9sZJ7BsDKICn3WiCCa7qh2MC
 Q1qKmGFNLLb0U3HXC8u6w==
UI-OutboundReport: notjunk:1;M01:P0:li1RmyyL6NA=;TBGMqXmlVktZ5DKENEGl/XWWWDb
 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
Subject: Re: [cocci] Using statement list combinations?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2848
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/ab0209a9-fbf7-4bd8-ae78-d6fb337ee294%40web.de>

> I see nothing unclear.  You can write { sl }.  You can't write S1 sl S2.
Would you find an SmPL code variant (like the following) more reasonable?

@display@
statement header, footer;
statement list sl;
@@
*header { sl } footer


Regards,
Markus
