Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD268C27C79
	for <cocci@archiver.kernel.org>; Mon, 17 Jun 2024 13:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:date:message-id:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=GmsXeRVIZyGlEhYsUwXJ8dzSe6LIMAxeMWRo6OQ8z8A=;
  b=Q98aJ4obxmCd2tuhXEPOmR+w5J3o+NYvEAMaBaoOozGHenG/XlGXqId2
   vGc+2/FgGCLXMb5ggSAS/ivi4CBg/InbvPN1XtWrgublxWlQNMlE4+VBA
   uPLUphpf7UQgOTZPAZWeMH7QyYk7MZDFWX1cWYtuSGEKbnY98taGvR0gQ
   E=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@xteddy-org.20230601.gappssmtp.com
X-IronPort-AV: E=Sophos;i="6.08,244,1712613600"; 
   d="scan'208,217";a="171057241"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Jun 2024 15:14:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E2AAEE01A8; Mon, 17 Jun 2024 15:14:04 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D6FD4E0131
	for <cocci@sympa.inria.fr>; Mon, 17 Jun 2024 15:14:01 +0200 (CEST)
IronPort-SDR: 66703698_pinwl9GIVQLS9TKK4FlVhEjywW+Mqsdo/N1zgOtgul0j8Er
 Sa56xyj9gJUxQi1Nri3o84Tu12082CfnMSRC7RQ==
X-IPAS-Result: =?us-ascii?q?A0EdBAASNXBmfzGAVdFagliBQYEDgVU0BAtIhFaBI6gEh?=
 =?us-ascii?q?lKBJQNWDwEDAQ1EBAEBAwSNdQIeBgYyBw4BAgQBAQEBAwIDAQEBAQEBCAEBB?=
 =?us-ascii?q?QEBAQIBAQIEBgECEAEBIhkHDg4phXQNgmCBJoEmAQEBAQEBAQEBAQEBHQIme?=
 =?us-ascii?q?xEdAQE4JTcCIxIBBQFXhUMDoWeBBUKLO4EygQGCDAEBBtwdgWMJFIE0iDEBg?=
 =?us-ascii?q?VUCAodpgSEbgg2BSoJFAYV9gw6CaZlcjBImC4wkJiYDBwcQK0kQASEDJjMhA?=
 =?us-ascii?q?hEBVRMXCz4JFgIWAxsUBDAPCQsmKgY5AhIMBgYGWTQJBCMDCAQDQgMgcREDB?=
 =?us-ascii?q?BoECwd3gTyBaQQTRAOBN4FSiB2DO4IbhBpLhG+BawELAWCJfIE+gWaDUU2ED?=
 =?us-ascii?q?h1AAwtiCz01FBtMrUQfAYE+ghvGGoQdBYFdn2kzgU2obJhlqHkRI4FJBC+BX?=
 =?us-ascii?q?DMaCCgIbAaCME8DGQ+SG8lIRTICOQIHAQoBAQMJiSKBSAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:GH2DyaPcwLkgW8BcTsyjsMiBIKoaSvp037BL7TEXdfUxSKalfq
 +V7ZcmPHPP6Ar5O0tApTnjAtjjfZq0z/ccirX5Vo3SOTUO1lHYSL2KLrGP/9QjIUDDHyJmup
 uIupIRNOHN
X-Talos-CUID: =?us-ascii?q?9a23=3AC28q0WjCxV5ppeUcTnFYOjWg3DJuamXak0jMc1W?=
 =?us-ascii?q?CFmNZFo2TbgCI/rk8nJ87?=
X-Talos-MUID: 9a23:CTUFAghUor8taqkdzgQkUMMpZOUwvrqKEwc0ioQh4MyPJyJcKxGRtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,244,1712613600"; 
   d="scan'208,217";a="171057207"
X-MGA-submission: =?us-ascii?q?MDGDBxL7HeeQnHGmbGdSO2Xt4WQ0F64PnLFkQ9?=
 =?us-ascii?q?XOHW3ifqI6gq85W+y5ynAVpRH9Yky6mBnW2OTmNjY4xbhQnPu3z6FIUS?=
 =?us-ascii?q?vMXrvuZWgwq1xgTF5LACdAb1zcwGrWr/pk2P5shppA+lr/U5RTuWnxdA?=
 =?us-ascii?q?KWV7f84C47AkEerCWyHqmZTQ=3D=3D?=
Received: from mail-wm1-f49.google.com ([209.85.128.49])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 15:14:00 +0200
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42172ab4b60so38161485e9.0
        for <cocci@inria.fr>; Mon, 17 Jun 2024 06:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xteddy-org.20230601.gappssmtp.com; s=20230601; t=1718630039; x=1719234839; darn=inria.fr;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GmsXeRVIZyGlEhYsUwXJ8dzSe6LIMAxeMWRo6OQ8z8A=;
        b=Cf59EXqrdELr+MrOWV16cOcEEQqQrhJxZ1b1/8CEMLw3M1Y1i7B9HNQ/1FQoDJwJDj
         C+T4CzUaPruFliJSBIzGPXpGOIJicVYoPUmMPGradmUWWJp4qP03rwvVzw1r4v9xWQvN
         CBTmFQdC9CQvewmyiln58Aqi3RrtwvlOq+Do2Cov6SMwipPfPPSOkTg5yn8Baq16ijUa
         +O++zyHGnfQ/W1HXdPRIDrMEKSsiWgw+Jdh8NpY/MYKPjV6ieYx1CC5OinOHkcSDTy3T
         GdK5iTa5hB0hV3H+ngIvpD7MlQgG8FLZtVPcIi4+lT9JYcflWm4jYXD95r6FTQX1ZEkW
         mWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718630039; x=1719234839;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GmsXeRVIZyGlEhYsUwXJ8dzSe6LIMAxeMWRo6OQ8z8A=;
        b=OcMpiEYIj2cMFQijqIs+G70kP4ItsI9Ku8Qeg3ylzCae9KCwAB8+k9FwTHr+kTExlG
         Y7CFvs2ZC5au179mjfwWtZLjbWJUBf1nv+EKl7qzLYMfAckXcB1diFZpFC3auBU4Ej9p
         Y2kGhazTtHfNBNZ/TGG4hM4+aCgaqi+T7goQVztJNXm+QXVFhvOuX7gx59p+HU22KtID
         6R855bAQRRCQmbqUQwgLC7oz1Okxb61YHcxfSzwVmJPYxXRs4nYlK3/wVLju5jRZbD4S
         Fe9zMOvc5V1t3UhwnekE63ySbUHfWlwZoZb2a0a7Kmb3WNpScFbTVlQwG+HECy/uTg8z
         jBrQ==
X-Gm-Message-State: AOJu0YyOU27yaXuv8e56rSX9UGt1bTkY9DOGiPEk0YkpMnmeG8jPmzis
	QrMn1JPQcLqma6qiRQVBxBnltkdcRcWoGcvuXjji5JOtZn/73DBcl4pYMkmHhnzX6zp8O7B7xUO
	VW5uEFAO0d60s0hCnOXVgt0SZEhRI1DfnMxZSRGbBiHlbJH8G
X-Google-Smtp-Source: AGHT+IHWSV0ybgSmYznarPq1VD/9gxFqcbZOqpThQWOxCJK43oEWyO7GjwLTuDFTJL8+4ezsEtgr/fphuMo4iBjHIXU=
X-Received: by 2002:adf:f308:0:b0:35f:fb4:fc7d with SMTP id
 ffacd0b85a97d-3607a7c11f2mr6917788f8f.31.1718630039494; Mon, 17 Jun 2024
 06:13:59 -0700 (PDT)
MIME-Version: 1.0
From: Thomas Adam <thomas@xteddy.org>
Date: Mon, 17 Jun 2024 14:13:48 +0100
Message-ID: <CAOhcEPY3QqNFMzfGT4Zy8We5Y0+SLaG=A+5YZ5+O0MZAkGEKhQ@mail.gmail.com>
To: cocci@inria.fr
Content-Type: multipart/alternative; boundary="00000000000001403a061b15bd09"
Subject: [cocci] Disabling code blocks from cocci
Reply-To: Thomas Adam <thomas@xteddy.org>
X-Loop: cocci@inria.fr
X-Sequence: 1791
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-06/CAOhcEPY3QqNFMzfGT4Zy8We5Y0%2BSLaG%3DA%2B5YZ5%2BO0MZAkGEKhQ%40mail.gmail.com>

--00000000000001403a061b15bd09
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey all,

Is it possible to make a rule to make spatch ignore code sections from
being changed?

For instance, say I have a rule to change calls to strdup() to xstrdup().
What I=E2=80=99d like to do is something like:

/* start of ignore block */
a =3D strdup(=E2=80=9Cfoo=E2=80=9D);
/* end of ignore block */

Such that, for code defined between those two comments, spatch would ignore
it.

Is something like this possible?

TIA,
Thomas

--00000000000001403a061b15bd09
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><span style=3D"font-family:-apple-system,&quot;helvetica neue&quot;;fo=
nt-size:16px;font-style:normal;font-weight:400;letter-spacing:normal;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:1px;text-deco=
ration:none;float:none;display:inline!important;background-color:rgba(0,0,0=
,0);border-color:rgb(49,49,49);color:rgb(49,49,49)">Hey all,</span><div dir=
=3D"auto" style=3D"font-family:-apple-system,&quot;helvetica neue&quot;;fon=
t-size:16px;font-style:normal;font-weight:400;letter-spacing:normal;text-in=
dent:0px;text-transform:none;white-space:normal;word-spacing:1px;text-decor=
ation:none;background-color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:=
rgb(49,49,49)"><br></div><div dir=3D"auto" style=3D"font-family:-apple-syst=
em,&quot;helvetica neue&quot;;font-size:1rem;font-style:normal;font-weight:=
400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:n=
ormal;word-spacing:1px;text-decoration:none;background-color:rgba(0,0,0,0);=
border-color:rgb(49,49,49);color:rgb(49,49,49)">Is it possible to make a ru=
le to make spatch ignore code sections from being changed?</div><div dir=3D=
"auto" style=3D"font-family:-apple-system,&quot;helvetica neue&quot;;font-s=
ize:16px;font-style:normal;font-weight:400;letter-spacing:normal;text-inden=
t:0px;text-transform:none;white-space:normal;word-spacing:1px;text-decorati=
on:none;background-color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rgb=
(49,49,49)"><br></div><div dir=3D"auto" style=3D"font-family:-apple-system,=
&quot;helvetica neue&quot;;font-size:1rem;font-style:normal;font-weight:400=
;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:norm=
al;word-spacing:1px;text-decoration:none;background-color:rgba(0,0,0,0);bor=
der-color:rgb(49,49,49);color:rgb(49,49,49)">For instance, say I have a rul=
e to change calls to strdup() to xstrdup(). What I=E2=80=99d like to do is =
something like:</div><div dir=3D"auto" style=3D"font-family:-apple-system,&=
quot;helvetica neue&quot;;font-size:16px;font-style:normal;font-weight:400;=
letter-spacing:normal;text-indent:0px;text-transform:none;white-space:norma=
l;word-spacing:1px;text-decoration:none;background-color:rgba(0,0,0,0);bord=
er-color:rgb(49,49,49);color:rgb(49,49,49)"><br></div><div dir=3D"auto" sty=
le=3D"font-family:-apple-system,&quot;helvetica neue&quot;;font-size:1rem;f=
ont-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text=
-transform:none;white-space:normal;word-spacing:1px;text-decoration:none;ba=
ckground-color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)=
">/* start of ignore block */</div><div dir=3D"auto" style=3D"font-family:-=
apple-system,&quot;helvetica neue&quot;;font-size:1rem;font-style:normal;fo=
nt-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;whi=
te-space:normal;word-spacing:1px;text-decoration:none;background-color:rgba=
(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)">a =3D strdup(=E2=
=80=9Cfoo=E2=80=9D);</div><div dir=3D"auto" style=3D"font-family:-apple-sys=
tem,&quot;helvetica neue&quot;;font-size:1rem;font-style:normal;font-weight=
:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:=
normal;word-spacing:1px;text-decoration:none;background-color:rgba(0,0,0,0)=
;border-color:rgb(49,49,49);color:rgb(49,49,49)">/* end of ignore block */<=
/div><div dir=3D"auto" style=3D"font-family:-apple-system,&quot;helvetica n=
eue&quot;;font-size:16px;font-style:normal;font-weight:400;letter-spacing:n=
ormal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:1=
px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(49,=
49,49);color:rgb(49,49,49)"><br></div><div dir=3D"auto" style=3D"font-famil=
y:-apple-system,&quot;helvetica neue&quot;;font-size:1rem;font-style:normal=
;font-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;=
white-space:normal;word-spacing:1px;text-decoration:none;background-color:r=
gba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)">Such that, for=
 code defined between those two comments, spatch would ignore it.</div><div=
 dir=3D"auto" style=3D"font-family:-apple-system,&quot;helvetica neue&quot;=
;font-size:16px;font-style:normal;font-weight:400;letter-spacing:normal;tex=
t-indent:0px;text-transform:none;white-space:normal;word-spacing:1px;text-d=
ecoration:none;background-color:rgba(0,0,0,0);border-color:rgb(49,49,49);co=
lor:rgb(49,49,49)"><br></div><div dir=3D"auto" style=3D"font-family:-apple-=
system,&quot;helvetica neue&quot;;font-size:1rem;font-style:normal;font-wei=
ght:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-spa=
ce:normal;word-spacing:1px;text-decoration:none;background-color:rgba(0,0,0=
,0);border-color:rgb(49,49,49);color:rgb(49,49,49)">Is something like this =
possible?</div><div dir=3D"auto" style=3D"font-family:-apple-system,&quot;h=
elvetica neue&quot;;font-size:16px;font-style:normal;font-weight:400;letter=
-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;word=
-spacing:1px;text-decoration:none;background-color:rgba(0,0,0,0);border-col=
or:rgb(49,49,49);color:rgb(49,49,49)"><br></div><div dir=3D"auto" style=3D"=
font-family:-apple-system,&quot;helvetica neue&quot;;font-size:1rem;font-st=
yle:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-trans=
form:none;white-space:normal;word-spacing:1px;text-decoration:none;backgrou=
nd-color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)">TIA,=
</div><div dir=3D"auto" style=3D"font-family:-apple-system,&quot;helvetica =
neue&quot;;font-size:1rem;font-style:normal;font-weight:400;letter-spacing:=
normal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:=
1px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(49=
,49,49);color:rgb(49,49,49)">Thomas</div></div>

--00000000000001403a061b15bd09--
