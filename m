Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C048C28B2B
	for <cocci@archiver.kernel.org>; Fri, 19 Aug 2022 17:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KOCzZsLYba5QMnWaycuBVuoAM97RgMOPzlESvXqxVNo=;
  b=aBXoKF9Clm40rtrr2fdK0tNMN4guDQCcY4e0yyefUc4Ea8aJUzqjmI9H
   GZlUAbojU49icTt0iUqE3mrRw41EYygA4d/i+gumbCy/kggx8/Hv8ipfR
   63W+833ArvpgSqvp56ywa71z8qvT/vsSgLDm2RFB1ros/qFEWd79H7BDe
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.93,248,1654552800"; 
   d="scan'208";a="49262989"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Aug 2022 19:00:43 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 50215E0382; Fri, 19 Aug 2022 19:00:43 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9F170E0247
	for <cocci@sympa.inria.fr>; Fri, 19 Aug 2022 19:00:39 +0200 (CEST)
IronPort-SDR: EJX5RD1ythcTMKJ72F9uBCQUIjdy6JSCQWzzshipiv2jVLkHODeHA99/zvLUNZuiDYsj5tfzcK
 PcZGXsha5bcD4KVK/LWaZhJvpSUgL4z4+N/FdDRMBme6eaYZs77uh6OIY8OOlB63KQfpMWtOnd
 zbp8Th4TO52YliPhDpZVMDyU+FfLiUsKM1hdoADxpvvwvM4InnuYFbyYFalIUzzRhNCjflk/F7
 ArvpBN4lzocM3FdYpXulgHEJm/ILcoEUtUqNJ/xArUGtvgDAKL/8kvx5jpMfFFBSI1x982UgO+
 HhHI/27QU8ttWfCBCA8LIb3N
X-IPAS-Result: =?us-ascii?q?A0CrAwDBwP9ihwQP49RagQmDc4EBVy4EC0WETo5ngXcuA?=
 =?us-ascii?q?4QlmlYLAQMBDTMMAQIEAQGCE4J0AoR7Ah0HAQQ0EwECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEDAQEFAQEBAgEBAgQEARMBAQEMDQkFCAoHDgULBTYGXgZkBIFLBIF0CwcGJ?=
 =?us-ascii?q?w2CNSkBg2QBAgIBIx0BAREmAQQLCw4MAiYCAlcGDQgBAYJ5AYJsAQMNJQcMq?=
 =?us-ascii?q?QKBMYEBgggBAQaETh8sIlKBXAMGgREsjlh6JxCBVUSBPIMDPoJiBYFdg1aCZ?=
 =?us-ascii?q?ZluJgQOAxorHkICAQtNBQgJFxIQEAIEERoLBgMWPgkCBA4DQAgNAxEEAw8YC?=
 =?us-ascii?q?RIIEAQGAzEMJQsDFAwBBgMGBQMBAxsDFAMFGAwHAxkPIw0NBBgHHQMDBSUDA?=
 =?us-ascii?q?gIbBwICAwIGFQYCAk45CAQIBCsjDwUCBy8FBC8CHgQFBhEIAhYCBgQEBAQVA?=
 =?us-ascii?q?hAIAggnFwcTGBsZAQUyJxAJIRwKBBoKBgUGEwMgbwUKOw8oMzU8Kx8bCoESK?=
 =?us-ascii?q?ikVAwQEAwIGEwMDIgIQLjEDFQYpExItByt1CQIDImkFAwMEKCwDCR8fBwkiJ?=
 =?us-ascii?q?j0FBVs6AQQDAxMiPQYDCQMCLB8CmHCBWYFDKyAwgiegTKAwNAeCFoE/gUUMi?=
 =?us-ascii?q?VqUZAYTLpZjDgaRepYiYI04mieBeIF+MxokgzZOAQIBAg0BAgIDAQIBAgkBA?=
 =?us-ascii?q?QKMY4FTg1kzii0/NDsCBgEKAQEDCYVHAQGFIgEB?=
IronPort-PHdr: A9a23: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
 Q==
IronPort-Data: A9a23:1oLkbasT7wybi1NKNwgfmBQRKufnVH9YMUV32f8akzHdYApBsoF/q
 tZmKTiHbqyMYWb3e9p+Pdi39UwA7JPVzocxQARo/n83Fy9HgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTraCYEidfCc8IMsboUsLd9UR38g52rBVPyvX4
 Ymo+52GaQf8s9JJGjt8B5yr+EsHUMva42twUmwWPZina3eD/5W9JMt3yZCZdxMUcKEMdgKJb
 7qrIIWCw4/s10xF5uVJPVrMWhZirrb6ZWBig5fNMkSoqkAqSicais7XOBeAAKtao23hojx/9
 DlCnc2CbVl3eYTJpOYMUiZGOmZ/JYls0qCSdBBTseTLp6HHW37r3ukoE0w8e4EVkgp1KTsXr
 7pCcm9LN03F24paw5rjIgVoruEqNsr2J8Uyvn96zDfWJekrS9bPTs0m4PcChWho3ZETTJ4yY
 eJJTyFBcAnfSCFoMw4RKr0Tvef010LwJmgwRFW9/PdrvTGKkmSdyoPFO93ecd2iXtRQhk/ep
 2Tc/m2/DAtyHNiW1jOB9lq+h+rFhyq9WYQIFbT++OQCvbGI7mkUFQFQSlax5/W04qKjZz5BA
 x0m3nRw6oE3yE66T+bjdlq5uFqulAFJDrK8DNYGwA2Kz6PV5SOQCW4FUiNNZbQaWCkeGmZCO
 rihwIqBONB/jFGGYS7Np+bI8FteLQBFdjBfNUfoWCNYu4GLnW0lsv7YZvpOeEJfpv78AzXr2
 S2KoUDSbJ1M05dQis1XEXjtij6hoN32UxQp+gjSVG+/4WtEiGONYou19R7E4PwGIIvxori9U
 Josy5f2AAMmVMDleMmxrAMlQujBCxGtbmS0vLKXN8N9nwlBAlb6FWyq3BlwJV1yLuEPciLzb
 UnYtGt5vcENZCv2MvMsONvsUqzGKJQM8/y6Bpg4ifIRMvBMmPOvp3AGibO4gjy8zhN2+U3BE
 c7KIJnxZZrlNUiX5GPrG7lEiOFDKtEWnC2KDZH90xm917eCLHeaIYrpw3PeBt3VGJis+V2Pm
 /4Gb5Xi40wGDIXWP3eLmaZOcwFiBSVqXfje9p0MHsbec1oOMD97V5f5n+l8E6Q7xP49vrmTo
 RmAtrpwkweXaYvvclnRNRiOqdrHAf5CkJ7MFXN3YQn1hCB+O+5CLs43LvMKQFXuz8Q7pdYcc
 hXPU5zo7i1nRmuV9jIDQ4P6qYA+Jh2niRjQbTWoan4zcsc4FQDO/9bleCrp9TUPV3bm65Fh/
 uf4jg6LE4AeQwlCDdrNbKz9xV2GvU8bxLB4UXzOL4QBY07r6oVrd3f8g6ZvccEBIBnO3BWA0
 AOSDUtKrOXBudFn79TDw6yJ9t/7H+x7F0tcPm/a8bfvaXiEpDX+m9cYXb/RLz7HVW7y9KGzX
 slvzqnxYK8dgVJHk4tgCLI1n6gw0NvYoeMIxApTGniWPU+gDaltIyXd0MRC6v9Ny7tetVfkU
 06D4IADa7COJd+jD1MbYgYoN7zR2fYRkzjUzPI0PESjuH4ppuXaCx0KMknekjFZIZt0LJghn
 7UrtvkW3Arj2BAkBdCL03JP/GOWI31cCKgq6sMADInwhlZ5w11Oe8WFWCrx/Y3JdNhGdEUne
 2fGiK3HjrVa50zDb3tqSSmTh7UA38xWtUAY1kIGKnSIhsHB2K090ipRxjJrHA5b+RNKjrBoM
 W9xOkwpfqiD8l+EXiSYs7xAxu2AOPGYxqA1414OiXGfUESiEGDARIH41SBh42hBm1+wvBACl
 F1b9IoheSnndof900PenGZ7/uf7Q4UZGhLqwaia8gfsI3X+SSXoiOmiaALkbvch7dwZ3CX6m
 AWhwAq8hWAX+8LdT23XxrR2DYgtdS0=
IronPort-HdrOrdr: A9a23:4szLRaGovMHH9eVJpLqEzMeALOsnbusQ8zAXPo5KOHlom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAsxD4bbLbWSS4/yKgjVQX+xA/DGdmprY/ts2Ik0dNz2DUstbnnpE4o33KCdLeDU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,248,1654552800"; 
   d="scan'208";a="21703959"
X-MGA-submission: =?us-ascii?q?MDFT/PTMioyKaQ4RhmfbOfq5awjKI06hlMZdZA?=
 =?us-ascii?q?s8igVL9fnimRWx90bd658RVHN0ZIkbUVx+waFg/W4ilh5Pm3SnEmBJ1l?=
 =?us-ascii?q?8+iRIBQyJCcNq5n0iR/A+3k2IVQ5NSepKYOD2eoHVNgqqWyE3iZt3BAD?=
 =?us-ascii?q?XfUJzPImBu7dg++ZiwPOgJPw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 19:00:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1660928437;
	bh=d7AB+nkOmXt/YqoIy5mkd7M60vxWDJraOuVOCFWN95I=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dtp8HGfHB1AqA8P+akA+aBfsamcd7scbRiaUwYAF7a6z4Soaqkjk9QfjTb+Qvdy0S
	 W2qmoyC13FqODblM3UvYJN+jO0O+YeyoytMXuCes+Vyo5RzlwVfTFXPBL1BFQx9Wn/
	 4vubKDuVnd07ap39JNvbkZ5b2E6o/myTnY3XQXDg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([2.243.71.64]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJnvp-1o4x0m0IOn-00Jp0o; Fri, 19
 Aug 2022 19:00:37 +0200
Message-ID: <d9e428c2-f4d2-13bb-bf42-447a1f0ffa73@web.de>
Date: Fri, 19 Aug 2022 19:00:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Content-Language: en-GB
To: Jakob Koschel <jkl820.git@gmail.com>
Cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <20220816085416.1542114-1-jkl820.git@gmail.com>
 <alpine.DEB.2.22.394.2208161337001.2561@hadrien>
 <29F3BFF3-ADB0-4E8C-BE30-298D0ABB8F1A@gmail.com>
 <alpine.DEB.2.22.394.2208162306410.2625@hadrien>
 <A564705D-53D2-44E9-BAF4-AE99E78B09ED@gmail.com>
 <alpine.DEB.2.22.394.2208171631050.2482@hadrien>
 <92b5eb33-9c76-7e45-7651-6296c9795a67@web.de>
 <88152C77-84AD-4515-A403-71F827180FD9@gmail.com>
 <cf4058d8-13ca-0637-fe0c-d9d8582c5673@web.de>
 <17A83354-2406-47E5-94EE-4955E09819DA@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <17A83354-2406-47E5-94EE-4955E09819DA@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kGYQ7im6u9+pWQlyA8uF5l0UUAeRTojDWH0NLbA11HJbLEGrwQD
 o1gYUxfciQL/2AEps1i43HuNt+vBnlewcKwDSEU18hUmUt4g8cmwEOYFOiIN3ZC8EkjNlEL
 TxomWn6m25Fg6NRGwXKlU36vgMZRZzxA1n+jkC4VtWry5GMTeEAc8XtlXmKkPa5gikWup4I
 y/j6rD+L7na9f64ahavLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rCJ+aJPOboE=:dunt6vwsTakrrDTxh23bFm
 cdDEsazZEMA2b0z0V8+pP8+4eZi1T0V7gfM/DW5tobKDiSxAAyZFsfyg/jO3w+I2YeV71IgL2
 wMWBD5A6NxgjM3q/x3X+jTH+zm04ynerZVbZpjJ5xuVDLAba171G8RX8EBGJkoFo9uaXHvV/j
 F8hqvyOPytXb/l+fWaElNn/YX5/EfyYmq3Ml+MVrYAfnilqvPQH+T65ZCHnwPzKmNpkfNem3o
 rvt8wdtftu8JHyrEg4e0In4z0/FfunyH0bfuoFUTu5Lb8c1DPy/8eeRVixBdHBqAyvlo6Et+A
 kk9VpzOKhBDrwito8rx0pN1byp+EyYS/UblOQWzZJW0g0vHbcfYbVtCUVlRv2WqgcgvoYB/WZ
 jmVEKgKvjMEwv9U0Pi3k2NM6U5+TExEe2zQt6I7/rYnOgkJfXrbzfP7CeR4K8DLb+aC9m32YI
 4or/Hbk9T0kiGWrvcxYoyuQsx/d6ggd3ZF+pCNXV3L/F9PKyO9eqQrvrNisk/D2a8BZAGYXcp
 nnoCxG21YfDPS89uJGE+LYapP+0Z7lyFkAszYc+9VypaQFCpcuk9yBArPTF62ZX4mf1U7baW0
 SXUikZtxGQx4g4TUhwKK6UV0UlLwQU+nNGT4XIgwZmXyVxEUdAWRrEX1RCDAu4uWN099DPjX+
 xA4LtCvSo9CirxHNtF/EJyzb2H4NC8fqGD8FKMtPx1vRsKbuGDNwtLT059los48sFqpFs2k53
 p0kzuYymFOKYM8xyG6ZZUx9lLsQfLsTOJngXjL//c5ZrAcldjv/fBphx1KHvf3Sit/K2FwPTM
 FbkUlsS35yEZE4TXVWemIht8hIquSDfYQZTJ33++petD8XF56nhTmgSrjbyDc9PxAFSQvlSq2
 qwSOaZ2DRoa4+ejqvNJ+wCCliwPh91Plh+kGR0Ys0v9pCaYpEcNGwNDcgZRhRpYce1iRPnyY+
 PaCntsMxsuXL8IjNv0TxecWOAJ496TaL5sU754F7qGNgVSffd7cliAPib1Qv0TJlv4bHSmpMc
 Kg4LRwpjC8zW7lFFDOr7WpTcRZKHZaSHGWDYfKC572q5nBT9vfXOidZ8aW7OlwqJBbCmBvkUy
 XINL40pWWsREKl+v4XmZPLfTR7NukkYcRFdR88hTibb10BpyoG6C35xNQ==
Subject: Re: [cocci] Working with parameter/expression lists by SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 524
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/d9e428c2-f4d2-13bb-bf42-447a1f0ffa73%40web.de>

> I'm trying to detect certain code patterns spanning across files with th=
is.
> They will *probably* not easily be automatically patchable since I'm try=
ing to
> find bugs with this in an ongoing research project.


Would you like to add a link for this evolving information source?



> You're right, the positions can be omitted here, but I'm using them with=
 a
> simple python script afterwards to report the matches I found where the =
positions
> will be useful.


Would you like to improve the distinction for the usages of mentioned vari=
ables
any further by using operation modes (or variants) for SmPL scripts?

Would it become helpful to use the name =E2=80=9Dinteresting_func=E2=80=9D=
 as another metavariable?



>> =E2=80=A6
>>> +++ /tmp/cocci-output-test1.c
>>> @@ -6,7 +6,8 @@ int interesting_func(int argc, char *str
>>> }
>>>
>>> int main(int argc, char *argv[]) {
>>> -  int x =3D 0;
>>> +  int x =3D 0
>>> +    // test;
>>>
>>>   func1(x, "asdf");
>>> }
>> Do you vary comment additions for your test results?
> yes exactly.


Do you stumble on any more development challenges for adding comments
by the Coccinelle software?

How do you think about possibilities to add multi-line comments
(instead of specifying desirable messages behind double slashes)?
https://en.cppreference.com/w/c/comment

Are you looking for better source code formatting according to semicolons?


> Only issue I'm having now is that it doesn't work across files.


Would you like to explain remaining development concerns any more?

Regards,
Markus

