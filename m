Return-Path: <SRS0=67nU=DO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70415C4363C
	for <cocci@archiver.kernel.org>; Wed,  7 Oct 2020 08:15:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96DE02076C
	for <cocci@archiver.kernel.org>; Wed,  7 Oct 2020 08:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+Js+118"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DE02076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0978EfQ9011033;
	Wed, 7 Oct 2020 10:14:41 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6910A769A;
	Wed,  7 Oct 2020 10:14:41 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D332A578C
 for <cocci@systeme.lip6.fr>; Wed,  7 Oct 2020 10:14:38 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:636])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0978Ecwi003150
 for <cocci@systeme.lip6.fr>; Wed, 7 Oct 2020 10:14:38 +0200 (CEST)
Received: by mail-pl1-x636.google.com with SMTP id bb1so625039plb.2
 for <cocci@systeme.lip6.fr>; Wed, 07 Oct 2020 01:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=aR/crGqpjngWx4uY4BPhbCIGGN5/NfXCrwfurQ6wFX8=;
 b=M+Js+118hi8DOmX4FZf6mM4Ib2Y7HqIbHABHKm5ceOi/4YB8ADUtyzTcFCLWJIiiNL
 d/PiaG1qaUaFVeft9/wdrewQBHyiiSYMZPUn1gsuMeeuMUEvfcU9m7VwDCW1JiGlMo1j
 3TSGkt/XxZ7y+JrANSekJFzReHjOnpQQqhTXKzE9aabYvy+YHbY0lJAgkJJ91bv9cp3Z
 S4ospVUiU0DcNofTKhlJgPIuKGU675U84EOke+sMGFdZaomba+4el2KKYDbas7PlHgsf
 /IetCjGw4truos/ZkrxPMbYjhtdU3IXsucgFh8GZv2gGIaqT7nonV0RRj6pngaHd4SV5
 SY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=aR/crGqpjngWx4uY4BPhbCIGGN5/NfXCrwfurQ6wFX8=;
 b=UXlfQmh6Zz4A2waFhTvWbZA7HTqJt0dvzs8DzUX7Z3UKQGz80jvpnrYgXuNlPW78Nl
 MEazslIzQ4IJsi4MLWPLKVQsafdLiZygiHf8kxSOi4D+e0HkUeCXFtz6COdJU4LgpUll
 F4bSvHzsld1ka8lXH3TaUluvg5cI+9+UseBSOl5d85PqbX4j6hlKq8a1f6b8QiDAWKKI
 B9kevtmSYjAxIhKIJ6K16+rAQxTjBqxN2wUvi9SxfdDx41tdmtje+zTc2u00poA7cICu
 /j+hkQ8V8kULTUnNfzYSl6iWLFnTF2QXqXbVKiSsYfZK9twA1Ui6QDqG3dqGd+8eN0ly
 1rvQ==
X-Gm-Message-State: AOAM533eb73m63cLCfFgxuHJBfWHytx0nbHc2Lwa+QEsumuYuiAnJ5bu
 ivlGLpLlkI7ODPgpML/Qeb0=
X-Google-Smtp-Source: ABdhPJz/IG9016CRVziTx6VnTnMzdjx9OkOQzHYZaUJYwr+krDqW/GsysWerNUdwLfDFLLG/GMQ9mQ==
X-Received: by 2002:a17:902:b70a:b029:d2:6391:a80f with SMTP id
 d10-20020a170902b70ab02900d26391a80fmr1843556pls.0.1602058477662; 
 Wed, 07 Oct 2020 01:14:37 -0700 (PDT)
Received: from adolin ([49.207.194.78])
 by smtp.gmail.com with ESMTPSA id w10sm1443590pjy.13.2020.10.07.01.14.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 01:14:36 -0700 (PDT)
Date: Wed, 7 Oct 2020 13:44:32 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Message-ID: <cover.1602054065.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 07 Oct 2020 10:14:42 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 07 Oct 2020 10:14:38 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: michal.lkml@markovi.net, linux-doc@vger.kernel.org, Gilles.Muller@lip6.fr,
        corbet@lwn.net, nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH 0/2 V3] Improve Coccinelle Parallelisation
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

Coccinelle utilises all available threads to implement parallelisation.
However, this results in a decrease in performance.

This patchset aims to improve performance by modifying cocciccheck to
use at most one thread per core by default in machines with more than 4
hyperthreads.

Sumera Priyadarsini (2):
  scripts: coccicheck: Change default value for parallelism
  Documentation: Coccinelle: Modify parallelisation information in docs

 Documentation/dev-tools/coccinelle.rst | 5 +++--
 scripts/coccicheck                     | 5 +++++
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.25.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
