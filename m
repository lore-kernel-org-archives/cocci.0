Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671DDD68BE1
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=2qNmVTIUPIQHjxG6U+oz3oOJorUpDTvltiEua1kgDGM=;
  b=P2SUGNGnBwceBHxg/IkBxawGvOnsC3eNpjEtvOmM+U72ezlPU47sG06y
   E2q1WrGytvL1kPlu53HQ9br0Fs2PWWqrsVtgc5KZYkwNI6XJsemyWI2eC
   bVKphD0p4LLm/StgXztTecJ6xzeoGHxffWn01GavvekzmwrFtWHzNrZra
   Q=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.microsoft.com
X-IronPort-AV: E=Sophos;i="6.12,158,1728943200"; 
   d="scan'208";a="194169833"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:36:08 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A8822E0E56; Fri, 15 Nov 2024 23:35:55 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id F1289E0133
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:26:44 +0100 (CET)
IronPort-SDR: 6737bc94_S0MRjrek4+50xlL+USNuN+dFTW7uS8+UfQjVZ9cIbhgN90d
 e0dnRGw/EkrjT40Aa0prWwzhxSzFu/7nKAevQkQ==
X-IPAS-Result: =?us-ascii?q?A0EDAABHuzdncraaTQ1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDgVczBwhIhFaIHZVHkE2BVoFAPg8BAwFOA?=
 =?us-ascii?q?QIEAQEDBIFMgzQCiksCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAYEMhXsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QERAg1eAQEeAgEDERIdAQE3AQ8lAiYCAkYQBgESgwGCZQYCn00Bh2ABAQKLI?=
 =?us-ascii?q?4EygQGCDAEBBoJn2TiBZAmBGi4BiEsBgWyDfTuDQnonG4FJRIFKgQaCLYRYg?=
 =?us-ascii?q?0aCaYJFhRMlhQaDeZl+CT+BBRwDWSERAVUTDQoLBwVjVzwDIm9qU3orgQuBF?=
 =?us-ascii?q?zpCgTuBEy8bIQtcgSmBGhQGFQSBDkY/gkppSzcCDQI2giQkWYEdgTKFGoRsZ?=
 =?us-ascii?q?y8DAwMDgzyCTmQyHUADCxgNSBEsNQYOG0MBbgefBEaDNIEPlX6DfI1Cgh+fT?=
 =?us-ascii?q?IQkoV0BMqpOLodkkGUiqFSCGDqBXEYHIxWDIk8DGQ+OIQwWg1iPPgG2HkM1O?=
 =?us-ascii?q?wIHCwEBAwmFRgEBig+BSwEB?=
IronPort-PHdr: A9a23:/1w4bB/ioN0qIf9uWeyrngc9DxPPW53KNwIYoqAql6hJOvz6uci5Z
 QqFub400AOBHd2Cra4f06yO6+GocFdDyKjCmUhBSqAEbwUCh8QSkl5oK+++Imq/EsTXaTcnF
 t9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFRrlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5/I
 gi6oR/PusQZjoduN6k8xxTUqXdMZ+ha2HlkKF2dkhrg/Mu84IJv/yFNsP896sBMVrn3cKs/Q
 bFEFjoqNHw76tP2vhfZVwuP4XUcUmQSkhVWBgXO8Q/3UJTsvCbkr+RxwCaVM9H4QrAyQjSi8
 rxkSAT0hycdNj4263/Yh8pth69Guh2hphh/w4nJYIGJMfd1Y63Qcc8GSWdHQ81cTDJKDJ+iY
 IQTDuoBJedYoJf7p1sSthu1GA2gCPryxjNUmnP62Ks32PkjHw7bxgwtB9IAvnrJotr6KKgcX
 uO7zKfKwjvdcf5Y3izw6JTKfx07vf2BR658fMjXxEIyFw3FlFKQqYn9Mj2azOsNqGaa4PB6V
 emyiWAosRtxojmvxsg2kInGnIQVwU3D+Cpn2ok1Jce3SFR6Yd6kCpRdrCWaN4pwQsM/TGBko
 iM6yrwatp6heygK05MnxxDDa/Cdb4eI5RfjWf+XLDxli31rZKixiAyu8Ui81OL8TM+03U5Fo
 CdbktTBt3AD2gLP58WJRfZw/0as1SiN2g3S9O1IPFw4mKXVJZMi3rM9kocevEfAEyLomEv4g
 7ObeEs49uao7ensf7bopoeEOoNphAzyKKYjl86lDeglMgUDUHKX9fm/2bH95UH0T6lGgucyn
 6XEqpzWONkXqrCjDwJR1osu7Qu0Aimi0NQFhnkHMExKeAiagYjoOlDBPuj1Aeu5jl+xijlk3
 erGMafkApjVLnjMjrPhfbFl5k5YyQozy81f5p1OBrEEIfL8RlXxtNvDDh8+PQy03/zrB8l61
 oMbQW6PA6mZP73OsVKQ++4iLfOAaY0XtTrnNvQo5/HjgWUklVIeY6WlxZ4XZ2q5HvRiLUWZe
 33sgtIZHGgUpAU+TPbliEeDUT5TfXm/RKY85jA9CIK7AobPXIWtgL2d0yehGZ1WfWdGCl6QE
 Xvya4qEXPIMZDqUIsB6ijMET6SuS5c91RGysw/306RrIvLO+iIErZLjyMR15+rLmBE27zN1A
 d6S02WJT2xvn2IIRjo207tloUNn0FuD0K54g+ZZFdNJ/f9JXB06OYbGz+NmE9DyRh7BftCRR
 Vm6RdWpHS0+TtMqzt8VY0d9Hs2igQrZ0yqrBb8Vjb2LC4Yu/qLSxXiib/p6nk7P3q0mx38rQ
 9FGfUS3m7V4v1zLDoTNlG2fmrqkdKAA0TSL832Mmy7GnkZKSwN+GYbMUXQSbVDXrpyt5UrOS
 7KlIbIqLgVAzdKPMO1NcNK/yR0MaP79OdiWWCT5vma0ARuSjPvYYIP0dmA10CzDBU0AlA4Pu
 3CLKV56Tgq7ommWICFrHEDifwu4/OVjrXqpQ1McwAaNYElskbGy/0hRzd6VSO4ZlpEFsyYns
 DZ1VAK+wtjfI9mNvQxseONbe9xrpB9/3GXdsERUNJGmLug2nlcUfgJ2l1nj2xV+FsNLls186
 DsRzQ91L+q410lEfjXQiZD3ILjMAmr/5haib+jRwF6IlJ6056MO4bwcokrquAXhQmg/93Rul
 f1czHKY4r3LChATWNT/SBBzvz57rLbeazJ134rQ1G0kZa+1uTjG0slvHOIhywaIftJWP+WKD
 lm2W+ETAcmjLKQPklOqJkYINeZT+aocLcSgbuaLnqmxM7Ak1BKvimZG6YY14EKR/ixzArrI1
 pEHwviemBmHSj76g3+ut8n2ncZPYjREWiKFziLpHpIZRKRob4MKCi/6Ocq9y89iwZzkQWxd9
 V2LCUkL1YmnY0zWJ2bgxhZd0UBfgn2hlmPsyz1yjiEBp7Ca2C3I3vSkcwAIfHNIEi0qrVrtI
 o/8pNkAR1SlaRNhwBuu7G7+xq5GtOJ+JWyVSkBNKWy+EWh5U6+h/pWFecRO69t8viJNeOC9Z
 02KDL/3pl0R1Ca1WyN3wD0rfjemt4+xsBtghG+QMj4npXXeY819yAn34N3aWO4X3zADAiJ/j
 G+TTnO8Jdiy4dSdkd/ptfq4S3ioW5Jea2G/x4Sasjeh7GBlDAeXm/G1h82hEAI/lyT80o8uH
 R7WoRC0WYLr0am+Ne8vKlJ2CVnnw857HJxu1Io6gdcb3n1Mwt2y83sd2U3yLclc3+qqa3AMW
 SIMxfbV6QLs3kQlJ3Pfg8reWniRiuRobdOzcytC3S005cpDGY+X4aZCkC8zpUC3+0aZReV2l
 yxV5fZmzXcAiOEI8F4p0y6UGfYeEExRJyfsljyJ6cyzqONcY2P5NfCM1E17lMvpLLyGphpAQ
 uj8MsM+HSh15945MF/I1Gbv8IbhUN3Ra88D8BySjxrEyeNSLcR13sANiTBmNmW1g3w7yqZvl
 xtix5C1u86ZKnts1KO/HhNccDbyYpVXshTkhLxCk8De+4mpHZVmAC4XFM/tRPuyDD8U8/DuM
 QWOFycntl+fGLzCDUme7ltrqzTEFJX9czmyLWkYyNgqfhiFLVZTyFQRRjQil4Q1PgOn3srsd
 AF+/D9HohbEqhxJw/kgBRj6V2rFoQ6ubH9gVIqeKR9b9ARL4UH9KtGF46R/EncctrGosg2BY
 kWafQBJACldU02eA1HuMpGh4NDB966TAe/oa7P1YLCJr+UWafqU2Z+1mt99/jOLMMynMHd9C
 /l90UoVGThbFt7eljNHRyFfvSXXdNLT8BWx4Cp6qMy12PvsXw3r6M2EDL4EdZ1X4RmojKqFf
 82ZgCd2KDBV258NjSvQy7Eb3VETjSxjeziFHrMHuirACqnXn/kTRyUbYiJ3Oc1Ep4k81w9Bc
 ZrAitr00rN+gtY6DFBKUVGnkcasM4hCCmexLl7YTGKWMrLOcTTNz9v6fuC6RKFcgft8swC2v
 3CQExmndhaKkjTyHyuqOPtQxHWZNRlTo8emdx93FUDpVtXvZha8NZl8ijhghfUYh3jJfU0RN
 z5xf1IF+rGR5iAegfh5HWFN/1JvN+6Nly2e6q/TLZNA9bMhIC1xmvkSzTIYjfN/6z1YQ/lxl
 TqY5opMqlSria+lzSZ7Vx9KpydjpIuNpkhkAazD6p9NQ23E/QpL5mKVXVBC7f5sEMHuvehzj
 JD3mb7+MixP9Zicqc4VHdTVLoSfPWYsKwHkHhbTFgIOSTPtPmba0QgVqvad+2fdlpEn4r3rn
 pyPAutBU1M4DLUCA1lNF90eOpZnGDgjlOjfxOwF42H2hQnbQ8gS6pnXXPWfKfbiMjCUif9IZ
 E1MiZDxKYAefrPy30sqPlpklYDNM0ndR9ZApmtmdABi5A1v/XZwBk8020T+bQXltH0REv6yh
 Rkwoghze+Ig8HHr+VhhYhLhrTc5lEg30fDsmzGXeSW5eKy5QYhSCiyyskErM5XyWC58dwj0l
 kthYnOMbrRdlbZ/PUVskhPbv9MbEP1ESIVAYRkN1bSZYOgu3V1AqyKhg0hd6r2BQblrnwhiT
 peqoDoU2QNldMNzOqXWK4JCyl9NiuSPuSmvzaY6xwpIYw4o+XmZdSpAmEsMKrwvISzgqull8
 wePnxNDf2wQUvMspLRt7Exrf6yiyCLp1fZjJ0y7OvaQZ/ebvGjJk4iIT18621kHv0ZA9Llyl
 8wkdhzQH2QyzanZPgkGKNHeLklLaMwa2HXVYTTG5eHQwIAzM4i7CvLAQuqHtaJSiUWhSkJhM
 J4B4YwiBJ6l0AT4JN37KbcDgUEi/gnkJ1WtCPVPZQKFlyoBr8ijzZhxm45HKWdZSUt5Nj+27
 7CfiAYrhveHWNZ+NnkeWZEFP3RwVsS7nSNdu3VoBiOw2+4Szw3E5Dj58GCYNjDtJ/h+Zb/Af
 xFxCfm84zI2/6OxjBjc9ZCIYynBPtN+ppfl8+ocq5uBQ6dPR6N0tUvRnaFSXXujX2XIFJi+I
 J2mL8EGd9v9Bn29VxS+jS44VcH4OJ6uI7KOjAWgX4tKsYSElDQiLtP1QjsVHlJzqvsF6aY5a
 wAOb5Ayah2tswUlK4S1OgCR3t6pRiCmLj4AC7FvzPiwYPRzzmJ4fu6nwn8hZos3w+m+7QgGQ
 5Rcyln/weeqL6VEQC/2HWIVLwTDvzs+km9/Huk3y+Y7hhjPtA9YexKMb+whUGtFuts7CE6ca
 SF0Em05QlWbgKLA7xSq0rRU+DFSyZIc8+xfsTDduYTeZjvkDK6qqpLOmyktd94rp+t2K4O1Z
 oOjtYnZhTjWUtH6vwuIS2buEvBXnNVLCDlFW/QOknNzfYQ+tJZboW81X8szJPQbEKwor7yna
 hJ/EDUfiyQeUtXElB4Fj6+Y0qTAmxGbfdx2MhsJ9pFLncEQVSV7SjkTqK+qS8PdkGrSDiApK
 R0U9gBF+kojh5R9eumttJLFVpJc4yZbuf9kFCDZQN0gy1L4Q3qWgBDZV/yg27i13B1bzdr3z
 8IWHhV4DB4Zj8JLnUIzYIprIqIQ9trO9CSUfEj6lHrgzuS7OENWz8zEMVH1Ws6Nj3fnSSAY/
 TU3RIlAgCXbFJIPg0l0dKAiulRSCIm8f0L/4SE0gYNzEP+lVpbvj30lt3cdWyajFZJuDuxnt
 l/NEGluY4qqs4nkMpMUTWpd+ZuQsX9WlUxsN2iyzp8Kb4lp5SMNR3B3rDibp5PmTMpe2NQwF
 5IBJMxXsHDnGaxFPpXXqHoz7Pin737S+zkxtB+XwDG+AaqxSaoN+nUTMggtI2mEr0ApSeogt
 G7PpBSFlFF//+BfD6PHtUR+rzd7VsRIHjdG2nGjB1t2RXhC9e5dLfKRO+dcWfgpeRi3OxF2M
 fM82F3BqUp0h3bifytqtgYc/y3HWBgcXjIamLDwgXsTt5fjcRkTVZ9Fa30HJx3MLErPnylJs
 RtZQ0JnQZYUBpBC4b5NmcNx98bCQFilL2k+Rh1kNxwxyvNZ3RpGuUmUaAjZDAy1ZbDOuBgxd
 sCU+p2HNvP8qSpOkZzuqqgY/r8CR3S8kAvlFd3Xr4bmt92Dnk+Pcrrodei9amXGVz/CkVa7g
 rJyXMqCxDTaLAcOc8oy8nEje5W0TDeTZXyuRooeLktfDuVhbMle5/tdf4licboI/qlkAlSGQ
 AnuEcqhtqoONU7dEBLZKSjJ6emjucTL97WIROHgb9aNx3/vR6NxI4c87DjwAbDx1oFCvEHx3
 6Ql7Vt0HGDPKDvJt9H9PkUO7cimeFHlu8gkFDPfGpZwmVLpx0ddZ4wSQiaw948fxo8f43H1G
 qpjykamiORJ7PF/7JUvpbBkzcDhPaDJNfFTqlNqGDCQBwN35tMoAWNlQHtWbPNXI/DUFUgAp
 ebpre2/V6ke6RnOvvdcdcOCPEbZ3M+2FjCbTxVA2gYHsz8TaAWGhbaDnOdvRMCpqPKcuApl6
 kWiLhMA0LFm5JuVsquOqujNahLNzL8CEqH0T8L3p74otguc//oh3LIJf2V0ZUWgHo1/HoYQz
 2fp16EqxAooEsXeD/Tl+fVZUGk+kC6mkJd4Xh0XFv4SAbuX7NFGhG5r/o6RftYSc61EhiOOD
 Uv9SfldljjytnfReTk/0XSsm1nqTGi+7UH7t3p9SCrIlJL4l1ZNE6KwHQFUVjaoPklxtHWOO
 hDpvZz5o/dQjgl+P2r6udaKjGbkNqlQGpi1KdWcKDM1pFs/iJw3W8zp3IEQA92mJ9kNtnp5a
 7GNjgHj2z8EuKpBi4fEt4uY8/XeB3ighoWeqrOQ1HZdy3Miuko45MzmPfbLrY7vIbzgxyMaS
 CFxvBHEVhi+p+nArlwaDkeM1V/ChI0AOtwxMWAQ7kj9/6BjRdsy8F4bDYPcf7YZoii1PjLow
 FGZatZxVy+E0jIREEinWVV/HaE93ir3sqer3T/d8l0hXIhwfmTjhBpqH8M9KEk370MQzDZFG
 g8IIRyWF7CnA035IJBMDBNFNkvBheXmPP5nhwV62dbNrKfLYPZ5BrYRO/oVlQOIkFVBW9oXv
 aAYXLNgagpY/a/TqBLlDtuvVPznmHwscPytF5kBt59G8SJ/vkDmF0DzjPULp6wWg52JaKNeN
 J3FvcQnqlxi+SZKbStVxh52kxK+V+kY4uHl+NnS9pSyuYPMHO4gQfsa8x8sCiFwlZz11Rouq
 NHezeZcQ6XRiILi4EZIInWQv53d3QU6Iu0LYdHOHv4o5zAcKi4SKmhbd9efa/Am4i9kGDHS4
 UFSRMYNbskfJ83DhUZfjUijC9QxvoLLX1SfDYl0bcUh6WH6nSs0/ZULWeHl8DaqJJrb4gIFL
 7ZZgS5rjt6HuPkNzK+YFn0M+XfAIUsQoGvK29yXBv335+nJ1NzESwZMAHstS4kEbDuapV7+H
 azqy9OwD1/Ss5+pyNc3cEbaLpCotJwMqb0EUetJiyGgmyNbCpiwnPWN9dyl9GpQsFRDVod19
 xzMXqtFbN13PhHxl8/jQUYZZGO3YMbPah8no/ab3M8I4uNjJw37ZIQBJQkDxa684n1QBgdjU
 7/5uF+FUPlZPYAgF6yC9y0Jr9swcecGJz3/7NTyoy1NqUwqDQNhc7I2ojFANwHPkABTR6foq
 esAhw8bApZyvU5BH371OXprvmGBCvsT1fTNTqVFqGb2LORGSUhjPyJgTgng3Zxvf+DshvVbq
 iZdmTs7pvE20jtgTR/6uCv2pqtL1yhzndPw/DgHp3FBSf2T1inSDlAWhvkDja4GCnbrwVi9Z
 mQTKo7z66NgPsPu6c8q5HF1MnBBN2UWGP+tDS39lfbCGouUrNdVnwKAou3KbLmuPW4XN78nz
 gnkSWQ72Q/b1kUNkiNDUnCr69kqI5+4MMAuy3+zGGTVQ10L57tArMr7sVNYBPtzc15qx39vl
 9SWXiBYDtKaAH4710J3DAcMOIIG8xIRELMkxyqFrrUTtB9Bey/aS8yk4tWCxJyOhiZ7FIo2g
 DuG/OXAj5cumhWNevtw7yiTqDIXdufCVNRrDGS13YBam7WWjxCFtuEBVZsgzbWqSvgZNce/v
 2Cx3ccyMqdK7rAfGUepduoCza3cSCCrVSuTXuHZKgCx
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:yX6c5a4lDZiabMTitwPXwPLXdLJyesId70hD6qm+c20yTiX+rb
 HMoB1773/JYFR4YhsdcLW7VZVoLkmyyXcY2+Us1PKZLW3bUQiTTb2Kk7GSoQEIcheWnoVgPO
 VbAs1D4bbLY2SS4/yKhzVQa+xQueW6zA==
X-Talos-CUID: 9a23:GnA0B29stKNbyVLhYRaVv0UVNcoKU0f78FPRAWjgGyE2Ubq/Y1DFrQ==
X-Talos-MUID: 9a23:WCC79gUs/WLqFhfq/G7jiHJTH8pr2aCzA1sOzrg5m5XDbSMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="101771123"
X-MGA-submission: =?us-ascii?q?MDHk8+LgLvzJtLHvLM3u2KtrPjsUa8MUYVNlxa?=
 =?us-ascii?q?Du5fgY9atJw5w5QGsJZvVxZHlmuvBvoub4D4yYe9pZl1ppXqw1MS9wcF?=
 =?us-ascii?q?OCwHIt8m2YHspElMKkrP72HrinYt8ROnfEvnNS42JoEarA5V8Qvmipzp?=
 =?us-ascii?q?XnVsVdeIwiPX6ft2aR/C+lGw=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 15 Nov 2024 22:26:44 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id CEC70206BCF9;
	Fri, 15 Nov 2024 13:26:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CEC70206BCF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731706002;
	bh=2qNmVTIUPIQHjxG6U+oz3oOJorUpDTvltiEua1kgDGM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iVvLyPnzqMDnIVqCr8TaID7h6/EcvZ4uGITdugla/Mpc21N0a+zSOXosYGRpfd2vu
	 d1MyMoy9U+Z9sd1VeqqtG/myJ7CKMnsPLRLQ8NuKd0YjVEIqU9hZB6KsELpQ9xGs8R
	 v7zo22n2+S5uyzdobRgvEalMR5SyEYAxTB4IIGU8=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:26:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v2-4-911fb7595e79@linux.microsoft.com>
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
In-Reply-To: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, 
 Nicolas Palix <nicolas.palix@imag.fr>, Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 Russell King <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Ofir Bitton <obitton@habana.ai>, 
 Oded Gabbay <ogabbay@kernel.org>, 
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jeroen de Borst <jeroendb@google.com>, 
 Praveen Kaligineedi <pkaligineedi@google.com>, 
 Shailend Chand <shailend@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 James Smart <james.smart@broadcom.com>, 
 Dick Kennedy <dick.kennedy@broadcom.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 =?utf-8?q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Jens Axboe <axboe@kernel.dk>, Kalle Valo <kvalo@kernel.org>, 
 Jeff Johnson <jjohnson@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Jack Wang <jinpu.wang@cloud.ionos.com>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 Louis Peens <louis.peens@corigine.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, cocci@inria.fr, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org, 
 linux-block@vger.kernel.org, linux-wireless@vger.kernel.org, 
 ath11k@lists.infradead.org, linux-mm@kvack.org, 
 linux-bluetooth@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-rpi-kernel@lists.infradead.org, ceph-devel@vger.kernel.org, 
 live-patching@vger.kernel.org, linux-sound@vger.kernel.org, 
 etnaviv@lists.freedesktop.org, oss-drivers@corigine.com, 
 linuxppc-dev@lists.ozlabs.org, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v2 04/21] s390: kernel: Convert timeouts to use
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2031
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v2-4-911fb7595e79%40linux.microsoft.com>

Changes made with the following Coccinelle rules:

@@ constant C; @@

- msecs_to_jiffies(C * 1000)
+ secs_to_jiffies(C)

@@ constant C; @@

- msecs_to_jiffies(C * MSEC_PER_SEC)
+ secs_to_jiffies(C)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 arch/s390/kernel/lgr.c      | 3 ++-
 arch/s390/kernel/time.c     | 4 ++--
 arch/s390/kernel/topology.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kernel/lgr.c b/arch/s390/kernel/lgr.c
index 6652e54cf3db9fbdd8cfb06f8a0dc1d4c05ae7d7..68021cb38574b122bbe3d9f70e9168305360017b 100644
--- a/arch/s390/kernel/lgr.c
+++ b/arch/s390/kernel/lgr.c
@@ -166,7 +166,8 @@ static struct timer_list lgr_timer;
  */
 static void lgr_timer_set(void)
 {
-	mod_timer(&lgr_timer, jiffies + msecs_to_jiffies(LGR_TIMER_INTERVAL_SECS * MSEC_PER_SEC));
+	mod_timer(&lgr_timer,
+		  jiffies + secs_to_jiffies(LGR_TIMER_INTERVAL_SECS));
 }
 
 /*
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index b713effe057967623f64da8297314fcc42ff1af2..e28c61d39d27c6e89f490e779ff674ba2fe21d3e 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -656,12 +656,12 @@ static void stp_check_leap(void)
 		if (ret < 0)
 			pr_err("failed to set leap second flags\n");
 		/* arm Timer to clear leap second flags */
-		mod_timer(&stp_timer, jiffies + msecs_to_jiffies(14400 * MSEC_PER_SEC));
+		mod_timer(&stp_timer, jiffies + secs_to_jiffies(14400));
 	} else {
 		/* The day the leap second is scheduled for hasn't been reached. Retry
 		 * in one hour.
 		 */
-		mod_timer(&stp_timer, jiffies + msecs_to_jiffies(3600 * MSEC_PER_SEC));
+		mod_timer(&stp_timer, jiffies + secs_to_jiffies(3600));
 	}
 }
 
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 813e5da9a9737e05ec3ef85a495fe38cbb40c49b..99095ff3897c1b5337f7e2abcf10f3fe8219ad7c 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -370,7 +370,7 @@ static void set_topology_timer(void)
 	if (atomic_add_unless(&topology_poll, -1, 0))
 		mod_timer(&topology_timer, jiffies + msecs_to_jiffies(100));
 	else
-		mod_timer(&topology_timer, jiffies + msecs_to_jiffies(60 * MSEC_PER_SEC));
+		mod_timer(&topology_timer, jiffies + secs_to_jiffies(60));
 }
 
 void topology_expect_change(void)

-- 
2.34.1

