Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31948C433EF
	for <cocci@archiver.kernel.org>; Sat, 19 Mar 2022 15:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ehCUQmz/ttL2Z059uQYOyqq02L5A1d7UY2Au8xUTkJo=;
  b=XVs08xBkHJ/IXCZg5aL5NmuiWOL+0b+nf3yGfFjrYd5q6/QyHTu5+Hbg
   v6v0LIGMAxjfJfBZ/wUu+f8HPJxPDg0iVKA/EPI6lV4I+AlZg5u9flpOn
   0KfZ/tk3LF/w3R0Hr/THkrl0lg+PgZImm/L8NudsmKLwGTn9WxbQWnirt
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="27010971"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2022 16:22:04 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9DBA9E020F; Sat, 19 Mar 2022 16:22:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1E48DE0069
	for <cocci@sympa.inria.fr>; Sat, 19 Mar 2022 16:22:02 +0100 (CET)
IronPort-SDR: Sqif0lSvt1roLCvJwEQE/iWcCWMORnN9D8AELLmKzReKng0X1KYBDgayRRF0XXE93Gj8Nrkrdq
 oyz+Ivm0lxzrm55vrH/mySR1Nv7o6I69GfzrVjMHfvN47YzxjUMG/jVjk5m19tpK4wh5qT6TIj
 oCHS6JijBCBmb0xufBg/B2A3s+W00YwmT/DN76ayW4DE2EpS+zdXwJyTuAlbbNT1xCSnsjln1q
 uSNd+6+Xr7CeRWqyZNLGCnIdu7q5yIDjf4YF0L4JKhxSwW2JLKKtNoI4zVsiGYfr0GZEw4FjZ8
 tEud0I0TjHtpGguXOmSVl7OP
X-IPAS-Result: =?us-ascii?q?A0B0AQB/9DVihwMP49RaHQEBAQEJARIBBQUBQIFagiiBV?=
 =?us-ascii?q?SsEC0SEVI5zgXcxiySHGIoogXsLAQMBDRIBKwECBAEBhQcChDQCHQcBBEcBA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBDA0JBQgKBw4QBTYGX?=
 =?us-ascii?q?gZkBIFLBIF0CzQNgjUpAYNkAQICASMdAQERJgEECwsaAiYCAlcGDQgBAYMAg?=
 =?us-ascii?q?mUBAw0lrWuBMYEBgggBAQaESB8sIlKBWwmBECyKFIM7eicQgVVEgTwMgkAHM?=
 =?us-ascii?q?D6ERYMagmWYFJYTjh6fdzQHghKBOoFBDJ4RBhQulj0OBpFtllunAjWBVgKBa?=
 =?us-ascii?q?TMaJIM4TgECAQINAQICAwECAQIJAQECjh0ZHoNuiixANDgCBgEKAQEDCQGBV?=
 =?us-ascii?q?oNwAQGHPy2CGQEB?=
IronPort-PHdr: A9a23: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
 tWdzMrO
IronPort-Data: A9a23:yqC6eKBr5o0iNBVW/znlw5YqxClBgxIJ4kV8jS/XYbTApDh3hjMHn
 2AeXm+EPfqOM2b1eox2PIni/EIGvpXQzdYyOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6jMlkf5KkYAL+EnkZqTRMFWFw0XqPp8Zj2tQy2YPgUlvX0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYozPQp+ws2
 P5oj5OxGRUpIPbGxuUhUxYNRkmSPYUekFPGCX24rNDV0EDMNXfhqxlsJBtvZ8tCoLkxWDwIr
 pT0KxhVBvyHr8e/2rGmUa9Bgso5Lc/kFJwSsDdswFk1CN58HsiaG/SUtbe02h9rvt1VJtmdI
 PEwaCpgYEzKeUVEB1k+XcdWcOCA3ySjLWQB9jp5v5Ef6G/Yxw1Zy6noKNOTe9qQRMwTkFzwj
 mbP4G39BjkINdmV0zPD83S2h+aJkzmTZW4JPLi/6+Isn1CZgGAeYPELabelif/gsnLjS/l6E
 UMVqjgus/M4qk2XTtaoCnVUv0W4lhIbXtNRFcgz5weM1rfY7m6lO4QUctJSQIF+6JRsGVTGw
 nfWz4q5X1SDpZXIESr1y1uCkd+lEQQ4RYPoTQoDSxcM6dD+uunfZTqSEIo6SMZZYvXPGTzxx
 TSDqiR7v7saidxj6klW1VXAni7quZXDCAI4juk2Yo5HxlMkDGJGT9X2gbQ+0RqmBNjAJrVml
 CZd8/VyFMhUUfmweNWlGY3h5o2B6fefKyH7ilVyBZQn/DnF0yf9Id8Nvmkjehk5bZpsldrVj
 Kn76Vs5CHh7YyrCUEOLS9nuYyjX5fW8RIq+DJg4kPIUP8MrLmdrAx2ClWbJgjyzyRFy+U3OE
 c7VKI6tC2oXE6Jq0HK/SI8gPUwDlkgDKZfobcmjlXyPiOLADFbMEOttGAbQMogRsf3VyC2Io
 o43H5bbkH13DbyuCgGJqtR7BQ5RchAG6WXe8JE/mhireVY9RwnMypb5ndscRmCSt/8Mx7mSo
 S3lBBMwJZiWrSSvFDhmo0tLMNvHNauTZ1piVcD1FVr3iXUlf6i166ITK8k+cbU9qr58wPQyQ
 /RcI5eMBfFGSzLm/TUBbMCh/dI4K0nx3VqDb3i/fTwyX598XAiXqNXqSQvY8nVcBCSAs8Zj8
 aar0RnWQMZYSgk7VJTWZfujwkmfp38YnO4uDULELsMNKlrh+s5mJnWp3PMwJsgNLzTFxyebj
 lrHX01H+LOV+4JsqYvHn6GJqYutAtBSJEsCEjmJ96uyOAnb4nGnn91KXtGISjaBBmn6z6OvO
 LdOxPbmPfxbx1tHvtYuE7tvyq5itdLjq6UDl1ZhG2jXKUumAPVsLyDej8VIs6RMwJ5fuBe3A
 x7epIMFZO/RYM61QkQMIAcFb/iY0a9GkDfl7cMzfBfw6hhx8efVSk5VJRSN1HdQIecnKo8j2
 ut96sca5xbm00gvNcuayD9Z/SKAIyVYAakgs5gbBq7tixYqkw0TP8aDV3WuuJzfOc9RNkQKI
 yOPgPSQjbprxn3ELyg5G0/L0LcPnp8Joh1LkAQPKlnhdgApXRPrMMC9MAjbTzi5Cj1C1P9vf
 HdmPQt5KM1iOtuuaNdrBwiR98NpXXV1OXAdD3MWmWefQ0TAuqnlMjgmIejUlKwG2zs0Q9WYl
 Y10DE76XDyscMyZMu7en6J6g6SLcOGdPTEuVCxq8wpp0nX6jffYbneSWFc1
IronPort-HdrOrdr: A9a23:sslwwagICyXyB5xS7CX/HltMgnBQXv4ji2hC6mlwRA09TyVXrb
 HKoB1p726WtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykfsS+Q2mmF+rgbsbu6GeyT5Ns31B1WPHpXgkxbnn1E4j/wKDwKeOHMaKBSKK
 ah
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="27010968"
X-MGA-submission: =?us-ascii?q?MDEuT60Yl1SCsa882fyUMUNmgswvXc0C6t8TAp?=
 =?us-ascii?q?PulcNYbVwwOlr+47nYiK1nbh/MiCwPaVDhQMdixyJWRdIydb3OKIPeF7?=
 =?us-ascii?q?9AZrv9wQuNzkjd9gLGnmtObCH1L/4irLhgXqrdwjID5b/xzzKCqrI3da?=
 =?us-ascii?q?ClHUKH1mOYFlbbKrINVIkI3w=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 16:22:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1647703320;
	bh=3jGj/U8CUn979xJpOFTNLfHHQAz3/uRUEcdZ8NM37XA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BxKCC2QmR63W6erqGoPClZycPAmB26Z2icP9pYx4GWcq1HY/bNzs1mS5dQL4pnaaT
	 EIwg6GcFcfJMuTVplYb8zRH4vbNinj/SmzocmGXKtzW7Eo5SKwVK/bLa5gMgs1KyP+
	 DTMiK25wB56kuLLiaaRLUgBce1nGXiq7j7/gZeeE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.182.172]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N79RI-1oA2Tc1vwK-017acq; Sat, 19
 Mar 2022 16:22:00 +0100
Message-ID: <54531a6d-1494-ed72-b70b-e859aab58856@web.de>
Date: Sat, 19 Mar 2022 16:21:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, Luis Chamberlain <mcgrof@kernel.org>
References: <458b35d6-7ca5-e98c-60fb-196c3ea3dc08@web.de>
 <alpine.DEB.2.22.394.2203191604480.3204@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2203191604480.3204@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F5RZMGs2KXYprIgQMtLfGnooC48cTvEnIX/gIdMZzpxIneEwbD/
 knsC/wJCRcoFgSBB23p+KbpvMzqrD74ITgaKM7IZ16PVey/vCvUaamquxhnh6ssYfAFBFcf
 DV8A15g5XZp5IEwZNYnPS8HisSp114QavZsK1vUKsQPHu8hJbRRZZXYU8V9qYfQTiyXl0ie
 Q8yL6Qlk5XpUffNh4H98g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ozRzyvVz2YM=:9W4nEf2jF6GXj5/nSD1/0r
 ustpi0kOBFJi66ZhYNFfwUuh7WnjcFIpBpAfSZ5tKLwLv011csh8QnafHIqjRcNi8prr7eSIu
 mYNOoFczPhnzNQ25aauMAqBFhsLwkIMC2yfNMUCotko3Nvxh9zWpFmQyopmQctrkN79400rFJ
 i9Q0ghVce+pFnMFlQhW6CF6Rzeo6zJGMGZqJs9p7mkaqtCQwwuqdzJl0oTVLA2TrRiY7E7jdw
 yDvkPaIAIApgIzFc9VKB9ht6AXOU+laIxJvwVDM3k7Uts5Vq3V73d3dxgJqQEg/T2DViMg87R
 UMPqULo31p3rMVYwKlcszGNKcrtMke9qd20e0ffihA1JC7qVatf/E3RRjP1idJsvN76dgV6s1
 E1zAh9ILqEnHJSMA/soSxoEJxAPEiMRvlD2q5ty020/b4YACvz4zPN/d3X+G4xC0KJCEP6dk1
 LpeC9xC+5piU112hP9AjIGCdgVqkgINeGDih5XxJErmyEJRehoRE9OEWY1NgJBO45Wxu4plbt
 gKyqF2WtQW7SNs5IkyQjCxUwPC8bkTsQDkw3KyqeVvdqzTUoOL5dO6BOZWTQgeCBjkfaaPkRL
 zn4++8++eMGPNlopxbTi/EN/JbkvwD2l0vU03GJ39fLVeMcCh6pkoAAY0J7zCvL5UlC+OFUHB
 UaYdPD2l1AE2AoeAqnRQc1Dttl/HB4s+GtCB657YP8Ge2kd9Kz03NeOmX8O6TuJo5pw50Xe/J
 q8uqwawuPRrcQrIYEFds9Y918qD3OYADYJVbd01lEraLdH1oUvyK52cinb1AjJ6cU60pYKTiy
 GDtX/9pg1v9SzfSYNpNvPe9LxY/yu2d1ha8F3cYl3CB9WWlTeG0bxyPLgSXBAxPv6GPMiVdw3
 /HFLcjVVDxglbu7bYpT8oPnRpwqqVY4ryw2JDE1q6/nmY4NNlTsBnexfbHNcqVtwQgrumA7w9
 wj3Q1OfyA5Fjc75mVxBO9m82VtYugh4UasPB0uo4XYLIc68qYtF8Y/cJc/5nmKuV3bHb9YXQ7
 Pl4SebG3LcCWR69QQnHdZk7an6x/V9EZsEk25wZVn/81ePGByNDR4R0as8DgQiTXVQgnfIDBP
 rC3gZW1wXwSyQ0=
Subject: Re: [cocci] Adding another metavariable type for the construction
 of =?UTF-8?Q?=E2=80=9Cfresh=E2=80=9D?= source code?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 245
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/54531a6d-1494-ed72-b70b-e859aab58856%40web.de>

>> The script code of a metavariable of type fresh identifier returns a
>> string that is used as the name of the identifier.


How do you think about to avoid that a provided string violates the syntax=
 rules
for a supported programming language?

(Example:
Would you like to distinguish a generated string literal better from an =
=E2=80=9Cidentifier=E2=80=9D?)

Can it matter to check the returned data for compliance with known format =
restrictions?



> There is no such thing as fresh source code.  "source code" doesn't give=
 enough information to
> correctly parse the string.


I got the impression that some source code could be added by the means of
the semantic patch language if data format validation is eventually not pe=
rformed.

Regards,
Markus

