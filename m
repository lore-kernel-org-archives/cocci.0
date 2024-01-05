Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5994FC3DA6E
	for <cocci@archiver.kernel.org>; Fri,  5 Jan 2024 20:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=N9JSccww3TZfyD6pJaZWwWwkm78EBQwtrdNmntJLG6I=;
  b=lX5Ug0V/r/FuCxAUwEh10Rgwyiz1YAGrBfmzReh96nFGrhmTSeB8AYtZ
   LFgk1GIlW9AZeE14s5UCUKULlRgaDUaxH+F0/HMUaQAyAHLCDBQorROcF
   IoI2PxAxq6elLcUHghTGPYQ/wGQOE0/fN+Vm3aaSTeLeQrVFtohHkA7Nd
   k=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,334,1695679200"; 
   d="scan'208";a="145139961"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Jan 2024 21:00:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 14EA2E0CCA; Fri,  5 Jan 2024 21:00:38 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 05B65E004E
	for <cocci@sympa.inria.fr>; Fri,  5 Jan 2024 21:00:36 +0100 (CET)
IronPort-SDR: 65985fe3_E/uQ+08ntmqBjsaXGQLgDpUUFjCkzbn5iy8XIyKXNOOu1B6
 sy0WOLPhHgViMby09V1iJrSHWNcz0YXD2VKAWCA==
X-IPAS-Result: =?us-ascii?q?A0EDAACjXphlew4P49RaDgsBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAQEBAQEBAQEBAQEBQIE7BAEBAQEBCwGCOHxWMgQLSIRTiB2JGS0DhDuPA?=
 =?us-ascii?q?YRrhASBVoFAPg8BAwENOwYBAgQBAQMDATiERwKHOgIeBwEEMAkOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABASQYBg4FCyeFbA2CXAEQgQyBH?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAg06Q?=
 =?us-ascii?q?QEBAQECASMdAQERJgEECwsUAQUCJgICVgYBEgIBAYJ8AYIqAQMOIwcNBrAce?=
 =?us-ascii?q?oEygQGCCgEBBoFFAgwCQ06sch8sIlaBYAMGgRouAYgaAYVng0F6Jw+BVUSBF?=
 =?us-ascii?q?SeCUjE+gQUBgVsDgSY5g1uCaIIcg0KPPVJ/HwOBBQRcDxsPHjcREBMNAwhuH?=
 =?us-ascii?q?QIxPAMFAwQyChIMCyEFVQNABkkLAwIaBQMDBIEwBQ0aAhAaBgwmAwMSSQIQF?=
 =?us-ascii?q?AM7AwMGAwoxAzBVQgxQA2UfMgk8DwwaAhseDScjAixCAxEFEAIWAyQWBDQRC?=
 =?us-ascii?q?QsoAywGOAISDAYGCV0mBw8JBCUDCAQDKykDI3QRAwQKAxQHCwdpAxkrHUACA?=
 =?us-ascii?q?QttPTUGAwsbBj0ClEkBgjd7EyoCghM3xQE0B4I0gWCBYQyKGJUTBhMvlyYOB?=
 =?us-ascii?q?pJULpgfIItUgXaVR4U1gWM6gVwzGiSDNk8DGQ+OIBeEFIELg1aKIAgBPUA1A?=
 =?us-ascii?q?jkCBwEKAQEDCYVGAQGDJjSBRgEB?=
IronPort-PHdr: A9a23:kpV23xMV8vhHgshXwYkl6naWBBdPi9zP1u491JMrhvp0f7i5+Ny6Z
 QqDv6Ur1gOYFtyBtrptsKn/jePJYS863d65qncMcZhBBVcuqP49uEgeOvODElDxN/XwbiY3T
 4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx7xKRR6JvjvGo7Vks+7y/2+94fcbglWhzexe61+I
 RqyoAneq8Uan4tvIbstxxXUpXdFZ+tZyWR0KFyJmBry+tm+94N5/SRKvPIh+c9AUaHkcKk9U
 LdVEjcoPX0r6cPyrRXMQheB6XUaUmUNjxpHGBPF4w3gXpfwqST1qOxw0zSHMMLsTLA0XTOi7
 7p3SBLtlSwKOSI1/H3Rh8dtl69Qvg6vqAJjzI7VeIGVNeRxfqXBfdMBWGFNWt9dWzFdDo+ga
 ocCCfcKM+RFoInnv1YArhWwCgaiC+3yyjFGmGH73aM43Os9Hg/LxxAgH8sUvXjIsNn5KqUfX
 Oaox6fI1zXDaPZW1C/65ofSaBAhouyMXaltesTezUkvGRnFjlSWqYzqIjiY0eMDvHKB7+pjS
 OKvkHQrpQ51ojih3Mcsi4/Jho0Ox1HK6yp225w5KsCmR0NiZ9OvDZRfuT2AOYRsXsMiX39nu
 Dw8yrAepZK2cjUHxZsjyhPCdfGKbYmF7xbtWeuMITp0mn1odayjixuz70St1+3xWMe73VtUq
 idIncTBu3QM2hHN5MaKV/1w9Vqv1zaI0gDc8OBEIUYsmKrYNZEh2LgwmYQXsUjZGS/2gkr2g
 LeXdkUi4Oio6v7obq/opp+GMYJ/lwLwMrw2l8ChHOg0LBICU3aF9em+zrHv4E30TK9XgvA5i
 qXUtJ/XKd4Vq6KkGQNY0YYu5wy7Ajqm1tkTgGcKLFZYeBKck4jmJUvOLu35Dfa+nVuhiCtny
 vbbNbP7GJrNNGLMkLL5cLZ99UFczA0zwMha55JTF7EBPOj/W0Hvu9PDFBM2LhK7z/7mCNV7y
 IweRXqCDrGEPK/Mq1OE+PwjLuuWaIMIuDvxMeUp6vH2gX88g1AdfK2p3ZUNaHC/G/RrO0KXb
 mD2gtcCDGcKpRAyQuPuiF2MSz5TZnCyX60n6zA1Fo2pFp3PSZ2zj7CZ2ie0BYVZZnpaBVCUD
 Xfoa4KEVu8RZC6KOM9ujiQEVaS9S48mzRyhqAj6xKZ7IerV4SAYrpLi1N1t5+LJjx0y9Dp0D
 96c026XVW10kHkIFHcK2/V8rFZ7x1PG06F+guBfD8d7+fxESEE5OITawug8DMr9HkrFf9GUW
 BOtRtaOHz48VJQyzsUIbkI7HM+tyljH3iy3E/ocjbnOB5Eu9K/Y93zwPNpmjXfA2rMog1QvT
 o1IL2Lizqp+8RXDQo/Mg22fh77sfqMZmGbO+X2FwG6mpExeXxNsS6LDXGBZakaS5f3z60eKc
 bK1APxzOwFMzdCPMaJiadDzi1hCAvD5N4KaK0ewkGe5CBLA+q6WdZfnZ3kQlHHYFFUeih0e4
 WqLHQI3FyOgqXjTSjdpEASrK3vh9+Y2hnq9BhsswgeFKUNo0ZKz6gZTjvuZHbdb5bsfsyco4
 xV9AVunl4bNTdqJugd7VL1RZ9wg/E1A02PJ8QBwaNjoFKBrmVhWXBlw9xf11xxoDIpdluApo
 WkswQ40LriXhhcJTC+VxZD9PPX9LXj+tES0YanH1nnd3cyQ96NJ7+43/RGrjgGgEEor9D1Hz
 pEBwXaG4cyQVVNJeZLsSVpx+hRn4brcNHoT/YTRgFhlK6qpqXfv39wzBe0qgkKFds1cLbjCO
 Qv8CcwcCOCxJeZsl1X/PUFMB/xb6KNhZ5DuTPCBwqP+eb84xFpO7ExC6YF5iQeX8jZkD/XPx
 9ADyu2Z2Q2OU3H9ik2gu4b5g9MMfikcS0y4zyWsH4tNfutqZ49eLG60INCsgPh6iYTsXXFw6
 1OpQV8Li4eyYRTHV1XmxkVL0FgP53mumC+21TtxxhQgtKmCx2rjx+r4dRwIEnFGTi9ugASkO
 pC62vYdWkXgdA01jF2l6EL9krBcv7h6JnLPTF1gei/rMyd9X6H2urfqj9dnzpQuvG0XVe29Z
 QvfUbvhu14B1DulGWJCxTc9fjXsu5PjnhU8hnjPZHB05GHUf81933K9rJTVWOJR0zwaRSJ5l
 SifB16yOMOs9MmVkJGLu/63VmaoXJleOSfxyobIuCy+7GxsSRqx+pL70vjuCwsnymnW09dwV
 CPHhAnxaM/n2uXyMO5qeFVpGE6p89BzScl1loo9go1V2GBP3MzPuyBdziGqbJMChfGbDjJFX
 zMAzt/L7RKw3URiKinM3IflTjCGxdMnYdCmY2QQ0yZ77sZQCa7S4qYX+Ek96le+sw/VZuBw2
 zkHzv57olsTmeIUo0wAyiuHA7YdNVZVN2rgml7birL25LUSf2upfbWqgQBblMqiEarEjwVSQ
 nf/db89ECU24sg1YzeumDXjr4rjftfXd9casBaZxgzBg+ZiI5U0jvMWhCBjNAoRpFUdwvUgx
 Vxr1JC+582cLnl1ubm+GlhePyH0YMUa/nfsi7xfl4CYxdLnEpJkEzQNFJzmKJDgWBcbr/f6L
 ECjFDMmq3GUMaXSF0mT5Q9qomnOHJaiK3yMbCNAl5M4HkbbfREZ2VxcVS5yhpMjEwG22MHtF
 SUxrisc4FL1sFoEy+5lMQX+TnaKoQ6pbjkuT53MZBFS7wxE+wLUKZnEt7g1RXsHuMT86lXRe
 Qn5L0xSAGoEW1KJHQXmN7iqvpzb9vSAQ/G5N73IaKmPrupXU7GJw4iu281o5WXpVI3HM398A
 vk8wkcGU2p+HpGTvjwVSDEM0Q/JYdSaohiU5SB96MyyuqeOOkqn9c6UBr1ePM86sTW/m6SeL
 Ki9gChjKDBX/owBzznExfJMuTxawzErfD6rH7MasCfLR6+Fga5bASkQbCZrPddJ5aYxjUFdf
 NTWgdTv2vtkn+Y4Xh1bAEf5lJjjNqloaymtcUnKD0GROPGaKC3XlovpNLikR+QYjf0I5Ufp4
 3DBSRClZ27d0WCzB1f1bIQuxGmaJEAM4tjnNEw3Vi66EZS+LUfmeN5v0W9smOdy3CmVczdDd
 2A7KRwFr6XMv3kB3bMgQSoYvyAjd7XU3HzIiouQYpcO7ak7WGItyb8cuSlrjeMStn8MReQpy
 nGL8Zgx+Rf8yrbJkn09D1JPsmoZ3tvU+xo4f/yIrN8eBTGeondvpS2RE0hY94EjU4Oy/foKm
 56Wz/q7KS8eoYKOu5JCWo6Oc5rBaiBpJxPtHHS84BItazmtOCmfgkVclKrX7XiJtt0hrYCqn
 pMSS7hdXVhzF/UAC00jEsZQaJFwFigpl7KWlqtqrTK3sQXRScNGv5vGSuPaAPPhLyychKVFY
 B1AyK3xLIAaPIn2k0J4bVwykIPPEkvWFddDx08pJhczu1lI+WNiQ3cb3kX4dkWy7XVVGfP11
 h86hw1iYPg8oTfh51BkQziC7CA0kUQ3hZDkmWXLKWS3dv3vG9gLTXOo5C1TetvhTg14bBO/h
 xlhPTbAHPdKiqd4MHtskEnasIdOHvhVSetFZgURzLeZfaZNsxwUpyO5yEtA/eaAB4FlkV5gV
 Je2rG9bnS9nYsQ0I6P4O6dDiFRdzPHr3GfgxqUqzQkSKlxYunuVYzINsVcUO6MOIi214qpz5
 AbElzYJKw1uH7I65/lt8E06IeGJySnthqVCJk6GPOuaN6qFumLEmKZgo3s10V4U0VZI9/563
 JV7G6J7f18ixv2dGkZQXSInAR5YZYxe+SqLFRs=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ruN97axrzwCeTJfQfLyTKrPw+L1zdoMgy1knxilNoNJuA6ilfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bBYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebrN5DNB7foSjjPIduoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:nExyV2GVBNcdK5kVqmJWzRMpHNkuSUHz40mBfRafBXg5ZbS8HAo=
X-Talos-MUID: 9a23:d6zDWgU23YUFPwjq/GHCqAhQd+5R2qTwM1gNkrUlidiZZDMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,334,1695679200"; 
   d="scan'208";a="75983243"
X-MGA-submission: =?us-ascii?q?MDEKOk9UxQsU8Pzxgbs7GvtmLZNlwCCS2nLi2l?=
 =?us-ascii?q?Jc7nckaEnFyoQT+ttIWzOEX8lJXbscYm3tEqb08wJdS7uCNwcTA0V0nV?=
 =?us-ascii?q?yXrfC4NX7q0/jKqjXsnyy0kO8NfrtVaGVpbltU6pJN9IrWMmKMGrKaHZ?=
 =?us-ascii?q?0bSErnHZWAqvqkXiVLrHP1Ew=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 21:00:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704484819; x=1705089619; i=markus.elfring@web.de;
	bh=7tKN9THIKO8mzprnhNgRdQfDAhpFFaMZeNyl5X57Uk4=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=CwIa9wnVA4pyddnDoXHRiF6n/xRqqyAEPRIdWC7MHKJRe/yjNQ1mIcatZ1Tc6GVG
	 KCeKgNrX3UNiE70xrYlABgOj+RlB7Lozhvz2Agf1Fm3vGvCIKMNRXCtpruk7+AVEW
	 h8vY9X3MRhlr/0OjqxRi9yLsoygYK7Pz0Vtv82cQQmtIwyXoRtXjrXBMH/S1k+oG0
	 oD9Do5ml16+xZkThoA/ijiUOzVv6y1bxllzISyYAW3DYMJ0C2wveEQkLq8DBZTE7Q
	 OeNeS9aHhGyACWVVy0DjY0clD5kvevTDKm7V7BqbbUJ0KUk+ArP5YlXRvRxtZfRJw
	 I5K5rCylCNF0UqwHgg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mtguh-1r41Ou11mp-00ujzR; Fri, 05
 Jan 2024 21:00:19 +0100
Message-ID: <b8aa03e0-a375-40cb-b12a-7a100a49247d@web.de>
Date: Fri, 5 Jan 2024 21:00:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
 kernel@pengutronix.de, Abel Vesa <abelvesa@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Zhanhao Hu <zero12113@hust.edu.cn>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <20230601033825.336558-1-zero12113@hust.edu.cn>
 <cf7b69f4-c4b2-5160-e19a-14c272b0dc6e@web.de>
In-Reply-To: <cf7b69f4-c4b2-5160-e19a-14c272b0dc6e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ix32BVSsWMwSZ6Vh5wdmlGvAtykyML3TrHZxPYOle17n3AW20uX
 X+uvlkuJHgff6iM3+VxV8y5npFJ0VopTxi92S6+mAx/UUXpF0OpHrfHidwB57yDfAMPMMhX
 UFzf2ZfEmVTFxIHTI7wl1hjviFq2DNlid7KHBLxqTGf9gUUp19DYWFK2rUKhP23BamJvr3g
 306mEbXRZbc31cmESO9Xw==
UI-OutboundReport: notjunk:1;M01:P0:wFOxBD+xYDk=;IzyD/+s2SdULrl+/cVGgHxXVVdX
 pc9s8QrmnTN3LdZMtPCzXu944QwG4FwGrFJl9kwoVplzJWo6cEBD0i9srcGqktklicFKe8OYo
 WctTQKZZfsgVHzSIlsS2eJ7rQr6r38/2LtcTZKfsbu7E1SoObZYJh3vDx5AcSw1lHiAgaMAAs
 GeNaQTIdKcoYNPM6uzuAt49W7+a3phEtj2X1Gu99GsrygSqSIwyqmFSna9w7SMET5QjAEDX/X
 h4+syBqdERtceKqMabELRwi0zDUpAI5YZfo59lJC0Tfo7hjhoDM/XfWEtvIM5/3sIzd+LFH9G
 5XkE8GjgfS4Bft9U24NXrFtBvVoGiZ5l/4NN5ve5cyYTTLNIwXjfWlTz3P/ejiSb7UZSQUIup
 rMztxdmf9NRQsWy2BObLQkQETNsi78vnXqYaO/qdNFwBPt0nKYcvq044VYbOwEhqChW7/Rjgl
 9BbpaXRp7iyyl2Q2ytxkEHYm4s3FaghYMbsfuL7Tw5vAZ8u1FCsu8vhLFKy6omyPByng0cKI6
 8jgDoU/fIrVl3QGVIQ1Uiu5YcY6UI9qKHm95JMMKTzQog7heMSsE/dRfyrJKzlaKSbwDRMf0q
 TZdWmt2h9hGsVBhZ1D0vEQmEqJfYyT/TNgSsdSDnV0iLNLgoSxbStaaq0Om4ETPuDeXtNzJH6
 N/blfoiaJH5/f1vWennq8JbvqRTt5Mvidt92h5jwcLWqF70L4vfGzVJJ8/DfqTzK1HTb72rFp
 WN2cf8hfJjBoMtp4J3/aVaXkqOoTVVeNGKKSDG+G4rSW8gj9pfO1CBNae8hUR79VjfhIHBycv
 gxrIXtFLvq8HdLQLG1lLMpOvVtv2CoKkAKArMZn//kLqxnjq5Yszvim5c0MHQHGG2OsDf6LV4
 t2f2wNYNSIHwP8BgocNI25C0CnZ07fsZqfvl4TXR71FketuOr3bDtFqgLs57XmbkcsMBHhbDi
 1RKQD8rf/QT6JAwCrBa8R5kdEA8=
Subject: Re: [cocci] [PATCH] clk: imx93: Fix an error code assignment in
 imx93_clocks_probe()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1435
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/b8aa03e0-a375-40cb-b12a-7a100a49247d%40web.de>

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 13 Jun 2023 21:50:50 +0200
>
> The variable =E2=80=9Cbase=E2=80=9D was passed to a call of the function=
 =E2=80=9CPTR_ERR=E2=80=9D
> in the implementation of the function =E2=80=9Cimx93_clocks_probe=E2=80=
=9D.
> Unfortunately, the variable was not assigned to an error pointer
> before this if branch.
> Thus use the variable =E2=80=9Canatop_base=E2=80=9D for an error code as=
signment instead.
>
> Fixes: e02ba11b4576 ("clk: imx93: fix memory leak and missing unwind got=
o in imx93_clocks_probe")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/clk/imx/clk-imx93.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
> index b6c7c2725906..44f435103c65 100644
> --- a/drivers/clk/imx/clk-imx93.c
> +++ b/drivers/clk/imx/clk-imx93.c
> @@ -291,7 +291,7 @@ static int imx93_clocks_probe(struct platform_device=
 *pdev)
>  	anatop_base =3D devm_of_iomap(dev, np, 0, NULL);
>  	of_node_put(np);
>  	if (WARN_ON(IS_ERR(anatop_base))) {
> -		ret =3D PTR_ERR(base);
> +		ret =3D PTR_ERR(anatop_base);
>  		goto unregister_hws;
>  	}
>

Is this patch still in review queues?

See also:
https://lore.kernel.org/cocci/cf7b69f4-c4b2-5160-e19a-14c272b0dc6e@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-06/msg00016.html

Regards,
Markus
