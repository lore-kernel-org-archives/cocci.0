Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823F0C54EE9
	for <cocci@archiver.kernel.org>; Sun, 25 Sep 2022 19:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Bz9nknY+ZdMk+JGD9rGUdauBQMRKynEJIzZPgcyB4+I=;
  b=RADh/ehTmQR3ZGM7oJMtJX6anaXPt/GwAhecqiUJtUlbgg0FZSa3085W
   JleGQwEk48U7cFritKgTdQT0iVuMu0ZCRp3mUKdwFDxZyYdPNqikTnqAb
   tkOdWUDyF3L2t3Rkegu/+ML21qpMzPbIVWdZGBL+LJkZWjKSyjxl9mi6T
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
X-IronPort-AV: E=Sophos;i="5.93,344,1654552800"; 
   d="scan'208";a="54407372"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Sep 2022 21:49:13 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4B571E0091; Sun, 25 Sep 2022 21:49:13 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B661BE0090
	for <cocci@sympa.inria.fr>; Sun, 25 Sep 2022 21:49:10 +0200 (CEST)
IronPort-SDR: 6330b0b6_x3dbAuR98c1aqaAZYE9MEaLDUUDU3ew1Pp3UAC95iWnjQqK
 KM4KobCJZG1Li6zOZtksJgzAtRjyaE5FAkfWDuA==
X-IPAS-Result: =?us-ascii?q?A0BlAwCorzBjhwQP49RSCB4BAQsSDECBRAuCJIFXLgQLR?=
 =?us-ascii?q?YROkGYxhCaHGJNQCwEDAQ0/AQIEAQGFBQKEbAIdBwEEMwYOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQMBAQUBAQECAQECBAQBEwEBARkJFwcOEAUihWgNgjUpAYNkAQICA?=
 =?us-ascii?q?SMEGQEBESYBBAsJAhoCJgICVwYBDAgBAYJ5gm0BAw0jB41JnBd/M4EBgggBA?=
 =?us-ascii?q?QaETh8sIlKBXAmBESwBjACDLnonEIFVRIE8glMwPoQdJ4NWgmaVAYQkJgQOA?=
 =?us-ascii?q?xkrHUECAQtCNQMVAxQDBSQHAxkPIw0NBBYHDAMDBSUDAgIbBwICAwIGEwUCA?=
 =?us-ascii?q?k02CAQIBCskDwUCBy8FBC8CHgQFBhEIAhYCBgQEBAQVAhAIAggmFwcTGBsZA?=
 =?us-ascii?q?QUyJxAJIRwKBBoNBQYTAyBvBQo6DygxaysdGwqBDCooFQMEBAMCBhMDAyICE?=
 =?us-ascii?q?CoxFAQpExItBytzCQIDImcFAwMEKCwDCSEfBygmPAdYOgEEAwIQIj0GAwkDA?=
 =?us-ascii?q?iRbdgI3ExUFAw0ZJggFIxceBAg8AgUGVxMCChIDE5t9gQCCI6BeoEE0B4IYg?=
 =?us-ascii?q?USBSQyeTQYTLpZnDgaSCZcLIKdJgXckgVszGiRPgmdOAxkPjiAZhAyKLT80O?=
 =?us-ascii?q?wIGAQoBAQMJhUcBAYR8AQE?=
IronPort-PHdr: A9a23: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
 t3Iib61NzpItd7Zr5N0Og==
IronPort-Data: A9a23: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
 z0B0iWYAyVdCa2FiQreCjJXTAunKj7nKqo0xH3A
IronPort-HdrOrdr: A9a23:oXnxPakD+MWuEJwLo0ZCUOZgeirpDfIZ3DAbv31ZSRFFG/FwWf
 re5cjzsiWE8wr5OUtQ4exoXZPrfZqyz+8R3WB8B8bBYOCighrKEGgA1+rfKl/baknDH4dmvM
 8KT0E9Mr3N5DNB/KHHCWeDYrAdKRq8nJxAR92y856gd25XgmhbgTtENg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,344,1654552800"; 
   d="scan'208";a="54407367"
X-MGA-submission: =?us-ascii?q?MDEwuOX//UKcY88bgowgzmbdkXlEpt72TSsrN6?=
 =?us-ascii?q?fH7BMMXUBazfAjOqZXR/3ol7yT3mVn3XidTDhYOdNRurnR3NnEghQhxD?=
 =?us-ascii?q?1n6E8rOl+dpDRvH24PWW6dfkNPPpBQEdCL2oFawWM+3lhtTI4DAqoQCX?=
 =?us-ascii?q?qWMHXv7X4p3JDpJ+YKGtrCbg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2022 21:49:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1664135340; bh=aBnoMMuHm+14Il0TUUUhegIIsCN5ZHE8j10SWi0YOMs=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=vYnK5M/OlDcEsfVbOjcMDjPF+gSzo+TlpKeDO1bJmd6q/n3UKuVHsVB7NstWVVfVF
	 ZrNiri7qe8Fz+nGQPOth3rh7wJIBCKeUeh1xOlwsMaGm5t5vs6LmUqOU4k7PE1794b
	 t7LDeTDvlkKqj312LgtOOIe6UTGVkXRGIhyHc7VuKplxFxFQiXx+HsxMdDmlmUNpSM
	 Ha6lq/xAq6kLlIH/jwZmgAQqyBu433erF7C9PcnSqAAY6eCadAj7dIKopIDnBMntYw
	 j3laHaF3qGuhY43YAl2zs5/RzQCnMvd8KjhNHKSx6DmYKlP4n+JbXsGWhPTGd8e9MM
	 yXgyg9fLFIvDw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.160]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbCI8-1pDoFH3V4i-00bqVg; Sun, 25
 Sep 2022 21:48:59 +0200
Message-ID: <d375b225-04e6-15f2-d559-ad7f404b5087@web.de>
Date: Sun, 25 Sep 2022 21:48:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Yuan Can <yuancan@huawei.com>, kernel-janitors@vger.kernel.org
References: <alpine.DEB.2.22.394.2209251906090.3293@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2209251906090.3293@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KVl3ttF+xXA/Idmg8TgN5SSm7CyCmpe6/Wpf9QLXFxudN5SWfPt
 tN5A7xw2p82CKOOAU04RmcQ3nhQcnJqpIpYz6tGptT1/LJ3UWJ67SXWSVnY81Q4V0ti12M9
 eXl4DpeXihDDCwJ+q1LuAUaUfVCryVQ7sbgk5yy4XJv+NsZqeozitv3ZkxafThXwJyQJ/Bj
 GQ3TJO8kGqB1onWInAomA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bSi5/wcGnJw=:84EM6km/r3bPmRzFQgqFFW
 +/G/nRZrEeAfyELa7TFp2/yBVxqiq/rDNhVXCB64Xyp8ro7SyuWKyh3IIRqz8diMgn3wBCos2
 sCrLzo1YgVuKBK6/UaMHkpV2E1U2nvfkrq54D/h17FouF6lsqUljX4gXQf/dIGxkx3nPD7D4y
 NOcKOkHZoQofbvbDTOK7PPDpXS0Tr8FZ19XK7mk52FQ8DHcF1WfvHRymahFQywI6BwXF2EDbG
 JRKN5w5i9NyXSzlp0C3zz4W/trQ1bwkzLEFFeEN65jGeFUGUXQ2DOQonjVnrolfnQQSUl80jo
 OEj4dyC2VvcQCEVUjMeIv4Kyy0sgXVVAvoUC5ScuxvRNZQ4dOHiPyThC2DTwqXyVkEtKPeu1z
 81N8XXLl2rLSmVnUF7M1FqVDEsinEnNlTC0qo7ePWHPRuntbAhirwVnAX1QCWdoKSsgX6lLjC
 tZi93xfWV7ufNAUsLbNmRcott+yRempYpU/KJoRe1JuqH7AOMdH1MGNVJIIH0wMLFCrZHgRcB
 dewgC+G2VftEnUkoLMJSDb6yF/VLxK5LyPDByz35jqHXhxjPwXDA57Zqrr6GEf1zSkDqbNzZA
 0Tso2Nk6Qryi4tdQMcrKg0pgeto4TD0CI3yqyF0WQo5Z5dPaxHFv54SMvzuZ/WZuVfRWXdQvM
 T+GNGyUoqYPJcoWZp7UmsGOrck5Fmk72IRBiUDrbPHGzvWlLRjVMHiYMEiGwp61jwdAog0fOs
 Uyg5sYvQpXFsjdQqnLyoX2b0onqDeAUYTFFqLi6VXnas1y9mfq2OUxJ379LF/ym0WN8ximM+g
 YPmvylWjZ8Ikr26CU98xqCihJFgK+ZZdIpBYd+23SkXuXz8Q3BHtgFyh6soGX61IMs2fT/Vmk
 j4dAjdVSYuhpevc+4DEqo9Jl1yaWSw+nK1cobzOUwgYLH4lnYcWrglgmEMXeBvZMUrN9Du3Cm
 +Khl3HzmwYTuWKJPXOPEGGOjWs4CeZV/MOum88BjmcM9QDW78lIf95793IA2iPc5bWLxSZRsg
 5Hcw9NnwM9epiZEE07L7V1aSQoiGcHzUeR5OkvTzoVSUstOH8hmGVJDnKslftsNbgw5mmM/gm
 5Cu6FWSWAExBxZ2KPckyt2tfNhqOwk+eEBmzDXFaTQGmxD/qIJjivJtgGJFFOM1mOu9fMRg2i
 fED35kkxauI5diGuo3Tq7ec8Tk
Subject: Re: [cocci] Checking the usage of locks with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 584
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/d375b225-04e6-15f2-d559-ad7f404b5087%40web.de>

> Here is an alternative semantic patch to the one proposed by Yuan Can.


Thanks for another contribution.



> =E2=80=A6                                        There may be false posi=
tives due
> to problems in parsing the functions that initialize or lock the locks.
> Another reason for false positives is the use of typedefs that make the
> type at the point of declaraion and at the point of initialization or
> locking appear to be different.


Will such background information trigger further development consideration=
s?


Would you like to achieve any improvements for safer scope (or name) resol=
ution?


> @init@
> type t;
> t o;
> identifier f;
> position p;
> @@
>
> \(spin_lock_init\|mutex_init\|__mutex_init\|__mutex_rt_init\)(\(&o.f@p\|=
&o.f@p[...]\))


How do you think about to apply the following SmPL coding style variant?

(spin_lock_init
|mutex_init
|__mutex_init
|__mutex_rt_init
)(&o.
(f@p
|f@p[...]
))


Can a reordering become helpful for known function names according to
their call probability?


=E2=80=A6

> @lock@
=E2=80=A6
> identifier lock =3D {spin_lock,=E2=80=A6
>   =E2=80=A6,mutex_lock_io};


Can such a function name list be also dynamically be determined?



=E2=80=A6

> @@
>
> lock(\(&o.f@p\|&o.f@p[...]\),...)


Can the following SmPL code variant work also?

=C2=A0lock(&o.
(f@p
|f@p[...]
)=C2=A0=C2=A0=C2=A0=C2=A0 , ...
=C2=A0=C2=A0=C2=A0=C2=A0 )



=E2=80=A6
> @alias2@
=E2=80=A6
> @@
>
> (
> return e;
> &
> return \(&o.f@p\|&o.f@p[...]\);
> )


Can the following SmPL code variant be helpful?

=C2=A0return
(=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e
&=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &o.
(f@p
|f@p[...]
)
);


=E2=80=A6

> @alias3@
> type t;
> t o;
> identifier f;
> expression ifn =3D~ "init";
> expression lfn =3D~ "lock";


How do you think about to apply more advanced regular expressions for
corresponding search patterns?



=E2=80=A6

> @script:ocaml@
> t << alias3.t;
> f << alias3.f;
> p << alias3.p;
> ofn << alias3.ofn;
> @@
>
> Hashtbl.replace other (t,f) (p,ofn)
=E2=80=A6
> @finalize:ocaml@
> cs << merge.created;
> ss << merge.created_array;
> is << merge.initialized;
> ls << merge.locked;
> pi << merge.possible_init;
> pl << merge.possible_lock;
> ot << merge.other;
> @@
=E2=80=A6
>       match (isinit,islocked) with
> 	(true,true) -> r
>       | (true,false) ->
> 	  let p =3D Hashtbl.find initialized k in
> 	  (1,Printf.sprintf
> 	     "%slock %s.%s declared in %s on line %d is initialized in %s on li=
ne %d, but is never locked%s"
> 	     s t f file line (clean((List.hd p).file)) (List.hd p).line
> 	     (check_possible "lock" k possible_lock other)) :: r
>       | (false,true) ->
> 	  let p =3D Hashtbl.find locked k in
> 	  (2,Printf.sprintf "%slock %s.%s declared in %s on line %d is locked i=
n %s on line %d, but is never initialized%s"
> 	     s t f file line (clean((List.hd p).file)) (List.hd p).line
> 	     (check_possible "init" k possible_init other)) :: r
>       | (false,false) ->
> 	  (3,Printf.sprintf "%slock %s.%s declared in %s on line %d is never lo=
cked or initialized%s%s"
> 	     s t f file line
> 	     (check_possible "init" k possible_init other)
> 	     (check_possible "lock" k possible_lock other)) :: r)


Can such a source code analysis approach be interpreted in the way
that internal data structures should be constructed for any special
knowledge representation from which final conclusions and advices
will be presented?

Regards,
Markus

