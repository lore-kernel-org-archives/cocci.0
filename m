Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B34C433F5
	for <cocci@archiver.kernel.org>; Tue, 29 Mar 2022 07:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=to:cc:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=AExd4vaFTbJ590yLTEsxZaq1Tm0Bzwb1nLh9ynuGeIw=;
  b=mIShv6Y0GGQpEPmKaeO0/u9lCe65rjlPU/01gUZUjVWo2an3UyCNmFh/
   EhYEHrlBZANxau34VwqGaD8LgSoGG+H5+gucjU3qR/+WPUCkW+hmmVTyR
   rXldaE5ycqdayiducDX/eq7t2TTnx4a0XVbL0+VHTbaQLe/m86Nr2HRf7
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linuxfoundation.org
X-IronPort-AV: E=Sophos;i="5.90,219,1643670000"; 
   d="scan'208";a="28809431"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Mar 2022 09:17:45 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 20FE1E437B; Tue, 29 Mar 2022 09:17:45 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AFF4DE436E
	for <cocci@sympa.inria.fr>; Tue, 29 Mar 2022 00:36:26 +0200 (CEST)
IronPort-SDR: qe9F0fo+WtdaJYekCkttjeu/ndZix2aiespXeJWtMBkV7aR90KXMLKp0aDRu3QtAR85oQcey5e
 7lG4yft9PG7onAv9i5zm4KLLFVr9oyxHaZw8Hwa9Uqj97j8AZV5TCHYIZngzeFZP1KVACyLOy8
 MFKuLY1qqSBRu+Y8k640KduKjo/FtYArWnfiYpi2CcDwaD2gfEQEfYuBmvr2g4qhIlh4tEExSv
 L3PeNYgSeXtZzxoOBgev5SYNKt8He4rL8TvRZ4AayyyGcDPkmqWhALS9RLHJ96dRQb6oOS1GSj
 UGaReZyU2sT41aarnBjILNbT
X-IPAS-Result: =?us-ascii?q?A0APAABON0JifzGmVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UYHAQELAYInflcrBE8DhFGIJohyA4sRkVOBfAsBAwELAQE5CgQBAYUHAoRQA?=
 =?us-ascii?q?h0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQENCwkHC?=
 =?us-ascii?q?AoCBQ4OBT5kaIFPgXQLBwYnDYI1KYNkAQEBAQIBEhEVCAEBNwEECwsYAgImA?=
 =?us-ascii?q?gIhEwEFARwGAQwGAgEBHoJiAYJlAw0hD6IFgQQ9ijh6gTGBAYIIAQEGgluCO?=
 =?us-ascii?q?A1ngVwJCQEIfiwBhhCEKIMXeiccgUlEgTyBFYFuPoIhQgSBPAEBIIMagkMil?=
 =?us-ascii?q?3o/NFMoExQIDwEgAi4EBBxAGQ06KZIeFI8+Yp0ua4NTiw+OaYVmBhQug3SBT?=
 =?us-ascii?q?4pmhhoUkW+EdJFoIIx2g1OQawuEfAIKBwYQI4E+ghUzGggoCIMkCUUBAgECD?=
 =?us-ascii?q?QECAgMBAgECCQEBAowugW8MFoY0gXU7hWkiNAIBNQIGCwEBAwmRYAEB?=
IronPort-PHdr: A9a23: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
 xGSlTxefmQFS/stpLRt7ExvYoy9
IronPort-Data: A9a23:YSRgea1hOVFlwuIx3vbD5QJ3kn2cJEfYwER7XKvMYLTBsI5bpzwHy
 TdJXzzQO6mLZmCjed9ybtywoR8GvceGzNQySAdt3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOH9IQMcacUsxLbVYMpBwJ1FQyw4bVvqYy2YLjW1jX6
 YuoyyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt9d09
 ehPn8DzdVdzJKyT2/lBfThbDj4raMWq+JefSZS+mcmazkmDcny1hvsyXQc5OooX/usxCmZLn
 RAaAGpVP1bT2qTvnuz9FrgEascLdKEHOKsEuXFpyxndDPA7UZ7EXqPG7MNZ2zF2gdpBdRrbT
 5BJNmQwNEieC/FJElw2KbYQur3yuib+UgxWhU+egIQU5meGmWSd15C0aIaPEjCQfu1emU2Tp
 0rd7mHhC1cbMsaewHyL6BqRavTnmCr6XMcTE+T9+KI7xlKUwWMXBVsdUl7TTeSFZlCWXNdiF
 k4+pmkS/fIo9RPoU4XTfh6lvyvR1vIDYOZ4H+o/4QCL76Pb5QeFG2QJJgKtjvR266faohR6h
 je0c8PV6S9H6+fIECnEnluAhXbjZHlNcjVqiTosFFNdu7HeTJcPYgUjpzqJOIW8iMHyH1kcK
 BjV8XFm3N3/YSP3vphXEHjCijOo45nOF0s7ulSRUWWi4Qd0IoWiYuRECGQ3D94Qfe51rXHb5
 xDofvRyCshQVPlhcwTTGo0w8EmBvartDdElqQcH82Md3zqs4WW/Wotb/StzIkxkWu5dJ2O5P
 BeO6VsJuccNVJdPUUORS9LuYyjN5fiwfekJqtiJBjazSsQpJF7epH8GibC4hjiyyxZEfV4D1
 WezKJ7wVx72+Ixoyz25Q+p17FPY7nFW+I8nfriil07P+ePGOha9EO5dWHPXN7xRxP7a/W39r
 okHX+PXmk03eLCvOUH/rN9DRXhUdyRTLc6t8KR/KLXTSjeK7Ul7VJc9N5t6K9I790mU/8+Ul
 kyAtrhwlQOn3CadeFzQAp2hAZu2NatCQbsAFXREFT6VN7ILOO5DNY8TKMk6e6cJ7utmwaImR
 vUJYZzRUPBOTCnX9TMAa5X0sI1lclKsnw3XZ3ipZz02fphBQQ3V+4a8J1OyrnJQVHq65Zkkv
 rmt9gLHWp5fFQ5sO8DbNaC0xFSrsHlBxe9/BhOaItRadEj23pJtLij90q0+L80WcESRwjqcy
 haYBgoeqeDRoogztt7Tivnc/YuuFuJ/GGtcHnXatO7vbXSApTT5kYIZCbSGZzHQUm/w6Z6OX
 +QNwqGuKuADkXZLr5F4T+Rhw5U46oa9vLRd1AllQCjGYln3WLNtJn6KgZtGuqFXnOQLvAK3X
 geO/YAfN+nYfsziF1EVKUwuaeHajaMYnTzb7PIUJkTm5X8ooODWDx0KZxTc2jZAKLZVMZ8+x
 btzssAh7QHi2AEhNcyLj3wJ+mnQfGYMVb4r6sMTDIPx0FF5z1hDZdndDXaz7s3eLdpLNUYuL
 3mfg6+b3+ZQwU/LcnwSE3nR3LoC2c5f5kgSlFJSdU6Untflh+Ms2EED+zoASAkInA5M1Ph+O
 zQ2OkB4TUlUE+yEWCSes6GQ9wB96Nmx/0Xwzx4IkzScQRX5EGPKK2I5NKCG+0VxH6ewuNRE1
 Onw9YoneW+CkALNMu8aXU9jtuztSsF3+gTemcehWcOfEPHWpBL717S2azNgRwTPWKsMaY6um
 QWu1OJxb7DrOykNpaEyF4id0/IXUh/syKmuhx1+1PthIFwwsw1eFdRDx45dty+NyzH3HZeEN
 vFT
IronPort-HdrOrdr: A9a23:7Gnv96DsuJYLVeHlHel155DYdb4zR+YMi2TDGXoBLCC9Afbo6/
 xG+85rqiMc6QxhJU3I/OrrBEDuewKkyXcY2/h3AV7mZnidhILKFvAY0WKB+UyHJ8SWzIc0vs
 ddmupFebnN5DBB7PoSizPIcOrIruP3kpxAyd2ut0uFjjsHV0ij1WpE48qgfXGejTMpOaYE
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,218,1643670000"; 
   d="scan'208";a="28767046"
X-MGA-submission: =?us-ascii?q?MDEVXcM4GpFte9B3mWQYxG0bYorJWWwh2/03Pt?=
 =?us-ascii?q?ZXhqLaLVGwL7Aw6Jh7MV4K2neNt/oU4Ll0z9DcAEC7J5jxbgCbhLjYbV?=
 =?us-ascii?q?M8Vq9aqw7nwWZ8YDxHO6H0XvEif2PP873OYLMD4fuUgu2DSKi/Vbd5qF?=
 =?us-ascii?q?3Zhoio6O+0LsdJN7Kqh9j4vA=3D=3D?=
Received: from mail-io1-f49.google.com ([209.85.166.49])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 00:36:25 +0200
Received: by mail-io1-f49.google.com with SMTP id g21so5738825iom.13
        for <cocci@inria.fr>; Mon, 28 Mar 2022 15:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AExd4vaFTbJ590yLTEsxZaq1Tm0Bzwb1nLh9ynuGeIw=;
        b=DTRFn7+l1UKGJysQuFvGqP5W+I598Bx27SczkLubNCt0VlS2qdgUPay/HmX8b6XpGC
         PTu66/GD01WGJz9u0XQ35hx2zataUVLZX413a+wYt3JptVnM1+bb2pnMkZFqWgVlM2je
         s4wGDP20Dm3uuXw4kmJXTzk4OU+xgUe94XwiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AExd4vaFTbJ590yLTEsxZaq1Tm0Bzwb1nLh9ynuGeIw=;
        b=69hbmhGRF4+sEgbGpdn1a3GQ0rtHq33pg3tZ+tt2E/ErCjlaldIPkm9laQHQBFnm5a
         +RZm7D94W3Cv/2mEarKRYAVHfTUuF/ChArl+6GYKtBYcIUY3w6duCtZEDgQUy0TtD5H6
         ztmCSC+UyYOJPOsTpuZhXag3RK3ErANH05biA7VQFn8J+tpP+tJx0+KUI22BI8Br+Tdt
         MFqRx4gf7kgIrWT6Ceb4e0jPE7nJ7fyCYmMI9OO5Hhvj1CsttTpp5qQWgUkQ7mYDFgW9
         prvBifqIbaB5gO2mlHq4FRxK7YRzl5sijyc6HOzwAHWNI2t0SAqFHaFjjAXNw5gCd49U
         eWTA==
X-Gm-Message-State: AOAM530KdP6aWAlwe+1g5r3mFVj5rlLBaqfW/AkmGUgF0SW/nNNkq5pF
	tb6ttpVKXBw9iKRAky5gVUknYg==
X-Google-Smtp-Source: ABdhPJxHgbesdx6T5wcEa6Fn7Cv//g3Oqi2VOyXANaYIxT1Jk5KGVgEj1yKkQN/+2BN4fxIYPra8Lw==
X-Received: by 2002:a02:cb0d:0:b0:321:4041:f680 with SMTP id j13-20020a02cb0d000000b003214041f680mr13781718jap.162.1648506983900;
        Mon, 28 Mar 2022 15:36:23 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id y20-20020a5d94d4000000b00640843474e2sm8434240ior.10.2022.03.28.15.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 15:36:23 -0700 (PDT)
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, corbet@lwn.net,
 mchehab+huawei@kernel.org, dlatypov@google.com, davidgow@google.com
Cc: linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org, cocci@inria.fr,
 smatch@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <YkImfPbNOzQBq5ZD@marsc.168.1.7>
From: Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6f1e410e-4b35-eb37-153a-8f5959ef0a49@linuxfoundation.org>
Date: Mon, 28 Mar 2022 16:36:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YkImfPbNOzQBq5ZD@marsc.168.1.7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] Documentation: dev-tools: Add a section for
 static analysis tools
Reply-To: Shuah Khan <skhan@linuxfoundation.org>
X-Loop: cocci@inria.fr
X-Sequence: 300
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/6f1e410e-4b35-eb37-153a-8f5959ef0a49%40linuxfoundation.org>

On 3/28/22 3:19 PM, Marcelo Schmitt wrote:
> Complement the Kernel Testing Guide documentation page by adding a
> section about static analysis tools.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
> Hey everyone,
> 
> I think this patch can be a good addition to the documentation as
> discussed in the thread for the testing guide documentation page:
> Link: https://lore.kernel.org/linux-doc/CABVgOS=2iYtqTVdxwH=mcFpcSuLP4cpJ4s6PKP4Gc-SH6jidgQ@mail.gmail.com/
> 
> If you think it would be worth it, I can try making something more
> elaborated. Maybe provide some guidance on when to use each tool.
> I've been studying how Linux device drivers are tested.
> Here's a post I wrote talking about some testing tools.
> Link: https://marcelosc.gitlab.io/how-is-linux-tested/
> 
> Best regards,
> Marcelo
> 

This a good addition to the testing overview doc. Please see a couple of
comments below

>   Documentation/dev-tools/testing-overview.rst | 29 ++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
> index 65feb81edb14..b00511109a9d 100644
> --- a/Documentation/dev-tools/testing-overview.rst
> +++ b/Documentation/dev-tools/testing-overview.rst
> @@ -115,3 +115,32 @@ that none of these errors are occurring during the test.
>   Some of these tools integrate with KUnit or kselftest and will
>   automatically fail tests if an issue is detected.
>   
> +Static Analysis Tools
> +======================
> +
> +In addition to testing a running kernel, one may also scout for bugs by
> +analyzing the source code semantics. Three tools are well known for serving this
> +purpose.
> +
> +Sparse can help test the kernel by performing type-checking, lock checking,
> +value range checking, in addition to reporting various errors and warnings while
> +examining the code. See the Documentation/dev-tools/sparse.rst documentation
> +page for details on how to use it.
> +> +Smatch extends Sparse and provides additional checks for programming logic
> +mistakes such as missing breaks in switch statements, unused return values on
> +error checking, forgetting to set an error code in the return of an error path,
> +etc. Smatch also has tests against more serious issues such as integer
> +overflows, null pointer dereferences, and memory leaks. See the project page at
> +http://smatch.sourceforge.net/.
> +
> +We also have Coccinelle as an option within static analyzers. Coccinelle is
> +often used to aid collateral evolution of source code, but it can also help to
> +avoid certain bugs that have been expressed semantically. The types of tests
> +available include API tests, tests for correct usage of kernel iterators, checks
> +for the soundness of free operations, analysis of locking behavior, and further
> +tests known to help keep consistent kernel usage. See the
> +Documentation/dev-tools/coccinelle.rst documentation page for details.
> +
> +These static analysis tools support running tests on the whole source tree or
> +over a specific file or directory.
> 

You can also add a couple of sentences along the lines to clarify why static
analysis is beneficial:

"It is easier to detect and fix problems during the development process."

Also add a word of caution:

"Static analysis tools suffer from false positives and errors and warns need to
  be evaluated carefully before attempting to fix them."
  
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
