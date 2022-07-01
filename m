Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E86AC433EF
	for <cocci@archiver.kernel.org>; Fri,  1 Jul 2022 16:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=sc5haICp0r9sKEVe6yhAEIjQvIhn95yGYiNm0cSa4sY=;
  b=vXUgrGAPO2SnXnKbdOdt40WsvfjfYMu02xAGeiUr3kE2w/lHyVfypWZZ
   7YWrfn3OUx5ZyJ753ugerq9HrYXhXhOp40qsje3fDfrnFftipUV+JDkna
   aaqYOZTLUxCXiUVKHFbvFP28E0l0Aeiw6eAGWUbl3VAJ4ZonQ9d7KuZ2/
   Q=;
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
X-IronPort-AV: E=Sophos;i="5.92,237,1650924000"; 
   d="scan'208";a="43879738"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Jul 2022 18:20:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2FBFDE0358; Fri,  1 Jul 2022 18:20:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2B285E0092
	for <cocci@sympa.inria.fr>; Fri,  1 Jul 2022 18:20:26 +0200 (CEST)
IronPort-SDR: glyWxQIUu7De1JMV9KLWD01/hbu1Gdd9jkx6XejKPSvjNM6HO4rI3v2Nbno4HjN6PMbknD3wY3
 dE9eZg1dwdboHOW1AQGSF6E+p59SFGncuTMIyQx6jXhvwjsoUFpF0xxZb0j19KYG5ZcH4jiuqy
 JJEWgrN54ANNd6TKB/WEOX3QxnIKkrwYbSmnxbA7d4UXz0e/4lflIUroQsTm+I5G96sKks4RFt
 jOpJFMS4DRpvazyyr+itqyakumYqzBAsyODjVWLmsh1Sb7gK7gpRifj3tAg4VZnlw18/aN5kMk
 rW3EPd5rtJj+EoYFI5Dt6s5x
X-IPAS-Result: =?us-ascii?q?A0CYAQDpHb9ihw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CJIEBVi4EC0SETpBfMYQjjimKO4FoCwEDAQ07BAECBAEBhHoKAoVLAh0HA?=
 =?us-ascii?q?QQ0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEMDQkFCAoHD?=
 =?us-ascii?q?hAFNgZeBmQEgUsEgXQLNA2CNSkBg2QBAgIBIx0BAREmAQ8LGgIRFQICVwYBD?=
 =?us-ascii?q?AgBAYJ5AYJkAQMNIwcLrReBMYEBgggBAQaBPwGDCx8sIlKBXAMGgREsil6DJ?=
 =?us-ascii?q?HonEIFVRIEVJwyCRzA+gQ+BUwEBAoEXgQaDF4JljHWNMyYEDwMaLS8SgR9uA?=
 =?us-ascii?q?QgEAwMHCgUwBgIMGBQEAhMSUxwCEgUHChsOFBwkFwwPAxIDEQEHAgkSCBUrC?=
 =?us-ascii?q?AMCAwgDAgMgCwIDFgkHCgMdCAocEhAUAgQRHgsIAxkeLAkCBA4DQAgLCgMRB?=
 =?us-ascii?q?AMTGAkWCBAEBgMILw0nCwMFDw0BBgMGAgUFAQMgAxQDBSQHAyEPJg0NBBsHH?=
 =?us-ascii?q?QMDBSUDAgIbBwICAwIGFQYCAm4uDQgECAQ3JA8FAgcvBQQvAh4EBQYRCAIWA?=
 =?us-ascii?q?gYEBQIEBBYCEAgCCCcXBxMYGxkBBTInEAkhHAofCgYFBhUDIW0FCjsPKDQ2P?=
 =?us-ascii?q?CwfGwqBGiwrFgMEBAMCBhoDAyICECkGMgMVBi0VEwYiARsCmz1rgUGCBJMHj?=
 =?us-ascii?q?1meazQHghSBPYFEDIlRlGAGEAMtllYOBpF6lnMgjRKaEYF4gX4zGiSDN04BA?=
 =?us-ascii?q?gECDQECAgMBAgECCQEBAo4dGR6DOzOBC4kiPzQCCTACBgsBAQMJhUcBAYk8A?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:7RRJN6A040kiHxVW/wblw5YqxClBgxIJ4kV8jS/XYbTApGhw3jZVy
 mQcWWmAO/qNNjH8ft5xaoW1oB8AvZOEzIJkOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6j8lkf5KkYAL+EnkZqTRMFWFw03qPp8Zj2tQy2YfhWlvX0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYox6lusFgy
 MlQj6fzQxoPGpyVtcVASgYNRkmSPYUekFPGCX24rNDV0EDMNXfhqxlsJBtvZ8tCoLkxWDwIr
 KBwxDMlNnhvg8qTyai4V/Iqq8AtNsjtM6sAt3smwTyx4fMOHcuTHPSVvoAwMDEYocx/BfzEP
 o0gbTswKxjcaC9BJFoFMcdr9AuvriCiL2MB8Qz9SbAMy2za0wV11JD/Md/fYNXMRMNPn0/eq
 Hiu12/+CRobHMeOzCKMtHOqnO7G2y3hML/+D5W98eN2xkKezCofBXX6SGdXv9GSpmuvStJDN
 nYvuSAzi4wDrWGKE8DiCkjQTGG/gjYQXN9ZEusf4Q6Ly7bJ7wvxOoTiZmEYADDBnJBvLQHGx
 mNljPu1VGQ36+b9pWa1puvO8m/a1T09cDdaDRLoWzfp9PHPjenfZDrsR8xnC7SojtCd9drYn
 G7T93dWa1k7p8cH2qP+wvsTmS6wq53DQxQ6jjg7s0qg6R5lIpGobcqk5DA3DMqszq7GEjFtX
 1BdyqByCdzi67nTzERhp81TRdmUCw6tamG0vLKWN8BJG86R03CiZ5tMxzp1OV1kNM0JERewP
 hKN51oKtMQJYyDxBUOSX25XI5t6pUQHPYu1Ps04kvISO/CdiSfaoHAwPhT4M57FyhFxzvlX1
 WinnTaEVCtGV/0+klJats9En+ZjxyYiyHnVSIyzxhvP7FZtTC79dFvxC3PXNrpRxPrc/m39q
 o8DX+PXlUk3eLCgM0H/rN9LRXhXfCNTLc2n+6R/KLTfSiI4QztJI6GKntscl3lNxPk9ehHgp
 S3mBSe1CTPX2RX6FOl9Qio8N+m1Bskh9CJT0O5FFQ/A5kXPqL2HtM83H6bbt5F+nAC65fIrH
 fQDZeuaBfFDFmbO9zgHM8vioYYkeBny3VCCOC+sYT4eeZ98RlWVq4G+IVa1rHEDXnitqM8zg
 7y8zQeFE5ANcARVCpqEYvyYyV7s72MWn/h/XheTL9QKIBfs/YFmJjbflPgyJ81QexzPyiHEh
 RmbC1EUqLCV8YMy9dDIg4GCrpuoSrcvQBAFQjODtbvvbHvU5Guux4NEQd2kRzGFWTOm4rima
 MVU0+r4bq8NkmFKhIwgQbxl+qQzuon0rLhAwwU4R3jGYgj5Cr5kJXXaj8BDurcUn+1cvhaqH
 F2C8J9WNOzRas/iFVcQIisjb/iCjK1FxGONsK5teEiqtjVq+LenUFlJO0fegiJqLIxzbNEvz
 9AntZNE8Ae4kBcrbo2Lg3wG7WiKNXBcAawruotDWd3ujRc3jE5Pa9rQB3ausp2IbtxNNGgsI
 yOV3faT2e4DmxCaK3djR2LQ2ed9hIgVvE4YxlE1J2OPxojPiMgx0UAD6j8wVAlUkk5K3u8b1
 rKH7KGpyXhiPguEhfSvm0ipHBxdQgKU8Ar9xjPlUYEfo1aADgTwwK8VYI5hP3z1N0pDczId8
 LzwJKPNT2PxZM+otsctcRcNlhEgJOCdMiXdlcrhE8nt81zWp9b6qvfGWFfkYCcLzS/8aIMra
 AWqECtNhXXHCBMt
IronPort-HdrOrdr: A9a23:WhHgEqr7SaFp9w/8iO31gZ4aV5omeYIsimQD101hICG9vPbo8v
 xG78566faUslwssR4b9exoVJPwIk80sKQFhrX5Xo3MYOCFggaVxehZhOOI/9SjIVybygc378
 ZdmsZFeb/N5BRB4/rH3A==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,237,1650924000"; 
   d="scan'208";a="43879737"
X-MGA-submission: =?us-ascii?q?MDErPgmigNEMmoygHtkbpv1e73X7fMQ5pg9XRE?=
 =?us-ascii?q?r9lPDxVAGkddqr4FH5RZBs5S7Mnmz38+LDqQHxiXS2xsYR9b1tyYv/mg?=
 =?us-ascii?q?ot1VK8i5QtqZ0WGNDpMJHgKUFKmbpTys1F3fkGv3ion+92vB6dt4h490?=
 =?us-ascii?q?KN4iMCXHFbyGuv3Mmr4ElOoQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 18:20:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1656692424;
	bh=82xwfA0Mnu6CY38ouyjdF/YACfpaPpvZymx3pwBAagA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GjNHzYClHYDEcdHp3fM/bjFCo63OCwVO5382QoMgc7I/jxtyOe3DZ3QJtSuz3SpOT
	 fZNUQhGxl8/telG2iOc7jm4GZ3Y2glG6tEFUdFab2zg7sqdVVtslP/HUMpqgAOhfs2
	 0Tad+kVQpHwbokv8V6WJ3HEuIRpynHDUwQ7MBSGc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([93.132.48.14]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeUbo-1nX9993zNM-00aOnB; Fri, 01
 Jul 2022 18:20:24 +0200
Message-ID: <01936690-bb86-1cf2-aa66-fc860972b64e@web.de>
Date: Fri, 1 Jul 2022 18:20:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-GB
To: cocci@inria.fr, =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?=
 <jeremy.lefaure@netatmo.com>
Cc: Nicolas Palix <nicolas.palix@imag.fr>,
 Julia Lawall <julia.lawall@inria.fr>
References: <AS8PR03MB76039ED18663E85F7E8234CF93B59@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <AS8PR03MB76032BE6B27D43AD020D810D93B89@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <alpine.DEB.2.22.394.2206281246160.2182@hadrien>
 <AS8PR03MB7603A0EDD52082F08387477993B89@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <alpine.DEB.2.22.394.2206281635110.2121@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2206281635110.2121@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:zrq8HVm/rqFptQ6OCfiJ74gs3H9i0TggqD+d2ZazGqaT4UX1UvW
 ipGrjI95AZfaeocOwTsUpzBWN7MDs6KOjTIERyhOgO8xh3Af9P0TJxSPjjHoVY8oU9U0QlS
 02wAKVHKzBkn8ZvnbtYbeG9ep48zocqqZzlwwXzbRwksT2iAWEbJZY2cH4gMBCFDZ6lowkN
 RVJZEujtsrhWDo3pYiMPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wyL1wd6z9Kg=:LeQWGkfeU34NaLer/WHfqC
 d5/Obg7FVArwSl21t0W1B4RY94IjXDgnZcaOjaSg0IMIU0i8AUN/j+viALqznY+I+4k7B69Wg
 ew0yvzT79taUUvrS0DvBkTHXtHWteeR4z0tdDcjNQBKzXPk12t/xNAY8M/GfcYZBJ1jstUXpC
 jSdm7LDRUcq0sCW5VplEm1seQMYQYMMr+D6QMtjU7mUvm6Hr0vYjqAGjF9qNsQCCDbzM7W+ra
 zaJBLhwloa95GjiWjT01RGYevVvjjHbfRFhDtlwxQ8Yu4LEQRg1JsSHssaSLkmfFq7U0kF3eJ
 8p0JOuBiPDCFUMEx2qwYiqALYGT/C4K1cPHWf2Q10X4OzP0iskiu6Tkc/wbO/8vEwN+gUuUxt
 fenzjWyB4Y3SWlcZQi1WWb9rOVL0OnLjlC8bgjJ3SOg9FN6QTV6Con9DYinoO/eo75WSpmGjf
 OsZ/R1kwpHU74QV+2ViraPbgckRy/KYTmb6Z5FFWr9fdAjC4zh5+QSTL3SzDY7cbIEE8fAoij
 nctc4ve4en6GDiOKJnIZAx6jgwxK+u1EGhShmZLleFmUL0XQpFHI2zifTDav9CbGOiH/vtLH+
 hW38dHCsOSaaoaxmcuqe6DC9N6ecSnvydzaDiFSEwVCSG5HOOtYljcE7M90nXENBBo/BRwAhZ
 1jH9OlmWg8yc3IWqib7jJW3bJ1jmRjffek9oRtGOLCw5tzDVWjtlYWSOjuLCU5DFiZLiCASdB
 gIn82X1sAQs4+lSWTUNYhAVAafyLsp20d6VvQzSuqApJOoppJ1Z8CXrJnAWqZmM8ODnbL0tOu
 oCINf1blqaWV4DQfVTfYRQyWaYW7K67Jeko16HtQrDjO4+FcrTPDqe/Owj1tYH/Gknlqsd++W
 je9nOFZg1olcBscvwhQxmbd/xjYq9C6albSR06Selfe6NPptqIOiP8guP4uGGedoylI/fsEgy
 kX+MHZbj/e3e2YrNAnRmpqJtY0PE2CokTPZvVue/7oKc9k4Auyaxw1pEcWm/3AZF+qX06bpdN
 WMtFY7cG7a/KFdLVcJow9edEw6b6hvoWAHlwE80I5kqNNdFKpEtya41mwMnF/NduLAdNOi8At
 llQ8LinMOqi88Z49PZz1bvUwKfvSsiMFYRa9SfK2X0b89cECpNZfdfviA==
Subject: Re: [cocci] [v4] coccinelle: Extend address test from ifaddr
 semantic patch to test expressions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 471
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/01936690-bb86-1cf2-aa66-fc860972b64e%40web.de>

>> I get that the &x allows to match the `!= NULL` case thanks to the
>> isomorphism `X => X != NULL` but I don't get how the `== NULL` case only
>> could match the test address without negation as the isomorphism is
>> `X == NULL => !X`.
> I think you should have \(&x == NULL \| &x != NULL\)
>
> If you have if (&x) S1 else S2 then it will consider the possibility of
> exchanging the branches and negating the test.  But if you just have a
> positive test expression by itself, it won't consider the possibility of
> changing it into a negative one.


This information can be handled in another constructive way.


Changes are generally context-dependent.
Thus context data are accordingly required also for the usage of structure isomorphisms.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/02d51a763c8bcce054e065062e43b9b196840159/standard.iso#L421
https://github.com/coccinelle/coccinelle/blob/19ee1697bf152d37a78a20cefe148775bf4b0e0d/standard.iso#L421

How do you think about to extend the SmPL search pattern
so that more case distinctions will be taken better into account?

Regards,
Markus
