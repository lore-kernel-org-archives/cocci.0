Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC8FC433F5
	for <cocci@archiver.kernel.org>; Sun, 13 Mar 2022 15:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=L0NuqLk73DSLCsB9gVC9JJ8YutdBwSqucvED9k9U4wg=;
  b=pkuItgg5eJF6ZKCtAcYaU0qEfHSw/QAurszmXJfHUqAy38T1KvQtwSsO
   89/H3srj2tDweCjTlESHKxawVAPV71JuEKZR0cNc+egCsCmUhVBxqfBOt
   5Z4/oAI8eBlu+TaBvXCT3zbY0HFdui5cuJ8eyFof54TCqWo+kc8gT+AM9
   E=;
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
X-IronPort-AV: E=Sophos;i="5.90,178,1643670000"; 
   d="scan'208";a="25863831"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2022 16:36:33 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C3A39E0048; Sun, 13 Mar 2022 16:36:32 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 96305E0045
	for <cocci@sympa.inria.fr>; Sun, 13 Mar 2022 16:36:28 +0100 (CET)
IronPort-SDR: v8U7F3viEyt+7mFQWRkukkOFVfpo3X5JFCLzwkGSWv7AtG7PkeeYYFiWOSJDrcYOmKDoRxRioL
 SpHqBVqIK7YfCbD6YnZmHMjYZ+4huVBFieGQXIlu2v9+Sg0HEcTDYTPa/771xqOLRnM3AVoaAK
 zJ3D3PvuT0HijAeBoUWPMqvCJu8osU/xXq+p558zDgYdx77wFFyzZ9RqiSQgPwUaex5qSfohCr
 SiGM4IuBdEhb7Fyipi5Z+jLP1IdoSnOMSIVkhi4D49clZXJ6CQZQrM3Qc4U5gwQbUX1zv+SKA0
 CWe3XpvEiSE5gqekvnWxfIEt
X-IPAS-Result: =?us-ascii?q?A0A0AgBhDi5ihwQP49RaHgEBCxIMQIQCflcrBAtEhFSQa?=
 =?us-ascii?q?i4DnHOBaAsBAwENOQUBAgQBAT2BVYJ1AoQkAh0HAQQ0EwECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEDAQEFAQEBAgEBAgMEARMBAQEMDQkFCAoHDhAFNgZeBmQEgUsEgXQLN?=
 =?us-ascii?q?A2CNSKDbAECAgEjBBkBAREmAQQLCQIODAImAgJXBg0IAQGDAAGCZAEDDSULk?=
 =?us-ascii?q?iucDH8ygQGCCAEBBoE/ARNBgjQfLCJSgVsDBoEQLI5IJxCBVUSBPAyCQAcwP?=
 =?us-ascii?q?oJjAQECAYEoARIBIYMagmWXCwJgLSwJghegU556ejQHghKBOoFAC4k/lEwGF?=
 =?us-ascii?q?C6WOg4GkWmWV40TlgWDY4F4gQ5wMxokT4JpTgECAQINAQICAwECAQIJAQECj?=
 =?us-ascii?q?h0Zg1kzgQuJIUA0AgktAgYBCgEBAwmFRwEBjRwBAQ?=
IronPort-PHdr: A9a23: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
 uU=
IronPort-Data: A9a23:mtGd76xp/0iM8mN1W+x6t+dOwCrEfRIJ4+MujC+fZmUNrF6WrkVWy
 mBNXm6HOPfYZGT9L9AnaYy0/EgH6J/cnddqTwpkqlhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefQAOOU5NfsYkidfyc9IMsaoU8lyrZRbrJA24DjWVvW4
 Iiq+qUzBXf8s9JKGjJMg068gEg31BjCkGtwUosWOJinFHeH/5UkJMp3yZOZdxMUcaEIdgKOf
 Nsv+Znilo/vE7jBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XOdJEAXq7hQllkPh7k
 fp/uYCQTT4oP6vOyP5DXzAGNQxXaPguFL/veRBTsOSWyFDaNWThybNiASnaP6VCo7wxWzsRs
 6VFbmxlghOr34paxJqeQ/Nvm99lAc3lJoIZtVl/wDufAftOrZXrE/mSvY4CgV/cgOhCTOvUP
 eElNgZwR0uQPj5ECk0rM9EHybLAan7XKmAE9gvM+8Lb+VP7xwt627nFK8vQYtXMRMNPn0/eq
 HiuwojiKhQdKcDZ1jePtH6h7gPSoc/lcIhLO4+06t5uuVySwG5DEkMafAWdjNDs3yZSROljA
 0AT/yMvq407+0qqUsTxUnWEnZKUgvIPc4cIT7ZgtGlh3oKLs1/JXADoWxYcMIROiSMgedA9/
 nOk9z8DLRlotqGcQ3uA7N94RhvvZ3RMdQfuiQc+TQYE5d3qpo12thzGSsQLLUJYptjyBC223
 D2A6iQz71nysSLp//Xllbwkq2vyznQscuLTzluONo5Cxl0gDLNJn6TytTDmAQ9ode51tGWps
 nkegNS55+sTF5yLnyHlaLxTQO7wvq3fbWaN3Q4H83wdG9KFpC7LkWd4v2AWGauVGp1bEdMUS
 BKP6F0Kvve/wlPwMf8qPOpd9PjGPYC5SIi7D6mKBja/SsE/LUeG+j1jf0idwyjknyARfVIXa
 f+mnTKXJS9CU8xPlWLoL89EiOND7n1gmQv7GM6qpzz6gOL2TCPEEt8tbQreBshnt/nsiFuOr
 L5i2z6ikEg3vBvWOXWMrub+7DkicRAGOHwBg5cOJ7DZfVY+Rj1J5j246epJRrGJVp99zo/gl
 kxRkGcBoLYmrXGYewiMdF55b7bjAcR2oX4hY34zMFzu13V6OdSj66IWdp0We7g79bU/nKAuE
 KRfI52NUqZVVzDK2zUBdp2j/oZsQxScg17cNSSSZjViLYVrQBbE+4O/cwa2rHsOAyO7uNEQu
 bql0g+HE5MPSx48XtnbYrSjwgrp73QanetzWWrOI8VSIRm9rtI1dnap1vJuepMCMxTOwDeex
 j26OxZAqLmfuZIx/fnImbuA8dWjHdx+KUwGTWPV2rC7aHvB9W25zI4cC+uFcGyPVG7w/6n+N
 +xZw+ulaa8Cm0tW9ZVxGfBnwPtmtdfoorZbyCViHWnKNgj6VOk/fyPehcQf5LdQwrJ5uBetX
 hzd8NdtOYKPZJHvHmkXKVd3de+Ez/wVxmLf4KhnOkn8/yMrrrOLXV8LZkuJjzFBaqR4OsUpz
 L556sIR7gW+jDssM8qH13wFqT7TcyZYC6h35IsHBILLixYwzg8Qa5LrChjwvMOFZeJKPxR4O
 TSTnqfD2+9Ry0eqn6DfzpQRMTexRKjiuSymCHcHIEmV3MXIjLk70XW9NNjxoht9ln16PyBbY
 wCH9HGZ4Y2R8j0uiMUrs6WEBVRaHBPAkqDu4wJhqYAaJnVEkkTSIWd7NevlEIX1NY5DVmAzw
 Yx0A1oJndonkA8dE8fytYNYRyTfcOFM
IronPort-HdrOrdr: A9a23:SXZgRaNBpz7hk8BcTuWjsMiBIKoaSvp037Dk7TEUdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YET0EUMr3N5DZB/KTHCUWDcurJ27O8gduVbArlvg1QpTgBUdAc0+/zZzzwLnFL
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,178,1643670000"; 
   d="scan'208";a="8400925"
X-MGA-submission: =?us-ascii?q?MDFzxrgy2a0wAYqmH+3wInKGvSCSiwoQwg7EI6?=
 =?us-ascii?q?52CvKbbD3JEGE/Y0dGYxVUafXRPDhjFa3kkD7MlgOBLcFAW/tF6HuWV7?=
 =?us-ascii?q?ThsyOll53zXl8SitA4N5oS3SbTOKeJorESguucLRMHgRLiEJfE2m3ZDH?=
 =?us-ascii?q?YEJKL5YHcyxO4s812y8Vze+A=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 16:36:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1647185786;
	bh=NEeP3JYLg/fmaMcOIPC3JhdTEIS6ElXjqgK3lG/7Pn8=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=D/ZJW0WPamFgdeEmEEW1AB+ezB89+84+LH/f1hcJevKLCwoPx4jjGnfXyWARjiXsq
	 nOMR6YHCLACvptDHWrbKuDSHkvWza40vgRKk6Ggk/5tgtT3B0B1ABh4XfF5AZgERRP
	 Qlc6wY90GGtWOUPl4fSFe+UWTLgs02Ym+4e+J/zw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.179.181]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIc3F-1nOFBv2TFl-00EX2I; Sun, 13
 Mar 2022 16:36:26 +0100
Message-ID: <d11cb479-55a3-60ae-3355-9e46074cf191@web.de>
Date: Sun, 13 Mar 2022 16:36:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Eric Wheeler <cocci@lists.ewheeler.net>
References: <44139568-4c27-7ae5-75b3-f9c9c2d88a73@ewheeler.net>
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <44139568-4c27-7ae5-75b3-f9c9c2d88a73@ewheeler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DR1jBajJWLzp89J5Wt7NHgnYBVYTPtnSx6wz4IMEU2Qvf7LXpge
 LjQ4hsZsvbCcKPMZqTabmbHAHZhklhtsNUt9h/8/kcilj/eA3iAf6STEXXH/MeObx2XDFjF
 YUJTNYkI5XqajYnM/fq45weiissf0DotF6OCEKeunPE5s88rFQ4ZS/e98c216s1eWqoKhBi
 5M9/qEh9LGWDFPInft2EQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r+/avSOeRms=:0tjCMxGcS/cQpjGNxQjCoo
 P3RQ+BZVijHeq5lBhyibCOJDVDQFN/RPycwz4BlgwycFp9EuSvsltftZcUsC63+33uZqAcmuU
 LdYNeNk77657Dn3vgEmuhbCsdtd6sPI1oDXXY4bEv+OslcRx4vh1fv6Tv4Ht6RMmiHkPp8j6w
 IgLeMPmUvsrNsXFAkjRWdKaxBXKgKahoQ56YiamZXUXyS0B3GYPjbFtCJ1nh79gwGXENcGF9A
 LdhfG0yTYv360pEag479vSq8IOqY7IVyFT7lrSvLT9sT/Bv0YV5D82Pv7YvIigZc5W8i856HM
 b6CeS5uMPUtBL4w1Ib7u3Hn+L2R6nsmT8xBRgC/83jQLeri0PEjhdWL/YOjn91rUDQ9BCfJxZ
 Ko4KNJrjEg6CKxlsAovckNsrXpRyfzGNb7l9ltFxNAEVJ29UubSoy3KBntMKIDPy4DQE5fUQv
 TEw9iNRNHRHqk9IiA1zcACfVoq6/vKH4ZI1kiUPbdX0n9mg+Ykw29FI6o6WZox5oklr+2TWxA
 O3Iw5uBeyOR0nL457XNcCom9ReBpXaCAQPIEZgvtA41gWrYOqmcBpZI6qOhggjXUtA1rj3iIW
 IgV0sdPNgwiC3HZDoYYn9jAHMr6NGzoHRhrCHJUtyWr8LpBec9/KGeGnpndDlB0KkQ9wWcQKZ
 I3kZSivQQKrt1c6Jw7BuFgT1NKPR8SOGRlSz77cqdilZhwB6nK2MD8JYqFO02/QYGII32FrVN
 OjPE40nydWmRtgCSEjrFX+oUdbQOG/5PqP4hekgjwI4yx4tyZ85OVO0hzetsiSoZI8tyhNntp
 dxbE/N09CBxJMudp505scl56Wng6dY3ImdxkilZ9Hyw2Ok53iDGkoV6VljjMXNnjJMT4/na1Z
 TRIffgTs5LzznosqhxPjTWPv2g5FTHrT/tgDYcfUD/Z50l3lp7qLGpuFnNQehkVN/5SH99XzG
 f3nkJn+XmDBcQSqA9XWvkOo26/Hr6Sz09rXoJxHV5YU0zPKfqSdT8TkPox06mOXXS/9QKYRr7
 HbyvEgFyTXw+Il3TIx3jui+y/WnXItjAGUCMI3GJzArzE75VRL4cnJCL99ZoquaWLfe8lHs32
 Zc6BQwdmAZ18xo=
Subject: Re: [cocci] How can Coccinelle operate on a series of else-if
 statements?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 218
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/d11cb479-55a3-60ae-3355-9e46074cf191%40web.de>

> Side note: see the other email about string concatination for the "%n"
> part, but this email is about handling else-if's, so I let (for example)
> "%d%n" remain "%d" and just name it metavariable C in this example:
>
> 	@ verify_parsed_vars @
> 	identifier F =3D {parse_var};
> 	constant C;
> 	type T;
> 	parameter list PL;
> 	@@
> 	F(PL)
> 	{
> 	    ... when exists
> 	    when any
> 	    if (...) {...}
> 	-else if (strcmp(v->format, C) =3D=3D 0) count =3D sscanf(line, v->form=
at, (T)v->vars[0]);
> 	+else if (strcmp(v->format, C) =3D=3D 0)
> 	+   count =3D sscanf(line, C, (T)v->vars[0], &check);


I suggest to reconsider the change specification a bit more.

I would like to point out once more that adjustments can be concentrated o=
n
source code items which should really be modified.



>
> 	    ... when exists
> 	    when any
> 	}
>
> This works for the first occurance as you can see here


I guess that your understanding for the functionality which is supported b=
y
the Coccinelle software is still evolving.



> (even though the formatting gets clobbered, which I can live with and ca=
ll `indent`
> unless there is a cocci fix for that):


The Coccinelle software is occasionally struggling with pretty-printing
for adjusted source code.


=E2=80=A6

> but there are several more else-if's in the series in the same format.


I suggest to take another look at possibilities for the repetition of elem=
ents
in SmPL search patterns.
This functionality is described in the documentation section =E2=80=9CDot =
variants=E2=80=9D (for example).
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/20fdb67f4b20a242f2223=
37e13091115884cf6bb/docs/manual/cocci_syntax.tex#L795
https://github.com/coccinelle/coccinelle/blob/ae337fce1512ff15aabc3ad5b6d2=
e537f97ab62a/docs/manual/cocci_syntax.tex#L795



> I would like to do the first 'if', too, but I can do that by hand if it =
is
> inconvenient to do in SmPL.


How many development efforts would you like to invest for automating file =
changes?

I imagine that your views and expectations can also evolve further for dat=
a
processing conveniences and corresponding transformation safety.

How do you think about to increase the distinction between compound statem=
ents
(or code blocks) and the others?
https://en.cppreference.com/w/c/language/statements#Compound_statements


> Thanks for your help understanding SmPL+else-if's!

Do you get any further development ideas from a SmPL script variant like t=
he following?


@verify_parsed_vars_2@
constant literal;
statement is, es;
type cast;
@@
=C2=A0parse_var(...)
=C2=A0{
=C2=A0<+...
=C2=A0if (...)
=C2=A0=C2=A0=C2=A0 is
=C2=A0else
=C2=A0=C2=A0=C2=A0 if (strcmp(v->format, literal) =3D=3D 0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 count =3D sscanf(line,
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v->format
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 literal
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 , (cast)v->vars[0]
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 , &check
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 );
=C2=A0=C2=A0=C2=A0 else
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 es
=C2=A0...+>
=C2=A0}


Regards,
Markus
