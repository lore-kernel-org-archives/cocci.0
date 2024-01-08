Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2260CC3DA6E
	for <cocci@archiver.kernel.org>; Mon,  8 Jan 2024 07:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=M2rryX7A/nzX9G+UnNW+Y+/tv5HvKFKnr6dnsNK7jnQ=;
  b=i+ouUrM4TeRJEoTfviA5BeKaiipSJgobQ54cg9DqBoSLogFf+JeICeyE
   8AgWMHDxZV2Jcym5nXbYwXPulqoinB9fTMFlfLlHf5CYC6o4IxirYwwbT
   xE9kOP1GaTWAJg3ruuqc4N4mgnxr2zBGCJTSLNtWjD78D9JkA/cKFz1Hf
   Y=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,340,1695679200"; 
   d="scan'208";a="145304405"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Jan 2024 08:31:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 06364E004E; Mon,  8 Jan 2024 08:31:23 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7D2D4E004E
	for <cocci@sympa.inria.fr>; Mon,  8 Jan 2024 08:31:21 +0100 (CET)
IronPort-SDR: 659ba4ca_5C0IbWHwyMs5Ms1uH4CZY7nxNsvJLTUC3NedwD3oB/HkwAA
 BvpVQMQPrfUK224Be/taw53ZTkvMmUcebh78ijw==
X-IPAS-Result: =?us-ascii?q?A0EhAAAgpJtl/07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4B3VWMgQLSIRTiB2JGTCEO48BiG+BVoFAPg8BAwENOwYBAgQBA?=
 =?us-ascii?q?QMDAYR1CgKHOgIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECB?=
 =?us-ascii?q?AYBAoEGE4VsDYJcARCBDIEeAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQECR0IBBAEjHQEBESYBBAsLGgImAgJWBgEUAQGCfAGCK?=
 =?us-ascii?q?gEDDiMHDbEggTKBAYIKAQEGr1gfLCJWgWADBoEaLgGIGgGFZ4Q7Jw+BVUSBP?=
 =?us-ascii?q?IJSMT6IHoJohVuPUlJ/HQOBBQRcDxsPHjcREBMNAwhuHQIxPAMFAwQyChwLI?=
 =?us-ascii?q?QVVA0MGSQsDAhoFAwMEgTAFDRoCEBoGDCYDAxJJAhAUAzsDAwYDCjEDMFVCD?=
 =?us-ascii?q?FADaB8yCTwLBAwaAhseDScjAixCAxEFEAIWAyQWBDQRCQsoAywGOAISDAYGC?=
 =?us-ascii?q?V0mBw8JBCUDCAQDKykDI3QRAwQKAxQHCwd3AxkrHUACAQttPTUGAwsbBj0Cl?=
 =?us-ascii?q?FQBgjd7P4FFk3eRBIIZnnI0B4I0gWCBYQyKGJUTBhMvg24BkzcOBpJUmE0gj?=
 =?us-ascii?q?UqafIFjPYFZMxokgzZPAxkPjiCEK4ELjjxANQswAgcLAQEDCYVGAQGDWoFGA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Imw
IronPort-HdrOrdr: A9a23:tSISoa19qZhQTrN+u5JMVwqjBGYkLtp133Aq2lEZdPWaSL39qy
 ncpoV/6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyTMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: =?us-ascii?q?9a23=3A45R+62ueny8wdovEKIxHB+6Y6IsqSGbenHLgD3O?=
 =?us-ascii?q?kFHYuFJqvSg6Rxr1Nxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AWgWX2Ayk8lkF4aQe4N6K7z4qcy6aqI6IFkkVvbE?=
 =?us-ascii?q?vh9GZHhVQIA2cnj/raaZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,340,1695679200"; 
   d="scan'208";a="145304396"
X-MGA-submission: =?us-ascii?q?MDF4IofmkACbmN6xeSmz1E8RPg89e8UxyV3eP7?=
 =?us-ascii?q?Fl+ZobIYJvlYB9YauIMuf3XIkoU1kGh0ZCfZHWgNZV3/xP/peLbImc+v?=
 =?us-ascii?q?7Ty7cq3bryfp/7PUfThhdfzyfYWuWQdxUuWK7jXHFeBJ8Iq3LDs8GPGm?=
 =?us-ascii?q?qi+ktRIe9mkC/44XzMidfG0Q=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 08:31:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704699072; x=1705303872; i=markus.elfring@web.de;
	bh=M2rryX7A/nzX9G+UnNW+Y+/tv5HvKFKnr6dnsNK7jnQ=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
	 In-Reply-To;
	b=Gg8cdW2FTX83zhWVdlkaOhVZZXcXOi8fc4DwEVlHgjDE7h8UazBaOkaX2y7/ckWz
	 RqoNP/PzSzQRjX00VCWqYTAbY6r6UaZzxD3TgUldPzZ1lnjGnX3iJacZ2PEZpNM1p
	 VvE69YSG3Ds0C+ktyPzeZKPfl5e1phprMMAj8C1BWyArMYv6pSKI+pXLGgVrnkW45
	 tG5Gq6ZlffkYlpea+kCF4JWFyK9kyBRUIAahYpWm1oD6YHogoYwCfZ1zxGaFWHGz9
	 kGrZ5lk7XR6qpTK/W+D6n3m5Cb02pQk/lqwLwCFu8uGU1Eg2jXJWFjX0EnhT4dEfX
	 5/Hznu74wadwKoM1lw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1u6d-1rBNH43o9B-011pRZ; Mon, 08
 Jan 2024 08:31:11 +0100
Message-ID: <2e297c1d-ced6-40e7-bc85-f29ac7c4e227@web.de>
Date: Mon, 8 Jan 2024 08:30:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, Jakub Kicinski <kuba@kernel.org>,
 cocci@inria.fr
References: <20240107103536.5719ce30@kernel.org>
 <alpine.DEB.2.22.394.2401071947460.3185@hadrien>
Content-Language: en-GB
Cc: Nicolas Palix <nicolas.palix@imag.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2401071947460.3185@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:89T3MhuqYDohVkDzlZ23xARyeb3mlqBfQYiS5IfEv2N7tH4sxQ8
 T3mid51xJyQTittw88Livja4oPbd+blgpX8hmeR50P53GcR4M3Ksy0wE8Xmck9UvigDkQQC
 cJL0NXvvybGUQFWM8BphknFk2P+91As+11Ni12dY/XvojJO95tT/a/FrH78HltjV0i7bGtQ
 I3h7Hpk7nzncrCQX1GSFw==
UI-OutboundReport: notjunk:1;M01:P0:UbEEH0DtTJk=;u93crCIfFUi4QpvcbL1YULEIkUp
 A39JmU/cjdW/d0W/9+Qik519ZV9iYFa0mzQNBhS6AhSWQ2ewOOmVIk5CYLDB9nU2Bl+W8y+za
 hEBnbayq+TOgOnkkU6lclmYHUKcuLPK7Y+dDlV2rItUGLWihsO9MNTC6dk0K1/8eoDrUkGp3a
 UZRUcwCFL/QnPLagNbODkdDIfmOHTQ/K+6flxOFVHPYw96H/B1q+TP1zCHnRzfNrfUMuHi/JA
 xBBCsz9qMpZnsc4uvHuYBXsoc+xBgL07AAk6iRkahBHCcE3X0GQLH0XlW3recBGhjozcb2AUA
 e8iiVymEb0iIVbbySCZJOOqBRZmmB2/dwWrfwovs096CpxD3dzuGlje7gpe9kzAbOWu5epVXr
 INUfiQKq/ljoIk6a6eDB9SKntT5oWFY8z4ISWwseUzul1xgzFOKKUP9h+lrTopYMHCuu4u+GM
 dfJQl1xbY1EzNjuDGXO82TTx222/91Kkj8XBvN203DHajtNsPyDM5CX5x3hRBd46jQWVJTjbE
 ItKu7f0wE+NY5Gq9Og0GX+AooVzTS/FtFavOX3NyBxEzrzFX7C/cs6aRVv1fGJSpMwR+9Jbuf
 yn3QN/vaHHMOI4OW0g4MTb+QpLFUyqUj16OlJBhA7QsmDLRZ7YqMa+OIDRk8MSuaYzeufG2bl
 hltEx2m7sFtfSRfOkebGc36EcXaa37/ISvgWQSJh56gNq4Wnb+9VlpUnPNH/Ja3s+D3wwCfIS
 dbLYslh3Fho6e9Q8noPQipAGmKjJTizXtqyA+rRb7knThnRNhALn8t1nUF3TLgwL9BYh+0mRr
 5dabSWuiKbScXsW6OPRYJK3x8rylIYfRMy2OV+v8c5wVDafqVIAC4vsvXNNX0+CHcaUGE5wDP
 wQnt4jSDQH51W+b5E1k3mDI51xABU2umOFAJ0X5DcNZ7gLet1mAr7ovCZMh/gYOZKs3OdpjbB
 r4EQXA==
Subject: Re: [cocci] Reconsidering error handling strategy for coccicheck
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1441
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/2e297c1d-ced6-40e7-bc85-f29ac7c4e227%40web.de>

> But the real problem is that Coccinelle was changed at some point to fail
> if anything failed.

See also:
adjust treatment of patching_failed
2022-09-05
https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/5448bb2bd03491ffec356bf7bd6ddcdbf4d36bc9

Regards,
Markus
