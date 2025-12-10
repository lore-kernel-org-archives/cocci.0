Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CC9D3C52A
	for <cocci@archiver.kernel.org>; Wed, 10 Dec 2025 11:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=7vJr52SGAYOe4lXILP1aRuCCPUL/DGgiN2SfC8Ju3YA=;
  b=DqrTJmAlQHLrp3/BRcAOU3FNQA1uIlzytuq2ffWhyaohmZvehhv2uxX9
   DdlDY8aPGRb5pbkmVVE7000hQYvwg+UKYKdm5p2zTca68l0tZVyrrFkac
   XvhWFdg02aaCmMnrJXxDuLPWN7NnQfAq22JdCSDw5Sbd47A5/EWvmR6rd
   U=;
X-CSE-ConnectionGUID: Zdu6FLUfRs6GqCV4JT7DlQ==
X-CSE-MsgGUID: rUmXIwkpRpOc22Big2Gs2Q==
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
X-IronPort-AV: E=Sophos;i="6.20,263,1758578400"; 
   d="scan'208";a="253740476"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Dec 2025 12:12:38 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 398B081239; Wed, 10 Dec 2025 12:12:38 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (dsi-ha-lb1-dmz.inria.fr [128.93.162.100])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id C1EAA80FC9
	for <cocci@sympa.inria.fr>; Wed, 10 Dec 2025 12:12:35 +0100 (CET)
X-CSE-ConnectionGUID: sHAgHsssQYugVW0MdhxR8g==
X-CSE-MsgGUID: FmKBEKR/Sq6y7t16n3/ENw==
IronPort-SDR: 693955a3_NTEVlK6GMmYERrgMnLv2V/XbvnKMaE6G+QlmnFxAWP2k95I
 ULgFHzSEve4NdZxGpEIsmp9Q/W8eCmi++nYFE4A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0F/AAD9VDlpgAQP49RaHQEBAQEJARIBBQUBQIE+BgELA?=
 =?us-ascii?q?YI/ZyVZMwQLSYRVj1OCJIQ7hzyHVYpOgX0CDwEDAQ1OAQIEAQEDBIIMgnQCj?=
 =?us-ascii?q?GgCHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QE7Bw4KMYZPDYJbgSyBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJgEEC?=
 =?us-ascii?q?wsODAImAgJWBhUBAYJ+giMBBhABAw8nB7J9gTKBAYIMAQEG2mEfLCJZgWQJg?=
 =?us-ascii?q?R0uAYVtgmUBimYnD4FVRIE8gwM+iB6CaYImgQ6ZXlJ4HANZLAFVExcLBwWBI?=
 =?us-ascii?q?EMDgQsjSwUtHYEjIR0XE2A9F0CDSRgGaA8GgREZSQICAgUCQDqBZgYcBhwSA?=
 =?us-ascii?q?gMBAgKBDQyBdwICBIIVfoIKD4dFgQgFLoE2AgELbT03CQsbBj2VDk6CK6h2o?=
 =?us-ascii?q?UU0B4I4gWeBZAyfbAYTL4NxAZNgDgaTBZkGqUCBbwgrgVwzGiSDNk8DGQ+OI?=
 =?us-ascii?q?YQzvnlCNTwCBwsBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23:ZdNHAxQBi9bda0Yayvp0JIcMatpsoleVAWYlg6HPa5pwe6iut67vI
 FbYra00ygOSAcODs7ke0bCI++C4ACpcus3H6CtDOLV3FDY7yuwu1zQ6B8CEDUCpZNXLVAcdW
 OlkahpO0kr/D3JoHt3jbUbZuHy44G1aMBz+MQ1oOra9QdaK3Iy42O+o5pLcfRhDiiajbrNuN
 hW2qhjautULjYd4Jas8xBTErmFUd+hKym9kO0yfkwj968yt+JJv7zlct+gu+sNOX6j2Zbg0Q
 LJdAD87L207+crnuAXMQgeI+nYSSHgdnABSAwjC4hH6X5PxvTX/u+FgxiSUPtD4QK4tVzi64
 KllUBDnhD4ZOjA27W/bksN/gr5VrxKnvBx/3pXbYJqJO/pkf6PSZs0VSGxcVctMTSNBA4e8b
 4wSD+odOOtTsofwq0cSoRa4GAKhAv7kxD1ViX/sxaA00OovHg7I0wI9AdwOvmrZotX3O6gOX
 u6417XIwDfZYv9KxTvx9orFfxY8qv+MR7Jwds/RxFEoGQzflFWQqpHlPyiI3eoCt2ib4fBgV
 eOpi24otgp8pT+hyd02ionKm4IV0UrI+yp9wIY7P924SUh7YdG/HZpeqS6VLJF6Td48TGxxv
 isx17IJt4KhcicQ1JQn2wDQa+aBc4WQ7RzuW+afLzl7iX57Zr6xiAq+/Eqjx+HhUsS501hEo
 CRbntTCq30D1wDe58yHRPVy4EusxDiC2g/P5uxGLk05kazWIIMizL4ojpcfr1nPEjHslEnok
 qObdF8o9vWo5uj9bbjqvpuROoBuhgzwL6gigM2yDOAiPgQQQ2SW9uKx36D580LjWrVFlPg2n
 7HZsJ/EIcQboba0AwpS0oY+9xazFTmn38oDknUdMV1KZgqLj4nvO17QPPD1Femzj0mynDtx2
 fzKIL/sDo/QInXDirvscq5x60tGxwoyydBf6YhUCrYEIP/rXUH+rsbYDhwkMwyv2erpB9F91
 o0EWWKOBK+ZP7jfsFGW6e00OeWDeZEatC7nK/c5//7ukWM5mVgFcKa12psYdGy3HvV9LkWCY
 Xvsh88BHn0Qsgo/SuzqklyCXiRJa3a8RaIw/jc7B5m+AofZWo+tmKCB3Du8HpBOe2xKEl+MH
 mnvd4uHQfkBcCycLMB5njweS7ehVYwv2wu2uQ//zLpnM/bU9jcWtJ39z9d5/fDcmg8q+TNpD
 MSd0mSNQnlskG0HSTA4wrxxrFB7xFubzKd4huZXFcZP6P5RSgk0LIbSweNiB9DpQgLBcM+ER
 ky6T9u7HD89Vskxw8cAY0llG9WtkBTD3y2yDrENjrKFHJM6oerg2C3ULtp9yn/dnIo7hkQ9T
 4MbMGygh7Z79iDcHZXEmFiDlrq7M6IRwHie2n2EyD+rtVtbTRU4fKHLR3EZaQOCiN3j5V7ZC
 ZKqB64mNARp1sOIbKdHPI66xW5aTevubYyNK1m6nH29UE7gLtKkaYPrfz9YxyDBEA0elAtV+
 3+aNA84DyPnomTEDTUoG0i8K1j0/7xYr3W2BlQx0xnMd1dogp+84B0InrqxT/0J37QLkDgso
 XN4EQX1xMrYXuKJvBEpZ6BAeZU46VZD23jesllYN4ajMrskq1oQaQVxsGvx2h8xBogT2dMyo
 iYMywx/YbmdzEsHdz6c2sXoPabLL2Dp4B21Q6vRx02Yz9ucvKsCgBghg3PkugzhVk8r8nE9l
 sJQz2PZ/JLBSgwbTZP2VE8zsRl8vbDTJCcntcvS0jV3PK+4vyWnuZphDfY5yhumY9ZUMb+VX
 A70HcoAAsGyKess01G3ZxMANepW+eY6JcSjP/eB3aeqOq5nklfExSxi6Zp+z1nK2i5yUO/O0
 L4azvve0gbGHzbwgVG9s9zmzJhebGJaFW6+xC74QY9JM/crJ8BRUzjoepDxmoYb5dalQXNT+
 V+9CklT3caofUDXdFnhxUhK0k9Rp3W7mCy+xjgykjczr6PZ0jadpoaqPBcBJGNPQ3FvyFn2J
 o3hxfUTRku1dE4EkBW/5ED177dWruJzIiOAJCUANzizNGxkXqaq4/CnatRM9YhunCFZSuW6b
 niFR7S7rxZQgEaBVyNOgTs8cT+toJDwmRd33XmcIHhEp33cYchsxB3b6bQwXNZp1yEdDGl9g
 DjTXB2nOsWxuM+TnNHFu/y/UGSoUttSdzPqxMWOrnnz6WpvCBy51/e9/7+vWS0zyyzmzJ9HU
 SvSrRDzSpbm3eK2PKprc1JpC1n198dhUtsnyM1q3s5WgCVc2t2c5jIfnH32MMlH1K6bDjJFX
 jMNz9PPoUDk1EBlMnOV1tf8X3SZzNFmYoryaWcX1yQhqsFSXf3Ntvoex3Qz+wf+8VG0A7A1h
 DoWxPow5WRPhugIvFBo1SCBGvUIGkIeOyXwlhOO5tT4raNNZW/pf6LjsSg21d2nEryGpRlRH
 XjjfZJ3Vwp59MZiKxTh1HPp64frUMbdZ5Qfu1fH9nWIx/gQM583mvcQ0GBCMHj+oGZj5uo1l
 x1o0rmlsYLBJ2gnr8fbSlZIczbyYc0U4DTki61Ty92X046YFZJkAjwXXZHsQKHgAHcIuP/gL
 QrLDCwkpyLRB+/EBQHGohQDzTqHA9WxOnqQPnVc0dhyWEzXOhlEmA5NFDxom5kkCka1ycanf
 Eox72IU4UPk7wtCzfh3PgPzFHjSrkGkZ1JWANCWfh9R8x0H7UDIN8eTqP1+FWdU89Wo/gmKN
 3DebB9CEGUKHBWNAVy6eLKp4Lyiu6CRVO+5MueLaq6FrvZGEa6Bw572lIBh+n6aP8GLdBGOF
 tUd3UxOFTB8EsXdwXAUTjAP0jjKZIidrQu9/St+qoa+9u7qUUTh/9nHDbwaKthp9x2s5MXLf
 +eNmCZ0LypZ3ZIQ1DfJzrYYxlsblyBpcXGkD70BsSfHSK+YlLVQClYXbCZ6Nc0A6KxZvEEFI
 cnAltb8zaJ1lNYwDEpZE0PskIelaI1CIm2wMk/GGFfeNLmCIm6uoYm/aqe9RLtMyeRM4kfp4
 3DBSRClZ2nFy2qMNVjnK+xHgSCFMQYLvYi8dkwoEm3/VJf8bRb9NtZrjDowyLlyh3XQNGdaP
 yIvFiEF5rCW8y5che1yXmJb6X8wZ8yNgSWE9K/1LpgMsP1kKjt5naRW7T5prtkdpDEBX/Fzl
 CbI+5R2pEq6l+CU1jd9eB9JtyoNm4+B+0lvc/a8lNEISTPP+xQD6n+VAhIBqo5+C9HhjKtXz
 8DGiKP5LDoqGzP8+MwBG47LJcjBPHdzaXIB9xbLAQFDQTP5bAk3YmRCnfvU+nDH9vAH
IronPort-Data: A9a23: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
 AzwUQ==
IronPort-HdrOrdr: A9a23:b9/iMaE4JCvpO2BUpLqEPMeALOsnbusQ8zAXPo5KOHhom7+j5q
 WTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: 9a23:ebrCCm5PMRuNSe5w2dss7249FeA+aWbk/WrfHXDgLGppWIfFRgrF
X-Talos-MUID: 9a23:kA7jdwS123s2e6SuRXTCgRJIGeRSpJ+3VlFSjcxYvZLDGApvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,263,1758578400"; 
   d="scan'208";a="253740464"
X-MGA-submission: =?us-ascii?q?MDGrYaqcyUfoQ0MdQ39T/N9IDMfvDQc31WvhY+?=
 =?us-ascii?q?yVo0ln5xhR3cxls0Ms179vkcF1TtHuzq0tt0pse74vaJNJyEKcfma5q0?=
 =?us-ascii?q?VZ69/aoIu4s+sTIfxxOjKJSqumSoWMnHHzqHF//MGQ6Vn8ZQsEyjM3Qn?=
 =?us-ascii?q?Wv1AFs5kO6Pi6M12OuXjbhsQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 12:12:35 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.204]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHmq2-1vHkzk2cyc-007qaq; Wed, 10
 Dec 2025 12:12:34 +0100
Message-ID: <fb348ba6-0d58-4e94-b86e-b620cc60c2ce@web.de>
Date: Wed, 10 Dec 2025 12:12:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mathias Krause <minipli@grsecurity.net>
References: <ccea6cbd-8c39-425d-93ca-0685c8154619@grsecurity.net>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ccea6cbd-8c39-425d-93ca-0685c8154619@grsecurity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:IHOdypPXCRW6/G0TdmVAdnsv0me/PVGkHX0R4voULKfNF8g0p++
 HbMzw5ZDs+GjeK30TuSR2IZmlEmTAvHOZYTzO1EYbWIiFsucW+FO9rtLOca+cJFg4fsqRuG
 M20oXkLN07A8j8XVxJLx7azPK0WQCPe4fF4JTM/yHghBhbmvdlnsttpY/uNChI7gAPMb9UL
 Smm7lPSzi17AdEkfn1n3w==
UI-OutboundReport: notjunk:1;M01:P0:fu+sAI5jPaw=;xXY1lFlaELl7KfPaG2cCn1rKsr9
 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
Subject: Re: [cocci] Matching function pointer casts
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3259
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2025-12/hhbekyWZxFizziswWxPGRQ>

> Is there a way to match function pointer casts in spatch at all?

How do you think about to construct another test case variant
for the desired software clarification?

Regards,
Markus
