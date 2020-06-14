Return-Path: <SRS0=yQoC=73=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7867C433E0
	for <cocci@archiver.kernel.org>; Sun, 14 Jun 2020 18:22:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DDE7206D7
	for <cocci@archiver.kernel.org>; Sun, 14 Jun 2020 18:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skpqeAph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DDE7206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05EILvdA009671;
	Sun, 14 Jun 2020 20:21:57 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C02737760;
	Sun, 14 Jun 2020 20:21:57 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AE1F044A7
 for <cocci@systeme.lip6.fr>; Sun, 14 Jun 2020 20:21:55 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:62a])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05EILtAO011001
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 14 Jun 2020 20:21:55 +0200 (CEST)
Received: by mail-ej1-x62a.google.com with SMTP id x1so15024820ejd.8
 for <cocci@systeme.lip6.fr>; Sun, 14 Jun 2020 11:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=225IYXjfjqwlsJoM56IQsF7q74PBimOlhOs/vYp8QKY=;
 b=skpqeAphHkfEFv4Lt8Nj4Dx8zu4Hd3Z978LQL4dxWp+e8Iw+Pz3eG6SXM1li8Ty8ws
 p+bbMI2jjkZwOmBixQ4WboHipLe3r4Wy2gjmg6XhKALy1eZe5znAN++bWa0x4q7gLSQ7
 tubkUP2UHQ4oCFvZKNM0xOOL5+2d9+LFAVltvQMSZKqpBIHfZHeKS8781nBwGx955vv0
 BA+ltb+mCgAytzKpq9Psg63fjlswTO1Pu1Jtg4qHdc5ldEeU8HLP8rwdZdUuIAmSJtY2
 pGeK38C6dOv5cBJ9842tNVcDg/J6y/CXuCVA4bVKUir6TxQrw74j7cCCoQ6h8WT+2rso
 mkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=225IYXjfjqwlsJoM56IQsF7q74PBimOlhOs/vYp8QKY=;
 b=LwE0icTqiJuW3F0GolwhbLvAC29JIcI8ir4+11pyn4aV1S4kM9XM/FjTotbhhiwYtY
 gEXMkHgcae8BD/pxAUA0RhsQdaWzKLQ5zM5kPBhqpxunso65y+5+R1QdBFqPQoLDicJR
 F8TGCOpYumj4O4GO810Qdj7HnAlbJdEKKRShA8QTJXSNBAyhqUfPCLGLpsSo650tgNhs
 kXNFMkL7qmBeqjzD8eAQQ05K0n8t8MVVBcuIX7qLM3cPLo8c8fzt+fqb7V5SerzJllju
 kvN5YzVpxKWRcScSq43SdKc2REBKY8VUCp0QRxv1i8IbC7flIzhokzywYZOa66dNZXb1
 1u6w==
X-Gm-Message-State: AOAM532WAP8L4TMgVFsB7RbigII30VyEDT4TvJEchji4Q2mGzefi7nLf
 VZbqH+LelF+qCTVwDzpAhL8=
X-Google-Smtp-Source: ABdhPJz49uapQQLIzKZB38EsdDxWu4uJbebyt+g40JeKcFC8h4/a8Etjh5v9+WA/LtaPxTCLVNxaJA==
X-Received: by 2002:a17:906:1c8e:: with SMTP id
 g14mr22316256ejh.136.1592158914834; 
 Sun, 14 Jun 2020 11:21:54 -0700 (PDT)
Received: from homer.simpson.net ([185.221.150.24])
 by smtp.googlemail.com with ESMTPSA id
 gv18sm7494425ejb.113.2020.06.14.11.21.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2020 11:21:54 -0700 (PDT)
Message-ID: <1592158913.7336.48.camel@gmail.com>
From: Mike Galbraith <umgwanakikbuti@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Sun, 14 Jun 2020 20:21:53 +0200
In-Reply-To: <alpine.DEB.2.22.394.2006141456520.2849@hadrien>
References: <b14e6d1d-afa0-5c28-547a-9bb1a987f6fd@infradead.org>
 <1592115803.27290.33.camel@gmail.com>
 <alpine.DEB.2.22.394.2006140940000.2849@hadrien>
 <1592121432.2129.9.camel@gmail.com>
 <alpine.DEB.2.22.394.2006141042270.2849@hadrien>
 <1592124280.2129.22.camel@gmail.com>
 <alpine.DEB.2.22.394.2006141456520.2849@hadrien>
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 14 Jun 2020 20:21:58 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 14 Jun 2020 20:21:55 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Randy Dunlap <rdunlap@infradead.org>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] coccinelle issues
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

On Sun, 2020-06-14 at 14:59 +0200, Julia Lawall wrote:
> 
> On Sun, 14 Jun 2020, Mike Galbraith wrote:
> 
> > On Sun, 2020-06-14 at 10:43 +0200, Julia Lawall wrote:
> > >
> > > What is your Linux distribution?
> >
> > openSUSE Leap-15.1
> 
> Our CI already has an entry for openSUSE Leap.  We will look into it, but
> if you have any further information about the problem, please let us know.

Executive Summary:

warning: Can't find macro file: /usr/local/coccinelle/bin/../lib/coccinelle/standard.h
warning: Can't find default iso file: /usr/local/coccinelle/bin/../lib/coccinelle/standard.iso

I find those under lib64, apply symlink bandaid, proggy acks.

WRT the HEAD make install booboo..

git@homer:~/coccinelle> sudo make install
mkdir -p /usr/local/coccinelle/bin /usr/local/coccinelle/lib64/coccinelle
mkdir -p /usr/local/coccinelle/lib64/coccinelle/ocaml
if test -f bundles/pyml/dllpyml_stubs.so; then \
        /usr/bin/install -c -m 755 bundles/pyml/dllpyml_stubs.so \
                /usr/local/coccinelle/lib64/coccinelle; \
fi
if test -f bundles/pcre/dllpcre_stubs.so; then \
        /usr/bin/install -c -m 755 bundles/pcre/dllpcre_stubs.so \
                /usr/local/coccinelle/lib64/coccinelle; \
fi
/usr/bin/install -c -m 755 spatch.opt /usr/local/coccinelle/bin/spatch
/usr/bin/install -c -m 644 standard.h /usr/local/coccinelle/lib64/coccinelle
/usr/bin/install -c -m 644 standard.iso /usr/local/coccinelle/lib64/coccinelle
/usr/bin/install -c -m 644 ocaml/*.cmi /usr/local/coccinelle/lib64/coccinelle/ocaml/
if test -f ocaml/coccilib.cmx; then \
        /usr/bin/install -c -m 644 ocaml/*.cmx /usr/local/coccinelle/lib64/coccinelle/ocaml/; \
fi
/usr/bin/install -c -m 755 tools/spgen/source/spgen.opt \
         /usr/local/coccinelle/bin/spgen
/usr/bin/install -c -m 644 python/coccilib/*.py \
        /usr/local/coccinelle/lib64/coccinelle/python/coccilib
/usr/bin/install: target '/usr/local/coccinelle/lib64/coccinelle/python/coccilib' is not a directory
make: *** [Makefile:332: install-python] Error 1

mkdir -p bandaid worked.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
