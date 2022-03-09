Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03910C433F5
	for <cocci@archiver.kernel.org>; Wed,  9 Mar 2022 18:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=pRNnV5pVm6/7DQUxOsr0a71iv/UItU8Zkyu75rjSHus=;
  b=kupujkTwt3n7HIfNC4bG3kIZx45IEx3xevA0esBuPFndO+r/mx+lOAat
   SuIkv2FtdX3pMvN8eD8J+lMxozb8ydZVne3++tgFN0HUrTDRmsQue4fTb
   AOqWNhre1hob964pfMlVHhNEZPrJ798phkQqIAxFWeLhqW3xf6o3kEvgS
   g=;
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
X-IronPort-AV: E=Sophos;i="5.90,168,1643670000"; 
   d="scan'208";a="25316072"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2022 19:38:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C6C37E09B6; Wed,  9 Mar 2022 19:38:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 22C25E004D
	for <cocci@sympa.inria.fr>; Wed,  9 Mar 2022 19:38:27 +0100 (CET)
IronPort-SDR: BrBO6ydBZgclRIAijJn8Fui8iWDQsFk0X7Icssp5MDDhJe/MvPgo0K9337sToGGYPvO8KEx3w8
 3jnuJk4emNBXmgMUZ38c1VOs27i8ZF1gejvMDUQ8RH3kP/ZDVDiyh/Dxn0M8G/HLH+6NLNvbv/
 Dv5fDy4+xdGdddeJWVXEx1NQ5tzfVCPTf1/fdvPNA7l6wRUoPsuSgMuSwh8eDwJ4/ZMT2qSi6Y
 Rba89eT2wdodaTxAvoQRzTW76ftRHcThPuwszBdS7rekR851tQSdQTyeHG/SXDguLz1jMfM7BZ
 2xFpZZ06AUzdTAzIMg4eXk2V
X-IPAS-Result: =?us-ascii?q?A0AaAgDA8yhihwwR49RaHgEBCxIMQIQCflcrBAtEhFSQa?=
 =?us-ascii?q?i4DnlsLAQMBDTkFAQIEAQGCEoIwRQKEIgIdBwEENBMBAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAwEBBQEBAQIBAQIDBAETAQEBDA0JBQgKBw4QBTYGXgZkBIFLBIF0CzQNg?=
 =?us-ascii?q?jUig2wBAgIBIx0BAREmAQQLCw4MAiYCAlcGDQgBAYMAAYJkAQMNJQuuQYExg?=
 =?us-ascii?q?QGCCAEBBoE/ARNBgjQfLCJSgVsDBoEQLI5IJxCBVUSBPIMDPoJjAQECgV6DG?=
 =?us-ascii?q?oJll00tLCJ+gR2gNJ9zNAeCEoE6gUALiT+NZYZnBhQuhDqRfw4GkWWWVY0Tl?=
 =?us-ascii?q?EQKdYQjgXiBfjMaJE+CaU4BAgECDQECAgMBAgECCQEBAo4dGYNZM4ELiSFAN?=
 =?us-ascii?q?AIJLQIGAQoBAQMJhUcBAYwmAQE?=
IronPort-PHdr: A9a23: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
 nO6RjFGvFys1OWCmGMPuP9mtTtBwo6G7x0KBA==
IronPort-Data: A9a23:9WSClqw63qlrTowmYpd6t+c4wCrEfRIJ4+MujC+fZmUNrF6WrkVUz
 mEaXjyPO6mKY2b9f9lza9nl8xwFvcfXmtRmGQZq+1hgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefQAOOU5NfsYkidfyc9IMsaoU8lyrZRbrJA24DjWVvW4
 YKq+KUzBXf8s9JKGjJMg068gEg31BjCkGtwUosWOJinFHeH/5UkJMp3yZOZdxMUcaEIdgKOf
 Nsv+Znilo/vE7jBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XOdJEAXq7hQllkPgp6
 PlnuoPgRztxFZPglsUaVDJmEDBHaPguFL/veRBTsOSWyFDaNWThybNiASnaP6VCo7wxWzsRs
 6VHbmlXBvyAr7reLLaTb+B2hdk4auTvMpkevH5I0jzTS/orKXzGa/+XvoYGhGpg7ixINffMO
 ZI+YDZvVxfFQiZNHwgpGq8XoM790xETdBUB9Q7L/PNpi4TJ9yR617PmMfLOa9mSTINUmFyZr
 yTI5QzE7goyMduC1Xya/3jqiuKncT7HtJw6TJ2U3PF10FOvnkctJBM3UlyQn/qosxvrMz5AE
 HA89i0rpKk00UWkSNjhQhG1yEJoWDZDA7K89MVlsmmwJrroDxWxWzBYFWQdADAynJBmHGxwv
 rOct46xXVRSXKuppWW12pr8QdmaHC8TMWYIbDIeJefuy4S9/Nhr5v4jZuxjHa+zitTzFXTIz
 TmOvkADa1g7iMkWy+Ok8FqBjz/ESnn1ouwdtlm/soGNt10RiGuZi2qAtAmzARFoctzxc7V5l
 CJY8/VyFchXZX13qASDQf8WAJai7OufPTvXjDZHRsd9qWvzpyT7JdsLuVmSwXuF1O5bKVcFh
 2eD4WtsCGN7ZyTCgVJfPt7gUJt0pUQePY6+Bq+KBjaxXnSBXFbaoH83PBD4M5HFyQZ12aA5J
 ZqBd8uwRX8VYZmLPxLmL9rxJYQDn3hkrUuKHc6T503+jdK2OSDJIZ9YbgrmRr1otMus/VSOm
 /4CZpvi40sECoXWPHKImbP/2HhRcBDX87it95cIHgNCSyI6cFwc5wj5mupwJdY6w/wLyo8lP
 BiVAydl9bY2vlWfQS3iV5ypQOqHsU9XoS1pMCoyE0yv3nR/M4+j4L1BJYQ6d/8r+bU7n/JzS
 vAEfeSGA+hOE2iWpW5CMMOl9IEyJg62gQ+uPja+ZGZtdZBXRzvPpo3ucDzp+XRcFSGwr8Y//
 +at21qDE5oOTghvFujMb/erww/jtHQRgrwgQEbCZNVeIR2+/I9vIi33r/k2P8BVdUSdnGTHj
 V7ODE5B9+fXooIz/N3Yvoy+rt+kQ7lkA05XP2jH9rLoZyPUyWqUx9MSWui/ez2ABnj//7+vZ
 LkOwvzxbK8HkVJNv9YuGrpn1/tntd7ouqMc0QluWnnGNgz5BrRlK3iA/M9OqqwUmu4H41TrA
 BrX94kII6iNNePkDEUVelgvYNOD4vdIyDPc2vI4fRfh7yht8bvbCkhfY0uWhCpGIOcnOY8p2
 7546ssR9hD5lRcgdNqL13gG+2OJJ30GcqMmqpBDXN610FV2kAkabMyOEDLy7bGOd85IbBsgL
 AiUs6ye1b5S8UzPLigoHn/X0OsB3pkDtXimFrPZy4hlRzYEuhM24PGV2TEwUxgT0RhNle5+U
 oSu24uZOo3WlwqERuAaN4xvJ+2FLAKU8Ar9xjPlUUXHGlKwWDWlwHIVYI6wEYNwz46YVidW9
 veUxQ4JlNoskN7ZhkMPZKKulxAvoRGdOOEPdABL0vlpx6UHXAc=
IronPort-HdrOrdr: A9a23:XR2Is61j9fLZDU2wq8BsUwqjBJYkLtp133Aq2lEZdPWaSL39qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrQdKZW8kZxBno3lvgxQpOxRGttdBz4SMHfnLqX8KTMtOaYE
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,168,1643670000"; 
   d="scan'208";a="25316058"
X-MGA-submission: =?us-ascii?q?MDHSCvpzDJxwnuIeysWWb4g8NYvL9MD+b+BlA7?=
 =?us-ascii?q?NPrRpB+PZEhNcSZ7aTEw5LevGYtjYsNBF8+WGhxeWGAqr5OXWtP3Mcs+?=
 =?us-ascii?q?TZUxRiWiYlGQs+vPwU0rWncb8GCq+tLHJMIcHqg2sctt/Buc1zErviP8?=
 =?us-ascii?q?pG09NHR74CRnRDZ1ItW8B4xw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 19:38:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1646851106;
	bh=HtFlnDdAM8PMy83y/NF1UqoMin998s2i4+k++/c+OoI=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=F2ZzDJiFiWkSP25e43h6iywZA9FEaQu/iFllbWx6yyAkOmsgBIYij+15v+HsrEBXL
	 5/VMAaBppu2QTfx6+G20pgA7z9ygmF+lGtd+5NmDHfO+EujyjpoCKuj/mGux930tet
	 e/TWznIVxWfYP12BooPSQp2uaYBWQUJYyjjBlxzM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.114.231]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mpl0p-1nvoB23d9B-00qA2y; Wed, 09
 Mar 2022 19:38:25 +0100
Message-ID: <f79b9c33-f5d0-7d38-06bd-fde9f9e089d1@web.de>
Date: Wed, 9 Mar 2022 19:38:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-GB
To: Eric Wheeler <cocci@lists.ewheeler.net>
References: <4fc9237-ca2-518a-3221-9770f6112c6@ewheeler.net>
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4fc9237-ca2-518a-3221-9770f6112c6@ewheeler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FiPcWOHXP08Ydv3JVZVTsfaWVWAx9NiQusO0os5PlpVSRT/jlGt
 tjSAtMxFdWcH94e1cRJ0IxhJltdM5lw2Hv9vobyDF9lLxzihbqGm8GDYYiGoVxLAbAkR3HE
 MiyRtkmMBO7m5tYKzRHkP2m68cNETA1Ks2hMzSY7xZeM0KvbAyxFc+Uh7V89VY+ne7S6xO8
 QjvGzH+K72wPGx7LvnSGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+IjRACwuoac=:BXZpZb4DPIkiMe1Y/WVmwg
 fAawghvoE9j0nBZNl05RuEw6xMEgijSIrrcBXLvsAJQdWdparcbHPJR8w/G1ZZizvv2dBdu2a
 eNzbhFE6zOjzHgIp7NN0DzCx2dRzuryATls0eM9Tav2fqoNqNbcyMiqnn9b7xYyrXgbXnm6Ri
 c9R6wGBXwsnc4hti3uVa5UwBpt8eDbrRg5fbv7OcuQrGo+IDQePgRbEDt/+9wE9jyN5gcXsbB
 CziIOZyfdvJTm8l6dIhndPS/BxPb1376RlQZ3dISkRJftXb8xqdLuabzO8juNeom5AEEVrD1k
 n92/Gz8T1pABgAyi/gmF6J5S1AE0hLCYFxH5QSUaCD5WPH+cVmU7zVgtvWSYQVjpZdRCD42GN
 u3AhjI5qik6Mp16djRg1pDyFHb2zKy6uwmEsmt2qXgWjRMa3IPoIaXgWQ5fBTTj0/gYPWsSY6
 2Qd91DCAbogzEVydwDS3O6UgzzZtuTFJ4KAbz3DSdL0rhD49ySSv48vQGeSQ/BLxvcyXbjtGN
 cW8+f6JpscORsyRVm42kFWtvt7fLAELye9rDuq0gi1a65MkBQiiNvvAy6okRZk3Yv712gFP+U
 n4WviYMy6ucp4QZCn0kjZlmNvr0UhBCUMwr/WbAI02Ps4nmEs65jHWcuOMpnKZz0yTWOuxQZ4
 jMnSIcaTsUUYYIoFA1qtsWqq05Nr6HrDZUc+X+O6bZga1qm9jGyxxeSDjkHURTVe+lg0U3+w0
 u1T7lGdGhmW7850A/A5Menw4HG059zsJZ5w7Q3AezNCqSOdqMTa3e5QOQE2QoxMphaVnck7ol
 jcmP/4sQidgBJhVJmpjcpamW++gy2G02KUp9XExqSBsfa2WxuhuDWd16LH9q0/Ga20KZN4fRR
 rQGNDzd9ExBKbAaBGD1da3v4HiuEfQzwVrJabbfSgW+NNBZhPB4xUFQe/t1Sw39L4HZp1B4I9
 mwCJ8oroAGvwlqB1lf0WJC3kgUY4lmG2HTjIJB3QSHNPtl2RTinTUh6oE6WqLJZ/IhU1a3I26
 lRqYHXd0GWpEUDPMMfbYg5Y3YVG4Uxqpbttf2rOyYzTs3mJ6fTXTUTqBHkp1/aPrmp6TzvrUX
 AOT+I31uoxUuAU=
Subject: Re: [cocci] Does SmPL support regex groups?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 192
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/f79b9c33-f5d0-7d38-06bd-fde9f9e089d1%40web.de>

> And extract the extension ".gplot" as an identifier


It seems that you are looking for a string literal
(which would contain a file name).



> and pass it to the function get_nec_filename_stem, like so:


Literals can be found with the means of the semantic patch language
by the metavariable type =E2=80=9Cconstant=E2=80=9D.

https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5479fc964d209209e84dd=
d5caf3f395667721e7c/docs/manual/cocci_syntax.tex#L216
https://github.com/coccinelle/coccinelle/blob/ae337fce1512ff15aabc3ad5b6d2=
e537f97ab62a/docs/manual/cocci_syntax.tex#L216


> The SmPL patch below works for what I want statically, but notice the
> commented `expression E`:
>
> Is there a way to regex-group `expression E =3D~` with a parenthesis and=
 then specify
> something like E[0] to pick up the grouped regex match?


Would you like to achieve any further software evolution also according to
my feature request =E2=80=9CReuse of content from capturing groups in regu=
lar expressions=E2=80=9D
from 2015-08-27?
https://github.com/coccinelle/coccinelle/issues/46



> 	@ replace_untitled @
> 	identifier F;
> 	parameter list PL;
> 	expression list EL1, EL2;
> 	//expression E =3D~ "\"untitled\.(.*)\"";
> 	@@
>
> 	F(PL)
> 	{
> 	+   char newfn[PATH_MAX];
> 	    ...
> 	    file_chooser =3D Open_Filechooser(EL1,
> 	-       "untitled.gplot",
> 	+       get_nec_filename_stem(newfn, ".gplot", PATH_MAX),
> 		EL2);
> 	    ...
> 	}


I would like to point the possibility out that SmPL ellipses
can be used instead of the metavariables =E2=80=9CPL=E2=80=9D, =E2=80=9CEL=
1=E2=80=9D and =E2=80=9CEL2=E2=80=9D.



> Ideas?


Would you get any further ideas from the clarification approach for the to=
pic
=E2=80=9CDevelopment challenges around using the function =E2=80=9Cmake_ex=
pr=E2=80=9D for expression
construction by SmPL=E2=80=9D (from 2016-10-27)?
https://github.com/coccinelle/coccinelle/issues/88

Excerpt from my script:

@initialize:python@
@@
import re

@find_update_candidate@
constant input_string;
expression input_context;
position pos;
@@
=C2=A0seq_printf@pos(input_context, input_string);

@script:python selection@
call;
param << find_update_candidate.input_string;
pos << find_update_candidate.pos;
text;
@@
match =3D re.match('"([^"]+)"', param)
if match:
=E2=80=A6


Regards,
Markus

