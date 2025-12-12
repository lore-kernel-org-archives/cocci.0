Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C33D4415D
	for <cocci@archiver.kernel.org>; Fri, 12 Dec 2025 09:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Dtv5YfVKWvqekBEDQEStEZlHajPn42BPyX8iEnS+i08=;
  b=FYivkXuc4/nXf4DsufnKq3su5PVa5rk2k5jeEMmVuVfFJXLETZn3/d5A
   ivDaDfBBoYpHdqvTFpQ5qZ9mz6lkApjIutKPSME4t8kuFQkFOP14Yj2C4
   WDTM21BofZp2iM4ZklxUYv9b/hJ9pwU3JQnW9bmMs6UXpU4kKJf6d8sSE
   o=;
X-CSE-ConnectionGUID: PE8bJtuDTbSiVdLFSDt5hw==
X-CSE-MsgGUID: 9PJsW0llTa+iCHWheq467w==
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
X-IronPort-AV: E=Sophos;i="6.21,143,1763420400"; 
   d="scan'208";a="254121073"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Dec 2025 10:52:35 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id C48088167E; Fri, 12 Dec 2025 10:52:35 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (dsi-ha-lb1-dmz.inria.fr [128.93.162.100])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 0FFB981673
	for <cocci@sympa.inria.fr>; Fri, 12 Dec 2025 10:52:28 +0100 (CET)
X-CSE-ConnectionGUID: yb32r6jCTU+0f+NNMHHppQ==
X-CSE-MsgGUID: iVomBkTfS0iPEbXG2JQimA==
IronPort-SDR: 693be5db_9rE+0FOScciF1eKHuTTvUPd2MYFtKY7BapOP1mMB+Y1lrwT
 oDi+G49y4RYz2PvIxlHHWgkkvKQfIth68LJg5GA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FCAADt5DtpgA4P49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/AgEBAQELAYI/Zx8GWTMEC0kDhFKPU4IhA2mDUpgKg1ICD?=
 =?us-ascii?q?wEDAQ1KBAECBAEBAwSEOkYCjGgCHgcBBDMGDgECBAEBAQEDAgMBAQEBAQEBA?=
 =?us-ascii?q?QENAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYZPDYJiAYEkgSYBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEdAg06RAEBAQIBIx0BAREmAQQLCxoCJgICVgYBFAEBgn4BgiIBBhABAw8nB?=
 =?us-ascii?q?w2zUYEygQGCDAEBBtphHywiWYFkAwaBHS4BhW2CZQGFbjuDQ3onD4FVRIE8g?=
 =?us-ascii?q?wM+gkoXBBiBRoNbgmmCJoEOhh2TS1J4HANZLAFVExcLBwWBIxAzAyAKNC0CF?=
 =?us-ascii?q?A0iDxoFLR1wDCcSDx0PCBNgPRdAg0kYBmgOBoERGUkCAgIFAkA6gWgFARwGH?=
 =?us-ascii?q?BICAwECAjpVDIF2AgIEghh9ggoPh0KBBgUueyUjAgELbT03BgMLGwY9lRBOg?=
 =?us-ascii?q?T9sBoE7gU2TcBSDPQGMcKJ7NAeCOIFngWQMii6VPgYTL5dSDgaTBS6YWCKNZ?=
 =?us-ascii?q?pYZhR+BfiSBXDMaJIM2TwMZD44hhDOEYLwIQjUCAQEMLAIHAQoBAQMJhUYBA?=
 =?us-ascii?q?YxWgUsBAQ?=
IronPort-PHdr: A9a23:MgkdOhJwToR9ZJ3n8NmcuFFvWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCEubM11BSTAtWGo7Ic0qyK6PumATdBqb+681k8M7V0HycfjssXmwFySOWkMmbcaNPMUWkRM
 f8GamVY+WqmO1NeAsf0ag6aiHSz6TkPBke3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55I
 AmroQnLucQbj4RvJrwtxhfVrXdEZeZbyGBoKFmOmxrw+tq88IRs/iletf8t7dJMXKv/c68lU
 bFWETMqPnw668HsqRTNVxaE6GEGUmURnBpIAgzF4w//U5zsrCb0tfdz1TeDM8HuQr46QTut4
 751RRHnlSkLLzE2/n3Zhcx2l6JbvQmupwdjzI7OYYGaL+Rxc6XAdt4HX2VBX8JRVytcAoOga
 oYEEuQMMfpEo4T7ulADtgW1CxWyC+zzyz9Inn720rM80+Q9CgHNwQgsE8sTvHjIsNn5MaEfW
 v23wqbV1zXOd/BY1zny54fGbx4vv++BXbxwf8XT1UYhGBjIjkmJqYH/Iz+ZyvoBvmqd4uF9V
 eyvkWknqwRprzao3MgskIrJhp8OylvZ+it5xIg1Jce5SE59bt6vDZxduSaAOItsQcMiXnpot
 Dw1xL0Ct567ZikKyJIoxxPEZf2IbZOH7gj+W+mPODp1gm9ud72jiRio60eg1vH8Wdeu0FZMt
 idJjMfBu3IP2hHX9sSKS/pw8Ei81DuS2Q3e9/xJLE40m6fFNZMsxrA9moYXvErNHiH7hlv7g
 a+Se0g65+Sl6ufqb7P7rZGSMI90jxvxMqUomsGnAuQ3LBIOX26F9uS4zrHj+lf5QLpMg/Yrk
 afZqIjXKdoGqqKnGQNZzJgv5hSlAzu70NkUh2QLIV1ddB+DgIXlIV/DLO3iAfq+h1mgiipny
 vPaMrDnH57DNGLMkK37crZ480NcyBQ8zdRY559MD7EBJ+/zWlPruN3WEBA2KBa4zPv5B9ll1
 4MeX3yAArOBPa/MrFOE+PgjL/eSaIIXojrxNvgo6+TzgXI2gVMdeLOm3ZoTaHC2BPRmJECZb
 GLrjNgbC2cKvRc+TPfwhFONVT5TaWyyX6M65jE0E4+nA5nMSZu3jLOcwii3BodWaXxeClCQD
 XfocJ2JVOsLaC2OPsBhkycJVaOhSo8kzRGhrhX2y7thLurO+y0Xr4jv1NZv5+HLjxE96SR0D
 9iB02GKV2x0mnkHRjEs06B7pUxw0VaC0al9g/NDD9xc/elFUgY8NZ7Gzux1Ecr+WgzbftuRT
 lapWc2pASstQdIp398Of0F9Fs28ghzb0CqlHbgVmb+RCpEs/KzS0GD9J9xjxHbY16cvlUErQ
 s5INW27mq5z7QbSCJDSnEmDiqmla7wQ0zPO9GeCyGqDpFlWXgF+XqvbQX4Sek3Yoczk6UPHV
 bCuE6goPxNZx8CbMqVEZcXljU5eRPftINnQeX68lXqtCxqQ3bOMdITqdH0d3CrDDEgElBge8
 26fOwYmCSny617ZWR9jGEmnSETr8qEqq362VWc3whuMYkkn0KC6rFpdjvuXQPI737QeuS5np
 S8wVFK82c/GTtqJvQZseqRabvsj71pdk2HUrQpwOtqnNa8mzlofdRln+kbr/xZpA45D188wo
 yAE1g13fIeRylBcbHu12Z7qO7vYYj3X9QqsdrWQ91XQyteQ9Y8Q5f5+p1i171LhLVYr73gyi
 4od6HCb/JifSVNKCfoZM24y/hl+/fTBZzUlopnT3jtqOLW1tTnL35QoAvEkw1CuZYQXK7uKQ
 Sn1FcBSHM2yMKoygVH8SxseP/1JsoMwMdmncfSux6Oheuptz3q9lWoS2IlmyQqX8jZkDOvB3
 pIL2fadiy6OTTThlxGMts7tmIZLTS4fFCyzxHusH5ZfM4t1e4tDEmKyO4u3y9F50obqQGJd/
 UW/Ckku3ci0ZVyNYla70QA4OV0/h3uhlGP4yjV1l2tsta+DxGnUxO+kchMbO2lNTW0kjFH2I
 IHygcpIFE6vJxMkkheo/yOYj+BSubh/Im/PQExJYzm+LmdsVbG1v6aDZMgH4Y0hsCFeWuCxK
 V6ATbu1rxwf2iLlV2xQoVJzPxSjoJbkhFpXjGyHLXB8hGXUc4d8yFaX5dDRQ+JQwitTXDNx2
 nHcAlmxOcXs/M3Bzc6Z9LrkCCT4C9sKLXqOr8vIriaw6Gx0DAfqmvmynoeiCg0myWrh0NIsU
 yzUrRH6a42t1qKgMOshcFM7YT20o8d8BIx6lZM9wZ8K3n1PzLCc53kaiiHeNdtB2KTxRGUAT
 3gHzpSGhWqtkF0mNX+Py4/jAz+4y9FiesL8T2cYwCM74OhVBa3S4LEOzk4X6hKo6AnWZ/Z6h
 DIUz/AjvWUbj+8+sw0o1iyBA7oWECG0JATUng+Tp5C7paRTPiO0dKSokVB5lpanBa2DpQdVX
 DD4fI0jFGl+9Jc3PFXJ2Xz1oobqHbuYJfcarB6JiFHti+ZPKZQ+vuUHj2xrNCrxsGYkxOgyk
 RF1lcvj5s7dcTorpf//W0IQPya9f84J/zDxkatS+6Tel5uiGJlsAHRDXZflS+6pDCNHsP3mM
 wiUFzhv4nyfGLfZAUqe8BI89iiJScr0cSjKYiBFnrAADFGHKUdSgR4ZRmA/l589TEWxwdD5N
 V1+7XYX70L5rR1FzqRpMQP+WyHRvlTNCH98RZ6BIR5R9gwH6V3SNJnUy+tpHDxDuLClohaML
 GOzeAlCS20EEB/hZRirLvy16N/M/vLNTM+3NfjTevOjreJEVvGH7Y2i2M1q8nzfU6fHdmknB
 Po91E1ZWHl/EMmMgDQDRRsckCfVZtKarhOxqWVn69qy+/PxVEfz9JOCXvFMZM539Un80sLhf
 6aAwTx0IjFC2tYQyG/UnfIBiUUKhXgmfmuoFqkc8zHARuTcl+deXRscdj82JMVP9b01xAULJ
 sPRzN/4s9wwxvdnDlBYSRnrndyvbsFMPGy3cl/KTE/ZMbObOXjA2MvqZaD6ELRWgLwSvBq13
 FTTW0axOzOei3ziTBuoK/kK1SidMEUYs4a4OgBkDWypJD7/Qju8NtI/zTg/wLluw2jPKXZZK
 z93NUVEsryX6ypcxPR5AW1IqHR/f6GCnG6C4u/UJ4xz07MjCzlol+9c/HUxyqdEpCBCSvtvn
 SLOr9lo61i4m+iLwzBjXVJAsDFOzI6MuExjP+3e+PwiET7c+wkR6GyLFxkQj95iF8GppK1aj
 NTC1eryJDpE79PI7J4cCszTe6fleDIqNRvkHiKRDRNQF2fxczuF2AoEzbfLqi7wzNBysJXnl
 ZsQR6UOUVU0EqlfEUF5BJkYJ5wxWDo4kLmdhcpO5HykrRCXSt8J2/KPHv+UH/jrLy6UyLdeY
 B5di5bxN4cOLcvW30J4a191tJvHEQzcUJoex08pJh9xu0hL/HVkGycr3Fn5bwq2/HIJPfuzg
 wJwlQZ0J+ggvmSJgR9/Nh/Boy0+l1M0kNPujGWKcTL/G6y3WJlfFyv+s0VZ2nLTRgFocUutk
 EYiODqWH9q5YJN/eGothAKO4POn/NZDQKcCbBJCnZmq
IronPort-Data: A9a23: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
 xmVBFYf5e7BsfiovPkyDBkPnutSOwDWBurEGw==
IronPort-HdrOrdr: A9a23:UisDq67HZ6h72D3IwwPXwBzXdLJyesId70hD6qm+c202TiXqrb
 HLoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:HpdAGWFmlXlVY5QHqmJ2/hVOAJ4nWUHgjy/eYGmeLEZJUKWsHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AioKR8Q2uY5P6TzYb8tG3iQRjCDUj4pqpDWoOrZs?=
 =?us-ascii?q?948i8GCZAFG2/tTWya9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,143,1763420400"; 
   d="scan'208";a="254121043"
X-MGA-submission: =?us-ascii?q?MDE8SDK/1PgS/NBsLO7LJP97vgmuNbKtNnwG2f?=
 =?us-ascii?q?cC45T3yPynSykeTWooKDTQqXWDiW0FOGGiDj3d33t65AHLpTYGYbXWYV?=
 =?us-ascii?q?ewfeYjr8ZgprJVfXWiQ1reOOdvjRgKeaIvgJm45aQQKoZeSmhK7To+M8?=
 =?us-ascii?q?uamSNcSTlZMDwLN/pfhCHFqg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 10:52:27 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.180]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MV2OY-1vdEx70kqM-00L8R7; Fri, 12
 Dec 2025 10:51:35 +0100
Message-ID: <b4023748-453c-433d-b3ce-45cf42d74889@web.de>
Date: Fri, 12 Dec 2025 10:51:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kees Cook <kees@kernel.org>, cocci@inria.fr,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, LKML <linux-kernel@vger.kernel.org>,
 linux-doc@vger.kernel.org, llvm@lists.linux.dev,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexander Potapenko <glider@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Bill Wendling <morbo@google.com>,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Harry Yoo <harry.yoo@oracle.com>, Jakub Kicinski <kuba@kernel.org>,
 Jan Hendrik Farr <kernel@jfarr.cc>, Jann Horn <jannh@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Justin Stitt <justinstitt@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Marco Elver <elver@google.com>, Matthew Wilcox <willy@infradead.org>,
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Pekka Enberg <penberg@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Sasha Levin <sashal@kernel.org>,
 Tony Ambardar <tony.ambardar@gmail.com>,
 Vegard Nossum <vegard.nossum@oracle.com>, Vlastimil Babka <vbabka@suse.cz>,
 Yafang Shao <laoar.shao@gmail.com>
References: <20251122014304.3417954-4-kees@kernel.org>
 <71d406fb-9fb1-44a9-912a-7a0d270b9577@web.de>
 <202512111352.387A339CE@keescook>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <202512111352.387A339CE@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PhTgDphTssUyrodhgTCx7Tqtgufwo1sjpK9UJ5w9XqTxKWfOXaU
 O/cJ2ZnIYWd2plns2xNoLZ6Wu5a+3zBgF7aOQyD3Tl0erfE6h9xUo4DOItCvDl61epaLFQS
 RGlAqFD4gmTcyOD5b/81KM3BDkbHlK7xY5VE8ie6O6ZPc6tLhETNiLSaeX3GrZeV6DAenKL
 EiUOldJE6L0VHbBDRAIGw==
UI-OutboundReport: notjunk:1;M01:P0:fFhpdpeAcsw=;6MaFvpcyAnAkj21LKn1f+O6CLgf
 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
 jtBNOANA=
Subject: Re: [cocci] [PATCH v5 4/4] coccinelle: Add kmalloc_objs conversion
 script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3262
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2025-12/dcD5T6aK66Dg5DOO4Rwbsg>

>> See also:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.18-rc7#n94
>=20
> "Describe your changes in imperative mood"
>=20
> I guess I can try rewording this, =E2=80=A6

I became curious once more how another improved change descrition can look=
 like.


>>> +virtual patch
>>
>> Will additional operation modes become relevant after clarification of =
implementation details?
>=20
> I am not interested in other modes; if people want to contribute them,
> they are welcome. :)

Will development interests eventually grow accordingly?


>> =E2=80=A6
>>> +def alloc_array(name):
>>> +	func =3D "FAILED_RENAME"
>>> +	if name =3D=3D "kmalloc_array":
>>> +		func =3D "kmalloc_objs"
>> =E2=80=A6
>>
>> * I suggest to avoid duplicate variable assignments.
>>
>> * How do you think about to collaborate with the Python data structure =
=E2=80=9Cdictionary=E2=80=9D?
>=20
> I wanted the stderr warning when there was no match, but to return
> "FAILED_RENAME" in such a case.

Such a data processing result can be achieved also by a more appropriate a=
lgorithm,
can't it?


>                                 Using a dictionary was basically the
> same length as the elif stack. If you have an alternative, I'm happy to
> replace it with what you come up with.

Is there a need for further case distinctions?


>> =E2=80=A6
>>> +type TYPE;
>>> +TYPE *P;
>>> +TYPE INST;
>>> +expression VAR;
>>> +expression GFP;
>> =E2=80=A6
>>
>> Such repetition of SmPL key words can eventually be also avoided.
>=20
> That is true, but I like having them separated -- I find it more
> readable that way.

Under which circumstances would you become used also to more succinct SmPL=
 code?

Regards,
Markus
