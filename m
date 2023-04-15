Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08EEC7619A
	for <cocci@archiver.kernel.org>; Sat, 15 Apr 2023 16:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=4J/uPoUgdkQSJq9JBWymzEmt/SmGd1wdQKsCdw8j9W4=;
  b=QkhwcmdQnzFRTu5HzbJZqlWgpbnLQsWcrrGlGm5VwOID4X00BSqfAxGy
   278PT9+yh89200d4hWzCeLt7pRcYTTd5vY4g+sxffMuBuC66c/tWbgO7I
   muq+28qp5NkpMyZeEDGcNNaICMCplkkJ5xKzdLMSeUyDWU+Cap224iGEy
   k=;
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
X-IronPort-AV: E=Sophos;i="5.99,200,1677538800"; 
   d="scan'208,217";a="103235224"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Apr 2023 18:52:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A3FC6E033A; Sat, 15 Apr 2023 18:52:05 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D7A70E00A8
	for <cocci@sympa.inria.fr>; Sat, 15 Apr 2023 18:40:28 +0200 (CEST)
IronPort-SDR: 643ad37b_vZLv1VoLkiC8W9GUzAfoIt9mKnQVUT06JD/NVP5msXwQOoN
 mVZBG0oORH9+uzXQJn08e+IPdsMdBU8mNNJLsiQ==
X-IPAS-Result: =?us-ascii?q?A0GHAQDI0TpkmPSZo5RahDRSdYEFBAtGhFOIfYg2i1uLM?=
 =?us-ascii?q?4R4g1QGCQEDAQsBAUICBAEBAwSEfwKFPAIdBwEENBMBAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAwEBBQEBAQIBAQIEBQECEAEBAQEBAQEBFQkZBRAOBSKFaA2CNykBdYEIA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBARYCFHEBAQEDEhEdAQE3AQ8JAgQUKgICNAEFA?=
 =?us-ascii?q?RwGExsHglwBglwDAZFvjyASckJuQIkKAQEBeIEygQGCCAEBBp01AQmBawkSg?=
 =?us-ascii?q?S+HTHZeAQGIGSeBGIEQgTyCUzE+gVOGTIJnmlaBNHaBIA6BPIEEAgkCEWuBE?=
 =?us-ascii?q?AhqW4EaBEACDWQLDm+BSYMqBAIUBTEODhcHNgNEHUACAUY6PgE1CQsgBoEtQ?=
 =?us-ascii?q?iQFAwsVKkcECDgGGzQRAggPEg8GJkQMQiEWMxMGXAEcDQsOEQNONIETBC+BW?=
 =?us-ascii?q?wYBJiSfGYQ4VgEBAZU9jSugAwEGAoQAoHIGVZZ2kjmXd6JdhRkCBAEBAQMFA?=
 =?us-ascii?q?gYQI4FXI4FcMxolgWyBSU8DGQ+OLA0JhDqPLSQzPQIHAQoBAQMJhWmFXAEB?=
IronPort-PHdr: A9a23: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
 EPv
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:RafT2KsY572mExueFf2lI6uX7skDi9V00zEX/kB9WHVpmwKj5q
 aTdZUgpGDJYVMqMk3I9urwXZVoLUmskaKdpLNhRYtKPzOWxFdATrsSlLcKqgeIc0aSmp8+6U
 4jSdkENDSaNykBsS+V2njeLz/i+re6GWKT6ts2A00McShaL5h66QF3EwCaFVAzaSx+bKBJaq
 Z0IvA31gaISDAtYsy3C3wIG8zOvcfCmp6jQTNuPW9b1OBGt1LYi4LHLw==
X-Talos-CUID: 9a23:uLC4Im4ZUo0LY/z9ZNsspEg7OeM9cV7kyFzQBGrnLX1RVaLFcArF
X-Talos-MUID: 9a23:21ADtAVbN3INVbHq/B/GvSNwFPpt2Ki3VkRdlc4GgJfDGBUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,200,1677538800"; 
   d="scan'208,217";a="53441362"
X-MGA-submission: =?us-ascii?q?MDEdScAagT8AEMTkIlCFKMLV1+5n3kR68MPieG?=
 =?us-ascii?q?6W43KbN52ivnfCL/zQHw64WKaNLqCmDTcMT9hb1aN4aSELoML7n3Mb85?=
 =?us-ascii?q?63UJzw6qqdGeP+6fzV471936CPXn1uZvR0oSeBrHwY29JG2GWCyMp56G?=
 =?us-ascii?q?MPk1+xG8mqydKw3Gp2aPwCtQ=3D=3D?=
Received: from mx0b-0010f301.pphosted.com ([148.163.153.244])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2023 18:40:26 +0200
Received: from pps.filterd (m0102859.ppops.net [127.0.0.1])
	by mx0b-0010f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33FDg2kn005347
	for <cocci@inria.fr>; Sat, 15 Apr 2023 11:40:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rice.edu; h=date : from : to : cc :
 message-id : in-reply-to : references : subject : mime-version :
 content-type; s=ricemail; bh=4J/uPoUgdkQSJq9JBWymzEmt/SmGd1wdQKsCdw8j9W4=;
 b=hzNamId04/upbw1WLKXOhNBzgy4iXDdDvRRtI2ZfgFtqGhH3bUywNYCys21yOu7R0iL0
 pueuZ1EZB2kP8Y4BNf4I3AYaafrXPH+oP7C7al8a5S+dDOPOV1xfr6WIwkEyd0uaQ6M/
 t6fmK5MgY1tUUv13eeNfni89VM1AQ75nhv129uxnTsdlFLpDYc7+WcM6J409DTrM7dJH
 zD4A8TLgOPAYrn5Alckh1+UiRCZpx35N2FjmulZDzw1/IdSPDV0xJOU+uqfwZGk0nx9U
 I7TD36R9kM0B2a2icrrNWJikWja6+EeN8rw4ch1731oPILLxFFMVKtjBDBkmjxF+WpD5 0Q== 
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0b-0010f301.pphosted.com (PPS) with ESMTPS id 3pyq9xgdna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <cocci@inria.fr>; Sat, 15 Apr 2023 11:40:24 -0500
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-18776718334so5708406fac.9
        for <cocci@inria.fr>; Sat, 15 Apr 2023 09:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681576823; x=1684168823;
        h=mime-version:subject:references:in-reply-to:message-id:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4J/uPoUgdkQSJq9JBWymzEmt/SmGd1wdQKsCdw8j9W4=;
        b=Kr4HEdknaUZSoikCWee4SQTJ6MWNHjHaACtxyGzqG7sHpAmKeYWtVkdm7zOgJJh4VN
         1in/KOEUaS4jyvUjufUOFetr/KjTTM4M8JbuZAl4HdGPKCHibvJRnaqw1SbkN9GDeJol
         r5T019hABbApUAldyZv14RICUcZm7LhXsY26RANI5fMwDQuEHfNPOoBHlvC/k9/gmEmj
         eRidDJGPR7TGQKedHJcWr+Y5DFwk1PKu1GQU0uO0DOBthHUMdohohzpcosts9kf0Yv93
         0MZ8kvf13aJ3hM8gJqbNGZWuRj/VY9q7GmDmELpq8d/3QqneLuvi2IdJ7xKHFV6cK+ZU
         +EoA==
X-Gm-Message-State: AAQBX9dynV6jMP062R7+Vm74jnw1r9OioeHrd5/XbsyP8QNBK6FGNpV2
	VBQ9YUItvRjaAsFSLHgyZLxvBh1GqJkXB6Ex+76JDdBQ5gbwrTTBQWmhwS7eYth35/sMZtT0Int
	V+wR9iOE8SegzcSRd3TAUINpMAxb3TXYa
X-Received: by 2002:a05:6870:41d4:b0:17a:cc85:5b1e with SMTP id z20-20020a05687041d400b0017acc855b1emr5095389oac.3.1681576823541;
        Sat, 15 Apr 2023 09:40:23 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z/iUteoBYK44D026cv40byEuZ212l+9rUOnUG3Chmo8IWznRpWQZ1OQ/2ImMJX4IoQ26tcQQ==
X-Received: by 2002:a05:6870:41d4:b0:17a:cc85:5b1e with SMTP id z20-20020a05687041d400b0017acc855b1emr5095385oac.3.1681576823318;
        Sat, 15 Apr 2023 09:40:23 -0700 (PDT)
Received: from [2600:1700:d00:6760:e094:1451:f87f:0] ([2600:1700:d00:6760:24d9:82c2:900:162])
        by smtp.gmail.com with ESMTPSA id g4-20020a056870a24400b0017703cd8ff6sm2951424oai.7.2023.04.15.09.40.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Apr 2023 09:40:23 -0700 (PDT)
Date: Sat, 15 Apr 2023 11:40:17 -0500
From: Yudi Yang <jy103@rice.edu>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <7ce84f72-833a-4bd7-84cc-2fd8a473d0e7@Spark>
In-Reply-To: <alpine.DEB.2.22.394.2304150930200.2975@hadrien>
References: <da277553-d798-4dd0-a0bb-f641f41a16bf@Spark>
 <alpine.DEB.2.22.394.2304150930200.2975@hadrien>
X-Readdle-Message-ID: 7ce84f72-833a-4bd7-84cc-2fd8a473d0e7@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="643ad376_830d6f6_1df"
X-Proofpoint-DLP: Gmail-Outbound
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-15_08,2023-04-14_01,2023-02-09_01
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Match and print size of allocation
Reply-To: Yudi Yang <jy103@rice.edu>
X-Loop: cocci@inria.fr
X-Sequence: 1058
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/7ce84f72-833a-4bd7-84cc-2fd8a473d0e7%40Spark>

--643ad376_830d6f6_1df
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thank you. It now matches if-statements. However, in case of a variable i=
nitializer such as:

void* p =3D malloc(100);

The solution does not correctly recognize the allocation.

Best,
Yudi

=E5=9C=A8 2023=E5=B9=B44=E6=9C=8815=E6=97=A5 -0500 02:31=EF=BC=8CJulia La=
wall <julia.lawall=40inria.fr>=EF=BC=8C=E5=86=99=E9=81=93=EF=BC=9A
>
>
> On Sat, 15 Apr 2023, Yudi Yang wrote:
>
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

>
> What I proposed didn't work, but the following works fine:
>
> =40=40
> statement S;
> expression size;
> =40=40
>
> (
> S
> +printf(=22%d=5Cn=22,size);
> &
> malloc(size)
> )
>
> julia

--643ad376_830d6f6_1df
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageBodySection=22>
<div dir=3D=22auto=22>Thank you. It now matches if-statements. However, i=
n case of a variable initializer such as:<br />
<br />
void* p =3D malloc(100);<br />
<br />
The solution does not correctly recognize the allocation.</div>
</div>
<div name=3D=22messageSignatureSection=22><br />
<div class=3D=22match=46ont=22>Best,
<div dir=3D=22auto=22>Yudi</div>
<div dir=3D=22auto=22><br /></div>
</div>
</div>
<div name=3D=22messageReplySection=22>=E5=9C=A8 2023=E5=B9=B44=E6=9C=8815=
=E6=97=A5 -0500 02:31=EF=BC=8CJulia Lawall &lt;julia.lawall=40inria.fr&gt=
;=EF=BC=8C=E5=86=99=E9=81=93=EF=BC=9A<br />
<blockquote type=3D=22cite=22 style=3D=22border-left-color: grey; border-=
left-width: thin; border-left-style: solid; margin: 5px 5px;padding-left:=
 10px;=22><br />
<br />
On Sat, 15 Apr 2023, Yudi Yang wrote:<br />
<br />
<blockquote type=3D=22cite=22>Hello Julia,<br />
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
 /></blockquote>
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
julia</blockquote>
</div>
</body>
</html>

--643ad376_830d6f6_1df--

