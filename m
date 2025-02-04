Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8821C02193
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2025 16:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:cc:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qsQ3qC5Tpg63dCD7/jZT/AEnIALZtLkxfeA7sZPfYvI=;
  b=rUIK/sjhS4cOefTj8ZYFmfOlRFy24fU4lVgEDXBNXTlL9z/bRuhCKs7U
   Upg8iscFSwjQPQrW0jOITYQmHpbdXaGbsMf9iYmA54w9q9JE0vys3gvOU
   vmAqDu3fWKHegAdff/T7py2WWDBL45KBRt9Wn47z6iE2uEoPjMPIs2ksv
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@linux.microsoft.com
X-IronPort-AV: E=Sophos;i="6.13,258,1732575600"; 
   d="scan'208";a="206575179"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Feb 2025 17:20:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 44D62E0D1D; Tue,  4 Feb 2025 17:20:22 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9CA92E0260
	for <cocci@sympa.inria.fr>; Tue,  4 Feb 2025 17:20:20 +0100 (CET)
IronPort-SDR: 67a23e44_dK8F00y8lNVhBiUxmjTLxxyDRzWwW4WZv2fUDYqVZvc3Xqg
 NB5SLV8KcbUJfHwZQIvFdjcls33gkvo7G3NIiyQ==
X-IPAS-Result: =?us-ascii?q?A0EJAABUPaJncraaTQ1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFBAwEBAQELAYJDgVczBwhIhFaRcxOLYJIjgUA+DwEDAU4BA?=
 =?us-ascii?q?gQBAQMEhHYKAop9Ah8GAQQyBw4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAGBDIV7DYJiAYEkUQ1IAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBE?=
 =?us-ascii?q?QINXgEBHgEBAQMREh0BATcBDwsYAgImAgJWBhUBAYJ+gmUGAp80AYdgAQECi?=
 =?us-ascii?q?yOBMoEBggwBAQbcH4FlCYEaLgGITQGFa4R3JxuBSUSBPA6CdT6EWINGgmmCM?=
 =?us-ascii?q?4Fxg0CibFJ7HANZLAFVExcLBwWBKUgDgREjgSYFNQo3OoINaUk6Ag0CNYIef?=
 =?us-ascii?q?IEdgQ5rBAWBLYI7hEOEToVeghKBXwMDFhABgyV6HINLHUACAQttPTcJCxtDn?=
 =?us-ascii?q?naHX5ZzAY4Ta6EEhCWhSwYPBC+DcQGTZpJ7LodkkGqofYIfDSaBXEYHIxWDI?=
 =?us-ascii?q?k8DGQ+OITiDQshUIjU8AgcLAQEDCYVGAQGKa4FLAQE?=
IronPort-PHdr: A9a23:TMvM9BejWheC639FrpMWlqZXlGM+39fLVj580XLHo4xHfqnrxZn+J
 kuXvawr0ASTG92DoKgc2rSe8/i5HzBbuNDZ6DFKWacPfiFGoP1VpTBoONSCB0z/IayiRA0BN
 +MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBke3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55I
 AmroQnLucQbj5VuJrwtxhfVrXdEZfhayGdpKFmOmxrw+tq88IRs/ilepv4t7dJMXbn/c68lU
 bFWETMqPnw668HsqRTNVwyD6GcCXG4LiBRIGQ/F7B/7Xpf1rCT3s/d21TeZM8PrU706QCyu4
 Kh3RhDmjicHLCM5/3rMisNslqJboQmuqAJ5zoXJfYyaLvt+fqfafdMHWWpMW9taWiJdDo+ga
 YYEEvEMNvhEoYbju1QOrAO+BQiyC+Pp1j9InWL90akj3+g8DQ3KwAksEtQTu3rWsdr1Lr8fX
 +O7wqbHwzrOce5Y1ynz6IbIcB8uvf6CUKlsccfT00QjCx/JgkuSpIHjIjib1v4Ns2+e7+d4W
 uygkXUnqg9rrTi128wiiJPGhpgUylDE7yp52pw6JdulQ0N8f9GrCptQuDuAN4t3QsMtWXplu
 CI7yr0ApJ66czIGyJEmxxHDcfyHdJOI4hXtVOaNOzt3mHVleLemihu07EOvxfHyWNOu31ZWs
 ipKjMPMtnYV2hHS9MWKV+dw8luj1DuM1A3d5ONJL047mKbHJJMt36I9mJUTvEnMESL7mlj6g
 LGKe0gr9OWl5Ofqb7bmqJGcK4N5jBz1PKc2msGnHOg1PBICUmqZ9OimybHu/UL0TK9XgvA1j
 KXVqI7WKdgBqqKnDQJY05wv5wujAzu8zdgUg2ULIVRYcx+Zi4jpJkrOIOzmAvelnlqskTZqy
 O7eM7H9BJjGM2LNn637fbln7k5R0Aozws5b55JTErwBJPPzWknstN3XFBM5Ng20zPr9CNV6z
 YMeXmyPArODPKzOtl+I4/ojI+iKZIALpDbwM+Up6vD0gXI7m1IRZ7Sl0JsYZXyiA/hrIFuVb
 WLpgtgbEGcKugQ+TPbtiF2HSTNceWy9X6Im6TEhCYKmDZ3MS5upgLyA2ie7A5JXanpDClCND
 XjobYKEW+wLaCKcPs9tiCALVb+kS4M50xGhrxf1y6B7IerM5i0YqZXj2cBr6+HLjxE96SR0D
 9iB02GKV2x0mnkHRjEs06B7pUxw0VaC0al9g/NDD9xc/elFUgY8NZ7Gzux1Ecr+WgzbftuRU
 lapXs2mAS0tTtI229IBf0F9FMm+gRDCxCeqGL8Ul7mTBJMu6K7c3n7xJ9x8y3nczqUhgUMmE
 YNzMjiDj7R86hObKorHiUSfmO7+UK0G3zPWskqHw3CPuk5wTwN6F6nICyMxfEzT+Pnw/VzLV
 feOAK4mMgJbwMjKfqZDatTzjFVPbPPiPsnOJWewkH23HhGG2vWHa4+8KDZV5znUFEVRy1Nbx
 n2BLwVrQ375+wo2bRRrHFPrOQb39PVm7Wm8RQkyxh2LaEto0/y0/AQUjLqSUaBbxaoK7QEmr
 Tg8B1Ohx5TOEdPVqgNhdb9dYdoV5FZByHKfsg12JJu7KK5+wFUZdlc/pFvggi1+EZ4Iis02t
 DUvxQt2J7if1QZMfjORx5HwM5XTK2/v7FaqaqXM3UrZ3srQ8aAKu7wjs1u2hAiyDQI59ml/l
 dlY13zJ/pLREA8bSo78SG4z9h5nt/ffYyIn4JjT22EqOq6x2tPb8/QuAuZtihOpftMFdbiBC
 Be3CcoRQc6nNO0tnVGtKBMCJuFbsqAubYugcLOd1ainMfwF/nruhHlb4I17zkOH9jZtAu/O0
 ZEfxviE3wyBHz7ihValu8rzlMhKfzYXVma4zCHlAsZWaMgQNc4GAGenOcy3z/16hpjwSzhd9
 VW5AEgB1tPvch2XLhT80QBWyUULsCm/gyLrql482zotr6eZwGnP27G7L1xYZSgSGTUk1Ae2c
 u3Wx5gAUUOlbhYkjk6g7Ef+ne1AobhnanPUSgFOdjT3KGdrVu2xsKCDaohB8sBN020fXeKib
 FSdUrO4rQEd1napEmJezSo6dziCvpT/ggw8jWOWNnFoq3TFP8p3wF2Mgb6UDe4UxTcASCRi3
 HPaD1i1Jdip9P2QlpHeoqa7Vmm7UYZUfzWtxoSF/njehyUiEVi0mPa9ncfiGA4x3Hrg1tVkY
 i7PqQ71fojh06nS3ftPRkBzHxe87sN7Hts7iY4snNQK3nNcgJyJ/H0BmGO1MNNB2Ku4YmBfD
 TIMxtfU5kDi1igBZjqEzoLwTHSdy+NlZt+nciUT2ykn6NtNBrvS57tB1Sd4uVu3qwvNbOM1x
 2xblqRosSNGxbhZ4kIk1UD/SvgKEFNdPDDwmhjA9N24oKhNJS6ufbW2yEtijIWkBbCGrBtbX
 SWxcZMjEClsq8RnZQuXliKsrNi5JJ+JPYhA03/c2w3NhOVUNp8rw/8DhC49fHn4oWVg0ekwy
 xpnwZC9uoGDbWRr5qOwRBBCZViXL4se/C/giaFGk4OYxYeqS99sEzUCRproRNqsETQPpbLiN
 g2UFyY7pGvdEr3aV1z6ig8uvzfUHpanOmvCbnQQzdx4RRmUDEhehh0EGjA7lYQ+DQek2Irqd
 0IztVVzrhbo7xBLzOxvLRz2VGzS8RypZjkDQ5+aNBNK7wtG6hSdIYmE4+l0BS0d4oy5oVnHN
 DmAfwoRRzJsOATMFxX5M7Kp/9WF7+WIGr/0Ma7VebvX4e1GC6XRntTwjc0/omrKb5XVdjxrC
 /lxsqZadUhwAN+R2zAGSihN0jnIc9bevhC3vCt+ssG49v3vHgPp/4qGTbVIY51j/BW/gKHLM
 OD15m4xMTFDypYF3mPF0pAb3VgPm2drdjK3Fq8HuzKLR6XV0qNaFB8UbSpvOdAAtvl6gVYLY
 JOHzIqljPZxlZtXQx9dWEbkm921aMBCOGy7OF7dRQ6KOLmAOTzX0pT3bKe7GvVbiORZsQH1u
 C7OShSlYWvFzmS1EUn/a7Ip7mnTJhFVtYCjfww4DGHiSIijcRinKJptijZwx7Qoh3TMPGpaM
 D5mckoLoKfDiEEQyvh5BWFF6WJoaOeenCPMpeTRKp8MsPtiKiB1kf9KpnE7wKFS9yZKWLp+n
 y6Y/bsM6xm21/KCzDZqSk8EsjFQmIeCpllvI43d959dSTDB/RkX6n6XBQhMrNxgQI6K2egY2
 p3Ek6T9Ly1H+tTf8J4HBsTaH8mANWIoLRvjHDOHRBtAVzOgMnvTwlBMiPzHvGPAtYA089K//
 fhGAq8eTlE+EekWT1hoDMBXaokiRSsqyPaalJJavCH480aXHZgG+MmXDLrXCPHrYl5xYpFAZ
 h0V0fX9LI8JMZb81VAkYV5/zt2i86v4WdFLvz0naw4/ukJW93ZiCGY03hC8AutIyHsSE+Ok2
 Bs3gRF5euMj6HHn5FJlfjL3
IronPort-Data: A9a23:BPqA3KkKOldid+SWvFN84oDo5gwbIkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xJMWGiFPa6DYTH8fNklbIS/9U0HucLUy9JkSQI//3xhQVtH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvymTrSs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82Ayazl8B56r8ks14ayo4G9A5zTSWNgS1LPgvylNZH4gDfrpR5fIatE8NvK3Q
 e/F0Ia48gvxl/v6Io7Nfh7TKyXmc5aKVeS8oiI+t5uK3nCukhcPPpMTb5LwX6v4ZwKhxLidw
 P0V3XC5pJxA0qfkwIzxWDEAe81y0DEvFBYq7hFTvOTKp3AqfUcAzN1ELVE7AaIX+NxvLl1/5
 /gXFBITPzOc0rfeLLKTEoGAh+wnLc/2LMUau3p6yireA+pgSpfGK0nIzYYDmmhvwJkTQbCHN
 5BxhTlHNHwsZzVCM1ceEpM+lc+sh3/iY3tdqVmPorEw7XSVxwt0uFToGICNJIHVGJwKwy50o
 ErE8n/1WAs4OebClyaf9nyHlLH3vXvSDdd6+LqQraUw3AL7KnYoIBkfSlK/pdGri0u0QdsZK
 koO+yNoo7Ja3EesRdL8dwappWaN+B8aQdtZVeMggDxh0YLQ4gCEFi4BTzVbb8chutNwTjsvv
 rOUoz/3LRZOoLCpZn2fzK+7kQKgPScpD3FTRjBRGGPp/OLfiI00ixvOSPNqH6i0ksD5FFnML
 9ai83lWa1I70pFj6kmrwW0rlQ5AsXQgc+LYzgHWWH+1qAZ4b5SifIum9R7Q6vMowGelorup4
 iZsdyu2tblm4XSxeMqlG71l8FaBvKftDdEkqQQzd6TNDhz0k5JZQahe4StlOGBiOdsedDnib
 Sf74FwKtMELYybyMPMmO+pd7vjGK4CwRLwJsdiEP7JzjmRZKl/YoUmCmGbMgT+wyBRyzcnTx
 7/CKZn0VydDYUiY8NZGb7xGi+N0rszP7WbSTor81BOpzfKVY2SNIYrpw3PfBt3VGJis/l6Pm
 /4BbJTi9vmqeLSiCsUh2ddPdQhSRZX6bLiqw/Fqmhmre1E3RD55VKSBntvMueVNxsxoqwsBx
 VnlMmcw9bY1rSSvxdyiMyg7NuHcTtxkoGglPCchG1+t1jJxKcys9aoTPd9/N7Uu6OUpn7Y+Q
 ugnavewJK1Fag3G3DABMrj7johpLyqwiSy0YiGKXTkYfrxbfTLvxOPKRAXU2RM1PnKFjvdm+
 7yE/SHHcKUHXDVnXZr3aurw7lafvko9ueNVXmnTK+YOIUjHrZRjFArghKQRPfMKEAjynGqG9
 geJACU3ofvGjJ81/eLo24GFjdaNOMlvEnVKG1L06e6NChDb2W6406psbf2tfw2BZFjr+a6nW
 /pZ/8v8PNIDglxOlYh2SJRv8o4T+PrtoOV84jl/PXCWcWmuNKxsEkOG0eZLqKdJ4L1T4imye
 0CX/+hlKae7A9zkHHERNTgaQLy6j99MoQbr7NMxPEnezw109uDeUUxtYj+9uBYEJ75xaI4Y0
 eMtvfAN0DOGiz0oD82nix5F/GHdP10CVKQa7qshOrHJsTZy6F9+Ys37MBTUsbWvcNRHN3c4L
 gCE3JTig6tu/WucUn4RO0WU489jq8UghBR4wmUGBWy1ofvep/pu3BRu4TU9FQtU6RNc0tNMA
 GtgNmwrBKCe5z1uupRnWjm0KlpjGhbDq0n94AYLnjeBTm2DdG/EHEsiM8mjoWEb9GN9eGBA3
 be6kWzKbxfjTPvT7AATB3F3juPFdsNg0DHClOSMPdW3L7NjbRXL2qaRNHc18T35CsYPtWj7j
 OhN/tcoT5bkNCQV8pYJO6PD2Zs+EBm7dXF/G9d/96Y0HEbZSjG4+R6KD2uTIsptBfj7wXWUO
 vxUBPBkdkqBjX6VjzUhG6QzDad+n6cp6Po8a7rbHzM6nIXFnAV5kqD713bYv3AqceVMgMxmC
 4L2dhC+KEKyq0ZQuVfwqJhjBjLlT/gCPBbxzcKkwtUvTpgjitxhQWs287mzvkiWDjdZwgKpj
 FvDSZP7n+1G4qZwrrToCZRGVlmVK8usdeGm8zKTktVpbPHUOPiT7g4+90XuACJHN+A3ReZxr
 Km86o/r/ULavYQZV3LStImBGpJou+SzfrtzGeDmIEZKmRCtXJfX3CIC3GSjO7llrch45PT7d
 zCnacC1S8EZa+1dyFJRdSJaNRQXUIbzUYvNugK/qK6qJiUG8AmaMu6iy2DlXVtbegAMJZf6L
 A3+4NSqx9JAqbVzFA02PO5nD7B4MW3cd/MfLfOpjgahD06snl+mkZnhn0B56Tj0V1+1IPyj6
 pfBHhXDZBC+vZ/T9+5gsqtwgwY2CUhsiuxhb2Mf/N9L0wqBNlAkFthEE5s6CcBzqBfQhaHIP
 GSHKCNoDCjmRj1LfCnt+NmpDE/VGuUKPcy/PTAzuV+dbyCtHo6bHb997WFa7mxrfif4hvSSQ
 T3EFqYc4jDqqn2oeQoS2hB/qeNmwO7KgHcJ8lr6iMv8H1AVBrBiOLlJAl9WTSKeey3SvByjG
 IT3bTksrIKHpYrZFcdmZm4THRASpjT0yDs0KyyIxb4zfq2FmfZYxqSX1/7bi9U+gQdjGFLKb
 Xf2QXadpWWX0WYUoqwnp5Qihqoc5Tdn2CSlBPeLeDD+VJ1cJojq0w3uUMbPoAwfFNZjLm7g
IronPort-HdrOrdr: A9a23:Y+3+GaNyXE6eC8BcTvGjsMiBIKoaSvp037Dk7SBMoG9uA6ulfq
 eV7YwmPH7P+U8ssBNJo7q90cy7LE80mqQb3WB8B8bHYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 xdmupFebjN5DNB/KXHCWeDYrQdKZW8kZyVuQ==
X-Talos-CUID: 9a23:7AxsY21Zb81mb6EL6LBKuLxfMOE1f0Hyw3XqO2CEOHRtR4G3Vw6z5/Yx
X-Talos-MUID: 9a23:h9waQQu3eeBCZmZ5ac2nhjx5OJ1ywamUVR4Ri5EIkNvaDQwoEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,258,1732575600"; 
   d="scan'208";a="206575175"
X-MGA-submission: =?us-ascii?q?MDFzaZCW9nwLDZmZIGfArDs6jgfXQ1pUalHYk/?=
 =?us-ascii?q?IhPcjsoi7mPPAk098dDG2RyFqjQlKfz8gLNmdrBz0XVdzs2gxk81kVEI?=
 =?us-ascii?q?29bT6dH39h71xiqJXiPVXCQVvSM3HhxFHtoYntgYlDRNradb4/wAaP6L?=
 =?us-ascii?q?msZNDTpV1TuXm935X3Tnbm0w=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 04 Feb 2025 17:20:19 +0100
Received: from [100.65.217.97] (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id A1B222054913;
	Tue,  4 Feb 2025 08:20:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A1B222054913
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738686017;
	bh=qsQ3qC5Tpg63dCD7/jZT/AEnIALZtLkxfeA7sZPfYvI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=JFNqQ3WMJYt9x5FlRLFXv9KHyV1pKDlzhODb53QoWzpp6J3AdAjnkgoFXzX5upaKS
	 NFB7RQX/lTZhUgAoDftbhFMBWRFjJJRgsKy9ZaQziRTcbj53IbbgDHyBHFcvhpmjTi
	 8Sj+Z0cZpDnm8hl7T3Q2wnghxJwrjTRbik8PdIpE=
Message-ID: <974a03d2-3f3f-4be2-9dba-ece6dca8015e@linux.microsoft.com>
Date: Tue, 4 Feb 2025 08:20:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cocci@inria.fr, Andrew Morton <akpm@linux-foundation.org>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>,
 Ilya Dryomov <idryomov@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Ricardo Ribalda <ribalda@chromium.org>, Xiubo Li <xiubli@redhat.com>,
 eahariha@linux.microsoft.com, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org, ceph-devel@vger.kernel.org,
 linux-block@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
References: <20250203-converge-secs-to-jiffies-part-two-v2-0-d7058a01fd0e@linux.microsoft.com>
 <20250203-converge-secs-to-jiffies-part-two-v2-1-d7058a01fd0e@linux.microsoft.com>
 <49533960-e437-4042-951a-0221164bfa3d@web.de>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <49533960-e437-4042-951a-0221164bfa3d@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] [PATCH v2 1/3] coccinelle: misc: secs_to_jiffies: Patch
 expressions too
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2342
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/974a03d2-3f3f-4be2-9dba-ece6dca8015e%40linux.microsoft.com>

On 2/3/2025 11:56 PM, Markus Elfring wrote:
>> Teach the script to suggest conversions for timeout patterns where the
>> arguments to msecs_to_jiffies() are expressions as well.
> How do you imagine that the shown SmPL code fits ever to patch reviews?

By the simple fact of accomplishing the same result despite differences in
code style, as explicitly called out in the changelog.

- Easwar (he/him)
