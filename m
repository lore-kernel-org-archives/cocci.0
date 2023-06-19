Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00ABDEB64D9
	for <cocci@archiver.kernel.org>; Mon, 19 Jun 2023 09:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=u2yJNZLeU0gMmZ9UJSONA/zDBac/Rviyjjrwl3LwJnU=;
  b=iSNq10uWcS0q5/buCKhp9d1IiAYugB+itQxOrgNMi17LHeLGQJTG2pzv
   jOBL3Yeaij9PY0ro4fxkVpC/jfHQZuEcZnv8J5+xLuA/sAfPLn2ftUGl3
   19IKqy7670BbzjLtM5diAifSQwEa2TmmGZZ8e9jSIa7zloaRW1EMUgWKy
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.00,254,1681164000"; 
   d="scan'208";a="113513374"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Jun 2023 11:11:41 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9E457E03AD; Mon, 19 Jun 2023 11:11:41 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7CB08E03AB
	for <cocci@sympa.inria.fr>; Mon, 19 Jun 2023 11:11:36 +0200 (CEST)
IronPort-SDR: 64901bc7_+A5M5jHZ8Rwv6ushQkF+zs+5Si1LGh+DOC2yDgPdQZe05Bn
 8eqauoZVsivVL0HfnU1uIq6GxTDYl5W4liYwQKQ==
X-IPAS-Result: =?us-ascii?q?A0GfAABYGpBkhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIudQNTMAQLR4RSiB2HEIF2MYQ2jneEaIQEgVaBQD4PAQMBDT0EA?=
 =?us-ascii?q?QIEAQEDBDiBFIMzAoV/Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBA?=
 =?us-ascii?q?QIBAQIEBQECEAEBASMXBw4QJ4VoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQESAg06PwECAgEjHQEBESYBBAsLGgImAgJXBgEMBgIBAYJ6AYInA?=
 =?us-ascii?q?QMOIwcNrUiBMoEBgggBAQacDh8sIlWBXwMGgRUtAY0ugzd6Jw+BVUSBPIMEP?=
 =?us-ascii?q?oJLgXmDW4JnjjCFZQeBWYligShvgR6BInoCCQIRZ4EICF+BcUACDVULCw9Ug?=
 =?us-ascii?q?RxSOoFGAgIRJxMUBU14GwMHA4EFEC8HBC8JFgkGCRgYFyUGUQctJAkTFUEEg?=
 =?us-ascii?q?1gKgQ0/FQ4RglorNj8bUYIAJQQOAxkrHUACAQtwPTUGAwsfBiYBHgIpgVcwW?=
 =?us-ascii?q?HUjJKAOA4MUAoE5gUNQxD41B4IwgVuBXQyKE5UJBhMvlxUOBpIvLoc6kDEgi?=
 =?us-ascii?q?0mBcppdgWM6gVwzGiSDNhMMMAMZD44gGYQOhGGKKAE+PzQCAQE3AgcLAQEDC?=
 =?us-ascii?q?YVGAQGGAAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 R3yN5E+0tVdAn2keArL2sGGvA==
IronPort-HdrOrdr: A9a23:H2Xlx6CTw/233UrlHejXsceALOsnbusQ8zAXPiBKJSC9JPbo6P
 xG+85rsCMc6QxhOk3I9urwSZVoLUmskaKdpLNhW4tKPzOW21dAUrsSk7cKqgeIc0aVm4BgPO
 VbAtFD4bvLfD9HZK3BgDVQfexA/PC3tI6pmKP14V9JVAlhaalv4x0RMHfmLmRGACdHGN4DGJ
 Wa7s5KzgDQAkg/X4CUBmRAZOTNus3TmPvdEGQ7Li9ixgmSyQil8biSKWnh4j4uFx1O3PMY/X
 etqX2F2oyT99eFy1v30m/e6Il3gbLapedrNYirlclQFy7lgAqyIKRtMofyzAwdkaWR0xIRqf
 HpiT8dBegb0QKlQkiF5STXnzPY+BIVwVnY5Taj8AneiP28ewl/MfNoobhlWib0gnBQz+1B7A
 ==
X-Talos-CUID: 9a23:zyOe3myjZo8u8OD24bqqBgUZE+0fX3aM5U2IIhC8D1RZUp2KYlC5rfY=
X-Talos-MUID: =?us-ascii?q?9a23=3Aq3j7wAxBSOHowN0hqFd8fgUs87uaqIC2KE08rLc?=
 =?us-ascii?q?kgPOnBSlSJzO6pQ6TUrZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,254,1681164000"; 
   d="scan'208";a="113513290"
X-MGA-submission: =?us-ascii?q?MDEdW1P6Vo737YWiCMO67oWXVDye5Tfv6z7zno?=
 =?us-ascii?q?bMWU+uBZGvbA4q/9g1+5nDHekPjP0zygoHAqE324ecOyFRYHl9RNY89x?=
 =?us-ascii?q?5ezKVsk1EfiJ9Ltfu9iXRyl7ozepqUftWTOKICwxbzRNjf2xXL+F9iZz?=
 =?us-ascii?q?j/TRdfFmUCo8neDNjG7Vr0Rg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 11:11:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687165894; x=1687770694; i=markus.elfring@web.de;
 bh=u2yJNZLeU0gMmZ9UJSONA/zDBac/Rviyjjrwl3LwJnU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=AWEFukCC5qhPLNbqWkDAJgb6Hu5Kun337JPTVhrQg/JfzIlck6i6RDry5OKbc5Xeydq8eMq
 pfTQz6HNxBM+fMbEeAHyKHqDI1vXJPmWmFV3m7jBTMksaArFlsfnHBpA2pmlLrCDYB330w9Hh
 crTlmrf5GQhhLQMA6wcXR/rAhviEOl51ydav9nRcpSRuwEx+WSpL1WkjqTIhIjqFxz8mXxjH6
 sL5YcHEAlWrr6V1qtCjVkklQlgC3Ka21x6HZThWxvp4NOYwKmJxn9lrwrdBQwtB+agQPGvBQ6
 ch6E7B5qt0iDLDazoSv0RfXJ5+R/0njoQ4hO6kCl3+tl86GosGRQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4bUg-1qCpLU32Gs-001vtf; Mon, 19
 Jun 2023 11:11:34 +0200
Message-ID: <6e1071ec-f19a-454c-215a-b5193984bc6b@web.de>
Date: Mon, 19 Jun 2023 11:11:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-GB
To: Dan Carpenter <dan.carpenter@linaro.org>, Fei Shao <fshao@chromium.org>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-clk@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <20230617160901.1.I2b151cdf7a72d9e3ecc7ab2ff38409ebe6d65d6b@changeid>
 <71168ceb-8273-4067-d0e0-c6c219d4618e@web.de>
 <CAC=S1ngN=TFQa0Y4FoSCOTUs8HRi4NEP1OwY8WccUEUMG_UDeQ@mail.gmail.com>
 <8366a35f-bc2c-4aee-b2bb-5fc9b2a7072b@kadam.mountain>
 <ea5c0b0b-7aa5-d4eb-def9-fa279d69cd44@web.de>
 <56998d04-7f09-4982-b0f1-20ef917aa524@kadam.mountain>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <56998d04-7f09-4982-b0f1-20ef917aa524@kadam.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YjdDsOxkAt4bdrDo+zfzTTW+4V6GQF/kokCslO92BUvY1ysq5vk
 rW14G44go9ZN3D9EiHCJbE9rr1b+9weXXktw5erZqyv0N8w0Tt6GEWdwdmEIbSnUu16iieL
 BW0WwTNq2q06ZX7YzlrzUNcCswC6BF/DYPdxNyy9B8gI+E8YzTZHHTKaCvtppvDz7I6Jhn7
 A7JEMtd8cooujXPgq+mUg==
UI-OutboundReport: notjunk:1;M01:P0:Tb1q6djtE4g=;shERtqE8WBB9bXtL+5clISSEH8V
 yh+u73VYXwcETc4M4vja5V5iAW3ncqWgZ6H7HFU1NErH0fcxsM6YG/7+3r1ObwiZVqc2/tkm2
 Quu30PE41b+/axxlQURiXBC0t5wxCHD9wZ5FN5q1rjGiqUi7LNvrnHLqT1T48Ctvl7ZO7jqTx
 LkIh/KdDTRSzQf8xTPpudPgKLQwFvX9533c24SCCcEW/fTAgzfTZ5mJn19ro2wWdZBD1iSZkS
 YCORoz14GXFMbRk4Sx73yvUHcZDQR03+h5QIHH9gzJX24W38qiiVfbLbGF9z/o5xZJPcQloqG
 Yi98rvN6sw6prTnRfPD0s5ulDKyuFGESA8k0tlyN3RAc5qZ2kdBSkfMdkOJ5OVIsQGgMA4WS2
 fJXa/UR0O5gd0fMJRYEFHtXU6TCfC2ggzbyAg0u+X1TfxLjZHphopz0UHkGmvt+7WxGnIaHwA
 oFTs14PZBLV3gtYOl9T271dwlizumJ8iP2j41I3m+4Y5WCw689yNl5rCMeimsg6dD+TuulyQG
 FPfzw7ea+/1pCx1GFYOJKnK9jiYxL65C+ocdf7qctkOEswjwKCifVKYcmBIzujL/nj520JSua
 YMLNaHAoHu+zaXfuNY2hFMUgo1QVrHpZwBJw8Wj54/wgxhNB3aAgCqOAMc9OuiBZ3COCwih7i
 S4qZbKfryVXPFLcTmksm05Qw+LuMGVugkm9SF7uFZcRrdPe0qglPJgvglS9cWSx+twXQI2qvF
 poVY7YyNrQdxFT0D5i8U5WPyGIFwIMhkwuun+6pmvK34wHtqvtq0yZlnsTFj0DyfMNhPLINb+
 GZAny9GnrxkGgChr4p1egJAGOvln/dsjFFxDVy9Hu2iRC5BM92sClujBHGdsOhgPhokdrFIUb
 YKvfxR+2NxwV2zBPJ3TbivMcPn5bxVLzBhLBU1RTKPNmZyUCWOOy8QcL/xVOo8PY/Fsu/V9oN
 j/oe0w==
Subject: Re: [cocci] clk: Fix memory leak in devm_clk_notifier_register()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1193
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/6e1071ec-f19a-454c-215a-b5193984bc6b%40web.de>

>> I offered various hints for desirable change possibilities.
>> The change acceptance might evolve in more constructive ways, doesn't i=
t?
>
> No, I'm sorry, it's not constructive at all.

I find it interesting how views are varying also according patch review ap=
proaches.


> You're just creating noise when we should be looking at if the patch is =
correct

How much do change descriptions matter for the desired correctness check?

Another example for a subsequent version:
[PATCH v2] clk: Fix memory leak in devm_clk_notifier_register()
https://lore.kernel.org/linux-clk/20230619112253.v2.1.I13f060c10549ef18160=
3e921291bdea95f83033c@changeid/
https://lkml.org/lkml/2023/6/18/326


> and how we can improve our QC infrastructure to prevent bugs like this i=
n the future.

Would you like to add any more ideas for this area?

Regards,
Markus
