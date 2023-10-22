Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FD3C07545
	for <cocci@archiver.kernel.org>; Tue, 24 Oct 2023 05:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=RKTKIQmeHxvARLga/Bo7BZg51mVprL5pw9O7XytgzVQ=;
  b=XZtO640l/REqlY5LOn7rKxrcB/3lOTJmq80oWH8DO3KjXIsEKq24YXYO
   a6DvMvuHOi2ozPU4c+zJjjbV1ZeC705ZGxiGgsWaRzq2jB1blfPvplNAb
   lrgnHYFAbywECK+wds5au+XhbVnXdsoxSRdOzGj2z/38HZED057s2uBJu
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@swedishembedded-com.20230601.gappssmtp.com
X-IronPort-AV: E=Sophos;i="6.03,246,1694728800"; 
   d="scan'208,217";a="132814771"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2023 07:48:16 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 26AEFE0CD5; Tue, 24 Oct 2023 07:48:16 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8B2AEE00B7
	for <cocci@sympa.inria.fr>; Sun, 22 Oct 2023 17:27:07 +0200 (CEST)
IronPort-SDR: 65353f4a_TuV07ieGMIQiqAEPwPwqa5XSokGEhwgUXEwyiM50pb6pN8l
 8/Dk2Ggpv9fcemeV8y0OCJDQ6bZyMth1EWEUAAg==
X-IPAS-Result: =?us-ascii?q?A0HtAwBqPjVl/yraVdFagliCOQdzVTEEC0iEFzyBI4Isi?=
 =?us-ascii?q?22CIwOXLIZQFIERAxgWKA8BAwENPQcEAQEDAQOEfwKHFwIeBwEEMgcOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAoEGE4VoDYI3KwERImpLFAk1A?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBARQCCAUZEjEBHwEBAQIBDAYRHQEBNwEEC?=
 =?us-ascii?q?wkCCyIVAgIiEgEFARwGEyKCXYIqAw4jAxGVQY8wgQVCizuBMoEBggkBAQaBB?=
 =?us-ascii?q?68YIoEWgR4DBhSBHBiICgGBTgEBhzx6JxuCDYFLgXNRMT6CYQKBGXQSgxyCa?=
 =?us-ascii?q?IMIbYJEgnkFAjKBQ4Q3hS2FfiYpBAcHIyMEQxhYGwMHA4EDECsHBC0bBwYJF?=
 =?us-ascii?q?hgVJQZRBC0kCRMSPgRzdIFRCoEGPw8OEYJDKzY2GUuBX38JFQYBOU12ECoEF?=
 =?us-ascii?q?BeBCQgEah8VHjcREhcNAwh2HQIRIzwDBQMENAoVDQshBRRDA0QGSgsDAhoFA?=
 =?us-ascii?q?wMEgTYFDR4CEBoGDScDAxlNAhAUAzsDAwYDCzEDMFdHDFkDVRofNgk8DwwfA?=
 =?us-ascii?q?jABAgEdJh1AAwtiCz01FBtNIJ0IA22BeGwIgRUkUQMSFRVaIxIeESnEXoQWN?=
 =?us-ascii?q?AiLRZUiM6l3mDyLCYJchnaTZhAjgUcCNIFZMyIbFWwGgjBPAxkPkhiPe0IyA?=
 =?us-ascii?q?jkCBwEKAQEDCYI5hA+CWoIpAQE?=
IronPort-PHdr: A9a23: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
 mR/KzrIRqlRgr5qeGxnhQOaspxKS6c0cA==
IronPort-Data: A9a23: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
 xSQMKONSDLeZzuRKLC5pcST/9bxxpkbtpvdmB4=
IronPort-HdrOrdr: A9a23:Fg+7CassiDu9QqFMiewEwxFi7skDSdV00zEX/kB9WHVpmwKj5r
 mTdZUgpGfJYVMqMk3I9urwXZVoLUmsl6KdpLNhXotKPzOGhILLFvAH0WKK+VSJcBEWtNQ86U
 4KSdkYNDSfNykdsS842mWF+hQbreVvPJrGuQ4W9RlQcT0=
X-Talos-CUID: =?us-ascii?q?9a23=3ArVUOT2sxgEqwTHrbWCq9/Woh6Is7fm+ey3zcKHS?=
 =?us-ascii?q?4KkF7VJO8QlrL9f17xp8=3D?=
X-Talos-MUID: 9a23:ucm7MwYWQ4cQFuBTqjrvgCBGOepS77m+BE40mqklgcO2Knkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,242,1694728800"; 
   d="scan'208,217";a="132542492"
X-MGA-submission: =?us-ascii?q?MDGwgvOmAdq2ceIomx0Omk5pTFCukvyuJh/D3K?=
 =?us-ascii?q?VMdOZRU5IIl5EKtCMHcX10gDeYyAVqvYMR62MrmWWXtoxGCiiLxd62y4?=
 =?us-ascii?q?uuH3v+PsmyZl5dtTC0n74RfWEJD3Muy6YZVlqLB0hd7j6VGe7xKZOBov?=
 =?us-ascii?q?+txnyQOUYYIRwm31v25O3N6A=3D=3D?=
Received: from mail-ej1-f42.google.com ([209.85.218.42])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 17:27:06 +0200
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-9ba1eb73c27so390579366b.3
        for <cocci@inria.fr>; Sun, 22 Oct 2023 08:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swedishembedded-com.20230601.gappssmtp.com; s=20230601; t=1697988418; x=1698593218; darn=inria.fr;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RKTKIQmeHxvARLga/Bo7BZg51mVprL5pw9O7XytgzVQ=;
        b=aJlR8HNt4TSj4yC76lRl0iSj6YHgo1jmdhCGv4sYNJ1ghrwkchG+Oq3NREITPLX4uM
         RPqvOlNbRKTEp9I2fHl5CCNtcH1JXorQ2tFehiyIjTowgO8QZB7wFb6bVrCO5Pgs8IfK
         rQjj1wLBvjqUeKeJfQ2nmF1/nVLBmOfOUPmAY34c9DRIFZWbWNU9OZRWeake4k1+fDzd
         om9vm/MtlPT2XDV77AWtEPoe1pwOJm7unCUzh6Mgo6fpA0gA2iBHj4f2NErlZ8k3Ytge
         dvWmHeyhhTfDl0Iqtfsd5aAmsz7c+IMWqQdlvNiYkBXYKz/rV4RmYUpZ/Bv23OWZGTki
         urfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697988418; x=1698593218;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKTKIQmeHxvARLga/Bo7BZg51mVprL5pw9O7XytgzVQ=;
        b=osQSbtkQE0XFIOLk/Yn5NyX4t6AVAxyVGlIsyMmnth0cWvBxNLye1N5NMsC0eLGTlY
         So2ViFnwJW14sbdKkS/56iX0sP0k4FSa3I2PRv/msTrchkFq6GFY5ic0LYRxS9jRH+oB
         u2nBmOZ2/F/aKS2Ocx4vkyBMz21IwDKJfKdOh2KWHRLzn5q/3IajaUBgUByq6P7aA1fD
         vDCLF3U2QeTGF67MBHtNObiFrN4JG4zH4ZJayVkFIbcxtexvfBbNUqoFH2vCD5Y4F10b
         VL45mUpOybzCcYegFAeEms6784Tq1rPqGsgwy+Bi2EpzzFepVLv87EgJj11wYMULqWwH
         k3Dw==
X-Gm-Message-State: AOJu0YydPH/Bek62vG95zV2Zq9tIlV35/8axqeQ09+F0+914a5SplCoX
	M+ik5yJ75MR/jLoeS7/V1K4BcYwOhWUOeEtSfLla8A==
X-Google-Smtp-Source: AGHT+IHUZhOdzrJNXmuVLt8Xc2EbGWM8t57W2FVwXzTRo/rdum4T/9G+qEjrNVW8sENseCOEQnIYOMxLTtsZJQIBR5Q=
X-Received: by 2002:a17:907:d86:b0:9be:b7da:72d6 with SMTP id
 go6-20020a1709070d8600b009beb7da72d6mr5691906ejc.63.1697988417705; Sun, 22
 Oct 2023 08:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAEqMKof5Ke4yV0KBZm2FW8z-Ct1UHZRDz5=Sd3gaO3a-f4+y_w@mail.gmail.com>
 <6213b47a-3ae7-d316-b1a4-8fb5d3bf9b5@inria.fr> <608e77e0-a36d-44ef-a2fd-9c0c50cf61b3@web.de>
 <CAEqMKoco-UjiPu4bwm69t1HexJi0y+cCPEH6NZ10xZCfn36=5w@mail.gmail.com> <0352f48a-47e2-492a-a263-1916a7065157@web.de>
In-Reply-To: <0352f48a-47e2-492a-a263-1916a7065157@web.de>
From: =?UTF-8?Q?Martin_Schr=C3=B6der?= <info@swedishembedded.com>
Date: Sun, 22 Oct 2023 17:26:46 +0200
Message-ID: <CAEqMKoeoLmEsxFsTAmF2TQv1DE+SeYgXEYh1OZdfC=vL=q+BoA@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Content-Type: multipart/alternative; boundary="0000000000007869e606084fbced"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Finding functions that do not unlock mutex in the same
 function
Reply-To: =?UTF-8?Q?Martin_Schr=C3=B6der?= <info@swedishembedded.com>
X-Loop: cocci@inria.fr
X-Sequence: 1272
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/CAEqMKoeoLmEsxFsTAmF2TQv1DE%2BSeYgXEYh1OZdfC%3DvL%3Dq%2BBoA%40mail.gmail.com>

--0000000000007869e606084fbced
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I explicitly want to disallow lock scopes that are distributed over
multiple functions. Instead, semaphore should be used in such cases. I want
to create a rule that ensures that 1. proper unlocking takes place across
all exit paths and 2. that both locking and unlocking happen in the same
function.

Markus, how would you recommend using disjunctions?

Here is my slightly updated rule:

@ r exists @
expression l;
identifier r, e;
position p;
@@
r =3D k_mutex_lock(l, ...)
... when any
if(r){ ... }
... when !=3D e =3D r
when any
if(e){
... when any
when !=3D k_mutex_unlock(l)
return@p ...;
}
... when !=3D k_mutex_unlock(l)
k_mutex_unlock(l);



On Sun, 22 Oct 2023 at 10:44, Markus Elfring <Markus.Elfring@web.de> wrote:

> > My final script that seems to work looks like this:
> >
> > virtual report
> > virtual patch
> >
> > @ r exists @
> > expression l;
> > identifier r, e;
> > position p;
> > @@
> > r =3D k_mutex_lock(l, ...)
> > ... when any
> > if(r){ ... }
> > ... when !=3D e =3D r
> > when any
> > if(e){
> > ... when any
> > when !=3D k_mutex_unlock(l)
> > return@p ...;
> > }
> >
> > First I match k_mutex_lock. Then there can be any statements between
> that and the first check.
>
> I suggest to take further case distinctions better into account
> also for such a source code analysis approach.
>
> I imagine that you would like to restrict the code which may be used
> between a function call and a corresponding return value check.
> Should the (compound) statement be restricted also for the corresponding
> if branch?
>
>
> > If locking fails then in the first check it is valid to return.
>
> Such a control flow possibility is reasonable.
>
>
> > Not sure how to capture that this first if statement must return in tha=
t
> case.
>
> How do you think about to add any SmPL disjunctions and to adjust the usa=
ge
> of SmPL ellipses?
>
>
> > Then there can follow additional if statements and in all of them there
> must be an unlock if there is also a return.
>
> * Why do you try to exclude the assignment of the item =E2=80=9Cr=E2=80=
=9D to other items?
>
> * Would you occasionally like to support (lock) scopes which would be
> distributed over
>   multiple function implementations?
>
> Regards,
> Markus
>


--=20
Best regards,

Martin Schr=C3=B6der
*Embedded Firmware Consultant*
Connect on LinkedIn <https://www.linkedin.com/in/martinschroder/>
*Book online meeting <https://calendly.com/martinschroder/call>*

Swedish Embedded Consulting Group AB
W. https://swedishembedded.com

--0000000000007869e606084fbced
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I explicitly want to disallow lock scopes that are distrib=
uted over multiple functions. Instead, semaphore should be used in such cas=
es. I want to create a rule that ensures that 1. proper unlocking takes pla=
ce across all exit paths and 2. that both locking and unlocking happen in t=
he same function.=C2=A0<div><br></div><div>Markus, how would you recommend =
using disjunctions?=C2=A0</div><div><br></div><div>Here is my slightly upda=
ted rule:<br><br>@ r exists @<br>expression l;<br>identifier r, e;<br>posit=
ion p;<br>@@<br>r =3D k_mutex_lock(l, ...)<br>... when any<br>if(r){ ... }<=
br>... when !=3D e =3D r<br>	when any<br>if(e){<br>... when any<br>	when !=
=3D k_mutex_unlock(l)<br>	return@p ...;<br>}<br>... when !=3D k_mutex_unloc=
k(l)<br>k_mutex_unlock(l);<br><br></div><div><br></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, 22 Oct 2023 =
at 10:44, Markus Elfring &lt;<a href=3D"mailto:Markus.Elfring@web.de">Marku=
s.Elfring@web.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">&gt; My final script that seems to work looks like this:<br=
>
&gt;<br>
&gt; virtual report<br>
&gt; virtual patch<br>
&gt;<br>
&gt; @ r exists @<br>
&gt; expression l;<br>
&gt; identifier r, e;<br>
&gt; position p;<br>
&gt; @@<br>
&gt; r =3D k_mutex_lock(l, ...)<br>
&gt; ... when any<br>
&gt; if(r){ ... }<br>
&gt; ... when !=3D e =3D r<br>
&gt; when any<br>
&gt; if(e){<br>
&gt; ... when any<br>
&gt; when !=3D k_mutex_unlock(l)<br>
&gt; return@p ...;<br>
&gt; }<br>
&gt;<br>
&gt; First I match k_mutex_lock. Then there can be any statements between t=
hat and the first check.<br>
<br>
I suggest to take further case distinctions better into account<br>
also for such a source code analysis approach.<br>
<br>
I imagine that you would like to restrict the code which may be used<br>
between a function call and a corresponding return value check.<br>
Should the (compound) statement be restricted also for the corresponding if=
 branch?<br>
<br>
<br>
&gt; If locking fails then in the first check it is valid to return.<br>
<br>
Such a control flow possibility is reasonable.<br>
<br>
<br>
&gt; Not sure how to capture that this first if statement must return in th=
at case.<br>
<br>
How do you think about to add any SmPL disjunctions and to adjust the usage=
<br>
of SmPL ellipses?<br>
<br>
<br>
&gt; Then there can follow additional if statements and in all of them ther=
e must be an unlock if there is also a return.<br>
<br>
* Why do you try to exclude the assignment of the item =E2=80=9Cr=E2=80=9D =
to other items?<br>
<br>
* Would you occasionally like to support (lock) scopes which would be distr=
ibuted over<br>
=C2=A0 multiple function implementations?<br>
<br>
Regards,<br>
Markus<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=
=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>Best regar=
ds,<br><br><font face=3D"arial narrow, sans-serif"><img src=3D"https://ci3.=
googleusercontent.com/mail-sig/AIorK4wH6aPZe4eYWheYhio282OdbmPN-eMyvcew6Pbe=
QLd1K_qGuSNTnBuq0VT6bSD79PDVrzgSr5c" width=3D"74" height=3D"96"></font></di=
v><div><font face=3D"arial narrow, sans-serif">Martin Schr=C3=B6der</font><=
/div><div><i><font face=3D"arial narrow, sans-serif">Embedded Firmware Cons=
ultant</font></i></div><div><span style=3D"font-family:&quot;arial narrow&q=
uot;,sans-serif;font-style:italic"><a href=3D"https://www.linkedin.com/in/m=
artinschroder/" target=3D"_blank">Connect on LinkedIn</a></span></div><div>=
<i><a href=3D"https://calendly.com/martinschroder/call" target=3D"_blank">B=
ook online meeting</a></i></div><div><span style=3D"font-family:&quot;arial=
 narrow&quot;,sans-serif;font-style:italic"><br></span></div><div><font fac=
e=3D"arial narrow, sans-serif">Swedish Embedded Consulting Group AB</font><=
/div><div><font face=3D"arial narrow, sans-serif">W. <a href=3D"https://swe=
dishembedded.com" target=3D"_blank">https://swedishembedded.com</a></font><=
/div><div><font face=3D"arial narrow, sans-serif"><br></font></div><div><br=
></div></div></div></div></div></div></div></div></div></div>

--0000000000007869e606084fbced--
