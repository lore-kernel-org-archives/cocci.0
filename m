Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035FBC433F5
	for <cocci@archiver.kernel.org>; Mon,  7 Feb 2022 13:01:39 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="20074847"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Feb 2022 14:01:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 46127E0381; Mon,  7 Feb 2022 14:01:38 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2D935E037F
	for <cocci@sympa.inria.fr>; Mon,  7 Feb 2022 14:01:34 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=efremov@linux.com; spf=Pass smtp.mailfrom=yefremov.denis@gmail.com; spf=None smtp.helo=postmaster@mail-pj1-f43.google.com
IronPort-SDR: eb+PXx19LAMbBsRvdJQvC5reAurSRj/6PkiBvHekiWhbpgFj2hKkvfVpi1rQLQKS2J2OTmysX0
 zhTnUAZiNtrsq/DYWjeyJjdvHOa60j6+UvTLC+Bhj9hyLR0pGT8HaEHbTwuQhB3rrT3SFUJF/4
 sweO5pNQ9UqX1J+qxChXN5+TGz0aJfR5j62ncHPcHOXLgPDextm0DNCAAUO4ra5g4Ba0ypWW9b
 C4qEBsmUPCrfzNR7VlQzYY/8aehkUq0Nh0DFSk8QkFmZqy5mBVj2jOxUE/Zm5vUsWXwnaCLluQ
 jLtYCB1OAzgDZkVurGeFJ6Mh
X-IPAS-Result: =?us-ascii?q?A0DoAgDiFgFifyvYVdFagQmEAn5XKwRNhFSOcYF3LgOWT?=
 =?us-ascii?q?IgOAQMBCwEBNQwEAQGIagIdBwEENBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBA?=
 =?us-ascii?q?QIBAQIDBAETAQENCwkHCAoHDg4FYAFFZIFPgXcIAwEwDYI1KQGDYwEBAQECA?=
 =?us-ascii?q?RIRVhALFAQCAiYCAjQBBQEcBhMbB4JiAYJ1IQQLnzaBBD2KOHqBMYEBiX0JA?=
 =?us-ascii?q?Qh+Ko4zJxyCDYE8gkw3Pmlnhg2CZQSTAgGBDysaCIEjDC0hkjKPO1yeCoNQh?=
 =?us-ascii?q?A2GdY1aCYZlBg8FLoU+kG0UgSWQKZZKjRKUVYRgAgoHBhAjgVWBfjMaCBsVg?=
 =?us-ascii?q?yQJRQECAQEBDQECAgECAQIBAgkBAQKOKRaFDYJihkE+MzgCBgsBAQMJkE8BA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:Eoz44q7pEXnsQ49lFFjBIwxRtPvBchMFZxGqfqrLsTDasY5as4F+v
 mccUTqDO/3fYTD0KtAnaYy19EIOucDRnIBmSQo/pCszZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOK6UYYoAwgpLeNeYH5JZSlLxqhp0uaEvfDjW1nX4
 Ymq/JWGULOY82cc3lw8u/rrRCxH56yaVAMw5jTSstgW1LN2vyB94KM3fcldHVOgKmVnNrLSq
 9L48V2M1jixEyHBpT+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRYRQR8/ttmHozx+4
 Nln78eBQhYFBPSSlvY9dDwDSyxaBLITrdcrIVDn2SCS50jPcn+p2/c3SU9qZssX/eF4BWwI/
 vsdQNwPRkrb1qTmnfThE7cq2p9LwMrDZOvzvllxwD/DAPMhX9bPTqPL/vdX2T4xgoZFGvO2i
 88xM2I3M0iQOUwn1lE/CIsRuLynu0TFUH5Rul2/voQM5HnV5VkkuFTqGIONJobiqd9utkKRu
 WvC+0zrAxQQLtXZyDyf83vqiPWntSj8U4kTPKap8+ZjxlyV3G0aThMMPWZXutG8g0+6Hspdc
 gkapnFooq81+0imCNL6WnVUvUJooDYQcYALIuYrxDvUlKTGwyG8XTAJagdePYlOWNANeRQm0
 VqAntXMDDNpsaGIRX/1yltyhWPiUcTyBT9TDRLoXTfp8PG4/95u1kOnosJLVf/q3oesSFkc1
 hjT9HBm74j/m/LnwElSwLwqqzelp5yMVgxsowuLBSSq6QR2YIPjbIutgbQ60RqiBNbGJrVil
 CJc8yR70AzoJc/X/MBqaLtWdIxFH97fbFXhbadHRvHNDQiF9X+5Zpx36zpjPkpvOctsUWa3P
 BOK6VIAvM8NZiDCgUpLj2SZW5RCIU/IRYWNaxwoRocmjmVZKFXep3k3PSZ8IUi3yBZxzsnTx
 qt3ge71VSpAYUiW5DWxQOgZ3NcWKtMWlAvuqWTA503/i9K2PSbLIZ9caQfmRr1nscus/VqNm
 /4CZpPi40gOC4XWP3iHmaZNdgtiBSZgVfjLRzl/LLHrzvxOQzF/VZc8ANoJJ+RYokiivr2Up
 yHmBB4ElwaXaL+uAVziV02PoYjHBf5XxU/X9wR1Vbpx83R8M4up8okFcJ47Iesu+OB5nKx7S
 vAEf4OLBfEWEmbL/DEUbJ/cqo1+dUTz1VjeYXb9ODVvLYR9QwHp+8P/elS9+SQLCB2xv5Rsr
 rCl0DTdXpdeFR9pC9zbaa70wl7o5Sodlet+UlHmON5WfEmwooFmJzag3Ps2Jdwcbx7Ew2LCh
 QqRBB4Zo8jLopM0r4aR2PrV8d/xHrInTERAHmTd4bKnDgXg/zKukd1aTeKFXTHBT2etoPeoa
 9JN1fb5K+UJkQsYqIF7CbtqkvMzvoO9u79Aww14N3zXdFD3WKh4K3yL0MQT5K1AwrhV5Vm/V
 k6VoIIIPLyIPIb9EgdUKlZ+KOuE0v4Ql3/Z6vFseBf24yp+/bymV0ROPknT1HYMcuMtaI51k
 /08vMM26hCkjkZ4ONixiC0JpX+HKWYNUvl6u5xGUpXnjBEnlgNLbZDGUHSk5ZiOb5BUMBBvL
 GPPwqXFgLtYywzJdH9qTSrB2u9UhJIvvhFWzQ9dew7YxIKd3vJnjgdM9TkXTxhOykkV2exEP
 GU2ZVZ+Ir+D/ms1icVON4x299qt2PFLFo3NJ1o1eKnxSkCpUinVLjR4N7rWuk8e9G1Yc35Q+
 7TwJKMJl9r1VJmZ48fwcRcNRz/foRhZ+QjLmcThFMOAd3X/SSSwmbegPALktDO+af7cRyT7S
 S1C+Od2dL29PikVy0H+5092ypxIIC25yKd+rT2NMU/H8awwuN1/5NRWF32MRw==
IronPort-HdrOrdr: A9a23:X+C5nKHQZ9AgUAPcpLqF15HXdLJyesId70hD6qkvc3Nom52j+/
 xGws536fatskdoZJhSo6H6BEDgewKpyXcR2+cs1NiZLW/bUQeTXeJfBOjZskrd8k/Fh5dgPM
 5bGsAUYryRMbETt7e73ODSKadE/DDzytHOuQ6o9QYIcegFUdAD0+8bYjzrUHGfG2J9dN4E/P
 /13LsFmxOQPVAsKuirDHgMWObO4/fRkoj9XBIADxk7rCGTkDKB8tfBYm6l9yZbdwkK7aYp8G
 DDnQC8zL6kqeuHxhjV0HKWx4hKmeHm1sBICKW3+4Eow3TX+06VjbZaKve/VQMO0aySAZER4Z
 XxSiIbTo9OArXqDy6ISFXWqkfdOX0VmgXfIBej8AbeSGbCNXNKTPapw7gpNycxonBQwO1Uwe
 ZF2XmUuIFQCg6FlCPh58LQXxUvjUasp2E++NRj+kC3fLFuG4O5l7Zvjn+9PK1wYh4S2bpXYN
 WGVvusm8q+WWnqHkzkgg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="20074829"
X-MGA-submission: =?us-ascii?q?MDFn9MgzIFe70MkN6jHjzpQTOW/R2vWlV8gug8?=
 =?us-ascii?q?WUAxlozOdsLIp97LVxTA3FSoYnGFBONEvjeN0tm95uZ24mqbIAWzMMvp?=
 =?us-ascii?q?a6ZfBufwOUAU1DbA/mWgJqLiEuvFe3tMljvJSYbdHm+k4hs5+0wFY3FA?=
 =?us-ascii?q?bjci71E4LnbK49Y5KaPMgvVw=3D=3D?=
Received: from mail-pj1-f43.google.com ([209.85.216.43])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 14:01:33 +0100
Received: by mail-pj1-f43.google.com with SMTP id om8so4779574pjb.5;
        Mon, 07 Feb 2022 05:01:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A+v0pbrsaLIEQnFl28WdHoH1WFqVb7jA6Zv4RL/Q2tg=;
        b=VzKoQ5dGuNJdevqHo0MjNwD5Ob7IumKnBxonhSx11CfxF7kZ9K4SMzMvgjKvntb2n7
         VkHjXc1rlQWJWp++bx1fqTsf1ATsbKSMTdB1WwqqljgKxMlzZzaPAZA+7pF5yGA4Xt4f
         MQ+oD4++gGBntFXuHPNCBIksISs0WV2cjkbdq0PY6fuxeggWzyIFj+SIDb3Jpe+kEvce
         mSLZnuBpznwsqekbv1Fh+xQEMvyIwOvSxnkzf2KqAcMMBNfTOXitO9Yf1mu2jSn/4ObM
         8KSQ1erY2pM3rjyebj55Kv7ApKXHybpN7U+phITdI5eWYNfxRb+qzH28JD4YTp6KYWtE
         BkaQ==
X-Gm-Message-State: AOAM532ikEBrQ9FCnnhlPfWtKXUNn3TVZoHoKiEi0Ln5AxKJpzfXi1hv
	uRk4u93fJza6T/bgE/Y3/Bqdbh5VkAo=
X-Google-Smtp-Source: ABdhPJwZuxZ26S35r6D1cJ+OY+odwPbd5i4PNB1phZf62AwgOlKxnhHZikaS9GhV5q1m0sBPXTa8IA==
X-Received: by 2002:a17:903:22cb:: with SMTP id y11mr15985403plg.138.1644238891139;
        Mon, 07 Feb 2022 05:01:31 -0800 (PST)
Received: from [10.68.32.40] (broadband-109-173-81-86.ip.moscow.rt.ru. [109.173.81.86])
        by smtp.gmail.com with ESMTPSA id x5sm1510496pjr.37.2022.02.07.05.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 05:01:30 -0800 (PST)
Message-ID: <98066af4-1d26-dead-4e85-71ef0ec45d47@linux.com>
Date: Mon, 7 Feb 2022 16:01:27 +0300
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
 <d3e3961b-b0d5-6107-c14b-1e745ce1a631@linux.com>
 <alpine.DEB.2.22.394.2202071355350.52266@hadrien>
From: Denis Efremov <efremov@linux.com>
In-Reply-To: <alpine.DEB.2.22.394.2202071355350.52266@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] spatch 1.1.1 segmentation fault report
Reply-To: Denis Efremov <efremov@linux.com>
X-Loop: cocci@inria.fr
X-Sequence: 137
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-02/98066af4-1d26-dead-4e85-71ef0ec45d47%40linux.com>



On 2/7/22 15:56, Julia Lawall wrote:
> 
> 
> On Mon, 7 Feb 2022, Denis Efremov wrote:
> 
>>
>>
>> On 2/7/22 12:54, Julia Lawall wrote:
>>>
>>>
>>> On Mon, 7 Feb 2022, Denis Efremov wrote:
>>>
>>>>
>>>>
>>>> On 2/7/22 09:56, Julia Lawall wrote:
>>>>>> I checked that the problem persist on latest commit
>>>>>> b2a4b9b77157 parsing_c: print correct attributes in pretty_print_c.ml
>>>>>>
>>>>>> and bisected the crash to commit
>>>>>> 7b79a2415a8c6e8b1c39a8183bf732fdc6d00453 is the first bad commit
>>>>>> commit 7b79a2415a8c6e8b1c39a8183bf732fdc6d00453
>>>>>> Author: Corentin De Souza <corentin.de-souza@inria.fr>
>>>>>> Date:   Tue May 25 19:21:51 2021 +0200
>>>>>>
>>>>>>     parsing_c: detect macro iterators from their bodies
>>>>>>
>>>>>>     This uses the same strategy as macro statements (see
>>>>>>     https://gitlab.inria.fr/coccinelle/coccinelle/-/merge_requests/92).
>>>>>>     The goal is to do fix https://gitlab.inria.fr/coccinelle/coccinelle/-/issues/24
>>>>>>
>>>>>>     The next commit will finally fix the assign_expr rule in the parser, removing
>>>>>>     the conflicts it introduced while not breaking test
>>>>>>     assign_deref_funcall_in_macro_it.
>>>>>>
>>>>>>  parsing_c/cpp_token_c.ml | 39 ++++++++++++++++++++++++++++++---------
>>>>>>  parsing_c/parser_c.mly   |  3 ++-
>>>>>>  2 files changed, 32 insertions(+), 10 deletions(-)
>>>>>
>>>>> Thanks for all of the investigation.  I'll take a look at this commit, but
>>>>> from the subject it seems hard to imagine how it would affect python...
>>>>>
>>>>> Could you take a look at the core to see if indicates what function caused
>>>>> the problem?
>>>>
>>>> Core was generated by `spatch segfault.cocci empty_dir'.
>>>> Program terminated with signal SIGSEGV, Segmentation fault.
>>>> #0  0x0000000000aa8b7e in pydecref (v=<optimized out>) at pyml_stubs.c:247
>>>> 247     pyml_stubs.c: Directory not empty.
>>>> (gdb) bt
>>>
>>> Does your pyml come from the bundle in Coccinelle or from opam?
>>>
>>> In my spatch 1.1.1 code, line 247 is just a variable declaration.
>>
>> Installed with opam pyml.20211015
>> Line 247:
>> 244:static void pydecref( value v )
>> 245:{
>> 246:    if (getcustom(v)) {
>> 247:        Py_DECREF((PyObject *)getcustom(v));
>> 248:    }
>> 249:}
>>
>> I uninstalled opam and rebuilded spatch with the bundled pyml on
>> latest commit: b2a4b9b77157 parsing_c: print correct attributes in pretty_print_c.ml
>>
>> Result is the same.
>>
>> #0  0x0000000000aa810e in pydecref ()
>> #1  0x0000000000ac512e in caml_empty_minor_heap () at minor_gc.c:409
>> #2  0x0000000000ac554c in caml_gc_dispatch () at minor_gc.c:475
>> #3  0x0000000000ac563e in caml_check_urgent_gc (extra_root=<optimized out>, extra_root@entry=1) at minor_gc.c:572
>> #4  0x0000000000ac56d3 in caml_alloc_small_dispatch (wosize=2, flags=flags@entry=1, nallocs=nallocs@entry=1,
>>     encoded_alloc_lens=encoded_alloc_lens@entry=0x0) at minor_gc.c:516
>> #5  0x0000000000ac6c71 in caml_alloc_small (wosize=wosize@entry=2, tag=tag@entry=0) at alloc.c:68
>> #6  0x0000000000accb2f in caml_ml_out_channels_list (unit=<optimized out>) at io.c:512
>> #7  0x0000000000a46645 in camlStdlib__flush_all_231 () at stdlib.ml:349
>> #8  0x00000000005ffeaf in camlStd_exit__entry () at stdlib.ml:556
>> #9  0x00000000005f5199 in caml_program ()
>> #10 0x0000000000adfca0 in caml_start_program ()
>> #11 0x0000000000ae0024 in caml_startup_common (argv=0x7ffcaf256848, pooling=<optimized out>, pooling@entry=0) at startup_nat.c:160
>> #12 0x0000000000ae009b in caml_startup_exn (argv=<optimized out>) at startup_nat.c:165
>> #13 caml_startup (argv=<optimized out>) at startup_nat.c:170
>> #14 caml_main (argv=<optimized out>) at startup_nat.c:177
>> #15 0x00000000005f3ddc in main (argc=<optimized out>, argv=<optimized out>) at main.c:44
> 
> Thierry has found the problem.  I will push the solution shortly to
> github.  We can make a new release if you need that.
>

Thank you! I don't need a new release. But if there is a way to slightly change the pattern
to avoid the crash this will be useful to me.

Regards,
Denis
