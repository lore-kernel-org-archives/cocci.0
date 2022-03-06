Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088DCC433F5
	for <cocci@archiver.kernel.org>; Sun,  6 Mar 2022 18:30:55 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,160,1643670000"; 
   d="scan'208";a="24643627"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Mar 2022 19:30:53 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AEBA9E00D9; Sun,  6 Mar 2022 19:30:53 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A4312E004B
	for <cocci@sympa.inria.fr>; Sun,  6 Mar 2022 19:30:50 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=Markus.Elfring@web.de; spf=Pass smtp.mailfrom=Markus.Elfring@web.de; spf=None smtp.helo=postmaster@mout.web.de
IronPort-SDR: zLOJoaEZJ0aJDMkvnA/GuH+iI/eaiwNKLsXVLACkPPgfX82QfkvC/nPdBGac7GWdwrGdxPafvU
 MG5b+EbUGstD+lszoEtO8GlcbaZjU4WS2O46njR3Tt+A9obHWJkHMMgs/Pa/24AVW5nXv7mKRw
 Qi5cM7CjLyViQr6Q4QUTfa2BV1F5aQiIQNmaO6IRSgeJpWP0tMnpooT919ZYnZlYSBTYe4yUQj
 MhDDpa2etotxF4fvEocxaWRVs+QHXhSRQcKuTsPTogzeKqlmHrOhFb9pcm0/PUEN4LzEPcnpk4
 JehFriYyeltMTwZWWQNWYT1t
X-IPAS-Result: =?us-ascii?q?A0B/BACH/CRihwQP49RaHgEBCxIMQIFcgiZ+VysEC0SEV?=
 =?us-ascii?q?I5zgXeSaoRFhWKBewsBAwENEgEBJQUBAgQBAYkkAh0HAQRHAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQMBAQUBAQECAQECAwQBEwEBAQwNCQUICgcOEAU2Bl4GZASBSwSBd?=
 =?us-ascii?q?As0DUAWAYFeIoQVBBEIAQERJxgcAiYCTh4IAQGDAAGCZAEDMguQGZwMfzKBA?=
 =?us-ascii?q?YIIAQEGgT8BgRyBbB8sIlKBWwMGgRAthhMUQoMphFwQgVVEgTyGJAEBAoIrg?=
 =?us-ascii?q?k2CZZdUEIJOkjQLrVc0B4ISgToFgTsLiCKBHZRMBhQuljgOBpFeLYUlkQONE?=
 =?us-ascii?q?5QuhTg1gVqBZzMaJIM4TgECAQINAQICAwECAQIJAQECjh0Zg1kziixANAstA?=
 =?us-ascii?q?gYBCgEBAwkBgVaDcAEBiSCDFgEB?=
IronPort-PHdr: A9a23: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
 SdxeQVBo+/Ihcu3qupyESpN4yg8RdQ=
IronPort-Data: A9a23:YkRR16M50dXJTUXvrR3dkcFynXyQoLVcMsEvi/4bfWQNrUog1TNWy
 mAdUG+AOv6ONmD1eYpzYIzgpEMAuJHdm9I3S3M5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8kk/jgqoPUUIYoAAgoLeNfYHpn2EoLd9IR2NYy24DiW13V4
 7senuWGULOb824sWo4rw/nbwP9flKyaVOQw4zTSzdgS1LPvvyF94KA3fcldHFOkKmVgJdNWc
 s6YpF2PEsw1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB2Zxutzi
 8hG6KCZVDwgH673pbw7FAdXRnQW0a1uoNcrIFC6ttGPiVLLeT3gzp2CDmlsZNdeoLwoRzgTs
 6BwxDMlNnhvg8qTyai4V/Iqq8AtNsjtM6sAt3smwTyx4fMOG8ydH/6Uv4EwMDEYh+NtAvfbW
 solOCtwNVfNW0cXAVMHF8dr9AuvriCiL2MB8Qz9SbAMy2PUxwdw+KP8NcLcPN2MX8Rc2EiCz
 l8q5Ez8BQwGcsOSw3yJ/xpAm9MjgwvrAbkQV6Czq8JDnWaa528oNUUwEkW09KzRZlGFZ/pTL
 Ekd+ywLpKc09VC2QtSVYyBUsEJorTZBA4YLSbFSBBWllfqNs1zx6n0sE2YZAOHKovPaUhQG+
 zdldfvMAjpzubecVGj1Gly88G3uYHB9wYMqXy8JTA0B6t/v5bk9hxbdJuuP/YawicDpXy79y
 XaGoUDSZon/b+ZbiM1XHnie3VpAQ6QlqCZrv207uUr7tGtEiHaNPdDA1LQixa8owHylZleAp
 mMYvMOV8foDC5qA/ATUHrlTQen0v67dbGSE6bKKI3XH32v9k5JEVdAIiAyS2G8yYq7ohBe0P
 B6I5l05CGF7ZiD7MPMfj32N5zQClPW8S428CJg4n/IXLME5dQmb8TtoaFLY1m+FraTfufFXB
 HtvSu71VSxyIf0/klKeHr5BuZd2mHxW7T6NFPjTkkX/uZLDNSX9YepUYDOmMLtjhIva+1q9z
 jqqH5DXo/mpeLaiOXa/HE96BQxiEEXX8rit850HLrPYe1E+cIzjYteIqY4cl0Vet/w9vo/1E
 ruVAye0EXLz2i/KLxukcHdmZO+9VJpztyxpIiEme1qlgiBxbYGq5aYZVp02Ybh+qL09l6EpF
 aFddpXSGOlLRxTG5y8ZM8v3ortiQxL31wiACCyoPWokdJl6Sg2VodLpJ1O99CQHAietm9E5p
 rmsilHSTZYZGVZ9AcyQZP/2lwG9un0UmeRTWUrUI4APKRu2r9Uwc3T816ZlLdsNJBPPwiqh+
 zyXWRpI9/PQp4IV8cXSgf7WpYmeE9x4QhhQEV7d4OvkLiLd5GeindRNXevULzDQUGT4pPera
 elPlqiuNfoagBBVvoA6H7sylfAy4N7mprl7yAV4HSyXPgrxVe46eiGLjZtVq6lA5r5Fog/oC
 EiBzdltP+nbMs3SFlNMdhEuaf6O1K1PlzSOv+45Jl72uH1+8LadCBwAOh6RlGpCIbEzPI58m
 bUtv8sf6gqejBs2M4/a334OqDnWdiQNA/c9q5UXII73kQ51mFtMVpzrDHOk6p+4bdgRYFIhJ
 SWZhfaZirlRrqYYn6HfyZQQMSthaZUyVNRiyVgfOxKWl9CDivJfMNi9N9goZlw98/mF+7sb1
 qtX24ldOqiEuTtl7CSGd375ABlPXXV15WSoo2bkVwTlo42ASWHHamEwUQpIEIb17EoEFgVmE
 HqkJKoJnNokkAwdHsf/ZKK9l8HecA==
IronPort-HdrOrdr: A9a23:T7Nl3qlhFcTsv9Nct637CMuYrlzpDfIM3DAbv31ZSRFFG/Fwwf
 rPoB17737JYVkqKQwdcLy7VJVoIkmsiqKdg7NhR4tKBzOW21dARbsKheCJrgEIcxeOitK1vp
 0PT0ERMrLNJGk/p939502VFMlI+qjkgcXY4Za4vhEdNHATGtpdB1gTMHfkLqTdfng2OaYE
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,160,1643670000"; 
   d="scan'208";a="24643626"
X-MGA-submission: =?us-ascii?q?MDF8a8nVy+6zvasPdMCLOmZczJ3YtdfVy0yxL8?=
 =?us-ascii?q?pnH/Czwdv3ha9WTNL8y8fK0IOAjDQ6QZVXEPUvv6s1pdCkHlbSQIvh5G?=
 =?us-ascii?q?fdcw6RsohanZxYbO+SWALD8TcBEro65lC1pMaDEIARaoPMAuI7ZY7MQ3?=
 =?us-ascii?q?7/VyV8nOxk7t+IFoXKBk2Z1g=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 19:30:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1646591449;
	bh=EcgQItMb52L0AyEz+PlzHySgorwn3lDBOvuoUGQ+bYA=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=Ub0qePGog/LVG6n361zpS2Z4jqOZ25i7SdeOicJUh/ZDTr8Q9dmLMgekTEBpfKgSX
	 Qv7O17o1Y7EgmCq/TbQ6z+fcaaGd/Hws8Rd5gTHIYwQiK5AfI3+LCux2l9cWbvbMb9
	 0S0I51xWXO0Ga7BnDrgeWxCx0ibz/e9may2rfRls=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.90.163]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mfc4q-1o6YvR0n7Y-00gIgo for
 <cocci@inria.fr>; Sun, 06 Mar 2022 19:30:49 +0100
Message-ID: <818d2b72-e28a-ba5e-661c-cba9fe9914ca@web.de>
Date: Sun, 6 Mar 2022 19:30:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
To: cocci@inria.fr
Content-Language: en-US
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XWk+/7FzRPSmuRzTIP5JJ0iFnXebIHjwuRCPvNEFBUJYoJaKz+d
 Ez4I2NHpWBLesXA4humCzFU2C6zycKSROUTCuoEpegA/3lZ/Bh8nK4wIldHz8+tt6+b0JQu
 Bi5lVxhTRnKCH6kruBPZu9OTkGLGBGsBpyA83SmU/UgGiEU7WwSvUR7EgA+ttgvKlCRCKmm
 BB1GuSXlsnU0gQcwcOWGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pUw3btk7jkg=:UCYlyP06MPPNtmPnCgib7F
 ffLYFNRHqisMgEoBItkB3upQ6Y4iQLlNGKb1+MUNQcbxoqxluepay4ihXDTLVLpud1HNXccpM
 cuQjMY2o5mBJYnJU45WsUUuX5z/zhZTLDji2z9yVI/fhVMakHK0MmxQ7Z6RaY8cZDYWRIr2Pg
 SgU5dEa5xmnLtXRpwG/je2VJghD+snYctBeyAhndFhuKxrXBrW+6A2T1lhYC1CrFrX6w4LPdE
 o7qe8+rEpF8abZx2TTlnMbIIuIaUUdi7V5R+5eYCeMVNc4L5HEResaXHU7Yz+4/t70I7BkWuh
 VAkoZABw6xYfTw4J5AlaD9mY8hsJs4jEwvllJVWR+4meZ5cc2ehskIdeRUas7MTnNBU4lUs7M
 xsM8HxCpIGrqB6rJCpV/qqe+LQ/pjQrIiotYLJmGvExA5cn6hJwyFNU3TpSh4FLojXpLrCj/r
 x59FF+lmGIBT+vaxCt+RzQYSXgKWqB57/0oRJU8c71VP+Lq81s5ZwFVPsr4XFMUvYMiivmAfR
 lZt9GmKFz9G9icwxvetvMpcL7TZxyd5UM4RPgdBfZ5HqJmoJ3FR7lYpFqT75znpiftr5xxlZg
 8RQ3r9063PtIe5KahwnyIP51osyZAC5aEyc1zJAqggiLuGgxVRGjIwBBR1jfXSz3QYS+eA8yH
 oIVBthXfoFA2eYX/dLsQMYxRdZ/Wav40gkuYazNkuNHrvP6Lz44jGRzgxRV1qZdwIUIiucA/6
 LHS9bp8lCUeS70YvSdafK2/Iq/lj3EOti1A4zpEkOMbpDI8YGrFYnLl+P4dyygKMtLZ7/2hR7
 HYYlnWw+2OHpYgR2LPkX6+m6hn9AiPyNgBs7+kj1Ok+VuN3G9RAu7ojBuTQBJk53Fu7GcsH0u
 H+WH0BPYgiO9nFCXNdAAh//53uLS8qIBve1WEHpAMUDxMhBDhGWmavSAL2yo499xBroRK2J2p
 i4fQfzb/veJPAU+ThRYfAxgDwAfh46LXJ//w3ghwqYZHUYjW73Kkw00jQG5mMSkJkQb/6Wao6
 4LC4cJRZ1W+0L6+E77KvKt2qGSz0c2gIu0H6mK37ld8yCO9oValKcey0AjNID0nyaESqx5dO6
 dcwDzclpuBsQSY=
Subject: [cocci] Checking the isomorphism =?UTF-8?Q?=E2=80=9Cptr=5Fto=5Far?=
 =?UTF-8?Q?ray=E2=80=9D?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 171
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/818d2b72-e28a-ba5e-661c-cba9fe9914ca%40web.de>

Hello,

I have taken another look at the following code.
https://github.com/coccinelle/coccinelle/blob/57cbff0c5768e22bb2d8c20e8dae=
74294515c6b3/standard.iso#L556

=E2=80=9C=E2=80=A6
//
=2D-----------------------------------------------------------------------=
---
// Pointer/Field isomorphisms
//
=2D-----------------------------------------------------------------------=
---

Expression
@ ptr_to_array @
expression E1, E2; // was pure, not sure why that's needed, not good for
rule27
identifier fld;
@@

E1->fld =3D> E1[E2].fld
=E2=80=A6=E2=80=9D


I would interpret such a specification in the way that this SmPL code
transformation
can be valid only if the expression =E2=80=9CE2=E2=80=9D will be represent=
ed by something
that will be resolved to a zero value.
How do you think about such an implementation detail?

Regards,
Markus

