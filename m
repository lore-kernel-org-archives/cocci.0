Return-Path: <SRS0=BkxN=P7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4795AC282C0
	for <cocci@archiver.kernel.org>; Wed, 23 Jan 2019 16:15:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E3C21726
	for <cocci@archiver.kernel.org>; Wed, 23 Jan 2019 16:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="joA7jYot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E3C21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0NGF3vg018420
          ; Wed, 23 Jan 2019 17:15:03 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1834B76E9;
	Wed, 23 Jan 2019 17:15:03 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 95F4576E3
 for <cocci@systeme.lip6.fr>; Wed, 23 Jan 2019 17:15:01 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0NGF0Q2022901
 for <cocci@systeme.lip6.fr>; Wed, 23 Jan 2019 17:15:00 +0100 (CET)
X-pt: isis.lip6.fr
Received: from [192.168.1.75] (cpe-24-28-70-126.austin.res.rr.com
 [24.28.70.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8927021726;
 Wed, 23 Jan 2019 16:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548260099;
 bh=/TczVCgNyV83kOA0MxR/CxAZP9rlK6jWUqj8snwv2uI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=joA7jYotzEmKsSKqG+PnMJdq5dxYv3veCS+oCyX+6SZlcTIr86EuCBrviGY4e8Il5
 MSLpwG9Cmf3lizFgBcfy4aNzzZUS2OPGk8DY3n8njBvXhKDwmEErLEQ1CuHTvAX37/
 wwr6UFiSAlHINZWys2TQP5LXVdzfHqfWDPJroHfY=
To: SF Markus Elfring <elfring@users.sourceforge.net>
References: <CAOZdJXWTzvTJFrdUnWD-YPPj6o=k2Xum5PR6enZKutv_+TRrEQ@mail.gmail.com>
 <b73ba628-ee07-5962-0f17-72cebfa14954@users.sourceforge.net>
From: Timur Tabi <timur@kernel.org>
Message-ID: <bf98d42f-2859-7e54-2a9f-81a8ecf10c2c@kernel.org>
Date: Wed, 23 Jan 2019 10:14:57 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <b73ba628-ee07-5962-0f17-72cebfa14954@users.sourceforge.net>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 23 Jan 2019 17:15:03 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 23 Jan 2019 17:15:00 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Source code adjustments in header files?
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

On 1/23/19 7:28 AM, SF Markus Elfring wrote:
>> It seems to me for my DBG_PRINTF changes, I definitely want --no-includes.

> How do you think about to adjust any macro calls also in header files?

When I specify a file name on the spatch command line, I don't want any 
other file modified.  If I wanted to modify a header file, I'd tell 
spatch to modify that header file.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
