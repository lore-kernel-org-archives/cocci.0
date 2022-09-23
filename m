Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85B7C6FA82
	for <cocci@archiver.kernel.org>; Fri, 23 Sep 2022 17:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=FNdNY6S2a88omOuZ8cT6xQ13b1NTfmKvU4RrK34fMA4=;
  b=N85y2cPg7OWA2L/xi8njrTkrhn3TrUbTqPBdk8qyuOqzSh8BwWFsSnUZ
   GvMkqjCU1P57Zgqt1hXlxmriuH6kQdf3+L7PgiGDNaYr+EJ8RnbDcUImH
   l/uW3gWegR9fP1FvKL18a+HhSNsgAimIsax7evWihA8MR9J8cYTDrWc0i
   w=;
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
X-IronPort-AV: E=Sophos;i="5.93,339,1654552800"; 
   d="scan'208";a="54283813"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Sep 2022 19:03:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 85EC3E0236; Fri, 23 Sep 2022 19:03:03 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8A4C1E0091
	for <cocci@sympa.inria.fr>; Fri, 23 Sep 2022 19:02:58 +0200 (CEST)
IronPort-SDR: 632de6c2_0ot6fZiItBZTRuGttIv042ciI/woGs3xTpfz4r5ua0QRfxa
 wLPhdoDVXKCaFMSJ/D88FoqOI2DxuxquvbWm56A==
X-IPAS-Result: =?us-ascii?q?A0BfAwBW5i1jhwsR49RaHgEBCxIMQIFEC4IkgVcuBAtFh?=
 =?us-ascii?q?E6Ob4F3LgOEJocXi3+HUQsBAwENPwECBAEBhQUChGwCHQcBBDMGDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEZCRcHDhAFIoVoDYI1KQGDZ?=
 =?us-ascii?q?AECAgEjBBkBAREmAQQLCxoCJgICVwYNCAEBgnmCbQEDDSMHrDd/M4EBgggBA?=
 =?us-ascii?q?QaETh8sIlKBXAmBESwBjy56JxCBVUSBPIMDPoREg1aCZpR7hCImBA4DGSsdQ?=
 =?us-ascii?q?QIBC0I0GAMUAwUkBwMZDyMNDQQWBwwDAwUlAwICGwcCAgMCBhMFAgJNNggEC?=
 =?us-ascii?q?AQrIw8FAgcvBQQvAh4EBQYRCAIWAgYEBAQEFQIQCAIIJhcHExgbGQEFMicQC?=
 =?us-ascii?q?SEcCgQaDQUGEwMgbwUKOg8oMWsrHRsKgQwqKBUDBAQDAgYTAwMiAhAqMRQEK?=
 =?us-ascii?q?RMSLQcrcwkCAyJnBQMDBCgsAwkhHwcoJjwHWDoBBAMDECI9BgMJAwIkE0h1A?=
 =?us-ascii?q?jcTFQUDDRkmCAUjFx0ECDwCBQZXEwIKEgOadXoTgSeBCRuvA5JyNAeCF4FEg?=
 =?us-ascii?q?UkMnk4GEy6WZw4GkgkthwkTj0GiP4UqgXckgVszGiSDNk4DGQ+OIBmEDIotP?=
 =?us-ascii?q?zQ7AgYBCgEBAwmFRwEBhRgBAQ?=
IronPort-PHdr: A9a23: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
 t3Iib61NzpItd7Zr5N0Og==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:WenCC6+A6O9nXvyJGg5uk+D8I+orL9Y04lQ7vn2ZhyYlF/Bw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObOEYZmIbsS+V2njbLz9t+ri6GLvDv5ak856Bd3ARV0lYhT0JdzpymSBNLjV7OQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,339,1654552800"; 
   d="scan'208";a="54283792"
X-MGA-submission: =?us-ascii?q?MDHsHOly120WVM/kq9tmuMUKe5Rj0Fh6vwM7Qa?=
 =?us-ascii?q?Dfa46l1gLkIq6ILEDXtKbWb8FsV3jofPasgYVXB5i7711+R/amuKQJiW?=
 =?us-ascii?q?/B1geNcHGKyt6WtWe/50VrpWNCzSeMWVi9EskWfaASq735E56iScmnD4?=
 =?us-ascii?q?gTRT+t1F+DHSp9e5uUkg7Cgg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 19:02:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1663952565; bh=H7evFtt5qYlVgXphk4QhiH9qqCmd3WcK2wTn7ayeyW8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=N6evLLsuHqBOI7XNe3EN5hqOXLgy4bZcbrI0noG94QZ/jQDclj2B5c3CTkMu7Amvt
	 MkSmQJj6onXnvsQzh3K0gdruU0wihn22TdXzUSky6IWpTRKTWlR4eimYXZEd9Pm6eC
	 YYsNQmptYWXcZm23iuBEj2lFMLpBl+w76XD5LUOdDBqWWEu3xhheiBAA6WHoOxYLRq
	 Ceni8/c75LJYeg9cjrvDaxekseaVHbEAv//uLsgAiZCQP0sELmchtFlMiWuwzpYVDL
	 w83EGVpcZgMwUJ8MTM9rcVM8aOtRZ6Q/UZNldZHsh16kz/asBatuOajndG+M+h/oTO
	 K0CatrLMD+7mQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.160]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbkSC-1p85QB1hew-00dMh9; Fri, 23
 Sep 2022 19:02:45 +0200
Message-ID: <6a0600c7-dcdd-f37d-9a6d-cc734cf88dd1@web.de>
Date: Fri, 23 Sep 2022 19:02:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Yuan Can <yuancan@huawei.com>, cocci@inria.fr,
 Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org
References: <20220922115535.44132-1-yuancan@huawei.com>
 <20220922115535.44132-2-yuancan@huawei.com>
 <3351dd3d-f55a-10b0-6b35-d5206570e687@web.de>
 <2274a1a9-4b13-7677-9cf7-55ea960d8be@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <2274a1a9-4b13-7677-9cf7-55ea960d8be@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MjFc27vmLw0fF20qe9p6WYImpS7/FfwDAVLW1+M2rQSLaCd+bqy
 dqr3b2pQLMayD6H4kxS/JbKvjAKPthXhRI7oPGZCgkZGIjT1ySivN7kbx9MdJpLKk8qNu1L
 laPI1rdMoH4vBQPQ2YT4mQuKKCoIMgrw6igv3Z6RGyF1SAMUTQstHXLg0UxSTdvV1Tio5r/
 lNgwUK0386mEHePZ1p8vg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KQ6XD6niI+w=:T+qqf8yNm/R3Ds6Qnvo1pq
 ZRs12yTnRcZGuU2n5mmvOz863zorkFMYnU3e6wK5mp+AbfkVCnWDDGMv8b6FlzVnxaLfLg7/r
 rM83VXFuxzJrVLh7u9sawbsjLtIaef0Ydbqz2xk+bQc61ovMNSyXHArB+btaOeFw31OOnmY5H
 055Mlz1JTXvpdxFryMjosHWMlMedKgcPDKsGO6oL0faB4g7qD91sQlSwetDABq4w7HzoyJDPB
 kIcYjr5G3cgZQsoQMhgEMQ+lg6U0p8akhjhzfHDJZkGQETZYRjwv5RHKX1Q7BZ6a39da+vJqJ
 HaPJsKP/F3wHgycKDnmxASMuatNak0IDIKnzgqaRk53WG7IUF8/2AVm3+xejo1NJw15bKsqEi
 0zMxB7zgb8VgiA41ZvSFfLsanKWqFnwfV/Wbf7a8YpEhOfPBTK7/6ox2pMruCdserP/3j44E9
 rmzlB7wuvEXIsWzVZHlEfrIjgC2HPRymcFJg/pkV2bBsn0eh9ABCy5uTkMNIXwPrnszxgnMiu
 NNUmS458UY6BfT27m2XfKOnYQsKDs6MyHws7K05LPGYbWqvzhJGy1gPVmhMjEM/yMU/8UxI3O
 8nycAcZfPohP5z0f3LqYtz/8caIchlSS5UibTu/DCru2KecaBz/HWvNbntoHFUFg7lzraWdCR
 uj6vvnSW6qLV88RsLqjq3AnnO5L+GhXSNM5pEPxrxOSMSEUMSgybI9BKDqRKtjQzWvE5x7ZOk
 vzh2zBGnk1L8J/0WkMWl4nQ3FqAyskEsiEXaCzvKylW1AP3Cte3Xx9Ri+8Uhe8noAhpNCUeb+
 tT2i+FRlXQKc1SnAZiQ7/hRTcfZVFkDEMSEf9s4ylXx7raFto2qcQPA/ktCze7GL8dUbI/lry
 KyX6ispv8PGdguUesbWPKMtvTdE0cVQhu1tV6b7Nt1CWjzUZJXIJORF6zpliIYBkmBkxxzzPq
 9aNNNOkNdI6cEML1kuar65gK/i66/VaiaeULoe9l0puUjs4qZa2cPKKENarSFTHijSGcfkwfg
 2etnAZezKM1Y33Dlcs8kimL8OKYX75EulPEuKYEuMjVPXAjlxnU82elwYrVn3gb1rIORjQc2X
 8PSRzR+ONIsc4OLABd64J/dFXhx6KcBA5Ff+qfDwekhz9bxp0KgDyZdz8/EX9xDXbeHJWc6qV
 66AMp8qPfo6srsn4LN03vqCtuy
Subject: Re: [cocci] [v3 1/2] coccinelle: locks: add
 missing_mutex_init.cocci script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 576
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/6a0600c7-dcdd-f37d-9a6d-cc734cf88dd1%40web.de>

>>> +@r3@
>>> +identifier s, fld;
>>> +position p !=3D {r2.p};
>>> +@@
>>> +
>>> +struct s {
>>> +  ...
>>> +  struct mutex fld@p;
>>> +  ...
>>> +};
>>
>> How many mutexes (or spin locks) should be initialised before further d=
ata
>> processing can be safely performed with corresponding structures?
> I tried the semantic patch on this file:
>
> struct s {
>   struct mutex fld;
> };
>
> int main () {
>   struct s *mm;
>   mm =3D kmalloc();
>   mutex_lock(&mm->fld);
> }
>
> and it reported the expected error message.


This test result might be nice.


> So what exactly is the concern, Markus?


I just suggest to check once more if it would be really required to determ=
ine
the position for a data structure member twice (as proposed by the SmPL ru=
les
=E2=80=9Cr2=E2=80=9D and =E2=80=9Cr3=E2=80=9D).

Would you like to compare the data processing for a SmPL code variant
like the following?

@find_member@
identifier s1, s2, f;
position p;
@@
=C2=A0struct s1
=C2=A0{
=C2=A0...
=C2=A0struct s2 f@p;
=C2=A0...
=C2=A0};

@show_member@
identifier s1, s2, f;
position p !=3D find_member.p;
@@
=C2=A0struct s1
=C2=A0{
=C2=A0...
*struct s2 f@p;
=C2=A0...
=C2=A0};


# How do you think about the handling of multiple members within data stru=
ctures?

# How much does it matter here that curly brackets are used for a proposed=
 SmPL constraint?



I got another development concern for the presented algorithm.
Why is a data initialisation function call searched in the first SmPL rule=
 at all?

I imagine that potentially missing function calls can be determined also
by other approaches.

Regards,
Markus

