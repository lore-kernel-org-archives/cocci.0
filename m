Return-Path: <SRS0=otX5=PT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDB6C43387
	for <cocci@archiver.kernel.org>; Fri, 11 Jan 2019 22:24:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCC952084C
	for <cocci@archiver.kernel.org>; Fri, 11 Jan 2019 22:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCC952084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0BMONlR026759
          ; Fri, 11 Jan 2019 23:24:24 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B732C76F3;
	Fri, 11 Jan 2019 23:24:23 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2F09676F2
 for <cocci@systeme.lip6.fr>; Fri, 11 Jan 2019 23:24:22 +0100 (CET)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0BMOL0j014117
 for <cocci@systeme.lip6.fr>; Fri, 11 Jan 2019 23:24:21 +0100 (CET)
X-pt: isis.lip6.fr
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 463ED792BA
 for <cocci@systeme.lip6.fr>; Fri, 11 Jan 2019 22:24:20 +0000 (UTC)
Received: from redhat.com (ovpn-125-134.rdu2.redhat.com [10.10.125.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3EE46B467
 for <cocci@systeme.lip6.fr>; Fri, 11 Jan 2019 22:24:19 +0000 (UTC)
Date: Fri, 11 Jan 2019 17:24:17 -0500
From: Jerome Glisse <jglisse@redhat.com>
To: cocci@systeme.lip6.fr
Message-ID: <20190111222417.GE3190@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 11 Jan 2019 23:24:25 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 11 Jan 2019 23:24:21 +0100 (CET)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 11 Jan 2019 22:24:20 +0000 (UTC)
Subject: [Cocci] Adding a field to struct and new line issues
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Hi,

I am trying to add a field to struct however coccinelle insist on
adding it on the same line as struct name definition ie:

spatch:
@@
@@
struct foo {
+int roto;
...
}

original c code:
struct foo {
    int titi;
};

result:
struct foo {int roto;
    int titi;
};


This is kind of ugly and i am at loss trying to force a new line ie:
struct foo {
    int roto;
    int titi;
};



Funny thing, trying to out smart coccinelle with:
@@
identifier I1;
type T1;
@@
struct foo {
T1 I1;
+int roto;
...
}

Gives:
struct foo {
    int titi;int roto;
};


I am still scratching my head on how i can force a new line. There
does not seem to have \n or any escape sequence i can use to force
new line.

Thank you for any pointers toward that.
J=E9r=F4me
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
