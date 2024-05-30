Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A63C25B74
	for <cocci@archiver.kernel.org>; Thu, 30 May 2024 09:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=AKA2sgCHan22Dyd94SfDgIjyQAoUdPZIvOVvutCvuVk=;
  b=IfyqdNIjO1ScN5c0BhAB7AU20yPJLvryFsuJj9jq0KAi6Ca0V5pbEjQF
   xJnvgvyGa7bLQlOajK5COr5Skqpov0fAXzjySfEvsZMNTCRyiBFpEgYwe
   UsNaS8/Lj6WN79SIshOO5J3szz9s9LqbrxS+hQdYDde3/XONbLsFuJf7/
   8=;
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
X-IronPort-AV: E=Sophos;i="6.08,199,1712613600"; 
   d="scan'208";a="168154591"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 May 2024 11:05:43 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A8FD1E0035; Thu, 30 May 2024 11:05:43 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8F11DE0035
	for <cocci@sympa.inria.fr>; Thu, 30 May 2024 11:05:42 +0200 (CEST)
IronPort-SDR: 66584166_6ulS8z37qva6o8FWhIGkrWi6DgTTHRpczTOVF38bOAcAnbi
 oNdUObFNMBI2R6iaOYbb2ZYhrt7mqZ+K2VT3qoQ==
X-IPAS-Result: =?us-ascii?q?A0FfBQCSQFhmhw4P49RaHgEBCxIMQIQTfAZUMwQLSIRWj?=
 =?us-ascii?q?0iBdS0DhDuPCYhxgxY+DwEDAQ05CAECBAEBAwSCC4J0AohUAh4HAQQ0EwECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxcHDhAnhXQNgmcBE?=
 =?us-ascii?q?IEOXkgBAQEBAQEBAQEBAQEBAQEBAQEBAQEUAg06IgEfAQEBAgEjHQEBESYBD?=
 =?us-ascii?q?wsaAiYCAlYGARQBAYJ8AYIvAQMOIwcNBrF2gTKBAYIMAQEG2lkfLCJXgWMDB?=
 =?us-ascii?q?oEaLoguAYV8g0Z6Jw+BVUSBFSeDAz6CYQOBX4NbgmmPLYcogxOCJooFJguHP?=
 =?us-ascii?q?VR9HANZMgFVExcLPgkWAhYDGxQEMA8JCyYqBjkCEgwGBgZZNAkEIwMIBANCA?=
 =?us-ascii?q?yBxEQMEGgQLB3WBcYE0BBNEA4E3BoltDIMHAgUhKYFOKYEkgngIMBNsFYEIA?=
 =?us-ascii?q?oJlgWsOYYNNhE9jgRCBRIFqAVCBHR1AAgELbT01BgMLGwY9pjWDZGU9AlQng?=
 =?us-ascii?q?UKTD7I0NAeCNoFggWIMiiGVJwYTL5c5DgaSaJhjII1WmxSBfCOBXDMaJIM2T?=
 =?us-ascii?q?wMZD44hGYQUhGHIK0E1AjkCBwsBAQMJhUYBAYNagUgBAQ?=
IronPort-PHdr: A9a23:CkmEHhYON90dfH+y47Z+l3D/LTHS2oqcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1g6PB9WHoKoUw8Pt8IneGkU4oqy9+EgYd5JNUxJXwe43pCcHRPC/NEvgMfTxZDY7F
 skRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQviPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCS5bL9oM
 hm7rgrcusYKjYZhN6081gbHrnxUdutZwm9lOUidkxHg6Mmu4ZVt6T5Qu/Uv985BVaX1YaE1R
 qFGATolLm44+tTluQHMQgWT6HQcVH4WkgdTDAje8B76RJbxvTDkued7xSKXINf5TbEwWTSl8
 qdrVBrlgzoJOjIl7G3ajNF7gblFqxy9uRNw34/UYJmUNPVgeKPdYcgaTndFUspISiBNHp+wY
 44JAuEcP+hXspP9qkMNoxWwCgajCv7hxCFWi3/43aM10fguHw7d0Qw8BtIDqmjYoMnrOKoQV
 +2+0anGzS/Eb/NTwTrz75LHcgoiofGRRrJ7bMXfyU0hFwPfj1WQr4PlNC6S2+oKqWeb9elgV
 f+0i2I9pA9xpjavxt0tionPiYIY0V7F+jtiz4ovONK3Vld2bNi5G5Rfqy+ULZF5Qt8+Q252o
 iY6zKULt5C5cSYK1pkr2wPSZuCEfoWH5h/uVfudLDR4iX9qfL+zmwi//Ee+xuDyWMS500pGo
 CRbn9fDt30D2R/e5tSER/Z740yv1zGP1wXJ5eFFJ0A5ja/bK589wr4qiJUfq0PDHjX5mEjwk
 aSYdV0k9/C25+j6fLnqvIGQO5F2hw3kL6gjmtazDfk3PwQWW2WW9v6w2bP+8UHjQ7hHgOc6n
 63ZvZ3cOM8WuKq5AxJO0oY/9Rm/FSqo0NUZnHYZNF9JZBSKhJXzNV7UOvD3F/K/jkyskDh1w
 /DGOaXsApDKLnjejLftZ7h85FBHxwYp0N9Q+YpYCrAHIP3tRk/8rMLUAgInPwCu3errFtdw2
 pkDVW+PGKOVLazfvUeN5u01IumMYIEVuCz6K/gg//PgimU2mUUefam0xpsbcn+2HvBoI0WDY
 HrshNgBHHwEvwUgV+PmkkCNXiBLa3a0RK0z/is7B56+DYffWoCth6SM0DmjEp1Mem9GEkyME
 Wvvd4icR/gMbz6dLdNgkjEfTrigS4oh1Qm0uwPgyrpnKPDU+iwCup752th1/fXflQsu+jxsE
 8Sdz2aNQnlwnmwSST45xqR/oUhmx1aC0Kh4hudXFcZJ6P9TUwc6M4Tcz+1gBNzoVALBZITBd
 FHzbty4AD15Z9Y4xZchYkJ3Fs++xkTH3iy3E5cJjbGBAJ07tKXG0C61b816wH3H/KgnlVgvB
 MVVcSWli7R5+gyWBYfPklmejb2Ca6sRxmjO+X2FwG7Iu1tXAyBqVqCQeHkFZVbN5fn96FnDS
 bDmXZEuKAhc0oivLqVQa9vmpUpLTrHvNYKNMCqKh26sCEPQlfu3Z43wdjBYhX2FYKBluwUa/
 HLccBM7Gj/kuWXVSjpnCVPoZUrot+h4snKyCEEunEmRd0M08b2z91YOgOCEDesJ1+chsT0it
 i4yMVKzxdPQBPKfqgAncKgPKcgl7gJ/3HnC/xd4IoTmKqljglAEdAEimkr01AhsTKhEn9Irq
 nwC0wd4b66Vgxtabz3N+5f2N/XML3XquhCib6mDwlbFzNOf4bsC8tw9rEj/+h6kHAwu/h2Ly
 vFz1H2RrtXPBQsWC9fqV1ovsgJ9rPfcazU84IXd0TttN7O1u3nMwYBhAuxt0Rumc9pFVcHMX
 AbvD80XAdSvI+02ihCoaBwDJuVb6K8zOYuvafKH3KehOOsokiihiCxL54V000TE8CQZKKaA+
 p8fwOyDmCaDWS39iliJrc3934xJJHkTEme51Sn4FdtJfKQhNY0PCGqoP4i23oAk3sSrASQHs
 gf+QQpai6rLMVKIYlfw3BNdzxESqH2jw26jyiBs1isupeyZ1TDPxOLrcFwGPHRKTS9slwSJQ
 8D8gtYEUUyvdwVsmgGi4BOw4qFBp7lkaUTXT11JeSfeMGxoFKe9/OnnAYYH+NYzvCNbXf7pK
 3WTUL3guF031y35Hm1R7C82fXemt9+q+n4ywHLYJ3F1on3DfMh2zhqK/93QS8la2T8eTTV5g
 z3abrSlF+Gg5s7c15LKs+TkEnmkSoUWay7gi4WJqCq842RuRxy5hfG63NP9Q0A21iry1t8iU
 iutzl60R4Dx1Lmhd89jcFNpAlDU9MdwXI1z2oc9n5Af33EGi47dpyNd1z2pbpMChOSnMDIEX
 nYTzsTQ4RT51UEGTDrB3I//WniHg4Nga9S8fmIKy3c45sFOBr2T6e8Mli90r1yk6APJNKIkx
 HFHk6RosSNc2r1a3Whlhj+QCb0TA0RCaCnllhDSqsu7sL0SfmGkN765yEt5m9mlSrCEuABVH
 njjKfJAVWd96NtyNFXU3Tj98IbhLZP1ZMgQqwbSvhPOlelTJ7oum/BMiSctagef9TU1jvU2i
 xBjx8TwmYGdKHh2uo+9DARZMDLdeM4ZvD3gx/U7/I7ez8WkGZNvHS8OVZ3jQKezET4cgv/gM
 h6HDDw2rnrIUaqaBwKU711q6m7eC53+fW/CP2EXlJ8xIXvVbFwamg0fWy8224I0Bhz/jtK0a
 193v3gYtFv/twcK1e9icRXyGm6NoQC1dnIkRp+FMxNM4kdd6k2TPcH7jKo7FnNd+YC96QaKN
 2qQakJXAGtPVkHMDgLmOaSyoNLb+fWcBaznJv3COPOFruk7Nb/AzMCq1ZZ6uj2XPcKVJj87B
 vs3gwxIWnUxDc3dn39npzU/sSXLYobboR69/ncytcWj6LHxXwmp44KTCrxUONEp+hasgK7FO
 fTCzCB+YS1V0J8B3xqqgPAWwUIShidydjKsDaVItCjDS7jVk7NWCBhTYj16Nc9B5aYxlgdXP
 suThtTw379+xvk7bjUNHUTmgd2sbNcWLnuVMVTaGACUOb7AKTCKi8D7bKWgSKFB2eVZsxrj3
 FTTW0TnPzmFi3zoT0X1aLsK1nvEekUD/tjhIXMPQSD5QdnrawO2KopyhDwym/gvg2/ScHQbO
 n56el9MqbuZ6WVZhO9+EipP9CkAT6HMliCH4u3fMptTv+FsB3E+sutA42khjZZR4jtFQvNdh
 ybY6NJj6QLD8KHH2n98XRxCpywezpqMpllnML7F+4NoXHHZ4FQS4G/WBxlA9L4HQpX//qtXz
 NbIjqf6LjxPpsnV8cUrDM/RMMubMXAlPHIB/RbLAQFDQTP5bQk3ZmRYl+yOsGKYpN42p8q08
 HLhYqBWXho5G6FDYnk=
IronPort-Data: A9a23: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
 aUIqbh4fXyG
IronPort-HdrOrdr: A9a23:X9V2U6HYgiTQM15OpLqEPMeALOsnbusQ8zAXPo5KOH5om7+j5q
 STdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3AhztzN2m8opvi6rzN9CoeyC7PbwHXOVTZiybvImu?=
 =?us-ascii?q?JMG1kaJKUFEbX4IMjvMU7zg=3D=3D?=
X-Talos-MUID: 9a23:Yd0mHQj/Mn7GcEOWpyTj5MMpd5dxuLa2ERk0tL42pNaYCR5fOyyYpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,199,1712613600"; 
   d="scan'208";a="168154579"
X-MGA-submission: =?us-ascii?q?MDFf46BeggxPe7NS+XbDThZrwh5weCfb1yC/7m?=
 =?us-ascii?q?9y29FGF+hv8SDODNNgPqmXkiittPvHxs2mJe0xUqPjWnQv/fF5wx6oNn?=
 =?us-ascii?q?DTKSY6FpOrCozi9G3VGKNhkuce9SJNVTxBQkr27UiNA2f8UEuYIZQBc/?=
 =?us-ascii?q?aCSZU4ioeTJDlXXtpQ3APOUQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 11:05:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717059941; x=1717664741; i=markus.elfring@web.de;
	bh=AKA2sgCHan22Dyd94SfDgIjyQAoUdPZIvOVvutCvuVk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=t0l2ueHEf8zNHMCl4EGJ+CCVzvT3ShrV652nYACpY/wzrEBd7/GFaihNmcNoNLBj
	 sp/C8Rad+h93apnlxpsMWbrBpdG1XjEsq5Z31HFYWL4c0T8hmjKJHmL8AzC2fhoX0
	 3pTZRHU6b1ho8BYTmWY2gXxdBlhIa6m1fcWbi7s8B6xh12RgX5ckm1RiDz7HSNk9P
	 E7d3SJrU9IU4Y/L8cQI735tpby2ltVM3f5UwguSQ91qleFfPJwpteTBkZaXFFNZWl
	 LUVB2r/kLvrEYtPYXAvBTcIaQwKEUgfkL2x+v6dKX5dtIi9l+ybyyU+D7IIkCFgnX
	 03+cWnQHUqOvSmAtvQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MA4fW-1sJnn44Ao6-00BkTW; Thu, 30
 May 2024 11:05:41 +0200
Message-ID: <b9fbac02-a1eb-460e-80f0-07b32e704bb2@web.de>
Date: Thu, 30 May 2024 11:05:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: David Alan Gilbert <linux@treblig.org>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
Cc: Julia Lawall <julia.lawall@inria.fr>
References: <7eb9626c-da7b-414d-bf50-da1eed27be31@web.de>
 <alpine.DEB.2.22.394.2405261847380.16852@hadrien>
 <2dc6a1c7-79bf-42e3-95cc-599a1e154f57@web.de> <Zlckg1LH-2TBew85@gallifrey>
 <e6de2b59-c9c5-4714-8a4d-5c5970b9fad4@web.de> <ZlfIl39GRcXKFRn6@gallifrey>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZlfIl39GRcXKFRn6@gallifrey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AciCZ4igdXJ1+CD2A9wqTq2M5jfvMDtL70rSIU7q2o4EjzIHqeT
 xoluV8gh8a4PR0CiB77DcsjtiIO6Nb+6MwUTKLVSbs0PtIYAKQY1ORRiMM3Tbs5LKxJlOSL
 ZFFf9t90OpaaL/Vn5uD8THh+kXr/FkaBZr5tPYm3whSYVPrVv+5q2nkdAxiKikIOp4rjDNl
 ZchodNYRvmqph2Y7g0YCg==
UI-OutboundReport: notjunk:1;M01:P0:fIjwmVIt960=;TxgzFQ+8Z6+XX1EJ5yousZPcRj1
 Q2+1X4MEyOK16P5/APIoeuXyQRjmUjbt1ZRhWuSibjQ2LtxVlK5y7xbFfrQEdPWklW1IcuWBE
 ZiDvQO7OzgFaBr4Yh/CuheSYwRLJSkuJI/9DaKJbOk+0ns0rTCozPSRouBux3bdQu90geE7fi
 wP20BrI3yc6q6YKctO1CRX57lykcydMxnXSmTDaNmijI/dAYwEaFDFvV+eoJ+dlb7H15+xo1q
 J93m5WTM1Kad7g4XvzbATTYnOX7Dyb22oi3secSQVSPnaf+wkFU1Ti5lDRWecAJPEDE5Vp619
 cOGXeurULulJgMtqqU3yd09wQY6yLKVEp889KGMxGmIYDmcvpSvsqafJ03hqduWiSuRTMOfz8
 emhyux0z+ZYL6GbobgDaY3YPNvOW8PN+OHcLAARp6F6fuFqmTAfpftzAXOFMkVMTTJYFli4ro
 IoedjKtv4/mFF88ZktxR/Ck/5seK06heFzvBZddnv0bGFzJsgFaCInMGA60DsWfpjYY7QiHow
 gF0zhNopX0Q6lP69jLptJR0DaT4I6/aHYVH7wpWSp2X4jNgIs5uv7KImLI/ijti0lGK0EeZdP
 gIyedyy6wy9RNxdEEAeX5abDs366Oq3TzvTZPNvmItFAUHFLdndevstG2eqg68PSEUiDDZx1o
 W6E+Do7yLujKlOHASLXlnozvJ1mn/kJNTpFpgEiGuTWHi/gxhp6EtfFncbMq0fzqLDyko3cdz
 hPNX9wWvrecIgzVmBam/Zh1EUfEqtcr/HOSRtd+lROYOBDyFjfD7wZB0IMbWDuScLR+/nLrI0
 Ds81+LdX1DZrNr7ccGjPz1RW6EldX9M0WrpkaYeXr85dY=
Subject: Re: [cocci] Looking at lock scopes (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1768
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/b9fbac02-a1eb-460e-80f0-07b32e704bb2%40web.de>

>>> Is there a way to look for functions that have a lock, followed by unl=
ocks on
>>> multiple error paths?
>>
>> Probably, yes.
>> https://cwe.mitre.org/data/definitions/667.html
>>
>>
>>> IMHO the nicest thing with guard is simplifying lots of error paths, a=
nd
>>> innevitably someone forgets to unlock in one of them.
>>
>> Would you like to improve the support anyhow for more complete and succ=
inct
>> resource management in affected software areas?
>
> I was just suggesting a perhaps more targeted approach rather than
> just looking for all cases of lock/unlock.

How would you like to handle source code analyses if lock scopes
would occasionally be distributed over different function implementations?

Will development interests grow also for checking combinations according t=
o
other pairs of actions?

Regards,
Markus
