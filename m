Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E619C6FD18
	for <cocci@archiver.kernel.org>; Sat, 22 Apr 2023 19:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=g9rpZkdUE7hPHvPBknLXJGZvTcrw7bsan4uXeWzDt+4=;
  b=EBIajkljkuMVxu2plVRFV33n2p2DFxyKaV6nopSRn5F9J3ozGE9E9mgK
   umBEYT8lIJHMsczO87gumdOFSuCidLDtDKP6nF9LxS6r29soCGus4jAvT
   cmWW3ICNdBwg4STltH3/1a2hq6E5SJj2k75ucKKaPnLmhmdirKv7eTqBr
   8=;
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
X-IronPort-AV: E=Sophos;i="5.99,219,1677538800"; 
   d="scan'208";a="104307271"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Apr 2023 21:46:26 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 23C25E01D1; Sat, 22 Apr 2023 21:46:26 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D1727E019E
	for <cocci@sympa.inria.fr>; Sat, 22 Apr 2023 21:46:20 +0200 (CEST)
IronPort-SDR: 6444398c_BbNngPw+VUmrlVz1crUlFnTHcjV8dLbBjOT/yZFXTxaRLfK
 /1y1P9Ocx4jiQngwDVufaHxtBxdxPa/kmtBhu0w==
X-IPAS-Result: =?us-ascii?q?A0FLAADDOERkhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYItgUsvBAtGhFOPEIF2MYQwhy6HPohqgVaBQD4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEhHUBCQKFPAIdBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECB?=
 =?us-ascii?q?AUBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQESAkc+AQICASMdAQERJgEPCxoCJgICVwYBDAgBAYJ6gigBAw4jB6sTg?=
 =?us-ascii?q?TKBAYIIAQEGnA0fLCJUgV4JgRQtAY0fgzd6Jw+BVUSBPIJTMT6IH4JnlhiBM?=
 =?us-ascii?q?3SBJ4EygQQCCQIRa4EQCGiBdEACDWQLDnCBRYMXBAIUNA4MFgVCJQQOAxkrH?=
 =?us-ascii?q?UACAQs7Oj01CQsfBkQCH4FsBC9YdwoGASUkmlKBB8NqNAeCK4FWgVkMnw0GE?=
 =?us-ascii?q?y+DagGTHg4GkiUeh12EYosbIKgAgWoJKoFcMxokgzZPAxkPjiAZhAyPSD80P?=
 =?us-ascii?q?QIHCwEBAwmFRgEBhX0BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 IT+eYyIrIxXh6I8/QaMtkO5wC0kgQ4=
IronPort-HdrOrdr: A9a23:KQkW96596wbiE8JPCQPXwBzXdLJyesId70hD6qm+c20xTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkbNDSaNzhHZKjBkWuFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3A0CUKxGgv0IvMenA6MhESxB1qgjJuVCfW7lOJIFe?=
 =?us-ascii?q?EUHtMS5GtGEGV1p5anJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AFC9q5g8+r4dqbtEmvq30foWQf9xlzvn3DkcHq5E?=
 =?us-ascii?q?l4NHeaCBWMQWkgzviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,219,1677538800"; 
   d="scan'208";a="54048669"
X-MGA-submission: =?us-ascii?q?MDFkjv6gWWKH7JmD8YbnWU8MRyAlKExNR3P/Yk?=
 =?us-ascii?q?/I+wsnhh7rfN0xYwIO17nISGTxGa1hWuIoeFeYUiHe0iVhhkm2HrHc1n?=
 =?us-ascii?q?eaLJLHYF0SGg5Dt3GqcCS2/rFsgUmGru6XE8oP9IriX4nQ7eXxkAtyGL?=
 =?us-ascii?q?/HtLly/xDPrcuzbxWSQJAf6g=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 21:46:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1682192779; i=markus.elfring@web.de;
	bh=g9rpZkdUE7hPHvPBknLXJGZvTcrw7bsan4uXeWzDt+4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=pfKZRKtUwgh/y1s5BW+bp1WcvAdkrlphunMMwMBg+itSJsIEkSMdiy93z01hovA7v
	 oj1FOZHafWr/yvByYdYK53rbqm5xUYKay172NwpfBFCmLcYiratbovaefXcO9hnK1a
	 vXUtcA3WJJWXswJiVuOCTIx88oOqXpL/3orR3+vt6l3lT7Q6oUDZIX3FMe39vtRdnI
	 AUPPjoodcw72JZzdWXFyvy78ZVktEGjfUq2CFqCLxh4/E+ziBY29Zuz1gAt6uKGCDJ
	 SgsRObs7koir+Nc652INUReSAC4QeRbEo/dsx8nUAGX6Iwu+N/MgtrWCehCb8cXO8P
	 5Y6OJePy9h+HA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mhnvw-1qU1et39EW-00e09L; Sat, 22
 Apr 2023 21:46:19 +0200
Message-ID: <19fe7f01-f566-5de0-d1af-65020bf8cead@web.de>
Date: Sat, 22 Apr 2023 21:46:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Thierry Martinez <Thierry.Martinez@inria.fr>
References: <037507d2-ab0a-7d93-bf3b-10e51e70fbc6@web.de>
 <alpine.DEB.2.22.394.2304221031370.2766@hadrien>
 <e170b7fd-c7ff-c3cf-db35-0427833a8215@web.de>
 <4285b7fb-00d8-8273-1bc5-bba31b94484a@web.de>
 <alpine.DEB.2.22.394.2304222141280.2766@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2304222141280.2766@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YFKlTMWIy7F3cEtqvHdwN792ffjb7++1hjnsF7o0Vie27GlOUOw
 VwdPNfkwyJhINaym1uMgwWyszAa3zRekLTvqWdAhgqbY9l4OvXbn49/9ahgPwAkVCwFDogA
 zNX73de7HZYJC72nIHl5ExYh9eEl2o20xu412H2JcA4X+0oRycitFjtC7OxnYuHJUHQ76XU
 S8WYrm7c1dLeaJog5Q5Sg==
UI-OutboundReport: notjunk:1;M01:P0:RNEdZId8SQA=;Jgysq204PQy281SCJtbMcGOIKLK
 0pf7ZcaSn2wpYpVy++w6dVZ0ZlPOEue2rFzKVx/yFzGligCnEr0Ia02CHTvVwXFy2iBgZg0R7
 tNWpiE9c8THQIf8D7nHCT72q1bEDGxBT9K++yaQVRPtuLPflU5oloSISWT8dnqZiQqyRKY6kW
 fD1ZkkSSRO+LHlJXol6BhllCzNBb9ae4Cg31oDzLVVbtURdlzntD/MCvjuqIWD7WWor2/d45M
 dnnVozVZFEDnlZ58yaKYB+Y+hvPAtIvb6H+MB/V/Kk/h59h8fxMKFoXiwH3C/k7E+Fzr5CuUv
 eND2EHSYXg1g/vyITog45ydbt2LPnak1zANYlR0yoeBH9kTsRwrHLP6IAslFA0B9H8TkpIVS9
 PdVHNBOhqRKNodiGp0sF1PhvsV7rGOzFoGJ2FG8CRX7IBOWx510Y8X9iMceheLWlxhh0CgdUd
 /hs+sL/E4YlYHK/lZNZtZ8/qL3FKyqPZStqvKubie/lszW8E+rBRBtFmO8hxXFSZ5PaGiRbsx
 TaiqX2DyRlLrwapU5oICqzGcZ1OWuuKbFvR6DdIHmw7YeDjWo5sg+Yw1e9cQ6fViKWp1XT4X2
 UwS7K44aYgydvE3S+UEzqSl5KnXAdzmLFvEJbNELPTJCP1yHjwZsIHy2oQvnSx2eysaH2Rfua
 xIUafuFmb6C8Ws/VkD6eocaIka52EHMBEaf1PNDGeA02kTFU0W8tZvbrpAtbjRm7jjzD/CUD7
 AwRXnFGziCg9M13Kjeo2Qpz+/7ZTlhIZIp+TJm1CqMl5tlh+taVtgEjK6/Zi4zExkKmaAoiVq
 Q6R+3z6a+3OLnZU0/PyLqxyAQOHsnrId10d/OmXTockIdVRYr9xY+U+1LpOUOcZ9Hfctgztu/
 Bs7v+sUwyQi+Dce7WFt6cYLqTMs4lX8e3/JpIILWlOlE6Woeq8EpKLZXz33lHneJDOJ5V17Xq
 SBHwmA==
Subject: Re: [cocci] Checking data processing order for SmPL rule
 evaluations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1123
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/19fe7f01-f566-5de0-d1af-65020bf8cead%40web.de>

>> May I expect that the original control flow order should be preserved?
>
> No.

I find such a feedback surprising.

Will there be a need to be more sure about the desired order
for data processing items?

Regards,
Markus
