Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31B2C77B75
	for <cocci@archiver.kernel.org>; Tue, 18 Apr 2023 05:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=AIdzb7XHAVLs8803XEeB2ST8H64rPIYmDoD5GGZzQAE=;
  b=Zkp95iDH59s1mJowiNCCNHVfLIt5JW4gzfaQiHZd4raOY2YSvCEwF8gs
   WMG54A6Wea/7ow8j21IXs+tpbQpaRsQb7mof3KRVb9uoM+ffkGqRYKifG
   xxjc5+/bcd0wUNcGMYWGn0LguICjHay2m/y2pZWAJ5hriy8npA79VbpBn
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@rice.edu
X-IronPort-AV: E=Sophos;i="5.99,206,1677538800"; 
   d="scan'208,217";a="103517885"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Apr 2023 07:38:35 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D41D3E0298; Tue, 18 Apr 2023 07:38:34 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id F0BE1E00A8
	for <cocci@sympa.inria.fr>; Mon, 17 Apr 2023 19:48:56 +0200 (CEST)
IronPort-SDR: 643d8687_w5Zy2kO13PdGhEjPQOF5ztNHqZPpQrL+DcPxkK3qVYxdBrU
 8LnieqzKz8b6CdkwRRyNMKwsxdO/ttLHBYYOsiQ==
X-IPAS-Result: =?us-ascii?q?A0GGAQDghT1kmPSZo5RahQZ1gQUEC0aEU4h9iDaLW4szh?=
 =?us-ascii?q?HiDVAYJAQMBCwEBRAQBAQMEhH8ChTwCHQcBBDQTAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QMBAQUBAQECAQECBAUBAhABAQEBAQEBARUJGQUQDgUihWgNgjcpAXWBCAEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEWAhRxAQEBAxIRHQEBNwEPCQIEFCoCAjQBBQEcB?=
 =?us-ascii?q?hMbB4JcAYJcA5FLjyASckJuQIkKAQEBeIEygQGCCAEBBp01AQmBawkSgS+HT?=
 =?us-ascii?q?HZeAQGIGSeBGIEQgTwMgkcxPoFThkyCZ5pbgTR2gSAOgTyBBAIJAhFrgRAIa?=
 =?us-ascii?q?1uBGgRAAg1kCw5vgUmDKgQCFAUxDg4WBzYDRB1AAgFGOjwBNQkLHwaBLUIkB?=
 =?us-ascii?q?QMLFSpHBAg4Bhw0EQIIDxIPBiZEDEIhFjMTBlwBHA0LDhEDTTOBEwQvgV0GA?=
 =?us-ascii?q?SYknxmEOFYBAQGVPY0roAMBBgKEAKByBlWWdhSSJZd3ol2FGQIEAQEBAwUCB?=
 =?us-ascii?q?hAjgVcjgVwzGiWBbIFJTwMZD44sDQmEOo8tJDM9AgcBCgEBAwmLRQEB?=
IronPort-PHdr: A9a23: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
 GokG6uihqeR5i4ej/liSTUp0w==
IronPort-Data: A9a23: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
 ITteV15fQ==
IronPort-HdrOrdr: A9a23:7IUUV6pFS7wpbxaxPLe0ELwaV5rWeYIsimQD101hICG9vPbo8f
 xG/c5rqiMc7Qx6ZJhOo6HkBEDtewK5yXcx2/hoAV7AZnibhILLFvAa0WKK+VSJcECTh4xgPO
 VbAtND4bbLfCJHZKjBkW6F+hUbruVvMprGuQ4T9RdQZDAvUrpn6QhhDAadDwlaYTAuP+tGKH
 NZ3Ls3mxOQPU8aZsm3A3VAe+TYvdXEmNbHTHc9dmMaAcC17ELK1ILH
X-Talos-CUID: =?us-ascii?q?9a23=3ABOrP02sASiq/odqAk+umTaog6Is0dXuC4C7+D3O?=
 =?us-ascii?q?lEH1iEv66VAeJv4Frxp8=3D?=
X-Talos-MUID: 9a23:W2pHnQQDgOoG37/nRXS8r2ljFNpLyZjzJ3o1vIcZmevfKj5JbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,204,1677538800"; 
   d="scan'208,217";a="53585127"
X-MGA-submission: =?us-ascii?q?MDFMOmMS5Y4p/8ZovYha29dWxUzp/vEhxVobnH?=
 =?us-ascii?q?1W9fnvamZ+omLMlmvKwPMboSl7kWM4Ky/E7O2mtZyEBvFTvQVRUblf2j?=
 =?us-ascii?q?lUZ9AiCUx9qb2Te4BAUPxmDpp5QV2AjqVPCRzQ9o5WoWVKqQITyMaAaF?=
 =?us-ascii?q?dJ8M0UqZcqjlHeo3SxUyELQQ=3D=3D?=
Received: from mx0b-0010f301.pphosted.com ([148.163.153.244])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 19:48:55 +0200
Received: from pps.filterd (m0102858.ppops.net [127.0.0.1])
	by mx0b-0010f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HDwcX9024460
	for <cocci@inria.fr>; Mon, 17 Apr 2023 12:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rice.edu; h=date : from : to : cc :
 message-id : in-reply-to : references : subject : mime-version :
 content-type; s=ricemail; bh=AIdzb7XHAVLs8803XEeB2ST8H64rPIYmDoD5GGZzQAE=;
 b=c3B9uSsygJFnZ7Rk8FnHOpE8vdHERiaYPBeHYnJ0DQgpnIbCVWft8CROPe559tF12S7m
 W/wg/cFf1bEDOy/4NXbYNkiaNPituc0oOfWTb7sNTY+DlBEDtZmjT0zLCmV585g86uTH
 Y/msU7f1SgH6oIZ0FFdeoRZ5Y2xqQF/68wNhNMHwXrv8R2isl82OrTZVtREedDYZ3+t/
 XS6DX7Wv1HfO5c6pwNjg2E/lnWiQmDBiCsepZiCc4zvS9mkMueGqTqJ9NpwNisF5q2Uj
 0mdAt2Sd1bpbEfLSoyRqOTs1FqXhJVnmOX+EhzwZoYVnRowHEwvAlhAo4RncddZeLelQ iw== 
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0b-0010f301.pphosted.com (PPS) with ESMTPS id 3pypmu2x1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <cocci@inria.fr>; Mon, 17 Apr 2023 12:48:53 -0500
Received: by mail-oo1-f69.google.com with SMTP id z18-20020a4a4912000000b005466c327979so921321ooa.15
        for <cocci@inria.fr>; Mon, 17 Apr 2023 10:48:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681753732; x=1684345732;
        h=mime-version:subject:references:in-reply-to:message-id:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AIdzb7XHAVLs8803XEeB2ST8H64rPIYmDoD5GGZzQAE=;
        b=PNBrBW3hPF5s/WRqO9JErGMLE0KXEu5CtHZzPQXm3hb8hPEzZSFKDnhVzmSNn1XJTr
         8QYOQy7oQb2Y48TnvWwYv5UbQboEMHm37y6QKwb4u7adHnaBtzyUL2qoKqHftTu1jKeU
         MripjLM4zfQs5wKV5kOFfhaT6RnTdIunQjSagh9skDrJNkpZro/1tKlje25zxrpxAeDa
         FehLVu4zfdSwWx6d8cBIHNxQVIRE8xk/Uqumxy8Egm23mBum9w7Iv2t8g2V/zvkYquII
         BNVIItRGUUwu1CqrSEIEQTNGo/fJ/gkv9pFb7ESBC4rHftQbf6G8cST0lZgDJkjczr84
         Qw+w==
X-Gm-Message-State: AAQBX9etXnkTz6O1dwIINzgoQMmjsZ8YW8ZYc91hmcQBnLthKiY8rMlm
	HuBvfkhKQInUaQ3oWupE+1623SCzivQeNRU4ArLLrDw8x64EWHUx2llSq3/WFc/iChyZt6OFZev
	uezJ59rxNnW6RDXKYshela2hmUnP1IKKO
X-Received: by 2002:a05:6808:2029:b0:38c:66d3:67b8 with SMTP id q41-20020a056808202900b0038c66d367b8mr3819429oiw.16.1681753732262;
        Mon, 17 Apr 2023 10:48:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yiy3fT0ILnFzTpvMzNgJqKPWqN8RJqgqm6fumxw0AQy7JP9tHNWCff/32X6m9yKndMVOJ8cA==
X-Received: by 2002:a05:6808:2029:b0:38c:66d3:67b8 with SMTP id q41-20020a056808202900b0038c66d367b8mr3819426oiw.16.1681753731941;
        Mon, 17 Apr 2023 10:48:51 -0700 (PDT)
Received: from [168.5.40.224] (yudidembp.dyndns.rice.edu. [168.5.40.224])
        by smtp.gmail.com with ESMTPSA id m14-20020a9d644e000000b006a4308f1e2asm4663062otl.54.2023.04.17.10.48.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Apr 2023 10:48:51 -0700 (PDT)
Date: Mon, 17 Apr 2023 12:48:45 -0500
From: Yudi Yang <jy103@rice.edu>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <d41fcc6e-5888-409a-99cf-0e5b8bcc739c@Spark>
In-Reply-To: <alpine.DEB.2.22.394.2304151852450.2975@hadrien>
References: <da277553-d798-4dd0-a0bb-f641f41a16bf@Spark>
 <alpine.DEB.2.22.394.2304150930200.2975@hadrien>
 <7ce84f72-833a-4bd7-84cc-2fd8a473d0e7@Spark>
 <alpine.DEB.2.22.394.2304151852450.2975@hadrien>
X-Readdle-Message-ID: d41fcc6e-5888-409a-99cf-0e5b8bcc739c@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="643d8682_3cebd7f_1df"
X-Proofpoint-DLP: Gmail-Outbound
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_12,2023-04-17_01,2023-02-09_01
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Match and print size of allocation
Reply-To: Yudi Yang <jy103@rice.edu>
X-Loop: cocci@inria.fr
X-Sequence: 1082
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/d41fcc6e-5888-409a-99cf-0e5b8bcc739c%40Spark>

--643d8682_3cebd7f_1df
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Julia,
I have tried out the following, but it seems not working.

(
=C2=A0=C2=A0D;
+ printf(=22%d=22, SIZE);
&
=C2=A0=C2=A0malloc(SIZE)
)

Best,
Yudi
=E5=9C=A8 2023=E5=B9=B44=E6=9C=8815=E6=97=A5 -0500 11:53=EF=BC=8CJulia La=
wall <julia.lawall=40inria.fr>=EF=BC=8C=E5=86=99=E9=81=93=EF=BC=9A
>
>
> On Sat, 15 Apr 2023, Yudi Yang wrote:
>
> > Thank you. It now matches if-statements. However, in case of a variab=
le initializer such as:
> >
> > void* p =3D malloc(100);
> >
> > The solution does not correctly recognize the allocation.
>
> You should be able to use the same idea, except put D, declared as
>
> declaration D;
>
> julia
>
> >
> > Best, Yudi
> >
> > =E5=9C=A8 2023=E5=B9=B44=E6=9C=8815=E6=97=A5 -0500 02:31=EF=BC=8CJuli=
a Lawall <julia.lawall=40inria.fr>=EF=BC=8C=E5=86=99=E9=81=93=EF=BC=9A
> >
> >
> > On Sat, 15 Apr 2023, Yudi Yang wrote:
> >
> > Hello Julia,
> >
> > Thank you for your answer=21 I have modified my code:
> >
> > =40=40
> > expression E, SIZE, N;
> > statement S;
> > =40=40
> > (
> > =C2=A0=C2=A0E =3D malloc(SIZE);
> > + printf(=22%d=22, SIZE);
> > =7C
> > =C2=A0=C2=A0E =3D calloc(N, SIZE);
> > + printf(=22%d=22, (N) * (SIZE));
> > )
> >
> > However, it cannot match initializations and if-statements.
> > I am not quite understanding your =22malloc(SIZE)=40S=22 solution.
> > Could you point on how to use the it, or perhaps some related links=3F=

> >
> >
> > What I proposed didn't work, but the following works fine:
> >
> > =40=40
> > statement S;
> > expression size;
> > =40=40
> >
> > (
> > S
> > +printf(=22%d=5Cn=22,size);
> > &
> > malloc(size)
> > )
> >
> > julia
> >
> >

--643d8682_3cebd7f_1df
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageBodySection=22>
<div dir=3D=22auto=22><span style=3D=22font-family:Courier New=22>Hi Juli=
a,</span><br />
<span style=3D=22font-family:Courier New=22>I have tried out the followin=
g, but it seems not working.</span><br />
<br />
<span style=3D=22font-family:Courier New=22>(</span><br />
<span style=3D=22font-family:Courier New=22>&=23160;&=23160;D;</span><br =
/>
<span style=3D=22font-family:Courier New=22>+ printf(=22%d=22, SIZE);</sp=
an><br />
<span style=3D=22font-family:Courier New=22>&amp;</span><br />
<span style=3D=22font-family:Courier New=22>&=23160;&=23160;malloc(SIZE)<=
/span><br />
<span style=3D=22font-family:Courier New=22>)</span></div>
</div>
<div name=3D=22messageSignatureSection=22><br />
<div class=3D=22match=46ont=22><font face=3D=22Courier New=22>Best,</font=
>
<div dir=3D=22auto=22><font face=3D=22Courier New=22>Yudi</font></div>
</div>
</div>
<div name=3D=22messageReplySection=22>=E5=9C=A8 2023=E5=B9=B44=E6=9C=8815=
=E6=97=A5 -0500 11:53=EF=BC=8CJulia Lawall &lt;julia.lawall=40inria.fr&gt=
;=EF=BC=8C=E5=86=99=E9=81=93=EF=BC=9A<br />
<blockquote type=3D=22cite=22 style=3D=22border-left-color: grey; border-=
left-width: thin; border-left-style: solid; margin: 5px 5px;padding-left:=
 10px;=22><br />
<br />
On Sat, 15 Apr 2023, Yudi Yang wrote:<br />
<br />
<blockquote type=3D=22cite=22>Thank you. It now matches if-statements. Ho=
wever, in case of a variable initializer such as:<br />
<br />
void* p =3D malloc(100);<br />
<br />
The solution does not correctly recognize the allocation.<br /></blockquo=
te>
<br />
You should be able to use the same idea, except put D, declared as<br />
<br />
declaration D;<br />
<br />
julia<br />
<br />
<blockquote type=3D=22cite=22><br />
Best, Yudi<br />
<br />
=E5=9C=A8 2023=E5=B9=B44=E6=9C=8815=E6=97=A5 -0500 02:31=EF=BC=8CJulia La=
wall &lt;julia.lawall=40inria.fr&gt;=EF=BC=8C=E5=86=99=E9=81=93=EF=BC=9A<=
br />
<br />
<br />
On Sat, 15 Apr 2023, Yudi Yang wrote:<br />
<br />
Hello Julia,<br />
<br />
Thank you for your answer=21 I have modified my code:<br />
<br />
=40=40<br />
expression E, SIZE, N;<br />
statement S;<br />
=40=40<br />
(<br />
&=23160;&=23160;E =3D malloc(SIZE);<br />
+ printf(=22%d=22, SIZE);<br />
=7C<br />
&=23160;&=23160;E =3D calloc(N, SIZE);<br />
+ printf(=22%d=22, (N) * (SIZE));<br />
)<br />
<br />
However, it cannot match initializations and if-statements.<br />
I am not quite understanding your =22malloc(SIZE)=40S=22 solution.<br />
Could you point on how to use the it, or perhaps some related links=3F<br=
 />
<br />
<br />
What I proposed didn't work, but the following works fine:<br />
<br />
=40=40<br />
statement S;<br />
expression size;<br />
=40=40<br />
<br />
(<br />
S<br />
+printf(=22%d=5Cn=22,size);<br />
&amp;<br />
malloc(size)<br />
)<br />
<br />
julia<br />
<br />
<br /></blockquote>
</blockquote>
</div>
</body>
</html>

--643d8682_3cebd7f_1df--

