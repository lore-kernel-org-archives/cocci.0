Return-Path: <SRS0=DmmV=57=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08281C2BB85
	for <cocci@archiver.kernel.org>; Wed, 15 Apr 2020 19:24:05 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77EAB206D5
	for <cocci@archiver.kernel.org>; Wed, 15 Apr 2020 19:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77EAB206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03FJNm1R012018;
	Wed, 15 Apr 2020 21:23:48 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A35ED7755;
	Wed, 15 Apr 2020 21:23:48 +0200 (CEST)
Received: from osiris.lip6.fr (osiris.lip6.fr [132.227.60.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C4F143B93
 for <cocci@systeme.lip6.fr>; Wed, 15 Apr 2020 00:13:56 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0154.hostedemail.com
 [216.40.44.154])
 by osiris.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03EMDtiJ005349
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 15 Apr 2020 00:13:56 +0200 (CEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave05.hostedemail.com (Postfix) with ESMTP id B9C62180142E2
 for <cocci@systeme.lip6.fr>; Tue, 14 Apr 2020 19:47:09 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay06.hostedemail.com (Postfix) with ESMTP id 9E3611802B57F;
 Tue, 14 Apr 2020 19:47:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: coal59_5a1e7cc02a463
X-Filterd-Recvd-Size: 2796
Received: from XPS-9350.home (unknown [47.151.136.130])
 (Authenticated sender: joe@perches.com)
 by omf07.hostedemail.com (Postfix) with ESMTPA;
 Tue, 14 Apr 2020 19:46:59 +0000 (UTC)
Message-ID: <2a58f592879cf67b4c6b8e859ce87e1f9652902a.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Waiman Long <longman@redhat.com>,
        Michal =?ISO-8859-1?Q?Such=E1nek?=
 <msuchanek@suse.de>
Date: Tue, 14 Apr 2020 12:44:49 -0700
In-Reply-To: <578fe9b6-1ccd-2698-60aa-96c3f2dd2c31@redhat.com>
References: <20200413211550.8307-1-longman@redhat.com>
 <20200413222846.24240-1-longman@redhat.com>
 <eca85e0b-0af3-c43a-31e4-bd5c3f519798@c-s.fr>
 <e194a51f-a5e5-a557-c008-b08cac558572@redhat.com>
 <20200414191601.GZ25468@kitsune.suse.cz>
 <578fe9b6-1ccd-2698-60aa-96c3f2dd2c31@redhat.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 15 Apr 2020 21:23:49 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (osiris.lip6.fr [132.227.60.30]);
 Wed, 15 Apr 2020 00:13:56 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.30
X-Mailman-Approved-At: Wed, 15 Apr 2020 21:23:47 +0200
Cc: linux-btrfs@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        virtualization@lists.linux-foundation.org,
        David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
        linux-sctp@vger.kernel.org, keyrings@vger.kernel.org,
        kasan-dev@googlegroups.com, samba-technical@lists.samba.org,
        linux-stm32@st-md-mailman.stormreply.com, devel@driverdev.osuosl.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, x86@kernel.org,
        James Morris <jmorris@namei.org>, Matthew Wilcox <willy@infradead.org>,
        cocci@systeme.lip6.fr, linux-wpan@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, David Rientjes <rientjes@google.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-pm@vger.kernel.org,
        ecryptfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-integrity@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@c-s.fr>, linux-cifs@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-security-module@vger.kernel.org,
        target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-crypto@vger.kernel.org, netdev@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, wireguard@lists.zx2c4.com,
        linux-ppp@vger.kernel.org
Subject: Re: [Cocci] [PATCH v2 2/2] crypto: Remove unnecessary
	memzero_explicit()
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

On Tue, 2020-04-14 at 15:37 -0400, Waiman Long wrote:
> OK, I can change it to clear the key length when the allocation failed
> which isn't likely.


Perhaps:

	kfree_sensitive(op->key);
	op->key = NULL;
	op->keylen = 0;

but I don't know that it impacts any possible state.


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
