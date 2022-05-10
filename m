Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A84BC433EF
	for <cocci@archiver.kernel.org>; Tue, 10 May 2022 17:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=yEYNdyN/B8zgEmmx5X2RR3jb8bu0TB9cW04DCAye1ms=;
  b=upFh6LK+pJqTSBMcAVBg2YxToycMUxn5sSaMxkm6+LAxhPDP/zSIlNNb
   RNUynOisevtbEaZLKWmZNssLwgJcYh9ikRgFf/UsmYDZ3h6a0Ha4972Vt
   1oPV5D655GTEhUfcT47/+ZwzzfuNIouAXfAs524MFDMxwqiEOJYxBq8Z9
   w=;
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
X-IronPort-AV: E=Sophos;i="5.91,214,1647298800"; 
   d="scan'208";a="35632951"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 May 2022 19:00:20 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 36059E028C; Tue, 10 May 2022 19:00:20 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8FF92E0099
	for <cocci@sympa.inria.fr>; Tue, 10 May 2022 19:00:18 +0200 (CEST)
IronPort-SDR: B1DkD1IFvPZZo2YTTI7amkrGw2YJVPEzWF9sq8TqWKArD0amkREcm0K8pS615cvcgHy3+v1g3T
 NBigF9CMB28lRmfhpUoCtG2c9uG6o+c9WOsrjBslVLkodKlAvPrkhD9R6g0qUyOl9SK/MCzCwd
 BC3invZAL3VPvD9DojE5sO7hVZNZaembTO1AaXSRXtZaQuWi1+PUU6MkFzZLu5zbQhXge+BI0B
 B/5ehQu5a7yhBJsO8yFBLIoQTWyWPGasXuO3TIdk0B1D8CFI+TyPd58+7WKU+VkHRQfW7kAbw4
 lpaE28sgCaXfVpAXS8tzTO/0
X-IPAS-Result: =?us-ascii?q?A0DEAQCcmXpihwQP49RagQmDc4FTLQQLQ4QRPY5mgiiLJ?=
 =?us-ascii?q?5M4CwEDAQ0/AQIEAQGCDoJ0AoU+Ah0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgQEARMBAQEMDQkFCAoHDhAFNgZeBmQEgUsEgXQLNA2CNSkBg?=
 =?us-ascii?q?2QBAgIBDBcdAQERJgEECwkCGgImAgJXBg0IAQEXgmKCYwEDDSiQe5wRgTGBA?=
 =?us-ascii?q?YIIAQEGhEofLCJSgVwJgRAsjl0nEIFVRIE8gwM+hESDVoJlliwoBA8DHScKG?=
 =?us-ascii?q?gMIAjwRCRcEOQ2BHBKBIXEBCgYDAwcKBTIGAgwZFAQCFRFTHgITBQcKHA4UH?=
 =?us-ascii?q?CkZDA8DEgMRAQcCCxIIFSwIAwIDCAMCAyMLAgMYCQcKAx0IChwSEBQCBBMfC?=
 =?us-ascii?q?wgDGh8tCQIEDgNDCAsKAxEEAxMYCxYIEAQGAwkvDSgLAxQPAQYDBgIFBQEDI?=
 =?us-ascii?q?AMUAwUbDAcDIQcLJg0NBBwHHQMDBSYDAgIbBwICAwIGFwYCAnIKKA0IBAgEH?=
 =?us-ascii?q?B8mEwUCBzEFBC8CIQQFBhEJAhYCBgQFAgQEFgICEggCCCcbBxYZHRkBBTcnB?=
 =?us-ascii?q?gsJIxwKJA0GBQYWAy8GIgEbAlKYMYFFgUFaklmDIop/oAc0B4IRgTuBQQyeI?=
 =?us-ascii?q?AYTLZZKDgaRdZZipyGBeIF+MxokT4JoTgECAQINAQICAwECAQIJAQECjjaED?=
 =?us-ascii?q?IotPzQ7AgYBCgEBAwmFRwEBjCYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:NPiP4KIf1uRnv6vQFE+RqJMlxSXFcZb7ZxGr2PjKsXjdYENS0D0Cy
 2QaDTvTbv+PNzH9c48nb9mzoBwGsZHRm9JmG1Md+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefSLlbFILas1hpZHGeIcw98z0M68wIFqtQw24LhXlrV4
 YmaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhjot1w
 sRqpcaMaBYlZfTGqLg2dydSHHQrVUFG0OevzXmXtMuO0wvZfnGqz/gG4EMeZ9RCvLwtXicXq
 LpEQNwORkjra+ae5buhSfR3wOknItPqOow3pXxqiz3UZRojacmYHPyavI4HtNs2ruBHQtn4T
 Ms4UmR2URXpOxNAIWoJS7tryY9EgVGmLmEG8QvLzUYt2EDXxRN41LzFItvQcMaDA8RThEeR4
 Gzcl0zyBRoRNfSE2D+d+zStgPXOlGX1Quov+KaQ8/l3nBuMy2ZVBBB+uUaHTeeRmxW6UcN4O
 xYo2zsi9vE4xBCAauf3UEjtyJKbhSI0V91VGuw8zQiCzKvI/gqUblToqBYeM7TKU+dpH1QXO
 k+1c8DBWGU14ezOIZ6J3ubI/GrqUcQABTVaPUc5oR05D87LjKxbs/4iZtNkDbLzkdD/Xz39q
 9xrkMTcr+VN5SLo//zllbwiv95KjsaTJuLSzluNNl9JFisjOOaYi3WAsDA3F8poIoeDVUWmt
 3MZgcWY5+1mJcjTyXbUGrxQTOzzuKnt3NjgbbhHT8FJG9OFpC/LQGysyG0iTKuUGptYKGGyO
 ic/RysLv84JZRNGkpObk6roVph0lPG+fTgUfqmaN5JPZIR8bgmK4GlnaiatM5PFwCARfVUEE
 c7DK66EVC5EYYw+lWbeb7pDjdcDm35vrUuOFMiT50n2itK2OS/FIZ9bagfmRr5itsus/l6Km
 +uzwuPRln2zpsWlPnKImWPSRHhWRUUG6Wfe8ZIILLLTeVo2cIzjYteIqY4cl0Vet/w9vo/1E
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
IronPort-HdrOrdr: A9a23:zmeijqEhfbTuBKp8pLqExseALOsnbusQ8zAXPhhKOHtomszxra
 +TdYcgpHnJYVcqKQsdcL+7Scq9qB/nmKKdpLNhWYtKPzOWxVdATrsSj7cKqgeIc0aVygce79
 YET0EUMrPN5C1B7foSlzPYLz9P+rW6GeuT9J7jJj9WPHlXgo9bnnxENjo=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,214,1647298800"; 
   d="scan'208";a="13718197"
X-MGA-submission: =?us-ascii?q?MDEu3hK55HWeEWl68l25ufKHr8ihjqslJC1Fs3?=
 =?us-ascii?q?knFFLlFqwz2WKdfGO058BUqTOUiw1/EMz5YsECUpUr6OYbAx7N0HVV+C?=
 =?us-ascii?q?hZm2MUQeVJbM/vSjnfUy6R7+q/hyH7WgakLPM2D8Gx1EZgJTTa4hnayX?=
 =?us-ascii?q?qTCxXPpTJESI2JFGjAdUu4yw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 19:00:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1652202016;
	bh=FuwD/CVFQeS/YAMQJ+bNI3x3ibnW6yiFKNXRiQZZTLo=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
	b=YGMMbQRPCNu4KJ4+C59NEYxx/S+ofbcCIexhbE/UWxyhEtmGSlctViSTSM6lx81RG
	 bsKlZMx78hnNTndNAEkhLttfcWZ87aRaxQyN4vJxiuP3MQMmLdfxMnj23o26lFivGq
	 kcKPh0G/FFhNf7KaKYsLPgk/FDdNur63azVQT4KM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.171.193]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWzD3-1nHpH719kv-00X4Lp; Tue, 10
 May 2022 19:00:16 +0200
Message-ID: <3cb75ef2-5fd4-462b-7e95-bdd25a3482d2@web.de>
Date: Tue, 10 May 2022 19:00:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
References: <CAPp5cGQV6Lm7fwhUcVs6sqXrA00XYAem2ZopE1eFW_v2EExJQQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2205091216530.2394@hadrien>
 <CAPp5cGRMAOanfvuhV1LAV9eZka8ZJHRPy6ncMwO=Q+C=GUA2gA@mail.gmail.com>
 <CAPp5cGS+ANKVuE+QThN=Byqm=BR0FotbCe7aQgjX77Ee65UDuQ@mail.gmail.com>
 <6a926cad-e15a-5c04-1fc9-34d20bd18618@web.de>
 <CAPp5cGQRKxk5RXn7a=7R3s4y=fsvi_O9aFUj6HudPSX+06-_2w@mail.gmail.com>
 <alpine.DEB.2.22.394.2205100957160.2667@hadrien>
 <CAPp5cGS+4snNh+8S3vFw01MMbUjYgpL2qm0tUPrZ1FUtK8bz9Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2205101123120.2667@hadrien>
 <CAPp5cGQMuy3aM5cLYk4HH8Ny=uH_t2yhWasfmT2AS7M12YDiWA@mail.gmail.com>
 <alpine.DEB.2.22.394.2205101236050.2667@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: Alessandro Carminati <alessandro.carminati@gmail.com>, cocci@inria.fr
In-Reply-To: <alpine.DEB.2.22.394.2205101236050.2667@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:38/nXRDMDTnjfRkL+URTlhorEOA1xVh9deVtxnhP/7A1X8GHdPi
 n/m0cWcJCN4NdJV4x110gFF1qeVrAsRsy3pj7aD2v/V7fWJysUc9sPp3y627DVO0I2fC7i+
 mrkwhsQO8vgL7MiiVrVLEXTjuIj1y6qqGbWtqmC3KYrxneMVROp8QPgSSwSf5nCoXGmTPcQ
 WKVugZq25Vd6/dF6f6YaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QLDjBgsO8M0=:S9G8UWiylGxcq3Aw0pPi+R
 orVJlB60tjUvudbjL5udSp+Z39RnoXIdWLz2a1YDHerndrX/tH9tDH96uuLsW6k0Bra4/3sy8
 aDRDD0RJJgMlpcjtM2Sawd//VUW3l2LONFJNLwDsMoKJ110sLbFtYlp4o5a9sjzssge2SwZ1L
 jcgUuivps+zu2IB0QcK7PgyOYlqCAmZNPA8BPlPCe+iBq1tS+nhyt3DaW4LFSKBLLCpnyTeFR
 w9DVKLVpyHsHnzgJnjTYBxSgGF0sesoswXM0Wfxj0redAHWOusI0quL3+HBNrb/ALVh5p7LQQ
 lhyIObaoV1UOH5/wOjuMAqXX72JxJ1TQK4tMhr/IhKZaMyAZFcYQs96Mu88QIIgMznjEW3PpV
 WmUWUuOB3cGTdoknwJjcO+GMU+Jc7hHMKgIGhkcxyKHj5RZbPSByYlGQoTd+IsisOpUIca7Or
 B3FmL0WBTXIw2pzo5VikEy3jUT5r69SE/e6HaGqNugyMOeVtgDto0cIRrvwqN8bJKreIu1DJj
 s3pWm5EAV5FjHhPKuLiAkuq8let34pBUhk+HacrEjxlSHM+j3kuSza2RrVnLp8JPkaSkHscWM
 l8oHw4U1602qwSRqb4eh8gwwPDBxMHuWonXj2iSJHOK4Lnw4WCKo63+7NX7EAu2PjzvPPu5AK
 DqB7p+ivxIzeTWmrzTRWmHdFbRR8w+1AYjtbFUgjP2jRZEFiQQbEZJksaG5+sCkLWmeJJzwke
 dfjXkOtB8kiJaJKR9pRzgCTd0ZknNlg/xhVMLxSBy66Uv74IxNjaLikNzjWvw9S95b4Buu5iX
 qsKPhY22z//fUrNgM6aKGhdvj+BuzQlYVjw6CCZiKHxREbDX+i4jQ112GN/P10rNiOr+EmHGk
 I5ooyC2H940yQViXf3+voiO0rc4I3SRXwR3gyfa751uaaZm+tCLS0Zwly4HuLJgl5WwFVnVeW
 i2+asjp6hRokUQRFYwgP7ykj5YKcuxyJtEO6zIbzfdGQe++nSjsg3F0xUP8jmFz92UNAvIyDz
 EWmESQg89+S4AoCUyZDOLcTctE2oOqfaUjTgQLJDK8mjTDay9u2N6KDUqKgdwRgl3nLSmeP1n
 6WX0iAZfo6thTTkeBAvk7+izgW58Kr+bMQGbqPt2xN5VL+QNKyG9J+PVA==
Subject: Re: [cocci] List global variables with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 377
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/3cb75ef2-5fd4-462b-7e95-bdd25a3482d2%40web.de>


> Here is a suggested solution for all of the problems reported so far:
>
> @r@
> type T;
> identifier i;
> expression E;
> position p : script:python(i) { p[0].current_element =3D=3D i };
> attribute name __randomize_layout;
> @@
>
> (
> T i(...);
> |
> T i(...,......);
> |
> extern T i;
> |
> T i@p;
> |
> T i@p=3DE;
> )


I find that this SmPL code needs further clarifications.


The information =E2=80=9C=E2=80=A6 current_element is the name of the func=
tion containing the matched position; =E2=80=A6=E2=80=9D
is provided by the manual for the Coccilib module.

* How can a function name be referenced if data should be determined for
=C2=A0 the global scope?

* Why is a comparison attempted in the scripted constraint at all
=C2=A0 if the passed identifier would refer to a variable name according t=
o the metavariable =E2=80=9Ci=E2=80=9D?


> @script:python@
> i << r.i;
> p << r.p;
> @@
> print (i)
=E2=80=A6
> The problem with __randomize_layout is that the Coccinelle parser is not
> recognizing it as an attribute.  You can force that by putting a
> declaration in the semantic patch.
>
> It seems that ... in a function parameter list does not match the ... in=
 C
> for a variable list of arguments.  That ... can be matched explicitly by
> ...... so I have added another case with that.
>
> I als combined all of the patterns into one rule.  By inheriting the
> position varaible p into the python rule at the end, that python rule is
> only executed if p is defined, which makes it select the cases of intere=
st
> and ignore the others.


Will these details trigger any improvements for the software documentation=
?

Regards,
Markus

