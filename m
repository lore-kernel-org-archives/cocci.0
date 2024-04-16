Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AECC4345F
	for <cocci@archiver.kernel.org>; Tue, 16 Apr 2024 11:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Ui7l+SaHrHq3cSvKjv3JWxTa8MuFN1eFiOWgpWl/TPk=;
  b=ABtP1Ta6idaoC0pJLITq+NiIOWu9k/fVuOHh4+KE+OJoYO5CDjB45Ng3
   kar1eZDOZJAT56w7gMCS30tv2zHSyv2QQ1Tg29zZ7VxX3ymSlASaO3Ytu
   FPO6L/JBMa92nt6EhhboBK40ScLsd53GRfi7sRX41FNxoKdQTf2dDxU7A
   4=;
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
X-IronPort-AV: E=Sophos;i="6.07,205,1708383600"; 
   d="scan'208";a="161841540"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2024 13:30:38 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0AD23E013D; Tue, 16 Apr 2024 13:30:38 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D2272E0035
	for <cocci@sympa.inria.fr>; Tue, 16 Apr 2024 13:30:34 +0200 (CEST)
IronPort-SDR: 661e615a_AKkR1lgp11t54NiTSy9gLvEuMciPugXcAK+yi7N0p8fh1Ek
 0rHLPNzwpxgbi9xqvB+4bCZs1Z7DFcoqeZ1I8HQ==
X-IPAS-Result: =?us-ascii?q?A0E0BQAQYB5mhwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CRH9TMwQLSIRWkTuEa4c4h06IcYMWPg8BAwENQQECBAEBAwSEfwKIGgIeB?=
 =?us-ascii?q?wEENBMBAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMTBAcOE?=
 =?us-ascii?q?CeFbQ2CZwEQgQ6BJgEBAQEBAQEBAQEBAQEBAQEBARcCR0ICAQMjHQEBESYBD?=
 =?us-ascii?q?wsaAiYCAlYGARQBAYJ8gisBAzEHtAWBMoEBggoBAQbaWR8sIleBYQmBGi6IL?=
 =?us-ascii?q?gGFfINGeicPgVVEgTyCSzg+aYNag1uCaIIVmWaGI1R9HANZMgFVEyILBAwaA?=
 =?us-ascii?q?hsUDSQjAik+AwkKEAIWAx0UBDARCQsmAyoGNgISDAYGBlsgFgkEIwMIBANQA?=
 =?us-ascii?q?yBwEQMEGgQLB3WBfIE9BBNEAxCBMgaKDwyDMSmBTimBKYMJCENxFYEIAoJ9g?=
 =?us-ascii?q?WADRB1AAgELbT01BgMLGwYiAR2iSYIbxV40B4I2gWCBYQyfRQYTL4NyAZNFD?=
 =?us-ascii?q?gaSaJhiIKhlgXsjgVwzGiSDNk8DGQ+OIBmEFJVlQTU7AgcBCgEBAwmFRgEBg?=
 =?us-ascii?q?1qBSAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:nHpRu6i0rTA32u0gSygGF8LTX161pBQKZh0ujC45NGQN5FlHY01je
 htvCziBaP+LYDT3fNAnaYS38kMHsJeEndM1G1dkqSFjQiNjpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UqieUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tqaT/f3YTdJ4BYqdDpLg06/gEk35qiq5GpG5gVWic1j5TcyqVFFVPrzGonqdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv4+lpTWhRiro/6ZWBiuFIOM0SRqkQqShgJ70oOHKF0hXG7JNm+t4sZJ
 N1l7fRcQOqyV0HGsLx1vxJwS0mSMUDakVNuzLfWXcG7liX7n3XQL/pGBxg1Ia8q1cRNMCJM+
 toZOmlVZA2gmLfjqF67YrEEasULKc72IMUAt3smwTyx4fQOG8mZBf+QupkBg3Fp36iiHt6GD
 yYdQR9mdhfdeFtiPlkNCZQxtPiljD/zflW0rXrF+ftrvjWClWSd1pDdAfjYVMeDVf5kk2Wfg
 znNwEH+XFIzYYn3JT2tqS783rSfwksXQrk6ELSn//puqE+Sw2YJAVsXU0G6qL+3kCaWUNVUI
 E084TsrtaF09UqxT9C7UQfQnZKflhsbRsYWDOAwrg2AokbJ3+qHLmNdTSJjWvMEjv51RzMM1
 03Qx9n0JiM65dV5Vkmh3ruTqDqzPw0cImkDeTIIQGM5Dz/L/t1bYvXnEIoLLUKlsuAZDw0c1
 BimgUADa1g7iMkWy+Ok8FqBjz/ESnn1ouwdt1+/soGNt10RiGuZi2qAtASzARFocdvxc7V5l
 CJY8/VyFchXZX13qASDQf8WAJai7OufPTvXjDZHRsZ4rG71pi/yIdEKsFmSwXuF1O5bJVcFh
 2eM5WtsCGN7ZifwMsebnqrqUJpxnfSI+SrNCa2NMLKinaSdhCfcoHE2Ph7Pt4wcuEkrl6Ykc
 YyWGftA/l5KYZmLOAGeHr9HuZdynn5W7TqKGfjTkUz6uZLAPiL9YeleajOmMLtmhJ5oVS2Or
 r6zwePRkUQHOAA/CwGLmbMuwacidiFrXsmr95AJKYZu4GNOQQkcNhMY+pt5E6QNokifvr6gE
 qiVCxEGmmnsz2bKMxuLYX1FYbbiF8Q353EiMCBmeR7i13E/aMz9pO0SZrkmT4kBreZD9P9TS
 +VaWsOiBv8UdC/L1Q5AZrbAratjVi+RuySwAwSfbgMSRaVQHz7yxoe8fy/E1jU/MS6shM5v/
 5yizlz6RLQAdSRDDeHXSqmd8HKsj1cgmcZZfUjBEv9McmrCraloLC3QiKcsAscucB/s+BqT5
 zy0Mzw5+9bfhpATy8bYo5yEo6OCMfpMLmADE0b1tb+JZDTnpEy9yop+YcO0VDH6VlKs3p69Z
 O9QnsrOANdekHlk64NDQqtWl4Qg7N7Spphf/ARuPFPPS3+JUrpAAH237fNjh5135I1ymFWJA
 xqU29xgJ7+2FtvvEwcRKCobf+2z76wotQeI38slAnfRxXFRx6WGY3VwLhPXqS16LZlJCq0H7
 9olmvYr712YtkJ3HPeA1jtZ5kadHEwmCq8HjKwXMKXvqwgsy2xBX6DiNz/L0MmxTOtIY2YXI
 W6ypavdhr5j6FLIXFgtGFPsg+dMp5Q8lypb7V0FJljTpNvhg8Uz/RxO8AYYShZe4QVH3tlSZ
 ElqFRxRDoef8wh4gPNsWziXJDhAIxmC6Gnd9kAsllCFf3K3V2fIEnIxCdyN8G8d7WhYWDpRp
 5Oc90rIThfoe5vX8hYpeEs4tcHmc8N9xjfClO+jAc6BOZswOhjho622YFs3uwnVOtwwiGLHt
 NtV0r5JM4OjDhEpooo/F4W+/pYTQkrdJGV9HNdQzJlQFmTYIDyPyTyCLn6qQfx0JtvIzFSZD
 vJ/LcceRjW80yez9gogP5AuGIMtvvAV54slQIjJdEomqLqUqwR7vK3ArhbegHAZePQwsMIfB
 L6ISRe8PD2xv0ZEo07Ms8hOBUSga/YmegDX/b644ccJJb05ocBudkA47erts17IazlY3g+mk
 z7CQ4T0zOVS75tmsKWxM6dEBiSyccjSUsbR+i+Nkt1+V/H9GuaQiBEwtX/mIBZzEYYKftZKy
 YS2r9/82X3asIYMU2z2n4eLE49L756QWNV7H93WLn4Auwe/Q+7pvgU+/l6nJaxzkN9y4tetQ
 y26YpCScf8XQ9Js+21HWRNBEhoyC7XFUYm4nHmT98+zMxk61RDLCPiF9nWzNGFSSXIuCq3EU
 wTxv66j28BcoIFyHyQ7PvBBAaJjAVrdSKAjJszQtz6ZMzGSuWm8mIDezDgu1TKaLUO/MpfK0
 cqQDFy2PhG/o7rBw9xlopR/9E9fRmp0he4rOFkR4ZhqgjS9F3QLNvkZLY5AMJxPjyjuz9vtU
 Vkhtof55fnVBlyosCkQ4egPmi+aAfESfMj0LHol8it4rstw6JyoWNNcGuVIuh+auQcPCMm4J
 NtY9nCY0t2Z3MRyXehKjhCkqb4P+x4Zr07kPWjinsa0Dxt27XDmEpB+NFIlaBEr2P0hWKkGy
 abZiIyErIyGpZbNLPtd
IronPort-HdrOrdr: A9a23:YCAkrKABchX7F0XlHejxsceALOsnbusQ8zAXPhZKOGZom6uj5q
 KTdZUgpHzJYVkqMk3I9ersBECrewK7yXcX2+ks1NWZMjUO0VHAROpfBO3ZrwEIcxeOitK1vp
 0AT0ERMrLN5HFB/LvHCF7SKadf/PC3tI6pmMLXxDNVTRhnbqFm40NYB2+gYzRLbTgDK5olMZ
 KWovNGvjakeXMaKv+2CRA+LpD+juyOupL6RBYMQycm8QWKjTSlrITmGwWFxH4lIkhy6IZn32
 jZtgTzopy5tfK2wAK07R63071m3PXg1/5KD4i0kc4XJj/wziakDb4RP4GqjXQaoPyL4F1vqc
 LLoBsrIoBL427RF1vFxicFjDOQrwoT1w==
X-Talos-CUID: 9a23:pvGtT2+POMbFNW2m/GyVv0VNGdwHQFL/9kaTIUCeCHQwELeIakDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3Aj2Ntrg0eWfOosvW4cFKuKT3WdTUj05WMBW4WmIU?=
 =?us-ascii?q?9isSnMgkrMAi4i2r0a9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,205,1708383600"; 
   d="scan'208";a="84945591"
X-MGA-submission: =?us-ascii?q?MDEsWFZyARWic5FlukxotJi8vV6DX7gpCy/jjz?=
 =?us-ascii?q?cYERzHI/A4zmaj+aw6SVM3mV18IDuOvL0degjujpgQB9XFiAxzcbe330?=
 =?us-ascii?q?QkHkTm7GgvQ3h6cL4PsKwOasE1/fgwMeN4eBO47ZCQc0op+mspF2c+IK?=
 =?us-ascii?q?gJix+57FaMJKTQ2OF3MdZg8g=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 13:30:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713267032; x=1713871832; i=markus.elfring@web.de;
	bh=Ui7l+SaHrHq3cSvKjv3JWxTa8MuFN1eFiOWgpWl/TPk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=h1jUOVt8p8foEsAuJlb0m9wGaFUYv/ABNZ8iizwoOTQpAgmqjmh3YY3pQNzfCrPW
	 tgw0L4FX/mAfqU+oZPlqM9EZnZkHiE8meZIjv3yB8TGDy2Vp2JFVgp0zAfaytxnNy
	 cuQPHfyuxte3alBtfwnC0J1W1rQb1Dw5YWxhfJF5BlHrOA1X2L+ZHXgcV7/1e8sPK
	 m0tHa8OSpEQYTKf+Ckg5MaO9uqkZtcoo/xmqEljCD4xq0aUNkhAbr+m1oxOTBhYIv
	 aKvDOxPYeH83tIALVHUCZTRuY8n7d4jiCFUV4cL+4j55JUWKs8phNH5wnI2nOzjwH
	 vnuGyy47qXy75dICNQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6sFx-1soNdf1ZEN-018KM9; Tue, 16
 Apr 2024 13:30:32 +0200
Message-ID: <fbf22b53-7b68-4e60-99c7-ab38a77a53c8@web.de>
Date: Tue, 16 Apr 2024 13:30:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ricardo Ribalda <ribalda@chromium.org>,
 Julia Lawall <Julia.Lawall@inria.fr>, cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, Denis Efremov <efremov@linux.com>,
 Nicolas Palix <nicolas.palix@imag.fr>
References: <20240415-minimax-v1-1-5feb20d66a79@chromium.org>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240415-minimax-v1-1-5feb20d66a79@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AFMKKd2u0wM3PusYJITwpe/1FJ5meZooU3ZIXmvxEeBtK9lezd0
 6VFMRoMDB0EXqhsmrLaofR8hPVpNZ0FT6xdD9wRg9Byo1P13A6oNd1X+vFRcskTkLNgVx+h
 zL7s0ztZevVeEi9960bbTeXNMC/DI8BzZpXUMEFHAIKl9OHre/JzvN/VFy0v+kJV7oI7Vvr
 /I5Or6QYRl1IXVhRTQRTg==
UI-OutboundReport: notjunk:1;M01:P0:/VhDKEAz9LQ=;NGRQehjoXDtUOn6caJ5wKhLZSgY
 9bSn4OQ/r7h2iqXjiwUJat6VipLNo5yIb3Nj3oGQU8jCVuxg3aifeN5cotH1F//nszHKWl4zq
 d3s+76i3jSh7s42B7uY/vWbRDKqTz+toI6iAQfkKUYX8yqfl2Xj+1ZXVjInvCHwNdJie1TRUe
 HJ66RMMdLr+8xmzojlAPdrSj1ZqlV9vK19smQvccbOH3HKJAvOkQ1/vSxNtmrFNFjbeKBj957
 7yDdqJfobRPHdANhWydeR/qlo+egV/7CJ/5Ht94PanFz2mMx9Tajr3aV8ccChvUuqiGGRrI9d
 sWZwVySkbB7P/YpcwcBeXIGobYqHiJkwI7HgALkJKOF/4LGVJbNmSeJ4k7MkYCXKhuqykEa0k
 3U+qRBI0UT+EDtsiXe1lq2c0vVCTUIxRAcWKz2zEPZifqKukPqj5BEj+7HCVUdktsmAz9tD3O
 g/bHXnOCeJhZZUyH9EGOlum7JYe0Yw2l417M5QLSehlNwXQr4gKL3ZQl/VLm3c1u2HkOwmzIr
 vPt0IbwCXSbJmdivC2ryqFiYgs7y8+CtRj8Cdxy6YwqSreZIC8dG5zF3hYa1xfp8rguvnDWI1
 SyociTTgQEL2aEXPlVc0U04HSJPlIPeaPOfZJPZBpQuIFCs1U320AcMfxwCDmBfjudNGb4AEB
 9HngDj1fCJZSRfcg57JEHvomgJXoWbJUs1OdwJyM7akDG9OuCAA556JoEm/5VMiy40j08koSl
 6Up6RNOMUXovjEvUU+9FyO34htIgKhe8eGIzqm3BXUmRMFiNi+B+xcvFNo28BUM290zyP4Pbu
 k8eODGJB4ie0YW4mdGvME87mUcdubV0LjBMFhMaEFBdFk=
Subject: Re: [cocci] [PATCH] coccinelle: misc: minmax: Suppress reports for
 err returns
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1654
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/fbf22b53-7b68-4e60-99c7-ab38a77a53c8%40web.de>

=E2=80=A6
> +++ b/scripts/coccinelle/misc/minmax.cocci
> @@ -50,11 +50,26 @@ func(...)
>  	...>
>  }
>
> +// Ignore errcode returns.
> +@errcode@
=E2=80=A6

I see that you would like to omit the specification =E2=80=9Cdepends on pa=
tch=E2=80=9D
from the previous SmPL rule location.

Would you really like to influence and adjust SmPL code any more
according to affected coccicheck operation modes?

Regards,
Markus
