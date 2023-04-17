Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A1DC77B71
	for <cocci@archiver.kernel.org>; Tue, 18 Apr 2023 05:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ynm43D7i4N+pZimOMnDwC/BCSCrEsesy/dP0mKqsoh8=;
  b=dRjNGijcq0PP5McqcOsHPgifN+kC4LonVXo4plOtBnpR0QFsYA+YNAbz
   1g4eL4VebpC0lcnjkv2U2x4xLtMCUnJskCtBtTH6kWRnooj2jO8OLyXCJ
   Oa6AFyOoRT5Jtx+YsDvuu1x4MTFKGLbs2TabMBLpCr8WJ3j4GOEcw9yiN
   E=;
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
   d="scan'208,217";a="103517898"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Apr 2023 07:38:36 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AE5CCE7318; Tue, 18 Apr 2023 07:38:35 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 48E47E00A8
	for <cocci@sympa.inria.fr>; Tue, 18 Apr 2023 01:26:19 +0200 (CEST)
IronPort-SDR: 643dd59a_0emCEpr/D40Z+spdwGsqkOq+xRIaZpU+0OLO8Yuqf6llupp
 S2e9laLgpERT98SCD6ZbH+Eyzf6cIwgkcPJSXlw==
X-IPAS-Result: =?us-ascii?q?A0FlAQBY1D1kmP6Vo5RagliBXFJ1gQUEC0aEU4h9hg+CJ?=
 =?us-ascii?q?4tbizOEeINUBgkBAwELAQFCAgQBAQMEhH8ChTwCHQcBBDMGDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBAQEBAQEVCRkFEA4FIoVoDYI3K?=
 =?us-ascii?q?QF1gQgBAQEBAQEBAQEBAQEBAQEBAQEBFgIUcQEBAQMSER0BATcBDwkCBBQqA?=
 =?us-ascii?q?gI0AQUBHAYTGweCXAGCXAMBkRmPIBJyQm5AiQoBAQF4gTKBAYIIAQEGnTUBC?=
 =?us-ascii?q?YFrCRKBMIdLdl4BAYgZJ4EYgRCBPIJTMT6BU4ZMgmeaXYE0doEgDoE8gQQCC?=
 =?us-ascii?q?QIRa4EQCGtbgRoEQAINZAsOb4FJgyoEAhQFMQ4OGAc2A0QdQAIBRjo8ATUJC?=
 =?us-ascii?q?x8GgS1CJAUDCxUqRwQIOAYcNBECCA8SDwYmRAxCIRYzEwZcARwNCw4RA00zg?=
 =?us-ascii?q?RMEL4FdBgEmJJ8ggQITgyNWAQEBlT2NK6ADAQYChACgcgZVlnaSOZd3ol2FG?=
 =?us-ascii?q?QIEAQEBAwUCBhAjgVYkgVwzGiWBbIFJTwMZD44sDQmEOo8tJDM9AgcBCgEBA?=
 =?us-ascii?q?wmFaYVcAQE?=
IronPort-PHdr: A9a23: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
 yzX/IYGng==
IronPort-Data: A9a23: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
 VUIeA==
IronPort-HdrOrdr: A9a23:/KSXdKvWOtgwjP+pMriaOgxC7skDe9V00zEX/kB9WHVpm62j5q
 eTdZEgvyMc5wxhO03I9erhBEDiexLhHPxOkOss1N6ZNWGMhILCFvAG0WKN+UyFJ8Q8zIJgPG
 VbHpSWxOeeMbGyt6jH3DU=
X-Talos-CUID: 9a23:R1pB3m0MB4QtPsVrcKXKebxfQu0nSX6FkC7rHmiVJj9NE4LOZnKqwfYx
X-Talos-MUID: =?us-ascii?q?9a23=3Axlem8AwpGyeb2mAClSChdUeRrVmaqIKkLHgBwJY?=
 =?us-ascii?q?hgtmNaSIqHDO0shS2b4Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,205,1677538800"; 
   d="scan'208,217";a="103500700"
X-MGA-submission: =?us-ascii?q?MDFYVNGfe1ggS+fQnyfxa/yazPwf59G4qWRIek?=
 =?us-ascii?q?An9qMVTCj6zAg3QXASFKb2v7IzucVOlrMtYHg2bha8O8XpSE3IUHUIv5?=
 =?us-ascii?q?zZQMAkDo29xHpIGRFyoxX/icrbrHtnlJbHKcC2LS/nKcW2mo0AeS1ybh?=
 =?us-ascii?q?SSCCSlsOcz9A/IjHQ9tdRvQQ=3D=3D?=
Received: from mx0a-0010f301.pphosted.com ([148.163.149.254])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 01:26:17 +0200
Received: from pps.filterd (m0102856.ppops.net [127.0.0.1])
	by mx0b-0010f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HKutpI032389
	for <cocci@inria.fr>; Mon, 17 Apr 2023 18:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rice.edu; h=date : from : to : cc :
 message-id : in-reply-to : references : subject : mime-version :
 content-type; s=ricemail; bh=ynm43D7i4N+pZimOMnDwC/BCSCrEsesy/dP0mKqsoh8=;
 b=PXYyzj47LCt/MpYs8UpnCvz2O56x/5MryI4NivCX6mkl3c5Jpe/livKGyy9YZ8n+2pvu
 CrOY8PEdn5raOkdNKSLsiwdsXTbfh65tSRV7+UN95dpQHMvKjTCEidFL/uTxjro61ezb
 rmFKUiCo9burVb578QGg6BgFZpJxJ7PwBal3TQSETT7jnJCRwo61MmzMwp2/xIlecxWn
 WBryn7Jetc/Ef4feD52APW0oQhT4cMSqJw338CvNf6oaBzzeCRY2/cNOzSEfP+MMP1lD
 dYcEqCYyI7Ptdsb/tHG7hpqUm34CHSDe5Uw32sra6Wa+30G5WFQ29/ShCvfXlqYVIeVg rQ== 
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0b-0010f301.pphosted.com (PPS) with ESMTPS id 3pys28bux2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <cocci@inria.fr>; Mon, 17 Apr 2023 18:26:15 -0500
Received: by mail-oi1-f197.google.com with SMTP id bb17-20020a056808169100b003846654dd65so7864250oib.19
        for <cocci@inria.fr>; Mon, 17 Apr 2023 16:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681773974; x=1684365974;
        h=mime-version:subject:references:in-reply-to:message-id:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ynm43D7i4N+pZimOMnDwC/BCSCrEsesy/dP0mKqsoh8=;
        b=l2//YnhsfVorTeufiXjcAhUwl1evTzkc49xkMwQmSoG3O7qZeAK0iv6KLx26KcEpL9
         5hz6STfDtmcuzpSDMUbsPRN6gwTc3I/rFA0jA4N+DRSnDnrT4J1qSy8QeKLxavfILe24
         bsHv3BpHvrC2+RF4msHmxppx1/qWUt1+rF3HkwnBHHl2sebdZ2jnK4ArXARJ3i6TKw22
         zP5DQqB8kfMUvTN92EzeHW3ka2x60VzKdQqMfBaYY2Fhcl4gCRFtBNtGXRC9ei2RzMl8
         kj7r6Pt8UjEXjataD1I+qUtdYRZOnRmPNqMKoSVlsG3ufgSpRyHSn2YsEKNAln8BWMkg
         iF0g==
X-Gm-Message-State: AAQBX9czIJCaB5efcBs5Vwt2ZnhxgaLTMnWon7n9ZZPskc8eCY9Uo7He
	gPLekxBapUGqMDqGCHEBtrbKJMhGhjaayh+ESlmPdtY46w9r6pJyubXWPj9kbkXpB6NzN4s5y5i
	LIxD/g/1+qi0pci6GkM+/A/EGgEysGF/0z+ecDwjn
X-Received: by 2002:a54:4d8f:0:b0:38d:e60a:11b7 with SMTP id y15-20020a544d8f000000b0038de60a11b7mr323203oix.51.1681773974777;
        Mon, 17 Apr 2023 16:26:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350brXTHt/D4+5oL0V6weVTO3R80Sb90ZDrztMpDyjBl+0sW5tkdAx0PpSeOxEWz/WovAtKIEfw==
X-Received: by 2002:a54:4d8f:0:b0:38d:e60a:11b7 with SMTP id y15-20020a544d8f000000b0038de60a11b7mr323195oix.51.1681773974480;
        Mon, 17 Apr 2023 16:26:14 -0700 (PDT)
Received: from [2600:1700:d00:6760:e094:1451:f87f:0] ([2600:1700:d00:6760:7511:c8ec:d3e8:b49a])
        by smtp.gmail.com with ESMTPSA id 63-20020aca0742000000b003896b3269d3sm5171910oih.20.2023.04.17.16.26.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Apr 2023 16:26:14 -0700 (PDT)
Date: Mon, 17 Apr 2023 18:26:08 -0500
From: Yudi Yang <jy103@rice.edu>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <24b9f1d3-502e-42c0-ae9d-bf4ca7c4d8dd@Spark>
In-Reply-To: <alpine.DEB.2.22.394.2304172139580.2883@hadrien>
References: <da277553-d798-4dd0-a0bb-f641f41a16bf@Spark>
 <alpine.DEB.2.22.394.2304150930200.2975@hadrien>
 <7ce84f72-833a-4bd7-84cc-2fd8a473d0e7@Spark>
 <alpine.DEB.2.22.394.2304151852450.2975@hadrien>
 <d41fcc6e-5888-409a-99cf-0e5b8bcc739c@Spark>
 <alpine.DEB.2.22.394.2304172139580.2883@hadrien>
X-Readdle-Message-ID: 24b9f1d3-502e-42c0-ae9d-bf4ca7c4d8dd@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="643dd595_5c30be5f_1df"
X-Proofpoint-DLP: Gmail-Outbound
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Match and print size of allocation
Reply-To: Yudi Yang <jy103@rice.edu>
X-Loop: cocci@inria.fr
X-Sequence: 1083
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/24b9f1d3-502e-42c0-ae9d-bf4ca7c4d8dd%40Spark>

--643dd595_5c30be5f_1df
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Without having the =E2=80=9C;=E2=80=9D here, we are experiencing an error=
:

plus: parse error:
=C2=A0=46ile =22patch.cocci=22, line 11, column 0, charpos =3D 103
=C2=A0around =3D '&',
=C2=A0whole content =3D &


=E5=9C=A8 2023=E5=B9=B44=E6=9C=8817=E6=97=A5 -0500 14:40=EF=BC=8CJulia La=
wall <julia.lawall=40inria.fr>=EF=BC=8C=E5=86=99=E9=81=93=EF=BC=9A
>
>
> On Mon, 17 Apr 2023, Yudi Yang wrote:
>
> > Hi Julia,
> > I have tried out the following, but it seems not working.
> >
> > (
> > =C2=A0=C2=A0D;
>
> I don't think you should have the semicolon. That would be matching eg
> int x;;
>
> julia
>
> > + printf(=22%d=22, SIZE);
> > &
> > =C2=A0=C2=A0malloc(SIZE)
> > )
> >
> > Best, Yudi
> > =E5=9C=A8 2023=E5=B9=B44=E6=9C=8815=E6=97=A5 -0500 11:53=EF=BC=8CJuli=
a Lawall <julia.lawall=40inria.fr>=EF=BC=8C=E5=86=99=E9=81=93=EF=BC=9A
> >
> >
> > On Sat, 15 Apr 2023, Yudi Yang wrote:
> >
> > Thank you. It now matches if-statements. However, in
> > case of a variable initializer such as:
> >
> > void* p =3D malloc(100);
> >
> > The solution does not correctly recognize the
> > allocation.
> >
> >
> > You should be able to use the same idea, except put D, declared
> > as
> >
> > declaration D;
> >
> > julia
> >
> >
> > Best, Yudi
> >
> > =E5=9C=A8 2023=E5=B9=B44=E6=9C=8815=E6=97=A5 -0500 02:31=EF=BC=8CJuli=
a Lawall
> > <julia.lawall=40inria.fr>=EF=BC=8C=E5=86=99=E9=81=93=EF=BC=9A
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
> > However, it cannot match initializations and
> > if-statements.
> > I am not quite understanding your =22malloc(SIZE)=40S=22
> > solution.
> > Could you point on how to use the it, or perhaps
> > some related links=3F
> >
> >
> > What I proposed didn't work, but the following works
> > fine:
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
> >

--643dd595_5c30be5f_1df
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageBodySection=22>
<div dir=3D=22auto=22>Without having the =E2=80=9C;=E2=80=9D here, we are=
 experiencing an error:<br />
<br />
plus: parse error:<br />
&=23160;=46ile =22patch.cocci=22, line 11, column 0, charpos =3D 103<br /=
>
&=23160;around =3D '&amp;',<br />
&=23160;whole content =3D &amp;</div>
</div>
<div name=3D=22messageSignatureSection=22><br />
<div class=3D=22match=46ont=22><br /></div>
</div>
<div name=3D=22messageReplySection=22>=E5=9C=A8 2023=E5=B9=B44=E6=9C=8817=
=E6=97=A5 -0500 14:40=EF=BC=8CJulia Lawall &lt;julia.lawall=40inria.fr&gt=
;=EF=BC=8C=E5=86=99=E9=81=93=EF=BC=9A<br />
<blockquote type=3D=22cite=22 style=3D=22border-left-color: grey; border-=
left-width: thin; border-left-style: solid; margin: 5px 5px;padding-left:=
 10px;=22><br />
<br />
On Mon, 17 Apr 2023, Yudi Yang wrote:<br />
<br />
<blockquote type=3D=22cite=22>Hi Julia,<br />
I have tried out the following, but it seems not working.<br />
<br />
(<br />
&=23160;&=23160;D;<br /></blockquote>
<br />
I don't think you should have the semicolon. That would be matching eg<br=
 />
int x;;<br />
<br />
julia<br />
<br />
<blockquote type=3D=22cite=22>+ printf(=22%d=22, SIZE);<br />
&amp;<br />
&=23160;&=23160;malloc(SIZE)<br />
)<br />
<br />
Best, Yudi<br />
=E5=9C=A8 2023=E5=B9=B44=E6=9C=8815=E6=97=A5 -0500 11:53=EF=BC=8CJulia La=
wall &lt;julia.lawall=40inria.fr&gt;=EF=BC=8C=E5=86=99=E9=81=93=EF=BC=9A<=
br />
<br />
<br />
On Sat, 15 Apr 2023, Yudi Yang wrote:<br />
<br />
Thank you. It now matches if-statements. However, in<br />
case of a variable initializer such as:<br />
<br />
void* p =3D malloc(100);<br />
<br />
The solution does not correctly recognize the<br />
allocation.<br />
<br />
<br />
You should be able to use the same idea, except put D, declared<br />
as<br />
<br />
declaration D;<br />
<br />
julia<br />
<br />
<br />
Best, Yudi<br />
<br />
=E5=9C=A8 2023=E5=B9=B44=E6=9C=8815=E6=97=A5 -0500 02:31=EF=BC=8CJulia La=
wall<br />
&lt;julia.lawall=40inria.fr&gt;=EF=BC=8C=E5=86=99=E9=81=93=EF=BC=9A<br />=

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
However, it cannot match initializations and<br />
if-statements.<br />
I am not quite understanding your =22malloc(SIZE)=40S=22<br />
solution.<br />
Could you point on how to use the it, or perhaps<br />
some related links=3F<br />
<br />
<br />
What I proposed didn't work, but the following works<br />
fine:<br />
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
<br />
<br /></blockquote>
</blockquote>
</div>
</body>
</html>

--643dd595_5c30be5f_1df--

