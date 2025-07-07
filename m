Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AED3C83F07
	for <cocci@archiver.kernel.org>; Mon,  7 Jul 2025 10:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=FUwuF8HC734SQaugIMlE3bfI7jkg3t1HUau2iwGTBX0=;
  b=rQTrbUhuIafw2GpWZC8t8AwqFFxklWlFZ+5otqA0NH1k+aZEawBqNXGq
   03+zIZes0gWEleXZW9iZUgd82uG9cPBp/WrtO17kzZOwyiF7c1OT8U5j7
   HulKLmXEZV+5Bc7HulEQ/TDKEnCXmm29vwzq3GsxpgYGcCYoiSEiQKtJG
   0=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.16,294,1744063200"; 
   d="scan'208";a="230596191"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jul 2025 12:15:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6765FE0AF1; Mon,  7 Jul 2025 12:15:31 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BD507E0157
	for <cocci@sympa.inria.fr>; Mon,  7 Jul 2025 12:15:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FUwuF8HC734SQaugIMlE3bfI7jkg3t1HUau2iwGTBX0=;
  b=B4yPBiAVqH8VTGNYgmQWZiZVkbCMBlQlyVgIAcTEyNnBnLZZv1J6FzDS
   O6YE76c75y2Ha1ph+0lFzbgfx7Q7Q4abLEgjgpo6WFTX6P8GtfD0GxNP+
   FTPkFlP1gydQJXE6Vg0a0LeKgOsefrZrfKtvGxwmCdgWce9JNLSgvBY/Z
   Q=;
X-IronPort-AV: E=Sophos;i="6.16,294,1744063200"; 
   d="scan'208";a="230596188"
Received: from lfbn-idf2-1-636-60.w86-246.abo.wanadoo.fr (HELO [192.168.1.12]) ([86.246.95.60])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 12:15:29 +0200
Message-ID: <61ad6417-fead-48e3-806f-957f3714d697@inria.fr>
Date: Mon, 7 Jul 2025 12:15:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: devnoname120 <devnoname120@gmail.com>,
 Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <7c65be39-dfc3-4b9c-9acd-dd94d1225db8@Spark>
 <alpine.DEB.2.22.394.2506291925100.95572@hadrien>
 <55f3b1f1-2537-4bc3-88d3-d7da1136060a@Spark>
 <alpine.DEB.2.22.394.2506292109470.95572@hadrien>
 <1a234d32-e87d-414b-8566-490618417f6c@Spark>
 <c08d6fa1-e53c-d21-7892-1132133087fb@inria.fr>
 <5d6b297d-2139-4732-acbd-92270ecfd4e7@Spark>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <5d6b297d-2139-4732-acbd-92270ecfd4e7@Spark>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] [HELP] Using macro `randomized_struct_fields_end` as
 context?
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2860
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/61ad6417-fead-48e3-806f-957f3714d697%40inria.fr>

Hi,

On 05/07/2025 12:09, devnoname120 wrote:
> Interestingly I seem to have an error on pkg-config:
> ❯ spatch --sp-file include/linux/sched.h.cocci --in-place 
> --linux-spacing include/linux/sched.h
> init_defs_builtins: 
> /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coccinelle/standard.h
> SPECIAL NAMES: adding u64 as a type
> Py.find_library_path: unable to parse the output of pkg-config 
> '-L/opt/homebrew/opt/python@3.13/Frameworks/Python.framework/Versions/3.13/lib'

I am looking into this error, but I can't reproduce it at the moment. 
Did you build coccinelle manually, or is this straight from your 
distribution package manager? If it's the former, can you let me know 
what your local changes are (the "-dirty" part of the --version output 
seems to indicate you have some uncommitted changes, they may be 
relevant). If it's the latter, could you tell me which one?

>  If I try to run this command manually:
> ❯ pkg-config 
> '-L/opt/homebrew/opt/python@3.13/Frameworks/Python.framework/Versions/3.13/lib'
> pkgconf: unknown option -- 
> L/opt/homebrew/opt/python@3.13/Frameworks/Python.framework/Versions/3.13/lib


I also cannot run this command manually.

Thanks,
Victor

> I'm using Coccinelle 1.3:
> ❯ spatch --version
> spatch version 1.3-dirty compiled with OCaml version 5.1.1
> Flags passed to the configure script: --disable-silent-rules 
> --enable-ocaml --enable-opt --without-pdflatex 
> --with-bash-completion=/opt/homebrew/Cellar/coccinelle/1.3.0/etc/bash_completion.d 
> --disable-debug --disable-dependency-tracking 
> --prefix=/opt/homebrew/Cellar/coccinelle/1.3.0 
> --libdir=/opt/homebrew/Cellar/coccinelle/1.3.0/lib
> OCaml scripting support: yes
> Python scripting support: yes
> Syntax of regular expressions: PCRE
> Paul
> On Jun 30, 2025 at 10:52 +0200, Julia Lawall <julia.lawall@inria.fr>, 
> wrote:
>> randomized_struct_fields_end will soon be supported in the C parser. It
>> is not currently supported in the semantic patch parser, but you can get
>> the same effect as illustrated by the example below.
>>
>> I will let you know when this is all available on github.
>>
>> julia
>>
>>
>> @@
>> field f : script:python () { f == "randomized_struct_fields_end" };
>> @@
>>
>> struct task_struct {
>> ...
>> + int something;
>> f
>> ...
>> };
