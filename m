Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D609CD3427
	for <cocci@archiver.kernel.org>; Sun, 10 May 2026 13:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=O98n8LfI2Eh0HMKXlAaHp3LGEQ4i4aplPy3eHzaM39M=;
  b=u0KrRxiW+xgQakM9hX1MUcYxMT/GcoHR8ScBOK4u2G7OAZbpJK758JHV
   mIMhPRb8zA5KTbuma6QYLaKBE26mfmtrxUgY+irsv3ejXlrxc2jPmwuvD
   3/oQWNBA+6snSOitDbrX7U9WIwoAFmVpxV70zIcPNiN0qQHF/RB1rBef1
   k=;
X-CSE-ConnectionGUID: WOzTmxM6RAWl7ZDNDk9MfQ==
X-CSE-MsgGUID: 0BYFjUJuTjmG6U29mEx94w==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,227,1770591600"; 
   d="scan'208";a="276030261"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 May 2026 15:05:45 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 145BE8143F; Sun, 10 May 2026 15:05:45 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 8C4148143F
	for <cocci@sympa.inria.fr>; Sun, 10 May 2026 15:05:40 +0200 (CEST)
X-CSE-ConnectionGUID: ycaKAu+/Ra26+Q5/8WKVqg==
X-CSE-MsgGUID: EAFKp/3iS3GNdH41sgtbqQ==
IronPort-SDR: 6a0082a4_WhUPu0LUvTHXqfyJr86QNxY5PHppRNB/Y1f+drvOD2JwS1b
 dCIsdtb8oIZmW1VHbQiBOcrCvnnziV2V9JwOfeQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0G4AwAlfgBqg07ASNlagluCP4FmNAQLSYRYj1OCJIQ7h?=
 =?us-ascii?q?zyHVYxLAg8BAwENTgECBAEBAQIEhHUKAo0zAh4HAQQ1BQ0BAgQDAgMBAQEBA?=
 =?us-ascii?q?QEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEBOgcOO4ZPDYJiAYEkgSYBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBESYBBAsLGgIYDgICVgYVAQGCfoIjA?=
 =?us-ascii?q?QYQAQMPJwe1DYEygQGCDAEBBtpmHywiWoFnCYEfL4VxgmcBiXd6Jw+BVUSBP?=
 =?us-ascii?q?AuCRzE+iB6CaYImgQ6FL4lTUngcA1ksAVUTFwsHBYEjQwOBBiNLBS0dgSMhH?=
 =?us-ascii?q?RcVH1gbBwUSISpuS2QsXBoDAw0hNVl1CgFJBYF0AoIeGV8jLwNOgQUCAQttP?=
 =?us-ascii?q?TcJCxsEPYs8HQ+CKQaEA6RtoUU0B4I4gWeBZAyfbQYTL4NxAZNgDpMLHphoq?=
 =?us-ascii?q?UGCACKBXDMaJIM2UAMZD446hBzDYUUyPQIHAgcNAwuFRAEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 3PgIJv9KpkPcJL20QpuZwsi9Lk=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:LAvCm6+vV5OpSmM29Jluk+DLI+orL9Y04lQ7vn2ZKCYlEPBw8v
 rEoB11726RtN98YhAdcLO7Scq9qA3nhPtICOAqVN/JMTUO3lHJEGgI1+TfKlPbdxEWjtQy6Z
 td
X-Talos-CUID: 9a23:F6i+CGHayz4eU2kyqmJ2/0c3M91mNUfUlimTGhL/WVlKdqSaHAo=
X-Talos-MUID: 9a23:cyH+BQhTMzs2igjIGmwttcMpGe5GwLzpU0E2yrogt+nYbDd/Jz2EtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,227,1770591600"; 
   d="scan'208";a="276030248"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDE8t1J59/XgYXniwGoK14hb0C2cNwrQCqk9Xa?=
 =?us-ascii?q?sxiEg9hPHPef/9UFVJJQwDHQLKW4dPSjyoOvWur3TsvUTz1YuQR1EHWd?=
 =?us-ascii?q?6zzQz85K3u9toGWKGycqG12qHfALz7zU6laHMMAlTv4vL7QA8vis/0KX?=
 =?us-ascii?q?e/dnkvQX5pUqIdl2sNavsQ5Q=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 15:05:40 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N45xz-1xLtlS3ZxZ-00s8J9; Sun, 10
 May 2026 15:05:39 +0200
Message-ID: <6d99cc03-2307-4eed-935c-3a737b7c947a@web.de>
Date: Sun, 10 May 2026 15:05:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <ffd64e55-beb3-4030-8b7d-763ba6f8f563@web.de>
 <1f97d99-bf20-44f9-8781-26162f5824b@inria.fr>
 <ef0539dd-b1d5-49b0-9c20-74c5e5d977b1@web.de>
 <e5a66d9c-5462-2f54-6abf-d2ec2cfd1d9@inria.fr>
 <26e1d3aa-13f1-4e55-88d1-68b9d027ded0@web.de>
 <806afe75-8e1-17d8-dc3e-c2e33f4ab64@inria.fr>
 <049a046d-3952-4192-9b9f-a7c2162c6ea9@web.de>
 <2437833c-e02c-736c-e96f-7ded7eb263c1@inria.fr>
 <569a2fa4-d655-4c26-836d-a86aedf4e0b9@web.de>
 <6614c14-3844-9774-24c3-e891ad57e9a@inria.fr>
 <f3e6a976-2ab6-428c-ac42-ccd2281774aa@web.de>
 <44e0e8aa-f4f5-be2c-3956-a15d1989eec6@inria.fr>
 <80eb8b28-fe71-4d21-b154-646d425fea46@web.de>
 <cdebe356-d9a9-36d6-aec-94673979520@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <cdebe356-d9a9-36d6-aec-94673979520@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ahImESax6t4BjuVDX0L7nNPdShzqGXLGZnkO/c2X9ZbJzH/jelC
 Z4PZW0HbAShurfe9NzosSHiT8pnGtLyjzVm2FX8UmNmIscHyCTXZoYysd/RDpXpU9OIdv+G
 46Rn9rZVMjoKsG10ZgeHdH7oMc4/RO47u1wHPNapxzoUP07PYs0LSu08BQ2jBF8JAf4Tu0V
 NihRUk3CKj00dfLGI7oDA==
UI-OutboundReport: notjunk:1;M01:P0:sxIAlzomHNo=;hKKcgfDlDeHr1w5opjmvNCv/Nsg
 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
 JY4w9roUhflE+5svQVoijUKQ==
Subject: Re: [cocci] Merging results from parallel data processing?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3499
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/_oQQdSQpIyMYDc_7CUW-8Q>

>> Will development views evolve further accordingly?
> No/.  I see no reason for the default behavior to change.

Will further development concerns become more interesting also for this use case?


>                                                            It works fine,

Partly, yes.


> and Coccinelle has no more information about what the user wants.

Do you find the presented clarification approach improvable?

Regards,
Markus
