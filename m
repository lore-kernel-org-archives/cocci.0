Return-Path: <SRS0=72o0=CI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDA3C433E6
	for <cocci@archiver.kernel.org>; Sun, 30 Aug 2020 06:57:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D08C32076D
	for <cocci@archiver.kernel.org>; Sun, 30 Aug 2020 06:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08C32076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07U6vULL023811;
	Sun, 30 Aug 2020 08:57:30 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CCE197789;
	Sun, 30 Aug 2020 08:57:30 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A00193F6C
 for <cocci@systeme.lip6.fr>; Sun, 30 Aug 2020 08:57:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07U6vTKU021287
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 30 Aug 2020 08:57:29 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; d="scan'208";a="465240887"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Aug 2020 08:57:28 +0200
Date: Sun, 30 Aug 2020 08:57:28 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Joe Perches <joe@perches.com>
In-Reply-To: <de28becbfe76575b18c0bf47567b7f9c20f15f87.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2008300854510.3629@hadrien>
References: <de28becbfe76575b18c0bf47567b7f9c20f15f87.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 30 Aug 2020 08:57:31 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 30 Aug 2020 08:57:29 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] transform oddity / bug ?
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



On Sat, 29 Aug 2020, Joe Perches wrote:

> Is it me not understanding cocci grammar again?

The problem is the loop.  You are trying to change something in the body
of a loop and the body of a for loop might not be executed.  ... means
that the thing must be found on every execution path.

Do you want to make the change in the function header even if there are
not changes in the body?  If so, <... ...> is what you are looking for.
If you want to be sure there is a change to make in the function body then
you can use <+... ...+> but it will be more expensive.

julia

>
> Given these input and cocci script files:
>
> Why isn't the show_test1 function transformed?
> Why is only the show_test2 function transformed?
>
> The only difference between the files is some
> commented out lines with a for loop and if test.
>
> $ cat test.c
> static ssize_t test1_show(struct device *d,
> 		struct device_attribute *a,
> 		char *buffer)
> {
> 	ssize_t rc = 0;
>
> 	for (cnt = 0; cnt < s_attr->size; cnt++) {
> 		if (cnt && !(cnt % 16)) {
> 			if (PAGE_SIZE - rc)
> 				buffer[rc++] = '\n';
> 		}
>
> 		rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "%02x ",
> 				((unsigned char *)s_attr->data)[cnt]);
> 	}
> 	return rc;
> }
>
> static ssize_t test2_show(struct device *d,
> 		struct device_attribute *a,
> 		char *buffer)
> {
> 	ssize_t rc = 0;
>
> //	for (cnt = 0; cnt < s_attr->size; cnt++) {
> //		if (cnt && !(cnt % 16)) {
> 			if (PAGE_SIZE - rc)
> 				buffer[rc++] = '\n';
> //		}
> 		rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "%02x ",
> 				((unsigned char *)s_attr->data)[cnt]);
> //	}
> 	return rc;
> }
> $ cat sysfs_emit_rename.cocci
> @@
> identifier d_show =~ "^.*show.*$";
> identifier arg1, arg2, arg3;
> @@
> ssize_t d_show(struct device *
> -	arg1
> +	dev
> 	, struct device_attribute *
> -	arg2
> +	attr
> 	, char *
> -	arg3
> +	buf
> 	)
> {
> 	...
> (
> -	arg1
> +	dev
> |
> -	arg2
> +	attr
> |
> -	arg3
> +	buf
> )
> 	... when any
> }
> $ spatch -sp-file sysfs_emit_rename.cocci test.c
> init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
> HANDLING: test.c
> diff =
> --- test.c
> +++ /tmp/cocci-output-68270-4c9b1f-test.c
> @@ -16,18 +16,18 @@ static ssize_t test1_show(struct device
>  	return rc;
>  }
>
> -static ssize_t test2_show(struct device *d,
> -		struct device_attribute *a,
> -		char *buffer)
> +static ssize_t test2_show(struct device *dev,
> +			  struct device_attribute *attr,
> +			  char *buf)
>  {
>  	ssize_t rc = 0;
>
>  //	for (cnt = 0; cnt < s_attr->size; cnt++) {
>  //		if (cnt && !(cnt % 16)) {
>  			if (PAGE_SIZE - rc)
> -				buffer[rc++] = '\n';
> +				buf[rc++] = '\n';
>  //		}
> -		rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "%02x ",
> +		rc += scnprintf(buf + rc, PAGE_SIZE - rc, "%02x ",
>  				((unsigned char *)s_attr->data)[cnt]);
>  //	}
>  	return rc;
> $
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
