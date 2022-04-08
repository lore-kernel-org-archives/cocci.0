Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DA0C433EF
	for <cocci@archiver.kernel.org>; Fri,  8 Apr 2022 11:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=RNDVJhn7n6s9gOpcUjtyvA0Oxdr76JkCYrvaDuVWP3M=;
  b=m15BY0SLWnFJk7/D27aF4UaJzmibkHE0DG41F1E289tkBRG/IpIYSnu0
   z2zHDBP/O4UxWCFxSAqdE2fdr5vw4SbPDH0WSDgF69ogJsnTe76zCj6ay
   eswjW/LHzEZIdQ8p8fuKgZLip5mEFdB8itFzG6l/6gF4rOsKvjgiSRs7Z
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linbit-com.20210112.gappssmtp.com
X-IronPort-AV: E=Sophos;i="5.90,244,1643670000"; 
   d="scan'208";a="30782703"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Apr 2022 13:24:12 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 41B6AE0207; Fri,  8 Apr 2022 13:24:12 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AF525E0115
	for <cocci@sympa.inria.fr>; Fri,  8 Apr 2022 13:24:06 +0200 (CEST)
IronPort-SDR: la+H33CCwg5pO+sduEPVdfy7QrHVBIxOzMSovZwM6Aoewb+cKohc7co5BIMah0ZBP/P1cITwYj
 qUJ0K7hb+/HTJv1RzcLpe3YBbbB2cAo8qnNCLnQdbUCmeLafszz/Ai+nICPhHhdg9raxO4Rfw5
 9cbATPHR2QvHbnrBhKTM3vBMjvXWIIoVXlwwrYsboxwMR0GGkVSBi7HzwIa5ginw5ZrDsO5WbN
 Qev//kYYEOBK6CYKoOIjPg83cDNI05YT0lmwM+sA7HvAdZI59xFQ4u+ACOqoud2x8dZrnFA+lV
 R9BhXfyXdYIPkrIDRiU5shDo
X-IPAS-Result: =?us-ascii?q?A0A6AgCWGlBify7aVdFagQmEAoFVKwRPhFWvKwNUCwEDA?=
 =?us-ascii?q?QwBQwQBAYISgnWEbgIdBwEENBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBA?=
 =?us-ascii?q?QIEBAETAQENCwkHCAoCBQ4OBT5kaIFPgXQLNA2CNSKEBBEPAQ0BATg0AiYCN?=
 =?us-ascii?q?gEFAS8IAQEegmKDGgSiNoEEPYsygTGBAYIIAQEGglyDaYEeCQkBCH4sjnaCK?=
 =?us-ascii?q?YE8DIJHhR0rOIJNgmWbOjdysAaSdQeDTAWfZQYPBS6WRxSRdpZepmgCCgcGE?=
 =?us-ascii?q?COBVYF+cIM5TgECAQINAQICAwECAQIJAQECjikWg1CKYD80AjYCBgEKAQEDC?=
 =?us-ascii?q?YI6iWKCRwEB?=
IronPort-PHdr: A9a23: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
 ho3jAF/faIm8zK+uj8K
IronPort-Data: A9a23:R+SxS60sDsMWo5K5zfbD5fZ3kn2cJEfYwER7XKvMYLTBsI5bpzVWn
 GUbXTrUMq2MZGagKtlxYY2x9BgPvJbcm95jG1Q63Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOH9IQMcacUsxLbVYMpBwJ1FQyw4bVvqYy2YLjW1/V6
 YuryyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt8pw8
 fwViIfuczYOErX8uMdGQkhpCi4raMWq+JefSZS+mcmazkmDfnm1hvsyUgc5OooX/usxCmZLn
 RAaAGpVP1bT2qTsmeL9FrcEascLdKEHOKsUumth1i3eFfZgS5fOQ6DV7NtU0S0YgsFIF/fCI
 cEebFKDaTybO0IfYAlHV/rSms+M2lnfVAUbiGvKnvMJ0kz27RR4+v/iZY+9ltuiHJ0JxC50v
 Fnu9GPyCRAyL82a0TPD83S2h+aJkzmTZW4JPLix9/ovjV/Kg2JPVlsZUly0pfT/gUm7Mz5CF
 6AK0jAvlIFqyVf1dOjacwWIgF3fr08tQtUFRoXW9zqx4qbT5g+YAE0NQThAdMEquacKqdoCh
 g/hczTBVWwHjVGFdZ6O3uzL8m7qaED5OUdHNHBUF1JUizX2iNhr1kqnczp1LEKiYjTI9dzYx
 jmLqG0zhexWg5JVkaq8+l/DjnSnoZ2hou8JCuf/DjzNAuBRPtbNi2mUBb7zs6sowGGxEATpg
 ZT8s5LChN3i9LnU/MB3fM0DHauy+9GOOyDGjFhkEvEJrmrxqiTzIdAIv28lfS+F1/ronxe5M
 Cc/XisBtPdu0IeCMMebnqrtU5R7lPC+fTgbfqmMNIYVM/CdizNrDAk3PRLKt4wcuEcrlq47N
 P+mnTWEXB4n5VBc5GPuHY81iOd1rghnnDu7bcmik3yPjOTDDFbIFu9tGAbfNogRsfLfyC2Io
 oY3H5XQl313DralCgGJqt57ELz/BSJkbXwAg5cHKLDrz8sPMD1JNsI9Npt9I9c1wPkPzr6gE
 7PUchYw9WcTTEbvcW2iAk2Popu2NXqmhX5kbyEqI3iy3H0vPdSm4KsFLsNlebgh/u1/i/VzS
 qBdKcmHB/1OTBXB+igcNMGl9dE4Kkv32w/ebTC4ZDUffoJ7Q1Cb8NHTeAaypjIFCTC6tJdjr
 rD5jlHbTJMPSh5MFsHTbP7znVq9sWJEwLB2Xk3CI8UVc0LpqdA4Jyv0h/4xAscNNRSanmPDi
 lzIXktGqLCU8YEv8dTPiaSVlKuTErNzThhAAm3WzbeqLi2GrGCt9olNDbSTdjfHWWKopaiva
 LkHz/z4N/Fbzl9Gv5AmSORuxKM6otbt/vpUkloiE3LMYFCmTLhnJyDej8VIs6RMwJ5fuBe3C
 h3ToIgEYe3RNZO3CkMVKSokcv+HiaMelA7U4KlnO079/iJ2oOeKXBkAJRWKkyABfrJ5PJl/m
 rUksc8SrgG9018kbojAgSdT+GCBaHcHVvx/5J0dBYbqjCsty01DMcOAUH6ouMnXZoUeKFQuL
 x+VmLHG2+ZWyH3EfidhDnPKx+dc2ckDtR0iIIXu/LhVdgcpR8Pb3SG9NRwyRwVRixhFiqd9Z
 jYtOEpyKqGDuTxvgaCvmoxq9x5pXHWkFo7ZkjPlV1E1i2GsV2rHLXF7MuGIlKzc23wJZSBVp
 dl01068OQsHv6jNMu8aXU9jof3/C9d282UuXSxh89utR/EHXNYuvkNiiafkZfcq7QPdSXArf
 dVXwds=
IronPort-HdrOrdr: A9a23:X0/hgamz+JhPGwHLrrt2oFmhdHXpDfIb3DAbv31ZSRFFG/Fw5P
 re+8jzsiWE8gr5OUtQ4uxoXZPrfZqyz+8W3WB8B8baYOCEghrMEGgB1/qA/9SIIUSXnY5gPM
 9bEpSWY+eAdWSS4/yKhjVQX+xQpOVvM5rFuQ4d9RpQpM1RBJ2IJj0WNjqm
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,244,1643670000"; 
   d="scan'208";a="30782687"
X-MGA-submission: =?us-ascii?q?MDEuo3IzDdYlPJiI0bVwo/KW1WGH/Xd7YHf1Rd?=
 =?us-ascii?q?eqAqWHPaclyL/3XOzZOGaICpCx3eKw6cuxiqGY6l6cAgtBhprG2z/NCn?=
 =?us-ascii?q?Mz6PmX3GeeubAyz50gmOStmjQNKEX2lBNKj4aCMouPy8O6an563HtL1C?=
 =?us-ascii?q?k5JQpiG+pGttJD5qq6oBgvtA=3D=3D?=
Received: from mail-ej1-f46.google.com ([209.85.218.46])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 13:24:06 +0200
Received: by mail-ej1-f46.google.com with SMTP id bq8so16636602ejb.10
        for <cocci@inria.fr>; Fri, 08 Apr 2022 04:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=RNDVJhn7n6s9gOpcUjtyvA0Oxdr76JkCYrvaDuVWP3M=;
        b=w8AQ8IDEddT4Kp2GTX+AFywc0o7J3eDSM/vD2ZebS1B/4DHU4ChhU8XK+DeML1eX5U
         m2zkqDxjmh6P5sAPiY04LL90+Aln9erd/tWMmkKNtEhw2w5FerrmxMUGVAA7rBT/MZGL
         zF9f7GnUJOdDUn1KMDuZ6/n0KbRs+5h/mLRPsmlZWD4h9nLEe4/KzM4pShYGAtAg3unc
         S3deVqsx0tHL/LUE1PxMx6wC/h4D+g5EaWvS9apXpcQuVgK2pIzi+NP3jBuyfalS6uTG
         dR8q+i+gCWmsScTCFBqFUUSYJ7EsBVTbMv0ymbNc8brIK/AtTsStVBWVRU2ZOQTC4tdj
         fP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=RNDVJhn7n6s9gOpcUjtyvA0Oxdr76JkCYrvaDuVWP3M=;
        b=eluGP2G/pcCDZVFf+DIum5OvJa+onPkE6gPvxE8/nRh3wW8QFT+/1fC5Z//nDdMn7P
         FL+wQpyxkjZzbvYHY31RCahlDUOkEr9aCJ7y+sQyHcyjrbKJ1qz5WzCk5V0VmbkQ7WKo
         5W0vTEpDckCDC+/wf6P2Ys0G2lM6LkAfefZ2f79/lHumgYsc+lZYdb+kJ2UB7I7ahYdm
         x8xr96oAXVlqDWxYtg9wmu24EAWyts9r1cqO/yuvINX8QoDVuFB/HJb2alirhj0s5xUF
         TIhdUWlCk7ywClU/aV0LI1vwXz70/n3F/1s7ZGQu3VE5yNrLQfd2IF2ioDkaFIojX8BQ
         tnuw==
X-Gm-Message-State: AOAM530sDZ9H1GXixZdcn5OFIxbacSeJH6eDBtSOiqCj+XwzQdRN1awK
	3Fmp8QXQAG/wQHiJbvdBdS1U5PrqfUaAhLfG
X-Google-Smtp-Source: ABdhPJzvgifmGdP6QjPZRGuvSzrgNTgpEjNcwNrXwbcQk5r8OfYrxZI+vcAzB3uWc+7IFi7kCsMgZg==
X-Received: by 2002:a17:907:72c5:b0:6da:e99e:226c with SMTP id du5-20020a17090772c500b006dae99e226cmr18098565ejc.515.1649417045182;
        Fri, 08 Apr 2022 04:24:05 -0700 (PDT)
Received: from [192.168.178.55] (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id eq7-20020a056402298700b00419d8d46a8asm9972763edb.39.2022.04.08.04.24.04
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 04:24:04 -0700 (PDT)
Message-ID: <b59aa9b9-8caf-2256-8f1e-6404e56a6410@linbit.com>
Date: Fri, 8 Apr 2022 13:24:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: cocci@inria.fr
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [cocci] Matching a label after a return
Reply-To: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
X-Loop: cocci@inria.fr
X-Sequence: 359
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/b59aa9b9-8caf-2256-8f1e-6404e56a6410%40linbit.com>

Hi all,

Consider some function like this:

void test (int x)
{
   if (x)
       goto label;
   return;
label:
   do_something();
}


and the following coccinelle patch:


@@
identifier x;
identifier label;
@@
if (x)
    goto label;
...
- label:
-   do_something();


I would expect this to match the label, but it does not:


$ spatch --sp-file test.cocci test.c
init_defs_builtins: /usr/lib64/coccinelle/standard.h
HANDLING: test.c


Is this a bug or am I holding it wrong?
It does not appear to be directly related to the label itself, because


@@
identifier label;
@@
- label:
-   do_something();


gives the expected result.

$ spatch --version
spatch version 1.1.0-g69ea912-dirty compiled with OCaml version 4.12.0

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
