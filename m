Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CFEC433FE
	for <cocci@archiver.kernel.org>; Fri,  4 Nov 2022 08:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9seidrdYTz04RPVGdWP4nyPzWlb4oH9psxQUsg5al1g=;
  b=jlx9qhTLv71zFIKo8Ry70MjVlUb0jqqRXBJROwfQdvMv4KbSZtgPiWux
   iWMP5YhO4Obyx765JfqEHrqTqs8oCvj5V+NOhT5iTGwK6Gsu5Kz6/0deB
   SuCvWU1JfgVsfpXOTxS5QbpywvlmuJKhAxQolTPhf7TNwikscdp2Eb+EB
   o=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,136,1665439200"; 
   d="scan'208";a="75018301"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Nov 2022 09:30:52 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 86168E019F; Fri,  4 Nov 2022 09:30:52 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5DB3CE0157
	for <cocci@sympa.inria.fr>; Fri,  4 Nov 2022 09:30:50 +0100 (CET)
IronPort-SDR: 6364cda4_ZEQhig07l9cfIzTUSPdi4HigC4RZgvc5FSpLjR+23hd6XQR
 REU9ad2DJgw+ijur6TXiD90xB7P2Wv77Q9O3Rbw==
X-IPAS-Result: =?us-ascii?q?A0AHBQBBzWRjhw4P49RagQmDfIEFUy4EC0WETpBshFqHH?=
 =?us-ascii?q?YctjDMPAQMBDUEBAgQBAYUFAoR4Ah0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgQEARMBAQEZCRcHDhAFIoVoDYI1KQGDZAMDIx0BAREmAQ8LG?=
 =?us-ascii?q?gImAgJXBg0IAQGCeYJuAQMwB6tHgTKBAYIIAQEGmBIfLCJTgV4JgRQskAR6J?=
 =?us-ascii?q?xCBVUSBPIMDPoREg1eCZ48Bh3MmBA4DGSsdQAIBCzsyDUwbMScOCR8cCgQXD?=
 =?us-ascii?q?QUGEgMgbgUKNw8oL2crHBsHgQwqKBUDBAQDAgYTAyACDSkxFAQpEw0rByNxC?=
 =?us-ascii?q?QIDImUFAwMEKCwDCSEfBxYRJDwHVzoBBAMCECI6BgMJAwIiWHMCLxEVBQMNF?=
 =?us-ascii?q?yUIBU0ECDoCBQZSEgIKEQMSDwYmRw5KPjkWBidEATQPDhQDYIFwBjWdQ8NuN?=
 =?us-ascii?q?AeCHoFMgUwMnmMGEy6DZZMIDgaSFJcwp3eBeSOBWzMaJIM2TwMZD445hAyKL?=
 =?us-ascii?q?EA0OwIHAQoBAQMJhUcBAYR1AQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 RzyNJE90thdD6yFndou28E=
IronPort-HdrOrdr: A9a23:Q32AWKwZcHMU3ikHAMGbKrPw+L1zdoMgy1knxilNoNJuA66lfr
 OV7ZAmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebjN5DNB7foSjjPIcOoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,136,1665439200"; 
   d="scan'208";a="37855988"
X-MGA-submission: =?us-ascii?q?MDGPRyMWvWPolvZHzbnbB0/n13pXshLQ3P8CYJ?=
 =?us-ascii?q?epthglNSiopEazRbchWk+I23CE1RQKCrBNtf+6vOWGRcahY8AUhIovh4?=
 =?us-ascii?q?aZEAfq1z5inxuRwMYQGcX3dwIFWenSt7EC7nr5plMpQv4l8HZd5h7dUZ?=
 =?us-ascii?q?FlD2bMZ/7SfRzrZglmXGdttA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 09:30:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1667550627; bh=0zbsKjQzT+8D0n1wkawZ4MtxO2OwSNgd8URAPO7cYO0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MBzNWV1vjDVxNtXjUHun7MjvEG2hmT3lGoQZf0lXgHCeFVzupEmy4rSGFwXtOuEQZ
	 gsxHVh8Sc+U9CoGiuTCl8N4UPc/yyZEpbW41A9LIadlgE8ifj4mgzMYK6LjLLvcTP/
	 ORRZLGN8ECotkV22IU3g/CepahLFF9O+2ARQAbU8etOKAzxu/hLvfe6abL3NlYY3yr
	 cITobVqB7PpKkj5t3Qd21nA6eg1oU7YahByIHfboiNh1m1u5vZpjj8fARNy4l1ACyv
	 bX93QW4q6R7RgZHzxCX92pKgTkJSgKoKCfBN3BRKDKotAiRZIJhgtOaKSvHaMGWQRx
	 3bd2NNpes9G/A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2jaS-1p0aNT0QZA-0139Xk; Fri, 04
 Nov 2022 09:30:27 +0100
Message-ID: <3a2a50ba-8c30-43c5-354c-7b194eea8df0@web.de>
Date: Fri, 4 Nov 2022 09:30:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To: Sebastiano Miano <mianosebastiano@gmail.com>
Cc: cocci@inria.fr
References: <CAMENy5qK-KB1_D-zgh=UyLarKVaup-J0yRdZwTL-fkyn_gQhJg@mail.gmail.com>
 <1b150ca0-402b-9b1a-7a47-da1a118d61d7@web.de>
 <CAMENy5otzNE3wfm8=PJxP_8T4t_AydhUWs_dmWGmvzrrBeQa7w@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAMENy5otzNE3wfm8=PJxP_8T4t_AydhUWs_dmWGmvzrrBeQa7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JsFMqEGLChu95QDHlnGLUSmnqTb4mx7OFQ62d8yB/T+hKn/EqR3
 tcN4Mw8SA/l8SqSA3vEDMPaSN8YZqXMsN1cANV4eA2bi79TGXam9eVS7xQFbY4UUMC0p6hg
 lubSz0FWOPaaIgAz3rtCjmt+2krED5hNxxZuFQtqDWVfiz3+fR8JWUO25UzK6W/aHTSyBn3
 SjHYjJDeKVOoPCmqFKR8A==
UI-OutboundReport: notjunk:1;M01:P0:9jBOHMVpBgY=;BwAJtsb7ZojUf6H9wHOBPil6xqA
 5ji7d9VIjfrPj0n//HSHj8hKhpssOGnVTorhtSOGsVYQaXCtBlObbL7FkZi2rW8LELoQjCgLx
 oDZc7nvyX3pgxuEUJLj4WQ1/cYWjmXSqe2JDnq2PbSisuQvQEyo2e98v3INaaLgkkZKZkyaF9
 l2IOuBzvTlWMsZQMNoUbXAp6k9EkOz0d8JF9qH7REYdFMfGu+qYA3VwtXF5D4wtqrUeYSWtT0
 DRnN8TkQWbiTOBQ4xvBPNRSf7YKQ0G1rHNTsZo9UZVCnhPBLiq6YhYU4yDkfhfBraKuU7bzXg
 N+ZjmNo7s7+d2WmRPTjWcEvntcNVWbuMAo7nCE+AAIKvE5q6UYUZT8iXYHF+u8wSXch+v1McE
 8FA2VFHtgRHfLkf8bk4OJvhakW5zMWB7+r5jnkXJ1Lha2AMspB9n5fpme7xxBAjmsRqUCMmju
 o6OYzpuWZbC4Azpo077we00S5VFH6cFG2+hxL/5WEb2YFghexplVJLXQKAv2KZS59x2dtziK5
 QbUGYv6EXpxoWLbSayzKTxitWVuPFPklfefspbPHiS4dcnwtRkgiB52+T0uQjhZEyFNv1YSoK
 rofwwoKlEwUCK50oXmDO0EV9q9vx4LH3GgDi260+GxjZm2SHip98ErXBkxagsxhShYHPCCvEL
 MZcLVJlNwPUSfX3/Sx3Srm6+OS7lVnHIsHvIud1UPgqAQ9BgcrCn3h1g6KZrH5PaFtysM+4nO
 jpV8vJ0wsnCngXdxFokG4xpzJb5L2Atr55NZEN6fqsCPPwuILdt7w2O3eVEmlaau5Z4cntEFZ
 dMp10ZsCoVGP8rhTOoxmmoPh0ydEe2YtHa7O+8j014D8GsZ5f8T9k2iIbll5RMQJdhvUnthme
 /M94zREgVl5EhYxlMm9OM2kwqwliQ7TgunTXK8ZbctS/80dV4/wOz8P92rzU7MMkaKHzov+DZ
 nsSvow==
Subject: Re: [cocci] Replace custom function multiple times
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 714
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/3a2a50ba-8c30-43c5-354c-7b194eea8df0%40web.de>

>> @searching@
>> expression path, fn;
>> @@
>>  MERGE_FUNCTION_OPENED(path, fn, ...);

Do you find the metavariable type =E2=80=9Cconstant char[]=E2=80=9D more a=
ppropriate here?



>> @script:python generation@
>> path << searching.path;
>> fn << searching.fn;
>> new_fn;
>> include_name;
>> @@
>> coccinelle.new_fn =3D cocci.make_expr(fn.strip('\"'))


Are ordinary function names passed by string literals instead of detailed =
expressions?
How do you think about to use the method =E2=80=9Cmake_ident=E2=80=9D here=
?

Regards,
Markus

