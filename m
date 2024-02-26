Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB452C48BF6
	for <cocci@archiver.kernel.org>; Mon, 26 Feb 2024 14:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=w1j4n5piV5lJO4TYJQ5tVQ4fRWX1z8QvmVmq7Ogv0YM=;
  b=LLFVwjfVOUgjXqluSVU5pLgKrXXA8SJp25QkxVrKClqu6IKbSIaNrXPM
   e2FHuWtZqM8XL6A6zt3GsB1Do1W2pkzgsdQ/nvxrKpPU0jeEPx5ArN9l/
   ly2Tsza9B0fvA4W/ePy/5RaoZE/Ox02lMIQz/VAmxjZPLb5dicM1MiFvE
   w=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.06,185,1705359600"; 
   d="scan'208";a="153849442"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Feb 2024 15:35:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DC464E0CD7; Mon, 26 Feb 2024 15:35:53 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C0DB6E008A
	for <cocci@sympa.inria.fr>; Mon, 26 Feb 2024 15:35:52 +0100 (CET)
IronPort-SDR: 65dca1c7_jgZtCY9RbqXUBEWPkPhGpEf2rtmQvZHQ+Ly7mk7FYQGHOCx
 cvzwlQbQn3eJRYi6KHH9w9kZIA3LfSVRIPJMIww==
X-IPAS-Result: =?us-ascii?q?A0F0AgAOodxlhwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+COX9TMgQLSIRTkTkwhDuHOIdOhGuEBYMWPg8BAwENQQECBAEBAwSEfwKHb?=
 =?us-ascii?q?gIeBwEENBMBAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXB?=
 =?us-ascii?q?w4QJ4VsDYJcARCBDoEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHQQECAgEjHQEBE?=
 =?us-ascii?q?SYBBAsLGgImAgJWBgEUAQGCfIIrAQMOIweuYoEygQGCCgEBBq9cHywiVoFhC?=
 =?us-ascii?q?YEaLogmAYVvg0J6Jw+BVUSBPAuCRzE+hEODW4JohVCTUYdIVH8cA4EFBFwNG?=
 =?us-ascii?q?xAeNxEQEw0DCG4dAjE6AwUDBDIKEgwLHwVUA0AGSQsDAhoFAwMEgTAFDRoCE?=
 =?us-ascii?q?BoGDCgDAxJJAhAUAzgDAwYDCjEwVUEMUANkHzIJPA8MGgIbFA0kIwIsQAMJC?=
 =?us-ascii?q?hACFgMdFgQwEQkLJgMqBjYCEgwGBgZdIwcPCQQlAwgEAyspAyB0EQMEGQcLB?=
 =?us-ascii?q?3iCCYE9BBNEAxCBNAaFMoRqDIIDgQ8DGSsdQAIBC209NQYDCxsGIgEdAqJbf?=
 =?us-ascii?q?IEFgTwwljgBrn80B4I1gWCBYQyfOQYTL4NyE4x6hjIOBpJiLodWkFYgqFmBe?=
 =?us-ascii?q?yOBXDMaJIM2TwMZD44gGYQUj0dCNTsCBwsBAQMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
 chWIle6fFkyC+9cFUlvWtAPcs8fYw==
IronPort-Data: A9a23:SioCyaslVk7wlj4g14nxixHvr+fnVHdaMUV32f8akzHdYApBsoF/q
 tZmKW6EOfuNZWfzc94laInkoEwPuJOEx4RhQAVrqS82Qi1GgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTrSCYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCRMtcpvlDs15K6u4GlC4wRiDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNz94X2mVTKlLjFVDmZkh+A8BOsTAezsAG6ZvXAdJHAathZ5plqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJB0LArJI6OVNOFBD0
 btCeSgOfgjepNvjldpXSsE07igiBMzsIZ9ZpXxqiz3UZRokacqaGeOQv4AehWp23aiiHt6GD
 yYdQR9mdhfdeFtiPlkNCZQxtPiljD/zflW0rXrM+PFnvzmPkFUZPL7FNNrlYs2QTMhugWGEu
 jzL+23WXgoRHYnKodaC2inw1reUzXyTtJgpPLa//fVrqEaCw3QaThwQT1qy5/ej4nNSQPpaL
 FEIvDUjp+4++SRHU+URQTXknUG77gwfYeNhHsl9slCVybrMviWgUz1soiF6VPQqs8o/RDoP3
 1CPns/0CTEHjFFzYSzCnltzhW3sURX5PVM/iTk4oRwtz/SLnW3ephfIU8olD6O/yNH4cd0R/
 9xohHli71nwpZdVv0lewbwhq2/zznQuZlNqjjg7pkr/smtEiHeNPuREE2Tz4/daN5q+RVKcp
 nUCkMX2xLlRVcHdxHHdHrpdQurBCxO53Nv03gMH834JqGnFxpJfVdoIvG4WyLpBaZ1aIm+1C
 KMtkVINusA70ISWgV9fON7hU596ksAM5PzkUfbTdZJVb/BMmPyvrElTibqr9zm1yiAEyPlhU
 b/CKJrEJShAVcxPkmHsL89DiuBD+8zL7TiOLXwN50/7iuX2ib/8YettDWZimchjsv3f/VqEr
 ooBXyZIoj0GONDDjuDs2dZ7BTg3wbITXPgacuQGKLDRERksA2w7Ff7azJUofoEvzewflf7F8
 jv5EgVUwUb2zy+PYwibSGFRWJW2V7ZGrFU/IXMNO3Ss0CMdeoqB1voUWKY2WrgFz9Zd68BIY
 cMLQOi+J8heay/m/m0dZKbtrYY5exWMgxmPDhWfYzM+XsBBQlXX9u/dYwe1yigqCxCzlMoho
 o+P0hHQbooDSj9DUufXSqOL5HGgsUcNnNldWxPzHeBSX0H34q1GGjfUnNZuB+0tcDLtniC70
 SSSCjcm/dj9mZc/qoT1tPrVvrWXHPtbNWsEOWvitJKdFzTQp0inyq9+CNe4RyjXDj7Iyf/zd
 Ndu7q/ONdMclwx3qKt6KbFgyJw+6/bJp7N3ygdFHm3BX2+0C4FPc2W34s1SipJjnrNpmxO6e
 kaqyOloPb+kPMDEEllIACEHau+F9+8fmxiMzPATDXj52hRK/+u8YR0PByWPtS1TF6sqEYUHx
 ex6htUaxTbigTUXM/GHrBtuyUKyElI6XZ4KjKoqWL3QtlJzy3VpQ4DtNSvt0ZTeN/ROKhYLJ
 xGXtorjhpNd5BHwTFsuJ1fw3M52p5cHiDZVxnAsenWLndvkgKcs/RtzqD4YcCVc/i9l4clSZ
 Fd5ElJTHrqf2QtoiOxofXGeKysYCDK3okXOmkY0zkvHREyWZ0nxBWwaO9fV2nsG8mhZLwNpz
 JvBxEnLCT/VLdzMhA0sUktYqtvmf9x71ivGvOuFR82lPZ0LUQDJs5+UR1gjikXYWJsqpUj9u
 +NV0v56avT7OQ4usqQLMdSm+opKei+UBl5pYK9Hx7wIL1H+aTvp+DmpKmKNQO1vCcHO03eFD
 51JGpoSeTW4jD2DvxIKN54qerVUpsMk1PAGW7HsJFMFjYehkypUgMru0Rb61UAWQIRIsMciK
 4nuWSqIPU6OiFB1xWLcjsl2FVCpQNsDZQGm4uGR9d8NNpMcsdNDdVM5/au0sk60bipm3UOwl
 yHSa5DGy9dNzdxXoLLtNaFYFSCYFMjWVtnUwDusst9LU8zDAf3OuywRtFPjGQZcZpkVZPhai
 pWPt4TR8H7enbNrTV3cpYaNJ5NJ6eq2QuBTFMD9d1tevCmaXf7T8wkxwH+5JbNJgeFiyJGeH
 SXgU/SJdPkRR9t5719WYXIHEx8iVoLGXp25ria59/mxGhwR1DLcF+ye9FjrUHp6cxEZMJivG
 y72vPeTvupjlrpuPyNdJf9aAM5fGmTBCJsWL4i78XHSC2SzmVqNt4fzjRdqu3mBFnCAF928+
 p7fAAT3cBOpoqzT0dVFqMpIswYKCGpmy/wFFq7HFwWaVxjhZILHEQgcDXnCIpRTjzC0y5zyI
 j3ABIfn5eMRQhwcGSgQIvy6NutcOgDKEsj0LHol8it4rg+oUZiYDuIJGjhIuh9Ll/iK8A1jA
 c4T8Dv8M3BdB32vqfk7vpSGvAus+h8WKr/kN6wwfwwezivy2Yk36UE=
IronPort-HdrOrdr: A9a23:/TyJ2qtAm77iWDgKeCmQRl6V7skDotV00zEX/kB9WHVpmwKj5q
 WTdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDxHZK3BgDVQfexQouWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: =?us-ascii?q?9a23=3Ant6n9GsFQpT6BlYP6v35YTst6It5T0LinGXTGXa?=
 =?us-ascii?q?JBEIuEuyNSk+IpYBdxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A14vSQw/dNaxloevZ+R7doXaQf8No07y/EkkAqoo?=
 =?us-ascii?q?hp9XaOCh5FGuGhx3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,185,1705359600"; 
   d="scan'208";a="153849441"
X-MGA-submission: =?us-ascii?q?MDE6Tcrvw33Z8U47+8+9runU2GXJRrfY4cYucE?=
 =?us-ascii?q?dumlbOr1KCWfIzef7PNt0y8s+X3Xmvc00y7PhkaTsArK09I000HPjnor?=
 =?us-ascii?q?IwrFKAFPh5ZCPxJDuVK4yopCkC0ijWbIta9CKo8OigVD6l8OHUIkwpUk?=
 =?us-ascii?q?OlrAIbqPfZVNUf45VVOtyNFg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 15:35:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708958144; x=1709562944; i=markus.elfring@web.de;
	bh=w1j4n5piV5lJO4TYJQ5tVQ4fRWX1z8QvmVmq7Ogv0YM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=fhaELeMf9XLkwiHf8oWLsYuqb2xArERZFnRXqvhj/S5LOixeEp02UBm3bF9UG3u/
	 hXebI2/dj1icLZTNCweURk0s0pgXyMR8NWFqOJbdweywmjRrIfCbq/zVo6y45OoJ5
	 KOMj9gEYcbWX6QbKfSXQnwpF27sdkmak+nJ47pndw0U9ePzVJnjfSSI93wfQCiWuo
	 GCECkOUUTHRleU1SME2vbGYO+gLGXQX1fG38moKzW9N9eW7yXCYAqD/GubHdkBr0Y
	 M1P9zn8P/JHl4PNNEGsYw+bIvi7y/BHx4TRi6ekcADmWY2p4iS9GZSBIVo/ivGaE4
	 9eEyZv19oZ6dtlD7EA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiMEM-1r0Lqw18xq-00fP3l; Mon, 26
 Feb 2024 15:35:44 +0100
Message-ID: <1edb972e-7285-47d1-8ee6-606146b2f9e3@web.de>
Date: Mon, 26 Feb 2024 15:35:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Abel Vesa <abel.vesa@linaro.org>, kernel@pengutronix.de,
 linux-imx@nxp.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
 Fabio Estevam <festevam@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 cocci@inria.fr
References: <20231210171907.3410922-1-visitorckw@gmail.com>
 <0e906ec6-fe73-4dbd-b555-a2c03b6e1030@web.de> <Zb04UUeE/cU9HtKZ@linaro.org>
 <1a3c05b8-45f8-4205-8cb5-3b8f2d791877@web.de> <ZdxVHLce6mk975Zp@linaro.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZdxVHLce6mk975Zp@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ik7pubzyywRLN+A8mM0fkXjKiGabN6eGEKg2njPktovMf7/kFaC
 iVS+JNE7lldbXx0Cihn0bS3x1IrbChjtnXXeppNQ/oFFxgAXBabAe8duD6XAqn+gNbOauia
 u4o0zlsfYQo9huyUbO0i8wqx7te3aOOyxeOP6/+4jmOEdU5ZWIIokDPKknVUlfGndZxE8qh
 5s2NokyeBzRJcqy9c1H5Q==
UI-OutboundReport: notjunk:1;M01:P0:avMEIdZR8Iw=;MDxH7h9hE7musDOfhwLI8lHqKOs
 vSZxQcxO1BMq5OdWipMRggwmb6Phb8RPbGdrDx5EiGUyKP0GFoMHBIYB7GgID5CajqqzXtk+6
 r1Qoh65N5IBVhN9O/5didT7ai1T2HJKfwVQ//nE0xE9s05RETt7rKUB4/CYLg04ptaQGRHzlI
 +ksJ04n67GamCfPWbq7p5HiDCrdW9/MKL7KZ+EvGlrFH16uMlK5qoOf3zXLE+Pb3sck43OpTw
 T1p8guLssAsJUgY5J5TjNo64KsJrVdNVKgQQHsZ8MAQMJbc11CRSuXyo5IFdojagqwtcMGhg/
 QIyxG5QhGCH6sOwbw93WzSX+c4BpAwD0f3bfJupCnjPxaJqLc4g2O3qy204PablIsLKcXHIHH
 lwMhyBN/2eWidgiGI8xajsJIANfGhG0zFUA3HwmfjdfnqIBikPR2I1v2UuHVYRXSGjtXuHhT+
 Y/CqDQNA5ntSAc5MhNewLQ3FIVybhPREn4FD3vQazhV/JsnRdPeW9Ew4Z4L9mRmPVB0jIIB1Z
 TtPYEZijFEj+9IIFVcQ+EMjiDx6L7f1pfzlUONSm1vHrBXULdamd7jjB7ILRBGE223Dz655N5
 Vh1u77t/EkNlRzNmD+HpJAU20uHluduKHv9C/gpyDqAq3dAHHl3TNip0Q/HvExZcAxMCMrcyy
 NfmAWT/2Z33LJZuozoUCBIdbaFBjo/MhWPL2r1LzlYKotE3FtYVW6pl1K8SkRFuwu+8TesQJ8
 ny0Je+/DbcfMmw2AvDIsF3LjmhIcfB8GRZ/M+k0f9nc9+nJIPD69GwBoBXTVOLQ1BKbQOfDsL
 HYx2C4uxdA17KYLN0FaNZe8sv4ExJdYQ/pCo+Hoz0nrfo=
Subject: Re: [cocci] clk: imx: scu: Use common error handling code in
 __imx_clk_gpr_scu()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1606
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/1edb972e-7285-47d1-8ee6-606146b2f9e3%40web.de>

>>>> Use another label so that a bit of exception handling can be better r=
eused
>>>> at the end of this function.
>>>
>>> Please don't send patches as reply to other(s) patches.
>>
>> This is a general possibility to connect an information sources with
>> a corresponding change idea.
>> Will the acceptance grow for the presented source code transformation?
>>
>
> Nope, please don't do that.

Do you find the proposed source code transformation reasonable (in princip=
le)?


> The b4 tool will pick up the old patch if you do this.

Are you looking for further improvements for this development tool?

Regards,
Markus
