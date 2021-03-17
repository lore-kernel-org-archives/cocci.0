Return-Path: <SRS0=Sj7A=IP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD2BC433DB
	for <cocci@archiver.kernel.org>; Wed, 17 Mar 2021 19:57:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0609A64EEC
	for <cocci@archiver.kernel.org>; Wed, 17 Mar 2021 19:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0609A64EEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12HJuSV2013239;
	Wed, 17 Mar 2021 20:56:29 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A2D1C77CD;
	Wed, 17 Mar 2021 20:56:28 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2A63B24DD
 for <cocci@systeme.lip6.fr>; Wed, 17 Mar 2021 20:56:27 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12HJuQ7H022364
 for <cocci@systeme.lip6.fr>; Wed, 17 Mar 2021 20:56:26 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id j18so3086843wra.2
 for <cocci@systeme.lip6.fr>; Wed, 17 Mar 2021 12:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=QayY/bS4bLl4JfWOsYVrTrq3ni+OykeyXzo0MlhQaW0=;
 b=XOTCyYSG7VgdtTaofCJYbvgbtSDgqU8n7ZVM7MnbRtjzAHthrErxlnLe+oUCIJZZJo
 ViD0fabhXTtxd6Ycj62UyZGySBQQ6tMU7vV/CipkOzvbTRwLXvGkN2wc1DXajVMV5cyT
 m0RJxeEhdjm0kB0XRDnZOn+xGqRP/ZfyDrsC8IvUFbhjIRTt6wuI+8EhL4fY9whfmXtp
 gDlEVqDxtS1pVGDLExAnkkBHEsBAp1fNr4TWsEYgeMDjDNMKAQj9wTXGWxuYtMjBHyHM
 9MaXOM3+9LXsiB4zmef4sUjjgcKcWep7goQuULd9dcsAFbbhEXeC5CR5VE42QmLeEgVI
 gYAA==
X-Gm-Message-State: AOAM5336ex6Pr7LpaJVKL/Zq4YwLXDAalEJMKFDz1pXuywA6QzPco47j
 sD5kDiIK9l0EwWHy4NhiEBw=
X-Google-Smtp-Source: ABdhPJyc/5gVa8T/HlaEpzi2xbn6PfGA52saDPgOecjjGNi1eQkXBypNip/oDWGzjTQzd2ziVcSUOA==
X-Received: by 2002:a05:6000:10c5:: with SMTP id
 b5mr5930421wrx.347.1616010986641; 
 Wed, 17 Mar 2021 12:56:26 -0700 (PDT)
Received: from [10.68.32.147] (broadband-188-32-236-56.ip.moscow.rt.ru.
 [188.32.236.56])
 by smtp.gmail.com with ESMTPSA id n6sm31153665wrw.63.2021.03.17.12.56.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Mar 2021 12:56:26 -0700 (PDT)
To: cocci@systeme.lip6.fr, Julia Lawall <julia.lawall@inria.fr>
From: Denis Efremov <efremov@linux.com>
Message-ID: <c62bd578-1f83-d876-d6f1-cc39513ecbd9@linux.com>
Date: Wed, 17 Mar 2021 22:56:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 17 Mar 2021 20:56:30 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 17 Mar 2021 20:56:26 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Incorrect match with when != condition
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Hi,

I'm trying to write the check to detect the absence of commit
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=51b2ee7d006a736a9126e8111d1f24e4fd0afaa6
in kernel. The pattern can be:

@err exists@
identifier namlen, dchild, dparent, exp;
position p;
statement S;
@@

compose_entry_fh(..., int namlen, ...)
{
	...
	if (namlen == 2) {
*		dchild =@p dget_parent(dparent);
		... when != dparent == exp->ex_path.dentry
	} else S
	...
}

But unfortunately, it matches even the fixed source. I think
that condition "... when != dparent == exp->ex_path.dentry" doesn't
work as expected. Steps to reproduce:

$ cd linux # latest master branch
$ wget https://raw.githubusercontent.com/evdenis/cvehound/b2d109c959c299dce10274c1806406fc5653e5d0/cvehound/cve/CVE-2021-3178.cocci
$ spatch -D detect --cocci-file CVE-2021-3178.cocci fs/nfsd/nfs3xdr.c
fs/nfsd/nfs3xdr.c:935:10-11: ERROR: CVE-2021-3178
diff =
--- fs/nfsd/nfs3xdr.c
+++ /tmp/cocci-output-526900-b87df1-nfs3xdr.c
@@ -932,7 +932,6 @@ compose_entry_fh(struct nfsd3_readdirres
  
         if (isdotent(name, namlen)) {
                 if (namlen == 2) {
			// !!! shouldn't match because of if (dparent == exp->ex_path.dentry) goto out; check after
-                       dchild = dget_parent(dparent);
                         /*
                          * Don't return filehandle for ".." if we're at
                          * the filesystem or export root:
$ spatch --version
spatch version 1.1.0 compiled with OCaml version 4.11.1

Thanks,
Denis
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
