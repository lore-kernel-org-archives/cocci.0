Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0586C433EF
	for <cocci@archiver.kernel.org>; Thu,  9 Jun 2022 16:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+uSkX9S/rlMN4xzVpMPqw0DLYACqJIpVDEqwT3qrK+Y=;
  b=ouUptqoKm+G+5HUVizNjZ22BqcE5NGbcvW/aNebxRmMM+CAKfR3eZo3A
   BW8/uCgTmdsSn/d85JJYtrT2jc/G88BqNVzE09reGw0ZIKS2jbR164cEK
   /2/Sel7TmCtIbgXoZ8FiaR+wR6DuAFlG1KOLAlhOLsIOPuDxDfpi510cx
   8=;
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
X-IronPort-AV: E=Sophos;i="5.91,287,1647298800"; 
   d="scan'208";a="40276317"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Jun 2022 18:20:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EC905E02DE; Thu,  9 Jun 2022 18:20:38 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6A1DEE010B
	for <cocci@sympa.inria.fr>; Thu,  9 Jun 2022 18:20:34 +0200 (CEST)
IronPort-SDR: Hvf+e6beEhQDCmMlib0SKkuA6hMbgbHNZWo/JNpCY6T3P1KFYJgVP0vNrO5Yl875MbQLH5lRO5
 DLC/U3pcugjfJ0aygY1/R045SoENDr2jzh+lcwlwvcYz/167V8kkIqpuO3wL0hWumbjhI0R5if
 AgqZbfdOIx8eoWyTpf6WhOK6Bh6Rnk9OsfCy1G1wmDZd4J6D6/5k9tvY5if5BZtlfZgV77xplx
 wMc4yrFD/7r9Q1kH2MeGaBli1DR7YZ/wZokEgwFtUuqJ4FK+q3QdWvnQ2SfavdoLFnymBS20KV
 YMrjMrO2VxWhvRjr30C9wCm/
X-IPAS-Result: =?us-ascii?q?A0AcAABoHaJihwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYIjgVcuBAtEhE6REYQhhwmHG4oigXwLAQMBDT8BAgQBAYR4CgKFR?=
 =?us-ascii?q?gIdBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQwNC?=
 =?us-ascii?q?QUICgcOEAU2Bl4GZASBSwSBdAs0DYI1KQGDZAECAgEjHQEBESYBBAsLGgImA?=
 =?us-ascii?q?gJXBg0IAQGCeYJlAQMNIwerfYExgQGCCAEBBoRKHywiUoFcCYERLAGNb3onE?=
 =?us-ascii?q?IFVRIEVJ4EVgT4wPoEPgzWDVoJllXmCFScEDwMaLTQSgSFxAQgGAwMHCgUyB?=
 =?us-ascii?q?gIMGBQEAhMSUx0CEgUHChwOFBwkGQwPAxIDEQEHAgsSCBUsCAMCAwgDAgMjC?=
 =?us-ascii?q?wIDFwkHCgMdCAocEhAUAgQTHgsIAxkfLAkCBA4DRQgLCgMRBAMTGAsWCBAEB?=
 =?us-ascii?q?gMJLw0oCwMUDwEGAwYCBQUBAyADFAMFJwcDIQcLJg0NBBwHHQMDBSYDAgIbB?=
 =?us-ascii?q?wICAwIGFwYCAm8KJg0IBAgEHB0kEAUCBzEFBC8CHgQFBhEJAhYCBgQFAgQEF?=
 =?us-ascii?q?gICEggCCCcbBxYZHRkBBTYnBgsJIRwKHwsGBQYWAyNxBQo+Dyk1NjwvIRwKI?=
 =?us-ascii?q?gYiARsCmQFrCJYzrkU0B4IUgT2BRAyeLQYTLZZRDgaRdpZqpzOBaAeCBzMaJ?=
 =?us-ascii?q?IM3TgECAQINAQICAwECAQIJAQECjh0MDQmEA4otPzQ7AgYBCgEBAwmFRwEBi?=
 =?us-ascii?q?UgBAQ?=
IronPort-PHdr: A9a23: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
 4qW/EoSADJF7s6S4sYWQcTZeprvDQ==
IronPort-Data: A9a23:uHR296xE87A56WV3gip6t+cowCrEfRIJ4+MujC+fZmUNrF6WrkUAm
 mpKCmmOP6uPZzDzethyPIXnpEIFvZ7XzINlQFA4qlhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefQAOCU5NfsYkidfyc9IMsaoU8lyrdRbrJA24DjWVvT4
 YOq+KUzBXf8s9JKGjJMg068gEg31BjCkGtwUosWOJinFHeH/5UkJMp3yZOZdxMUcaEIdgKOf
 Nsv+Znilo/vE7jBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XOdJEAXq7hQllkPg22
 PNKi5mBZT4HGa/UiPYsDSJiKyBhaPguFL/veRBTsOSWyFDaNWThybNiASnaP6VCo7wxWzsRs
 6VHbmlXBvyAr7reLLaTb+B2hdk4auTvMpkevH5I0jzTS/orKXzGa/yUvoIBjWho7ixINa/YS
 s8iOWFfVk7jX15gJ0oyMYwcu8790xETdBUB9Q7L/PNpi4TJ9yR617PmMfLOa9mSTINUmFyZr
 yTI5QzRBhgFPdib4SiE93i2j6nOmzn6UcQcDtWFGuVChVqO2ioMBRdQWVbTTeSFZlCWHMJ5L
 HIRywYXg48w7Fy5f4fGZSW5vyvR1vIDYOZ4H+o/4QCL76Pb5QeFG2QJJgJ8hMwaWNweGGR2j
 QXV9z/9LWM/6e3PIZ6I3urM9VuP1T4pwXgqSQJsoeEtxt7lvIg5hw/VJjqIOPPr0oStcd0c6
 wqKoSk4g7wVgYsz2ay/7zj6b9+Eo5/UUkgq6w+RUm/NAuJFiGyNN9LABbvztKcowGOlor+p4
 iBsdy+2srpmMH11vHbRKNjh5Znwjxp/DBXSgER0A74q/Cm39niocOh4uW8jeBgwaZ5fJ2CyP
 ic/XD+9ArcMbBNGiocoMuqM5zgCkfKI+SnNC6yFMIEUCnSPXFXcon4+DaJv44wduBFxzf9mY
 MnznTeEVDhDQaVh0DesQeoBmbYkrh3SNkuDLa0XOy+PiOLEDFbMEeltGALXMogRsf3YyC2Ir
 Yc3H5bbk313DbylCgGKoN57BQ5QcRATW8usw+QJLbHrH+aTMDp8YxMn6eh9INMNcmU8vrugw
 0xRrWcJkwOl2CeaeVrih7IKQOqHYKuTZEkTZUQEVWtEEVB8CWp2xKtAJZYxY5c98+lvkax9Q
 /UfJZefD/4JRjmeo2YRapz0rYpDchW3hFvSbnT/P2VlJ8ZtF17T59vpXgrz7y1QXCC5gssJp
 eHy3A3sR5deFR9pC9zbaa70wl7o5Sodlet+UlHmON5WfEmwooFmJzav3OA6KYcAJEyblDed0
 g+XBzYepPXM+tNkroOW2Prc94rwSrlwBEtXGWXf/I2aDyiC8zrx25JEXcaJYSvZCjH+9pKiU
 uMJnfvyB/sKwQRRuI1mHrc3lq8z6oe9p7JeyQg4TnzHY07yU+FlJWSam9ZCvOtBy+YB6wexX
 0uO/PhcOKmIYZ+0TgROeVB9NunTh+sJnjTy7OguJBuo7iFA/I2BDRdYMS6KhXEPN7ByKo4kn
 bwstZJE8QC5kRZ2YN+KgjoNrjaJKWEcFboqvNcWDdaz2AYsz1hDZ73aCzP3uc3eNY8TbxNye
 jLE1rDfg7l8x1bZdyRhH3b63d1b2cYEtidMwQJQPF+OgNfE2qQ60RA5He7bleiJIsirEt6fO
 1SH82VwIriSuShljo5PUghA3u2H6AKxoiTMJ5khzQU1jHVEkkTSIWd7NevlEIUx7TdHZjYCl
 F2H4D+NbNspFf0dGgMtVEQjp/GLoRmdMOHdsJjPIvlp1KXWrdYobmFCqIbIR9ba7RsNuXD6
IronPort-HdrOrdr: A9a23:OUTbaqnX6/6+lVu868zVWDjDSKfpDfII3DAbv31ZSRFFG/FwWf
 re+cjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzEnlv4bjJ2wGd3AQV0iM1XYCNu6jeHcGOTWvjvcCfq
 ah2g==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,287,1647298800"; 
   d="scan'208";a="16351970"
X-MGA-submission: =?us-ascii?q?MDGZcqbm/ddT3pKA0nM7cdh0lmYs8nAiskRRtV?=
 =?us-ascii?q?eCM5z2I/ImDVw6bEdtcy7bZI9vcSMJx5RNabTkKawxsQo8QkWFwyeOjk?=
 =?us-ascii?q?vogx8ayyGv5UNrWRBjMzWl7Hzey9XqvISCHT/uQyWWAaWcuMmHPqvpUK?=
 =?us-ascii?q?gf3+tywYz06dhlpfL94kfspQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 18:20:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1654791631;
	bh=+uSkX9S/rlMN4xzVpMPqw0DLYACqJIpVDEqwT3qrK+Y=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GqXqaIP6SrzFpHZ476klxTLyyiUSsLiYwV051C6VFB0hEm/80BAyTlxOAvDN3Une0
	 1ju0uDDTtYd1iYvbyvWV6HAxxpUprrQ7xaq494Hc2Xp8ZTI4XjVUkH0Zin9a5+PH6V
	 PilBszPBAyjKiOKci6fJPH9j8Xih5xX/z3vPJi/g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.155.143]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWi9q-1oEoQI3qmW-00X7qE; Thu, 09
 Jun 2022 18:20:31 +0200
Message-ID: <da86bc36-36af-7bd7-6bee-861e160ba6a4@web.de>
Date: Thu, 9 Jun 2022 18:20:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, kernel-janitors@vger.kernel.org,
 Nicolas Palix <nicolas.palix@imag.fr>,
 =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@netatmo.com>
References: <AS8PR03MB760365A0DE3A8522136471BE93A59@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <415ca02b-9618-b447-6471-6bcd0e2215e8@web.de>
 <alpine.DEB.2.22.394.2206072138160.2960@hadrien>
 <15a253a6-469b-9632-8c7d-983554604451@web.de>
 <alpine.DEB.2.22.394.2206091740520.2380@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2206091740520.2380@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xcDjdiCNvK2M9XQ6Dt0uasLk2yujxz5ZwgiJUK7szx7NU6sr+35
 uAAri932TPxRURp1+ebSONzdXDGb/2ofcnYc5XD/PxhW5gY2uU22Maivw/f20RXYbjAdMRT
 HbcZnsWcnoVaqSV8a/GfgoLBOK63OYvGBb/M/lgxjD+LAxYliQp34JDJrqcaLIFRSIJGIVX
 wIonZPbonhL8u2/7T8Taw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q8RbLf+PqB0=:p+Zp0PgyzWqgvpLk/Frdza
 Fkqs0G6mAQ/qO635BVSa12X9KXKJ/Nk/6f8lgk73JTarIJQtU+13VQFYmJwxnpigVO1f4SLgc
 puS3N1YPUuNyNL9B1du8u7Az8z2/zWrUrHw+IUAjRQAufYM71rEZi3wE1Tafp0LN5ilPD3TAx
 CP9nzEhtjJnvLaEkKeX0uLrcbrlm7sJE1gtz4+oM3h28KhbpHY4wwOwnHDzU9YI+YNObAi28m
 02UeiJv7Jfgccj/maGzSVp3GyLY978DHVruierjyDq8shCMfjLIc96TD7tG95NSBiKAATkKgW
 SB+Ta652ZP7Qz5oiLu4Mpk6UFXo3TOJkEugInfrq7SEJBmfxw1Um80r55djK6vqpS8jzCib56
 hfTdfGOnGYuvayZnS0gy2hjWoMux8WAcFP44LmAwIaC7tqDyoOkYSEA0Bm8iAYpBeDKLx6nOW
 CBxjmb6PIhi/QgoN59X5sv0LhMpwAx+LaqhKiMTpiS+JpvTA5T2ZrLTArh1oEmGRuVMWquZU4
 URVFKS+rvjAigrdbMLWVQ/3zhWRV0w5LbMGyeWwUlFIpaysisTKc1H2jXL/AlBi5jYgmZC7aH
 al8WyroZcEzLpY7UDlhu/Bk65rHGw6dVoBLuNSzPCygYF345ldHn6prRN85i27hwZ4dUuLp1g
 B2mCcQbMHjbn4PdDFaJC23f14Gkg0r/QSi30KSXN8whUt1OGCObNIE2LfQlb8rKQ3N6xhWkvP
 fR82tm8zxBCJHEzGUuuia5h8IzvExqluPA8/7QWSGYN8d+4LgKW5pbQIfyix/ObXu+T1TbGgJ
 NxbB8Zb1W7WMRezPzxt06SnudB75Jb1kCLSsoV/WY01AvLoBoBNt38S5WObxUE6NW+ZqU837r
 MlqDvz0AVLNAK8vMmJTeBWWJlVDpjjrZm83ETNeeywMJ9VrmvDWDg1MPeHz76dIvP0XhEJezW
 TolX+QE35nf3ZTC5odQ0Tc8WHIGMrwYmSTUeMG4Lr84Gq84Xg+oi2n3QFatUTWMA0JJOaR4am
 2OAsnOLPo1l/r56XGiq0n0P3BU6ejmyBGCQAeFh0mpekCEaynjPxXjEq69P248gtF6h8AddM9
 hX0joP8fYLMiRjYO94Hbup6nC6ISv+UkzWiVeyUl5d+dvtaHC5pz5+C7A==
Subject: Re: [cocci] coccinelle: ifaddr: Find address test in more complex
 conditions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 428
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/da86bc36-36af-7bd7-6bee-861e160ba6a4%40web.de>

>> Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Coccinelle/Prob=
e> spatch --parse-cocci show_address_determination_in_checks-20220609.cocc=
i
>> =E2=80=A6
>> @display@
>> expression x;
>> @@
>>
>>
>> (
>> *&*x *|| *...
>> |
>> *&*x *!=3D *NULL *|| *...
>> |
>> *&*x *|| *...
>> |
>> *NULL *!=3D *&*x *|| *...
>> )
=E2=80=A6
>> Would another transformation be needed for the omission of trailing bin=
ary operators
>> (according to the shown combinations with SmPL ellipses)?
> I don't know what you mean.


The results from the application of some isomorphism are shown by the ment=
ioned command.



> How about trying an example?


You might interpret the following test result as an expected one according=
 to
your understanding of implementation details.

Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Coccinelle/Probe> =
spatch show_address_determination_in_checks-20220609.cocci initialisation_=
test2-20220609.c
=E2=80=A6
@@ -1,8 +1,6 @@
=C2=A0void check(void)
=C2=A0{
=C2=A0int s =3D 1;
-bool t =3D &s ? 0 : 1;
=C2=A0bool u;
-u =3D &t ? 1 : 0;
=C2=A0}



I observed that no questionable places were marked in the following source=
 code.


void check(void)
{
int s =3D 1;
bool t =3D (&s);
}


Will this test case trigger further development considerations?

Regards,
Markus

