Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B81FFEA838
	for <cocci@archiver.kernel.org>; Wed, 25 Mar 2026 09:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=bpz1QqdvFu2B6olYDyt7//UPTcp0bnN0O4JNGS3A+6A=;
  b=pzddM9fmQYAZ/IBwqSnBZFQ5OAHVdkMcfW3GvC1WzQKAK3phl+Rushvf
   g3OPtK0XWxG6hT+3ZLWTmVLYDLqwRYbCjpyxEiDjgBq837uizLT0EIjAi
   cY3SuQxeS4bj0foKljpyZ2zdf4um1EC9h7rCDa8+lYdZanMhvQGvvH5B+
   E=;
X-CSE-ConnectionGUID: rIdhrbSVSNmtowjvObGLSw==
X-CSE-MsgGUID: 4lUy/izcRuqNoclxMwuhOA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,139,1770591600"; 
   d="scan'208";a="269391565"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2026 10:15:34 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id EC3FB81735; Wed, 25 Mar 2026 10:15:33 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 1E19D81735
	for <cocci@sympa.inria.fr>; Wed, 25 Mar 2026 10:15:32 +0100 (CET)
X-CSE-ConnectionGUID: 35THiwpZRsOFCvmZlJYjZw==
X-CSE-MsgGUID: Uu9lAlKMTOaf3alULFm2fg==
IronPort-SDR: 69c3a7b4_+7BxpCOWj8Sm+H+sxqxjxPPy6eCvRToZ8NgQfjGkn8EPJa6
 xgZJFMrKqC+20Dku+AXc1ZmAfv/C+7WX3GTxWWA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FECADTpsNpfk7ASNlagluCP4FlNAQLSYRYj1OCJIQ7h?=
 =?us-ascii?q?zyHVYpPgXwCDwEDAQ1OAQIEAQEDBIUAAo0kAh4HAQQ2BA0BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOEimGTw2CYgGBJIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQJHRAEBAQIBIx0BAREmAQQLCxoCGA4CAlYGFQEBgn6CIwEGE?=
 =?us-ascii?q?AEDDycHrzCBMoEBggwBAQbaZB8sIlmBZwmBHy+FboJmAYl1eicPgVVEgTyCU?=
 =?us-ascii?q?jE+hEODW4JpgiZ6FIpjhxJSeBwDWSwBVRMXCwcFgSNDA4EGIw88BS0dgSMhH?=
 =?us-ascii?q?RcVH1gbBwUSISqBJw+GZXkDLl4aDiICOVxKPgoBUgWCHQJsSQIBC209NwkLG?=
 =?us-ascii?q?wQ9jUozhHOBAAgkxkk0B4I4gWeBZAyfbQYTL5dSDpMLmQapQYICBxmBXDMaJ?=
 =?us-ascii?q?E+CZ08DGQ+SVMh8RTI9AgcCBw0DC4VEAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 w0hoIfv5esRkNiEndjBDAzfYzqi
IronPort-HdrOrdr: A9a23:bLRInaqEQouPApl6+Qp0Dy8aV5r/eYIsimQD101hICG9vPbo9f
 xG785rsSMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaGSS5vyb3ODXKadC/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: =?us-ascii?q?9a23=3AR33mrGvk/1sXgELuReYB78ms6It+L0H9zWjIEXW?=
 =?us-ascii?q?jLkhCVrinTX2h+pF7xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A5WiQCA5prTatwnCZMypcrWy1xoxV/vWqIUQutKk?=
 =?us-ascii?q?hssffPChNHxmY1jq4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,139,1770591600"; 
   d="scan'208";a="269391547"
X-MGA-submission: =?us-ascii?q?MDHpwOqoZPedyTqg0PCu1j0EauG8SIrOeGLCFq?=
 =?us-ascii?q?+HBsl+fK6dOq/YRMHABC7BSRNSyhrwiMqYpIU8qk7BWYnCETejamSEMX?=
 =?us-ascii?q?eCT3etEb3ky+uwke1O6rJCMI7E6S6phFiFWaiZIoW6DB6iz5n695G9lo?=
 =?us-ascii?q?UE0KA5ToZrTL3R8eaDDeDOxQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 10:15:32 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MxYbD-1vKoJu0Dm5-00urGz; Wed, 25
 Mar 2026 10:15:31 +0100
Message-ID: <ff3d9345-e54c-482a-a30b-570f4ed89fb4@web.de>
Date: Wed, 25 Mar 2026 10:15:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <1f5a4f0b-ed5e-4e16-a39d-f1289b7a50aa@web.de>
 <73d88351-640-62a8-189-4e9f8a8a24db@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <73d88351-640-62a8-189-4e9f8a8a24db@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+WzulbFsR9S5LrQYcZfWrRcIqxe/sx3qrMMCsx/roqmyneFeQy4
 IJndSL0CkjR912Ad0sM2PXg94ALuFFGyyZadwZlo7iiemvFUVGk0wduEyxSrlO8Wz4vwBeL
 i3TM+AWYepAsxy56TgXMo1iJZwyvMaDQccRLPOtT1xEuLqOpfmUj67cwnyR3FI9gFk/oLdC
 n5El3EosDvzblBKxn0BAA==
UI-OutboundReport: notjunk:1;M01:P0:yIfWHKs+QWI=;Cscob0AO6YjxdwcKNXG9A4/E0ug
 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
Subject: Re: [cocci] Searching for function calls with known parameters (by
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3451
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/z7m5tXBMiPJ4K2OJ05nlEA>

>> Can function calls be restricted to known parameters accordingly?
>=20
> I still have no idea what you are asking about.

???


>                                                  What is the connection
> between a function call being placed at the beginning of a function and

It is usual that a function call can occur at the beginning of a function =
implementation.
Such a call can occasionally be also repeated before an other call of
the referenced function.


> the number of parameters that that function call requires?

The function signature contains a parameter list.
Would you become interested to determine how many of such parameters
would be passed to a selected function call?

Regards,
Markus
