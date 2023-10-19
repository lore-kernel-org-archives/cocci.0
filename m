Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E200CDB47E
	for <cocci@archiver.kernel.org>; Fri, 20 Oct 2023 07:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:date:message-id:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=hY7tAoUuXPxBj32A1zZVPCrPDprjoEYqeAV9cIhRL6A=;
  b=uCbBHF5FVJkSqKLKPqsKgA3GJ45ZbtQrj/PUiMq+VaqzwZBDHIbcX2vA
   IiAzTWokF6v/lXxN1mwl1UeKYgZ+/js4Rx6KpJ0ZpigNaYs5Ebqm3f7Ei
   QKd7KoJ4Agz8hek1ifzUfSzZ9IgxAlvtvY/DiIaiYwblRtf38za7dVVfz
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@swedishembedded-com.20230601.gappssmtp.com
X-IronPort-AV: E=Sophos;i="6.03,238,1694728800"; 
   d="scan'208,217";a="132266431"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Oct 2023 09:53:30 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D9433E0CDD; Fri, 20 Oct 2023 09:53:29 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2E6F4E00B7
	for <cocci@sympa.inria.fr>; Fri, 20 Oct 2023 00:01:13 +0200 (CEST)
IronPort-SDR: 6531a727_N0goI8R854C6Z/SDuZJfHbSfq/42V+4laAtmQpBqn8GDS/d
 YMnkWpu6x40f3PdCGs+g9JeJmQPC50cqRafP6ZA==
X-IPAS-Result: =?us-ascii?q?A0F5RADjpTFlfzLQVdFSCBoBAQEBATwBAQEBAgIBAQEBA?=
 =?us-ascii?q?gEBAQEDAQEBAYFmgU8CAWV6VTEEC0iEU4EjgiyLbYIjly+HdAMYFigPAQMBD?=
 =?us-ascii?q?RQCAQIOFgcEAQEDAQOEf4cYAh4HAQQ0EwECBAEBAQEDAgMBAQEBAQEDAQEFA?=
 =?us-ascii?q?QEBAgEBAgQFAQIQAQEiGQcODimFaA2CNyQZImpLFAk1AQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBARQCCAUZEjE4ER0BATglNwIkEgEFAVeCXAGCXgMRp1iBBUKLO?=
 =?us-ascii?q?4EygQGCCQEBBoEHsFCBHgMGFIEcFgIBAQGIBwGBTgEBhlNpgSEbgg2BS4JEg?=
 =?us-ascii?q?1ACgTlUgy6CaIMJbYJCgnkFAoF1hDeFGYV9JikEBwdHRxhYGwMHA4EDECsHB?=
 =?us-ascii?q?DIiBgkWLSUGUQQtJAkTEj4Ec4JFCoEGPw8OEYJDYTYZS4FffAkVBgE6TXYQK?=
 =?us-ascii?q?gQUF4EJCG4fFR43ERIXDQMIdh0CESM8AwUDBDQKFQ0LIQUUQwNHBkoLAwIcB?=
 =?us-ascii?q?QMDBIE2BQ0eAhAuKQMDGU0CEBQDOwMDBgMLMQMwV0cMWQNVGh82CTwPDDMBA?=
 =?us-ascii?q?gEdJh1AAwtiCz01FBtNnSMDbYM7IQc/URUqsVeUaYQWBS8Ii0WVITOpapg8i?=
 =?us-ascii?q?wmCXIZ2k2QQI4FXI4FcMyIbFWwGgjBPAxkPkhiPe0IyAjkCBwEKAQEDCYI5h?=
 =?us-ascii?q?A+CWoIpAQE?=
IronPort-PHdr: A9a23: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
 xs8hwdybOhr/zDpsQ5fGw==
IronPort-Data: A9a23:ndcY96l31QZNku28Tv7EPnzo5gwjIkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIbXjvTPKqDZWvyKt0gaI++oExXv8SBxtBnTQs5r3g9F1tH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvymTrSs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82Ayajl8B56r8ks1562q4WJA5DTSWNgS1LPgvylNZH4gDfrpR5fIatE8NvK3Q
 e/F0Ia48gvxl/v6Io7Nfh7TKyXmc5aKVeS8oiI+t5uK3nCukhcPPpMTb5LwX6v4ZwKhxLidw
 P0V3XC5pJxA0qfkwIzxWDEAe81y0DEvFBYq7hFTvOTKp3AqfUcAzN1xNkBnZagh+d1cIm1X6
 vgbczAnQRmM0rfeLLKTEoGAh+wmJcjveY4T4zRukGmfAvEhTpTOBa7N4Le03h9q3pEITauYP
 ZJJL2c3BPjDS0Un1lM/CZQwm8+zmXTzciZYpVefqKY77mSVxwt0uFToGISEIIfUH50O9qqej
 ljY/j3CLgM3D/6gyxm/02Lzh9/NwDyuDer+E5XhrqIw6LGJ/UQYDxYdVHOgsPyhgwi/XcheI
 goa4EITQbMa8UWqSpzwU0T9riPc+BEbXNVUHqsx7wTlJrfoDxixGVIFH2ZkUd8dn+w6XCMu1
 QSJtfzgCmk62FGKck61+rCRpDK0HCEaK24eeCMJJTfpBfGz8OnfaTqfHr5e/L6JYs7dQm6vn
 mjbxMQqr/BC0p5RjvTTEUXv2mr0/vD0ohgJChI7t19JAyt8bY+hIoGksB3VsK4GI4GeQV2M+
 nMDnqByDdzi77ncz0Rho81XRNlFAspp1hWC3DaD+LF/qlyQF4aLJ9w43d2HDB4B3jw4UTHoe
 lTPngha+YVeOnCnBYcuPdPuVJhyl/O/TYi9PhwxUjaoSsghHONg1HE+DXN8I0iw+KTRufhga
 MvGLpbE4YgyU/k+nGHeqxghPU8Dn3hinws/tLj0yBOo1bf2WZJmYeZtDbd6VchgtPnsiFyNr
 b53bpLWoz0BCrGWSneMquY7cwtaRUXX8Lis9KS7gMbYclQ4cIzgYteNqY4cl3tNz/gOyLuUp
 ynlMqKaoXKm7UD6xcyxQigLQNvSsVxX9BrX5AR1ZQ7yiUswK52i9rkefJYRdLwqvr4rh/1tQ
 vVPP43KDv1TQ36Vs34QfLvsnrxELR6LvAOpOzb6QT4de5U7eRfF1OW5dSTS9Q4PLBGNi+0An
 5Oa2Dj2f78/ViV5LcOPaPuQ31K75nccv+RpXnr3GNpYeWSy0Y0zKyXOkeMFHPgcDSrynx6xi
 gCcW0Yer8bwvr5vocXohL+FnaitAeBRDkpXJEiFzLeUZA3x3Huv/p9Ea8mMJQvibWLT/L6wQ
 Mlk1NT+DaE3p0lLuI9CDLpb96IyyN/xrbt8zA4/PnH0Q3m0K7FneF+q4NJus/BT+7pnpgeGY
 EKD1d1EM7GvOsm+MlowJhIgX9uTx8MvhTjewvQkEnrUvBYt0uK8bnxTGB2QhAh2Drh/atoly
 Nh8nv8m0VW0jx5yP+uWiixRyX+3EUUBdKcarbAfPp7gj1s661NFYKGEMBTM3rO0V4xuPHUpc
 xiuv4iTo5RHx0HHTWg/KmiV48pZmqY1mU5ryH0sGg23v+Tr19EL2C9fyzAVdjhu7w5m1rtzM
 1d7NkcuKqSp+Sxptfd5XGutOl9gAjvCyHPL01BTlGnTcGusZEP3KF8WZOSHphgY10l+fTFr2
 q6S50i4cDTtfeD3hjATX2w8odPdbNVBzC/ws+H5INakRbwUOSHEhI2qbko28yrXO9s73hD7l
 LM77dROZr3eHg9Oha8CUq2x96kaETKAL0x8GcBRxrsDRzzgSWvjyAq1Ch6Df+1WLKb36m6+M
 ctlI/xPWzmY1CqjqjM6B7YGE4RrncwGtcYzRbf2GVEo67evjCJlkJb1xBjMgGUGR9ZPk8FkD
 qjzczmEMHKbhFoKumvrgfRHBFGFYog/VFWh5Ny2zeQHLIJckedOdUpp7KC4kU/IOyRa/jWVn
 jj5WYno88JYx79BpbDcSpd4O13sKPfYdvi5zwSogtEfMfLNKZjvsi0WmHnGPiNXH6kdAep0n
 ISrt+zIhUL3g4w1YV/ghqjbRrVo5NqzbsVTIMnYPHlXpgrcec7Osj8o2XG0FoxNq/xZvvKYf
 gqfbNChU9w/V/N25mxnWwIHHzkzU63IP7rd/wWjpPGyOz0h+A3gLuL/00T2bGteJxQ6C7enB
 iDa4/+Rt81l9qJSDxo5BtZjMZ9yAHnnfYAEL9TRlz2pPlOEs2O4mInJtEQfsGnQK3y+DszFz
 4rPRUH+eDSMqaj49oxlnLIojCIHLkRWoLcWRV0cye5UmjrhLW8hLMYhC7skJKxQsBTP0MDfW
 GmQQkokUCnzZGERO1G0qtHuRRyWCeEyK8/0bG5htV+dbyCtQpiMGv19/yNn+G17YSbn0PrhE
 9wF53nsJVKk9/mFnwrICiCT2o+LB882x07kPWj4ms32RhsSWPAEiSQnEw1KWijKVcrKkS0n4
 ITzqX9sGCmGpYzZSK6MuEK53DkCoz7jzi4oYCKFzdrTtondx+pFoBE6E/+myaUNNazmO5ZXL
 U4ahAKxD6S+wWMetaoyu98si6J4Bf+HWMO9KccPgOHUc76YsgwaAi/JocbDoAzONuKS/5MxW
 wRAO0QDOXk=
IronPort-HdrOrdr: A9a23:fpd/SqmOOwNU3+OAuChLmwmUGG7pDfIh3DAbv31ZSRFFG/Fw9v
 re+8jzsCWftN9/YgBCpTntAsm9qBDnlKKdg7NhX4tKNTOO0ACVxepZnO7fKlPbaknDHy1muZ
 uIsZISNDQ9NzdHZA/BjjWFLw==
X-Talos-CUID: 9a23:HTj6AGxNMb72DghZNm4+BgULIMF0Kljkz0z7AEOhFmJqE72/ZlafrfY=
X-Talos-MUID: 9a23:ZhgDDAVyVcB7wzfq/AXyhWhZGNVF2IaRCmM3sIVZuvmGaDMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,238,1694728800"; 
   d="scan'208,217";a="69236203"
X-MGA-submission: =?us-ascii?q?MDEfAQE332WOUobBPDSM/VYhxwOAMixQhIzev5?=
 =?us-ascii?q?1pfeFx+lPgG1UyfRsiuhB5T6KNMgyNa+J2qseWirvzdbmzcsprz5YRN+?=
 =?us-ascii?q?k8Kc4ueX18If0+P+WqBdqB1fwp5rfuD5jVQxemltL7NixIl5uTCQNhgi?=
 =?us-ascii?q?QOJ56ZmhCKGwItH7mBuPyv4w=3D=3D?=
Received: from mail-ed1-f50.google.com ([209.85.208.50])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 00:01:11 +0200
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so139844a12.2
        for <cocci@inria.fr>; Thu, 19 Oct 2023 15:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swedishembedded-com.20230601.gappssmtp.com; s=20230601; t=1697752870; x=1698357670; darn=inria.fr;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hY7tAoUuXPxBj32A1zZVPCrPDprjoEYqeAV9cIhRL6A=;
        b=EXnqMlcxh78adlFodZ7zjMg2FflVszEKJL8tBDzH69cR+f2tFRTkqv6g2tvII8XVL8
         on8uZ5exHx1xAknE5wSIU7erd1Ay9PkdWSr6u6wMjp0WLjsug0wJggzi0uEcDORgTWaG
         +YbhQQRAGoaAWx9gxYOB3B5NPCrd8K+qyx8MC4jaOzRcF18VGiO7zhmU7FFsz8oCFvHr
         0cJjIDNBJ1UDtXRvc2nx5YyiBL1BCf2yKzzlBCeiUS8NPEtEaB9a+/OxL9LmG5e0yylC
         Cws8wrIDqGYtSOBUGv9fn8vXyPCgRsqHw+zd762EtbEm0JxR4fpvruFr1jqQVdNEDmbU
         47MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697752870; x=1698357670;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hY7tAoUuXPxBj32A1zZVPCrPDprjoEYqeAV9cIhRL6A=;
        b=H0wxgtwhWsii1Q3/RkIkttW/HSfYOiepi8a+ZGKVGZF/WD3OvqJtPMCVM6TpVV45NK
         4KKtamGr4I7Z8Vyy6y8BnVn/rae7DseDS1ONnaZgN979ffN836i9zYEn4RgVoCgDTCCn
         QVNuBiXS2P4eF8N/Qez/Xng4SRCv3zKr7kwDIRbgY+Rx/vhrPDuliSKSmOviZeWUfhkC
         c1+LrVVHChPQCQXGqOlPy4ua3lUYkjROHweQRccRleT1KMFL2dnevmkd4NT3FBIDXRHV
         veuuRXL+gctmgr1On+oB+BH0FuJBNZXB8YiTAo90wO3gMKrNqAHx6b10ywjztF5ePz7Z
         qsDw==
X-Gm-Message-State: AOJu0YyFvwhwByplg4Lna5xtRNLD4sXrC3Jaca6nos2SnwQWciVSytUh
	vz52KoUDZp2hSvFbt30JrqQD1T97URIqDIt7jiy87gpIO5WKMvqta3o=
X-Google-Smtp-Source: AGHT+IEKwyOfKAHXKU1sE1Y3i2tJvjOISd5bpEAP8sjddlxgUbKQ29xRK8rFa+rL4gnxkpWbB3mCOz7N6Q4oM2BNnMQ=
X-Received: by 2002:a17:907:983:b0:9c4:344e:b48c with SMTP id
 bf3-20020a170907098300b009c4344eb48cmr2749888ejc.36.1697752869153; Thu, 19
 Oct 2023 15:01:09 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Martin_Schr=C3=B6der?= <info@swedishembedded.com>
Date: Fri, 20 Oct 2023 00:00:57 +0200
Message-ID: <CAEqMKof5Ke4yV0KBZm2FW8z-Ct1UHZRDz5=Sd3gaO3a-f4+y_w@mail.gmail.com>
To: cocci@inria.fr
Content-Type: multipart/alternative; boundary="000000000000aec03d060818e4d7"
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] Finding functions that do not unlock mutex in the same
 function
Reply-To: =?UTF-8?Q?Martin_Schr=C3=B6der?= <info@swedishembedded.com>
X-Loop: cocci@inria.fr
X-Sequence: 1263
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/CAEqMKof5Ke4yV0KBZm2FW8z-Ct1UHZRDz5%3DSd3gaO3a-f4%2By_w%40mail.gmail.com>

--000000000000aec03d060818e4d7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

How can I adjust the following code to find all cases where a function
locks a mutex but does not call unlock in the same function:

```
virtual report
virtual patch

@ r exists @
identifier f;
expression l;
expression r, e;
position p;
@@
f@p(...){
... when !=3D k_mutex_lock(...)
r =3D k_mutex_lock(l, ...)
... when !=3D e =3D r
if(e){
... when !=3D k_mutex_unlock(l)
    when any
    when strict
when exists
}
(
return ...;
)
}

@ script:python depends on r@
p << r.p;
f << r.f;
@@

// This Python script runs if a locked mutex is not unlocked in all code
paths.
msg =3D "In function '%s', there's a path without unlocking the mutex. Ensu=
re
that the mutex is always unlocked before returning or exiting the
function." % f
coccilib.report.print_report(p[0], msg)
```
It catches some cases but I'm still not able to make it catch everything
but the first error checking if statement:

```
int invalid_a(int a1, int a2){
int r =3D k_mutex_lock(mutex, K_MSEC(200));
if(0 !=3D r){
return 0;
}
if(1){
return 1;
}
return 0;
}

int invalid_b(int a1, int a2){
int r =3D k_mutex_lock(mutex, K_MSEC(200));
if(0 !=3D r){
return 0;
}
return 0;
}


int valid_b(int a1, int a2){
int r =3D k_mutex_lock(mutex, K_MSEC(200));
if(0 !=3D r){
return 0;
}
k_mutex_unlock(&mutex);
return 0;
}

int invalid_c(int a1, int a2){
int r =3D k_mutex_lock(mutex, K_MSEC(200));
int b =3D foo;
if(0 !=3D r){
return 0;
}
if(0 !=3D b){
return 0;
}
k_mutex_unlock(&mutex);
return 0;
}
```

Result:
tests/coccinelle/mutex_lock_unlock.c:1:4-13: In function 'invalid_a',
there's a path without unlocking the mutex. Ensure that the mutex is always
unlocked before returning or exiting the function.
tests/coccinelle/mutex_lock_unlock.c:12:4-13: In function 'invalid_b',
there's a path without unlocking the mutex. Ensure that the mutex is always
unlocked before returning or exiting the function.

Invalid_c is not detected.

--=20
Best regards,

Martin Schr=C3=B6der
*Embedded Firmware Consultant*
Connect on LinkedIn <https://www.linkedin.com/in/martinschroder/>
*Book online meeting <https://calendly.com/martinschroder/call>*

Swedish Embedded Consulting Group AB
W. https://swedishembedded.com

--000000000000aec03d060818e4d7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">How can I adjust the following code to find all cases wher=
e a function locks a mutex but does not call unlock in the same function:<b=
r><br>```<br><font face=3D"monospace">virtual report<br>virtual patch<br><b=
r>@ r exists @<br>identifier f;<br>expression l;<br>expression r, e;<br>pos=
ition p;<br>@@<br>f@p(...){<br>... when !=3D k_mutex_lock(...)<br>r =3D k_m=
utex_lock(l, ...)<br>... when !=3D e =3D r<br>if(e){<br>... when !=3D k_mut=
ex_unlock(l)<br>=C2=A0 =C2=A0 when any<br>=C2=A0 =C2=A0 when strict<br>	whe=
n exists<br>}<br>(<br>return ...;<br>)<br>}<br><br>@ script:python depends =
on r@<br>p &lt;&lt; r.p;<br>f &lt;&lt; r.f;<br>@@<br><br>// This Python scr=
ipt runs if a locked mutex is not unlocked in all code paths.<br>msg =3D &q=
uot;In function &#39;%s&#39;, there&#39;s a path without unlocking the mute=
x. Ensure that the mutex is always unlocked before returning or exiting the=
 function.&quot; % f<br>coccilib.report.print_report(p[0], msg)</font><br>`=
``<br>It catches some cases but I&#39;m still not able to make it catch eve=
rything but the first error checking if statement:<br><br>```<br>i<font fac=
e=3D"monospace">nt invalid_a(int a1, int a2){<br>	int r =3D k_mutex_lock(mu=
tex, K_MSEC(200));<br>	if(0 !=3D r){<br>		return 0;<br>	}<br>	if(1){<br>		r=
eturn 1;<br>	}<br>	return 0;<br>}<br><br>int invalid_b(int a1, int a2){<br>=
	int r =3D k_mutex_lock(mutex, K_MSEC(200));<br>	if(0 !=3D r){<br>		return =
0;<br>	}<br>	return 0;<br>}<br><br><br>int valid_b(int a1, int a2){<br>	int=
 r =3D k_mutex_lock(mutex, K_MSEC(200));<br>	if(0 !=3D r){<br>		return 0;<b=
r>	}<br>	k_mutex_unlock(&amp;mutex);<br>	return 0;<br>}<br><br>int invalid_=
c(int a1, int a2){<br>	int r =3D k_mutex_lock(mutex, K_MSEC(200));<br>	int =
b =3D foo;<br>	if(0 !=3D r){<br>		return 0;<br>	}<br>	if(0 !=3D b){<br>		re=
turn 0;<br>	}<br>	k_mutex_unlock(&amp;mutex);<br>	return 0;<br>}</font><br>=
```<br><br>Result:<br>tests/coccinelle/mutex_lock_unlock.c:1:4-13: In funct=
ion &#39;invalid_a&#39;, there&#39;s a path without unlocking the mutex. En=
sure that the mutex is always unlocked before returning or exiting the func=
tion.<br>tests/coccinelle/mutex_lock_unlock.c:12:4-13: In function &#39;inv=
alid_b&#39;, there&#39;s a path without unlocking the mutex. Ensure that th=
e mutex is always unlocked before returning or exiting the function.<br><br=
>Invalid_c is not detected. <br><div><br></div><span class=3D"gmail_signatu=
re_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature" data-sm=
artmail=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"l=
tr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><di=
v dir=3D"ltr"><div>Best regards,<br><br><font face=3D"arial narrow, sans-se=
rif"><img src=3D"https://ci3.googleusercontent.com/mail-sig/AIorK4wH6aPZe4e=
YWheYhio282OdbmPN-eMyvcew6PbeQLd1K_qGuSNTnBuq0VT6bSD79PDVrzgSr5c" width=3D"=
74" height=3D"96"></font></div><div><font face=3D"arial narrow, sans-serif"=
>Martin Schr=C3=B6der</font></div><div><i><font face=3D"arial narrow, sans-=
serif">Embedded Firmware Consultant</font></i></div><div><span style=3D"fon=
t-family:&quot;arial narrow&quot;,sans-serif;font-style:italic"><a href=3D"=
https://www.linkedin.com/in/martinschroder/" target=3D"_blank">Connect on L=
inkedIn</a></span></div><div><i><a href=3D"https://calendly.com/martinschro=
der/call" target=3D"_blank">Book online meeting</a></i></div><div><span sty=
le=3D"font-family:&quot;arial narrow&quot;,sans-serif;font-style:italic"><b=
r></span></div><div><font face=3D"arial narrow, sans-serif">Swedish Embedde=
d Consulting Group AB</font></div><div><font face=3D"arial narrow, sans-ser=
if">W. <a href=3D"https://swedishembedded.com" target=3D"_blank">https://sw=
edishembedded.com</a></font></div><div><font face=3D"arial narrow, sans-ser=
if"><br></font></div><div><br></div></div></div></div></div></div></div></d=
iv></div></div></div>

--000000000000aec03d060818e4d7--
