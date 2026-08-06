Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4F9C5DF86
	for <cocci@archiver.kernel.org>; Thu, 20 Aug 2026 08:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=85JNUC8SyfLYyGobZYpdZmxyQGF0qjVqbjDUd/Wkets=;
  b=i9EZZ3mjt5BSPq3sOMBM8y6X92I0jPGgf728gInvCFLq/6DkTOboTFVO
   0LrQLycJgzm1g20VybgtaBEETuyuFVhU0o1UMjpQ/6ugsYq+HDhUKoIIC
   jYFMj6uXe9N8k3vYf0qJHCGkeW5m8zvMpqXw6J3Viioy54dwXDc1PPAp8
   o=;
X-CSE-ConnectionGUID: r4+f+2tlShqvYcCdMGHHXw==
X-CSE-MsgGUID: gAligKXPQZ+OtVCpHqaAhg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.25,232,1779141600"; 
   d="scan'208";a="290784102"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Aug 2026 10:36:49 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 7F0E281A1C; Thu, 20 Aug 2026 10:36:49 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id B68C281247
	for <cocci@sympa.inria.fr>; Thu,  6 Aug 2026 21:06:38 +0200 (CEST)
X-CSE-ConnectionGUID: 6T/UdMCkSdygAaUexojraQ==
X-CSE-MsgGUID: sDQbF0sSQve3jb8eXrOB3A==
IronPort-SDR: 6a74db36_PKuUUuGJamQLg1FcJUYVdyjj/jw5tbzCpQRzWyGkZug8I3D
 xog6MKOaT9+D3TDKZ8vbyLb/k6tMR2PYtffLccg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FwAQCG2nRqgyCx3M1AGh4BAQsSDIIFC4JBgQqBEgQLS?=
 =?us-ascii?q?YRYiHqGWIIknEaBVYE/PQIPAQMBCwEBPRQEAQEBAgSEegICAo1iAh4HAQQwC?=
 =?us-ascii?q?Q4BAgQDAgMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEBASAZB?=
 =?us-ascii?q?w47hk8NgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAR8BA?=
 =?us-ascii?q?QECARIRDwENAQE3AQQLCxoCJgICRhAGATSCYAGCKSQnAxGxQUNnJzYjAYEgQ?=
 =?us-ascii?q?okRAQEBeIEygQGCDAEBBt4aAwYVgQouiF0BgXCDEnY7hEEngWREgUeCQTg+g?=
 =?us-ascii?q?VKDBoNGgmqCJoEMknIJPwp4HANZLAFVEw0KCwcFYUIQMwMgCgsSEhgVAhQNE?=
 =?us-ascii?q?BIPBBYFLR1wDCcSDx0XFx5YGwcFEiAqQUQjAxMUBBMdQwWBTQKBcz8jGTZ8g?=
 =?us-ascii?q?QkKVIEtKmQBAhAXRi4VTwEDAoIMAgaCcYE2CxgNSBEsNwYOGQQ9AWgHjgMgg?=
 =?us-ascii?q?3+BfZdbr1kHA4QdjCGVVAQvg3EBpnqZCCONZ5sOAgQCBAUCGIFoOoFcUR+DN?=
 =?us-ascii?q?1ADGQ+OIRmDaYUTiioBvHcpND0BAQcCBw4DC4FokDSBTAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:b2lW+Ks+Y3OVNyrpSthAg4id5efnVK1aMUV32f8akzHdYApBsoF/q
 tZmKW7QPPuNazH9f4snYIzg8UsPu8WBytNqGwQ++X8zRCoR9ZOVVN+UB3msAy7DdceroGBPv
 5xPMIGYRCwXZiaB/Un1auCJQV1Uj/zgqm/UUbacUsxJbVY6Dn9n1VQ7wrBRbrdA2bCRGxmKt
 c75v/rRMVqk3y8cGm8P4spvkjs21BjJkG1e5AFWicxj5geEySFFVMxHf8ldElOhKmVqNr7iL
 wr85Orhlo/p109FIs+olL/9bnoLTtb6VSCSimBbUrSVmRNLoCo/yM4TbJLwvm8K49kht4kZJ
 ORl7fRcey9wVkH/sL11vy1jLs1LFfEuFInvcSHu65TLp6HxWyCEL/1GVCnaNGCDkwp9KTkmG
 fcwcVjhYv0f7g4fLX3SpuRE36wewMfX0Iw35E0n8D38JvUdTYHMaqz36M9f3i05v5UbdRreT
 5JxhTtHaQSYaVgXYg9JWZxmxqGwnnn4aCFVpBSeoq9fD2r7llQsluK3aJyMJYPMHp89ckWw/
 goq+0z8CwsGNdrZ0TeZ/2i3i+nnmjnyU4YfUra/85aGhXXKmzdMV0NICwrTTf+RkWKHUfwHM
 Hct5Cd1r6Ji+XyxafOmdkjtyJKDlkVGB4IMTLBSBBu24qHT6A2YLnMVSyZILt0grs4/AzIwv
 mJlhPvsFWRl9eXNESzM+O/O6yuqOS8OMWIOIyQDSGPp/uUPvqltslXyQvNIE5W5n9LcEAz90
 zeItiEH0uB7YdEw60mtwbzQb9uRSnXhSx5t7ECPBjr7vw0hPsi9f4yv8kTW4bBLK4Pxori9U
 Josy5L2AAMmVMDleMmxrAMlQODBCxGtbG20vLKXN8N9nwlBAlb6FWyq3N2BGKuZGp1eJWe1P
 xK7VfJ5/IVUO3Wyaq5xf8qwDc9spZXd+SDefqmMNLJmO8AvHCfepX0GTRDLhAjFzhNz+ZzTz
 L/AKK5A+15BUPw/lFJbho41jdcW+8zJ7TmOG82rkE73jOr2ibz8Ye5tDWZip9sRtMusyDg5O
 f4BXydT40wHDbGsUTqd6oMJM1EBIF4yAJ28+YQddfeOLkAiUCstAuPYi+FpMYF0vbVnpsGR9
 FGEW2hc1AXeg1/DIl60cXxNUu7kcqt+inMZBhYSG2iU9UItWquV15dHRaALJeEm0MdB0c9LS
 +I0fpTcI/ZXFRXC1TcvTbj8i41AaCWbp1qHAHa4axcBJ6xQZR77xYLNdFDN9BhUHi6TsO0gq
 YaBzSLee4IIHC55PfbVadWu7XWAjVpFkd0uUHDZftZuV3u0wrhIOR7O0v45GN4NIhP93Qmn1
 x6aLBMbhOvVqao3zYX5vr+FpIKXDOdOJEpWMG3F57KQNyOB3G6c7aJfceSPJxbxaXjV/fi8W
 OBr0P3MCv0Ls1JUuY5aEbww76Yf5cPqloBK3DZfA3THQFS6OIxOekDc85F0iZRM4btFtS+de
 EGFoIBaMIrUHvLVKgcaIQ59Y9mT0f0RpCLp0s00B0fH/w5ywquMVBRDHhuLiREFFoBPDqEe/
 b4DtvIVuiuFsTh7FvadjytRyXaAEWxYbYUjqaMhIdHKjigF9wh8RKLyWw7M3YG3StRTM0MVD
 Ceeq4jcip99mEfTUXoBOkLc/OhahJ4+tw97zQcdAnigwP36t+AS3UBO+hs3UA8O9BF1+L9xM
 DIzNmleB6aHzxF3judtAkGuHABgAkWC20rTklEmqkzQf3OKZEfsclIvCL2ox18I1V5TZR5Z9
 +yo83nkWjPUY83B5Cs+dkp7ofjFT9Yq1An9tO24PsaCDb8oSCHEh/KwWG82tBfXO8M9q0nZr
 +1M/uwrS6naNzYVkpIrGbuhyrUcZxCVFlNsGcg70vsyIljdXzWu1RylCUO7IJpNLsOX136IM
 ZVlI8YXWimu0CqLkCsgOpcNBL1Jh98s2ssJf+L6BGwBsobHlAFTjrDrynHcilMoEvJUquRsD
 qPKdjmHLH6cumsMpU/Js/t/GzSZZfsqWVTC+d6bocs1E6ANiuVOSX0J86CVuiyVOTR3/hjPs
 wLkYbTX/tNYyo9tvtXNF/xDDAOOMdnyCfu6wDq3uNJoadnMG9nFsi0XoHbaIjUMbKcwWst2p
 5uJotXYzEPIh5docmH7yr2qNbhF2tW2Z8VTavnIFXh9mTCTfvPs7z8o2XGKGbYQnPxzvsCYF
 haFMu2uftsravJh7XxyaRkGNS0CCq7yP5zSlQnko9uiUhEigBH6dvW5/nrUbEZeRC8CG7v6L
 iTW4/+OxNRpnL5gNS8+JcNNIsFHeQf4eK4cadfOmyGSDTCojnO8q7LSr0ccxg+ROEaUMvTRw
 MzjfQf/RiSQqauT7dB+sq5OhDM1Ikt5o9ENehM6x4YrpRG8VWIIFLFIe9FOQJRZiTf725zEd
 SnAJjlqQzn0WTNfNw7w+pL/VwOYHfYDIcr9OidvxU6PdiOqH8mVNdONLMu7D6teIVMPDd1LK
 O3yPlX1LkC7h8kxHbhC6KThx/9/xvTB2n8Ev0v6lqQexvrY7aoijBRc8MhlDEQr0P0hUG3MP
 2E+QW0CS0a+IaI0Odg1YGZbQXn1oxu2pwjFrk6zLBL3vJ+Sx+lNjvb4PokfF1HFgNsifNYze
 J88e4dBD616FJDeVWvFdu/FWZNJNM8=
IronPort-HdrOrdr: A9a23:bPUFq6EMXNYHVxnfpLqEW8eALOsnbusQ8zAXPo5KOH5om6uj5r
 2TdZUgpGXJYVMqMk3I9urwXJVoLUm9yXcx2/hpAV7AZnichILLFvAE0WKK+VSJcECTmYA96U
 4jSdkHNDSaNykesS+V2njaLz6iq+P3gZxA/d2uqUtFfEVScKdn4B5+CgGHVmNLZCQuP+tKKL
 OsovNdoTyuYHIWadn+IEIkcazsm/3n/aiWHyLvIXYcmXazpALt0aX9FReA2BcYTnd02L8ntU
 XIjgT447/mn/awoyWspFP73tBug93mxcJEBMuQzvINIjGpqgGmYu1aKs2/VfQO0Z2S1Go=
X-Talos-CUID: =?us-ascii?q?9a23=3Am4lBx2rSnRquPrlWhZW0PazmUZ4ZNUDR6VzTGEO?=
 =?us-ascii?q?pBk9gdbCFTl2K8Zoxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Abhj+aQ2SnWBVBGsxPiE4tQBvUDUj+IiXAm5Viq4?=
 =?us-ascii?q?/pcTfNyYgNgeHqx7sa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,209,1779141600"; 
   d="scan'208";a="153776669"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDE4gSHSWqVNXaxuoeHoQklGgifZoIz07lbf7p?=
 =?us-ascii?q?j1jHODrez0I5G/rD8XwvALcGnIu7s4VvRN6znwXy4No/ZB0yORX8KELh?=
 =?us-ascii?q?cvZhRDST5XGghafyKcVrs/ksTFuUc0v7KWEIxbJNkFfHBSvJbRevivb1?=
 =?us-ascii?q?PV3KPJeurxBRaagQ8RAknQIw=3D=3D?=
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 21:06:30 +0200
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676Ftr4v4168306;
	Thu, 6 Aug 2026 19:06:26 GMT
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs8ugpqtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Aug 2026 19:06:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 676J0b6k024663;
	Thu, 6 Aug 2026 19:06:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78w56e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Aug 2026 19:06:25 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 676J6LgY011247;
	Thu, 6 Aug 2026 19:06:24 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4fs78w56b9-3;
	Thu, 06 Aug 2026 19:06:24 +0000 (GMT)
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Julia.Lawall@inria.fr, Alex Deucher <alexander.deucher@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        David Airlie <airlied@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hansg@kernel.org>, Hans Verkuil <hverkuil@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jiri Pirko <jiri@resnulli.us>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Johan Hovold <johan@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Julian Anastasov <ja@ssi.bg>, Leon Romanovsky <leon@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linusw@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Matthew Sakai <msakai@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mike Rapoport <rppt@kernel.org>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Paolo Abeni <pabeni@redhat.com>, Ping-Ke Shih <pkshih@realtek.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sebastian Reichel <sre@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Simona Vetter <simona@ffwll.ch>, Simon Horman <horms@verge.net.au>,
        Stephen Boyd <sboyd@kernel.org>, Steve French <sfrench@samba.org>,
        Takashi Iwai <tiwai@suse.com>, Thomas Renninger <trenn@suse.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tony Luck <tony.luck@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, cocci@inria.fr,
        amd-gfx@lists.freedesktop.org, dmaengine@vger.kernel.org,
        dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org,
        iommu@lists.linux.dev, linux-cifs@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mm@kvack.org, linux-pm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, lvs-devel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        nouveau@lists.freedesktop.org, platform-driver-x86@vger.kernel.org
Date: Thu,  6 Aug 2026 15:06:08 -0400
Message-ID: <178589207129.336697.9870225893827541543.b4-ty@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=672 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608060149
X-Proofpoint-ORIG-GUID: XGMDaQGIFMb57T6Q2yvPQTQQt2debxfq
X-Authority-Analysis: v=2.4 cv=XqnK/1F9 c=1 sm=1 tr=0 ts=6a74db32 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8
 a=Br-j9HdbvUlrMjNZj6IA:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13510
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE0OSBTYWx0ZWRfX6uIK9jT+2Jev
 rYS5Xc6Wjv9hMYRtyD0NY9wioUhY1o9ts8S44XrOIykROIC2fMM+q3H5rjkub44bNgkLDQ3tnSe
 fkx9LiuU0Ioed9eVzRB8PP2qYuZIVaHGDH9Vr333gSb2ZgsHD92v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE0OSBTYWx0ZWRfX43FUiflrVixJ
 FNgAKsr+fsfl0ktZltC3fvW6MVFcRQRy/oySHj8nQQDMOHwfS94QLWHrXArK3j62D1c6aNzQrnl
 2DtOuGbPQocnjuSCI1ny1WWYx/7jkkjlcfyl+lp7TEesEfkx307+KuCZo0OgIxbIwfa72MWD4em
 tn6/hMd/QXx6zH3wP5OlhrMzlp2qKgIxJlelAMfUWIkruyj4hnvKzGUkqPoF4QRZ71As9I8pV2j
 DMm/cMIaHufC6lXcsuKfUk0yiqWTx1Zr8LtQAR498eW34hEj3pAMHucta0+1CKmEnv9EN7lkU/M
 FG7jgW8yHOjl2TgueMJFzovO4heKYSqjW47oC3CHVujyZPMUqifsWdUKFoxdhd+EKhXdCEJL9b0
 LGCES5HP/CdGIqj2UaaWymZGJVFVJ4RBD/aEk7/710HO5x59Z+gVx3LZGgty2YUYCbgJE7oGTWH
 QPXliDM2eYx5QgvaSSBlrfWn/1V9lBD33lbCDCaI=
X-Proofpoint-GUID: XGMDaQGIFMb57T6Q2yvPQTQQt2debxfq
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] (subset) [PATCH 00/36] treewide: remove conditional
 returns with no effect
Reply-To: "Martin K. Petersen" <martin.petersen@oracle.com>
X-Loop: cocci@inria.fr
X-Sequence: 3686
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/kZw4jZ2sk8c-txR2VT1wNA>

On Fri, 24 Jul 2026 03:45:02 +0900, Sang-Heon Jeon wrote:

> While reading mm/memblock, I found a conditional return where both
> branches return the same value:
> 
> 	err = do_something();
> 	if (err)
> 		return err;
> 	return err;
> 
> [...]

Applied to 7.3/scsi-queue, thanks!

[30/36] scsi: mpt3sas: remove conditional return with no effect
        https://git.kernel.org/mkp/scsi/c/c79f9bf2d87f

-- 
Martin K. Petersen
