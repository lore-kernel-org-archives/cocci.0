Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7864C282D1
	for <cocci@archiver.kernel.org>; Thu,  6 Mar 2025 12:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=OtUFWvmDDURdvZ0DW7jQdXkRvklZ7Tk8DLOYR5A2NdM=;
  b=Y98eHrvCdZKOcFl2ItxWmbSjZwkO2Tpkc7FVxNuBn3NBUpg9GYj7gigX
   x3O3g1aJojcJ0ZXbzdFHyK6YUUSSJbxoV39Sy2Utq/xuIDODobCHuD+ao
   CEM4QZ9zPPi31hi0aXypxjxTgcZpdPSJJbneasWLtEljXhnvALD6wZdR5
   0=;
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
X-IronPort-AV: E=Sophos;i="6.14,226,1736809200"; 
   d="scan'208";a="211542863"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Mar 2025 13:13:51 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CCCBEE0D1E; Thu,  6 Mar 2025 13:13:51 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3B8CFE0260
	for <cocci@sympa.inria.fr>; Thu,  6 Mar 2025 13:13:44 +0100 (CET)
IronPort-SDR: 67c99178_pZfSqgQdI1qiGv0zMLCH4/zuxLJRLRFkX4iHYcMelscQSz3
 LPFh62b/70zRFGB2zLeDR3MqilczBZREyvwSYFw==
X-IPAS-Result: =?us-ascii?q?A0HfCADCkMlngAMP49RaDnuBU4JEYnUzBAtIhFaPT4F0M?=
 =?us-ascii?q?IQ7hzuHU4pLgX4PAQMBDUEBAgQBAQMEggyCdAKLGAIeBwEEMAkOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgoxhXsNgluBLIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQJHRAEBAQIBIx0BAREmAQQLCw4MAiYCAlYGFQEBgn6CMAEDD?=
 =?us-ascii?q?iMHr1GBMoEBggwBAQbaXB8sIleBZQmBGi6FbIJjAYpiJw+BVUSBPIMDPoRDg?=
 =?us-ascii?q?1uCaYIzhEBnhkuDCohch1aOblJ7HANZLAFVExcLBwWBKUMDgQ8jgSMFNEE6g?=
 =?us-ascii?q?gtpSToCDQI1gh58gitqBAWBJII3hD2EQoVSghGBXQMDFg8BgjBvdxyDT3c7h?=
 =?us-ascii?q?AhhFx1AAgELbT03CQsbBj2iMINQgWUJX4ERKccDNAeCOIFmgWMMn14GEy+XR?=
 =?us-ascii?q?g4Gkn2YfqkzgWc6gVwzGiSDNk8DGQ+STo8BuC5CNTwCBwEKAQEDCYVGAQGKV?=
 =?us-ascii?q?IFLAQE?=
IronPort-PHdr: A9a23:DF4E9h27FlpnsK9ysmDOIQ8yDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BeFo601xwaRAtqBo9t/yMPo8InYGlY8qa6bt34DdJEeHzQksu4x2zIaPcieFEfgJ+TrZSFpV
 O5LVVti4m3peRMNQJW2aFLduGC94iAPERvjKwV1Ov71GonPhMiryuy+4ZLebgtWiDanfb9+M
 Bq6oRjNusQUg4ZuNLs6xwfUrHdPZ+lZymRkKE6JkRr7+sm+4oNo/T5Ku/Im+c5AUKH6cLo9Q
 LdFEjkoMH076dPyuxXbQgSB+nUTUmMNkhpVGAfF9w31Xo3wsiThqOVw3jSRMNDsQrA1XTSi6
 LprSAPthSwaOTM17H3bh8pth69dvRmvpQFww5TMbY+WOvRxca3Sc84ES2pPQMtfVy5ODZ+zY
 YYUE+oBJPxVo5Xhq1cQrxazAxSnCuP1yj9Pg3/7xao03P47EQHFwQwgBM8FvnvQrNX7LqcSU
 Oa1zKbVxjjEaP1Zwy396IvVchA6u/2CUrZwccTLyUkuEQPFgU6dqIL7MDyOzOgCrnaU4vNmW
 OmyhGEptxt/rSKzxscwlIbJnIQVx0jZ+ClkxIs4JcO1RVJ1bNOnDpZdtSKXO5V5TM8+TG9kp
 Ds2x6AIt5O5YCQHyJoqyhzQZfCbb4SF/w/vWuiSLDpmgn9uZbGxhw6q/ES+1+HwSNO43EhUo
 idHiNXAq3AA2wbd58SfTvZw8V2t1DiS2wzJ7uxJL1o4mbTdJpU83LMwkocTsV/fHiDogkX4k
 a6Wd0Q69eWw9+jqZKjtqIWGOI9ukA7+N7wjmsyhDuQ8NQgDR22b+eOh1L3/50H4TqtFgeYsn
 qbErp/WPcUbpqinDA9Jyosv9QuzAym83NgGg3UKLkhJdA+HgoTzNVzCOPX4Au2+g1Sonjdr3
 ffGPrj5D5vKNHfDirThfatm60JGxwQzyd5f54hVCrEHL/L+QUHwu8LDARMjLgO73f7rCNNm2
 YwGQ2KAHreZML/OsV+P/u8jPvGAZJUJtzblN/gl+/nugGclll8aYaamwZoXZWujHvVmJkWZe
 WDjjs0AEWcMpAo+TfblhEeMUT5JND6OWPcQ7zc6C4GvRaXOQpuugfTV1yK5R8YITntNA0qIH
 GvtfoSAHe0RdC2fONQnnzAZA+uPUYgkgDSnrgzn0PJKKuTO+ysX/cbG3cJ2+vaVuBU87z1yA
 OyC3mvLQ2wizTBAfCM/wK0q+R818VyEy6Ut25SwdPRW7vJNCEIhMILEivZ9AJb0Ux7AedGAT
 BCnRM+nCHc/VIF52McANmB6HdjqlRXfx2yyGbZAsrWRB4EvtI/Y0WLwIclV1HvMkqUs3BE9W
 sUaDWS9neZk8hTLQYvAkkGXjaGvIIEVxi3Q7yGuyWSUvUdXeBF9W+PJUCNXfVPY+PL+4E6KV
 LqyEfInPw9GnNaFMbdPY8b1gE9uQfD+JJLBbmj3l2rY6Q+g4LSKYcKqfmwc2H+YE00Yi0UJ+
 n3AMwEiByCnqmaYDTp0FFupbVm+ue954Gi2SEM51WToJwVoyqa19xgJhPedV+Jb37QKvz0ko
 il1G1D11szfCt6JrQ5sNKtGZtZ17FBC3GPf/wtzW/7oZ4VrnF0DaEJau0301hN4IppNm44mo
 TJizQZ/L76ZzEIUbymRjtj7PrzaLHW3/Qj6MfeMnAuEj5DPp+FUu5Fa4x35sQqkF1Qv6SBi2
 thRiT6H44nSSRAVWtT3W1o28B5zo/fbZDM87sXazy4JU+H8vznc1tYuHOZgxAyneoIVFaqeF
 xLpVeAeCdKvLuMChFWjKB4JdrM3luZ8L4a9ev2K1bT+dsNphjG7liJq5I5n00SD3zVxQKjE0
 txWppPQlhvCXDD6glC7t8nxko0RfjAeEF20zi38DZJQbKl/FWoSIV+nONb/htB3hpq3HmVd6
 EbmHVQNnsmgZRuVaVX5mwxWz0Ue53K9y2O0yDl9kjdhqaT6vmSG5u34dwccfENPSnNji1jEP
 oW+ydwXFESldAkmkhK56F2ynfEB4v4lcC+KHAETNyHtZ3lvSK6xqqaPb6stoNszvCNbXf79K
 VGWR7jhogcLhibqHm9Q3jc+JHmhvpT0mQA/iXrIdi8p6iCDJocpmFGEt7m+DbZL0zELRTd1k
 2zSD1m4ZZyy+MmM0o3Euaa4Xn6gUZtadW/qy5mBvW21/z4PY1X3kvatl9ngCQV/3zX80owgc
 CzSrwvnJKTv2b67N+1PYURiQlPxoZkfeMk2gs4riZcc1GJPzLCc53kaiiHeNdtB2KTxRGUAT
 3gHzpSGhWqtkF0mJXWPyYXjU3ybycY0fNi2bFQd3Scl5txLAqOZv/RU2DF4qV2ioUfNcOBwy
 30DnOA25idQ0IRr8EI9iz+QCbcIEQxEMDzwwl6WusumovwfbTSqdqWsklVzl5atAfmL8ARbR
 Wq8apklBzB59Mk5L1/GlnH+j+OsMNCCaNUOqlielArGhOUTN5870PYHzSM1PGXgoTgu0OQmi
 R8ohJi8sNHBIGJomcDxShcKMzroe4YY4Trql74Yx8+Q09npFZJkUiMCWJ+iJR6xOBQVs/mvd
 wOHETlm72yeBaKaBwiUrkFvs3PIFZmvcXCRPngQi9t4FlGbIwREjQYYUS9f/NZxHx22xMHnb
 EZy5ywArl/+pBxWz+t0Nh75Gm7BrQasYz0wRdCRNh1Tpg1F4k7UN4SZ4IcRV2lA+Ya9qQWWN
 mGBTwFPEH1PRUGOQVzuf/Gv6dTG7+mEF7++Iv/JMtDs4aRVU/aFw47q05MzpW/WcJ/VYT87U
 rtgiS8hFThjFs/UmisCUXkSniPJNYuAoQukvzdwpYa5+ejqXwTm4c2ODaFTOJNh4UPT4+/LO
 uiOiSJ+MTsd2IkLwCqC7bEF30MJzQxqeSOsF7soqiPHCq7d0PwybVZTe2ZoOc1E4rhplBFKI
 tLeg8jp26RQi/koFxFaWFanlszjNqloaymtcVjAAkiMLrGPIzbGltr2ba2LQrpVlOxIthe0t
 F5z/Gf8Mz7FmzS7DnhH1MlTgSvdMBEM4OlVkz5oDnX/Cs3rYFu3PY0v5QA=
IronPort-Data: A9a23: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
 aXZi4yJrIFXhHMdyfpdRkM=
IronPort-HdrOrdr: A9a23:Lu0sXq4QBx79GAWAWQPXwBzXdLJyesId70hD6qm+c20wTiXqrb
 HKoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkdNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:tEjEO29yfmeeqpQ54ciVv289JPAOLVfe8FXNDmXpK2lJWqWoVmbFrQ==
X-Talos-MUID: 9a23:WW6crQicZej5mv68LMfcXsMpOe1t6p+zI1w3yIxd44qFEiJINBaDg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,226,1736809200"; 
   d="scan'208";a="211542858"
X-MGA-submission: =?us-ascii?q?MDEZu74VxRx6ZyVCR9uZIOSipR2PNer4gVLZZC?=
 =?us-ascii?q?x45Qpft3AkJe2vI9a9C/3qJGCrIyAycSrCTYualLuGCu6GnAhqGkhqAx?=
 =?us-ascii?q?cowkVuQIim3NtjTpQEgcyL85FnvzB79VNzrm1KZ4DsHCpfzj71IDmpFU?=
 =?us-ascii?q?UWbuXcMVJ9z15RSWu8IwEHoQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 13:13:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741263222; x=1741868022; i=markus.elfring@web.de;
	bh=OtUFWvmDDURdvZ0DW7jQdXkRvklZ7Tk8DLOYR5A2NdM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AYoHJQLwJxrnvws7gCLPGO747fEyDjTpPjuGoFSCQIyUnpkfzYuGjGoEgFDGZS9r
	 xBuhoklIukyZGCipKmBRrjAHw2eGzQN7uBCxIkFKufIJ9rqZV1lGRgFrkJbCnCahR
	 zjeSlXeatUOZt/CEn+V038fZprhn17jlFIruqtpWBxjE/+7IFFT8L3sqoWCxau2kK
	 IAhxbRCjB6Dy2LuR0uKXUXnSgj0i+CFz3174DdUpxaHax5N++2IY7TboyMG5mv9SD
	 MR+YDZg8LYSbGpq2gzVdtBHnrkvnXV7f05f1eq5R2DofkDiL8tKbEAwJkweEYy6Lm
	 K7gBNVXVm7abemqWUA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.2]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDvDU-1u06Fu1Ff2-003IB4; Thu, 06
 Mar 2025 13:13:42 +0100
Message-ID: <14e44e1b-e35d-4cc9-ac76-2e4c05c15849@web.de>
Date: Thu, 6 Mar 2025 13:13:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Danikka Jelski <cmj136@scarletmail.rutgers.edu>
References: <CABDMBwh_LRL+Dxz94caz+ybJT5MLP9usBs12fLeDHaTSnOES3A@mail.gmail.com>
Content-Language: en-GB
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CABDMBwh_LRL+Dxz94caz+ybJT5MLP9usBs12fLeDHaTSnOES3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dnzPelpLfXIzYUWK5YlnFdJR49Va8vMTKDKBRDA3uW04Y7fa2mp
 7HWr3pafL4cHRvbdW9HtLMbe5KJgdkS5MVA8xzAVWH6e9uR9A3dCFPfDR1QeE+EvpLYDrrd
 o/IpUTZbsNAE3MUSlsvKhru0YxeDpT9/4UouiWGC7TA/bYGvEQkoqkNCWl2paJ4qrkKNgTy
 YNtWsopbQKURcMDnu4fsw==
UI-OutboundReport: notjunk:1;M01:P0:EnMqNV2EBV4=;Dh0yPB8vJBSAFpV7+I9Q1vbBuvJ
 /JTmnV3vWN5+NUj4XIefEhfRmFq2kDp/3AkxIYSHOS0K2oWgEAs1dL3LoDyZGcLTmchoLNhIR
 q00m+7UH07nFLTknO2rtx0nOZDg3MVDC40MFqLbzx9Tm4UYYYe61x+JEJAUA0PGGp7LEnGvH2
 LYptnwR+c1HB7m9Kci6lIXIbYUglILpZSgbI2EPAqlckdfYKudcNSvivEr/ut/Vhh2c/qNP+O
 XmMFD9h8jqkbT4rZ/T44kAT2rCnJWq/5ci4trQVLRfzIxgdZ7ECAhsgqi1TPkM9ZI/oR89Rza
 oIeTCeIH+RYv2/pYKOaElp0wGpBsIr5Ppovl4YmcSVb4jwGkNly47aPJ6+kzfySvDVYZl4inI
 MgRyS4LwLKmEk7OtRrmnyjNcWox5GG2BQKx3hIJErbqcc8B+PnB2eYGhQt7wudIX1whZcf/Z2
 mEzJ+YIvQnCY6Xdgybe7ufqAoFmDL6FjDDiRenIPQMxA6AES3oHKqr9o7XnV6D9WzGVa4rOSE
 vEnMUsuDfVQLc0l81/jlSR1TnuwBrSR6/eijGUu6B9gkODPVYD/Y1eEdZ/cB56ihiW4o2fzHH
 WHOkQt/KuwkN/uuonz3L1ngtnZWXJhEd3lJ1BMHc8t9Z7IQj2YuStviHMf1PwRzvQYHPnhDwU
 bIIUFrEWUJM5/OGUJMHXXDrJHTtQZYN8LsObNXtTffpldEvzCJW8X5G5EsN1b9GNpOcuTmfyr
 rhZ4eddu/4UeCRFFZUqvojmEKuFG/60HQGnv9F9qSS/O34Lcw3SGA+QVNKjaATfKyZyh4QtkX
 2ho2IzOmZF99KHXTLPNpOJyP7MS8Wy4dRgpOhZzzPWxl1nsc+CeG0P2yTegJ7sl6+Cjr7Td4n
 kB9qSilvhN8QPX71IZWHGgwQqh9powSCK9Pmqn2bgcgsvey6YoTfLv/2heKzxg5p+mkEGEvu8
 GfukcTlWvhm+E+7wuF3Om/JfVeIED2MW/DNnciGykDu9YN7XX1myDZDlen835rK7L9eC4JoUy
 kGcpE39wMRAY/Xp3jl/2fh1u7JBL8gQ+TFpE8WUcdS4hAr4QLo6FayjmzCjMxnjfo13FrWXkD
 ZConrsYFAVGSz5e+xhWfmfNcKxmtPrESiE9VUpDEOjuq9MSn+a1j0BpdEBLxgIPanodbvS+oD
 UhJoxm0aHPrss6eL29GAPP0cPrys8dDPOv5fp44A7t/krRXLHC+QjVChzcWFoFtso0qHHsBkG
 i7hxh73I/G9QjVziOlLTTvo1IJDx75UWH2FBrhifixnFKry5jzoeQSEKTpnRJeAdSCf15Dt7Y
 M66lDB452XQah1Ewf782dYVl7bG2neV+NVaXK93SdU9Si2C4tWN22m8p3YGZT6pwOdLdWZTe/
 pRZH3/swV9PO+MWas8APJT1BK9ewXjzrN5TILv0E10NKr4n9bnNA82ZC1q40k39NGT4ay+mLq
 3UoGbmA==
Subject: Re: [cocci] Modifying BPF map definitions?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2565
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/14e44e1b-e35d-4cc9-ac76-2e4c05c15849%40web.de>

=E2=80=A6
> Specifically, I was trying to modify BPF map definitions, and I encounte=
red an issue when applying a patch:
=E2=80=A6
> The error I get is:

How do you think about to share any additional information as text
instead of linked pictures?


>     Can you provide any guidance on how to properly match and modify thi=
s struct in Coccinelle?

I observed that another transformation approach gets accepted
(also together with the software version =E2=80=9C1.3-00043-gcca22217d=E2=
=80=9D).


@replacement@
@@
 __uint(type,
-       BPF_MAP_TYPE_ARRAY
+       BPF_MAP_TYPE_PERCPU_ARRAY
       );


I am unsure under which circumstances a subsequent software version will b=
ecome able
to generate patches accordingly.

Regards,
Markus
