Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A8EC48BC3
	for <cocci@archiver.kernel.org>; Mon, 19 Feb 2024 07:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=3KLwjEUU4Vu8/0mpX+V/0bYSk1n908nmLLxRW0zgEwg=;
  b=jc8JIq7/JjLL7rJvYfwGBgANxT/UgBVggpIm4c8hRvV5cMTZkY9QXz3g
   9Ef0+pftPWuUGnLj+2mAp8oBb1/0Hp8lYYPKCv52wx7N3P1fG7sRxGZYn
   ae9Xz9ziq8cq4t7frBooAJLITPvtEBkxlqHqHkKTD6CEXHbKBC/YTF2Mf
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.06,170,1705359600"; 
   d="scan'208";a="152559821"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Feb 2024 08:48:50 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0EB01E0CD6; Mon, 19 Feb 2024 08:48:50 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 612D9E008A
	for <cocci@sympa.inria.fr>; Mon, 19 Feb 2024 08:48:46 +0100 (CET)
IronPort-SDR: 65d307dd_dTy5AQxph4dU7Mv3wDM1lFYGFZmZButCZwXpdiWVyuM6vp8
 7DBnloUCZJMvJMbv/JfmHsWos53/Qd5Ywd84q/w==
X-IPAS-Result: =?us-ascii?q?A0E/AAD2BtNlhwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYI4f1MyBAtIhFORaYQ7hzeHTohwgVYUgSw+DwEDAQ1BAQIEAQEDB?=
 =?us-ascii?q?IR/AodkAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBASMXBw4QJ4VsDYJcARCBDoEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHQQECA?=
 =?us-ascii?q?gEjHQEBEScECwsaAiYCAlYGARQBAYJ8gisBAw4jB7QwgTKBAYIKAQEGr1sfL?=
 =?us-ascii?q?CJWgWEJgRouAYglAYUkS4Q8Jw+BVUSBPIJSMT6EBT6DW4JohHhbg2uWIFSBA?=
 =?us-ascii?q?h0DgQUEWg0bEB43ERATDQMIbh0CMToDBQMEMgoSDAsfBVQDQwZJCwMCGgUDA?=
 =?us-ascii?q?wSBMAUNGgIQGgYMJgMDEkkCEBQDOAMDBgMKMQcpVUEMUANkHzIJPAsEDBoCG?=
 =?us-ascii?q?xsNJCMCLEADERACFgMdFgQyEQkLJgMqBjYCEgwGBgZdCRoHDwkEJQMIBAMrK?=
 =?us-ascii?q?QMhM0ERAwQKAxMHCwd4ggmBPQQTRAMQgTRChHaEbwyBUgMZKx1AAgELbT01C?=
 =?us-ascii?q?QsbBiIBHQKhYwKWcLIwNAeCNIFggWEMnzgGEy+XMA4Gkl+YWCCoV4FrByyBX?=
 =?us-ascii?q?DMaJIM2TwMZD44gGYQUj0dCNTsCBwsBAQMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
 NTCxvubwNZq9tXJ4Y0DCsKSJM/VaBIc
IronPort-Data: A9a23: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
 FUI
IronPort-HdrOrdr: A9a23:ILFBsqhnWC2xtN6MskuMFRvPsnBQXgQji2hC6mlwRA09TyXqrb
 HMoB19726MtN9xYgBHpTnkAsK9qBznmqKdjbNhWYtKGTOW31dAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWuFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQlTuRRjz7LqVsLjM2fabR+a
 DsnfauLFebE0gqUg==
X-Talos-CUID: 9a23:tNQ83G4s1uuGtE5vddss1mokAs4pKETn1W7PP1a6BSV4UIHMVgrF
X-Talos-MUID: =?us-ascii?q?9a23=3AeJx4pg9AaGjL1MP5cMa5E9uQf+hn/q++BXgdq7l?=
 =?us-ascii?q?YlpWjGQF5CyqgtSviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,170,1705359600"; 
   d="scan'208";a="79982313"
X-MGA-submission: =?us-ascii?q?MDEy2N95OB8YIu198VV5BWHGIdeCSJ/cBYbMjl?=
 =?us-ascii?q?FV7YkJWZcDkQ9E8/zbLxtntmuXMOXwXxZPJcCUvm/2Bt8fRUQPppCuQu?=
 =?us-ascii?q?sJ9z1DlwKcRO3PcRnb8pWJ0aYBcEZgvUkhNtVpv31eRUWDDXuO3IQ6M3?=
 =?us-ascii?q?YzuFT9GgsEavu2h8tHldLQ1A=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 08:48:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708328924; x=1708933724; i=markus.elfring@web.de;
	bh=3KLwjEUU4Vu8/0mpX+V/0bYSk1n908nmLLxRW0zgEwg=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=ett0HSoctxzSr3mWlrIRe2BL4RoHalhSqmgCS0NF6p1ZXkexLLKGLq9+xAuExogK
	 gat+yhSrUIBc2nwNTf71unJqLj8D1R+OaONNZ6w28+MFO/dM17eOvwZv7vCjePaYI
	 Gep2Nru07sBR/liH2f2IPdt9Zc8w3wbzExZUdxXnYb2Edp0njzjRhSDcR5WwODdLt
	 +nZC2puLcFPiFANJkK9onobyhnaQYR7SD0gs5WiMtfDCygx2CV98rAV8lym2KSqSL
	 wF77jDY6DuHg1sA2bw72vb3q9MGyI69XUhDHETFY8hZ7NZ06AdGFhCDGplK18bGJa
	 MI8MZScoL82bAzDLnA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzCED-1qgAff2jg3-00wDDG; Mon, 19
 Feb 2024 08:48:44 +0100
Message-ID: <f16fa613-738f-4a85-89a2-bbbe0c05b18f@web.de>
Date: Mon, 19 Feb 2024 08:48:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <c5bcc0b5-1a19-4256-8572-b9ee5e78ea0f@web.de>
 <12009cea-f93c-4a80-a95f-9bde16dc78a5@web.de>
 <4bd9de70-de02-4fea-9d41-095304edf4fe@web.de>
 <38d77d89-ffb7-d495-ff80-898861d46d32@inria.fr>
 <5afbaf9d-892b-4105-a54a-35f1e40e6749@web.de>
 <6a89e704-5561-4f44-b9d7-7c8f78976e71@web.de>
 <alpine.DEB.2.22.394.2402180908440.3095@hadrien>
 <30fef057-5f06-47bd-8b62-1bb6fc3fb946@web.de>
 <alpine.DEB.2.22.394.2402181707300.3095@hadrien>
 <407f678d-05a3-425d-a93b-dac350e9c731@web.de>
 <bcdf429d-a35e-e4b4-b2b6-5e455a8f6035@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <bcdf429d-a35e-e4b4-b2b6-5e455a8f6035@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B3tZRsISArCbArlMxsn/MkSgvekcVSLaUF3xdXY5mlSJSe9nT+e
 kNN0IQkYN8B/+7K183lBQPD2rOx8Az48RIJc6w56JpqPPegduxAye3qVU29OTOEztSAxcXX
 Z44S2wVuiyYsNe3Bz9E1cHNRL7iKgRc//yECyDX3WG7XenTjN3hqtISDjE7D5HzezSNXAo6
 bbvogPH2UJRixZWaTR2mg==
UI-OutboundReport: notjunk:1;M01:P0:VzDa/wLCLkE=;/k7jGg10rtxebWerSl0myj8riel
 ficpfCNqxvw5SK9wlbY0Si/aq6Mj6FZZNCFsKq0lCfX8lLij0y+MCARnFgCPW3iLzSWR7fZYI
 DYUDuCoAFngpP9GgIUbVD7hqvzRWMavlR990/O4Z351XnW40uKkjsaDpuYJDqeIdd9QlmR/cu
 xlBYKcc7mJPkVhen5NLI/Z1JPWsyIsRrZzM/Jgvh0tqcnrfqx1vtrK/sbJClb83mjohsiG7RU
 MxIaYnxPYtsKOtLr3xFfCUS9wP0Ux1Cp7WuSFJJg2hTBvVk6RfSy85LGyLBV7uskihAouMh6n
 7cfUJYYbtBZGmRUSfwh4CivwnQqbNKhgVx739wY23glG7DgrJLwe1JSBKuwxgggeHkxHvblA+
 +LTAGvHT8Cnynf+TFcUxr4RMXDTLSV/uLFiPy576uwEntgQfSAFiZPa7KdPXy+QJlrQPqTkEW
 7NKUvShjN5pe+foYIugc0Y/lF+D4jMCGuVT/ZtXHhmaX4rmODgDAT4etT1iLBu8X3AERGpRl3
 FHt5qG5V8WvbDPDrJLpMPSGPmiLkz6BXnul2PzE/RR4SiGtprf4y2Ig1f6yMuYlXx3nv+5MnL
 jKwg/ovvZIBj10xH+oUzBvrZnRVNchdo6RZiUmPZO+zdTCN1Bq+ejagYwQcqtnQb6oFqySINy
 CgxYNLHTp4ekxj4gGNFJUAhqECPsrz5YELYdwA6Ft+f7g6uvVIoB8d2TTmtE+fFkH7RA7YgP0
 VwnTJrrICqc8M3kpU0uXdR5vlqNWWY8xCHFyTcV12dQRayz3EPoSHeiKrC+H8I32a32nRLjWe
 /ooXpubkrLeKQpdxifYOw/mwP6IBbL5oBvIlqvbM+R5rI=
Subject: Re: [cocci] Checking the search for a repeated condition check with
 SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1585
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/f16fa613-738f-4a85-89a2-bbbe0c05b18f%40web.de>

>> How will the chances evolve to achieve consensus on the desired
>> evaluation order for the shown source code search and transformation co=
de
>> according to the semantic patch language?
>
> We are not going to change the entire underpinnings of Coccinelle

I hope that interests can grow to take another look at affected
implementation details.


> so that you can have the pleasure of saving 10 characters.

It seems that your feedback indicates general communication challenges
for the clarification of desirable data processing approaches.
Can any other contributors help more to adjust involved development concer=
ns?

Regards,
Markus
