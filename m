Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A57AC48BC3
	for <cocci@archiver.kernel.org>; Mon, 19 Feb 2024 09:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ccsalXz3urZKFmkr0vhN0fIGP1JG7rUZdS6N0Eby5J0=;
  b=mCjSGOCwVr1AE6wWDy9j7XwHNbPruAW8otL5FIP30T6ohBCn7uZ3QzTq
   pnq/pFEQKFL6KBe19PZ+m1Y7hJFZhMSlRcQDRHk7b2i4hFKk5zPc6OM1c
   fw2HW0YTMWKoQDVnUE0/vn12uiVvmlwu6s43pFhnLkrigjXubGQiqk+uE
   M=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.06,170,1705359600"; 
   d="scan'208";a="152594929"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Feb 2024 10:45:49 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 42CFAE008A; Mon, 19 Feb 2024 10:45:49 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 98D74E008A
	for <cocci@sympa.inria.fr>; Mon, 19 Feb 2024 10:45:43 +0100 (CET)
IronPort-SDR: 65d32347_g4Fb4xY+eiTftHkA9SjexD0JjXjuRYgp8RCFPOp8U9DGSzp
 0p6AZYe5iXa4YGaPfqqxrakKJlX/R7S/TToT29w==
X-IPAS-Result: =?us-ascii?q?A0FaAABnItNlhwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYI4f1MyBAtIhFORaYQ7hzeQPoFWFIEsPg8BAwENQQECBAEBAwSCC?=
 =?us-ascii?q?4J0AodkAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBASMTBAcOECeFbA2CXAEQgQ6BJgEBAQEBAQEBAQEBAQEBAQEBARcCR0EBA?=
 =?us-ascii?q?gIBIx0BAREnBAsLGgIRFQICVgYBFAEBgnyCKwEDDiMHtBaBMoEBggoBAQavW?=
 =?us-ascii?q?x8sIlaBYQmBGi4BiCUBhSRLhDwnD4FVRIE8C4JHMT6DfEc/gxyCaIIYgmBbk?=
 =?us-ascii?q?wSHB1SBAh0DgQUEWg0bEB43ERATDQMIbh0CMToDBQMEMgoSDAsfBVQDQwZJC?=
 =?us-ascii?q?wMCGgUDAwSBMAUNGgIQGgYMJgMDEkkCEBQDOAMDBgMKMQcpVUEMUANkHzIJP?=
 =?us-ascii?q?AsEDBoCGxsNJCMCLEADERACFgMdFgQyEQkLJgMqBjYCEgwGBgZdCRoHDwkEJ?=
 =?us-ascii?q?QMIBAMrKQMhM0ERAwQKAxMHCwd4ggmBPQQTRAMQgTRChHaEbwyBUgMZKx1AA?=
 =?us-ascii?q?gELbT01CQsbBiIBHQKhXQiEAcUfNAeCNIFggWEMnzgGEy+XMA4Gkl+YWCCoV?=
 =?us-ascii?q?4FrDCeBXDMaJIM2TwMZD44gGYQUj0dCNTsCBwEKAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:aJTsoKsn8oNTFejHz9NrfkMO2ufnVJJaMUV32f8akzHdYApBsoF/q
 tZmKWDSbP+MYDb8c4t0a4i38h4OsMTcmoQ3TgQ/qCBkFH8VgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTrSCYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCRMtcpvlDs15K6u4GlB7wRnDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNz94X2mVTKlLjFVDmZkh+A8BOsTAezsAG6ZvXAdJHAathZ5plqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJGokOYYR3b9tOjkN6
 MAaLhwwSRGJvu3jldpXSsE07igiBMzsIZ9ZpXxqiz3UZRokacqaGeOQv4AehWh235km8fX2P
 6L1bRJKZQ7DfgYJF1MZEpM4k8+3i3O5fzAwRFe9/PdtvjmPnVQuuFTrGP3KWP6RZMVlom+dm
 0Xh4W7XEjQCL/XKnFJp9Vr32r+XxnOkMG4IL5W8/+FjhFm71G0WAgcfE1q9u/iwzECkM/pUL
 Ecf+wI1vK0q/QqqSMP8Vlu2uha5UgU0Xt1ND6sl5QvLxqe8Dxul6nYsZSxFY9UB7dUNHX836
 l2Ps+7OBDZWv+jAIZ6CzYu8oTS3MCkTCGYNYy4YUAcIi+UPRqlt0Xojqf49TsaIYs3JJN3m/
 9ydhAQT74j/YOYO0Linu0/KiXSgq/AlrzLZBC2GAwpJDSsgOuZJgrBED3CGsJ6sy67EETG8U
 IAswZT20Qz3JcjleNaxaOsMBqq1wP2OLSfRh1Vid7F4qGz9oS76Jd4OvWwjTKuMDiriUWC0C
 KM0kVwMjKK/wFPwNfUvC25MI59xk/OwSbwJqNiFM4MVCnSOSON31HoyNRbLjz+FfLkEkKY5P
 ozTasvEMJrpIfQP8dZCfM9EieVD7nlmmwv7HMmnpzz5ief2TCDPFd8tbgDUBshnt/zsnekg2
 40CXyd8404FAbWWj+i+2dJ7EG3m2lBlWsyr85UMLLPrz8gPMDhJNsI9CIgJI+RN95m5XM+Rl
 p1kch4GlgjMljfcJB+Ua3tuTrrqUNwt5Tg4JCEgdxLgkXQqfY/lvu9VeooVbIsX0rVp7cd1a
 P0ZJOSGIPBEEQrc9xonMJLSkY1FdTaQvzyoARaLWjYFQsNfd1T7weO8JgrL3wsSPxWzrvo78
 uGB1BuEYJ8tRDZCLcfxadD0/WyQoEoypeNWdGnLK+l1Z0/D3tVLKSvwr/lvOOAKC0zJ6QW73
 jasIyUzhLfysaoq1uLWlIa4r4uNOMlvLHpwRmX0w+6/CnjHwzCF34RFbtetQRncc2HFoIOZe
 uRfyqDHAs0txVplndJ1LOd28PgY+dDqmr59yzZkFlXta3CAKOtpAluC7Pl1mpx9/J1rkiroZ
 RvX4fhfA6uDB+39Gl1IJAYFUPWK5ctJphbst8YKMGfIzw4p2oGYUHdiHQiG0w1cC7pXDLkL4
 8kcvOwu1gjurSZyb/iniHhP+nWuP04wdfwtlqsnDb/BjispzVB/YqLgNBLm3aHXa/twHxkrB
 hS2mJv9g69twxueUngrSlnI8+lvpbUPnxFo0FVZGQytnNbBt/5q3y9q0C8WSz5NxU5tyNNDO
 WlMNmx0K56R/jxuutNxYmC0FyxFBzyb4kbU2XJTsEH8UG+TSX3rEG0xHc2v7XIp2TtQURYD9
 Y7J1Vu/dyjhef/A+xcbWGlnmqTFdsNw/AiTo/KXNZ2JMLdiaAW0n5L0Q3QDribmJsYDhEfng
 +1O18QoYI3ZMR8gmYEKO7O4558xFi/dfHdjRMt/9pwnBWvfITG++QafInCLJ/9iGab4zl+aO
 edPeOR0SBWM5ASfpGs6BIkNAYNOstwH2d4gQo7vdEk66+axjzwxq5/B1DnMtElySfVUrMsNA
 IfwdTWDL2+uuUVpi1L99MlpB27pTuQHNSvd3f+0+tonD5gskv9hWmBs36qWv0e6ChpG/RWVs
 Fn9ZovT9ehDyJttraToAK5sFwW5EvKtdeWqoSSYkcVCUsPLCujK7zgqk1jAOx9EGJcsQPF1q
 Oi9i8H210b7o7oGaWDVtJ2fHa1v58/pfu5oHu/oDXtdxw2uZdTN5kYdxmWGNpB5qtNRyc25T
 Q+easHrV9o0Wc9Y9UJFeRplDBcRJKTmXJjO/Rrngay3NSEc9gjbIPeM13zjNzhbfxBVHazOM
 Fb/vvL26+1IqIhJOgQ/OMhnJJ1FO37mZ7otcozglDufD1TwuGi4hJnZqUMC5w3IW16+K+Sr0
 aKdE1K6PF63tbrTxd5Uj51qs1dFRDxhiO03ZQQG98Qwlzm+C3UcIP8ANYkdTKtZiTH2yIqyc
 QSlgLHO0skhdW8sndTADNXfssO3A+sTJpHmKzZv8078h+Jawm+fKOMJy8uiyy4elvjfICWPN
 twUvHH9VvR06o88Xv4dv5RXns8+rs43BRs0FYTVjMH4RRoTaVnPOLqNAyIVPRH6/wrxeIkn6
 IT7qa2ogK12dKIpLftdRg==
IronPort-HdrOrdr: A9a23:wraBgK7a83Q7pYm7IQPXwP7XdLJyesId70hD6qkDc20qTiX4rb
 HUoBx4vSWZ+VIssRQb9qHmBEDuewKgyXcY2/hhAV7AZnibhILLFvAZ0WKK+VSJcEeSl44ttt
 YDAs0OcayJMbEQt7eI3ODXKadR/DDKytHWuQ4A9RkdKz1XVw==
X-Talos-CUID: 9a23:mVZm9G0Lw9E7VDebHBgRb7xfMdIheXT6lW3rewylNWRvZICySFWp9/Yx
X-Talos-MUID: 9a23:IGnHmAWtXdFxwV/q/BjzphN5FcdY342rNWcqj58oq+ycLgUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,170,1705359600"; 
   d="scan'208";a="152594907"
X-MGA-submission: =?us-ascii?q?MDH4HRka7ZDIYRNfx5CjA9ZKzwIeSw3m9XjV2A?=
 =?us-ascii?q?WlPTlFED5tWCW1HcBttqBhhiZMMiPtGeHS/kTS2wrMOsjdM56UIeP3Sw?=
 =?us-ascii?q?GG5e1+gNHI3R7OdcLKnh35p9Ot71sQUxeuWVcAcYkmLtLySv59wh5oMn?=
 =?us-ascii?q?KLdCV/5IszDRHsKO9K3cdHnA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 10:45:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708335942; x=1708940742; i=markus.elfring@web.de;
	bh=WpdaDq6YiUUEjJcsxp/kaOUD2B4HBWYz6dlkyha/UDM=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=XiNCgVHB3UATzlVVEShM+9DDC0B0jVGY2d1Gts5MoEP3ks3GMnlxIGjjAAi0Z1/m
	 CnR/ie0uumN/aq7ncCUO9i9TEw8T8kjb5R8spFBp60Eo+mvrwpqzze6XmWaSkZGbh
	 QRolMLE06RmaSo1+AkJ5t+Gk9SGdBFmjRk318Xd3stxLQ7h6IhViH3kYw0l6aXziy
	 O1nZqV0izWXxeYe4RfF0fc6QGDiCljNPeFv1GnkOdo6Km1f3f/mz/rgN4vzekIR8+
	 nJDb8OYlRopgyrO8wRb8Ja743E+/R1p534FgNDNPUk5PvhR9O9dIF0+s7aNsT8a5D
	 dAsFwVOgdcdB45WpbA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXGK4-1rRcDY1lqo-00Yg7B; Mon, 19
 Feb 2024 10:45:42 +0100
Message-ID: <cfbd7f80-5485-4578-a77d-94445af135cd@web.de>
Date: Mon, 19 Feb 2024 10:45:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <c5bcc0b5-1a19-4256-8572-b9ee5e78ea0f@web.de>
 <12009cea-f93c-4a80-a95f-9bde16dc78a5@web.de>
 <4bd9de70-de02-4fea-9d41-095304edf4fe@web.de>
 <38d77d89-ffb7-d495-ff80-898861d46d32@inria.fr>
 <5afbaf9d-892b-4105-a54a-35f1e40e6749@web.de>
 <6a89e704-5561-4f44-b9d7-7c8f78976e71@web.de>
 <alpine.DEB.2.22.394.2402180908440.3095@hadrien>
 <30fef057-5f06-47bd-8b62-1bb6fc3fb946@web.de>
 <alpine.DEB.2.22.394.2402181707300.3095@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2402181707300.3095@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F3t/zipq0Qg5gMxd41ku6cUvkMzWnwL+eKRemY1cUr/yt0Z0qbg
 mLMnnTP5LHWP/JTC8EU+AG64n9wVK6yinzoLiRnLPuS5QsijTkJmB5gHskVVQ/NZxAZmjtV
 V1oZFAcy1lWNFvcQ5ZCg27X23gfucxH5slkfzHGDAfcUh5a8KRXtGsPPJBgN/xNkb/nBh3t
 K2IYSF39YaynmTXsmgIAg==
UI-OutboundReport: notjunk:1;M01:P0:/zOM5ElDJIw=;4lO7lU8m725NbY+geYRuWI4xp13
 Z10FM+j5o30A9CjRPd49/xP318CKWN4mV5oSjQrCOIADAPyfpTCmTVJBgLP3Z9LKl3C3APAod
 xZhoUlgWJzzPsNcFrs9SoD9/cb2p7bd0TuKZoadNhZraJS4HagE29iPflHdKxTK2HfvfJPoPm
 ARbWN5OdC2aiRtICX7n1h6/zYrCgVVjdeuM6626lI9r+UTI+txMOk3fEKS1ddN9VGP1LUghHX
 UsMZtIZEXIEIwYRlyZ0nFGXA+aI9cpsjYHlTB/8V7xby8qtUtHMFgAyNP8tg3qnq/NnjRXowy
 y11XUGVurphdPYVZl+ECCl8uy/ehipJArdzsqXUe1sfzcic5l3Z2870osCJiCP9rEfgP4cJyv
 CLlwsJyzqyJ+NoBwEP7fBI9PbuPN5PW0BVdmGiw1FSZU8E6sBCiLZa1wKogkKtW3WtQpggiWg
 J8/jNzZcaFTa4KkeTF00gtkJlxWjhpmUfuqPcyiHNQs7x4qVDstnZX0RLn6y7a2XugRTY8lwN
 9OBFZJeSAEn1dZmQKe75ZAuV6iFshlTDQgKTwVmkJil7H9UxclGKtFHZvjzgq35cW6GQ0yl/5
 wF67zqWYmdFbJ9ZEFWKdFqLvRxV+3bSZVNj3P1LyAEWtH70Fq4Zt88bfLIggZxL7ZNz8+IYJ3
 Alrv7GYnbOXZrXKNxLd9JqkQbSdQi7TIB2bh+5v7QETKNpfW/VK9IwM6vj7mj4mqNgMCwyH/m
 DXH4s0m1ryuR+/HJr+3StU59xsnO4Zctwaxu7KkJ58mO0j5EcSTjND77FlFbP02u/YMFigOgx
 Cc0CKQY7QUbWgkaIRy9guGnpcc6B5+aXCNOn/Jib6sE68=
Subject: Re: [cocci] Checking the search for a repeated condition check with
 SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1586
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/cfbd7f80-5485-4578-a77d-94445af135cd%40web.de>

Another contribution was published yesterday:
account for the fact that binops and assignops are now stripped

Thus data processing can be measured once more after such a bit of develop=
ment progress
also together with the software combination =E2=80=9CCoccinelle 1.1.1-0073=
9-g68c580f1=E2=80=9D
for the following SmPL script variants.


> Accordingly, the following semantic patch is quite slow:
>
> @@
> binary operator bo;
> constant c;
> identifier var;
> statement stmt;
> @@
> ( if (var bo c) return var;
> & stmt
> )
>  ... when !=3D var
> - stmt

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> git checkout =
next-20240209 && time spatch drivers/md/dm-vdo/slab-depot.c =E2=80=A6/Proj=
ekte/Coccinelle/janitor/delete_redundant_if_statement3.cocci
=E2=80=A6
real    0m16,386s
user    0m16,306s
sys     0m0,056s


> And the following semantic patch is quite fast:
>
> @@
> binary operator bo;
> constant c;
> identifier var;
> statement stmt;
> @@
> stmt
>  ... when !=3D var
> ( if (var bo c) return var;
> &
> - stmt
> )

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> git checkout =
next-20240209 && time spatch drivers/md/dm-vdo/slab-depot.c =E2=80=A6/Proj=
ekte/Coccinelle/janitor/delete_redundant_if_statement-by_Julia-20240218.co=
cci
=E2=80=A6
real    0m47,888s
user    0m47,238s
sys     0m0,304s


> In the former case, it first matches stmt at the end of the semantic
> patch, that can be anything.  In the latter case, it first matches the i=
f,
> then binds stmt, and then can easily recognize stmt earlier in the code.
>
> There will be no changes in this respect.

Which evaluation order for the shown source code search and transformation=
 code
(according to the semantic patch language) will become more desirable fina=
lly?

Will development interests grow to reduce the software run time difference=
s
(according to the demonstrated application of a higher level metavariable =
type =E2=80=9Cstatement=E2=80=9D)
for an SmPL conjunction considerably?

Regards,
Markus
