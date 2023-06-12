Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A955BC7EE23
	for <cocci@archiver.kernel.org>; Mon, 12 Jun 2023 11:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qW39qBqYL5rh7y7+SHOvtOy2E6fDNHB7OZ224peZEy4=;
  b=WUvcUsZyaCeIId3r2/SVAN5ebLjJ4NdJit68/8VKjDKlNmXcg2XLLjG8
   Jybp2r0gwMcXCZJqEURamzPSzZhQaKr9uDruTRgNMLormjfYMQB0pb1kS
   JR3cMkkZvvbq7ZI50+E5QqHAuhdLwUAMa9PZnI7u6JN2C07yy1erB93yF
   E=;
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
X-IronPort-AV: E=Sophos;i="6.00,236,1681164000"; 
   d="scan'208";a="112421822"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2023 13:30:49 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 527BAE0CCE; Mon, 12 Jun 2023 13:30:50 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5C55CE00BA
	for <cocci@sympa.inria.fr>; Mon, 12 Jun 2023 13:30:47 +0200 (CEST)
IronPort-SDR: 648701e5_0XTmNTvMZ4GzdC3qQyT2RhcWkpu/ekdL3gtkKfh/aldJ7Re
 RKawx4biUEf7VL4O3OgUAXkQl3O9WE12/7znq1w==
X-IPAS-Result: =?us-ascii?q?A0E8AADCAIdkhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIudQNTMAQLRwOET4gdiTSENI51hGiEBIFWgUA+DwEDAQ09BAECB?=
 =?us-ascii?q?AEBAwSBTIIyO0YChXUCHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBA?=
 =?us-ascii?q?gEBAgQFAQIQAQEBIxcHDhAnhWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBARICDTo/AQICASMdAQERJgEECwsaAiYCAlcGAQwIAQGCegGCJwEDD?=
 =?us-ascii?q?iMHDa5JgTKBAYIIAQEGnA4fLCJVgV8DBoEVLQGNLoM3eicPgVVEgRUngwQ+g?=
 =?us-ascii?q?ksXBBiBRoNbgmeLMA4LgmiDNIwqgShvgR6BIn8CCQIRZ4EICGOBcUACDVQLC?=
 =?us-ascii?q?2OBHFI9gUYCAhEpExQFTXsdAwcEAoEFEC8HBDIJFgkGCRgYFycGUQctJAkTF?=
 =?us-ascii?q?UIEg1kKgQ0/FQ4RglswNkYbJCUEDgMZKx1AAgELcD01BgMLHwYmAR4CKYFXM?=
 =?us-ascii?q?FhwCiQknmYDgw+BOYFNMJZPAa18NQeCMIFbgV0MihOVCQYTL4NukyYOBpItL?=
 =?us-ascii?q?oc5kC8gjTqaXYFjOoFcMxokgzZPAxkPjiAZhA6EYYpnPzQCAQELLAIHAQoBA?=
 =?us-ascii?q?QMJhUYBAYV+AQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:KfhmO6NMaOAxwvLvrR2sk8FynXyQoLVcMsEvi/4bfWQNrUol0jQOy
 WsbCG6APvmJMzTweNwna96y9kgHu8XRzNBiGnM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8mk/vgqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvU0
 T/Ji5OZYAfNNwJcaDpOsPrd8Uk35ZwehRtB1rAATaAT1LPhvyJNZH4vDfnZB2f1RIBSAtm7S
 47rpF1u1j6xE78FU7tJo56jGqE4aua60Tum1hK6b5Ofbi1q/UTe5EqU2M00Mi+7gx3R9zx4J
 U4kWZaYEW/FNYWU8AgRvoUx/4iT8sSq9ZeeSUVTv/B/wGXfQWfymc4/Hno3ErdE4f9yLUVx+
 f4XfWVlghCr34pawZq+TfRwwNsuJo/nMevzuFk6lGufV6x5B8meBfmiCdxwhF/cguhrFOzde
 tFfRD5hdhXGbDVQN11RBJ9WcOKA3yClL2cB+AvPzUYxy1fUwD5LgZO9CYLUSt+nZ8t2vxa8p
 1uTqgwVBTlDaYDBkGPbmp62vcfEmijwWaoJBbig/7hrhkeSzyodEnUruUCTpP6klgihVtgZJ
 0F8FjcSQbYa7X63UIPGDg+DoVG+4gUFXvZ0LOE451TYokbL2DqxCm8BRz9HTdUpss4qWDAnv
 mNlefu2X1SDV5XLGBqgGqeoQSCaZHFLdj5TDcMQZVdbuoO+yG0mpkiXFr5e/LiJYsrdPxWYL
 9qiniUgirMZgNQE2qPTEbvv323y/PAloiYT4R/LXiqP9ApzbYi5D7FEBHDe6utcapmURB+Ns
 RDoevRyDshRUflhdwTXGY3h+Y1FAd7balUwZnYyT/EcG8yFoSLLQGypyGgWyL1VGsgFYyT1R
 0TYpBlc4pReVFPzM/8pPtrhUZ90kvSwfTgAahwyRoUfCnSWXFDXlByCmWbLjwgBbWBxz/pjZ
 MrznTiEVy9LUP0PIMWKqxc1iOJ3mHlnmws/tLiigU3v0LyCaWSTRKtNOVTmUwzKxPPsnekhy
 P4Gb5Hi40wHDoXWO3CLmaZNdwxiBSZgX/je9ZcIHtNv1yI9RQnN/deKneh+E2Gk9owJ/tr1E
 oaVBhUDlQah3CaWc21nqBlLMdvSYHq2llpjVQREALpi8yNLjV+HvPhHJagkN6Iq7vJixvNSR
 vwIMZfISPdWRziNv3xXYZDhpcYwPF6mlCCfDRqDOTIfRp9HQxCW29nGegC0yjICIBDqvuQDo
 pqh9Djhf7w9eypYAv37VteT3nKqnH1EmOtNT0rCedZSX0P38blVES/6j95pAsRVNxnz/yaWj
 TiXJRIiocjMvI4H393bjo+Ur4qSMrVfH2gLO0L5/LqJJS3h0W77+rB5UcGMZiL4eFLv3beLP
 MF57qjbHqUcvVBot4FcLe5a/Zgm7YGym44AnxVWInrbSn+KVJViGyCi9utSvPRvwrR5h1OHa
 niX8IMHBYTTadLXK39PFg8Lde/Z6Oo1nAPV5vELIEnXwi970b6EcEdKNSm3ly1vA+ppAbwh3
 NselpYa2y6nhjouF+S2vCRe2mCPD34HCqscps47Bq3vgVEV0V1sW8HXJRL3x5CtUO9yFHcWD
 AWav4f4vIQE9HH+KyIyMVPvwdtigY8/vUEW7V0aeHWMtNn3pt42+xxzqgYIbxln4ShG98lRO
 WFbEVJ/CovT3jVvhelFB3uNHSMYDjKn20XB8Xk7v0yHcFuNSUr2M3wbBeaB2Gs74lBsVGFX0
 5/AwVm0TAuwWt/62xUDfHJMqtvhfIRXzRLDksX2JPa1NcA2ThS9i5D/eFdSjQXsBP4wo0j1p
 eNK2uJUQo+jPA4yp5wLMaWr5Y4yejulelMbGepA+ZkXF17yYDuxgDiCC36gc/N3esDlzxWKN
 NxMFOluCTKOjD2DvxIKN54qerVUpsMk1PAGW7HsJFMFjYehkypUgMru0Rb61UAWQIRIsMciK
 4nuWSqIPU6OiFB1xWLcjsl2FVCpQNsDZQGm4uGR9d8NNpMcsdNDdVM5/au0sk60bipm3UOwl
 yHSa5DGy9dNzdxXoLLtNaFYFSCYFMjWVtnUwDusst9LU8zDAf3OuywRtFPjGQZcZpkVZPhai
 pWPt4TR8H7enbNrTV3cpYaNJ5NJ6eq2QuBTFMD9d1tevCmaXf7T8wkxwH+5JbNJgeFiyJGeH
 SXgU/SJdPkRR9t5719WYXIHEx8iVoLGXp25ria59/mxGhwR1DLcF+ye9FjrUzBrRnddcdm2Q
 Ar5oO2n6d1kvZxBTk1MTe1vB5hjZkTvQ+06ftn2riOVFXSsnkjEgLb5iB488nvePxFoyiohD
 U7tHXAStSheuZ0kCPlctJFu+AIaBjBxjIHcu67bF8Fe01iH4KwudIzx8qnqzrlLnya02JyQi
 PTlcj45ESukNdhbWUyU3TkgNztzwsQRN92/KjFBE4Z4rcupLNvoPYaNPRuML5u7lvUPAQ1nx
 RwjFqXMAyWM
IronPort-HdrOrdr: A9a23:wmqTuqoT5xm2Mb9qdi+H9dIaV5r/eYIsimQD101hICG9vPbo9P
 xG785rsSMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAb2SS5vyKhTVQfexB/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: 9a23:QBLkrG0VTMU/bE+HFId+irxfA/I5bCfmnWXrImCCVX1wTZGxdlOS9/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3APA+xrg5s6QLySbX5x/2xHh3bxoxX5KicMhEmwax?=
 =?us-ascii?q?euvmHGA5+GBbNqDWOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,236,1681164000"; 
   d="scan'208";a="112421812"
X-MGA-submission: =?us-ascii?q?MDGA+fnZzvPJF+Eqiji9Zt15ccc/R8YjhNtV4Y?=
 =?us-ascii?q?lTgaL1eAi6V3xQMbx0LJeh+D+RxaZTcP8MZM+k5M4g9d7jed5LM7U81E?=
 =?us-ascii?q?/cDDPXqy1zwm6w2HvKOl2vUJJkjYOvKB8gVXF1mJ7EGAoHREuLPapvj7?=
 =?us-ascii?q?OwCAFC6pdJuVV40snZoyIMYQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 13:30:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1686569439; x=1687174239; i=markus.elfring@web.de;
 bh=qW39qBqYL5rh7y7+SHOvtOy2E6fDNHB7OZ224peZEy4=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=wdBKVUYSdvY38VFIZUpZKdoUSQpe7nGNdofBOpnCvD6tABi3SabSTOpPAnah2QyLMzlt7rP
 m+kfg8lqH7G4X3PpVUM008KumGvI9Dky9o8KmbSj4qEOA4F4dh/0kkkz1DhNT6+1xpsbW8mMb
 oYpqPUmh0nSsg3kw+RxeIFtVQSxK32GSShlw4UsaJUUKiCiKV9BadJzmEpM+WzftDAfmqqnen
 Vy2QxU2dQRqBAW8mr13B3Aa/U2XCywxr9Q/1m/HCHrKb6UwJ0jNrhgbMf6nd7ipmzgVvZFUPo
 PNLUZDRG9iWOMYGHK67Q5B+vrClJ/AAOFOpP2Nn5Vo8SIFNmRxiw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MkVwo-1pj0iX1R9S-00mCjd; Mon, 12
 Jun 2023 13:30:39 +0200
Message-ID: <48cc92a8-65af-440b-c94a-c0972012f18e@web.de>
Date: Mon, 12 Jun 2023 13:30:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Lu Hongfei <luhongfei@vivo.com>, kernel-janitors@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 opensource.kernel@vivo.com
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>
References: <20230612065954.24014-1-luhongfei@vivo.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230612065954.24014-1-luhongfei@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EbYhRPPXRXE01p1Nn9DVyRAT5YOoHkWIQAWP01M9qj+pguJhRpa
 SnLxALodboD6pS55CHd1kID4QW1vIlP41Y3X23luTWVAN3Wdr01dzP5P+W0p371ifKQlYWE
 bMvFqH14Hg4pgVGgg0exnehoH6E0otvlxAVKNXeCmI6NPr9EXGZ13laO1rdkXvSf2XO2dl7
 peFaDXs3vr/3Qy8AiNWQA==
UI-OutboundReport: notjunk:1;M01:P0:q3kTOB8t68k=;NDnXDAfj1cTmsuruxSWNOk3Rm1b
 ak5BAQnYhbawUgKSbGBSR0zzgGe8tINC4zqvQdf94UNaK6orZfSK9osYGE9cSMnKfbWT6oP3z
 X/RnRwvuTqw1C4DxdarURtoJBV9iikTvzDyWAJ3+tasc4AXKZPW0dorNa50l4bpSNwUekLkcJ
 aDh4A4flG9KZVcvEtrT/KWGsZ/ya9h40GpodaaxtO3l2kQUppbJbutIZVs2ss5kN7hYQ4iN8W
 AE2gNeHJWWwkdfyoT2fwke5PnlKxoQUN6hT37tCGoXxPeTB2wGH0fimphhFKF8JLUTb1zkp1o
 0V0EXYCaS5lnhrSa8v/WlJrHHZ2gjwTAT45Qzu5egiZpJkXjIuLIfbfZUhyuuWrfgrqAO00Lq
 7mPtMofpzi/QkZtTD6kq4fldC+RXNCXu2YUAWy7huYwTZzThcdyKPuDHToizKk7gNh9KZ0dJC
 i70Rj+i1GDPyhHf6YdH9Z4KBxcQj27r52TgQ72ULAbAQh1CNpBcJwE4zIywI7Hc8LA+umCIBA
 yIOAo0yhF+7SagM6Uz8CJjVH9uKQw3r91j0ZUwkqVUknPu0MPjFmH9bOhDVh9ilgnlavdApCL
 isn5VGoPsLuObVa0EHUYezmCe2L6Dh7o/qMba/fgJDpmcb8rRJqbiSKXamrLjUvmPoFREYaOR
 pNCWnOFGEQfdTaFIlGFc+f2QZkBkiVzHA6Py+bYNjpXx1Nmd0DiXAT3aAO1dJre4s3VsaYlIa
 abgy/INyzE31HQQlN++Ohbk0gopR9piSzeO/R5fWGWC3TUYWL9wT8wqWvxVQj6HbcX55jWCds
 TBttHyNDYRdw9YiFb6ggripIDfCokFFqPdOkLVzNElSIAW3TE9kt+gSXM/LwOgJzxQYCP7c7n
 6REmO3JZcqYz4LzAf2qEjJG3lVwJiPl5LtSOlnYs+wpvfKW0ynbtSQrkbBoZMx/OJB5XIYmqP
 NLc3KA==
Subject: Re: [cocci] [PATCH] gpu: drm/amd: Fix the bug in
 list_for_each_entry() loops
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1175
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/48cc92a8-65af-440b-c94a-c0972012f18e%40web.de>

> pqn bound in list_for_each_entry loop will not be null, so there is
> no need to check whether pqn is NULL or not.

Would it be more appropriate to use the wording =E2=80=9CDelete an unneces=
sary check
within a list_for_each_entry() loop=E2=80=9D instead of
=E2=80=9CFix the bug in list_for_each_entry() loops=E2=80=9D in the patch =
subject?


> We could remove this check.

I suggest to use the sentence =E2=80=9CThus remove a redundant null pointe=
r check.=E2=80=9D.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.4-rc6#n94

Regards,
Markus
