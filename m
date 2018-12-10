Return-Path: <SRS0=GhGO=OT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0230FC04EB8
	for <cocci@archiver.kernel.org>; Mon, 10 Dec 2018 15:02:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 377B620851
	for <cocci@archiver.kernel.org>; Mon, 10 Dec 2018 15:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377B620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cs.tu-darmstadt.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBAF1tuB002319
          ; Mon, 10 Dec 2018 16:01:55 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4F0AE76D5;
	Mon, 10 Dec 2018 15:51:45 +0100 (CET)
Received: from osiris.lip6.fr (osiris.lip6.fr [132.227.60.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4E08376AB
 for <cocci@systeme.lip6.fr>; Mon, 10 Dec 2018 15:51:43 +0100 (CET)
Received: from mail-relay231.hrz.tu-darmstadt.de
 (mail-relay231.hrz.tu-darmstadt.de [130.83.156.231])
 by osiris.lip6.fr (8.15.2/lip6) with ESMTP id wBAEpgsx005685
 for <cocci@systeme.lip6.fr>; Mon, 10 Dec 2018 15:51:42 +0100 (CET)
X-pt: osiris.lip6.fr
Received: from lnx141.hrz.tu-darmstadt.de (lnx141.hrz.tu-darmstadt.de
 [130.83.156.236])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by mail-relay231.hrz.tu-darmstadt.de (Postfix) with ESMTPS id 43D5F32LTNz43vT
 for <cocci@systeme.lip6.fr>; Mon, 10 Dec 2018 15:34:31 +0100 (CET)
Received: from lnx500.hrz.tu-darmstadt.de (mailout.hrz.tu-darmstadt.de
 [130.83.156.225])
 by lnx141.hrz.tu-darmstadt.de (8.14.4/8.13.8) with ESMTP id wBAEXo1l008196
 for <cocci@systeme.lip6.fr>; Mon, 10 Dec 2018 15:33:50 +0100
 (envelope-from schwahn@cs.tu-darmstadt.de)
Received: from smtp.tu-darmstadt.de (mail-relay14.hrz.tu-darmstadt.de
 [130.83.156.238])
 by lnx500.hrz.tu-darmstadt.de (8.14.4/8.14.4/HRZ/PMX) with ESMTP id
 wBAETl3R012227
 for <cocci@systeme.lip6.fr>; Mon, 10 Dec 2018 15:29:47 +0100
 (envelope-from schwahn@cs.tu-darmstadt.de)
Received: from [130.83.162.151] (deeds23.deeds.informatik.tu-darmstadt.de
 [130.83.162.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by smtp.tu-darmstadt.de (Postfix) with ESMTPSA id 43D57b63FVz440B
 for <cocci@systeme.lip6.fr>; Mon, 10 Dec 2018 15:29:47 +0100 (CET)
From: Oliver Schwahn <schwahn@cs.tu-darmstadt.de>
Organization: TU Darmstadt
To: cocci@systeme.lip6.fr
Message-ID: <ecaf70fe-1194-9457-ad0c-5f029343b2d4@cs.tu-darmstadt.de>
Date: Mon, 10 Dec 2018 15:29:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Language: en-US
X-PMX-TU: seen v1.2 by 5.6.1.2065439, Antispam-Engine: 2.7.2.376379,
 Antispam-Data: 2018.12.10.142116
X-PMX-RELAY: outgoing
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 10 Dec 2018 16:01:55 +0100 (CET)
X-Greylist: Delayed for 00:17:11 by milter-greylist-4.4.3 (osiris.lip6.fr
 [132.227.60.30]); Mon, 10 Dec 2018 15:51:42 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.30
Subject: [Cocci] Build issue after stdcompat upgrade
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
Reply-To: schwahn@cs.tu-darmstadt.de
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

I am trying to build Coccinelle from the latest Github version (commit 
163d2058). My OCaml version is 4.05.0 on an Ubuntu 18.10.

I do the following from a clean repo checkout:
./autogen
./configure
make

and get the error:
ocamlfind ocamlc -c  -no-alias-deps -I . stdcompat__pervasives.ml -o 
stdcompat__pervasives.cmo
File "stdcompat__pervasives.ml", line 1:
Error: The implementation stdcompat__pervasives.ml
        does not match the interface stdcompat__pervasives.cmi:
        Type declarations do not match:
          type ('a, 'b) result = ('a, 'b) result = Ok of 'a | Error of 'b
        is not included in
          type ('a, 'b) result =
            ('a, 'b) Stdcompat__init.result =
              Ok of 'a
            | Error of 'b
make[2]: *** [Makefile:1370: stdcompat__pervasives.cmo] Error 2
make[2]: Leaving directory '/v/coccinelle/bundles/stdcompat/stdcompat-7'
make[1]: *** [Makefile:3: all] Error 2
make[1]: Leaving directory '/v/coccinelle/bundles/stdcompat'

Apparently this issues appeared after the upgrade of stdcompat to 
version 7. The last commit that builds on my system is 890e385a, being 
the last commit before the update.

Do you have any suggestion for a workaround?

Cheers,
Oliver
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
