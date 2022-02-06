Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968DCC433F5
	for <cocci@archiver.kernel.org>; Sun,  6 Feb 2022 19:04:14 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,348,1635199200"; 
   d="scan'208";a="19951156"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2022 20:04:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A7A20E0384; Sun,  6 Feb 2022 20:04:12 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A6DB9E037F
	for <cocci@sympa.inria.fr>; Sun,  6 Feb 2022 20:04:07 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=efremov@linux.com; spf=Pass smtp.mailfrom=yefremov.denis@gmail.com; spf=None smtp.helo=postmaster@mail-lf1-f54.google.com
IronPort-SDR: BfORssDpidyH/LGkmic1EkL1t3TL/F9/DaTXzorApTwEmlPC4vbFN8+02xn//cDtTSQLfHBdC3
 WYjHYWyzNImpxq/VrNfGZdYIH5MjoXo71MtMs/pAkBuw/Iy5VNUwkPPwd8eIyjeYCoNYTr1xMK
 NwFV903iZ51fedzKzYu7kf9WvzQDYO0gdDvUXXiyiEVG3VeXNnHjDP8ewaDKMW9t/gERiMau33
 NY/WE9fPHpzShKdavKL1iS7C7tgj51Lwj1yf/uM9DmL2QPa84UZ5zIugthnG4sNqmrY1MPkZkP
 jF99vNpoPfTJzvI0TwJXoYUS
X-IPAS-Result: =?us-ascii?q?A0CJAQApGwBifzanVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VqCKIFVKwSFIY5xgXcuA55aAQMBCwEBQQQBAYhpAh0HAQQ0EwECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEDAQEFAQEBAgEBAgMEARMBAQ0LCQcICgIFDg4FYAFFZIFPgXcIA?=
 =?us-ascii?q?wE9gjUpAYNkAQUSEVYQCxgCAiYCAjQBBQEcBg0IAQEegmKDFwSfUYEEPYo4e?=
 =?us-ascii?q?oExgQGJfQkBCH4qjFCBYyccgg2BFSeDAz5phnQTglIElBEBgXA4QDqhFVyeC?=
 =?us-ascii?q?oNQhA2bPQYPBS6WKxSBJZAplkqmRwIKBwYQI4FVgX4zGggbFYMlTQECAQEBD?=
 =?us-ascii?q?QECAgECAQIBAgkBAQKcbz5rAgYLAQEDCZBPAQE?=
IronPort-PHdr: A9a23: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
 UNg/A==
IronPort-Data: A9a23:Es2OD6DsOo7idxVW/+flw5YqxClBgxIJ4kV8jS/XYbTApGwj32MAx
 2pNWW7UOPqIZzT9Kd1xbISy9xwFusKEyIJkOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6jMlkf5KkYAL+EnkZqTRMFWFx2XqPp8Zj2tQy2YLhXVvX0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYozmXx4FL6
 Olwj4KTEygCPZX+v6c0dyANRkmSPYUekFPGCX22sMjWy0OfNnWxn7NhC0Y5OYBe8eFyaY1M3
 aZAeXZdM1ba2b3wne7TpupE3qzPKOH6MY0Ft3Rn03fVAPAnWrjMRqzL4ZlT2zJYasVmRKePO
 pNANGcHgBLoOh1RCm00JcwHwfqsiVyicDp+8RWnqv9ii4TU5FUpjOKF3MDuUtiDWsxRmm6Kp
 2fM5W2/AxcANdXZxyDt2nmrjeTOtTjqXZobUry+7P9jxlOJrlH/EzUTXFq/5P230wuwBo4ZJ
 EsT9S4j66M18SRHU+URQTW0vibVhD4gZuBOMLcVwwK1+I2XyiKgUz1soiF6VPQqs8o/RDoP3
 1CPns/0CTEHjFFzYSLNnltzhWPjURX5PVPudgdfElRYu4iLTJUby0OQHow6QcZZm/WsQWmoq
 w1muhTSkFn6sCLm/6Cy/FSChzz145aUEkg64QLYWm/j5QR8DGJEW2BKwQiKhRqjBNzCJrVkg
 JTis5bDhAzpJc/S/BFhuM1XQNmUCw+taVUwe2JHEZg77CiK8HW+Z41W6zwWDB43bp1VKG61O
 BeN6Fo5CHpv0J2CPf8fj2WZW5VC8EQcPYmNug38MoAXOcAoLGdrAgk0PR7IhwgBb3TAYYlmY
 cvBGSpdJXkdDqtjwVKLqxQ1gNcWKtQF7TqLH/jTlkz5uZLHPSb9Ye5cbDOmM75khIvZ/1292
 4sOb6OilkQEOMWjM3m/2dBIdjgicyNrba0aXuQNKYZv1CI9SD9/YxIQqJt9E7FYc1N9zLuRr
 irjCxMHlDISRxTvcG23V5yqU5u3Nb4XkJ7xFXVE0Y+A1ydxbICxwr0YcpdrL7Ar+PYyn/FxR
 vgBPc6HB60XGDjA/j0ca7j7rZBjJEz731LQY3L9bWhtZYNkSizI5sTgIVni+SwIOSy96pkzr
 rim4QXETMdRXA9lFsvXNKmiwgrp73gQke5/RWXSJdxXdBm++YRmMX2jiv4xPtFKIhLGn2PI2
 wGTCBYehO/Mv45qr4GU3/Ha99+kSrIsEFBbEm/X6aeNGRPbpmfzk5VdVOuofCzGUDqsqq+sU
 v1PyPTnKPMKwQRRuI1mHrc0nK9nv4nzp6VXxxhPFWnQawj5EatpJ3SL0JUdtqBJwbMF6wK6V
 ljVoYtfMLSNfcfrSRsfeVZjYeOE2vUZ3DLV6K1tckn94SZ2+puBUFlTb0bQ0n0DdOMtPdN32
 /olte4X9xe71kggPOGAg30G7G+LNHEBD/gqu81IGoPtkQZ3mFhObYaGUX3z6ZCLLtFCawwkf
 2PSi63FiLBRgEHFdiNrR3TK2ONcg7UIuQxLnABefQXXwoKdi69lxgBV/BQ2Uh9RkkdN3dV1N
 zU5LEZyP6iPo2plicUrs7pAwO2d6M91O3AdymflUEXcRkisE2jDdSgzZLrL80ce/GZRODNc+
 dl0DYojvSnCJKnMMukaACaJaMAPifR+8wTDnIasGMHt81wSf2/+mqH3DYYXg0KPPC7y7XErY
 cFu/eBteevwMit4T2jXzWWF/ex4dS1o71CujR2sEG3l0I0clPyPNeCyFn2M
IronPort-HdrOrdr: A9a23:gESPuaChi5AISuHlHemP55DYdb4zR+YMi2TDGXoBMCC9Afbo8P
 xG+85rqSMc6QxhJU3I9urwW5VoLUmsjqKdpLNhR4tKPzOW2ldATrsD0WKK+VSJcEzDH6xmpN
 9dmsBFZuEYZmIK6foSjjPIderIjOP3lZxARt2y856ud2tXgm1bgzuRwzz1LnFL
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,348,1635199200"; 
   d="scan'208";a="19951155"
X-MGA-submission: =?us-ascii?q?MDEqhtngOGVzXp4lN5tvDMVSIuUsDD11thkAh8?=
 =?us-ascii?q?69k1rqpVohWmSfcSkc8pbGn6WCIF3LcNGPO0YXM8U4RidXVmpr/kczpo?=
 =?us-ascii?q?o6/XKlfq/METxNzwdkJjmo+T4CuxVb/1DMeb+FfD2oBhAv+3LU+mj8Ll?=
 =?us-ascii?q?smm1Q8lWHVNga8f+2dcRDIcg=3D=3D?=
Received: from mail-lf1-f54.google.com ([209.85.167.54])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 20:04:06 +0100
Received: by mail-lf1-f54.google.com with SMTP id z19so22868107lfq.13;
        Sun, 06 Feb 2022 11:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vkw2vrLP4cH3oSH9gelJPDVSAM8xsKYFkVn8SxM/ih0=;
        b=IskgYgRuu20bE9yGNns30oM1IT1v3SxX665j7yKGWjcOXHt0kgmGxihbxU56pDBg7U
         qS7ayOhVy4Qkz3O8rj5e3DfafX4kHtblfMunM03PXln2C8RqZGTxJNUE1FO/npJdu3Ov
         /lq2OhNMfxdzHNMorzCpT9VBhd06/IHu+b3+r5TqY3VpGhDq+6kfUlTdDzOMdUu5X4bu
         Dz+M4SfzAm5VaDsTv/ClSiyHXUOglBpPjqvF9bX7syAiCjEE/tD/6xZgYkCNp2kkYJvA
         F8nfPQgTYdDZDkRkcZcNdPibKYmJfzNluWuGe/4JDiNRQwfdokY9fmNNr5SQXGS/E9cX
         YjSA==
X-Gm-Message-State: AOAM530JpVcqLy/grKc/0zlZ9nlLQrUHyGIbdq7UktZPxVPb+Z3k2PvX
	9MdaNpjmdzWETsVEFdLljLPEtTVNXIo=
X-Google-Smtp-Source: ABdhPJzm588l6AtXUoaxLmpCvjd9jfX/P0uwXJxLMFkG/WkUePfsAgHGqzl3lXPIm/niwOHUwaiYIw==
X-Received: by 2002:a19:4f4a:: with SMTP id a10mr5970780lfk.397.1644174245167;
        Sun, 06 Feb 2022 11:04:05 -0800 (PST)
Received: from [10.68.32.40] (broadband-109-173-81-86.ip.moscow.rt.ru. [109.173.81.86])
        by smtp.gmail.com with ESMTPSA id p9sm1190413lfo.290.2022.02.06.11.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 11:04:04 -0800 (PST)
Message-ID: <f07ed61b-96e5-d99f-dc0f-d3f39b8291bf@linux.com>
Date: Sun, 6 Feb 2022 22:04:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <cd9a37f0-9a90-1df5-cec7-853a783e5538@linux.com>
 <alpine.DEB.2.22.394.2202061941500.3126@hadrien>
From: Denis Efremov <efremov@linux.com>
In-Reply-To: <alpine.DEB.2.22.394.2202061941500.3126@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] spatch 1.1.1 segmentation fault report
Reply-To: Denis Efremov <efremov@linux.com>
X-Loop: cocci@inria.fr
X-Sequence: 125
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-02/f07ed61b-96e5-d99f-dc0f-d3f39b8291bf%40linux.com>



On 2/6/22 21:43, Julia Lawall wrote:
> 
> 
> On Sun, 6 Feb 2022, Denis Efremov wrote:
> 
>> Hi,
>>
>> I'm observing a weird crash with spatch 1.1.1
>>
>> $ spatch --version
>> spatch version 1.1.1 compiled with OCaml version 4.11.2
>> Flags passed to the configure script: --enable-opt --enable-ocaml --enable-python --enable-pcre-syntax --enable-pcre --prefix /home/work/.opam/4.11.2 --libdir /home/work/.opam/4.11.2/lib
>> OCaml scripting support: yes
>> Python scripting support: yes
>> Syntax of regular expressions: PCRE
>>
>> $ cat segfault.cocci
>> @err@
>> position p;
>> @@
>>
>> amd_energy_is_visible(...)
>> {
>> *       return 0444;@p
>> }
>>
>> @script:python@
>> p << err.p;
>> @@
>>
>> coccilib.report.print_report(p[0], "found")
>>
>> $ mkdir empty_dir # creating empty directory
>> $ spatch segfault.cocci empty_dir
>> init_defs_builtins: /home/work/.opam/4.11.2/lib/coccinelle/standard.h
>> 0 files match
>> [1]    152475 segmentation fault (core dumped)  spatch segfault.cocci test
> 
> I tried 1.1.1 with the options --enable-opt --enable-ocaml --enable-python
> --enable-pcre-syntax --enable-pcre, but it seems to work find for me.
> Does the problem go away if there is a file in the directory?  If you
> remove the python code?

It doesn't crash if I run it on the linux kernel sources on commits prior to
9049572fb145 hwmon: Remove amd_energy driver


$ git checkout 9049572fb145~
# there is amd_energy_is_visible in drivers/hwmon/amd_energy.c
# spatch doesn't crash on this commit

$ git checkout 9049572fb145
# no amd_energy_is_visible in kernel source
# spatch crashes

If I remove python code then spatch doesn't crash.

$ python --version
Python 3.10.2

Thanks,
Denis
