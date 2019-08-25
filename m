Return-Path: <SRS0=RP4p=WV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709B0C3A5A1
	for <cocci@archiver.kernel.org>; Sun, 25 Aug 2019 18:59:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E0D206E0
	for <cocci@archiver.kernel.org>; Sun, 25 Aug 2019 18:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E0D206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7PIxGtt001999;
	Sun, 25 Aug 2019 20:59:16 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DAF8976C5;
	Sun, 25 Aug 2019 20:59:15 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1456E7694
 for <cocci@systeme.lip6.fr>; Sun, 25 Aug 2019 20:59:14 +0200 (CEST)
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7PIxCJD006641
 for <cocci@systeme.lip6.fr>; Sun, 25 Aug 2019 20:59:13 +0200 (CEST)
Received: by mail-lf1-f65.google.com with SMTP id h27so4748548lfp.2
 for <cocci@systeme.lip6.fr>; Sun, 25 Aug 2019 11:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HC8F/9/UXZritXuADo9xVPlkrJhuLUNcByy7bFV18Rw=;
 b=lNcaT/+SwaEYg77jVlCMktlVfAYBfkzd0eKKv7ltCimlkDfWgnMV7vk8LwTttHheNv
 U/XpEvm10hKQVevqqBn0KdMQp6khRn6T9m5qj0hykuRpw2NdaewOLWLaREgITUaiFR6B
 MoTzWojT8QnKF6DJtrdTrrZyN2Ob6wrj2V6u81bBwkiBLCLRxtzu4BFaJQ2HNHCWuH8Q
 7mSV4StqphAS3RN6ZUCVgmrfD9KFRItK+7s4sSR3uot1wiygCWhFzdt4U6KjdmOgBzzv
 TW3BMB3fwEotnv2iFzRP0I3wYfS7rN0kSKjIgLRE0GjlBaQtNZbP8mX8ZbjjXEDL2uoS
 qTjQ==
X-Gm-Message-State: APjAAAVo/Kk6+ErXVAXsWnX6RNHC21kKeHbSLZThiX00wfYrnor1HmPX
 6MbcmT+Lh17RJznGIfNpuJM=
X-Google-Smtp-Source: APXvYqy0lzSO8Su8977hmLw1VHWRN5y3e54ruphdf/hNQj2Owwt2sjkRF+a57EULQciGQ/5U2NIsGQ==
X-Received: by 2002:a19:7515:: with SMTP id y21mr161268lfe.129.1566759552735; 
 Sun, 25 Aug 2019 11:59:12 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru.
 [188.32.48.208])
 by smtp.gmail.com with ESMTPSA id a20sm1666375ljk.34.2019.08.25.11.59.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Aug 2019 11:59:12 -0700 (PDT)
To: Joe Perches <joe@perches.com>, cocci@systeme.lip6.fr
References: <20190825130536.14683-1-efremov@linux.com>
 <b5bae2981e27d133b61d99b08ee60244bf7aabe3.camel@perches.com>
From: Denis Efremov <efremov@linux.com>
Message-ID: <88f6e48e-1230-9488-a973-397f4e6dfbb5@linux.com>
Date: Sun, 25 Aug 2019 21:59:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b5bae2981e27d133b61d99b08ee60244bf7aabe3.camel@perches.com>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 25 Aug 2019 20:59:16 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 25 Aug 2019 20:59:13 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] scripts: coccinelle: check for !(un)?likely
	usage
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr



On 25.08.2019 19:37, Joe Perches wrote:
> On Sun, 2019-08-25 at 16:05 +0300, Denis Efremov wrote:
>> This patch adds coccinelle script for detecting !likely and !unlikely
>> usage. It's better to use unlikely instead of !likely and vice versa.
> 
> Please explain _why_ is it better in the changelog.
> 

In my naive understanding the negation (!) before the likely/unlikely
could confuse the compiler and the initial branch-prediction intent
could be "falsified". I would say that either you need to move the
negation under the bracket "!unlikely(cond) -> unlikely(!cond)" or
you need to use likely instead "!unlikely(cond) -> likely(cond)".
However, I'm not a compiler expert to state that this is a general
rule. But, we've got 2 special macro for branch predicting, not one.
There is also ftrace in-between. I will try to do some simple
benchmarking.
 
> btw: there are relatively few uses like this in the kernel.
> 
> $ git grep -P '!\s*(?:un)?likely\s*\(' | wc -l
> 40
> 
> afaict: It may save 2 bytes of x86/64 object code.
> 
> For instance:
> 
> $ diff -urN kernel/tsacct.lst.old kernel/tsacct.lst.new|less
> --- kernel/tsacct.lst.old       2019-08-25 09:21:39.936570183 -0700
> +++ kernel/tsacct.lst.new       2019-08-25 09:22:20.774324886 -0700
> @@ -24,158 +24,153 @@
>    15:  48 89 fb                mov    %rdi,%rbx
>         u64 time, delta;
>  
> -       if (!likely(tsk->mm))
> +       if (unlikely(tsk->mm))
>    18:  4c 8d ab 28 02 00 00    lea    0x228(%rbx),%r13
>    1f:  e8 00 00 00 00          callq  24 <__acct_update_integrals+0x24>
>                         20: R_X86_64_PLT32      __sanitizer_cov_trace_pc-0x4
>    24:  4c 89 ef                mov    %r13,%rdi
>    27:  e8 00 00 00 00          callq  2c <__acct_update_integrals+0x2c>
>                         28: R_X86_64_PLT32      __asan_load8_noabort-0x4
> -  2c:  4c 8b bb 28 02 00 00    mov    0x228(%rbx),%r15
> -  33:  4d 85 ff                test   %r15,%r15
> -  36:  74 34                   je     6c <__acct_update_integrals+0x6c>
> +  2c:  48 83 bb 28 02 00 00    cmpq   $0x0,0x228(%rbx)
> +  33:  00 
> +  34:  75 34                   jne    6a <__acct_update_integrals+0x6a>
>                 return;

I think it's incorrect to say so in general. For example, on x86/64:

$ make mrproper
$ make allyesconfig
$ make && mv vmlinux vmlinux-000
$ make coccicheck MODE=patch COCCI=scripts/coccinelle/misc/unlikely.cocci | patch -p1
$ make 
$ ./scripts/bloat-o-meter ./vmlinux-000 ./vmlinux
add/remove: 0/0 grow/shrink: 3/4 up/down: 41/-35 (6)
Function                                     old     new   delta
dpaa2_io_service_rearm                       357     382     +25
intel_pmu_hw_config                         1277    1285      +8
get_sigframe.isra.constprop                 1657    1665      +8
csum_partial_copy_from_user                  605     603      -2
wait_consider_task                          3807    3797     -10
__acct_update_integrals                      384     373     -11
pipe_to_sendpage                             459     447     -12
Total: Before=312759461, After=312759467, chg +0.00%

It definitely influence the way the compiler optimizes the code.  

> 
> And here's a possible equivalent checkpatch test.
> ---
>  scripts/checkpatch.pl | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 287fe73688f0..364603ad1a47 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6529,6 +6529,24 @@ sub process {
>  			     "Using $1 should generally have parentheses around the comparison\n" . $herecurr);
>  		}
>  
> +# !(likely|unlikely)(condition) use should be (unlikely|likely)(condition)
> +		if ($perl_version_ok &&
> +		    $line =~ /(\!\s*((?:un)?likely))\s*$balanced_parens/) {
> +			my $match = $1;
> +			my $type =  $2;
> +			my $reverse;
> +			if ($type eq "likely") {
> +				$reverse = "unlikely";
> +			} else {
> +				$reverse = "likely";
> +			}
> +			if (WARN("LIKELY_MISUSE",
> +				 "Prefer $reverse over $match\n" . $herecurr) &&
> +			    $fix) {
> +				$fixed[$fixlinenr] =~ s/\Q$match\E\s*\(/$reverse(/;
> +			}
> +		}
> +
>  # whine mightly about in_atomic
>  		if ($line =~ /\bin_atomic\s*\(/) {
>  			if ($realfile =~ m@^drivers/@) {
> 
> 
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
