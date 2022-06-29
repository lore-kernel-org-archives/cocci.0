Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE92C433EF
	for <cocci@archiver.kernel.org>; Wed, 29 Jun 2022 18:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=23UjtO/JnaGGoNZMcaJrPWg6ZYVffgaXW4qdcDoKFnA=;
  b=IlsqsTwKA3iFw2Ke3JCQuQn2oxzRkb5f+kAJhvSics1ZM3mMszw9l1n7
   f1+yYjrlp4JCoPLbY8flk6yi7MhnUYwmCmxDSOM78urcRqAx2pefItKhi
   MWy3+D46840ZL+L3xVdYjVFct8BtO3dDbDIPooMPFEogx8pUyA4fzwu6v
   I=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.92,231,1650924000"; 
   d="scan'208";a="43491188"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jun 2022 20:43:11 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DD55BE436F; Wed, 29 Jun 2022 20:43:10 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4601EE2680
	for <cocci@sympa.inria.fr>; Wed, 29 Jun 2022 20:43:07 +0200 (CEST)
IronPort-SDR: FlD4ukQ3/Zh+Up5nfyuN4g2DkN9WZvtcHmnQmEV7qasKodOan6rWbedeeJhuY0RYk6nohs3P3j
 uCU2DhLBLsQEgAF7o8hu5fCQCiq1a7Vxyfk/XEzuO6yqBKNMiHHgdmoGIJWDpR/oYUwV0axMqS
 jrokzmyAIWScXnxs7tCSVN9QVKF0/W+td/DKk2kVtgSt15ox9atZjzgV1b4cZzvNHzSMx4PVa5
 dLD20FAkrf6/ZNq3FQUmv6cUqC5XeIKUQXwWnqaLZ4P6YISXEZbGTRH1Cd9ik2V0whmRYe0lid
 Qce4aiwCMu8X+kG1nFdXJxv/
X-IPAS-Result: =?us-ascii?q?A0BpAgAAnbxihwQP49RaHQEBAQEJARIBBQUBQIFPgiSBA?=
 =?us-ascii?q?VYuBAtEhE6OZ4F3LgOEI5pMCwEDAQ0yDQECBAEBghCCdAKFSgIdBwEENBMBA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBDA0JBQgKBw4QBTYGX?=
 =?us-ascii?q?gZkBIFLBIF0CzQNgjUpAYNkAQICASMdAQERJgEPCxoCJgICVwYBDAgBAYJ5A?=
 =?us-ascii?q?YJkAQMNIwcLrEOBMYEBgggBAQaESx8sIlKBXAMGgREsilmDJHonEIFVRIEVJ?=
 =?us-ascii?q?wyCdz6BD4M1g1aCZZoOJgQPAxotLxKBIG4BCAYDAwcKBTAGAgwYFAQCExJNB?=
 =?us-ascii?q?hwCEgUHCgYVDhQcEhIXDA8DEgMRAQcCCRIIFSsIAwIDCAMCAyALAgMWCQcKA?=
 =?us-ascii?q?x0IChwSEBQCBBEeCwgDGR4sCQIEDgNACAsKAxEEAxMYCRYIEAQGAwgvDScLA?=
 =?us-ascii?q?wUPDQEGAwYCBQUBAyADFAMFJAcDIQ8mDQ0EGwcdAwMFJQMCAhsHAgIDAgYVB?=
 =?us-ascii?q?gICGFYuDQgECAQYHyQPBQIHLwUELwIeBAUGEQgCFgIGBAUCBAQWAhAIAggnF?=
 =?us-ascii?q?wcTGBsZAQUyJxAJIRYGCh8KBgUGFgMhSCYFCjsPKDQ2PCwfGwqBGiwJIhYDB?=
 =?us-ascii?q?AQDAgYaAwMiAhIpBjcDFgYoBiMbApwNC4EpEgaBG4EWN5U2qzA0B4IUgT2BR?=
 =?us-ascii?q?AyJUZRgBhMtllYOBpF6LZVQdSCNEZoRgXiBfjMaJE+CaE4BAgECDQECAgMBA?=
 =?us-ascii?q?gECCQEBAo4dDA0JFYNuhGGFTD80OwIGAQoBAQMJhUcBAYZ2LYIZAQE?=
IronPort-PHdr: A9a23:FYEpsxIjfSAvmgYb+tmcuNRsWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCFvrM00A6CBN+Go9t/yMPu+5j6XmIB5ZvT+FsjS7drEyE/tMMNggY7C9SEA0CoZNTjbig9A
 dgQHAQ9pyLzPkdaAtvxaEPPqXOu8zESBg//NQ1oLejpB4Lelcu62/689pHJfglFiz6wbbxvI
 BmorQjaq9Ubj5ZlJqst0BXCv2FGe/5RxWNmJFKTmwjz68Kt95N98Cpepuws+ddYXar1Y6o3Q
 7pYDC87M28u/83kqQPDTQqU6XQCVGgdjwdFDBLE7BH+WZfxrzf6u+9g0ySUIcH6UbY5Uim54
 qx1VBHnljsINz8h8GHWlMNwir5boAm8rBB72oLYfZ2ZOOZ7cq7bYNgUR3dOXtxJWiJCDI2zY
 IUAAfcfM+tGoYnzp1kBogexCwS3GOPv0yVFimPq0aA00eksFxzN0gw6H9IJtXTZtNL7O70IU
 eC20anI1ijIYfxS2Tfz8ojIcxYhof6RVr93dsTe01MvFwDYjlWLs4DrMDeV1uoXs2ia6epgW
 vmiimA5pA5quDSg29kjh5DPi4kIxV/K6T93z5wpJd2kVkF7e9ikHYNOuyyHOIZ7X8wsTn12t
 CokybAKpZy2cSwOxZk5yRDSdvKKfoyW7h/iWuidPDh1iGxldbywmxq/8Eiux/DhW8S31ltBs
 yRLkt7Jtn8X1hzT7NCKSvxl/ki/3zaPzB3T6vpaLkwukqrbMZEhz7gtnZQQqUTOBjH6lFjog
 KOMaEko5Oql5/76brjmvJOROJd4hwXwP6g0h8CyD+o1PhITU2SF9umwzrzu8VP/Tb5XlPM5i
 LPZv4rfJckDpq62HQtV0oE75ha6CDemzcgYkWMJLV1bYx2LlZXmNE/WLPD5C/ewnUisnS91y
 /zbILHtGIvBImbBnbv7YLpw61RQxQUrwdBa/Z1UC7UBIPzpWk/2sdzVFhg3PBauw+bkFdV9z
 ZkSV22LAq+XKqPSsFmI5u00LuiCeoAaoyzxJOU76PL2i382gkcSfbO10psPdHC4AvNmLl2Hb
 Xb0mNcODX8KvhYiTOztkFCCVSRcZnioUKI44jE2E4OnDYbGRo+2mryOxj23HpxQZmBcC1CDC
 23kd4ueW/sUciKdPtdhkiAYVbimU4IuyRauuxPmxLpmNefU4S0ZtZf71Ndv/eHTlBcy9SZ1D
 8uHyW2NQXt0zSs0QGp87qFuqEpygmee2K4ww8NZEdhS7vYIGE9uKp/Yy+1zDpbiRwvHbNaYQ
 VCpatW7CC48T5Q6xNpYJw52HN6pjzjC2TCrCvkbjfjDB5Eu9K/Ymnr4IcdhzGzd/LcugkNgQ
 cZVM2CiwKll+Fv9HYnMxmCQjaW3buwx2CDX9WGMhT6rtVtbTRU2fKHLR3EZaWPJoN6/6k6UH
 OzmMqguLgYUkZ3KEaBNcNC8yAweHJ8LWfzbamO1wSKrAAqQg6mLZ8zscnkc2yPUDA4FlRoS9
 DCIL1t2HT+v9kTZCjEmDlfzewX06+ArjXqhTVIviSyOYVdg0bWd5RMfw/CRGLsIxrxRgC46s
 H1vGUqlmdffCt6OvQ1kKYBVe9Ag+xFq0WzDtgpyFoOtJeZuiw1WaBx56mXp0Rg/EYBciY4qo
 XctmRJ1Mr6d2Uhdeimw2JftJvvIJ2O08B3Hh7f+/FbY3Z7W/64O7K59sFD/pESzEUFk9Xx70
 t5T2n/a55PQDQNUX4ijGkAwvwN3ob3XeExfr8vdyGFsPK+oszTDx8NhBe0rzQyldsteN6XMH
 RH7EskTDcyjYOIwnF3hYhUBNeFUvKk6WqHuP96Pwq22J6BNmDy8jGJIyJ9w2ASA+ms0S+LF2
 YoE3+DNxhGOBH/3iFastNyymJgRP2hIWDDllm69WcgNNcgQNc4RBGyjItO63IB7jp/pATtD8
 UK7QkkB04mvcAaTaFr02UtR014WqDqpg3jdrXQ8njc3o66YxCGLzf7lcU9NH2dRR3R5y3roL
 5K1id8yQ0WiKQQk3kjAhw6y1+1AqaJzInOGC2JBZSvrNCdPVqWqt7yNS9FC4tUkvG8ENYb0K
 UDfQbn7rRwA1irlFGYL3zE3eQahvZDhlgB7gmaQRJpqhELQYto4hRLW5diGAOVUwiJDXi5zz
 z/eGlm7OdCtu9SSjZbK9O6kBSqtUZhacC+jyo3l1mPzwGRwAgCk2d23lMfmFwcSziLxkdVnH
 SnFtxfzZID32r/ya7s9OBMyWxmltowmUohl2pM9npQRxWQXivD3tTIcnGH/PM8akaPyYXwRR
 CIaltvc4QzrwkpmfTqCw4P0UGnYw9M0PYDgJDlMhWRksoYWW8L2pPRekCB4o0S1t1fUaPl5x
 HIGzOc2rWQdiKcPsRYsySOUBvYTG1NZNGrijUftjZj2oaNJaWKoabX12lB5mIXrKbiYoRxHH
 lv9dI0jGyBY8ch1dl7Bmi6WiMmsaJzLYNQfuwfB2TLJletIM9QckvQQhCxoEX3wtzspxqRo6
 H4mlYH/t4+BJWJ3+au/CRMNLTz5afQY/TT1hLpflMKbjMi/W49sETIRUN70XOqlRXgM4O//O
 V/EQ1he4j+LXKDSFgiF5AJ6omLTRtq1YmqPKiBRzM0+FkPEfgoF2l9SBW9k2MdjRkfwmamDO
 A94/mxDvAei7EEWlaQxal+nFT2C7AawNmVuEcLZdkAJqFgdoR+Sa5PW7/ovTXsBodv+9krUe
 zbdPVgYSjtYPy7MT1H7Yuv+v5+ZrbXeX7fvaaOJO+vGqPQCBa3RmtTwiM08p2nKboLVYTFjF
 6FpgBMcGy8jXZ2IwXNRF2tNyUevJ4aavEvuqncx957itq6xCUS2vtPHCqMOY4U1vUno3OHZb
 LbW3nwxbD9c0tlkKWbg7r8Z0RZSjihvc2PoCrEcrWvXS6mWnKZLDhkdYic1Nc1S7qt60BMfc
 cjcwsj40LJ1lJtXQx9MSEDhl8e1ZMcLP3D1NVXJA1yOPaiHIjuDyt/+YKe1Q7ldxOtOsBj4t
 TGeGk7ldjON8luhHwioKv1JhTqHMQZ2vYagblByBGKlQN+nIhy3PdlrjCEnlL05gnSZUAxUe
 TN4ck5LsviR9XYC2685QTYeqCM4a7XX/kTRp/PVIZsXr/ZxVyF9luYApW8/16MQ9iZPAvp8h
 CrVqNdq5VCgiOiGjDR9A38s4n5GgpyGuUJ6NODX7J5FDDzh9QgO8H7WJhAEvdpjBfXwtqoWx
 tWFx8eRYH9StsnZ+8cRHZ2eMMWcLH8oKgbkAhbRCxYZCyGmPyfTigYO9ZPavm3QpZ88pJ/2n
 ZMIQbIOT105GMQRDUF9FcADKpN6NtvFubuckdJO+ne06hXcFp0yVnXvSf+YR/niem7xZVZse
 BYCh7/1f917Cw==
IronPort-Data: A9a23:O0cWM6olqvHC2mL3F7rEF6Rc1/BeBmI3YxIvgKrLsJaIsI4StFCzt
 garIBnXOKyCMzTzeY1xa4zg8x9S6JeBzNFqSwdvqis2HykT8OPIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKicfHoZqTZMEE/Nszo68wICqtMu0ILR7z+l4
 4uo+ZWBYg79glaYD0pNg069gEM31BjNkGhA1rAOTagjUIj2yhH5pLpGTU2AByOQrrt8RoZWd
 M6fpF2NxV41yj92Yj+TfhkXRWVRKlLaFVDmZnO7wMFOiDAazsA5+v5T2Pbx9S67hh3R9+2dx
 umhurTzcx4CAajQs94bbDZaIQFPMaIF1/z+dC3XXcy7lyUqclPpxOhySl47N8sU946bA0kUr
 KZecmpSKEnewb7eLLGTEoGAguwGJdPoIZhZl3Vu1zDfAt45TJqFT6iiCdpwgGxs15kXTa22i
 8wxTTFXXAaYaEJzCGgWDM8Rg9333FD4SmgNwL6SjfNqvzaKlVIZPKLWGN7cZdWOQe1Hn0OSv
 GuA/mLjAxhcOsb34TGC+XmtrvTemDvyHoMUDryxsPBw6GB/3UQWDwAKE0S2q7+1hyZSRu6zN
 WRXwDMFkq0u33atcfb/bT2JrHHHkV0lDo84//IB1CmBza/d4gC8D2cCTyJcZNFOiCPQbWNzv
 rNut4ywbQGDoIF5WlrBp+/M9mja1Tw9fTNYOnNsoR4tvoG7yLzfmC4jWf5PPcZZZPXWECv02
 CqXrCVWa1470pBSjPrTEbzvqTugq56McaXh/BnLU2ev4xl2DLNJiqSt7kXHq+lNJsCVQzFtX
 UToeeDOsoji7rnUxURhpdnh+pn3vp5p1xWC2TZS82EJrWjFxpJaVdk4DMtCDEloKN0YXjTif
 VXevwhcjLcKYib0MfMuO9ntVJ13pUQFKTgDfq+FBjapSschHDJrAAkyPCZ8IkiwzBlyyvtX1
 WmzK5/2Uily5VtbIMqeHrpBj+ZymEjSNEuKC8mzzhK73KCYaWLdQLhtDbd9RrBR0U9wmy2Mq
 4w3H5LSlX13CbSiCgGKr9J7BQ1UfBATWMGuw+QKJ7XrClc3SAkJVaWNqZt/INYNt/oOyY/1E
 oSVARIwJKzX3iGcdm1nqxlLNNvSYHqIhSlhbXB9bQrwhiNLjETGxP53SqbbtIIPrIRLpcOYh
 dFcIq1s29xDFWbK/Sozd574oNAwfRinn1zcICevJjQyJsYySwvM897iXw3u6ChXUnvp75Rj+
 eX421OJW4cHSiRjEN3SNqClwWSxin5Byuh8aE3Ff4tIc0L2/Yk2cCH816dlI8wFJRjZ6CGd0
 gKaXUURqeXX/d0q/dOPia3d99WlFO53H0x7GWjH7O/qZHeAoTf5mddNCb/acyrcWWX4/LSZS
 d9Ul/ysYucamFtqspZnF+g5x6wJ5+zp++1QwDNiESiZdF+sEL5hfiKL0MQT5K1AwrhV5Vm/V
 k6Vo4AIPLKUJIX6HVRXKAd8NraP0vQdmz/z6/UpIRymtXEto+fdCR1fb0uWlShQDLppK4d7k
 +0vj84h7VDtgBQdNNvb3Dtf8H6BLyBbXqh75IsWBpTn1lgixl1YOMWODyjr/NeQZt8KPkRze
 m2Yg6/LhrJ9wEveciNvRCaXgrcH3cwD6EJQ0VsPB1WVgd6b1PU56x1m92hlRApiyBgagfl4P
 XJmNhEuKKiDl9uyaBOvg4xx98B96BylFojZzlwUiCvGQkPuWmGlwKjR/wqS1Bhxzo6eVmEzE
 HKkJKLNTjvgOs38tsf3cVAwsOTtFLSd6SWb8P1K3K25810SfjfvxKOjDYbNR90LHutp7HD6S
 SJWECqcpEE12eP8Y0H2NmVC6YktdQ==
IronPort-HdrOrdr: A9a23:R2VUAK2E0KhK0aiu3SZrGAqjBJYkLtp133Aq2lEZdPWaSL38qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyVMbEQt6bHCWeDYrQdKZW8kZxBno3lvgxQpOxRGttdBz4SMHfnLqX8KTMtOaYE
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,231,1650924000"; 
   d="scan'208";a="43491183"
X-MGA-submission: =?us-ascii?q?MDG4ehYO2PXVkQMBv4DuS15yWnqFsSnx9ZlIzF?=
 =?us-ascii?q?CJe9Mz9X4IYPX1ajY7SOr0nla/Kb65lgt5gyqRvRG81DwgbXXrgLyDIi?=
 =?us-ascii?q?z9ByAE6Wtr31hG/7AYgvJtxF4hqwyAO7rhUqekAhH0kGYj5AJgrLf8wE?=
 =?us-ascii?q?j4qB/GmNkn+bjfWq/f6RX5hQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 20:43:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1656528166;
	bh=23UjtO/JnaGGoNZMcaJrPWg6ZYVffgaXW4qdcDoKFnA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hK33njl9EM0Jw+jVuxUQKrtbVcqfRdz+bV/1aduLx2y490J9KKOlwSNva8nrA6s3Y
	 9B+QUB3vSihqVlWbTqvUDO4C7t6auvuB8w5RCvsUQPJqkjEy0/uei/CnRJPmTTcGIq
	 n8sN9I+G28fqaqYzt0TA22IjCIpYT7X5NX8q0hpI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([93.133.124.62]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhWkh-1nThGY3ClP-00eVOG; Wed, 29
 Jun 2022 20:42:45 +0200
Message-ID: <0e3d2713-ab8a-2ce5-5423-a72ba36ac1ff@web.de>
Date: Wed, 29 Jun 2022 20:42:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-GB
To: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, Fabian Frederick <fabf@skynet.be>,
 Yajun Deng <yajun.deng@linux.dev>, "David S. Miller" <davem@davemloft.net>,
 Phil Edworthy <phil.edworthy@renesas.com>
References: <20220616013253.520310-1-william.xuanziyang@huawei.com>
 <32da2d32-9554-de90-62ca-c4be456ad31a@web.de>
 <6b3eac2c-6e24-46e0-c548-dc87f666709b@huawei.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <6b3eac2c-6e24-46e0-c548-dc87f666709b@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F93nbW/7CgSLIz2pUZKKgQuU6UaKDTTgnrlsuxxPsav7yKbA0Ck
 rDiGLK/tOozENbovnd0pXToFejjBxA3z+LL/DKQJFQP2ac9LmFrmKz4Z6k6UFPeBegIr0u7
 N404TINcO89qujZwBw8D3FRfLo9H1jBVwkmm3Hzk12IFMn/WSgAQZ3ErkPI8uTgCfDYqnDj
 9HrqnACl895iZvVJbphKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t5vbYTzCS40=:i5sVR83uEZrbv7t9uYFHpp
 IpieKBliNYkZ4eFc+8O3s9D7GXMF56RiYkdaGDcS8Ny1rgRSr0x/v5vqeEdy7nHrfMtUO5zF0
 pMN396AAbaU4ZQPLGux5zi5EStZlflxm7Cpq+hD5zDt+kpYHRSdNGG7amD5uK6vkL7CrrRFae
 L2GOa570Lzur05U9sgxFuj3ez0uf6fsF01Ex/l2cm0j/rgf7NdtkZksUSOm2A7aiiWrsmQ5Zt
 xZtumlqBgwkX+Uo6+/wCKBDHsdBcpggSL4Wd2d0ltbeW/1wIB0cB5pELwkh8lkseRi1pceWBe
 yU0u5SotcB/pA0pTWukIn2gCFDkDpDT77uDYSwKWeL4nYCya1S2tIMf47VM1Em9qtfW4+tSdT
 UmloosJb6/19LyncxIF3n3UiJJuyxKevOt9AaFogPyHQT4P44czwXQNV6waOJNb7h8adklyGs
 nSh1lVwsQct8AG3HigT0kTkntKgBNg0BxZnx4zDVPR+xQUCygCLt8zuWgraFzvUy2Cz/NzFoh
 cpmhlsXgwDMIqIN00xTFdLLYpiVH9sECIqstnsQCVHfQttScLASK5oqDjoFNTTk0tnwdveZuE
 f+KM8oM1VoM21HF6d5YNtrJ9p59dSPZyj9Sy36Ex8FNLydnZOa92Y04QzG0YhorloMMqBvamz
 sdRa8zMxTcUPh8pRFP1ZRMCZMakrWfOLzRHxDAPC35/vpOyGUnwI8nXGZW0PquxmhyK5hxweh
 rMEZ98iVSsm3d46LXZpRHlwQf9gjejN0SJb+DPiS2qrnjKNC7lKyNuJFH8rVHXrzT4iaJx5n9
 tmsD7MO8THZCTZ5rLuluDk7FSy2xjO2SOKxhIQOSL967rqT+dCuNMmo8+8Nv5+U0SN7wG+Dr7
 5Kdyutp83SI+V/M6QfjHKspldurC5ghtFhOP2rjofF2vNg9gw9zOWowrB8ea8XIEm+9zvmKgA
 hwDpXPXW59d+yEre8LnZnSAx4RlZLppG6bLerCN+BvECwh5eWeO7A9gAg4VHbD3eUD6mF0RGK
 44wlmlERDmO1GokgCAzV5BkO23I9QZmt6OIY+bIt8c43FCZEfRwy7KvMAl7r9JnCoY9fsprUL
 jvtpzUNnUSltIfu5QCStxZrR0rZXeE3L7pZI7c88v7juYdFgE5B749NAw==
Subject: Re: [cocci] scripts/coccinelle/free: add NULL test before dev_{put,
 hold} functions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 468
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/0e3d2713-ab8a-2ce5-5423-a72ba36ac1ff%40web.de>


>> I find the patch subject improvable.
>> You would like to detect the remaining usage of redundant null pointer =
checks
>> before selected function calls.
>> Thus it would be nice if the corresponding description can become clear=
er
>> another bit, wouldn't it?
> Sorry, I did not get your mean.


How do you think about a wording like the following?

Commit subject:
[PATCH] coccinelle: Add detection for redundant null pointer checks before=
 dev_{put,hold} function calls

Commit description:
The information =E2=80=9CAdd the case if dev is NULL in dev_{put, hold},
so the caller doesn't need to care whether dev is NULL or not.=E2=80=9D
was provided by the commit b37a466837393af72fe8bcb8f1436410f3f173f3
("netdevice: add the case if dev is NULL").
Thus extend source code analyses and corresponding transformations
by the means of the semantic patch language so that null pointer checks
which became unnecessary at other places because of the mentioned input
parameter validation.


>> Did you order the case distinctions in the SmPL disjunction according t=
o
>> the call frequencies of the mentioned function names?
> No, no any special, just list the related functions.

Will this view influence the selection which SmPL code variant
will be preferred finally?


Do you get further software development ideas from a data processing appro=
ach
which I published before?
https://build.opensuse.org/package/show/home:elfring:semantic_patching:Del=
etion_of_checks_before_specific_function_calls/Deletion_of_checks_before_s=
pecific_function_calls_in_Linux_source_files

Regards,
Markus
