Return-Path: <SRS0=7N6k=7P=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA488C433E0
	for <cocci@archiver.kernel.org>; Tue,  2 Jun 2020 09:28:13 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 352D2206A4
	for <cocci@archiver.kernel.org>; Tue,  2 Jun 2020 09:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cilium-io.20150623.gappssmtp.com header.i=@cilium-io.20150623.gappssmtp.com header.b="A5mC/rpj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352D2206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cilium.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0529S95l006063;
	Tue, 2 Jun 2020 11:28:09 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E6B727567;
	Tue,  2 Jun 2020 11:28:08 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6D8A13F9A
 for <cocci@systeme.lip6.fr>; Tue,  2 Jun 2020 11:28:06 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:62b])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0529S5Rk002899
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 2 Jun 2020 11:28:05 +0200 (CEST)
Received: by mail-ej1-x62b.google.com with SMTP id mb16so12062196ejb.4
 for <cocci@systeme.lip6.fr>; Tue, 02 Jun 2020 02:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cilium-io.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:subject:message-id:mime-version:content-disposition
 :user-agent; bh=MaHWPVQbMMkiGhmwqp7Pn3t/LLX6Q/x4eBaFtq2yq+w=;
 b=A5mC/rpjh4ybeaNlagjR27RITZytJTsOZU/nu0FH9CGwXfDxYn/HoGvhjRtnXxQk+7
 PFP0wgGGuGP1pilu/vbkrADG7RaephzT55hEhG2Ji/UhwL6HDqWWofBhQjk7UI4eLBic
 VMjoXYsysm1eRvmEtKjpTTKPRMYC4ua6VjAkzML559ysfAsXbc6u5/BHrn1Rb7NA97qB
 bH4fFCIQbjk8gikOWgPg/gTe3hWK3oV7tDLW1bqQNw8FVF2I5eAWCTm0YdFRcJdRzLlg
 hsPcIw377MdRSaInmiI0W+G/TVyX/Qoo4HtPDDs6juFGL0c8K86bKXc3LFyRfLumHElm
 PX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=MaHWPVQbMMkiGhmwqp7Pn3t/LLX6Q/x4eBaFtq2yq+w=;
 b=ZGdyvRLTNXgxDMIvqpjlhSX5HcDCfSrG7OchBKkhRtsrSjQhEypaPgZXuqYT5/ktjZ
 TKJWJPGj/HjWIuZg5Cu2BoK19GrVq33c5XLqlfXdseAT59HtIVRXe5zJih15xZdlXuPf
 9w/N76dhNjA/aTAW+OiX+2Z/4GQh3nqh2e2fhtT2mwAHx8jzMeiSatKe3Pn5SC20S06d
 /E8P2wSgjesu4680Jff9GgXyYM50MMdOdIl4bxvRSrQwaEDuoLiWDO80G0LivqniIIwf
 884cN+GEqvU+67z7wCxf09UGO+7nXJj3cB4Bi0l7e9eoy6vQbcFCHBrgRdaOf+gcAce0
 P91Q==
X-Gm-Message-State: AOAM533VDPX+TE/F7CVbL3HWa0K+olz1DtG1V9fFcOQ4tc/5szZu4cDH
 U38fqBu6sKm1x7EZf0VzSg5B6RZg1Rha
X-Google-Smtp-Source: ABdhPJw31O6sohCwfBRq2ecj28b22aTTk+D/7dF2BoE6JFQypI540iScOuaBDwpEp7qnbHK3/bmKdg==
X-Received: by 2002:a17:906:5645:: with SMTP id
 v5mr5780756ejr.533.1591090084831; 
 Tue, 02 Jun 2020 02:28:04 -0700 (PDT)
Received: from Mem ([81.30.78.170])
 by smtp.gmail.com with ESMTPSA id g22sm1414030ejp.0.2020.06.02.02.28.04
 for <cocci@systeme.lip6.fr>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 02:28:04 -0700 (PDT)
Date: Tue, 2 Jun 2020 11:28:03 +0200
From: Paul Chaignon <paul@cilium.io>
To: cocci@systeme.lip6.fr
Message-ID: <20200602092802.GA24095@Mem>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 02 Jun 2020 11:28:09 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 02 Jun 2020 11:28:05 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] Whitelist function in rule
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

Hi all,

I'm trying to find calls to ep_tail_call() that are *not* followed by
'return DROP_MISSED_TAIL_CALL'. That works fine (rule1 below), but I then
want to whitelist one specific function, send_drop_notify().

I couldn't find a way to do that from the first rule, so I whitelisted
send_drop_notify() with a second rule (rule2 below). That seems rather
cumbersome and I'm wondering if there's maybe a simpler approach?

  @rule1@
  position p1;
  @@
 
  (
    ep_tail_call(...);
    ... when forall
    return DROP_MISSED_TAIL_CALL;
  |
    ep_tail_call@p1(...);
  )
 
  @rule2@
  position p2, rule1.p1;
  identifier fn != send_drop_notify;
  @@
 
  fn(...) {
  <+...
  ep_tail_call@p1@p2(...);
  ...+>
  }

When I tried using rule1 as the body of the function in rule2, it just
didn't match anything anymore.

Thanks,
Paul
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
