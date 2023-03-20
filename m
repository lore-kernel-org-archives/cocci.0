Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89435C7618A
	for <cocci@archiver.kernel.org>; Mon, 20 Mar 2023 08:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=nZzY3BD7QJRqfD8f+HPFlGKBWJlajy1Tq6LpJONfNks=;
  b=d17nUSo+i1WCnWK9Ujnt+mZdgeCcxZFyAMDBj1UlfF8EBrKB9CSmsY72
   NJBk6/ytuXg/Ub1QYkHhC6qKUs7ImkeCIrqcckzhoCnEMMX6sCNyuP4BN
   Q93jy6IkTQYKGhq3o9nKJidJgCH+h52iFrm4pHuEB6MX09Qk0pcwH/pth
   A=;
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
X-IronPort-AV: E=Sophos;i="5.98,274,1673910000"; 
   d="scan'208";a="98014511"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Mar 2023 09:55:37 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E7345E0D30; Mon, 20 Mar 2023 09:55:36 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 428BBE0A9B
	for <cocci@sympa.inria.fr>; Mon, 20 Mar 2023 09:55:33 +0100 (CET)
IronPort-SDR: 64181f84_KlR9JWK5Aov0Vs2HSV/uZwdcnQNINvArZC8LdX39fuRPuW9
 EW/Lb0/vllnEHspoc0GSKfAlGDYxYftYLtcVoCA==
X-IPAS-Result: =?us-ascii?q?A0HVAwCqHhhkhwMP49RagQmBT4IudVYvBAtGhFOPCoF3L?=
 =?us-ascii?q?gOEL45mhGeHGD4PAQMBDTsGAQIEAQEDAwE4gVOCcwKFNQIdBwEEMwYOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBGgkXBw4QBSKFaA2CN?=
 =?us-ascii?q?ykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAg06GDs9AQICASMdAQERJgEECwsUBgImAgJXBg0GAgEBgnoBgicBAw4jB?=
 =?us-ascii?q?wwGsxqBMoEBgggBAQaBQAEDAgwCQ5lzHywiU4FeAwaBFC2QOXonD4FVRIE8g?=
 =?us-ascii?q?wM+gmIDgV+DWIJnjW2LHAqBNHWBIA6BPYEEAgkCEWuBEghrgX1BAg1lCw5yg?=
 =?us-ascii?q?UsCgVklBA4DGSsdQAIBCzs6PzUJCyEGWGsCLBETBQMLFSpHBAg5Bhs0EQIID?=
 =?us-ascii?q?xIPBiZEDkI3NBMGXAEpCw4RA0+BRwQvXnwKBgEmJJ0JAlJlAiAmxSo0B4Iog?=
 =?us-ascii?q?VWBWQyKDJUABhMulwgOBpIjLocgDZAPi2OBb5UmhSKBeCSBXDMaJIM2TwMZD?=
 =?us-ascii?q?445hAyBC4NWimZANAI5AgcBCgEBAwmFRgEBhXsBAQ?=
IronPort-PHdr: A9a23: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
 rAne4rsJT0E/9+GpKMh
IronPort-Data: A9a23:A9+5WKsVTXKmNOrJeEJ0amyw6OfnVFpaMUV32f8akzHdYApBsoF/q
 tZmKW/SPa6NZWf1f41ya460ph4P7ZSEzNMyGQM/rHgyF3kUgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTrSCY0idfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbyRFu8pvlDs15K6p4GhB7wRkDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNz94X2mVTKlLjFVDmZkh+A8BOsTAezsAG6ZvXAdJHAathZ5plqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJHN1fqIi1/YmO2Fl9
 v5FeGojP0veuP3jldpXSsE07igiBMzsIZ9ZpXxqiz3UZRokacqaGeOQv4AehWp23aiiHt6GD
 yYdQR9mdhfdeFtiPlkNCZQxtPiljD/zflW0rXrI/fRquDmCkmSd1pDCL4X2RZ+4b/wShxa1o
 D/3pDmjXzUVYYn3JT2tqy/w2LaWw0sXQrk6H7qz/f9Cm0yW3mVVCRsMVFL9r+PRt6Klc9dYN
 lBS5Sck66Q/nKC2cjXjdy/741G+kw5NYdp7EO9nuFujm/GJ3BnMUwDoUQV9QNAhscY3Qxkj2
 VmIg87lCFRTjVGFdZ6O3urN82jjaED5OUdeO3ZeEGPp9vG++Nlbs/7Zcjp0OIiR5jEfMQP93
 T2MpiUkiLgV5SLg//nkowqvb96EgJ/TUg59zB/eVGuj8mtEiGONYou19R7E4PwGIIvxori9U
 JosypH2AAMmVMDleMmxrAMlQunBCxGtbWy0vLKXN8N9nwlBAlb6FWyq3BlwJV1yLuEPciLzb
 UnYtGt5vcEMbSH3NfEtPtztV6zGKJQM8/y6CZg4ifIRPfBMmPOvp3EGibO4gj2xzxV1+U3BE
 c7ELZfwZZrlNUiX5GPrG7lEiOFDKtEWnC2KDZH90xm917eCLHeaIYrpw3PeBt3VGJis+V2Pm
 /4Gb5Xi40wGDIXWP3eLmaZOcwFiBSZhWfje9ZcNHsbdeVUOJY3UI6SMqV/XU9c5xPs9eyah1
 i3VZ3K0P3Kl3yyecF/XMi08AF4tNL4mxU8G0eUXFQ7A8xAejUyHtc/zrrNnIuF1x/8p1vNuU
 fgOduOJB/kFGHyN+C0QYdO55MZufQiiz1DGdSe0QikNT7g5TSzw+/jgYlTO8gsKBXGJrscQm
 eCr+T7aZpshfD5cKvjqRsih9W7sgkhFqtlOBxPJBvJxZHTT9JNbLn2tr/0vfOAJBxbx5hqb8
 Ae0WiUnhPT/jLI01PLrhqm0iZijPMUjP0hdHkjdta2XMwuD9EWd4IZwasS6VhGDa3HR54OZe
 vRz8/HwFNYljWR6mdNwPJgzxJ1v+ua1gaFRyzpVOUnibnOpO+tGGWaH18wejZ997OZVliXuU
 33e5+QAH6uCPf7kN1sjJAAFSOCn/tNMkxnw6cUFGmnL1BVVzpGmD3oLZwKtjRZDJoRbKIkmm
 OctmPAH4jyF1yYFDIy0sTB2xU+tcFowC74qp7MLMr/N0wAL8GxPUbbYKy3x4ayMVelyD1kXE
 meUqZfG1pthxRvkUnssFHLy8/JXqrYQtTtrklITBVS7teDUp/0w3RELzzUTSz5R7xRY0tBcP
 npgGF11KJ6voRZppplndEK9Fz5RACa2/hTK9GIIs2nCXWyEa3foLlBhCd2S/UsczX1QTgJb8
 J6c1mzhdzTgJ+P14QcfRm9nrKbFYeFq1wifhv2iIduJL6M6bRXhnKWqQ2gC8DnjIMEpgXz4t
 ftYx/lxZYL7JBwvjfUCUafC7ospSTeAOGBmatNi9vlQHWjjJReD6QLXIEW1Is5wN/jG9HGjM
 PNXJ+VNaUWa9D2PpTUlF6IzM+dKvPo21uEjJJLvB0A76oW6kBQ4kajt5hDfhXAqSepAicwSC
 J3cXBPcH32yhUl7oX7srs5FMFXpONUvOVbO48Gowso0FrYokuJlQWct2JSa4lSXNwpG+UqPn
 QXhPqX58c1r+b5OraDNTJpRIhqSKMzhcci16yWxjoh+VszOOsLwqA8lkFnrEABIN783Wd4st
 7CynPPo/UHC5pAabnv4nsSfKqx3+smCZupbHcbpJn18nyHZesvN4QMGyl+oO65yj9JRycm2d
 TSWMPLqW4YuZO5c43lJZwx1MRUXUf33Z5i9gxKNla2HDxxF3DHXKN+iy2TSUlhaUS02aq3OU
 lq+/77k491Dt41DCSMVH/wsUdcyPFbnXrBgbNHr8yWRCm6zmF6Zp7/+jlwa5CrWDmWfWtPPi
 X4fqsMSqDzp0E0J8D1Yj2C2lhgQEWo7nuQ6OE4QkzKzZ/ZWE0ZeRdnx871fYn2XrsA2/I71b
 nfBYQPOzA3jCC9cf0yUDMvLB2+i6y9nBjs9DiMk9QWYZk9awW9G7KRJrk9d3pu9RtcvICxL5
 z3TFr0c8yVdGq1UeNs=
IronPort-HdrOrdr: A9a23:TrKkoqwZK/WsOjD7jkJEKrPw+L1zdoMgy1knxilNoNJuA6mlfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebnN5DNB7foSjjPIceoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,274,1673910000"; 
   d="scan'208";a="50653996"
X-MGA-submission: =?us-ascii?q?MDHBCu/MvIuJDGcHwG+RBGqMPNnh4psRBdCFlY?=
 =?us-ascii?q?YY0U/9VJaffQTPM6aRuhDXUQsyflNthyL7TyAVjHkePVvsg4zTqXtXJ8?=
 =?us-ascii?q?GzgkhhCPhs8I0tRKD6cVmzlZXq+pgQ23Sgtoi+3uf4Qdt8G8Xdgysq7a?=
 =?us-ascii?q?PiM/jXGmbpwfsTViHUl19RIA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 09:55:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679302528; i=markus.elfring@web.de;
	bh=nZzY3BD7QJRqfD8f+HPFlGKBWJlajy1Tq6LpJONfNks=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FPvIB6rvsGw1rOGRHL9E3Z30Adi4+YyGVbySOyvGsYajOG32HtVSKd+p2rkRzdmFe
	 qZNOtIMnPrwaieZ0Vg1XOST/DSuxExC7+KVDdMnTEHnzctydnAyU2RQ/bNN/0WP/N/
	 iXjIv9qtaOvXdV7b5yQZkK4c+R3vDoHthVVak8dQUTJ3lMd3+/tQuLLdgk5YkevwLP
	 u2lItcYArh+7Lx/pTGS24lPeeaosnBJQuYD4n3syQMb/RHLSdCtRZgFpOxG6D3HHD2
	 zCm9khPlO2bdsxy708fbjfkvp2lS5+Yh6IpxGed9FSSIzWUo014xnRdMAepAEhvdCj
	 h7XAEFQ+y4VTw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZjEJ-1q2BRn0QfX-00WjqX; Mon, 20
 Mar 2023 09:55:28 +0100
Message-ID: <9a73c360-4e07-69f8-64ec-d2229ad0d847@web.de>
Date: Mon, 20 Mar 2023 09:55:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org,
 Hillf Danton <hdanton@sina.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, cocci@inria.fr,
 LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <521b63e1-9470-58ef-599e-50a1846e5380@web.de> <ZBffPEIWcmYcaXR3@google.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZBffPEIWcmYcaXR3@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ui779he3IjZg8fFz+smKsb2NdH2uZDPcl1XVnaY0HOy2b1+sQ8M
 AJzbzFUeztTVIrITFm8K+CTgMXWu2Zeiwu0ARHuEgQKPKDSwt3cQnqQV6RmVPSahZH/r161
 +YSlIYWs8ZVkfAFU6t3fgOqPqKF0NomzBUXmUiS7gbx0iV2pVdZzdsTbAVMHjr/+OWFKTAy
 ojXONUnTs1i8IA/6/tPMw==
UI-OutboundReport: notjunk:1;M01:P0:JX/a9P2gA68=;6LQG6QJEC5iSdwJ14TopWwoVpmI
 VATHSweBnWHRvGKHJ0XIWCI3bDj3cflX7CNBtLaVo1NSFiPU1+teZyO4mpUwOiIeh9BvpNh+u
 EKsBG+ft4aaNWLcdBeTn1OTPhJbFXQfgx0nmzIiiCL/M+u4pORRNALmfM0XDmnewcQMrEuJXf
 Cj/a9AtwI8OHW4T7QULnnj4DXJnP73C92zMy29gunFY5E3S/7KF+Qv/fB3+V4BroB2ra+TmJk
 /EYcb+y/lbLegr5SvWrKhGQT5x1JXso2muHQwhxFqOXSn+QY0hvXPR7CzY+5m2DoumHPa3Nb2
 AQ9Cwio57/3PG7VqZ+GRnCxB1VQkR360S4yh+vgNrgo/cX2xU3jrxg4/pQqKg9VriJIINs+os
 Ez9p8kvbiMpJQUcoqxGr6+ZPrIKuiZothxaRYNFRpJ4Y5dCzJHeP/dsAgn/JfXLUjumGkTnfJ
 XFHydFwVRYcMOSJbb71azQVq4B+tzCS1AZtU5NQGYyK+/zTLmWl/B5GOFYQXORL5Hb4AcHLMW
 InHJxkmkrhYElReYDmf22R5IEcSThu+f44P8twpj2Fe5WZ1q+E1EMNd1tfTHP5pFmmXo61hen
 QCqcTD77fnRYKRaICvIsNVF7Tp7iD0B2+JP6b7Zxtk4+lyzMotcq6m93Y/tHFMne6zNb4EPGY
 zQZ9sU5BaFKJ6kR0pWyQtpTu7s3Y6U5gGI8vpeC4OO7UhEv07D83+ymX8rzWyG1a2fTp2Ex8H
 MOdT+PwIT2MjGIBKY8LpEHmJDkRUEc2TW4heO/ak8bLGRmQdm9ih+eaC6aR2qV7c8yTW4ov9u
 DS74taqQTzmAEOKl4nWAVo1GmhzMcKyjFqyVs8cu4IUEMrKLE4Xr3a4yMaRk/7rCHIXFmChrQ
 hOEqNd3ZOVRBnZGqAUO/CfwY4lu/AuHFUTh4ScHXSsmxKRGzcU9qgbaukhSRSMgfprB++BDop
 XC4fQw==
Subject: Re: [cocci] [PATCH] Input: iforce - Fix exception handling in
 iforce_usb_probe()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 903
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/9a73c360-4e07-69f8-64ec-d2229ad0d847%40web.de>

>> Date: Sun, 19 Mar 2023 18:50:51 +0100
>>
>> The label =E2=80=9Cfail=E2=80=9D was used to jump to another pointer ch=
eck despite of
>> the detail in the implementation of the function =E2=80=9Ciforce_usb_pr=
obe=E2=80=9D
>> that it was determined already that a corresponding variable contained
>> still a null pointer.
>>
>> 1. Use more appropriate labels instead.
>>
>> 2. Reorder jump targets at the end.
>>
>> 3. Delete a redundant check.
>>
>>
>> This issue was detected by using the Coccinelle software.
> I am sorry, but I do not understand what the actual issue is.


* Would you find a duplicate pointer check questionable?

* Will you become into the mood to adjust the usage of a single label like=
 =E2=80=9Cfail=E2=80=9D?


> The fact that come Coccinelle script complains is not enough to change t=
he code.


Can you understand the corresponding clarification request better?


Reconsidering repeated pointer checks with SmPL

https://lore.kernel.org/cocci/f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00017.html



Regards,
Markus
