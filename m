Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0083C433F5
	for <cocci@archiver.kernel.org>; Sun, 13 Mar 2022 17:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=P/ClDkD06m4vTaqAiFBMOE4g8psp//vqobVUU+M90Iw=;
  b=E/DI0bY7dwNzOoEL/mhzcaxIHuG8GbyW9eIthQYy9fjIWArWuWD4tIvb
   QFz2nSiU7YclCenX9SLNGZdmgzKRhn26+GNh+y3rzYuSi619vNMi5+Ns1
   eo19UOBkxT4bdQNxVYsIxjXC4QcNUwrYpHNU69MsBhqmfbJJuMQUjGts9
   o=;
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
X-IronPort-AV: E=Sophos;i="5.90,178,1643670000"; 
   d="scan'208";a="25869536"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2022 18:08:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0C336E0048; Sun, 13 Mar 2022 18:08:20 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 674D5E0045
	for <cocci@sympa.inria.fr>; Sun, 13 Mar 2022 18:08:15 +0100 (CET)
IronPort-SDR: rz8BMXmABHLd51UyPZnBvP6nZAVJHqBsMsQbt0TEoWnQlFGfyNlxdeRdOC0HCEGSTT/+dgKlme
 XBxeUmz/fWc2bvi57WhQgRyoASBJl7bo9MJH8EnnDZRnCQNir78EYit+tKUVeC5cAsk5wVNlBq
 if5+NYCHECBaK3Hbj8ZZAcqiwVQWRHNGoagvgIeUYQ0IUvrpzBoLj28I9ePCKocMZDBkpyaisH
 82V3BNxZCW3y+JGPgaXSTn8t38zAiCaqX+a9BVmiisTbvPXrMW0PxWIo66hooFFou7xwBe12N9
 UZ4zlyaOuaYaY1VsSlJitYgn
X-IPAS-Result: =?us-ascii?q?A0BIAQCtJC5ihwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VqCKIFVKwQLRIRUkGoxiyOHFoo6gWgLAQMBDT4BAgQBAYUHAoQkAh0HAQRHA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECAwQBEwEBAQwNCQUICgcOEAU2B?=
 =?us-ascii?q?l4GZASBSwSBdAs0DYI1IoNsAQICASMEGQEBEScECwsODAIRFQICTAsGAQwIA?=
 =?us-ascii?q?QGDAIJlAQMNJa4ofzKBAYIIAQEGhEgfLCJSgVsJgRAsihMkhBEnEIFVRIE8g?=
 =?us-ascii?q?wM+g35HP4JbgmWXBYEVwxM0B4ISgTqBQAueCwYULpY6DgaRaS2FJZEFIKZbN?=
 =?us-ascii?q?YFEgX0zGiSDOE4BAgECDQECAgMBAgECCQEBAo4dGYQMiixANDgCBgEKAQEDC?=
 =?us-ascii?q?QGBVoNwAQGNHAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:IvVnmqzDBNvCrwWTaNl6t+dPwCrEfRIJ4+MujC+fZmUNrF6WrkVSz
 moXCm2HaamDZmSmfI10bdng90NUv5WGyNUySQFl+FhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefQAOOU5NfsYkidfyc9IMsaoU8lyrZRbrJA24DjWVvW4
 Iiq+qUzBXf8s9JKGjJMg068gEg31BjCkGtwUosWOJinFHeH/5UkJMp3yZOZdxMUcaEIdgKOf
 Nsv+Znilo/vE7jBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XOdJEAXq7hQllkPhck
 +tEupaUbTwIEff1u905eTZUAQJHaPguFL/veRBTsOSWyFDaNWThybNiASnaP6VCo7wxWzsRs
 6VFbmtlghOr34paxJqeQ/Nvm99lAc3lJoIZtVl/wDufAftOrZXrGfiau44Fh25YasZmPdTMP
 /EhYjdURRnhQD4eJVNLOc0dpbL97pX4W2QF9AzM/PRfD3Lo5Ad227PsGMHEf8SDA8RThEeR4
 Gzcl1kVGTkfM8GDjyWI+DSgi4cjgB8XRqo/T4Ox+fROpGay6TYqKyQyf3S3s9qA3xvWt81kF
 2QY/S8nrK4X/UOtT8XgUxDQnENoriLwSPINS7Fhsl3lJr78vFbAVjJsoitpNYR+3PLaUwDGw
 XelsrsF7xRKt7uJQHiU6638QdiaZHZJdDdqicMsdwsI4t/nqYc/yyrBR9JxeJNZY/XwHizsh
 S+Hpm4yit3/bPLnNY3rozgrYBr1+PAlqzLZAC2JBwpJCSsnPeaYi3SAswSz0Bq5BN/xoqO9l
 HYFgdOCy+sFEIuAkieAKM1UQu32vq/eamCH0AI/d3XEy9hL0yHzFWy3yG4vTHqFzu5fJlcFn
 WeO5VIPv8U70IWCN/MnPt3Z5zsWIVjITIm5CKmNMLKik7AoOlbP/SdyaFSW0nylmUdErE3ME
 cfzTCpYNl5DUf4P5GPuGY81iOZ3rghjmz+7bc2lnnyPjOvGDFbIGOxtGAbfPogRsvjeyC2Lq
 Ik3Cid/404COAEISnKLqtF7wJFjBSRTOK0aXOQML7/deFU6QD99YxITqJt4E7FYc21uvr+g1
 hmAtoVwkzITXFXLdleHbG5NcrTqUcotpH43J3J+IluinXQuON794KAafpoxXL8m6O06ka8qF
 aZYIZ3YD6QdUCnD9hQccYL58t5oeiOrsgTSbSCrVz4yIsx7TAvT9964JQbirXFcDie+ucYkj
 aen0wfXHcgKSwh4UpTJZfjpw17o5SoRn+d7Xk3pJNhPeRywodYwdHGr1qc6epheJw/Cyz2W0
 xetLS0Z/eSd8ZUo9NTphLyfq9n7GeVJHn1cQzvR44GwOHSI5WGk24JBDL2FcD2BBmP5/KKuO
 bdcw/3maaRVmVFXr8xjHrwtwa9nv4njoLpTzwJFGnTXbg33W+06fSTchZFC5v9X27tUmQqqQ
 UbRqNNUDrW+Pp+3GlAmIgd4PP+I0usZm2WJ4Plpcl/24jR7oOiOXUlIZkDejStAMP1qPYljz
 ep44Jwa7Am2ixwLNNeaj3kIpjrWcSFaC/0q5sMAHYvmqgs30VUcM5bSPS/B5s3dYdt7NER3c
 CSfg7DPhugHy0fPG5bp+aMhAQaAaVUyVBF2IJsqIlOUhpzai/Vx0BA5HfHbiOhK5k0v7g6xE
 jED245JyWGm4DpiwsRON4xpMx8UHwWXoyQd1HNQ/FA0jCCUuqjlM2A3f+qAlKzcH6SwYRADl
 IylJK3ZvfoGsS0/MubemaKolhA7ceFMyw==
IronPort-HdrOrdr: A9a23:vZ580avF1frwPzDoFjLsW58s7skDWNV00zEX/kB9WHVpm7+j5q
 OTdZMgpGbJYVcqKRcdcLW7U5VoLkmyyXcY2/h0AV7mZniAhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgjVQX+xA/DGdmprY/ds2Ik0dNj2DUstbnn1E4o33KCdLeDU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,178,1643670000"; 
   d="scan'208";a="25869531"
X-MGA-submission: =?us-ascii?q?MDHy+ao9x/XXw20OooLg9oxpAr5vq6fHMNXF5S?=
 =?us-ascii?q?L/ke8P2MDIBEqe6fcCgzLBW203s6ZwI+ih5JZ+li4HiJcqVBcuVUMLUA?=
 =?us-ascii?q?vwXYDSVfdgB+rSQIRnOJBCE9vFElzQTaSixX8gzUH1+jjkFpm5s1AuLk?=
 =?us-ascii?q?AwQ9+Lcmv2MZ5mukuo+PzulA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 18:08:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1647191289;
	bh=L7yiHIcpk6569FRHnfKPJpMe+M5Aqczc69++WYzGRnc=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=bnLnV0lvyOjv92APJqlSi05NUklUYTwzgTyp7ifWHUmjjjK19xJGzA1h7yJkTH8Jd
	 JcbuOPyYmb3lv8r4nv43aKqiETw4vsAYMT0p8kBkR6X3grMOg/D0Buja9Q5mXCpE2m
	 bxCL8CvJmDjUslYGKeIkFhD+JAw1z2nZtfkhNb1c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.179.181]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MxYbN-1oMwvQ2eYD-00xYQU; Sun, 13
 Mar 2022 18:08:09 +0100
Message-ID: <c415341b-70c4-2bc7-b067-39c273ace958@web.de>
Date: Sun, 13 Mar 2022 18:08:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Eric Wheeler <cocci@lists.ewheeler.net>, cocci@inria.fr
References: <818d2b72-e28a-ba5e-661c-cba9fe9914ca@web.de>
 <70ad3def-a4f-14b4-cb70-acfe4a516d9b@ewheeler.net>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <70ad3def-a4f-14b4-cb70-acfe4a516d9b@ewheeler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1HoKRyxMF01t/YBdqtoDkWfdV044FOzotLauNgS5efslXWLBLjC
 SttybXwV61oG/20pfGvW6wP67l3LsgSgGcM7TcnNPXpD9g2CeamohzHEMA8UGymR+weUPdX
 skldOcg39NN7rbCnyuNoPvXUzH83wOkaGa9bgq6+zY5YBEaj91WDilKCmUYOc6nZEpqKAuZ
 iP1zd9eHlZ2OP6kPmD/cg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I71IXPiKdWQ=:bgbXdmkFvcBLKvljezoX0c
 Wd4MG3WLS5U3tNzKOxZWXM5CoVbJR2RhwmSKYMCyTz3GirRQuiTQgj6o3plJf0ThAYGdPI1kr
 hGepbUGAToOmtmKK9XDMxC93CwRyzSVK5M5U3fPgITwxsCJJIONg7YxxdJpjNuvG3iPC6n+jq
 mdgRKt+a6M1scrNkPChNvV/tHSa/U/iAzY7mT4xH7Ng4UmzGZm9q1ymO2M/WRLNE+Fzq9jqbp
 QAgQj2mcrR3zmm/yPo+XUpk7bSRNHr/O31dYFxoZAIZ333HSljbAzNYc5XRRF0TQypdVefml4
 urTXRiEoagkUXbxnos9YG8PeGDYIBs3sJILvoJG4QfhggDVghldSz40abjUc0XMXM2/oIgUs6
 W9xvmP1rf5FxH9rWJzItVoUIS5Tbiw/omGi+XNvrlTL8FzRkjVlWUOgtAZQuWUYxfF13vapfa
 ovr1VFcL4B0W4Rxfw7Ym6w1LBnI7K7Hyt9Se4ZeJb1MJNauanUdMJG5jW90F8643rwZVu00di
 nStJzdZb60WYKpywZuYVduzEPW0PNtXFxjmSbY8yjqNg6f7gKMPJDvbix8THk9V+kqwpRWfsh
 1oGJ89kSDY1KlQkhEh7JebG1SoB/Dsvfw0X1RFieJTA1JF+PCKGip6rSJE2Qmthj1+Qex7NdY
 ncdzyCGOn+EalKcF2xF5E1T6IQLDMZyvnB6vsAv5atq0N5xkOEnavFRevlZel9nNiCrLEhgbx
 RH5tV6QWHf3Oq/BvV0UBnD9RnkW7jwmdCXfvRPznLahATm7cwt2Bb1onZrO1si0fULM67oNdI
 /Y6Y33yqsNzsrSCX39vsrI5xnyYXr8yZB3rpX//l847M3WTwewCY7sfPqTCHJY+FkVPzzNP9N
 T61Crb1RHZyhFvdf3ZrHBNBQDhGx6Ue1L8jNZ3ReFCFKARIdvkkF5yMluaz+2ml8weyqOUaaA
 ox4YNyIu50ipdAWZ1nqeQk5No5L+TRwjM7n5s2H/0vyN0qcptDSztvs4x8VSfohPeQoqk6Pp3
 9tXYcPmJHL5gr4iRV+XK8R0DPm87YHKa1Tu+G+aysP8581yMTuZ/OZPBM0XyLcT6D4rKaZ9pc
 WNj2aEjyJFonbE=
Subject: Re: [cocci] Checking the isomorphism =?UTF-8?Q?=E2=80=9Cptr=5Fto?=
 =?UTF-8?Q?=5Farray=E2=80=9D?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 220
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/c415341b-70c4-2bc7-b067-39c273ace958%40web.de>


> Here are some other equivalent transforms I can think of for E1->fld whe=
re
> E2 =3D=3D 0.
=E2=80=A6
> E1->fld =3D (E1++)->fld  // but not ++E1


I find that this idea does not refer to an equivalent transformation for s=
uch an expression
because increment and decrement operators modify their corresponding objec=
t.


I would expect that the object should be kept unmodified under all circums=
tances
and independent from special values in this use case.
(Such a transformation might look interesting if you would like to take dy=
namic constraints
better into account accordingly.)


Thus I propose to delete the specification =E2=80=9Cptr_to_array=E2=80=9D =
from the file =E2=80=9Cstandard.iso=E2=80=9D
so that only safe source code searches and adjustments will be performed.

Regards,
Markus

