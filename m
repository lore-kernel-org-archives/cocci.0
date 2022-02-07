Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990C1C433EF
	for <cocci@archiver.kernel.org>; Mon,  7 Feb 2022 12:45:31 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="20070903"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Feb 2022 13:45:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5AB9EE0384; Mon,  7 Feb 2022 13:45:29 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C5892E037F
	for <cocci@sympa.inria.fr>; Mon,  7 Feb 2022 13:45:25 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=efremov@linux.com; spf=Pass smtp.mailfrom=yefremov.denis@gmail.com; spf=None smtp.helo=postmaster@mail-pj1-f48.google.com
IronPort-SDR: NRYLUHy82QtJyAxOsShQf/xgPq4bV6++f9vbJQ5CoOoaKjNDLIGykV1SIYVI2nrimqJKdw2paY
 hPjW6Ac3o8OOyaymVPhUXHSEUw7XO5wISJIS9X9j+3WIGdTG3365I8NBleebpOMUjyPJzeyb8S
 4+1cm/x4vmfGPixVnI5YmX5Y2KUoCRIPaXkQ1I1znzgtkTSH/fCGQPWX5qVrq9dCCNTDTbFsfK
 T153ypLbfTKQnDS3KnwttQECxJ4aFf2mYkBV+3WKj2uURVIQYbUmtNwC+JZrk+mBkQq6Xn6etQ
 +qxmpM6Az3+D84vdLxE/liRj
X-IPAS-Result: =?us-ascii?q?A0DoAgBZEwFifzDYVdFaHgEBCxIMQIQCflcrBE2EVI5xg?=
 =?us-ascii?q?XcuA5ZMiA4BAwELAQE1DAQBAYhqAh0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgMEARMBAQ0LCQcICgIFDg4FYAFFZIFPgXcIAwEwDYI1KQGDZ?=
 =?us-ascii?q?AEFEhFWEAsUBAICJgICNAEFARwGDQYCAQEegmIBgxYEC583gQQ9ijh6gTGBA?=
 =?us-ascii?q?Yl9CQEIfiqOMyccgg2BPIJMNz5pZ4YNE4JSBJMDgQ8rGgiBIwwtIaFtXIsmk?=
 =?us-ascii?q?mSDUIQNhnWNWgmGZQYPBS6FPpBtFIElkCmWSo0SlFWEYAIKBwYQI4FVgX4zG?=
 =?us-ascii?q?ggbFYMkCUUBAgEBAQ0BAgIBAgECAQIJAQECjikWhQ2CYoZBPjM4AgYLAQEDC?=
 =?us-ascii?q?ZBPAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:YQT1W6r/D6wz1S7FFO33WjSCAWleBmLWYxIvgKrLsJaIsI4StFCzt
 garIBnQaK2Ma2DyeYtzPtmypBtUup7RndJlHAM5ri5kEihHoOPIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKicfHkZqTZMEE/Nszo68wICqtMu0YjR7z+l4
 4uo+ZWFYAD9glaYD0pNg069gEM31BjNkGhA1rAOTagjUIj2yhH5pLpGTU2AByOQrrt8RoZWd
 M6fpF2NxV41yj92Yj+TfhkXRWVRKlLaFVDmZnO7wMFOiDAazsA5+v5T2Pbx9S67hh3R9+2dx
 umhurSpdhZ0N6fBqd4MQiNYQiB5IvcWp4DudC3XXcy7lyUqclPpyvRqSVk0ZMgWprYxDmZJ+
 vgVbjsKa3hvhcrsmOP9GrQq3J19apW7VG8ckikIITXxHPsoW53GRLuM6dJe3SwYicVHHPKYb
 M0cAdZqRE6YO0IXagdOYH44tMmEpym8TGZ9k3GyuvMz+y+N5Sgh/re4ZbI5ffTTHZkP9qqCn
 UrC9nvwBhUyJt2awyCMtHOqnO7G2y3hMKoZE7az99ZxkViLzyoSDgcXXB21u5GEZlWWXtteL
 wkM+HNro/RiskOsSdb5Uluzp3vsUgMgt8R4CtIrtQiHx5vu8hejBjkFSSEbOIMZnZpjLdA17
 WOhk9TsDD1plbSaT3OB67uZxQ9e3wBFfQfuggdUHGM4D8nfTJIb1U2QE44yeEKhppikRmGqm
 mHiQD0W3u1L1aY2O7OHEUcrag9AS7DMRw8xox3VByerslM/a4miaIilr1Pc6J6szbp1rHHR4
 xDoeODEtIji6K1hcgTTGo3h+5n3vJ643MX02wIHInXY323FF4SfVY5R+ipiA0xiL9wJfzTkC
 GeK518Nvc8CbSP6M/UsC25UNyjM5fiwfTgCfqCFBueinrAsHON61H00PBXIhjiFfLYEy/lhZ
 MjznTmQ4YYyUPw7llJats8S1rgkwi1W+I8gbcGT8vhT6pLHPCT9Ye5dbjOmN7lhhIvd+Vm92
 4sBaqOilkoHOMWjM3G/2dNCdjgicClrbbio8Jc/XrDYcmJb9JQJUaC5LUUJINw7wcy4V47go
 hmAZ6Ov4ACj3C2cd1TWNSwLhXGGdc8XkE/X9BcEZT6As0XPq672hEvGX5doL7Qh6sJ5yvt4E
 6sMd8maU6ZATz3G/3IWapyk9N5ucxGihASvOSu5YWhnL8QwGVCRotK0LBHy8CQuDzassZRsr
 rCl0DTdS8VRSglnCvHQd//ynUi6umIQmb4pUkaReotTdUzg/ZJEMSv0ivNrccgAJQ+SlD+b0
 RuGRxwfoLCV8YMy9dDIg4GCrpuoTLQmQxALQTGD4O/vZyfA/2elzYtRa8qyfGjQBDHu5aGvR
 eRJ1PWlaK8NkmFSqY15CK5lwP9s/NDovbJbkVVpRS2Zc1SxB7p8CXCaxs0T5LZVz7pUtAbqC
 EKC/t5WZeeANM//SgVDIQMkaqGb16hRlGWCq/syJ0r+6Wl8+7/eCRdeOByFiSp8KrppMdN6n
 b1w5pZOswHv2AA3NtumjzxP8zjeJHI3Vah65IoRB5Xmi1Z2x1weM4bQDDT6vMOGZ9lWaBJ4J
 zaVgO/ahe0ZyBaSNXU0EnfJ0KxWgpFX4EJGy1oLJlKonNvZh69ogEcAr2xvFgkFnA9a1+9TO
 3RwMxEnL6u5+To11tNIWHqhGl0cCRCUkqArJ4DlSIELo4iUum3xwKkVPO+M+AUB8TsZcGQLu
 r6fz2nhXHDhe8SZMu7en6J6g6SLcDCz3lSqdAOb8wCtEJwzYD6jiairDYbNgwWyGts/3SUru
 sEzlNudqsTH2eo4p6w9Fpnc3rMVIPxByKquXtk5lJ408arglP1eFNRAx41dui+AGhASzXKFN
 g==
IronPort-HdrOrdr: A9a23:0rfNeKvDMrqg6zAMOUy1ne347skDVdV00zEX/kB9WHVpmwKj5r
 mTdYcgpHjJYVEqKQ0dcLG7SdS9qBznhP1ICOUqTMyftUzdyRGVxeJZnOnfKl/bexEWn9Q1vc
 wAT0E9MqyJMbETt6jHCWKDYrIdKbe8gcaVbKvlvhJQpMJRBp2ILT0SNu9WKCFLrcB9aqYEKA
 ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="20070881"
X-MGA-submission: =?us-ascii?q?MDHY9DeM6/hCZMqjypkcq1uN34tXl9vZEe2VOq?=
 =?us-ascii?q?nZn3ifCutfwvKZuHt8TkfAZTu6Q22LLoGTL9+sk8ayZcyR8i4TwvZHj0?=
 =?us-ascii?q?82dmeGVv37mZ1ngcB4rf45Fjq5FDbcZi8dc5jWBAViTvgE3Q8XOYyoE6?=
 =?us-ascii?q?Eoe7uc4fqh3SyFqyfRY7ozqQ=3D=3D?=
Received: from mail-pj1-f48.google.com ([209.85.216.48])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 13:45:24 +0100
Received: by mail-pj1-f48.google.com with SMTP id om8so4728694pjb.5;
        Mon, 07 Feb 2022 04:45:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tJlbGdpVTcLVDDEd+LF/FGWxOfhiLtgut1G5619eYqA=;
        b=FWTAzzS8cLe9fve7W+7g+xhkuYJQWU4MPdWUEVd7tbYtdQr4kD+pj35aXiOiNKZp1b
         bj6jJeVTD/tKjk1S1GvUSRqXrtRcWEO1KahM+qSVydFt1g8rbgUUAHVqexXKeT8tyq16
         1cIwNnY7+imnOCMBFBeEIpqh3MvryIuRZuTxw+9yIUn7T3IIO/4gVyeolfdrK0BaXy3K
         a21xMdn7U6HgiUrp/jitJXOtLpd3gfadzK8Ix8JwXF3fKC6ElP9Ql3q7keTgBeEgyPo+
         kXt0QwU9ceYYhGbUsG+Qq0uwQRnsWLgOmSGb6vP8cGhidhXp1v+xJiQ6z2DDZv4lNG0R
         efJA==
X-Gm-Message-State: AOAM532fsTaq682avmCTcz2A2L4iKoY1E72JHg4Q5Nhxfd4Bwlcp4DwL
	d0IkuNLfvGJE/Ma1NThixw7MdlVspOk=
X-Google-Smtp-Source: ABdhPJzMxqI6+Bdc6zausazb9JBz14Djhrly1gsAqxvaOynvn0E56CHvG4Z4NdVGyVuS0WdYOihCVQ==
X-Received: by 2002:a17:902:da81:: with SMTP id j1mr5699617plx.3.1644237922787;
        Mon, 07 Feb 2022 04:45:22 -0800 (PST)
Received: from [10.68.32.40] (broadband-109-173-81-86.ip.moscow.rt.ru. [109.173.81.86])
        by smtp.gmail.com with ESMTPSA id k9sm11325612pfi.134.2022.02.07.04.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 04:45:22 -0800 (PST)
Message-ID: <d3e3961b-b0d5-6107-c14b-1e745ce1a631@linux.com>
Date: Mon, 7 Feb 2022 15:45:18 +0300
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
 <bb419c62-f560-e918-2eb2-94f489a93f4a@linux.com>
 <alpine.DEB.2.22.394.2202071053010.3105@hadrien>
From: Denis Efremov <efremov@linux.com>
In-Reply-To: <alpine.DEB.2.22.394.2202071053010.3105@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] spatch 1.1.1 segmentation fault report
Reply-To: Denis Efremov <efremov@linux.com>
X-Loop: cocci@inria.fr
X-Sequence: 135
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-02/d3e3961b-b0d5-6107-c14b-1e745ce1a631%40linux.com>



On 2/7/22 12:54, Julia Lawall wrote:
> 
> 
> On Mon, 7 Feb 2022, Denis Efremov wrote:
> 
>>
>>
>> On 2/7/22 09:56, Julia Lawall wrote:
>>>> I checked that the problem persist on latest commit
>>>> b2a4b9b77157 parsing_c: print correct attributes in pretty_print_c.ml
>>>>
>>>> and bisected the crash to commit
>>>> 7b79a2415a8c6e8b1c39a8183bf732fdc6d00453 is the first bad commit
>>>> commit 7b79a2415a8c6e8b1c39a8183bf732fdc6d00453
>>>> Author: Corentin De Souza <corentin.de-souza@inria.fr>
>>>> Date:   Tue May 25 19:21:51 2021 +0200
>>>>
>>>>     parsing_c: detect macro iterators from their bodies
>>>>
>>>>     This uses the same strategy as macro statements (see
>>>>     https://gitlab.inria.fr/coccinelle/coccinelle/-/merge_requests/92).
>>>>     The goal is to do fix https://gitlab.inria.fr/coccinelle/coccinelle/-/issues/24
>>>>
>>>>     The next commit will finally fix the assign_expr rule in the parser, removing
>>>>     the conflicts it introduced while not breaking test
>>>>     assign_deref_funcall_in_macro_it.
>>>>
>>>>  parsing_c/cpp_token_c.ml | 39 ++++++++++++++++++++++++++++++---------
>>>>  parsing_c/parser_c.mly   |  3 ++-
>>>>  2 files changed, 32 insertions(+), 10 deletions(-)
>>>
>>> Thanks for all of the investigation.  I'll take a look at this commit, but
>>> from the subject it seems hard to imagine how it would affect python...
>>>
>>> Could you take a look at the core to see if indicates what function caused
>>> the problem?
>>
>> Core was generated by `spatch segfault.cocci empty_dir'.
>> Program terminated with signal SIGSEGV, Segmentation fault.
>> #0  0x0000000000aa8b7e in pydecref (v=<optimized out>) at pyml_stubs.c:247
>> 247     pyml_stubs.c: Directory not empty.
>> (gdb) bt
> 
> Does your pyml come from the bundle in Coccinelle or from opam?
> 
> In my spatch 1.1.1 code, line 247 is just a variable declaration.

Installed with opam pyml.20211015
Line 247:
244:static void pydecref( value v )                                                  
245:{                                                                                
246:    if (getcustom(v)) {                                                          
247:        Py_DECREF((PyObject *)getcustom(v));                                     
248:    }                                                                            
249:}

I uninstalled opam and rebuilded spatch with the bundled pyml on
latest commit: b2a4b9b77157 parsing_c: print correct attributes in pretty_print_c.ml

Result is the same.

#0  0x0000000000aa810e in pydecref ()
#1  0x0000000000ac512e in caml_empty_minor_heap () at minor_gc.c:409
#2  0x0000000000ac554c in caml_gc_dispatch () at minor_gc.c:475
#3  0x0000000000ac563e in caml_check_urgent_gc (extra_root=<optimized out>, extra_root@entry=1) at minor_gc.c:572
#4  0x0000000000ac56d3 in caml_alloc_small_dispatch (wosize=2, flags=flags@entry=1, nallocs=nallocs@entry=1, 
    encoded_alloc_lens=encoded_alloc_lens@entry=0x0) at minor_gc.c:516
#5  0x0000000000ac6c71 in caml_alloc_small (wosize=wosize@entry=2, tag=tag@entry=0) at alloc.c:68
#6  0x0000000000accb2f in caml_ml_out_channels_list (unit=<optimized out>) at io.c:512
#7  0x0000000000a46645 in camlStdlib__flush_all_231 () at stdlib.ml:349
#8  0x00000000005ffeaf in camlStd_exit__entry () at stdlib.ml:556
#9  0x00000000005f5199 in caml_program ()
#10 0x0000000000adfca0 in caml_start_program ()
#11 0x0000000000ae0024 in caml_startup_common (argv=0x7ffcaf256848, pooling=<optimized out>, pooling@entry=0) at startup_nat.c:160
#12 0x0000000000ae009b in caml_startup_exn (argv=<optimized out>) at startup_nat.c:165
#13 caml_startup (argv=<optimized out>) at startup_nat.c:170
#14 caml_main (argv=<optimized out>) at startup_nat.c:177
#15 0x00000000005f3ddc in main (argc=<optimized out>, argv=<optimized out>) at main.c:44


