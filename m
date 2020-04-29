Return-Path: <SRS0=9rx2=6N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18ACC83000
	for <cocci@archiver.kernel.org>; Wed, 29 Apr 2020 15:01:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FBBF22209
	for <cocci@archiver.kernel.org>; Wed, 29 Apr 2020 15:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cilium-io.20150623.gappssmtp.com header.i=@cilium-io.20150623.gappssmtp.com header.b="F8uh+yTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FBBF22209
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cilium.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03TF111Y029278;
	Wed, 29 Apr 2020 17:01:01 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A7CAE7816;
	Wed, 29 Apr 2020 17:01:01 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B5B8A7807
 for <cocci@systeme.lip6.fr>; Wed, 29 Apr 2020 16:39:30 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:429])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03TEdUqu004010
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 29 Apr 2020 16:39:30 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id k1so2854157wrx.4
 for <cocci@systeme.lip6.fr>; Wed, 29 Apr 2020 07:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cilium-io.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:subject:message-id:mime-version:content-disposition
 :user-agent; bh=mOlgS21lFyrr43ON/AyEplTD0HcPslhtY9ymTmEC1Yc=;
 b=F8uh+yTVQ9P/BDky0DOhtuSXtXlnZBYqX4wMBF1gBVAc+AbGYxMOaKHdZR6thgPkWu
 glO8WPB78vbV8jmuIlwJMtfZOd070M6aM6gYxQ4ZUwZHMZt10JgXoA2JpP5pxxoeiDvj
 An4oqxPtn6X3L0x/olHjPNhDf1rRiXwBrppvtBuzDMemWqvJgj+t9l2lFU5PAP/1nLKf
 lRLnPf0utJjXd3W+d72CVk2r70dfxvXIXjW0QgaNIHDqTUVuxBPkoeZP3H91qHpTStEl
 KXQHqv6K2u6FEy2Bhnp9PHRMrZqXuV7QZAX7Bjgf5FX5BAMA6NkvKADy7h6EIIVVe3AB
 TSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=mOlgS21lFyrr43ON/AyEplTD0HcPslhtY9ymTmEC1Yc=;
 b=qZh7L9VqL4f4omc0doiG90LyL5bryf8UZmxe5Tlyqd7P9f4ITA26aeYyDwEPGVCT3X
 AoBDozMGlwF3GEYrpdYXiwI1Xqhf5vokUQ/5fXCuTyAlb3+3AhZycj0iwITDA7yWVkii
 Cg3rNiZxDMezv5j6fAJUl+6uGtbqmzEQE+z4hgoX9BTfOfkVAW3Pqkl+/m1Qaxx4QYNK
 G8N/kdX8Ga8uVIb57uEMvhkn3ZLOAO6uO5gxv6jNTQzQ3xSrFofOumGJPXd2wNw+yrRN
 joGNgOoG1RavQbu2HH3d9KNkwJs06NEJ9ehr++rMatOVnE0fAt5lTWvDNaEj/UvVKMKf
 G5fQ==
X-Gm-Message-State: AGi0PubGOR5dGp/MEXcDt3OBX4YnVhx3C+5hVsLheeAOgS7HE3mShwiG
 tZ5HTVLqNLeyuyaZwTrGMXx+462MNqQu
X-Google-Smtp-Source: APiQypKT2uFnHDhjZY9SypDu/GuSQqkVkKEiwO1e8Qv/HVGYQrgeuqFa+weABxrRKg+EthJ4v7PI9A==
X-Received: by 2002:adf:f881:: with SMTP id u1mr38788782wrp.348.1588171169553; 
 Wed, 29 Apr 2020 07:39:29 -0700 (PDT)
Received: from Mem ([145.136.49.157])
 by smtp.gmail.com with ESMTPSA id z15sm29245508wrs.47.2020.04.29.07.39.28
 for <cocci@systeme.lip6.fr>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 07:39:29 -0700 (PDT)
Date: Wed, 29 Apr 2020 16:39:28 +0200
From: Paul Chaignon <paul@cilium.io>
To: cocci@systeme.lip6.fr
Message-ID: <20200429143926.GA24738@Mem>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 29 Apr 2020 17:01:02 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 29 Apr 2020 16:39:30 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Wed, 29 Apr 2020 17:01:00 +0200
Subject: [Cocci] Exit with non-zero status
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

Hi everyone,

I am trying to exit spatch with a non-zero exit status when required
changes have been found. I have tried to add a rule with finalize:python
and the following code:

  @finalize:python@
  @@
  exit(cnt)

where cnt is incremented by another Python rule everytime a required
change is found. This works as expected except for the --in-place option
which becomes ineffective.

Is this a bug, or is finalize:python not intended to be used in that
manner? Is it possible to overwrite spatch's exit status?

Thanks,
Paul
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
