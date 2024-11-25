Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2746D58D6F
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 16:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ZqMSDni09fAFBf/EXAsY4j/UacKvGZCa+0KHPA/gOow=;
  b=v0ucppaHuIsAlmCgj3qtXmG7mAQvvj3qtIj0yVNbVaVBgIhJ2wfpMpXL
   jKYR1ubme8Va/wSPzgyivSoS0rzZJxvW1zbQfnwo4fpEX15BLEqgiMJk3
   sEsIys4Kz1MBbB5i2lR0fl57ND0ep9HWeNrhL7rTfKjOB6jKAH5YTvHZh
   k=;
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
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="195724910"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 17:57:37 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8374CE0D7B; Mon, 25 Nov 2024 17:57:27 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C7E8BE0D21
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 17:57:23 +0100 (CET)
IronPort-SDR: 6744ac73_2xAStIoFhe2kEDxC9u1ldAAV5XafMJG1kTxkmAXdbrUFdG+
 8JEEZXTOHt+UQxuXx+BkmdPPRmwU+frhuCO2pOA==
X-IPAS-Result: =?us-ascii?q?A0EwAQA3rERneAQP49RaHQEBAQEJARIBBQUBQIFCBQELA?=
 =?us-ascii?q?YJDYiFUMwQLSIRWkUGEa4c7h1aIdYNUDwEDAQ1BAQIEAQEDBIR2CgKKWwIeB?=
 =?us-ascii?q?wEEMwYOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABQw4KMYV7D?=
 =?us-ascii?q?YJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAgEDIx0BAREnDwsaAiYCAlYGARQBA?=
 =?us-ascii?q?YJ9gjABAzEHsCiBMoEBggwBAQbaWx8sIleBZAmBGi4BhWmCYgGGJIQ8Jw+BV?=
 =?us-ascii?q?USBPAuCRzE+hEODW4JpgkSFDyWIGGibOFJ7HANZMgFVExcLBwWBKSEsA4F5T?=
 =?us-ascii?q?n+BNoFRAUKCTkqDLoFeBTdHgkppTTcCDQI2giQkWYJNgSUEBYNrgQuDXoReh?=
 =?us-ascii?q?gsdQAIBC209NwkLGwY9oVyES4E9x0Q0B4I4gWWBYwyfWQYTL4NxAZNRDgaSe?=
 =?us-ascii?q?ph7IqkGgX0kgVwzGiSDNk8DGQ+OIYQtxxpCNTsCBwsBAQMJhUYBAYtygUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
 9KJmK+hcF+qFvrL8MFaC8WGcKq6
IronPort-Data: A9a23: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
 kBtLV15rIqHpYId3Cqul7O52P3Ugd838wgVUA==
IronPort-HdrOrdr: A9a23:NYApxKAg5P+Xms7lHely55DYdb4zR+YMi2TDpHoBLCC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOlNK1vp
 0BT0ERMqySMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: =?us-ascii?q?9a23=3AvFesPGvEFx3nwF+H/GxTZVRr6IscTWLNlkmBM3W?=
 =?us-ascii?q?HGD5YVO27akDIpLhrxp8=3D?=
X-Talos-MUID: 9a23:Ni5hNwbuvCEFBuBTqTzSvSM+L9dS6IuyBVANra8FsOyGDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="195724202"
X-MGA-submission: =?us-ascii?q?MDGgYR/IswNBsjmVVLVjabfBWKLVCZ7d8Oq2iu?=
 =?us-ascii?q?YpQSkOoXajBHsNUbmHIpijkeQFDYDtXd7+sAmEBMISILfthDOCV9Fl1B?=
 =?us-ascii?q?8VSQOJTw7Tt793zWBWMbuSvNV8rmV7XKMGWMfFiyrWM0SiVJ+BnLW3Wp?=
 =?us-ascii?q?hHBNKZ37Oxz3Am9SfBEtNEEA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 17:57:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732553842; x=1733158642; i=markus.elfring@web.de;
	bh=ZqMSDni09fAFBf/EXAsY4j/UacKvGZCa+0KHPA/gOow=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=X3eB5ZULAI+/Tq+qh3Dw6Cc5euWxkSO9fw5oE2gu9fANPs0fM9SlK2bzSfg166Xn
	 94uwfanTQNKlogEtHlrzpjhVfrs0B9ZHjBmcgDMia5gUEuUz54JXfaXnayXpKIzco
	 v8OxOwyhvtKQ3hJear1NrfHYOCLBJ9cNSC0vp2uvsUrzB05Ca6EgQV5ibtXMVMJYF
	 qcwifaa0MrEcu0WOYdCc/HlLzLchMSzbEx8wLf8ma510A5wECf3JF4cJUYdfOiizU
	 UU2Tvn03gdI3+57cZKMfrgs+k5lOa382YpEhKAd+z7koRL0uI5Px2YuHSSjIF0K4b
	 Vd3Je150t7xZgBqYOg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiuOW-1trzYE1fWu-00hW7h; Mon, 25
 Nov 2024 17:57:22 +0100
Message-ID: <84112e0f-d7f3-4868-ac64-9b82a1925880@web.de>
Date: Mon, 25 Nov 2024 17:57:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <434d257c-f0a5-483d-9fcb-3303301ad867@web.de>
 <9e8d6626-f8a2-19a7-33d3-b0cc48d2fa68@inria.fr>
 <100663c2-6281-49cb-bb9f-55656dff80ca@web.de>
 <d05cde6b-6189-4c2-a452-a0851430dcb@inria.fr>
 <71494b2c-d690-4b58-ada0-59233e10c7a4@web.de>
 <a65c8579-de4b-c6f-f882-b62d667a839@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <a65c8579-de4b-c6f-f882-b62d667a839@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:exaELlps/kTfoN1TbfXnmm8jGHKEBwBR+Ye7LQxu6bNmCBvDzsv
 AlgNRJvHZY18UDHlPOBB1Vqu/SczaMNkDZN8bkwEKli4YKp4G7qyoBeU4nEGAg6uW2MLBUe
 zcKGXWxP0lGPRT1QAiFdILnGoeVaXu/QDKVbIHUKEB1CWHxmYWcuM8Q10yILgK+GuuHRQg2
 5V2rrJwIksb1UyqllOKpQ==
UI-OutboundReport: notjunk:1;M01:P0:MPZhAo1fWlY=;HyMqj0gsRKqJsvnpsjASW8vZzw8
 zWKzhVm9VuheNgY5w4TvY/59roCxegqNGrNH8KbIY6IuBqsBoc9Y5qtYnEOn5Ef/q3Q/bcEUk
 uxPXxzRJGnqxTKsGSCTn8DRWWJeMYovpRPojaHNjwkKohH+VNHWb4cogGKw3znDNb9rpZvlVS
 vLx+1hoI3gWrVt5av8bvaK3lOOn5PVTShMSMPmNS0jWyWbx9kgNmLilySTNmpFvrpKededYUk
 90mAiUjLdjXct8ZbNbGCU8VUXby1XNUMJ75Gi4qNrIX9TufWqfB3+4QIROtFk9tYmM972FBkc
 nmR4FwNjHqVgiUV+fWdilzQFxCuqWEA66XTS7JIRPCj5RvvD+48lMFjF2Ll/IBKMM3iDz8+bW
 jFuOfdK+V188TSckdsGgtAPfe4FsEifkpdCvDJCso8UOmfajUWInG7MH1Airlse5KknsBUJ8+
 W1fRoB5e3+DEi8WvWlzGlgOzhmV72CXamxYfZnr5ya+vLthkD4Ypsn74LfP1Bit4FG2nW6eLf
 vqD0uhX/4QVErUQpPgDR5tHj+tFJjt8IdoevjrZ1t1egdrucp1J+3re/lRKKOKTVAywW8lov0
 tULkGBc5n8Aa1tcO/YaGnk/l8g/azHv9nSGBSYqTbWzSuKJvzRrwrZkIzIhPG/BDDP4xCj9py
 ob+ExZUZR0pvJ1i6XzFYnOZa7aPt2Amblqu+3jonvxCDYrrpyYV1a4EWJHH5xRWnYhqHVU9zx
 aeeFj534drUy9vU1xuVVz2kjFXtzhawUvZj/X1zdV3H/QmtGsUtZ7KejqEywNYMZC7+FqE3UT
 9IkQlny2XLX5ASMmbfxPnZ0Ur+1gCTqQ/pVanMEIM4k7NfOUTZPwpyN8qN1OC2E4uwy3XmYhN
 BalzU89+4eixyNXlY96hdq+uDAXfo6nKONOszkn9uPOlDcfTX9bEWwnvK
Subject: Re: [cocci] Advanced handling of logical operator chains (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2120
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/84112e0f-d7f3-4868-ac64-9b82a1925880%40web.de>

>>>> * Specifying a varying (or even unlimited) number of items for discus=
sed boolean operators
>>>
>>>   e1 || ...
>> * Does such SmPL code indicate that subsequent expression parts can be =
optional?
>
> Yes.

I am looking for ways to express by the means of the semantic patch langua=
ge
that such a detailed expression should contain at least two operands
which would all be connected with a logical OR.

Regards,
Markus
