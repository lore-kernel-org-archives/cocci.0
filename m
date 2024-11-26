Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01ACD65553
	for <cocci@archiver.kernel.org>; Tue, 26 Nov 2024 20:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Le9Otod9mgn08JeaLGuFaQBUOihmKeqMX1vHLv/7ZC4=;
  b=dbIWS9NIkTVQghWBZIIcsrUFWmt9VfviCzQcH5TF95UxTjwa0fiS+TXi
   G0SRL2JWPZvoLXeYmTCIj6Th/zYZQOLIeJwXybZGqdf+c5Nh5sLP1fxbB
   ecXKVfsKZCorDqguV3JB68kIomz5FtFapo0plXw+wfiaPfYtSo6/20kk6
   A=;
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
X-IronPort-AV: E=Sophos;i="6.12,186,1728943200"; 
   d="scan'208";a="195953195"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Nov 2024 21:34:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1B0A0E0D1C; Tue, 26 Nov 2024 21:34:20 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D3415E00B6
	for <cocci@sympa.inria.fr>; Tue, 26 Nov 2024 21:34:16 +0100 (CET)
IronPort-SDR: 674630c8_ZUUm8CyUTqwdlMDKLDuL/ZjBrrz0rMjcCc6BxIqcmwnL0af
 e5Gp20o1sLqrQE1zk0eqrxOEDqFiTzUFmqPkvOA==
X-IPAS-Result: =?us-ascii?q?A0HYAAD9L0ZneA4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UIEAQELAYJDfQZUMwQLSIRWkUEwhDuPEYh1gxY+DwEDAQ05CAECBAEBAwSEd?=
 =?us-ascii?q?goCilwCHgcBBDMGDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?UMOCjGFew2CYgGBJGUJOAEBAQEBAQEBAQEBAQEBAQEBAQEWAj0KRAEBAQIBI?=
 =?us-ascii?q?x0BAREmAQQLCxoCJgICVgYBFAEBgn0Bgi8BAw4jBw2xLYEygQGCDAEBBtpbH?=
 =?us-ascii?q?ywiV4FkAwaBGi4BhWmCYgGGJIQ8Jw+BVUSBPAuCeD6CYQIDhTiCaYJEhQ8li?=
 =?us-ascii?q?Bhom2BSexwDWTIBVRMXCwcFgSkhLAOBeU5/gTaBUQFCgk5Kgy6BXgU3R4JKa?=
 =?us-ascii?q?Us3Ag0CNoIkJFmCTYElBAWDaYELg16EW4YpHUACAQttPTcJCxsGPaEnR4UCp?=
 =?us-ascii?q?xKhNzQHgjiBZYFjDIonlTIGEy+DcQGTUQ4GknqYeyKNXpsogX0kgVwzGiSDN?=
 =?us-ascii?q?k8DGQ+OIYQthGHDH0I1OwIHCwEBAwmFRgEBi1aBSwEB?=
IronPort-PHdr: A9a23:d9cPwxKQPO9gbxSyVtmcuKFsWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCEvLMx0xSQBt+Tq6odzbaN6+a4AS1IyK3CmU5BWaQPbSNNsd8RkQ0kDZzNImzAB9muURYHG
 t9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oI
 xi7oxjdutMZjIZgJao91xXErmVVcOhS2W9kOEifkhny68us5pJv7zhct/c8/MNcTKv2eLg1Q
 rNfADk6KW4549HluwfeRgWV/HscVWsWkhtMAwfb6RzxQ4n8vCjnuOdjwSeWJcL5Q6w6VjSk9
 KdrVQTniDwbOD4j8WHYkdJ/gaRGqx+8vRN/worUYIaINPpie67WYN0XSXZdUstXSidMGZ23Y
 ZcRAOUdPOZYt4j9qEUIrRuiHgmnGefjxiZVinPqwaE21uIsGhzE0gM9BdIDqHfaotv6O6gcT
 O670qfIwCvDYfxUxTjz55PFcgwjrPyWQb58bdTdxEspGgjYjluQs4vlPzaN2+oKqWeb9elgV
 f+0i2U6pA9xpjavxt0tionPiYIe11fJ+yJjz4YvJt24VVV7bcSrHptUuSGaLYp2QsUtQ2xzt
 ic11KYJtYSmcycU0ZkqwQPUZPObfYaS+B3jSPqRLilihHJjYL+yiBi//Equx+HgS8S50UpGo
 jRLn9TIqnwAyx3e59SbR/Zj/Eqv1iqD2Q/O5uxKLk45iaTVJ4Muz7IslpcerUDOEynrk0v4i
 6+Wc18r+umu6+n/bLTmp5ycN45sig7gL6sum9awDf4/MggUUGiW//m32r77/UDhXrlGk+M6n
 rPHvJzEJ8kXvLO1Dg9P3oo+5BuzFzOr3dsCkXQJMV5JYhaKg5XzN1zKIP31C+q0jkqokDd23
 PDGIqPuAo/QIHjCkbbuY65w51JaxQEu195Q/YhUBasEIP/rWk/+qtjYDhghPgyxxObnFcl92
 pkQWG2RGaCVKr7dvkGQ6uIuJemDepMVtS7jJ/Q4+fLil2E1lUEfcKWzwJcaaGq0EulpLkmBZ
 HrjmNYBEWMEvgokS+zqjUWPXzlJaHaoXKI8+yo7BJipA4fHSICtmr2B3CG0HpBNaGFJFEuDH
 W31eIqaQ/sMbjmdLdd7kjMYTbihV5Mh1Ra2uQPk07ZnNPbb+jUEtZL/09h4//HclRYu+jNoD
 sSQyHqNTmFxnmMQXTA6xqF/oUpnyleCy6d0mfJYFcZL6/NTTgg6LYLcz/B9C93qXgLOZNmIR
 0yiQtWiGjwwT9Mxw9oVbEZnAdqulBHD3yywA78UjbOHHpI08riPl0T2cuRgz3fPnI0okFAiR
 oMbN3Cih6c58wHMDorNu0SfjaejM6oGimqF/2CIxmumvUdCUQc2X7+Wc2oYYx7zpM76+1iKY
 rugE7UhPUMV7MeYKbZRLPDtg09HQvjLJ9nUJW68zTTjTS2Uz6+BOdK5M14W2z/QXQ1dy1h7F
 ReuMAE/An3kuGfCFHl0ElmpZUrw8O54oXf9T0kuzgjMYVcyn6Gt9EszgvqRA+gWwqpCoD0o/
 hB9BlWgxJT7D9SapgxuVLpRa5Ux7QQPznrX4jR0JYfoNKV+nhgbegVzsVnp0kBSA59DjNNsg
 Xck1gt0JoqH3VkHez7LlYvoNOjxLW//tAuqd7aQ2lza14OO/bwT7f0jt1j5lASuC1Zk7Hhtl
 dVYu5eFzrPNCgdaEZf4U0JtsgN/u6mfeC42oYXdyXxrN6Cw9D7EwdMgQuU/mF6meJ9EPaWIG
 RWXcYVSDtWyKOEsh1mibw4VdOFU+qkuOsq6dvyAkKe1NedklTiigCxJ+od4mk6L8iN9TKbP0
 fNni7m91xGESiy6oVOvqMHxlqhbaDtUEmf+gSnoCYhNZ7FjKJ4RADTmKMm2y9Niwp/1DiQBr
 hj5XQxAgZLvIEbBCj61lRdd3kkWv3G9zC6xzjgu1iossrLaxivFheLraBsAPGdPAmhkl1blZ
 4au3LV4FAClaRYkkBy96AP03a9e8e5aJnPQXFwOUiz4NWBkXYOvu7DEb8MFu/ZK+W1HFf+xZ
 1yXUOu3hhIA0D74WUZayio6cT6CpZjz2RB3wjH4Tj47vD/Sfsd+wg3a7drXSKtK3zYIcyJ/j
 CHeGlm2O9TBEcy8r57Yqaj+UmugUscWaiz31caasyD942R2ABq5lvT1m9v9EAF83zWpn9VtU
 CzJql77bOyJn+yfOPhkY1IuKVvy8ct8Falhn4F2iJxY1XUBh5qT9GYKii+paI8dg/ihKiNQA
 2dXi9fOqBDowkhiMm6Ey+ebHj2Gz81tasP7KmIa1yQh7txbXaKd7bhKhyxw8RKzqQPcZ+Q4n
 y9Ik6J0riRA3KdQ5Ux0knb4YPhaB0RTMC3ymg7d6tm/qP8Sf2Ozaf2q00E4m9m9DbaEqwUaW
 XDje55kEzUji6c3eF/KznD37ZnpPdfKatdG/DidiRTdlK54LJwrl/wFrTVqMyTxsDd2roxzx
 Qwrxpy8sIWdfi9I9bi6HwUeGzn7fcIV9RnygKwYksvcjOXNVt1xXz4MWpXvV/ehFjkf4O/mO
 wi5Gzo5sn6HGLDbEFzX+AJ8onnICZzuK2CPKSxT04B5XBfEbh864khcTHAgk5U+DAzv2MHxb
 BIz+GUK/lCh4hIez+V1K1/gX22ZqArgY2UxT4WDaQpY6Rtd7l3Zd9OT5KR/EkQ6ttWo/gmKN
 3DebQNVC2oEHFOJDRbvM/Gnt9zH7vTdDfG0Mv/NJ+yHr+AHEfyPwPfNmsNvrTOLK9nKNWJpC
 OcjnBNKW3wgXc/enn0ZQigT3Uohdua9oxGxsm1yp8G7qrHwXR73oJGIAP1UOMlu/Ba/heGCM
 fSRjWB3M2QQ0JRE3nLOxLUFuTxawyhzazmgF6gBvi/RXerRnKFQFRsSdyJ0MoNB8as92gBHP
 cOThMny0/Z0ifs8ClENUlKE+InhfcsRP2S0L0/KHm6OM6maYyLGyYf7bOL0SLFdivlVqwzlu
 TufFByGXHzLnD3oWhazdOBU2XvCZloE4t77K0srUDSwKbCuIge2O9J2kzAslLg9h3eQcHUZL
 SA5aURG6LuZ8SJfhPx7XW1H9Htsa+eeyEP7p6HVLIgbtfxzD2F6jeVftT4fwqFW8ToCafh7g
 irUofZxrlvgnuTFmV8FGFJe7y1Ggo6GpxAoIaLC6pxJQmrJ5joI6niMTQsHrZ1pB5e83sIYg
 siKn6X1JjBY9tvS9sZJHMnYJvWMN385OAboEjrZZOPkZTusKH2ZmEFX1v2fpCX9RncStZXm3
 pYDGOYzvLkdCf4QTEhoToRqHQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ewITOaFl7sCfUN+0pLqEPMeALOsnbusQ8zAXPo5KOHhom7+j5q
 WTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: 9a23:0E8m8W63uW1TIb1hq9ss1UkNNv09cnzmzViPcma/O1QweJvFYArF
X-Talos-MUID: =?us-ascii?q?9a23=3AalXvKQ5qBa88qJMK4NEnkb8Gxoxp/rWnCX0szq4?=
 =?us-ascii?q?v+OS8Gi9yPQnCsGSeF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,186,1728943200"; 
   d="scan'208";a="195953187"
X-MGA-submission: =?us-ascii?q?MDE8cM21DlLCR6r1uuZyh9PAHDEC6zm1LPBHo5?=
 =?us-ascii?q?Y6pLSWQBt4G7eA/iAQPKvCQ71oeVeTuOSM5hGbIEiwXcpn6HNc1PY4OA?=
 =?us-ascii?q?YYtCePGV8mlh0ATc0cb9cFamaKJ4k5vLa5kaZBFEAaRkgHAMlsqcbsNO?=
 =?us-ascii?q?8xrcBoRzKaH1XCORw6CvHX5Q=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 21:34:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732653255; x=1733258055; i=markus.elfring@web.de;
	bh=Le9Otod9mgn08JeaLGuFaQBUOihmKeqMX1vHLv/7ZC4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DXtn8AwKIGR+fI4dxlMBW9RmLYvxtlEaxs+5zotCaTmMndnp9LW3YcTCyi5Hr9a9
	 KtjcscOP/RUrX0KeLj43R3r55a24m6u5tJMg7fSmkH2OCKc8IU0vgKHnddX4x5Cjy
	 Pjyd96bKYGjlPl+gxXGSaLQadAvie3ihTY0yOiUdpbvaqnbRYTCm/QVCmZDvypSgn
	 7tnsIxHnvanyX7ELd4BjGvR08FEMMo/qAneLqFqzfAnopxa9TQIy9DO5FcJhF7rkz
	 SdvKRei1bmwLMHcvIxvdfWbiExPU+lfVsNa/VhnXPsKN4yCbizzEWTVUaEiNbzLJ5
	 M7Hk8yudAGtWTDqiyw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MMGyA-1swrTt1fdu-00Oj5q; Tue, 26
 Nov 2024 21:34:15 +0100
Message-ID: <9e7556d0-8df5-4527-824c-4f1e8b78b2a1@web.de>
Date: Tue, 26 Nov 2024 21:34:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <CABQX2QM+cBpVhcBYRae+W4n5a6bVJ=sC+zu9GGj0veiqvU2_4w@mail.gmail.com>
 <6b81d431-36e9-7a7a-687b-2d7fc7aa6c31@inria.fr>
Content-Language: en-GB
Cc: Zack Rusin <zack.rusin@broadcom.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <6b81d431-36e9-7a7a-687b-2d7fc7aa6c31@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:gQ9LgM3UGpq7mHA0o4znQebFJMH2PBAlZzxF26s5e+nDrX/ANQV
 oRDXri0rZv5uDMdqQR6A0psai6/K8Jm2GE56lLdv4BgcT6ocg27AIPoYcm17I1HRwZ0ZZop
 tV+iBwGyhed+kBOKHUMW4Of0AD9U2bcViulV8J2vPHwrdf6GLuUHKdI0oC2RatDJ+TxTVuL
 9PlP8LEOxBwsMQdGXgJQw==
UI-OutboundReport: notjunk:1;M01:P0:TdLoG9znJps=;RGeG69h/DDd+SyeGXCk3sTPbFfF
 lugBfqUPbbDMqnQY5PSqhj1vfnIBnB5L21cqrhnM6LNuHh1exuNnzpvOUlynfMMstMJdQP+eI
 8MbzJB+IjsvaqtwwjTpTYjhSBpTAajpSc16cVu9zmSmxHHm1ACkXAX85IxtVlnjLvS/2lvZZh
 YBK29+ZKVp1Ckv7atZNrXKFRTNC3a2pcLB1Ko2N+BFcu9lEil6vfU3E9LRC549QPZi4P5dvsR
 U2wHE4EEhzfwWkedhIoKWhCOvdG2DQXAoYF4w0ithXwOxKZ6u76ahsGwCO49Ls/SoLzFIFgJZ
 5Y/kQfTsqvxzTNWmJWHL8Dz6YCmF6uBpB15i7guVGs6kryZhHw+3QAdrwuxnZCZFORHbE9t+8
 duwyvlcom7gAtrqTDXaBz63eruC7+RdmdZ8oSpRtPB8QQTxpgstlELxj1xkpKPhxp/ZiDU2P+
 ZjjI0poReHN7wAGi3BbNoFqJEmz9aosykXO8WBBHNxmXxvWNLcRlovrFzXYEq72pa80a8YtdU
 uRliAAGJM+bs/mkp19LcW67kkmlArncMMqbSUTiAgxbWAhEr2dzH6tGkJ4PEzzE4B2em/e9Wq
 q9CURy54OYN+pgiv6OgHfRJLg6THoH56NyLcvzsGdMipv9uzdegYQUDGcaShJMXjKHPUoJDQm
 RKRwen4GPJ37HatWHvufWayybGelP8ggtUMFFLjsj3wF6qDESEIZszvevDmRGCQM2Fnadvrah
 awbf6mV5GunfcFsnOQqhyZEIFF0bKrawvvPcPgxzEx0M9qA3LMVwd2PZOj7WRkn0qzVMmbec9
 4unmbXaOSMe74qInyAJkSMzcOfc0xZngQTul6aNYpG68MNYjHZ0Sp6OSEl1nLaR09N3phkLTR
 7U6y8wdT0MsbVLx7hUZpi7pn/HcP0Ovd8qJ5MZupkUou4QZdKXmWlawNO
Subject: Re: [cocci] Replacing type names
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2135
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/9e7556d0-8df5-4527-824c-4f1e8b78b2a1%40web.de>

> Will cover the variable in declarations, but it will also include
> structure field names.  I don't know what you want to do with them.

Naming convention preferences can be reconsidered in more detail.
https://en.wikipedia.org/wiki/Snake_case

There are some development challenges known for corresponding source
code transformations.

Regards,
Markus
