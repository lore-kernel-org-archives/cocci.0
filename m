Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D48EC433FE
	for <cocci@archiver.kernel.org>; Thu, 29 Sep 2022 09:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:message-id:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=upChFG9qS/0+HdrOOzrv7KGBfBanjsaZTIUsn/P30hY=;
  b=ibxz8L+RhxcE8ijblIlZymuERXGwO3OJlXkuT1Cn9pX4KkaytnjeupQV
   ZktqVHvZL+mr856CeXmf/K6lYEj5vtJliYpDfb/6uTF43rCiOnkJ8d8Cf
   /k8aXZ30IpBTRfkLoyFIHOP/rLXQNfgez6FWw6dvFia/kOonN3szi87ZS
   c=;
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
X-IronPort-AV: E=Sophos;i="5.93,354,1654552800"; 
   d="scan'208";a="55122693"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Sep 2022 11:40:36 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5EE9EE0241; Thu, 29 Sep 2022 11:40:36 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5F507E0076
	for <cocci@sympa.inria.fr>; Thu, 29 Sep 2022 11:40:33 +0200 (CEST)
IronPort-SDR: 63356810_8FPXhJTpI/hCZhuh6NjyhxsM9UenPDacEGSyUZphDwxIV8z
 d5xnm7BBZjxvMFsGGOLu+fqu4YHSUYHHcDaGCwA==
X-IPAS-Result: =?us-ascii?q?A0DwBwBVZzVjh07ASNlagQmBUYIigQFWLgQLRYROkG8ok?=
 =?us-ascii?q?mWMKwsBAwENNwgBAgQBAYUFAoRsAh0HAQQ1BQ0BAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?wEBBQEBAQIBAQIEBAETAQEBFwsXBw4QBSKFaA2CNSkBg2QBAgIBIx0BAREmA?=
 =?us-ascii?q?QQLBQYaAiYCAlcGJIJsAYJsAQMNIwcMqz+BMoEBgggBAQaETh8sIlKBXAMGg?=
 =?us-ascii?q?REthxWIGnonEIFVRIFIAYJGMD6CYgWBXYNWgmaUfIRKOANEHUEDTTUYAxQDB?=
 =?us-ascii?q?SQHAxkPIw0NBBYHDAMDBSUDAgIbBwICAwIGEwUCAk02CAQIBCskDwUCBy8FB?=
 =?us-ascii?q?C8CHgQFBhEIAhYCBgQEBAQVAhAIAggmFwcTMxkBBTInEAkhHA4aDQUGEwMgb?=
 =?us-ascii?q?wVEDygxaysdGwqBDCooFQMEBAMCBhMDAyICECoxFAQpExItBytzCQIDImcFA?=
 =?us-ascii?q?wMEKCwDCUAHKCQ8B1g6AQQDAhAiPQYDCQMCIoFQNSgFAw0ZJggFIxceBAg8A?=
 =?us-ascii?q?gUGVxMCChIDEw8GKZlJg0yjVY1PknM0B4IbgUWBSQyJZ5UMMwOWYQaSCpcNj?=
 =?us-ascii?q?TyaLYF5IoFbMxokgzZOAxkPjjmDWTOKLT80OwIGCwEBAwmFRwEBhHMBAQ?=
IronPort-PHdr: A9a23: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
 HUmVbJRElA4RKpyNw==
IronPort-Data: A9a23:geMJxqJXEzpc4iy1FE+Ru5ElxSXFcZb7ZxGr2PjKsXjdYENS1jMPy
 zRMUTqCaKmNZzPzf4ojPYvg/R9Q6pWAytExHQUd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6j+fQLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWCfg7+s9JIGjhMsfjb+Uk+5K2aVA4w5zTSW9gb5DcyqFFOVPrzFYnpR1PkT49dGPKNR
 uqr5NlVKUuEl/uFIorNfofTKiXmcJaKVeS9oiY+t5yZv/R3jndaPpDXmxYrQRw/Zz2hx7idw
 TjW3HC6YV9B0qbkwIzxX/TEes1zFfUuxVPJHZSwmfKZ/WHaSTzp/6RnUEATY4NJ/M99GVgbo
 JT0KBhVBvyCr+ex3a79VeRmwMguRCXpFNlG5Tc/l3eAXKxgHsCrr6bivbe02B8Vj9pNAO2YS
 s4XcztpYzzfbhcJNlp/5JcWxrv51yakLmQwRFS9j/AM2G3j7ypI/IfWM8iPRIyqZJVMgRPNz
 o7B1z2kXk9DbYL3JSC+2nalmebLmQvpWYcYDrT+9/hwgVTVyHZ7IBYRXlC6ieKoj1a3HdNZM
 U0dvCQ0xZXe72SuScThGQK1qjiIs3bwRua8DcUE4jOh1pCT5jrIDzQFa2BPOdoPvtcPEGlCO
 kCyo/vlAjlmsbuwQH2b96uJoT7aBRX5PVPudgdZFFFUsoKLTJUb306eF44L/Lud1IWtcQwc1
 QxmuwASqt0uYSMj0qKm4RbYjjjqqpWhou8JCuf/DjLNAuBRPtbNi2mUBb7zs64owGGxEADpg
 ZT8s5LChN3i9LnU/MB3fM0DHauy+9GOOyDGjFhkEvEJrmrzpyXzLNAKvmkjdS+F1/ronxe2M
 Sc/XisOtPdu0IeCMfYfj3+ZVph7k/O6fTgbfqmENoYXCnSOSON31HgzORDJhj6FfLkEyO9mc
 Zadbcu2C3sGQa1opAdatM9NuYLHMhsWnDuJLbiil0rP+ePHOBa9FOlZWHPTMbhRxP3f+m39r
 Y0AX/ZmPj0EDYUSlAGMrdVMRb3LRFBnba3LRzt/KLLSfFE/QzpwYxITqJt4E7FYc21uvr+g1
 hmAtoVwkTITXFWXdl3YWWMpc771Q5d0oFQyOCFmbx7i2GEubczrpO0Tfoc+N+tvvuFy7+9Gf
 99cceW5A9NLVmvm/RYZZsLDt4BMTkmgqj+PGCuHWwIBWaBcaTbHwfLaWzf+1TIvC3O3vPQuo
 rf72QL8R4ECdjtYD83XSayOygqvsUgkhe4oYUrsJ+NXWUTz8bpFLz76oe83LvotdzTC5Gq+/
 CSHDSgIodLip9cOz+DIoqSfvaKFIvBbDGMDO0X6tJGYbTL7+Einyq9+CNe4RyjXDj7Iyf/zd
 NdrwOHZG9xZulRz6q5XMathlIA67PvR/45q9BxuRij3Xg76G4FbAye02OdUvfdw3Z5fgwy9X
 3yP9vR8ObmkPMDEEkYbFDE6b9ashO0lpT3P0csbeEnKxjd73L6iY3VgOxOhjC98LrwsPrg1n
 sYnmsodsDKkhjQQb92psyFz9ka3FEImbZkJjJ8hLbXQulIZ8W0aOZ34IQ3q0a6LcORJYxULI
 CfLpa/shIZ850vlclhoJ0fswNhyuJUqkzJJxW8kOF6mtIfkhPg2/RsJ6hUxbF1f4Stm2tJJG
 FpAFhNKN4CR2Qx3le5/X2yIMCNQNi2zo0De5QMAqzzEchOOSGfIElwYBc+M20Ioq0RnYTlR+
 eCj+lbPCDrFUpn44XovZBRDtffmcN1W8z/CkuCBG+CuPcEzQRjhs5+USVs4kTnVKuJvuxSfv
 shvxvh6VoPjPy1Jo6EbNZiT5Y5NdD+6fl59UdNT14JXO1GEYzyj+ym8G2bocON3GvH620uZC
 ctvG8FxayqDxBu+9g48O6pdDIJ3zdgI5cUDcIzFPWQpkaWShRs3vYPy9hrRvn4KQdJvnZwDK
 6fUTTajE3ORt1RQiWTivMlJAUvmQNgmNSnX/vG5z/UNLL0H6NpTSEAV1qCmmlmoKy5lwk6kh
 xzCbKro0OBS84RgsI/yGKFlBQ/vC9fMeMmX0QK06fJiUMjuNJrQigYrtVXXBQRaEr8PUdBRl
 77WktrW3lvAjYkmQVLihJiNOKlY1/qcBNMNHJrME0Bbui+eVOvHwRgJoTm4IKMUtuJt3JCsQ
 g/gZfagcdIQZcxm+0RUTCpgQiYtU/G9Ku+qoC6mtP2DByQMyQGNfpvt6XbtanodbSMSfYH3D
 gjvofu1+9REt8J2CQQZA+19SYpNSLM5tXDKq/Wq3dVZMoWpvr9Gkr7liAZm9jzBTHWJeCo/D
 VQpWTCmHCleeomRpD2aj2C2lgIaBjBxjIHcu2oDrsVuhWnS4HEudIwg3FZvNn2QujP/3tf0a
 VkhqYfk5TrVBVx5TPk33DgvsspzyADD1hcV6wHFJ3+pVho=
IronPort-HdrOrdr: A9a23:Z5oQxaxYuETNVFQHZLpkKrPw7r1zdoMgy1knxilNoNJuEvBw8P
 re48jztCWE6gr5PUtKpTnuAtjkfZqxz/BICKgqTNOftUzdyQ2VxeJZgbcKoQeOJ8SWzIc0uJ
 uIMZIOceEZyDNB/KHHCWKDYrUdKbe8kZxA/t2utEuEVmtRGttdBupCe3umO3wzeCkDIZYiDp
 KT6o57tyOtEE5nFvhSPxM+LpT+T1anrvjbXSI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,354,1654552800"; 
   d="scan'208";a="24997351"
X-MGA-submission: =?us-ascii?q?MDH+eJz7pgzczh09ZCpIrWZA2Yb4k0ioGe/5mb?=
 =?us-ascii?q?jObopvmPRAcZaQG4oeeNGv2V4pW5ViMV0uu/LjyfbQvpy4WtnFY0demQ?=
 =?us-ascii?q?aPwr34qBxkWU8vwDG5HjDi3JHIgvXfIvT3wqFzl3G0Cv+Q9LUPd+yBBm?=
 =?us-ascii?q?ZJbCPK69arkDdyi43LpsJ5tA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 11:40:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1664444418; bh=upChFG9qS/0+HdrOOzrv7KGBfBanjsaZTIUsn/P30hY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RMscJRoKrGXAXCZXM+WVGJBXFfT6/3gJdYdMuUlJKcODFjdVuAe3reVwHKEVNFiOF
	 tmUVxmaUTlTSx8lcop53H/CH1JA+KlO+1hNhdUMqMWNMjmGEbkvbgc1Ug1yZ04L7V0
	 kZQdDaHLmkQbF4yjCN/7FfONe0b5hlAxZBxd8AjAZ4HDrWGN9kQxqcS9QJXEYferzQ
	 EQ4WKRihkwXH7UYOElec489AcxS3HOHoQuRyqP15bx0zw+MrFSTuzEntCHI6EoeB5o
	 zEdrUYY45KJtuFF9KzNE9s9Xb2MPv4jweXrkOdAqBJ+9rezWvylTqrgKzTJUk7sqQq
	 uUVW0GmDRmZQw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [212.144.252.253] ([212.144.252.253]) by web-mail.web.de
 (3c-app-webde-bap27.server.lan [172.19.172.27]) (via HTTP); Thu, 29 Sep
 2022 11:40:18 +0200
MIME-Version: 1.0
Message-ID: <trinity-756ae022-9de7-4ffe-8296-6e6742928287-1664444418251@3c-app-webde-bap27>
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Yuan Can <yuancan@huawei.com>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Sep 2022 11:40:18 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <92e58a54-fa4a-e726-4613-8c8c7bb79522@inria.fr>
References: <alpine.DEB.2.22.394.2209251906090.3293@hadrien>
 <d9ba411d-2b5d-061e-f985-ff5158b5521a@web.de>
 <alpine.DEB.2.22.394.2209282125470.2984@hadrien>
 <c2f73ccb-8106-7cc4-7c06-9e9eaa8d0638@web.de>
 <alpine.DEB.2.22.394.2209282137030.2984@hadrien>
 <trinity-6a1e80bd-4b4d-40fb-a944-50346c34f58b-1664432497287@3c-app-webde-bap27>
 <59318b60-5c22-e774-6b2c-eb1463681ac3@inria.fr>
 <trinity-83107000-6c16-4ec3-a6d7-11d2bd7cc14c-1664437216657@3c-app-webde-bap27>
 <8076a3d9-6a67-5e48-4046-8f33f261f4bd@inria.fr>
 <trinity-ccfe7d99-bf56-490a-88bf-74fad2b21b9c-1664442456545@3c-app-webde-bap27>
 <92e58a54-fa4a-e726-4613-8c8c7bb79522@inria.fr>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:yfWcdZIlH1oGzDUNiniihKxn3WtYGL/vJgwlgQ3lr1wJXWpKsgOTRVJMdIDBSNU9fcxAY
 6fKmGtkl1unyrtH3/LS6ts3rP2ZKa0mZpTuRLDo7YgaFjSMil0BJMANo2wRlHLZztQ2vk3dqv3BX
 HjxGBS5y96Gb53WsnXx7Id3vu5V+CJ/Jp40zG8h9+jlr0ypjBSXzonP951YZwoarKS1GgYhFvMUD
 0HlSptSV6612MnFj2D/Rq2gIuCmjYkazdLLjRHmSVsO19qhi/A+2TNRdjshbLx5p9LJus7rh0pQU
 bo=
X-UI-Out-Filterresults: notjunk:1;V03:K0:MuI9sXWYeLc=:FzIHREDfrvW/RzJSubuF4I
 cLN4MTxUTzO16Fgp541PkW9My/VpUOOUuVt71mJvZ2TBdRE1U+2y7/QJqy421oPK9ZTbtqmSJ
 3mZRKKhi/5JE6pDKf6DG9rc+uOBB43e2apCKhEoCCiFq5uFBTcBlSwbyqkCFVPY9jemrIgxyW
 jHUB8d93/tPpFFYaSF59xKfiamKaJpHGnUDUr9z6VQvCcpCpSZ2Jt6efshNwcFpk4FZQyzi5y
 Ttwu4vLgbIgmcrtpKtSRHx5m9qN069hrYuv+eq1l65HjjlV0uiTHUEUg7MoDkDnmcxx/CJKnV
 h4Vh85j934O99YNCb2gaSzuEFrkwfxQE/CrSDluLgMCjj3EByWVhftcyaxknDDYZkGy/+GpeA
 C9iSoN8+H99qO1iHTD1OPGBbS57OEPVaMBg2zW43jcdo2AKg0Flv3WRMop4NYNhEUt3Vp5Lcj
 jQW0sGFeGz6rFT+gnNErhqt0dZUIyaaVLfVdUKCDlqmg9SECi1TC4Ot9EPXEAVXPFp9n7P98x
 CKJKlBFyqsfbRPSV81Mx0I6QTyxUOlnJhiuz0XWZ/8V8azBBTP/tUVFzR2K84irpJOtI28NGu
 g3kqna16SP6a7YutbOZr5nSi+ralSXdATgx+8ll9kdVOtHVA75dq/UNCJxhYXD9RfV0qMrHQU
 pMuSDTEBzNq7UbwevhmV4v2F2hXM4yNShszENRuNvG+eLBOMzNRiUtz/cLWJFItZcZvhepL+I
 037tHDr+ND7M4H977lLjSoGxuLmao0TLJOprYQiwrTi4jZUbv0lOUDDeBCPkPh2nsUC5VZi0j
 PhebxGZ
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] Checking the usage of locks with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 608
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/trinity-756ae022-9de7-4ffe-8296-6e6742928287-1664444418251%403c-app-webde-bap27>

> > > > How would you like to improve the desired scope (or name) resoluti=
on further?
> > > > https://en.cppreference.com/w/c/language/scope
> > >
> > > What is wrong with it as it is now?
> >
> > I got the impression that the representation of corresponding scopes i=
s still unclear.
>
> There is no real representation of scopes in SmPL.

Thanks for this information.

* Will it trigger further development considerations?

* Can the handling of scopes be an essential functionality for safe source=
 code analyses?


> But the type inference does not rely on what is expressed by the semanti=
c patch.

Such a feedback is promising.


> It just looks at the C source code available and does the best it can.

Corresponding data processing approaches will evolve further, won't they?

Regards,
Markus
