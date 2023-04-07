Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D55C76196
	for <cocci@archiver.kernel.org>; Fri,  7 Apr 2023 07:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=rM6ZtimIJzHjZ0LqGrAUagjcVzmFrRHqU2zg15sMrGc=;
  b=E4buZJKSmQ/yYlMBLRIJYBJxwRVqL0+A8SFCAZtWsLAPf3uFlTEZvfsF
   PMhHJL9saGZ0mB9fK4u8cCSqi+FBSa4zr2n48fastv6sdshHNoOmI0ZhI
   DwSJhBtVaCjTuWWrKbq9geUNgWU3rA8S8Vevxi2aF3vEa2q5Kqy8cEZLV
   A=;
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
X-IronPort-AV: E=Sophos;i="5.98,326,1673910000"; 
   d="scan'208";a="101474521"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Apr 2023 09:50:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 88123E7316; Fri,  7 Apr 2023 09:50:32 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BF7FEE72F8
	for <cocci@sympa.inria.fr>; Fri,  7 Apr 2023 09:50:29 +0200 (CEST)
IronPort-SDR: 642fcb44_famBgC9w8odArTInJrgWFH6tO1wOSTfIqdYYee31zHfEfx+
 XJJIe7GAn2nEAMIoniU8kIBZICdomBzZmJmdMUw==
X-IPAS-Result: =?us-ascii?q?A0EoAACmyi9khw4P49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YItgUsvBAtGhFOIH4kQA4Qvhy6QKYFWgUA+DwEDAQ1BAQIEAQEDBDiBU4J0A?=
 =?us-ascii?q?oU9Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECEAEBA?=
 =?us-ascii?q?RoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICR?=
 =?us-ascii?q?z4DAyMEGQEBESYBDx8GAiYCAlcGAQwGAgEBgnqCKAEDMQesP38zgQGCCAEBB?=
 =?us-ascii?q?oJjmSgfLCJUgV4JgRQtAY0JhDAnD4FVRIEVJwyBCYE+bogfgmeCLIdQh2iIT?=
 =?us-ascii?q?QqBNHaBIA6BPYEEAgkCEWuBEAhqgXlAAg1kCw5vgUpjTIF7BAIUHSUEDgMZK?=
 =?us-ascii?q?x1AAgELOzo/NQYDCyAGWGsCCSMREwUDCxUqRwQIOAYcNBECCA8SDyxEDkI3N?=
 =?us-ascii?q?BMGXAEpCw4RA0+BRgSBCoEBBgEmJJ1jcwFSKBNMJoIEklgRkjSeGTQHgiqBV?=
 =?us-ascii?q?oFZDJ8NBhMvlwkOBpIkAZdzIKd/gWM6gVwzGiSDNk8DGQ+OIBmEDI8JAT4/N?=
 =?us-ascii?q?D0CBwEKAQEDCYVGAQGFfQEB?=
IronPort-PHdr: A9a23:mDiO2RWOQyM1shMwXub+A6r1KHnV8KyfXTF92vMcY1JmTK2v8tzYM
 VDF4r011RmVB9idsa0YwLOM6OjJYi8p39WoiDg6aptCVhsI2409vjcLJ4q7M3D9N+PgdCcgH
 c5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFRrhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTajYb5+N
 gu6oAfeu8UZnIduNKg8wQbVr3VVfOhb2WxnKVWPkhjm+8y+5oRj8yNeu/Ig885PT6D3dLkmQ
 LJbETorLXk76NXkuhffQwSP4GAcUngNnRpTHwfF9hD6UYzvvSb8q+FwxTOVPczyTbAzRDSi8
 6JmQwLmhSsbKzI09nzch9duh6xHvh2uux1/w5bVYI6LMvp+Yrjdds4eSWZYQ8pdSzBNDoa6Y
 oASDeQOIPxYopH+qVUAohSxCxSiCuPxxD9GmHL537E13es6HAHaxQwtBc4CvGjaodj3MqoZT
 OC7zLPPzTXGd/5Y3i3y6JLLchA8uvGHQL1+cc7fyUk1FgPFiFqQopHiMj2SzOsNqWub7/d7V
 e61hGAnrw9xoiKuxscqhYnEnYwUxU7f+ilj3Yk6O8S1RUhmatGrDJVerTuVN5dqQsw8WWFov
 j43xqAEtJO0fCYExokrywPDZ/Cac4WF4RbuWPufLDp3hHxpZrOyihas/EWh1uHxWce63VJKo
 CZYjNTBuWwB2wHP5sWBV/Bz/V+h1C6R2wzO9O1IO144mbTZJpI737I9loAfvVnMEyPunEj7g
 7Wae0s59uSy7+nrfq/qq5ySOoJylwrwKL4hmtalDuQ9KgUOX3aU+eC71LD7+E35R6hKjuEsn
 qjXrp/VPt4XqbOnDANN04Yj7QiwDyu+3dgGgHULMkhJdAyZg4XrIV3CPfD1Ae2ij1mjiDtrw
 urJPrzlApXDNHjDl7LhcK565UFG0gozzs1f54lOBr8OJPLzVFXxtN3eDh82KAG1zfjoB85n2
 owDR22DGqmZP7jKvl+S+u0vO/WMZJMSuDvlNvQp/+TugmMhmV8BYamp2oMaZ2y/Hvt6P0qZY
 GHhgswBEGcPpgoxVvbmiFyEUT5JZna9Rbgw5j8hCNHuMYCWRY23hrGFmSWyGJxKYXpdIk6DH
 G2udIieXfoILiWILYsplDEYW7mlV4I7kB2jqgL+46RoI/CS+SACs5/nkt9v6Kmbkxwu+TFqJ
 9qS3nvLTGxumG4MATgs0+Q3pVJmj1uOz6V8q+JXGMYV5P5TVAo+c5nGwKgyANfoVx7Md9KhT
 lu6TNSiHTwrCNUrzJtGSkJwC52NhwrfxSeuB/dBnrOCHoAu/6bY93b7Yc16ziCCnOMNhkcnT
 oN0cyWDh6p7+hKZT9rFmluUko6mfLoR2SrK+nvFy2eS6gUQfRRxWu3pQHUWdEbK5YD06l7HR
 q2jFZwoNQxOzcPEIaxPPJmho1FBXvbqPpzhbnmtg2e5AV7cyKykd5bwf2gbminQXgxMsQkQ4
 HzOFgk1ByG6oGOWWD9zH1vHYE729+R67nShQRlwhyONfVZs2fKW8xIRiPeHSvBbirENtCMso
 B1yEUqz3tbKBsDGoBBuKuEUQ8454V5BnUvfvhdhN4enMeg2hFc2aB92+UnhgVE/MoxKlc9ii
 n4r1gM6ALOFy1QJIyuR15T3ErvaNmfz+AyicejRwF6IlJ6u86AL77wRoVjlvUn9DkMo/nNm+
 8NY33uV+tPBCw9EFdrKU0Mw8VBaoKvfay91s4PTz3h3Gbe5qDDPndQkGK0s10DzUc1YNfahH
 RXxDtZSKsygMu0slBD9SxseP/1JsoMwMdmncfSux6OheuptymH1xV9b6ZxwhxrfvxF3TfTFi
 tNcm6nwNmqvUj79iAzkqcXrgcVfYilUGGOjyC/iDYoXZ6tofI9NB339a9avyIBYgJjgE2Vd6
 EblH0kPjeqgYxmPdBrQ2QNK1EIYiWOqk220wm88iCkn+5KWxzeG2OH+bFwCM29PSnNliALJK
 JK3kstccUymdQkvmzO66Ey8y6UI7L9nITz1RkFFNzPzM3kkUqa0se+aZNVT7ZozrShNeOG7f
 EzcVbP35RcXu8/6N01Zwj1zNzSju5Gi2gd/lHrYN3Fr6nzQZcB3wx7bot3aX/9YmDQcFmF+j
 nHMC16wMsPMn53cnorfsu24S2OqV4FCOSjtw4SasSKn5GpsSRShlvG3k9fjHEA0yyj+n9VtU
 CzJql77bOyJn+yfOPhkY1IuKVvy8ct8Falhn4F2iJxRkXkWi5OJ/GYWxH/pOIYT0qb/YXwRA
 D8TloSMuk6/ghIldy/Pnt6qMxfVitFsbNS7fG4Mjyc07sQRTbyR8KQBhixt5FyxsQPWZ/F52
 DYb0/onrnAA0IRr8EIgyDuQBrcKEAxWJyvpwl6t5sq9sb4RSWKha7m222JhkNrnALzI8WQ+E
 D7pP4wvGyN99JA1FVvW02DorKzgdsPRa907qRCe1RvNxbswStp5hr8BgixpPnj4tHsuxrsgj
 BBg6pq9uZCON2Rn+K/R7gdwDjTufItT/zjsif0bhcOKx8W0GY0nHDwXXZzuRPbuETQItP2hO
 RzcWDE7r36aH/LYE2r9oA9DpmjMDovtGnWZPngfwv19SRPbKEEXjA0PXTo8l4I0DUjwnZanK
 h0moGlMoAek4hJXgvplLRz+TnvSqGLKIn8vRZ6TIQAXpgBO6kHJMNCPu+d6HiVW5Jqk/0SGL
 m2WYRgNDHlcABXeQQq5Yf/3uJ+Zr7v9ZKL2NfbFbLSQpPYLUv6JwcnqyY5653OXMd3JOHB+D
 vo9004FXHZjGs2flS9cLk5f3y/LccOfow+xvyNtqcXqutHiQgHy/s2iD7VIMNNg0w+7i+GPO
 qTD4UQxYSYdzZ4KyXLSnfI61UQRljooWj2jC7UGugbSQaiWlqIdXHt5I2tjccBP6aw7xAxEP
 8XW38j02rBPhfkwE15ZVFbll5LhdYkQLmq6Ll+CGFeTOeHMO2jQ28+uK/DZK/UYnKBOuha3o
 zreD0LzImHJiWzyTx72eeBU0HPBZUYY4tviNE83Vy66FoKhMEDeUpc/jCVqk+dt3DWQbzFaa
 GU6KwQX8/WR9X8K2KwlXTYbsTw8cq/c3HzGp+jAdsRM6KQtXX4yzrMApi5mm/wPvUQmDLR0g
 HeA/oQo+g/71LDSm3w/F0AQ4jdT2NDR5BokZv+frMEfHy6Dpk1F7H3MWU5T+J06UJu26voWl
 ISIzvyWSn8K8sqIr5tGQZGKdYTdaitnaEGxUD/MUFlVF3jyazyZ3RcF1qvIvjicqpxwwnT1s
 LwJTLITFFk8F/dBT19gAMRHO5BvGDUtjb+ciscMo3u4thjYAstA7NjBUbqJDPPjJSz87/EMb
 gYUwb7+MYUYN5Hqk01kZF5gmY3WGk3WFdlTqyxlZwUwrQ1D6n97BmE03kvkbEuq7hpxXbasm
 QUqjwJlfek33DLr/ktxOVfA4ic90QEwldjjnTGNYWvxIaO3DuQ0Q2L/s0k8NI++Qh4gN1To2
 xY+a3GdGvQI0+gFFygjkgLXtJpRFOQJSKRFZERV3vSLf7Az1kwarCy7xEhB7O+DCJ14lQJsf
 4T/yhAIkw9lctMxIrTdYaRTyV0FzIeHpCy1zaYcxAEEJkAC2HyfcmgEtQZbU9tubzrt5eFq5
 QGYznFbf3MQUvMxvv9w3kY6JvjG0C/qlbJOYBPUVaTXP+aSvG7OktSNS1U72xYTlkVLyrNx1
 N8qb0ueU01HJFS5CBkDc8bPe1g9hyt68X/OYWCRvO+LzZ8nZ+1V88j3QOXIuKtG2iqZ
IronPort-Data: A9a23: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
 OzyMUEc8vR8Ll+FiArTCjGGbT9b+87n
IronPort-HdrOrdr: A9a23:vf4fdKBERM+LGbDlHel455DYdb4zR+YMi2TDGXoBLiC9Afbo9P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkOss1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QF5SWY+eRMbEVt7ee3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,326,1673910000"; 
   d="scan'208";a="52437176"
X-MGA-submission: =?us-ascii?q?MDHYPN2MagkPpImXWDT8bC/q7EW49KUkDq6bAO?=
 =?us-ascii?q?di4X/teov9XLqUyl2aOxXis6rAMRFf6ukzr96YxZLovEHJlvEu+a8Rm2?=
 =?us-ascii?q?BiJYWWRcpodjiZpqpPaFR+oUdyPwjpGhhRk7NrXcH0dYMUT9LCGC4H0x?=
 =?us-ascii?q?Hing9y+0X27r7DJDrB4LL7Hg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 09:50:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680853814; i=markus.elfring@web.de;
	bh=XeTrvo4c7c7EY8OpqNaDpVzfsH12ErYXcgkrGuBZzog=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=ADSa6MlwvcVt149D+3gtOacO3kH74BpN5w1UYbc01rXXNENuwAuUZU4NBg7hxgSre
	 pkiLZXv1dBWs0I4AZFmFecfxhSGycxIMrOU9INYaBcSsa+DDyCnT1NlV5fgj/ckD/l
	 BkvSkyYPzVMvrTKVyxESeudTP74/sXNkG39Qd6rCo6yndWR5cusL0ol3N8a60TMrG8
	 XhGjDJPrGZKkgiL/3Zmjdx7cr7qwjQsIbkzUamw27oNHC7qIsAsRLwHqUvCmYRG7Fz
	 FrzCE44sPNwXoAtoxeihMLU52I5AoQIbyPVcR4KMAX2YkeJTL9iBT+I7JYEPjLoQyP
	 Nok8NleqezCng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8kAH-1popaZ2qx7-004Y3V; Fri, 07
 Apr 2023 09:50:14 +0200
Message-ID: <64e1977a-ffd8-4948-951a-29608fe631f8@web.de>
Date: Fri, 7 Apr 2023 09:50:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, netfilter-devel@vger.kernel.org,
 netdev@vger.kernel.org, lvs-devel@vger.kernel.org, coreteam@netfilter.org,
 Alex Gartrell <agartrell@fb.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>,
 Jakub Kicinski <kuba@kernel.org>, Jozsef Kadlecsik <kadlec@netfilter.org>,
 Julian Anastasov <ja@ssi.bg>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@verge.net.au>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <8f785de5-ebe2-edd9-2155-f440acacc643@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <8f785de5-ebe2-edd9-2155-f440acacc643@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TT2yXNaIChtFd+o+dostBRxAmMGeqk0Dz2VupoonxF1ND2JCi70
 daOUL8oMMEk5xcB6kkZPRISlBYhqlrMzMw7tKqdiQeBkaINOL4M3w6QIwTmLWdozo4uKwMb
 BmluCZG/t/NPy+FcV2dyIxzbzBfVc2DNqog0e9atn5E0r1L3tcNuZ21GHmze96YbjK62TNZ
 CZaRAhZjD2vjat1g+nCtw==
UI-OutboundReport: notjunk:1;M01:P0:16yTS4XiJYo=;CTLjcP7qGKJ1Ezp1FMK5FvpztdZ
 tjJ8e36PKhOq+hI93c3QBOEovT4LrZYyjGrAEwYS2TM0+oSQKzz0iCV5hCyO0XVgbmeP2qwW/
 lQmfuJgpgknK9FqWQheka3WsHpgpGaCIuTOJqlRnghiWZyth1x45Z/eXqftFzBzvV1Sm0JkN/
 cIGIGUvr1M3hADiwZAMJi5YCt8Ha+dCRslac6CWV2XFyGrEskoPoDjZzI0k8fXEonBlzr5k7P
 y9cTiJVSfVzaxcTicDPtoXFVN5oC6qu6OtfuoV2yAy+Xenxgs2myaoKLt6sfNhCczoC1+HzcK
 pyM9VVLLXpAOqcJX3yCQVpfVW9l3X4iGOZh9EV7BciU8muPAG+9Ft41/5pvNvycDztCu5cFc9
 zCpuj3v+TGRoL2GdQAo2ViNjMmwVM6sk/TI1kpk48QlSHUlfMxhSoqSyOTkfdz3u/jaYo7gJR
 OBdUapjCPIyHtuVCZ6BJ+g7AVlIU7pisZvyOAV31m0MkIn2YTaEK9v+djJK7QlETNBp6uQ/5g
 t7cZSOiNwTs7xkq1hj/cduG5vsnVUUbV5bjXkcFYdFN5Rox37k01uu0L+xqvKI/yXikfpLPK1
 NQD8amKgVgB9X5MHrcbVWErdjDxxim1Blixch9yuiD0dTID/GyGNX08Ls8X+pnba1SVBdtxLq
 vNk3q7u7ZjfBU6vqhs81JyEr1Ns+P/P4nZlZ7NX1FOl55MT/w/xY81atssNuyOgk6TRQcvpXw
 grd8LbvvYfv1t0R7E4WhALhJ9LH83vuC2THv/gkksbwsXL6h7qSuBaBtirqoNXI+6N31/xX9t
 2zm5Tebk3uP+cwgHVHDa17QrI+CNgTzjry4I2ZL8lVmZJqR9/qtWAc3Hs0Zg3GePDsumF2ehS
 eZLECq8n02uAcn6TNHxlGpJ2f8roXa89KN2Q2ekfpOPfAAEzwFhyhX9Nx
Subject: [cocci] [PATCH] ipvs: Fix exception handling in two functions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1011
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/64e1977a-ffd8-4948-951a-29608fe631f8%40web.de>

Date: Fri, 7 Apr 2023 09:33:43 +0200

The label =E2=80=9Ctx_error=E2=80=9D was used to jump to another pointer c=
heck
despite of the detail in these function implementations
that it was determined already that the corresponding variable
contained an error pointer because of a failed call of
the function =E2=80=9Cip_vs_prepare_tunneled_skb=E2=80=9D.

* Thus use an additional label.

* Delete two redundant checks.


This issue was detected by using the Coccinelle software.

Fixes: ea1d5d7755a3e556de78cc757d1895d5c7180548 ("ipvs: properly declare t=
unnel encapsulation")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 net/netfilter/ipvs/ip_vs_xmit.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xm=
it.c
index 99c349c0d968..68343ee380e1 100644
=2D-- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -1199,7 +1199,7 @@ ip_vs_tunnel_xmit(struct sk_buff *skb, struct ip_vs_=
conn *cp,
 					 &next_protocol, NULL, &dsfield,
 					 &ttl, dfp);
 	if (IS_ERR(skb))
-		goto tx_error;
+		goto leave_function;

 	gso_type =3D __tun_gso_type_mask(AF_INET, cp->af);
 	if (tun_type =3D=3D IP_VS_CONN_F_TUNNEL_TYPE_GUE) {
@@ -1266,16 +1266,14 @@ ip_vs_tunnel_xmit(struct sk_buff *skb, struct ip_v=
s_conn *cp,
 		ip_local_out(net, skb->sk, skb);
 	else if (ret =3D=3D NF_DROP)
 		kfree_skb(skb);
-
+leave_function:
 	LeaveFunction(10);

 	return NF_STOLEN;

   tx_error:
-	if (!IS_ERR(skb))
-		kfree_skb(skb);
-	LeaveFunction(10);
-	return NF_STOLEN;
+	kfree_skb(skb);
+	goto leave_function;
 }

 #ifdef CONFIG_IP_VS_IPV6
@@ -1347,7 +1345,7 @@ ip_vs_tunnel_xmit_v6(struct sk_buff *skb, struct ip_=
vs_conn *cp,
 					 &next_protocol, &payload_len,
 					 &dsfield, &ttl, NULL);
 	if (IS_ERR(skb))
-		goto tx_error;
+		goto leave_function;

 	gso_type =3D __tun_gso_type_mask(AF_INET6, cp->af);
 	if (tun_type =3D=3D IP_VS_CONN_F_TUNNEL_TYPE_GUE) {
@@ -1413,16 +1411,14 @@ ip_vs_tunnel_xmit_v6(struct sk_buff *skb, struct i=
p_vs_conn *cp,
 		ip6_local_out(net, skb->sk, skb);
 	else if (ret =3D=3D NF_DROP)
 		kfree_skb(skb);
-
+leave_function:
 	LeaveFunction(10);

 	return NF_STOLEN;

 tx_error:
-	if (!IS_ERR(skb))
-		kfree_skb(skb);
-	LeaveFunction(10);
-	return NF_STOLEN;
+	kfree_skb(skb);
+	goto leave_function;
 }
 #endif

=2D-
2.40.0

