Return-Path: <SRS0=prLC=PX=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFD1C433F5
	for <cocci@archiver.kernel.org>; Thu,  4 Nov 2021 07:12:31 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D099561053
	for <cocci@archiver.kernel.org>; Thu,  4 Nov 2021 07:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D099561053
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3AYXKYgqCkZkYe1xVW/zjiw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fBgHo1WsggWAFzmoeUTyAMq6IMGWhfYx/bo3j8k4E7JOAx9UxeLYW3SE0HigS8?=
 =?us-ascii?q?aIpJvzAcxyuZ3vKRiH7ofMOA/w2MrEsF+hpCC+DzvuRGuK59yAljPnUHuOU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+6UzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j82G9a?=
 =?us-ascii?q?9m/D6dFcLS/jcJ2BiiFIPAfjk00ME/3JolP9lbJLwam8O49mNt9t2w95M8JuvT?=
 =?us-ascii?q?wozFqzKguUUFRdCe817FfQXoeWffynXXcu7iheun2HX6/5pB0o3FYQC8eZ2H2x?=
 =?us-ascii?q?Us/8VMjYAalaEne3e6Li6UfJ9iMoLI8ziPYdZsXZlpRnSCvsgTJbrTKDD5Nse1?=
 =?us-ascii?q?zA17uhCFPCYZYwGaD5rbR3FeDVAP14WDNQ1m+LArnX2bTxUs1WTqaQ450DcyQV?=
 =?us-ascii?q?w1P7mN9+9UtCHA95Sg1SR4GnB5Wn/HhAcHNOawDuBtHmrg4fnljjmXIYDPLK/8?=
 =?us-ascii?q?fFujRuYwWl7IBcbU1a3oPqlok6zWtRSbVYT8Sk1xYA58EusVfH/Xxa8p3mf+BU?=
 =?us-ascii?q?bXrJ4H+Q86QyJjK7Z8Q2QAG8sSj9HYcYh8sgsSlQC3V+Tnsj1AiRv9reSRHKY6?=
 =?us-ascii?q?b6QoT6oESwUK2UDeWkPSg5t3jVJiOnflTrXVNFvVaq0lcH4Aiypk3aLqjI/jvM?=
 =?us-ascii?q?dl6Y2O2yA1Qivq1qRSlLhH2bZPjnqY18=3D?=
X-IronPort-AV: E=Sophos;i="5.87,208,1631570400"; 
   d="scan'208";a="1912069"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Nov 2021 08:12:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CC6FCE0295; Thu,  4 Nov 2021 08:12:19 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1CE4EE004C
	for <cocci@sympa.inria.fr>; Thu,  4 Nov 2021 08:12:18 +0100 (CET)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=Markus.Elfring@web.de; spf=Pass smtp.mailfrom=Markus.Elfring@web.de; spf=None smtp.helo=postmaster@mout.web.de
IronPort-PHdr: =?us-ascii?q?A9a23=3AsVg9ahR3Lrwx9knNxNK5DAfSGtpsoteYAWYlg6H?=
 =?us-ascii?q?Pa5pwe6iut67vIFbYra00ygOTBcOKsrkZ1KL/iOPJYSQ4+5GPsXQPItRndiQur?=
 =?us-ascii?q?oEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZ?=
 =?us-ascii?q?vJuTyB4Xek9m72/q99pHNfwlEnj6wba59IBi2rwjaq9Ubj5ZlJqst0BXCv2FGe?=
 =?us-ascii?q?/5RxWNmJFKTmwjz68Kt95N98Cpepuws+ddYXar1Y6o3Q7pYDC87M28u/83kqQP?=
 =?us-ascii?q?DTQqU6XQCVGgdjwdFDBLE7BH+WZfxrzf6u+9g0ySUIcH6UbY5Uim54qx1VBHnl?=
 =?us-ascii?q?jsINz8h8GHWlMNwir5boAm8rBB72oLYfZ2ZOOZ7cq7bYNgUR3dOXtxJWiJCDI2?=
 =?us-ascii?q?zYIUAAfcfM+ZWr4fypUcBoxSlCAmwHePi0CNEimP40KA41ekqDAHI3BYnH9ILq?=
 =?us-ascii?q?Hnaq8/6NL0RUeCo16nD0DrNb/dY2Tfn6YjIdB8hquyLULx3a8XR00ovFx7ejlm?=
 =?us-ascii?q?KpoLlOz2V1v4Ms2id4OptTuyuhHA8pA1rvzeg2N4hh4/UjY0a1l7K7z92wJopJ?=
 =?us-ascii?q?dKmUk57Z8apHZRNuiyVNIZ7QN4uTn9ntiskyrALp5C2cDYExZkm2xLSaPKKf5W?=
 =?us-ascii?q?U7h/9W+icISp0iXZndb+jhxi+7Eitx+PyW8SyzV1ErTJFn8HSunwQyRDf8NaLR?=
 =?us-ascii?q?uV/80u7xDqC1Rrf5vxaLUwsl6fWKIQtz7E0m5YJrEjPAiD7lF/1gaOKcEgv5/K?=
 =?us-ascii?q?m5P79Yrr8o5+RL490hR/6MqQpgsG/BOM4MhUSX2SB9+Wzyqbs8VfkT7pUlvE2k?=
 =?us-ascii?q?6/Zv47GJckDuKK1HhFZ3pw95xqhDTqqyskUkHsdIF5YZh6Ll43pNEvPIPD8A/e?=
 =?us-ascii?q?/mVOskDJzyv7BJLLhGJbNLmXYkLv7crh970BcyBAyzdBZ6JJZEb8AL+zoVUPrq?=
 =?us-ascii?q?dPXEAc1MxaozOb/FNV9yoQeVHqTDa+eLKzdrV6I6/k0I+iMYY8VoCzyJ+Ik5/7?=
 =?us-ascii?q?ol385mEUScbOn3ZsNcHq4BOhpI12FYXrwhdcMCWgKvg8jTOzujF2NTyRTam2zX?=
 =?us-ascii?q?qI94zE0E5imAp3ZSoCshryBxia7EYdMamBIEFCGCW3oeJmcW/cQdCKSJddskjg?=
 =?us-ascii?q?eWrmvUYAh0RWuuRT7yrpmK+rb4TcYuoj52Nh04e3TjxAy+iZuA8STyWHeB11zy?=
 =?us-ascii?q?0EVQz4/lIR2vkV5zh/X07V8gvUeEdVM7vdNegY8L5/VieJgXYPcQAXEK/KAUlW?=
 =?us-ascii?q?7WZ2LBT8rT9Q+i4sralx+Bs7koxTNxSusDJcKmrbNCJFiofGU5GT4O8sokyWO7?=
 =?us-ascii?q?6ImlVRzB5IXbQVOY4Zg+gKVC4Obyy1xeI61eK5a0COfrQ9rLEKLu1xEFhF9W+P?=
 =?us-ascii?q?JUCJHDnY=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ArYUQaakoZHZ8OrrI1FuuRiOuBprpDfIr3DAb?=
 =?us-ascii?q?v31ZSRFFG/FwWfrDoB17726XtN9/YhodcLy7UpVoBEmzyXcX2/hzAV7BZmbbUQ?=
 =?us-ascii?q?KTRelfBMnZogEIcBefygcp79YHT0EIMqyWMbEVt6vHCXGDYrIdKY68gcWVuds?=
 =?us-ascii?q?=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BhAAASaxphhwwR49RaHQEBAQEJARIBB?=
 =?us-ascii?q?QUBQIFIBQELAYMMbDoxhEePSYF3MIQYhlaGcIwGCwEDAQ0+AQIEAQGBbIJ1AoJ?=
 =?us-ascii?q?rAh0HAQQzBg4BAgQVAQEFAQEBAgEDAwQBEwEBAQwNDgg6JIVoDYI1KQGDZAECA?=
 =?us-ascii?q?gEjFQgBAREmAQQLCxoCJgICVwYNCAEBgm2CVQEDDiWnd4ExgQGCBwEBBoRrHyw?=
 =?us-ascii?q?iUIFaCYEQKgGNcicQgVVEgTyCTjA+h1uCZIUmAYIWvhEtB4IAgSuBNwucewYUJ?=
 =?us-ascii?q?oNTkXYOBpEYu1aBdoF+MxokgzhQGQ6OIBmEDIosQDI4AgYLAQEDCWwBAYkHAQE?=
X-IPAS-Result: =?us-ascii?q?A0BhAAASaxphhwwR49RaHQEBAQEJARIBBQUBQIFIBQELAYM?=
 =?us-ascii?q?MbDoxhEePSYF3MIQYhlaGcIwGCwEDAQ0+AQIEAQGBbIJ1AoJrAh0HAQQzBg4BA?=
 =?us-ascii?q?gQVAQEFAQEBAgEDAwQBEwEBAQwNDgg6JIVoDYI1KQGDZAECAgEjFQgBAREmAQQ?=
 =?us-ascii?q?LCxoCJgICVwYNCAEBgm2CVQEDDiWnd4ExgQGCBwEBBoRrHywiUIFaCYEQKgGNc?=
 =?us-ascii?q?icQgVVEgTyCTjA+h1uCZIUmAYIWvhEtB4IAgSuBNwucewYUJoNTkXYOBpEYu1a?=
 =?us-ascii?q?BdoF+MxokgzhQGQ6OIBmEDIosQDI4AgYLAQEDCWwBAYkHAQE?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="398193627"
X-MGA-submission: =?us-ascii?q?MDF+zxTmOiROthdjFRg3JlFVkwY8n/BAC+v2Fd?=
 =?us-ascii?q?NcNWOhnkjOAXbn57O+9lilPHI+02y/7FlI7byce4s5BSPUlPVDdiRmzs?=
 =?us-ascii?q?qnpXW3XV4+TJ+ZadNiAj4XI8lum2zQ3OwfSCTrjLa4UUfkIzZLuDucE+?=
 =?us-ascii?q?oAe4Nzd4Z/qW6EBj74nGbPDg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 08:12:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1636009935;
	bh=YvlUFkpMWF4xvwhiUcSKYH3gn3+AWuh0Ap09L40Sb3c=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=F/+mbtzJJIVEbHT1UdB7EPHmnHasimSrJQUjvCKKgFhw8iw837jnibrrwcsEHnIYO
	 Bi0kjKCBSo/CGa69S1+M+l8i/ts26ZjuWfVqBbgPBsQwlk4Y33AL2OLoa9W8IkmTW3
	 7QoqG2q3nxy8LVZ22UW5q8Ucba9v5G2Woxrcyl9A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.104.80]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LqlWY-1mD3in2pec-00eM10; Thu, 04
 Nov 2021 08:12:15 +0100
Message-ID: <43ac12d4-b25b-122f-a69e-0c43886ad69b@web.de>
Date: Thu, 4 Nov 2021 08:12:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
References: <20211103124001.68e76017@kicinski-fedora-PC1C0HJN>
 <alpine.DEB.2.22.394.2111032134360.3289@hadrien>
Cc: cocci@inria.fr, Jakub Kicinski <kuba@kernel.org>,
 Gilles Muller <Gilles.Muller@inria.fr>, Nicolas Palix
 <nicolas.palix@imag.fr>, Michal Marek <michal.lkml@markovi.net>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2111032134360.3289@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oYUF5PYsrLUGu/NEA1mShp+PVvWjwa1aYoSGbxgdPdhCMzPC0Xj
 QNLOPOm702t5NLfgf6NDSOGDJWFuPp9s2w4Hfr/Z5jPhI2CXoTUr072wf5NWsdccVTI1F+k
 /5DcTJGScoBFPx4MOuOzibFDNKJF4EnyJvpe1Yn0S785e/B/0coxVcFbAONHVmfZhT0X9MT
 +s4jFFq64UO2twsUXUW9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Sf9WI9d4wro=:DEcr26LpyjFu11v/rmFIOE
 hUUVl2lgtwaDZhYmj44hCFWAR8La2V3XSGEdM9soeMarI06Y8cPKcdRDHhLUaSrllSlEH1piw
 yxpKDT+kLp+TkMSRS1eKnlcHzCsWvQur27XmXqn4AdroeWlcfMCPkURDkr6aR/K/r5ZMvuLyV
 PChR1LbQttyd599XD28sK/Pjvx7LqdVsV1l0JWWmdQMc/+b5/nkOLrG2W1mawMy6FU2bg1sWQ
 7gabEpry74iPr1YG5728/qK63NJa2y7NXYNzpF/ZLu0MYj/cMNo8VoKA+9M4mbgHNY4N9wjnZ
 mEsZ7XabSRCYvuk/cat+wlL8joyFLb7LWgU5HAM6GDZWmhyvWh7WuyTUQrWZKVr2wj7Q+3LWb
 J6yF32KKKCQb1sg1eO6fh0eY+tthrgDC6HY3NStUlczfeU7Z0rHHiWy9XeX1d3o+9Ud23LsLT
 9u9rcLiJbwI+kXieNIAuS20nQxJeODOpQmPEgfvCbwmPoHm2vBipRI6Ybr5/TOuFiXMxAKH95
 tebgqZuPrZNcsrWSRyuEKizyV+dLYOTxYstyKqgDeTtRTsZqazrJEdq8sgjX46aDWPTVEqU/4
 8GOdv5x2Mfu05eelEtioJtTijzmQ96elNuiZdRnARvwlC8sJqWWcMtDXRg1MXdv6nTf6YUQox
 8HPHqcWyHV3ibsm2mqYCgnXCYUFOBt8eyerzE5RDIhuwVpk10yl4p1H248RtW9t06yHPTZAiZ
 V1exDB7w37id10zodO0MMJ/SdhoKfMlNeoWdOMe/z7iV2gckSBEtf9+IFHu/6bV/L0iAe4MY3
 QxwTiqVTGICQjCwoMm2bNnKtpTuDbTKLy0Xa1gKJ4uGixN80O/qOAJDYLufighEGuzRe/nsEt
 ItOy36YRqgQ+pku5sweJw5hvuKAeu3OIGW0dT0lET3kCcSl6+9XlA5e65DDndqhVmgbbp4vTD
 ylYSOXdtzuFTafUIzw4X0svz/9/uo+xmNruy84ovZ9WwG9BYayztojn45ryF9GzW+sqrny+A7
 auynhc9lNvlijMCe0IXRj/zBlBomOJSdvmCOkuNLMCt+HbM+hNMr1GLExZ54JRhbT0dvb1PNT
 UKE7rBcGqXcmyA=
Subject: Re: [cocci] Best way to run coccinelle in a CI?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 66
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/43ac12d4-b25b-122f-a69e-0c43886ad69b%40web.de>

>> I'd like to run coccicheck on all patches before they are committed
>> to Linux networking trees. Is there a recommended way of doing that?
>>
>> I'm looking for a way to run the checks only on files which were
>> touched and in the fastest way possible..
>
> I had an intern who worked on an extension to Coccinelle to take a patch
> and then only apply spatch to that file.

Thanks for such background information.


> Perhaps I can resurrect that code.

Does anything hinder the integration of corresponding software extensions?

Regards,
Markus
