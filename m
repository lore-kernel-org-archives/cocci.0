Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DA5CFD2F6
	for <cocci@archiver.kernel.org>; Sat, 29 Nov 2025 16:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=xLZvhzCGzhNSdr7sp5D1y1f2q0OBLSlAmacIGSONpfk=;
  b=mDiIA5PpFJLDxPjcjBiq0kxuVrhfVwt3K+c50DNzEhyQP2ZuCIE5+tol
   rZL5FknA/5ilkRqfeKCG0gr42hhDgD3DjBk2BcqyrKAuKxiYjrjQD2l+P
   olqzPpfvNomUmayIQhBN72QfttKKsg3QaHt88PKUhozWsUbvwKmTAl/5d
   E=;
X-CSE-ConnectionGUID: qc2RxTqjR5aqvUxbS+dYow==
X-CSE-MsgGUID: ZzO8o0aXSH+XzsnWFP/iGA==
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
X-IronPort-AV: E=Sophos;i="6.20,236,1758578400"; 
   d="scan'208";a="251896880"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Nov 2025 17:28:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E5E9DE01A8; Sat, 29 Nov 2025 17:28:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 31DABE0157
	for <cocci@sympa.inria.fr>; Sat, 29 Nov 2025 17:28:24 +0100 (CET)
X-CSE-ConnectionGUID: adEuSeWRSsCjJhzQxnaeeA==
X-CSE-MsgGUID: 6pPLqaFJRziHvw2YaT6Rkw==
IronPort-SDR: 692b1f28_XDxnEX9jrYvJdQ22yAVDNcHaiz+V37pjrjmzevhLY/nrqcp
 Mjeaz9Bs+Wg4Xt0l7J1q6RvOJxECJlSqXJI5E/g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HiAwBEHitpgwsR49RaHgEBCxIMQIQQZSNYMwQLSYRVj?=
 =?us-ascii?q?1OCJIQ7hzyHVYxLAg8BAwENTgECBAEBAwSBTECCdAKMZQIeBwEENBMBAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBAToHDjuGTw2CYgGBJ?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREaDAEECwsaAiYCAlYGFQEBg?=
 =?us-ascii?q?n6CIwEGEAEDDycHsU2BMoEBggwBAQbaXx8sIlmBZAmBHC6FboJlAYpmJw+BV?=
 =?us-ascii?q?USBPIJSMT6EQ4NbgmmCJoEOmVZSeBwDWSwBVRMXCwcFgSBDA4ELIw88BS0dg?=
 =?us-ascii?q?SMhHRgRYD0XQINJHQZnDwaBERlJAgICBQJAOoFmBhwGHBICAwECAjpVDIF3A?=
 =?us-ascii?q?gIEghZ9ggoPiAuBCQUugQ0CAQttPTcJCxsGPZUNUIQLb6RujhiUYzQHgjiBZ?=
 =?us-ascii?q?4FkDJ9sBhMvg3GTYQ4GkwWZBqlBgX8jgVwzGiSDNk8DGQ+OIRklg3XEfUI1P?=
 =?us-ascii?q?AIHCwEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23:eIqnyRftNU0h3cXN27OS0VONlGM+F9TLVj580XLHo4xHfqnrxZn+J
 kuXvawr0ASSG92HoKgZ0buM++C4ACpcus3H6CtDOLV3FDY7yuwu1zQ6B8CEDUCpZNXLVAcdW
 OlkahpO0kr/D3JoHt3jbUbZuHy44G1aMBz+MQ1oOra9QdaK3Iy42O+o5pLcfRhDiiajbrNuN
 hW2qhjautULjYd4Jas8xBXErmFUd+lZym9kO1Kekwj468uu4ZVv9zhct+87+8NPX6j3cb40Q
 aBWATgjLms4+NDluR7fQASA4XcRTn8YmQdSDQjf6xH6UJbxsi/kued4xSKXI874Q60qVDq79
 6tlRwfmhygeOzMn/2/Zl9R8g61Hrh2voRx/2JPUb5qONPViZKPdfMgVSnRHU81MSiFOGIK8b
 48ID+ocIeZVqpT2qlUSoReiAwSnGfjiwSFUiHDowaI60vwhEQDY0wwmA9IOq2nfoNHsOKsPT
 ey50KzEwDPeZP1UxDj98pDFfBMvr/6DU71+bNTfyUcxGg3FjFqftYPrMiiJ1uQUqWWX8/ZsW
 fythmMhtgp/oiKvxsApioTRgYwa0ErE9SZkwIYuONa2R0p7YdC+EJtRsSGaOJZ9T8QlTW5yo
 iY6yaAGuYWhcCYFzJQnyQTfa/2Bc4iH+R/iWvieLixiiH14Zr2ynhC/+lWvxePgTMe7ykpKr
 jZbndnWsHAAzwHe5tWDR/Z94EqsxTiC2gPN5+xGIk04i6XVJ4IuzLIsi5YerErNEy3qlEj2g
 qKbdEoq9vS05+n6f7noqJyROpFyhwrjMaougtSyDfolPgQQRWSX5/qw2b/58UHkQrhGlOA6n
 rTBvJ3eKskXvKC0DxJP3osi7xuzFSqq3dcakHQBMVlLYgiIj5LzNFHLOP34Demwg1CrkDpzw
 vDGOaDhAonXInnNjrjuZqxx5FNCxwYrzNBf4YxbCq0ZLf7tR0P9qsbUAgEnPwG22errFddw2
 pkDVW6SGqOZNbndsV6M5uIhOemMY4oVtS76Jfc//f7ujmI5mUQHcaem2ZsXZmq4HvVgI0WWe
 nftjMkOHnwQsgUjUuPmkEeCXiJLZ3auQ6I84Sk2B56hDYjfWo+tgaeM3Dy7H51TfmBJEEqAE
 Xbud4WeWvcDcjieIsF7kjAcU7iuUJcu1Quyuw/i17pnMu3U9zUFuZ7729h6+erTmxIo+zFsA
 cqT3HmBT3tqkWMWRDE4xrhyoUl6yleezah0mfJZGsJI6P9TTwg1K4bQwPF5C9DzXwLMZs+HR
 lmoTdu4HT88UtQ/z8cTbEZ4AdqilAzM0jKyDbEMj7KFC4Q48rnE33j/P8tz0WrL2rQ8gVU+W
 ctPLWOmibZ/9wfNA47JlF2Umb6ze6oE0yCevFuEmFaJtkBRS0ZcXKTAXHYQa1Ge+cj+7ELLV
 PmiBLUiMw1OxNSqMqxRdtDuy1lLEqTNItPbNke4gWStHl6lwr2WbYzlMzE41T/eFVNCvgQd5
 3eAOiAhCy3nr2+IX28mLk7mf065qbo2k3i8VEJhiljSNyWJtpKw8x8R37mHTu8Lm6gDs2Eno
 il1G1C025TXDcCBrkxvZvYUessztXFA02+RrAlhJtq4Nak3o1cEcBls+W7q2Q92DIpojsUg6
 n8nn0JpMazN6FpabHuD2IzofLjeK2385heqPovfwFLDy5C7/qkV6fI3g0rutkelGxlq6G1ph
 v9S1XbU/ZDWFEwSXJb2B14w7AR/rqrGbzMV4oTJyTtzPKPyvjKqN8sBIuwjx17get5eNPnBD
 wruC4gAAMPoLuU2ml+vZxZCPeZI9adyMdn0P/2BkLWmOupthlfExSxO/Zx930SQ9iF9Vv+A3
 pALxOud1xeGUDG0hUmos8T+k4RJLT8IGW/3xS/hDY9XLqp8GORDQUKnOc6q3ZNTg5D3WnhX3
 EGuDRUK1Y7heBafaUD8wRwFzV4e8jSsnSq1ySAxkil89PPFmnaUnKK7K1xeYz0uJiEql1rnL
 ImqgspPWUGpa1Jsjx65/QPgwKMdoq1jLm7VSEMOfi7sLmgkXLHj09jKK8NJ9p4stj1aFeqmZ
 lXPAJv0uRgHyGXOG2VExTY0Xy6nsNP1klYp7QDVZGY2t3ffdcxqkF367cbfWOUX8z4IXih+h
 hHIC1L6M9TjrrD239/T9+u5UWymTJhadyLmmJiBuCWM7mpvGRSjnvq3l7ULCCAC2DTgn5lvX
 CTM9lPnZ5Xzkr69OqRhd1VpA1n174x7HJt/m80+nsNY1X8fj5STtX0J9AW7efBSw6HjdzwgQ
 TARwtjayBfo0gtvIzqFypn4WXOU3sZ6L4PjOCVMgH17tp8MUf7c5acMhSZvp1uksQ/dBJo11
 iwQz/cj8j9Sgu0EvhYs0jTIB7kTGUdCOim/3x+M7t24sOBWfDP1KOL2jhAh24n+Sujb8WQ+E
 D7jd5wvHDF99JB6OVPIijjo7538PcPXZpQVvwGVlBHJi65ULogwn7wEn3kCWyq1sHs7xuo8l
 REr04u9ud3NDmx3/7+iRDNcOCf0Ycw75Tzny6pT1JXzvcjnDtB6FzMHUYG9B9ehCjEPrrLKM
 wiUETszgmiWE/zTEEXMjSUu52KKGJetOXaNIXAfxtg3XxiRKntUhwUMVSk7lJo0RUi6gdbse
 0Bj6nUN90b1/1FSn/lwOUC1AQK97E+4Ly05Q5+FIF9K4xFesg3LZNeG4Ls7FnNd+YC96hOAI
 CqXakxBX2QOR1DBF17kJKan/9WG7OWSQOazSpmGKbzcrOtDS7KCwo+p2YYg4DuGcMmCdnAwC
 vomxg9IRnpkH8efwjwJR3VRnCXICqzT7B7u/ypqsoW06//sQhqpvIKJB+IUOtJqswa/haPJX
 wKJrAB+LzsQlpYFxHuSjaMawEZXkSZlMT+kDbUHsyfJCqPWgK5eSRABOWt1M4NT4qQw0xMoW
 4aTg87p1rN+kv8+CktUHV3nlMazYMUWIma7fFrZDUePPb6CKHXF2cbyKa+7TLRRiq1TuXjS8
 X6DFFT/Oz2YizTzfxWoLP0KkyyRehBT+cm8fhtrFWn/XYfmZxm8Y7oVxXU9xbw5gG+PNHZJa
 2EmNRkX8fvJsmUB26YaeSQJ9HduIOialjzM6uDZLsxTqv53GmFukOkc5n0myrxT5SUCRfpvm
 SKUoMQ9xjPu2uSJ1DdjVwJD7zhRg4fe92BrI6bE7d9tXXje/RQCxXqdAVIGqpE2b7+n87AV0
 dXJmK/pfX1a9MnI+MIHG8XOAMeALWZnLhfjXjLZRlhgL3bjJSTUgEpTl+uX/3ueo80hq5Tir
 5EJT6dSSF0/Ev5y4qtNA9EIZpt6DGpMeVuzk8MCo3az/kG5rCRyu5faSrSNDP+pJDvL1dF5
IronPort-Data: A9a23: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
 QwhtFcfNBg=
IronPort-HdrOrdr: A9a23:BWDlIKjGUft///hEt0Bo04So53BQXg4ji2hC6mlwRA09TyVXrb
 HLoB1p726QtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykZsS+Q2mmF+rgbsbq62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: =?us-ascii?q?9a23=3ACVgmEGkguTas8UAhF+OnUllbN2XXOXTR4WrrLnC?=
 =?us-ascii?q?CMn1CSp+VW2aA/qppnuM7zg=3D=3D?=
X-Talos-MUID: 9a23:w6bRtguFbLYfI49oCs2n2ilaEN5hzYaUGkEtj4pcisC4axZzJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,236,1758578400"; 
   d="scan'208";a="251896878"
X-MGA-submission: =?us-ascii?q?MDEDJZJiAwby2skvd/dSKENDEi8I/vW3hAAw6E?=
 =?us-ascii?q?RLvNlF4HEx6rbZrtrpcHDuTHWOlJb7ZnwWL6dZCa9neKAUhyNe+P3FNW?=
 =?us-ascii?q?y0Dhd8z1NtvfMe/9rpTAQ7Mdb+FIw4Bk1VTeshH7lAE0COy0Yg1w/As5?=
 =?us-ascii?q?cBJvY2xY1uzScXX4iJvTAJqg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 17:28:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764433691; x=1765038491; i=markus.elfring@web.de;
	bh=xLZvhzCGzhNSdr7sp5D1y1f2q0OBLSlAmacIGSONpfk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fvywoi2N1hcLga3Yp/3FHDHI706D+9d2PlzDklGOXWdYaBx7Cqx/HuvRnwj0gSf+
	 dSlABnz9eu/6k+wQ/9xHNYwcrN55YFJoRQJ1fs76ZtBGwt7yNTJ0ap/WzIivYPdIB
	 apgpEBinTaZJd3GWvMgSRmtQ+Wj3U5qAoYhOKz7hNWiWPbX08VPWRiV8NGZlkIuGx
	 GqsmV/4zPOWdTbbjI4WeUbh6DYH/mNgNQM+JPVJj1bl8UzdYXgDdLeVJMQ5uE2hvG
	 miWoUpj4g7iW26U/9/3NXNy+dNOi6Y/cf2fid3yDVCuIe/m3nAz+clGQQCdj7a/uM
	 jl/xjlFpSCxBWrlRIA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.187]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MeDQj-1vyzCm2MTv-00qckC; Sat, 29
 Nov 2025 17:28:11 +0100
Message-ID: <46756c86-1d67-4cc9-93cd-2cffff8820ab@web.de>
Date: Sat, 29 Nov 2025 17:28:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tobias Deiminger <tobias.deiminger@posteo.de>
References: <4f6e259891de0666aa1fa10b810a5dd3@posteo.de>
 <b4884a21-4a59-c549-8466-164a20a76abe@inria.fr>
 <2897bda0c438111e967017f6bb3422f0@posteo.de>
 <caf02577-eee9-d55d-1f42-7b1f3bd2f60@inria.fr>
 <3ae5bc93f8cae1f28a068d89d3d1b070@posteo.de>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <3ae5bc93f8cae1f28a068d89d3d1b070@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WFMuX5c8YxFvBU7m+PB02TK4iuscgeXCE6WHkrl1qGX6byguhlO
 +mo6dzfwnrMGUKyAgI9Md4nNRA7/Wj3XP/NxTFUVyf4UZOrzUxjxmnGBg8k/iuVKfJX0cft
 bV8HatfojIEOXwU1EeSWHtcA3kPUTG9tAP+ZzctX2buZxIKGsxcP+HhoP4vdPET5SOxFp8O
 sZxMg9RTn6rOBgK8rVmLA==
UI-OutboundReport: notjunk:1;M01:P0:3BN8eJ9ODyI=;cxNLMumdLk/mb4G91oHa/pt04ZQ
 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
 0OeOI7aagbJ2xgGay++7J/01Q1QJCNvRf+aSAD
Subject: Re: [cocci] Can we match a known macro by macro name instead of
 expanded function name?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3214
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/46756c86-1d67-4cc9-93cd-2cffff8820ab%40web.de>

>> You might point remaining improvement possibilities out for this evolvi=
ng software.
>=20
> Thanks also for your pointers. I've started learning about Coccinelle ye=
sterday evening

Interesting.


> and think I'm not in a position to make improvement suggestions :D

I guess that some clarification approaches can influence also desirable ad=
justments.

It seems that you would like to achieve data processing according to macro=
 applications.
Such a technical detail can affect known open issues.

Regards,
Markus
