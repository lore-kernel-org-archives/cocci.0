Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFA5C7619A
	for <cocci@archiver.kernel.org>; Sat, 15 Apr 2023 07:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=3Wz4bywk00NkmGdrlo9aAjcsHp7D6oSi2rReiqb4Wvk=;
  b=vbjge2PZvfPVCPGijba5C1XqGFf2sZ+T37Xd6do2uDza8I1dY8cSk9Gs
   IAZ/z4AVDrVd/0JESODo3ti6lbwQw4gcIFxLXhOw5xkuafm88M5D2TnBA
   XqIHrkFuPFs5dayy8kKZBsGOBMUllcrIqaXJZs6latcMe9HweIamNIXct
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
X-IronPort-AV: E=Sophos;i="5.99,199,1677538800"; 
   d="scan'208,217";a="103202207"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Apr 2023 09:23:45 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 477F8E0297; Sat, 15 Apr 2023 09:23:46 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2DE75E00A8
	for <cocci@sympa.inria.fr>; Sat, 15 Apr 2023 08:13:53 +0200 (CEST)
IronPort-SDR: 643a4092_TIGfPFShS7qm5GXS+nIWc5+ocdUGQ8+oe9tOSs+hGTt8ylv
 stO/eo5NYWdm2XUYUTt2eJS5pFAutYwHfb8AUYQ==
X-IPAS-Result: =?us-ascii?q?A0GNAQAwQDpkmPSZo5RahDRSdYEFBAtGhFOIfYYPgieLW?=
 =?us-ascii?q?4szhHiDQBQGCQEDAQsBAUICBAEBAwSEf4U+Ah0HAQQ0EwECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBAQEBAQEVCRkFEA4FIoVoDYI3KQF1g?=
 =?us-ascii?q?QgBAQEBAQEBAQEBAQEBAQEBAQEBFgIUcAEBAQECExEdAQE3AQQWGCoCNgEFA?=
 =?us-ascii?q?SITGweCXAGCOSMDAaB5EnJCbkCJCgEBAXiBMoEBgggBAQadNQEJgWsJEoEvh?=
 =?us-ascii?q?0weWF4BAYgZJ4EYgRCBPIJTMT6BU4ZMgmeJa5BrgTR2gSAOgTyBBAIJAhFrg?=
 =?us-ascii?q?RAIaluBGgRAAg1kCw5vgUmDKgQCFAUxDg4XBzYDRB1AAgFGOj4BNQkLIAaBL?=
 =?us-ascii?q?UIkBQMLFSpHBAg4Bk8RAggPEg8GJkQMQiEWMxMGXAEcDQsOEQNONIETBC+BW?=
 =?us-ascii?q?wcmJJ8ZhDtTAQEBkXGDTI0roAABBgKEAIpQliIGVZZ2kjmXdaJdhRkCBAEBA?=
 =?us-ascii?q?QMFAgYQI4FXI4FcMxolgWyBSU8DGQ+OOYRDjy0kMz0CAQYBCgEBAwmFaYVcA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 XmKxuM=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:oy9SZKj6vBE/TGUg0WPQ+65McnBQXhsji2hC6mlwRA09TyVXrb
 HJoB17726ItN91YhsdcL+7Scy9qB/nhPpICOoqTM2ftWvdyRKVxehZhOOIrlGQeREWndQtrZ
 uIHZIOb+EYzmIVsS852maF+hoboOWvweSQnuHZwG5qTQZ2L4xE1m5Ce3qm+4lNNXZ7LKt8L5
 aV68dDq36FdW4MZsq2QlkpNtKz3OEjXaiGEH07OyI=
X-Talos-CUID: 9a23:yaPh5W8RLdPs9/oi4NGVv21EJ/gCTS399mfZAUKDBl4yapOnE1DFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3A9qUGcg2iENvuCYZGiVmsfYbPKDUjwqvpWGc2yLc?=
 =?us-ascii?q?9qszZOwV8MivEyzubXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,199,1677538800"; 
   d="scan'208,217";a="53417207"
X-MGA-submission: =?us-ascii?q?MDHsxXJfzeNamZgSOOumOs8VklmDjlFBZ3f+Jd?=
 =?us-ascii?q?qfRH5P+K1xwb3hxhgNMth9yh/8hHXp1w0TPSqx2nwNvfBJp7HMa4nT9u?=
 =?us-ascii?q?nK7uKB6s9qohQ7/y5DTgoG9+5P0Hf5LobmRfHSh0mChxqPO6/E8ttPVY?=
 =?us-ascii?q?Ra2mAMLvZkKaeX8JCUrGEvDw=3D=3D?=
Received: from mx0b-0010f301.pphosted.com ([148.163.153.244])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2023 08:13:38 +0200
Received: from pps.filterd (m0102859.ppops.net [127.0.0.1])
	by mx0b-0010f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33F46tAK021700
	for <cocci@inria.fr>; Sat, 15 Apr 2023 01:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rice.edu; h=date : from : to : cc :
 message-id : subject : mime-version : content-type; s=ricemail;
 bh=3Wz4bywk00NkmGdrlo9aAjcsHp7D6oSi2rReiqb4Wvk=;
 b=lpz3kP5Z926kmHV/xVqpyqjORoox4ORVeagjm42H5MCZ1TXhdAQx4ok80V9s3ifS25z8
 h6rAzyYvxK+n8YQ88K6fZORZGdhZnNvLqi7AvtHEvmMzhEk+isa+Amr+QLLXdLdupzY+
 UtLDQC2s6o3ABBIRknNxYZVt7d9SC+zUGB2nG/EKmCaNbRzx9AwMs04Gpr0gLLg5keLB
 PJU7KNl5Ea3mLuQ1PYHiLu0JxrEA/dxRqry0JeByIWkA6DkkzXIAj4muIV2Twp+7T5tT
 ha1A5H0PemKDjdNr4qBaeR0rzinlnGZHidedtOl5HlF6X0mLyfYD/5WsCWLeMMn0eyDK hg== 
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0b-0010f301.pphosted.com (PPS) with ESMTPS id 3pymkvg20w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <cocci@inria.fr>; Sat, 15 Apr 2023 01:13:35 -0500
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1842ccf7ae4so10608621fac.1
        for <cocci@inria.fr>; Fri, 14 Apr 2023 23:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681539214; x=1684131214;
        h=mime-version:subject:message-id:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Wz4bywk00NkmGdrlo9aAjcsHp7D6oSi2rReiqb4Wvk=;
        b=SnbyITbChkbY6b1SPoQo4lYSlOdSMBqAjeEcS9oh8JW5lI9ccIITiLU52q0Y7zeJsX
         /CJRFiSlUTBVEe1sHzXgKbC4NtxEEKGoB1WiSj6k7LK332YeBmvkkrxWz1CgIaQ9JBKJ
         pJ2kF2/+0LjzpGv4HK46MXAXEbxWEtdyegy5kKWELdbMGUm0F+gVjflSTjNOJ1Dltn9O
         3TRNpEV+8k1pNpzdB3tocm4JdP15tx2q9HArEkfpF+M4clS9csKbfDV3uLHSHGLD4ahH
         wrZIyEAJiMZZEEM6PxTbD8TnZ/ut6Hx0PHikMzUb84gKf7cU/maTFy5jRa6bRJxb7aD6
         kjwg==
X-Gm-Message-State: AAQBX9eHEaMr+QccoRp4fxhkeXhRxGEMe3O2JvYtIC88vXgoFdXeIyC7
	qPmO+yjhEbIag/owXJK6l2UUZ/YTbXVg11q9mjM4btMoLMKighCiV+i4rwlaeihsV5ama00Op/P
	WJDClTBiQyB2ss4KFg8IUVtxybsC4GNDT72hNluD+Ui8=
X-Received: by 2002:a05:6870:d61e:b0:187:88a5:6879 with SMTP id a30-20020a056870d61e00b0018788a56879mr4715066oaq.29.1681539214761;
        Fri, 14 Apr 2023 23:13:34 -0700 (PDT)
X-Google-Smtp-Source: AKy350ab++EbozkUr8GA1VnR4+JJgNgU8jrv6hm5t+lM5pMDgigi0QHENLaRLLnlrIeuDltPCMsTJA==
X-Received: by 2002:a05:6870:d61e:b0:187:88a5:6879 with SMTP id a30-20020a056870d61e00b0018788a56879mr4715060oaq.29.1681539214524;
        Fri, 14 Apr 2023 23:13:34 -0700 (PDT)
Received: from [2600:1700:d00:6760:e094:1451:f87f:0] ([2600:1700:d00:6760:24d9:82c2:900:162])
        by smtp.gmail.com with ESMTPSA id k1-20020a4ab081000000b00541cb3cf2d2sm2454961oon.13.2023.04.14.23.13.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Apr 2023 23:13:34 -0700 (PDT)
Date: Sat, 15 Apr 2023 01:13:28 -0500
From: Yudi Yang <jy103@rice.edu>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <da277553-d798-4dd0-a0bb-f641f41a16bf@Spark>
X-Readdle-Message-ID: da277553-d798-4dd0-a0bb-f641f41a16bf@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="643a408d_3f299ff3_1df"
X-Proofpoint-DLP: Gmail-Outbound
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-15_01,2023-04-14_01,2023-02-09_01
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Match and print size of allocation
Reply-To: Yudi Yang <jy103@rice.edu>
X-Loop: cocci@inria.fr
X-Sequence: 1055
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/da277553-d798-4dd0-a0bb-f641f41a16bf%40Spark>

--643a408d_3f299ff3_1df
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Julia,

Thank you for your answer=21 I have modified my code:

=40=40
expression E, SIZE, N;
statement S;
=40=40
(
=C2=A0=C2=A0E =3D malloc(SIZE);
+ printf(=22%d=22, SIZE);
=7C
=C2=A0=C2=A0E =3D calloc(N, SIZE);
+ printf(=22%d=22, (N) * (SIZE));
)

However, it cannot match initializations and if-statements.
I am not quite understanding your =22malloc(SIZE)=40S=22 solution.
Could you point on how to use the it, or perhaps some related links=3F

Thank you,
Yudi

> On Apr 15, Reiwa 5, at 12:43 AM, Julia Lawall <julia.lawall=40inria.fr>=
 wrote:
>
>
>
> On =46ri, 14 Apr 2023, Yudi Yang wrote:
>
> > Hello,
> >
> > I would like to match the size of allocation, I am wondering if I wri=
te the following:
> >
> > =40print=40
> > expression N, SIZE;
> > =40=40
> >
> > (
> > =C2=A0=C2=A0malloc(SIZE);
>
> Code doesn't usually contain just malloc(...); because then the return
> value would be thrown away. =C2=A0You can write x =3D malloc(SIZE); for=
 an
> expression metavariable x. =C2=A0If malloc can be used in other context=
s, eg an
> if header, then you can write malloc(SIZE)=40S where S is a statement
> metavariable. =C2=A0I think that that will allow the printf to be added=
 after
> the innermost statement containing the call to malloc.
>
> julia
>
> > =7C
> > =C2=A0=C2=A0calloc(N, SIZE);
> > )
> > + printf(=E2=80=9CAllocation: %d=5Cn=22, (N) * (SIZE));
> >
> > I am not sure if I could set the default value for N in the malloc ca=
se, or is there anything I should do to make it correct.
> >
> > Best, Yudi
> >
> >

--643a408d_3f299ff3_1df
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageBodySection=22>
<div dir=3D=22auto=22><span style=3D=22font-family:Courier New=22>Hello J=
ulia,</span><br />
<br />
<span style=3D=22font-family:Courier New=22>Thank you for your answer=21 =
I have modified my code:</span><br />
<br />
<span style=3D=22font-family:Courier New=22>=40=40</span><br />
<span style=3D=22font-family:Courier New=22>expression E, SIZE, N;</span>=
<br />
<span style=3D=22font-family:Courier New=22>statement S;</span><br />
<span style=3D=22font-family:Courier New=22>=40=40</span><br />
<span style=3D=22font-family:Courier New=22>(</span><br />
<span style=3D=22font-family:Courier New=22>&=23160;&=23160;E =3D malloc(=
SIZE);</span><br />
<span style=3D=22font-family:Courier New=22>+ printf(=22%d=22, SIZE);</sp=
an><br />
<span style=3D=22font-family:Courier New=22>=7C</span><br />
<span style=3D=22font-family:Courier New=22>&=23160;&=23160;E =3D calloc(=
N, SIZE);</span><br />
<span style=3D=22font-family:Courier New=22>+ printf(=22%d=22, (N) * (SIZ=
E));</span><br />
<span style=3D=22font-family:Courier New=22>)</span><br />
<br />
<span style=3D=22font-family:Courier New=22>However, it cannot match init=
ializations and if-statements.</span><br />
<span style=3D=22font-family:Courier New=22>I am not quite understanding =
your =22malloc(SIZE)=40S=22 solution.</span><br />
<span style=3D=22font-family:Courier New=22>Could you point on how to use=
 the it, or perhaps some related links=3F</span></div>
</div>
<div name=3D=22messageSignatureSection=22><br />
<div class=3D=22match=46ont=22><font face=3D=22Courier New=22>Thank you,<=
/font>
<div dir=3D=22auto=22><font face=3D=22Courier New=22>Yudi</font></div>
</div>
</div>
<div name=3D=22messageReplySection=22>
<div dir=3D=22ltr=22><br />
<blockquote type=3D=22cite=22>On Apr 15, Reiwa 5, at 12:43 AM, Julia Lawa=
ll &lt;julia.lawall=40inria.fr&gt; wrote:<br />
<br /></blockquote>
</div>
<blockquote type=3D=22cite=22>
<div dir=3D=22ltr=22>=EF=BB=BF<span></span><br />
<span></span><br />
<span>On =46ri, 14 Apr 2023, Yudi Yang wrote:</span><br />
<span></span><br />
<blockquote type=3D=22cite=22><span>Hello,</span><br /></blockquote>
<blockquote type=3D=22cite=22><span></span><br /></blockquote>
<blockquote type=3D=22cite=22><span>I would like to match the size of all=
ocation, I am wondering if I write the following:</span><br /></blockquot=
e>
<blockquote type=3D=22cite=22><span></span><br /></blockquote>
<blockquote type=3D=22cite=22><span>=40print=40</span><br /></blockquote>=

<blockquote type=3D=22cite=22><span>expression N, SIZE;</span><br /></blo=
ckquote>
<blockquote type=3D=22cite=22><span>=40=40</span><br /></blockquote>
<blockquote type=3D=22cite=22><span></span><br /></blockquote>
<blockquote type=3D=22cite=22><span>(</span><br /></blockquote>
<blockquote type=3D=22cite=22><span>&=23160;&=23160;malloc(SIZE);</span><=
br /></blockquote>
<span></span><br />
<span>Code doesn't usually contain just malloc(...); because then the ret=
urn</span><br />
<span>value would be thrown away. &=23160;You can write x =3D malloc(SIZE=
); for an</span><br />
<span>expression metavariable x. &=23160;If malloc can be used in other c=
ontexts, eg an</span><br />
<span>if header, then you can write malloc(SIZE)=40S where S is a stateme=
nt</span><br />
<span>metavariable. &=23160;I think that that will allow the printf to be=
 added after</span><br />
<span>the innermost statement containing the call to malloc.</span><br />=

<span></span><br />
<span>julia</span><br />
<span></span><br />
<blockquote type=3D=22cite=22><span>=7C</span><br /></blockquote>
<blockquote type=3D=22cite=22><span>&=23160;&=23160;calloc(N, SIZE);</spa=
n><br /></blockquote>
<blockquote type=3D=22cite=22><span>)</span><br /></blockquote>
<blockquote type=3D=22cite=22><span>+ printf(=E2=80=9CAllocation: %d=5Cn=22=
, (N) * (SIZE));</span><br /></blockquote>
<blockquote type=3D=22cite=22><span></span><br /></blockquote>
<blockquote type=3D=22cite=22><span>I am not sure if I could set the defa=
ult value for N in the malloc case, or is there anything I should do to m=
ake it correct.</span><br /></blockquote>
<blockquote type=3D=22cite=22><span></span><br /></blockquote>
<blockquote type=3D=22cite=22><span>Best, Yudi</span><br /></blockquote>
<blockquote type=3D=22cite=22><span></span><br /></blockquote>
<blockquote type=3D=22cite=22><span></span><br /></blockquote>
<blockquote type=3D=22cite=22><span></span></blockquote>
</div>
</blockquote>
</div>
</body>
</html>

--643a408d_3f299ff3_1df--

