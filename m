Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB13C433F5
	for <cocci@archiver.kernel.org>; Fri,  1 Apr 2022 20:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=oONlkVbXzQ/THoU/WcE133F/FhfwIz8wEygpv7tEk0A=;
  b=IdAq/kl9ZM98SrCSiMxj2Kksqaai5LMXRMAQ59B46sQdQfShYjEpN38r
   rGReJsxeJTRWnpoxlOlikKpnsSfr3TayFsQASW8d15eNDfAEMR/gTDFQ+
   496SbNRodwsTxA8w3TMAHURwpMruhSptotY/uJMRtlchQPgUkFAQb8xO8
   8=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.90,228,1643670000"; 
   d="scan'208";a="29630226"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Apr 2022 22:20:41 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 848C9E00A8; Fri,  1 Apr 2022 22:20:41 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4195DE00A8
	for <cocci@sympa.inria.fr>; Fri,  1 Apr 2022 22:20:40 +0200 (CEST)
IronPort-SDR: jZEHvsrJyS5VqiytZADcLVCoZL8+cVN+lesN+hCKMzrefXFt1NBrULxaqOWPIvngZNcZCnl2s+
 V0M6oaI4LTDR58/4LBF3X753I7xo2FQ74v+iXFUMDF2IhB+h8zhe9CfhQrGsr72k8vKfH4pF64
 HYUtXCoO9oYREaRwOhHHY/ZrTyhmt2+NyI5rXWCic6iEwKtAd5Jr8BgBogS1AB3crre8UBvoYa
 yflkmz0zQfYieKZWfjjEwX6jW9pFo9TLW3GEWssrttesbfYVU7eHFyY9dJaipO7aIDtnn7GutK
 0miadBcfb+dQvElIdHakl7mg
X-IPAS-Result: =?us-ascii?q?A0COAwA6Xkdi/0Xcza1agQmBWoIoB3dWAQEBKQQLlAuCJ?=
 =?us-ascii?q?QOcZoF8CwEDAQ0zEAQBAYUHAoRaAh0GBjAJDgECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgQEAYEILAFjAWcBgU4BgXkGBDANgjUpAYNjAQEBAQIBOj8QC?=
 =?us-ascii?q?xguVwaDFwGCdSGvJ3iBM4EBg08BhiYGgTyOTiccQIFNgTwMgnc+gmMChz0iB?=
 =?us-ascii?q?JlHgQITAStxFIEaWKAIghWeHINTixSUUgYULpZRkX2WXopMgkyZc4E/IjyBW?=
 =?us-ascii?q?R8UGggmCjuCak0BAgECAQwBAgIBAgECAQIBCAEBAgGOU4M7in4hAQEBaQIGC?=
 =?us-ascii?q?wEBAwmRYAEB?=
IronPort-PHdr: A9a23:upfN1x8XTLfrqv9uWZy3ngc9DxPPW53KNwIYoqAql6hJOvz6uci4Z
 gqGu6sm1QOWFazgqNt8w9LMtK7hXWFSqb2gi1slNKJ2ahkelM8NlBYhCsPWQWfyLfrtcjBoV
 J8aDAwt8H60K1VaF9jjbFPOvHKy8SQSGhLiPgZpO+j5AIHfg9qp2+yo5pHeYgRFiDWgbb59L
 hi9sBncuNQRjYZ+MKg61wHHomFPe+RYxGNoIUyckhPh7cqu/5Bt7jpdtes5+8FPTav1caI4T
 adFDDs9KGA6+NfrtRjYQgSR4HYXT3gbnQBJAwjB6xH6Q4vxvy7nvedzxCWWIcv7Rq0vVD+88
 6lkVgPniCYfNz447m7XjNBwjLlGqx6lvhBz3pLYbJ2QOPd4Y6jTf84VRXBZU8hfVyJPHJ6yY
 IkMAeoPMulXs5Lwp0cSoRakGQWgGP/jxiFOi3Tr3aM6yeMhEQTe0QIvBdIOsWjbp8j1O6cST
 ++60q3IwivZb/hL3jry9I/IfQw9rvGNRr9wdcvRyVIzFwPelFmft4LkPzOL2esTt2iU8fBgW
 fipi2E5twF8uz6izdojhYfVnIwa0EzE9Tlnz4YvI921UFJ2bNy6HJZNtyyUOYR4T98tTW9np
 Co3yrMIt560cSUXxpkq2hrSZuKZf4WV7BztVPicLDd5iXxlZL6ygwq+/Famx+bhWMe011NKo
 TBEktnKrn0N2B3T6tSHSvtg5UitwyqA1wfW6uxCPEs6lrLbJoY8zrMymJcfq1rPEjP2lUnsk
 qOaaFko9vKp5unjZLjtu4WSOJVuig7kN6Qjgsy/Dvo8MggJR2Wb/Ou92Kf98kz3QLVFkOM5k
 q3Hv5DAP8gboLC2AxNN3oYi7RawESum3cwFkXQFIl9JYgyLg5TpNl3UPvz0E+uzj06tnTpv3
 /zGO6fuApTJLnjNirfherN95lZAxwo00d9Q+5NUB6oFIPLyQU/xqMfYAgUnPA26w+boFsty1
 ocAVmKVGKOZNr3dsUOQ6uIpOOaDfJUVtyrlK/g5+/7uimc0lUEFcamzwZQXcGy4HuhhI0iBf
 XXshcsOHnsLvgclV+zriFiCUSZJaHqoXqI84Cs7CIO8AovZSICtmqSN3D2nEZ1OemBGFleMH
 G/sd4qeVfYDciaSIst6nz0FVLihTpQu1Qu0uwPgyrpnKPDU+iwCup752th1/b6bqRZn1yFwD
 s3V92iSRmVw1jcKWjs31eZ7qFN0zlOr0K5igvUeG8YFtN1TVQJvGITdxKRFC93/Xg/bNoOCT
 12tQ/2iACotVZQ83N8DbkJwAZOkgwyVjHniOKMci7HeXM98yanbxXWkYp8lkx4utYEkhlgiG
 Y5UMHG+w7V4707VDpLIlEOQk+Crc74d1WjD7jTL1nKA6WdfVgM4SqDZRTYHfEKDptPy7ULqS
 761Fa9hPxRBxMOGJ7EMbND13h1dXPm2HtPYbiqqnnuoQxOBx7eCdo3vLm4a1y7cIEwFiBwIu
 3uZNQUzAiq75WTTEG8mDkrhNmXr9+Q2s3anVgk0wgWNOlVmzKaw8wUJiOa0TuNV060EtSolp
 i8yGluhtz7PI/yHoQcpPKBVYNdmpUxCyXqcrAtleJqpM6FlgFcaNQVxpULnkRttWM1GloAxo
 XUmwRAXS+rQ2U5ddz6ewZH7O6HGYmj08he1bqfK21bYmN+I86YL4f48ph3tpgasXkYl9nxm1
 ZFS3R7+rt3BCwEZULr1U10r7F53uLHXby0w/cXS2GEteai4vzne2s44UfM/w0XFHZ8XO6eFG
 QnuVswCUpHxc6pwwwXvNEhcer4Dp8tWd4u8evCL2bCmJrNllTOi1iFc5Zxll1mL72x6Q/LJ2
 JAMx7eZ2BGGXnHylgTE0Ii/lIZaaDUVBmf6xzLjAdsbbap5docjDWa1P9bxy8p+ipPpVmQe8
 lO/TQBjuofhaV+JYlrx0BcFn08QqnemsS+51CBv1Tw2rqeS2CHUheLvaFBUXwwDDHknhlDqL
 4+uitkcV0X9dAklmiyu4kPizrRarqByR4XKaWFPeSW+b2RrU6/r86GHf9YK85Qw9yNeTOW7Z
 1meDL/7uRoTlS35TSNYw3ggejemt4+c/VQygX+BLHt1sHvSeN1hjRbZ6tvGQPdN3z0ADCBmg
 DjTD1K4MpGn59KR35vEt+m/USqmWPgxOWHgyoiLtQO/5HZ2GluygPC+l9nqC0483DO6n9hmW
 CPUrQrtN4zi1qC0K+ViLSwKTBf378t3HJ07k5Nl3c5LnyJC29PPpyJBzzagVLcTkbjzZ3cMW
 zMRltvc4Qy+nVZmMmrM3IXhEHOU3spmYdC+JGIQwCM0qc5QW8L2pPRJmzV4pl2goEffe/94y
 30WzvAl6VYegvoVo0wg0SWQD7QfBw9eMDCmxHHqp5iu6b5aYmqia+363011ltGJCLCZvhoaV
 Wn5d5omEDU26MhjegGpsjW7+sTvf9/easgWvxufnkLbjuRbH5k2k+IDmSttPW+VUWQN7ek9g
 FQu2Ji7uNPCMGBx5OeiBQYeMDTpZsQV8zWrjKBEn8/Q0Zr9VpNmUi4GWpflV5fKWHobqOjnO
 gCSETY9tmbTGLzRGhWa4VtnqHSHGo6iNnWeLn0Uhdt4QxzVKEtaiQESFDI0+/xxXhit39Dke
 Vxl6yo5406+pwRMx+9sOgO5VGrD5U+pZjoyVJmDPU9W4wVFtCK3eYSV6uN+GT0d/4X09VPWb
 DbDOkISVzlPBB3XYjKrdqOj7tTB7eWCU++3Lv+VJK6LtfQbTPCQg5Smzoph+T+IcMSJJHhrS
 fMhiS8hFTh0HdrUnzIXRmkZjSXIOoSQoxy3+wVzr9uj67LmRwLi6I+CEf1UPMklqHXUye+Tc
 vWdgip0M2MSzpQX2XrB06QSxnYXm2djaDmgHLANr2jLQb6ayco1R1YLLih0MsVP9ac12AJAb
 NXaht3C3bl9lvcpCl1BWDQJdemtZNcWOCewK1PKCUKGLvKAKCGZm6kfhIu4SKZMl6NZqB29t
 DKWCQnlMyjRz1EBtjiqIadBkyGWMRhTose7fwo/UQDe
IronPort-Data: A9a23:sN0SmKlmk3c89g9eYpA7PuHo5gy8IERdPkR7XQ2eYbSJt1+Wr1Gzt
 xIdDTrVM/nYN2L0e4x0PY619EtS75fSmNZgS1FsrH88Q1tH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvykTres1hlZHWeIcg944f5Ys7N/09YAbeSRWVvX4
 4uu+5SHYzdJ5hYtWo4qw/LbwP9QlK+q0N8olgRWiSdj4TcyP1FMZH4uDfnZw0nQGuG4LcbmL
 wr394xVy0uCl/sb5nxJpZ6gGqECaua60QFjERO6UYD66vRJjnRaPqrWqJPwZG8P4whlkeydx
 /1Aj7u2ZV5zZ5TOmdkHdRlqIntGevx/reqvzXiX6aR/zmXDYz3h3PVjAUU7J8se9/of7WNmr
 KNDbmpVM1bZ3brwnuPTpupE3qzPKOHgO4gUu1lkzCrFFrArXpDOTqHH/5le0StYasVmRK6FP
 JRGNGEHgBLoRjcQCxASB7MFv8iL3Hf+QzB0gl+quv9ii4TU5FctjuO8b4q9lsaxbc5SlU2Zj
 nnX+nzwRBAcLt2WjzSfmlqoj/DGmSfTSoMXHqexsP9smlyagGIJYCD6TnO+sb+0lU6zVtZSM
 QoS9zZGQbUOGFKDQ+PaWTHh+ie9vB8hQfxQIdxg0Ebc8/+Bi+qGPVQsQjlEYd0gkcY5Qz02y
 1OE9+/U6SxTXK69Ei3Cq+/Fxd+mEW1Ecj9YPH5soR4tuoG7+OkOYgTzosGP+ZNZY/XwCXf93
 DCHoSwznfMVgNJjO0SHEbLv2GLESnvhFFJdCuDrsoWNtFkRWWJdT9b0gWU3FN4ZRGtZJ3HY1
 JT+p+CQ7foVEbaGnzGXTeMGEdmBvqjZYGKB2AAwT8l8plxBHkJPm6gLuFmSw28yaa45lcLBO
 hKN0e+vzMA70ISWgV9fON7vUJV1ncAM5PzoSfDZY95DeJl3f0rfpUlTib24hAjQfYlFuf9XB
 Kp3hu73VilKUf03lWXuLwrfuJdyrh0DKarobciT53yaPXC2PRZ5kJ8JbwmDaP4X9qSBrFmH+
 tpTLZLamRFeS/HlJCTI8YMeKV0Qa342Gcmu+cBQc+eCJCtgGX0gUqWNmul5JtU5xqkFxP3V+
 nydW1NDzAStj3PwKTKVNiJpZoTpUMsttnk8JyEtYAilgiBxfYa14a4DXJIrZr17pvd7xPt5Q
 qBdKcWNC/hCUBrd/DEZYcWvpYBubk371waPJDa+JjUgf5NtQwHTvNnpYlK3piUJCyO2s+o4o
 qGhj1mHGsBbGl0+VcuPMaCh1VK8u3QZidleZUqQL4kBYljo/ahrNzf10K09LfYMHgqflDGU4
 ACbXEUDru7Xro5ortSQ3fKYr52kGvdVF1ZBGzWJ9q6/MCTX8zbxwYJEV+rULznRWHmtpfend
 aNY0PHxPfkKhhBMvpYlS+Rnyqc35t3Oob5Gz10+QC6RNwnyVuptciucwM1ClqxR3bsH6wG4b
 UK45YUIM7u+Ps64QkUaIxAob7nd2KhMyCXS9/k8PG7z+DRzoOicSUxXMhTQ2jZRKqB5bNEsz
 es74ZNE7hz5hwUqP9uCgzoS8WmQdyRSX6Iiv5AcIYnqlgtykA0ZO8SBU3Ov7cHdcchIP2krP
 iSQ2vjIiYNc8VWeIXA9In7AgLhGjpMUtREXklJbfwaVmsDIj+Mc1QFK9WhlVRxcyxhK3oqf4
 ISw25GZ8UlPw9tpuCSHd2W8XQxeBBCU/kHrjV0EiAU1iqVuunPldAUA1SSlpSj1MF6wuhBf/
 aqE0yDoTjbnccX8xG00VFINRzkPizBu3lWqpS1kdvhp27E+YCH5memjemoFph/qG4U3iVGvS
 SyGOgpvQfWTCBP8aJHXx2VXOXr8hfxEyKF/rSldwZ40
IronPort-HdrOrdr: A9a23:KivFrqPAvQsAwMBcTsWjsMiBIKoaSvp037BL7TEJdfQ2Gvb2qy
 nAppomPHPP6Qr5HUtQ/OxoW5PwJ080l6QFhbX5VI3KNGKK1FdAbrsSircKqAeQeREWmNQ86U
 6+ScJDIdf7ZGIK7vrH3A==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,228,1643670000"; 
   d="scan'208";a="10336753"
X-MGA-submission: =?us-ascii?q?MDH57s6o7rJKemQ+6ozkZTFRQZFyO0YWHlUZ03?=
 =?us-ascii?q?lLXoAOwiZvZxsQjE2O8J454fznR01TXy/A0Hc9YUqJgEB13bptiJwTk/?=
 =?us-ascii?q?BL7m9nCWk/eiPNnuUVyiEk09KY2EX/H9G9N3CbEcd9OXttnHbMKEKq8t?=
 =?us-ascii?q?zXxdunvqZPob01IJYobgtjhA=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 22:20:39 +0200
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id D077641;
	Fri,  1 Apr 2022 13:20:36 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id cIWAFw-DsIDQ; Fri,  1 Apr 2022 13:20:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 8C64448;
	Fri,  1 Apr 2022 13:20:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 8C64448
Date: Fri, 1 Apr 2022 13:20:09 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Julia Lawall <julia.lawall@inria.fr>
cc: cocci@inria.fr
In-Reply-To: <alpine.DEB.2.22.394.2203200732590.3429@hadrien>
Message-ID: <ac254b9c-3923-5b7b-5d56-564d50e06760@ewheeler.net>
References: <a9b43b8f-7f87-5e55-fa98-cfd888848b7@ewheeler.net> <alpine.DEB.2.22.394.2203192038220.3204@hadrien> <75def6a3-d1d3-8b7a-87c6-a74e685c48@ewheeler.net> <alpine.DEB.2.22.394.2203200732590.3429@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Using `parallel` to run over lots of .c files and
 avoiding stack overflows.
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 328
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/ac254b9c-3923-5b7b-5d56-564d50e06760%40ewheeler.net>

On Sun, 20 Mar 2022, Julia Lawall wrote:
> On Sat, 19 Mar 2022, Eric Wheeler wrote:
> > On Sat, 19 Mar 2022, Julia Lawall wrote:
> > > On Sat, 19 Mar 2022, Eric Wheeler wrote:
> > > > Just a quick tip for others (like me) who are new to Coccinelle:
> > > >
> > > > You might already use this, but if not, here's a hint for doing lots of
> > > > replacements in parallel:
> > > >
> > > > 	parallel -j24 spatch --sp-file smpl.cocci {} --in-place ::: *.c
> > > >
> > > > If the SmPL depends on interactions between files then `parallel` won't
> > > > work, but if the changes work per-file then it runs much faster with lots
> > > > of big .c files.
> > > >
> > > > In cases where you do need to run over lots of files and they _do_
> > > > interact, you might get a Stack Overflow error.  In this case set
> > > > something like this for 1GB of stack space:
> > > > 	ulimit -s $((1024*1024))
> > > >
> > > > In my case spatch needed 1GB of stack and 2.4GB of RAM.  It took a few
> > > > minutes and finished thousands of replacements!
> > > >
> > > > Julia, you might add this to documentation if you think it would be
> > > > useful.
> > >
> > > I'm not sure what you are trying to do.  You can give spatch the name of a
> > > directory and the argument -j N for a number for cores N, ad it will run
> > > in parallel on the files in the directroy.
> >
>   --jobs          the number of processes to be used
>   -j              the number of processes to be used

Running `top` shows spatch at 100% cpu: it is not parallelizing, though 
the rules and files are completely independent of eachother (no 
inter-SmPL-rule dependencies).  

Not sure if this is an spatch bug or not, but its ~3x faster to use 
`parallel` as follows:

]# time parallel -j24 -- spatch --sp-file cocci/printf-refactor.cocci  :::  `ls src/*.c|grep -v resources.c` &> /dev/null
real	0m1.224s

]# time spatch -j24 --sp-file cocci/printf-refactor.cocci `ls src/*.c|grep -v resources.c` &> /dev/null
real	0m4.852s


Here is the SmPL:
	@ p4 @                  
	expression list EL;     
	constant C =~ "BUG";    
	@@                      
	-printf(C, EL);         
	+BUG(C, EL);            
				
	@ p3 @                  
	expression list EL;     
	constant C =~ "warn";   
	@@                      
	-printf(C, EL);         
	+pr_warn(C, EL);        
				
	@ p @                   
	expression list EL;     
	constant C;             
	@@                      
	-printf(C, EL);         
	+pr_info(C, EL);        
				
	@ p2 @                  
	expression list EL;     
	constant C;             
	@@                      
	-fprintf(stderr, C, EL);
	+pr_err(C, EL);         


The .c files are from here:
	https://github.com/KJ7LNW/xnec2c

--
Eric Wheeler


> 
> julia
> 
