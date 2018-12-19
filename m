Return-Path: <SRS0=dzya=O4=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247DFC43387
	for <cocci@archiver.kernel.org>; Wed, 19 Dec 2018 13:32:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66EDE21841
	for <cocci@archiver.kernel.org>; Wed, 19 Dec 2018 13:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ig6+LZMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66EDE21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBJDWd4j029315
          ; Wed, 19 Dec 2018 14:32:39 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0189176D7;
	Wed, 19 Dec 2018 14:32:39 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2995276D5
 for <cocci@systeme.lip6.fr>; Wed, 19 Dec 2018 14:32:37 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBJDWaMa000110
 for <cocci@systeme.lip6.fr>; Wed, 19 Dec 2018 14:32:36 +0100 (CET)
X-pt: isis.lip6.fr
Received: from [192.168.1.75] (cpe-24-28-70-126.austin.res.rr.com
 [24.28.70.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id ADDD421841;
 Wed, 19 Dec 2018 13:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545226355;
 bh=MXM01raz9hEjE1ma7kx3PR0o8tX63R7Rrlhnmmr/XIY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Ig6+LZMjuGhzyw8va4zB96aGY30h3SODISb4Qhvz6ltXcQvrwsCdc9lSI818eRoU0
 84VUKMRKn6WlEyJUS6TOs45omJ58ARt8XomG4BTiwRcGvNi81V42BHYsC6BLYJ3NfQ
 llgTp+OA27rIf1LLIp2AYhtWUwmsqEVQqDCI/WTw=
To: Julia Lawall <julia.lawall@lip6.fr>
References: <CAOZdJXXHJU3f4K-ECQjGs2WoE8XFMZDHL3bQ93ncewv_XCOSrg@mail.gmail.com>
 <alpine.DEB.2.21.1812182303590.2486@hadrien>
 <CAOZdJXUj5mZDHC+71N+mBQ98hpa4H7rbA1E3kkGzDgV_zFRobQ@mail.gmail.com>
 <alpine.DEB.2.21.1812190720480.2656@hadrien>
From: Timur Tabi <timur@kernel.org>
Message-ID: <a8fb939c-21ab-8ef0-f17e-d193e89327db@kernel.org>
Date: Wed, 19 Dec 2018 07:32:30 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1812190720480.2656@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 19 Dec 2018 14:32:40 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 19 Dec 2018 14:32:36 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Positional parameter p1[0].file contains temporarily
 munged filename, not original
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

On 12/19/18 12:21 AM, Julia Lawall wrote:
> Before you change a given function, everything is reliable.  Afterwards,
> only the function name and the column start and end would be reliable.

Hmmm.  I'll see if I can move my Python code to a new rule at the top of 
the file.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
