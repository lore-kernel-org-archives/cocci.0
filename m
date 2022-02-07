Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA02C433EF
	for <cocci@archiver.kernel.org>; Mon,  7 Feb 2022 07:17:16 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="19988187"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Feb 2022 08:17:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A5456E0382; Mon,  7 Feb 2022 08:17:13 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B546BE037F
	for <cocci@sympa.inria.fr>; Mon,  7 Feb 2022 08:17:08 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=efremov@linux.com; spf=Pass smtp.mailfrom=yefremov.denis@gmail.com; spf=None smtp.helo=postmaster@mail-lf1-f51.google.com
IronPort-SDR: +ggdbxhUZA3Tr5dMM2qGXTrOf8x+FG1amTGerY/7kckQgoJlowWXe/AzlN3phY3wdMGiXkTjWU
 NQq8+l/wRRtCYnLzeNxoiUF7ViI9mKkGxbLdexA4mFEZUAORdcuumTk8GL8uFm3mZ7SAVKIB/Y
 8AF7H/RO+JQvr6kFH89jtCx0nwDnnEg/cNk5JDtgv4MfyxC4jm7Fr8tByqZCE9jD2YetQZ6Rgc
 AM3YH/praWcIs8s/8bJCLzwoJf1X2dtDXXx7eKrtBIcOjs+MZ+WDhQQpNSMlxLs4faU7DVu22f
 NRw9yYu/o0LabFvKGVBIc0CD
X-IPAS-Result: =?us-ascii?q?A0BKAwDyxgBifzOnVdFagQmEAn5XKwRNhFSOcYF3LgOeW?=
 =?us-ascii?q?gEDAQsBATUMBAEBiGkCHQcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECA?=
 =?us-ascii?q?QECAwQBEwEBDQsJBwgKBw4OBWABRWSBT4F3CAMBMA2CNSkBg2MBAQEBAgESE?=
 =?us-ascii?q?VYQCxQEAgImAgI0AQUBHAYNBgIBAR6CYgGCdSEEC58zgQQ9ijh6gTGBAYl9C?=
 =?us-ascii?q?QEIfiqOMyccgg2BPIJMNz5pZ4YNE4JSBJMDWTYrGgh5KgwtIVihFVyeCoNQh?=
 =?us-ascii?q?A2GdY1aCYZlBg8FLoU+kG0UgSWQKZZKjRKUVYRgAgoHBhAjgVWBfjMaCBsVg?=
 =?us-ascii?q?yQJRQECAQEBDQECAgECAQIBAgkBAQKTTIJihkE+MzgCBgsBAQMJkE8BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:u0vl6qDv7Sx+DRVW/+rlw5YqxClBgxIJ4kV8jS/XYbTApG9x3zVUy
 mQZDW2COf+CamfzeNFyOoS1/UoE6J6HyYVlOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6jMlkf5KkYAL+EnkZqTRMFWFx2XqPp8Zj2tQy2YLhXFvU0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYozKvxJNv0
 Y5tjoCPawMkH7TFu/wlUBYNRkmSPYUekFPGCX22sMjWy0OfNnWxmrNhC0Y5OYBe8eFyaY1M3
 aZAeXZdM1ba2b3wnevTpupE3qzPKOH6MY0Ft3Rn03fVAPAnWrjMRqzL4ZlT2zJYasVmRKePN
 5pANmUHgBLoQjRkJhAlEYkFmti2pyTlVCRTpVyyuv9ii4TU5FUpjOKF3MDuUtiDWsxRmm6Kp
 2fM5W2/AxcANdXZxyDt2nmrjeTOtTjqXZobUry+7P9jxlOJrlH/EzUTXFq/5P230wuwBosZJ
 EsT9S4j66M18SRHU+URQTW/hiXHoAdHe+FMLM8+5SCUw4nM2wWWUz1soiF6VPQqs8o/RDoP3
 1CPns/0CTEHjFFzYSLNnltzhWPjURX5PVPudgdfElRYu4iLTJUby0OQHow6QcZZm/WsQWmoq
 w1muhTSkFn6sCLm/6Cy/FSChzz145aUF0g64QLYWm/j5QR8DGJEW2BKwQmChRqjBNzCJrVkg
 JTis5bChAzpJc/S/BFhuM1XQNmUCw+taVUwe2JHEZg77CiK8HW+Z41W6zwWDB43bppdKW64O
 B+N41g5CHpv0J2CPf8fj2WZW5VC8EQcPYmNug38MoAXOcAoLGdrAgk0PRDNgAgBb3TAYYlmY
 cvBGSpdJXkdDqtjwVKLqxQ1gNcWKtQF7TqLH/jTlkz5uZLHPSL9YepbbTOmM79hhIvZ8V292
 4sObKOilkQPOMWgOXK/2dBIfTg3wY0TX8+eRzp/Lb7dfGKL2QgJV5fs/F/WU9Y5xvQOyLaUo
 S3Vt40x4AOXuEAr4D6iMhhLAI4Dl74mxZ7iFSBzb1uuxVY5ZoOjsPUWe5ctLOso8eViybh/S
 PxcI5eMBfFGSzLm/TUBbMml/NYyKkjz3Q/ebTC4ZDUffoJ7Q1Ob99LheDzp/nZcAyeys/w4v
 LD9hBjQRoAORlg5AcuPMKCvwlq9sGIzguV3W0eUcNBfdF+9ooxrLTHhyPQwJphUexnEwzKb0
 SeQAAsZ+raV/tVkroGRiPnd/YmzEuZ4Ek5LJEXh7O67ZXvA426u4Y5cS+LRJWLXWlTs4qKnf
 v1bwqyuK/YAhltL7NtxSu450aIk6tLzjLZG1QA4Tm7TZlGmB748cHmL2c5D6v9EyrND41DkX
 0uO/pxeN+zMNp68VlEWIwUhY6KI0vRNwmve6vE8IUPb4i5r/erYDR8DYUHU0CENfqFoNI4Fw
 Ps6vJJE4QKIjBd3YM2NiTpZ9jjRI3FcAb8rsIoWXN3ihgYxkAoQZJXdDmry7sjKZYgVdEYtJ
 TCQiezJgLEFnhjOdH86FH7s2+tBhMRR5Eobkgdaf1nZyMDYgvIX3QFK9WhlRApiyBgagfl4P
 XJmNhEoKKiDl9uyaBOvg4x+98B96BylFojZzlIIkCjdQRDtWDGUamI6PumJ8QYS9Gc0kv23O
 l2H4D6NbNooVJiZMugOtYpNpPnqTNg3/QrH8CxiN9rQBIE0OFIJnYf3DVflaHLb7QcZgEzBu
 Pks9+F1AUE+2ej8vIVjY7SnOX8spNxo6YCMrTyNPE/EII0ERAyP5A==
IronPort-HdrOrdr: A9a23:Qoz8fKv5BL/+sva530IA5d2t7skDVdV00zEX/kB9WHVpmwKj5r
 mTdYcgpHjJYVEqKQ0dcLG7SdS9qBznhP1ICOUqTMyftUzdyRGVxeJZnOnfKl/bexEWn9Q1vc
 wAT0E9MqyJMbETt6jHCWKDYrIdKbe8gcaVbKvlvhJQpMJRBp2ILT0SNu9WKCFLrcB9aqYEKA
 ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="19988177"
X-MGA-submission: =?us-ascii?q?MDEJTeG9m4L1TtSylAs+J6lBO23dkRCGbW6pW9?=
 =?us-ascii?q?gVYYisoi7V3LAvQB0+3fywPslpk1YVOsL6+jjcfG6FPMWk+oYQH2fKnK?=
 =?us-ascii?q?orEDkbktwfaDCAhqmwKqBpmWl/x2EnGsBZmOh37E+reZBu/TPFLNrZk7?=
 =?us-ascii?q?bsrzFO7GWDfKGp2flSjKfHVQ=3D=3D?=
Received: from mail-lf1-f51.google.com ([209.85.167.51])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 08:17:07 +0100
Received: by mail-lf1-f51.google.com with SMTP id u6so24930164lfm.10;
        Sun, 06 Feb 2022 23:17:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uqcFTOGXDEqghAAUaAoe5ssGBAC1pWYocqajsA1eWkI=;
        b=DwbPG66704Gfetcd0SLn7e/8QaAvp6dmgqtIZioXJGgjkaZpF1yNKTnhTW0PWbJrnq
         sWe06UlFGmIlJxGgUPydEuZikeCrI90avjL4ybgxPRZ/n9dDXm8s0sxaMsb/8l7VAJDe
         z8wFXLDmbmvOaa5DxZlzocKAQapbvChKFDKfk8ximAC0wj3Wif7/6y3W26NJMHx9hRZG
         RLjBc1uLe/UKnk/UV8rd+dPYuOWjUKfDu+2igCWA06nvImiNxzUXNBp+OlUuSAsP8X5m
         9PA0r5RO4INWqzgtWRNddjdG0e69M8GrNlsMeTcSwVPYmztyLbrigiDkSqFZ5YnBn2le
         wfcw==
X-Gm-Message-State: AOAM532sbTpWCTMkckBH2R1Fm9LOXAWonMZQgOxnAQ8neGiGf3GGS0ez
	RZ64GackEVBPl37ZTGNTGV0NQYJIqzY=
X-Google-Smtp-Source: ABdhPJztvRhh43VvXTPsPucJWb3+dbs0StrjzyWSSgc00dI5ze2Twr9qZqFqbR0DZSIO7wBPrMV0Fg==
X-Received: by 2002:a05:6512:ba4:: with SMTP id b36mr7664518lfv.481.1644218226574;
        Sun, 06 Feb 2022 23:17:06 -0800 (PST)
Received: from [10.68.32.40] (broadband-109-173-81-86.ip.moscow.rt.ru. [109.173.81.86])
        by smtp.gmail.com with ESMTPSA id z15sm1384998lfe.89.2022.02.06.23.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 23:17:06 -0800 (PST)
Message-ID: <bb419c62-f560-e918-2eb2-94f489a93f4a@linux.com>
Date: Mon, 7 Feb 2022 10:17:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <cd9a37f0-9a90-1df5-cec7-853a783e5538@linux.com>
 <alpine.DEB.2.22.394.2202061941500.3126@hadrien>
 <f07ed61b-96e5-d99f-dc0f-d3f39b8291bf@linux.com>
 <alpine.DEB.2.22.394.2202062047220.3126@hadrien>
 <412f6138-c5de-38f4-553b-6b34a0650005@linux.com>
 <alpine.DEB.2.22.394.2202062158390.3126@hadrien>
 <efdc5e18-fdc4-56d6-f78e-0e47fe24ef02@linux.com>
 <alpine.DEB.2.22.394.2202070752260.3105@hadrien>
From: Denis Efremov <efremov@linux.com>
In-Reply-To: <alpine.DEB.2.22.394.2202070752260.3105@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] spatch 1.1.1 segmentation fault report
Reply-To: Denis Efremov <efremov@linux.com>
X-Loop: cocci@inria.fr
X-Sequence: 132
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-02/bb419c62-f560-e918-2eb2-94f489a93f4a%40linux.com>



On 2/7/22 09:56, Julia Lawall wrote:
>> I checked that the problem persist on latest commit
>> b2a4b9b77157 parsing_c: print correct attributes in pretty_print_c.ml
>>
>> and bisected the crash to commit
>> 7b79a2415a8c6e8b1c39a8183bf732fdc6d00453 is the first bad commit
>> commit 7b79a2415a8c6e8b1c39a8183bf732fdc6d00453
>> Author: Corentin De Souza <corentin.de-souza@inria.fr>
>> Date:   Tue May 25 19:21:51 2021 +0200
>>
>>     parsing_c: detect macro iterators from their bodies
>>
>>     This uses the same strategy as macro statements (see
>>     https://gitlab.inria.fr/coccinelle/coccinelle/-/merge_requests/92).
>>     The goal is to do fix https://gitlab.inria.fr/coccinelle/coccinelle/-/issues/24
>>
>>     The next commit will finally fix the assign_expr rule in the parser, removing
>>     the conflicts it introduced while not breaking test
>>     assign_deref_funcall_in_macro_it.
>>
>>  parsing_c/cpp_token_c.ml | 39 ++++++++++++++++++++++++++++++---------
>>  parsing_c/parser_c.mly   |  3 ++-
>>  2 files changed, 32 insertions(+), 10 deletions(-)
> 
> Thanks for all of the investigation.  I'll take a look at this commit, but
> from the subject it seems hard to imagine how it would affect python...
> 
> Could you take a look at the core to see if indicates what function caused
> the problem?

Core was generated by `spatch segfault.cocci empty_dir'.
Program terminated with signal SIGSEGV, Segmentation fault.
#0  0x0000000000aa8b7e in pydecref (v=<optimized out>) at pyml_stubs.c:247
247     pyml_stubs.c: Directory not empty.
(gdb) bt
#0  0x0000000000aa8b7e in pydecref (v=<optimized out>) at pyml_stubs.c:247
#1  0x0000000000ac5cee in caml_empty_minor_heap () at minor_gc.c:409
#2  0x0000000000ac610c in caml_gc_dispatch () at minor_gc.c:475
#3  0x0000000000ac61fe in caml_check_urgent_gc (extra_root=<optimized out>, extra_root@entry=1) at minor_gc.c:572
#4  0x0000000000ac6293 in caml_alloc_small_dispatch (wosize=2, flags=flags@entry=1, nallocs=nallocs@entry=1, 
    encoded_alloc_lens=encoded_alloc_lens@entry=0x0) at minor_gc.c:516
#5  0x0000000000ac7831 in caml_alloc_small (wosize=wosize@entry=2, tag=tag@entry=0) at alloc.c:68
#6  0x0000000000acd6ef in caml_ml_out_channels_list (unit=<optimized out>) at io.c:512
#7  0x0000000000a47005 in camlStdlib__flush_all_231 () at stdlib.ml:349
#8  0x00000000005ffeaf in camlStd_exit__entry () at stdlib.ml:556
#9  0x00000000005f5199 in caml_program ()
#10 0x0000000000ae0860 in caml_start_program ()
#11 0x0000000000ae0be4 in caml_startup_common (argv=0x7ffcf50f98c8, pooling=<optimized out>, pooling@entry=0) at startup_nat.c:160
#12 0x0000000000ae0c5b in caml_startup_exn (argv=<optimized out>) at startup_nat.c:165
#13 caml_startup (argv=<optimized out>) at startup_nat.c:170
#14 caml_main (argv=<optimized out>) at startup_nat.c:177
#15 0x00000000005f3ddc in main (argc=<optimized out>, argv=<optimized out>) at main.c:44


> 
> Do you have parmap installed on your machine or are you using the bundled
> version?

I guess it's in my system:

configure: configuring package parmap
checking for OCaml findlib package parmap... found
...
cp /home/work/.opam/4.11.2/lib/parmap/parmap.cmi ocaml/parmap.cmi
if test -f /home/work/.opam/4.11.2/lib/parmap/parmap.cmx; then \
        cp /home/work/.opam/4.11.2/lib/parmap/parmap.cmx ocaml/parmap.cmx; \
fi

> 
> Could use test with the bytecode version of Coccinelle?  I think that
> would come without the --enable-opt option.
>

When I build spatch with --disable-opt there is no crash.

