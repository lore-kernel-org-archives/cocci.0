Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A5FC433F5
	for <cocci@archiver.kernel.org>; Sun,  6 Feb 2022 20:38:14 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,348,1635199200"; 
   d="scan'208";a="19956329"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2022 21:38:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F3248E0384; Sun,  6 Feb 2022 21:38:12 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0B670E037F
	for <cocci@sympa.inria.fr>; Sun,  6 Feb 2022 21:38:11 +0100 (CET)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=efremov@linux.com; spf=Pass smtp.mailfrom=yefremov.denis@gmail.com; spf=None smtp.helo=postmaster@mail-lf1-f43.google.com
IronPort-SDR: JlIXhkOAcuRFDxW9SNgjJBIGsftPYnPFuVB3erLblli3oef6Ih+rMcW+DgTeCjspVFspXjTu4h
 G5OBxnkSmPnBx1Ey5wHgwS9DJC9ChtUB7yfA6Jnpz00Ux/d9IhQsgLEhfaBKlhuj5sky/LZvXt
 5iMoEf8old4U0AM3hURPQeOvB5vWTYZJmzqa/8IktbnhWM2+01XgnI1/9i1uX1Oz8ocFN4nSG8
 TVfyEKoJ0SGsJhKwib9dL1lT4QbsrTKS6NK1M2CoToBi4X8NTdBE7W5a+g4vkhGAv0qSiYB0Sc
 x+yzfSKAteiBpfru4C/AevpC
X-IPAS-Result: =?us-ascii?q?A0CWAQB7MABifyunVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VqCKIFVKwSFIY5xgXcuA5xngXMBAwELAQFBBAEBhSiDQQIdBwEENBMBAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAwEBBQEBAQIBAQIDBAETAQENCwkHCAoHDg4FYAFFYwGBT?=
 =?us-ascii?q?gGBdwgDAT2CNSkBg2QBBRIRVhALGAICJgICNAEFARwGDQgBAR6CYoMXBJ9Ig?=
 =?us-ascii?q?QQ9ijh6gTGBAYl9CQEIfiqMUIFjJxyCDYEVJ4MDPmmDQoMygmUEkwSBDQGBc?=
 =?us-ascii?q?DhAOpIDjxKeZoNQhA2bPQYPBS6WKxSBJZAplkqmRwIKBwYQI4FVgX4zGggbF?=
 =?us-ascii?q?YMlTQECAQEBDQECAgECAQIBAgEIAQECAZ0sawIGCwEBAwmQTwEB?=
IronPort-PHdr: A9a23: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
 klRqY4=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:h+/oqa4JP8+r4mt23APXwK/XdLJyesId70hD6qm+c3xom62j5q
 KTdZsguSMc5Ax+ZJhCo6HiBEDjex7hHPdOiOF7V4tKNzOIhILHFuBf0bc=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,348,1635199200"; 
   d="scan'208";a="5157923"
X-MGA-submission: =?us-ascii?q?MDG6BgvERGO0XjL4bMWcKmeaMeLyjs3+8e+yQE?=
 =?us-ascii?q?8dauO4G8dbewptZIyXADD7qd7fpc6Ad2UpeSlBCyvj/zFAHZw4gdjBFu?=
 =?us-ascii?q?cfYOnKt+hudP23A7V8gUEcOEBKuQiLapwB45Dsvuh54kj/2hdwl3u/xd?=
 =?us-ascii?q?K30KWus9xOaYD9qxsB77bDQQ=3D=3D?=
Received: from mail-lf1-f43.google.com ([209.85.167.43])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 21:38:10 +0100
Received: by mail-lf1-f43.google.com with SMTP id z19so23107632lfq.13;
        Sun, 06 Feb 2022 12:38:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7NhQUZTuSFTVCYDD5B4IfXltmbVr4dt6QxRVdm0cs7w=;
        b=DLyeKIjRxvK4py2PM7DQsnk5tXDffreBN9hZhF2tDsUef4C+3lXyZjLZwK4/W/JLlB
         QAQ0Ou+8V4gKPTQA5qK+Km33ppZ9X9wIStFNo0Ikhuzhc2fG6lXuJftAKwkL57dZpWV2
         KqoACyn0t2OlMMDDnNBUD6FZeoySs13CdzIqt7ErEtMt6iGMWGYRlSUlb+glpufE21P0
         rYUx6Sp3KzW8wtjAUtGzP3yDdgAoJ33gEuN6hlP+DZBhnuOOtUEOglAI+LnK86I5Af56
         LoBIynSAyXblsq6skRlclKftS3Zj+g+D6jsbCGMNZI5mI7E6r24JkUXKjgIpAzv9FC97
         OX+w==
X-Gm-Message-State: AOAM530Xx8iRPuxmVVJerI5YsE2MJ8MShpfo6F9Y4wjvP8lva5x8q65N
	fg/xaPZmmav/2dpV0DkxblhLIli9XhU=
X-Google-Smtp-Source: ABdhPJzdlZnroIgqV68HkqyxWkE3NDAirMOzRio7eetd9IDiMFSKZbV62j8/604cbg/YBcsfdBTCzQ==
X-Received: by 2002:a19:c201:: with SMTP id l1mr6292011lfc.485.1644179887913;
        Sun, 06 Feb 2022 12:38:07 -0800 (PST)
Received: from [10.68.32.40] (broadband-109-173-81-86.ip.moscow.rt.ru. [109.173.81.86])
        by smtp.gmail.com with ESMTPSA id g8sm1221169lfr.13.2022.02.06.12.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 12:38:07 -0800 (PST)
Message-ID: <412f6138-c5de-38f4-553b-6b34a0650005@linux.com>
Date: Sun, 6 Feb 2022 23:38:06 +0300
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
From: Denis Efremov <efremov@linux.com>
In-Reply-To: <alpine.DEB.2.22.394.2202062047220.3126@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] spatch 1.1.1 segmentation fault report
Reply-To: Denis Efremov <efremov@linux.com>
X-Loop: cocci@inria.fr
X-Sequence: 128
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-02/412f6138-c5de-38f4-553b-6b34a0650005%40linux.com>



On 2/6/22 22:48, Julia Lawall wrote:
> 
> 
> On Sun, 6 Feb 2022, Denis Efremov wrote:
> 
>>
>>
>> On 2/6/22 21:43, Julia Lawall wrote:
>>>
>>>
>>> On Sun, 6 Feb 2022, Denis Efremov wrote:
>>>
>>>> Hi,
>>>>
>>>> I'm observing a weird crash with spatch 1.1.1
>>>>
>>>> $ spatch --version
>>>> spatch version 1.1.1 compiled with OCaml version 4.11.2
>>>> Flags passed to the configure script: --enable-opt --enable-ocaml --enable-python --enable-pcre-syntax --enable-pcre --prefix /home/work/.opam/4.11.2 --libdir /home/work/.opam/4.11.2/lib
>>>> OCaml scripting support: yes
>>>> Python scripting support: yes
>>>> Syntax of regular expressions: PCRE
>>>>
>>>> $ cat segfault.cocci
>>>> @err@
>>>> position p;
>>>> @@
>>>>
>>>> amd_energy_is_visible(...)
>>>> {
>>>> *       return 0444;@p
>>>> }
>>>>
>>>> @script:python@
>>>> p << err.p;
>>>> @@
>>>>
>>>> coccilib.report.print_report(p[0], "found")
>>>>
>>>> $ mkdir empty_dir # creating empty directory
>>>> $ spatch segfault.cocci empty_dir
>>>> init_defs_builtins: /home/work/.opam/4.11.2/lib/coccinelle/standard.h
>>>> 0 files match
>>>> [1]    152475 segmentation fault (core dumped)  spatch segfault.cocci test
>>>
>>> I tried 1.1.1 with the options --enable-opt --enable-ocaml --enable-python
>>> --enable-pcre-syntax --enable-pcre, but it seems to work find for me.
>>> Does the problem go away if there is a file in the directory?  If you
>>> remove the python code?
>>
>> It doesn't crash if I run it on the linux kernel sources on commits prior to
>> 9049572fb145 hwmon: Remove amd_energy driver
>>
>>
>> $ git checkout 9049572fb145~
>> # there is amd_energy_is_visible in drivers/hwmon/amd_energy.c
>> # spatch doesn't crash on this commit
>>
>> $ git checkout 9049572fb145
>> # no amd_energy_is_visible in kernel source
>> # spatch crashes
>>
>> If I remove python code then spatch doesn't crash.
> 
> Maybe try with --debug.  Or try without the p[0] in the python code.
I removed coccilib.report.print_report(p[0], "found")

$ spatch --debug segfault.cocci .
init_defs_builtins: /home/work/.opam/4.11.2/lib/coccinelle/standard.h
-----------------------------------------------------------------------
processing semantic patch file: segfault.cocci
with isos from: /home/work/.opam/4.11.2/lib/coccinelle/standard.iso
-----------------------------------------------------------------------
@err@
position p;
@@

amd_energy_is_visible(...)
{
*       return 0444;@p
}

@script:python@
p << err.p;
@@


-----------------------------------------------------------------------
script  = 
-----------------------------------------------------------------------
dependencies for script satisfied:
binding in = []
Initializing python
%!
0 files match
Check duplication for 0 files
Finalizing python

[1]    174812 segmentation fault (core dumped)  spatch --debug segfault.cocci .
