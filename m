Return-Path: <SRS0=HFFw=VL=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28B7C73C66
	for <cocci@archiver.kernel.org>; Sun, 14 Jul 2019 14:14:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A5920644
	for <cocci@archiver.kernel.org>; Sun, 14 Jul 2019 14:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="OhE+ucWJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="L4w05nho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A5920644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nexedi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6EEDoF7017453;
	Sun, 14 Jul 2019 16:13:50 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A0EB47772;
	Sun, 14 Jul 2019 16:13:50 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8F88376BB
 for <cocci@systeme.lip6.fr>; Sun, 14 Jul 2019 16:13:46 +0200 (CEST)
Received: from mail133-22.atl131.mandrillapp.com
 (mail133-22.atl131.mandrillapp.com [198.2.133.22])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6EEDjNs018369
 for <cocci@systeme.lip6.fr>; Sun, 14 Jul 2019 16:13:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
 i=kirr@nexedi.com; 
 bh=OkdXMsKChIXf9sKU+iNJjSMcEzWlygaeee1sm+U5lN8=;
 b=OhE+ucWJMuTEEahgvz5s1kT1MIePtRlyoN4wmmUGU4NfO3YVURy/OmnvZDqZgtEJf6QGq3kb3zgz
 kIXBmnm/JOOIYeN5rVTVJekE9edPvnVqfH6azsv3yF9oNYVfJlrqaswFyHMKOzomtVTqpUQUjlP+
 e/h8o0YmCis7HTcQoBc=
Received: from pmta02.mandrill.prod.atl01.rsglab.com (127.0.0.1) by
 mail133-22.atl131.mandrillapp.com id h5cs9k1sar8t for <cocci@systeme.lip6.fr>;
 Sun, 14 Jul 2019 14:13:45 +0000 (envelope-from
 <bounce-md_31050260.5d2b3899.v1-ee6dfe04401042b8ba736e9a61460527@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1563113625; h=From : 
 Subject : To : Cc : Message-Id : Date : MIME-Version : Content-Type : 
 Content-Transfer-Encoding : From : Subject : Date : X-Mandrill-User : 
 List-Unsubscribe; bh=OkdXMsKChIXf9sKU+iNJjSMcEzWlygaeee1sm+U5lN8=; 
 b=L4w05nho6BTrmzaJZTZrKV0F3cNXNHM+fWKDhdWu9sM0JzQ0EJ7MxsqSruMCC8+KUjI3Ip
 lATDftW32p52s51r61TgbvbNRMwvAvQUYHGpkW4YsFJtYpGERhXQnYzWJCQy4xAQIUQXFwMU
 jLs9U/d4nIjHM1JSTtF0qYbGYfJ1k=
From: Kirill Smelkov <kirr@nexedi.com>
Received: from [87.98.221.171] by mandrillapp.com id
 ee6dfe04401042b8ba736e9a61460527; Sun, 14 Jul 2019 14:13:45 +0000
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-Id: <20190714141317.GA20277@deco.navytux.spb.ru>
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here:
 http://mandrillapp.com/contact/abuse?id=31050260.ee6dfe04401042b8ba736e9a61460527
X-Mandrill-User: md_31050260
Date: Sun, 14 Jul 2019 14:13:45 +0000
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 14 Jul 2019 16:13:51 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 14 Jul 2019 16:13:46 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-fsdevel@vger.kernel.org, Jan Blunck <jblunck@suse.de>,
        cocci@systeme.lip6.fr, Jonathan Cameron <jic23@kernel.org>
Subject: [Cocci] [PULL] stream_open bits for Linux 5.3
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

Linus,

Please consider pulling the following stream_open related bits:

This time on stream_open front it is only two small changes:

- the first one converts stream_open.cocci to treat all functions that
  start with wait_.* as blocking. Previously it was only wait_event_.*
  functions that were considered as blocking, but this was falsely
  reporting deadlock cases as only warning. The patch was picked by
  linux-kbuild and already entered your tree as 0c4ab18fc33b.
  It is thus omitted from hereby pull-request.

- the second one teaches stream_open.cocci to consider files as being
  stream-like even if they use noop_llseek. I posted this patch for
  review 3 weeks ago[1], but got neither feedback nor complaints.

  [1] https://lore.kernel.org/lkml/20190623072838.31234-2-kirr@nexedi.com/


The changes are available for pulling from here:

	https://lab.nexedi.com/kirr/linux.git stream_open-5.3


Thanks beforehand,
Kirill


Kirill Smelkov (1):
      *: convert stream-like files -> stream_open, even if they use noop_llseek

 drivers/hid/hid-sensor-custom.c          | 2 +-
 drivers/input/mousedev.c                 | 2 +-
 scripts/coccinelle/api/stream_open.cocci | 9 ++++++++-
 3 files changed, 10 insertions(+), 3 deletions(-)
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
