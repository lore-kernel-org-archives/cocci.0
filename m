Return-Path: <SRS0=ND+5=5W=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3758C2BA18
	for <cocci@archiver.kernel.org>; Mon,  6 Apr 2020 08:05:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F1D9206C3
	for <cocci@archiver.kernel.org>; Mon,  6 Apr 2020 08:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtdQwdoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1D9206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03685FFk020761;
	Mon, 6 Apr 2020 10:05:15 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2F5B177FC;
	Mon,  6 Apr 2020 10:05:15 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7AB6A3CA2
 for <cocci@systeme.lip6.fr>; Mon,  6 Apr 2020 09:47:06 +0200 (CEST)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0367l3ZU029420
 (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA256 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 6 Apr 2020 09:47:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586159223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Mmc9bUIzpEkABlnn7BLv3rBeyrfyR3BD42yRJfpE6fE=;
 b=NtdQwdoe61NrDNEaFWE8ViLGn+3+ySS0F1ao/paPsu/UL1uoZo15hXZns0WHeq7ZE8xtjm
 3X6RCjjY8ZpjVqG5j3SaQAw0qSoo797LDpbLstxEczN/8zPBIQiFxaQGG/pN7nSKEl27Bw
 DBlSp1Ixq8BOj7H/4iosbrRAjitJ9EQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-ab-W5njLPP2VWuL6tDdwhA-1; Mon, 06 Apr 2020 03:47:01 -0400
X-MC-Unique: ab-W5njLPP2VWuL6tDdwhA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 438EB13F7
 for <cocci@systeme.lip6.fr>; Mon,  6 Apr 2020 07:47:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-152.ams2.redhat.com
 [10.36.112.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 13B692719A
 for <cocci@systeme.lip6.fr>; Mon,  6 Apr 2020 07:46:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 65AD211385C8; Mon,  6 Apr 2020 09:46:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: cocci@systeme.lip6.fr
Date: Mon, 06 Apr 2020 09:46:58 +0200
Message-ID: <875zed839p.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 06 Apr 2020 10:05:15 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 06 Apr 2020 09:47:05 +0200 (CEST)
X-Mailman-Approved-At: Mon, 06 Apr 2020 10:05:13 +0200
Subject: [Cocci] Function-like macro with the same name as a typedef ->
	parse error
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

I noticed that Coccinelle skips over much of QEMU's hw/arm/armsse.c.
I append a minimized test case.  Observations:

* spatch seems to have trouble parsing

    ARMSSE *s = ARMSSE(opaque);

  where ARMSSE is a typedef, and ARMSSE() is a function-like macro.
  Yes, I know that's in rather poor taste.

* Workaround #1: rename the typedef to ARMSSE_

* Workaround #2: move the typedef and the macro from the .h to the .c.



$ cat armsse.c
#include "armsse.h"

void nsccfg_handler(void *opaque, int n, int level)
{
    ARMSSE *s = ARMSSE(opaque);

    s->nsccfg = level;
}
$ cat armsse.h
#ifndef ARMSSE_H
#define ARMSSE_H

typedef struct {
    int nsccfg;
} ARMSSE;

#define ARMSSE(obj) ((ARMSSE *)(obj))

#endif
$ spatch --parse-c armsse.c
init_defs_builtins: /usr/lib64/coccinelle/standard.h

PARSING: armsse.c
including ./armsse.h
ERROR-RECOV: found sync '}' at line 8
parsing pass2: try again
ERROR-RECOV: found sync '}' at line 8
parsing pass3: try again
ERROR-RECOV: found sync '}' at line 8
parse error 
 = File "armsse.c", line 5, column 16, charpos = 91
  around = 'ARMSSE',
  whole content =     ARMSSE *s = ARMSSE(opaque);
badcount: 7
bad: #include "armsse.h"
bad: 
bad: void nsccfg_handler(void *opaque, int n, int level)
bad: {
BAD:!!!!!     ARMSSE *s = ARMSSE(opaque);
bad: 
bad:     s->nsccfg = level;
bad: }
-----------------------------------------------------------------------
maybe 10 most problematic tokens
-----------------------------------------------------------------------
ARMSSE: present in 2 parsing errors
example: 
       void nsccfg_handler(void *opaque, int n, int level)
       {
           ARMSSE *s = ARMSSE(opaque);
       
opaque: present in 2 parsing errors
example: 
       void nsccfg_handler(void *opaque, int n, int level)
       {
           ARMSSE *s = ARMSSE(opaque);
       
level: present in 1 parsing errors
example: 
       void nsccfg_handler(void *opaque, int n, int level)
       {
           ARMSSE *s = ARMSSE(opaque);
       
n: present in 1 parsing errors
example: 
       void nsccfg_handler(void *opaque, int n, int level)
       {
           ARMSSE *s = ARMSSE(opaque);
       
nsccfg_handler: present in 1 parsing errors
example: 
       void nsccfg_handler(void *opaque, int n, int level)
       {
           ARMSSE *s = ARMSSE(opaque);
       
s: present in 1 parsing errors
example: 
       void nsccfg_handler(void *opaque, int n, int level)
       {
           ARMSSE *s = ARMSSE(opaque);
       
-----------------------------------------------------------------------
NB total files = 1; perfect = 0; pbs = 1; timeout = 0; =========> 0%
nb good = 0,  nb passed = 0 =========> 0.00% passed
nb good = 0,  nb bad = 7 =========> 0.00% good or passed
$ spatch --version
spatch version 1.0.7 compiled with OCaml version 4.07.0
Flags passed to the configure script: --build=x86_64-redhat-linux-gnu --host=x86_64-redhat-linux-gnu --program-prefix= --disable-dependency-tracking --prefix=/usr --exec-prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc --datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib64 --libexecdir=/usr/libexec --localstatedir=/var --sharedstatedir=/var/lib --mandir=/usr/share/man --infodir=/usr/share/info --with-python=/usr/bin/python3 --with-menhir=/usr/bin/menhir
OCaml scripting support: yes
Python scripting support: yes
Syntax of regular expresssions: PCRE

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
