Return-Path: <SRS0=ltO7=HS=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908D5C433DB
	for <cocci@archiver.kernel.org>; Tue, 16 Feb 2021 18:15:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC96464E13
	for <cocci@archiver.kernel.org>; Tue, 16 Feb 2021 18:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC96464E13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11GIEUKv004303;
	Tue, 16 Feb 2021 19:14:30 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 924FE77C0;
	Tue, 16 Feb 2021 19:14:30 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9523139D7
 for <cocci@systeme.lip6.fr>; Tue, 16 Feb 2021 19:05:30 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11GI5UH7021085;
 Tue, 16 Feb 2021 19:05:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1613498729;
 bh=ZRfmMvXYJTRP0ZDpFlumr6HElOi6S3rRirx9PEI34Gg=;
 h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
 b=pziR7pYTz632CYlYOdlqnQgbjQNZabSH8IJHYm0RcvR7qF9c6NC0jE7LFCpc3xoEG
 pki/+Ll7McnkaCY2UimCl3jnnfM3eM8KNVaE27XWDvnU3ShoakeUl6EtEnAjwFjCPa
 LrFRtX6bvwT941H0lu0Ox3E5pz+CD7CrrALMln2k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.120.40]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MRW6L-1lXL0W2NbJ-00NPhX; Tue, 16
 Feb 2021 19:05:29 +0100
To: Denis Efremov <efremov@linux.com>, Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Coccinelle <cocci@systeme.lip6.fr>
References: <20210216080133.455456-1-efremov@linux.com>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <3f83062c-41f0-b621-95ef-3af277842309@web.de>
Date: Tue, 16 Feb 2021 19:05:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210216080133.455456-1-efremov@linux.com>
Content-Language: en-GB
X-Provags-ID: V03:K1:5TirUA0LlMFfjSir4aquYiQtckf1BO0DbJ8h3HUAdOxSXj0HQMJ
 NDFG9+ZaQ8Xal4c2D6E8XYmtAT6PPNGXiRBybnCJ8u2yG1qGHZ4NwDynNoUxtX2x9U0KJNW
 +NFS6p+uMwKedI6+EwwZoAH+77xFhpGevF9GLS9VywYBqtdOED9sX7vvEbzUv6BJi9hrZVN
 l4ABxgWJuRw4pZdcDS3Gg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KpvKzFLRLIk=:BXemFb3Z/KLKQGEnu7yhMs
 qMVZ9H8DTXM2G19mFTFfJQ3ggfUfFj+zXPanjTVK3PHmDf1thoWqh6Nb258fCwVR/mRx15wqg
 TfUEm4JR0iUccaaKXAv5ueQ+HLT0mPEttx4/dGWaY2nrZ9A4iPPMfqGqxZcNtCS4Ae91AYu2q
 +h6r/TSxpJl5Do/IIuTf37no4VtJWodoE9hxQBSqAWDR6yiXjIV95QHgvA7RnVTXXNwTaajGH
 wrTDP6uRO0QuzpAmkNfhZu+H2c3VG+x46XXA9HT2JQ+xByLPgII5oWfvb3VgV0VE0m3P+6oTC
 ICVCC+jtzTraAPN9edjowPMlIFCQYuJQAvgM2qFCkCCtNK8KzBrqmngBUGoyDH/uw5o5z/kMf
 8g/H+6Y6qhR0Ie3aQdbjlVQWrYNRRDN9Ip/xjEUHOkeqDjlUDhkxCnyu1c4qgQCETADUkOi+B
 5OFJduKuDzC2ysNSuJg/MdOkaOevRE6iOB74ebz18jHVA+wDL+vM3sbVAui44+9WHhCLAaZGh
 gn6fe58L5cckUEqSGomMgQArocgV6yNsq/SzPTndVWFlex9nQsmIrhp7nwgUl7BVxeXrdadVA
 d/XHE+M9gnB2eBPJVXcDaTYxq84g7AQNcUs4hZDt8Qh+hQcNWOz9iH/GfXKeJfo2wTo/3CMx1
 /j6tW1cdKVTzW9rcJjJUSSYAKh6AXR2jBfqAbJpaqZERvrENajoDSyjDq1KiOi/9WYE41Dx/d
 vqT8KtAoy6i6Mo8Jwn3R8NJyDIW8w5/UuaHeb3F6qAop0qF/yF0cvOwwHjBdTfP+0e1/43FEl
 zqV36tNE5NPPjHcDPG5oJBsbXQCJb8eezAt8/HovuFz+NaY1uMTv2UyboChtCrdUb86gTbj+k
 jSlRXTsqSlh9YShA4JBg==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 16 Feb 2021 19:14:31 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 16 Feb 2021 19:05:30 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Tue, 16 Feb 2021 19:14:29 +0100
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: misc: add swap script
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

> +- tmp = a;
> +- a = b;
> +- b = tmp;
> ++ swap(a, b);

How do you think about to use the following SmPL code variant?
* Omission of a few leading space characters
* Keeping a semicolon unmodified in a line

+-tmp = a;
+-a = b;
+-b = tmp
++swap(a, b)
+;


Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
