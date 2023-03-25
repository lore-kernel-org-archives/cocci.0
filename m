Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94DDC6FD1F
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 17:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=8sdA88MBEyOgI5cOnWpmo+cMqsE8r3krOe/kC3XSUEE=;
  b=ayZfjf8JDW6fQdFeLlWUcjbpYFWIp6L9LoGtSePbOfuk6rZl6jJv7W5V
   TkJ5XjyPZVbZOYg9f8Mxuigxrq4HXQdqUchIvEGWuvvBaNCIOEfXl30Pn
   jFTyaIfjLzEhEbPAwMg9SuqiMPDrZDksMNG60S9vLDffdVF9iLv/JJgXz
   g=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99078905"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 18:10:36 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B5B70E0D41; Sat, 25 Mar 2023 18:10:35 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6E2CFE0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 18:10:28 +0100 (CET)
IronPort-SDR: 641f2b03_rB02LNsb89DG4IcobMIxhSxHwi5IXemm2t/T9EcaUMdNQsE
 cHosX+6bOxiupljuIQJFSJmW5lBVV6O3Pj0C0qQ==
X-IPAS-Result: =?us-ascii?q?A0FfAACiKh9khw4P49RaHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YItdVYvBAtGhFORATGEL45miGmBVoFAPg8BAwENNA0BAgQBAQMEhH4ChToCH?=
 =?us-ascii?q?QcBBDIHDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBARoJF?=
 =?us-ascii?q?wcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICFDMfN?=
 =?us-ascii?q?B0BAR4BAgIBIx0BAREmAQQLCxoCJgICVwYBDAgBAYJ6AYInAQMOIwcMsGaBM?=
 =?us-ascii?q?oEBgggBAQacCh8sIlOBXgMGgRQtAY0EgzZ6Jw+BVUSBPAyCdz6ERINYgmeOJ?=
 =?us-ascii?q?ossCoE0dYEgDoE9gQQCCQIRa4ESCGuBfUACDWQLDm+BSgJkTIEeJQQOAxkrH?=
 =?us-ascii?q?UACAQs7Oj81BgMLIAZYawIJIxETBQMLFSpHBAg5Bhw0EQIIDxIPBiZEDkI3N?=
 =?us-ascii?q?BMGXAEpCw4RA1CBRwQvW4EBBgEmJJpyA4Jnej+YRa0rNAeCKIFVgVkMigyVA?=
 =?us-ascii?q?AYTLoNqAZMdDgaSIy6XPCCNMppIgWoBMoFJDAczGiSDNk8DGQ+OIBmEDDePE?=
 =?us-ascii?q?EA0AjkCBwEKAQEDCYVGAQGFewEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:8xZMyKJkm0yFrdsMFE+R3ZElxSXFcZb7ZxGr2PjKsXjdYENS0zFRy
 WsYXmqObKqJNDane951bIi+phkBsMXSzN9rTFAd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6j+fSLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWCfg71s9JIGjhMsfnb80ky5K2aVA4w5zTSW9gb5DcyqFFOVPrzFYnpR1PkT49dGPKNR
 uqr5NlVKUuEl/uFIorNfofTKiXmcJaKVeS9oiY+t5yZv/R3jndaPpDXmxYrQRw/Zz2hx7idw
 TjW3HC6YV9B0qbkwIzxX/TEes3X0GIvFLLveBCCXcKvI0Luf2nR/NRhN1gNGKY/2utXK05C+
 L8eAWVYBvyDr7reLLOTT+5xmoI8IcOtMI53VnNIl2iDS6x8HtaaHuOTube03x9o7ixKNdPXf
 ckEcnxCaBraYhtAEkgaAtQykY9Eg1GiKmcE8Q7M+8Lb5UD08yZak4DGKObrY/uUWedTlGGej
 U7ZqjGR7hYybYHDl2PcrBpAnNTnliTwU4M6D6y97vcsgVuJx2VVBgd+aLegify+l1L4RN9Vb
 UAZksYzkUQs3EC5c+bcUCahm1uvmT4Re/B/H+B57ijYn8I4/D2lLmQDSzdAbvkvu8k3WSEm2
 ze1oj/5OdB8mODMFynMp994uRvuZ3FPcAfucAdeFVNt3jX1nG0kpjTrJjqJOJy4kNDzEzzqz
 D2MxMTVr+lM05RjO0mT21fdnzLkjILARAcz+m3qso+N6wRkeMi6aobu5VWzARd8wGSxHgXpU
 Jsswpn2AAUy4XelyX3lrAIlQeDB2hp9GGeA6WOD5rF4n9hXx1atfJpL/BZ1L1pzP8APdFfBO
 RGM6F0BvsAIZCr3PMebhr5d7ex1ncAM8vy6CZjpgiZmOccZmPKvoXwxPhfJt4wTuBF8yfBmU
 XtkTSpcJS9HVfo+lWTeqxY1iPFyjiE42W7JQ53nhx2ouYdyl1bFIYrpxGCmN7hjhIvd+Fu92
 48Ga6OilksDOMWjPHi/2dBJcTgicyNhbbio8JM/SwJ2ClE7cI3XI6SNmuxJlk0Mt/g9q9okC
 VnnBBIEkwCh2SCvxMfjQikLVY4DlK1X9RoTVRHA937xs5T6SdbwtPUsZNEscKM59edu6/dxQ
 rNXM4+DG/lDAHCPsTgUcZC3/sQoeQWJlDC+GXOvQAE+WJp8GC3P2NvvJTX0+Ac0UyGYiMoZo
 p+b7D39f6YtfQpZIfjzVOOO1HK05HgUp/JzVRDHI/5VY0Tdz7JpIC3Q0N4yet8AGSzeymGk1
 iKTOxM5pPbMkaAx4tLmlaCJlKb3MupcT25xPXjX0qayDgbeplGc+I5nVP2aWBzsT0bm0fyGS
 cQM6N+kK9wBvlJBk7QkIoZR1ahkuufe/e5L/DprDFDgTgqNCIo5BlKkwMMWlKlG5oEBiDuMQ
 kjVp+VrY+SYCvjETmwUChEuNNmY9PcunTLX0/Q5DWP66AJz/5uFSU9iBAaNugMMMIpKNJ4Z/
 sl5tP408wCfjj8YAuSChA1Q9EWOKSUOaLV4l5c4BISwtBEn5GsfarPhCwj3wqq1VfNyDmcQL
 AWp2ZXy34Zn+hKacl4YN2T84u5GtJFf5DFI1AAjInqKqPrkh9g2/kZjzhUqfCtozzFs8eF6C
 k50PWJbeISM+DZJgpBYfmaOQgtuOjyQynbT+XAoylLLalaObXPcClE9NcKm3lErw0gFchd1p
 LinmXvYCxD0d8TP7w4OcE9Cqc27a+du9wfHyfuVL+7cE7YUOTPa07KTP0wWoB7aAOQ0tk3Nh
 c9u2M1SMaTbFyohk5cXOrmg94Y7aU67fTRZYPRb4qk2M3nWe2iy1RiwOkmBQJ5xCMKQw3CoK
 f5FB5xpZ0yl2TesvwIrI/cGA4VJkc4D4PsAfbLWJlA6jYaPkwoxsL/t8nnRuWx6ZfRvjsc3F
 a3JfR2gDGG7pCVZik3NnuZ+K0u6ZtgIPjP9+OWP9MQICJMxn+V+em4i0raPniu0MSk22zm2r
 Q/8d6vt4Og68rtVnqzoCbdmKzivDNHOCNSz7wG4tupRYeP1Mcvhsx0frn/lNV90OYQ9dstWl
 7PXlvLKx2LA4agLVl7Gl6m7F6Vm4du4WMxVOJnVKFhYhS6zZ9/+0SAc+myXKY17r/0F35OJH
 zCHUcqXccIZf/x/x3cPMihXLEs7OpTNN6zloXuwkuSIBh0jyjf4FdKA90G4XVEDI2VMc9f7B
 xTvsvmj2sFAoc4eTFUYDvVhGNljLEWlRaIicMbruCKFCnWzxGmPoabmiQFq/ASj5qNoyyomy
 cmtqtnCmBWOVGXgydZEr8ptsxdRAHsVbSzcuK4C04Yettx4JDduwSch3VEuFZxe1CD/vH09T
 C+Yd3MsUE0RQhwdGSgRI73fssO3GeEEfNv0TtDsE4V4dA/ubL697HBdGuuMLpu4lvYPDA1qF
 D3GxkDNAw==
IronPort-HdrOrdr: A9a23:/uuyUK9Bp8bMSvvAvAZuk+AMI+orL9Y04lQ7vn2ZhyYlF/Bw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObOEYZmIbsS+V2njbL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="51241416"
X-MGA-submission: =?us-ascii?q?MDHrYPQR+ngib86DccWixU4F8hbHBj3BfayA5A?=
 =?us-ascii?q?K0u53abkfz6AJ1pb7Ko54YBA+bipMETyRpZCEtXDH9+pv+dW6KTK9LPv?=
 =?us-ascii?q?3EyjU9JH35xRsL/FsyvgXqVe7K0+QiG8Yr73N2HBF+4ByHkcKpWDL/Tk?=
 =?us-ascii?q?CnCqIqCR/LSh6KYs92KDo4sg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 18:10:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679764225; i=markus.elfring@web.de;
	bh=8sdA88MBEyOgI5cOnWpmo+cMqsE8r3krOe/kC3XSUEE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZP0UirMwo0r0YmB0EpqIzslande728fpib7curzHLkh6H4ImA2DR22tRufln1JBp8
	 vfgqpNgCBPJX1/SvG47mB32Slo0hJXqbRbgR5VdvvnruVErQ59cffaQnDhDASWIK2x
	 2WaAHFZwpguBMF90djB2AUo3OvVX2JQzORW4hzObcX1DYtAUHd8dOS8pMrYLYWK7yI
	 /UzU4T3iQ4Co+aXaV43yW9MRb78Puyim6CbTNPL9+TDUs2wmKoSQ9dQ7PBBRMeqmX4
	 jnakTR28C1AslY5AQRHNP76Gnkeja8/LuToUyEd5ZuG8LWsvTucoNPWr6A+t7kEoQC
	 eMT24iK+avt3Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1McIga-1qC9NN0fWe-00cban; Sat, 25
 Mar 2023 18:10:25 +0100
Message-ID: <2418a77c-5a68-7e82-1674-23cfd3c8294b@web.de>
Date: Sat, 25 Mar 2023 18:10:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@gmail.com>, cocci@inria.fr,
 LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <e33f264a-7ee9-4ebc-d58e-bbb7fd567198@web.de>
 <d0381c8e-7302-b0ed-cf69-cbc8c3618106@web.de>
 <157b8db9-82f7-85e7-3bbd-7ef3a1797892@suse.de>
 <13b4a57a-5911-16db-2b6e-588e5137c3aa@web.de>
 <BE6CEE57-E9AF-4F17-B281-1E00C5DC2A9C@suse.de>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <BE6CEE57-E9AF-4F17-B281-1E00C5DC2A9C@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zanbd3fhbJ7N/HX+x+H22i++QIWNVTsnl+KMcHnWElP8mUemPhS
 5immueMcYsLBGOUHmZyaGfc50uPwl4ZDBm3SupyOipG+iYQasGebZKsbst0vl74osOv+yFH
 VupDuwxRmslXF8ZHGywWbhTrdDsQn/gcE4C5VEL2DOh1Z5bVO6w/VbXzNLwsDlBesEXBVWU
 AkrD7HgIiV6ibPJq2dXZw==
UI-OutboundReport: notjunk:1;M01:P0:epTdvN4sGMI=;kfOcc/BaUUuYSQUcIvmEe8XFymK
 FOvk9acHCnFL2w00zwwGktutUf1LCblNuncN51Gh3TSkeKcgeHcg3XhZGFkpBELtEAjpRyVxJ
 yOpjmeY0g8utSZDfms4Bm1czczwqkX+nUEckkTz5RMK7pJ/EK+PNvdTKCWXE4ZW28tFB/YZ3k
 WcNs6WHDMQbKcyyWO72Y1gwDcQWtLxlHmLLFPBVG4JQEQ5uJyYBETij9Rbf+DaJQXLuicUd6j
 4BdOQtV7EuvT4D2MJ4N1UZFu6jrH9h+6S7EmKJg4xDIL85DEJ4v0u0dc5vol5z0KGt09csMrk
 tbiIE9NjfnpY+6l/z0mWKXzrEKhq/OTHJA4oy+WFy0TIjVWeXOzkdL+tkoAbGpgZQ8DtXVIi5
 GuCJ/iAMBSm4oX95PQQV8l6ODD/q/Yr6bpJUW7iqcrgkqpihKk5s2dmBRE07ZFbV4yjjteDph
 gqmNbckXUUTHEwRTzJGhkHL2Cg1Cp6JsVdYPUk0XRI46u+rItpq142EFj7KxkMVMADTrGaLeF
 jAg3j/GCAwwVGLsi9U6oRbUfdaUR7SV6AMI9tfeSyucjJ5q+6CFz2X3OMBcT3nfe3uG94sXU8
 X7FNKmLXQquTCZON/6PEYH+NUFjNUYeU7mVIKX4q0jzqHG8llQuq8KJs9qa9x/ss/ZD4RbQQ3
 GDCHlMdAxAzxezo6JmYdn8muGRNJ+Lzc+jQutQBDcr99InRg1E2Fi0iW7IGBNcY9Yg4LeTWo0
 lRSM6fa4TIxu4JUGmgNXy/jMtJuPAqIc6/KT3GstibmvQNbwJ/tQ8mF2LwRab6od1Wb1/xZmK
 bawsVuJo7IwPUiXJvYgBnHrfx3vAVB98jjg6YoENwsrp4k77asT4icQG4Oi6QPTsvalvtDsxC
 5Q5FOSLtcpv2n4h2OkS+JJBj+TMbG37QE9r/PAAWYOyTg9xqh1bTdifiL
Subject: Re: [cocci] bcache: Fix exception handling in mca_alloc()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 957
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/2418a77c-5a68-7e82-1674-23cfd3c8294b%40web.de>

> Yes the extra =E2=80=98if=E2=80=99 check can be avoided,

Thanks for such an acknowledgement.


> but the code is more simple before adding labels unlock and cannibalize_=
mca.

I became curious how views will evolve further according to affected
coding style aspects.
https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+go=
to+chain+when+leaving+a+function+on+error+when+using+and+releasing+resourc=
es

Regards,
Markus
