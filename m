Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5128AC87FCC
	for <cocci@archiver.kernel.org>; Sun, 27 Jul 2025 14:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=B2J4AVsogwUkSliETjxKILbxEDzmp0nqOCt6eXS5Ubs=;
  b=FrEkCM+N32zBptLAvCOdgkaADU7EIr5SUFtysmqprTXNrt2QZ9M/7apE
   86WFp38bHMqnBFBm+2fsajj+2VRNX8LO+h1EQ7Lc+JaYnzKQIuthO7Zeq
   qd6sTQEqodJcYYdd7XDpCrDoQiLP5aeeIvNp9lndiaP3PEoU9J2V87Rt5
   w=;
X-CSE-ConnectionGUID: Kk0qfXK/QfKvZ3nJylaXLw==
X-CSE-MsgGUID: necWszUYQtmSdOJDRQBvxQ==
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
X-IronPort-AV: E=Sophos;i="6.16,339,1744063200"; 
   d="scan'208";a="233262563"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Jul 2025 16:24:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4C5A4E0C55; Sun, 27 Jul 2025 16:24:48 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 62736E0171
	for <cocci@sympa.inria.fr>; Sun, 27 Jul 2025 16:24:46 +0200 (CEST)
X-CSE-ConnectionGUID: hJiOHcBnRVCIWjoKwAqd1Q==
X-CSE-MsgGUID: crsppyCyRnyJpzxDr9x4nw==
IronPort-SDR: 688636ae_eHd9gMiF52W2F7iWWJNz7GodMqPI0YscYAuBxte0fhZ9tAj
 Q8suVPXgrrWr5IWgA1p+qzocLsejkd/+j+Jp4fg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FAAgAVNoZogA4P49RaHQEBAQEJARIBBQUBQIFBBgELA?=
 =?us-ascii?q?QGCQoEGVDMEC0mEVY9QgiSEO4c8h1WIeYFVgX0CDwEDAQ1OAQIEAQEDBIIMg?=
 =?us-ascii?q?msJAowZAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBOwcOCjGFew1JARABggcBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECA?=
 =?us-ascii?q?SMdAQERJwQLCxoCJgICVgYBFAEBgn6CIgEGEAEDDiQHtTSBMoEBggwBAQbaX?=
 =?us-ascii?q?h8sIlmBZAmBGy4BhWyCZAGGJ4Q8Jw+BVUSBPAuCRzE+hEODW4JpgiaBFoNlj?=
 =?us-ascii?q?QeIT1J4HANZLAFVExcLBwWBIEMDKjQxIw88BS0dgSd9gw2BDoQnK0+CIgF1g?=
 =?us-ascii?q?XlBGT+DVB4GbQ8GgRUaSgICAgUCQ0WBYBFAAgELbT03CQsbBj2TPYN7gTSzS?=
 =?us-ascii?q?pRjNAeCOIFngWQMn2sGEy+DcQGTYA4GkwWZBiKpH4FvAjGBXDMaJIM2TwMZD?=
 =?us-ascii?q?44hhDPAb0E1PAIHCwEBAwmFRgEBhV6FU4FLAQE?=
IronPort-PHdr: A9a23:L+b3VhYXqJZX/zhEaTh3B33/LTGV2oqcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1wSPBd6Qu6MZ0qL/iOPJZy8p2d65qncMcZhBBVcuqP49uEgNJvDAImDAaMDQUiohA
 c5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFRrwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/I
 Ru4oAnLqsUbj4RuJ6U1xxbJv3dDZvhby35vKV+PkBnw4du98oR++CpKofIh8MBAUaT+f6smS
 LFTESorPWMo6sD1rBfPVQSB6GMTXWkPjBdGDBXL4An1UZntvCT6sPF92DSBMs3tUb80QzWi4
 Lx1RxLulSwKKiQ28GDTisx3kaJbvBesrAFxzoLIfI2YMud1c7jDdt0GW2VOQsdRVzRAAoyia
 YsPE/EBNvtco4XkulcCsQeyCQyqCejyyDFHm2X20LU53eovHg7J0hEuEcwAsHrUrtr6KKgcX
 PupzKnR1zjPc+9a1Sn/5YXObxsvoeuMXbV1ccfJzkcgDRnFjlaNqYz+Ijib2eANs2aB7+phU
 +KvhHMspgZ2rDe13McsiZTJhpkPxl7L8SV5zpw1Jdy+SE50etOlHoVfuDqAO4RrXMwvWmdls
 zs1xbMao5C0ZjQKyIg5yB7FbfyKa4mF7wz/WeqNJTp1mnBodK+wiRuw8kWs1+/xW8qp3FtKs
 iZLncXAuHAN2RHd98SLV/pw8Emv1ziB2Q7e6P9JLEIymKHGKJAh2qY9moQOvUjdBCP6hlv6g
 a2Mekk5+uWk8fnrb7r+qpKYOIJ4kA/zPrk0lsG7D+k0KBUCUm6G8uqmzrLj51f2QLBSg/02j
 KbZtJfaKNwepq6+Hg9Vzpwv6hihADi9ytgXgGcIIEpEeBKBkYfpJ0nDLO7lAfuhmVigjilny
 vLcMrH8ApjBNGXPnbj5cbZ48UFcyQ4zzd5F55JTD7EMOPX9VVXrtNzbEx85KBa4zenjCNVzz
 IMeWGSPAqCCPaLcr1CH/fgjLPSSa4MNojbyN+Al5+LyjX8+gVISYa6p0ocLZ3C5BflmOEWYY
 X/0gtgbC2sKvww+TPbriFKYSzJTaWyyU7om5j4nEIKmEZvDRoe1jbyFxii6EIdZZmRCCl2XE
 HbodoCEVOwWaC2IOMNhkzoEVaKgS4A7zx2uuhX6x6JhLuXP4iIYr47s1MBp5+3PkhE/7SJ4A
 9yS026TSGF6nXkGSic40q5wuUB90EmM0bZ7jfJCDdFT4vRJUhomNZLGwe11Fcv9VhjccdiXU
 FqpX9amATA0Tt8p29EAbEhyFcu+gB3f2SSmG6Ial7mRC5wu7q3Rx2D/Kd9lxXjJzKUhlEEmQ
 sVXOGO8mqNx6hXdC5bSk0WBmaalbaQc0zDJ9GeE1WeApFhWXhZ/X/aNYXdKRFbSrN2xwkrdR
 ruqQeAlLw9AwIiGI7RDbtnBjFNcRf6lNs6IJyq6nGy7BD6JwKmNZczkYTYzxiLYXW0NiQMO5
 j6rMQYkByGu6zb7BSZtCEmpTkfi6+h4p1ukQ0VywwzcPB4p7Ka85hNA3a/UcPgUxL9R/X558
 12cfX641tPSUZ+bohZ5Ob9bapU76UtG0mTQs0p8OIahJuZsnA1WaBx56mXp0Rg/EYBciY4yt
 np/6QNoKr+Dln5FeSmZ25/YJbDdbGX/r1i0c6CD4ljFy56N/7sXrvExqlHtpgasQ28r6XZ6y
 J9413WG55PFJBUfW9T9XxV/7AB08pfdZCR1/IbIzTtsPK2z5yfFwM4sDfA5xwyIetBCLOWbG
 QW0H8By69GGDusslhDpaxsFOLoX76soJ4a8cPDA3qe3PeFmlTbgjGJd4Yk73Fjevyx7AvXF2
 ZoI2ZT6lkOOSiv8gVG9s8v2hZEMZDccGXC6wDTlA4gZb7N7fIICA2Oja8OtwdA2i5noUn9ev
 FmtYjFOkOqgYxmPdBrQ2QNK1EIYiWOqk220wn08kj0kqLaewD2b2/7rJ1IMPm9GQnUnjE+5e
 9HuyYpAAw7xMk5wyEjAhw6y3aVQqaVhInOGRE5Je3KzNGR+Su6qsbHEZcdT6ZQuuCERUeKmY
 FncRKSuxnlSmy7lAWZawyg2Mj+wvZCs1TlzkmGANzBeqHTDeMd/7QjS7prQSLQCu1hODDk9k
 jTRClWmapOM9M+XioyFn+SwTWOnWbVMfCOtwY7K507ZrSV6RBa4mf60gNjuFwM3hDT629ddX
 iLNtB/gY4Pv2sxWKMpfd1JzTB/54st+QMRll5cowYsX0j4cj4mU+nwOlSHyN89a0OTwdihFS
 TkOyt/TqA/rvS8rZleA3YHkTTOwxsV7Zt+1Snwb0GQx4ohGBbyV47pNgSZu6gDh90SLO6c7x
 2pbkKdm4WVSm+wTvQsx0iiRZ9JaVVJVOyDhjVXA7tyzqrlWeHf6dLGx0ERkmtXyRLqGowxaR
 DP4YsJ4RHU2tJ8gdguRliSvueSGMJHKYNketwOZiULFhulRctcqk+YSwDBgMiT7tGEkzOgyi
 Vpv24u7tc6JMTYInurxDxhGOznyf85W9CvqiPMUu8+M3J20WLhlFC8KWpTAUv+iVj4f/6eCV
 U7GAHgnp3GXFKCKVyqW8kR7tDTiF56xNneYDGYUx5NuSVPOQS4XyBBRVzI8kJkjEwmsz8G0a
 0Z16Aca4VvgowdNwOZlZFHvF33SrwCyZnIoWYCSeVBIuxpa6R6fYqn8pqpjWjtV9Zq7oEmRJ
 3yHMk5WWHoRVBXMDgLmOaSyo8bN+a6UC6K3ff7JfKnLueJZTeiB357pzYZsuTqBU6fHdnAwC
 vomxg9JWm1/EMmfhDgFDSAa3yufasmGuFK34SdqqsP5qf3tVFup7oyKbtkaedw9/herneKIL
 OWXnj4/cD9e2spKznjNgK4W2FpY4813Xx+qF7lI9SvETaaK37RSEwZecSR4cs1B86M72ABJf
 8/dkNL8kLBi3LYzDB9eWFrtl9vMB4RCKnyhNF7BGEeANaiXbTzNzcbtZKqgSLpWxOxKvhy0s
 DyfHgftJDOG3zXuUhmuN6lLgkT5dFRGv5qhdx92FWX5ZNfhdwH9L9J9yzE7gPU1in7MKW8AI
 G18fkdK/djypWtThvRyHXAE72Iwd7De3XzDsK+Bd9BP7agOYGw8je9R7XUkxqEA6ShFQKYwg
 y7Otpt0pFrglOCTyz1hWR4IqzBRhYvNs18xXMeRvpRGR3vA+woAqGuKDBFf7f5sEN7yoOZ9z
 tbVlaT8AChP+ZTY8IFPYqqcYNLCK3cnPRfzTXTMCxAZSDewKWzFr0laje3U6XCf6JQ34MuJ+
 tJGWvpQU1o7EekfA0JuEYkZIZt5aTgjlKaSkM8C4XfWRPb5W8hQ+JzKBKv66RTHLTGEkf9ba
 hFOzb6qdez706Xk1kYkZlQoxOz3
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:A+KTH6iqbLFJxP3WrzOHBr6f3nBQXgQji2hC6mlwRA09TyXqrb
 HKoB19726MtN9xYgBHpTnkAsK9qBznmqKdjbNhWYtKGTOW31dAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkdNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQlTuRRjz7LqVsLjM2fabR+a
 DsnfauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3A8cbvaWlacL5dlkGLasvFmEj0lZ3XOX3/zVDwKGW?=
 =?us-ascii?q?+M1hCaYKXTnyP0bpoyvM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AQsoncwxOLxqDKOCqoZHW0c8El9GaqK+0E1gVgL4?=
 =?us-ascii?q?Xgc+VFzRiKxuH3STrRJByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,339,1744063200"; 
   d="scan'208";a="233262562"
X-MGA-submission: =?us-ascii?q?MDEJIsGzTP7LsPHZfsMtJF0JZQ/DpMsvqYlrve?=
 =?us-ascii?q?nVhl/JzdQDEA8fVnrNHgHu7v4KDISgCBY0R7mdWdD6OeEmVe4eaPTHSz?=
 =?us-ascii?q?mgzAepIlDg5EJ1vwrxJO6ouMSVeF5pa0b4w5NmLOq245yyR94pooNm23?=
 =?us-ascii?q?eXTQIfzq3fnai8c6Laa+0OiQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2025 16:24:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753626285; x=1754231085; i=markus.elfring@web.de;
	bh=B2J4AVsogwUkSliETjxKILbxEDzmp0nqOCt6eXS5Ubs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WuIFWJtRFZxWUU25NEHIECGBrKbrLkM+WY3/0ZrvMt5lFIVyHdOdwTFz36k4rqCV
	 Rhk4lh+dxOhOwRfXysNbROZC7c1pQPJ7PuNuW+SzjHVtsopf7KoXqD0U28ota56Bs
	 XQsWRq7/fTWFAopWZG/8qHG5YXzl2uidmKLL/PcnGpyKX5KJ8mgZa4ERKDWwMd9a2
	 FWtayWbA2l0k+0e8WFbqGvrQHITqI80N00oUW0r+d/m5jzovAWUMG6080XIJ9Se80
	 culiV14xEX/pEs/t+arPJ5p14YOIISYXTj/NOh6gVRyqKs81KcOxBVbJs1fTxb0W1
	 2UTg+x418j9g2GqEVA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.1]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MxHUC-1uVEaS3qPI-010EVC; Sun, 27
 Jul 2025 16:24:44 +0200
Message-ID: <ca8b22e3-7ccc-4e33-9938-9035d259cec6@web.de>
Date: Sun, 27 Jul 2025 16:24:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <67e35fac-d223-4067-882b-a632a57c792c@web.de>
 <alpine.DEB.2.22.394.2507271618550.3493@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2507271618550.3493@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ISQMCvdTibkxRsCH54ACFYALWfHHOhGs8+lEPIllIRo562Hg9ph
 VPYFT8bpIW71JYrjEUA0li/B5vxKxFfNrKtno1QKlBIxNZKiO07y819SeuFMJqSsHRFsoVJ
 nDhT6eoNG/0oZsefdzyhtB3bTxmhNCVI5xw1M6XkfVLoNm5QMrsigmxuJGGJkgqU8APYqrv
 hPF1AJCstqxeA0eH2lAZQ==
UI-OutboundReport: notjunk:1;M01:P0:g1CMXraSG/U=;hmxj5Y//9TjdLnvB8BmFkqIZVAW
 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
Subject: Re: [cocci] Supporting expression fragments with SmPL dot variants?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2919
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/ca8b22e3-7ccc-4e33-9938-9035d259cec6%40web.de>

>> @display@
>> expression x, y;
>> @@
>> *(1 * x) /
>>  ...
>> *(2 * y) /
>>  <+...
>> *(4 * x) /
>>  ...+>
>=20
> You have to make a real expression.

I hope that this software limitation can reconsidered better.


> What you show is not a real expression.

This is obvious.

Can it be detected anyhow that corresponding parts are occasionally repeat=
ed?

Regards,
Markus
