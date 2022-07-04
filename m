Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4353C43334
	for <cocci@archiver.kernel.org>; Mon,  4 Jul 2022 17:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=RP5HMgXIvpx8/GtxIDaac6oxueNLMd395E7PZ7RQCpM=;
  b=RAHw8g9IdP8EjSklQrqDXCZod5yriFEsDOu7XpmGMOxTsrbyaCT67z9H
   YlqtemgD90H4CBskpxRkCUOa2ZytiFy5nVBbRzKNIMAWthBPq7DZUgUh7
   HtQaqtzg01+99SSIhpyJB6csdgIuDhlqV/ksqg0qk7946wogerOIpdy5a
   s=;
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
X-IronPort-AV: E=Sophos;i="5.92,243,1650924000"; 
   d="scan'208";a="44189904"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Jul 2022 19:17:18 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C50E5E034D; Mon,  4 Jul 2022 19:17:17 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A17F6E0092
	for <cocci@sympa.inria.fr>; Mon,  4 Jul 2022 19:17:16 +0200 (CEST)
IronPort-SDR: 9YHQ0FglSekU3S7m18A9e3g3eNoIrObJOGgSnZv74DNQtgx8EpiOd+SVdvv+npJxIWgpcUqEiB
 YvPrX6U/gmPyIZ3PA2VT4I5vRteISPtgTNz3OthLnwiGmLOMw1GoYpLZv+Gc+4jfFS9fROui4a
 +tL1D+4HFGrBfflZEFviep7pkBmA/I5rvr37hgaCy6vpuuLLsJ++BqsEE7IhqRnhFpnGHznZ9F
 wCIKsiDTbaUpFyYFtS/HN3YO0kN+BZ4sULB4nphc1Po2a1bn2fmVL+TEvpaLK1vuzzD0y2PBQF
 90JL79xpM5PFcX7A3U9guiQ1
X-IPAS-Result: =?us-ascii?q?A0BWAABxIMNihwwR49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBT4IkgVcuBAtEhE6QXzGEJIcOhxyMIwsBAwENPwECBAEBghCCdAKFS?=
 =?us-ascii?q?wIdBwEENBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBDA0JB?=
 =?us-ascii?q?QgKBw4QBTYGXgZkBIFLBIF0CzQNgjUpAYNkAQICASMEGQEBESYBDwsaAiYCA?=
 =?us-ascii?q?lcGAQwIAQGCeYJlAQMNIwesXX8ygQGCCAEBBoRLHywiUoFcCYERLIpehB4nE?=
 =?us-ascii?q?IFVRIEVJ4JTMD6BD4M1g1aCZZouJgQPAxotLxKBH24BCAQDAwcKBTAGAgwYF?=
 =?us-ascii?q?AQCExJNBhwCEgUHCgYVDhQcEhIXDA8DEgMRAQcCCRIIFSsIAwIDCAMCAyALA?=
 =?us-ascii?q?gMWCQcKAx0IChwSEBQCBBEeCwgDGR4sCQIEDgNACAsKAxEEAxMYCRYIEAQGA?=
 =?us-ascii?q?wgvDScLAwUPDQEGAwYCBQUBAyADFAMFJAcDIQ8mDQ0EGwcdAwMFJQMCAhsHA?=
 =?us-ascii?q?gIDAgYVBgICGFYuDQgECAQYHyQPBQIHLwUELwIeBAUGEQgCFgIGBAUCBAQWA?=
 =?us-ascii?q?hAIAggnFwcTGBsZAQUyJxAJIRYGCh8KBgUGFQMhSSYFCjsPKDQ2PCMJHxsKg?=
 =?us-ascii?q?RosCSIWAwQEAwIGGgMDIgIQKQYyAxUGLRUVEQYiARsCm0xxxQ00B4IUgT2BR?=
 =?us-ascii?q?AyeMgYTLYNjknMOBpF6lnUgpyWBeIF+MxokgzdOAQIBAg0BAgIDAQIBAgkBA?=
 =?us-ascii?q?QKOHRkeg26KLT80OwIGAQoBAQMJhUcBAYk8AQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:zEmx+ahWbFx0/5IVkUgHFERDX161fhYKZh0ujC45NGQN5FlHY01je
 htvDzrXbP6MZmegL48lbY+1/RwH65XWm4I2HAE+/y40HyJjpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKieUsxIbVcMpB0J0HqPoMZkxN8y6TSFK1nV4
 4mq/JWDYAbNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 NplsK2rRQATDPXwkroHaydcDRNbbahZ0eqSSZS/mZT7I0zudnzx37NxAUtwMYBwFuRfWzgUs
 6ZCd3ZUMVba3Ypaw5rjIgVoruEqNsr2J8Uyvn96zDfWJekrS9bPTs0m4PcEgG5g15AfQZ4yY
 eICbCYxTzj6fyRqZFQxVJ8YoMKGuSbgJmgwRFW9/PdrvTGKkmSdyoPFO93ecd2iXtRQhk/ep
 2Tc/m2/DAtyHNiW1jOB9lq+h+rFhyq9WYQIFbT++OQCvbGI7mkUFQFQSlax5/W04qKjZz5BA
 0kl4SYpl5pqyEb1VOHDWwOKhS6BoTdJDrK8DNYGwA2Kz6PV5SOQCW4FUiNNZbQaiSMmedA5/
 gLRw4O4VVSDpJXKGSzDqt94uBvvYXB9EIMUWcMTZScoizUJiKcygx7CVN9jCsZZZfWoR22pn
 1hmQAAEh7gSi8oC0an+xV7OhyDEm3QkZgsy+xmRQW+vqA90DGJEW2BKwQiKhRqjBN/IJrVkg
 JTis5bGhAzpJc/V/BFhuM1XQNmUCw+taVUwe2JHEZg77CiK8HW+Z41W6zwWDB43b5hUJmSxO
 hKM5VI5CHpv0J2CMvAfj2WZVJRC8EQcPYi8PhwpRocSM8YqLmdrAgk0PBbJhAgBb3TAYYlmZ
 MvFKJ/yZZrrIf0plXK3QfsQy7km2mg3ygvuqWPTn3yaPU6lTCfNE98taQPQBshgtf/siFiLr
 753apXboz0CAbWWSnSGquY7cAFaRVBlX8yeg5IMLIarfFE5cFzN/teKnNvNjaQ+w/8K/goJl
 1nhMnJlJK3X2SeXd1zQMys+MtsCn/9X9BoGAMDlBn7ws1BLXGplxPp3m0IfceZ1+ep94+RzS
 vVZKcyMDu4RGCvK8XIRYMCl/oBlcR2qgyOIPjakOWRuIcQ/GlaRotK0LBHy8CQuDzassZVsq
 bOX1jTdHcgJSTNkAZuEc/mo1V6w4SMQlbsqDUvFK9VeYmv2941uJ3Cjh/M7OZ9eNhjJgDeXj
 l7EDRAdrOjLgok07NiQ2fHa9dj0SbMmExMDTWfB7LuwOS3LxUaZwNdNALSSYDTQdGLo46H8N
 +9b+PHLNqFVllh9tYchQa1gyrgz5oe0qrJXklZkEXHMYwj5A79sOCDfj8xIq7EL2bJT/we7A
 xrd9t5fMLSPGcXkDF9IeFt7NLvej6lMl2mA9+kxLWX7+DRzouiNX3JSCB/Q2iZTG714bdE+y
 uA7tc9KsAGy1kgwPtCdgnwG/miANCVZAaAgq41cH4LhzAYmkwkQbZvZAy7wwZeOd9QVbhh0e
 GDJ3vKaiuQO3FfGfloyCWPJg7hXi6MOjxYWnlUMEFKEx4jejfgt0RwNqjk6Q2y5FPmcPz6f5
 4SqC6F0GUlK1zJvmdQFQG2mXQ1MbPFcFood1HNR/FA1jWHxPoAOEIH5EfmA9gYV/gqwuxBFq
 aqAxj+NvSnCJanMM+hbZaKhg+PuR5p9+2UuXSxh89utR/EHXNYuvkNiiafkZfcq7QPdSXArf
 dVXwds=
IronPort-HdrOrdr: A9a23:r4U/+K/Z3sxSR9SfF1Zuk+D8I+orL9Y04lQ7vn2ZhyYlFvBw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njbLz9t+ri6GLvDv5ak856Bd3ARV0lYhT0JdzpymSBNLjV7OQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,243,1650924000"; 
   d="scan'208";a="44189894"
X-MGA-submission: =?us-ascii?q?MDEEX+LwdkgURyHRP8R5oEXo+dTfjqreD4l1XO?=
 =?us-ascii?q?+YyMfEtMCDaE0z1lIPv2Fey2EmRO5zGgqbdt8II8K7ZWcOu7l9YzfmHu?=
 =?us-ascii?q?IPfDtpFmmVsDBskZ2A9sCoARLVfZLuR5JWqfoxjqNurirp+voe1HNldD?=
 =?us-ascii?q?0abinQaf8qTel349Bm9CF+oQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 19:17:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1656955024;
	bh=RP5HMgXIvpx8/GtxIDaac6oxueNLMd395E7PZ7RQCpM=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=JdNVkRJvjeDOM4HFkTc7lN0UMEZc8PTTZZmsw1tX+5Fo3U4Phq/WQO9ymbeBuPXtd
	 XdolRbog3dHm9ISpGfbcDxGGgqv76MwU3wpUD6FQoR9nkHUrIHtfDqE5L35luJw5Jz
	 sgHlL3OeF8zrCiPIjHM630I5S7Gbi9DTsRdPSFkY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([93.135.151.96]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6K1b-1nWwIr2i5Z-016RBV; Mon, 04
 Jul 2022 19:17:04 +0200
Message-ID: <0002e8ee-e024-c576-f0e6-908d1734b886@web.de>
Date: Mon, 4 Jul 2022 19:16:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>,
 =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@netatmo.com>,
 cocci@inria.fr, kernel-janitors@vger.kernel.org
References: <AS8PR03MB7603EE9F885BA2573CD56CF993BD9@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <alpine.DEB.2.22.394.2207032345230.23263@hadrien>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2207032345230.23263@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Exnw4bkJmcxwRDjwyFCXymrzVl06cbz1PWiVaYsRDxUb/vHgDck
 dJUj3+tEtqrgqPFcHI/wdlo6gWpqxZBzFIE9jwvH1hWqja3UHps4NQ8Hrf14XLhdFSFEJdZ
 5IVGkkZzp0GGYKRe1fef/yxTIRrAdQFS5foq2LAwfRecXAXzfGd1F4NVANTxLGFytQ3mGx5
 NwM3aaZuY+y7rt9k4LXIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oH0pkaLq7XM=:V/tlgb4BVvNnh70zul0ogk
 /Iftgb7xGjhgbhzS2pMkaVdYhZBq9O9jGsJxkUe56GNUUbThHZRq6otf35KtrFSjTZUbWDUIW
 q8hLL33bf0fd5ErvtlyhW1p0NIDfoKrMwoyBZRf3JgRfceyUVwAZMufcXErlp8+Ymgau/IULw
 pjXpO9pH9WEWAlaDx8VSCdE8LwVUiWgI0F6PtFcyH6A1eSM7TW+MW3/BLnsC2xcIUSslsMolF
 dx8AdDtFOUi1g1ldDLQawvoDCdDf8BxjY+lAxGMnZY65eKifYj1Co9brUcRKYBUgm0/vtZesN
 pSxwEfPuDpYPkLhLABzelWLuF+S6GUG1az8iOeBf+/c7DkTCYv/KXbYd1xw8phUhp6YoSmNPD
 AoQVmkK2sTuBLHCGfiTA31AuXar6C9Bp7xP/WsUSureaKb4PIkcgUuC4BPaxX+VyGCtgrXsGe
 S6287bQMJjnGoYq9LzlPsTz/YKdoh8IyJyyL5nxRyV8mwn/lrmTxLcFVuGpg+jrH/qKNJG3AV
 U7wW3LRpCRKIdYEs/tBZRy6nra85ZZ7qb9quE0bGoFOPvpOOk/ZXpytGzBR3RDHIJbeg5Gq6g
 xZ0RgscYLPO3SbEzcSGXxq3ic7qnA/NrnMOBZeeki0YLhDBi6nq/8qO1wdZDyBsgo/CMOo+m7
 bVFSQaBaYuSnvAPdsmfXKrne07aWGYwER+y18nyTxLF6rRKRTvxrkPcUmem5/PptAfqX6WJs+
 5jaZak+p+5cphv0H8Zf9Y0bx6eTSI/Ix8BdvHYyNYY6slRZUJgSMu7+p4IG540Gy8TMNhLBYP
 qatOyedwKnhQSjLUqNRMO4VZRTK1ej4VYFtUH0SCF2hvw+P67nrSvbjDScBGZ7hNaKJ2IoRnS
 bfriRY1Nknsy8/rI9ej3yOdEwg22Z4DaYwOnGMXNQEOW2rs+gidPZkPEiinQzt/+mLdyFr0L6
 fZbT5UJHb8U0vf2Ig/p0TJPpiJM+/EC9XjG3inldZV5KKcds1VCSxpEhdTjKhx9R9lhis+8Wo
 /XYLPx01xmiSpxo+4FRHeZ1SZc+R38NRpoj1SpYNxkkp6adUnW0cF6Ui2x9OpxfC8xepURumb
 E43Dnx5fVZEOu02x7kdkUkQkv9wuKeL7Zt2AfkTszaHeF2PyDvmZpMz6g==
Subject: Re: [cocci] [v5] coccinelle: Extend address test from ifaddr
 semantic patch to test expressions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 482
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/0002e8ee-e024-c576-f0e6-908d1734b886%40web.de>

>> This change aims at detecting an address test in more complex condition=
s
>> and not only in if statements.
=E2=80=A6
>> v4 -> v5: Change semantic patch to match explicit tests to NULL +
>> improve commit message
=E2=80=A6
> Applied, thanks.


Another intermediate software development result was achieved.


Would you eventually like to care for remaining change possibilities
according to the discussed SmPL code variants?

Regards,
Markus
