Return-Path: <SRS0=IHaO=HN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83515C433DB
	for <cocci@archiver.kernel.org>; Thu, 11 Feb 2021 12:09:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C914564E79
	for <cocci@archiver.kernel.org>; Thu, 11 Feb 2021 12:09:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C914564E79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11BC9F4X010909;
	Thu, 11 Feb 2021 13:09:15 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3651C77AC;
	Thu, 11 Feb 2021 13:09:15 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 61F0874AF
 for <cocci@systeme.lip6.fr>; Thu, 11 Feb 2021 13:09:13 +0100 (CET)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com
 [209.85.208.169])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11BC9Ca5021780
 for <cocci@systeme.lip6.fr>; Thu, 11 Feb 2021 13:09:12 +0100 (CET)
Received: by mail-lj1-f169.google.com with SMTP id v6so2421857ljh.9
 for <cocci@systeme.lip6.fr>; Thu, 11 Feb 2021 04:09:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=I8ZJxMR7FqrroVuPQaN8sXYHBVFT0NtngaOtp03NhBo=;
 b=ghaTeq7WWRs51jjz88Dg2BeJ+t371s4ZqCfLBg2Jr985hd1rvXS8VQgRXbSQIywz2C
 LsupbXgZENf1kyLlcGPrNu/cQ0fWN/huHTT2jymeE45rW0WgifkNN0yxDkVB+BHYB0sw
 hIJNHRs4xGHgQCNhxx9A0yloRg+ocE1qD3tdk4lFblPsNWMa8xuf7uxa2SvcBr5EhRyX
 3+8mcNmLhbLnFNDaV/2fifn5geZkn4Q2pEjSxFGAcb6wObbxLIKIrS8MMt5/yiJQEmHb
 C1yxS2MpaDAEH24Iuthc4pvste0u0LNn5oPLE6cvhxe7Z3rlw4ovJRlpdxWbwVhXvDBg
 NFIg==
X-Gm-Message-State: AOAM533Hz1eI8UMAtggMFO59pWV06Tzcsc3j5JNkPyHD1LKsQLh/Z6XN
 51/ps9nPfmc04G+gljYBb59UwJ7O7Ckfmg==
X-Google-Smtp-Source: ABdhPJxGmUsrCATKvy18b5pf5rR/VLrobDlOuACjbLYfwoAiHtDYRDfBztvUoTVx0pKzL+j0lS404w==
X-Received: by 2002:a2e:5046:: with SMTP id v6mr4593978ljd.439.1613045351679; 
 Thu, 11 Feb 2021 04:09:11 -0800 (PST)
Received: from [10.68.32.147] (broadband-188-32-236-56.ip.moscow.rt.ru.
 [188.32.236.56])
 by smtp.gmail.com with ESMTPSA id 127sm629421lfm.155.2021.02.11.04.09.10
 for <cocci@systeme.lip6.fr>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Feb 2021 04:09:11 -0800 (PST)
To: cocci@systeme.lip6.fr
From: Denis Efremov <efremov@linux.com>
Message-ID: <0c2a01f3-e48b-fc67-78b4-f061026aec42@linux.com>
Date: Thu, 11 Feb 2021 15:09:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 11 Feb 2021 13:09:16 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 11 Feb 2021 13:09:12 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Backward compatibility issue
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

Hi, one of my patterns started to fail tests on latest coccinelle.
I've bisected the commit that introduces "error". It's:
commit db60e916633d2cb3ae31140364783fdf85ed10f4
"make information about SmPL iterator and declarer names available to the C parser"

To reproduce the error:
$ cd linux
$ git checkout 5b01014759991887b1e450c9def01e58c02ab81b
$ wget https://raw.githubusercontent.com/evdenis/cvehound/master/cvehound/cve/CVE-2016-9793.cocci
$ spatch -D detect --cocci-file CVE-2016-9793.cocci net/core/sock.c
# spatch before db60e916633d2cb3ae31140364783fdf85ed10f4 will find the match
net/core/sock.c:718:16-17: ERROR: CVE-2016-9793
net/core/sock.c:754:16-17: ERROR: CVE-2016-9793
...
# spatch >= db60e916633d2cb3ae31140364783fdf85ed10f4 will not match the same code

Thanks,
Denis
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
