Return-Path: <SRS0=lKqB=5J=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548BDC43331
	for <cocci@archiver.kernel.org>; Tue, 24 Mar 2020 13:04:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 962BA208D5
	for <cocci@archiver.kernel.org>; Tue, 24 Mar 2020 13:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962BA208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02OD4K5X017746;
	Tue, 24 Mar 2020 14:04:20 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 269C8781F;
	Tue, 24 Mar 2020 14:04:20 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 79C4E3B63
 for <cocci@systeme.lip6.fr>; Tue, 24 Mar 2020 13:48:13 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02OCmC9D027524
 (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 24 Mar 2020 13:48:12 +0100 (CET)
Received: from mail-qt1-f197.google.com ([209.85.160.197])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <gpiccoli@canonical.com>) id 1jGiwE-0002Fa-VH
 for cocci@systeme.lip6.fr; Tue, 24 Mar 2020 12:46:03 +0000
Received: by mail-qt1-f197.google.com with SMTP id f7so4942806qtq.3
 for <cocci@systeme.lip6.fr>; Tue, 24 Mar 2020 05:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=1gaGCSvbUvFxUDYFtFdzOfLzBRbgwsoBtcQn8FrobJE=;
 b=mtFdQOQPsZrCzdWwU1BmfDo9ZC002SVhndgq/fbwni1yXbF4yE3bkpaOV+bPJ3+3zE
 q/2WDIofQ2Kn6wNTcsMov+RrBSi2UCyID0uQy2flwl5DvqmJzxF+vXRxdkgokO3N8kP+
 KjTsYs++yk+3ZkdbAWG7ZNREjbkT2Sv0P0+AKtvzW9rwXy7xFlPMK6cJOi7YHlgcQg9J
 RlUmIiZmcJQb8Y5/dkTD8m7DefjiSiaYLy0lxWlQcwCIMttYpki7EsGBbyH2mr0Pqjrf
 NMzSHccyRMNwd6jpmEDSyMnuQQtDxHZztzziCGgrFDZh/eAcQb+2emlgCp6B5jfBtvBZ
 6V0A==
X-Gm-Message-State: ANhLgQ0r0lgGNor64la5NwK/luNbPAw7HVMfBWIO8LCrG1r3m8KTjCT2
 AWubkn6JhJkvI5I/+0sr9OJtotHvVCwhMOEnJ9LFE+hH9tWeO8bSyDSACHGkR+xsXAR6taQ6uco
 pDOHvjChUFSvxeT9IW54EXHRwhdEO51Gb
X-Received: by 2002:ac8:7a72:: with SMTP id w18mr13890597qtt.260.1585053946094; 
 Tue, 24 Mar 2020 05:45:46 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsJTKeG/ltjtIrAmk7rWlgqC0MDN+DIYegBWmCgJY1czFa1TCerbdXmWy488e+x3QMi/tk5bw==
X-Received: by 2002:ac8:7a72:: with SMTP id w18mr13890575qtt.260.1585053945833; 
 Tue, 24 Mar 2020 05:45:45 -0700 (PDT)
Received: from [192.168.1.75] (189-47-87-73.dsl.telesp.net.br. [189.47.87.73])
 by smtp.gmail.com with ESMTPSA id
 t71sm13463643qke.55.2020.03.24.05.45.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 24 Mar 2020 05:45:45 -0700 (PDT)
To: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200323214618.28429-1-gpiccoli@canonical.com>
 <b73a6519-0529-e36f-fac5-e4b638ceb3cf@suse.cz>
From: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gpiccoli@canonical.com; prefer-encrypt=mutual; keydata=
 mQENBFpVBxcBCADPNKmu2iNKLepiv8+Ssx7+fVR8lrL7cvakMNFPXsXk+f0Bgq9NazNKWJIn
 Qxpa1iEWTZcLS8ikjatHMECJJqWlt2YcjU5MGbH1mZh+bT3RxrJRhxONz5e5YILyNp7jX+Vh
 30rhj3J0vdrlIhPS8/bAt5tvTb3ceWEic9mWZMsosPavsKVcLIO6iZFlzXVu2WJ9cov8eQM/
 irIgzvmFEcRyiQ4K+XUhuA0ccGwgvoJv4/GWVPJFHfMX9+dat0Ev8HQEbN/mko/bUS4Wprdv
 7HR5tP9efSLucnsVzay0O6niZ61e5c97oUa9bdqHyApkCnGgKCpg7OZqLMM9Y3EcdMIJABEB
 AAG0LUd1aWxoZXJtZSBHLiBQaWNjb2xpIDxncGljY29saUBjYW5vbmljYWwuY29tPokBNwQT
 AQgAIQUCWmClvQIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDOR5EF9K/7Gza3B/9d
 5yczvEwvlh6ksYq+juyuElLvNwMFuyMPsvMfP38UslU8S3lf+ETukN1S8XVdeq9yscwtsRW/
 4YoUwHinJGRovqy8gFlm3SAtjfdqysgJqUJwBmOtcsHkmvFXJmPPGVoH9rMCUr9s6VDPox8f
 q2W5M7XE9YpsfchS/0fMn+DenhQpV3W6pbLtuDvH/81GKrhxO8whSEkByZbbc+mqRhUSTdN3
 iMpRL0sULKPVYbVMbQEAnfJJ1LDkPqlTikAgt3peP7AaSpGs1e3pFzSEEW1VD2jIUmmDku0D
 LmTHRl4t9KpbU/H2/OPZkrm7809QovJGRAxjLLPcYOAP7DUeltveuQENBFpVBxcBCADbxD6J
 aNw/KgiSsbx5Sv8nNqO1ObTjhDR1wJw+02Bar9DGuFvx5/qs3ArSZkl8qX0X9Vhptk8rYnkn
 pfcrtPBYLoux8zmrGPA5vRgK2ItvSc0WN31YR/6nqnMfeC4CumFa/yLl26uzHJa5RYYQ47jg
 kZPehpc7IqEQ5IKy6cCKjgAkuvM1rDP1kWQ9noVhTUFr2SYVTT/WBHqUWorjhu57/OREo+Tl
 nxI1KrnmW0DbF52tYoHLt85dK10HQrV35OEFXuz0QPSNrYJT0CZHpUprkUxrupDgkM+2F5LI
 bIcaIQ4uDMWRyHpDbczQtmTke0x41AeIND3GUc+PQ4hWGp9XABEBAAGJAR8EGAEIAAkFAlpV
 BxcCGwwACgkQzkeRBfSv+xv1wwgAj39/45O3eHN5pK0XMyiRF4ihH9p1+8JVfBoSQw7AJ6oU
 1Hoa+sZnlag/l2GTjC8dfEGNoZd3aRxqfkTrpu2TcfT6jIAsxGjnu+fUCoRNZzmjvRziw3T8
 egSPz+GbNXrTXB8g/nc9mqHPPprOiVHDSK8aGoBqkQAPZDjUtRwVx112wtaQwArT2+bDbb/Y
 Yh6gTrYoRYHo6FuQl5YsHop/fmTahpTx11IMjuh6IJQ+lvdpdfYJ6hmAZ9kiVszDF6pGFVkY
 kHWtnE2Aa5qkxnA2HoFpqFifNWn5TyvJFpyqwVhVI8XYtXyVHub/WbXLWQwSJA4OHmqU8gDl
 X18zwLgdiQ==
Message-ID: <eee335a2-e673-39bf-ae64-e49c66f74255@canonical.com>
Date: Tue, 24 Mar 2020 09:45:40 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b73a6519-0529-e36f-fac5-e4b638ceb3cf@suse.cz>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 24 Mar 2020 14:04:20 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Tue, 24 Mar 2020 13:48:12 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Tue, 24 Mar 2020 14:04:18 +0100
Cc: randy Dunlap <rdunlap@infradead.org>, keescook@chromium.org,
        linux-doc@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
        linux-api@vger.kernel.org, kernel@gpiccoli.net, cocci@systeme.lip6.fr,
        tglx@linutronix.de, yzaikin@google.com, akpm@linux-foundation.org
Subject: Re: [Cocci] [PATCH V2] kernel/hung_task.c: Introduce sysctl to
 print all traces when a hung task is detected
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

On 24/03/2020 05:27, Vlastimil Babka wrote:
> [...]
> Before adding a new thing as both kernel parameter and sysctl, could we perhaps
> not add the kernel parameter, in favor of the generic sysctl parameter solution?
> [1] There were no objections and some support from Kees, so I will try to send a
> new version ASAP that will work properly with all "static" sysctls - we don't
> need to be blocked by a full solution for dynamically registered sysctls yet, I
> guess?
> 
> Thanks,
> Vlastimil
> 
> [1] https://lore.kernel.org/linux-api/20200317132105.24555-1-vbabka@suse.cz/
> 

Thanks Randy and Vlastimil for the comments. I really liked your
approach Vlastimil, I agree that we have no reason to not have a generic
sysctl setting via cmdline mechanism - I'll rework this patch removing
the kernel parameter (same for other patch I just submitted).

If you can CC me on the new iterations of the generic sysctl patches
Vlastimil, I appreciate - I can maybe test that, I'd like to see it in
kernel.

Thanks,


Guilherme
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
