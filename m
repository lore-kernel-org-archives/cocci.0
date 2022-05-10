Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A323C433EF
	for <cocci@archiver.kernel.org>; Tue, 10 May 2022 07:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=gfA+ViPkYwPQ1sdo+Ly/ZlvEPvwtlAa9pRlBL6sOf2g=;
  b=EPdkOkLdVUn5fPS6KxrNq6uy3MD/9YMKq6mU/KgN1r1J14UuhRGcLQeg
   goXGmydisANxeughf26V9AeU9fk75NQupWP/xZ/6rL5woANfKzsSi3hHE
   ydzfA+tXfigu5FE4L6H/OUDD6byHHI5bmYIEK2trlOdKGMjzXFl/iiZeP
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.91,213,1647298800"; 
   d="scan'208,217";a="35496104"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 May 2022 09:53:21 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EA3FAE0099; Tue, 10 May 2022 09:53:20 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9CC26E0099
	for <cocci@sympa.inria.fr>; Tue, 10 May 2022 09:53:10 +0200 (CEST)
IronPort-SDR: gzCAb4xafUQmSyNTp3SRZv3/kk8iLFm7F00bezF5iRWMAGyDp2nFgvGFz6rNTvQO4wJEbbABx5
 cpl3041KOAF69gXjNbULE1obDZErlv0zb4apH3SgCq1GD16VotRMYHt4yqSHzDVgM3vwfG4Lwz
 qxI+OwxIHo6LnEJCtkSNfSpFC+TEDcrsHZOTS+pDReIxGYfuohtPdTs8Jzajj9bzWmFqll/MfH
 pZGE4z4bj50SutIYxbITSvSWqvn5nf8FhMLKkkq6nsMS7207177ErxLe/6Z05yiLaFnUQsqqBz
 jhtUd6RGsK9DHtL5nPZjzdUd
X-IPAS-Result: =?us-ascii?q?A0BxBAAAGXpif7bdVdFaHQEBPAEFBQECAQkBgWQCgiJ+V?=
 =?us-ascii?q?C4EC0OEToEjjUOCKIwskDeBfAsBAwENEgEBJwcEAQGFAgKFPQIdBwEEMgcOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBDQsJBwgKBw4OBWABY?=
 =?us-ascii?q?QMBRIFPgXQLAzENgjUpAYNkAQEBAgESER0BGx0BAwwGBQs3AgIiAREBBQEcB?=
 =?us-ascii?q?hMbB4JcgmIBAw0kD585gQRBizKBFQUXgQGCCQaBQAEVQYI0ChkoDRVSA4FZA?=
 =?us-ascii?q?gEGEoEqAYYVAlhKAQGHIScQgVVEgUuCdD6CYgEBAoILgymCZQSVQWhZe8Epf?=
 =?us-ascii?q?DQHg0yBOwYMiUuUajGDdZMYkUaWYo0jlEGFKxAjEoEyAYIOTSNQMYI3TgECA?=
 =?us-ascii?q?QEBDQECAQEDAQIBAgkBAQKSD4E+iSJCMQIJMAIGAQoBAQMJkW8BAQ?=
IronPort-PHdr: A9a23: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
 pv+9xqoPipsadc0IerbI68bljBt
IronPort-Data: A9a23:J/bMFKgYJcDORpNQ5syURQHIX161pRYKZh0ujC45NGQN5FlHY01je
 htvWT+Ab/+CM2Xyftxwa4qwph8C75HXytFrSgZr/nhjFytjpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKieUsxIbVcMpB0J0HqPoMZkxN8x6TSFK1nV4
 4mq/pSHYAbNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 NplnJCPVl0TebH1puUHSiRhEyQ5JK9X5+qSSZS/mZT7I0zudnLtx7BwDxhzM9RIoKB4BmZB8
 fFeIzcIBvyBr7jukfTrF6823J1ldZmxVG8ckikIITXxBPIrWovKRanQ4plT1S01h8ZHAff2a
 M8QaD4pZxPFC/FKEgxKVMNjw7/17pX5Wx8Fl3jE/bQX2Wno0St30bfAa97VVuXfEK25mW7B/
 j6cl4jjOTkRM9eUyBKe43e0j6nOmzn6UcQcDtWFGuVChVSSwikNC0RTWwLr+7+2jUmxX98ZI
 EsRksYzkUQs3GWnccanZVqkmUCFpAchYtpVVPQ4+R7Yn8I4/D2lLmQDSzdAbvkvu8k3WSEm2
 ze1czXBVWwHXFq9GSL1y1uEkd+hEXNKcjJaNEfoWSNAsoaz+thi5v7aZo87SPbdszHjJd3nL
 9m3QMUWgrwSiYsV1Pz+8wmX2XSjoZ/GSgNz7QLSNo5E0u+bTN75D2BLwQKDhRqlEGp/ZgfZ1
 JTjs5bGhN3i9bnXyESwrBwlRdlFHcqtPjzGmkJIFJI87Tmr8HPLVdkOvWsnfh40YptfJWGBj
 KrvVeV5tM870JyCPf8fXm5NI5lCIVXITom6Dq+MMLKinLAoLlHcpkmCmnJ8L0i0yBR2+U3OE
 ZicdsmoAB4n5VdPnVKLqxMm+eZznEgWnDuNLbiilkjP+efAORa9FOhdWHPTP7hRxP7V+239r
 ocPX+PUkUk3eLOlOUH/r9VDRW3m2FBhWvgaXeQMJrDdSuencUl9Y8LsLUQJIdI6xfgFzbeYl
 px/M2cBoGfCabT8AV3iQhhehHnHBv6TdFo3Yn4hO0iGwX8mbdr95asTbcplcrwu9eglxvlxF
 qFXd8KFC/VJazLG5zVNNcmn/NI+LEym1VCUIi6oQDkjZJo/FQHE/9nTeAGwpiQDCyyAs9Qz/
 u+73QTBTJtfHAlvVZ6EaP+mw16rk2IaneZ+AxnBLtVJKRfj9YFrL2r6ifpue5MALhDKxz270
 QeKAEdA9bOd/dNtqNSQ3PKKtYakFed6D3F2JWiD4ObkLzTe80qi3ZRED7SFcDXbY2X+p/eva
 OBT+PfjaaFVkVtPtb18JLZl16cJ4dXi+u1BxQN+EXSXNlmmB+8yInSC2sUT5KRByqUD5VmzU
 0OLv8dZYPCHYZO/VlEWIwUhY6KI0vRNwmve6vE8IUPb4i5r/erYDR8DYUHU0CENfqFoNI4Fw
 Ps6vJJE4QKIjBd3YM2NiTpZ9jjRI3FcAb8rsIoWXN3ihgYxkA0QZJXdDmro48jKZYwcaA8lJ
 TibgKeEjLNZnxKQf302HHnL/OxcmZVe50wQnQFafwyEyojfm/s6/BxN6jBrHA5b+RNKjrBoM
 W9xOkwpeKiD8l+EXiSYs7xAxu2AOPGYxqA1414AlWmcUUrxE2KUfDd7NuGK80QUtWlbe1C3O
 V1eJHnNCV7XkAPZh0PemnKJb9TsSNVw8kvJn8XP8wGtAcwheTS86kOxTTNglvYkaP/dQGXIo
 OBr+KB7bqiT2ev8ZUEkI9Hy6In8gyxo6ICPrT+NMU/J8azhlOmO5AWz
IronPort-HdrOrdr: A9a23:PB/p3qsm72yYbF/MFCIvX4mX7skDSdV00zEX/kB9WHVpmwKj5r
 mTdZUgpGfJYVMqMk3I9urwXZVoLUmsl6KdpLNhXotKPzOGhILLFvAH0WKK+VSJcBEWtNQ86U
 4KSdkYNDSfNykdsS842mWF+hQbreVvPJrGuQ4W9RlQcT0=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,213,1647298800"; 
   d="scan'208,217";a="35495705"
X-MGA-submission: =?us-ascii?q?MDEMOaELUFXq5KxkgD9uB+NaEr95zavahqvH+W?=
 =?us-ascii?q?gEn+R1jTzxNBEOebhqnwG/DMJ1JHOQRYnLFXlpyXIn59WTx7ymTvdA/y?=
 =?us-ascii?q?Z6vkQX8ghsdfRv2AfdVtFu4TxZvz5anNeJccFL2YH3gHMdlWrxyVwMhE?=
 =?us-ascii?q?JTQdECh3GZIYKLIZ9EmtNqfA=3D=3D?=
Received: from mail-vk1-f182.google.com ([209.85.221.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 09:53:09 +0200
Received: by mail-vk1-f182.google.com with SMTP id t12so8036620vkt.5
        for <cocci@inria.fr>; Tue, 10 May 2022 00:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gfA+ViPkYwPQ1sdo+Ly/ZlvEPvwtlAa9pRlBL6sOf2g=;
        b=IuxH95TionibDz7vcNjC0rEYpPWH0abDEMmceXqHxNYMruzbqvxF1bzYxXTMdA8ygg
         L0Cl8q4oQFuJqehmoVCt6zzbhW+ggAohkaSgv3R6oJPbxaS+3eO2u/Azmqw8qD6ySNYj
         PWvLbUQ21XyE4dEAX6HPb3L5x9Gfnhqnhh7wI7NNUr6jxdBKFwyEMPRbgJVdcqXFvmV9
         q71gZgY90C28YPdgVwu6fuQq5T7G7BFEwHKroJ+bMsKRL+YtR1WrijopU9j3+awwLSz8
         wY9dq62FJku3sWvsMG30ihhka0ZPo1rl5Ncs133gnbGZmgYdOP1jluCYqfmo1bm3IH3O
         Y+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gfA+ViPkYwPQ1sdo+Ly/ZlvEPvwtlAa9pRlBL6sOf2g=;
        b=TIYeF2q0lHpqLl4uZJLkfxDSBSZay+HSertLN5XE0/WsW4naAIymLUzhF8qVpczqeg
         QcNE8Frr9cY+eFfm/KrjWCdZ/7L5X33D9b6R+IOzC7+CPZs7uwQKdV6wkIe/alvlpfnO
         TNLm0O1hIGb8ycVP3ZURrVw6g0cW9TNabwhjHrR9EdDW8EtucvnxTMqzJEgdk2i9NK5Y
         PBoaHsmS3q/1Elb5+TkrllqGXqemQSAHwvmG8gi312e+KPCsaJV36fPG9boO0Hqv1Cvt
         iFQ+p9pf5qrMnAszCRUea+mGmqrFNQmZNgV2AbEweDEkAjb7ucZZ3PGATiZPiQRP0iUP
         68Uw==
X-Gm-Message-State: AOAM5320b+JwtTI8yTZMq7z1RFTcHjlkc/yVrg1AjQu+sp7oyrT2/KcX
	5URq+yooV7t3rada/F8qEEVueVI15HhHF/LuyPSUAy9OIVc=
X-Google-Smtp-Source: ABdhPJwyYMilkN0IY22FO0CcpQNxQpm8TauEjkI1TJWgZ1Lmb83eiqEfPx9Uej3xx4zJu1sqdFi7NNHD3Q17tzRKNrs=
X-Received: by 2002:a1f:d481:0:b0:34e:af4c:5bd3 with SMTP id
 l123-20020a1fd481000000b0034eaf4c5bd3mr11476253vkg.39.1652169188485; Tue, 10
 May 2022 00:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAPp5cGQV6Lm7fwhUcVs6sqXrA00XYAem2ZopE1eFW_v2EExJQQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2205091216530.2394@hadrien> <CAPp5cGRMAOanfvuhV1LAV9eZka8ZJHRPy6ncMwO=Q+C=GUA2gA@mail.gmail.com>
 <CAPp5cGS+ANKVuE+QThN=Byqm=BR0FotbCe7aQgjX77Ee65UDuQ@mail.gmail.com> <6a926cad-e15a-5c04-1fc9-34d20bd18618@web.de>
In-Reply-To: <6a926cad-e15a-5c04-1fc9-34d20bd18618@web.de>
From: Alessandro Carminati <alessandro.carminati@gmail.com>
Date: Tue, 10 May 2022 09:52:32 +0200
Message-ID: <CAPp5cGQRKxk5RXn7a=7R3s4y=fsvi_O9aFUj6HudPSX+06-_2w@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
Content-Type: multipart/alternative; boundary="00000000000096ad4105dea39da7"
Subject: Re: [cocci] List global variables with SmPL
Reply-To: Alessandro Carminati <alessandro.carminati@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 371
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/CAPp5cGQRKxk5RXn7a%3D7R3s4y%3Dfsvi_O9aFUj6HudPSX%2B06-_2w%40mail.gmail.com>

--00000000000096ad4105dea39da7
Content-Type: text/plain; charset="UTF-8"

Hello Markus,


Il giorno lun 9 mag 2022 alle ore 21:23 Markus Elfring <
Markus.Elfring@web.de> ha scritto:

>
> The solution you sent indeed does what I expected.
>
>
> I doubt that it fits to your initial source code analysis desire.
>
> Are your expectations still evolving (also for your data processing needs)?
>
Indeed Julia's proposed code does not solve all the situations I encounter
now  in the kernel source analysis.
It reports not only global variable names but also function names.
It confuses sparse annotation and a few other macros with variable names.
I also have trouble with "extern" declared variables that appear multiple
times.
Still, it is far better than I was up to, And it allows me to improve the
solution by adding statements and rules to make it better suit my use case.
Currently, I'm using this, but I still have duplicates due to "extern"
declarations.
```
@func@
type T;
identifier i;
position p : script:python(i) { p[0].current_element == i};
@@

T i(...)@p;


@r depends on !func@
type T;
identifier i;
expression E;
position p : script:python(i) { p[0].current_element == i};
@@

(
 T i@p;
|
 T i@p=E;
)

@script:python@
i << r.i;
@@
print (i)
```

>
>
> Would you mind add a short explanation of this statement:
> `position p : script:python(i) { p[0].current_element == i};`
> I probably have a simplified understanding of what a position is.
>
> I imagine that known information sources can help further.
>
>
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5069eaeadd731ecdd99e7a6f4465c286a2792354/docs/manual/cocci_syntax.tex#L410
>
> https://github.com/coccinelle/coccinelle/blob/ae337fce1512ff15aabc3ad5b6d2e537f97ab62a/docs/manual/cocci_syntax.tex#L410
>
Thanks for this.

>
>
>
> Maybe it is worth digging deeper and having a more concrete knowledge.
>
>
> Probably, yes.
>
>
>
> Any read you want to suggest to me?
>
>
> Related links for example:
>
>
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5069eaeadd731ecdd99e7a6f4465c286a2792354/docs/Coccilib.3cocci#L5
>
> https://github.com/coccinelle/coccinelle/blob/57cbff0c5768e22bb2d8c20e8dae74294515c6b3/docs/Coccilib.3cocci#L5
>
>
>
> Regards,
> Markus
>

--00000000000096ad4105dea39da7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hello Markus,<br clear=3D"all"><div><div =
dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><d=
iv dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><br></div></div>=
</div></div></div></div></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">Il giorno lun 9 mag 2022 alle ore 21:23 Marku=
s Elfring &lt;<a href=3D"mailto:Markus.Elfring@web.de">Markus.Elfring@web.d=
e</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
 =20
   =20
 =20
  <div>
    <br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <div dir=3D"ltr">
            <div>The solution you sent indeed does what I expected.<br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>I doubt that it fits to your initial source code analysis desire.</p=
>
    <p>Are your expectations still evolving (also for your data
      processing needs)?<br></p></div></blockquote><div>Indeed Julia&#39;s =
proposed code does not solve all the situations I encounter now=C2=A0 in th=
e kernel source analysis.</div>It reports not only global variable names bu=
t also function names.<br>It confuses sparse annotation and a few other mac=
ros with variable names.<br>I also have trouble with &quot;extern&quot; dec=
lared variables that appear multiple times.<br>Still, it is far better than=
 I was up to, And it allows me to improve the solution by adding statements=
 and rules to make it better suit my use case.<br>Currently, I&#39;m using =
this, but I still have duplicates due to &quot;extern&quot; declarations.</=
div><div class=3D"gmail_quote">```</div><div class=3D"gmail_quote">@func@<b=
r>type T;<br>identifier i;<br>position p : script:python(i) { p[0].current_=
element =3D=3D i};<br>@@<br><br>T i(...)@p;<br><br><br>@r depends on !func@=
<br>type T;<br>identifier i;<br>expression E;<br>position p : script:python=
(i) { p[0].current_element =3D=3D i};<br>@@<br><br>(<br>=C2=A0T i@p;<br>|<b=
r>=C2=A0T i@p=3DE;<br>)<br><br>@script:python@<br>i &lt;&lt; r.i;<br>@@<br>=
print (i)</div><div class=3D"gmail_quote">```<br><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex"><div><p>
    </p>
    <p><br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <div dir=3D"ltr">
            <div>Would you mind add a short explanation of this
              statement:<br>
              `position p : script:python(i) { p[0].current_element =3D=3D
              i};`<br>
              I probably have a simplified understanding of what a
              position is.</div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>I imagine that known information sources can help further.<br>
    </p>
    <p><a href=3D"https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5069=
eaeadd731ecdd99e7a6f4465c286a2792354/docs/manual/cocci_syntax.tex#L410" tar=
get=3D"_blank">https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5069eae=
add731ecdd99e7a6f4465c286a2792354/docs/manual/cocci_syntax.tex#L410</a><br>
<a href=3D"https://github.com/coccinelle/coccinelle/blob/ae337fce1512ff15aa=
bc3ad5b6d2e537f97ab62a/docs/manual/cocci_syntax.tex#L410" target=3D"_blank"=
>https://github.com/coccinelle/coccinelle/blob/ae337fce1512ff15aabc3ad5b6d2=
e537f97ab62a/docs/manual/cocci_syntax.tex#L410</a></p></div></blockquote><d=
iv>Thanks for this.=C2=A0=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div><p><br>
    </p>
    <p><br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <div dir=3D"ltr">
            <div> Maybe it is worth digging deeper and having a more
              concrete knowledge.</div>
          </div>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>Probably, yes.</p>
    <p><br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <div dir=3D"ltr">
            <div> Any read you want to suggest to me?</div>
          </div>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>Related links for example:</p>
    <p><a href=3D"https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5069=
eaeadd731ecdd99e7a6f4465c286a2792354/docs/Coccilib.3cocci#L5" target=3D"_bl=
ank">https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5069eaeadd731ecdd=
99e7a6f4465c286a2792354/docs/Coccilib.3cocci#L5</a><br>
<a href=3D"https://github.com/coccinelle/coccinelle/blob/57cbff0c5768e22bb2=
d8c20e8dae74294515c6b3/docs/Coccilib.3cocci#L5" target=3D"_blank">https://g=
ithub.com/coccinelle/coccinelle/blob/57cbff0c5768e22bb2d8c20e8dae74294515c6=
b3/docs/Coccilib.3cocci#L5</a></p>
    <p><br>
      <br>
      Regards,<br>
      Markus<br>
    </p>
  </div>

</blockquote></div></div>

--00000000000096ad4105dea39da7--
