Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D5EEB8FAD
	for <cocci@archiver.kernel.org>; Wed,  6 Sep 2023 07:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KK4EsowBL7/5bPF2NjKALxzA6tsSB4tcaMhay0tq6IA=;
  b=q8R2rQO6Vgq9Ih+dhpYSe0P+gNKeMRzY+gQmPLXyrsnQelT36LoJGTCY
   mSZ4xo/8f4nvTqhCT4ruUm8TFBV8Kf7+/6xOexOXxAK53hc/EyNAExjlj
   hlaQpLSn0cqf+8VMry2Y0uBZUlrDiDZ3qRrbeWBTV6Pzwm8sXSp/1IwS4
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
X-IronPort-AV: E=Sophos;i="6.02,231,1688421600"; 
   d="scan'208";a="124543458"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Sep 2023 09:21:19 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EE273E0AF1; Wed,  6 Sep 2023 09:21:18 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 82AE7E004E
	for <cocci@sympa.inria.fr>; Wed,  6 Sep 2023 09:21:13 +0200 (CEST)
IronPort-SDR: 64f8286a_QfJPMFsByqgdVbmhyU069SRyd2gzHdi3RwfRizzPxC3AKgL
 ubRDuxz5qmd9TW3wx/f6GnrMOrkod1ffI9OmraA==
X-IPAS-Result: =?us-ascii?q?A0H1BgAEKPhk/w4P49RaHgEBCxIMQIFEC4I3B3JTMAQLR?=
 =?us-ascii?q?4RSjz2Bdi0DhDyHM4dJiG2BVhSBLD4PAQMBDUEBAgQBAQMEgguCdAKGbwIdB?=
 =?us-ascii?q?wEEMgcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAoEGE4VoDYI3K?=
 =?us-ascii?q?QERZIEIAQEBAQEBAQEBAQEBAQEBAQEBFwJHPwEEASMdAQERJgEECwsaAiYCA?=
 =?us-ascii?q?lcGARQBAReCY4IqAQMOIweqDYEygQGCCQEBBq9UHywiVYFfCYEXLYgIAYVKg?=
 =?us-ascii?q?zt6Jw+BVUSBPAyCRzE+hAY+g1uCZ4lRlSsqgQgIX4FqPQINVAsLXYEVgkcCA?=
 =?us-ascii?q?hEnEhMFQnEbAwcDgQIQKwcEMhsHBgkXGBUlBlEELSQJExI+BIFpgVMKgQY/E?=
 =?us-ascii?q?Q4RgkcrNjYZS4JjCRUMNU52ECsEFBiBEwRqHxUeNhESGQ0DCHYdAjI8AwUDB?=
 =?us-ascii?q?DYKFQ0LIQVXA0gGTAsDAhwFAwMEgTYFDx8CEBoGDi0DAxoWBA4DGSsdQAIBC?=
 =?us-ascii?q?209NQkLGwZAAiehUIJPDYIvShqwaZQwNAeCMYFdgV8Mnx8GEy+XFw4GkjSYL?=
 =?us-ascii?q?CCoJYFqATWBWTMaJIM2TwMZD44gDBaECI9IPzU7AgcBCgEBAwmFRgEBhgABA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 m8dm/9u3IBdabu4VlIhdPV5B1c=
IronPort-HdrOrdr: A9a23:d/5LmKo1lHrdiPB5tTBl4HAaV5r/eYIsimQD101hICG9vPbo8v
 xG785rtiMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaWSS5vyb3ODXKadD/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: =?us-ascii?q?9a23=3AjWAPjmowLK9//6TkWZC1TMzmUeM+WSzb13bqH2i?=
 =?us-ascii?q?xVkdqV6CeT2O32poxxg=3D=3D?=
X-Talos-MUID: 9a23:82vTXQjUcyLZpWUAO2Na18Mpbdw0srmzCms3qKojsemiJD0rESiQtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.02,231,1688421600"; 
   d="scan'208";a="124543418"
X-MGA-submission: =?us-ascii?q?MDGdx+9RRgxnVUdZVMfL922n47rWmhzytEHkIu?=
 =?us-ascii?q?qL/uyHD2pSGHsoYsg7+iImC74AHGFr4fiPKf2H9fw+iW9Yl0jWVdvqSG?=
 =?us-ascii?q?MhfUZFNvfNiKcmHeyOLua1U5FVMdh0G4MZwb8iu0Kh52pSLoPbCEad/v?=
 =?us-ascii?q?8vnpQrYqvnPEi0RhbxZZ2cBQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 09:21:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1693984854; x=1694589654; i=markus.elfring@web.de;
 bh=KK4EsowBL7/5bPF2NjKALxzA6tsSB4tcaMhay0tq6IA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=BW6h6ASdKe5+gjgI4Sreb8qBYfKWWf8V7ceHnUrIAMRneIO/EZNPkWAUitKsR5+n5gbbMt5
 xOucv0LWhUk68ptM9yIOa3GOBQH8iedcYZp6WqacwvV4ADpVwzkK9nH7Y7IdpIoOaV9Ic+745
 IUM0Ni8dCcxsjc49JBi0M8FOie+JX25uLVAaUonoMaEHgjpa7jHY5pUB4w7HLdjODjNXA9i+K
 bulX3/g0pNPL9rzvIFUHAL4XgVVcUvVGGLUNs1h8lfEh3uNFNrGo8Rt50GbK6zpJq0Cyvm+g7
 xEhi6ABMgVo16eyQHtX0PIUanvRyotSMZoW9x3eUHym3xqa2N52Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mx0Ix-1phQxZ1Vcp-00y5of; Wed, 06
 Sep 2023 09:20:54 +0200
Message-ID: <2666fc24-a631-4b2b-9055-d30dea379e53@web.de>
Date: Wed, 6 Sep 2023 09:20:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Thomas Adam <thomas@fvwm.org>
References: <7e3fdd0f-e691-4ebd-9de9-4fbdb6ece973@web.de>
 <alpine.DEB.2.22.394.2309022008310.3175@hadrien>
 <205fad47-dbef-4cfe-885b-69a2a0d4b09b@web.de>
 <alpine.DEB.2.22.394.2309022032260.3175@hadrien>
 <1326a929-8a48-4113-981c-df6dc3220474@web.de>
 <alpine.DEB.2.22.394.2309022101230.3175@hadrien>
 <852c86a4-403b-49f5-b307-c47fcf6da68a@web.de>
 <a9c2e240-eb0d-449c-ace2-d723a891500b@web.de>
 <0bd30d22-162c-487e-a4a2-4592cb6f2a24@web.de>
 <d5bb984b-8b43-5aba-7275-4b6fb5e44c63@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d5bb984b-8b43-5aba-7275-4b6fb5e44c63@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:05E7nrVziw2+iExeg/vZmfFz8w24a/k9hjLOJqExa9T3dbol4Gy
 1GBP5ZXuPSPGZqRlcoH4vde9o62H5l0fM8ktsQlDVMherEoUmwuDhNg9eS5mtXP9QwAP7OM
 mTgrYobKgcK6gNouwLNr3PYfxYKhytsDns4ICFuk2TN63qkwxC/GNEl4fXdxYTfZjRrTwet
 aA0ib+IpzxxBnANKgf/EQ==
UI-OutboundReport: notjunk:1;M01:P0:tkLI4c8LYtU=;sZN62XI25jKqobGMB5DwBArUZd2
 lPudDsKrD2A6qwiYqBuVif/itOlXgx17l98jXDu2/GzMvjYgV/XXhPToCZeqjwObsORtzklRf
 tImpDtAIQVNYoSLQPPGjeYJSPbQbkC5UAuQir730Hwq96aiuMkXaYi+VpeyG1OnTKGrXW2uom
 RFVYwbDo25+yVTMAQatYq7lCPpChPJWIL1wWQ3+jEHV9hytpHOC3d3+GGW+SSo7OPLTU1y8JZ
 jYpz7ca5rAU8eZrKw67w+916e/+4Ma5xUhiesBEUxeefBNJ6r5OKlMrpjZQvxPPNotYQqxuHM
 ZLX9i2fLYaaHnb2fiij5O+Knc4FZ9MsT9fhOQj2LQOk56WJ3Tx0G0UFX4QO67XWNtgL120EfQ
 97KVgePhB8TXDctRjdmMlQj8ZK2h41SPTfjUWEKou0Rufq04mxiXgQJOAUYZbW4S7NlsiyXPc
 JC6Yen2A9fQ8foNRAuu8l6p4iaJQM4HCVV7DrCNjISGHcDbuJmWCfpc8NMfyuw8I0hypgBNhs
 rEwWRutQRL/XTXQ46r5vtmLiM2y4vJ7XLj/cByCS0XoxN+vEYBpYYCLpz4xa3/fLLjr6aPrmk
 DkakBy8XRYqpNvhFKwE3cf61AYg2mKn7v7CbhRQHJB4BUdT6taOZ9hbG4mD0j8nUltKj4sseu
 HEu5HoAa31Roh/zP9tGGRUIqwj1jDIgRFn6SrRX6jNh/pDoa/g0A4KT4UShKLkQHZiuwAZLd6
 e9qzFoewM231HVCzzkenGb6WpiFaZ/ak5LijB0wKpDTSiHEjnGgLsKp7ObZQeeoRArL8l35w3
 l1DRFF7U5ExUmLk6EziNatTo6n380iK/ALmb1Eqo0T2A/VvxxcXgnwApCSVtO5AinbfCyvRb8
 MNyrp1n+wJGRZe3SOQ43BN294MjGefbuUw0ZJk80tx+TV8LtnQC9B+Yg9WToOkVnqcHZlWyPe
 dmayvw==
Subject: Re: [cocci] Checking an analysis approach for the avoidance of
 duplicate code
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1240
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-09/2666fc24-a631-4b2b-9055-d30dea379e53%40web.de>

>>> Will any case distinctions be adjusted in the implementation of the Co=
ccinelle software?
>>
>> Would you like to discuss data processing consequences any more for the=
 use case
>> if multiple metavariables are specified with the same type?
>>
>> Are there any special constraints to consider for the safe application
>> of the semantic patch language if a type like =E2=80=9Cstatement=E2=80=
=9D was chosen for some
>> variable names?
>
> None of the above questions make any sense to me,

I hope that such communication difficulties can be resolved better.


> but I did spend some time yesterday looking at the problem,

Thanks for this information.

Which impression did you get from the software situation?


> and I don't have a solution for the moment.

Will any clarifications become more helpful here?

Regards,
Markus
