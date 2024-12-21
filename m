Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4ABE7718B
	for <cocci@archiver.kernel.org>; Sat, 21 Dec 2024 16:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=hUAt10+QeD/1oHnICrAa3sFhhEDA21dA3LEIq1va/oE=;
  b=XStNyB34NneRxFo9bBaw95h+lBeIOovW/bZShf+ATmLLKc87pRfPfV1Y
   PVYRp9Jut9dDQDPdse+5ohqGrMTUG8X7XAcfLBb6XEeKMU19aJEsas/6N
   q3FTY/6UEDlUtwCe7MdWDaQxTk0fGzSI2lJ+GK84RyzWPGBw4khrIReIU
   M=;
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
X-IronPort-AV: E=Sophos;i="6.12,253,1728943200"; 
   d="scan'208";a="200421953"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Dec 2024 17:14:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C4631E0137; Sat, 21 Dec 2024 17:14:21 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id F11A7E0077
	for <cocci@sympa.inria.fr>; Sat, 21 Dec 2024 17:14:19 +0100 (CET)
IronPort-SDR: 6766e95b_UIuSPluuZRdGyqqwklFgQsqzVS2O2pGLgPwyw/nx3iQS65U
 aWeIe/HQ9N6CkKd+9h+rol9ZG/WU8XtH1rMt+NQ==
X-IPAS-Result: =?us-ascii?q?A0HzBgBg6GZngwsR49RaHgEBCxIMQIFIC4JEYiFUMwQLS?=
 =?us-ascii?q?IRWj02BdDCEO4c7h1aIdoNUDwEDAQ1BAQIEAQEDBIIMgnQCim0CHgcBBDMGD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBOgcOCjGFew2CY?=
 =?us-ascii?q?gGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREnBAsLGgImAgJWBgEUA?=
 =?us-ascii?q?QEXgmaCMAEDDiMHsAaBMoEBggwBAQbaWx8sIleBZAmBGi6Fa4JjAYYmhDwnD?=
 =?us-ascii?q?4FVRIE8C4J4PogegmmCPIV4Z4pqiSiKRFJ7HANZLAFVExcLBwWBKR8rAy42M?=
 =?us-ascii?q?YIFgVsFNkc6ghBpSTcCDQI2giAkWIJNgSUEBYEtgj2EYYRWhhuCF4FrAwMWE?=
 =?us-ascii?q?gGBXB1AAgELbT03CQsbBj2eEYR7f6ZJoTo0B4I4gWWBYwyfXAYTL4NxAZNRD?=
 =?us-ascii?q?gaSe4gpkFIiqQmBfSSBXDMaJIM2TwMZD44hGYQUtw1CNTwCBwsBAQMJhUYBA?=
 =?us-ascii?q?YowgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aXZhYyJfa1jdXPMLA==
IronPort-HdrOrdr: A9a23:e4LRzq93zxABSBf7zahuk+AGI+orL9Y04lQ7vn2ZOiYlF/Bw8P
 re5cjztCWE7gr5PUtKpTnuAsa9qB/nhPpICMwqTNCftWrd1ldATrsP0WKK+VSJdhEWtNQtt5
 uIGJIfNDSfNykYse/HwE2fD8sqxsWB/ZulnOHE0h5WPHtXgu1bjjuQEWygYzVLreR9dOEE/B
 Hw3KB6mwY=
X-Talos-CUID: 9a23:WbUkO29q2Q/Ub9lVvbCVv3VJNdF5a3/Y8Cr/Pl2eC2hgV5aXZ0DFrQ==
X-Talos-MUID: 9a23:zgmiDAQ9B9fyOac1RXTDoBpLHZtR3J+NI2MXoKkbuNWNPH1ZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,253,1728943200"; 
   d="scan'208";a="104943451"
X-MGA-submission: =?us-ascii?q?MDGN0LmeqLXgZ9lteGI6oQ0rzCGQEmg3CFBXH0?=
 =?us-ascii?q?nMQ4TR0JmvNCQjT8J9T4WVP5SiFDHh8afra469NRZX817t9yhWcCmTFy?=
 =?us-ascii?q?YIVUIa282Jp6D6lXrIa5aB1INEt2zCx5g2M8X5rEZNxyZJEK1r++d6yg?=
 =?us-ascii?q?69bXw0rCMAuXOY/WZ9zb4Wpg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2024 17:14:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1734797657; x=1735402457; i=markus.elfring@web.de;
	bh=hUAt10+QeD/1oHnICrAa3sFhhEDA21dA3LEIq1va/oE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nbC35DWgoXbCAgMSknDoHP0gLtivX+QkYcSm59XJmD1/ASNCjsRBDCVgroFZOMsP
	 j0/VRkMnKMwNtfmMuK+fEJklewEC5gQ7XhshLcdPDwypVEyjni594FC7J9QZo//0A
	 DkH41JGMx42AoaJ7iNKAPCMDl0Lb3KAINyXreMYr53yXpiimznd9lHQ4of0Bgj7SV
	 6E/URpKHXMKsQv7LnAadodcXGzY/3W6AsXssXbmtMe3B6fxYkHMtdWMvNKXklUYes
	 0iLkUahzqhJHjBRwgi2Hq/VbrkMQdjVLx56MX1/iqPcVwTGFnnW1JgrD9Rqgd8eCU
	 PcpONUzpriI3wWxqHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.93.29]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MAtwh-1tIfGi1llJ-00BL2Y; Sat, 21
 Dec 2024 17:14:17 +0100
Message-ID: <0e37b3f0-b629-4048-ba71-eea7a8dcd07d@web.de>
Date: Sat, 21 Dec 2024 17:14:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mats Kindahl <mats.kindahl@gmail.com>, cocci@inria.fr
References: <f0764391-b0d3-48fa-8a54-6edddf8d2c8d@gmail.com>
 <da51b2de-12cd-4aad-d989-79e925ead01f@inria.fr>
 <a1e9628f-4d97-4fe3-99d0-585a0196d988@gmail.com>
 <alpine.DEB.2.22.394.2412202253060.4924@hadrien>
 <0146ddc0-016a-481a-89e7-b83a8493df6c@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <0146ddc0-016a-481a-89e7-b83a8493df6c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Fy/uR8pe52V9cs70Amm77AmQ3BEOkkKxSs/NnzEbgZGTWVLmMgJ
 BbvrRdvVmj10sE4hKruAUd3+Vi0I+Nf5AsmkdaZKEKcJagDb4AjkF8FKQfAJn/xqCa9max8
 FCRx5XSNzaiMlchJQwgKflr/8c0hPiFpZ9tMBx3QhnNOL/SfOrceHKklBRsbkGjHcD/kMxe
 EUkNybZEqqWKeR5NLwRLg==
UI-OutboundReport: notjunk:1;M01:P0:y51I092Z2Y0=;dLLrWPNMWhWQDvQm7ajNXsFEOgx
 Qc2U+ca5IejnerZKSBRIl3h1mf+sVxrbJxOv1J59eSblPkw5WKGjjQiCvockF2IPLphTq0RBp
 9Rmh3tJQ1TTnYX+Tkcykw6jyysD4MIoPmtfVBq5NEjBzKqvuxl8m91H7LK59hH0Qb0he7jgxW
 puAVEJuJmCdRbFyJ0M5YmqpuvseYuQ5KjscRLMM6BjntJODyq7zUzS020hcTyljksLCJymfCj
 pst2ZNt2BBiRgJpy9r/TUGc+Nj7CaO5/Pe5LyJmpZn+geQSFtZDSY4mkOR9YkYEr6TVUKy3+P
 KlstMyHLV5xf2b31EEQ9XjE/HKAnd9SS5tFmyNQ1zYOLj0nSxeN+4LxQOtvpnmFZTCJ5caiFm
 c44SdDpQ+uv2nE5ZPDQcW0BVVALYDmjNn5ceI4jFEiLhp5s83ZySSGKzhsyEhQ7MxrtJwI9qi
 kYpFvVsi29HJ6hVLu52ahyolsqwf1GeIm8U8loN+y/g7uksUbwu4niOiFAW9wwkPROyeLQKFL
 H9NrvtSiGD43fFMEuJlGDnup7nhRcb5qvkmypj+BdqG3y6VROGARaqn3e+Rk9GrWbBqXUCAvl
 STpf2zD290W4rGXe574l4FlEEqyK7SN1wQE8WRcKwMnRs+8B9dbALKaodf6hB2jb2BiY28OoQ
 TDQPkWiUWmztNYAhKN0QZXcUZQuUneioy+lA5CJKbgABCHoR3NHZ8oJEF6JQXPiGRE27NV15j
 m0tWDwdH4m2fWrp+DHXLc/DoT1xmKxaB3LzSnT4MXrF3A5zo9AEcvLj6/6L91l2Tcp5Ttyqnc
 2hPoy7zRgLefEDUUu7y7CIT4itXDM9AO/5fpZE429s3MRSgf9XEy5q+iDS2nfLIqUEGbc3jIB
 OPhTubsG6AWfXKLOYJ3djZQpp5Zc79ecWDVYnBoiC3GjXT8mX4gjc3vwycIuZ4owsKjh+vIzs
 jTi/enk0POZlpEFKdA7qTKQaGyxBvqcZW1GFHxJQ7QdPktLo1HjF53xIsepLNBXm+PeAXCKU2
 OA/JjG1ZuL/8SJc+DjFDkS7n3x2EVeWbjeh3+wrSwKPwg3PhH12msvho97+32xdi5xu0xmUm6
 UOAVwIk1E=
Subject: Re: [cocci] Depends on with negative matches
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2194
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/0e37b3f0-b629-4048-ba71-eea7a8dcd07d%40web.de>

> I feel really stupid, but now it works.

Will any solution approaches become more interesting for known software limitations?

Regards,
Markus
