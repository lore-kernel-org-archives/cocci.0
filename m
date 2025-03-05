Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67A1C19F32
	for <cocci@archiver.kernel.org>; Wed,  5 Mar 2025 14:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=C1xWGzwYPulTit0Q4OqYEAYIGUZud3a18Yr5KId4AB8=;
  b=fx9brrsowWXKUn9+jOgJcYUFAbAjtYBYWJVJRGlYpkBnuiSKrY6oA3HW
   OfdW3vCD/pU1FU6zpFyZ5MNzkiR99b285hQmE7VZvNuU0H9osqwtHqQ/K
   p0F64XNeN3R47Gmjy2AwFG7v2euXNxL68rWRYo3UCZuY6lF7psvZwbGdd
   E=;
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
X-IronPort-AV: E=Sophos;i="6.14,223,1736809200"; 
   d="scan'208";a="211349326"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Mar 2025 15:21:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9FD9FE0D1E; Wed,  5 Mar 2025 15:21:29 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9C189E0260
	for <cocci@sympa.inria.fr>; Wed,  5 Mar 2025 15:21:27 +0100 (CET)
IronPort-SDR: 67c85dcf_dHXttZ4hnFIeTZ88+xxEIaT8S1C3dyGk/cWNIaRDe2NIpHk
 8jdF/0CzR40yajcKtd4wWZ2kGMGD1s8UQS2vxOQ==
X-IPAS-Result: =?us-ascii?q?A0EkHQBAXchngQsR49RagQmBU4JEYhtaMwQLSASEUo9Pg?=
 =?us-ascii?q?XQtA2mDUo8OhG+EBoFWFIERB1IPAQMBDTsGAQIEAQEDBDiESAKLFgIeBwEEM?=
 =?us-ascii?q?gcOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAcCEAEBOwcOCQExhXsNh?=
 =?us-ascii?q?AeBJgEBAQEBAQEBAQEBAR0CDTpEAgEDIwQZAQERJgEPHwEFAiYCAlYGARICA?=
 =?us-ascii?q?QGCfgGCLwEDMQcNrzV/M4EBggwBAQbaXB8sIleBZQMGgRouhWyCYwGGJoNCe?=
 =?us-ascii?q?icPgVVEgRUnC4M2gkqBQCCDdIJphB2DPYFsilUcLYIlmTOBTRwDWSwBVRMXC?=
 =?us-ascii?q?wcFgTkzAyAKNBQEGQIUHQ8GEARqeoJFaUk6Ag0CNYIeJFiCK2oEBYNbhD2EQ?=
 =?us-ascii?q?oI/UYJCghFxgRqHf4EyhHIdQAIBC209NwYDCxsGPaFtATqDRnyBDhQYUHN6D?=
 =?us-ascii?q?cYTNAeCOIFmgWMMiimVNQYTL5dGDgaSfAEuh2WPcnkii2qBeZsugW4HLIFcM?=
 =?us-ascii?q?xokgzYfMAMZD44tFoQLhGCKKgG5G0I1AgE5AgcBCgEBAwmFRgEBiiCBfwEB?=
IronPort-PHdr: A9a23:necnmB2vh55F1WJ6smDOlwIyDhhOgF2VFgsc6559zqlLbrzm5ZPpe
 krW+fRqilbNG4Td8fNNzeTM4Oj7QWJVx5GHvTgZdYBUEQcfgJAzlhYjHdXDJEn1Nv/sYAQlE
 c4EWFI2t2qjPx1tEd3lL0bXvmX06DcTHhvlMg8gA+3vGZPJyemz2fqz/ZL7fAhCwjawMvtpN
 BvjiwLXu4ENhJd6bKY8zhycunxTZ+Ff3n9lP3qWmAvgoNi99thv/ky8otoH8MhNGeX/dqU8F
 /lDCSg+dnoy74vtvAXCSg2G4j0dVH8Xm1xGGVqN6hayRZr3vibg04g1kCCHIc37S6w1UjW+/
 u9qThHvkiIOKz8+9inelMVxiKtRpB/pqQZ4xsbYZ4ScNfw2ea24H5tSYGNbXdtKEQFFDJm9a
 YQnEOcLe+pV7sH8q1YIsRqiFFy0Huq8gjRMh3Lwweg7y7F7SFuAhlZ/WYtR9i2N/7CXfO8IX
 Ou4zbfF12DGZvJSg3Lm7ZTQNwomqreKVK5xdszYzQ8uERnEhxOes9+AXXvd2+ITvmyc9+clW
 /iojjttjghroSW0gOoohJPIgI091V3Osyl0itVQR5XwWAtgbNioHYEF/QSTLYhrWYUPR29yu
 SA14qILs9i3cWJZrfZvjw6aYPuBfY+S5xvlX+vEOjZ0ikVuf7enjgqz+0ytogHlfvG9y00C7
 i9Mk92W82sIywSW8M+MDP104kam3z+LkQHV8OBNZ04ux+LXLJsow7h4kZR20wyLOybsm1jty
 oKSeF8l/OeA9OntJLnr7pORLI57jAjiP79mwJXlR75ibU5XAC7CoKy1z/X78Ff8QalWg/FT8
 OGRq53cKckB5+a4DwJTzoc/+kO6Bjai3s4fmCpPJ1ZEdRSbyonxbguXeraiV6j52gvqyW44o
 pKOdqfsCZjMMHXZxbLofLInrlVZ1BJ219dUoZRdFrAGJvv3HE73rt3RSBEjYGnWi67qDstw0
 oQGVCeBGKicZen3uEWL+/lpDu2Cfo4Ttx7iJvJj6/Ok3hpb0RcNOLKk25caciXyO/18IFiCJ
 1fojM0AF2gioQc0CuDnwg7nM3YbdzO5WKQy4Ss+AYStANLYR4yjt7eG2T+yApxcYm0VQkDJC
 3rjcJ+IHusdcC/HaNE0iSQKDPLyLu1pnQHrrgLxzKBra/bZ6jFN/4y2z8B7vqXaxxQ16CAyE
 MmXlW2AB2gmm2QVW3om0qdlvkVnxhGc3KI+j/E9d5Qb7qFMVRomcJTb0upxBpbtVwiHctrBQ
 QSjRci6RDoqRM81wJlXakBxQpOpiRWmvWLiCu0QkKGXQZcv+aXGxz6oLsBxkjDN06xpmVAiR
 oEn2XSOoKl5+kCTAofIlx/cjKO2beEG2yWL8m6fzG2ItUUeUQhqUKyDU2pNLk3R5c/04E/PV
 drMQfwuLxdBxMieK6BLdsyhjFNIQ+3mMcjfZGT5knm5BBKBzLeBJITwfGBV0CLYAUkC2wcdm
 BTOfRA5HTukqnnCASZGEFXyfwXz/OM4pH76Bk44wgeWblFwgrq4/hlG4J7UA/gX378CpGIgs
 2AuRQz7hYiJTYPf4VM4L8A+KZsn7VxK1HzUrVl4N52kdeV5g0IGNh5wtAXo3gl2DYNJlY4rq
 mkrxUx8M/H9shsJejWG0JT3IrCSJHP1+UXlTqfM2UzFlvuS9L0O7vsQtFjp+g2kXBlHkT0vw
 5xO3n2Q64+fRhIVSo70W10r+gJSorbHfm8i6omS2XAmYszW+nfSntkuAuUi0BOpedxSZbiFG
 AHFGMofH8GyKeYuljBBgTobMeoU+KNmZqtOltOD37O3evltlnSqgDYfiGiY+l2B/WxwR7yQt
 6s=
IronPort-Data: A9a23:NIBRw69R60IhJxaG2aFmDrUDQ3qTJUtcMsCJ2f8bNWPcYEJGY0x3n
 WcYXGCBbKqIYmH0ftt2OYzloEIEvcKGnIdlHAJrry5EQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHPymYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f7nWcoWo4ow/jb8k4356yv4GhwUmEWPJingneOzxH5M7pEfcldH1OgKqFIE+izQ
 fr0zb3R1gs1KD9wYj8Nuu+TnnwiGtY+DyDW4pZlc/TKbix5m8AH+v1T2Mzwxqtgo27hc9hZk
 L2hvHErIOsjFvWkdO81C3G0H8ziVEHvFXCuzXWX6KSuI0P6n3TEmv80IRgNNokjpbwqDU5X+
 NYoBgs3YUXW7w626OrTpuhEg8M+MI/0MYlZtnwIITPxV698B8qZHOOTupkBhV/chegWdRraT
 +8Qczlyd1LtZxNVO1EYII0zlqGkixETdhUC8QvO+fttvjW7IApZypjVCfPEXcawafpTvX68q
 Wfiz2r1HURPXDCY4WHZoir31rCncTnAcIkVH7a53uV7hUWagG0VEhwfE1WhycRVkWa7XM9Db
 VMZ8GwioMDe6XBHUPGkVUeV+UWPuiVDAYdcPPQ3wjGj8ZDbtlPx6nc/chZNb9kvtckTTDMs1
 0OUk96BOdCJmOLNIZ563ujOxQ5eKRQowXk+iTgsYSZt3jUOiIQ0kw6JUdtpVqK45jEUJd0S6
 2HTxMTdr+xN5SLu60ld1Q6d695LjsaSJjPZHi2NAgqYAvpRPeZJnbCA51nB9upnJ42EVFSHt
 3Vss5HBsLlXVMrUyHLVHrVl8FSVCxCtb2K0bblHQMlJythR0yD+Idk4DMxWfxYwY51aEdMXS
 BSD5FgAjHOsAJdaRfQrM9rqW5tCIVnIFNPjUeucddcmX3SCXF/vwc2aXmbJhzqFuBF0z8kXY
 M7HGe7yVStyIfo9kFKeGb1AuZd1nH5W7T2IH/jTkU/4uYdykVbPGN/pxnPVNrhhtMtpYWz9r
 75iCid9404BDLKkP3OMoeb+7zkidBAGOHw/kOQPHsbrH+asMDh5YxMI6eJxId5WjO5Om/3W/
 3qwfEZdxRCtzTfEMAiGIDQrIr/mQZ81/zpxMD0OLGSY/SEpQb+uy6MDKLoxX70sr9J4wdBOE
 vIqRsSnA9Z0cArhxQgzV5fHkdFdREyZvj7WZyuBSxojTqFkXD3Mq4PFfBOw1SwgDRiXlMoZo
 p/75Dz6XKgsegVGJ+TVYcKJ0FmekyU8muVzfk2QOfhVWhzm37ZLIhzLrM0cAp8zOySY4wCFx
 SO6PAw9p9SRk7Qq8dLMu7+In72pH8R6AEBeOWvRtpSyCgX34UuhxtVmfNuTXDWASl7xxrquV
 d9Vw974LvcDulRA6Kh4MrRzyJMB98ndnKBbwitkDUf0QQySUJ04GUa/3O5LqqFp7Z1as1HvW
 kuwp/9rCY/QM8bhSFMsNA4pa9qY7s4tmx7Q0O8UJXvr7yom7ZuFVkRvZyO3shJ/F4csEo0Zw
 rYGgvU0uiifkRshN+iUgh9Er1qsKmMyaIR5l5U4LrKytC8V5ABjW7L+BBXywqmzUPRXE0xzI
 jarlKvI3Ltd4UzZcksML3vG3MsDpJICvCFLkVwwHHWSu9//nvRs9gZgwTc2aQV0zxt8zON4P
 FZwBXB1Pamj+zRJhtBJeWKnCyVtIQK/wVPg7WcJmEnybViaZkaUIEITYe+yrV0kqURCdT1lz
 ZSk4WfCUweyWvru3yE3CHVXm9a6QfNfrgT9yd2aReKbFJwHYB3gsK+kRUwMjzDFWcoRpkn2l
 dNGzdZKS5/QFHAv+vUgKoygy74vZgiOJzVCTdFf7ao5JzzgVw/o6weeCXKaW51rHOPLw3+aG
 sY1B8NoVjaC7gisgA0fJ5YxJ+5ToKZ0yvsEIqjmNEwXgYu59zBJiq/dxgL6pW0sQuhtr/oDF
 5PsR2qCPFC91XpwsE3RnfZAIVu9MIUlZhWj/eWb89cpNpMkscNwexoMip+ys3GkMVZkzSm1p
 yLGXbfdlMZ5+LRvnqztM6RNPBq1ItXNT9a18Bi/ntBNTNHXO+Lcnlkxhmi8Gj9JL549Zs9Sl
 4nRgOXo3UjAgqk6Y1rZl7aFCaNNw8e4B8hTDe7aM1hYmnGkdPL3wh5e5V29F4NFoOld6uajW
 QG8Tsm6LvwRetVFwUxqezpsKAkcB4v3f5Xfi3uE9drUMSck0CvDMN+D3l3qZzsCdiY3ZrvPO
 jWtsPOqvt1lvIBAASEfPM5fArh6HUTCXJU3fNigpBiaCWiV2mm5gIXAriZ5yz/3CSijKv3Ys
 KL1Hk20MFz4vazT19hWvrBjphBdXj43neA0eVlb4NJszSyzCGkdN+kGLJEaEddunzfv0I3jL
 iT4BIf45f4RgRwfGfk93DjiYutbLukJJ8u/OTEjuU+ZA8tz6EVsH5M5nhqMIV8vEtcg8A1jA
 c4T8Dv8M3BdB7l3EP0L6KXTbfhPn5vnK7Fhxaw5u9P/CVASDN3mEZCn8BVlDUT6Li0GqKkHy
 aXZi4yJrIFXhHMdyfpdRkM=
IronPort-HdrOrdr: A9a23:5FKdg667aAt/PdCfnwPXwBzXdLJyesId70hD6qm+c202TiXqrb
 HLoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:EE2MWG/pLwkjtNvYH2GVvxceQO18SXbZ9yiKfkOXEGtDeJOuc1DFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3ACrbMgw/7mfHYhm07Bcb8jviQf91I252HGWcXq7k?=
 =?us-ascii?q?5veq8ESN1HweTgCviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,223,1736809200"; 
   d="scan'208";a="211349255"
X-MGA-submission: =?us-ascii?q?MDFcl7vhpC+HPrMExN5Jx0GrySTNJ0zR3Lbns+?=
 =?us-ascii?q?SGd1XiuDivB9097Lkp/nWNrWV+YEVd/AIrvdkfA58lwxDXrv3CBze2E8?=
 =?us-ascii?q?TXF+Y2Xb1vLs2/Jvx0aRu0682PT14JnPDxjd+VBa2zINtK8GGd1kuj8O?=
 =?us-ascii?q?dyENkHl/u91nmCOWd3fpFXWQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 15:21:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741184442; x=1741789242; i=markus.elfring@web.de;
	bh=C1xWGzwYPulTit0Q4OqYEAYIGUZud3a18Yr5KId4AB8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OlThstys6j83TWzkyFcMswl/GOTcM3VEpAu3qt2qK287aJw8yBDslqMH3mQ/imIc
	 ynQHBbnKQG5Ku/za3XWJ5+m3vA/mZH4zv/KYgsSIHBDHSgA7/u7mxkHI9WuyaXFH+
	 uCOkNJq52SDtbgZ/26funprLFb4NWXM8wuA3/+OQHNl5A9761SFHclRVPxQflTdws
	 4RMzskm0NStsYCiPDTo/wZlPopdK1S+5b+wDDYy8uD2xPyKTJXaSkF3TmeymsJi8C
	 w8WQEPCUwEB9J04At8isQwHb9dQy6u8ztBApGfpf4LXZyixHJC30zN1OWrm/jnAZt
	 sMqhz2G6D4M2sdfkXQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.10]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MN6Fj-1tZX9L08H7-00I6c4; Wed, 05
 Mar 2025 15:20:42 +0100
Message-ID: <20a1a47c-8906-44e8-92e6-9b3e698b1491@web.de>
Date: Wed, 5 Mar 2025 15:20:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org,
 Cheng Xu <chengyou@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kai Shen <kaishen@linux.alibaba.com>, Leon Romanovsky <leon@kernel.org>,
 Yang Li <yang.lee@linux.alibaba.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <f0f96f74-21d1-f5bf-1086-1c3ce0ea18f5@web.de>
 <167179d0-e1ea-39a8-4143-949ad57294c2@linux.alibaba.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <167179d0-e1ea-39a8-4143-949ad57294c2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K5YWpl1afCIz0GSstMdQrjpKFA5E9zL+d6oUnGlMOn9oeASRXMM
 cxOSbYvrdMcL5omgjTJmGrvhAgOtgemjkpRpepr+oDPbfmNlOhHZBpyRHqrh7cZ7doD1Ioy
 EiDLvYTClCslBiG7DVhc9QPEG9vvNLD9gmYVv1EgQCmnXuJaR/anSsQ/o/eDgMZV1CRGZay
 k0BnV2DvSPWrF3Z170RuA==
UI-OutboundReport: notjunk:1;M01:P0:gkDAiXcZH1k=;xz6JkpFjlNnnbsnyId4VAAQBYB9
 gj4Beb6FayFHM+1bAX90V/bSG3/gQmPupHRKxKzdED9+llmecmGpdQnrUTdasLiJ7oQ/8PEaQ
 zn+NaH5ZETr5WC0U47QwQQFrwZn/poog0ZDEUs2AKFsHlyMGMQ6sO2pYhHXbQsWZZ4qXIiyhv
 bgKWlf1CJPC/2AuLxrk0WZWIBF6Hs0yG68fbjCFl1o8KXdutMD/LufdhzdhZdjdZaNnAWU2QJ
 yWyFLulaOpFNT0fHwx+AgrGJbEKigSIPLM3Du9kYJYBy3h9rQDjdx9vQGClDCs9Q0BiVoxVH+
 85AGZPGzYGhK8kgZuaO02XX8WaP4Rsf9WZpc4weY0A5Hw+atGKJnJUQ4nSMLnZLO6qFOfz/Zc
 1Nx6ezUnWDFFyQffJOKJJpX6R0RA2IrMjXvvojeJAKytVrk8nx+c/9rKw/LQmOnLYKts+lo9B
 /Uc1aLKXi6oaHYE/XaMG5cuLyrwUwVBVrE7UH2J1eoF8wNsQDWRYYSj03nw5yaPivMsTPX/sE
 EGuhlXedguV7tvfa4yS5LQDZc6XlGWcxEOFFpTmxhHUCygUr002AQtANhzNA7TfytfSP0Sk0H
 qrQpVo6c8qNk/TyARLXSwrFOs/cq0Idb86qSZjD/OK5x/VlKCGyDuZrkhBdTGC9uUKj4UgU2C
 h8XYp0qRz/hpf7mmgEHR50eiBnG4AFCzZ3rNRvrOhONSOvkIlvW5JO/UH/Bp3ySsMWRVcGHqT
 wgIFVGOUrCdB1tErrx5DBJ+aruL7TQhouko8vWxlz5r7tvyD84TFi8B/PneQEc6MTIskZm9Xs
 o4vL91KQ/rqLx0e2aKQyLHVEV6wkRwfx0nha+UF//r9sXleqZ+0bmUZm+WDRSo/5xg9vUt0FQ
 +0k9RUnnpILrviowSwiwSQ8vqHAd2ZyLAWSigXVca6ZC3ZI/JekwWPSAhdmzO89j/k6wLV+5F
 iPmj4Ud9diSnNOqarGsbbTJo4oR1UlgIm34w2aaAdEnAhbNcBmKLtZCpH2g8ZhiGBSRmY5/M5
 lnsTAGHxnIISkPnULX/RcI8UlS47DRqE+WVky3nRng1SGq3V8tM0ibq7QgnAOtq48L3tIpOPm
 xBjJXJp28BArO2+pkH+SVh45iDfnzwQfqjNuFPEfxK66aK5RaNb1+QvTL3L78DDj9/+LMSdi8
 KbL8JvI8pa0CDu6YxCRBcK71mnnhq0i/LuLMATBifXFX6UAfGDcTpkAXcfMFsQqOcLlgErtqx
 t3Mt9dbeEQe4YZnomN9dKlTX2QE+r8aneg8h7XiRCjEItR9Itp2UYgqA65mRuIe547q0/fAz9
 go/TF8a/wRy7S89tN567WnVAp08wKSMMPcJFL/lw2s6UyuEvq8SnApJJDLt31+AmWV71H3XdP
 FHtEE/450w7P9JH+VL220PGPgt6m2BkYgMYmWUOwBSaKYmj6V87D/NO7OiZwNsDvrJJ/5d0Kw
 sw0WY6+fVlliAzq2pP77dif5eDBk=
Subject: [cocci] [PATCH] RDMA/erdma: Prevent use-after-free in
 erdma_accept_newconn()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2542
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20a1a47c-8906-44e8-92e6-9b3e698b1491%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 5 Mar 2025 15:07:51 +0100

The implementation of the function =E2=80=9Cerdma_accept_newconn=E2=80=9D =
contained
still the statement =E2=80=9Cnew_cep->sock =3D NULL=E2=80=9D after
the function call =E2=80=9Cerdma_cep_put(new_cep)=E2=80=9D.
Thus delete an inappropriate reset action.

Reported-by: Cheng Xu <chengyou@linux.alibaba.com>
Link: https://lore.kernel.org/cocci/167179d0-e1ea-39a8-4143-949ad57294c2@l=
inux.alibaba.com/
Link: https://lkml.org/lkml/2023/3/19/191
Fixes: 920d93eac8b9 ("RDMA/erdma: Add connection management (CM) support")
Cc: stable@vger.kernel.org
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/infiniband/hw/erdma/erdma_cm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_cm.c b/drivers/infiniband/h=
w/erdma/erdma_cm.c
index 1b23c698ec25..e0acc185e719 100644
=2D-- a/drivers/infiniband/hw/erdma/erdma_cm.c
+++ b/drivers/infiniband/hw/erdma/erdma_cm.c
@@ -709,7 +709,6 @@ static void erdma_accept_newconn(struct erdma_cep *cep=
)
 		erdma_cancel_mpatimer(new_cep);

 		erdma_cep_put(new_cep);
-		new_cep->sock =3D NULL;
 	}

 	if (new_s) {
=2D-
2.48.1

