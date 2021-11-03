Return-Path: <SRS0=6LBi=PW=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188F1C433EF
	for <cocci@archiver.kernel.org>; Wed,  3 Nov 2021 11:15:52 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28AF86103B
	for <cocci@archiver.kernel.org>; Wed,  3 Nov 2021 11:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 28AF86103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3ATFktfqBuIo1PvRVW/zjiw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fDFO60mwj1zwOx2odXTrVMvfZMGv3e4snb4ni80MA6JSAx9UxeLYW3SE0HigS8?=
 =?us-ascii?q?aIpJvzAcxyuZ3vKRiH7ofMOA/w2MrEsF+hpCC+DzvuRGuK59yAljPnTHuCU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+6UzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j82G9a?=
 =?us-ascii?q?9m/D6dFcLS/jcJ2BiiFIPAfjk00ME/3JolP9lbJLwam8O49mNt9t2w95M8JuvT?=
 =?us-ascii?q?wozFqzKguUUFRdCe817FfQZqO+ZfSTXXcu7iheun2HX6/5pB0o3FYQC8eZ2H2x?=
 =?us-ascii?q?Us/8VMjYAalaEne3e6Li6UfJ9iMoLI8ziPYdZsXZlpRnSCvsgTJbrTKDD5Nse1?=
 =?us-ascii?q?zA17uhCFPCYZYwGaD5rbR3FeDVAP14WDNQ1m+LArnX2bTxUs1WTqaQ450DcyQV?=
 =?us-ascii?q?w1P7mN9+9UtCHA95Sg1SR4GnB5Wn/HhAcHNOawDuBtHmrg4fnljjmXIYDPLK/8?=
 =?us-ascii?q?fFujRuYwWl7IBcbU1a3oPqlok6zWtRSbVYT8Sk1xYA58EusVfH/Xxa8p3mf+BU?=
 =?us-ascii?q?bXrJ4H+Q86QyJjK7Z8Q2QAG8sSj9HYcYh8sgsSlQC3V+Tnsj1AiRv9reSRHKY6?=
 =?us-ascii?q?b6QoT6oESwUK2UDeWkPSg5t3jVJiOnflTrXVNFvVaq0lcH4Aiypk3aLqjI/jvM?=
 =?us-ascii?q?dl6Y2O2yA1Qivq1qRSlLhF2bZPjnqY18=3D?=
X-IronPort-AV: E=Sophos;i="5.87,205,1631570400"; 
   d="scan'208";a="1788644"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Nov 2021 12:15:49 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4E340E02AF; Wed,  3 Nov 2021 12:15:49 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 114C0E004C
	for <cocci@sympa.inria.fr>; Wed,  3 Nov 2021 12:15:45 +0100 (CET)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=Markus.Elfring@web.de; spf=Pass smtp.mailfrom=Markus.Elfring@web.de; spf=None smtp.helo=postmaster@mout.web.de
IronPort-PHdr: =?us-ascii?q?A9a23=3AB590AhUw9WJHyqBgEkCMn7Re9XrV8KzPVTF92vM?=
 =?us-ascii?q?cY1JmTK2v8tzYMVDF4r011RmVB92duqsP1rWempujcFRI2YyGvnEGfc4EfD4+o?=
 =?us-ascii?q?uJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFAnhOgp?=
 =?us-ascii?q?pPOT1HZPZg9iq2+yo9JDffRlEiCC5bL9vIxm7rQfcvdQKjIV/Lao81gHHqWZSd?=
 =?us-ascii?q?eRMwmNoK1OTnxLi6cq14ZVu7Sdete8/+sBZSan1cLg2QrJeDDQ9LmA6/9brugX?=
 =?us-ascii?q?ZTQuO/XQTTGMbmQdVDgff7RH6WpDxsjbmtud4xSKXM9H6QawyVD+/6apgVR3mh?=
 =?us-ascii?q?zodNzMh82/ZhMN/g6xGrhyhuRJ/zYzbb52aOvdlYqPQf8kXSXZdUstfVSFMBJ6?=
 =?us-ascii?q?3YYsVD+oGOOZVt47zqEEUrRu9GAmsH/7kxDBMhn/4x6060uIhEQ7b1wEnGNwBq?=
 =?us-ascii?q?m7UrNboNKcJS+y7w63IzTvZb/NX3zf955PFcx4/rv6XR75/bNTexFApGgjYgVq?=
 =?us-ascii?q?etZbrMCmJ1uQRrWeb9exgWPquhmMopQx8oyaiy8UxhofJgo8YyU7J+Tt5zog1J?=
 =?us-ascii?q?NC0VVJ3bN66HJVetiyXOYh7TMw+Tm11pis0xL8LtJG1ciUJzpks2h3Ra+SffoS?=
 =?us-ascii?q?W/x7vSvydLSlmiH9nYr6zmhS//VK9xuHiTsW51FhHojBYntTCuH0BzQHf5tSZR?=
 =?us-ascii?q?vdn4Eus2TCC3B3J5O5eO0A7j6/bJoYhwrEukpoTtlzOHirxmEXrkK+abEsl9fa?=
 =?us-ascii?q?z5Oj9f7rpuIeQN45yig7gLqQjgtKzDfkmPgQUQWSX5+ax2Kf+8UD7WrlGk+M6n?=
 =?us-ascii?q?rHcsJ/AJMQboqC5AxVS0oYm8xuxCC2p0M4bnXkaN1JJYh2Jj4znO1HUIfD4C/i?=
 =?us-ascii?q?/jk+ikTh13P/KJKDuDYvVInjZjLjhZap961JbyAcr0d9f4I5bBa0AIP/oQU/wt?=
 =?us-ascii?q?NnYDgcjPACuwubnDs991oIEVm6VDK+ZKvCajVjd7eUkKOikZYkPuT+7JeJ2yeT?=
 =?us-ascii?q?piCockEUeYLLh8J8ZcnG+EbwyBkyDYmf3xPoFH30LuAUWU+HgzlGPB20AL02uV?=
 =?us-ascii?q?r4xs2loQLmtCp3OE9jFaF2p2SCmAttJa2oABl3eSR8Akq2bVv1KZC/AeqeJfRQ?=
 =?us-ascii?q?bWLLnR4JzjHmT?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3At00lXKHcfo+DjsmwpLqE68eALOsnbusQ8zAX?=
 =?us-ascii?q?PidKOHtom62j5qSTdZsguyMc5Ax6ZJhYo7G90fC7IU80l6QFg7X5VI3KNDUO3l?=
 =?us-ascii?q?HGEGhM1+ffKlbbcBEWmNQx6U92G5IOa+EZ0zNB/KPH3DU=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AJAgASaxphhwwR49RaHgEBCxIMQIFOC?=
 =?us-ascii?q?4MNbDoxhEePSYF3MIQYhlaGcIoKgXwLAQMBDT4BAgQBAYRhAoJrAh0HAQQyBw4?=
 =?us-ascii?q?BAgQVAQEFAQEBAgEDAwQBEwEBAQwNDgg6JIVoDYI1IoNsAQICASMVCAEBEScEC?=
 =?us-ascii?q?wsaAiYCAlcTCAEBgm2CVQEDDiWnd4ExgQGCBwEBBoJaghEfLCJQgVoJgRAqjXM?=
 =?us-ascii?q?nEIFVRIE8gk4wPoURgkqCZKgBnU0tB4IAgSuBNwucewYUJoNTAZF1DgaRGLtWg?=
 =?us-ascii?q?WcCggszGiSDOFAZDo4gGYQMiixAMjgCBgsBAQMJbAEBiQcBAQ?=
X-IPAS-Result: =?us-ascii?q?A0AJAgASaxphhwwR49RaHgEBCxIMQIFOC4MNbDoxhEePSYF?=
 =?us-ascii?q?3MIQYhlaGcIoKgXwLAQMBDT4BAgQBAYRhAoJrAh0HAQQyBw4BAgQVAQEFAQEBA?=
 =?us-ascii?q?gEDAwQBEwEBAQwNDgg6JIVoDYI1IoNsAQICASMVCAEBEScECwsaAiYCAlcTCAE?=
 =?us-ascii?q?Bgm2CVQEDDiWnd4ExgQGCBwEBBoJaghEfLCJQgVoJgRAqjXMnEIFVRIE8gk4wP?=
 =?us-ascii?q?oURgkqCZKgBnU0tB4IAgSuBNwucewYUJoNTAZF1DgaRGLtWgWcCggszGiSDOFA?=
 =?us-ascii?q?ZDo4gGYQMiixAMjgCBgsBAQMJbAEBiQcBAQ?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="398119751"
X-MGA-submission: =?us-ascii?q?MDFPnVu2V50rzS5En97TFlyJxl8si3x8sK3iNd?=
 =?us-ascii?q?IrdTMVlA7eTnXqpOvpPwcmCs7StnNWmZOcs5lTnxmXNcXJpnO2y3ylIF?=
 =?us-ascii?q?Nl3J5Js/J6jN8U/GgqrfNshaDQ6zbQtZHELHtkWK9ccnAvRWqL5sbhU3?=
 =?us-ascii?q?i1SvyWYJYqnYPkT2pS6Npxhg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 12:15:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1635938143;
	bh=O2xVW6jrXDGQso58yIO0sI2Ouyv+s4DJqA2AXimJdUc=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=Th0YA+jw3gw2K15Mn5Rx9hdTkKYfo/qq0aqQqstLW7rXDAgKSzzdCBkcYFKuOd5CX
	 jb6jH5DcaUIR3LWCky+0X4TFsV3u6FRRrZnEDyagiI7cvzFViWnnPa6AG3s3Cp1h9N
	 mfGMEHxamr8dQ05JWwweiute7Rw4KgUmzpZU6688=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.102.25]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqqPT-1mMcoA1kzx-00mSOC for
 <cocci@inria.fr>; Wed, 03 Nov 2021 12:15:43 +0100
Message-ID: <7dd9873b-c533-df72-ab89-95597f91fe3d@web.de>
Date: Wed, 3 Nov 2021 12:15:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <b2aa6f7a-2169-143c-59c4-bab1830126bf@web.de>
In-Reply-To: <b2aa6f7a-2169-143c-59c4-bab1830126bf@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:S1B+/NcPWjaIza+7zNjcQfjz2CBP+pbzRX5B2fCpA75Jq6+vr+C
 UnFUeVBQxkacU6ilvqO2Mx2CcITtPgP+NFrZCDy0fgiSqhqp+D4q1DNHULKZXdBmOT5QF/K
 U4sukEX19iY1b2V04PBm1n1EMsenYeZ9bSKkYOYQvWTlQTq/w/jJjkfHQv2lXERqeGQCNVI
 aL68V8vCVILE0D8GKjM4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bsClztYEk1I=:LdzznIuTPIVUQgwGAc2cQp
 RnavhIuA0GwfeUDu2JcYVM0IXi8iK84/I2dx8EkBnTPRIdjsiulq/MT7XsGDInCBF2wqfaVd4
 WAJchLjgOeBEDf4DaMaemvuxtGuWg+xkICAeceKVT4zb8oeSMgdMEKaD1PAyk7lo42Xp7Mu1i
 PM8O7rs5CRAyRq/z2LwlDuup3l2najhAWPUwLrDccu2fOKLZ5Ki+/2cVhnxUxG+wH53mxhUFe
 PrO4Hp9n2p4GhSNdAPfftDK4yEvtw7ofVn5Kw9GMb2dMKTiTat1+M8viQvy44s8ggL954sE8A
 kYAvLC3GQCELr0hqaoerhoeROgbpNtMqLLB5C3uyBnqmRKo2Rk6lOQwVB/fm32LlVlBJ/KOgU
 gqk7MTLXv2csmP+daGsyf8cscEkQCfJEl+42oWr10Uqq7kFWr9Mf40sb81QqEQsFOIwKxLGoA
 gbkLIx4JfVH3Nlh6IkbtQLGDI7507ymhnAiHQrsccyMAc5pwRuQ4GnR0SryfirSMgNvsHzYTr
 99ae4h6w7a/eUMD0Y1RKZitiMZf0FnS2dXW9bHav7YrHBOG5Bi1EMIXTxmerylI7rZnwVf5S0
 vH2jksFDAMK3Z60PveI9ooIqHnJyEw5CALC/NGg4ikJ4Pfi3rqMPmqDDfbP1pnEde8u1L6ui1
 gRMDmXZvzHkUvuR4M3EoPTnaUul3vYz9KQ8Aq9L1e6Jl7ewO20eemgcDYIYqSjeFm7X07nfaS
 heNrYoG9N9STzWKzZSMb9t8VX7lJuzN2GB65QSzkSo4yKrfPgbw14DyJvz6v6r6qeJxVODDki
 3SbTe6HQqqMkhYnUdPpZa54RUBSpg94iUAI7hhAXHUiMZUm3G3JQLZ9mTEnhPPBbezBB+NGJP
 6k3ecYImOaVKDPMOLhUCfsPw1zGGdICdoLWKucoOKhft+h1RzFn2cRzOBcb6LAhmjU2d+teCX
 /Kwab2elCBe5+C8gye1EXOOZonuWi8r1hn0vgjpOWl7U3mjJE3GpKEQUXX+iAl3af6dudCzSi
 QD+/ymV5FguE/9lyxivgJZapy6OXnbv8Kk/R78+L6VkYOk6wiv6jZ9ezzHqQ54JbzE8Pu845v
 QeZ0jHpLco5q+4=
Subject: Re: [cocci] Checking parts of binary computations with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 58
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/7dd9873b-c533-df72-ab89-95597f91fe3d%40web.de>

> binary_operator bo;

I should have omitted an underscore at this place.


The following SmPL script variant gets accepted.

@display@
binary operator bo;
expression left_ex, rigth_ex;
idexpression idex;
@@
*idex = left_ex bo rigth_ex;


Regards,
Markus
