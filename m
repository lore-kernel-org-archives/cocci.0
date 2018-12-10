Return-Path: <SRS0=GhGO=OT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B8FC67839
	for <cocci@archiver.kernel.org>; Mon, 10 Dec 2018 15:51:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8328C2082F
	for <cocci@archiver.kernel.org>; Mon, 10 Dec 2018 15:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8328C2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cs.tu-darmstadt.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBAFpRJV009567
          ; Mon, 10 Dec 2018 16:51:27 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4779476D5;
	Mon, 10 Dec 2018 16:51:27 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4AC5776AB
 for <cocci@systeme.lip6.fr>; Mon, 10 Dec 2018 16:51:26 +0100 (CET)
Received: from shiva.jussieu.fr (shiva.jussieu.fr [134.157.0.129])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBAFpIwA028959
 for <cocci@systeme.lip6.fr>; Mon, 10 Dec 2018 16:51:19 +0100 (CET)
X-pt: isis.lip6.fr
Received: from lnx503.hrz.tu-darmstadt.de (mail-relay239.hrz.tu-darmstadt.de
 [130.83.156.239])
 by shiva.jussieu.fr (8.15.2/jtpda-5.4) with ESMTP id wBAFoqhD093591
 ; Mon, 10 Dec 2018 16:51:18 +0100 (CET)
X-Ids: 164
X-Authentication-Warning: shiva-164.jussieu.fr: Host
 mail-relay239.hrz.tu-darmstadt.de [130.83.156.239] claimed to be
 lnx503.hrz.tu-darmstadt.de
Received: from smtp.tu-darmstadt.de (mail-relay238.hrz.tu-darmstadt.de
 [130.83.156.238])
 by lnx503.hrz.tu-darmstadt.de (8.14.4/8.14.4/HRZ/PMX) with ESMTP id
 wBAFokJ8001928; Mon, 10 Dec 2018 16:50:46 +0100
 (envelope-from schwahn@cs.tu-darmstadt.de)
Received: from [130.83.162.151] (deeds23.deeds.informatik.tu-darmstadt.de
 [130.83.162.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by smtp.tu-darmstadt.de (Postfix) with ESMTPSA id 43D6l13mlwzJBhf;
 Mon, 10 Dec 2018 16:42:05 +0100 (CET)
To: Julia Lawall <julia.lawall@lip6.fr>
References: <ecaf70fe-1194-9457-ad0c-5f029343b2d4@cs.tu-darmstadt.de>
 <alpine.DEB.2.20.1812101554470.3486@hadrien>
From: Oliver Schwahn <schwahn@cs.tu-darmstadt.de>
Organization: TU Darmstadt
Message-ID: <9957435e-f4bc-92aa-0a9e-295c0d77345b@cs.tu-darmstadt.de>
Date: Mon, 10 Dec 2018 16:42:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1812101554470.3486@hadrien>
Content-Language: en-US
X-PMX-TU: seen v1.2 by 5.6.1.2065439, Antispam-Engine: 2.7.2.376379,
 Antispam-Data: 2018.12.10.154516
X-PMX-RELAY: outgoing
X-Miltered: at jchkmail2.reseau.jussieu.fr with ID 5C0E8B5C.001 by Joe's
 j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 5C0E8B5C.001 from
 mail-relay239.hrz.tu-darmstadt.de/mail-relay239.hrz.tu-darmstadt.de/130.83.156.239/lnx503.hrz.tu-darmstadt.de/<schwahn@cs.tu-darmstadt.de>
X-Scores-Stats: 5C0E8B5C.001 B=0.50000 L=0.28041 G=0.28041 Disagree Winner=PH
X-Label-Query: YES
X-j-chkmail-Score: MSGID : 5C0E8B5C.001 on shiva.jussieu.fr : j-chkmail score
 : X : R=. U=. O=. B=0.280 -> S=0.280
X-j-chkmail-Status: Unsure
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 10 Dec 2018 16:51:28 +0100 (CET)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 10 Dec 2018 16:51:19 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Build issue after stdcompat upgrade
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

>> Do you have any suggestion for a workaround?
> 
> Can you upgrade to 4.06?  I also have this problem with 4.05.

Thanks for the suggestion. OCaml 4.05 was indeed the problem. I upgraded 
to 4.07 and that worked fine.
I also had the chance to check on configurations with OCaml 4.01.0 and 
4.02.3, which also work as expected.

Just out of curiosity, when I run the included tests with:
./spatch.opt --testall
I get a score of: good = 529/552.
Is that the expected outcome or is something not working correctly?

Cheers,
Oliver
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
