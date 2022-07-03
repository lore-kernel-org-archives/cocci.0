Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13160C43334
	for <cocci@archiver.kernel.org>; Sun,  3 Jul 2022 11:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=jqoJdJCmc5Ka2LTlMpgx/JCPU4tulxRY+1wz1v7GNmY=;
  b=WKKKERCj1GZvuVpNQOfmEmypDZwv6qSiv1qioDfW41p1JYndGeExYxwB
   O+PoFwPbwRaf9CqjQT3Uz6IBo9DY8k+yEd0ZLcPrP51ZlW7JdDSb8dDPd
   dNhwWokGOlXoWF6WtYoZQWzd/e1Bw4B25/NVNBOjA43VZzmKhmyFfctxB
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.92,241,1650924000"; 
   d="scan'208";a="43984579"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Jul 2022 13:34:46 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D481BE015F; Sun,  3 Jul 2022 13:34:45 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CDD7BE0092
	for <cocci@sympa.inria.fr>; Sun,  3 Jul 2022 13:34:43 +0200 (CEST)
IronPort-SDR: v9MspTYl9nmoyBR/phCm+8L8iAEzJawkhTsYHv2Vjy+V2B/ZAF4ofzI5Jbfnb9OrjzO0fYhrOy
 aydSw3zMC5wv+tL9cBuQw/x2yR9FQz4byvx9LBiMxP0DqklzkmQQ+uXhCBM20E6GiRu1HBfP43
 6g0QtWdMDQpIPGOqLN8VqKxFBtab0GeFK0MlDqQvi3OUArrNNryy67JT7U6CYFMSpyt6goLsHp
 0VO1m75OYUXNZ/hPtGxb8PFBZwv68E9cXCvYdZoFoHIF99zPqOjPU+pTL6Fg1klO18F7/1+jV5
 tJ3kyf9aWn9Y4/AGsw0iPMAZ
X-IPAS-Result: =?us-ascii?q?A0ApAADbfcFihw4P49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFPgiSBVy4EC0SETpBfMYQkhw6HHIwjCwEDAQ0/AQIEAQGFB?=
 =?us-ascii?q?AKFSwIdBwEENBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBD?=
 =?us-ascii?q?A0JBQgKBw4QBTYGXgZkBIFLBIF0CzQNgjUpAYNkAQICASMdAQERJgEECwsaA?=
 =?us-ascii?q?iYCAlcGAQwIAQGCeYJlAQMNIwesZoExgQGCCAEBBoRLHywiUoFcCYERLIpeg?=
 =?us-ascii?q?yR6JxCBVUSBFSeCUzA+gQ+DNYNWgmWaLiYEDwMaLS8SgR9uAQgEAwMHCgUwB?=
 =?us-ascii?q?gIMGBQEAhMSTQYcAhIFBwoGFQ4UHBISFwwPAxIDEQEHAgkSCBUrCAMCAwgDA?=
 =?us-ascii?q?gMgCwIDFgkHCgMdCAocEhAUAgQRHgsIAxkeLAkCBA4DQAgLCgMRBAMTGAkWC?=
 =?us-ascii?q?BAEBgMILw0nCwMFDw0BBgMGAgUFAQMgAxQDBSQHAyEPJg0NBBsHHQMDBSUDA?=
 =?us-ascii?q?gIbBwICAwIGFQYCAhhWLg0IBAgEGB8kDwUCBy8FBC8CHgQFBhEIAhYCBgQFA?=
 =?us-ascii?q?gQEFgIQCAIIJxcHExgbGQEFMicQCSEWBgofCgYFBhUDIUcmBQo7Dyg0NjwsH?=
 =?us-ascii?q?xsKgRosCSIWAwQEAwIGGgMDIgIQKQYyAxUGLRUVEQYiARsCm0vFfjQHghSBP?=
 =?us-ascii?q?YFEDJ4yBhMtg2MSjEOGHg4GkXqWdSCnJYF4gX4zGiSDN04BAgECDQECAgMBA?=
 =?us-ascii?q?gECCQEBAo4dGR6DbootPzQ7AgYBCgEBAwmFRwEBiTwBAQ?=
IronPort-PHdr: A9a23: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
 chXIle+fEM4HLUWBxY9dOE=
IronPort-Data: A9a23:myAHJqvgi3YW+EfYaGK1aCqwi+fnVHlYMUV32f8akzHdYApBsoF/q
 tZmKTyOP6yKYTbxed8jYd63oRwB7MPXz4BmGgFkrS88Qi4VgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTraCYEidfCc8IMsboUsLd9UR38g527BVPyvX4
 Ymo+5KHYwf8s9JJGjt8B5yr+EsHUMva42twUmwWPZina3eD/5W9JMt3yZCZdxMUcKEMdgKJb
 7qrIIWCw4/s10xF5uVJPVrMWhZirrb6ZWBig5fNMkSoqkAqSicais7XOBeAAKtao23hojx/9
 DlCnYKNSR4pEoHoodkiCStdSTNcLbRj6LCSdBBTseTLp6HHW37r3ukoE0w8e4EVkgp1KTsXr
 7pCcm9LN03F3r7eLLGTEoGAguwGJdPoIZhZl3Vu1zDfAt45TJqFT6iiCdpwhWds3pkVQqi2i
 8wxZhtfKz3NID10ZHBUIo1hzN3xoELBSmgNwL6SjfNqvzaKlVIZPKLWGN7cZdWOQe1Hn0OSv
 GuA/mLjAxhcOsb34TGC+XmtrvTemDvyHoMUDryxsPBw6GB/3UQWDwAKE0S2q7+1hyZSRu6zN
 WQKxyo3rYQe0HWWcYPPWkeqgm6dmw4TDo84//IB1CmBza/d4gC8D2cCTyJcZNFOiCPQbWJ7v
 rNut4ywbQGDoIF5WlrBp+/M9mja1Tw9fTNYOnNsoR4tvoG7yLzfmC4jWf5PPcZZZPXWECv02
 CqXrCVWa1470pBSjPrTEbzvqTugq56McaXh/BnLU2ev4xl2DLNJiqSt7kXHq+lNJsCVQzFtX
 UToeeDBsYji7rnUxURhpdnh+pn0t55p1xWC2TZS82EJrWjFxpJaVdk4DMtCDEloKN0YXjTif
 VXevwhcjLcKYib0Mv8pPdjsVZ1xpUQFKTgDfq+KBjapSschHDJrAAkyPCZ8IkiwzBlyyvtX1
 WmzK5/2XC5y5VtbIMqeHrpBj+ZymEjSNEuKC8mzzhK73KCYaWLdQLhtDbd9RrBR0U9wmy2Mq
 4w3H5LSlX13CbSiCgGKr9J7BQ1UfBATWMGuw+QKJ7XrClc3SAkJVaWNqZt/INYNt/oOyY/1E
 oSVARIwJKzX3iGcdm1nqxlLNNvSYHqIhStnZ3FzZgnxgyhLjETGxP53SqbbtIIPrIRLpcOYh
 dFcEylZKvgQGDnB5RoHapzx8N5reBix21CRMiDjbDVmJ8xsQAnA+9nFeArz9XBSX3Tt6pZk+
 +WthlHBXJ4OZwV+F8KIOvih+FOGuyRPkuxFWUaVcMJYf1/h8dQxJiGo1q03LsgAJA/t3Dyf0
 wrKUx4UqfOT8ZA4+p/FiPnc/YuuFuJ/GGtcHnXatOrna3OFozD7mYIZCbSGZzHQUm/w6Z6OX
 +QNwqGuKuADkXZLr5F4TeRhw5U+0N2z9bVU+QJpQSfQZFOxB7I8eXSL0JUdtqBJwbMF6wK6V
 ljWo4tfPqiVftzoGhgdKVN9POiE0PgVnBjU7Og0eRmrunUooeDfCUgCbQORjCF9LaduNN13y
 +kWuPkQt161hC0sP4vUlStT7WmNcicNXvl1rJ0cG4O32AMnxksbOM7ZDTLqpo6CYZNAPxByc
 DOTgaPDgZVax1bDKiZiSyKSgLAF3Zle6gpXyFIiJkiSnoSXjPEA3CpXrWY9QDNTw0gVyOl0I
 GVqaxZ4KKjmE+2EXySfs71A2j2tBSF1PmT0zEYV0nLURQ+kWwQh6YH71fmlpCgkH6B0J1C3P
 410DE76XDyscMyZMu4aRxt+s/K6JTBu3lSqpS1kdvhp27ElbDCjjqLGia/kbff4KZtZuXArb
 tWGMAq9hWMX+MLQT2AG51Gm6Ikt
IronPort-HdrOrdr: A9a23:ANRetKugtlAOki747WfA+yqI7skDUtV00zEX/kB9WHVpmwKj5q
 WTdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDxHZK3BgDVQfexQouVvvJrIuQ/EpU0dNj2ChpsQlTuQM2ygYzBLrIIqP/AEKK
 Y=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,241,1650924000"; 
   d="scan'208";a="18401376"
X-MGA-submission: =?us-ascii?q?MDG11hUtKDhpf3QSbLoHubXy1PBM8Yw80LEpRO?=
 =?us-ascii?q?ztqxcp/2rHbwfpnAiKlleGGyqjbr3xdUTALY4NfL7qLCDqVvqk2qrVqi?=
 =?us-ascii?q?GY6kUoCs64+spcf6nqmrBKv7vgCKIyoadLgHJNxwhb0Hiw2Ei5boTjtY?=
 =?us-ascii?q?9bujLtEBuvI2XZcVkeohdM0w=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 13:34:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1656848081;
	bh=jqoJdJCmc5Ka2LTlMpgx/JCPU4tulxRY+1wz1v7GNmY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IXs1FxJZlpLCy1P5BFFjivO6jCRA7/2y6l/txiNCEiEnt6gJoganowgwAx8X6nC3C
	 E5sx6waSeHT3ACW8PfatnAAX3K9VHmBI8JB+VawSuMiClvjbWLLjfBJQaVXTTrrNcz
	 0u+wlyUgimUNaYHy3cmw/QheS9mu29ogw13dA0Aw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([93.135.75.166]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFauo-1oOwmd0WVy-00HFHa; Sun, 03
 Jul 2022 13:34:41 +0200
Message-ID: <8ec4c66d-a315-5c64-7f7f-f707a175d56c@web.de>
Date: Sun, 3 Jul 2022 13:34:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-GB
To: =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@netatmo.com>,
 cocci@inria.fr, kernel-janitors@vger.kernel.org
Cc: Nicolas Palix <nicolas.palix@imag.fr>,
 Julia Lawall <julia.lawall@inria.fr>
References: <AS8PR03MB7603EE9F885BA2573CD56CF993BD9@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <632c81ca-3d53-4ff5-505e-f8da998e47db@web.de>
 <alpine.DEB.2.22.394.2207011647580.4779@hadrien>
 <51130aa6-1a1b-51fb-c4b7-c0dcda1d78d1@web.de>
 <alpine.DEB.2.22.394.2207021218550.2882@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2207021218550.2882@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TQzGxrW4ER49d6fiY+yrPVkFce4JcLCEdUzpUbjEZiXNNwwGhJj
 fRtLzVYKZ3mOMcHJD9XsLqWvrXuhUZPy5MG2sVZGx7c5wOCKkZ0yJ88JrLzwhy3q4c0/7QS
 V2Kx+2p8iaOD+qM1SWkgz6wP66bCGZN0yDgMoQEuaDZj8GSQxfEwSHpWCiqu688Fm7ZH2ZC
 wKYuv/OE4Upnsz6OAKy8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/4cwpuB6y8I=:Ne2TnNDMxB+n09Dq+pAlQE
 L9u6qeFPBotTDGCN2HVfhkwli3n2iV7qD4ZTI0d2Ujql+LRvf3oUFjdDjS32TNkVi2KOAFg69
 jNVGo2yJroEbg32YUjB/vJqdDf4clpnXSscDPRi/yUJMEqmelVYxJK2TttGFyCgF/4aN9sG5W
 uDhkp4FqEVL2axe2/CUIm6xI+OwUxjTuQREvEo1xQpZcXXwrP03OkNjJaPF/BL9dzEiAECbis
 hB9FIzuV5g3PJIw4m8Vcyeu5ZoMX727iMb07RqhwRtteSWKlO+Stv138FgXbe0igRunnb8h5L
 zAOhzwxASOVxJCbrlY5B1PKITu8rT4vaPASEtDat9zmxTvdFhHDt1LG3baC+708s4xEpZo7iZ
 E2iEEZeFS5uMcnIp1IGYN+g3EMzL383WYateWlSimqKuwAkqILcImkGZtrLbnSalWDQerBCNX
 OMY9uwpASC7TbQ5cf+lOFlEl6ob3B/ZsC9ESQdfnuefva3amKPgPtMEDZOvamOmjy8BytQ28W
 MG0Vnvcb1w/EL2MdKl9s+oOKZaY1kB3kuZkjGSnFTd8Xyfy7p4T1Py0JRFy4FVC9jfqwuWPHz
 2ROzqdN+Mz8C/RW2SReOJ/X+j5iMwNr9RlYfKbbjw+yGP/ZVFK2YB0XpXL8NWkFpPItqIZsYl
 rGGZDEgyDMvJsHfS//8sE8w2sl+cdCSL2P8kunOIgKK/mHt+A+oXMw5QBNe+ehqdzivyux95U
 JZUylKg9tUMHObrKOsQr3PB4PccxHitQylDPRi6DhAsblfNMiPqnLpjCAGXE6zS28lJg3pjM6
 QTM21wcGcnbp0Yh13gt5A9VXJgDeLnNyisyJhSZyUSWSl8HNm5wSElSqrNfmIO6RBoqX26EQP
 +z0sz60wBP4O8nAvRlVVmRXDyx8+K9gujEKHhaSocsJEoeuCAmVzJNfTh2kNxfY0S9LrfhB1z
 0aqMAnkqloAfy2nMqEAkaF38wqk8Jz7dlgqSfRanm1BW4HLPTWLoXZcJM4vPY5J1K5sc8o7nl
 vSis4r3/uKbiznRZv+nb8zIK6cZKbSKUomzMuEv1m8Qk3rwULEsj141pw6qVzvfe7/+XsgaKL
 +K2ufwMlcWYaPCx3Swvioa+YxmyBcJUh4llgaZe1qcCl4bZIBKgC0slTQ==
Subject: Re: [cocci] [PATCH v5] coccinelle: Extend address test from ifaddr
 semantic patch to test expressions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 480
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/8ec4c66d-a315-5c64-7f7f-f707a175d56c%40web.de>

> If you want a feature to be added, ask for the feature.
> But please stop confusing the discussion about semantic patches
> that are proposed by other people.


Would you like to achieve that all basic coccicheck operation modes will b=
ecome
properly supported for a SmPL code variant like the following?


@display@
type t;
statement is, es;
identifier i;
expression x, ix, ex, z;
binary operator bo;
@@
(
*if (&(x))
=C2=A0=C2=A0=C2=A0 is
=C2=A0else
=C2=A0=C2=A0=C2=A0 es
|
* &(x) bo NULL
|
* NULL bo &(x)
|
* !(&(x))
|
* (&(x))
=C2=A0 ? (ix)
=C2=A0 : (ex)
|
=C2=A0t i =3D
* (&(x))
=C2=A0;
|
=C2=A0(z =3D
* &(x)
=C2=A0)
)


Regards,
Markus
