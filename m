Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA66C433EF
	for <cocci@archiver.kernel.org>; Sun,  6 Feb 2022 22:53:17 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,348,1635199200"; 
   d="scan'208";a="19962748"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2022 23:53:16 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B4B4DE0384; Sun,  6 Feb 2022 23:53:15 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 955C9E037F
	for <cocci@sympa.inria.fr>; Sun,  6 Feb 2022 23:53:13 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=efremov@linux.com; spf=Pass smtp.mailfrom=yefremov.denis@gmail.com; spf=None smtp.helo=postmaster@mail-lj1-f170.google.com
IronPort-SDR: hyN1xRLqRjb/mOWgBx4qsC5XqdjFLcwFhKCYdFGY3Tv3F61DNXpJpp0/g+unKSdCTZF2Vu5HeR
 3J8EfLhq53I+/zHhVwrQpTUE0ih2W8v8hEEQCGuMN/a0ZQpeG7MURrGnJpXclmj3PjcVUfnBv/
 eYtzoy25JAagwsTU382Cc6Vk+7eaQvIStQ1RrTIzEaVDJytkJnSwHtTg1SpiGZh1JnLyj4HZCK
 blorwRDElecoHoCcq+Z1rPV0yaGnF9RvWxsAz93Rd2xjlf7Jdg/5mlGg1rnhnzCOtRj7Tbw0NV
 XtihOAO+wUYxOX095gBrDGvx
X-IPAS-Result: =?us-ascii?q?A0CXAQA7UABif6rQVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VqCKH5XKwRNhFSOcYF3LgOcZ4FzAQMBCwEBNQwEAQGFKINBAh0HAQQ0EwECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgMEARMBAQ0LCQcICgIFDg4FYAFFZ?=
 =?us-ascii?q?IFPgXcIAwEwDYI1KQGDZAEFEhFWGxQEAgImAjYBBQEcBg0GAgEBHoJiAYMWB?=
 =?us-ascii?q?AufJ4EEPYo4eoExgQGJdwYJAQh+KoxQgWMnHIINgRUngwM+aYNCgzITglIEk?=
 =?us-ascii?q?wOBDgErIoEjOAEhHjqhFZ5mg1CEDYZ1lEgGDwUulisUgSWQKZZKjRKZNQIKB?=
 =?us-ascii?q?wYQI4FVgX4zGggbFYMkTgECAQEBDQECAgECAQIBAgkBAQKOKRaFDYlhMzgCB?=
 =?us-ascii?q?gsBAQMJkE8BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:ekhRkK9UJXZP7iVKVdy3DrUDV3iTJUtcMsCJ2f8bNWPcYEJGY0x3m
 DZNX2GPbvmNNGLwLd0nOo7joUsF6pfcyIJnGQc4ri1EQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHvylYAL9EngZqTVMEU/Nsjo+3b5p6mJUqYLhWVnV4
 4us+5e31GKNglaYDEpEs8pvlzs05JweiBtA1rDpTa0jUPf2zhH5PbpHTU2DByOQrrp8QoZWc
 93+IISRpQs1yfuC5uSNyd4XemVSKlLb0JPnZnB+A8BOiTAazsA+PzpS2Pc0MS9qZzu1c99Zl
 dVGl5W6aBcVFIKXvuk2WhpJSghAMvgTkFPHCSDXXc27ykTHdz7owawrAhhpZcsX/eF4BWwI/
 vsdQNwPRkrb1qTmnfThErkq35t7RCXoFNt3VnVI3DzXF/sjRo6FT6jM5MRw0zI5h8QIFvHbD
 yYcQWM+PUqaPEEQUrsRIKllp9qz3FrnSnp/om2P/Is9yG7yxQMkhdABN/KMIoDQLSlPpW6cr
 33P+2DREBAfPsaWjzuD6HOlwOHV9QvwX4kZFZWj5/tyiRuSwHYSAVsYTzOGTeKRj0e/X5dbK
 RVR9HNx9e4980ukStS7VBq9yJKZgvICc4dQGM8z4iCd9oD7uCCULWEHX2doVtNz4afaWgcW/
 lOOmtroAxlmv7uUVW+R+9+oQdWaaXh9wYgqNX5scOcV3zXwiNps0U+XH76PBIbw34KlQ2ihq
 9yfhHFm3+17sCId60msEbn6b9+Eo5HISksx5FySUDv6tkV2Y4mqY4Hu4l/ehRqhEGp7Zgnf1
 JTns5LGhAzrMX1rvHLWKAnqNO/wj8tpyBWG3TZS82AJrlxBAUKLc4FK+y1ZL0x0KMsCcjKBS
 BaN5VgAtc4PZCP0PPYfj2eN5yICnfiI+TPNBqG8UzaySsUZmPKvoHs3PhbJhwgBbmB2yfFnY
 f93jvpA/V5DUfg9pNZHb+ga1rAvy0gDKZD7FPjGI+Cc+ePGPha9EO9bWHPXN7hRxPrd/G39r
 ogCX+PXlE03eLCvOkH/rN9IRXhXfChTLc6t8KR/KLXTSjeK7Ul7VJc9N5t6K9I790mU/8+Ul
 kyAtrhwkgam1SaZeFnVNhiOqtrHBP5CkJ7yBgR0VX7A5pTpSd/HAH43e8RlcL852vZkyPIoH
 fAJd9/RUPtKQzXDvT8aaMCl/oBlcR2qgyOIPjakMGBvJc4+G1SR94+2ZBbr+QkPEjGz6pkzr
 rim4QXRHsgOSgFkO8DJZa/91Fi2p3UcxLl/UhKQcNlecUnh6qZwLCn1gqNlKs0AM0SRwjqcy
 hbQChAd/LGfr4gw+djPpKaFs4b2TLMjRBsERzHWtO/kOzPb82yvxZ57fNyJJT2NBnnp/KiCZ
 PlOy6ikYvcJq05QtI9nC7hmkPAl7Nz1qr4Fnwk9RCfXb06mA69LK2Wd2ZUdrbVEw7JUtFfkW
 k+L/dUGa7yFNNm/TAwULQshK+CBjLQaw2aKq/syJ0r+6Wl8+7/eCRdeOByFiSp8KrppMdN6n
 b1w5pZOswHv2AA3NtumjzxP8zjeJHI3Vah65IoRB5Xmi1Z2x1weM4bQDDT6vMOGZ9lWaBV4J
 zaVgO/Ghe0ZyBOdKzw8En/C2ecbjpML4UgYwFgHLlWPu9zEmv5ng0ELoGpvFlxYnkddzuZ+G
 ml3LEkpd6+AyDFl2ZpYVGe2FgAdWRCU9yQdEbfSeLE1naVpaoDMEIH5EeOE/URc92AFOzYCo
 +nex2HiXjLnOsr220PenKKjR+PLFbRMGs/qwahL3Php27E1ZDPkhumlYm9gR97PH5YqnEOez
 QV11L8YVEA4XBL8Z4U/Co+HxfIbTxXsyKmuhx1+1PthIFwwsw1eFdRDx45dty+NyzH3HZeEN
 vFT
IronPort-HdrOrdr: A9a23:hVD1+qlwhYWc+JUooGzFZoteNzDpDfIP3DAbv31ZSRFFG/FwWf
 re5cjzpiWE7wr5P0tQ5exoWZPwPE80mqQFgrX5UY3SJzUO/VHYVr2KjrGSoQEIeRefygc178
 4JGMlD4Z/LfCBHZK7BjjVQeOxQpOVvnprY49s2g00dKD2CqJsM0+66MGym+4FNKDWuzKBXKK
 ah
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,348,1635199200"; 
   d="scan'208";a="19962747"
X-MGA-submission: =?us-ascii?q?MDHDSUuSUvVvcSQKzH4OsYSoAmSZd0aS1LCgtS?=
 =?us-ascii?q?NBS/N16ZCSphyqikE7K8Rtvy3tz15nnQ9bVqyxE1dMi0+YRZHXhfUke/?=
 =?us-ascii?q?rdxivzR+FdvpWYSb44/RGZ7ir8VG0fO/6E77oy5NutFuNyhqU6cAer9s?=
 =?us-ascii?q?/ByalwINZRdAKmdGT/V53DPA=3D=3D?=
Received: from mail-lj1-f170.google.com ([209.85.208.170])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 23:53:12 +0100
Received: by mail-lj1-f170.google.com with SMTP id e17so17110302ljk.5;
        Sun, 06 Feb 2022 14:53:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lCAEzrHofKvhIiTTh3h65OFU32QycLPFr3iBglFJ3+M=;
        b=U+8KZ9mk7Py/6JVqJ9VUXrso8/+5L3WmJTPBFcZoWhxeCZXj/88HK285IRKTl3b64l
         XL0JZVp947uZeBMLJUGG5MgOfcnIIpO0jVa2vkMJnbWoEcjmdXzHZ4U4exozF5RQCoTK
         7TB+2PWYXq0Gl1eZcoVfmfk/E7NBFlfv6GIqApZ19dnWmItq/4UEAMEqYUOKPnInnvPA
         o4kGM3O/iqnXxCeBV7FdOHQgj38dRO5XtBvcUzlDmuKdlYdmAL+jQxdKizktcyyT8I8o
         OGxiHl+AD8jdNUkM2JtMriEFDgAiLnFFFhNOfQeF31RWCIoFlGeG1oZbLkn2uaXgYqNL
         xKcA==
X-Gm-Message-State: AOAM530KNdPbNZkMs77fZbszPWmCvngOxon9YjoN2IrAGOVvoIDMTMv/
	5PxtkHWV3nXVCQJqzOvHNH0bgy14ifw=
X-Google-Smtp-Source: ABdhPJxQCc3dFhDGzMq2yLDZ1PxOAH6O7PcBzpP1oRgo+0kMlbhEq1MGKMr6Yhp5XbcNkkQY36ClQw==
X-Received: by 2002:a2e:bc14:: with SMTP id b20mr6882750ljf.6.1644187991116;
        Sun, 06 Feb 2022 14:53:11 -0800 (PST)
Received: from [10.68.32.40] (broadband-109-173-81-86.ip.moscow.rt.ru. [109.173.81.86])
        by smtp.gmail.com with ESMTPSA id u13sm1253214lfs.260.2022.02.06.14.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 14:53:10 -0800 (PST)
Message-ID: <efdc5e18-fdc4-56d6-f78e-0e47fe24ef02@linux.com>
Date: Mon, 7 Feb 2022 01:53:04 +0300
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
From: Denis Efremov <efremov@linux.com>
In-Reply-To: <alpine.DEB.2.22.394.2202062158390.3126@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] spatch 1.1.1 segmentation fault report
Reply-To: Denis Efremov <efremov@linux.com>
X-Loop: cocci@inria.fr
X-Sequence: 130
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-02/efdc5e18-fdc4-56d6-f78e-0e47fe24ef02%40linux.com>



On 2/7/22 00:00, Julia Lawall wrote:
> 
> 
> On Sun, 6 Feb 2022, Denis Efremov wrote:
> 
>>
>>
>> On 2/6/22 22:48, Julia Lawall wrote:
>>>
>>>
>>> On Sun, 6 Feb 2022, Denis Efremov wrote:
>>>
>>>>
>>>>
>>>> On 2/6/22 21:43, Julia Lawall wrote:
>>>>>
>>>>>
>>>>> On Sun, 6 Feb 2022, Denis Efremov wrote:
>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> I'm observing a weird crash with spatch 1.1.1
>>>>>>
>>>>>> $ spatch --version
>>>>>> spatch version 1.1.1 compiled with OCaml version 4.11.2
>>>>>> Flags passed to the configure script: --enable-opt --enable-ocaml --enable-python --enable-pcre-syntax --enable-pcre --prefix /home/work/.opam/4.11.2 --libdir /home/work/.opam/4.11.2/lib
>>>>>> OCaml scripting support: yes
>>>>>> Python scripting support: yes
>>>>>> Syntax of regular expressions: PCRE
>>>>>>
>>>>>> $ cat segfault.cocci
>>>>>> @err@
>>>>>> position p;
>>>>>> @@
>>>>>>
>>>>>> amd_energy_is_visible(...)
>>>>>> {
>>>>>> *       return 0444;@p
>>>>>> }
>>>>>>
>>>>>> @script:python@
>>>>>> p << err.p;
>>>>>> @@
>>>>>>
>>>>>> coccilib.report.print_report(p[0], "found")
>>>>>>
>>>>>> $ mkdir empty_dir # creating empty directory
>>>>>> $ spatch segfault.cocci empty_dir
>>>>>> init_defs_builtins: /home/work/.opam/4.11.2/lib/coccinelle/standard.h
>>>>>> 0 files match
>>>>>> [1]    152475 segmentation fault (core dumped)  spatch segfault.cocci test
>>>>>
>>>>> I tried 1.1.1 with the options --enable-opt --enable-ocaml --enable-python
>>>>> --enable-pcre-syntax --enable-pcre, but it seems to work find for me.
>>>>> Does the problem go away if there is a file in the directory?  If you
>>>>> remove the python code?
>>>>
>>>> It doesn't crash if I run it on the linux kernel sources on commits prior to
>>>> 9049572fb145 hwmon: Remove amd_energy driver
>>>>
>>>>
>>>> $ git checkout 9049572fb145~
>>>> # there is amd_energy_is_visible in drivers/hwmon/amd_energy.c
>>>> # spatch doesn't crash on this commit
>>>>
>>>> $ git checkout 9049572fb145
>>>> # no amd_energy_is_visible in kernel source
>>>> # spatch crashes
>>>>
>>>> If I remove python code then spatch doesn't crash.
>>>
>>> Maybe try with --debug.  Or try without the p[0] in the python code.
>> I removed coccilib.report.print_report(p[0], "found")
> 
> Could you remove the python metavariable p and print something in the
> python code?  Flush standard output to be sure to have a chance to see it
> if it crashes after.  Maybe it would help to see where the crash occurs in
> the core file?


I checked that the problem persist on latest commit
b2a4b9b77157 parsing_c: print correct attributes in pretty_print_c.ml

and bisected the crash to commit 
7b79a2415a8c6e8b1c39a8183bf732fdc6d00453 is the first bad commit
commit 7b79a2415a8c6e8b1c39a8183bf732fdc6d00453
Author: Corentin De Souza <corentin.de-souza@inria.fr>
Date:   Tue May 25 19:21:51 2021 +0200

    parsing_c: detect macro iterators from their bodies
    
    This uses the same strategy as macro statements (see
    https://gitlab.inria.fr/coccinelle/coccinelle/-/merge_requests/92).
    The goal is to do fix https://gitlab.inria.fr/coccinelle/coccinelle/-/issues/24
    
    The next commit will finally fix the assign_expr rule in the parser, removing
    the conflicts it introduced while not breaking test
    assign_deref_funcall_in_macro_it.

 parsing_c/cpp_token_c.ml | 39 ++++++++++++++++++++++++++++++---------
 parsing_c/parser_c.mly   |  3 ++-
 2 files changed, 32 insertions(+), 10 deletions(-)

I removed the @p variable and reduced the cocci file to
@err@
@@

amd_energy_is_visible(...)
{
*       return 0444;
}

@script:python@
@@

and it still crashes.
$ mkdir empty_dir
$ spatch segfault.cocci empty_dir
init_defs_builtins: /home/work/.opam/4.11.2/lib/coccinelle/standard.h
no inferred keywords
[2]    240209 segmentation fault (core dumped)  spatch segfault.cocci empty_dir

$ touch empty_dir/file
$ spatch segfault.cocci empty_dir
init_defs_builtins: /home/work/.opam/4.11.2/lib/coccinelle/standard.h
no inferred keywords
[2]    240269 segmentation fault (core dumped)  spatch segfault.cocci empty_dir

$ echo "void amd_energy_is_visible(void) { return 0444; }" > empty_dir/file
$ spatch segfault.cocci empty_dir
init_defs_builtins: /home/work/.opam/4.11.2/lib/coccinelle/standard.h
no inferred keywords
[2]    240363 segmentation fault (core dumped)  spatch segfault.cocci empty_dir

Regards,
Denis
