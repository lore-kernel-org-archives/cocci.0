Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CFBC7618E
	for <cocci@archiver.kernel.org>; Sat, 22 Apr 2023 15:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=IAdjPCyJeG+ZA+3rwU2XoTZNKv1drgZulaB3/2F4KAs=;
  b=feAjVjO07piwhW4ItJipDieQp53lC8xfOc9dZ1tm5Ejp8aH4Kriv54F9
   5Ar8kDaHXSNhl+rRd6j9q6pxCVHadjJZNUlxBhxkCEVqmjfo7q+M50ENd
   Z2MS+lsukwkpXrDLhqRP2+PAMaRbXM4zSp2uCOSAh4GBf+0zehCW16bvU
   M=;
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
X-IronPort-AV: E=Sophos;i="5.99,218,1677538800"; 
   d="scan'208";a="104298970"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Apr 2023 17:33:56 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CD415E01D1; Sat, 22 Apr 2023 17:33:56 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4C926E019E
	for <cocci@sympa.inria.fr>; Sat, 22 Apr 2023 17:33:53 +0200 (CEST)
IronPort-SDR: 6443fe60_ASoRd61ux1jSzdqmm/mIJaApBu4kTFTWIICHJzN6xYTdGxm
 l3AeYEw2aWibxAb6uwf0ST9GApKZiROblkYQaLw==
X-IPAS-Result: =?us-ascii?q?A0FIAADz/ENkhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYItdVYvBAtGhFOPEIInaYNHjmyIaoFWgUA+DwEDAQ05CAECBAEBA?=
 =?us-ascii?q?wSCC4J0AoU8Ah0HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEB?=
 =?us-ascii?q?QECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARICDTo+AQICASMdAQERJgEPCxoCJgICVwYBDAgBAYJ6AYInAQMOIwcMq?=
 =?us-ascii?q?nOBMoEBgggBAQacDB8sIlSBXgMGgRQtAY0fgzd6Jw+BVUSBPIJTMT6CSxcFg?=
 =?us-ascii?q?V2DW4JnlhiBM3SBJ4EygQQCCQIRa4EQCGiBdEACDWQLDnCBRYMXBAIUNA4MF?=
 =?us-ascii?q?gVCJQQOAxkrHUACAQs7Oj01CQsfBkQCH4FsBC9YdwoGASUklSeEE8YINAeCK?=
 =?us-ascii?q?4FWgVkMig2VAAYTL5cJDgaSJR6XWSCNM5UnhSWBaQEzgVwzGiSDNk8DGQ+OI?=
 =?us-ascii?q?BmDWTOPSD80PQIHAQoBAQMJhUYBAYV9AQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aTZiIyKrIxXiaI8LCq4R0NoJQ==
IronPort-HdrOrdr: A9a23:hSZKYqN4znuLLcBcThWjsMiBIKoaSvp037Dk7TEVdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YFT0EUMr3N5DZB/KTHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:txIIPmCQU+b8cwv6EwRY/gkYWZ90SUP+wnj/HVWTOEwwZqLAHA==
X-Talos-MUID: 9a23:NTK/QwnFWIHtPxRB3YOwdnppC8NCyf2JUHxRgJwCns2OGSFxMj6k2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,218,1677538800"; 
   d="scan'208";a="54042754"
X-MGA-submission: =?us-ascii?q?MDF3nfPdtJgqOK5wYevMA2kZNGeH0YgsAfL5Zl?=
 =?us-ascii?q?/Qox/be+YwSPiEj4smDfXWeD4gZx93DhqtG6QSaL8eeRilVhUDvlQgot?=
 =?us-ascii?q?eU9d3GC0P6mRSg+WCgfeG9GZN6oLngeXctfTLgQFMFbrC2+/tIa+jY3Z?=
 =?us-ascii?q?OK9TAkgnIS4WTnBQsZoY64Qw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 17:33:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1682177632; i=markus.elfring@web.de;
	bh=CYa8BFR1l1ZaMUwTx4X92vlyH5PiRWMq6qbO5LYiSpE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GyPKZVQ3Tt8U1agI5Bau4D/ACx6/6vxi+TFl7QK22PHRw6GpRcFyrErQPKQJL1X+c
	 mNph8pWh4HkCnyKYZs6vkKucOtO/napToSS11/P9RdsBJpb3Rrk8RbmznJHddIZx2f
	 cZUCNXn5pV+2oXUiNsQWsoWFUO8uL+nSNzLI2Dm1zPrc/qs9poNoCzIpq3yD+uK31J
	 4Q4j594umyn4Qr0LPFQWWayLS0yIWKXedf30a3RMORh0Z3TSkkUJcBwj+RwTmmXZsE
	 zYObLWn4pb+021P4A+ndyUac+hO7myVPoPH2eOFtOlu24dyc8F+kpOidL/uCzV+1p8
	 Wi5d+PA/G3LHQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnX5F-1qYtP046uT-00jBCD; Sat, 22
 Apr 2023 17:33:52 +0200
Message-ID: <e1bd2ec7-92e2-9a7f-be08-d6932f4ccbf2@web.de>
Date: Sat, 22 Apr 2023 17:33:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Thierry Martinez <Thierry.Martinez@inria.fr>
References: <037507d2-ab0a-7d93-bf3b-10e51e70fbc6@web.de>
 <alpine.DEB.2.22.394.2304221031370.2766@hadrien>
 <e170b7fd-c7ff-c3cf-db35-0427833a8215@web.de>
 <alpine.DEB.2.22.394.2304221719080.2766@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2304221719080.2766@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z06zcf0dkkIASFINgGEp4OVWYGYKipHZWhhvWBZQjcgioKdTwfn
 Apu8w2AAjS2GxFGpocM4ELHZrMWbpCL5YpNmojmXCksv9CDm8F2ADrcirZdsIVYtF9qJ2Lp
 nsYO3rJdBrRTFSrne8lXNEWZVnX6Qdnu9zllRYoeXFIW2xBzX5s2Ta8+SZWvBhNjY0cfcSk
 ifXZ/stJi2zmerXpHBhRg==
UI-OutboundReport: notjunk:1;M01:P0:xbRVWyWPK0Q=;YDsaKxGJYUiZpSsPa6n36v/VSuU
 C+TOlQ5jfZcvRJukxUomeQlKRKReD+cP9E8nFsMfLrSogKz4EoC8bfBeCXWUcPzjGuhQ6eNYu
 6RoS5AyEWztckmX1EEW9Tkv38Ltnd9bOgXSYGr+IOw5Vg2m/F4DcAVlChW1VSRrPl0r5zci3W
 k2hNUUVtRnr7Um5wFT66KSZyXAYZ2Gs1ajA3Tiin6BeXOaA4XskgsJklkRs15UcrElOM7iLB0
 i0V+wjUWR+WbsOQofUXju2FhiyEDfAcP9YxaBGSBMNjfSFM6MyFMM5+tVjHvHk9YaC4GYLX/2
 uJi1NXQLgjou9ezm5lGD3q/9LBXb1ILR4dz80xbdyxsSTPhR8wKbnYaWx0N8qbZKK/gVrihj2
 Zd+63cQhR9NJ7p3ygg3sV+EDlhFHHbyviJVHo9qtp5zhcesTGSvGGpmOaQYrNlfbAx1AO6ajW
 3/19/nS0Za3hDdtUc7lrCk9HFrcGiOSrCiOQzxb9vZ2cZetVU+sIHRq8Wu1zCnHL7/IYJs7CS
 dgLfkK07Jyyi2hCeaA0ODbWBAJxvt26U7O+rO5EzJc6332thwxokUp7VaD67qrTNBnyVxTJIV
 C+knkDXtjLF4vQw0i2TTBaL1c3TTGN3hsJSIhDMyNBrZGV27R1q5ur4yro7Wsq0Ve49z8Y+UH
 RFEdLptBY09yA6aU5hIOVsQssdzCIHM+Ncte7EVqm3ieB/pry8qPXWT/lQfl/i2pQz8jLjz63
 qfXerddrVnKtXa0wVYfzaFc0EeYuOvZZO1MqIIyCiEpHqF6ASs1DIjSNSghvKLlXldeTqOh6L
 ruFhUQu9lI/2JCXqLTi/oHTFvSLL+103W4jrhu/BuKAkp6ubrAqUzvEf/Uyhz2U08C3JVNoVw
 yK9O44jvvtGnkxXdsUjte8Ek6MjoUhfIY/r5oR08yCplk9sCN2hWxtcvdFRqWfD77CjDgtVOL
 t0zLFT8NwECa30/7bm4XWF7hkwQ=
Subject: Re: [cocci] Checking data processing for provided string literals
 (with SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1119
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/e1bd2ec7-92e2-9a7f-be08-d6932f4ccbf2%40web.de>

>> How reasonable do you find the following test result?
>>
>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch check_=
string_literal3-20230422-debug.cocci string_literal_usage4.c
>> =E2=80=A6
>> text:   "++"
>> no match
>> text:   "X"
>> no match
>
> OK, it seems that you expect the value of a metavariable bound to a stri=
ng
> to have extra string quotes inside of it.  Maybe it would be useful.

I got the impression also from this feedback that we stumble on
a different understanding for desirable software behaviour.

String literals must be enclosed by double quotation characters.
https://en.cppreference.com/w/cpp/language/string_literal


Should white-space characters be excluded around them for the contents
of corresponding metavariables?

Regards,
Markus
