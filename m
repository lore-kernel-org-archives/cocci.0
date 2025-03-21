Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBBBC36000
	for <cocci@archiver.kernel.org>; Fri, 21 Mar 2025 14:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=RFX1ZkC0zX6aoCdMAbBvYOQSnKEpm6lIm4JI/dVjizo=;
  b=qsVuvd4BB8aEqaJsw6GXk7y7oWLwlWnG9MixsPUYVvRDXdL8mL81kzT1
   ObekAcIeHdui7+X707c49nro3V/T27t3jL9VGVzHXmpwVWQ1hAFMjWBu0
   aVAlgkuv7GMANblVhTfiyyWWtABnpNyHlt1rVp1cG+hbtDpO9AwdN41VT
   s=;
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
X-IronPort-AV: E=Sophos;i="6.14,264,1736809200"; 
   d="scan'208";a="214155086"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2025 15:41:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5948FE0264; Fri, 21 Mar 2025 15:41:07 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A9C9EE007A
	for <cocci@sympa.inria.fr>; Fri, 21 Mar 2025 15:41:04 +0100 (CET)
IronPort-SDR: 67dd7a81_gqF9HzL2PH+DE2wIU9wboiO5kGyQpk6Ofz5G7AbzYRy52li
 QAbadC6jnqwCNaV/kVZ4fJe45HrtxzCM/O6VIKA==
X-IPAS-Result: =?us-ascii?q?A0HUAABzed1ng07ASNlaHQEBAQEJARIBBQUBQIFCBQELA?=
 =?us-ascii?q?YJDgVczBAtIhFaPUYF0MIQ7hzuHU4h1g1QPAQMBDUEBAgQBAQMEhQACiyICH?=
 =?us-ascii?q?gcBBDMGDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBOgcOO?=
 =?us-ascii?q?4V7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBEScECwsaAiYCA?=
 =?us-ascii?q?lYGARQBAYJ+gjABAw4jB65LgTKBAYIMAQEG2lwfLCJXgWUJgRouAYVsgmMBh?=
 =?us-ascii?q?ieEPCcPgVVEgTyDAz6EQ4NbgmmCM4RDZ5l2kGNSexwDWSwBVRMXCwcFgSlDA?=
 =?us-ascii?q?yo0MSOBIgU0NA44KYFjaUk6Ag0CNYIbJFiCKGoEBYEkgjaEPoRAhVCCEYFcA?=
 =?us-ascii?q?wMWDwGDH3Ucg0t1PYRjLVCCRR1AAgELbT03CQsbBj2kCoQjhBc6xWg0B4I4g?=
 =?us-ascii?q?WaBYwyfXgYTL4NwAZNVDgaSfS6YUCKpEYF9JIFcMxokgzZPAxkPjiEZhBS7I?=
 =?us-ascii?q?kI1PAIHAQoBAQMJhUYBAYpUgUsBAQ?=
IronPort-PHdr: A9a23:XjYSshylsUQGqNrXCzLlwFBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 xaZva0m1QKQBtiTwskHotSVmpijY1BI2YyGvnEGfc4EfD4+ouJSoTYdBtWYA1bwNv/gYn9yN
 s1DUFh44yPzahANS47xaFLIv3K98yMZFAnhOgppPOT1HZPZg9iq2+yo9JDebRtEiCChbb9uI
 xm6sAXcutQYjIZiN6081gbHrnxUdutZwm9lOUidkxHg6Mmu4ZVt6T5Qu/Uv985BVaX1YaE1R
 qFGATolLm44+tTluQHMQgWT6HQcVH4WkgdTDAje8B76RJbxvTDkued7xSKXINf5TbEwWTSl8
 qdrVBrlgzoJOjIl7G3ajNF7gblFqxy9uRNw34/UYJmUNPVgeKPdYcgaTndFUspISiBNHp+wY
 44JAuEcP+hXspP9qkMNoxWwCgajCv7hxCFGhnH236I1z+svHBra3Aw5Bd8CrGjYoMv3OaoUT
 Ou7zLPIzTLGb/5O3jny8pLIchM8ofGXQLl+fs7RyUc1FwPEiFWQppHuMjSS2OsXqWib7PdgV
 fm1h2AorwFxrCKvxsYqionGnY8UxE7L+j5jzIkoO9K1UUh2asOrH5VMrS+VLZd2Qt88TGFyv
 iY30rwLtICncSQWzJkq2RzSZ+GIfYWK4R/vSeScLDRliH9lZL6xiAq+/0igxODyS8W4zVdHo
 CRLnNfCuH4A1QLe58qBR/Bg/UmhwS6C2x7O5uxGO0w5l7TXJ4Q8zrM0iJYfq0bOEyzulEjyg
 6KabEsp9vWy5+njbLjqvJGROo5yhwrjLKkuntG/Af8kMgcQRWiV5OW81bz98kDhXLlHiOA9n
 LPDv5DAP8sbo7a0Aw9L3YYn7BayFzKm0NMFnXkbNl5EdgyIgJPzN17TPv/0Ffa/g1Kynzd33
 /3KIKDtD5fXInXBjrvtZ6tx5kpCxAYpz91S5IpYCrQbL/LyXk/xusbYDhg8MwGsxOjoEs991
 oADWWKUGKOXP6fSsVGS5uIuJemMa5QYuTjjJPc+/fLhkGE2lUcbfaayxZQXcmy3Hux6I0WFZ
 nrhmskNHX8QvgUiVOzqlEGCUTlLanmuWKIz+i00CIO9AIfYRoGthaSB0z2hEp1XYGBGEFGMH
 m3ye4WKQfcAcDiSLdN5kjwYSbihTJcs1RW0uw700bVnKu7U9zYZtJLi0dh6/PfTmgso+Tx1C
 cSdyWCNQHtukmMGXT9llJx49G5gzlaKmYxxnPVcEZQH5e5NUw58MZfDxuh+I9H0QAPIONmTH
 hLuSdKtCjAZT9QrwtZIbVwuNc+li0Xm1jCpHqRduriFHp0y/eqI+nHrJNtmjVvC2rMgiVYOX
 cZFc2Gr0P0svzPPDpLExh3K352hcr4RiWuUrD/rJQumuUhZVFQ1SqDZRTUFYUCQq93l50TER
 rvoCLI9MwIHx9TRYrBSZIjPilNLDOzmJMyYe3i4zkK5HxWV3fWhaITwemMS9DrQAg4InlNb5
 m6IYDA3HTzpuGfCFHprHFPrbVnr9LxboWm4U1Ry4gWEdUxn2JKq9xRTifHPA+gL0OcivyEs4
 y5xAE7739/SDI+YoBF9eaxHfd4nyFJAyH6fqAF3eJCtR0x7rngZdQk//0bn1hEtT55FjdBvt
 nQhigx7NaOf1lpFMTKex5H5fLPNeCH0+1i0Zqja10u7sp7e87oT6Pk+t1TovR24Xksk/XJ91
 tBJ0nyarpzUBQsWWJj1Xw457R9/773dZyA84cvT2xgOeeGRuyXBxslvKe8r0BemcP9APanCG
 AKzW8wWCs6yKfA7zkCzZ0FMN+RT+agoesK+IqHfh+j0ZqA5zWjg0jQUheI1mliB/Cd9VOPSi
 pMMwvXCmxCCSy+5llCq9Mb+hYFDYzgWWGu50yntQoBLNcgQNc4GD3mjJ8qvy5BwnZnoDjR9/
 USgGkhA9cunYxuUYHTi0AcW2Uld8hnF0WOoiid5lT0ktP/V+SXUwPn5MjcDNHRKQmZKklrmZ
 4S5xYN/PgDgf00ikx2r4lz/zq5QqfFkLmXddkxPejD/M2BoVqbYWqOqW8dU89totCxWVL75e
 lWGUvvnpBBc1Sr/HmxYzTR9djewu5y/kQYowG6aKX9yqjLed6QSjV/67cbfWOUX8z4IXih+h
 hHIC1L6M9Th8diPlpjFu/yzTCr7D8IVLnOtlNLa8nTrrWRxSQWyhfWyhsHqHW1YmWfg2t9mW
 D+J5Bfwb4/31rirZOduf01mHlj5uIJxHoBzlJd1hYlFgyFFwMrPuyNWyyGsYYY+u+q2dncGS
 D8VzsSA5QHk3BcmNXeV38fjUX7bxMJ9Zt68a2dQ2yQn7skMBr3Hid4M1SZzvFe8qhrcJPZnm
 TJIg94n8n0HmKckvAQ3zyOSKq8fFw9UMGa/8nbAp8D7t6hRaGu1JPKV3VB9gMvnIbWMuABaV
 17md51kESI6vaAdeBrclXb07I/jYtzZa9ke4waVnxn3hO9QMJstl/AOiHkvKSfnsHYi0eJ+k
 Q120MTwot2cM2s0tvHcYFYQJnjvasgU4D2okatOgpPcwdW0Bps4UjxZWZz1UbS3HThUufmvP
 lSLFyAg72eVHqDAFBWTrlhrpTTDHvXJfzmednwe0MknTh6AIkdSxh8ZVnM2k9YwRAWt2dCke
 1xz+zQSoAfxrBcVjOlvMnydGi/W9gKvdytxQ4OUKwBOqFhL4UuMd8eZ66plFiVctPVNtSSrL
 WqWL0RNBGANAAmfAkz7e6Op7p/G+vSZAey3K73PZ6+PoKpQTaXAw5XnyYZg8zuWU6fHdnB/E
 /023FZCVnFlCozYnTsIUSkeiyPKaYaSuh69/iR9qs33/u7sXUrj4o6GCr0aNtsKmVj+maCYK
 +uZnzp0Mx5d0Y4Qg2DFwv4T0R9aii1jcSWsDaVVtSPJS/G1+OcfBBoaZiVvccpQuvhlgU8SY
 4iC24mzie4r65x9Q01IXlHghMyzMMkDImXncUjCGF7OLrONYzvC38DwZ6q4D7xWluRd8ROq6
 lP5WwfuOCqOkz7xWlWhK+ZJ2Wu+NQZdpZr7XxJjE2nlQ/r5Zxf9PNI93lhUifUkw2jHM2IRK
 202a0RWsriZ9j9VmN16HHFdqGVoJ6+IlmzKiouQYoZTuvxtDCNukutc63lv0LpZ4hZPQ/ltk
 TfTpNpjy7lJuvaCwHxrXUgXwt6qrIeMoFkkJqjTsJVNCy6sFPcl8miaTRgH9YMNNw==
IronPort-Data: A9a23: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
 lTZiYyJrI9XhKIx/Qtdl6ZpJSwk
IronPort-HdrOrdr: A9a23:k0L/Vaoc2zeXLFwilnNSmtAaV5r1eYIsimQD101hICG9Afbo8v
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: 9a23:kyC+EmzFS1B3A+bA1UpCBgVLIpsXX1Dl4k39eXC1NElCaJSIFF+5rfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AMAc4CA4P78PDleP80ivOvHttxoxl/YCsWUMnrK8?=
 =?us-ascii?q?smMeUBT1oFjuMkW2oF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,264,1736809200"; 
   d="scan'208";a="214155081"
X-MGA-submission: =?us-ascii?q?MDFjD86IwLkc3xhXjKBOnMEbZ0a2CRXDbTwnFi?=
 =?us-ascii?q?CD2mtzL7YRy5xrHdP8/CDSFwnjkmzCKGFpGPzq34i9nkb0X+o8zdyRZj?=
 =?us-ascii?q?MkaLKkphTzf++ZQ7ryMGaTQwZbsxz5KjbmP+diD6eD3xO19crgIpklGj?=
 =?us-ascii?q?nyAmgtWu92MUF4N7lHR8WnYg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 15:41:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742568063; x=1743172863; i=markus.elfring@web.de;
	bh=RFX1ZkC0zX6aoCdMAbBvYOQSnKEpm6lIm4JI/dVjizo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nUpMS28lq6txaJ9qQV3H+Soc//6FZhO88KQMrATvgVNgwFI4Et/Bije0NyIsYcdi
	 1ogHsoqw/iRpzsDiJXZLWbhvROIVL4MiHpEN/gv1Ygja3ZAIOnLwcfgcBNixzX4Hn
	 5HLA7tmxJy369oYPOefUugnC1AO0D2/hsZeY5/eWURDQPbLqO/XlgSg4twf4ipT+o
	 +g/1nO9eP1gFYoSo4GHgo7w8SAeYZsdos0fu4tQK0SAIePoAstR/QuU8ihguj0iev
	 pD17dEQ+tYabaFgotUGj28TlWIxxzjfdkrs+s2aDWRJlcsp/U7BFMBhQR4raV4xBj
	 5W9Dyu1SwQQoBpo0/w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.36]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mi53D-1tHt1C1reL-00lKkp; Fri, 21
 Mar 2025 15:41:03 +0100
Message-ID: <a5c6c5e1-d04f-4a93-b37a-cfc797a021a2@web.de>
Date: Fri, 21 Mar 2025 15:41:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <99c55fe9-b23f-a6c2-575-9a856a8a358c@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <99c55fe9-b23f-a6c2-575-9a856a8a358c@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2tbGuhpQ1oWYK4cYPqJHT/I+nBkXJLk3MiSIzMU/QAGTmE876mf
 9fRxJJEWyaiGqTQdw/SAfjnWFA9MgQ+cbOdtk9QrdNmn+MfcbhgeQHNzAAum7nJPLqiGbeA
 D847zpc575S7hai4PP+CbOzmI2/cUe4gK6kFUXFl5uWJxoz7LBE1DoPPTtxDTKqICkv9fWO
 7QsZ11dCSLoDKlgGnfQmg==
UI-OutboundReport: notjunk:1;M01:P0:KV6KaovHRQI=;asW8RlemMsyAOCM84yBvCMGA9Y+
 9PErBvr8f/zGTV9gwOz2xsJvGca0cWVv2XjXM6pUHOjcY5kq63B1gCH32+bPxHQ+JnuENevlQ
 Cy+89Kx1VkJ8ou67iMF5esk260Y39nF2HQwyr/rJkV2M6EYFwxlC4ddaylQMnSjm3wEXhAATG
 QP8KIarHfVefVr2bE3WuSUQxaYyQYmoBNxvVVIyNuVX3nCBoYrkHd714xiyvl9VW+plBE3Bo4
 /sDcYLuMMZSCUfk4DsYPOuAlxizxLJ82eiCMRbKq1v1T/YwGG8dLxdl3GTv/7hbsiPKy143AW
 P12KEasYdDZgDXy19oAGrdmE+7E7yVP+ldWyDFdZuBnH8tmKGS8GvpONFY8hLzSB/TdnB47ld
 yZm6pLFmS4s+uGP06/tEahKr46wL1o6vFjXs3k8prdpCxxnDwsHSH93d5ZQCwlm0cmnlCn3Ss
 oSJ/vcGifhp3gqPri8MX855+QiwtIoZgEYYFUdToMDHaW3La+pkRpu0C96c8yOTXbpKFvJUQe
 WMWDzdor9PyOv6CLrkIdZYrd9ompiPI0ve7nWOW8IhnlToX0xFmnLji2melKv18hvzDMKJ/XE
 uWrXEGbs+WwikwSE/SUL6PdavJpAjWH3rTirH60nZV5PXd981i9qDPxE8HRMayudEufM7QNLi
 5WHTZxiVJSy7ZbbXVgz1OIonuK8N/MBo7zAoHJj+TJ+11HapfxqrWLS2zBVHOC2A5ToQ8m6rF
 8iWZAoXNSbOfM4M59xCJjR4N0VYpr5WLgLu/y5Ka37/oW/7vpBMjo0DZ1+CIcGEqMdxB/FkF3
 jx+lmrJmJn7uCAseJAfSiJdZEemZsKDqna8Ue9DVqKy7m84icwbUqmVTK8wHL4SaNFECGGCPY
 GwGzsmoQTCymzs0ievGEq0ae+ySpYktD/AQ05UsVYlPSHVl/JqzToJHLHi35eCQ2UA0XNo6xV
 TnOpA6YCASDjNbJTeW8HXKc7xbk50kIgUYDPjWHHeH96vOYZVAoo1YiWc3i+y1QZVUyJWrN+Z
 On944VPKYwHLZdabJ4zbFzFgiXTQkLxNGUM7hNNo4n5FEMJb9kg4N0ZWn4I085tnZdORdGf2W
 Iq9BVTqWudPO+5MDYsSnGKM2w+bvTUor+jFy8QXs7+X1gmbmiBvitwTOOIXr9r/xXhRTHqOjq
 ZyeQsoorbliBTKaCWVoqvWAHSk+07QHR9uc+86bQFGwAmcZgj6URf98EwqbEJa1Z6kK04sFZ/
 rpWyOZP6HNX67v0atljSJZEkjflcMOuiV56BPTlx8V0FnjZ3GSlHgPir6zBY+EhhHAWgOi3lS
 w3yJ1vFfbkH2v9SAFHZTaCtciI27n1D90oyzqi9yIbS4tNGHhhDsSHiozv4jl7WMqNAID7oP7
 s9RSOmRZ5BDIBzi2jFBwQ+Lx4y2XusJlNLhXKXoT25Td3H0LJKuaHk5wypbRSpyZSh/qECsus
 se7i/9FP7aLmWFJdhlG+VJyhOJR3jVODbANhVG2XSTqNhupVO2gLubp9S1vuE3usX2u6q2g==
Subject: Re: [cocci] scoped_guard
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2673
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/a5c6c5e1-d04f-4a93-b37a-cfc797a021a2%40web.de>

> Coccinelle offers the "metavariable" type iterator for the names of thin=
gs
> that work like for or while.  That is, they represent the header of a
> block and they cause a loop.

Does this language construct support already code blocks which would =E2=
=80=9Caccidentally=E2=80=9D
be executed only once?

Regards,
Markus
