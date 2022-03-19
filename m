Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8491EC433EF
	for <cocci@archiver.kernel.org>; Sat, 19 Mar 2022 14:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=KE6zXccsWzDUTz2b9DoeOm23KiGAnUO9D6NeafUtR+w=;
  b=mO5HGzGWVdb3f/J4Ov/AZSQtQvYa9GfXYJx5FJx/WSwNFbNDozosft9N
   KEftNmjz8CN8t1eoNdPJyS/D4nW9oyxnJglcwZJX+QXQxwNMb3U9Xc/XK
   NfsPtSZf7GZ1U9WaNoyCVfcJWcDfi5J1eLwHs/RdHqERUNW4ABxouC9D9
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="27008812"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2022 15:53:40 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 714E4E0210; Sat, 19 Mar 2022 15:53:40 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6F8C5E0069
	for <cocci@sympa.inria.fr>; Sat, 19 Mar 2022 15:53:36 +0100 (CET)
IronPort-SDR: 5hUndEzvlnAL3VG7y6JzXFOS575vGTTkcvOQv2IwCTiLqtqePVVcs1fE4aB5Vu1aLGJ7MkMQO6
 xmuM22I0QoOmXQOPzGlqZOLU+B2uwx9lA4hGFwnrpIraNfkFWn2uT3bpSUKwZlxE+mSyVbb3/J
 RqP6AsXCwh6N5QXlO1tt//5TQe6m5hQbhn8jStdV9BFa6M4O2vFooCmYrcCUb+ZeQR+MINrl/1
 6LRfsRBd7zdq+5Zvp8M8nE6oS2MKSWM9cVg+i/91OqVThQrRnpl8DkRG4wIZYhijPH8njd9DU6
 JHx62hnvCx8si45aU9fvVEG7
X-IPAS-Result: =?us-ascii?q?A0DpAgA67jVihwMP49RagQmEAn5XKwQLRIRUjnOBd5Jth?=
 =?us-ascii?q?EaFYoF7CwEDAQ0SAQElBQECBAEBPAGBVYJ1hDYCHQcBBEcBAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBAQIEBAETAQEBDA0JBQgKBw4QBTYGXgZkBIFLBIF0C?=
 =?us-ascii?q?zQNgjUihBUdAQERJgEYHAImAk4eCAEBgwABgmQBAzILkVycDIExgQGCCAEBB?=
 =?us-ascii?q?oE/ARNBSIFsHywiUoFbAwaBEIZAFEKDKoM7gSEQgVVEgTyCU4NRAQECgiuCT?=
 =?us-ascii?q?YJlmHRZlQ+tYDQHghKBOgWBPAyIJYEdlE8GFC6WPQ4GkW2FU5EIjRWUNYU4N?=
 =?us-ascii?q?YFWA4FoMxokgzhOAQIBAg0BAgIDAQIBAgkBAQKONh6DOzOBC4khQDQCCS0CB?=
 =?us-ascii?q?gEKAQEDCQGBVoNwAQGKBQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:0SbpX6tv8r21Qi3qWjuKfy8WSefnVC9YMUV32f8akzHdYApBsoF/q
 tZmKWqOPKrfMzCjfNggOtyzox8Aup6DxtVlQQs+qy0xRH4TgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTraCY0idfCc8IMsboUsLd9UR38g52bBVPyvX4
 Ymo+5aGaQf/s9JJGjt8B5yr+EsHUMva42twUmwWPZina3eD/5W9JMt3yZCZdxMUcKEMdgKJb
 7qrIIWCw4/s10xF5uVJPVrMWhZirrb6ZWBig5fNMkSoqkAqSicais7XOBeAAKtao23hojx/9
 DlCncWKTwcyMYrMot4EUwZRMjllZ6capJaSdBBTseTLp6HHW37r3ukoE0w8e4EVkgp1KTsXr
 7pCcm9LN03F3Ipaw5rjIgVoruEqNsr2J8Uyvn96zDfWJekrS9bPTs0m4PcJhG1h3Z0WdRrYT
 4kTaAtIUC/lX0VgG0sRE5hkrrqK3ECqJlW0r3rM+PZpujGNpOBr65DmN9Hee/SRVMBNlwCZo
 HjH9iL3GHkn2Me3zD2Y7jSzi+WJkS6TtJ8u+KOQr8RsgEac4WwpMgQWSlKaueLjgBLicocKQ
 6ALwRYGoa83/U2ta9DyWRykvXKJ1iIht8ps//4StVnRkfCIi+qNLjdUF24bADAznJJuHVQXO
 km1c8TBKREHXFe9bHWb6r6epC6oUcT+BTJcOXZcJefpy+PjrYA1ihvJQpNbHqexnLXI9dzYx
 jeXsG4hir9VgcNjO0SHEbLv02/ESnvhF1BdCuDrsoSNsFoRiGmNOdXA1LQjxawcRLt1t3HY1
 JT+p+CQ7foVEbaGnzGXTeMGEdmBvqjZb2CC2QMxQcl+q1xBHkJPm6gAuFmSw282Y645lcPBO
 xC7Vf55ucMCYiDwBUOJS9jsUJ5wpUQfKTgVfqmJMoQXO8YZmP6vpW83LU+Ww233lkUw2agwU
 ap3gu78ZUv2/Z9PlWLsL89EieFD7nlnmQv7GM6npzz6j+v2TCPEEd8tbQrVBshkvfPsiFuOq
 b53aZDVoyizpcWlP0E7B6ZIcQtVRZX6bLiqw/FqmhmreVM3Rjt+V6ePndvMueVNxsxoqwsBx
 VnlMmcw9bY1rSOvxdyiZi8xZbXxc4x4qH5nbyUgMUz2iWcua8Cj4f5HJZcweLAm8s1lzOJ1F
 qVUJZ/fX64XEjmXqS4AaZTdrZB5cEr5jwy5Px2jPGo1calmSlGb4dTjZAbuqHIDA3Pv58szq
 rGtzC3BRp8HS1gwBcracqz90F67+3QQwbogU0zNK9hVWUPt7Ikzd32v1KBqeZlUJEyalDWA1
 guQDRMJnsX3otc4oIvTmKSJj4a1CO8gTEBUKGns6+rkPyft+Gf+k5RLV/yFfGyGWW75pPeia
 OFSw62uOfELhg8T4Y97Dqot0q80odfi/ucIwgNhFXTNTlKqFrI5fijYh5YS7PUVy+8LoxayV
 2KO5sJeZ+eDNvTlJ1hNdgArWeKOiKMPkT7I4PVpe0j3uH1t8LycXRkANhWAknUEfr5yLZ9j3
 uor/sIbslTthh0vO9eAryZV62XVci1eCfp67MlCDd+5kBcvx3FDfYfYVH387qaPXNMQYEMkF
 TmZ2fjZjLNGy0ueKHc+GBAhBwaGaUjiZfyL8LMDG7hNst/Cm+NxwxBbtzg6JuiQItOrzMorU
 lWH9WUsTUlNw9usrNdOVSagFmmtwTWHr1fpxQJheHLxFiGVu6+kEIH5EfmA9gYV/gqwu9SdE
 K6wkA7YbNohQC09Mubel6KoRzwPgOGdLjH/pf0=
IronPort-HdrOrdr: A9a23:1/M3kKOkM+t2nsBcTumjsMiBIKoaSvp037Dk7TESdfUnSL36qy
 nIpoV86faUskd3ZJhEo7u90ca7Lk80maQFhLX5Xo3NYOCFggeVxehZhOOO/9SKIVybygcy78
 ddmuRFaeEZFjJB/L/HCeSDYq4dKODsytHSuQ9Uok0GcT1X
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="9029350"
X-MGA-submission: =?us-ascii?q?MDGf+xia9G/b+JQKlSfPYd08/jBi1Iu79SaTer?=
 =?us-ascii?q?B+kWFcorPBeXPMVyc4s1cVDK3kOOc7PgyFXP8fYd+xP2W6dQf2Si/10x?=
 =?us-ascii?q?YdZhtQih2FVzmYJbB7PNOoURGlJhLdDKZyQG4HEPt2sSC/Zwjt/OC6GB?=
 =?us-ascii?q?Ny0D8M8VZ3f5byHq7rMQIFJw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 15:53:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1647701575;
	bh=KE6zXccsWzDUTz2b9DoeOm23KiGAnUO9D6NeafUtR+w=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=T4/VVSpZFbWAzP2DmUzqVkc3F4zgg5KIWibzmg5tYuVINcUqZndYdWydMi1Nmmmv+
	 TbL4ha5CuHjTfA87CNXMowGZWmy0hQyqHO8OJI0yCjoFQenMTwdUOKMc9xm9qCQEGZ
	 WsySGE8cMUJmHZ7Fe+k2VmGqotUcPI09vrOZQf3M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.182.172]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mvspv-1oLLaT3lH5-00saty; Sat, 19
 Mar 2022 15:52:54 +0100
Message-ID: <458b35d6-7ca5-e98c-60fb-196c3ea3dc08@web.de>
Date: Sat, 19 Mar 2022 15:52:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
To: cocci@inria.fr
Content-Language: en-GB
Cc: Luis Chamberlain <mcgrof@kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hcOEbzSfVq36PoVpXoYku8PWuEigwOBw0CNEuGI+P4EWdh5RrSS
 fDxrn30QT21DbI/QcalCpAsI3lXidwFO8cMA/QjJQIv0YK+YtxROjZONRFdRUjnqeYaEjlr
 xkZP5EIczXzZ68Y+CmqrTsnLIt3gHEhU9HAuTNGGhAUsuJHxxKC91/T29rxh4u2Zw8xz5qd
 wnEEsBpOyNlBrC9wHiN4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G62nllLz7OA=:KL8P0tdjb8tCm/nnNalx5P
 pRUHK/cqckgHuzcCeuoaYfi9DzDUccfzOxXg3laq1ueqbsUyHHrwxkmzEZElMPEt/qq8QeBqi
 lodjrvaETOkhvYuOMKTCkYzsuYY8Wdyg+7U8oBjkA9ssnVYivLIWYJKacr5H9qeFXbI1QYdyJ
 d4qruGYCZnqOt6r3o3U3v8S2X5Re+4IZDRfuMAQhvC5IsEKbHFB94nEvDHqZeiK70tJvpxrnG
 Y/FSfUAu8zJTkF/Exj1gfUyS6C4GF0/7FU1cdGDrIzKQ0ZklqIBUwdb93VTtfygdcp2M4F/PZ
 2VarDMdi12yYf6OJ40ZOU5widyp2bcNnMkVEFyXfCcVODxpAaGLgd5KK8U7EiR6bmwkysUq38
 OgPHOot0ZB77h+XS1cgszXk+JB17/aWwissvOy/aEgdK+Ggjn+uE9Zk03TaDTJNIMQSq/x6hD
 QWgpJVVJschZsGzN/W2VNBOvQrG5SfvlQCr9mPBmcpNNIO4sPUbBCafByhxZrsHqEwCVfuF23
 0mwNvByh/oMrrlb9PHvwzDH6/GklwVcaYgeDCZtvVE1wglZNmTIOmkxSYCNA9ySAUQ/2/1Uco
 XJMhN0H78PD9ncSZahfQwxq1Hb2B74zUEE3Jja0M+ONWObLHf6iBCjSE99hrdwSQXq8++T97t
 ksEsYUsgrVfp9sCGFK4te+k09BMGHOal97RKTrYllZcRmndTpHFpD/Wwzte7y+zEN1TtCHMnJ
 DUVNSAPWH7fM2ILuAWwiurhS/Z8JN3dGQ1+jMzT5Uwwm9jhZni5PWIhjrFhb64HC/rGgwmyiW
 qhSIIJJ+9jesHEmZqVSb3LuUheZFy+9bTCfiHDxtIvIlVJUeOYsFwPdq4m34w50OTCRJRlxIF
 gm15A5N7otwp8V3og4B+NrGWuD0tvzrTlQOyScbYt4roxSA5QI1dOOGpMqHsuMfkvpgEGc2rw
 qVecJU4bMz0aXQ2vAaCsZb3LDgqDKfRxfVLLBvMJkIEJxbdT1KkDKFy2kivxJEJKVL8VD4CWH
 PtIkEK89MGSXi3gC26Pjl4zsZcuvjtxYN9kYuiT0hhDxs4RIGplyhIgrS7UYjGDw8846OGkH5
 ZW9O5e2T6JsrbE=
Subject: [cocci] Adding another metavariable type for the construction of
 =?UTF-8?Q?=E2=80=9Cfresh=E2=80=9D?= source code?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 243
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/458b35d6-7ca5-e98c-60fb-196c3ea3dc08%40web.de>

Hello,

The software documentation contains the following information at the momen=
t.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/20fdb67f4b20a242f2223=
37e13091115884cf6bb/docs/manual/cocci_syntax.tex#L292
https://github.com/coccinelle/coccinelle/blob/ae337fce1512ff15aabc3ad5b6d2=
e537f97ab62a/docs/manual/cocci_syntax.tex#L292

=E2=80=9C=E2=80=A6
=C2=A0 \item if a script is given, then it must return a string and the re=
sult will be
=C2=A0=C2=A0=C2=A0 used as is
=E2=80=A6=E2=80=9D


I imagine that this description would fit better to a metavariable type li=
ke
=E2=80=9Cfresh source code=E2=80=9D (than the type =E2=80=9Cfresh identifi=
er=E2=80=9D).

Do you care if such metavariables can be applied in a type-safe way
according to syntax of supported programming languages?

How are the chances to extend the Coccinelle software accordingly?

Regards,
Markus

