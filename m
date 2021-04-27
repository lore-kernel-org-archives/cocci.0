Return-Path: <SRS0=KM+6=JY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46170C43460
	for <cocci@archiver.kernel.org>; Tue, 27 Apr 2021 07:14:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AA3161166
	for <cocci@archiver.kernel.org>; Tue, 27 Apr 2021 07:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA3161166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 13R7ENJQ001273;
	Tue, 27 Apr 2021 09:14:23 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 04AE87634;
	Tue, 27 Apr 2021 09:14:23 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 59ED73DD8
 for <cocci@systeme.lip6.fr>; Tue, 27 Apr 2021 09:14:21 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:832])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 13R7EJwv028447
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 27 Apr 2021 09:14:20 +0200 (CEST)
Received: by mail-qt1-x832.google.com with SMTP id d12so5438010qtr.4
 for <cocci@systeme.lip6.fr>; Tue, 27 Apr 2021 00:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :in-reply-to:user-agent;
 bh=Ul/amy1bHrVXLikAjGzXREZ1oIVt1sWptxkpTRFpPRo=;
 b=e5OwNLtkXJvQ8DVoWOeOUvdDKSIuG/emEMWqxW/e3bj7iw21wa1Rg9sjwt792dt3p+
 QC7dTWOYw7FTOrSunKYbbKst8pfVD4xrT9SQzzt8jetlSNM7slE/xYu5Q3yq45amnHc6
 qvPOCf747toK0avb1KmFWRQuMC75f3jlY1d7tBGDBHmrj/Oq4ZpsUdV5d0XWcaIqcrdO
 isekdU3ZeqyyCKqbu5JBiKc6Ql+Gk76sH0igTwbLBHHfnRpNgVa2mzPeb2GJZjdM9kel
 YkCgN9pfb/B9wJKUvDJbPnPDYVmlpRI+QYXjS8CAHDjZoUPxUXFbzsGvW2dX3GTBQ0jp
 bxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Ul/amy1bHrVXLikAjGzXREZ1oIVt1sWptxkpTRFpPRo=;
 b=RrhE06h8YYQzGo1qptRCsP9pxTW0P5pMwUToSRm2G3K8TDEMJoGSTbGUwnnB8MeffK
 vawCyoY2ziFCaE/DFEx3KOZ2Ql87kZ8mqCzGEC/1D3Xkq6+fAxJzrOe0duVVe3sU0UpU
 goDrbYlJ6kOthCnVWG8JqTyztus1Z64K+nQk/WAaIuruIbpO2IBifYf0TUMIJkVFfraF
 32aBlWESWGveFQmZLWQ5M9zYJa7jTxI9BKokLGqg8xrJFtUWOwkrO1TPrYhywxuqOMlm
 AsvDS8neNyDTaoEhWr6WZMY3lyuV9S/my4kmulAgZC6MAvfI1lFbK0dXvjwzXHaFMn7t
 uY1Q==
X-Gm-Message-State: AOAM5319mzdyGZIYPkqQj05f7bncmDxl/udWdPTfMV5xNmq2t9V43U9O
 gJH0Al+B/uADrJVwYpp6zEk=
X-Google-Smtp-Source: ABdhPJxhe2AB9fJG9VYF8NhfyRAfPtI75kG/hNE1STEZiWu3LCbQp1Jcjdn5x/sSCntXEr30A5L8iQ==
X-Received: by 2002:ac8:5517:: with SMTP id j23mr20469185qtq.148.1619507659111; 
 Tue, 27 Apr 2021 00:14:19 -0700 (PDT)
Received: from theldus ([2804:d45:9905:9600:f66d:4ff:fe73:55f5])
 by smtp.gmail.com with ESMTPSA id y9sm2193786qkm.19.2021.04.27.00.14.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Apr 2021 00:14:18 -0700 (PDT)
Date: Tue, 27 Apr 2021 04:14:15 -0300
From: Davidson Francis <davidsondfgl@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>
Message-ID: <20210427071415.GA12067@theldus>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210306200541.3133-1-davidsondfgl@gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 27 Apr 2021 09:14:23 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 27 Apr 2021 09:14:20 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v2] scripts: coccicheck: Fix chain mode in
 coccicheck
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

On Sat, Mar 06, 2021 at 05:05:41PM -0300, Davidson Francis wrote:
> As described in the Coccinelle documentation (Documentation/dev-tools/
> coccinelle.rst), chain mode should try patch, report, context, and org
> modes until one of them succeed.
> 
> It turns out that currently, the 'run_cmd_parmap' function, by failing
> to run $SPATCH, rather than returning an error code, kills the execution
> of the script by executing the exit command, rather than returning the
> error code.
> 
> This way, when running coccicheck in chain mode, as in:
>     $ make coccicheck MODE=chain
> 
> the first .cocci file that does not support one of the virtual rules
> stops the execution of the makefile, rather than trying the remaining
> rules as specified in the documentation.
> 
> Therefore, modify the coccicheck script to return the error code,
> rather than terminating the script. When returning the error code,
> it returns the same value obtained in run_cmd, instead of the
> generic value '1'.
> 
> Signed-off-by: Davidson Francis <davidsondfgl@gmail.com>
> ---
> Changes in v2:
> * Use the same return value from run_cmd as the exit value
> 
>  scripts/coccicheck | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 65fee63aeadb..165701657c5a 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -153,7 +153,7 @@ run_cmd_parmap() {
>  	err=$?
>  	if [[ $err -ne 0 ]]; then
>  		echo "coccicheck failed"
> -		exit $err
> +		return $err
>  	fi
>  }
>  
> @@ -251,14 +251,14 @@ coccinelle () {
>  	run_cmd $SPATCH -D context \
>  		$FLAGS --cocci-file $COCCI $OPT $OPTIONS               || \
>  	run_cmd $SPATCH -D org     \
> -		$FLAGS --cocci-file $COCCI $OPT $OPTIONS --no-show-diff || exit 1
> +		$FLAGS --cocci-file $COCCI $OPT $OPTIONS --no-show-diff || exit $?
>      elif [ "$MODE" = "rep+ctxt" ] ; then
>  	run_cmd $SPATCH -D report  \
>  		$FLAGS --cocci-file $COCCI $OPT $OPTIONS --no-show-diff && \
>  	run_cmd $SPATCH -D context \
> -		$FLAGS --cocci-file $COCCI $OPT $OPTIONS || exit 1
> +		$FLAGS --cocci-file $COCCI $OPT $OPTIONS || exit $?
>      else
> -	run_cmd $SPATCH -D $MODE   $FLAGS --cocci-file $COCCI $OPT $OPTIONS || exit 1
> +	run_cmd $SPATCH -D $MODE   $FLAGS --cocci-file $COCCI $OPT $OPTIONS || exit $?
>      fi
>  
>  }
> -- 
> 2.29.1
> 

Ping for review.

Regards,
Davidson Francis.

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
