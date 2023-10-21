Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4025C07545
	for <cocci@archiver.kernel.org>; Tue, 24 Oct 2023 05:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ps8StpECzPn1E3l2uPZ/JLWI1jibaj73JEp/JrORwE8=;
  b=kGYf9FDyejnAIbCzMq5vlv+EqFoYwnHwfXLLuG2kZWDkPiQcusUGR+4A
   5nI5ylAUO5a6LhhTrBSXkiuW3NdpkV6AlipikrEWgGUtzP+TfkjfcgjtO
   0vo4Szc9haXZScEVgDg/Gu/ed4uUKUBrPE/Y+bLH4vOSTRS+tmM82kK3c
   s=;
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
   d="scan'208,217";a="132814735"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2023 07:48:06 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F0BE3E0CD5; Tue, 24 Oct 2023 07:48:05 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 97934E00B7
	for <cocci@sympa.inria.fr>; Sat, 21 Oct 2023 23:51:04 +0200 (CEST)
IronPort-SDR: 653447c6_sVRBFfrOzJ5p1jsIGFk2KwNZ9uFoBbp/8rK+UGR5jpFlmHI
 C3OpA4E7bznp1IRNlsXbznVYJQOYGzDwwnXQp3w==
X-IPAS-Result: =?us-ascii?q?A0EGBABrRzRlfzLQVdFaHgE8DAILgWSCOXpVMQQLSIRTg?=
 =?us-ascii?q?SOCLIttgiMDlyyHdQMYFigPAQMBDT0HBAEBAwEDgguCdAKHFwIeBwEEMwYOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAhABASIZBw4OKYVoDYI3K?=
 =?us-ascii?q?wERImpLFAk1AQEBAQEBAQEBAQEBAQEBAQEBAQEBARQCCAUZEjEBHwEBAQIBE?=
 =?us-ascii?q?hEdAQE3AQQLCws3AgIiEgEFARwGEyKCXYIqAw4jAxGlfYEFQos7gTKBAYIJA?=
 =?us-ascii?q?QEGgQevGCKBFoEeAwYUgRwZiAkBgU4BAYc8eicbgg2BS4JEMT6CYQKCDYMug?=
 =?us-ascii?q?miDDG2CQoJ5BQIygUNfg1mFLIV/JikEBwcjIgRDGFgbAwcDgQMQKwcEMhsHB?=
 =?us-ascii?q?gkWGBUlBlEELSQJExI+BHN0gVEKgQY/Dw4RgkMrNjYZS4FffAkVBgE6TXYQK?=
 =?us-ascii?q?gQUF4EKCARqHxUeNxESFw0DCHYdAhEjPAMFAwQ0ChUNCyEFFEMDRAZKCwMCH?=
 =?us-ascii?q?AUDAwSBNgUNHgIQGgYNJwMDGU0CEBQDOwMDBgMLMQMwV0cMWQNVFx82CTsPD?=
 =?us-ascii?q?B8CMAECAR0mHUADC2ILPTUUG00gnQhtgXdsCIEVJFEDEiqBPimvdZRphBY0C?=
 =?us-ascii?q?ItFlSIzqXeYPIsJglyGdo5BhSUQI4FWJIFcMyIbFWwGgjBPAxkPkhiPe0IyA?=
 =?us-ascii?q?jkCBwEKAQEDCYI5hA+CWoIpAQE?=
IronPort-PHdr: A9a23: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
 aSBHCzbSr5QlLttcGpmhAPRtd1EHvsOFcV5
IronPort-Data: A9a23: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
 vSRD6ACOXm4
IronPort-HdrOrdr: A9a23:axJiJ6h+vSChS9pF9ttmze33yHBQXuUji2hC6mlwRA09TyVXrb
 HWoB17726NtN91YhsdcL+7Scy9qB/nhPxICMwqTNSftWrd2VdATrsSibcKqgeIc0bDH6xmtZ
 uIGJIOb+EYY2IK6/oSIzPVLz/j+rS6GWyT6ts2Bk0CcT1X
X-Talos-CUID: =?us-ascii?q?9a23=3Aj0nbmWuAW1iHPIevPMA5k3dQ6IsUdXzD7ibZOHS?=
 =?us-ascii?q?VKnkuUJuXQHCh3J5dxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AYIDN1Q7d1T1UdOdyM35N2/HUxox3z6+0GB0KzK4?=
 =?us-ascii?q?stua+LwpBHBqAkxu4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,242,1694728800"; 
   d="scan'208,217";a="69393619"
X-MGA-submission: =?us-ascii?q?MDFtLXrV6KPp7tRXA3vZF0DOq6g8cbo1+XnWY/?=
 =?us-ascii?q?01qYUQMHo51ZuWDSwFWf/H+5iX5xZ0/GuAyz455UvKlKhHxTkr7iFF2c?=
 =?us-ascii?q?8qSEps29SS2txwDySi0HgQAsGuL5EGFygI+UHUPRht3j3bZnYmUUc/2Y?=
 =?us-ascii?q?F6qXqqav1pA75gh/mW/mWQtQ=3D=3D?=
Received: from mail-ed1-f50.google.com ([209.85.208.50])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2023 23:51:02 +0200
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-53f9af41444so3096045a12.1
        for <cocci@inria.fr>; Sat, 21 Oct 2023 14:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swedishembedded-com.20230601.gappssmtp.com; s=20230601; t=1697925061; x=1698529861; darn=inria.fr;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ps8StpECzPn1E3l2uPZ/JLWI1jibaj73JEp/JrORwE8=;
        b=qz+N1Dc86k/QH1/0L6cmxvoTsJtoKt4Oo39Qa7vXGTLBJFSN75IEpTd0FT89t1wIBU
         GulPus6gNs7eEkTAU1LWXlchYp/I+h4/jLjYRWqz5tY8tB6/dwEELbLA4KuWEAKvada1
         dgFWyrilD7kBBB/GP1Uebr4iPMyRU6mYlFBJBgxJHG5tTtiK2foX+QMv8T3gPmyC4orS
         tXl7tmjf3+hGhB7jqNlxVjIzZd2+nucSus0e4RtJfw7M9vZOs09/N5SerJ5mJ4l3BOMP
         72vDa8CI7mXxAPciKki3y/6VGYhv36spYrC8c/A32S5xCJlQRGCauCe7cfnt4CtymjrM
         qgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697925061; x=1698529861;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ps8StpECzPn1E3l2uPZ/JLWI1jibaj73JEp/JrORwE8=;
        b=nUD9w/gDI3MHN+XJ9aGWfOF2nP6kpSidqGoU/bqCyLPME84LfirjnVYdMXmPYsmkiH
         8OGyQDaq1ZiHIgYbDgCK/kG2BYy4juz0twBzTWj+AltKB12TuFdrNZfgxg/aggLK8c30
         d+RJxlFNg6j+PkSA4G8M7UDQg/audfU9ctqGqVGuoKuoTmJB9g56it0k+LasmqqNNGSJ
         wzPb5QRyni/7/hW7nwI+mWR2JJmAjspDBYrOvSJbLsovTDeVVHU8DXSLvuH7vfOlINEY
         9WQykQ6BnhrZnrhoamABf8sPkK5zMG80ksBW/gYoxcPmd/nL4TyVJZYj7sKHaxXyIIu+
         wJew==
X-Gm-Message-State: AOJu0Yw0Xi3rRwJfSbOZZmu6sgDs6vyuKUOyV+zJ6In54KkBsyzaJa5S
	CLkA7sELAtBtrRVGaHMzfAQyC/Ft572O4VZ2NpGWkA==
X-Google-Smtp-Source: AGHT+IEj4R0FocvrfE7xexESbd0LFsk1MU40lz8IJk9YjqH0F3m+fEqjw0s6u3nAZMLcK4N9+ZuijtFTHqEy0AVULu8=
X-Received: by 2002:a17:907:1b11:b0:9ae:6ad0:f6db with SMTP id
 mp17-20020a1709071b1100b009ae6ad0f6dbmr4420327ejc.71.1697925061104; Sat, 21
 Oct 2023 14:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAEqMKof5Ke4yV0KBZm2FW8z-Ct1UHZRDz5=Sd3gaO3a-f4+y_w@mail.gmail.com>
 <6213b47a-3ae7-d316-b1a4-8fb5d3bf9b5@inria.fr> <608e77e0-a36d-44ef-a2fd-9c0c50cf61b3@web.de>
In-Reply-To: <608e77e0-a36d-44ef-a2fd-9c0c50cf61b3@web.de>
From: =?UTF-8?Q?Martin_Schr=C3=B6der?= <info@swedishembedded.com>
Date: Sat, 21 Oct 2023 23:50:49 +0200
Message-ID: <CAEqMKoco-UjiPu4bwm69t1HexJi0y+cCPEH6NZ10xZCfn36=5w@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Content-Type: multipart/alternative; boundary="0000000000001f6a6d060840fc64"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Finding functions that do not unlock mutex in the same
 function
Reply-To: =?UTF-8?Q?Martin_Schr=C3=B6der?= <info@swedishembedded.com>
X-Loop: cocci@inria.fr
X-Sequence: 1271
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/CAEqMKoco-UjiPu4bwm69t1HexJi0y%2BcCPEH6NZ10xZCfn36%3D5w%40mail.gmail.com>

--0000000000001f6a6d060840fc64
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Julia.

My final script that seems to work looks like this:

virtual report
virtual patch

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

First I match k_mutex_lock. Then there can be any statements between that
and the first check.

If locking fails then in the first check it is valid to return. Not sure
how to capture that this first if statement must return in that case.

Then there can follow additional if statements and in all of them there
must be an unlock if there is also a return.

The sample code looks like this:

struct k_mutex lock;

int function(){

int r =3D k_mutex_lock(&lock, K_FOREVER);
if(r){

return -ETIMEDOUT; // valid to not unlock here

}
r =3D produce_something();
if(r){

k_mutex_unlock(&lock);

return -EIO;

}
r =3D produce_something();
if(r){

return -EINVAL; // here an unlock is missing

}
k_mutex_unlock(&lock);
return 0;

}

On Fri, 20 Oct 2023 at 17:01, Markus Elfring <Markus.Elfring@web.de> wrote:

> > I think you could just put
> >
> > ... when any
> >     when !=3D  k_mutex_unlock(l)
> >
> > and drop the rest.
>
> How do you think about to check the desired consistency of lock scopes
> in more detail?
>
> Will any software extensions become helpful for further source code
> analyses?
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

--0000000000001f6a6d060840fc64
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Julia.<div><br></div><div>My final script that seem=
s to work looks like this:<br><br>virtual report<br>virtual patch<br><br>@ =
r exists @<br>expression l;<br>identifier r, e;<br>position p;<br>@@<br>r =
=3D k_mutex_lock(l, ...)<br>... when any<br>if(r){ ... }<br>... when !=3D e=
 =3D r<br>	when any<br>if(e){<br></div>... when any<br>when !=3D k_mutex_un=
lock(l)<br><div>	return@p ...;</div><div>}<br><br></div><div>First I match =
k_mutex_lock. Then there can be any statements between that and the first c=
heck.</div><div><br></div><div>If locking fails then in the first check it =
is valid to return. Not sure how to capture that this first if statement mu=
st return in that case.=C2=A0</div><div><br></div><div>Then there can follo=
w additional if statements and in all of them there must be an unlock if th=
ere is also a return.</div><div><br></div><div>The sample code looks like t=
his:</div><div><br></div>struct k_mutex lock;<br><br>int function(){<br><bl=
ockquote style=3D"margin:0 0 0 40px;border:none;padding:0px">int r =3D k_mu=
tex_lock(&amp;lock, K_FOREVER);<br>if(r){<blockquote style=3D"margin:0 0 0 =
40px;border:none;padding:0px">return -ETIMEDOUT; // valid to not unlock her=
e</blockquote>}<br>r =3D produce_something();<br>if(r){<blockquote style=3D=
"margin:0 0 0 40px;border:none;padding:0px">k_mutex_unlock(&amp;lock);</blo=
ckquote><blockquote style=3D"margin:0 0 0 40px;border:none;padding:0px">ret=
urn -EIO;</blockquote>}<br>r =3D produce_something();<br>if(r){<blockquote =
style=3D"margin:0 0 0 40px;border:none;padding:0px">return -EINVAL; // here=
 an unlock is missing</blockquote>}<br>k_mutex_unlock(&amp;lock);<br>return=
 0;</blockquote>}</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Fri, 20 Oct 2023 at 17:01, Markus Elfring &lt;<a href=
=3D"mailto:Markus.Elfring@web.de">Markus.Elfring@web.de</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; I think you cou=
ld just put<br>
&gt;<br>
&gt; ... when any<br>
&gt;=C2=A0 =C2=A0 =C2=A0when !=3D=C2=A0 k_mutex_unlock(l)<br>
&gt;<br>
&gt; and drop the rest.<br>
<br>
How do you think about to check the desired consistency of lock scopes<br>
in more detail?<br>
<br>
Will any software extensions become helpful for further source code analyse=
s?<br>
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

--0000000000001f6a6d060840fc64--
