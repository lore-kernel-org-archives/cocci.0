Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7168CC87FC9
	for <cocci@archiver.kernel.org>; Sat,  2 Aug 2025 12:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=18h3wtys1lcrYeKnjag9LgVINf4nMZ/6Jb3KboYTF/c=;
  b=MU3hle5fCquAcvFnUT26wD/bbRrD50dE4/eyBbh2p2bLR1taikCcI++x
   YrgN0SmbIsEusmh5gDM701N3b9PlMyF2pRHFuKaDUWVMPJjHNA8vG7AVo
   TQyY14L/JVJHnWtRAyQtsv0qTu+eHfCaJsoedVjn5ACnc1q2VLzQa4B5F
   c=;
X-CSE-ConnectionGUID: T+HvNxozSbWamipzUTwAkw==
X-CSE-MsgGUID: 7uKQQE7KRzmUfj04Qrh11A==
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
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233955804"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Aug 2025 14:56:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D95CCE0B0D; Sat,  2 Aug 2025 14:56:37 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 83832E0171
	for <cocci@sympa.inria.fr>; Sat,  2 Aug 2025 14:56:36 +0200 (CEST)
X-CSE-ConnectionGUID: gAnopS/TSXWQqFfFvsUZjg==
X-CSE-MsgGUID: 5q7s1LoiQHW2AmqkfykfPA==
IronPort-SDR: 688e0b03_dxEVwmffEQo3PxoAjgWFE+kkt59JQi4Q4EKHKLDN9k2y8d1
 isCo2evg59J2HdbawDPRBCB4bpeEhsZDMUctxdQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H6BAC+CY5ogA4P49RaHgEBCxIMQIFIC4JEgQZUMwQLS?=
 =?us-ascii?q?YRVj1CCJIQ7hzyHVYh5gVWBfQIPAQMBDU4BAgQBAQMEggyCdAKMGgIeBwEEM?=
 =?us-ascii?q?AkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxh?=
 =?us-ascii?q?XsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJgEPCxoCJgICV?=
 =?us-ascii?q?gYBFAEBgn6CIgEGEAEDDiQHsF+BMoEBggwBAQbaXh8sIlmBZAmBGy6FbYJkA?=
 =?us-ascii?q?YYng0J6Jw+BVUSBPAuCRzE+hEODW4JpgiaBFoNjNoIzihuCAQGGblJ4HANZL?=
 =?us-ascii?q?AFVExcLBwWBIEMDKjQxI0sFLR2BJ32DDYEOhCcrT4IidYF5QRk/g1MeBm0PB?=
 =?us-ascii?q?oEVGh4tAgICBQJDRYFgGQYaQAIBC209NwkLGwY9k1SDIYIVJ4EkSZJpgz2vb?=
 =?us-ascii?q?DQHgjiBZ4FkDJ9sBhMvl1IOBpMFmQYiqR+BaDqBXDMaJIM2TwMZD44hhDO9X?=
 =?us-ascii?q?EE1PAIHAQoBAQMJhUYBAYtbgUsBAQ?=
IronPort-PHdr: A9a23:Qx2CihBPUSSIqNm5FNEhUyQU0UkY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZua42ygeSFtyDtawcw8Pt8IneGkU4qa6bt34DdJEeHzQksu4x2yEGPouuJHa/EsTXaTcnF
 t9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFRrlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5/I
 hu7oR/NusQYjoduN7o9xxrIr3dUZu9b2X5mKVWPkhnz4cu94IRt+DlKtfI78M5AX6T6f6AmQ
 rFdET8rLWM76tD1uBfaVQeB6WMSXWoPnhdWDAbL8Qn2UZjtvCT0sOp9wzSaMtbtTb8oQzSi7
 rxkRwHuhSwaKjM26mDXish3jKJGvBKsogF0zoDIbI2JMvd1Y7jQds0GS2VfQslRVjRBAoKiY
 IsJE+oBJvtTo43kq1cTsReyGQygCeXywTFKm3D2x7U33ecvHw7J0gMuAswAvWrarNv1NqgdT
 e+7wbLUzTXadf5axSvx5JbKfx0nvPqCXahwcc3UyUQ3EA3KlE+QqY/4PzOOy+8DvGyb7+R6V
 eKujW4npBx6rz+oyMg2kInJhZ8Vykve+St2xIY1K8e4SE99Yd6rC5ZRuT+VOJBsTsw/XW5lo
 SA3waAJtpCnZiYF0ognxwLBZPyddYiF+hLuWeSNLDtlmH9oZKyyiRm9/EWjyuDyWdS43llKo
 CZZnNfBqHEA2gHd58WFVvdz8Eis1DeN2g3Q6+xIPUQ5mKvdJpU8wbAwjoIevVreEiPogkn6k
 rGae0c+9uS16+nreKjqq5CEO4JwhQzyKKojltGlDek6LgQCRXWX9OKh37P550L5Wq9Fjvgun
 6nZrp/aIcMbq7a8Aw9Sz4Yj9wyzDjm439sDh3UIMUxKdAqGj4jvJV7OPOj1Aemij1iyijtn2
 e7KM7/7DpnQLnXPiqrtcLll505Z0gUzzNRf55xOCrEGJfL+Qkj/u8bCDh86Lgy02PzrBtp51
 oMQQ2KPA6mZMKzJvF6G+O0gOPOAa5ILtzrlMfgq++bujWMlmV8aZaSp2YEYaX6iEfRiJ0WUe
 nvtgtYEEWgRpAoxVvbmiFyEUT5JZna9Rbgw5j8hCI6+F4fMWpitgKCd3Ce8BpBZemdGBUyQH
 nfpbIiEQPcNaCeKIsB7iDAEVL6hS5Ug1R60rgP6xaBnIvLS+iIDrZ3jzsR65/XPlREu8jx5F
 9qR33mCT25qmWMGRCU40bhxr0Jy0luDy7Z3g+JbG9JJ//5JVwA6NYPAz+BgBdH9RBnOcs2UR
 1m4WtmpHDIxTtM0w9IWe0hzFNutgA7f0Se2BbEZj6GEBJku/aLGw3f8P95zxW/e2qcul1UmW
 dNPNWO+i6Bl6wXdGpPHn12Cl6aye6QTxC7N+3mHzWqJpExWSBd+X73KUyNXWkyDj8n950qKa
 7axALAjel9D1MqDI+1OY8LgiVFuRfH5Od2YbXjn3y+7Ah2Dx5uNapDrciMTxnbzEk8BxiUa5
 3WbLkATAim7omTRRGhLHEjsfliq3O1wsnK9QWcrwgvMY0A3hOn9wQIcmfHJE6Bb5bkDoip07
 mwsRD5VvvrTAtuE/U96eblEJMk66xFB3H7YsAp0OtqhKbpjjxgQaVc/pFvggjNwDIgIis02t
 DUy1gMnDKuC005aMR6c04rxPLL/NWT4uhyiOObNwl+L6N+N4e8U7egg7VDqvQWnDE0nplBuy
 dpIyD2x4pvQDQwdeY38WAA7+ksyvKnUNw864Y6cznhwKe+0vzvFjsouH/cgww28cs13NaSZC
 EntHsdcC8XGxPUCvV+vY1pEOelT8PRxJMa6b76c36XtOu98nTWghGAB4YZn00vK+TAuAujPl
 40Ixf2VxG7lH3/1kUuhv8brmItFeSBaH2yxzjLhDZJQYas6dJgCCGOnKcm6jttkgJulV3ld/
 V+lT1QIva3hMT+bdV/gxkt90UoNoHqosTS1xXp4nnBhr6aS2jDP3/W3bAAOaSZAQGhvi0upI
 JDh1YlAGhLyME5wyV38uRWfpeATvql0ImjNTF0deiH3KzsnSa6srv+YZMUJ7po0sCJRWeD6Y
 FaAS7e7rQFJtkGrV2ZY2j0/cCmn/5vjmBkvwkeUNnVutzz0fc9qxBHQzMPRT7hd03BVIUsww
 SmSHVW6M9SzqJ+xno3Ar/v4emavTJxVfgH0wInGuCbxtggISVWv2vu0nNPgCw0z1yT2gsJrW
 Sv/pxH5eoD31q6+PIqLZ2FQDUTno4p/E4B6yM4rgY0InGIdjdOT9GYGlmH6NZNa37j/ZTwDX
 2xDz9nQ6QnjkEptSxDBj6fwTHaA2Y1MY9egY2UZ8j0w5YZGBe+Y4adFki18vlej5ViIO74nx
 GhbkKZosSJSivpBoAc3yySBHr0eeCsQdTfhkRiF9ZH2ralaYnqubanl0UN/md67C7TR6gpYW
 Xv/ZtIjBXoqt585agiTliSurNi4K7yyJZoJuxaZkgnNlb1QIZM1zL8RgDZ/fHj6tjsjwvI6i
 hpn2de7upKGIiNj5vHcYFYQOzvrascU4jyog7xZm5Pc+om1HYh6XBgPUoHpS/2ADz8Y8/jqf
 VXrcnV0ujKAFLzTEBXKomJvtXHSCNaGM3+NJX8W5cpvTl+RKQYM5WJcFCV/lZk/GAewwcXne
 0os/TEd6GnzrR5Uw/5pPR3yAS/P4R2lYTAuRN2DPQJbu0tcslzNP5XUvYcRV2lIu4espwuXJ
 imHahRUWCsXD1ecCQmrN+ur4sTctfeVDKyyIrPHM7CJtPAbR/mP342myIcg4DuGcMmCWxsqR
 /Rp301eQTVzHNnfkDhJVCEd0S7AJ8fJoRCh5mh8tcqi9PetAQvp6dLJALxXVLcnsxnkhKCeK
 6ubny1+My4ej5oKySaOw78alEgbjyUkH9W0OZIHsyOFDKfZm6sNSgUedzs2LsxDqaQ1wghKP
 8ffzNLzzL9xyPAvWR9DUhT6l8elaNZvQSn1PU7bBEuNKLWNJCHai8Dxb6SmTLRMjeJS/xSus
 DefGkXnM3yNjT7sHxyoNOhNimmcMnk88MmldQ1xDGH4UN/8Qhi8LcMxkjA8h7E5xzvLOWMaL
 TlgYhZNo7mXvkY6yr10H21M6GYgLPHRwX/DqbOCddBP7L0yXncR9aoS+nkxxrpL4TsRQfV0n
 HGXtdtyuxS8leLJzDN7UR1IozINhYSRvEwkN7+Kk/sIEXvC4h8J6n2dThoQoN4wQPjmoaNN0
 Z7ikKzpKTFN283Z940QCoKHTaDPeGpkKhfvFDPOWUEdSiW3MGjEm0FHuPSV62HTsZUw7JTh0
 slrKPcTRBk+EfUUDV5gFdoJLcJsXz8qprWcidYB+Xu0qBS5rCRyu5faSrSNDP+pJDvL1dGsg
 jMXzLm+IYlBbuUTNGR9Z1M8kImYQiLt
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:HK5fgq8RBNeXk8fRmr5uk+AMI+orL9Y04lQ7vn2ZhyYlEPBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3Akf6E3GqCu5UesoSDRcT83CPmUc8MdHrF9zDsGH+?=
 =?us-ascii?q?HMH9HRpOLUmKi+qwxxg=3D=3D?=
X-Talos-MUID: 9a23:3FD6WQbY55RIBOBT6iazn2hGM8ZRw5v0IUUUkpsXuMe8HHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233955769"
X-MGA-submission: =?us-ascii?q?MDGPTxUP5GJr2fBtXzUz3Ol5gjR42K3BDyFwOb?=
 =?us-ascii?q?tvcSLzy2O1LPyVYltoxflxDbU8djC/wnIoUGPKSnDaHqhG/ITCC8EKET?=
 =?us-ascii?q?e5Eo9AgWAEDwKO5jJSUUGXudGlMQgjGuuCOIfl1i16yNptg/WkgOPpMM?=
 =?us-ascii?q?0JUEYAWPRif3iUAA+TIZrLpw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 14:56:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754139395; x=1754744195; i=markus.elfring@web.de;
	bh=18h3wtys1lcrYeKnjag9LgVINf4nMZ/6Jb3KboYTF/c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WwwCVdUpCGM54gvD6dt2tS7O8/5XSaCF3QyuJw8w6fvYg6je5t4HkjAcSbjH32eD
	 8xdU57L9Qe7OZhjR9RUDMa/+YrELDVnf4fRZU1Zc/sm1Vx6m98d/8xz8DlxGYmMxl
	 KNVuk/673DvWDu9Zec9BwpMctoT4mHZBvdPyiGooKmWjEI4vkdfT2X7Tj+O23+6lZ
	 utlmOnRT94LAJ+rp5ICwYXp3M2udotnLXaEa8cGeSsEpY1A3hRzzpWrSjjUzjJuwv
	 gLEQflqUa+jmf7udUCOQkcCIlqVipJVt3uqtMMhKyoG/YoyzsZEoDmaK4YiunZWJJ
	 6Ie//VyVuMOFd9ErJg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.1]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N1LsV-1uX91l3NJD-00xeNF; Sat, 02
 Aug 2025 14:56:34 +0200
Message-ID: <c5042d2d-43df-4276-9611-da4f30763940@web.de>
Date: Sat, 2 Aug 2025 14:56:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr>
 <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de>
 <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr>
 <b7298dde-48c6-4e0a-87af-2046ab999ec3@web.de>
 <3cdb1e5b-72bf-475a-a83b-c469e0225c84@web.de>
 <23a375dc-e768-f2b2-1036-909be61596d4@inria.fr>
 <70a43c52-f898-4fa3-a4b3-16c54bd4f9cb@web.de>
 <c1d74aa4-44db-4618-ba59-e9b6dab28c0e@web.de>
 <alpine.DEB.2.22.394.2508021326250.3428@hadrien>
 <7560a81f-ba29-4b16-b8ed-95cb4d72f3f4@web.de>
 <alpine.DEB.2.22.394.2508021353080.3428@hadrien>
 <e0519749-0043-4cb0-a12d-6a34e2076f58@web.de>
 <alpine.DEB.2.22.394.2508021409080.3428@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2508021409080.3428@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GUNgVJ6mkVxe+NusitFGznW1DFvHNRaXAg9LhZBEky7IVvanTXy
 +mWuW5bWEx8oHnXZEbBoqN3hasmbGYdpzCYybpZKBrWMAaqQhRLIuLiiQ0gH1p4hzJcnOEF
 wEWW4vHL9JVhtZBaGm5MOTXCnz4qUpdPY9vemHLSXxIWoBOCfPQsSN9FfrJGWeGhs29WwrZ
 WtDdUiCN5wtYI8fpy/zmg==
UI-OutboundReport: notjunk:1;M01:P0:OmMDO+iszWw=;NhGHJKVvtvSrtHNr1PpsiiRZ5Zf
 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
 90jEqoCmjg63aJ53Cwgf2As=
Subject: Re: [cocci] Searching for lock calls without unlocking (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2932
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/c5042d2d-43df-4276-9611-da4f30763940%40web.de>

>>>> May I expect that only a single call should be marked for such a test=
 case?
>>>
>>> No, I already explained why two calls are marked.
>>
>> I see further challenges with this explanation approach.
>>
>>
>>> The shortest path constraint is that for A ... B, the ... doesn't cont=
ain
>>> A or B.
>>
>> This is generally fine.

How does the =E2=80=9Cshortest path=E2=80=9D fit to the statement =E2=80=
=9Caction_lock(&blockage2);=E2=80=9D
from the if branch in your software view?

Can the path distance be determined anyhow?


>>>          It doesn't mean that the rule can't match at multiple places =
in
>>> the function.
>>
>> I find that this information will need further clarifications.
>=20
> Coccinelle considers every node in the control-flow graph and checks
> whether the pattern can be matched at that point.  Each mach is
> independent.  There is no guarantee that one match will not cross anothe=
r
> one.  Furthermore, (just in case this is the concern) when you mentin tw=
o
> different metavariables, there is no guarantee that they are not bound t=
o
> the same term.

I am looking for further clarifications also according to such general inf=
ormation.
How will related technical details be represented in an improved software =
documentation?

Will it become more desirable to distinguish metavariable contents in an u=
nique way?

Regards,
Markus
