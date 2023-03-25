Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8F5C6FD1F
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 13:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=xu3XkL+F2/o8bqABHCAAT72Xc+dNAPuVZ9L5oqK9BF0=;
  b=RMgh6oQszbBYgloSzvxPAc2FYfwrD1AjK8CSlPCSkrYchO2HPNrHPfot
   D64DMwsqllwSbCdthHR/TQMxtCvcc/OgSnWq7gYxJBRnUtJVCqmbQBg3G
   azYPnDBS4AoFrgKoZOD+mNyj00FYeEifftyW0MqgLq1kmA6IchnlGvUN2
   s=;
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
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99064051"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 14:40:36 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E3A5EE0D40; Sat, 25 Mar 2023 14:40:35 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4564FE0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 14:40:23 +0100 (CET)
IronPort-SDR: 641ef9c7_Dm4ATeKFt8WfCzegqIk6ijScu9xK5JyS8Vgs/2tGig/c5bP
 ASAx9rnp6EvIBN1xz8Sgd+m5sioPiWsLq4MBXcw==
X-IPAS-Result: =?us-ascii?q?A0HPBwAV+R5khwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CLoFLLwQLRoRTkQExhC+HLIc6hGeEAoFqgSw+DwEDAQ1BAQIEAQEDBDiER?=
 =?us-ascii?q?gKFOgIdBwEENBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABA?=
 =?us-ascii?q?QEaCRcHDhAFIoVoDQiCLykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBE?=
 =?us-ascii?q?gJHUz0DAyMdAQERJgEPHwYCERUCAlcGAQwIAQGCeoIoAQMxB7E1gTKBAYIIA?=
 =?us-ascii?q?QEGnAofLCJTgV4JgRQtjQWDNnonD4FVRIE8g0GDfYEGgxmCZ5lSCoE0dYEgD?=
 =?us-ascii?q?oE9gQQCCQIRa4ESCGuBfUACDWQLDm+BSgJkTIEeJQQOAxkrHUACAQs7Oj81B?=
 =?us-ascii?q?gMLIAZYawIJIxETBQMLFSpHBAg5Bhw0EQIIDxIPLEQOQjc0EwZcASkLDhEDU?=
 =?us-ascii?q?IFHBIEKgQEGASYknVt7E4FMlBOwPTQHgiiBVYFZDJ8MBhMug2oBEpMLDgaSI?=
 =?us-ascii?q?y6HLZAPIIIupUyBeiOBXDMaJIM2TwMZD44gGR6Dbo8JAT1ANDsCBwsBAQMJh?=
 =?us-ascii?q?UYBAYV7AQE?=
IronPort-PHdr: A9a23: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
 Fg6h1kmCdk=
IronPort-Data: A9a23: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
 Qkix0DN
IronPort-HdrOrdr: A9a23:AHjMY6/wDWNsEY1L+ftuk+AMI+orL9Y04lQ7vn2ZhyYlFvBw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNWftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOb+EYZmIbsS+V2njcL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99063767"
X-MGA-submission: =?us-ascii?q?MDGTTtN+ew4VE5AoFbeC9HW81SWG8JM+EtMzwS?=
 =?us-ascii?q?lVMoLg/OFMTWpPOIaPW2AJpT4gn5D0k9DYK+rlvKE7lFy2iQ0uiQKUsB?=
 =?us-ascii?q?yB5OsXA+LF8romokKPwOQRlEye2JbUVuoxf88tY5xd/sXecI+s4ebxhr?=
 =?us-ascii?q?PKRUxKB6sXRTz+n3FYWznXUQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 14:40:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679751616; i=markus.elfring@web.de;
	bh=lRoWN9GUUYimS2BBB1F/Au4aB0mJQoK2OFg0/or2gR4=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=iljR48N2ISK4ji74ogClq9/g7sMQh/XfauudPea01HVqlD50IK6UhHBlg+6CDGilk
	 C610HqemqI7SLFXfF91nsQsFwsvLU7ZrScf2sk5pNkbcHY46uCfogGsoIa5nqkdsDk
	 18qmxvdp0wG8nDfp49VbXry+U7Ik5dDlcPzRrHZFgOlSG8qNQ43B3NJF3v+tkVHGFQ
	 hL5ikEUsVcNp0uinMHB1z8g8ovFOBiDkmRKGfZbsDSiEu898OpgQrLfOc/kmrskmFa
	 R/O6ZDLKr7O2qfUE/WqzkYYQapWnn0EDmsrXlNyezL1ywy3S6gUxLFEuW0mHSgoIDj
	 p1P28TaVLWHbw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLAVa-1px31012Li-00IE91; Sat, 25
 Mar 2023 14:40:16 +0100
Message-ID: <08ddf274-b9a3-a702-dd1b-2c11b316ac5f@web.de>
Date: Sat, 25 Mar 2023 14:40:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, Nathan Lynch <nathanl@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Moore <paul@paul-moore.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <0981dc33-95d0-4a1b-51d9-168907da99e6@web.de> <871qln8quw.fsf@linux.ibm.com>
 <a01643fd-1e4a-1183-2fa6-000465bc81f3@web.de> <87v8iz75ck.fsf@linux.ibm.com>
 <2f5a00f6-f3fb-9f00-676a-acdcbef90c6c@web.de> <87pm9377qt.fsf@linux.ibm.com>
 <afb528f2-5960-d107-c3ba-42a3356ffc65@web.de>
 <d4bcde15-b4f1-0e98-9072-3153d1bd21bc@web.de>
In-Reply-To: <d4bcde15-b4f1-0e98-9072-3153d1bd21bc@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:buliI++mbLivrPirtf837mS+GlJgikN3OEFdGeTCMGXnrjtwIeF
 DQKkwH8tMwGZefcuFs8I5peVX6lfAJH8xBch9Mb14JwwU5N6rIZU0ZN9PDHqh0Mimi4kG8w
 vVvZTjn9R9vsEmrsb7xw0y6fvHM1iJjRsYVWydMmEwuv7jjQXkoNOKRWeMG8l9h8g3Q0NYE
 ZsEtXZ2egmNNjPQIrRgfg==
UI-OutboundReport: notjunk:1;M01:P0:TAHde6W2yT4=;OOErgJQ94CfmXPWl3Pyok2dqxkd
 CdY8B93M9ewX9Y++8EybdcoOTgHX4vmYXtqHmSFcugDeg6Ds8ez5fFIPf8UGU3E4oz3S47VOW
 rUOUT9pz/k6TGVR/yI42J0g8VBEgxfXf+aI1q1e+2YLnOFt3qAgbJw9uM69y+06hzwgwas5BR
 zuLOuXJUphP7wSwNngy58DZEQosEU4vRHTFDy9D6U54nc1J12Ks99A9UOijUk6wf90sLoJeX5
 aYXRU0y3CzF0upY8kNpowcf2Qyk6rpF0sAQF99Mtxr8g5hZ58CEjklxUh12OLTRlernfeuHDN
 bYL8f/9TcPyIrandblF3Hduf1uybCf/zr+Gsz7MoMckum51n1djdCc+j+OBnp3ZudhfqTG/fP
 PZda/eTMVeX1GfnPZhzqw6MT41AasAGIUhojxcbiwEfUIuxqdb53v7WLINX5Ph2WZokzuhEuH
 dznE3jxEnl7iYpl+P+mOPGgVVMpUSg4Uc9ywZGWgOCm8LhsSbsky5CUFZgAOolSArDILjWRsi
 04Ab9UoS4wk3DH0EjcaCzPWEgIJixCgnCFlhXU0SfqUwMdr1qk7fSSYNeDq4MGhGfuDs07145
 ZQsGi8449CZ87qXn0gQRkRe0pZycVet//rGbnbwHUhTx41gzo2JqD0MUnibOk9Tg3ur+vDI5W
 L4mZDhsxWx3M0Id6cAPnwpibfaUZXhpourrkHb6MzHznX9VYErmt65Cu0+hORu1j6zIIMKoWj
 p+NiN2rxL8oLqv0XakSj3dOcysKXOOg9uKoY19uNGQ55SbT/bMX8Cuifk2tiANITkP7fZ7KRM
 1duF9lFGZxv0PpHhKyzDeK5APLJoC8HTKmkjBM9DVV9H9P8N7D5l44iPJNN+c0HEQBJWumDKU
 kTYthiGZKeS6EonPLou4PS6OfJQUxn3m52WMHQ6TsC/Aiq0NHBcx3tYqi
Subject: [cocci] [PATCH resent v2 0/2] powerpc/pseries: Fixes for exception
 handling in pSeries_reconfig_add_node()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 943
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/08ddf274-b9a3-a702-dd1b-2c11b316ac5f%40web.de>

Date: Tue, 21 Mar 2023 11:26:32 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Do not pass an error pointer to of_node_put()
  Fix exception handling

 arch/powerpc/platforms/pseries/reconfig.c | 26 ++++++++++++-----------
 1 file changed, 14 insertions(+), 12 deletions(-)

=2D-
2.40.0

