Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1929AC02196
	for <cocci@archiver.kernel.org>; Fri,  7 Feb 2025 08:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=8ggcmYh4uTT9NNa2LmkVHU+PVfOqyjzQhrebmZxIgyU=;
  b=oWRFyrhc8jP8xTDbVjc+ZoE/RCljCZv7I5S43OGwmoPd9A7ODFTvmZuz
   RLvz4ox2TEsjgzYdAfme26KgjWCTXg4bDr5YQj3SVppnVjGkOP4ixjwjk
   eGjplnYnm2/avRLNnEyNxyVnfrqBhDnBD0njpbBT+tDSeaml6Y6K9Z23T
   c=;
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
X-IronPort-AV: E=Sophos;i="6.13,266,1732575600"; 
   d="scan'208";a="207099453"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Feb 2025 09:15:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 57847E0D20; Fri,  7 Feb 2025 09:15:55 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B475BE0260
	for <cocci@sympa.inria.fr>; Fri,  7 Feb 2025 09:15:54 +0100 (CET)
IronPort-SDR: 67a5c13a_ZIch6D0ZNVHkB2LTRkqCT96NyFiqG7fAOhFvuoOqjldOlX4
 vXveMqFy44eWlKEiZjjdS2KSzf3yO2hRZtEjx9A==
X-IPAS-Result: =?us-ascii?q?A0H+BACHwKVngAwR49RaHQEBAQEJARIBBQUBQIFCBQELA?=
 =?us-ascii?q?YJDYhtaMwQLSASEUo9PgXQwhDuPDoh1g1QPAQMBDTsGAQIEAQEDAwGCDIJ0A?=
 =?us-ascii?q?osCAh4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBO?=
 =?us-ascii?q?wcOCjGFew2CYgGBJIEmAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQECDTpEAQEBAgEjHQEBESYBBAsLGgImAgJWBgESAgEBgn4Bg?=
 =?us-ascii?q?i8BAw4jBw0GsQGBMoEBggwBAQaBRgIMAkPYQx8sIleBZQMGgRouAYVrgmMBh?=
 =?us-ascii?q?iaDQnonD4FVRIE8gwM+gmEDAYFeg1uCaYIzhEhnmmCIXVJ7HANZLAFVExcLB?=
 =?us-ascii?q?wWBKUgDKjYxI4EjBTVBOoINaUk6Ag0CNYIeJFiCK2oEBYEtgjmEQ4RNhViCE?=
 =?us-ascii?q?oFgAwMWEAGCMXB4HINaLx1AAgELbT03CQsbBj2eVT2EEYE/AoIfxjg0B4I4g?=
 =?us-ascii?q?WaBYwyKKZUzBhMvl0MOBpJ7LJhQIotpgXmbKoF9JIFcMxokgzZPAxkPjiGDe?=
 =?us-ascii?q?jOBC4NVwXBCNQIBATgCBwEKAQEDCYVGAQGKX4FLAQE?=
IronPort-PHdr: A9a23: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
 RcFk+uQEA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ibEGua6LWMSLd28IYQPXwBzXdLJyesId70hD6qm+c202TiXqrb
 HLoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3AlhP9zWsJHn6fYQQL6hn/dkqx6IsPSFmHy23tPHS?=
 =?us-ascii?q?2SltrSoTSUAaW3JNrxp8=3D?=
X-Talos-MUID: 9a23:1/JzWwv7+shwdT+iyM2ngB5jD8xo2I6UAVkwkpQDoMuJDCV0EmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,266,1732575600"; 
   d="scan'208";a="207099435"
X-MGA-submission: =?us-ascii?q?MDGO/oWZ5VYIcPY/l/SaF97ED1T2ZqPYg7iy1t?=
 =?us-ascii?q?0zGLjlTrlutnXxf8Rb3yn4Vmorq3AxnVXnTI7nKQrUM6Q4jvU/qKUN4i?=
 =?us-ascii?q?AJUHQiybCQeu7qz8PHsE/aWCOz706oC31bW1oABWZYIBx1lC3lrdxHtA?=
 =?us-ascii?q?oLSQNqVrIlSDKk/zAyf/j8Qg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 09:15:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738916153; x=1739520953; i=markus.elfring@web.de;
	bh=8ggcmYh4uTT9NNa2LmkVHU+PVfOqyjzQhrebmZxIgyU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gOn0EVG86pDRdKjKTMivIWy303MFlYDG1R9dDdIcSFInRey7vrAsQy7PHSn5a3D0
	 GH4M6h4HegZYhFY40uzJCi/2G//AhjVODluYS3KVJV7C0HqcZq5hpCChoV3G4HVRv
	 i34/DuITIu/pyRTFNpWZmLfc8B+wfQnsNkEO2L4DaV8Ok0AOSPQl0SsFYmxCW+RO9
	 7REWcVLyMIdXcUzC02TosSx1IgjSyiQF5RYJesS4GwPs7qNpFZ58rnZHTY/M8iyz6
	 HDlZZtkJ/bYBPXZnCYmNZ8lMWa0E4Vf/DyMnV49pqcAsoyuJHp29Ir72e/w9uJnXE
	 DzY2Tjht+GCj+p/JAw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.29]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mq184-1t3BPP0xBS-00dgjC; Fri, 07
 Feb 2025 09:15:53 +0100
Message-ID: <f67b5b79-09fe-433b-bd2a-6f50a00e4763@web.de>
Date: Fri, 7 Feb 2025 09:15:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Johannes Berg <johannes@sipsolutions.net>
References: <381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>
 <061f1b6b50d305671c02742382a3df0ff95f9c6b.camel@sipsolutions.net>
 <ca7c1a14-522a-9c2c-4f85-2fda289b83e8@inria.fr>
 <9bfe9c42-ef0c-44ae-a71b-26207e9083ad@web.de>
 <be231f53-bc7e-6aae-497d-ec83859957b@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <be231f53-bc7e-6aae-497d-ec83859957b@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nucq+sAM3KDqEPNfNAhkHNUo0V0ooC7Pdd7mjvgQ+7dw2dTc9pB
 TC5cARic8OIHpY9u4qo1ejcM0KXIr9uiOQMlpe2TEsZGkbOkyaNHjrMcOitZjlagalJ36RN
 BGvDYg7s8+bd2uik0iMWW1ZymMmHKuIBIP7XDmWSMh/oUhK2CM/NR1XBZeGX33vxaQHlBrw
 oOQ6w8jFFQHYb2O7g/SoA==
UI-OutboundReport: notjunk:1;M01:P0:bZGy/Rs55/I=;7A4rNM2b46Ux9ftPi7GWVto5laq
 ypJs6ze7YqOWt+5bzMCpS4PUJ9PmmTDgj33dBfMZE5hJ87Kw0tMvxeY2UkgYpajOLdybq6/ji
 /1/Rm5WwlHHuMVJ6+iSkR8N36XT/lOS5eYeZqN2BGJ1D2VOfD//sgx4FdoZ+6AyoBaZac2RSN
 Gc4KCFYg3GrF6tXhy8m0eYyOQ5AZkwmkMdVQ0C0B5/kdI2XCgbSkikPYjJfdzLY2CaTe4LN1o
 u0miSMuVLVP51Omf4Fgz5laINf3H8iAR03RY6XqRUYLfaVinxsS/JD2owTDVEoBcXWmk4ihin
 xg7NLYEsmTsTZNT7kqpyQ0RZGvwRB4Z67Ly48b+ctsdmZTR321ty8ChDHwXSKwYVNhVgEapJO
 1I8kQRXJwGgAOOWCtGH9QHWG3KnN3gQ9Q/ppW+NbdZp5QN2BiUgimZH2uFAgz8OCFEsVQ0bh8
 R2IWjEgMzbAYzXMsL5t22ULp6+XudClcZLR23PO+V1sKmMhIcO5na9x6A8XdkYYp9Iw6qtJZs
 JZ8OLlvAS94Bs2DsEQxQeljxz2rB4urDWQ4O8t3LmOY6PjYDRJRwT0pFMS26aLC8ksRF1RcwG
 4lYdUFJJz/u2i84uLJXximMI+AA9Zo6p7sM1I7aAfBQ9WaahAReDeR1FhkvwqNtYuJmYEmYou
 uKXG6TlGJ1vTU+TJxnj18+z50fz0sgLDVREX991JEnrp2YLlx8CMqyKUiREUKEUqJVNazbgHr
 Lb03mGvsNIlx18DWSFBxwH/e8YwDkcH+NtemmndxHuGKrqfePvErKjfV5/KMjk34VR+1Y61jR
 DB9TMBLKcZtF9dVfyBoBPod1DUCWNQNJfqAJcchZotzMSyQoxWVY8DRvSERgpe19uVPdCmFZS
 BdXGM+l4ZJFD41ZLmvsJ0HHe1QP+kggvRcwC23va64wYnBUdW7xtWl9NnVg/R+/me2TK/rQG3
 7qx2E0yWNb3ZcFzXR6TMa70EfWaG+m0Fw3rNgfoB42+uKIIYWazwj7Zga0ggEd4JyRprB0z92
 AhB0IpNTGjebsGyVihbRZ1GU+jj0YNDcN19AoGOBBuTCipXxdsJssiri78ZMBWh5KwEC1pFnl
 W8zlGXuJKB3DNdpJnjU0FERdIXxb3aGznOYLA5FpLtVqgECmWSxsbH2iQRkuYwq1ML2mvZIxc
 fFDTQZnQuRpGAo4jT5Tk8qtnDQHkBFzQbBvSw4DrMQcyVhvGIyNMeoD22PyIe28T6IXhuyb4X
 Mk+wBPmuTBXqoRFSifaqIFCLJrQeMCGWx0bpGMyEJWQja3upwW2xptMqvZC5Wsu7munimRPjb
 F/BYCcmuY/yHv9P+c1kFH0MeOekwK1jB/xMV5IcmMTZs5P2/kMZFeQPpvk+coUxTdoshTpsc9
 177ezEerfHTLNR3sItyV4kwPt3S5zFszp9Sp/I5fUNxUt+/X5ZHvxyvONvYAjfLr71dkdlVNt
 t4RlK/w==
Subject: Re: [cocci] Checking software run time characteristics
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2368
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/f67b5b79-09fe-433b-bd2a-6f50a00e4763%40web.de>

>> Would you like to clarify measurement data (like the following) any fur=
ther?
>
> It seems that the rule starting on line 4 is very slow?

The run time characteristics are obviously questionable.


> Maybe that is the only rule in the semantic patch

Yes.

Johannes Berg showed this test case yesterday.
https://lore.kernel.org/cocci/9063a6e6c83f9169456bc009cc35426889cc46e1.cam=
el@sipsolutions.net/
https://sympa.inria.fr/sympa/arc/cocci/2025-02/msg00029.html


> and the information is not very helpful.
Will the measurement data granularity be increased anyhow for the affected=
 function call hierarchy?

Why does the software run time =E2=80=9Cexplode=E2=80=9D (according to the=
 handling of two simple for loops
within if branches) so far?
https://elixir.bootlin.com/linux/v6.13.1/source/net/mac80211/ieee80211_i.h=
#L1210-L1240

Can our discussion trigger any further software improvements?

Regards,
Markus
