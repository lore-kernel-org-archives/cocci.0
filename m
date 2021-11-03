Return-Path: <SRS0=6LBi=PW=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB06C433F5
	for <cocci@archiver.kernel.org>; Wed,  3 Nov 2021 11:55:17 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F204C60F5A
	for <cocci@archiver.kernel.org>; Wed,  3 Nov 2021 11:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F204C60F5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3AlcDOpq64kRniLZE2fW+4UwxRtCnGchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENSgjxSz2EcCD+CbKrbY2f9KN93O9i3o0pXuMSDmtRhQFM5pCpnJ55og?=
 =?us-ascii?q?ZqcVI7Bdi8cHAvLc5adFBo/hykmh2ipwPkcFhcwnT/wdOi+xZVA/fvQHOOlUba?=
 =?us-ascii?q?fYnoZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2Ng1aYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57gY0gSS/jTOxKPgzxYQcBOgDAb/Hx0g/19baRGLx4J011lnPgooDlJnZe3Q?=
 =?us-ascii?q?gwoe6rTnukHexheCSB3e6NckFPCCSHg4JLKlBCun3zEhq8G4FsNFYYf8e12KWh?=
 =?us-ascii?q?U/vwZNj0XKBOOneS7xPS8UOYErs4iN9L6Mo03tXRpzDWfBvEjKbjIRKjM6Nlw0?=
 =?us-ascii?q?zI5h8QIFvHbD+IVYDwpblLfYhlLO14SE7oxme6pgj/0dDgwgF6cu6s7+G/VwAJ?=
 =?us-ascii?q?+1JDiNdPUfpqBQsA9tkqV4HnB4nbwRBodLtGZ1TuD2n2pj+7L2yj8Xeo6H6al8?=
 =?us-ascii?q?vp7qFKUwWMXBVsdUl7TifO0jEOyWtFDA0wZ+ywj67I1/0+wJvH2Wxq/u1aGvhU?=
 =?us-ascii?q?YXN1LVeY97WmlxqPS4gudQGwJXDVIbtsOsM4wTCYtkFiTkLvBDjx1saaJTmqds?=
 =?us-ascii?q?L2ToDO3JiERIWIYTSsFSwEE/5/op4Rbs/5lZr6PC4atlNr5XDXx2CyHtzVn1/M?=
 =?us-ascii?q?Si9QK3uO15zj6b/uXjsChZmYICs//BApJNj9EWbM=3D?=
X-IronPort-AV: E=Sophos;i="5.87,205,1631570400"; 
   d="scan'208";a="1796135"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Nov 2021 12:55:16 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 20BB3E02AF; Wed,  3 Nov 2021 12:55:15 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 08C77E004C
	for <cocci@sympa.inria.fr>; Wed,  3 Nov 2021 12:55:13 +0100 (CET)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=Markus.Elfring@web.de; spf=Pass smtp.mailfrom=Markus.Elfring@web.de; spf=None smtp.helo=postmaster@mout.web.de
IronPort-PHdr: =?us-ascii?q?A9a23=3AAVkqvRZnXZ55jtHw1E2ZWHH/LTEc0IqcDmcuAno?=
 =?us-ascii?q?PtbtCf+yZ8oj4OwSHvLMx1gePDNyQtq0MotGVmpioYXYH75eFvSJKW713fDhBt?=
 =?us-ascii?q?/8rmRc9CtWOE0zxIa2iRSU7GMNfSA0tpCnjYgBaF8nkelLdvGC54yIMFRXjLwp?=
 =?us-ascii?q?1Ifn+FpLPg8it2O2+5YHfbx9MiTagbr9/LBe7phjNu8cLhodvNrw/wQbTrHtSf?=
 =?us-ascii?q?ORWy2JoJVaNkBv5+8y94p1t/TlOtvw478JPXrn0cKo+TbxDETQpKHs169HxtRn?=
 =?us-ascii?q?CVgSA+H0RWXgLnxVSAgjF6Bb6Xortsib/q+Fw1jWWMdHwQLspXzmp8qVlRwLyi?=
 =?us-ascii?q?CofNDA3/m7YhcJtgqxbvhyhqR5wzJLbboyOKPp+Z7nQcc8GSWdPXMtcUTFKDIO?=
 =?us-ascii?q?mb4sICuoMJeFWoJPnp1sNsBu+HhSnCuzryj9GnH/23Ks60+s8GgzB2wIvBcgOs?=
 =?us-ascii?q?HfJrNXuLqscXuS1zKfSzTXCafNW1izw6YbWfR86u/2DQKx/fNPXxEIyGAzLkk+?=
 =?us-ascii?q?eppb5PzOJyOsNqW6b4vJ9We+rl2IppAB8rySty8kshIfHiZwYx0zG+Ct5zos4J?=
 =?us-ascii?q?d22RUp0b9K6HpZcqjyWOolqT888XW1ltyk3x78JtJKleiUB1ZcpxwbHZvCZboS?=
 =?us-ascii?q?E/AjvWPiPLTp6nn5pZbCyiwyv/US+0uHxUse53ExXoidLnNTArG0B2wDN5sSdV?=
 =?us-ascii?q?Pdw/kGs0iuV2Q/J8OFLO0U0mLLbK5E/xr4wkYIesUHEHi/rhEX6lqGXeVs/9eS?=
 =?us-ascii?q?y9uvofK3qpp6aN4BqlgHzKroiltGhDegiLAQCQWqW9f6h2LDh50H1XatGguUzk?=
 =?us-ascii?q?qbDsZDaIcobprS+Aw9Qyost7AywDy2l0NQFhnkLNl1LeBaJj4jzOlHOJv/4AOy?=
 =?us-ascii?q?xgluyizhn3e3JMaP5DpXXMnfDiKvhfap660NE1AUzysxQ6I5VCrwaO/LyWkrxt?=
 =?us-ascii?q?MTCARMjMgy0xfznCNRn2Y8EV2KPGPzRDKSHuliD7eMHIu+WZYZTtiyuBeIi4qv?=
 =?us-ascii?q?LhGU6hERVUK2nx5oRZzjsO/18IFiCJ1fojM0AF2gioQc0CuDn3g7RGQVPbmq/C?=
 =?us-ascii?q?vpvrgowD5irWN+rrm+Fn7GLmiu2TMQ+joVuFV2GV3vlJd3ssxYkbSWPPol+nzZ?=
 =?us-ascii?q?CWbXzE+cc?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Az7RmX696GRWe7XsR4Gtuk+D2I+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZOiYlEfBw8Pre5cjztCWE7gr5PUtKpTnuAsa9qB/nhPxICMwqTNCftWrd1l?=
 =?us-ascii?q?dATrsP0WKK+VSJdhEWtNQtsZuIGJIfNDSfNykesS+32miF+81L+qj+zElEv5ak?=
 =?us-ascii?q?859VJzsaEZ2JZGpCYDqmLg=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AHAgASaxphhwwR49RaHgEBCxIMQIFOC?=
 =?us-ascii?q?4MNbDoxhEePSYF3hEiGVoZwigqBfAsBAwENPgECBAEBhFgJAoJrAh0HAQQyBw4?=
 =?us-ascii?q?BAgQVAQEFAQEBAgEDAwQBEwEBAQwNDgg6JIVoDYI1IoNsAwMjFQgBAREnDwsaA?=
 =?us-ascii?q?iYCAlcTCAEBgm2CVQEDM6d3gTGBAYIHAQEGglqCER8sIlCBWgmBECqNcycQgVV?=
 =?us-ascii?q?EgTyCTjA+hERNgkqCZMVOLQeCAIErgTcLnHsGFCaDUwGRdQ4GkRi7VoFnBYIIM?=
 =?us-ascii?q?xokgzhQGQ6OIBmEDIosQDI4AgYBCgEBAwlsAQGJBwEB?=
X-IPAS-Result: =?us-ascii?q?A0AHAgASaxphhwwR49RaHgEBCxIMQIFOC4MNbDoxhEePSYF?=
 =?us-ascii?q?3hEiGVoZwigqBfAsBAwENPgECBAEBhFgJAoJrAh0HAQQyBw4BAgQVAQEFAQEBA?=
 =?us-ascii?q?gEDAwQBEwEBAQwNDgg6JIVoDYI1IoNsAwMjFQgBAREnDwsaAiYCAlcTCAEBgm2?=
 =?us-ascii?q?CVQEDM6d3gTGBAYIHAQEGglqCER8sIlCBWgmBECqNcycQgVVEgTyCTjA+hERNg?=
 =?us-ascii?q?kqCZMVOLQeCAIErgTcLnHsGFCaDUwGRdQ4GkRi7VoFnBYIIMxokgzhQGQ6OIBm?=
 =?us-ascii?q?EDIosQDI4AgYBCgEBAwlsAQGJBwEB?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="398124249"
X-MGA-submission: =?us-ascii?q?MDGXWrn7d4uVDLK1j9HQkBSR9bTa4OM7azwJ8y?=
 =?us-ascii?q?TofVY+0RiyB4zXocS+R/jzAACy6rwB7z0REbRWOrs75GJ3NIc1btVefC?=
 =?us-ascii?q?SRP0HE1ljRGZpMw8lZcaK00d+L6effTTBNxHV7GUqI3KqBvGHs0UbwLD?=
 =?us-ascii?q?2x2rsIXJQJ4bSn507pPi7e5A=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 12:55:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1635940511;
	bh=6G7FAXeVqY19E48o+RTwBlSUJ7JgjZBDz+/Q14l+sRI=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=l7R+nzfNrZRaiSQR1tPGLYPCDVKjnc75UBUI+olObND/rF+Ui3/0YP2CDTFe0+6v8
	 0ALjMwcqqeKhuIWs2ry0be77eyZiE2v2AdjrcMqN6ltZDgqv+0v4RLGyp5FBj1VrVr
	 IOUoS0TzJBWelw6NXbT0iY33CRngSuGr6GwG/WNE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.102.25]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M57Vi-1mXq2T1OAQ-00zC8T for
 <cocci@inria.fr>; Wed, 03 Nov 2021 12:55:11 +0100
Message-ID: <40d3e13c-0b1c-cf12-efd9-007532039d72@web.de>
Date: Wed, 3 Nov 2021 12:55:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <b2aa6f7a-2169-143c-59c4-bab1830126bf@web.de>
In-Reply-To: <b2aa6f7a-2169-143c-59c4-bab1830126bf@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wKAOyPU0o3Rd2z7yYkInb7cUdLoTjs3+palbeNFCapQxsKJ4MBQ
 djGS1bG6vRp1sVAJJFvn41Ws+MeDUSKy6atPz/XLMCPVfiSED7/fjVLUH+THpxoDPMMP15n
 vDgdWalYJnrg1PdMFjK9M0XKQWJVl9cjwZiipF5+KfVWlm6oMllbA3rbVbbYfij1mBmKKu3
 5+614eDnsGpp4y9SfUDZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x1kWIuITh3Y=:65v9YvsFQXvPDBJl5PpyE+
 nNQWTpeaW2u9L1CdlpY/+Tyrl+tXPQzPNltRBSpb9V28mjVlOFfvOD+pUx8icQ7AtcDZCFBZ4
 OIzyfXVSfJEjErkIf7/t4asyDzQ/5oF0ihOqluDf4PX18uG4CbiSx/Mltj1GAFqgNzvF3CF4+
 34KgwD3dQHZ0vpwCkFjCEjpvFEt8HOTyLROfP8eQe24ymklYsdpLL0eH5Xm8bVqf8gNGdRFFU
 Q+vLjUkLxAFGE1k0oEvNTOsSD5Nr6YdgXqexRqT/0jGd8msBBulB3VP1n+pKWYeCyVJdHbIwD
 pqbvSAfbiFFg8HPOJNGEUa9xkkn1FKc6FXfPIsFu1ZmaUCQzq6scdlG/05lFCLZYa3Hurhj4k
 QZXfOoJ9b2rsIfqOhnnqQHTcGFQK2ZDC6iYUMePo5pGOZzX/HKxtAl+Rkdtv/4C8TDnlW5yW4
 UrKojs4CLNkAVk2pS3855er9O+F5sfKdOWvcLAYbe9xRhBLMYyYaeCpQ/pkL5Pbqhm2PTSS3K
 ElFG6HUjDDAPXfpbU/H9uctUb8mWLU7Qjc38WclKp+zWOpOt2+T63czREzbtcoQK8Z/53TakL
 WYlmV4C7xXDl3kKbn9/NS0wUPyYlHq5r8waGWyzHMcvz/9hwHLqM00LffTssyA7+0Vdcwv4na
 jpYZ7W8W1dC6RL5hOxytGO3bxy1ThJNzBkOZxRZi9usUnscNaW1jGCKcjMPldPmUIZMJkauZH
 YHtV3e9UVKhsFp+cpxTqq+4xrDhwDUh+qPcn1iLNNQl5Ld9Cg+/Sxkn9IluKdQ511GpgkxzOr
 wX/bqdQ2ET44ORV+Fz/naq2asix+UrE6UCQDyq3Wn7f8wq+iC8CcHEYDypPIRdwLF6mDAfrC7
 Gwe8Kir9inoMckVwlC+Scilv1CM+4mk7HdOwnGtdv9hnMdcAA4p78nuGNNVNmnr4rOcRg5Cyv
 TvnM05ho5A9Z4XMAKQuqESKWhgs1zps+dGrv40rMU1QZfUG0XxFvz8rEPySlcm//PeCBVyfoy
 kEYeJbOl+8uc/ZnNo9eZqZgJz98q7I2Z0b4BVmy0UIwQQGPRQS6cmt9/a7VmC9L5pp9CS7PSg
 JPJ/WU5Wtv0Dsg=
Subject: Re: [cocci] Checking parts of binary computations with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 59
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/40d3e13c-0b1c-cf12-efd9-007532039d72%40web.de>

> *idex =3D left_ex bo rigth_ex;

Such a search pattern looks usable (in principle).
Source code places should be found then where one binary operator is appli=
ed
at least for computations so that their values will be stored somewhere.
But I guess that it is unclear then how many code would be matched by
the metavariable =E2=80=9Cleft_ex=E2=80=9D (and/or =E2=80=9Crigth_ex=E2=80=
=9D).
Is such a system detail improvable anyhow?

Regards,
Markus
