Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE8DC74A5B
	for <cocci@archiver.kernel.org>; Wed, 29 Mar 2023 05:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=7+qLNK3aKTjgQqYoDcY72/rlHkte/xaVhThuGMGJyXI=;
  b=Sb1H5Mc2EP2S3RxENftqACYRBZ6DBb214gjSiHTMfy/U6b4RgsC9zUFW
   KGoHLVs39RElpDTNNEJPSCqGf+qm12lKBhVeB3F85vlsT/popkF7sYI7R
   eGgh04KY3XA/KcSmi6eJ6uzhnyxbZvNEsp/eRpGeXU+obt3vf/Q4rIQUc
   I=;
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
X-IronPort-AV: E=Sophos;i="5.98,299,1673910000"; 
   d="scan'208";a="99614233"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Mar 2023 07:32:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F04A1E0B51; Wed, 29 Mar 2023 07:32:47 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9FC66E0B2D
	for <cocci@sympa.inria.fr>; Wed, 29 Mar 2023 07:32:43 +0200 (CEST)
IronPort-SDR: 6423cd7a_7eROIuAToxhyjs9fiMsIxO869GgP5SO6ZbqsQvGGjV+mSS4
 uwgAfIRfXr0aqf5NsOQ/KmQjdQuslWi538NRakg==
X-IPAS-Result: =?us-ascii?q?A0EuAABGzCNkhwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYItdVYvBAtGhFORATGEL4cshzqIaYFWgUA+DwEDAQ1BAQIEAQEDB?=
 =?us-ascii?q?IR+AoU5Ah0HAQQxCA4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBA?=
 =?us-ascii?q?hABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAkdTPQECAgEjHQEBESYBDwsaAiYCAlcGAQwIAQGCegGCJwEDDiMHriCBM?=
 =?us-ascii?q?oEBgggBAQacCh8sIlOBXgMGgRQtAY0EgzZ6Jw+BVUSBPIMDPoREg1iCZ44fi?=
 =?us-ascii?q?yUKgTRzgSAOgT2BBAIJAhFrgRIIa4F8QAINZAsOcYFKAmRMgSElBA4DGSsdQ?=
 =?us-ascii?q?AIBCzs6PzUGAwsgBlhrAgkjERMFAwsVKkcECDkGGzQRAggPEg8GJkQOQjc0E?=
 =?us-ascii?q?wZcASkLDhEDUIFHBC9efAoGASYknHuBaC8QxXA0B4IogVWBWQyfDAYTLpcID?=
 =?us-ascii?q?gaSI5dqIKd6gWUCNoFcMxokgzZPAxkPjiAMDQmEA48JAT4/NDsCBwsBAQMJh?=
 =?us-ascii?q?UYBAYV7AQE?=
IronPort-PHdr: A9a23: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
 lF4cijJTfRdguk4HV0=
IronPort-Data: A9a23:stYBR6sdEId479PJyOF1b7zlrufnVEZaMUV32f8akzHdYApBsoF/q
 tZmKWCBbquCY2H2KYsgO9y280MDvcCEyN9qGVRo/y42F3kRgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTrSCYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbyRFu8pvlDs15K6p4GhC7gRiDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNz94X2mVTKlLjFVDmZkh+A8BOsTAezsAG6ZvXAdJHAathZ5plqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJE9sGLEdwbl1OnNp1
 uIeb2wPVRqFqdvjldpXSsE07igiBMzsIZ9ZpXxqiz3UZRokacqaGeOQv4AehWp23aiiHt6GD
 yYdQR9mdhfdeFtiPlkNCZQxtPiljD/zflW0rXrE9PRuvzKIlWSd1pDJPsLlR5u1af4PuUCbo
 1nGwDqnPhIVYYn3JT2tqy/w2LaWw0sXQrk6H7qz/f9Cm0yW3mVVCRsMVFL9r+PRt6Klc9dYN
 lBS5Sck66Q/nKC2cjXjdxPihUKBhUEeYMh3MPM8r12P8aDSzT/MUwDoUQV9QNAhscY3Qxkj2
 VmIg87lCFRTXFu9FyP1GlC88mvaBMQFEYMRTXJdE1BUsrEPtKlv0EuVE76PBYbo1oWdJN3m/
 9ydhA4a71n5pfwGyai9913djD+qznQiZlJquF+/so6NyARjeI7tTZah41Hd8Z59wGuxS16co
 D4blsLY4O1m4XCxeM6lELVl8FKBva/t3NjgbbhHQslJG9OFpi/LQGyoyGsiTHqFy+5dEdMTX
 GfduBlK+LhYN2awYKl8buqZUpp6lfC6RY6/C6CPN7Kih6SdkifYrEmCgmbPgAjQfLQEyv5X1
 WqzLJvzVi9DYUiZ5GPpF7ZAuVPU+szO7TqOGc6ilkrPPUu2PTDMAbYDLFaUaO0lpKqLyDg5A
 P4PX/ZmPy53CbWkCgGOqdB7BQlTcRATWM6qw+QKKL/rClQ8RAkJVaSLqZt/INMNokigvryVl
 p1LchQEkwWXaLyuAVniV02Pn5u1B8kn/CJqYnV2VbtqslB6CbuSAG4kX8NfVdEaGCZLlJaYl
 tFVJJ3SMecFUTnd5TUWYL/0qYEoJlzhhhuDM2DhKHIzdoJpDV6BsNL1XBrdxA9XBAqOtOw6v
 +KB0CHfSsE9XAhMNpvdR8+u6FKThkIjvtxOcXHGGfRtXXn90ZNLLnXxh8AnIstXJhTkwCCb5
 jmsAhwZhLfsptYr/OnwmKzekYaNFtF6P0tFHlv06aS9Gjna81GCn65BcresVhLMWFzk/J6NY
 b1u8Mj9F/kcjnNmgpFZAZ8y6Y4fvvzB/6R7yCZgF1X1N2WbMKtqeCS67JMep59zya98kirof
 EC2o/1xG6iDYeHhG34vfDsVVPyJj6woq2OD/MYOARvI4QFs9+C6SmRUBR6HjRJdIJZTMI8Ix
 eQAutYc2zegiygFY8q3sSRJy1uidnAwcb0rlpU/Mr/ZjgAGzlJjY5uFBBTmv7CJSdFHaXcxL
 hGu2aHturV7x2j5SUQVK0Tj5+RmqK41iEh492Naf1WtsfjZt8AzxyxUoGgWTBwK7xBp0NBTG
 2lMNm8uF5qv4gVHuclndEKvEjFnGxe21BHQyVwItWuBVGiudDXHA1McMNa33nIy0jxjbB1E2
 oqH2UDZUTrOV+Pg7BsYAEJKhaTqco1sy1fkhsuiIfWgI7A7RjjU2omVemsCrkrcM/Mb3UHoi
 7Fjw7dtVPfdKyUVnqwcDrua35Q2TDSvBjRLYdNlzZMzMVDsQhOA8hnQFBnpYeJIHeLAzmGgA
 c83Js5vaQW35BzTkh8lX5wzM51Gt993wupaYb76B380g53GpBpTjZ/g3CzfhmgqftZQrfgAO
 r7hLwylLGjBqkZXyknsrdZFMFWWedMrRhPx98Hr/fQrF6AsivBNc0Yz3uGKvlGQCg9G/g2Vj
 izHdaT53+xv8qUyvorOQ4FoJRS4FsP3b8uMqDuMitVpacjdFOvzrCYXlwXXBBtXNr4vRNhHr
 7SBn9rp1kfjvrxtcWTmt7SeNqtOv+OeYfF2N5/pEXxkgieyYs/gzB8d8WSeK5YSstd85NGid
 jSoevmLat8ZdNdM9kJ7MxEEPU4mNJ32SaP8qQeWjfeGUEEd2DOaCuKXzybiaGUDexIYP5H7N
 BTPhM+vwdJm/bR8XEpOQ7ksBpJjO1bsVJc3b9C753HSEmCshUjEobf40wYp7TbQEHSfDcLm+
 tT/SwPjcAip8rT9pD2DX1eeYjVMZJq8vQUxQq7Z09txliz8E2MMa+gQWXnD5le4jQSqvKwUp
 hmUBIfhNck5dStJe1Pw7bwPmy+BU/cWNI6RyiMBpiuphuTfOG9EKKRs/GFs7h+av9clIP6Pc
 bkjx5E7AvR9LlyFiwreCjxXTNqLHs/n+08=
IronPort-HdrOrdr: A9a23:GPbPpal2Z4nJJTAJvQQHyich76XpDfL43DAbv31ZSRFFG/FwWf
 re+cjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,299,1673910000"; 
   d="scan'208";a="99614231"
X-MGA-submission: =?us-ascii?q?MDGu6/Ax8e4cGMfGlUhKn4DI/ki/ngbuYTets7?=
 =?us-ascii?q?2+aXe4Ua2PluOjBT3EntwPwBSHMn+qyOPhMXN9VPKszJ2TCpMh+zpCTx?=
 =?us-ascii?q?lkPadiuhIk9hWBzOwaF/qXWsH5DwYLlw7u0KfDD21t/ls9NFtIq9be7s?=
 =?us-ascii?q?ByEPqssTYEln2CFskEqUzTow=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 07:32:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680067952; i=markus.elfring@web.de;
	bh=eBEgkYuO3OdHwM+bSC1c2ca992gESB5yy+6aSDuoeO4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=l+WJo/apFP5ntyAkyGjGoIg9VcdP3NjAQ3dNjup35EPTLMJE/rDPCMr3sZzZj+9Dr
	 aS/mp2WTY7XG4UHfPfElYXGpfVqAYjBA1WktA+3eSGGwFmJjT2pbeyLjBRtlnKI4Cd
	 SDpfs6jINdRO5H6HrvnbndLCc05g9J7BziChE1336t2TZ8magLM+CarAbNdGQq4dA7
	 D/OeH7s7jWFnFMTQoSl6Fcn6EqvFkJJOq41i2h8Oo4siuGDHTfZ81ndlbkHfGYX4OY
	 ueWOR0CWziZbCE0Zo4KMJqUF/SM/+SckiUvoU8z21ekEOKaCeihKhegR+Fv+wJg9GK
	 sjvsBngDT0CPg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZSBG-1pv7dm2Unm-00WS0X; Wed, 29
 Mar 2023 07:32:32 +0200
Message-ID: <2fbfc20a-71ee-ddaa-19d8-7beed559b491@web.de>
Date: Wed, 29 Mar 2023 07:32:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
To: Song Liu <song@kernel.org>, kernel-janitors@vger.kernel.org,
 linux-raid@vger.kernel.org, Coly Li <colyli@suse.de>,
 Jens Axboe <axboe@kernel.dk>, Kent Overstreet <kent.overstreet@gmail.com>,
 Maciej Trela <Maciej.Trela@intel.com>, Neil Brown <neilb@suse.de>,
 Shaohua Li <shli@fb.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <6ee3b703-2161-eacd-c12f-7fa3bedf82dc@web.de>
 <49adf0c8-825a-018f-6d95-ce613944fc9b@web.de>
 <CAPhsuW7JZDps_fTHyCabjfG4YjzDVEW_41u6d+9mdc2CAJv_Kw@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAPhsuW7JZDps_fTHyCabjfG4YjzDVEW_41u6d+9mdc2CAJv_Kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N8anOI25ScTPYbtUTTWzPXqn6mLW8GzIm/Bl49VXzyp8UByFR4q
 bQsjV7/LX8IhwXi1cIc8k0sXuQaTTM5DWqHwfz13Ah8r3bOXvI1BFCXn/pTo5zm+kPI7pMm
 Dsmw5SBrluLaTVy7zS62QcbFpWTXcqDnJzTtfpERMAoaITyaFF1y/acyz0f8VDEp6mbzOEn
 RWr/ZaGkzDZFSnoyKT56A==
UI-OutboundReport: notjunk:1;M01:P0:FFYrd7HYAJ0=;dwG8RkB0zptP/JYlU6PPcYUaPaZ
 p0IAc1Da3mUlZtGjA42QJ3iqsE9QL60cvYLMYYucK015RODrlYtr/5yRbTG7f2Soac2GiRKG1
 070k/iYym6SPSegjHJ3whEfAdXmh+iF0CF49iXTbb3WIRj8cuSRADLf1+00M6dsyczcZjMd2M
 g9i3X9+O052O2yluWKqZixWREunAVq+buOYFfCWTvXI20PhT0HaFyTfwBUyeXhWfffG8tEtcM
 Lm8mWrxpsOZr8W5jlg7PMAmhN31C0+xKCyC5e5OiK49EMNL8WHKKNfralndwxwlBrLVYmlxP/
 2YBv7YpKrbBR2q4ojzSFsH9KuJNfwjjjWXdNRiuX3x6kyA+NEEysSYLmonjFcT+4Y8VtAeD/o
 cQn1zvYVDa/e3jMzSwK4TpOrQKz958dXKth1Xp4jCtC3qFwOwBfTP4qEYPsJ9qFuIvRNOSVqK
 BBBgpr4UX6ohI2LWNPrd1bOO0hFazjxOu4kO/GmYU0DMjsEInherzPoJvo2quqXcb9W8WyhXJ
 XxZAo9VGegVxdXg7HaK7yf+DG1OKVXQHYtOuzAAhwfaltagDsizRBjhr6cywGK/PzsYGW40ZJ
 EqCXEvxPUJmcup3XJDqLzK3D0EL4qBDJFvxVeOcmDMEuYu7s/syfvLjua1BLPANq3aAvuDTwJ
 u1GeJycuemF/x0YZQnXwxxkNpgvjTuXToOxlHinQ7lxO/YmNih0YsqiU+Es4bKV25I9KxO23z
 +2EKNfPcgfb09U5Ww6MkjPjIybXKrRJ3XCGptRLN8f9aLO078e3ZWsFp8m33UlKxPluAnaQjF
 1AwT4YPuYpQKWf54HGQMrLIPfm5UCSngWNxckQSB93QBYyps2Of+/AJi2YNTx7HTMEZWZTNL/
 3Onz3xQyNlRgaJm13WXkZ7TJcRbA4XnBL68bY+v/qZd0N6Sm7ADr6dkJR
Subject: Re: [cocci] [0/2] md/raid: Adjustments for two function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 979
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/2fbfc20a-71ee-ddaa-19d8-7beed559b491%40web.de>

>>   raid1: Fix exception handling in setup_conf()
>>   raid10: Fix exception handling in setup_conf()
>
> The two functions look good to me as-is. I don't think anything is
> broken except that the code analysis tool complains. I don't think
> it is necessary to make these changes.

Will development interests ever grow also for advice from another informat=
ion source?
https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+go=
to+chain+when+leaving+a+function+on+error+when+using+and+releasing+resourc=
es#MEM12C.Considerusingagotochainwhenleavingafunctiononerrorwhenusingandre=
leasingresources-CompliantSolution%28POSIX,GotoChain%29

Regards,
Markus
