Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5185FC433EF
	for <cocci@archiver.kernel.org>; Fri, 28 Jan 2022 21:27:49 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,325,1635199200"; 
   d="scan'208";a="18547643"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2022 22:27:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 444CDE027D; Fri, 28 Jan 2022 22:27:47 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3D430E00CE
	for <cocci@sympa.inria.fr>; Fri, 28 Jan 2022 21:56:19 +0100 (CET)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=lists@ewheeler.net; spf=Pass smtp.mailfrom=lists@ewheeler.net; spf=None smtp.helo=postmaster@mx.ewheeler.net
IronPort-SDR: 6sIzQXSpVGkfE4Jw5UWeR5/3+oTt2JMVbwGdo8aDCjWo3FWmKHdsMkcfmmw9ElqwJu4xtQyzqj
 YU8T5cZrBZ49C7r/u2iq624j4H6FCxRemasf9E6dIt0W1mn8NWAVtAlRwr8BwItayZhQpqfCfJ
 58IksWSyvaSILueCMbN09cm2nzmlLSF+X6Og0N5Q9GnTj1L+G3hTtAEgSY+qu6ljbkOZxJ4yQB
 xG5Hs+BFpGyMlOjLS1oXvFMgo9zXhFN6b52/pZzztsDNvLPW5yuF3J0zC9L7oBGu0oldPmzTfY
 L5bnL9GJb3j7Q4qgB53OZFQ/
X-IPAS-Result: =?us-ascii?q?A0CqBQCBV/Rh/0Xcza1agQmEAgd3VgEBASkECzGTN4IlA?=
 =?us-ascii?q?55NCwEDAQ03CgQBAYUFAoNgAh0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDAQEFA?=
 =?us-ascii?q?QEBAgEBAgMEAYEILWRnAYFOAYF5BgQwDYI1KQGDYwEBAQEBAQE6PxALGC5XB?=
 =?us-ascii?q?oMXAYJ1IQ+vCniBM4EBg04BE0FHhQ0GgTqGDIgnJxxAgU2BFScMgnc+gkwXA?=
 =?us-ascii?q?QEBAYdbBJIvYhoTLCCBJRpekkOPZZ4Bg0+LAJRGGi6WLZFVlkmNDJQ4gUGDY?=
 =?us-ascii?q?YE/OSWBWR8UGggmCjuCaU4BAgECDQECAgMBAgECAQgBAQIBkg2BPolBIAEBA?=
 =?us-ascii?q?TACAQgtAgYLAQEDCY1MAQE?=
IronPort-PHdr: A9a23:vuTOxxEHe6TUsHKjPf0jd51Gf1pGhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k31hmSAM6EtLoE07OQ7/q5HzRYoN6oizMrSNR0TRgLiMEbzUQLIfWuLgnFFsPsdDEwB
 89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9sM
 hm6twvcu8kZjYZgKKs61x/FrmdVd+hMym5kO0+fkwzg6sus+ZJo7jhdte8m+8NcS6vxYr42T
 aZfDDQoMmA14NPkuBzeRgaR5XUST3sbnANQDwfK8B/1UJHxsjDntuVmwymVIdf2TbEvVju86
 apgVQLlhz0GNz4992HXl9BwgadGqx+vuxBz34jZa5yOOfFgYq3SY88VRWtZXsZQSSNBBJ+8b
 5ASBOYFJOpUspXxq0cLoRa4GAKiBv7gyiVQi3H43aM0zfkvHgPF0gwuEN0BrG/ZrMnpOKoIT
 ey50LXEwSvFYvhL2Tn98o/IchU5rP+DR7JwcNbewlQvGAPFkFqft4jlMC2P1u8QtGWb6+tgV
 fmzi248sAx+vDauxscyhYbXgoIa1ErE+T9/wIkrOd21UUh2asOrH5VMrS+VLZd2Qt88TGFyv
 iY30qELt56mcCUOzJkqwx7SZuKZfoWW4R/uWvqdLDh4iX97eL+zmxW//Fa+x+DgSsW631VHo
 yhHn9TRuX4A1B7e58yBR/Bg8Emh3jOP2BrS6uFCOU00mqvbK4Ihwr4tjZUfq1jMHijzmEnuj
 a+WcF8k+umy5Oj9bLXmvJmRPJJ3hAHmKqkih86yDOoiPgQQQ2SW+f6w2KP98UHlWrlHj/k7n
 6/Eu57AP8sbvLS2AwpN34Yj9Rm/CzCm3cwdnXgINl5KZhyGj4j3NF7QJPD3E+2/j06qkDh12
 /DKJrzhApPTIXjfiLrtYLRw5kBGxAYt0dxS54hYBq8fLP7vQEP8tdjVAgc8MwOuwubnDNt91
 pkZWWKKGqKZNKLSsUSU5uI0OOSDeoEUuDbjJPc74/7hk2U5lUUbfaa3wZsbcGq4Eeh+I0WFf
 Xrshc8MHnsNvgUiUOPqiUaPUSVTZna3R6Iz/Cs3CIOgDYfZR4CimqaN3CmhHpdOfGBJFkiME
 Wv0d4WDQ/oMbDidI8F7nTwAUbisUI4g1RCrtADh0bpoNPDY+iwetZL51dh6/ffflR8o9W88M
 8PI8XyJTmg8umoXTjsylPR9vEh8wxGH2Ldxh/hwFNpJ5voPXB1sZrDGyOkvJsrzUUr+ftqET
 Fu8CoGiACotVfo83N8DbkJwAZOkgwyVjHniOKMci7HeXM98yanbxXWkYp8lkx4utYEkhlgiG
 Y5UMHG+w7V4707VDpLIlEOQk+Crc74d1WjD7jTL1nKA6WdfVgM4SqDZRTYHfEKDqdXi+ljqQ
 qCuBLkjPxEHz8OeeeNRctO8tVxdX7/4PcjGJWe4mmO+HxGNk7eNd5bxU2gC3CjQDEUe1QYe4
 SXOLhAwUwGmpW+WFzlyDRTvbkfrpPF5s2++R1Qowhuial0n2qW19xMRiObaTf4Ptl4dkAEmr
 Tg8XFO03taNTsGFuxIkZ6JEJ9U0/FZA02vd8Q17JJ2paa541BYYdExsskXi2g8SaM0ImNU2r
 H4s0At5KL6JmFJHeTSC2JnsO7rRYmDs9RGrYqTS1xnQytGTsqsI7f05rR3ksmTLXgIm8m57y
 PFYzHuR65HHFkwUXI6wGkc7+h5mpq3LNzEn7tCc3nltPK+o9z7ajot2X61/kkvmJY0Hdv3VR
 2qQW4UACsOjKfIngQ2sZxMAZ6VJ8bIsetihb72A0bKqO+BpmHSni35G6cZzyBHplWI0R+jW0
 pIC2/zd0BGAUmK2iFa6rtvflJ9EaDwWE3D5zyX4Tt00BOU6bcMQBGGiLtfijNF/nIL2c3NH9
 FOuA14cnsmkZVDBJ0y41gpW20MNpHWhkibt1D14nQYiqa+H1TDPyeDvHPYeElZCX3IqzVLlI
 IzvyssfQFDtdA8x0h2s+Uf9waFf4qV5NWjaB0lSLWD6KGRrU634sbTnAYYH7JIzrT5/Xfu8b
 F2eR6S7pRYGmy/uBGpRwjkneiri48qi2UYi1STHdi418iuRcNo43RrF4d3AWfNdu1hODDJ1j
 zXaHBn0PtWk+8mVi4aWt+m/U2y7UZgAOSLvzI6GqG66/TgzXkb5xaju3Ie9SU5kgHyetZEiT
 yjDoRfib5O+0q27NbkiZUx0HBrn7NI8HIhik4w2jZVW2H4Ah5zT82BU9AW7edhdx6/6a2IAA
 DARxNuAqgzkw1F4Bn+Wx4/0UniHhM1se5PpBwFekjJ49M1MBKqOufZAnDBpuXK1sgLcbPxwh
 HEbxOdkuzYKxuoOvgQq1CCUBLsfSFJZMSLbnBON99mira9TaTXKE/D4xA9kkNumFr3HvhBEV
 SOzZMI5BSEppJY3IBfW3Xb08I2hZNTAcYdZqEiPixmZx+1FTfB53vsS2Xg+ZzK75yZ4jbFky
 0YzhNm7uoODNmlgrri0BhdJcDj8ZscY+jjri6tahYCQ0pzKfN0pGzMAWIbkQKCuHS4YsfPsN
 B3IHCcxo3KbHqHDWwSY7Q8jpnbLWfhHLlmxI38UhZVnTRiZfwlEhRwMGS49htg/Hxyrw8rod
 AF44CoQ7xj2sEkEzOUgLBT5XmrFwWXgIj4pVJiSKgZX5QBe9g/UN8KZ9Od6AyBf+NWosgWML
 mWRYwkAA3sOXwSIAFXqP7/m4telkaDQHu2lM/7HeqmDs8RbR7GF2pKi349r5XCKO9nOdnhuA
 vsn21ZSCHB0H8OK/ldHAycTli/Lc4uavELlpXYx9Jjitq6xAESxtNjqafMaK9hk9hGojL3WM
 ueRgH08MjNEztYXwmeOzrED3VkUgiUodj+3EL1GuzSeKcCY0qJRERMfbDt+ccVS6KdplA1MI
 tLAot7q1rN1ivMvTVFISRay/6PhLdxPOGy7OF7dUQyTM6+aIDTQ38ztSaasD7BPjOhZsxCq/
 zCWDwWwW1bL3ymsXBepP+ZWiSidNxELo4CxfCFmDm37Rc7nYBm2WDeYpTApwbA5gn7Qc2gRL
 WolG6ushriAqy5HgvhyH2FbqHxoMbvc8858x+THKpsbtfZxRCJ5i7ACiEk=
IronPort-Data: A9a23:JBp0GKBynu0pxBVW/0nlw5YqxClBgxIJ4kV8jS/XYbTApDwi0DIBx
 mYeXjuPPqvfZmbyeo9zbozipxgOvsXXz4UwOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6jMlkf5KkYAL+EnkZqTRMFWFx2XqPp8Zj2tQy2YHjU1vR0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYowqgsN9Ry
 vVciZiTdBYXeYvMttwFSTANRkmSPYUekFPGCX2v98GMz0DLd3b2hfNjECnaP6VBpb0xWzkTs
 6ZCcHZTP3hvhMruqF6/Yu1tndg4BMT0PI4Svnx6izfUEZ7KRLifGPSTtIYHtNs2rpB1PcbxO
 ZAQUCJmMTvyTkR3EG5JVrtryY9EgVGkL2MD+Q3FzUYt2EDYywd60ZD2Id/Nc5qLQ99UlwCWv
 Aru+23mCxUeHM6ezDCf+zStgPXOlGX1Quov+KaQ8+4sjUKTy2EXBQdQU1anyRWktqKgc+12B
 EM0+Ao/kawRyV2VCf/9cSWgulfR63bwROFsO+E97QiMzI/d7ACYGnUIQ1Z9VTA2iCMlbWd1i
 QLRzrsFERQq4eLFEyvMnluBhWrqYXB9EIMUWcMToeI4DzTLpZF1gw3PQ9tnHbTziNDpcd0R/
 9xohHNg71nwpZRXv0lewbwgq2j2zqUltiZvum3qspuNt2uUpOeNPuREE2Tz4/daN5q+RVKcp
 nUCkMX2xLlQUcrXz3TcGrxWRu3BCxO53Nv02w8H834JrGjFxpJeVdoNvlmS2m82Wir7RdMZS
 BSP51gAu8870IqCYLB3bo+1Bt4ry6OlTY2NaxwnRoEmX3WwHSfZlBxTibm4hj61yBZ0zfBga
 P92s6+EVB4nNEiu9xLuL8917FPh7nlWKbr7Sc+pwhK5/6CZYXLJG74JPEHXNLI086OJrQHY6
 ZBZOtfTk0dTV+j3Yy/2948PLAlQcSNhXc2v95VaJryZPw5rOGA9EPuNk7kvTIpowvZOneDS8
 3DhB0JVkQKthXDOJQiQRGpkbbfjAcR2oX4hZHZ+MEmo1nUnbJzp6qoDLsNlcb4i/e1l7Ph1U
 /hcIZnbWKwSE2ie9m1EP5fnrYFkeBC6vi60PnKoMGolYpptZw3V4du4LAHhwy8DU3isvswkr
 rz8iw7WTMZRRwlmC8qKOvujw0no4CoYiKR/QEvFL91eYgPq/ZQzc379ifo+IsctLxTfx2LAi
 13MWUpB+bDA890v7d3EpaGYtIP3QeFwKUptADWJ57iBMySHrHGoxpVNUbvWcGmFBn/04qire
 c5c0+r4bK8chF9PvocgQaxny7kyu4nmq7NAl1k2GWWNYkurB75kL2PA28RT7/UfyrhcsAqwe
 0SO5tgDY+nSYpu4SQJIKVp3dPmH2NEVhiLWs6Y/LnL60zArrrCJZkNfYkuXgytHIboobo58m
 bU9uNQb4hCUgwYxNorUlThd8mmBIxTsiUn8Wk321GMqtuYq9r2GSZnMTCLp4JyCb9hWdE8nP
 ld4QUYEa6t0niL/n7gbTBAhHtaxQbwDpxBHwVsPPRKPl8atajofwkhK6TpuJuhK5kwv7g+wU
 1SH82V4OqWD8jNlno5FUnzE98StwvGG0hSZ9mblX1E1g6VluqIh4YH91SuwEJglzl9h
IronPort-HdrOrdr: A9a23:m3v+MaC5NAB61JLlHemo55DYdb4zR+YMi2TDtnoBMCC8EKSj+P
 xG88506faZslcssTQb6LW90cq7MBXhHPxOkO0s1N6ZNWGM1QeVxcNZnOzfKlbbak/DH4BmtZ
 uIrJIVNPT7BzFB/KXH3DU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,324,1635199200"; 
   d="scan'208";a="4391917"
X-MGA-submission: =?us-ascii?q?MDF5Gv4M7rjMdOsbQrGK9gBwMF9/nkx+pAibca?=
 =?us-ascii?q?5Lr+/6oz5fH/PCDc+QeJDsP/GVbQndRtGQ1aeTcDyEt2KRtLCfzsHQpK?=
 =?us-ascii?q?eLCCCQy1eCfR7RfpSmR42C9JCpQj+Qp1Pe81GtKw5gRN4ENWb30ZmeZ5?=
 =?us-ascii?q?Gq4Bq7CYvwfPgxMvuYrEgl2g=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 21:56:17 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 3F11045;
	Fri, 28 Jan 2022 12:56:15 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id AA-IJ_j1Qmcu; Fri, 28 Jan 2022 12:56:10 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id B165B39;
	Fri, 28 Jan 2022 12:56:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net B165B39
Date: Fri, 28 Jan 2022 12:56:09 -0800 (PST)
From: Eric Wheeler <lists@ewheeler.net>
To: Julia Lawall <julia.lawall@inria.fr>
cc: Eric Wheeler <cocci@lists.ewheeler.net>, cocci@inria.fr
In-Reply-To: <alpine.DEB.2.22.394.2201281013590.9718@hadrien>
Message-ID: <41d966e-4423-a83f-9ed1-18bec3c1c54@ewheeler.net>
References: <d6cf70b7-84b2-5078-f9f7-81ca8acad349@ewheeler.net> <alpine.DEB.2.22.394.2201281013590.9718@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] How do you match complex double's in Coccinelle?
Reply-To: Eric Wheeler <lists@ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 121
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-01/41d966e-4423-a83f-9ed1-18bec3c1c54%40ewheeler.net>

On Fri, 28 Jan 2022, Julia Lawall wrote:
> 
> 
> On Wed, 26 Jan 2022, Eric Wheeler wrote:
> 
> > Bonjour!
> >
> > I'm having an issue, perhaps you can help.  When I try to use the
> > following Coccinelle patch I get an error:
> >
> >
> > ```
> > @ rule1 @
> > double complex dst;
> > expression a1, a2, b1, b2, c1, c2;
> > @@
> > -dst += (a1)*(a2) + (b1)*(b2) + (c1)*(c2);
> > +vec_fma3(&dst, &a1, &a2, &b1, &b2, &c1, &c2);
> > ```
> >
> > It gives this error while parsing the .cocci file (not when evaluating
> > matrix.c because it doesn't get that far):
> 
> What version of Coccinelle do you have?  Because for me it works fine.  If
> you are using a version from a Linux distro, perhaps try getting the
> latest one from github.

I compiled from github on CentOS 7 before posting to the list:

]# spatch --version
spatch version 1.1.1-00044-gb2a4b9b compiled with OCaml version 4.05.0
Flags passed to the configure script: --prefix=/usr/local/coccinelle-git
OCaml scripting support: yes
Python scripting support: yes
Syntax of regular expressions: PCRE

It is strange though, I tried again and it started working? You might be 
right about the distro version, maybe it was first in path.

I'll report back if the problem continues.

--
Eric Wheeler



> 
> julia
> 
> >
> > ```
> > init_defs_builtins: /usr/lib64/coccinelle/standard.h
> > meta: parse error:
> >   File "vec_fma3.cocci", line 2, column 15, charpos = 25
> >   around = 'dst',
> >   whole content = double complex dst;
> > ```
> >
> > Strangely, it works if I change the type to just `double` instead of
> > `double complex` and it does produce the following patch from
> > matrix.c[1] even though `*cmx` and friends are all `complex double`'s.
> >
> >
> > Questions:
> >  - The Coccinelle grammar[2] says it supports `double complex` so am I
> >    missing something?
> >
> >  - Relatedly, does it support `complex double` as well as `double complex` ?
> >
> >
> > It does what I want if I specify only `double`, but I would like to be
> > more strict about the datatype being `complex double` when spatch'ing the
> > code:
> >
> > ```
> > -            cmx[k+(jl-1)*nrow] +=
> > -              dataj.exk* cabi+ dataj.eyk* sabi+ dataj.ezk* salpi;
> > -            cmx[k+jl*nrow]     +=
> > -              dataj.exs* cabi+ dataj.eys* sabi+ dataj.ezs* salpi;
> > +            vec_fma3(&cmx[k + (jl - 1) * nrow], &dataj.exk, &cabi, &dataj.eyk,
> > +                     &sabi, &dataj.ezk, &salpi);
> > +            vec_fma3(&cmx[k + jl * nrow], &dataj.exs, &cabi, &dataj.eys,
> > +                     &sabi, &dataj.ezs, &salpi);
> > ```
> >
> > Thanks for your help!
> >
> > --
> > Eric Wheeler
> >
> >
> >   [1]: https://github.com/KJ7LNW/xnec2c/blob/f7373f11551b963a78cc27b11692f41abac28615/src/matrix.c#L451
> >   [2]: https://coccinelle.gitlabpages.inria.fr/website/docs/main_grammar.pdf
> >
> 
